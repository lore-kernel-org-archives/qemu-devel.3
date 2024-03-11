Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4395CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkpg-0007ON-6U; Mon, 11 Mar 2024 14:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1rjkpZ-00076i-4U
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:57:04 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1rjkpV-0005i9-It
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:57:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56647babfe6so5110865a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710183414; x=1710788214; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0APSuVrlhCEdL75DcSxQTcjROoDKcEIqv9B8wfMiy+o=;
 b=EK8jWGZ+aCYG+24UZdv3SFb72D/Qt0xdqYCli95Kbvq1qeikrrTnxZjJuDUI+OcFFJ
 xwVx+GC7WnObI0UFYMzYiYVDoBWgl1+z1yL+KJJIh6OeUc++FihvFCyO+S1J1XyYbYrv
 wjtqQvgGFDw+88w4+1OKVH5VvSsGaJaIT5106csomU+seI3Epmb0a0bGdjgNU4ZCqYQ2
 WbIn+ArF65NzxP8ME+Aymu8T+FoA/Xd7Y2K5kKnIVs0z9jd4aU8VJDpcFyj6GEM+4gX+
 oFlt8nojcGnKeKzYpLmbaNyCTHwbUiIIXRTU1VmkV/EcE3CqACB6GMRrXIrH5Hnc5txB
 Xi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183414; x=1710788214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0APSuVrlhCEdL75DcSxQTcjROoDKcEIqv9B8wfMiy+o=;
 b=mhoAZytKxWVKPuOcRAxqSJKhjFIvYgccL/J6CeKojw2h9tSKUyqZ10DR3rt7kaH4ba
 s0hybIaOvrh/fXQc5sJKIekiVl5hEYOBW+hhJv2eCXVzFHHErwa5amQhKDn22rFjzUVQ
 oePkjq/6VYQTgJhXKkhd5STseT5vQmErsm/QW8FAUE4Vyq6/lmfuWHqJPU6hwQogGZXV
 8IXv6lda/YXl0SKxK4+zvcJFd91oMqmmDffqeKhS80cAH282/7FXm3jctHCl0nRwlSYc
 XhpyCn095JiN3jLoKA42KoIpodv5orbHqVeDxfWfxNuUzXO6XdQARClFvfRji7SFC58J
 M4hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkho/aX7hqCf6762Xxq2kCF3y57Ddz1d1p29QzQoQ9jkB0x/JtZVsh20wLLzgi7YMeyuo7yX9UZ3gEFJqYtNRy1XvXcfY=
X-Gm-Message-State: AOJu0YznXwpysDrFXkItw/ivilLlJbyqF8/oV2LPDszwHA48ca6m6XEV
 HUG/n+UerGqalZLEKFsysqWSwOrJlFMIvxpwy8OcFJvnxkX1vO59Qs1HEptqEhlbdNKrENlF7iJ
 owEoTCRARsTX5/7fYKf5n/CjPnK+Eic1Yn4Myag==
X-Google-Smtp-Source: AGHT+IHur+eZ0uA5K7EIEQBiOo6NOb+CNFg5Wb2OpB7Rp/TrRnpf2MOKJRnREJk/rZ41X9uSkjlH99chAE+OH9z3Pb4=
X-Received: by 2002:a50:9f25:0:b0:565:7b61:4c82 with SMTP id
 b34-20020a509f25000000b005657b614c82mr5093009edf.5.1710183414057; Mon, 11 Mar
 2024 11:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230810-c9e1f2783168b48bc07a1aa2@orel>
 <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
 <20230810-e160f9edae60ded9d2606b8b@orel>
 <20230811-bc15b48d336b79d9ec1f0936@orel>
 <20230811-52e2c90dc3b91e108eb5e4e8@orel>
 <CAARkPA-P1U7xyLpdx+XD1M3Ji2NUfTb+88+GKUk8R2aFsOCMRw@mail.gmail.com>
 <CAARkPA-dOxOWsR0VS+S8p4fDmNR5X5Jjmo5pQTaurWLYsc9vsw@mail.gmail.com>
 <20240309-ee813e971e7c5850d652b295@orel>
In-Reply-To: <20240309-ee813e971e7c5850d652b295@orel>
From: Richard Bagley <rbagley@ventanamicro.com>
Date: Mon, 11 Mar 2024 11:56:42 -0700
Message-ID: <CAARkPA_8zSZK-4oOTcJO2KinWSadxZYZztwRP-UvNNkDjmyexw@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Content-Type: multipart/alternative; boundary="000000000000e5693e0613671aae"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=rbagley@ventanamicro.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000e5693e0613671aae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have realized that *the patch is indeed a fix*, not a workaround.

In fact, the argument to LUI and AUIPC in assembly *must* be a number
between [0x0, 0xfffff].
RISC-V Assembly Programmer's Manual : Load Upper Immediate's Immediate
<https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md=
#load-upper-immediates-immediate>
Signed decimal numbers are programmed as their two's complement.

I checked: neither GCC nor LLVM will assemble

> lui x1, -4

The LLVM compiled models the arguments to LUI and AUIPC as UIMM (unsigned
immediate) or UIMM20 (20 bit unsigned immediate).

