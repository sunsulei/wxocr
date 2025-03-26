FROM python:3.12-slim

RUN sed -i \
    -e 's|http://deb\.debian\.org|https://mirror.nju.edu.cn|g' \
    -e 's|http://security\.debian\.org|https://mirror.nju.edu.cn/debian-security|g' \
    /etc/apt/sources.list \
    /etc/apt/sources.list.d/*.sources 2>/dev/null || true

RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install  -i https://mirror.nju.edu.cn/pypi/web/simple flask

COPY wcocr.cpython-312-x86_64-linux-gnu.so /app/wcocr.cpython-312-x86_64-linux-gnu.so

COPY wx /app/wx

COPY main.py /app/main.py
COPY templates /app/templates

WORKDIR /app

CMD ["python", "main.py"]