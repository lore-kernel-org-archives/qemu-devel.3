Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895FECCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnHD-0004cN-U5; Fri, 31 Oct 2025 07:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnH2-0004Wi-2w
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnGs-0001BG-0u
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761909972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QqGiAf/YL9Yd66V4jqsYAmncfefoX2C4M/XEVp0tmqE=;
 b=SeRlRiTufiVXts4TqbXgmvOf/phcyALTga3JRmTMAEq9Yjh+q1ENKbOzmckksQcJzTnnzQ
 FyiBfkpuS7tXvVjqbNBdr4t6yuz1vnv6Xq3H3kzsOiVLFVxyxUiM1xmBYQFWG1P8foKdyF
 mgr0v10QYtWFhoh9LctJtB3yoll6+l4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-eqhEh-4QMEin8ad6rnsdAg-1; Fri, 31 Oct 2025 07:26:10 -0400
X-MC-Unique: eqhEh-4QMEin8ad6rnsdAg-1
X-Mimecast-MFC-AGG-ID: eqhEh-4QMEin8ad6rnsdAg_1761909969
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3409148acc0so656638a91.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761909969; x=1762514769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QqGiAf/YL9Yd66V4jqsYAmncfefoX2C4M/XEVp0tmqE=;
 b=P5E3WBR/K1vFLU86h458UGhdT5Sgd4qPxk2rgDO0SkMJ/CjwGnS5BgKZ2QMS5nza7D
 yNolTJwODTpvLBms82lCTGZIGsORCqiqkWKZ85upAtdxFBClEwFQOwwRkStm2qofc3TX
 fm9ekejvAkWTJ61E17kmu01pEgXSkC32IvhJE26kst6juIDmsVD8wh3bgqu9uUOqzlnz
 rzzqgJ7zQgvKWuY9DGl6RWGuzef3RckHeD7QI1GBZ263ELOxQeJNxH5Qr/PV6mBxLyOx
 BWCvlKCbgeIvZVOUOa2UiMG2iy2BuI5Nj9UK/dh5xRbYZx2hDFLlWaXiqWbk49fBtIDW
 Okmw==
X-Gm-Message-State: AOJu0YwT/rZLWndBMdVr1Zvmjx1zOF4lsgnJqNdzwVb0H5PBFJeJfkM4
 Xz7evV8B8AstNqxyX4De/+4LJ3vfZLcIbbHOCZeBtqUoPGa1TMxENzKuu5SZARLqDhI4G4Ui4lJ
 M3WMOYhOHc/RTQSeYl41LpImOGcH1713q8cv7K6uhSCpJHNbNO/sfRA4PFKyHRtL7FAiwEQkG+q
 MX55upiRhxAxssKK+YTdcLdptZi6k/wrw=
X-Gm-Gg: ASbGncvg+z7YWILsXM3BveXeJ5DqJgYff7/LuOC6otU6HrzlTYRjONxR7ffSLdCZjS+
 YFSZ1n/prEcEK68OlVCR/DTrEqdFoYIsxlo+CWNPnKRanWqnMSqYF6PNiv139G5egctqjcsWNQ0
 Pfvo4N7TzsKdACS9uyJ9EH4Ueut3WtXeoeImGT5UlH5vhkiRlNB58SY6kPmVR6Rm2Rh2S/twhPB
 +LvM/yKVTT7QLA=
X-Received: by 2002:a17:90b:3947:b0:340:7777:2518 with SMTP id
 98e67ed59e1d1-34083074e24mr4780075a91.17.1761909969006; 
 Fri, 31 Oct 2025 04:26:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYL6toZF1Nal/9yrJ9g+kzsCL8yZVfgGpOq3SdttQys/m9LPwPQ4L2ADbD93u3sgfbn+BYKzOjaf8y3UQj2Ss=
X-Received: by 2002:a17:90b:3947:b0:340:7777:2518 with SMTP id
 98e67ed59e1d1-34083074e24mr4780034a91.17.1761909968527; Fri, 31 Oct 2025
 04:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-16-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-16-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Oct 2025 15:25:57 +0400
