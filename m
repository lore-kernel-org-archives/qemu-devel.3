Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E279CF2591
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 01:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0AHt-0006El-Qn; Sun, 13 Oct 2024 21:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0AHr-0006EU-JB
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:54:19 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t0AHp-0004KT-E5
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 21:54:19 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so1740534a12.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 18:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1728870855; x=1729475655; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/uobKTfd/+4sGkaXIvlOUn5THPJD3/eOOSk4nFsH6es=;
 b=Yn8w1LuSTvY75UOcIDkiVNAOq+InRijez7bbatAtTRsCQEj9Mx/9vZ+2O8J/K6fZ70
 YaTJlC9276CxgosQN4PZvRxddqAF3XqwUMaKG5nQjZROtPJFHrfn2cdU8hE8qZx0fjFf
 QJuQXS1xFZ87SX5/kTde0BwWfSpOxNRI37cQHfbJIPgabXoP7YHaynyfp2ME/FKuS2fu
 WqbVhXjK5B3/PNaLPGwuuAS3Rat0Fma8ttkDV9qC/o4siUdL4Em7UMUzNEjjOxoEvya9
 x578mOF2AiISgkddMioMvvrTjGsei4BFnDrR4VHnygSuIXxG/uQkwhr/eFTs+ECcEIz0
 42Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728870855; x=1729475655;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uobKTfd/+4sGkaXIvlOUn5THPJD3/eOOSk4nFsH6es=;
 b=va7JkgB8TgA9xT1OkLxmBi+tQn0afQHnjrwmTx5lB4Wsmtka7d3I/iwz8JAVGpbdc6
 c73W/6kcU2nyEC3YqjvWaz2NeXPb+f/D5zRK/ShrdHbLQgdDoW17Z5FRgZHVveBEo1Vp
 V0GJ17zcM1Ma7G2exDRhZiC5zDqTGnRyw/bO1hHQ7wYFDRjchxTDdKTe6Ycmk69vOwLU
 LIxMZm6FmD8wJgDUd2EYso5MnIkzlILqQtWADLIT2CNEybSR3eEiYRvmtm6Utb4/nhjh
 1oSKupOF/TIoahOY4G8Yy3CShqTfIRx8EP0oQHyiQhyNlHc/U8nMpPzti+p+Y0YSOdQA
 gO1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU758zGiXO/iOy1yjdUvl0zrEAaLFLVaZILNqmgJYa9AOYNxg8/YK90+I9U5Qt5tLyMF/nSTxOqEUEC@nongnu.org
X-Gm-Message-State: AOJu0YwKOXvCKTYDowJ5fn0ydvUpbudU3QcAe053fG/ONTgjpaX/M+j+
 Dx2mTvOqCndhe7yp7RPn35HDIGF5vJ1LQ/Y+u92903oRF32Yn5Z56BjpSIwVg5XADRlc/CiZ0aW
 veQuxNyaewdMTRbbpBZF5NknKOmhCpg2JIwtlTwDaqmrLmceNoKA=
X-Google-Smtp-Source: AGHT+IFnHbmHtsX/uX1pGe9tqvf2g3OtcJL8cN8thQszPGHLzMLzXc8uccXvo48c79vlevWAJwA8zTbJilQhaq6hcOU=
X-Received: by 2002:a05:6402:4414:b0:5c9:48e0:66d1 with SMTP id
 4fb4d7f45d1cf-5c948e06798mr8276598a12.35.1728870854881; Sun, 13 Oct 2024
 18:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
 <6e7a184f-3b47-480d-bd56-fef2e89beda6@ventanamicro.com>
In-Reply-To: <6e7a184f-3b47-480d-bd56-fef2e89beda6@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 14 Oct 2024 09:54:03 +0800
Message-ID: <CAE_xrPhW=EcaXVL5AOegRcSHj5jsA+6HL2wVxrmERUreL0wFZg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] target/riscv: Add Smrnmi support.
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Tommy Wu <tommy.wu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 palmer@dabbelt.com, alistair.francis@wdc.com, alistair23@gmail.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, ajones@ventanamicro.com, 
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Content-Type: multipart/alternative; boundary="0000000000002b09cc0624661d13"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=frank.chang@sifive.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002b09cc0624661d13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for the reminder.
I'll take over Tommy's work to send out the v7 patchset later this week.

