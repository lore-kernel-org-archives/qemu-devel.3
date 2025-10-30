Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B681BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYO0-0002hi-Io; Thu, 30 Oct 2025 15:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNx-0002gv-73
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNo-0005lR-0Q
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPpexqfre3TQlxzT3eaZX3r1F3h5MuDOnhgcH6ycLCQ=;
 b=JgBRdgOn0mVDAO88ok02asjhgPsZdJa25QW0/aqseIhlXdqCooGu6N+EMVmX2JplmUP8Ib
 cnrf9taSKQH4E2rudIAsabv5T/WUnVmFqozhtlB8b1YXRa53xAWqZqQMVj4J3GUSr+GZhQ
 hMwWf12lwfdwQY8d23jXe+hvkNT/mHg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-ePIsxPgdMN20JPP-YcW0JQ-1; Thu, 30 Oct 2025 15:32:19 -0400
X-MC-Unique: ePIsxPgdMN20JPP-YcW0JQ-1
X-Mimecast-MFC-AGG-ID: ePIsxPgdMN20JPP-YcW0JQ_1761852739
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-294df925293so13137795ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852738; x=1762457538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FPpexqfre3TQlxzT3eaZX3r1F3h5MuDOnhgcH6ycLCQ=;
 b=LaeUsuJ76dJDjFLfv9IBXty2qZ++oQbsrv/sUfSqoPvUL2fdF8Z2nb0UqcCrxvy1gM
 do7tbg9lAVdBF4mfBAkRTfA2F7Ut/hVuAyAdFqpjjq8zI6n+1orLJWS1VTFckmivUXsv
 Zlbg7zeoOeuKz9z9WSoZZLFZNdJ0xfe4PgnAYjrJl+Zxa/I/Jl0B/SVB/XI9VmMwVyo9
 WRpbBnH3W8jTPctH5jUhDKhQsDE0TUoPjOe3nnUb9j1mHcPtorqjq1RjeIDOHakzQMdn
 aGAKUFeiheBW3ax8y6zob/FfiCH/ngq35dwl3TCsFTQTWBbw/QJCBNHA0KBsGUwmEOn2
 Yg7Q==
X-Gm-Message-State: AOJu0YyyQ+RdcnCDTltdXtvj+gxCQYoUtg0Y8D/Zo3WInyc92XTQF9EE
 +UQHeMBgY7ommhsz2QFs8SShGwfN/EFl8TLh4cg1oMEb9kwTfAmUD6LQuOrDy5S1+G5FiIgKSK+
 Qvhzorx7jp6mZZ5yF7NoJ52cQQO/hb8hxO2iS0fqdZMqQSy50OnidF8MVL/gq2V41TfUXw4xNND
 7EDQOxnjrtBADEQkL5EFWyEAIukvdIiJmJc0MONfk=
X-Gm-Gg: ASbGncuFoDb9UvCw8GGPwJrtRlVrQr3Z6ALzRn42R7lNhe4H91wolbbziqGg8L8ePfa
 GPzhJr3xm9H1M/BXcURtT77ve76bgOAqPpcO0OvYKUQSBgSa1gWmbGZ4ISQcdBEsboGu7VWU7Hh
 0cn1vHEgnb+M/8apocZCQuyh+oTfRws1xAa4+rHt87x9fL58DjmyvuHYw1odXEzdfe0WLmUImi5
 r8+TuzWc4aDCLU=
X-Received: by 2002:a17:902:e742:b0:28e:acf2:a782 with SMTP id
 d9443c01a7336-2951a43eb7dmr11733185ad.37.1761852738531; 
 Thu, 30 Oct 2025 12:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi3Iikz/VY7WG+9kM68mXT8VWkcpT9H6Y47+nMh4ljkgNTVGG3WPhHUfETkMYyRgzaY2ABar/KX596Sa03C5A=
