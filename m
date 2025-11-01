Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79741CCF9F8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 09:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF7sD-0004DK-25; Sat, 01 Nov 2025 05:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vF7sB-0004CX-5Q
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vF7s7-0005IT-5u
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 05:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761989163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SZz5tnhgbIa9Vvv+QcpaiZMyhFreqR8VuNrY9QgYV0Y=;
 b=dxFyK3gdlryNCdbYzsEhGujGxXc9CPQQ7lp+hBkMSG2Ss2Xcm/G91ZYDZe7SJlg1FZ1Wdq
 Ly3TPmCzwYaBmM2Ur+lWnHhZcm/0iNuYuqVpFg1sRb06K2wtSb1x8NLNV9dvcQeZVjfUZL
 HEpuVS1BId0iafimPwUdTf5wmu0Hzl0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-dbehabV-PTmzGRQroZMyiw-1; Sat, 01 Nov 2025 05:26:01 -0400
X-MC-Unique: dbehabV-PTmzGRQroZMyiw-1
X-Mimecast-MFC-AGG-ID: dbehabV-PTmzGRQroZMyiw_1761989160
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3409148acc0so1407883a91.1
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1761989160; x=1762593960; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SZz5tnhgbIa9Vvv+QcpaiZMyhFreqR8VuNrY9QgYV0Y=;
 b=pBSL0E2KPTlIDrGYne2wMcco7hi9Ux3Nvl1Tasb6BPfyEm7RMVTQMoS1kAEEWezlvG
 TA0Qw3FlMo23wL+rbEZilaLD7z5BLIa3CGFopgGenI3YEOpjGNXAGBZ8Vu34K2rsiYeR
 tDCpp/ZwFySN1ZyyhVmqLSDD036yw+DgxcXT3tiX7VZd6YJ3SgIdjrXIEgDtlECOBa0r
 hpo9tVyxNLzBa3/jBR9rs/nWQ1veluep4NgDZp86YA3sodjZqKCaxEvKVmKFiiuvPnHA
 jNxgaKGZLmrs+9A2FdyBoATjGgCzeYsjBESqoN8itZ2JDatXWUt/vBBR94q7r15QL0w2
 UAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761989160; x=1762593960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZz5tnhgbIa9Vvv+QcpaiZMyhFreqR8VuNrY9QgYV0Y=;
 b=Hr08/p7vYJ1eZiVhKaiIvXW5mAsOOrvApHkV2xMCxJFuf/Q+q6QWfXVnXDW8muqMov
 vlE3bV7ojF+qfXuSv3vV+GHJzoultTv0NvsEWYQK6MaqGaYnWNyQ5Sr990+ryExGEijd
 ahbRblHmsCnSppETVs06E22s2i/F9FDE0bLdlBiok9fGuHJDtvyRV6oEZgy/7yiRYcgD
 5rGhmJe/OX+bBqPbT/30xrpSHpJ7748vMhffCUFoRMdBs+ZG3f+RNbxf7ahCadz+Fk95
 hZKsNSscU5MxqTvX42+Q0ePHJ7Bp31Nbmye/RVOyHJDL9UcAc/WKDE/t7c/DSL7VeQfG
 sHIA==
X-Gm-Message-State: AOJu0YyHW2/4Mfhu76NeX6Y/KOgEWdmoK9YwH3vockYEMBgESk/EOWaE
 4QiP1WIH86Lk/ne+Ogyau27GaDkheu8kJwNXCKe8MbeJd9SPniES7Ph8wtcrZyWqbjFFWnMvWQG
 uTXvKSnLYymmptf/3KJazFSZiz4uK+JArT3/WyzM5yxhNMpV+FLOdRZZMTMYtboLSZg9mj2x/Ds
 qCHXdX2gqKsrjCv7mRfQ1fnTEKXI77F+w=
X-Gm-Gg: ASbGncs1N0wpy81ARo43WcE21nGpK4EOSWFrRQBUn1B/UT+4yKTArPghZDsAkpkQUXy
 lkFCwUI5M4HbWHmy3GIoVu0AUlltjGElXb20s5K/SSpSE/MuA0jm1zfnfku8jKveNiOjJm3aWj+
 Bcm8lOCqm6NA+vuQ3IQCN5WSNEVOk2Juglo0KTfBc4NFcidu16Yc6tww1/hZ1ayg==
X-Received: by 2002:a17:90b:1f88:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-34082fdc189mr9454285a91.12.1761989159746; 
 Sat, 01 Nov 2025 02:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJjaF3XJJigOfLuQ1QKLEGFUWRbqSlpHvJXuUsJfGCOAvJnl5D/KyjR6LCoMJ7GlY00OnuLkWusl5WYtqlzIo=
X-Received: by 2002:a17:90b:1f88:b0:336:b60f:3936 with SMTP id
 98e67ed59e1d1-34082fdc189mr9454271a91.12.1761989159236; Sat, 01 Nov 2025
 02:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-19-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-19-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 1 Nov 2025 13:25:46 +0400