Regards,
Frank Chang

On Fri, Oct 11, 2024 at 7:38=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

> Hi Tommy,
>
>
> Do you plan to send a new version of this work soon? This series is a
> prerequisite
> of "target/riscv: Add support for Smdbltrp and Ssdbltrp extensions" and w=
e
> need
> this series merged first. We have minor comments from Cl=C3=A9ment and Al=
istair
> so
> hopefully it shouldn't be too much work.
>
> The code freeze for 9.2 will happen in the first/second week of November,
> so if you
> could send a new version to be merged in the next PR that would be great.
>
>
> Thanks,
>
> Daniel
>
>
>
> On 9/2/24 4:13 AM, Tommy Wu wrote:
> > This patchset added support for Smrnmi Extension in RISC-V.
> >
> > There are four new CSRs and one new instruction added to allow NMI to b=
e
> > resumable in RISC-V, which are:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    * mnscratch (0x740)
> >    * mnepc     (0x741)
> >    * mncause   (0x742)
> >    * mnstatus  (0x744)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    * mnret: To return from RNMI interrupt/exception handler.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > RNMI also has higher priority than any other interrupts or exceptions
> > and cannot be disabled by software.
> >
> > RNMI may be used to route to other devices such as Bus Error Unit or
> > Watchdog Timer in the future.
> >
> > The interrupt/exception trap handler addresses of RNMI are
> > implementation defined.
> >
> > If anyone wants to test the patches, we can use the customized
> OpenSBI[1],
> > and the customized QEMU[2].
> >
> > We implemented a PoC RNMI trap handler in the customized OpenSBI.
> > In the customized QEMU, we use the Smrnmi patches and the patch from
> > Damien Hedde[3]. The patch from Damien Hedde can be used to inject
> > the RNMI signal with the qmp command.
> >
> > [1] https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/twu/master
> > [2] https://github.com/TommyWu-fdgkhdkgh/qemu/tree/dev/twu/master
> > [3] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06232.html
> >
> > Test commands :
> > $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,
> > rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized
> > OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic
> > -bios fw_jump.elf -kernel Image -initrd rootfs.cpio
> > -qmp unix:/tmp/qmp-sock,server,wait=3Doff
> >
> > Use qmp command to inject the RNMI interrupt.
> > $ ./scripts/qmp/qmp-shell /tmp/qmp-sock
> > (QEMU)  gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi
> > number=3D0 value=3Dtrue
> >
> > (QEMU)  gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.rnmi
> > number=3D0 value=3Dfalse
> >
> > Changelog:
> >
> > v6
> >    * Delete the redundant code in `riscv_cpu_do_interrupt`.
> >    ( Thank Alvin for the suggestion. )
> >    * Split the shared code in `helper_mret` and `helper_mnret` into a
> >      helper function `check_ret_from_m_mode`.
> >    ( Thank Alistair for the suggestion. )
> >
> > v5
> >    * Move the patch that adds the Smrnmi extension to the last patch.
> >    ( Thank Alistair for the suggestion. )
> >    * Implement an M-mode software PoC for this with implemented handler=
s.
> >    ( Thank Andrew Jones for the suggestion. )
> >    * Add a commit message to all patches of the series.
> >    ( Thank Andrew Jones for the suggestion. )
> >
> > v4
> >    * Fix some coding style issues.
> >    ( Thank Daniel for the suggestions. )
> >
> > v3
> >    * Update to the newest version of Smrnmi extension specification.
> >
> > v2
> >    * split up the series into more commits for convenience of review.
> >    * add missing rnmi_irqvec and rnmi_excpvec properties to riscv_harts=
.
> >
> > Tommy Wu (5):
> >    target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.
> >    target/riscv: Handle Smrnmi interrupt and exception.
> >    target/riscv: Add Smrnmi CSRs.
> >    target/riscv: Add Smrnmi mnret instruction.
> >    target/riscv: Add Smrnmi cpu extension.
> >
> >   hw/riscv/riscv_hart.c                         | 18 ++++
> >   include/hw/riscv/riscv_hart.h                 |  4 +
> >   target/riscv/cpu.c                            | 18 ++++
> >   target/riscv/cpu.h                            | 10 +++
> >   target/riscv/cpu_bits.h                       | 23 ++++++
> >   target/riscv/cpu_cfg.h                        |  1 +
> >   target/riscv/cpu_helper.c                     | 80 ++++++++++++++++--
> >   target/riscv/csr.c                            | 82 ++++++++++++++++++=
+
> >   target/riscv/helper.h                         |  1 +
> >   target/riscv/insn32.decode                    |  3 +
> >   .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++
> >   target/riscv/op_helper.c                      | 49 +++++++++--
> >   12 files changed, 291 insertions(+), 10 deletions(-)
> >
>

