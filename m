Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C31C27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 03:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEhX9-0002vJ-Jz; Tue, 04 Jun 2024 23:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEhX8-0002uJ-Qz
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 23:41:54 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beeman@rivosinc.com>)
 id 1sEhX6-0001pl-Dz
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 23:41:54 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-627ecda47d0so63419047b3.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717558911; x=1718163711;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wcgJ3drr8pV4xw/cHtgE6c0a2yyBLTVLB5GHHo0K4h8=;
 b=ECdA3d5QUuAE3p5jCgcI8h7Wo/NXDxafegpnXRgj++14MbrNwaACN+ScwH6z7axbck
 o/1k1Qzu35d0VIACC5OINZrPsOVDRuvjjuOZ4x4ioclqfG9DXd6zMqPopg9xyvZNct1C
 4qnfBF0d8yXlcHn891S41IqBx6Xg9FHNIDoAcloAed56JseTIrzT5xBr6T/6DeM6BrCO
 Ouy9lsVDt4fswhdW6n5dxsJ/sVe85fEO19A7ppr/sORJ0ElYAU/vpl8y3jyKgL3F439+
 LzlTfsmWmscCZa8J1cyrMUh0TCgbjPmVGLdeXR7Bh7q+z9fUA7kfXSUmzvDSS5nVD00N
 z5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558911; x=1718163711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wcgJ3drr8pV4xw/cHtgE6c0a2yyBLTVLB5GHHo0K4h8=;
 b=en6mRcEuHMbO2fcKpRIfV6GLZOM96duZTRVjnvPlqbyT5BZXASvfwLH8upkkvyFMRU
 jGZio/epW+u0xyWyZmZ4AwYcVQjEwCwFPaCnyqrC8WipYAyWYyur3SmVbmLCG/NoWnRe
 3Nt6RXHWQJ+BNcFfV7fz8OfqtnsQ53Br/AvBRx/x9lhfiAIMwQw9uZKMdSSNCg5Sqf19
 YeFoqev4Q5A3//vVkngRrL3PP/Wv4jNJQ1xo7i1IAjFBYFHmMEs4DKF+yrauzeloNdYc
 5wTAcZU2zMVlTD1nMyf/aCyS1oK1kTrWCgs1R/bfYRzpVlEZ4llh7i4gR/gS//Ok6QOq
 qr0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUovprQcqQat87zgmBskUCFfsCNCacVIk7p8h5m/pUpLZQQg49G/lbSa2ybsSu0Fmbm5AfNKXfDGyWWk2NvBpcvFfjD1YE=
X-Gm-Message-State: AOJu0Yx3w2WOwQrOe39B1n6B7Tjzuc0Rf/9ry033VypGUT0uAIv2Va7O
 JnBKngX+BzKAYlX74JoWumnkQ3nxtRbQTiQrY3o1aNU4lOoGVGXB3zClu4oP0kJZIn+c/g8n1HK
 ihotX8V5nArrErToVjvbm0pA6CkmSuvyh5A20Pg==
X-Google-Smtp-Source: AGHT+IEGAXb3zuwgbU79ut+ukFh1xcwuBBXz/QiikcjaIIPIIyeZJNcPARVr1ST4H/sxgauQrprYG1vQgeTy43dyQVs=
X-Received: by 2002:a81:404b:0:b0:628:c1f0:d8fd with SMTP id
 00721157ae682-62cbb5dbc96mr11691497b3.52.1717558911247; Tue, 04 Jun 2024
 20:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <da896d6b-7b7f-4246-9750-f7bc11e54d3b@sifive.com>
 <CAP55G9B4u8M__rDsEoPR1_U-AQYicU4-KVVCkVwD+pc+RhvhMg@mail.gmail.com>
 <d294f246-c31f-4329-979a-ceef0d8e7bea@sifive.com>
In-Reply-To: <d294f246-c31f-4329-979a-ceef0d8e7bea@sifive.com>
From: Beeman Strong <beeman@rivosinc.com>
Date: Tue, 4 Jun 2024 20:41:39 -0700
Message-ID: <CAP55G9BQLKLjqrvpiZc+hXH4urRehWDGp4zVL0gG1okNLYeWDw@mail.gmail.com>
Subject: Re: [PATCH 0/6] target/riscv: Add support for Control Transfer
 Records Ext.
To: Jason Chien <jason.chien@sifive.com>
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, alistair.francis@wdc.com,
 apatel@ventanamicro.com, 
 atishp@rivosinc.com, bin.meng@windriver.com, dbarboza@ventanamicro.com, 
 liweiwei@iscas.ac.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 tech-control-transfer-records@lists.riscv.org, zhiwei_liu@linux.alibaba.com
Content-Type: multipart/alternative; boundary="000000000000c941d1061a1c58b7"
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

--000000000000c941d1061a1c58b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, good catch.  We removed that dependency late.  I'll fix it.

On Tue, Jun 4, 2024 at 8:34=E2=80=AFPM Jason Chien <jason.chien@sifive.com>=
 wrote:

