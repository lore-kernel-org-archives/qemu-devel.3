Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438081048925
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 00:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw8ay-0000Af-Ot; Fri, 27 Feb 2026 19:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vw8aw-0000AM-HS
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 19:54:10 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vw8au-0008GY-P4
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 19:54:10 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso1617991a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 16:54:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772240047; cv=none;
 d=google.com; s=arc-20240605;
 b=GtRgej9EZrgNUSvf3GKNG9ZRT5NaIqrVcBeh1/bw4v2hzkUpyLlTHPEe0ljXuoicxD
 3+o8wZl2V3viBMgDM/xjQ5VFTqEzhcnpjPgdS1s4negmpXeIg2iQUHNIH0lybBUh1xMz
 ZMSQehqi4YImSOUBl+kK++p7q6BRxDUw9CdC3P+FsPl35V+GtME1szbYewmamXDGE8th
 HeJS4GjF1xT5we+9/Q/NxCZd/CDOUtO7l0ZXKES7JEeZUfQOJVD5X2WvcK8t1FFWpC55
 LCxZMQuDkC5vEjxXj8+FMudGsU+PImVDvyeE1xyoZXZ5cWI3IohSk7u9boqrh2ULlAXj
 ZzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3FFmumRApwbrC5D0oxSefBWRUw5Shk4D9OgnzkilZJ0=;
 fh=dajFPOmwbchEUDS+10lbffNw9YuFtrll6EHxZ9gKqe0=;
 b=PmHCgVSKcNSedp/AF+Juzdmm8jCOgHilz6Pro9Pgf6zaGmBABOAnYdTr5b4Ly6PO7u
 FAJL5r6U6XmEy0sAtEmyHEjHsY7ffTsRe1re9KoVLFF9drkkcYzSMXY/6mQCCvEWdTpM
 BZLkeRIfT3AEX8OghPFPqHj4rWMRSpJotwMSChEa+E+G3wdt6T2g5ra55arBis7CwTLK
 umbPkzKAlY/oCnOf41ob274W1ejAR+IKu+d0yeVf21jXOy8IMckEp6L30sCMuahNvfrr
 Ay2Qdlm9MopnkZY+KRToMOrshBwxDXiEJrrPC8JVHe/cdrh/HMrsqWmtbJsUIXdeJ/uu
 Sq+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772240047; x=1772844847;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3FFmumRApwbrC5D0oxSefBWRUw5Shk4D9OgnzkilZJ0=;
 b=H31uiKNquEm8x1FyEonUnhPleGK/VogfDdLAN2GI7qtFTtTQ9u9yGXWO9I8ongQX/s
 5xRi5P6f1ArX7f3RRSmN5ffDi8pdJ8hQFDK+qcuiRwQLiJh/IaMwCnMZEVptnpPufnE7
 ISekB46yHVYn0P7ePSekbYFjaoC0JF4CP3pRxH77/O2XjZ+Dp8JDcKuXvl50b1xKTMMf
 9lT21GjT5bY3SuY/bClbxTUMjTepb8uel9Zs76xGZyG9QTJ896dInRlJjjvRSMtnSV+I
 ngCc3AO/mG5RpuHpzW6HUfiWmyS1UDJQtTI9cUva8MhyfukFuCwdjauRoH76Bdc0l52F
 rjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772240047; x=1772844847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FFmumRApwbrC5D0oxSefBWRUw5Shk4D9OgnzkilZJ0=;
 b=Mpy0v/msQg4I9rZU5lsCfhwaYCsPeNBXWRY+bBau1Z6IJWh7xcOO8/KLZmYpaavqUZ
 EMfNRVS8aELqzlAuwh7LUvH4bXbxhfqjHdjfx/Sdtoa8pCeaPra/ow0ERFxjulFEcAPC
 cpjAaimO3J3uF2ds7CsOQXMSKPvIkq/HUOz/xIK1izWGzNP2jC5enYRnKtw1X3uMDaO/
 dc3AGjE8p3ULyc5zAA7O0RyVQcIUkOKxhf/nKbkS6gjSdT/QVC0PSfeRB1LG5nCWIH0G
 I0WDffv7Hkhh4RJt0Sb67h/MnC9GrJwCpwqDE5vgcHrbYATBov50HA/0gOAUBsfezHBS
 D98w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBVxzcdT5NZcM2noZdg0BnMZ2JGFqmshO4tuDaws+s1iP3qDc+2fh1r6QRmi8Jc2RU5vOU7kTolKwJ@nongnu.org
