Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054B6C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 18:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFHyH-0000bc-HZ; Thu, 06 Jun 2024 14:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sFHyG-0000XU-5L
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 14:36:20 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sFHyD-0005Zi-Hq
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 14:36:19 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-62a08b250a2so13076807b3.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717698975; x=1718303775;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CdFYevwu3eH6Ba5axRf00KACn9Tb+LgJPzyHN4EWRMQ=;
 b=EsFJv8pDn55TJ+pW+MC5I93Btn9hOr0iizzmhCJlwKtcMDWl/B3osMBCANoQxYEazQ
 QhXB6g+xafcB8rcHb7ILqEEvkAXqCZZ/aC639/mOgI2DjiKkZmRcpJ02bXvEwpVllmk2
 kPbSgan5lU+Ppy12F3cgyAVee7jeCUZZbkO2+7++GDNfroJjgQsRvK/A9FKd/rQ2LjxU
 e5q1G3uBIhqP9PTA/uUyNVogOGT2QtyrjGU52M10ZWSGzxmelk2HMkQ7ZmI5wCNCwkuY
 5bmPg5XX4PE6Kmv1VxFUXQlpM2E+sbUJn5mf32tdmHF2AVCkZEJKmh8gtmIWHW4w9fZ8
 P66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717698975; x=1718303775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CdFYevwu3eH6Ba5axRf00KACn9Tb+LgJPzyHN4EWRMQ=;
 b=D3tAkgnvWOCGNfH+P0vMETbcXQSBf3DfJl8Fi7rlry/5cO60+qs0HtBUCM3hjQJG8R
 KOCNKnvU/+RVCXpImkxcjvdtpdWhsncs3rbe62a8QHjpT4q+afHVAFX2hbwL+pRwJyDt
 7Ay/vSts44kcvQE74A3uAOEF5UfpGaUb3yBXGpgFX4xinXiSBAOa8A8nULQuvfcTiWrc
 AsXZmh+DveggyAx9XpYiPVCUCvpEOVXKxRU5t+qD/v4ZS9vh/Jmb4dKFwnRg9MFPlTXR
 hb8QSteVFZfA8qIK/PMEWhO5JG8Tr962ax+wxZKuPvmPzVZ4KeR/xLEqADjGzh4GUn7Z
 07fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmdw9UeEqDGDnW3ZsGeLmIUVZ6H9IW6TxOFrs4ZHQfdgFIxgWg7yxI+E3GBJwK4Ej701YSFRjmg52PF+8DnbT3IjG8tbw=
X-Gm-Message-State: AOJu0YzbENsMeKZ+1vwqNUrnNPb+ENaAYdoa91ha1RA0Y9dUnrddtQyo
 NfmgBcXI1APYfUuQZSARaVAz9WB0Yr8OqeqWfX0LZpkuLv+u5rTVTh3IFIkCSHoRAyaMYivPY7L
 34t2NeXj++6qyO3GPjpiW/suSJ5muo7oN8MYuHQ==
X-Google-Smtp-Source: AGHT+IGUIbrT60Dzey0g+BTCrrx3yagGiU5IYD2k63/3MfMyITNo4pY9wKZn56EzyRI78PpXxoABDHAs19GE1lu3FfE=
X-Received: by 2002:a81:a9c3:0:b0:627:db26:7a2f with SMTP id
 00721157ae682-62cd5570e41mr1945867b3.2.1717698975287; Thu, 06 Jun 2024
 11:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <da896d6b-7b7f-4246-9750-f7bc11e54d3b@sifive.com>
 <CAP55G9B4u8M__rDsEoPR1_U-AQYicU4-KVVCkVwD+pc+RhvhMg@mail.gmail.com>
 <d294f246-c31f-4329-979a-ceef0d8e7bea@sifive.com>
 <CAP55G9BQLKLjqrvpiZc+hXH4urRehWDGp4zVL0gG1okNLYeWDw@mail.gmail.com>
In-Reply-To: <CAP55G9BQLKLjqrvpiZc+hXH4urRehWDGp4zVL0gG1okNLYeWDw@mail.gmail.com>
From: Beeman Strong <beeman@rivosinc.com>
Date: Thu, 6 Jun 2024 11:36:03 -0700
Message-ID: <CAP55G9DZJjA4qQMwyO-dsB9Dx98KvUwMX3unO7K4ak6rpESYTQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] target/riscv: Add support for Control Transfer
 Records Ext.
To: Jason Chien <jason.chien@sifive.com>
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, alistair.francis@wdc.com,
 apatel@ventanamicro.com, 
 atishp@rivosinc.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liweiwei@iscas.ac.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 tech-control-transfer-records@lists.riscv.org, zhiwei_liu@linux.alibaba.com