X-Received: by 2002:a17:902:e742:b0:28e:acf2:a782 with SMTP id
 d9443c01a7336-2951a43eb7dmr11733005ad.37.1761852738145; Thu, 30 Oct 2025
 12:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-10-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-10-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:32:03 +0400
X-Gm-Features: AWmQ_bnK63wuJu0-VyZhP4RZ0Albm32lRO1YvOSHdEigaDxx913VaCjQPmox2ZI
Message-ID: <CAMxuvay055A8HW9HoUyuctzG+gWvca4vxBfOKwWD5PPUqP1pyQ@mail.gmail.com>
Subject: Re: [PATCH 09/21] crypto: shorten the endpoint == server check in TLS
 creds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000009a9df50642654e98"
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

--0000000000009a9df50642654e98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> This eliminates a number of long lines aiding readability.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  crypto/tlscredsx509.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 1555285910..08223781d7 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -567,6 +567,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>      g_autofree char *cert =3D NULL;
>      g_autofree char *key =3D NULL;
>      g_autofree char *dhparams =3D NULL;
> +    bool isServer =3D (creds->parent_obj.endpoint =3D=3D
> +                     QCRYPTO_TLS_CREDS_ENDPOINT_SERVER);
>      int ret;
>
>      if (!creds->parent_obj.dir) {
> @@ -576,7 +578,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>
>      trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
>
> -    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
> +    if (isServer) {
>          if (qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_X509_CA_CERT,
>                                         true, &cacert, errp) < 0 ||
> @@ -609,9 +611,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>      }
>
>      if (creds->sanityCheck &&
> -        qcrypto_tls_creds_x509_sanity_check(creds,
> -            creds->parent_obj.endpoint =3D=3D
> QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
> -            cacert, cert, errp) < 0) {
> +        qcrypto_tls_creds_x509_sanity_check(creds, isServer,
> +                                            cacert, cert, errp) < 0) {
>          return -1;
>      }
>
> @@ -664,7 +665,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>          }
>      }
>
> -    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
> +    if (isServer) {
>          if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj,
> dhparams,
>
> &creds->parent_obj.dh_params,
>                                                   errp) < 0) {
> --
> 2.51.1
>
>

--0000000000009a9df50642654e98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 6:49=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" ta=
rget=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">This eliminates a number of long lines a=
iding readability.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>=
&gt;=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
---<br>
=C2=A0crypto/tlscredsx509.c | 11 ++++++-----<br>
=C2=A01 file changed, 6 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index 1555285910..08223781d7 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -567,6 +567,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *cert =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *key =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *dhparams =3D NULL;<br>
+=C2=A0 =C2=A0 bool isServer =3D (creds-&gt;parent_obj.endpoint =3D=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0QCRYPTO_TLS_CREDS_ENDPOINT_SERVER);<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!creds-&gt;parent_obj.dir) {<br>
@@ -576,7 +578,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qcrypto_tls_creds_x509_load(creds, creds-&gt;pare=
nt_obj.dir);<br>
<br>
-=C2=A0 =C2=A0 if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_E=
NDPOINT_SERVER) {<br>
+=C2=A0 =C2=A0 if (isServer) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds=
-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_X509_CA_CERT,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true, &a=
mp;cacert, errp) &lt; 0 ||<br>
@@ -609,9 +611,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (creds-&gt;sanityCheck &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_x509_sanity_check(creds,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;parent_obj.endpoint =
=3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cacert, cert, errp) &lt; 0) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_x509_sanity_check(creds, isS=
erver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 cacert, cert, errp) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -664,7 +665,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_E=
NDPOINT_SERVER) {<br>
+=C2=A0 =C2=A0 if (isServer) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_dh_params_file(=
&amp;creds-&gt;parent_obj, dhparams,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;creds-&gt;parent_obj.dh_params,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 errp) &lt; 0) {<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>
</div>

--0000000000009a9df50642654e98--


