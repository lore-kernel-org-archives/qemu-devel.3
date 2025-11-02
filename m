Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89629CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 08:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFTCP-0004vc-C8; Sun, 02 Nov 2025 03:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFTCK-0004vN-Hm
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 03:12:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFTCG-0008QE-43
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 03:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762071137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9bvmPWC9NxtSxydfx6T4aeOvZgK5xg/CDw5Hujj0dc=;
 b=KQVA0L2RFquRmXRAfVphQJNlgEUrVloxnsy51prbd/NW8lc7kGhQeaEburaNjeRdZXGEdy
 C63+77ikBu9AlX1HK5+lBZfad2yR22EH9IVJsrzByOUTaP3FWGbCh5qhaRheecV3IIVWxE
 +w29mKmWdSFppd8YazB4hhImXIZNM14=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-6BK9ibmuMaePIJr-6P1OZw-1; Sun, 02 Nov 2025 03:11:40 -0500
X-MC-Unique: 6BK9ibmuMaePIJr-6P1OZw-1
X-Mimecast-MFC-AGG-ID: 6BK9ibmuMaePIJr-6P1OZw_1762071099
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b969f3f5bb1so2531986a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762071099; x=1762675899; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u9bvmPWC9NxtSxydfx6T4aeOvZgK5xg/CDw5Hujj0dc=;
 b=AG6iJrIHcJfNzxXlQfR+gR93MvsJCNphmqV32Y+N/T9FsGOz4umx+F2z8L1oN1tDIh
 EofmJ2FSbdPPbC6BcvAof7z5SpyPQg1hQw8hUEJmxrTe5W4q+yvUgqztWZrdqfIe57/3
 6bNQmoflRWukFI/2b1ReuWvPF90g5N+5ETAbCip/EtTbPfj1BtqgQtlabHWveqT4McA8
 x9fJLGeEb7QOLCddc3SBV501iyleHjNysziSbdxWMdbk84bZG1W28f1GPcqYYVdE2sV8
 S6TeWqNNDLIbmPfqSaWFCtaxkhGXykP82apnZbGRQlMyVjpdIeG5aLGwvMslGg8YWwTh
 c1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762071099; x=1762675899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9bvmPWC9NxtSxydfx6T4aeOvZgK5xg/CDw5Hujj0dc=;
 b=VeXDPyCVkCtZbyiw5H8MqauPqvGVbpjQNID/IyMgBztAbUErb9662rxhehpmYHgSEu
 1U+r2GQWyKub8GUDtaWY/cvRmZ163Ggsri+nX+J3yMSSKiT9PUNwKI59+lP5RGuHa9LE
 0VPJxVUsNCn4f/Flbv8s4UCgj1Gp+SbuBvKF+lxE/ApuKPks85y8RvwigHimNgz0fJAT
 z9dbZL34I3mxas2g9O7l4CZs0zonMZHlfyXW+21KkZbNTwd8lD5PhtS4I5mk+8Q11t6g
 EoNS3QqLM1wyqDZ3Wu4d/YJARfuUNSCOGeqQN4xBcGjKqlj5EOWY2Y7tKSc/j2BenpV5
 69XQ==
X-Gm-Message-State: AOJu0YzDS10xKRx11d4UIVHdDpG1W4w3t22LwDZ63MHks3kA0Ri/25rm
 vvdQGpk+w++k8eVxoCFtgTtloTqKF8zPeASq4FZwWBeZCG4E0aYIXkeenjDBqGWzj2IdB+qCB05
 EnfVVVRlNzFi5G4keh1i90ZK5YF0tV+GbRQu7n5qWeGu1ZEI9YaLe5j6AeZj2kzMhjBZxWM7Oox
 3yLh+vVZkB5msqZyBctXrsvy1uYwpcYNI=
X-Gm-Gg: ASbGncv2AfrfZamOCjtzy+f24+2ENFFKNRDFhuGCNMcQx8S4JfwfcENtEevwmn3Fjby
 rmOPUSnANKxwrGrwTNe5jAYfRsBOrEnvRmF5ldgr6ZJOw8M+F/73ec8aPuj2Spo7MyXXxVDeuSO
 Kjn29VeFwlrn2z18o9uyTZWdBPQafJ2Xixshuu3/nZQtLdaDSIhqt1x4fwpVfv5w==
X-Received: by 2002:a05:6a20:2447:b0:347:9ae1:cffb with SMTP id
 adf61e73a8af0-348cab8372amr12472229637.24.1762071098982; 
 Sun, 02 Nov 2025 01:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ1pcIj74zASQny/vHmsRCatsADKLj4DSw1vM+LtXHP8XMTsMQQAuKkA/IqohV2QSyA7209fFeYCzTt/6oyy0=
X-Received: by 2002:a05:6a20:2447:b0:347:9ae1:cffb with SMTP id
 adf61e73a8af0-348cab8372amr12472213637.24.1762071098563; Sun, 02 Nov 2025
 01:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-20-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-20-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 2 Nov 2025 12:11:26 +0400
X-Gm-Features: AWmQ_bkaYpZsN-yeiwNNcF82aI9RCwf465tu8liQ4HJCOyQNR996xpx_zOACEKI
Message-ID: <CAMxuvaw4AfmRwtofASZ=h3SH1DKJA+RB2k2QG9P6x4Ws5OZ-Ww@mail.gmail.com>
Subject: Re: [PATCH 19/21] crypto: expand logic to cope with multiple
 certificate identities
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000e6305d0642982553"
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

