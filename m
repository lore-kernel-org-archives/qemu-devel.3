Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65064C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUirY-0000u5-V9; Tue, 30 Jan 2024 02:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rUirW-0000th-3j; Tue, 30 Jan 2024 02:48:54 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rUirS-0005Zc-40; Tue, 30 Jan 2024 02:48:53 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-599f5e71d85so2358395eaf.3; 
 Mon, 29 Jan 2024 23:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706600928; x=1707205728; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4H2WlUW2bCuwsVhh4JbHWVMVS6HvXXFg6AYP+U56Vqc=;
 b=C5Xn2Unt9IC8o4xr/p+78gkcbwy0LOHWwWO26LP3bcVJq5v1RC34s+qHswB4FMDN0G
 N366c1tIkEWwJ572S+C8rWr2Jx/wZjS7Md+Qjtqp1bHy2BkHQYk2ClN99bVessH1IbxN
 +fe02NUhniXftVEwTBC88akv5C+6p5M1UWMRPgoxPVQxYgKYsugpoIDHAaxNzJSHi3l4
 bAkGiz577Kf74lxf8RYluAUTbi8gY/4cz4gWu5bRSH31RAmXyqCvIYef5VOjVPP7G+Mv
 ttT3O4MRfUbnu6P+Bulg1vQR3SWN73KxjPTdK2QPiXkUPjRDhpvY651aQOXZoguZ1sgC
 nSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706600928; x=1707205728;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4H2WlUW2bCuwsVhh4JbHWVMVS6HvXXFg6AYP+U56Vqc=;
 b=nN4F5vRFuEq32OJKVHhxy7VLKa4qzV7TKgglnJA+UbMuhqvd7ub93ln8BK74gLkorw
 0o/wVmjzB/DsA0HoRl2i+jMZj/TBkRKQiRY7DoT2FzZZckwJCK3cVcAq2Y0hwi0FszwM
 2kLU23oS9W/RGvLlasmdoWLtyfMQitMF3DJKM0/6M93OkwzHh1ZxkyUkui4eLzriBwlU
 /02R1CZMo5yA4ARA8mcQdvJ5DPqWqQOw1MIgXDoINt1MMk3j3PPpGHqmACAZVoY7A4TN
 L1pnWpzZNc+ysXCxarjS8NvEn5V9n8aCJaDoTpNAhZz1pgmbOET4fVlHdKEpINKnADpf
 NLGQ==
X-Gm-Message-State: AOJu0YyTVeGQ3Hi8nCJwpPWErKIgCNCkUc/WlzdYMH0CKHK/OaZ+xVmU
 1PjAn+ch7wI/1bWXPo8oMj+XQheWeSLonmmx7rpjmQbOq1LCzxZ5BjG7v1eBYv153yp5AEgjS1L
 uIVRKqnqjTtER9L0XrNWL0aapZ8s=
X-Google-Smtp-Source: AGHT+IGz9nzd0cmnegByIHwUQ7ZKuRCKYNUxOS1P5r8v+trh7bJnvn1VCODfkFhIsMrcTAwQXefdeWdbyRa7wSyVf+c=
X-Received: by 2002:a05:6358:5919:b0:178:75cb:18dc with SMTP id
 g25-20020a056358591900b0017875cb18dcmr3220833rwf.10.1706600927406; Mon, 29
 Jan 2024 23:48:47 -0800 (PST)
MIME-Version: 1.0
References: <CA+ji3pGBJBp+trjM-RhgkYjOs8rrtLJgHsaNvf=EyGtWB4gAow@mail.gmail.com>
 <CAFEAcA-L2vepWXfgaHW=ogLAvAZjJd5yv1hm6dBU6dsEOS_gCA@mail.gmail.com>
 <CA+ji3pGVBmDAeUoPM9Zk8pOtpxcR+92XeUBN8G=Mmmyi4Eh8-g@mail.gmail.com>
 <CAFEAcA9AeqbWt1Q5QM_HEwi+A2KYXFs1ZEqfFJcqdktYwWujTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9AeqbWt1Q5QM_HEwi+A2KYXFs1ZEqfFJcqdktYwWujTQ@mail.gmail.com>
From: sanjana gogte <sanj27272@gmail.com>
Date: Tue, 30 Jan 2024 13:18:36 +0530
Message-ID: <CA+ji3pH4ZapKAZ+vCSw6P=svWUtfsWt8aqoTFZX_CV5DzPoOyg@mail.gmail.com>
Subject: Re: Assistance Required for QEMU Hardfault Error with Cortex-M33 on
 MPS2AN505
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000d325f061024fefb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=sanj27272@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 MANY_SPAN_IN_TEXT=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--0000000000000d325f061024fefb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I wanted to express my gratitude for your insightful solution concerning
the INVSTATE fault I was encountering. After recompiling my code with the
-mthumb compiler flag, the exception is no longer being raised, which marks
a significant step forward in my project.

