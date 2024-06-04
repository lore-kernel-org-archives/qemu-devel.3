Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC97C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 22:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEciJ-0008Iw-FC; Tue, 04 Jun 2024 18:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEciH-0008IP-Qe
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 18:33:05 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEciE-0001I9-VA
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 18:33:05 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-627f3265898so63385017b3.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717540381; x=1718145181;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J/8TtoxS9XL4AgUwmPIrDe571d90m3TMCwF9u1Ytdf4=;
 b=0uPPgGDoZaNB6dc+/uTC3fz7eR2lRFTAoxvke4e4yKNnLo0eQfSAU9NwVWUThbO52L
 47XMwOWkOsyfMTla3wr4T2WmptpmyCbIRozwwbENX+OgPAip2meL0MubgnWxQoH007uW
 dMsk3zYD6fbPbfuDdO/c2yoB4xXI5S+3hNDwIesIMlYlEXXKDT3EY3yk6matlCma7lNi
 vmpDFSW8jDTjqyHb7t91UghTeOW0e5xbC9TVEsL8DeJZCemdK5PjFfLcGzVWwMVfMaeb
 Rjg8soCgXdYme7AOftxRB7wdRF9rFXt24Dkl3X1eb57m1pk6YR5m1T7oDSasJDZhdrPm
 iE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717540381; x=1718145181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J/8TtoxS9XL4AgUwmPIrDe571d90m3TMCwF9u1Ytdf4=;
 b=twH5laLKosUNv0sU8i8BBI9Tquf+VKqhqHbHhk9YTm14OBbsyfdM+CFRCOH9eAHLVp
 /Hxv6C8PhaJoIOD0mrG5KdnPRfWo82HMBMBveYcGnK13dhySJYDV2wfGwcTB95inpL/a
 Umpi8b2ap1jmEuH0QrPcS455JczF/fNAF7QZ6LUTeyzmS0Ma05LNtdFxLvHc45lNPsKi
 oG7XvmjcuyRwAx9ZLEJ/W3v+BSX+3goKnHbt+6xLzLn46ogWLhTsKfBp+69iKfW2VQn4
 3QA0MgJPaY2IqYNx5RHdUnLluIU/nOCwOEEyVC5PFgRK8Gi2Yp8uGRZJupD++q8BB/jU
 TINw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7m9pGdKVyirT8wdx/09/GhLYBIl/fmGm7ApFt/+OThPtgcBHwHxZKCYUupBzZk8LUlVcjc2O0Gp0xbVGnH8JwV5x7xgs=
X-Gm-Message-State: AOJu0YygkPgsX8odLvAQCDbQlHfO8X2Cj3dH72LMnLJTImdS+MsNZJ7E
 3ZxvlqbtFsNqHKblQPrbhaIqEPPY/gReoFLqe1+aLSJBKLxYYVPG3+7jh+ApDBkPpj5BRbwaAZL
 evSr+quiA251de9FLwwItghwF96qAz8UtJV/utg==
X-Google-Smtp-Source: AGHT+IHc1cNc2KklmTMdaseZ731OryZ19WKER5keZgoNYiRb32oTNnMOA/eb3hxMXWgrmbLBZki2q0XCVzM7usBibJY=
X-Received: by 2002:a25:f623:0:b0:de5:53cc:eb10 with SMTP id
 3f1490d57ef6-dfacac458dbmr742506276.14.1717540381270; Tue, 04 Jun 2024
 15:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <da896d6b-7b7f-4246-9750-f7bc11e54d3b@sifive.com>
In-Reply-To: <da896d6b-7b7f-4246-9750-f7bc11e54d3b@sifive.com>
From: Beeman Strong <beeman@rivosinc.com>
Date: Tue, 4 Jun 2024 15:32:50 -0700
Message-ID: <CAP55G9B4u8M__rDsEoPR1_U-AQYicU4-KVVCkVwD+pc+RhvhMg@mail.gmail.com>
Subject: Re: [PATCH 0/6] target/riscv: Add support for Control Transfer
 Records Ext.
To: Jason Chien <jason.chien@sifive.com>
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, alistair.francis@wdc.com,
 apatel@ventanamicro.com, 
 atishp@rivosinc.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liweiwei@iscas.ac.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 tech-control-transfer-records@lists.riscv.org, zhiwei_liu@linux.alibaba.com
Content-Type: multipart/alternative; boundary="000000000000504133061a180849"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=beeman@rivosinc.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000504133061a180849
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is no dependency on Smcsrind, only Sscsrind.

On Tue, Jun 4, 2024 at 12:29=E2=80=AFAM Jason Chien <jason.chien@sifive.com=
> wrote:

