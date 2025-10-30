Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94D2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYNa-0002UT-Lx; Thu, 30 Oct 2025 15:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNU-0002Sq-O8
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNP-0005jk-UO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RZuwBqSglXfzHMANbZJfEPkpeSCYDm9KgAUzfY2qNjE=;
 b=Nukk68cE5G63IfxUSCR9R/95+nMzce1s4C9kx9dfwkiKFiexwoM16TzXAYS8wOqBaqcU/8
 +fnQQXdC66dexltHzF0Idql2NDUHVgkoHmOH7so1gPhR3ATIod6yXC7Mi0hnzYb/vusccV
 caZ7zGI827lRi5BTm+hU0uUiPJOC5cI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-fy1fkVUQO5Cz0HSV2BSK4w-1; Thu, 30 Oct 2025 15:31:57 -0400
X-MC-Unique: fy1fkVUQO5Cz0HSV2BSK4w-1
X-Mimecast-MFC-AGG-ID: fy1fkVUQO5Cz0HSV2BSK4w_1761852716
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-28bd8b3fa67so12522315ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852716; x=1762457516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RZuwBqSglXfzHMANbZJfEPkpeSCYDm9KgAUzfY2qNjE=;
 b=eET2iO0wnF5Ifd7213n9Ma+MT0+BZL1KWsOEeFbPj/Up87yvNEOf+pc44xilmRu820
 DK1+Zi3Lh+y+6u+geIF/6e70oLySijXHyPYD93irfcMDBeY9YmJSzmL9XWYN2N8xHkUE
 U0C9V02vnW0UpZ54C+i2FOz1hNIxf6OrQom/TaqIzhKa0dF+fXcs6NIuMVdLMOSpesFu
 FCoV6cnbCYy1BVgE/i+k9ds1X9jxQcuC3IZ3sKuSmNaqmjoIRSnpblk7tS6VLaxYbNso
 v4pdCS8piSUIPwsvuVXYiAYmKO382+OgfqCGc6BiY81nVuaFASfGSyJtlHY4Xlgxdn4b
 sNYA==
X-Gm-Message-State: AOJu0YwuFuhc+pc0+VQp6dIWsG+2SyAaCVNPsAgb7vafxNieFexP/nBO
 AW3f/dge8ennHC8FG9ytClY8gJXHDtRWC2GFwYTcCltJOvKRerFagF7v2FbYqaJKg+ktMF8oIas
 gU8GadabUj53CaztKVvnU9UayxtyzSFRBOQOMIvB7L5ULGU+Z44kICwvfjpJSPNXRDXg0lbeqB4
 qHMCrXZR0lMpeJjDWr5x3sQ6UIKB0Y//8c2h4P0TU=
X-Gm-Gg: ASbGnct9v3CEP3/5aYr9Ln2XIKbrW6HOqohtqMhnHcz2GKzD2DUW+lxaCNWQTF+RK6O
 xXbS3A7zK5mhZmREuFhGikLL8PP9HvPId0DjlUHvOkbBGUS+RMQjX2xgpaShwLIGrXvSV5/3uCZ
 QdU0LrB/gShcFtWGwENi9IVzveeSLgh08V3TN/yumTlqfB5v/l/cuC6nXO16CdkSqUdMcViroVz
 nRgULst6kbUtzE=
X-Received: by 2002:a17:903:11cd:b0:27d:c542:fe25 with SMTP id
 d9443c01a7336-2951a587e32mr11186455ad.41.1761852715738; 
 Thu, 30 Oct 2025 12:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXxoAWGqN9vPpwjhr49sLoOVwyJ8UvKI1dySSX8VTSVsPSODMzQsumM8xYsJ8s+g5VDvEWYl4DxnfS1Q40iiU=
X-Received: by 2002:a17:903:11cd:b0:27d:c542:fe25 with SMTP id
 d9443c01a7336-2951a587e32mr11186155ad.41.1761852715253; Thu, 30 Oct 2025
 12:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-9-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-9-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:31:43 +0400
X-Gm-Features: AWmQ_bnPEDxsNWPTZAL54O23vjrjWhuyY21_TC_DKHml5aYcS5BQpGX_e4ErXUk
Message-ID: <CAMxuvayDCp-XxzEkR8B1qsP3dAzcQ_bh0u1OpPBOC5ABMd_e8A@mail.gmail.com>
Subject: Re: [PATCH 08/21] crypto: move release of DH parameters into TLS
 creds parent
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000003d54470642654de2"
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

--0000000000003d54470642654de2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The code for releasing DH parameters is common to all credential
> subclasses, so can be moved into the parent.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