Content-Type: multipart/alternative; boundary="00000000000040e7da061a3cf5f1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=beeman@rivosinc.com; helo=mail-yw1-x112d.google.com
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

--00000000000040e7da061a3cf5f1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PR for the spec fix, in case anyone is interested.  Found a couple of other
references to Smcsrind that I also removed.

https://github.com/riscv/riscv-control-transfer-records/pull/29


On Tue, Jun 4, 2024 at 8:41=E2=80=AFPM Beeman Strong <beeman@rivosinc.com> =
wrote:

> Ah, good catch.  We removed that dependency late.  I'll fix it.
>
> On Tue, Jun 4, 2024 at 8:34=E2=80=AFPM Jason Chien <jason.chien@sifive.co=
m> wrote:
>
>> Thank you for pointing that out. CTR does not use miselect and mireg*.
>> There is no dependency on Smcsrind. I believe the spec needs to be
>> corrected.
>>
>> Chapter 1 states that:
>> Smctr depends on the Smcsrind extension, while Ssctr depends on the
>> Sscsrind extension. Further, both Smctr and Ssctr depend upon
>> implementation of S-mode.
>> Beeman Strong =E6=96=BC 2024/6/5 =E4=B8=8A=E5=8D=88 06:32 =E5=AF=AB=E9=
=81=93:
>>
>> There is no dependency on Smcsrind, only Sscsrind.
>>
>> On Tue, Jun 4, 2024 at 12:29=E2=80=AFAM Jason Chien <jason.chien@sifive.=
com>
>> wrote:
>>
>>> Smctr depends on the Smcsrind extension, Ssctr depends on the Sscsrind
>>> extension, and both Smctr and Ssctr depend upon implementation of S-mod=
e.
>>> There should be a dependency check in
>>> riscv_cpu_validate_set_extensions().
>>>
>>> Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=
=E9=81=93:
>>> > This series enables Control Transfer Records extension support on ris=
cv
>>> > platform. This extension is similar to Arch LBR in x86 and BRBE in AR=
M.
>>> > The Extension has been stable and the latest release can be found her=
e
>>> [0]
>>> >
>>> > CTR extension depends on couple of other extensions:
>>> >
>>> > 1. S[m|s]csrind : The indirect CSR extension [1] which defines
>>> additional
>>> >     ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation
>>> of
>>> >     RISC-V CSR address space. CTR access ctrsource, ctrtartget and
>>> ctrdata
>>> >     CSRs using sscsrind extension.
>>> >
>>> > 2. Smstateen: The mstateen bit[54] controls the access to the CTR ext
>>> to
>>> >     S-mode.
>>> >
>>> > 3. Sscofpmf: Counter overflow and privilege mode filtering. [2]
>>> >
>>> > The series is based on Smcdeleg/Ssccfg counter delegation extension [=
3]
>>> > patches. CTR itself doesn't depend on counter delegation support. Thi=
s
>>> > rebase is basically to include the Smcsrind patches.
>>> >
>>> > Due to the dependency of these extensions, the following extensions
>>> must be
>>> > enabled to use the control transfer records feature.
>>> >
>>> >
>>> "smstateen=3Dtrue,sscofpmf=3Dtrue,smcsrind=3Dtrue,sscsrind=3Dtrue,smctr=
=3Dtrue,ssctr=3Dtrue"
>>> >
>>> > Here is the link to a quick guide [5] to setup and run a basic perf
>>> demo on
>>> > Linux to use CTR Ext.
>>> >
>>> > The Qemu patches can be found here:
>>> > https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream
>>> >
>>> > The opensbi patch can be found here:
>>> > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream
>>> >
>>> > The Linux kernel patches can be found here:
>>> > https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream
>>> >
>>> > [0]:https://github.com/riscv/riscv-control-transfer-records/release
>>> > [1]:https://github.com/riscv/riscv-indirect-csr-access
>>> > [2]:https://github.com/riscvarchive/riscv-count-overflow/tree/main
>>> > [3]:https://github.com/riscv/riscv-smcdeleg-ssccfg
>>> > [4]:
>>> https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.co=
m/
>>> > [5]:
>>> https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-=
QEMU-RISC%E2%80%90V-Virt-machine
>>> >
>>> > Rajnesh Kanwal (6):
>>> >    target/riscv: Remove obsolete sfence.vm instruction
>>> >    target/riscv: Add Control Transfer Records CSR definitions.
>>> >    target/riscv: Add support for Control Transfer Records extension
>>> CSRs.
>>> >    target/riscv: Add support to record CTR entries.
>>> >    target/riscv: Add CTR sctrclr instruction.
>>> >    target/riscv: Add support to access ctrsource, ctrtarget, ctrdata
>>> >      regs.
>>> >
>>> >   target/riscv/cpu.c                            |   4 +
>>> >   target/riscv/cpu.h                            |  14 +
>>> >   target/riscv/cpu_bits.h                       | 154 +++++++++
>>> >   target/riscv/cpu_cfg.h                        |   2 +
>>> >   target/riscv/cpu_helper.c                     | 213 ++++++++++++
>>> >   target/riscv/csr.c                            | 312
>>> +++++++++++++++++-
>>> >   target/riscv/helper.h                         |   8 +-
>>> >   target/riscv/insn32.decode                    |   2 +-
>>> >   .../riscv/insn_trans/trans_privileged.c.inc   |  21 +-
>>> >   target/riscv/insn_trans/trans_rvi.c.inc       |  27 ++
>>> >   target/riscv/op_helper.c                      | 117 ++++++-
>>> >   target/riscv/translate.c                      |   9 +
>>> >   12 files changed, 870 insertions(+), 13 deletions(-)
>>> >
>>>
>>