However, I've encountered another challenge while working with a specific
version of QEMU (QEMU emulator version 7.1.0, v2.6.0-55433-g23b643ba16).
While the code runs flawlessly on QEMU version 8.1.50
(v8.1.0-2375-g516fffc993), the earlier version throws a hard fault, which
is critical to my use case.

The use case involves attaching a remote port to the MPS2-AN505, and for
this, I need to utilize Xilinx=E2=80=99s fork of QEMU, which is based on ve=
rsion
7.1.0 (v2.6.0-55433-g23b643ba16). The error I encounter during emulation is
as follows:

Loaded reset SP 0x0 PC 0x0 from vector table
Loaded reset SP 0x10080000 PC 0x10000009 from vector table
Taking exception 3 [Prefetch Abort] on CPU 0
...at fault address 0x10800000
...with CFSR.IBUSERR
...taking pending secure exception 3
...loading from element 3 000000c
...loaded new PC 0x10000011 of secure vector table at 0x1
Taking exception 3 [Prefetch Abort] on CPU 0
...at fault address 0x10800000
...with CFSR.IBUSERR
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

Observations: When I trace it using the GDB:

Remote debugging using: 1234


Reset_Handler () at boot.s:20

20          blx     helper

(gdb) l

15         blx     R0

16

17      .type Reset_Handler, function

18      .global Reset_Handler

19      Reset_Handler:

20          blx     helper

21          bx      lr

22

(gdb) s

Remote connection closed



It goes to prefetch abort as soon as I step into reset handler and the
connection gets closed.
What I do not understand is:

1) Why is my PC going to address 0x10800000?


2) When I use Qemu version 8.1.50 (v8.1.0-2375-g516fffc993), the PC goes to
the right address and does not throw a prefetch abort.


Please give me your insights on how I can fix this.


Some of my code for your reference:


My startup code :

.syntax unified

.thumb


.section .isr_vector

    .long    __StackTop

    .long    Reset_Handler




.text

.type helper,function

.global helper

helper :

   ldr     R0, =3D main

   blx     R0


.type Reset_Handler, function

.global Reset_Handler

Reset_Handler:

    blx     helper

    bx      lr



( Like you mentioned  previously , In the .isr_vector section I tried makin=
g
the other exception handlers  point to branch-to-self instructions but that
gives me the same error )


My linker code :


/* Linker script to configure memory regions. */

MEMORY

{

   NS_CODE (rx)     : ORIGIN =3D 0x00000000, LENGTH =3D 512K

   S_CODE_BOOT (rx) : ORIGIN =3D 0x10000000, LENGTH =3D 512K

   RAM   (rwx) : ORIGIN =3D 0x20000000, LENGTH =3D 512K

}


/* Entry Point */

ENTRY(Reset_Handler)


SECTIONS

{

    .text :

    {

        KEEP(*(.isr_vector))

        *(.text)

        *(.data)

    *(.bss)

    } > S_CODE_BOOT

    /* Set stack top to end of S_CODE_BOOT. */

    __StackTop =3D ORIGIN(S_CODE_BOOT) + LENGTH(S_CODE_BOOT);




}


kernel.list file :


kernel.elf:     file format elf32-littlearm


Disassembly of section .text:

10000000 <helper-0x8>:
10000000: 10080000 .word 0x10080000
10000004: 1000000d .word 0x1000000d