--000000000000e6305d0642982553
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Currently only a single set of certificates can be loaded for a
> server / client. Certificates are created using a particular
> key algorithm and in some scenarios it can be useful to support
> multiple algorithms in parallel. This requires the ability to
> load multiple sets of certificates.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c | 164 ++++++++++++++++++++++++++++--------------
>  1 file changed, 112 insertions(+), 52 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 3cb0a6c31f..d7d1f594c0 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -39,6 +39,14 @@ struct QCryptoTLSCredsX509 {
>      char *passwordid;
>  };
>
> +typedef struct QCryptoTLSCredsX509IdentFiles
> QCryptoTLSCredsX509IdentFiles;
> +struct QCryptoTLSCredsX509IdentFiles {
> +    char *certpath;
> +    char *keypath;
> +    gnutls_x509_crt_t *certs;
> +    unsigned int ncerts;
> +    gnutls_x509_privkey_t key;
> +};
>
>  typedef struct QCryptoTLSCredsX509Files QCryptoTLSCredsX509Files;
>  struct QCryptoTLSCredsX509Files {
> @@ -46,11 +54,8 @@ struct QCryptoTLSCredsX509Files {
>      gnutls_x509_crt_t *cacerts;
>      unsigned int ncacerts;
>
> -    char *certpath;
> -    char *keypath;
> -    gnutls_x509_crt_t *certs;
> -    unsigned int ncerts;
> -    gnutls_x509_privkey_t key;
> +    QCryptoTLSCredsX509IdentFiles **identities;
> +    size_t nidentities;
>  };
>
>  static QCryptoTLSCredsX509Files *
> @@ -61,14 +66,9 @@ qcrypto_tls_creds_x509_files_new(void)
>
>
>  static void
> -qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
> +qcrypto_tls_creds_x509_ident_files_free(QCryptoTLSCredsX509IdentFiles
> *files)
>  {
>      size_t i;
> -    for (i =3D 0; i < files->ncacerts; i++) {
> -        gnutls_x509_crt_deinit(files->cacerts[i]);
> -    }
> -    g_free(files->cacerts);
> -    g_free(files->cacertpath);
>      for (i =3D 0; i < files->ncerts; i++) {
>          gnutls_x509_crt_deinit(files->certs[i]);
>      }
> @@ -79,6 +79,26 @@
> qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
>      g_free(files);
>  }
>
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsX509IdentFiles,
> +                              qcrypto_tls_creds_x509_ident_files_free);
> +
> +
> +static void
> +qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
> +{
> +    size_t i;
> +    for (i =3D 0; i < files->ncacerts; i++) {
> +        gnutls_x509_crt_deinit(files->cacerts[i]);
> +    }
> +    g_free(files->cacerts);
> +    g_free(files->cacertpath);
> +    for (i =3D 0; i < files->nidentities; i++) {
> +        qcrypto_tls_creds_x509_ident_files_free(files->identities[i]);
> +    }
> +    g_free(files->identities);
> +    g_free(files);
> +}
> +
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsX509Files,
>                                qcrypto_tls_creds_x509_files_free);
>
> @@ -573,33 +593,32 @@ qcrypto_tls_creds_load_privkey(QCryptoTLSCredsX509
> *creds,
>
>
>  static int
> -qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
> -                                    QCryptoTLSCredsX509Files *files,
> -                                    bool isServer,
> -                                    Error **errp)
> +qcrypto_tls_creds_x509_sanity_check_identity(QCryptoTLSCredsX509 *creds,
> +                                             QCryptoTLSCredsX509Files
> *files,
> +
>  QCryptoTLSCredsX509IdentFiles *ifiles,
> +                                             bool isServer,
> +                                             Error **errp)
>  {
>      size_t i;
>
> -    for (i =3D 0; i < files->ncerts; i++) {
> +    for (i =3D 0; i < ifiles->ncerts; i++) {
>          if (qcrypto_tls_creds_check_cert(creds,
> -                                         files->certs[i], files->certpat=
h,
> +                                         ifiles->certs[i],
> ifiles->certpath,
>                                           isServer, i !=3D 0, errp) < 0) =
{
>              return -1;
>          }
>      }
>
> -    if (files->ncerts &&
> +    if (ifiles->ncerts &&
>          qcrypto_tls_creds_check_authority_chain(creds, files,
> -                                                files->certs,
> files->ncerts,
> +                                                ifiles->certs,
> ifiles->ncerts,
>                                                  isServer, errp) < 0) {
>          return -1;
>      }
>
> -    if (files->ncerts &&
> -        qcrypto_tls_creds_check_cert_pair(files,
> -                                          files->certs, files->ncerts,
> -                                          files->certpath, isServer,
> -                                          errp) < 0) {
> +    if (ifiles->ncerts &&
> +        qcrypto_tls_creds_check_cert_pair(files, ifiles->certs,
> ifiles->ncerts,
> +                                          ifiles->certpath, isServer,
> errp) < 0) {
>          return -1;
>      }
>
> @@ -607,6 +626,26 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>  }
>
>
> +static int
> +qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
> +                                    QCryptoTLSCredsX509Files *files,
> +                                    bool isServer,
> +                                    Error **errp)
> +{
> +    size_t i;
> +    for (i =3D 0; i < files->nidentities; i++) {
> +        if (qcrypto_tls_creds_x509_sanity_check_identity(creds,
> +                                                         files,
> +
>  files->identities[i],
> +                                                         isServer,
> +                                                         errp) < 0) {
> +            return -1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +
>  static int
>  qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509 *creds,
>                                 QCryptoTLSCredsBox *box,
> @@ -642,48 +681,38 @@ qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509
> *creds,
>  }
>
>
> -static int
> +static QCryptoTLSCredsX509IdentFiles *
>  qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
>                                       QCryptoTLSCredsBox *box,
> -                                     QCryptoTLSCredsX509Files *files,
> -                                     bool isServer,
> +                                     const char *certbase,
> +                                     const char *keybase,
> +                                     bool isOptional,
>                                       Error **errp)
>  {
> +    g_autoptr(QCryptoTLSCredsX509IdentFiles) files =3D
> +        g_new0(QCryptoTLSCredsX509IdentFiles, 1);
>      int ret;
>
> -    if (isServer) {
> -        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_SERVER_CER=
T,
> -                                       true, &files->certpath, errp) < 0
> ||
> -            qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_SERVER_KEY=
,
> -                                       true, &files->keypath, errp) < 0)=
 {
> -            return -1;
> -        }
> -    } else {
> -        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_CLIENT_CER=
T,
> -                                       false, &files->certpath, errp) < =
0
> ||
> -            qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_CLIENT_KEY=
,
> -                                       false, &files->keypath, errp) < 0=
)
> {
> -            return -1;
> -        }
> +    if (qcrypto_tls_creds_get_path(&creds->parent_obj, certbase,
> +                                   !isOptional, &files->certpath, errp) =
<
> 0 ||
> +        qcrypto_tls_creds_get_path(&creds->parent_obj, keybase,
> +                                   !isOptional, &files->keypath, errp) <
> 0) {
> +        return NULL;
>      }
>
>      if (!files->certpath &&
>          !files->keypath) {
> -        return 0;
> +        return NULL;
>      }
>      if (files->certpath && !files->keypath) {
>          error_setg(errp, "Cert '%s' without corresponding key",
>                     files->certpath);
> -        return -1;
> +        return NULL;
>      }
>      if (!files->certpath && files->keypath) {
>          error_setg(errp, "Key '%s' without corresponding cert",
>                     files->keypath);
> -        return -1;
> +        return NULL;
>      }
>
>      if (qcrypto_tls_creds_load_cert_list(creds,
> @@ -691,14 +720,14 @@
> qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
>                                           &files->certs,
>                                           &files->ncerts,
>                                           errp) < 0) {
> -        return -1;
> +        return NULL;
>      }
>
>      if (qcrypto_tls_creds_load_privkey(creds,
>                                         files->keypath,
>                                         &files->key,
>                                         errp) < 0) {
> -        return -1;
> +        return NULL;
>      }
>
>      ret =3D gnutls_certificate_set_x509_key(box->data.cert,
> @@ -708,8 +737,39 @@
> qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
>      if (ret < 0) {
>          error_setg(errp, "Cannot set certificate '%s' & key '%s': %s",
>                     files->certpath, files->keypath, gnutls_strerror(ret)=
);
> +        return NULL;
> +    }
> +    return g_steal_pointer(&files);
> +}
> +
> +
> +static int
> +qcrypto_tls_creds_x509_load_identities(QCryptoTLSCredsX509 *creds,
> +                                       QCryptoTLSCredsBox *box,
> +                                       QCryptoTLSCredsX509Files *files,
> +                                       bool isServer,
> +                                       Error **errp)
> +{
> +    QCryptoTLSCredsX509IdentFiles *ifiles;
> +
> +    ifiles =3D qcrypto_tls_creds_x509_load_identity(
> +        creds, box,
> +        isServer ?
> +        QCRYPTO_TLS_CREDS_X509_SERVER_CERT :
> +        QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
> +        isServer ?
> +        QCRYPTO_TLS_CREDS_X509_SERVER_KEY :
> +        QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
> +        !isServer, errp);
> +    if (!ifiles) {
>          return -1;
>      }
> +
> +    files->identities =3D g_renew(QCryptoTLSCredsX509IdentFiles *,
> +                                files->identities,
> +                                files->nidentities + 1);
> +    files->identities[files->nidentities++] =3D ifiles;
> +
>      return 0;
>  }
>
> @@ -752,8 +812,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>          return -1;
>      }
>
> -    if (qcrypto_tls_creds_x509_load_identity(creds, box, files,
> -                                             isServer, errp) < 0) {
> +    if (qcrypto_tls_creds_x509_load_identities(creds, box, files,
> +                                               isServer, errp) < 0) {
>          return -1;
>      }
>
> --
> 2.51.1
>
>

--000000000000e6305d0642982553
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaTwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBn
bWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5P
biBUaHUsIE9jdCAzMCwgMjAyNSBhdCA2OjUw4oCvUE0gRGFuaWVsIFAuIEJlcnJhbmfDqSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20iPmJlcnJhbmdlQHJlZGhhdC5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkN1cnJlbnRseSBvbmx5IGEgc2luZ2xlIHNl
dCBvZiBjZXJ0aWZpY2F0ZXMgY2FuIGJlIGxvYWRlZCBmb3IgYTxicj4NCnNlcnZlciAvIGNsaWVu
dC4gQ2VydGlmaWNhdGVzIGFyZSBjcmVhdGVkIHVzaW5nIGEgcGFydGljdWxhcjxicj4NCmtleSBh
bGdvcml0aG0gYW5kIGluIHNvbWUgc2NlbmFyaW9zIGl0IGNhbiBiZSB1c2VmdWwgdG8gc3VwcG9y
dDxicj4NCm11bHRpcGxlIGFsZ29yaXRobXMgaW4gcGFyYWxsZWwuIFRoaXMgcmVxdWlyZXMgdGhl
IGFiaWxpdHkgdG88YnI+DQpsb2FkIG11bHRpcGxlIHNldHMgb2YgY2VydGlmaWNhdGVzLjxicj4N
Cjxicj4NClNpZ25lZC1vZmYtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgJmx0OzxhIGhyZWY9Im1h
aWx0bzpiZXJyYW5nZUByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+YmVycmFuZ2VAcmVkaGF0
LmNvbTwvYT4mZ3Q7PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlJldmlld2Vk
LWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgJmx0OzxhIGhyZWY9Im1haWx0bzptYXJjYW5kcmUubHVy
ZWF1QHJlZGhhdC5jb20iPm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbTwvYT4mZ3Q7PC9kaXY+
PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCi0tLTxicj4NCsKgY3J5cHRvL3Rsc2NyZWRzeDUwOS5jIHwg
MTY0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLTxicj4NCsKgMSBm
aWxlIGNoYW5nZWQsIDExMiBpbnNlcnRpb25zKCspLCA1MiBkZWxldGlvbnMoLSk8YnI+DQo8YnI+
DQpkaWZmIC0tZ2l0IGEvY3J5cHRvL3Rsc2NyZWRzeDUwOS5jIGIvY3J5cHRvL3Rsc2NyZWRzeDUw
OS5jPGJyPg0KaW5kZXggM2NiMGE2YzMxZi4uZDdkMWY1OTRjMCAxMDA2NDQ8YnI+DQotLS0gYS9j
cnlwdG8vdGxzY3JlZHN4NTA5LmM8YnI+DQorKysgYi9jcnlwdG8vdGxzY3JlZHN4NTA5LmM8YnI+
DQpAQCAtMzksNiArMzksMTQgQEAgc3RydWN0IFFDcnlwdG9UTFNDcmVkc1g1MDkgezxicj4NCsKg
IMKgIMKgY2hhciAqcGFzc3dvcmRpZDs8YnI+DQrCoH07PGJyPg0KPGJyPg0KK3R5cGVkZWYgc3Ry
dWN0IFFDcnlwdG9UTFNDcmVkc1g1MDlJZGVudEZpbGVzIFFDcnlwdG9UTFNDcmVkc1g1MDlJZGVu
dEZpbGVzOzxicj4NCitzdHJ1Y3QgUUNyeXB0b1RMU0NyZWRzWDUwOUlkZW50RmlsZXMgezxicj4N
CivCoCDCoCBjaGFyICpjZXJ0cGF0aDs8YnI+DQorwqAgwqAgY2hhciAqa2V5cGF0aDs8YnI+DQor
wqAgwqAgZ251dGxzX3g1MDlfY3J0X3QgKmNlcnRzOzxicj4NCivCoCDCoCB1bnNpZ25lZCBpbnQg
bmNlcnRzOzxicj4NCivCoCDCoCBnbnV0bHNfeDUwOV9wcml2a2V5X3Qga2V5Ozxicj4NCit9Ozxi
cj4NCjxicj4NCsKgdHlwZWRlZiBzdHJ1Y3QgUUNyeXB0b1RMU0NyZWRzWDUwOUZpbGVzIFFDcnlw
dG9UTFNDcmVkc1g1MDlGaWxlczs8YnI+DQrCoHN0cnVjdCBRQ3J5cHRvVExTQ3JlZHNYNTA5Rmls
ZXMgezxicj4NCkBAIC00NiwxMSArNTQsOCBAQCBzdHJ1Y3QgUUNyeXB0b1RMU0NyZWRzWDUwOUZp
bGVzIHs8YnI+DQrCoCDCoCDCoGdudXRsc194NTA5X2NydF90ICpjYWNlcnRzOzxicj4NCsKgIMKg
IMKgdW5zaWduZWQgaW50IG5jYWNlcnRzOzxicj4NCjxicj4NCi3CoCDCoCBjaGFyICpjZXJ0cGF0
aDs8YnI+DQotwqAgwqAgY2hhciAqa2V5cGF0aDs8YnI+DQotwqAgwqAgZ251dGxzX3g1MDlfY3J0
X3QgKmNlcnRzOzxicj4NCi3CoCDCoCB1bnNpZ25lZCBpbnQgbmNlcnRzOzxicj4NCi3CoCDCoCBn
bnV0bHNfeDUwOV9wcml2a2V5X3Qga2V5Ozxicj4NCivCoCDCoCBRQ3J5cHRvVExTQ3JlZHNYNTA5
SWRlbnRGaWxlcyAqKmlkZW50aXRpZXM7PGJyPg0KK8KgIMKgIHNpemVfdCBuaWRlbnRpdGllczs8
YnI+DQrCoH07PGJyPg0KPGJyPg0KwqBzdGF0aWMgUUNyeXB0b1RMU0NyZWRzWDUwOUZpbGVzICo8
YnI+DQpAQCAtNjEsMTQgKzY2LDkgQEAgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9maWxlc19uZXco
dm9pZCk8YnI+DQo8YnI+DQo8YnI+DQrCoHN0YXRpYyB2b2lkPGJyPg0KLXFjcnlwdG9fdGxzX2Ny
ZWRzX3g1MDlfZmlsZXNfZnJlZShRQ3J5cHRvVExTQ3JlZHNYNTA5RmlsZXMgKmZpbGVzKTxicj4N
CitxY3J5cHRvX3Rsc19jcmVkc194NTA5X2lkZW50X2ZpbGVzX2ZyZWUoUUNyeXB0b1RMU0NyZWRz
WDUwOUlkZW50RmlsZXMgKmZpbGVzKTxicj4NCsKgezxicj4NCsKgIMKgIMKgc2l6ZV90IGk7PGJy
Pg0KLcKgIMKgIGZvciAoaSA9IDA7IGkgJmx0OyBmaWxlcy0mZ3Q7bmNhY2VydHM7IGkrKykgezxi
cj4NCi3CoCDCoCDCoCDCoCBnbnV0bHNfeDUwOV9jcnRfZGVpbml0KGZpbGVzLSZndDtjYWNlcnRz
W2ldKTs8YnI+DQotwqAgwqAgfTxicj4NCi3CoCDCoCBnX2ZyZWUoZmlsZXMtJmd0O2NhY2VydHMp
Ozxicj4NCi3CoCDCoCBnX2ZyZWUoZmlsZXMtJmd0O2NhY2VydHBhdGgpOzxicj4NCsKgIMKgIMKg
Zm9yIChpID0gMDsgaSAmbHQ7IGZpbGVzLSZndDtuY2VydHM7IGkrKykgezxicj4NCsKgIMKgIMKg
IMKgIMKgZ251dGxzX3g1MDlfY3J0X2RlaW5pdChmaWxlcy0mZ3Q7Y2VydHNbaV0pOzxicj4NCsKg
IMKgIMKgfTxicj4NCkBAIC03OSw2ICs3OSwyNiBAQCBxY3J5cHRvX3Rsc19jcmVkc194NTA5X2Zp
bGVzX2ZyZWUoUUNyeXB0b1RMU0NyZWRzWDUwOUZpbGVzICpmaWxlcyk8YnI+DQrCoCDCoCDCoGdf
ZnJlZShmaWxlcyk7PGJyPg0KwqB9PGJyPg0KPGJyPg0KK0dfREVGSU5FX0FVVE9QVFJfQ0xFQU5V
UF9GVU5DKFFDcnlwdG9UTFNDcmVkc1g1MDlJZGVudEZpbGVzLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBxY3J5cHRvX3Rsc19jcmVkc194NTA5X2lk
ZW50X2ZpbGVzX2ZyZWUpOzxicj4NCis8YnI+DQorPGJyPg0KK3N0YXRpYyB2b2lkPGJyPg0KK3Fj
cnlwdG9fdGxzX2NyZWRzX3g1MDlfZmlsZXNfZnJlZShRQ3J5cHRvVExTQ3JlZHNYNTA5RmlsZXMg
KmZpbGVzKTxicj4NCit7PGJyPg0KK8KgIMKgIHNpemVfdCBpOzxicj4NCivCoCDCoCBmb3IgKGkg
PSAwOyBpICZsdDsgZmlsZXMtJmd0O25jYWNlcnRzOyBpKyspIHs8YnI+DQorwqAgwqAgwqAgwqAg
Z251dGxzX3g1MDlfY3J0X2RlaW5pdChmaWxlcy0mZ3Q7Y2FjZXJ0c1tpXSk7PGJyPg0KK8KgIMKg
IH08YnI+DQorwqAgwqAgZ19mcmVlKGZpbGVzLSZndDtjYWNlcnRzKTs8YnI+DQorwqAgwqAgZ19m
cmVlKGZpbGVzLSZndDtjYWNlcnRwYXRoKTs8YnI+DQorwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7
IGZpbGVzLSZndDtuaWRlbnRpdGllczsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIHFjcnlwdG9f
dGxzX2NyZWRzX3g1MDlfaWRlbnRfZmlsZXNfZnJlZShmaWxlcy0mZ3Q7aWRlbnRpdGllc1tpXSk7
PGJyPg0KK8KgIMKgIH08YnI+DQorwqAgwqAgZ19mcmVlKGZpbGVzLSZndDtpZGVudGl0aWVzKTs8
YnI+DQorwqAgwqAgZ19mcmVlKGZpbGVzKTs8YnI+DQorfTxicj4NCis8YnI+DQrCoEdfREVGSU5F
X0FVVE9QVFJfQ0xFQU5VUF9GVU5DKFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyw8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHFjcnlwdG9fdGxzX2Ny
ZWRzX3g1MDlfZmlsZXNfZnJlZSk7PGJyPg0KPGJyPg0KQEAgLTU3MywzMyArNTkzLDMyIEBAIHFj
cnlwdG9fdGxzX2NyZWRzX2xvYWRfcHJpdmtleShRQ3J5cHRvVExTQ3JlZHNYNTA5ICpjcmVkcyw8
YnI+DQo8YnI+DQo8YnI+DQrCoHN0YXRpYyBpbnQ8YnI+DQotcWNyeXB0b190bHNfY3JlZHNfeDUw
OV9zYW5pdHlfY2hlY2soUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFFDcnlwdG9UTFND
cmVkc1g1MDlGaWxlcyAqZmlsZXMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJvb2wgaXNTZXJ2ZXIsPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEVycm9yICoqZXJycCk8
YnI+DQorcWNyeXB0b190bHNfY3JlZHNfeDUwOV9zYW5pdHlfY2hlY2tfaWRlbnRpdHkoUUNyeXB0
b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUUNyeXB0b1RMU0NyZWRzWDUw
OUZpbGVzICpmaWxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ3J5cHRvVExTQ3JlZHNYNTA5SWRlbnRG
aWxlcyAqaWZpbGVzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJvb2wgaXNTZXJ2ZXIsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgRXJyb3IgKiplcnJwKTxicj4NCsKgezxicj4NCsKgIMKgIMKgc2l6ZV90IGk7PGJyPg0K
PGJyPg0KLcKgIMKgIGZvciAoaSA9IDA7IGkgJmx0OyBmaWxlcy0mZ3Q7bmNlcnRzOyBpKyspIHs8
YnI+DQorwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IGlmaWxlcy0mZ3Q7bmNlcnRzOyBpKyspIHs8
YnI+DQrCoCDCoCDCoCDCoCDCoGlmIChxY3J5cHRvX3Rsc19jcmVkc19jaGVja19jZXJ0KGNyZWRz
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZpbGVzLSZndDtjZXJ0c1tpXSwgZmlsZXMtJmd0O2NlcnRwYXRoLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlmaWxlcy0mZ3Q7Y2VydHNbaV0sIGlmaWxlcy0mZ3Q7Y2VydHBhdGgsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgaXNTZXJ2ZXIsIGkgIT0gMCwgZXJycCkgJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqB9PGJyPg0K
PGJyPg0KLcKgIMKgIGlmIChmaWxlcy0mZ3Q7bmNlcnRzICZhbXA7JmFtcDs8YnI+DQorwqAgwqAg
aWYgKGlmaWxlcy0mZ3Q7bmNlcnRzICZhbXA7JmFtcDs8YnI+DQrCoCDCoCDCoCDCoCDCoHFjcnlw
dG9fdGxzX2NyZWRzX2NoZWNrX2F1dGhvcml0eV9jaGFpbihjcmVkcywgZmlsZXMsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGZpbGVzLSZndDtjZXJ0cywgZmlsZXMtJmd0O25jZXJ0cyw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaWZpbGVzLSZndDtjZXJ0cywgaWZpbGVzLSZndDtuY2VydHMsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpc1NlcnZlciwgZXJycCkgJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAg
wqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqB9PGJyPg0KPGJyPg0KLcKgIMKgIGlmIChmaWxlcy0m
Z3Q7bmNlcnRzICZhbXA7JmFtcDs8YnI+DQotwqAgwqAgwqAgwqAgcWNyeXB0b190bHNfY3JlZHNf
Y2hlY2tfY2VydF9wYWlyKGZpbGVzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaWxlcy0mZ3Q7Y2VydHMsIGZpbGVz
LSZndDtuY2VydHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZpbGVzLSZndDtjZXJ0cGF0aCwgaXNTZXJ2ZXIsPGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGVycnApICZsdDsgMCkgezxicj4NCivCoCDCoCBpZiAoaWZpbGVzLSZndDtuY2Vy
dHMgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCBxY3J5cHRvX3Rsc19jcmVkc19jaGVja19j
ZXJ0X3BhaXIoZmlsZXMsIGlmaWxlcy0mZ3Q7Y2VydHMsIGlmaWxlcy0mZ3Q7bmNlcnRzLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpZmlsZXMtJmd0O2NlcnRwYXRoLCBpc1NlcnZlciwgZXJycCkgJmx0OyAwKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqB9PGJyPg0KPGJyPg0KQEAg
LTYwNyw2ICs2MjYsMjYgQEAgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9zYW5pdHlfY2hlY2soUUNy
eXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KwqB9PGJyPg0KPGJyPg0KPGJyPg0KK3N0YXRp
YyBpbnQ8YnI+DQorcWNyeXB0b190bHNfY3JlZHNfeDUwOV9zYW5pdHlfY2hlY2soUUNyeXB0b1RM
U0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyAqZmlsZXMsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGJvb2wgaXNTZXJ2ZXIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIEVycm9yICoqZXJycCk8YnI+DQorezxicj4NCivCoCDCoCBzaXpl
X3QgaTs8YnI+DQorwqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IGZpbGVzLSZndDtuaWRlbnRpdGll
czsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIGlmIChxY3J5cHRvX3Rsc19jcmVkc194NTA5X3Nh
bml0eV9jaGVja19pZGVudGl0eShjcmVkcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBmaWxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaWxlcy0mZ3Q7
aWRlbnRpdGllc1tpXSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZl
ciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcnJwKSAmbHQ7IDApIHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCivCoCDCoCDCoCDCoCB9PGJyPg0K
K8KgIMKgIH08YnI+DQorwqAgwqAgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0KKzxicj4N
CsKgc3RhdGljIGludDxicj4NCsKgcWNyeXB0b190bHNfY3JlZHNfeDUwOV9sb2FkX2NhKFFDcnlw
dG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFFDcnlwdG9UTFNDcmVkc0JveCAqYm94LDxicj4NCkBAIC02NDIs
NDggKzY4MSwzOCBAQCBxY3J5cHRvX3Rsc19jcmVkc194NTA5X2xvYWRfY2EoUUNyeXB0b1RMU0Ny
ZWRzWDUwOSAqY3JlZHMsPGJyPg0KwqB9PGJyPg0KPGJyPg0KPGJyPg0KLXN0YXRpYyBpbnQ8YnI+
DQorc3RhdGljIFFDcnlwdG9UTFNDcmVkc1g1MDlJZGVudEZpbGVzICo8YnI+DQrCoHFjcnlwdG9f
dGxzX2NyZWRzX3g1MDlfbG9hZF9pZGVudGl0eShRQ3J5cHRvVExTQ3JlZHNYNTA5ICpjcmVkcyw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBRQ3J5cHRvVExTQ3JlZHNCb3ggKmJveCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ3J5cHRvVExTQ3JlZHNYNTA5Rmls
ZXMgKmZpbGVzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGJvb2wgaXNTZXJ2ZXIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqY2VydGJhc2Us
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY29uc3QgY2hhciAqa2V5YmFzZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sIGlzT3B0aW9uYWwsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRXJy
b3IgKiplcnJwKTxicj4NCsKgezxicj4NCivCoCDCoCBnX2F1dG9wdHIoUUNyeXB0b1RMU0NyZWRz
WDUwOUlkZW50RmlsZXMpIGZpbGVzID08YnI+DQorwqAgwqAgwqAgwqAgZ19uZXcwKFFDcnlwdG9U
TFNDcmVkc1g1MDlJZGVudEZpbGVzLCAxKTs8YnI+DQrCoCDCoCDCoGludCByZXQ7PGJyPg0KPGJy
Pg0KLcKgIMKgIGlmIChpc1NlcnZlcikgezxicj4NCi3CoCDCoCDCoCDCoCBpZiAocWNyeXB0b190
bHNfY3JlZHNfZ2V0X3BhdGgoJmFtcDtjcmVkcy0mZ3Q7cGFyZW50X29iaiw8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ1JZ
UFRPX1RMU19DUkVEU19YNTA5X1NFUlZFUl9DRVJULDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRydWUsICZhbXA7ZmlsZXMt
Jmd0O2NlcnRwYXRoLCBlcnJwKSAmbHQ7IDAgfHw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgcWNy
eXB0b190bHNfY3JlZHNfZ2V0X3BhdGgoJmFtcDtjcmVkcy0mZ3Q7cGFyZW50X29iaiw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBRQ1JZUFRPX1RMU19DUkVEU19YNTA5X1NFUlZFUl9LRVksPGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHJ1ZSwgJmFtcDtm
aWxlcy0mZ3Q7a2V5cGF0aCwgZXJycCkgJmx0OyAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IHJldHVybiAtMTs8YnI+DQotwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCB9IGVsc2Ugezxicj4N
Ci3CoCDCoCDCoCDCoCBpZiAocWNyeXB0b190bHNfY3JlZHNfZ2V0X3BhdGgoJmFtcDtjcmVkcy0m
Z3Q7cGFyZW50X29iaiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBRQ1JZUFRPX1RMU19DUkVEU19YNTA5X0NMSUVOVF9DRVJU
LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGZhbHNlLCAmYW1wO2ZpbGVzLSZndDtjZXJ0cGF0aCwgZXJycCkgJmx0OyAwIHx8
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHFjcnlwdG9fdGxzX2NyZWRzX2dldF9wYXRoKCZhbXA7
Y3JlZHMtJmd0O3BhcmVudF9vYmosPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUUNSWVBUT19UTFNfQ1JFRFNfWDUwOV9DTElF
TlRfS0VZLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZhbHNlLCAmYW1wO2ZpbGVzLSZndDtrZXlwYXRoLCBlcnJwKSAmbHQ7
IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC0xOzxicj4NCi3CoCDCoCDCoCDC
oCB9PGJyPg0KK8KgIMKgIGlmIChxY3J5cHRvX3Rsc19jcmVkc19nZXRfcGF0aCgmYW1wO2NyZWRz
LSZndDtwYXJlbnRfb2JqLCBjZXJ0YmFzZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAhaXNPcHRpb25hbCwgJmFtcDtmaWxlcy0mZ3Q7
Y2VydHBhdGgsIGVycnApICZsdDsgMCB8fDxicj4NCivCoCDCoCDCoCDCoCBxY3J5cHRvX3Rsc19j
cmVkc19nZXRfcGF0aCgmYW1wO2NyZWRzLSZndDtwYXJlbnRfb2JqLCBrZXliYXNlLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCFpc09w
dGlvbmFsLCAmYW1wO2ZpbGVzLSZndDtrZXlwYXRoLCBlcnJwKSAmbHQ7IDApIHs8YnI+DQorwqAg
wqAgwqAgwqAgcmV0dXJuIE5VTEw7PGJyPg0KwqAgwqAgwqB9PGJyPg0KPGJyPg0KwqAgwqAgwqBp
ZiAoIWZpbGVzLSZndDtjZXJ0cGF0aCAmYW1wOyZhbXA7PGJyPg0KwqAgwqAgwqAgwqAgwqAhZmls
ZXMtJmd0O2tleXBhdGgpIHs8YnI+DQotwqAgwqAgwqAgwqAgcmV0dXJuIDA7PGJyPg0KK8KgIMKg
IMKgIMKgIHJldHVybiBOVUxMOzxicj4NCsKgIMKgIMKgfTxicj4NCsKgIMKgIMKgaWYgKGZpbGVz
LSZndDtjZXJ0cGF0aCAmYW1wOyZhbXA7ICFmaWxlcy0mZ3Q7a2V5cGF0aCkgezxicj4NCsKgIMKg
IMKgIMKgIMKgZXJyb3Jfc2V0ZyhlcnJwLCAmcXVvdDtDZXJ0ICYjMzk7JXMmIzM5OyB3aXRob3V0
IGNvcnJlc3BvbmRpbmcga2V5JnF1b3Q7LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGZpbGVzLSZndDtjZXJ0cGF0aCk7PGJyPg0KLcKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+
DQorwqAgwqAgwqAgwqAgcmV0dXJuIE5VTEw7PGJyPg0KwqAgwqAgwqB9PGJyPg0KwqAgwqAgwqBp
ZiAoIWZpbGVzLSZndDtjZXJ0cGF0aCAmYW1wOyZhbXA7IGZpbGVzLSZndDtrZXlwYXRoKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqBlcnJvcl9zZXRnKGVycnAsICZxdW90O0tleSAmIzM5OyVzJiMzOTsg
d2l0aG91dCBjb3JyZXNwb25kaW5nIGNlcnQmcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZmlsZXMtJmd0O2tleXBhdGgpOzxicj4NCi3CoCDCoCDCoCDCoCByZXR1cm4g
LTE7PGJyPg0KK8KgIMKgIMKgIMKgIHJldHVybiBOVUxMOzxicj4NCsKgIMKgIMKgfTxicj4NCjxi
cj4NCsKgIMKgIMKgaWYgKHFjcnlwdG9fdGxzX2NyZWRzX2xvYWRfY2VydF9saXN0KGNyZWRzLDxi
cj4NCkBAIC02OTEsMTQgKzcyMCwxNCBAQCBxY3J5cHRvX3Rsc19jcmVkc194NTA5X2xvYWRfaWRl
bnRpdHkoUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtmaWxlcy0m
Z3Q7Y2VydHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtmaWxlcy0mZ3Q7bmNlcnRzLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVy
cnApICZsdDsgMCkgezxicj4NCi3CoCDCoCDCoCDCoCByZXR1cm4gLTE7PGJyPg0KK8KgIMKgIMKg
IMKgIHJldHVybiBOVUxMOzxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4NCsKgIMKgIMKgaWYgKHFj
cnlwdG9fdGxzX2NyZWRzX2xvYWRfcHJpdmtleShjcmVkcyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaWxlcy0mZ3Q7a2V5
cGF0aCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAmYW1wO2ZpbGVzLSZndDtrZXksPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJycCkgJmx0OyAwKSB7
PGJyPg0KLcKgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQorwqAgwqAgwqAgwqAgcmV0dXJuIE5V
TEw7PGJyPg0KwqAgwqAgwqB9PGJyPg0KPGJyPg0KwqAgwqAgwqByZXQgPSBnbnV0bHNfY2VydGlm
aWNhdGVfc2V0X3g1MDlfa2V5KGJveC0mZ3Q7ZGF0YS5jZXJ0LDxicj4NCkBAIC03MDgsOCArNzM3
LDM5IEBAIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfbG9hZF9pZGVudGl0eShRQ3J5cHRvVExTQ3Jl
ZHNYNTA5ICpjcmVkcyw8YnI+DQrCoCDCoCDCoGlmIChyZXQgJmx0OyAwKSB7PGJyPg0KwqAgwqAg
wqAgwqAgwqBlcnJvcl9zZXRnKGVycnAsICZxdW90O0Nhbm5vdCBzZXQgY2VydGlmaWNhdGUgJiMz
OTslcyYjMzk7ICZhbXA7IGtleSAmIzM5OyVzJiMzOTs6ICVzJnF1b3Q7LDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZpbGVzLSZndDtjZXJ0cGF0aCwgZmlsZXMtJmd0O2tleXBh
dGgsIGdudXRsc19zdHJlcnJvcihyZXQpKTs8YnI+DQorwqAgwqAgwqAgwqAgcmV0dXJuIE5VTEw7
PGJyPg0KK8KgIMKgIH08YnI+DQorwqAgwqAgcmV0dXJuIGdfc3RlYWxfcG9pbnRlcigmYW1wO2Zp
bGVzKTs8YnI+DQorfTxicj4NCis8YnI+DQorPGJyPg0KK3N0YXRpYyBpbnQ8YnI+DQorcWNyeXB0
b190bHNfY3JlZHNfeDUwOV9sb2FkX2lkZW50aXRpZXMoUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3Jl
ZHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgUUNyeXB0b1RMU0NyZWRzQm94ICpib3gsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUUNyeXB0b1RMU0Ny
ZWRzWDUwOUZpbGVzICpmaWxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sIGlzU2VydmVyLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVycm9y
ICoqZXJycCk8YnI+DQorezxicj4NCivCoCDCoCBRQ3J5cHRvVExTQ3JlZHNYNTA5SWRlbnRGaWxl
cyAqaWZpbGVzOzxicj4NCis8YnI+DQorwqAgwqAgaWZpbGVzID0gcWNyeXB0b190bHNfY3JlZHNf
eDUwOV9sb2FkX2lkZW50aXR5KDxicj4NCivCoCDCoCDCoCDCoCBjcmVkcywgYm94LDxicj4NCivC
oCDCoCDCoCDCoCBpc1NlcnZlciA/PGJyPg0KK8KgIMKgIMKgIMKgIFFDUllQVE9fVExTX0NSRURT
X1g1MDlfU0VSVkVSX0NFUlQgOjxicj4NCivCoCDCoCDCoCDCoCBRQ1JZUFRPX1RMU19DUkVEU19Y
NTA5X0NMSUVOVF9DRVJULDxicj4NCivCoCDCoCDCoCDCoCBpc1NlcnZlciA/PGJyPg0KK8KgIMKg
IMKgIMKgIFFDUllQVE9fVExTX0NSRURTX1g1MDlfU0VSVkVSX0tFWSA6PGJyPg0KK8KgIMKgIMKg
IMKgIFFDUllQVE9fVExTX0NSRURTX1g1MDlfQ0xJRU5UX0tFWSw8YnI+DQorwqAgwqAgwqAgwqAg
IWlzU2VydmVyLCBlcnJwKTs8YnI+DQorwqAgwqAgaWYgKCFpZmlsZXMpIHs8YnI+DQrCoCDCoCDC
oCDCoCDCoHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIGZpbGVz
LSZndDtpZGVudGl0aWVzID0gZ19yZW5ldyhRQ3J5cHRvVExTQ3JlZHNYNTA5SWRlbnRGaWxlcyAq
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBm
aWxlcy0mZ3Q7aWRlbnRpdGllcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZmlsZXMtJmd0O25pZGVudGl0aWVzICsgMSk7PGJyPg0KK8KgIMKg
IGZpbGVzLSZndDtpZGVudGl0aWVzW2ZpbGVzLSZndDtuaWRlbnRpdGllcysrXSA9IGlmaWxlczs8
YnI+DQorPGJyPg0KwqAgwqAgwqByZXR1cm4gMDs8YnI+DQrCoH08YnI+DQo8YnI+DQpAQCAtNzUy
LDggKzgxMiw4IEBAIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfbG9hZChRQ3J5cHRvVExTQ3JlZHNY
NTA5ICpjcmVkcyw8YnI+DQrCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoH08
YnI+DQo8YnI+DQotwqAgwqAgaWYgKHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfbG9hZF9pZGVudGl0
eShjcmVkcywgYm94LCBmaWxlcyw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciwgZXJycCkgJmx0
OyAwKSB7PGJyPg0KK8KgIMKgIGlmIChxY3J5cHRvX3Rsc19jcmVkc194NTA5X2xvYWRfaWRlbnRp
dGllcyhjcmVkcywgYm94LCBmaWxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciwgZXJy
cCkgJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqB9
PGJyPg0KPGJyPg0KLS0gPGJyPg0KMi41MS4xPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2
PjwvZGl2Pg0K
--000000000000e6305d0642982553--