--00000000000040e7da061a3cf5f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">PR for the spec fix, in case anyone is interested.=C2=A0 F=
ound a couple of other references to Smcsrind that I also removed.<div><br>=
</div><div><a href=3D"https://github.com/riscv/riscv-control-transfer-recor=
ds/pull/29">https://github.com/riscv/riscv-control-transfer-records/pull/29=
</a><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 8:41=E2=80=AFPM Beeman=
 Strong &lt;<a href=3D"mailto:beeman@rivosinc.com">beeman@rivosinc.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"ltr">Ah, good catch.=C2=A0 We removed that dependency late.=C2=A0 I&=
#39;ll fix it.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Jun 4, 2024 at 8:34=E2=80=AFPM Jason Chien &lt;<a h=
ref=3D"mailto:jason.chien@sifive.com" target=3D"_blank">jason.chien@sifive.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><u></u>

 =20
   =20
 =20
  <div>
    <p>Thank you for pointing that out. CTR does not use miselect and
      mireg*. There is no dependency on Smcsrind. I believe the spec
      needs to be corrected.<br>
    </p>
    <p>Chapter 1 states that:<br>
      Smctr depends on the Smcsrind extension, while Ssctr depends on
      the Sscsrind extension. Further, both Smctr and Ssctr depend upon
      implementation of S-mode.<br>
    </p>
    <div>Beeman Strong =E6=96=BC 2024/6/5 =E4=B8=8A=E5=8D=88 06:32 =E5=AF=
=AB=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div dir=3D"auto">There is no dependency on Smcsrind, only
          Sscsrind.=C2=A0</div>
      </div>
      <div><br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at
            12:29=E2=80=AFAM Jason Chien &lt;<a href=3D"mailto:jason.chien@=
sifive.com" target=3D"_blank">jason.chien@sifive.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Smctr
            depends on the Smcsrind extension, Ssctr depends on the
            Sscsrind <br>
            extension, and both Smctr and Ssctr depend upon
            implementation of S-mode.<br>
            There should be a dependency check in
            riscv_cpu_validate_set_extensions().<br>
            <br>
            Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=
=AF=AB=E9=81=93:<br>
            &gt; This series enables Control Transfer Records extension
            support on riscv<br>
            &gt; platform. This extension is similar to Arch LBR in x86
            and BRBE in ARM.<br>
            &gt; The Extension has been stable and the latest release
            can be found here [0]<br>
            &gt;<br>
            &gt; CTR extension depends on couple of other extensions:<br>
            &gt;<br>
            &gt; 1. S[m|s]csrind : The indirect CSR extension [1] which
            defines additional<br>
            &gt;=C2=A0 =C2=A0 =C2=A0([M|S|VS]IREG2-[M|S|VS]IREG6) register =
to address
            size limitation of<br>
            &gt;=C2=A0 =C2=A0 =C2=A0RISC-V CSR address space. CTR access ct=
rsource,
            ctrtartget and ctrdata<br>
            &gt;=C2=A0 =C2=A0 =C2=A0CSRs using sscsrind extension.<br>
            &gt;<br>
            &gt; 2. Smstateen: The mstateen bit[54] controls the access
            to the CTR ext to<br>
            &gt;=C2=A0 =C2=A0 =C2=A0S-mode.<br>
            &gt;<br>
            &gt; 3. Sscofpmf: Counter overflow and privilege mode
            filtering. [2]<br>
            &gt;<br>
            &gt; The series is based on Smcdeleg/Ssccfg counter
            delegation extension [3]<br>
            &gt; patches. CTR itself doesn&#39;t depend on counter
            delegation support. This<br>
            &gt; rebase is basically to include the Smcsrind patches.<br>
            &gt;<br>
            &gt; Due to the dependency of these extensions, the
            following extensions must be<br>
            &gt; enabled to use the control transfer records feature.<br>
            &gt;<br>
            &gt;