> Thank you for pointing that out. CTR does not use miselect and mireg*.
> There is no dependency on Smcsrind. I believe the spec needs to be
> corrected.
>
> Chapter 1 states that:
> Smctr depends on the Smcsrind extension, while Ssctr depends on the
> Sscsrind extension. Further, both Smctr and Ssctr depend upon
> implementation of S-mode.
> Beeman Strong =E6=96=BC 2024/6/5 =E4=B8=8A=E5=8D=88 06:32 =E5=AF=AB=E9=81=
=93:
>
> There is no dependency on Smcsrind, only Sscsrind.
>
> On Tue, Jun 4, 2024 at 12:29=E2=80=AFAM Jason Chien <jason.chien@sifive.c=
om>
> wrote:
>
>> Smctr depends on the Smcsrind extension, Ssctr depends on the Sscsrind
>> extension, and both Smctr and Ssctr depend upon implementation of S-mode=
.
>> There should be a dependency check in riscv_cpu_validate_set_extensions(=
).
>>
>> Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=
=81=93:
>> > This series enables Control Transfer Records extension support on risc=
v
>> > platform. This extension is similar to Arch LBR in x86 and BRBE in ARM=
.
>> > The Extension has been stable and the latest release can be found here
>> [0]
>> >
>> > CTR extension depends on couple of other extensions:
>> >
>> > 1. S[m|s]csrind : The indirect CSR extension [1] which defines
>> additional
>> >     ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation =
of
>> >     RISC-V CSR address space. CTR access ctrsource, ctrtartget and
>> ctrdata
>> >     CSRs using sscsrind extension.
>> >
>> > 2. Smstateen: The mstateen bit[54] controls the access to the CTR ext =
to
>> >     S-mode.
>> >
>> > 3. Sscofpmf: Counter overflow and privilege mode filtering. [2]
>> >
>> > The series is based on Smcdeleg/Ssccfg counter delegation extension [3=
]
>> > patches. CTR itself doesn't depend on counter delegation support. This
>> > rebase is basically to include the Smcsrind patches.
>> >
>> > Due to the dependency of these extensions, the following extensions
>> must be
>> > enabled to use the control transfer records feature.
>> >
>> >
>> "smstateen=3Dtrue,sscofpmf=3Dtrue,smcsrind=3Dtrue,sscsrind=3Dtrue,smctr=
=3Dtrue,ssctr=3Dtrue"
>> >
>> > Here is the link to a quick guide [5] to setup and run a basic perf
>> demo on
>> > Linux to use CTR Ext.
>> >
>> > The Qemu patches can be found here:
>> > https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream
>> >
>> > The opensbi patch can be found here:
>> > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream
>> >
>> > The Linux kernel patches can be found here:
>> > https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream
>> >
>> > [0]:https://github.com/riscv/riscv-control-transfer-records/release
>> > [1]:https://github.com/riscv/riscv-indirect-csr-access
>> > [2]:https://github.com/riscvarchive/riscv-count-overflow/tree/main
>> > [3]:https://github.com/riscv/riscv-smcdeleg-ssccfg
>> > [4]:
>> https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com=
/
>> > [5]:
>> https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-Q=
EMU-RISC%E2%80%90V-Virt-machine
>> >
>> > Rajnesh Kanwal (6):
>> >    target/riscv: Remove obsolete sfence.vm instruction
>> >    target/riscv: Add Control Transfer Records CSR definitions.
>> >    target/riscv: Add support for Control Transfer Records extension
>> CSRs.
>> >    target/riscv: Add support to record CTR entries.
>> >    target/riscv: Add CTR sctrclr instruction.
>> >    target/riscv: Add support to access ctrsource, ctrtarget, ctrdata
>> >      regs.
>> >
>> >   target/riscv/cpu.c                            |   4 +
>> >   target/riscv/cpu.h                            |  14 +
>> >   target/riscv/cpu_bits.h                       | 154 +++++++++
>> >   target/riscv/cpu_cfg.h                        |   2 +
>> >   target/riscv/cpu_helper.c                     | 213 ++++++++++++
>> >   target/riscv/csr.c                            | 312 ++++++++++++++++=
+-
>> >   target/riscv/helper.h                         |   8 +-
>> >   target/riscv/insn32.decode                    |   2 +-
>> >   .../riscv/insn_trans/trans_privileged.c.inc   |  21 +-
>> >   target/riscv/insn_trans/trans_rvi.c.inc       |  27 ++
>> >   target/riscv/op_helper.c                      | 117 ++++++-
>> >   target/riscv/translate.c                      |   9 +
>> >   12 files changed, 870 insertions(+), 13 deletions(-)
>> >
>>
>

--000000000000c941d1061a1c58b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ah, good catch.=C2=A0 We removed that dependency late.=C2=
=A0 I&#39;ll fix it.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Tue, Jun 4, 2024 at 8:34=E2=80=AFPM Jason Chien &lt;=
<a href=3D"mailto:jason.chien@sifive.com">jason.chien@sifive.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

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

--000000000000c941d1061a1c58b7--