10000008 <helper>:
10000008: 4802       ldr r0, [pc, #8] @ (10000014 <Reset_Handler+0x8>)
1000000a: 4780       blx r0

1000000c <Reset_Handler>:
1000000c: f7ff fffc bl 10000008 <helper>
10000010: 4770       bx lr
10000012: 0000       .short 0x0000
10000014: 10000019 .word 0x10000019

10000018 <main>:
10000018: b480       push {r7}
1000001a: af00       add r7, sp, #0
1000001c: e7fe       b.n 1000001c <main+0x4>






On Thu, 18 Jan 2024 at 15:34, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 18 Jan 2024 at 06:30, sanjana gogte <sanj27272@gmail.com> wrote:
> >
> > Hi,
> > 1) I am using QEMU Version 7.1.0. I am currently using this version wit=
h
> a plan to connect the remote port from Xilinx to the mps2an505 board. The
> decision to use this specific version is heavily influenced by the fact
> that it is the same version utilized by Xilinx's QEMU.
> >
> > 2) Debug Logs :
> > guest_errors:
> >
> > Invalid read at addr 0x10000000, size 4, region '(null)', reason:
> rejected
> > Invalid read at addr 0x10000004, size 4, region '(null)', reason:
> rejected
> > Invalid read at addr 0x10800000, size 2, region '(null)', reason:
> rejected
> > qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1=
)
> >
> > in_asm:
>
> >
> > IN:
> > 0x10000008:
> > OBJD-T: 00480047
>
> Whoever built your QEMU didn't do it with libcapstone-dev
> installed, so the debug logs have only binary dumps of
> instructions, not the actual instructions, which is a pity
> (--enable-capstone will force configure to either find the
> necessary library or else give you an error message.)
>
> Also, I did not mean "do logs of every -d option separately",
> I meant "do a single log, with -d
> in_asm,exec,cpu,int,cpu_reset,unimp,guest_errors,nochain"
> That way you get the different bits of logging in their
> correct sequence relative to each other.
>
> Luckily, this bit is enough to figure out what's going on:
>
> > Loaded reset SP 0x0 PC 0x0 from vector table
> > Loaded reset SP 0x10080000 PC 0x10000008 from vector table
>
> We load the PC from the vector table, but it does not
> have the low bit set, which is not correct. (All entries
> in the vector table must be function pointers in the
> usual Thumb convention, where the lowest bit is set to
> indicate Thumb mode and clear to indicate Arm mode.)
> This means that we will start without the Thumb T bit set...
>
> > Taking exception 18 [v7M INVSTATE UsageFault] on CPU 0
>
> ...which on M-profile means we immediately take a fault trying
> to execute the first instruction...
>
> > ...taking pending secure exception 3
> > ...loading from element 3 of secure vector table at 0x1000000c
> > ...loaded new PC 0x10000011
>
> ...but because your vector table includes no entry for
> the hardfault vector, we instead load a PC value which
> doesn't point anywhere useful...
>
> > Taking exception 3 [Prefetch Abort] on CPU 0
> > ...at fault address 0x10800000
> > ...with CFSR.IBUSERR
> > qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1=
)
>
> ...and eventually we execute off the end of the ROM memory,
> and then take a bus fault on the instruction fetch. This
> is a Lockup because we were already in a HardFault handler
> when we took this fault.
>
> > 3) You said the vector table is too small so I tried something like thi=
s
> from your reference files but it gives me the same error:
> >
> > Boot.s ( Startup file )
> >
> > .thumb
> > .syntax unified
> >
> > .section .isr_vector
> >     .long __StackTop
> >     .long Reset_Handler
> >     .word 0
>
> Zeroes here aren't very helpful because the CPU will try
> to jump to address 0 (and then immediately take another
> fault because the Thumb bit isn't set, which will be
> a Lockup condition again). If you at least make them point to
> branch-to-self instructions it'll be a bit clearer when
> you take an exception you weren't expecting, because in
> the debugger you'll see execution looping at that insn.
>
> >     .word 0
> >     .rept 7
> >     .word 0
> >     .endr
> >     .word 0
> >     .word 0
> >     .word 0
> >     .word 0
> >     .word 0
> >     .rept 32
> >     .word 0
> >     .endr
> >
> >
> > .text
> > .global Reset_Handler
> > Reset_Handler:
> >     ldr     R0, =3D main
> >     bx      R0
>
> But really your problem is here. You haven't told the assembler
> that "Reset_Handler" is a function entry point, and so it treats
> it like a data label. That means that the least significant bit
> is not set when you reference it in the vector table.
>
> Something like this will do what you want:
>         .type Reset_Handler, function
>         .global Reset_Handler
> Reset_Handler:
>
> PS: a hint for later: your code here does not do anything
> to enable the FPU before it jumps into C code. If your
> C compiler is generating code to use the FPU this will
> mean it will take an exception. So either make sure the
> C compiler is configured not to use the FPU, or else enable
> the FPU first.
>
> thanks
> -- PMM
>

--0000000000000d325f061024fefb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"border:0px solid rgb(217,217,227);box-sizing:b=
order-box;margin:1.25em 0px">I wanted to express my gratitude for your insi=
ghtful solution concerning the INVSTATE fault I was encountering. After rec=
ompiling my code with the <code style=3D"border:0px solid rgb(217,217,227);=
box-sizing:border-box;font-size:0.875em;font-weight:600;font-family:&quot;S=
\0000f6hne Mono&quot;,Monaco,&quot;Andale Mono&quot;,&quot;Ubuntu Mono&quot=
;,monospace">-mthumb</code> compiler flag, the exception is no longer being=
 raised, which marks a significant step forward in my project.</p><p style=
=3D"border:0px solid rgb(217,217,227);box-sizing:border-box;margin:1.25em 0=
px">However, I&#39;ve encountered another challenge while working with a sp=
ecific version of QEMU (QEMU emulator version 7.1.0, v2.6.0-55433-g23b643ba=
16). While the code runs flawlessly on QEMU version 8.1.50 (v8.1.0-2375-g51=
6fffc993), the earlier version throws a hard fault, which is critical to my=
 use case.</p><p style=3D"border:0px solid rgb(217,217,227);box-sizing:bord=