X-Gm-Features: AWmQ_bnwImw6GBP6bL9HfDlubl7yeCeqeM6mY2-Udy_BnrZhTpdznVnqa4iffpg
Message-ID: <CAMxuvazSUwJSP++Zv=+-Yn7eEAKfxXXOMO8j_-1ES2tqsr7Bdw@mail.gmail.com>
Subject: Re: [PATCH 18/21] crypto: avoid loading the identity certs twice
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000ef4c12064285110c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000ef4c12064285110c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The x509 TLS credentials code will load the identity certs once to
> perform sanity chcking on the certs, then discard the certificate
> objects and let gnutls load them a second time.
>
> This extends the previous QCryptoTLSCredsX509Files struct to also
> hold the identity certificates & key loaded for sanity checking
> and pass them on to gnutls, avoiding the duplicated loading.
>
> The unit tests need updating because we now correctly diagnose the
> error scenario where the cert PEM file exists, without its matching
> key PEM file. Previously that error was mistakenly ignored.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c                 | 247 +++++++++++++++++---------
>  tests/unit/test-crypto-tlscredsx509.c |   8 +-
>  2 files changed, 164 insertions(+), 91 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 6a830af50d..3cb0a6c31f 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -45,6 +45,12 @@ struct QCryptoTLSCredsX509Files {
>      char *cacertpath;
>      gnutls_x509_crt_t *cacerts;
>      unsigned int ncacerts;
> +
> +    char *certpath;
> +    char *keypath;
> +    gnutls_x509_crt_t *certs;
> +    unsigned int ncerts;
> +    gnutls_x509_privkey_t key;
>  };
>
>  static QCryptoTLSCredsX509Files *
> @@ -63,6 +69,13 @@
> qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
>      }
>      g_free(files->cacerts);
>      g_free(files->cacertpath);
> +    for (i =3D 0; i < files->ncerts; i++) {
> +        gnutls_x509_crt_deinit(files->certs[i]);
> +    }
> +    gnutls_x509_privkey_deinit(files->key);
> +    g_free(files->certs);
> +    g_free(files->certpath);
> +    g_free(files->keypath);
>      g_free(files);
>  }
>
> @@ -477,14 +490,13 @@ qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX50=
9
> *creds,
>                                   const char *certFile,
>                                   gnutls_x509_crt_t **certs,
>                                   unsigned int *ncerts,
> -                                 bool isServer,
> -                                 bool isCA,
>                                   Error **errp)
>  {
>      gnutls_datum_t data;
>      g_autofree char *buf =3D NULL;
>      gsize buflen;
>      GError *gerr =3D NULL;
> +    int ret;
>
>      *ncerts =3D 0;
>      trace_qcrypto_tls_creds_x509_load_cert_list(creds, certFile);
> @@ -499,13 +511,60 @@ qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX50=
9
> *creds,
>      data.data =3D (unsigned char *)buf;
>      data.size =3D strlen(buf);
>
> -    if (gnutls_x509_crt_list_import2(certs, ncerts, &data,
> -                                     GNUTLS_X509_FMT_PEM, 0) < 0) {
> -        error_setg(errp,
> -                   isCA ? "Unable to import CA certificate list %s" :
> -                   (isServer ? "Unable to import server certificate %s" =
:
> -                    "Unable to import client certificate %s"),
> -                   certFile);
> +    ret =3D gnutls_x509_crt_list_import2(certs, ncerts, &data,
> +                                       GNUTLS_X509_FMT_PEM, 0);
> +    if (ret < 0) {
> +        error_setg(errp, "Unable to import certificate %s: %s",
> +                   certFile, gnutls_strerror(ret));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +
> +static int
> +qcrypto_tls_creds_load_privkey(QCryptoTLSCredsX509 *creds,
> +                               const char *keyFile,
> +                               gnutls_x509_privkey_t *key,
> +                               Error **errp)
> +{
> +    gnutls_datum_t data;
> +    g_autofree char *buf =3D NULL;
> +    g_autofree char *password =3D NULL;
> +    gsize buflen;
> +    GError *gerr =3D NULL;
> +    int ret;
> +
> +    ret =3D gnutls_x509_privkey_init(key);
> +    if (ret < 0) {
> +        error_setg(errp, "Unable to initialize private key: %s",
> +                   gnutls_strerror(ret));
> +        return -1;
> +    }
> +
> +    if (!g_file_get_contents(keyFile, &buf, &buflen, &gerr)) {
> +        error_setg(errp, "Cannot load private key %s: %s",
> +                   keyFile, gerr->message);
> +        g_error_free(gerr);
> +        return -1;
> +    }
> +
> +    data.data =3D (unsigned char *)buf;
> +    data.size =3D strlen(buf);
> +
> +    if (creds->passwordid) {
> +        password =3D qcrypto_secret_lookup_as_utf8(creds->passwordid,
> +                                                 errp);
> +        if (!password) {
> +            return -1;
> +        }
> +    }
> +
> +    if (gnutls_x509_privkey_import2(*key, &data,
> +                                    GNUTLS_X509_FMT_PEM,
> +                                    password, 0) < 0) {
> +        error_setg(errp, "Unable to import private key %s", keyFile);
>          return -1;
>      }
>
> @@ -517,56 +576,34 @@ static int
>  qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>                                      QCryptoTLSCredsX509Files *files,
>                                      bool isServer,
> -                                    const char *certFile,
>                                      Error **errp)
>  {
> -    gnutls_x509_crt_t *certs =3D NULL;
> -    unsigned int ncerts =3D 0;
>      size_t i;
> -    int ret =3D -1;
> -
> -    if (certFile) {
> -        if (qcrypto_tls_creds_load_cert_list(creds,
> -                                             certFile,
> -                                             &certs,
> -                                             &ncerts,
> -                                             isServer,
> -                                             false,
> -                                             errp) < 0) {
> -            goto cleanup;
> -        }
> -    }
>
> -    for (i =3D 0; i < ncerts; i++) {
> +    for (i =3D 0; i < files->ncerts; i++) {
>          if (qcrypto_tls_creds_check_cert(creds,
> -                                         certs[i], certFile,
> +                                         files->certs[i], files->certpat=
h,
>                                           isServer, i !=3D 0, errp) < 0) =
{
> -            goto cleanup;
> +            return -1;
>          }
>      }
>
> -    if (ncerts &&
> +    if (files->ncerts &&
>          qcrypto_tls_creds_check_authority_chain(creds, files,
> -                                                certs, ncerts,
> +                                                files->certs,
> files->ncerts,
>                                                  isServer, errp) < 0) {
> -        goto cleanup;
> -    }
> -
> -    if (ncerts &&
> -        qcrypto_tls_creds_check_cert_pair(files, certs, ncerts, certFile=
,
> -                                          isServer, errp) < 0) {
> -        goto cleanup;
> +        return -1;
>      }
>
> -    ret =3D 0;
> -
> - cleanup:
> -    for (i =3D 0; i < ncerts; i++) {
> -        gnutls_x509_crt_deinit(certs[i]);
> +    if (files->ncerts &&
> +        qcrypto_tls_creds_check_cert_pair(files,
> +                                          files->certs, files->ncerts,
> +                                          files->certpath, isServer,
> +                                          errp) < 0) {
> +        return -1;
>      }
> -    g_free(certs);
>
> -    return ret;
> +    return 0;
>  }
>
>
> @@ -589,8 +626,6 @@ qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509
> *creds,
>                                           files->cacertpath,
>                                           &files->cacerts,
>                                           &files->ncacerts,
> -                                         isServer,
> -                                         true,
>                                           errp) < 0) {
>          return -1;
>      }
> @@ -606,6 +641,79 @@ qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509
> *creds,
>      return 0;
>  }
>
> +
> +static int
> +qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
> +                                     QCryptoTLSCredsBox *box,
> +                                     QCryptoTLSCredsX509Files *files,
> +                                     bool isServer,
> +                                     Error **errp)
> +{
> +    int ret;
> +
> +    if (isServer) {
> +        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> +                                       QCRYPTO_TLS_CREDS_X509_SERVER_CER=
T,
> +                                       true, &files->certpath, errp) < 0
> ||
> +            qcrypto_tls_creds_get_path(&creds->parent_obj,
> +                                       QCRYPTO_TLS_CREDS_X509_SERVER_KEY=
,
> +                                       true, &files->keypath, errp) < 0)=
 {
> +            return -1;
> +        }
> +    } else {
> +        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> +                                       QCRYPTO_TLS_CREDS_X509_CLIENT_CER=
T,
> +                                       false, &files->certpath, errp) < =
0
> ||
> +            qcrypto_tls_creds_get_path(&creds->parent_obj,
> +                                       QCRYPTO_TLS_CREDS_X509_CLIENT_KEY=
,
> +                                       false, &files->keypath, errp) < 0=
)
> {
> +            return -1;
> +        }
> +    }
> +
> +    if (!files->certpath &&
> +        !files->keypath) {
> +        return 0;
> +    }
> +    if (files->certpath && !files->keypath) {
> +        error_setg(errp, "Cert '%s' without corresponding key",
> +                   files->certpath);
> +        return -1;
> +    }
> +    if (!files->certpath && files->keypath) {
> +        error_setg(errp, "Key '%s' without corresponding cert",
> +                   files->keypath);
> +        return -1;
> +    }
> +
> +    if (qcrypto_tls_creds_load_cert_list(creds,
> +                                         files->certpath,
> +                                         &files->certs,
> +                                         &files->ncerts,
> +                                         errp) < 0) {
> +        return -1;
> +    }
> +
> +    if (qcrypto_tls_creds_load_privkey(creds,
> +                                       files->keypath,
> +                                       &files->key,
> +                                       errp) < 0) {
> +        return -1;
> +    }
> +
> +    ret =3D gnutls_certificate_set_x509_key(box->data.cert,
> +                                          files->certs,
> +                                          files->ncerts,
> +                                          files->key);
> +    if (ret < 0) {
> +        error_setg(errp, "Cannot set certificate '%s' & key '%s': %s",
> +                   files->certpath, files->keypath, gnutls_strerror(ret)=
);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +
>  static int
>  qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
>                              Error **errp)
> @@ -613,8 +721,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>      g_autoptr(QCryptoTLSCredsBox) box =3D NULL;
>      g_autoptr(QCryptoTLSCredsX509Files) files =3D NULL;
>      g_autofree char *cacrl =3D NULL;
> -    g_autofree char *cert =3D NULL;
> -    g_autofree char *key =3D NULL;
>      g_autofree char *dhparams =3D NULL;
>      bool isServer =3D (creds->parent_obj.endpoint =3D=3D
>                       QCRYPTO_TLS_CREDS_ENDPOINT_SERVER);
> @@ -646,60 +752,27 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>          return -1;
>      }
>
> +    if (qcrypto_tls_creds_x509_load_identity(creds, box, files,
> +                                             isServer, errp) < 0) {
> +        return -1;
> +    }
> +
>      if (isServer) {
>          if (qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_X509_CA_CRL,
>                                         false, &cacrl, errp) < 0 ||
> -            qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_SERVER_CER=
T,
> -                                       true, &cert, errp) < 0 ||
> -            qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_SERVER_KEY=
,
> -                                       true, &key, errp) < 0 ||
>              qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_DH_PARAMS,
>                                         false, &dhparams, errp) < 0) {
>              return -1;
>          }
> -    } else {
> -        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_CLIENT_CER=
T,
> -                                       false, &cert, errp) < 0 ||
> -            qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_CLIENT_KEY=
,
> -                                       false, &key, errp) < 0) {
> -            return -1;
> -        }
>      }
>
>      if (creds->sanityCheck &&
> -        qcrypto_tls_creds_x509_sanity_check(creds, files, isServer,
> -                                            cert, errp) < 0) {
> +        qcrypto_tls_creds_x509_sanity_check(creds, files, isServer, errp=
)
> < 0) {
>          return -1;
>      }
>
> -    if (cert !=3D NULL && key !=3D NULL) {
> -        char *password =3D NULL;
> -        if (creds->passwordid) {
> -            password =3D qcrypto_secret_lookup_as_utf8(creds->passwordid=
,
> -                                                     errp);
> -            if (!password) {
> -                return -1;
> -            }
> -        }
> -        ret =3D gnutls_certificate_set_x509_key_file2(box->data.cert,
> -                                                    cert, key,
> -                                                    GNUTLS_X509_FMT_PEM,
> -                                                    password,
> -                                                    0);
> -        g_free(password);
> -        if (ret < 0) {
> -            error_setg(errp, "Cannot load certificate '%s' & key '%s':
> %s",
> -                       cert, key, gnutls_strerror(ret));
> -            return -1;
> -        }
> -    }
> -
>      if (cacrl !=3D NULL) {
>          ret =3D gnutls_certificate_set_x509_crl_file(box->data.cert,
>                                                     cacrl,
> diff --git a/tests/unit/test-crypto-tlscredsx509.c
> b/tests/unit/test-crypto-tlscredsx509.c
> index a5f21728d4..b1ad7d5c0d 100644
> --- a/tests/unit/test-crypto-tlscredsx509.c
> +++ b/tests/unit/test-crypto-tlscredsx509.c
> @@ -95,16 +95,16 @@ static void test_tls_creds(const void *opaque)
>          if (access(data->crt, R_OK) =3D=3D 0) {
>              g_assert(link(data->crt,
>                            CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT) =
=3D=3D
> 0);
> +            g_assert(link(KEYFILE,
> +                          CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY) =
=3D=3D
> 0);
>          }
> -        g_assert(link(KEYFILE,
> -                      CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY) =3D=3D=
 0);
>      } else {
>          if (access(data->crt, R_OK) =3D=3D 0) {
>              g_assert(link(data->crt,
>                            CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT) =
=3D=3D
> 0);
> +            g_assert(link(KEYFILE,
> +                          CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) =
=3D=3D
> 0);
>          }
> -        g_assert(link(KEYFILE,
> -                      CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) =3D=3D=
 0);
>      }
>
>      creds =3D test_tls_creds_create(
> --
> 2.51.1
>
>

--000000000000ef4c12064285110c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBUaHUsIE9jdCAzMCwgMjAyNSBhdCA2OjUw4oCvUE0gRGFuaWVsIFAuIEJl
cnJhbmfDqSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20iPmJlcnJhbmdl
QHJlZGhhdC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFw
eCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPlRoZSB4NTA5IFRMUyBj
cmVkZW50aWFscyBjb2RlIHdpbGwgbG9hZCB0aGUgaWRlbnRpdHkgY2VydHMgb25jZSB0bzxicj4N
CnBlcmZvcm0gc2FuaXR5IGNoY2tpbmcgb24gdGhlIGNlcnRzLCB0aGVuIGRpc2NhcmQgdGhlIGNl
cnRpZmljYXRlPGJyPg0Kb2JqZWN0cyBhbmQgbGV0IGdudXRscyBsb2FkIHRoZW0gYSBzZWNvbmQg
dGltZS48YnI+DQo8YnI+DQpUaGlzIGV4dGVuZHMgdGhlIHByZXZpb3VzIFFDcnlwdG9UTFNDcmVk
c1g1MDlGaWxlcyBzdHJ1Y3QgdG8gYWxzbzxicj4NCmhvbGQgdGhlIGlkZW50aXR5IGNlcnRpZmlj
YXRlcyAmYW1wOyBrZXkgbG9hZGVkIGZvciBzYW5pdHkgY2hlY2tpbmc8YnI+DQphbmQgcGFzcyB0
aGVtIG9uIHRvIGdudXRscywgYXZvaWRpbmcgdGhlIGR1cGxpY2F0ZWQgbG9hZGluZy48YnI+DQo8
YnI+DQpUaGUgdW5pdCB0ZXN0cyBuZWVkIHVwZGF0aW5nIGJlY2F1c2Ugd2Ugbm93IGNvcnJlY3Rs
eSBkaWFnbm9zZSB0aGU8YnI+DQplcnJvciBzY2VuYXJpbyB3aGVyZSB0aGUgY2VydCBQRU0gZmls
ZSBleGlzdHMsIHdpdGhvdXQgaXRzIG1hdGNoaW5nPGJyPg0Ka2V5IFBFTSBmaWxlLiBQcmV2aW91
c2x5IHRoYXQgZXJyb3Igd2FzIG1pc3Rha2VubHkgaWdub3JlZC48YnI+DQo8YnI+DQpTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgUC4gQmVycmFuZ8OpICZsdDs8YSBocmVmPSJtYWlsdG86YmVycmFuZ2VA
cmVkaGF0LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmJlcnJhbmdlQHJlZGhhdC5jb208L2E+Jmd0Ozxi
cj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5sZ3RtPC9kaXY+PGRpdj5SZXZpZXdl
ZC1ieTogTWFyYy1BbmRyw6kgTHVyZWF1ICZsdDs8YSBocmVmPSJtYWlsdG86bWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tIj5tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb208L2E+Jmd0OzwvZGl2
PjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIw
NCk7cGFkZGluZy1sZWZ0OjFleCI+DQotLS08YnI+DQrCoGNyeXB0by90bHNjcmVkc3g1MDkuY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCAyNDcgKysrKysrKysrKysrKysrKystLS0tLS0tLS08
YnI+DQrCoHRlc3RzL3VuaXQvdGVzdC1jcnlwdG8tdGxzY3JlZHN4NTA5LmMgfMKgIMKgOCArLTxi
cj4NCsKgMiBmaWxlcyBjaGFuZ2VkLCAxNjQgaW5zZXJ0aW9ucygrKSwgOTEgZGVsZXRpb25zKC0p
PGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2NyeXB0by90bHNjcmVkc3g1MDkuYyBiL2NyeXB0by90
bHNjcmVkc3g1MDkuYzxicj4NCmluZGV4IDZhODMwYWY1MGQuLjNjYjBhNmMzMWYgMTAwNjQ0PGJy
Pg0KLS0tIGEvY3J5cHRvL3Rsc2NyZWRzeDUwOS5jPGJyPg0KKysrIGIvY3J5cHRvL3Rsc2NyZWRz
eDUwOS5jPGJyPg0KQEAgLTQ1LDYgKzQ1LDEyIEBAIHN0cnVjdCBRQ3J5cHRvVExTQ3JlZHNYNTA5
RmlsZXMgezxicj4NCsKgIMKgIMKgY2hhciAqY2FjZXJ0cGF0aDs8YnI+DQrCoCDCoCDCoGdudXRs
c194NTA5X2NydF90ICpjYWNlcnRzOzxicj4NCsKgIMKgIMKgdW5zaWduZWQgaW50IG5jYWNlcnRz
Ozxicj4NCis8YnI+DQorwqAgwqAgY2hhciAqY2VydHBhdGg7PGJyPg0KK8KgIMKgIGNoYXIgKmtl
eXBhdGg7PGJyPg0KK8KgIMKgIGdudXRsc194NTA5X2NydF90ICpjZXJ0czs8YnI+DQorwqAgwqAg
dW5zaWduZWQgaW50IG5jZXJ0czs8YnI+DQorwqAgwqAgZ251dGxzX3g1MDlfcHJpdmtleV90IGtl
eTs8YnI+DQrCoH07PGJyPg0KPGJyPg0KwqBzdGF0aWMgUUNyeXB0b1RMU0NyZWRzWDUwOUZpbGVz
ICo8YnI+DQpAQCAtNjMsNiArNjksMTMgQEAgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9maWxlc19m
cmVlKFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyAqZmlsZXMpPGJyPg0KwqAgwqAgwqB9PGJyPg0K
wqAgwqAgwqBnX2ZyZWUoZmlsZXMtJmd0O2NhY2VydHMpOzxicj4NCsKgIMKgIMKgZ19mcmVlKGZp
bGVzLSZndDtjYWNlcnRwYXRoKTs8YnI+DQorwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IGZpbGVz
LSZndDtuY2VydHM7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCBnbnV0bHNfeDUwOV9jcnRfZGVp
bml0KGZpbGVzLSZndDtjZXJ0c1tpXSk7PGJyPg0KK8KgIMKgIH08YnI+DQorwqAgwqAgZ251dGxz
X3g1MDlfcHJpdmtleV9kZWluaXQoZmlsZXMtJmd0O2tleSk7PGJyPg0KK8KgIMKgIGdfZnJlZShm
aWxlcy0mZ3Q7Y2VydHMpOzxicj4NCivCoCDCoCBnX2ZyZWUoZmlsZXMtJmd0O2NlcnRwYXRoKTs8
YnI+DQorwqAgwqAgZ19mcmVlKGZpbGVzLSZndDtrZXlwYXRoKTs8YnI+DQrCoCDCoCDCoGdfZnJl
ZShmaWxlcyk7PGJyPg0KwqB9PGJyPg0KPGJyPg0KQEAgLTQ3NywxNCArNDkwLDEzIEBAIHFjcnlw
dG9fdGxzX2NyZWRzX2xvYWRfY2VydF9saXN0KFFDcnlwdG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNv
bnN0IGNoYXIgKmNlcnRGaWxlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGdudXRsc194NTA5X2NydF90ICoqY2VydHMsPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdW5zaWduZWQgaW50
ICpuY2VydHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYm9vbCBpc1NlcnZlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sIGlzQ0EsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRXJyb3IgKiplcnJwKTxicj4NCsKgezxi
cj4NCsKgIMKgIMKgZ251dGxzX2RhdHVtX3QgZGF0YTs8YnI+DQrCoCDCoCDCoGdfYXV0b2ZyZWUg
Y2hhciAqYnVmID0gTlVMTDs8YnI+DQrCoCDCoCDCoGdzaXplIGJ1Zmxlbjs8YnI+DQrCoCDCoCDC
oEdFcnJvciAqZ2VyciA9IE5VTEw7PGJyPg0KK8KgIMKgIGludCByZXQ7PGJyPg0KPGJyPg0KwqAg
wqAgwqAqbmNlcnRzID0gMDs8YnI+DQrCoCDCoCDCoHRyYWNlX3FjcnlwdG9fdGxzX2NyZWRzX3g1
MDlfbG9hZF9jZXJ0X2xpc3QoY3JlZHMsIGNlcnRGaWxlKTs8YnI+DQpAQCAtNDk5LDEzICs1MTEs
NjAgQEAgcWNyeXB0b190bHNfY3JlZHNfbG9hZF9jZXJ0X2xpc3QoUUNyeXB0b1RMU0NyZWRzWDUw
OSAqY3JlZHMsPGJyPg0KwqAgwqAgwqBkYXRhLmRhdGEgPSAodW5zaWduZWQgY2hhciAqKWJ1Zjs8
YnI+DQrCoCDCoCDCoGRhdGEuc2l6ZSA9IHN0cmxlbihidWYpOzxicj4NCjxicj4NCi3CoCDCoCBp
ZiAoZ251dGxzX3g1MDlfY3J0X2xpc3RfaW1wb3J0MihjZXJ0cywgbmNlcnRzLCAmYW1wO2RhdGEs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgR05VVExTX1g1MDlfRk1UX1BFTSwgMCkgJmx0OyAwKSB7PGJyPg0KLcKgIMKgIMKgIMKg
IGVycm9yX3NldGcoZXJycCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc0NB
ID8gJnF1b3Q7VW5hYmxlIHRvIGltcG9ydCBDQSBjZXJ0aWZpY2F0ZSBsaXN0ICVzJnF1b3Q7IDo8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoaXNTZXJ2ZXIgPyAmcXVvdDtVbmFi
bGUgdG8gaW1wb3J0IHNlcnZlciBjZXJ0aWZpY2F0ZSAlcyZxdW90OyA6PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O1VuYWJsZSB0byBpbXBvcnQgY2xpZW50IGNlcnRp
ZmljYXRlICVzJnF1b3Q7KSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjZXJ0
RmlsZSk7PGJyPg0KK8KgIMKgIHJldCA9IGdudXRsc194NTA5X2NydF9saXN0X2ltcG9ydDIoY2Vy
dHMsIG5jZXJ0cywgJmFtcDtkYXRhLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEdOVVRMU19YNTA5X0ZNVF9QRU0sIDApOzxi
cj4NCivCoCDCoCBpZiAocmV0ICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCBlcnJvcl9zZXRn
KGVycnAsICZxdW90O1VuYWJsZSB0byBpbXBvcnQgY2VydGlmaWNhdGUgJXM6ICVzJnF1b3Q7LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNlcnRGaWxlLCBnbnV0bHNfc3RyZXJy
b3IocmV0KSk7PGJyPg0KK8KgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQorwqAgwqAgfTxicj4N
Cis8YnI+DQorwqAgwqAgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0KKzxicj4NCitzdGF0
aWMgaW50PGJyPg0KK3FjcnlwdG9fdGxzX2NyZWRzX2xvYWRfcHJpdmtleShRQ3J5cHRvVExTQ3Jl
ZHNYNTA5ICpjcmVkcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjb25zdCBjaGFyICprZXlGaWxlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdudXRsc194NTA5X3ByaXZrZXlfdCAqa2V5LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVycm9y
ICoqZXJycCk8YnI+DQorezxicj4NCivCoCDCoCBnbnV0bHNfZGF0dW1fdCBkYXRhOzxicj4NCivC
oCDCoCBnX2F1dG9mcmVlIGNoYXIgKmJ1ZiA9IE5VTEw7PGJyPg0KK8KgIMKgIGdfYXV0b2ZyZWUg
Y2hhciAqcGFzc3dvcmQgPSBOVUxMOzxicj4NCivCoCDCoCBnc2l6ZSBidWZsZW47PGJyPg0KK8Kg
IMKgIEdFcnJvciAqZ2VyciA9IE5VTEw7PGJyPg0KK8KgIMKgIGludCByZXQ7PGJyPg0KKzxicj4N
CivCoCDCoCByZXQgPSBnbnV0bHNfeDUwOV9wcml2a2V5X2luaXQoa2V5KTs8YnI+DQorwqAgwqAg
aWYgKHJldCAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAmcXVv
dDtVbmFibGUgdG8gaW5pdGlhbGl6ZSBwcml2YXRlIGtleTogJXMmcXVvdDssPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZ251dGxzX3N0cmVycm9yKHJldCkpOzxicj4NCivCoCDC
oCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+DQorPGJyPg0KK8KgIMKgIGlmICgh
Z19maWxlX2dldF9jb250ZW50cyhrZXlGaWxlLCAmYW1wO2J1ZiwgJmFtcDtidWZsZW4sICZhbXA7
Z2VycikpIHs8YnI+DQorwqAgwqAgwqAgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAmcXVvdDtDYW5ub3Qg
bG9hZCBwcml2YXRlIGtleSAlczogJXMmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKga2V5RmlsZSwgZ2Vyci0mZ3Q7bWVzc2FnZSk7PGJyPg0KK8KgIMKgIMKgIMKgIGdf
ZXJyb3JfZnJlZShnZXJyKTs8YnI+DQorwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCivCoCDC
oCB9PGJyPg0KKzxicj4NCivCoCDCoCBkYXRhLmRhdGEgPSAodW5zaWduZWQgY2hhciAqKWJ1Zjs8
YnI+DQorwqAgwqAgZGF0YS5zaXplID0gc3RybGVuKGJ1Zik7PGJyPg0KKzxicj4NCivCoCDCoCBp
ZiAoY3JlZHMtJmd0O3Bhc3N3b3JkaWQpIHs8YnI+DQorwqAgwqAgwqAgwqAgcGFzc3dvcmQgPSBx
Y3J5cHRvX3NlY3JldF9sb29rdXBfYXNfdXRmOChjcmVkcy0mZ3Q7cGFzc3dvcmRpZCw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBlcnJwKTs8YnI+DQorwqAgwqAgwqAgwqAgaWYgKCFwYXNzd29yZCkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIMKgIMKgIH08
YnI+DQorwqAgwqAgfTxicj4NCis8YnI+DQorwqAgwqAgaWYgKGdudXRsc194NTA5X3ByaXZrZXlf
aW1wb3J0Migqa2V5LCAmYW1wO2RhdGEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEdOVVRMU19YNTA5X0ZNVF9QRU0sPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBhc3N3
b3JkLCAwKSAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAmcXVv
dDtVbmFibGUgdG8gaW1wb3J0IHByaXZhdGUga2V5ICVzJnF1b3Q7LCBrZXlGaWxlKTs8YnI+DQrC
oCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoH08YnI+DQo8YnI+DQpAQCAtNTE3
LDU2ICs1NzYsMzQgQEAgc3RhdGljIGludDxicj4NCsKgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9z
YW5pdHlfY2hlY2soUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ3J5cHRvVExTQ3Jl
ZHNYNTA5RmlsZXMgKmZpbGVzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYm9vbCBpc1NlcnZlciw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3QgY2hhciAqY2Vy
dEZpbGUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBFcnJvciAqKmVycnApPGJyPg0KwqB7PGJyPg0KLcKgIMKgIGdudXRsc194NTA5
X2NydF90ICpjZXJ0cyA9IE5VTEw7PGJyPg0KLcKgIMKgIHVuc2lnbmVkIGludCBuY2VydHMgPSAw
Ozxicj4NCsKgIMKgIMKgc2l6ZV90IGk7PGJyPg0KLcKgIMKgIGludCByZXQgPSAtMTs8YnI+DQot
PGJyPg0KLcKgIMKgIGlmIChjZXJ0RmlsZSkgezxicj4NCi3CoCDCoCDCoCDCoCBpZiAocWNyeXB0
b190bHNfY3JlZHNfbG9hZF9jZXJ0X2xpc3QoY3JlZHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2VydEZp
bGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtjZXJ0cyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO25j
ZXJ0cyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmYWxzZSw8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBlcnJwKSAmbHQ7IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
Z290byBjbGVhbnVwOzxicj4NCi3CoCDCoCDCoCDCoCB9PGJyPg0KLcKgIMKgIH08YnI+DQo8YnI+
DQotwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IG5jZXJ0czsgaSsrKSB7PGJyPg0KK8KgIMKgIGZv
ciAoaSA9IDA7IGkgJmx0OyBmaWxlcy0mZ3Q7bmNlcnRzOyBpKyspIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoGlmIChxY3J5cHRvX3Rsc19jcmVkc19jaGVja19jZXJ0KGNyZWRzLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNl
cnRzW2ldLCBjZXJ0RmlsZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaWxlcy0mZ3Q7Y2VydHNbaV0sIGZpbGVzLSZn
dDtjZXJ0cGF0aCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpc1NlcnZlciwgaSAhPSAwLCBlcnJwKSAmbHQ7IDApIHs8
YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgZ290byBjbGVhbnVwOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqB9PGJyPg0K
PGJyPg0KLcKgIMKgIGlmIChuY2VydHMgJmFtcDsmYW1wOzxicj4NCivCoCDCoCBpZiAoZmlsZXMt
Jmd0O25jZXJ0cyAmYW1wOyZhbXA7PGJyPg0KwqAgwqAgwqAgwqAgwqBxY3J5cHRvX3Rsc19jcmVk
c19jaGVja19hdXRob3JpdHlfY2hhaW4oY3JlZHMsIGZpbGVzLDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBjZXJ0cywgbmNlcnRzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaWxlcy0mZ3Q7Y2VydHMsIGZp
bGVzLSZndDtuY2VydHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciwgZXJycCkgJmx0
OyAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIGdvdG8gY2xlYW51cDs8YnI+DQotwqAgwqAgfTxicj4N
Ci08YnI+DQotwqAgwqAgaWYgKG5jZXJ0cyAmYW1wOyZhbXA7PGJyPg0KLcKgIMKgIMKgIMKgIHFj
cnlwdG9fdGxzX2NyZWRzX2NoZWNrX2NlcnRfcGFpcihmaWxlcywgY2VydHMsIG5jZXJ0cywgY2Vy
dEZpbGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlzU2VydmVyLCBlcnJwKSAmbHQ7IDApIHs8YnI+DQotwqAgwqAg
wqAgwqAgZ290byBjbGVhbnVwOzxicj4NCivCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KwqAg
wqAgwqB9PGJyPg0KPGJyPg0KLcKgIMKgIHJldCA9IDA7PGJyPg0KLTxicj4NCi0gY2xlYW51cDo8
YnI+DQotwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IG5jZXJ0czsgaSsrKSB7PGJyPg0KLcKgIMKg
IMKgIMKgIGdudXRsc194NTA5X2NydF9kZWluaXQoY2VydHNbaV0pOzxicj4NCivCoCDCoCBpZiAo
ZmlsZXMtJmd0O25jZXJ0cyAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIHFjcnlwdG9fdGxz
X2NyZWRzX2NoZWNrX2NlcnRfcGFpcihmaWxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmlsZXMtJmd0O2NlcnRz
LCBmaWxlcy0mZ3Q7bmNlcnRzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaWxlcy0mZ3Q7Y2VydHBhdGgsIGlzU2Vy
dmVyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBlcnJwKSAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgcmV0dXJu
IC0xOzxicj4NCsKgIMKgIMKgfTxicj4NCi3CoCDCoCBnX2ZyZWUoY2VydHMpOzxicj4NCjxicj4N
Ci3CoCDCoCByZXR1cm4gcmV0Ozxicj4NCivCoCDCoCByZXR1cm4gMDs8YnI+DQrCoH08YnI+DQo8
YnI+DQo8YnI+DQpAQCAtNTg5LDggKzYyNiw2IEBAIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfbG9h
ZF9jYShRQ3J5cHRvVExTQ3JlZHNYNTA5ICpjcmVkcyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaWxlcy0mZ3Q7Y2Fj
ZXJ0cGF0aCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2ZpbGVzLSZndDtjYWNlcnRzLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZh
bXA7ZmlsZXMtJmd0O25jYWNlcnRzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlzU2VydmVyLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRy
dWUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZXJycCkgJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqByZXR1cm4g
LTE7PGJyPg0KwqAgwqAgwqB9PGJyPg0KQEAgLTYwNiw2ICs2NDEsNzkgQEAgcWNyeXB0b190bHNf
Y3JlZHNfeDUwOV9sb2FkX2NhKFFDcnlwdG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKg
IMKgcmV0dXJuIDA7PGJyPg0KwqB9PGJyPg0KPGJyPg0KKzxicj4NCitzdGF0aWMgaW50PGJyPg0K
K3FjcnlwdG9fdGxzX2NyZWRzX3g1MDlfbG9hZF9pZGVudGl0eShRQ3J5cHRvVExTQ3JlZHNYNTA5
ICpjcmVkcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBRQ3J5cHRvVExTQ3JlZHNCb3ggKmJveCw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ3J5cHRvVExTQ3Jl
ZHNYNTA5RmlsZXMgKmZpbGVzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJvb2wgaXNTZXJ2ZXIsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRXJyb3IgKiplcnJw
KTxicj4NCit7PGJyPg0KK8KgIMKgIGludCByZXQ7PGJyPg0KKzxicj4NCivCoCDCoCBpZiAoaXNT
ZXJ2ZXIpIHs8YnI+DQorwqAgwqAgwqAgwqAgaWYgKHFjcnlwdG9fdGxzX2NyZWRzX2dldF9wYXRo
KCZhbXA7Y3JlZHMtJmd0O3BhcmVudF9vYmosPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUUNSWVBUT19UTFNfQ1JFRFNfWDUw
OV9TRVJWRVJfQ0VSVCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0cnVlLCAmYW1wO2ZpbGVzLSZndDtjZXJ0cGF0aCwgZXJy
cCkgJmx0OyAwIHx8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHFjcnlwdG9fdGxzX2NyZWRzX2dl
dF9wYXRoKCZhbXA7Y3JlZHMtJmd0O3BhcmVudF9vYmosPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUUNSWVBUT19UTFNfQ1JF
RFNfWDUwOV9TRVJWRVJfS0VZLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRydWUsICZhbXA7ZmlsZXMtJmd0O2tleXBhdGgs
IGVycnApICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0K
K8KgIMKgIMKgIMKgIH08YnI+DQorwqAgwqAgfSBlbHNlIHs8YnI+DQorwqAgwqAgwqAgwqAgaWYg
KHFjcnlwdG9fdGxzX2NyZWRzX2dldF9wYXRoKCZhbXA7Y3JlZHMtJmd0O3BhcmVudF9vYmosPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgUUNSWVBUT19UTFNfQ1JFRFNfWDUwOV9DTElFTlRfQ0VSVCw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmYWxzZSwg
JmFtcDtmaWxlcy0mZ3Q7Y2VydHBhdGgsIGVycnApICZsdDsgMCB8fDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCBxY3J5cHRvX3Rsc19jcmVkc19nZXRfcGF0aCgmYW1wO2NyZWRzLSZndDtwYXJlbnRf
b2JqLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFFDUllQVE9fVExTX0NSRURTX1g1MDlfQ0xJRU5UX0tFWSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
YWxzZSwgJmFtcDtmaWxlcy0mZ3Q7a2V5cGF0aCwgZXJycCkgJmx0OyAwKSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQorwqAgwqAgwqAgwqAgfTxicj4NCivCoCDCoCB9
PGJyPg0KKzxicj4NCivCoCDCoCBpZiAoIWZpbGVzLSZndDtjZXJ0cGF0aCAmYW1wOyZhbXA7PGJy
Pg0KK8KgIMKgIMKgIMKgICFmaWxlcy0mZ3Q7a2V5cGF0aCkgezxicj4NCivCoCDCoCDCoCDCoCBy
ZXR1cm4gMDs8YnI+DQorwqAgwqAgfTxicj4NCivCoCDCoCBpZiAoZmlsZXMtJmd0O2NlcnRwYXRo
ICZhbXA7JmFtcDsgIWZpbGVzLSZndDtrZXlwYXRoKSB7PGJyPg0KK8KgIMKgIMKgIMKgIGVycm9y
X3NldGcoZXJycCwgJnF1b3Q7Q2VydCAmIzM5OyVzJiMzOTsgd2l0aG91dCBjb3JyZXNwb25kaW5n
IGtleSZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaWxlcy0mZ3Q7
Y2VydHBhdGgpOzxicj4NCivCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+
DQorwqAgwqAgaWYgKCFmaWxlcy0mZ3Q7Y2VydHBhdGggJmFtcDsmYW1wOyBmaWxlcy0mZ3Q7a2V5
cGF0aCkgezxicj4NCivCoCDCoCDCoCDCoCBlcnJvcl9zZXRnKGVycnAsICZxdW90O0tleSAmIzM5
OyVzJiMzOTsgd2l0aG91dCBjb3JyZXNwb25kaW5nIGNlcnQmcXVvdDssPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZmlsZXMtJmd0O2tleXBhdGgpOzxicj4NCivCoCDCoCDCoCDC
oCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+DQorPGJyPg0KK8KgIMKgIGlmIChxY3J5cHRv
X3Rsc19jcmVkc19sb2FkX2NlcnRfbGlzdChjcmVkcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaWxlcy0mZ3Q7Y2Vy
dHBhdGgsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtmaWxlcy0mZ3Q7Y2VydHMsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtm
aWxlcy0mZ3Q7bmNlcnRzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycnApICZsdDsgMCkgezxicj4NCivCoCDCoCDC
oCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+DQorPGJyPg0KK8KgIMKgIGlmIChxY3J5
cHRvX3Rsc19jcmVkc19sb2FkX3ByaXZrZXkoY3JlZHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmlsZXMtJmd0O2tleXBh
dGgsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgJmFtcDtmaWxlcy0mZ3Q7a2V5LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVycnApICZsdDsgMCkgezxi
cj4NCivCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+DQorPGJyPg0KK8Kg
IMKgIHJldCA9IGdudXRsc19jZXJ0aWZpY2F0ZV9zZXRfeDUwOV9rZXkoYm94LSZndDtkYXRhLmNl
cnQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGZpbGVzLSZndDtjZXJ0cyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmlsZXMtJmd0O25j
ZXJ0cyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZmlsZXMtJmd0O2tleSk7PGJyPg0KK8KgIMKgIGlmIChyZXQgJmx0
OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIGVycm9yX3NldGcoZXJycCwgJnF1b3Q7Q2Fubm90IHNl
dCBjZXJ0aWZpY2F0ZSAmIzM5OyVzJiMzOTsgJmFtcDsga2V5ICYjMzk7JXMmIzM5OzogJXMmcXVv
dDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmlsZXMtJmd0O2NlcnRwYXRo
LCBmaWxlcy0mZ3Q7a2V5cGF0aCwgZ251dGxzX3N0cmVycm9yKHJldCkpOzxicj4NCivCoCDCoCDC
oCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+DQorwqAgwqAgcmV0dXJuIDA7PGJyPg0K
K308YnI+DQorPGJyPg0KKzxicj4NCsKgc3RhdGljIGludDxicj4NCsKgcWNyeXB0b190bHNfY3Jl
ZHNfeDUwOV9sb2FkKFFDcnlwdG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRXJyb3IgKiplcnJwKTxicj4NCkBAIC02
MTMsOCArNzIxLDYgQEAgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9sb2FkKFFDcnlwdG9UTFNDcmVk
c1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKgZ19hdXRvcHRyKFFDcnlwdG9UTFNDcmVkc0JveCkg
Ym94ID0gTlVMTDs8YnI+DQrCoCDCoCDCoGdfYXV0b3B0cihRQ3J5cHRvVExTQ3JlZHNYNTA5Rmls
ZXMpIGZpbGVzID0gTlVMTDs8YnI+DQrCoCDCoCDCoGdfYXV0b2ZyZWUgY2hhciAqY2FjcmwgPSBO
VUxMOzxicj4NCi3CoCDCoCBnX2F1dG9mcmVlIGNoYXIgKmNlcnQgPSBOVUxMOzxicj4NCi3CoCDC
oCBnX2F1dG9mcmVlIGNoYXIgKmtleSA9IE5VTEw7PGJyPg0KwqAgwqAgwqBnX2F1dG9mcmVlIGNo
YXIgKmRocGFyYW1zID0gTlVMTDs8YnI+DQrCoCDCoCDCoGJvb2wgaXNTZXJ2ZXIgPSAoY3JlZHMt
Jmd0O3BhcmVudF9vYmouZW5kcG9pbnQgPT08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBRQ1JZUFRPX1RMU19DUkVEU19FTkRQT0lOVF9TRVJWRVIpOzxicj4NCkBAIC02NDYs
NjAgKzc1MiwyNyBAQCBxY3J5cHRvX3Rsc19jcmVkc194NTA5X2xvYWQoUUNyeXB0b1RMU0NyZWRz
WDUwOSAqY3JlZHMsPGJyPg0KwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqB9
PGJyPg0KPGJyPg0KK8KgIMKgIGlmIChxY3J5cHRvX3Rsc19jcmVkc194NTA5X2xvYWRfaWRlbnRp
dHkoY3JlZHMsIGJveCwgZmlsZXMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXNTZXJ2ZXIsIGVycnApICZs
dDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+DQor
PGJyPg0KwqAgwqAgwqBpZiAoaXNTZXJ2ZXIpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoGlmIChxY3J5
cHRvX3Rsc19jcmVkc19nZXRfcGF0aCgmYW1wO2NyZWRzLSZndDtwYXJlbnRfb2JqLDxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFFDUllQVE9fVExTX0NSRURTX1g1MDlfQ0FfQ1JMLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZhbHNlLCAmYW1wO2NhY3Js
LCBlcnJwKSAmbHQ7IDAgfHw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgcWNyeXB0b190bHNfY3Jl
ZHNfZ2V0X3BhdGgoJmFtcDtjcmVkcy0mZ3Q7cGFyZW50X29iaiw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ1JZUFRPX1RM
U19DUkVEU19YNTA5X1NFUlZFUl9DRVJULDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRydWUsICZhbXA7Y2VydCwgZXJycCkg
Jmx0OyAwIHx8PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHFjcnlwdG9fdGxzX2NyZWRzX2dldF9w
YXRoKCZhbXA7Y3JlZHMtJmd0O3BhcmVudF9vYmosPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUUNSWVBUT19UTFNfQ1JFRFNf
WDUwOV9TRVJWRVJfS0VZLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRydWUsICZhbXA7a2V5LCBlcnJwKSAmbHQ7IDAgfHw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoHFjcnlwdG9fdGxzX2NyZWRzX2dldF9wYXRoKCZhbXA7
Y3JlZHMtJmd0O3BhcmVudF9vYmosPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUUNSWVBUT19UTFNfQ1JFRFNfREhfUEFSQU1T
LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGZhbHNlLCAmYW1wO2RocGFyYW1zLCBlcnJwKSAmbHQ7IDApIHs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQotwqAg
wqAgfSBlbHNlIHs8YnI+DQotwqAgwqAgwqAgwqAgaWYgKHFjcnlwdG9fdGxzX2NyZWRzX2dldF9w
YXRoKCZhbXA7Y3JlZHMtJmd0O3BhcmVudF9vYmosPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUUNSWVBUT19UTFNfQ1JFRFNf
WDUwOV9DTElFTlRfQ0VSVCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmYWxzZSwgJmFtcDtjZXJ0LCBlcnJwKSAmbHQ7IDAg
fHw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgcWNyeXB0b190bHNfY3JlZHNfZ2V0X3BhdGgoJmFt
cDtjcmVkcy0mZ3Q7cGFyZW50X29iaiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ1JZUFRPX1RMU19DUkVEU19YNTA5X0NM
SUVOVF9LRVksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZmFsc2UsICZhbXA7a2V5LCBlcnJwKSAmbHQ7IDApIHs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCi3CoCDCoCDCoCDCoCB9PGJyPg0KwqAg
wqAgwqB9PGJyPg0KPGJyPg0KwqAgwqAgwqBpZiAoY3JlZHMtJmd0O3Nhbml0eUNoZWNrICZhbXA7
JmFtcDs8YnI+DQotwqAgwqAgwqAgwqAgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9zYW5pdHlfY2hl
Y2soY3JlZHMsIGZpbGVzLCBpc1NlcnZlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2VydCwgZXJycCkgJmx0
OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfc2FuaXR5X2No
ZWNrKGNyZWRzLCBmaWxlcywgaXNTZXJ2ZXIsIGVycnApICZsdDsgMCkgezxicj4NCsKgIMKgIMKg
IMKgIMKgcmV0dXJuIC0xOzxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4NCi3CoCDCoCBpZiAoY2Vy
dCAhPSBOVUxMICZhbXA7JmFtcDsga2V5ICE9IE5VTEwpIHs8YnI+DQotwqAgwqAgwqAgwqAgY2hh
ciAqcGFzc3dvcmQgPSBOVUxMOzxicj4NCi3CoCDCoCDCoCDCoCBpZiAoY3JlZHMtJmd0O3Bhc3N3
b3JkaWQpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgcGFzc3dvcmQgPSBxY3J5cHRvX3NlY3Jl
dF9sb29rdXBfYXNfdXRmOChjcmVkcy0mZ3Q7cGFzc3dvcmRpZCw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBlcnJwKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFwYXNzd29yZCkg
ezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCDCoCDCoCByZXQgPSBn
bnV0bHNfY2VydGlmaWNhdGVfc2V0X3g1MDlfa2V5X2ZpbGUyKGJveC0mZ3Q7ZGF0YS5jZXJ0LDxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjZXJ0LCBrZXksPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIEdOVVRMU19YNTA5X0ZNVF9QRU0sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBh
c3N3b3JkLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAwKTs8YnI+DQotwqAgwqAgwqAgwqAg
Z19mcmVlKHBhc3N3b3JkKTs8YnI+DQotwqAgwqAgwqAgwqAgaWYgKHJldCAmbHQ7IDApIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAmcXVvdDtDYW5ub3QgbG9hZCBj
ZXJ0aWZpY2F0ZSAmIzM5OyVzJiMzOTsgJmFtcDsga2V5ICYjMzk7JXMmIzM5OzogJXMmcXVvdDss
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2VydCwga2V5LCBnbnV0
bHNfc3RyZXJyb3IocmV0KSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+
DQotwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCB9PGJyPg0KLTxicj4NCsKgIMKgIMKgaWYgKGNh
Y3JsICE9IE5VTEwpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoHJldCA9IGdudXRsc19jZXJ0aWZpY2F0
ZV9zZXRfeDUwOV9jcmxfZmlsZShib3gtJmd0O2RhdGEuY2VydCw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBjYWNybCw8YnI+DQpkaWZmIC0tZ2l0IGEvdGVzdHMvdW5pdC90ZXN0LWNyeXB0by10
bHNjcmVkc3g1MDkuYyBiL3Rlc3RzL3VuaXQvdGVzdC1jcnlwdG8tdGxzY3JlZHN4NTA5LmM8YnI+
DQppbmRleCBhNWYyMTcyOGQ0Li5iMWFkN2Q1YzBkIDEwMDY0NDxicj4NCi0tLSBhL3Rlc3RzL3Vu
aXQvdGVzdC1jcnlwdG8tdGxzY3JlZHN4NTA5LmM8YnI+DQorKysgYi90ZXN0cy91bml0L3Rlc3Qt
Y3J5cHRvLXRsc2NyZWRzeDUwOS5jPGJyPg0KQEAgLTk1LDE2ICs5NSwxNiBAQCBzdGF0aWMgdm9p
ZCB0ZXN0X3Rsc19jcmVkcyhjb25zdCB2b2lkICpvcGFxdWUpPGJyPg0KwqAgwqAgwqAgwqAgwqBp
ZiAoYWNjZXNzKGRhdGEtJmd0O2NydCwgUl9PSykgPT0gMCkgezxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgZ19hc3NlcnQobGluayhkYXRhLSZndDtjcnQsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBDRVJUX0RJUiBRQ1JZUFRPX1RMU19DUkVEU19YNTA5X1NF
UlZFUl9DRVJUKSA9PSAwKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgZ19hc3NlcnQobGluayhL
RVlGSUxFLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBDRVJU
X0RJUiBRQ1JZUFRPX1RMU19DUkVEU19YNTA5X1NFUlZFUl9LRVkpID09IDApOzxicj4NCsKgIMKg
IMKgIMKgIMKgfTxicj4NCi3CoCDCoCDCoCDCoCBnX2Fzc2VydChsaW5rKEtFWUZJTEUsPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIENFUlRfRElSIFFDUllQVE9fVExTX0NS
RURTX1g1MDlfU0VSVkVSX0tFWSkgPT0gMCk7PGJyPg0KwqAgwqAgwqB9IGVsc2Ugezxicj4NCsKg
IMKgIMKgIMKgIMKgaWYgKGFjY2VzcyhkYXRhLSZndDtjcnQsIFJfT0spID09IDApIHs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoGdfYXNzZXJ0KGxpbmsoZGF0YS0mZ3Q7Y3J0LDxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQ0VSVF9ESVIgUUNSWVBUT19UTFNf
Q1JFRFNfWDUwOV9DTElFTlRfQ0VSVCkgPT0gMCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGdf
YXNzZXJ0KGxpbmsoS0VZRklMRSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgQ0VSVF9ESVIgUUNSWVBUT19UTFNfQ1JFRFNfWDUwOV9DTElFTlRfS0VZKSA9PSAw
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQotwqAgwqAgwqAgwqAgZ19hc3NlcnQobGluayhL
RVlGSUxFLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBDRVJUX0RJUiBR
Q1JZUFRPX1RMU19DUkVEU19YNTA5X0NMSUVOVF9LRVkpID09IDApOzxicj4NCsKgIMKgIMKgfTxi
cj4NCjxicj4NCsKgIMKgIMKgY3JlZHMgPSB0ZXN0X3Rsc19jcmVkc19jcmVhdGUoPGJyPg0KLS0g
PGJyPg0KMi41MS4xPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pg0K
--000000000000ef4c12064285110c--