X-Gm-Features: AWmQ_bmUdP3Iysx3-PnRjMg2ABJtyEkYSHoHx3rwaYHVL02Ruf3g4HMcimcPeb4
Message-ID: <CAMxuvawXB3YBa7i3CitSioDk6mPgwPfLJ56zintMXMcEjPy+Zg@mail.gmail.com>
Subject: Re: [PATCH 15/21] crypto: make TLS credentials structs private
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000ccf3c3064272a1bc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000ccf3c3064272a1bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Now that the TLS session code no longer needs to look at the TLS
> credential structs, they can be made private.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsanon.c |  3 +++
>  crypto/tlscredspriv.h | 15 ---------------
>  crypto/tlscredspsk.c  |  5 +++++
>  crypto/tlscredsx509.c |  6 ++++++
>  4 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
> index 0a728ccbf6..69ed1d792a 100644
> --- a/crypto/tlscredsanon.c
> +++ b/crypto/tlscredsanon.c
> @@ -31,6 +31,9 @@
>
>  #include <gnutls/gnutls.h>
>
> +struct QCryptoTLSCredsAnon {
> +    QCryptoTLSCreds parent_obj;
> +};
>
>  static int
>  qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
> diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h
> index 4e6dffa22f..69dac02437 100644
> --- a/crypto/tlscredspriv.h
> +++ b/crypto/tlscredspriv.h
> @@ -37,21 +37,6 @@ struct QCryptoTLSCreds {
>      QCryptoTLSCredsBox *box;
>  };
>
> -struct QCryptoTLSCredsAnon {
> -    QCryptoTLSCreds parent_obj;
> -};
> -
> -struct QCryptoTLSCredsPSK {
> -    QCryptoTLSCreds parent_obj;
> -    char *username;
> -};
> -
> -struct QCryptoTLSCredsX509 {
> -    QCryptoTLSCreds parent_obj;
> -    bool sanityCheck;
> -    char *passwordid;
> -};
> -
>  #ifdef CONFIG_GNUTLS
>
>  int qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
> diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
> index 5568f1ad0c..e437985260 100644
> --- a/crypto/tlscredspsk.c
> +++ b/crypto/tlscredspsk.c
> @@ -31,6 +31,11 @@
>
>  #include <gnutls/gnutls.h>
>
> +struct QCryptoTLSCredsPSK {
> +    QCryptoTLSCreds parent_obj;
> +    char *username;
> +};
> +
>  static int
>  lookup_key(const char *pskfile, const char *username, gnutls_datum_t *ke=
y,
>             Error **errp)
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index ef31ea664c..2fc0872627 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -33,6 +33,12 @@
>  #include <gnutls/gnutls.h>
>  #include <gnutls/x509.h>
>
> +struct QCryptoTLSCredsX509 {
> +    QCryptoTLSCreds parent_obj;
> +    bool sanityCheck;
> +    char *passwordid;
> +};
> +
>
>  static int
>  qcrypto_tls_creds_check_cert_times(gnutls_x509_crt_t cert,
> --
> 2.51.1
>
>

--000000000000ccf3c3064272a1bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30,=
 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Now that the TLS session code no longer=
 needs to look at the TLS<br>
credential structs, they can be made private.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/tlscredsanon.c |=C2=A0 3 +++<br>
=C2=A0crypto/tlscredspriv.h | 15 ---------------<br>
=C2=A0crypto/tlscredspsk.c=C2=A0 |=C2=A0 5 +++++<br>
=C2=A0crypto/tlscredsx509.c |=C2=A0 6 ++++++<br>
=C2=A04 files changed, 14 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c<br>
index 0a728ccbf6..69ed1d792a 100644<br>
--- a/crypto/tlscredsanon.c<br>
+++ b/crypto/tlscredsanon.c<br>
@@ -31,6 +31,9 @@<br>
<br>
=C2=A0#include &lt;gnutls/gnutls.h&gt;<br>
<br>
+struct QCryptoTLSCredsAnon {<br>
+=C2=A0 =C2=A0 QCryptoTLSCreds parent_obj;<br>
+};<br>
<br>
=C2=A0static int<br>
=C2=A0qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,<br>
diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h<br>
index 4e6dffa22f..69dac02437 100644<br>
--- a/crypto/tlscredspriv.h<br>
+++ b/crypto/tlscredspriv.h<br>
@@ -37,21 +37,6 @@ struct QCryptoTLSCreds {<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsBox *box;<br>
=C2=A0};<br>
<br>
-struct QCryptoTLSCredsAnon {<br>
-=C2=A0 =C2=A0 QCryptoTLSCreds parent_obj;<br>
-};<br>
-<br>
-struct QCryptoTLSCredsPSK {<br>
-=C2=A0 =C2=A0 QCryptoTLSCreds parent_obj;<br>
-=C2=A0 =C2=A0 char *username;<br>
-};<br>
-<br>
-struct QCryptoTLSCredsX509 {<br>
-=C2=A0 =C2=A0 QCryptoTLSCreds parent_obj;<br>
-=C2=A0 =C2=A0 bool sanityCheck;<br>
-=C2=A0 =C2=A0 char *passwordid;<br>
-};<br>
-<br>
=C2=A0#ifdef CONFIG_GNUTLS<br>
<br>
=C2=A0int qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,<br>
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c<br>
index 5568f1ad0c..e437985260 100644<br>
--- a/crypto/tlscredspsk.c<br>
+++ b/crypto/tlscredspsk.c<br>
@@ -31,6 +31,11 @@<br>
<br>
=C2=A0#include &lt;gnutls/gnutls.h&gt;<br>
<br>
+struct QCryptoTLSCredsPSK {<br>
+=C2=A0 =C2=A0 QCryptoTLSCreds parent_obj;<br>
+=C2=A0 =C2=A0 char *username;<br>
+};<br>
+<br>
=C2=A0static int<br>
=C2=A0lookup_key(const char *pskfile, const char *username, gnutls_datum_t =
*key,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index ef31ea664c..2fc0872627 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -33,6 +33,12 @@<br>
=C2=A0#include &lt;gnutls/gnutls.h&gt;<br>
=C2=A0#include &lt;gnutls/x509.h&gt;<br>
<br>
+struct QCryptoTLSCredsX509 {<br>
+=C2=A0 =C2=A0 QCryptoTLSCreds parent_obj;<br>
+=C2=A0 =C2=A0 bool sanityCheck;<br>
+=C2=A0 =C2=A0 char *passwordid;<br>
+};<br>
+<br>
<br>
=C2=A0static int<br>
=C2=A0qcrypto_tls_creds_check_cert_times(gnutls_x509_crt_t cert,<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--000000000000ccf3c3064272a1bc--