er-box;margin:1.25em 0px">The use case involves attaching a remote port to =
the MPS2-AN505, and for this, I need to utilize Xilinx=E2=80=99s fork of QE=
MU, which is based on version 7.1.0 (v2.6.0-55433-g23b643ba16). The error I=
 encounter during emulation is as follows:</p><p style=3D"border:0px solid =
rgb(217,217,227);box-sizing:border-box;margin:1.25em 0px">Loaded reset SP 0=
x0 PC 0x0 from vector table<br>Loaded reset SP 0x10080000 PC 0x10000009 fro=
m vector table<br>Taking exception 3 [Prefetch Abort] on CPU 0<br>...at fau=
lt address 0x10800000<br>...with CFSR.IBUSERR<br>...taking pending secure e=
xception 3<br>...loading from element 3 000000c<br>...loaded new PC 0x10000=
011 of secure vector table at 0x1<br>Taking exception 3 [Prefetch Abort] on=
 CPU 0<br>...at fault address 0x10800000<br>...with CFSR.IBUSERR<br>qemu: f=
atal: Lockup: can&#39;t escalate 3 to HardFault (current priority -1)<br><b=
r>





</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neu=
e&quot;">Observations:<span class=3D"gmail-Apple-converted-space">=C2=A0</s=
pan>When I trace it using the GDB:</p><p class=3D"gmail-p1" style=3D"margin=
:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-varian=
t-alternates:normal;font-kerning:auto;font-feature-settings:normal;font-str=
etch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica N=
eue&quot;">Remote debugging using: 1234</p><p class=3D"gmail-p1" style=3D"m=
argin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-v=
ariant-alternates:normal;font-kerning:auto;font-feature-settings:normal;fon=
t-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvet=
ica Neue&quot;"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fo=
nt-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">Res=
et_Handler () at boot.s:20</p><p class=3D"gmail-p1" style=3D"margin:0px;fon=
t-variant-numeric:normal;font-variant-east-asian:normal;font-variant-altern=
ates:normal;font-kerning:auto;font-feature-settings:normal;font-stretch:nor=
mal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot=
;">20<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>blx <span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 </span>helper</p><p class=3D"gmail-p1" style=3D"margin:0px;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fo=
nt-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">(gd=
b) l</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerni=
ng:auto;font-feature-settings:normal;font-stretch:normal;font-size:13px;lin=
e-height:normal;font-family:&quot;Helvetica Neue&quot;">15 <span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>blx <span cl=
ass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>R0</p><p class=3D"=
gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east=
-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-feature=
-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font=
-family:&quot;Helvetica Neue&quot;">16</p><p class=3D"gmail-p1" style=3D"ma=
rgin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-va=
riant-alternates:normal;font-kerning:auto;font-feature-settings:normal;font=
-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helveti=
ca Neue&quot;">17<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>.type Reset_Handler, function</p><p class=3D"gmail-p1" style=
=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-variant-alternates:normal;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;H=
elvetica Neue&quot;">18<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 </span>.global Reset_Handler</p><p class=3D"gmail-p1" style=
=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-variant-alternates:normal;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;H=
elvetica Neue&quot;">19<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 </span>Reset_Handler:</p><p class=3D"gmail-p1" style=3D"margi=
n:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-varia=
nt-alternates:normal;font-kerning:auto;font-feature-settings:normal;font-st=
retch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica =
Neue&quot;">20<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>blx <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 </span>helper</p><p class=3D"gmail-p1" style=3D"margin:0px;fo=
nt-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alter=
nates:normal;font-kerning:auto;font-feature-settings:normal;font-stretch:no=
rmal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quo=
t;">21<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>bx<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>lr</p><p class=3D"gmail-p1" style=3D"margin:0px;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fo=
nt-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">22<=
/p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:au=
to;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-hei=
ght:normal;font-family:&quot;Helvetica Neue&quot;">(gdb) s</p><p class=3D"g=
mail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-=
asian:normal;font-variant-alternates:normal;font-kerning:auto;font-feature-=
settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-=
family:&quot;Helvetica Neue&quot;">Remote connection closed</p><p class=3D"=
gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east=
-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-feature=
-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font=
-family:&quot;Helvetica Neue&quot;;min-height:15px"><span class=3D"gmail-Ap=
ple-converted-space">=C2=A0</span></p><p class=3D"gmail-p1" style=3D"margin=
:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-varian=
t-alternates:normal;font-kerning:auto;font-feature-settings:normal;font-str=
etch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica N=
eue&quot;">It goes to prefetch abort as soon as I step into reset handler a=
nd the connection gets closed.<span class=3D"gmail-Apple-converted-space">=
=C2=A0 <br></span>What I do not understand is:</p><p class=3D"gmail-p1" sty=
le=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal=
;font-variant-alternates:normal;font-kerning:auto;font-feature-settings:nor=
mal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot=
;Helvetica Neue&quot;">1) Why is my PC going to address 0x10800000?</p><p c=
lass=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;font=
-feature-settings:normal;font-stretch:normal;font-size:13px;line-height:nor=
mal;font-family:&quot;Helvetica Neue&quot;"><br></p><p class=3D"gmail-p1" s=
tyle=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;font-kerning:auto;font-feature-settings:n=
ormal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&qu=
ot;Helvetica Neue&quot;">2) When=C2=A0I use Qemu version 8.1.50 (v8.1.0-237=
5-g516fffc993), the PC goes to the right address and does not throw a prefe=
tch abort.=C2=A0</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-=
numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norma=
l;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font-s=
ize:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;"><br></p=
><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font=
-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto=
;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-heigh=
t:normal;font-family:&quot;Helvetica Neue&quot;">Please give me your insigh=
ts on how I can fix this.</p><p class=3D"gmail-p1" style=3D"margin:0px;font=
-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alterna=
tes:normal;font-kerning:auto;font-feature-settings:normal;font-stretch:norm=
al;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;=
"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helveti=
ca Neue&quot;">Some of my code for your reference:<span class=3D"gmail-Appl=
e-converted-space">=C2=A0</span></p><p class=3D"gmail-p2" style=3D"margin:0=
px;font:13px &quot;Helvetica Neue&quot;;min-height:15px"><br></p><p class=
=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">My =
startup code :<span class=3D"gmail-Apple-converted-space">=C2=A0</span></p>=
<p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&qu=
ot;">.syntax unified</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px=
 &quot;Helvetica Neue&quot;">.thumb</p><p class=3D"gmail-p2" style=3D"margi=
