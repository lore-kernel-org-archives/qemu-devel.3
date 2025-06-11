Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3755CC61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 04:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPChv-0006uR-1q; Wed, 11 Jun 2025 00:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yo-satoh@sios.com>) id 1uPChr-0006u9-6h
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 00:04:55 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yo-satoh@sios.com>) id 1uPCho-0006l7-O0
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 00:04:54 -0400
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4e7b397cc2aso401922137.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 21:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sios-com.20230601.gappssmtp.com; s=20230601; t=1749614689; x=1750219489;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/yzETLPN6QCz2mrepUAs37KWVXejS59hY8SF1A1d7Vs=;
 b=IKHGtfLZMeQnMq6bZ7eI/zMxhLJYgY4nI1PpahZm7DqV4yBCkNGsJLK5jiikKhiXR4
 SDBcZnwIvLLJ7gLyMtviMxVO3bWAgfIVEzObui17frEGj0KbpXGgweWNoQgpbTAI7AvK
 XN9F/4GIyUreqjBr1drXx1P+nZrHoNxPfkpckgaMOot5pEcWHoP8ekGxnkEAH2j4nZUo
 EOgd0dCiRkyzDfdbzMN8GKwLFpb9zFvXYCtOCI3zHot0yFDa2J6mp1vy+ZX8WgigMQ/C
 2Jl5xmHwiTVJ7OjgvKU+xoZaJIRRIvDmPRbomSLaJnJUVULmMpHn9ZgsQjnjY0qCEvGu
 xmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749614689; x=1750219489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/yzETLPN6QCz2mrepUAs37KWVXejS59hY8SF1A1d7Vs=;
 b=udug8CJ0IYEYzpTu4nWtIfHGK8uj97dTEj5VEoz3UR4HF0Onj8GY+BcPgmSCo35/Th
 6S2KQkH6extzNj7ugSVfHhk9ib0cd9cjiVMChu7goZVHcRkD5XrAihH0akq/qug56Bmb
 /Wxi03FGJYd4RMHP90UeS1JRtp7UgHOgc4lXRJQl5YE9JsQeT0hW+OIiQU5dxYobrV27
 ALp7q3xxqPlR5zD1uG8LNSqe7CHhL0J6bytDdTXIrGhdjpwc2rRtNT9kJeydjI/6E7GH
 iHFfZSiAu8NmHOjNGiELbB8immrvijJhNGw66PA6qiqyO4VHhPnAbjFbkoNStd5Z6EgU
 Dv7w==
X-Gm-Message-State: AOJu0Yy1WLg9KTRB0wBxdP4vwMlqOAZUzqDSnj97kog6+WDkomBu7UKi
 mmKD/tLUflQicmmYmedRw1RwNVeldEGP2tZH4fHB9lrfBHIq/1006x2HwsXDsotDrB39hXjvOcT
 ZAYcLvIAPXkTsbiGsdqioaJJZm5nIwLqVHaWC2R8Eog==
X-Gm-Gg: ASbGncsIjuoTwsaigPTk/EYjdHTM0ZqJsHyGjVfevW4DAyY8n174+UEn5zi50lGj4OP
 dmM10I4I2Lpr6WMw+GrUnYdI5JFgZzqfiveEhQM7qSj9D93aV3zKbDsjaxBmNYxTtsoIYu/vB+V
 fUHEhOw7pIho+fDSR6h1GCDBt+/yS6FzDZYq7ZOl7tdu2QsZLbzdd5v7HrGYadVdjSv2IAv9E=
X-Google-Smtp-Source: AGHT+IHIt9SDU4wgkfmc/kUaAGiP+SFNkuFyxM8wmmAU+IpqLhmje9TjRvtq6TiZldE5pCGP/v0vvVomErw6/opjkBM=
X-Received: by 2002:a05:6102:b14:b0:4e6:df73:f155 with SMTP id
 ada2fe7eead31-4e7bbaf6236mr1227744137.14.1749614689475; Tue, 10 Jun 2025
 21:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250610120123.37689-1-thuth@redhat.com>
