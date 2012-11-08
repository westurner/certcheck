#!/bin/bash -x
HOSTNAME=$1
PORT=${2:-443}
CERTTEXT=$(echo GET / | openssl s_client -CApath /etc/ssl/certs -connect "${HOSTNAME}:${PORT}")
CERTHASH=$(echo "${CERTTEXT}" | openssl x509 -outform DER | openssl sha1 | cut -f2 -d' ')
echo "${CERTHASH}"
dig @8.8.8.8 "${CERTHASH}.certs.googlednstest.com" TXT