and unload() was only called from finalize
(and qcrypto_tls_creds_x509_reload())

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscreds.c     | 4 ++++
>  crypto/tlscredsanon.c | 4 ----
>  crypto/tlscredspsk.c  | 4 ----
>  crypto/tlscredsx509.c | 7 +++----
>  4 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 65e97ddd11..1e39ee1141 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -246,6 +246,10 @@ qcrypto_tls_creds_finalize(Object *obj)
>  {
>      QCryptoTLSCreds *creds =3D QCRYPTO_TLS_CREDS(obj);
>
> +    if (creds->dh_params) {
> +        gnutls_dh_params_deinit(creds->dh_params);
> +    }
> +
>      g_free(creds->dir);
>      g_free(creds->priority);
>  }
> diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
> index bc3351b5d6..1ddfe4eb31 100644
> --- a/crypto/tlscredsanon.c
> +++ b/crypto/tlscredsanon.c
> @@ -92,10 +92,6 @@ qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon
> *creds)
>              creds->data.server =3D NULL;
>          }
>      }
> -    if (creds->parent_obj.dh_params) {
> -        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
> -        creds->parent_obj.dh_params =3D NULL;
> -    }
>  }
>
>  #else /* ! CONFIG_GNUTLS */
> diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
> index 545d3e45db..bf4efe2114 100644
> --- a/crypto/tlscredspsk.c
> +++ b/crypto/tlscredspsk.c
> @@ -175,10 +175,6 @@ qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK
> *creds)
>              creds->data.server =3D NULL;
>          }
>      }
> -    if (creds->parent_obj.dh_params) {
> -        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
> -        creds->parent_obj.dh_params =3D NULL;
> -    }
>  }
>
>  #else /* ! CONFIG_GNUTLS */
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 39f80b33ad..1555285910 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -685,10 +685,6 @@ qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509
> *creds)
>          gnutls_certificate_free_credentials(creds->data);
>          creds->data =3D NULL;
>      }
> -    if (creds->parent_obj.dh_params) {
> -        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
> -        creds->parent_obj.dh_params =3D NULL;
> -    }
>  }
>
>
> @@ -780,6 +776,9 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds *creds,
> Error **errp)
>      qcrypto_tls_creds_x509_load(x509_creds, &local_err);
>      if (local_err) {
>          qcrypto_tls_creds_x509_unload(x509_creds);
> +        if (creds->dh_params) {
> +            gnutls_dh_params_deinit(creds->dh_params);
> +        }
>          x509_creds->data =3D creds_data;
>          creds->dh_params =3D creds_dh_params;
>          error_propagate(errp, local_err);
> --
> 2.51.1
>
>

--0000000000003d54470642654de2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025=
 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@=
redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">The code for releasing DH =
parameters is common to all credential<br>
subclasses, so can be moved into the parent.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>and unload() was only called from finalize (and=C2=A0qcrypto_=
tls_creds_x509_reload())</div><div><br></div><div>Reviewed-by: Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_bl=
ank">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/tlscreds.c=C2=A0 =C2=A0 =C2=A0| 4 ++++<br>
=C2=A0crypto/tlscredsanon.c | 4 ----<br>
=C2=A0crypto/tlscredspsk.c=C2=A0 | 4 ----<br>
=C2=A0crypto/tlscredsx509.c | 7 +++----<br>
=C2=A04 files changed, 7 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 65e97ddd11..1e39ee1141 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -246,6 +246,10 @@ qcrypto_tls_creds_finalize(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCreds *creds =3D QCRYPTO_TLS_CREDS(obj);<br>
<br>
+=C2=A0 =C2=A0 if (creds-&gt;dh_params) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds-&gt;dh_params);<=
br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0g_free(creds-&gt;dir);<br>
=C2=A0 =C2=A0 =C2=A0g_free(creds-&gt;priority);<br>
=C2=A0}<br>
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c<br>
index bc3351b5d6..1ddfe4eb31 100644<br>
--- a/crypto/tlscredsanon.c<br>
+++ b/crypto/tlscredsanon.c<br>
@@ -92,10 +92,6 @@ qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;data.server =3D N=
ULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (creds-&gt;parent_obj.dh_params) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds-&gt;parent_obj.d=
h_params);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;parent_obj.dh_params =3D NULL;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0#else /* ! CONFIG_GNUTLS */<br>
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c<br>
index 545d3e45db..bf4efe2114 100644<br>
--- a/crypto/tlscredspsk.c<br>
+++ b/crypto/tlscredspsk.c<br>
@@ -175,10 +175,6 @@ qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;data.server =3D N=
ULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (creds-&gt;parent_obj.dh_params) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds-&gt;parent_obj.d=
h_params);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;parent_obj.dh_params =3D NULL;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0#else /* ! CONFIG_GNUTLS */<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index 39f80b33ad..1555285910 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -685,10 +685,6 @@ qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *cre=
ds)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gnutls_certificate_free_credentials(creds=
-&gt;data);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;data =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (creds-&gt;parent_obj.dh_params) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds-&gt;parent_obj.d=
h_params);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;parent_obj.dh_params =3D NULL;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
<br>
@@ -780,6 +776,9 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds *creds, E=
rror **errp)<br>
=C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_x509_load(x509_creds, &amp;local_err)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_x509_unload(x509_creds)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;dh_params) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(creds-&g=
t;dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x509_creds-&gt;data =3D creds_data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;dh_params =3D creds_dh_params;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>
</div>

--0000000000003d54470642654de2--


