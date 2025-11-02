Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30933CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 08:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFTPF-00066f-W1; Sun, 02 Nov 2025 03:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFTPD-00066U-4a
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 03:25:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFTP6-0003QG-9M
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 03:25:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762071933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6oTHGZ9LhQPOdTQihYeVQ1Bx99HhIf2TOgTm24qwIoo=;
 b=ZfB5isYSqj0q6rOBEtnSGejIpNzlNwTX2Tp5m4zvcMDrm3By1Cbcqd8VGKmxqQUWuX72+n
 JuYg3FaiioIa+6yywBdSGcgH6gA2FgfNvSY3rkR8NB1qipjmAMUwJycof+hbTq3R2pHTpO
 EXmbpD6CKROduuxhxiov5ClVo2pNORA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-Zii0ohE3PQO3PKgyLDsKKw-1; Sun, 02 Nov 2025 03:25:21 -0500
X-MC-Unique: Zii0ohE3PQO3PKgyLDsKKw-1
X-Mimecast-MFC-AGG-ID: Zii0ohE3PQO3PKgyLDsKKw_1762071920
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-340fb6acc39so478685a91.0
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762071920; x=1762676720; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6oTHGZ9LhQPOdTQihYeVQ1Bx99HhIf2TOgTm24qwIoo=;
 b=JHpoDZfzvbURNHHUWv40/z2sOZD7ZUEu4ctCCGkLU4aoBiXCmtO5k0ni2eCGQVAaRs
 mxBaqm/bZNk1xcdiMcU4PV2rNqv8jDXBBiQXxDVjEdV4tqb9X4+p11amBg9n9/wA7yMQ
 Cv/jtlH/qmzekE7Vaa+rJchsmsSsIiieugjYzvJ0ZrN++ZB+suiSqXJAX1rZSieLmI/q
 z4YeElfZEBPC3zq7kaD4zR6tgOcubBI7U2tw4e4RDBbtuq5EN9Kh7yjwwCSXXyCo6OsV
 XgM7ToX61ZXGjpPWdkV6o26qt5+FkG1Ii4tTPm8B7EbqC7tKVLQLPDWe4Zct0SnSlVEA
 OL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762071920; x=1762676720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6oTHGZ9LhQPOdTQihYeVQ1Bx99HhIf2TOgTm24qwIoo=;
 b=eputeR8dZcAFAx1OfTLaMSJcewz5ijONJ4Jr5lAYqR9yT2+bpn++STw/KNkjbnxOYq
 /oCCHFTRROBJ4MBqfVGsjKlIoXPfZjmh2ugacsrI4PQW8julnzBMI5YIKv1n3mviCV50
 T5WkAr4CjydMY5QhQ+g3f/VgM7CLf2ZS/UtAuYNP1P+ngSqz0g5ww4zmn5vpjD/GdOAx
 0TIcI2nCfmp8Bm4CNvOayVh83dEnDAChWFieFgdrpQMo8drEWjy36OJVjskKBzPf1H1L
 CxgF8SGvtNA1zYKwvT4KdrwSR2kPyBSiKE0FV6v2m+vl42bnLUYXKSzW4B9aLbvuny+B
 JqMA==
X-Gm-Message-State: AOJu0YznMBQk/OqSAEbvdZj5PbJz3ZESIDGvbIYuOIfvFkWcuphi5dHH
 OI/2LMAUvw01BAYTV2+TOMaVM4HjXJxnFnRP8DHEKn4XqBkf6ZIVgZ/adxar0pBAzf13Hx37c0w
 DV+ZoxSYMwKioe+fG4r0USDyKy3c98BGyv96mX8sM1hc3FH1kqPpSmiVMoe5A+zM4HUGLpO4By6
 qu1GnqluPJ6WUQWMXfeOZh9+5Ifz3csS8=
X-Gm-Gg: ASbGncvT8QVxrKhwuFInRtGJWVQsQC9FglNsz43+RZzKeHNhiNo57XhApR6GscJ3XgR
 mr6/L5ET1ZOWfQji5kQzzjsU9dfZlj5B4K0BNQOU5SnZWXxtMp7CqDnqBPoi3pTpQ/4cl9PsuJI
 S8ANiD5UapeqvO6SybClo6aW/e9wJ+dLzJ3HQaEALf59g1qQZbibB1GsDIU6n7XQ==
