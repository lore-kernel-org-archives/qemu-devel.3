Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE98FD3C935
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 17:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2wb8-00067q-9H; Mon, 21 Oct 2024 13:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t2wb4-00067H-HF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:53:40 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t2wb2-0006lf-HU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 13:53:37 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84fd01c9defso1425044241.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729533215; x=1730138015; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7s/me6Y3Q8U+Au/cFS/TNMnhZop3JZLNDJRQQncJFiA=;
 b=Hgz8f2VrmceIifwom4gYGVDhhVcfoTtBhKCSq8zcjCsMSqcFVkFXp7/8X3/a4oyQQn
 IftL6yYQE2GIS5A0WY5hnXy93aFIDp92qO3kIUNq97immIqyPhaHYfnpHAOA8zJvJVMu
 JeK6gF3vy/i0PJVaiWpvvSjlq6nhFaNAaAd2GcXg4oSd/GICaGbXv7hVUIZNnhp3MMyX
 Z32W2sfC32eXO9iAe46UwFqaRPWoa7gqoVp9oEh3g8RjpJLurAxTU5z3fbsS5+ELqaKH
 +hWYDwTJtTI/4G8BheTGh64hODM+4pOct2XROjsqjItXXtCRzaTyELQ1Z9M1UxCGyKN0
 J7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729533215; x=1730138015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7s/me6Y3Q8U+Au/cFS/TNMnhZop3JZLNDJRQQncJFiA=;
 b=ZXYt3wk/BxzMmQtSM2vt2qq8j10c6esLA9HbV0SRhftp8HVwuRbK7miPJJxXVOEpxi
 tIDF6HCrPNaCHECcv8D7yKKGyanpbCVqGEUvjRA1oo1kJV2I99tjtwC0MK46S2cJOb6y
 DmKbqDlwAzwoy6fYVa0K8zjvHY1qs03+YZztkeIRxKClumElP2gO9pOWDlIivMpAnRv5
 eQfb1zsH4iDcPtoEMKJ8UT8AKpD2E2OBZi7jfaaVncJ6GoErAeSCsRn9kZVT605DQRU5
 S4gVz3D8FN71Cwxpca5t1DuhifoIYBdSpbAdQgKcpB0GFIh+GK6k/Por703TVvS181ON
 Yagg==
X-Gm-Message-State: AOJu0YxCv0ZIAoSEqqMqY8cxfEwBf/RZLKnUuvnJ4bezlaweWZr/zUB5
 ASNoN2oV27mAP16WyCrFGknIsTiv1wC7ncfzjKPXKAJ+81ouc/jA01x7muB2S/AZ6dTsOoJnohf
 DP4jqtJmBhJYsacA0r5yCjzHBhvA=
X-Google-Smtp-Source: AGHT+IFpmFhxoy+Z39iXQzUfeJIQdnJFQAbLJAQSShpNqmMRik35XsLeMY7yed1FARd435rp8cyJxKC5L88Z22Lg2VA=
X-Received: by 2002:a05:6102:32d5:b0:4a4:8e06:6e98 with SMTP id
 ada2fe7eead31-4a5d6b16d68mr9329456137.15.1729533215058; Mon, 21 Oct 2024
 10:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241021161957.1431919-1-berrange@redhat.com>
In-Reply-To: <20241021161957.1431919-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 21 Oct 2024 21:53:23 +0400
Message-ID: <CAJ+F1CJNP+ow-BPE0xyZs5ezvDSNiqqBgZUkh1mfcPfquF+4fw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ui: various improvements to VNC SASL code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e935f20625005420"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000e935f20625005420
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel

On Mon, Oct 21, 2024 at 8:21=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> This fixes a few minor edge cases noticed when writing the formal
> specification for the SASL VNC extension.
>
> Daniel P. Berrang=C3=A9 (6):
>   ui/vnc: don't return an empty SASL mechlist to the client
>   ui/vnc: don't raise error formatting socket address for non-inet
>   ui/vnc: fix skipping SASL SSF on UNIX sockets
>   ui/vnc: don't check for SSF after SASL authentication on UNIX sockets
>   ui: fix handling of NULL SASL server data
>   ui: validate NUL byte padding in SASL client data more strictly
>

For the series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>  ui/vnc-auth-sasl.c | 75 ++++++++++++++++++++++++++++++++--------------
>  ui/vnc.c           |  3 --
>  ui/vnc.h           |  1 -
>  3 files changed, 52 insertions(+), 27 deletions(-)
>
> --
> 2.46.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e935f20625005420
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Daniel<br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 21, 2024 at 8:21=E2=80=AFPM =
Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This fixes a few minor edge cases noticed when writing the forma=
l<br>
specification for the SASL VNC extension.<br>
<br>
Daniel P. Berrang=C3=A9 (6):<br>
=C2=A0 ui/vnc: don&#39;t return an empty SASL mechlist to the client<br>
=C2=A0 ui/vnc: don&#39;t raise error formatting socket address for non-inet=
<br>
=C2=A0 ui/vnc: fix skipping SASL SSF on UNIX sockets<br>
=C2=A0 ui/vnc: don&#39;t check for SSF after SASL authentication on UNIX so=
ckets<br>
=C2=A0 ui: fix handling of NULL SASL server data<br>
=C2=A0 ui: validate NUL byte padding in SASL client data more strictly<br><=
/blockquote><div><br></div><div>For the series:</div><div>Reviewed-by: Marc=
-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marca=
ndre.lureau@redhat.com</a>&gt;</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
=C2=A0ui/vnc-auth-sasl.c | 75 ++++++++++++++++++++++++++++++++-------------=
-<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 --<br>
=C2=A0ui/vnc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A03 files changed, 52 insertions(+), 27 deletions(-)<br>
<br>
-- <br>
2.46.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000e935f20625005420--