In-Reply-To: <20250610120123.37689-1-thuth@redhat.com>
From: Yoshinori Sato <yo-satoh@sios.com>
Date: Wed, 11 Jun 2025 13:04:39 +0900
X-Gm-Features: AX0GCFvqYS1uU8JHDNhiaNnjvFqh2X_IltqkGZmnXeTkJCXpQ5es35a767wiYHU
Message-ID: <CAL_XjKVtOVa744H5VgSARaRMoG4S_bA3diHqV1AN0Wjv-hCNjg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Drop the defunct mail address from Yoshinori
 Sato
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000f723b063743ead2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=yo-satoh@sios.com; helo=mail-vs1-xe35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000f723b063743ead2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My email is becoming a black hole.
This email address cannot be used to send patches, so we will prepare a
different email address and update it.

2025=E5=B9=B46=E6=9C=8810=E6=97=A5(=E7=81=AB) 21:01 Thomas Huth <thuth@redh=
at.com>:

> From: Thomas Huth <thuth@redhat.com>
>
> The OSDN / sourceforge.jp site ceased to work (according to
> https://en.wikipedia.org/wiki/OSDN#History at least since midth
> of April 2025) and mails to Yosinori Sato are currently bouncing.
> Since it's unlikely that the site will be back, let's remove the
> defunct mail entries for now and hope that Yoshinori will be back
> with a working e-mail address sometime in the future.
> While we're at it, downgrade some related "Odd Fixes" entries
> to "Orphan" since we don't have a maintainer listed here anymore.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb2b338fb11..d6d5f47c9a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -367,7 +367,6 @@ F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>
>  SH4 TCG CPUs
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Orphan
>  F: target/sh4/
>  F: hw/sh4/
> @@ -1693,7 +1692,6 @@ F: docs/system/riscv/microblaze-v-generic.rst
>  RX Machines
>  -----------
>  rx-gdbsim
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Orphan
>  F: docs/system/target-rx.rst
>  F: hw/rx/rx-gdbsim.c
> @@ -1702,9 +1700,8 @@ F: tests/functional/test_rx_gdbsim.py
>  SH4 Machines
>  ------------
>  R2D
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
>  R: Magnus Damm <magnus.damm@gmail.com>
> -S: Odd Fixes
> +S: Orphan
>  F: hw/char/sh_serial.c
>  F: hw/sh4/r2d.c
>  F: hw/intc/sh_intc.c
> @@ -2753,9 +2750,8 @@ F: tests/qtest/*xive*
>  F: docs/*/*xive*
>
>  Renesas peripherals
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
>  R: Magnus Damm <magnus.damm@gmail.com>
> -S: Odd Fixes
> +S: Orphan
>  F: hw/char/renesas_sci.c
>  F: hw/char/sh_serial.c
>  F: hw/timer/renesas_*.c
> @@ -2765,7 +2761,6 @@ F: include/hw/sh4/sh.h
>  F: include/hw/timer/renesas_*.h
>
>  Renesas RX peripherals
> -R: Yoshinori Sato <ysato@users.sourceforge.jp>
>  S: Orphan
>  F: hw/intc/rx_icu.c
>  F: hw/rx/
> --
> 2.49.0
>
>

