Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2780ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sneva-0005j1-7b; Mon, 09 Sep 2024 09:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1snevY-0005c3-CZ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:59:36 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1snevV-0001D6-Mk
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:59:36 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so4441863a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725890366; x=1726495166; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h8ac+bWIFz+HvDNIsH/yrOboWEPVeqUnEMPcjug3CjM=;
 b=m4bxXLF8V9l3CwGUgd7tqsnzJctotqSiovRMaWJWMcN8McCwqovpSyrWHXThKutHUM
 BZLGnr8/ZoF/EI6s/SyuXrJszjVXCCxDeH9iJg2uy3+Xm2STDYON/Yl28ODoVH/zKCLp
 1vPXqhXoLPmIqSirhJEVG/NKe9uWEm1g2CLYpEuM6lbozC8HQqrIhT7uWqjUlCvDSoCg
 46fgFetPyBrdf8FzQAntlwhbOLxMb8ksAfv3VvjErQJ0iiNQHV7uuo3nLSQOz/8FlqQ4
 jUsVNUuHNweb+dL+V2Zjy+gs6iqL0FKdpvOr9G/mQFzUIXPwJeB8NorSZB1hqIcdDfYB
 oFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725890366; x=1726495166;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8ac+bWIFz+HvDNIsH/yrOboWEPVeqUnEMPcjug3CjM=;
 b=AIBi84f0xJPmk99R82r5JTZTefO1fz+aydFLfYF9PFYdA5R2YLOHwF+OQtb4O+Bym8
 3yTxlTqObbmAfBtyIkOSchBuR7IO6S17igeP1Wf10NAHdC2Ml5mBX63tViDx7Gs6WI4+
 564D+ly0ulJGcBLOWLnFkZILTS8tGjrQpRNnBDUpO60NYn+/8U9Gh5teAgXEiJmo8Ue8
 NKP2ghm4xks8RrCzbxqAHiKDY0VyXOS/i8CM5GWkaUdyRBiCwVpB53znxU5lX5A6p+lf
 1mxaq5dBV9nsu6JgpUEYItjCRg7ugNcmk9jnljLi9ENO4+/RyNNFsjieu5kdaoy2AvD4
 +tEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxRVRRo9QIOeP9WiumCZog9Oc3J6tWn4nOElKUjfOWYQA4li/Lnk8AbAzzENYBimzoj7kDWjuUM2WL@nongnu.org
X-Gm-Message-State: AOJu0Ywreg0yY17Crj0sFEcCNzPZ21RAZMXiNU7nPDKHFeblDXKU6FKX
 2XYeEHVCe0Oux7GWrB95Ghauz1QSCcZkPVHxUtGc0mKjMjqyB9HkP1ULtPWb1ntq2SehDCICt1C
 VWwPHoi2DklSdbqCmovRUMuS6IAo=
X-Google-Smtp-Source: AGHT+IEXofTvK9wP9OCOpRioy2nquxukCy4+MpmZrk+6q5Ebsufi5BxwH39jJwgbUEhQKRDgrphxRngjJ2Ri7QKABeM=
X-Received: by 2002:a50:cbc3:0:b0:5c2:60ac:fdd8 with SMTP id
 4fb4d7f45d1cf-5c3dc78ec1fmr6350066a12.13.1725890365533; Mon, 09 Sep 2024
 06:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240904143603.52934-1-philmd@linaro.org>
 <c2bfdb7f-52ff-4650-a171-663925194682@linaro.org>
In-Reply-To: <c2bfdb7f-52ff-4650-a171-663925194682@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 9 Sep 2024 07:59:11 -0600
Message-ID: <CAJy5ezo3VH2u-W9iFQNGZ2A8M8CoVtHPq-V_=ShrJa6HGB0ceA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] target/cris: Remove the deprecated CRIS target
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000028bad40621b02ad3"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x531.google.com
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

--00000000000028bad40621b02ad3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:25=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Hi Edgar,
>
> On 4/9/24 16:35, Philippe Mathieu-Daud=C3=A9 wrote:
> > Since v1:
> > - Split in smaller patches (pm215)
> >
> > The CRIS target is deprecated since v9.0 (commit
> > c7bbef40234 "docs: mark CRIS support as deprecated").
> >
> > Remove:
> > - Buildsys / CI infra
> > - User emulation
> > - System emulation (axis-dev88 machine and ETRAX devices)
> > - Tests
>
> You acked the deprecation commit (c7bbef4023).
> No objection for the removal? I'd rather have your
> explicit Acked-by before merging this.
>
>
Hi Phil,