X-Gm-Message-State: AOJu0Yx+TNRT9Pq1jW+VoWynDtzGXZ7PTencJ5i1fYfZyurqYF9mOauN
 jwRY1hUZrfg3Es6g/IbBxn6J+NcykjmmPFHI7vlisu4njZ4nKgCyz0Pykae2/UJKfCDruy6icg9
 w3czEy589z4ivImjEMuQZiZfr4jNE1rLkfaiM7z8lRg==
X-Gm-Gg: ATEYQzwIYN0NkEGqtxSS+x2HuL+fWW6rdmiIE2oHuHU8vzgPSLtI6aXo5AgdSqmqAmx
 OC054JzM60xW1udUNmPoeUoz7ub8T8K8TbW9AfItneuo73AseoXFtuQXJPRUMGIpc4B1PdeLomm
 jcHnxmXQ/u6/0XPcXTqvzJAW+M0e4E7ytSlDFtSdMo/jpuqx1fjJqGHtV71XpUTCuK27H7uruNi
 1awU1F/1WEX+DVczXoBoVg/0/l1wIy9HG8D/tDsmW7I7wVQ6lEbrcOibjryYhvrwFeIZdrsCv2a
 zL1CYxZ0bv+YK60ujhmyif19/AEIXSu2IGY/p3vzksriy1Mq
X-Received: by 2002:a05:6a20:748f:b0:363:cb5a:61 with SMTP id
 adf61e73a8af0-395c3a754e9mr4757291637.27.1772240046727; Fri, 27 Feb 2026
 16:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
 <20260228-abyss-mmap-relocation-v1-2-c8ec0476894b@astrafall.org>
 <CANCZdfpKfuP-yxAh42HEi_7ft6kPD_2HR0q28kj6VHNSu5hfWg@mail.gmail.com>
 <6039873.DvuYhMxLoT@xtex1>
In-Reply-To: <6039873.DvuYhMxLoT@xtex1>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 27 Feb 2026 17:53:55 -0700
X-Gm-Features: AaiRm53RCcmXJ8vBZAMVRQ7379oaxhYOtpBXrIgcicSuzRcXaMaxsP1jg_f-wmg
Message-ID: <CANCZdfrsvJjHjJ+N1rbtPfqY9hG3fG42XSC20BO5hx9r6VTpew@mail.gmail.com>
Subject: Re: [PATCH 2/4] bsd-user: Deal with mmap where start > reserved_va
To: Bingwu Zhang <xtex@envs.net>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000071317a064bd7ca0f"
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000071317a064bd7ca0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026, 5:46=E2=80=AFPM Bingwu Zhang <xtex@envs.net> wrote:

> On Saturday, February 28, 2026 7:49:39=E2=80=AFAM China Standard Time War=
ner Losh
> wrote:
> > Reviewed-by: Warner Losh <imp@bsdimp.com>
>
> Thank you!
>
> > Have you run FreeBSD binaries with this?
>
> No I didn't. I only ran {i386,riscv32,mips}-linux-user, failed to compile
> tests/tcg/multiarch/test-mmap.c for i386 freebsd, compiler saying mremap
> is
> undeclared.
>

Ok. I'm planning on sending my pull request later tonight. You'll likely
need to rebase around that when it lands....  If linux works, you've not
broken bsd-user

Warner

--=20
> xtex (Bingwu Zhang) @ Sat, 28 Feb 2026 00:41:49 +0000
>
>
>
>

--00000000000071317a064bd7ca0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 27, 2026, 5:46=E2=80=
=AFPM Bingwu Zhang &lt;<a href=3D"mailto:xtex@envs.net">xtex@envs.net</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">On Saturday, February 28,=
 2026 7:49:39=E2=80=AFAM China Standard Time Warner Losh <br>
wrote:<br>
&gt; Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=
=3D"_blank" rel=3D"noreferrer">imp@bsdimp.com</a>&gt;<br>
<br>
Thank you!<br>
<br>
&gt; Have you run FreeBSD binaries with this?<br>
<br>
No I didn&#39;t. I only ran {i386,riscv32,mips}-linux-user, failed to compi=
le <br>
tests/tcg/multiarch/test-mmap.c for i386 freebsd, compiler saying mremap is=
 <br>
undeclared.<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Ok. I&#39;m planning on sending my pull request later tonight. Y=
ou&#39;ll likely need to rebase around that when it lands....=C2=A0 If linu=
x works, you&#39;ve not broken bsd-user</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Warner</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
-- <br>
xtex (Bingwu Zhang) @ Sat, 28 Feb 2026 00:41:49 +0000<br>
<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000071317a064bd7ca0f--