n:0px;font:13px &quot;Helvetica Neue&quot;;min-height:15px"><br></p><p clas=
s=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">.s=
ection .isr_vector<span class=3D"gmail-Apple-converted-space">=C2=A0<span c=
lass=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span></span></p>=
<p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&qu=
ot;"><span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>.long=
<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>__StackTop=
<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Hel=
vetica Neue&quot;"><span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 </span>.long<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 <=
/span>Reset_Handler<span class=3D"gmail-Apple-converted-space">=C2=A0</span=
></p><p class=3D"gmail-p2" style=3D"margin:0px;font:13px &quot;Helvetica Ne=
ue&quot;;min-height:15px"><br></p><p class=3D"gmail-p2" style=3D"margin:0px=
;font:13px &quot;Helvetica Neue&quot;;min-height:15px"><span class=3D"gmail=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0</span></p><p cla=
ss=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">.=
text</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica=
 Neue&quot;">.type helper,function</p><p class=3D"gmail-p1" style=3D"margin=
:0px;font:13px &quot;Helvetica Neue&quot;">.global helper</p><p class=3D"gm=
ail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">helper :<=
/p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue=
&quot;"><span class=3D"gmail-Apple-converted-space">=C2=A0=C2=A0 </span>ldr=
 <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>R0, =3D m=
ain</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica =
Neue&quot;"><span class=3D"gmail-Apple-converted-space">=C2=A0=C2=A0 </span=
>blx <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>R0</p=
><p class=3D"gmail-p2" style=3D"margin:0px;font:13px &quot;Helvetica Neue&q=
uot;;min-height:15px"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;fon=
t:13px &quot;Helvetica Neue&quot;">.type Reset_Handler, function</p><p clas=
s=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">.g=
lobal Reset_Handler</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px =
&quot;Helvetica Neue&quot;">Reset_Handler: <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font=
:13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-converted-spac=
e">=C2=A0 =C2=A0 </span>blx <span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>helper</p><p class=3D"gmail-p1" style=3D"margin:0px;font:=
13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-converted-space=
">=C2=A0 =C2=A0 </span>bx<span class=3D"gmail-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 </span>lr</p><p class=3D"gmail-p2" style=3D"margin:0px;font:=
13px &quot;Helvetica Neue&quot;;min-height:15px"><br></p><p class=3D"gmail-=
p2" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;;min-height:15p=
x"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvet=
ica Neue&quot;">( Like you mentioned=C2=A0 previously , In the .isr_vector =
section I tried making<span class=3D"gmail-Apple-converted-space">=C2=A0 </=
span>the other exception handlers<span class=3D"gmail-Apple-converted-space=
">=C2=A0 </span>point to branch-to-self instructions=C2=A0but that gives me=
 the same error )<span class=3D"gmail-Apple-converted-space">=C2=A0</span><=
