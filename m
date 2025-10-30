Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F1FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYGB-0007He-6w; Thu, 30 Oct 2025 15:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYG6-0007H5-76
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYFt-0003p3-43
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s3ayChoVc9rO15LIDaK/U1yeFIKkQXsbCAoLofUqNRo=;
 b=K5irFkscMhka19kQnVpbC48ec1vDXDWq+L8GXYOclrHYBohyHe1bcY8lk9VnoDX/3hrme9
 OLHs86oU0EeSszDPAYWnqo3g3SkZNEx1CQ6B1V+bfBp0AHr0/C33DSrTaghpbsfJEhSNVu
 relbJ9x18fC6sNQ9yqTUCcb9qGuMK7s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-FRmdWrAzPo2kN4VaTvoFsA-1; Thu, 30 Oct 2025 15:23:58 -0400
X-MC-Unique: FRmdWrAzPo2kN4VaTvoFsA-1
X-Mimecast-MFC-AGG-ID: FRmdWrAzPo2kN4VaTvoFsA_1761852237
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-33da1f30fdfso3211902a91.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852237; x=1762457037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3ayChoVc9rO15LIDaK/U1yeFIKkQXsbCAoLofUqNRo=;
 b=EwImvbuIE02OI4Wmm0Ye4TA40fVWl7p6TtbNtjuf2Ubng4xLhS0EzaHcUZJjofhoqF
 kOQaO+CutzwhHYCJJwnf6TLjsI/G/XEjeclMcaM4unQi48YTKoEXZGP8kOlSNgx7v4po
 j0+hwOBA6/BtJEus9G1Ssp2DC2TOaS+yxwpTa4HEhutt9o0FlTPskhfIi/HE77/1iSPG
 p0wLa5OVBoz1m45CRR13IhfDZJCpbJ1cRb4kFcqI8PigrhqX0jdUXaeOOI+xr/IiPn8O
 6D0TeDpuoafWK4XrzBgw3DWylQAgHVbXkjFiX0gR9yQA4dZmvOQ9et5YWE+AlqlSJyMJ
 cROg==
X-Gm-Message-State: AOJu0YyK8HDBtnEszE8Bcl5ozAHygMopyiRpX/k43wD3IoatlD1L5qn9
 HJ8DVEe4jyNNEnrbrpsu62iS/E7n/z0tSR3mKEbUnTCXYjBwVt/uwC3bTqA8gOpstow4ZEvRgv6
 zWHp0h6QUNk86Iez+uIIo2K6Z/smkKbPGFYFXlyAw7Hb+uUkejZNOIfJ0d0s/tYTJlAHgJeJiex
 SljagkF8/X3VKzxn2St9UGXnD23MEa4no=
X-Gm-Gg: ASbGncs2euMbs5cO7ocTr0MpvKO+XZf/GtsXvZtrZve2KghJX79OjAAqM6bNuoT1Jf0
 BqjtD9+oKTAwZC8FpcCuf3oSX29DgrPNynYc1HkZs+ne26Obmb6KgFImaI6x0b/6My8YXmusyjW
 N3TKDEqhKQNvz4ry94FcqQO/ANvj4XRx7OBLhPVE9rz76SmdtX8w7UZKuljvabbZGxuw0p6SGNQ
 sXQe9RwV9F9HBg=
X-Received: by 2002:a17:90b:3f44:b0:32e:3837:284f with SMTP id
 98e67ed59e1d1-3408306ba19mr1099322a91.21.1761852236886; 
 Thu, 30 Oct 2025 12:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLx7BygOBUIDv/+5Ip/Tje2lIPuaF0Sa2CudLQ0Lx6jAQW4bUVENqs+sqdtUyfPUChw1ilkXjwsPNiu3+vQQY=
X-Received: by 2002:a17:90b:3f44:b0:32e:3837:284f with SMTP id
 98e67ed59e1d1-3408306ba19mr1099284a91.21.1761852236330; Thu, 30 Oct 2025
 12:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144805.2239954-1-berrange@redhat.com>
 <20251030144805.2239954-7-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-7-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:23:44 +0400
X-Gm-Features: AWmQ_bkj2YeVgJpssdMz0V0XxtXNpBrBMlY_ooTcqY6sRb6ZjufMnGDzaPk4NAs
Message-ID: <CAMxuvayKRO76yKcaajfbZWtN67zminu5BPhfyBAC22grPKrKkA@mail.gmail.com>
Subject: Re: [PATCH 06/21] crypto: use g_autofree when loading x509 credentials
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000b18bf6064265308d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000b18bf6064265308d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> This allows removal of goto jumps during loading of the credentials
> and will simplify the diff in following commits.
>
>
If you want, you could also g_autofree password.


> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 8fe6cc8e93..e5b869a35f 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -562,10 +562,12 @@ static int
>  qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
>                              Error **errp)
>  {
> -    char *cacert =3D NULL, *cacrl =3D NULL, *cert =3D NULL,
> -        *key =3D NULL, *dhparams =3D NULL;
> +    g_autofree char *cacert =3D NULL;
> +    g_autofree char *cacrl =3D NULL;
> +    g_autofree char *cert =3D NULL;
> +    g_autofree char *key =3D NULL;
> +    g_autofree char *dhparams =3D NULL;
>      int ret;
> -    int rv =3D -1;
>
>      if (!creds->parent_obj.dir) {
>          error_setg(errp, "Missing 'dir' property value");
> @@ -590,7 +592,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>              qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_DH_PARAMS,
>                                         false, &dhparams, errp) < 0) {
> -            goto cleanup;
> +            return -1;
>          }
>      } else {
>          if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> @@ -602,7 +604,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>              qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_X509_CLIENT_KEY=
,
>                                         false, &key, errp) < 0) {
> -            goto cleanup;
> +            return -1;
>          }
>      }
>
> @@ -610,14 +612,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>          qcrypto_tls_creds_x509_sanity_check(creds,
>              creds->parent_obj.endpoint =3D=3D
> QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
>              cacert, cert, errp) < 0) {
> -        goto cleanup;
> +        return -1;
>      }
>
>      ret =3D gnutls_certificate_allocate_credentials(&creds->data);
>      if (ret < 0) {
>          error_setg(errp, "Cannot allocate credentials: '%s'",
>                     gnutls_strerror(ret));
> -        goto cleanup;
> +        return -1;
>      }
>
>      ret =3D gnutls_certificate_set_x509_trust_file(creds->data,
> @@ -626,7 +628,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>      if (ret < 0) {
>          error_setg(errp, "Cannot load CA certificate '%s': %s",
>                     cacert, gnutls_strerror(ret));
> -        goto cleanup;
> +        return -1;
>      }
>
>      if (cert !=3D NULL && key !=3D NULL) {
> @@ -635,7 +637,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>              password =3D qcrypto_secret_lookup_as_utf8(creds->passwordid=
,
>                                                       errp);
>              if (!password) {
> -                goto cleanup;
> +                return -1;
>              }
>          }
>          ret =3D gnutls_certificate_set_x509_key_file2(creds->data,
> @@ -647,7 +649,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>          if (ret < 0) {
>              error_setg(errp, "Cannot load certificate '%s' & key '%s':
> %s",
>                         cert, key, gnutls_strerror(ret));
> -            goto cleanup;
> +            return -1;
>          }
>      }
>
> @@ -658,7 +660,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>          if (ret < 0) {
>              error_setg(errp, "Cannot load CRL '%s': %s",
>                         cacrl, gnutls_strerror(ret));
> -            goto cleanup;
> +            return -1;
>          }
>      }
>
> @@ -666,20 +668,13 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>          if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj,
> dhparams,
>
> &creds->parent_obj.dh_params,
>                                                   errp) < 0) {
> -            goto cleanup;
> +            return -1;
>          }
>          gnutls_certificate_set_dh_params(creds->data,
>                                           creds->parent_obj.dh_params);
>      }
>
> -    rv =3D 0;
> - cleanup:
> -    g_free(cacert);
> -    g_free(cacrl);
> -    g_free(cert);
> -    g_free(key);
> -    g_free(dhparams);
> -    return rv;
> +    return 0;
>  }
>
>
> --
> 2.51.1
>
>

--000000000000b18bf6064265308d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2=
025 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">This allows removal of goto jumps during =
loading of the credentials<br>
and will simplify the diff in following commits.<br>
<br></blockquote><div><br></div><div>If you want, you could also g_autofree=
 password.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/tlscredsx509.c | 35 +++++++++++++++--------------------<br>
=C2=A01 file changed, 15 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index 8fe6cc8e93..e5b869a35f 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -562,10 +562,12 @@ static int<br>
=C2=A0qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 char *cacert =3D NULL, *cacrl =3D NULL, *cert =3D NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *key =3D NULL, *dhparams =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *cacert =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *cacrl =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *cert =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *key =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *dhparams =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
-=C2=A0 =C2=A0 int rv =3D -1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!creds-&gt;parent_obj.dir) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Missing &#39;dir&#=
39; property value&quot;);<br>
@@ -590,7 +592,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_get_path(=
&amp;creds-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_DH_PARAMS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false, &=
amp;dhparams, errp) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds=
-&gt;parent_obj,<br>
@@ -602,7 +604,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_get_path(=
&amp;creds-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_X509_CLIENT_KEY,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false, &=
amp;key, errp) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -610,14 +612,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_x509_sanity_check(creds=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;parent_obj.endpoi=
nt =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cacert, cert, errp) &lt; 0)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D gnutls_certificate_allocate_credentials(&amp;cr=
eds-&gt;data);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cannot allocate cr=
edentials: &#39;%s&#39;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutl=
s_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D gnutls_certificate_set_x509_trust_file(creds-&g=
t;data,<br>
@@ -626,7 +628,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cannot load CA cer=
tificate &#39;%s&#39;: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cacer=
t, gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (cert !=3D NULL &amp;&amp; key !=3D NULL) {<br>
@@ -635,7 +637,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0password =3D qcrypto_secret=
_lookup_as_utf8(creds-&gt;passwordid,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!password) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gnutls_certificate_set_x509_key_f=
ile2(creds-&gt;data,<br>
@@ -647,7 +649,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot load certificate &#39;%s&#39; &amp; key &#39;%s&#39;: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cert, key, gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -658,7 +660,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Cann=
ot load CRL &#39;%s&#39;: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cacrl, gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -666,20 +668,13 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_dh_params_file(=
&amp;creds-&gt;parent_obj, dhparams,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;creds-&gt;parent_obj.dh_params,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 errp) &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gnutls_certificate_set_dh_params(creds-&g=
t;data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
reds-&gt;parent_obj.dh_params);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 rv =3D 0;<br>
- cleanup:<br>
-=C2=A0 =C2=A0 g_free(cacert);<br>
-=C2=A0 =C2=A0 g_free(cacrl);<br>
-=C2=A0 =C2=A0 g_free(cert);<br>
-=C2=A0 =C2=A0 g_free(key);<br>
-=C2=A0 =C2=A0 g_free(dhparams);<br>
-=C2=A0 =C2=A0 return rv;<br>
+=C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--000000000000b18bf6064265308d--