X-Received: by 2002:a17:90b:3d8f:b0:340:f05a:3ed1 with SMTP id
 98e67ed59e1d1-340f05a40bamr2289317a91.21.1762071920244; 
 Sun, 02 Nov 2025 01:25:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG74yybYH72406oWBUFapC+FEskFyL5kMWD8+j4JANXqLnq7MyvaHezJ3L83XmFSDT2T56RrZTfmmbxowVLvuc=
X-Received: by 2002:a17:90b:3d8f:b0:340:f05a:3ed1 with SMTP id
 98e67ed59e1d1-340f05a40bamr2289289a91.21.1762071919783; Sun, 02 Nov 2025
 01:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-21-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-21-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 2 Nov 2025 12:25:07 +0400
X-Gm-Features: AWmQ_bnE2IQSfEZPr9oLhbwIiQyGuu_CvAt3_GUwq7HaipA3tAgOXoJOuwRDbqE
Message-ID: <CAMxuvaw4Eus6jzc2gzbaf+zVZgnxn4Xbba4-=ZeoX3rXw3zChQ@mail.gmail.com>
Subject: Re: [PATCH 20/21] crypto: support upto 5 parallel certificate
 identities
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000d90078064298567d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000d90078064298567d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The default (required) identity is stored in server-cert.pem /
> client-cert.pem and server-key.pem / client-key.pem.
>
> The 4 extra (optional) identities are stored in server-cert-$N.pem /
> client-cert-$N.pem and server-key-$N.pem / client-key-$N.pem. The
> numbering starts at 0 and the first missing cert/key pair will
> terminate the loading process.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscreds.c             | 10 +++++-
>  crypto/tlscredspriv.h         |  3 ++
>  crypto/tlscredsx509.c         | 68 ++++++++++++++++++++++++++++-------
>  crypto/tlssession.c           |  1 +
>  crypto/trace-events           |  1 +
>  docs/system/tls.rst           | 54 ++++++++++++++++++++++++++--
>  include/crypto/tlscredsx509.h |  6 ++++
>  7 files changed, 127 insertions(+), 16 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 85268f3b57..b7e77f6285 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -85,6 +85,14 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds
> *creds,
>  }
>
>
> +char *
> +qcrypto_tls_creds_build_path(QCryptoTLSCreds *creds,
> +                             const char *filename)
> +{
> +    return g_strdup_printf("%s/%s", creds->dir, filename);
> +}
> +
> +
>  int
>  qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
>                             const char *filename,
> @@ -94,7 +102,7 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
>  {
>      int ret =3D -1;
>
> -    *cred =3D g_strdup_printf("%s/%s", creds->dir, filename);
> +    *cred =3D qcrypto_tls_creds_build_path(creds, filename);
>
>      if (access(*cred, R_OK) < 0) {
>          if (errno =3D=3D ENOENT && !required) {
> diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h
> index 69dac02437..8f2d096c7f 100644
> --- a/crypto/tlscredspriv.h
> +++ b/crypto/tlscredspriv.h
> @@ -39,6 +39,9 @@ struct QCryptoTLSCreds {
>
>  #ifdef CONFIG_GNUTLS
>
> +char *qcrypto_tls_creds_build_path(QCryptoTLSCreds *creds,
> +                                   const char *filename);
> +
>  int qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
>                                 const char *filename,
>                                 bool required,
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index d7d1f594c0..fa92431906 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -686,7 +686,6 @@
> qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
>                                       QCryptoTLSCredsBox *box,
>                                       const char *certbase,
>                                       const char *keybase,
> -                                     bool isOptional,
>                                       Error **errp)
>  {
>      g_autoptr(QCryptoTLSCredsX509IdentFiles) files =3D
> @@ -694,9 +693,9 @@
> qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
>      int ret;
>
>      if (qcrypto_tls_creds_get_path(&creds->parent_obj, certbase,
> -                                   !isOptional, &files->certpath, errp) =
<
> 0 ||
> +                                   false, &files->certpath, errp) < 0 ||
>          qcrypto_tls_creds_get_path(&creds->parent_obj, keybase,
> -                                   !isOptional, &files->keypath, errp) <
> 0) {
> +                                   false, &files->keypath, errp) < 0) {
>          return NULL;
>      }
>
> @@ -705,13 +704,17 @@
> qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
>          return NULL;
>      }
>      if (files->certpath && !files->keypath) {
> -        error_setg(errp, "Cert '%s' without corresponding key",
> -                   files->certpath);
> +        g_autofree char *keypath =3D
> +            qcrypto_tls_creds_build_path(&creds->parent_obj, keybase);
> +        error_setg(errp, "Cert '%s' without corresponding key '%s'",
> +                   files->certpath, keypath);
>          return NULL;
>      }
>      if (!files->certpath && files->keypath) {
> -        error_setg(errp, "Key '%s' without corresponding cert",
> -                   files->keypath);
> +        g_autofree char *certpath =3D
> +            qcrypto_tls_creds_build_path(&creds->parent_obj, certbase);
> +        error_setg(errp, "Key '%s' without corresponding cert '%s'",
> +                   files->keypath, certpath);
>          return NULL;
>      }
>
> @@ -750,7 +753,9 @@
> qcrypto_tls_creds_x509_load_identities(QCryptoTLSCredsX509 *creds,
>                                         bool isServer,
>                                         Error **errp)
>  {
> +    ERRP_GUARD();
>      QCryptoTLSCredsX509IdentFiles *ifiles;
> +    size_t i;
>
>      ifiles =3D qcrypto_tls_creds_x509_load_identity(
>          creds, box,
> @@ -760,15 +765,52 @@
> qcrypto_tls_creds_x509_load_identities(QCryptoTLSCredsX509 *creds,
>          isServer ?
>          QCRYPTO_TLS_CREDS_X509_SERVER_KEY :
>          QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
> -        !isServer, errp);
> -    if (!ifiles) {
> +        errp);
> +    if (!ifiles && *errp) {
>          return -1;
>      }
>
> -    files->identities =3D g_renew(QCryptoTLSCredsX509IdentFiles *,
> -                                files->identities,
> -                                files->nidentities + 1);
> -    files->identities[files->nidentities++] =3D ifiles;
> +    if (ifiles) {
> +        files->identities =3D g_renew(QCryptoTLSCredsX509IdentFiles *,
> +                                    files->identities,
> +                                    files->nidentities + 1);
> +        files->identities[files->nidentities++] =3D ifiles;
> +    }
> +
> +    for (i =3D 0; i < QCRYPTO_TLS_CREDS_X509_IDENTITY_MAX; i++) {
> +        g_autofree char *cert =3D g_strdup_printf(
> +            isServer ?
> +            QCRYPTO_TLS_CREDS_X509_SERVER_CERT_N :
> +            QCRYPTO_TLS_CREDS_X509_CLIENT_CERT_N, i);
> +        g_autofree char *key =3D g_strdup_printf(
> +            isServer ?
> +            QCRYPTO_TLS_CREDS_X509_SERVER_KEY_N :
> +            QCRYPTO_TLS_CREDS_X509_CLIENT_KEY_N, i);
> +
> +        ifiles =3D qcrypto_tls_creds_x509_load_identity(creds, box,
> +                                                      cert, key, errp);
> +        if (!ifiles && *errp) {
> +            return -1;
> +        }
> +        if (!ifiles) {
> +            break;
> +        }
> +
> +        files->identities =3D g_renew(QCryptoTLSCredsX509IdentFiles *,
> +                                    files->identities,
> +                                    files->nidentities + 1);
> +        files->identities[files->nidentities++] =3D ifiles;
> +    }
> +
> +    if (files->nidentities =3D=3D 0 && isServer) {
> +        g_autofree char *certpath =3D qcrypto_tls_creds_build_path(
> +            &creds->parent_obj, QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
> +        g_autofree char *keypath =3D qcrypto_tls_creds_build_path(
> +            &creds->parent_obj, QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
> +        error_setg(errp, "Missing server cert '%s' & key '%s'",
> +                   certpath, keypath);
> +        return -1;
> +    }
>
>      return 0;
>  }
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index a1dc3b3ce0..314e3e96ba 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -345,6 +345,7 @@
> qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
>                  goto error;
>              }
>              session->peername =3D (char *)g_steal_pointer(&dname.data);
> +            trace_qcrypto_tls_session_check_x509_dn(session,
> session->peername);
>              if (session->authzid) {
>                  bool allow;
>
> diff --git a/crypto/trace-events b/crypto/trace-events
> index d0e33427fa..771f9b8a6e 100644
> --- a/crypto/trace-events
> +++ b/crypto/trace-events
> @@ -21,6 +21,7 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, cons=
t
> char *file) "TLS creds
>  # tlssession.c
>  qcrypto_tls_session_new(void *session, void *creds, const char *hostname=
,
> const char *authzid, int endpoint) "TLS session new session=3D%p creds=3D=
%p
> hostname=3D%s authzid=3D%s endpoint=3D%d"
>  qcrypto_tls_session_check_creds(void *session, const char *status) "TLS
> session check creds session=3D%p status=3D%s"
> +qcrypto_tls_session_check_x509_dn(void *session, const char *dname) "TLS
> session check x509 distinguished name session=3D%p dname=3D%s"
>  qcrypto_tls_session_parameters(void *session, int threadSafety, int
> protocol, int cipher) "TLS session parameters session=3D%p threadSafety=
=3D%d
> protocol=3D%d cipher=3D%d"
>  qcrypto_tls_session_bug1717_workaround(void *session) "TLS session
> bug1717 workaround session=3D%p"
>
> diff --git a/docs/system/tls.rst b/docs/system/tls.rst
> index 44c4bf04e9..7cec4ac3df 100644
> --- a/docs/system/tls.rst
> +++ b/docs/system/tls.rst
> @@ -36,8 +36,58 @@ server and exposing it directly to remote browser
> clients. In such a
>  case it might be useful to use a commercial CA to avoid needing to
>  install custom CA certs in the web browsers.
>
> -The recommendation is for the server to keep its certificates in either
> -``/etc/pki/qemu`` or for unprivileged users in ``$HOME/.pki/qemu``.
> +.. _tls_cert_file_naming:
> +
> +Certificate file naming
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +In a simple setup, where all QEMU instances on a machine share the
> +same TLS configuration, it is suggested that QEMU certificates be
> +kept in either ``/etc/pki/qemu`` or, for unprivileged users, in
> +``$HOME/.pki/qemu``. Where different QEMU subsystems require
> +different certificate configurations, sub-dirs of these locations
> +may be chosen.
> +
> +The default file names that QEMU will traditionally load are:
> +
> +* ``ca-cert.pem`` - mandatory; for both client and server configurations
> +* ``ca-crl.pem`` - optional; for server configurations only
> +* ``server-cert.pem`` - mandatory; for server configurations only
> +* ``server-key.pem`` - mandatory; for server configurations only
> +* ``client-cert.pem`` - optional; for client configurations only
> +* ``client-key.pem`` - optional; for client configurations only
> +* ``dh-params.pem`` - optional; for server configurations only
> +
> +Since QEMU 10.2.0, there is support for loading upto four additional
> +identities:
> +
> +* ``server-cert-[IDX].pem`` - optional; for server configurations only
> +* ``server-key-[IDX].pem`` - optional; for server configurations only
> +* ``client-cert-[IDX].pem`` - optional; for client configurations only
> +* ``client-key-[IDX].pem`` - optional; for client configurations only
> +
> +where ``-[IDX]`` is one of the digits 0-3. Loading will terminate at
> +the first absent index. The index based certificate files may be used
> +as a replacement for, or in addition to, the traditional non-index
> +based certificate files. The traditional certificate files will be
> +loaded first, if present, then the index based certificates. Where
> +multiple certificates are compatible with a TLS session, the first
> +loaded certificate will preferred. IOW file naming can influence
> +which certificates are used for a session.
> +
> +The use of multiple sets of certificates is intended to allow an
> +incremental transition to certificates using different crytographic
> +algorithms. This allows a newly deployed QEMU to introduce use of
> +stronger cryptographic algorithms that will be preferred when talking
> +to other newly deployed QEMU instances, while retaining compatbility
> +with certificates issued to a historically deployed QEMU. This is
> +notably useful to support live migration from an old QEMU deployed
> +on older operating system releases, which may support fewer crypto
> +algorithm choices than the current OS.
> +
> +The certificate creation commands below will be illustrated using
> +the traditional naming scheme, but their args can be substituted
> +to use the indexed naming in the obvious manner.
>
>  .. _tls_005fgenerate_005fca:
>
> diff --git a/include/crypto/tlscredsx509.h b/include/crypto/tlscredsx509.=
h
> index c4daba21a6..61b7f73573 100644
> --- a/include/crypto/tlscredsx509.h
> +++ b/include/crypto/tlscredsx509.h
> @@ -37,7 +37,13 @@ typedef struct QCryptoTLSCredsX509Class
> QCryptoTLSCredsX509Class;
>  #define QCRYPTO_TLS_CREDS_X509_SERVER_CERT "server-cert.pem"
>  #define QCRYPTO_TLS_CREDS_X509_CLIENT_KEY "client-key.pem"
>  #define QCRYPTO_TLS_CREDS_X509_CLIENT_CERT "client-cert.pem"
> +#define QCRYPTO_TLS_CREDS_X509_SERVER_KEY_N "server-key-%zu.pem"
> +#define QCRYPTO_TLS_CREDS_X509_SERVER_CERT_N "server-cert-%zu.pem"
> +#define QCRYPTO_TLS_CREDS_X509_CLIENT_KEY_N "client-key-%zu.pem"
> +#define QCRYPTO_TLS_CREDS_X509_CLIENT_CERT_N "client-cert-%zu.pem"
>
> +/* Max number of additional cert/key pairs (ie _N constants) */
> +#define QCRYPTO_TLS_CREDS_X509_IDENTITY_MAX 4
>
>  /**
>   * QCryptoTLSCredsX509:
> --
> 2.51.1
>
>

--000000000000d90078064298567d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 6:50=
=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.c=
om">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">The default (required) identity is stored in server-=
cert.pem /<br>
client-cert.pem and server-key.pem / client-key.pem.<br>
<br>
The 4 extra (optional) identities are stored in server-cert-$N.pem /<br>
client-cert-$N.pem and server-key-$N.pem / client-key-$N.pem. The<br>
numbering starts at 0 and the first missing cert/key pair will<br>
terminate the loading process.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/tlscreds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10=
 +++++-<br>
=C2=A0crypto/tlscredspriv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++<b=
r>
=C2=A0crypto/tlscredsx509.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 68 +++++++++=
+++++++++++++++++++-------<br>
=C2=A0crypto/tlssession.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
 +<br>
=C2=A0crypto/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
 +<br>
=C2=A0docs/system/tls.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 54 ++++=
++++++++++++++++++++++--<br>
=C2=A0include/crypto/tlscredsx509.h |=C2=A0 6 ++++<br>
=C2=A07 files changed, 127 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 85268f3b57..b7e77f6285 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -85,6 +85,14 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *cr=
eds,<br>
=C2=A0}<br>
<br>
<br>
+char *<br>
+qcrypto_tls_creds_build_path(QCryptoTLSCreds *creds,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *filename)<br>
+{<br>
+=C2=A0 =C2=A0 return g_strdup_printf(&quot;%s/%s&quot;, creds-&gt;dir, fil=
ename);<br>
+}<br>
+<br>
+<br>
=C2=A0int<br>
=C2=A0qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 const char *filename,<br>
@@ -94,7 +102,7 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D -1;<br>
<br>
-=C2=A0 =C2=A0 *cred =3D g_strdup_printf(&quot;%s/%s&quot;, creds-&gt;dir, =
filename);<br>
+=C2=A0 =C2=A0 *cred =3D qcrypto_tls_creds_build_path(creds, filename);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (access(*cred, R_OK) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (errno =3D=3D ENOENT &amp;&amp; !requi=
red) {<br>
diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h<br>
index 69dac02437..8f2d096c7f 100644<br>
--- a/crypto/tlscredspriv.h<br>
+++ b/crypto/tlscredspriv.h<br>
@@ -39,6 +39,9 @@ struct QCryptoTLSCreds {<br>
<br>
=C2=A0#ifdef CONFIG_GNUTLS<br>
<br>
+char *qcrypto_tls_creds_build_path(QCryptoTLSCreds *creds,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *filename);<=
br>
+<br>
=C2=A0int qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool required,<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index d7d1f594c0..fa92431906 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -686,7 +686,6 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX50=
9 *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCryptoTLSCreds=
Box *box,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *cer=
tbase,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *key=
base,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool isOptional,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_autoptr(QCryptoTLSCredsX509IdentFiles) files =3D<br>
@@ -694,9 +693,9 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX50=
9 *creds,<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds-&gt;parent_ob=
j, certbase,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!isOptional, &amp;files=
-&gt;certpath, errp) &lt; 0 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0false, &amp;files-&gt;c=
ertpath, errp) &lt; 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_get_path(&amp;creds-&gt=
;parent_obj, keybase,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!isOptional, &amp;files=
-&gt;keypath, errp) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0false, &amp;files-&gt;k=
eypath, errp) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -705,13 +704,17 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX=
509 *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (files-&gt;certpath &amp;&amp; !files-&gt;keypath) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cert &#39;%s&#39; witho=
ut corresponding key&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0files=
-&gt;certpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *keypath =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_build_path(&am=
p;creds-&gt;parent_obj, keybase);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Cert &#39;%s&#39; witho=
ut corresponding key &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0files=
-&gt;certpath, keypath);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (!files-&gt;certpath &amp;&amp; files-&gt;keypath) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Key &#39;%s&#39; withou=
t corresponding cert&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0files=
-&gt;keypath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *certpath =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_build_path(&am=
p;creds-&gt;parent_obj, certbase);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Key &#39;%s&#39; withou=
t corresponding cert &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0files=
-&gt;keypath, certpath);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -750,7 +753,9 @@ qcrypto_tls_creds_x509_load_identities(QCryptoTLSCredsX=
509 *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool isS=
erver,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **=
errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsX509IdentFiles *ifiles;<br>
+=C2=A0 =C2=A0 size_t i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0ifiles =3D qcrypto_tls_creds_x509_load_identity(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds, box,<br>
@@ -760,15 +765,52 @@ qcrypto_tls_creds_x509_load_identities(QCryptoTLSCred=
sX509 *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isServer ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCRYPTO_TLS_CREDS_X509_SERVER_KEY :<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 !isServer, errp);<br>
-=C2=A0 =C2=A0 if (!ifiles) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 errp);<br>
+=C2=A0 =C2=A0 if (!ifiles &amp;&amp; *errp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 files-&gt;identities =3D g_renew(QCryptoTLSCredsX509IdentFil=
es *,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;identities,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;nidentities + 1);<br>
-=C2=A0 =C2=A0 files-&gt;identities[files-&gt;nidentities++] =3D ifiles;<br=
>
+=C2=A0 =C2=A0 if (ifiles) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;identities =3D g_renew(QCryptoTLSCre=
dsX509IdentFiles *,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;identities,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;nidentities =
+ 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;identities[files-&gt;nidentities++] =
=3D ifiles;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; QCRYPTO_TLS_CREDS_X509_IDENTITY_MAX; i+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *cert =3D g_strdup_printf(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isServer ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_TLS_CREDS_X509_SERVER_CE=
RT_N :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_TLS_CREDS_X509_CLIENT_CE=
RT_N, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *key =3D g_strdup_printf(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 isServer ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_TLS_CREDS_X509_SERVER_KE=
Y_N :<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_TLS_CREDS_X509_CLIENT_KE=
Y_N, i);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ifiles =3D qcrypto_tls_creds_x509_load_identit=
y(creds, box,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cert, key, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ifiles &amp;&amp; *errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ifiles) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;identities =3D g_renew(QCryptoTLSCre=
dsX509IdentFiles *,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;identities,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;nidentities =
+ 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 files-&gt;identities[files-&gt;nidentities++] =
=3D ifiles;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (files-&gt;nidentities =3D=3D 0 &amp;&amp; isServer) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *certpath =3D qcrypto_tls_cred=
s_build_path(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;creds-&gt;parent_obj, QCRYP=
TO_TLS_CREDS_X509_SERVER_CERT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *keypath =3D qcrypto_tls_creds=
_build_path(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;creds-&gt;parent_obj, QCRYP=
TO_TLS_CREDS_X509_SERVER_KEY);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Missing server cert &#3=
9;%s&#39; &amp; key &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0certp=
ath, keypath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
diff --git a/crypto/tlssession.c b/crypto/tlssession.c<br>
index a1dc3b3ce0..314e3e96ba 100644<br>
--- a/crypto/tlssession.c<br>
+++ b/crypto/tlssession.c<br>
@@ -345,6 +345,7 @@ qcrypto_tls_session_check_certificate(QCryptoTLSSession=
 *session,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto error;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0session-&gt;peername =3D (c=
har *)g_steal_pointer(&amp;dname.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_qcrypto_tls_session_check_=
x509_dn(session, session-&gt;peername);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (session-&gt;authzid) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool allow;<b=
r>
<br>
diff --git a/crypto/trace-events b/crypto/trace-events<br>
index d0e33427fa..771f9b8a6e 100644<br>
--- a/crypto/trace-events<br>
+++ b/crypto/trace-events<br>
@@ -21,6 +21,7 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const =
char *file) &quot;TLS creds<br>
=C2=A0# tlssession.c<br>
=C2=A0qcrypto_tls_session_new(void *session, void *creds, const char *hostn=
ame, const char *authzid, int endpoint) &quot;TLS session new session=3D%p =
creds=3D%p hostname=3D%s authzid=3D%s endpoint=3D%d&quot;<br>
=C2=A0qcrypto_tls_session_check_creds(void *session, const char *status) &q=
uot;TLS session check creds session=3D%p status=3D%s&quot;<br>
+qcrypto_tls_session_check_x509_dn(void *session, const char *dname) &quot;=
TLS session check x509 distinguished name session=3D%p dname=3D%s&quot;<br>
=C2=A0qcrypto_tls_session_parameters(void *session, int threadSafety, int p=
rotocol, int cipher) &quot;TLS session parameters session=3D%p threadSafety=
=3D%d protocol=3D%d cipher=3D%d&quot;<br>
=C2=A0qcrypto_tls_session_bug1717_workaround(void *session) &quot;TLS sessi=
on bug1717 workaround session=3D%p&quot;<br>
<br>
diff --git a/docs/system/tls.rst b/docs/system/tls.rst<br>
index 44c4bf04e9..7cec4ac3df 100644<br>
--- a/docs/system/tls.rst<br>
+++ b/docs/system/tls.rst<br>
@@ -36,8 +36,58 @@ server and exposing it directly to remote browser client=
s. In such a<br>
=C2=A0case it might be useful to use a commercial CA to avoid needing to<br=
>
=C2=A0install custom CA certs in the web browsers.<br>
<br>
-The recommendation is for the server to keep its certificates in either<br=
>
-``/etc/pki/qemu`` or for unprivileged users in ``$HOME/.pki/qemu``.<br>
+.. _tls_cert_file_naming:<br>
+<br>
+Certificate file naming<br>
+~~~~~~~~~~~~~~~~~~~~~~~<br>
+<br>
+In a simple setup, where all QEMU instances on a machine share the<br>
+same TLS configuration, it is suggested that QEMU certificates be<br>
+kept in either ``/etc/pki/qemu`` or, for unprivileged users, in<br>
+``$HOME/.pki/qemu``. Where different QEMU subsystems require<br>
+different certificate configurations, sub-dirs of these locations<br>
+may be chosen.<br>
+<br>
+The default file names that QEMU will traditionally load are:<br>
+<br>
+* ``ca-cert.pem`` - mandatory; for both client and server configurations<b=
r>
+* ``ca-crl.pem`` - optional; for server configurations only<br>
+* ``server-cert.pem`` - mandatory; for server configurations only<br>
+* ``server-key.pem`` - mandatory; for server configurations only<br>
+* ``client-cert.pem`` - optional; for client configurations only<br>
+* ``client-key.pem`` - optional; for client configurations only<br>
+* ``dh-params.pem`` - optional; for server configurations only<br>
+<br>
+Since QEMU 10.2.0, there is support for loading upto four additional<br>
+identities:<br>
+<br>
+* ``server-cert-[IDX].pem`` - optional; for server configurations only<br>
+* ``server-key-[IDX].pem`` - optional; for server configurations only<br>
+* ``client-cert-[IDX].pem`` - optional; for client configurations only<br>
+* ``client-key-[IDX].pem`` - optional; for client configurations only<br>
+<br>
+where ``-[IDX]`` is one of the digits 0-3. Loading will terminate at<br>
+the first absent index. The index based certificate files may be used<br>
+as a replacement for, or in addition to, the traditional non-index<br>
+based certificate files. The traditional certificate files will be<br>
+loaded first, if present, then the index based certificates. Where<br>
+multiple certificates are compatible with a TLS session, the first<br>
+loaded certificate will preferred. IOW file naming can influence<br>
+which certificates are used for a session.<br>
+<br>
+The use of multiple sets of certificates is intended to allow an<br>
+incremental transition to certificates using different crytographic<br>
+algorithms. This allows a newly deployed QEMU to introduce use of<br>
+stronger cryptographic algorithms that will be preferred when talking<br>
+to other newly deployed QEMU instances, while retaining compatbility<br>
+with certificates issued to a historically deployed QEMU. This is<br>
+notably useful to support live migration from an old QEMU deployed<br>
+on older operating system releases, which may support fewer crypto<br>
+algorithm choices than the current OS.<br>
+<br>
+The certificate creation commands below will be illustrated using<br>
+the traditional naming scheme, but their args can be substituted<br>
+to use the indexed naming in the obvious manner.<br>
<br>
=C2=A0.. _tls_005fgenerate_005fca:<br>
<br>
diff --git a/include/crypto/tlscredsx509.h b/include/crypto/tlscredsx509.h<=
br>
index c4daba21a6..61b7f73573 100644<br>
--- a/include/crypto/tlscredsx509.h<br>
+++ b/include/crypto/tlscredsx509.h<br>
@@ -37,7 +37,13 @@ typedef struct QCryptoTLSCredsX509Class QCryptoTLSCredsX=
509Class;<br>
=C2=A0#define QCRYPTO_TLS_CREDS_X509_SERVER_CERT &quot;server-cert.pem&quot=
;<br>
=C2=A0#define QCRYPTO_TLS_CREDS_X509_CLIENT_KEY &quot;client-key.pem&quot;<=
br>
=C2=A0#define QCRYPTO_TLS_CREDS_X509_CLIENT_CERT &quot;client-cert.pem&quot=
;<br>
+#define QCRYPTO_TLS_CREDS_X509_SERVER_KEY_N &quot;server-key-%zu.pem&quot;=
<br>
+#define QCRYPTO_TLS_CREDS_X509_SERVER_CERT_N &quot;server-cert-%zu.pem&quo=
t;<br>
+#define QCRYPTO_TLS_CREDS_X509_CLIENT_KEY_N &quot;client-key-%zu.pem&quot;=
<br>
+#define QCRYPTO_TLS_CREDS_X509_CLIENT_CERT_N &quot;client-cert-%zu.pem&quo=
t;<br>
<br>
+/* Max number of additional cert/key pairs (ie _N constants) */<br>
+#define QCRYPTO_TLS_CREDS_X509_IDENTITY_MAX 4<br>
<br>
=C2=A0/**<br>
=C2=A0 * QCryptoTLSCredsX509:<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--000000000000d90078064298567d--