I should have checked this from the start. I jumped to the conclusion that
both formats (signed decimal, two's complement) for negative arguments
should be supported, and that I was encountering a bug.
I apologize to all for the unnecessary back-and-forth.

I don't yet see a reason why llvm and gcc could not support a signed number
in decimal format, perhaps requiring a pseudo-instruction.
This might be desirable, if only in support of assembly programming.
On the other hand, it is easy to make the conversion to a two's-complement
number.

Richard

On Sat, Mar 9, 2024 at 4:01=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:

> On Fri, Mar 08, 2024 at 08:22:01PM -0800, Richard Bagley wrote:
> > post-nack, one further comment:
> >
> > One could argue that this change also aligns QEMU with supporting tools
> (as
> > Andrew observed), and it makes sense to merge this change into QEMU unt=
il
> > those tools update to supporting signed decimal numbers with immediates=
.
> >
> > As it is, both GNU assembler and the LLVM integrated assembler (or
> llvm-mc)
> > throws an error with examples such as
> > auipc s0, -17
> >
> > On the other hand, I have only seen this problem with the output of the
> > COLLECT plug-in, not (as yet) with QEMU execution proper.
> > If the problem is confined to COLLECT, perhaps the argument for alignin=
g
> > with other tools is not as strong.
> >
> > In the meantime, I have adjusted my change locally to include AUIPC, an=
d
> > written a substantive, and I hope, clear commit description.
> > If you would like me to resubmit a patch with this updated change, plea=
se
> > let me know.
>
> Since the patch is ready for posting, then it might as well be posted
> (even if it may not get merged right away). If the issue arises again,
> then we can refer to the latest proposed patch, which will be preserved
> in the mail archives.
>
> Thanks,
> drew
>

--000000000000e5693e0613671aae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"verdana, sans-serif">I have realized that <b=
>the patch is indeed a fix</b>, not a workaround.</font><div><font face=3D"=
verdana, sans-serif"><br>In fact, the argument to LUI and AUIPC in assembly=
=C2=A0<b>must</b>=C2=A0be a number between=C2=A0<span style=3D"color:rgb(31=
,35,40)">[0x0, 0xfffff]</span><span style=3D"color:rgb(31,35,40);font-size:=
16px">.</span><br><a href=3D"https://github.com/riscv-non-isa/riscv-asm-man=
ual/blob/master/riscv-asm.md#load-upper-immediates-immediate">RISC-V Assemb=
ly Programmer&#39;s Manual : Load Upper Immediate&#39;s Immediate</a><br>Si=
gned decimal numbers are programmed as their two&#39;s complement.</font></=
div><div><span style=3D"font-family:verdana,sans-serif"><br></span></div><d=
iv><span style=3D"font-family:verdana,sans-serif">I checked: neither GCC no=
r LLVM will assemble <br></span><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><span style=3D"font-family:verdana,sans-serif">lui x1, -4</span></bl=
ockquote><font face=3D"verdana, sans-serif">The LLVM compiled models the ar=
guments to=C2=A0LUI and AUIPC as UIMM (unsigned immediate) or UIMM20 (20 bi=
t unsigned immediate).<br><br>I should have checked this from the start. I =
jumped to the conclusion that both formats (signed decimal, two&#39;s compl=
ement) for negative arguments should be supported, and that I was encounter=
ing=C2=A0a bug.</font></div><div><font face=3D"verdana, sans-serif">I apolo=
gize to all for the unnecessary back-and-forth.<br><br>I don&#39;t yet see =
a=C2=A0reason why llvm and gcc could not support a signed number in decimal=
 format, perhaps requiring a pseudo-instruction. <br>This might be desirabl=
e, if only in support of assembly programming. <br>On the other hand, it is=
 easy to make the conversion to a two&#39;s-complement number.<br><br>Richa=
rd</font></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sat, Mar 9, 2024 at 4:01=E2=80=AFAM Andrew Jones &lt;<a =
href=3D"mailto:ajones@ventanamicro.com">ajones@ventanamicro.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Mar =
08, 2024 at 08:22:01PM -0800, Richard Bagley wrote:<br>
&gt; post-nack, one further comment:<br>
&gt; <br>
&gt; One could argue that this change also aligns QEMU with supporting tool=
s (as<br>
&gt; Andrew observed), and it makes sense to merge this change into QEMU un=
til<br>
&gt; those tools update to supporting signed decimal numbers with immediate=
s.<br>
&gt; <br>
&gt; As it is, both GNU assembler and the LLVM integrated assembler (or llv=
m-mc)<br>
&gt; throws an error with examples such as<br>
&gt; auipc s0, -17<br>
&gt; <br>
&gt; On the other hand, I have only seen this problem with the output of th=
e<br>
&gt; COLLECT plug-in, not (as yet) with QEMU execution proper.<br>
&gt; If the problem is confined to COLLECT, perhaps the argument for aligni=
ng<br>
&gt; with other tools is not as strong.<br>
&gt; <br>
&gt; In the meantime, I have adjusted my change locally to include AUIPC, a=
nd<br>
&gt; written a substantive, and I hope, clear commit description.<br>
&gt; If you would like me to resubmit a patch with this updated change, ple=
ase<br>
&gt; let me know.<br>
<br>
Since the patch is ready for posting, then it might as well be posted<br>
(even if it may not get merged right away). If the issue arises again,<br>
then we can refer to the latest proposed patch, which will be preserved<br>
in the mail archives.<br>
<br>
Thanks,<br>
drew<br>
</blockquote></div>

--000000000000e5693e0613671aae--