&quot;smstateen=3Dtrue,sscofpmf=3Dtrue,smcsrind=3Dtrue,sscsrind=3Dtrue,smct=
r=3Dtrue,ssctr=3Dtrue&quot;<br>
            &gt;<br>
            &gt; Here is the link to a quick guide [5] to setup and run
            a basic perf demo on<br>
            &gt; Linux to use CTR Ext.<br>
            &gt;<br>
            &gt; The Qemu patches can be found here:<br>
            &gt; <a href=3D"https://github.com/rajnesh-kanwal/qemu/tree/ctr=
_upstream" rel=3D"noreferrer" target=3D"_blank">https://github.com/rajnesh-=
kanwal/qemu/tree/ctr_upstream</a><br>
            &gt;<br>
            &gt; The opensbi patch can be found here:<br>
            &gt; <a href=3D"https://github.com/rajnesh-kanwal/opensbi/tree/=
ctr_upstream" rel=3D"noreferrer" target=3D"_blank">https://github.com/rajne=
sh-kanwal/opensbi/tree/ctr_upstream</a><br>
            &gt;<br>
            &gt; The Linux kernel patches can be found here:<br>
            &gt; <a href=3D"https://github.com/rajnesh-kanwal/linux/tree/ct=
r_upstream" rel=3D"noreferrer" target=3D"_blank">https://github.com/rajnesh=
-kanwal/linux/tree/ctr_upstream</a><br>
            &gt;<br>
            &gt; [0]:<a href=3D"https://github.com/riscv/riscv-control-tran=
sfer-records/release" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/riscv/riscv-control-transfer-records/release</a><br>
            &gt; [1]:<a href=3D"https://github.com/riscv/riscv-indirect-csr=
-access" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/risc=
v-indirect-csr-access</a><br>
            &gt; [2]:<a href=3D"https://github.com/riscvarchive/riscv-count=
-overflow/tree/main" rel=3D"noreferrer" target=3D"_blank">https://github.co=
m/riscvarchive/riscv-count-overflow/tree/main</a><br>
            &gt; [3]:<a href=3D"https://github.com/riscv/riscv-smcdeleg-ssc=
cfg" rel=3D"noreferrer" target=3D"_blank">https://github.com/riscv/riscv-sm=
cdeleg-ssccfg</a><br>
            &gt; [4]:<a href=3D"https://lore.kernel.org/all/20240217000134.=
3634191-1-atishp@rivosinc.com/" rel=3D"noreferrer" target=3D"_blank">https:=
//lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com/</a><br>
            &gt; [5]:<a href=3D"https://github.com/rajnesh-kanwal/linux/wik=
i/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine" rel=3D"norefe=
rrer" target=3D"_blank">https://github.com/rajnesh-kanwal/linux/wiki/Runnin=
g-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine</a><br>
            &gt;<br>
            &gt; Rajnesh Kanwal (6):<br>
            &gt;=C2=A0 =C2=A0 target/riscv: Remove obsolete sfence.vm instr=
uction<br>
            &gt;=C2=A0 =C2=A0 target/riscv: Add Control Transfer Records CS=
R
            definitions.<br>
            &gt;=C2=A0 =C2=A0 target/riscv: Add support for Control Transfe=
r
            Records extension CSRs.<br>
            &gt;=C2=A0 =C2=A0 target/riscv: Add support to record CTR entri=
es.<br>
            &gt;=C2=A0 =C2=A0 target/riscv: Add CTR sctrclr instruction.<br=
>
            &gt;=C2=A0 =C2=A0 target/riscv: Add support to access ctrsource=
,
            ctrtarget, ctrdata<br>
            &gt;=C2=A0 =C2=A0 =C2=A0 regs.<br>
            &gt;<br>
            &gt;=C2=A0 =C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A04 +<br>
            &gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 14 +<br>
            &gt;=C2=A0 =C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 154
            +++++++++<br>
            &gt;=C2=A0 =C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02=
 +<br>
            &gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 213
            ++++++++++++<br>
            &gt;=C2=A0 =C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 312
            +++++++++++++++++-<br>
            &gt;=C2=A0 =C2=A0target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A08
            +-<br>
            &gt;=C2=A0 =C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02
            +-<br>
            &gt;=C2=A0 =C2=A0.../riscv/insn_trans/trans_privileged.c.inc=C2=
=A0 =C2=A0|=C2=A0 21
            +-<br>
            &gt;=C2=A0 =C2=A0target/riscv/insn_trans/trans_rvi.c.inc=C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 27
            ++<br>
            &gt;=C2=A0 =C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 117
            ++++++-<br>
            &gt;=C2=A0 =C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<b=
r>
            &gt;=C2=A0 =C2=A012 files changed, 870 insertions(+), 13 deleti=
ons(-)<br>
            &gt;<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </div>

</blockquote></div>
</blockquote></div>

--00000000000040e7da061a3cf5f1--