> Smctr depends on the Smcsrind extension, Ssctr depends on the Sscsrind
> extension, and both Smctr and Ssctr depend upon implementation of S-mode.
> There should be a dependency check in riscv_cpu_validate_set_extensions()=
.
>
> Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=
=81=93:
> > This series enables Control Transfer Records extension support on riscv
> > platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
> > The Extension has been stable and the latest release can be found here
> [0]
> >
> > CTR extension depends on couple of other extensions:
> >
> > 1. S[m|s]csrind : The indirect CSR extension [1] which defines addition=
al
> >     ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation o=
f
> >     RISC-V CSR address space. CTR access ctrsource, ctrtartget and
> ctrdata
> >     CSRs using sscsrind extension.
> >
> > 2. Smstateen: The mstateen bit[54] controls the access to the CTR ext t=
o
> >     S-mode.
> >
> > 3. Sscofpmf: Counter overflow and privilege mode filtering. [2]
> >
> > The series is based on Smcdeleg/Ssccfg counter delegation extension [3]
> > patches. CTR itself doesn't depend on counter delegation support. This
> > rebase is basically to include the Smcsrind patches.
> >
> > Due to the dependency of these extensions, the following extensions mus=
t
> be
> > enabled to use the control transfer records feature.
> >
> >
> "smstateen=3Dtrue,sscofpmf=3Dtrue,smcsrind=3Dtrue,sscsrind=3Dtrue,smctr=
=3Dtrue,ssctr=3Dtrue"
> >
> > Here is the link to a quick guide [5] to setup and run a basic perf dem=
o
> on
> > Linux to use CTR Ext.
> >
> > The Qemu patches can be found here:
> > https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream
> >
> > The opensbi patch can be found here:
> > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream
> >
> > The Linux kernel patches can be found here:
> > https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream
> >
> > [0]:https://github.com/riscv/riscv-control-transfer-records/release
> > [1]:https://github.com/riscv/riscv-indirect-csr-access
> > [2]:https://github.com/riscvarchive/riscv-count-overflow/tree/main
> > [3]:https://github.com/riscv/riscv-smcdeleg-ssccfg
> > [4]:
> https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com/
> > [5]:
> https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QE=
MU-RISC%E2%80%90V-Virt-machine
> >
> > Rajnesh Kanwal (6):
> >    target/riscv: Remove obsolete sfence.vm instruction
> >    target/riscv: Add Control Transfer Records CSR definitions.
> >    target/riscv: Add support for Control Transfer Records extension CSR=
s.
> >    target/riscv: Add support to record CTR entries.
> >    target/riscv: Add CTR sctrclr instruction.
> >    target/riscv: Add support to access ctrsource, ctrtarget, ctrdata
> >      regs.
> >
> >   target/riscv/cpu.c                            |   4 +
> >   target/riscv/cpu.h                            |  14 +
> >   target/riscv/cpu_bits.h                       | 154 +++++++++
> >   target/riscv/cpu_cfg.h                        |   2 +
> >   target/riscv/cpu_helper.c                     | 213 ++++++++++++
> >   target/riscv/csr.c                            | 312 +++++++++++++++++=
-
> >   target/riscv/helper.h                         |   8 +-
> >   target/riscv/insn32.decode                    |   2 +-
> >   .../riscv/insn_trans/trans_privileged.c.inc   |  21 +-
> >   target/riscv/insn_trans/trans_rvi.c.inc       |  27 ++
> >   target/riscv/op_helper.c                      | 117 ++++++-
> >   target/riscv/translate.c                      |   9 +
> >   12 files changed, 870 insertions(+), 13 deletions(-)
> >
>

--000000000000504133061a180849
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">There is no dependency on Smcsrind, only=
 Sscsrind.=C2=A0</div></div><div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 12:29=E2=80=AFAM Jason Ch=
ien &lt;<a href=3D"mailto:jason.chien@sifive.com" target=3D"_blank">jason.c=
hien@sifive.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Smctr depends on the Smcsrind extension, Ssctr depends on th=
e Sscsrind <br>
extension, and both Smctr and Ssctr depend upon implementation of S-mode.<b=
r>
There should be a dependency check in riscv_cpu_validate_set_extensions().<=
br>
<br>
Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=81=
=93:<br>
&gt; This series enables Control Transfer Records extension support on risc=
v<br>
&gt; platform. This extension is similar to Arch LBR in x86 and BRBE in ARM=
.<br>
&gt; The Extension has been stable and the latest release can be found here=
 [0]<br>
