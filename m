Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B9BC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 18:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL5uo-00075T-FK; Sat, 22 Jun 2024 14:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sL5um-00074S-JY
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 14:56:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sL5uk-0001CV-LV
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 14:56:44 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c8062f9097so1900247a91.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719082600; x=1719687400;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MMIqqK8EHLIK636ZVfBV7/GjmZU89gW9RKNOtKYIEt4=;
 b=JIMzVpHhO7ITdKRerGDqn02Z+jrqGSeoi7tqdc4mJo1Fara9Y8vW2iiMW/TJ/JnUIX
 29s+HgvXlHc4bhgOHuuq6sfqqcWWl9gKdSil2IjNiVuBx+H4mANxYrgdsga1XVMg/y82
 SRxNgcdwsBbkX5eE/pwWob+/A9NfQ3hl7sIpRVlY8Ckt7QRfQmQezT/v7+6R65Jl9VBB
 nsUm2Np38MZEHaSK0uFWuE15hwe3UAcOCcyugw3afsg5Qx5/Q7SsVvPU2Qv3oGaC74cu
 MXuR3AXGX5U8otDSq5xzUWG1MO2UhNUKDiVr1gqrXeyrjxV1c4leniCN6xj1xp4yiCKN
 WIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719082600; x=1719687400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MMIqqK8EHLIK636ZVfBV7/GjmZU89gW9RKNOtKYIEt4=;
 b=DJ/qC48HdleMt8z2UpJk8x4qGh6Cdj+MEHdyDXVK4/sKAs+aZsc5k08qbV/XRE1RO6
 U/WmSuMByQb+YVREiTa7Tu19AIGkkWl6OE9rnKaR1uebLClM2SJ9vIqDgCm0zaXHkVQ7
 VJpqSxY2w7Kt0aO3LQqmErCY7pOrgQinjKIj2B1eek0gE5grILuirzw6Wlc3Nqj7CkrV
 oFYNh5GhmwOgG0f6NbLN7vZCr3cwZtzYgAQdJFGd//jSKILcAEHkc8RKyoA5DhvaUFlI
 +5GOuBQmvQCnGLtn3liLfAfUZx8lGym5PBFW6dIZyfy5yXcHgssgktYg7Cmi+1IYzmfC
 65Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg4KDVzUwCYiTTv/6YnRT5SWZI6OO29GMeeFCk1JvslhQoZrPn6tIO0oWw5vm32N+c5AXEjGCEJElD6QEpkqcZvSJSG0E=
X-Gm-Message-State: AOJu0Yxbvuxus/ONCs+eMDdBG3ACPp2YvBUq+mClbDxouSC/QcjMxI7w
 Waci/gvoswo6kiLfz+xHzEbYFJzcub+LCFUzYfUWi/AR6p6r8sc3QSPdm1Uvy5MEdIeXwjGOFlc
 NWub9KYX6MkCVd3VhAxRlThnvlWP1LDff/tD2aw==
X-Google-Smtp-Source: AGHT+IEQES5K0QJbYbWhViK6MccqD9tWphEdeVJh0OIHNisVGNnrWseuVr3J8SQfI9M8/13vQEHPjxXhMNqHf5L5k9I=
X-Received: by 2002:a17:902:ce89:b0:1f7:d1d:21ea with SMTP id
 d9443c01a7336-1fa23edac05mr6052575ad.32.1719082600563; Sat, 22 Jun 2024
 11:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-12-itachis@FreeBSD.org>
 <fbd46496-4bfb-4724-89da-1edf055619c6@linaro.org>
In-Reply-To: <fbd46496-4bfb-4724-89da-1edf055619c6@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 22 Jun 2024 12:56:29 -0600
Message-ID: <CANCZdfp5_Nbn9bR0SioxO4Q39onRs4ducUO1uTG8p_R5VMdS3g@mail.gmail.com>
Subject: Re: [PATCH 11/23] Update ARM AArch64 VM parameter definitions for
 bsd-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>,
 Sean Bruno <sbruno@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000bf2ed4061b7f1b2c"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102e.google.com
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

--000000000000bf2ed4061b7f1b2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 4:16=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/17/24 11:57, Ajeet Singh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Defined address spaces for FreeBSD/arm64 and added function for
> > getting stack pointer from CPU and setting a return value.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > Co-authored-by: Sean Bruno <sbruno@freebsd.org>
> > Co-authored-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/aarch64/target_arch_vmparam.h | 68 +++++++++++++++++++++++++=
+
> >   1 file changed, 68 insertions(+)
> >   create mode 100644 bsd-user/aarch64/target_arch_vmparam.h
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>
> > +                /* KERNBASE - 512 MB */
> > +#define TARGET_VM_MAXUSER_ADDRESS   (0x00007fffff000000ULL - (512 *
> MiB))
> > +#define TARGET_USRSTACK             TARGET_VM_MAXUSER_ADDRESS
>
> I will note that this may conflict with -R reserved_size,
> and is an existing issue with the x86_64 port as well.
>

There are indeed existing issues with address space management. We're
working through
them right now in the blitz branch. We have finally found where the atomic
issues were
coming from and it is <blush> not setting the flag saying we want atomic
ops when creating
the CPU structures (that's a quick summary, I'll post more on this later
when we review it).
So I'd suggest, for the moment, allowing this in and fixing it when we get
those details
ironed out. Does that sound OK?

Warner

--000000000000bf2ed4061b7f1b2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 18, 2024 at 4:16=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 6/17/24 11:57, Ajeet Singh wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Defined address spaces for FreeBSD/arm64 and added function for<br>
&gt; getting stack pointer from CPU and setting a return value.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; Co-authored-by: Sean Bruno &lt;<a href=3D"mailto:sbruno@freebsd.org" t=
arget=3D"_blank">sbruno@freebsd.org</a>&gt;<br>
&gt; Co-authored-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targ=
et=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/aarch64/target_arch_vmparam.h | 68 ++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 68 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 bsd-user/aarch64/target_arch_vmparam.h<=
br>
<br>
Acked-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.=
org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* KERNBASE -=
 512 MB */<br>
&gt; +#define TARGET_VM_MAXUSER_ADDRESS=C2=A0 =C2=A0(0x00007fffff000000ULL =
- (512 * MiB))<br>
&gt; +#define TARGET_USRSTACK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TARGET_VM_MAXUSER_ADDRESS<br>
<br>
I will note that this may conflict with -R reserved_size,<br>
and is an existing issue with the x86_64 port as well.<br></blockquote><div=
><br></div><div>There are indeed existing issues with address space managem=
ent. We&#39;re working through</div><div>them right now in the blitz branch=
. We have finally found where the atomic issues were</div><div>coming from =
and it is &lt;blush&gt; not setting the flag saying we want atomic ops when=
 creating</div><div>the CPU structures (that&#39;s a quick summary, I&#39;l=
l post more on this later when we review it).</div><div>So I&#39;d suggest,=
 for the moment, allowing this in and fixing it when we get those details</=
div><div>ironed out. Does that sound OK?</div><div><br></div><div>Warner</d=
iv></div></div>

--000000000000bf2ed4061b7f1b2c--

