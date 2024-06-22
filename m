Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C505FC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 18:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL5c8-0001k2-NJ; Sat, 22 Jun 2024 14:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sL5c6-0001he-V7
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 14:37:26 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sL5c3-0005WZ-Sr
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 14:37:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c85f0c02f5so117597a91.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719081441; x=1719686241;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OajuS3rPe6ZMEPvn56U+STwojWjPCsJfgHZTCLGZUIU=;
 b=eaEGzWtFKnBU6f5cj6cF9gHikJ06LcvuRFXpBGO05mSElGWaFiszJ+gCxtp3MkPboG
 W+To9H4RiUm3DFcrH9h8ey030dAg4/iDTUcem5uTG0x6ruWVRyZNEep1i5ssVQh+dkSx
 5RtpzLoAnOV79uyHP1y8F3QnEeerOkzKOg9BVh88MPveghgrstO6b5FV6/yzeTWE9XQZ
 a0QIN9Ou/jwHtKNrPNrKxrhYuECiIECIeSBmL5/i2M+8vHKf4woITYJYpmrkZFsTDGa8
 /Qx04eUQVLh+I2UzxaTQSESj+bGbRGXflEEQZO8QGq7LFArPYOWyX8+74pMwSFCIXjky
 PAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719081441; x=1719686241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OajuS3rPe6ZMEPvn56U+STwojWjPCsJfgHZTCLGZUIU=;
 b=vTfYCo7SBuSY3nd/J8AptXA3QstOms6k0r/DFOwoXAW6DrWGcJViIoMMhmgvb5sEDm
 D0pg0jYN//sexQOwk52yI9ehVl1PdNfA3OHg/bl6nP0IDcbtB/HIMCR6I1YeafcYJM9w
 LWzSsZ6ITNTyER0pfq4ZBpNuUqLAa5Kx6u0wgIO2rxEdN3vguZvhU6QtlkStPcYOjTZa
 e26JdU4HMgiHBncE7XH3lZsMgMUb1sbgj6rSm92Aj0iKZzIDMNoX8sbiC0wFFqeT0f3N
 q4iYIF1MeoWTnHOL6aI/NF6zbt767gLA7lzTw2FD4+iCGtw7nXYpBmIJelcMC3sS6MUb
 /wNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWaayrWKCcVr4mnfGwaS6YZMvZjsMP4E2JYnFFrf7b+tiuDwdMqq/iyWw22kKsjXCRRgXPCkq6Fp1vy0h6etFKjGPWXDA=
X-Gm-Message-State: AOJu0YzyNakPbKbbnl/6YBG9wB4nUOQV6AOCnP1KbqyDbncdAoNsJanW
 +lvblUJhmB7AWB5xSE9xlnQGI8xihIex1nvMliWCasZBzDFX2HgRSCkJ0qNDkt71dKXL+bBB/05
 UJIfhDqviuhF3DApIDjASY/PoigCRynUIfkE8uw==
X-Google-Smtp-Source: AGHT+IGd07YVcRRds8C+8o7yaA57t+MK04if+qfCSKfwToG58+pIHGIBpmLT5CmrwvEd6VwO/GI0+ouV9YRHPPA3li8=
X-Received: by 2002:a17:90b:4b4a:b0:2c2:e7e5:5c29 with SMTP id
 98e67ed59e1d1-2c86127adf7mr395121a91.29.1719081441445; Sat, 22 Jun 2024
 11:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-2-itachis@FreeBSD.org>
 <843f41b3-5ade-47bf-9802-be94086e6168@linaro.org>
In-Reply-To: <843f41b3-5ade-47bf-9802-be94086e6168@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 22 Jun 2024 12:37:10 -0600
Message-ID: <CANCZdfpFcJ3wodLi4FsDNcPoyqiRF0dfEfkq1ahrsNCD5GM4kw@mail.gmail.com>
Subject: Re: [PATCH 01/23] Add CPU initialization function
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000a86cf2061b7ed620"
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1032.google.com
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