/p><p class=3D"gmail-p2" style=3D"margin:0px;font:13px &quot;Helvetica Neue=
&quot;;min-height:15px"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;f=
ont:13px &quot;Helvetica Neue&quot;">My linker code :<span class=3D"gmail-A=
pple-converted-space">=C2=A0</span></p><p class=3D"gmail-p2" style=3D"margi=
n:0px;font:13px &quot;Helvetica Neue&quot;;min-height:15px"><br></p><p clas=
s=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">/*=
 Linker script to configure memory regions. */</p><p class=3D"gmail-p1" sty=
le=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">MEMORY</p><p class=
=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">{</=
p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&=
quot;"><span class=3D"gmail-Apple-converted-space">=C2=A0=C2=A0 </span>NS_C=
ODE (rx) <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>:=
 ORIGIN =3D 0x00000000, LENGTH =3D 512K</p><p class=3D"gmail-p1" style=3D"m=
argin:0px;font:13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-=
converted-space">=C2=A0=C2=A0 </span>S_CODE_BOOT (rx) : ORIGIN =3D 0x100000=
00, LENGTH =3D 512K</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px =
&quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-converted-space">=C2=
=A0=C2=A0 </span>RAM <span class=3D"gmail-Apple-converted-space">=C2=A0 </s=
pan>(rwx) : ORIGIN =3D 0x20000000, LENGTH =3D 512K</p><p class=3D"gmail-p1"=
 style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;">}</p><p class=3D=
"gmail-p2" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;;min-hei=
ght:15px"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot=
;Helvetica Neue&quot;">/* Entry Point */</p><p class=3D"gmail-p1" style=3D"=
margin:0px;font:13px &quot;Helvetica Neue&quot;">ENTRY(Reset_Handler)</p><p=
 class=3D"gmail-p2" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot=
;;min-height:15px"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font:1=
3px &quot;Helvetica Neue&quot;">SECTIONS</p><p class=3D"gmail-p1" style=3D"=
margin:0px;font:13px &quot;Helvetica Neue&quot;">{</p><p class=3D"gmail-p1"=
 style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;"><span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 </span>.text :<span class=3D"gmai=