Yes, sorry, I haven't had time to review each patch but:
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Cheers,
Edgar




> Thanks,
>
> Phil.
>
> > Philippe Mathieu-Daud=C3=A9 (15):
> >    tests/tcg: Remove CRIS libc test files
> >    tests/tcg: Remove CRIS bare test files
> >    buildsys: Remove CRIS cross container
> >    linux-user: Remove support for CRIS target
> >    hw/cris: Remove the axis-dev88 machine
> >    hw/cris: Remove image loader helper
> >    hw/intc: Remove TYPE_ETRAX_FS_PIC device
> >    hw/char: Remove TYPE_ETRAX_FS_SERIAL device
> >    hw/net: Remove TYPE_ETRAX_FS_ETH device
> >    hw/dma: Remove ETRAX_FS DMA device
> >    hw/timer: Remove TYPE_ETRAX_FS_TIMER device
> >    system: Remove support for CRIS target
> >    target/cris: Remove the deprecated CRIS target
> >    disas: Remove CRIS disassembler
> >    seccomp: Remove check for CRIS host
>
>

--00000000000028bad40621b02ad3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Sep 9, 2024 at 7:25=E2=80=AFAM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@l=
inaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hi Edgar,<br>
<br>
On 4/9/24 16:35, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Since v1:<br>
&gt; - Split in smaller patches (pm215)<br>
&gt; <br>
&gt; The CRIS target is deprecated since v9.0 (commit<br>
&gt; c7bbef40234 &quot;docs: mark CRIS support as deprecated&quot;).<br>
&gt; <br>
&gt; Remove:<br>
&gt; - Buildsys / CI infra<br>
&gt; - User emulation<br>
&gt; - System emulation (axis-dev88 machine and ETRAX devices)<br>
&gt; - Tests<br>
<br>
You acked the deprecation commit (c7bbef4023).<br>
No objection for the removal? I&#39;d rather have your<br>
explicit Acked-by before merging this.<br>
<br></blockquote><div><br></div><div>Hi Phil,</div><div><br></div><div>Yes,=
 sorry, I haven&#39;t had time to review each patch but:</div><div>Acked-by=
: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.igl=
esias@amd.com</a>&gt;<br></div><div><br></div><div>Cheers,</div><div>Edgar<=
/div><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
Thanks,<br>
<br>
Phil.<br>
<br>
&gt; Philippe Mathieu-Daud=C3=A9 (15):<br>
&gt;=C2=A0 =C2=A0 tests/tcg: Remove CRIS libc test files<br>
&gt;=C2=A0 =C2=A0 tests/tcg: Remove CRIS bare test files<br>
&gt;=C2=A0 =C2=A0 buildsys: Remove CRIS cross container<br>
&gt;=C2=A0 =C2=A0 linux-user: Remove support for CRIS target<br>
&gt;=C2=A0 =C2=A0 hw/cris: Remove the axis-dev88 machine<br>
&gt;=C2=A0 =C2=A0 hw/cris: Remove image loader helper<br>
&gt;=C2=A0 =C2=A0 hw/intc: Remove TYPE_ETRAX_FS_PIC device<br>
&gt;=C2=A0 =C2=A0 hw/char: Remove TYPE_ETRAX_FS_SERIAL device<br>
&gt;=C2=A0 =C2=A0 hw/net: Remove TYPE_ETRAX_FS_ETH device<br>
&gt;=C2=A0 =C2=A0 hw/dma: Remove ETRAX_FS DMA device<br>
&gt;=C2=A0 =C2=A0 hw/timer: Remove TYPE_ETRAX_FS_TIMER device<br>
&gt;=C2=A0 =C2=A0 system: Remove support for CRIS target<br>
&gt;=C2=A0 =C2=A0 target/cris: Remove the deprecated CRIS target<br>
&gt;=C2=A0 =C2=A0 disas: Remove CRIS disassembler<br>
&gt;=C2=A0 =C2=A0 seccomp: Remove check for CRIS host<br>
<br>
</blockquote></div></div>

--00000000000028bad40621b02ad3--

