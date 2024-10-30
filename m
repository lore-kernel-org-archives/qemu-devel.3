Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDBED6B6C0
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 19:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Dyt-00030d-GU; Wed, 30 Oct 2024 15:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t6Dyr-00030M-FJ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 15:03:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1t6Dyo-0006ZZ-UP
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 15:03:45 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e5a1c9071so142763b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 12:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730315021; x=1730919821;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w0sMXoheruX8J/YvB4XhrBL5xFSwAg8s95rXfLJ3DJU=;
 b=hNmiZV7OdItn8JrEi9d40/PLQ7YOJlHsxoG1no4Db02w3knsF9AxlCnxrNumWsq98t
 OqVrGSiuMJOhXsITbvFXfZ5z4DabDQxV5vLIcB4x/XARujLqHVQttgVBok9MQ/AJFlSU
 APbWfDsMh0EoSusuKlrjNgebDpQnlpH9SYA59ogUTJfGaM2wy/d6TyTzQbeK8MBTE6XC
 A8dOTnMxenFKvVKJWd9Cyje/Fk+3A7ThVTu4WOz5CE1aRlqwYIFePy1yKdXMvMek6Lz+
 Dj5JlTjm8UmERJbw4gABGuc2VBpTzn1Vvrx1Bue7nPGifyba1Xga/a317rzmSzq8OfOX
 F67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730315021; x=1730919821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w0sMXoheruX8J/YvB4XhrBL5xFSwAg8s95rXfLJ3DJU=;
 b=XbNQiDchtdYEW7r0w5lfsI7LBm8yWC4Q7ea7R1oo0cEXDv3UkSOcGnOuZ6BOSFQd0g
 c91FA4BEWEpB2ZQjMdJdvcpt7sdwIrJYZoP98lQmoagJDeo5GsND/LtqT5GOIjOyIBJN
 iRPYpoGOw1Y0wF/XyHKvGlBk9XGhMuRmN/zM4Jr0cqrE1fDHZ7yBMAcSdo83rs/zU1U2
 QB5pxh1Uzg4Z1PTXc3OQdtTlnRkoBALxld9BDdM30w7W+WYfn0Irp8pFMZRtNuMeN141
 4a/QKwtUYkONYOlN6Z3ALSYJnVS4Orlyi+I/NreS/Do+BZeNBstLwZUP2wbR/wuW4U+d
 73YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGV5YFzZ+ml5yDrFodVeAVsfesR+fJqm5mDOt2yTlEc95ekx4DfDAbzCUZgQFfuDfSZOpe3nOEsnkZ@nongnu.org
X-Gm-Message-State: AOJu0YyjMR1FDcWopTrIYHIIQB8COND97D5wVFtpjmxRrDNASSUrvrXC
 2shFZ494rKR5KI4lgeJQIcxlRA6KCFR552zPdDUaXWHNlZthPAvY7V6flvTml7zcAFNR4FGzcDr
 qpkP8tTj+XtEV2ccRTx23WUgR6Dq7ZRe3rEP/gxN01r9H5dH3FA==
X-Google-Smtp-Source: AGHT+IGtQWlDCebpgto4ZcWx/Dlsa0qEMeEfq7f1ojU0gObG5fIfOnKIdxj8S3Yb4kWx5VYUAueq85H/HjYLvJ1gAQk=
X-Received: by 2002:aa7:88c6:0:b0:71d:feb7:37f4 with SMTP id
 d2e1a72fcca58-720ab39eca2mr6125616b3a.6.1730315020943; Wed, 30 Oct 2024
 12:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241030140656.36540-1-abelova@astralinux.ru>
In-Reply-To: <20241030140656.36540-1-abelova@astralinux.ru>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 30 Oct 2024 20:03:30 +0100
Message-ID: <CAGCz3vuqRAkPtRRpqbPM+3z5iqVHOkr5fYotmva=6uqA7JnGcQ@mail.gmail.com>
Subject: Re: [PATCH] monitor: fix cases in switch in memory_dump
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Content-Type: multipart/alternative; boundary="0000000000002c725a0625b65cae"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::42e;
 envelope-from=lists@philjordan.eu; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000002c725a0625b65cae
Content-Type: text/plain; charset="UTF-8"

On Wed 30. Oct 2024 at 15:09, Anastasia Belova <abelova@astralinux.ru>
wrote:

> default case has no condition. So if it is placed
> higher that other cases, they are unreachable.
>
> Move dafult case down.
>

The stylistic merits might be debatable, but: the order of cases in a
switch block in C does not matter, the default case can appear anywhere.
The other cases are still reachable. So at minimum, the commit message is
incorrect.



> Found by Linux Verification Center (linuxtesting.org)
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  monitor/hmp-cmds-target.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index ff01cf9d8d..eea8ca047b 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -189,7 +189,6 @@ static void memory_dump(Monitor *mon, int count, int
> format, int wsize,
>          i = 0;
>          while (i < l) {
>              switch(wsize) {
> -            default:
>              case 1:
>                  v = ldub_p(buf + i);
>                  break;
> @@ -202,6 +201,9 @@ static void memory_dump(Monitor *mon, int count, int
> format, int wsize,
>              case 8:
>                  v = ldq_p(buf + i);
>                  break;
> +            default:
> +                v = ldub_p(buf + i);
> +                break;
>              }
>              monitor_printf(mon, " ");
>              switch(format) {
> --
> 2.47.0
>
>
>

--0000000000002c725a0625b65cae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed 30. Oct 2024 at 15:09, Anastasia Belova &lt;<a href=
=3D"mailto:abelova@astralinux.ru" target=3D"_blank">abelova@astralinux.ru</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">de=
fault case has no condition. So if it is placed<br>
higher that other cases, they are unreachable.<br>
<br>
Move dafult case down.<br></blockquote><div><br></div><div><div dir=3D"auto=
">The stylistic merits might be debatable, but: the order of cases in a swi=
tch block in C does not matter, the default case can appear anywhere. The o=
ther cases are still reachable. So at minimum, the commit message is incorr=
ect.<br></div></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
Found by Linux Verification Center (<a href=3D"http://linuxtesting.org" rel=
=3D"noreferrer" target=3D"_blank">linuxtesting.org</a>)<br>
<br>
Signed-off-by: Anastasia Belova &lt;<a href=3D"mailto:abelova@astralinux.ru=
" target=3D"_blank">abelova@astralinux.ru</a>&gt;<br>
---<br>
=C2=A0monitor/hmp-cmds-target.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c<br>
index ff01cf9d8d..eea8ca047b 100644<br>
--- a/monitor/hmp-cmds-target.c<br>
+++ b/monitor/hmp-cmds-target.c<br>
@@ -189,7 +189,6 @@ static void memory_dump(Monitor *mon, int count, int fo=
rmat, int wsize,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (i &lt; l) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch(wsize) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D ldub_p(=
buf + i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -202,6 +201,9 @@ static void memory_dump(Monitor *mon, int count, int fo=
rmat, int wsize,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D ldq_p(b=
uf + i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D ldub_p(buf +=
 i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot; =
&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch(format) {<br>
-- <br>
2.47.0<br>
<br>
<br>
</blockquote></div></div>
</div>

--0000000000002c725a0625b65cae--

