build:
	zola build

render: build
    #!/usr/bin/env bash
    for guide in public/guides/*/index.html; do
        base=$(basename $(dirname $guide))
        #weasyprint $guide $(dirname $guide)/$base.pdf
        pandoc -r html -w epub $guide -o $(dirname $guide)/$base.epub
    done

watch:
	#!/usr/bin/env bash
	inotifywait -m -r . \
		--exclude "(.*\\.pdf$)|public|justfile|\\.git" \
		-e close_write,move,create,delete \
	| while read -r directory events filename; do
		just render
	done