&gt;<br>
&gt; CTR extension depends on couple of other extensions:<br>
&gt;<br>
&gt; 1. S[m|s]csrind : The indirect CSR extension [1] which defines additio=
nal<br>
&gt;=C2=A0 =C2=A0 =C2=A0([M|S|VS]IREG2-[M|S|VS]IREG6) register to address s=
ize limitation of<br>
&gt;=C2=A0 =C2=A0 =C2=A0RISC-V CSR address space. CTR access ctrsource, ctr=
tartget and ctrdata<br>
&gt;=C2=A0 =C2=A0 =C2=A0CSRs using sscsrind extension.<br>
&gt;<br>
&gt; 2. Smstateen: The mstateen bit[54] controls the access to the CTR ext =
to<br>
&gt;=C2=A0 =C2=A0 =C2=A0S-mode.<br>
&gt;<br>
&gt; 3. Sscofpmf: Counter overflow and privilege mode filtering. [2]<br>
&gt;<br>
&gt; The series is based on Smcdeleg/Ssccfg counter delegation extension [3=
]<br>
&gt; patches. CTR itself doesn&#39;t depend on counter delegation support. =
This<br>
&gt; rebase is basically to include the Smcsrind patches.<br>
&gt;<br>
&gt; Due to the dependency of these extensions, the following extensions mu=
st be<br>
&gt; enabled to use the control transfer records feature.<br>
&gt;<br>
&gt; &quot;smstateen=3Dtrue,sscofpmf=3Dtrue,smcsrind=3Dtrue,sscsrind=3Dtrue=
,smctr=3Dtrue,ssctr=3Dtrue&quot;<br>
&gt;<br>
&gt; Here is the link to a quick guide [5] to setup and run a basic perf de=
mo on<br>
&gt; Linux to use CTR Ext.<br>
&gt;<br>
&gt; The Qemu patches can be found here:<br>
&gt; <a href=3D"https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream" r=
el=3D"noreferrer" target=3D"_blank">https://github.com/rajnesh-kanwal/qemu/=
tree/ctr_upstream</a><br>
&gt;<br>
&gt; The opensbi patch can be found here:<br>
&gt; <a href=3D"https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/rajnesh-kanwal/op=
ensbi/tree/ctr_upstream</a><br>
&gt;<br>
&gt; The Linux kernel patches can be found here:<br>
&gt; <a href=3D"https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/rajnesh-kanwal/linu=
x/tree/ctr_upstream</a><br>
&gt;<br>
&gt; [0]:<a href=3D"https://github.com/riscv/riscv-control-transfer-records=
/release" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/ris=
cv-control-transfer-records/release</a><br>
&gt; [1]:<a href=3D"https://github.com/riscv/riscv-indirect-csr-access" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/riscv/riscv-indirect-c=
sr-access</a><br>
&gt; [2]:<a href=3D"https://github.com/riscvarchive/riscv-count-overflow/tr=
ee/main" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscvarchi=
ve/riscv-count-overflow/tree/main</a><br>
&gt; [3]:<a href=3D"https://github.com/riscv/riscv-smcdeleg-ssccfg" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/riscv/riscv-smcdeleg-ssccf=
g</a><br>
&gt; [4]:<a href=3D"https://lore.kernel.org/all/20240217000134.3634191-1-at=
ishp@rivosinc.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/all/20240217000134.3634191-1-atishp@rivosinc.com/</a><br>
&gt; [5]:<a href=3D"https://github.com/rajnesh-kanwal/linux/wiki/Running-CT=
R-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-=
demo-on-QEMU-RISC%E2%80%90V-Virt-machine</a><br>
&gt;<br>
&gt; Rajnesh Kanwal (6):<br>
&gt;=C2=A0 =C2=A0 target/riscv: Remove obsolete sfence.vm instruction<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add Control Transfer Records CSR definition=
s.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add support for Control Transfer Records ex=
tension CSRs.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add support to record CTR entries.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add CTR sctrclr instruction.<br>
&gt;=C2=A0 =C2=A0 target/riscv: Add support to access ctrsource, ctrtarget,=
 ctrdata<br>
&gt;=C2=A0 =C2=A0 =C2=A0 regs.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04=
 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br=
>
&gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 154 +++++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 213 ++++++++++++<br>
&gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 312 +++++++++=
++++++++-<br>
&gt;=C2=A0 =C2=A0target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +-<b=
r>
&gt;=C2=A0 =C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0.../riscv/insn_trans/trans_privileged.c.inc=C2=A0 =C2=A0|=
=C2=A0 21 +-<br>
&gt;=C2=A0 =C2=A0target/riscv/insn_trans/trans_rvi.c.inc=C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 27 ++<br>
&gt;=C2=A0 =C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 117 ++++++-<br>
&gt;=C2=A0 =C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A012 files changed, 870 insertions(+), 13 deletions(-)<br>
&gt;<br>
</blockquote></div></div>

--000000000000504133061a180849--