--000000000000a86cf2061b7ed620
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:17=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/17/24 11:57, Ajeet Singh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Addded function to initialize ARM CPU
> > and to check if it supports 64 bit mode
> >
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > ---
> >   bsd-user/aarch64/target_arch_cpu.h | 42 +++++++++++++++++++++++++++++=
+
> >   1 file changed, 42 insertions(+)
> >   create mode 100644 bsd-user/aarch64/target_arch_cpu.h
> >
> > diff --git a/bsd-user/aarch64/target_arch_cpu.h
> b/bsd-user/aarch64/target_arch_cpu.h
> > new file mode 100644
> > index 0000000000..db5c7062b9
> > --- /dev/null
> > +++ b/bsd-user/aarch64/target_arch_cpu.h
> > @@ -0,0 +1,42 @@
> > +/*
> > + *  ARM AArch64 cpu init and loop
> > + *
> > + * Copyright (c) 2015 Stacey Son
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef TARGET_ARCH_CPU_H
> > +#define TARGET_ARCH_CPU_H
> > +
> > +#include "target_arch.h"
> > +#include "target/arm/syndrome.h"
>
> Do you actually need syndrome.h?
>

It's needed, but not for this chunk. It is needed for patch 2 because we
start to use the syndrome functions there to dispatch / decode the traps.
So that should be moved to patch 2 in the next round, I think.

Also

Reviewed-by: Warner Losh <imp@bsdimp.com>

since this looks correct and I didn't write it :)

Warner


> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>
> > +
> > +#define TARGET_DEFAULT_CPU_MODEL "any"
> > +
> > +static inline void target_cpu_init(CPUARMState *env,
> > +    struct target_pt_regs *regs)
> > +{
> > +    int i;
> > +
> > +    if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
> > +        fprintf(stderr, "The selected ARM CPU does not support 64 bit
> mode\n");
> > +        exit(1);
> > +    }
> > +    for (i =3D 0; i < 31; i++) {
> > +        env->xregs[i] =3D regs->regs[i];
> > +    }
> > +    env->pc =3D regs->pc;
> > +    env->xregs[31] =3D regs->sp;
> > +}
>
>

--000000000000a86cf2061b7ed620
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 17, 2024 at 10:17=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 6/17/24 11:57, Ajeet Singh wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Addded function to initialize ARM CPU<br>
&gt; and to check if it supports 64 bit mode<br>
&gt; <br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/aarch64/target_arch_cpu.h | 42 ++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 42 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 bsd-user/aarch64/target_arch_cpu.h<br>
&gt; <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/tar=
get_arch_cpu.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..db5c7062b9<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/aarch64/target_arch_cpu.h<br>
&gt; @@ -0,0 +1,42 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 ARM AArch64 cpu init and loop<br>
&gt; + *<br>
&gt; + * Copyright (c) 2015 Stacey Son<br>
&gt; + *<br>
&gt; + * This library is free software; you can redistribute it and/or<br>
&gt; + * modify it under the terms of the GNU Lesser General Public<br>
&gt; + * License as published by the Free Software Foundation; either<br>
&gt; + * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + *<br>
&gt; + * This library is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; + * Lesser General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; + * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef TARGET_ARCH_CPU_H<br>
&gt; +#define TARGET_ARCH_CPU_H<br>
&gt; +<br>
&gt; +#include &quot;target_arch.h&quot;<br>
&gt; +#include &quot;target/arm/syndrome.h&quot;<br>
<br>
Do you actually need syndrome.h?<br></blockquote><div><br></div><div>It&#39=
;s needed, but not for this chunk. It is needed for patch 2 because we star=
t to use the syndrome functions there to dispatch / decode the traps.</div>=
<div>So that should be moved to patch 2 in the next round, I think.</div><d=
iv><br></div><div>Also</div><div><br></div><div>Reviewed-by: Warner Losh &l=
t;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></=
div><div>since this looks correct and I didn&#39;t write it :)</div><div><b=
r></div><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
Otherwise,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
<br>
&gt; +<br>
&gt; +#define TARGET_DEFAULT_CPU_MODEL &quot;any&quot;<br>
&gt; +<br>
&gt; +static inline void target_cpu_init(CPUARMState *env,<br>
&gt; +=C2=A0 =C2=A0 struct target_pt_regs *regs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;The selected ARM CP=
U does not support 64 bit mode\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; 31; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;xregs[i] =3D regs-&gt;regs[i];<br=
>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 env-&gt;pc =3D regs-&gt;pc;<br>
&gt; +=C2=A0 =C2=A0 env-&gt;xregs[31] =3D regs-&gt;sp;<br>
&gt; +}<br>
<br>
</blockquote></div></div>

--000000000000a86cf2061b7ed620--