l-Apple-converted-space">=C2=A0</span></p><p class=3D"gmail-p1" style=3D"ma=
rgin:0px;font:13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 </span>{</p><p class=3D"gmail-p1" style=3D"ma=
rgin:0px;font:13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>KEEP(*(.isr_vector))</p>=
<p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Helvetica Neue&qu=
ot;"><span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>*(.text)</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px =
&quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>*(.data)</p><p class=3D"gmail-p1" style=3D"=
margin:0px;font:13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 <span class=3D"gmail-Apple-tab-span" style=
=3D"white-space:pre">	</span></span>*(.bss)<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0</span></p><p class=3D"gmail-p1" style=3D"margin:0px;font=
:13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-Apple-converted-spac=
e">=C2=A0 =C2=A0 </span>} &gt; S_CODE_BOOT</p><p class=3D"gmail-p1" style=
=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;"><span class=3D"gmail-A=
pple-converted-space">=C2=A0 =C2=A0 </span>/* Set stack top to end of S_COD=
E_BOOT. */</p><p class=3D"gmail-p1" style=3D"margin:0px;font:13px &quot;Hel=
vetica Neue&quot;"><span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 </span>__StackTop =3D ORIGIN(S_CODE_BOOT) + LENGTH(S_CODE_BOOT);</p><p =
class=3D"gmail-p2" style=3D"margin:0px;font:13px &quot;Helvetica Neue&quot;=
;min-height:15px"><span class=3D"gmail-Apple-converted-space">=C2=A0=C2=A0 =
=C2=A0</span></p><p class=3D"gmail-p2" style=3D"margin:0px;font:13px &quot;=
Helvetica Neue&quot;;min-height:15px"><br></p><p class=3D"gmail-p1" style=
=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;f=
ont-variant-alternates:normal;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;H=
elvetica Neue&quot;">





























































</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:a=
uto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-he=
ight:normal;font-family:&quot;Helvetica Neue&quot;">}</p><p class=3D"gmail-=
p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian=
:normal;font-variant-alternates:normal;font-kerning:auto;font-feature-setti=
ngs:normal;font-stretch:normal;font-size:13px;line-height:normal;font-famil=
y:&quot;Helvetica Neue&quot;"><br></p><p class=3D"gmail-p1" style=3D"margin=
:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-varian=
t-alternates:normal;font-kerning:auto;font-feature-settings:normal;font-str=
etch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica N=
eue&quot;">kernel.list file :</p><p class=3D"gmail-p1" style=3D"margin:0px;=
font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alt=
ernates:normal;font-kerning:auto;font-feature-settings:normal;font-stretch:=
normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&q=
uot;"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;font=
-kerning:auto;font-feature-settings:normal;font-stretch:normal;font-size:13=
px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">kernel.elf: =
=C2=A0 =C2=A0 file format elf32-littlearm<br><br><br>Disassembly of section=
 .text:<br><br>10000000 &lt;helper-0x8&gt;:<br>10000000:	10080000 	.word	0x=
10080000<br>10000004:	1000000d 	.word	0x1000000d<br><br>10000008 &lt;helper=
&gt;:<br>10000008:	4802 =C2=A0 =C2=A0 =C2=A0	ldr	r0, [pc, #8]	@ (10000014 &=
lt;Reset_Handler+0x8&gt;)<br>1000000a:	4780 =C2=A0 =C2=A0 =C2=A0	blx	r0<br>=
<br>1000000c &lt;Reset_Handler&gt;:<br>1000000c:	f7ff fffc 	bl	10000008 &lt=
;helper&gt;<br>10000010:	4770 =C2=A0 =C2=A0 =C2=A0	bx	lr<br>10000012:	0000 =
=C2=A0 =C2=A0 =C2=A0	.short	0x0000<br>10000014:	10000019 	.word	0x10000019<=
br><br>10000018 &lt;main&gt;:<br>10000018:	b480 =C2=A0 =C2=A0 =C2=A0	push	{=
r7}<br>1000001a:	af00 =C2=A0 =C2=A0 =C2=A0	add	r7, sp, #0<br>1000001c:	e7fe=
 =C2=A0 =C2=A0 =C2=A0	b.n	1000001c &lt;main+0x4&gt;<br></p><p class=3D"gmai=
l-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-variant-alternates:normal;font-kerning:auto;font-feature-set=
tings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-fam=
ily:&quot;Helvetica Neue&quot;"><br></p><p class=3D"gmail-p1" style=3D"marg=
in:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-vari=
ant-alternates:normal;font-kerning:auto;font-feature-settings:normal;font-s=
tretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica=
 Neue&quot;"><br></p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font-=
size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;"><br></=
p><pre style=3D"border:0px solid rgb(217,217,227);box-sizing:border-box;fon=
t-size:0.875em;margin-top:0px;margin-bottom:0px;background-color:transparen=
t;border-radius:0.375rem;color:currentcolor;line-height:1.71429;overflow-x:=
auto;padding:0px;font-family:&quot;S\0000f6hne Mono&quot;,Monaco,&quot;Anda=
le Mono&quot;,&quot;Ubuntu Mono&quot;,monospace"><div class=3D"gmail-dark g=
mail-bg-black gmail-rounded-md" style=3D"border:0px solid rgb(217,217,227);=
box-sizing:border-box;border-radius:0.375rem"><div class=3D"gmail-flex gmai=
l-items-center gmail-relative gmail-text-token-text-secondary gmail-bg-toke=
n-surface-primary gmail-px-4 gmail-py-2 gmail-text-xs gmail-font-sans gmail=
-justify-between gmail-rounded-t-md" style=3D"border:0px solid rgb(217,217,=
227);box-sizing:border-box;display:flex;border-top-left-radius:0.375rem;bor=
der-top-right-radius:0.375rem;padding:0.5rem 1rem;font-family:S=C3=B6hne,ui=
-sans-serif,system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cant=
arell,&quot;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&qu=
ot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol=
&quot;,&quot;Noto Color Emoji&quot;;font-size:0.75rem;line-height:1rem"><sp=
an class=3D"gmail-" style=3D"border:0px solid rgb(217,217,227);box-sizing:b=
order-box;color:rgb(197,197,210)"><br class=3D"gmail-Apple-interchange-newl=
ine"></span></div></div></pre></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, 18 Jan 2024 at 15:34, Peter Maydell &=
lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On T=
hu, 18 Jan 2024 at 06:30, sanjana gogte &lt;<a href=3D"mailto:sanj27272@gma=
il.com" target=3D"_blank">sanj27272@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt; 1) I am using QEMU Version 7.1.0. I am currently using this version wi=
th a plan to connect the remote port from Xilinx to the mps2an505 board. Th=
e decision to use this specific version is heavily influenced by the fact t=
hat it is the same version utilized by Xilinx&#39;s QEMU.<br>
&gt;<br>
&gt; 2) Debug Logs :<br>
&gt; guest_errors:<br>
&gt;<br>
&gt; Invalid read at addr 0x10000000, size 4, region &#39;(null)&#39;, reas=
on: rejected<br>
&gt; Invalid read at addr 0x10000004, size 4, region &#39;(null)&#39;, reas=
on: rejected<br>
&gt; Invalid read at addr 0x10800000, size 2, region &#39;(null)&#39;, reas=
on: rejected<br>
&gt; qemu: fatal: Lockup: can&#39;t escalate 3 to HardFault (current priori=
ty -1)<br>
&gt;<br>
&gt; in_asm:<br>
<br>
&gt;<br>
&gt; IN:<br>
&gt; 0x10000008:<br>
&gt; OBJD-T: 00480047<br>
<br>
Whoever built your QEMU didn&#39;t do it with libcapstone-dev<br>
installed, so the debug logs have only binary dumps of<br>
instructions, not the actual instructions, which is a pity<br>
(--enable-capstone will force configure to either find the<br>
necessary library or else give you an error message.)<br>
<br>
Also, I did not mean &quot;do logs of every -d option separately&quot;,<br>
I meant &quot;do a single log, with -d<br>
in_asm,exec,cpu,int,cpu_reset,unimp,guest_errors,nochain&quot;<br>
That way you get the different bits of logging in their<br>
correct sequence relative to each other.<br>
<br>
Luckily, this bit is enough to figure out what&#39;s going on:<br>
<br>
&gt; Loaded reset SP 0x0 PC 0x0 from vector table<br>
&gt; Loaded reset SP 0x10080000 PC 0x10000008 from vector table<br>
<br>
We load the PC from the vector table, but it does not<br>
have the low bit set, which is not correct. (All entries<br>
in the vector table must be function pointers in the<br>
usual Thumb convention, where the lowest bit is set to<br>
indicate Thumb mode and clear to indicate Arm mode.)<br>
This means that we will start without the Thumb T bit set...<br>
<br>
&gt; Taking exception 18 [v7M INVSTATE UsageFault] on CPU 0<br>
<br>
...which on M-profile means we immediately take a fault trying<br>
to execute the first instruction...<br>
<br>
&gt; ...taking pending secure exception 3<br>
&gt; ...loading from element 3 of secure vector table at 0x1000000c<br>
&gt; ...loaded new PC 0x10000011<br>
<br>
...but because your vector table includes no entry for<br>
the hardfault vector, we instead load a PC value which<br>
doesn&#39;t point anywhere useful...<br>
<br>
&gt; Taking exception 3 [Prefetch Abort] on CPU 0<br>
&gt; ...at fault address 0x10800000<br>
&gt; ...with CFSR.IBUSERR<br>
&gt; qemu: fatal: Lockup: can&#39;t escalate 3 to HardFault (current priori=
ty -1)<br>
<br>
...and eventually we execute off the end of the ROM memory,<br>
and then take a bus fault on the instruction fetch. This<br>
is a Lockup because we were already in a HardFault handler<br>
when we took this fault.<br>
<br>
&gt; 3) You said the vector table is too small so I tried something like th=
is from your reference files but it gives me the same error:<br>
&gt;<br>
&gt; Boot.s ( Startup file )<br>
&gt;<br>
&gt; .thumb<br>
&gt; .syntax unified<br>
&gt;<br>
&gt; .section .isr_vector<br>
&gt;=C2=A0 =C2=A0 =C2=A0.long __StackTop<br>
&gt;=C2=A0 =C2=A0 =C2=A0.long Reset_Handler<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
<br>
Zeroes here aren&#39;t very helpful because the CPU will try<br>
to jump to address 0 (and then immediately take another<br>
fault because the Thumb bit isn&#39;t set, which will be<br>
a Lockup condition again). If you at least make them point to<br>
branch-to-self instructions it&#39;ll be a bit clearer when<br>
you take an exception you weren&#39;t expecting, because in<br>
the debugger you&#39;ll see execution looping at that insn.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.rept 7<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.endr<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.rept 32<br>
&gt;=C2=A0 =C2=A0 =C2=A0.word 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0.endr<br>
&gt;<br>
&gt;<br>
&gt; .text<br>
&gt; .global Reset_Handler<br>
&gt; Reset_Handler:<br>
&gt;=C2=A0 =C2=A0 =C2=A0ldr=C2=A0 =C2=A0 =C2=A0R0, =3D main<br>
&gt;=C2=A0 =C2=A0 =C2=A0bx=C2=A0 =C2=A0 =C2=A0 R0<br>
<br>
But really your problem is here. You haven&#39;t told the assembler<br>
that &quot;Reset_Handler&quot; is a function entry point, and so it treats<=
br>
it like a data label. That means that the least significant bit<br>
is not set when you reference it in the vector table.<br>
<br>
Something like this will do what you want:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type Reset_Handler, function<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .global Reset_Handler<br>
Reset_Handler:<br>
<br>
PS: a hint for later: your code here does not do anything<br>
to enable the FPU before it jumps into C code. If your<br>
C compiler is generating code to use the FPU this will<br>
mean it will take an exception. So either make sure the<br>
C compiler is configured not to use the FPU, or else enable<br>
the FPU first.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--0000000000000d325f061024fefb--