--0000000000002b09cc0624661d13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Daniel,<div><br></div><div>Thanks for the reminder.</di=
v><div>I&#39;ll take over Tommy&#39;s work to send out the v7 patchset late=
r this week.</div><div><br></div><div>Regards,</div><div>Frank Chang</div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Fri, Oct 11, 2024 at 7:38=E2=80=AFPM Daniel Henrique Barboza &lt;<a href=
=3D"mailto:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Tommy,<br=
>
<br>
<br>
Do you plan to send a new version of this work soon? This series is a prere=
quisite<br>
of &quot;target/riscv: Add support for Smdbltrp and Ssdbltrp extensions&quo=
t; and we need<br>
this series merged first. We have minor comments from Cl=C3=A9ment and Alis=
tair so<br>
hopefully it shouldn&#39;t be too much work.<br>
<br>
The code freeze for 9.2 will happen in the first/second week of November, s=
o if you<br>
could send a new version to be merged in the next PR that would be great.<b=
r>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
<br>
On 9/2/24 4:13 AM, Tommy Wu wrote:<br>
&gt; This patchset added support for Smrnmi Extension in RISC-V.<br>
&gt; <br>
&gt; There are four new CSRs and one new instruction added to allow NMI to =
be<br>
&gt; resumable in RISC-V, which are:<br>
&gt; <br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 * mnscratch (0x740)<br>
&gt;=C2=A0 =C2=A0 * mnepc=C2=A0 =C2=A0 =C2=A0(0x741)<br>
&gt;=C2=A0 =C2=A0 * mncause=C2=A0 =C2=A0(0x742)<br>
&gt;=C2=A0 =C2=A0 * mnstatus=C2=A0 (0x744)<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;=C2=A0 =C2=A0 * mnret: To return from RNMI interrupt/exception handler.=
<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; <br>
&gt; RNMI also has higher priority than any other interrupts or exceptions<=
br>
&gt; and cannot be disabled by software.<br>
&gt; <br>
&gt; RNMI may be used to route to other devices such as Bus Error Unit or<b=
r>
&gt; Watchdog Timer in the future.<br>
&gt; <br>
&gt; The interrupt/exception trap handler addresses of RNMI are<br>
&gt; implementation defined.<br>
&gt; <br>
&gt; If anyone wants to test the patches, we can use the customized OpenSBI=
[1],<br>
&gt; and the customized QEMU[2].<br>
&gt; <br>
&gt; We implemented a PoC RNMI trap handler in the customized OpenSBI.<br>
&gt; In the customized QEMU, we use the Smrnmi patches and the patch from<b=
r>
&gt; Damien Hedde[3]. The patch from Damien Hedde can be used to inject<br>
&gt; the RNMI signal with the qmp command.<br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/TommyWu-fdgkhdkgh/opensbi/tree/dev/t=
wu/master" rel=3D"noreferrer" target=3D"_blank">https://github.com/TommyWu-=
fdgkhdkgh/opensbi/tree/dev/twu/master</a><br>
&gt; [2] <a href=3D"https://github.com/TommyWu-fdgkhdkgh/qemu/tree/dev/twu/=
master" rel=3D"noreferrer" target=3D"_blank">https://github.com/TommyWu-fdg=
khdkgh/qemu/tree/dev/twu/master</a><br>
&gt; [3] <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-06/m=
sg06232.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/ar=
chive/html/qemu-devel/2019-06/msg06232.html</a><br>
&gt; <br>
&gt; Test commands :<br>
&gt; $ ./build/qemu-system-riscv64 -M virt -cpu rv64,smrnmi=3Dtrue,<br>
&gt; rnmi-interrupt-vector=3D{Offset of the RNMI handler in the customized<=
br>
&gt; OpenSBI.} -m 4G -smp 2 -serial mon:stdio -serial null -nographic<br>
&gt; -bios fw_jump.elf -kernel Image -initrd rootfs.cpio<br>
&gt; -qmp unix:/tmp/qmp-sock,server,wait=3Doff<br>
&gt; <br>
&gt; Use qmp command to inject the RNMI interrupt.<br>
&gt; $ ./scripts/qmp/qmp-shell /tmp/qmp-sock<br>
&gt; (QEMU)=C2=A0 gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.r=
nmi<br>
&gt; number=3D0 value=3Dtrue<br>
&gt; <br>
&gt; (QEMU)=C2=A0 gpio-set path=3D/machine/soc0/harts[0] gpio=3Driscv.cpu.r=
nmi<br>
&gt; number=3D0 value=3Dfalse<br>
&gt; <br>
&gt; Changelog:<br>
&gt; <br>
&gt; v6<br>
&gt;=C2=A0 =C2=A0 * Delete the redundant code in `riscv_cpu_do_interrupt`.<=
br>
&gt;=C2=A0 =C2=A0 ( Thank Alvin for the suggestion. )<br>
&gt;=C2=A0 =C2=A0 * Split the shared code in `helper_mret` and `helper_mnre=
t` into a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 helper function `check_ret_from_m_mode`.<br>
&gt;=C2=A0 =C2=A0 ( Thank Alistair for the suggestion. )<br>
&gt; <br>
&gt; v5<br>
&gt;=C2=A0 =C2=A0 * Move the patch that adds the Smrnmi extension to the la=
st patch.<br>
&gt;=C2=A0 =C2=A0 ( Thank Alistair for the suggestion. )<br>
&gt;=C2=A0 =C2=A0 * Implement an M-mode software PoC for this with implemen=
ted handlers.<br>
&gt;=C2=A0 =C2=A0 ( Thank Andrew Jones for the suggestion. )<br>
&gt;=C2=A0 =C2=A0 * Add a commit message to all patches of the series.<br>
&gt;=C2=A0 =C2=A0 ( Thank Andrew Jones for the suggestion. )<br>
&gt; <br>
&gt; v4<br>
&gt;=C2=A0 =C2=A0 * Fix some coding style issues.<br>
&gt;=C2=A0 =C2=A0 ( Thank Daniel for the suggestions. )<br>
&gt; <br>
&gt; v3<br>
&gt;=C2=A0 =C2=A0 * Update to the newest version of Smrnmi extension specif=
ication.<br>
&gt; <br>
&gt; v2<br>
&gt;=C2=A0 =C2=A0 * split up the series into more commits for convenience o=
f review.<br>
&gt;=C2=A0 =C2=A0 * add missing rnmi_irqvec and rnmi_excpvec properties to =
riscv_harts.<br>
&gt; <br>
&gt; Tommy Wu (5):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add `ext_smrnmi` in the RISCVCPUConfig.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Handle Smrnmi interrupt and exception.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Smrnmi CSRs.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Smrnmi mnret instruction.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Smrnmi cpu extension.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv_hart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++++<br>
&gt;=C2=A0 =C2=A0include/hw/riscv/riscv_hart.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 18 ++++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 +++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 ++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 80 ++++++++++++++++--<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 82 ++++++++++=
+++++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +<br>
&gt;=C2=A0 =C2=A0.../riscv/insn_trans/trans_privileged.c.inc=C2=A0 =C2=A0| =
12 +++<br>
&gt;=C2=A0 =C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 49 +++++++++--<br>
&gt;=C2=A0 =C2=A012 files changed, 291 insertions(+), 10 deletions(-)<br>
&gt; <br>
</blockquote></div>

--0000000000002b09cc0624661d13--