--0000000000000f723b063743ead2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">My email is becoming a black hole.<div dir=3D"auto">This =
email address cannot be used to send patches, so we will prepare a differen=
t email address and update it.</div></div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">2025=E5=B9=B46=E6=
=9C=8810=E6=97=A5(=E7=81=AB) 21:01 Thomas Huth &lt;<a href=3D"mailto:thuth@=
redhat.com">thuth@redhat.com</a>&gt;:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
The OSDN / <a href=3D"http://sourceforge.jp" rel=3D"noreferrer noreferrer" =
target=3D"_blank">sourceforge.jp</a> site ceased to work (according to<br>
<a href=3D"https://en.wikipedia.org/wiki/OSDN#History" rel=3D"noreferrer no=
referrer" target=3D"_blank">https://en.wikipedia.org/wiki/OSDN#History</a> =
at least since midth<br>
of April 2025) and mails to Yosinori Sato are currently bouncing.<br>
Since it&#39;s unlikely that the site will be back, let&#39;s remove the<br=
>
defunct mail entries for now and hope that Yoshinori will be back<br>
with a working e-mail address sometime in the future.<br>
While we&#39;re at it, downgrade some related &quot;Odd Fixes&quot; entries=
<br>
to &quot;Orphan&quot; since we don&#39;t have a maintainer listed here anym=
ore.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 9 ++-------<br>
=C2=A01 file changed, 2 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index eb2b338fb11..d6d5f47c9a5 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -367,7 +367,6 @@ F: tests/tcg/s390x/<br>
=C2=A0L: <a href=3D"mailto:qemu-s390x@nongnu.org" target=3D"_blank" rel=3D"=
noreferrer">qemu-s390x@nongnu.org</a><br>
<br>
=C2=A0SH4 TCG CPUs<br>
-R: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge.jp" target=
=3D"_blank" rel=3D"noreferrer">ysato@users.sourceforge.jp</a>&gt;<br>
=C2=A0S: Orphan<br>
=C2=A0F: target/sh4/<br>
=C2=A0F: hw/sh4/<br>
@@ -1693,7 +1692,6 @@ F: docs/system/riscv/microblaze-v-generic.rst<br>
=C2=A0RX Machines<br>
=C2=A0-----------<br>
=C2=A0rx-gdbsim<br>
-R: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge.jp" target=
=3D"_blank" rel=3D"noreferrer">ysato@users.sourceforge.jp</a>&gt;<br>
=C2=A0S: Orphan<br>
=C2=A0F: docs/system/target-rx.rst<br>
=C2=A0F: hw/rx/rx-gdbsim.c<br>
@@ -1702,9 +1700,8 @@ F: tests/functional/test_rx_gdbsim.py<br>
=C2=A0SH4 Machines<br>
=C2=A0------------<br>
=C2=A0R2D<br>
-R: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge.jp" target=
=3D"_blank" rel=3D"noreferrer">ysato@users.sourceforge.jp</a>&gt;<br>
=C2=A0R: Magnus Damm &lt;<a href=3D"mailto:magnus.damm@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">magnus.damm@gmail.com</a>&gt;<br>
-S: Odd Fixes<br>
+S: Orphan<br>
=C2=A0F: hw/char/sh_serial.c<br>
=C2=A0F: hw/sh4/r2d.c<br>
=C2=A0F: hw/intc/sh_intc.c<br>
@@ -2753,9 +2750,8 @@ F: tests/qtest/*xive*<br>
=C2=A0F: docs/*/*xive*<br>
<br>
=C2=A0Renesas peripherals<br>
-R: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge.jp" target=
=3D"_blank" rel=3D"noreferrer">ysato@users.sourceforge.jp</a>&gt;<br>
=C2=A0R: Magnus Damm &lt;<a href=3D"mailto:magnus.damm@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">magnus.damm@gmail.com</a>&gt;<br>
-S: Odd Fixes<br>
+S: Orphan<br>
=C2=A0F: hw/char/renesas_sci.c<br>
=C2=A0F: hw/char/sh_serial.c<br>
=C2=A0F: hw/timer/renesas_*.c<br>
@@ -2765,7 +2761,6 @@ F: include/hw/sh4/sh.h<br>
=C2=A0F: include/hw/timer/renesas_*.h<br>
<br>
=C2=A0Renesas RX peripherals<br>
-R: Yoshinori Sato &lt;<a href=3D"mailto:ysato@users.sourceforge.jp" target=
=3D"_blank" rel=3D"noreferrer">ysato@users.sourceforge.jp</a>&gt;<br>
=C2=A0S: Orphan<br>
=C2=A0F: hw/intc/rx_icu.c<br>
=C2=A0F: hw/rx/<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--0000000000000f723b063743ead2--

