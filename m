Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F78C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCDx-0001iL-Kx; Fri, 12 Jul 2024 05:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCDt-0001fO-Io
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:05:49 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCDk-000057-4T
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:05:49 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso214553766b.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1720775138; x=1721379938; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z2HhYTDuUyAei8pbIc/0A8poefJBCRADplcR/zMSHO0=;
 b=Cqbma9sZHPUsTSdH1LejQBw/Hg2eoxZVH3v9++6hpf8N356B/BMivD/zLBX+db7x90
 BAqsP3/arA3ZOXcZ10wBc/T8hpDcqXNHYIBr1Jdo5NC5XY4assR3h+54hz+U/lJ3fANX
 d0hZq/5JOb/If8gIMBY8xYpKnthzKLIoChAtJSRzHl3FQAy2i1rvMghdjzC2noVkm8UY
 YHh/4obwFCZgDLyXnsDv6HRcBGVmboTrO+rPtNf0FV38PvZo/pPxlu5avJvGtCMJnNir
 lfHZpvjax1trk5H2AYW1YsKEb1OgHA+yeUBMT2q1iPMWv1oWJOaT5aOOX0cYpUF3rWaQ
 NAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720775138; x=1721379938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2HhYTDuUyAei8pbIc/0A8poefJBCRADplcR/zMSHO0=;
 b=aoDFpWFXj+PkuzhYn3i7UjaEveWA3mMEZzeQAtyGGbNXDu8GS6bsPCBBB8f+R64Ddj
 ubPEYyLqQq2lzWTYv2LTyXumiMmlixCZCaiqw94q0hoGMgm7DzDqyJvM3otxUZmDxqBh
 +aP8q3PyAa4IP6bI6ykPSh5Y55Ruso3rKZWzV7Q9L6Bot6Gw2lmu9Zy5FjnsK4oNhLxY
 RU7NWJfPwzVMBgRGZEUEmkTdt4sOrjiCxPnCiIKTWkwkpoTsAcfYoSxYpqPJRwDAB0pY
 rmbVzCRiqONdOBSqIU4fUdOSTKPI6m9G0a59nK/Omk8BaJ5/Ofko+sLCpokfOd7LhOXi
 kR8w==
X-Gm-Message-State: AOJu0Yz7mXJ30iDafIWvFpdsmFemG89Xwo8Hd/eXntu6YD8YTuXzFWpx
 9YuUE4bKSGUo83GmkTswdmKOKzb7ZxIsMvvkFqLnQX0DuZ8qxYpEIV/Tkoh493JSs36ZBHobFWV
 beumyWdcsL2nhUue2uAPIM5n9Mk4xuR8qZ8ma4Q==
X-Google-Smtp-Source: AGHT+IFbPO3+pUDhpg1aWz29w8RiVg9QxyJUqR9S5cIQToBc0y7mY7yo0MUauZarU97FLJke+KHkEeOY3XrsrGZHuEQ=
X-Received: by 2002:a17:906:1787:b0:a75:23bb:6087 with SMTP id
 a640c23a62f3a-a780b6b1baemr675829966b.29.1720775137893; Fri, 12 Jul 2024
 02:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
 <20240709113652.1239-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240709113652.1239-2-zhiwei_liu@linux.alibaba.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 12 Jul 2024 17:05:26 +0800
Message-ID: <CALw707rMkPo2B4DEhpn3S+RJLTER_HKh9vFNDXu9eg3bHLwZmA@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] target/riscv: Add zimop extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, Deepak Gupta <debug@rivosinc.com>
Content-Type: multipart/alternative; boundary="000000000000d53982061d092e8b"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x62c.google.com
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

--000000000000d53982061d092e8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Jim Shu <jim.shu@sifive.com>

On Tue, Jul 9, 2024 at 7:39=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com>
wrote:

> Zimop extension defines an encoding space for 40 MOPs.The Zimop
> extension defines 32 MOP instructions named MOP.R.n, where n is
> an integer between 0 and 31, inclusive. The Zimop extension
> additionally defines 8 MOP instructions named MOP.RR.n, where n
> is an integer between 0 and 7.
>
> These 40 MOPs initially are defined to simply write zero to x[rd],
> but are designed to be redefined by later extensions to perform some
> other action.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  target/riscv/cpu.c                          |  2 ++
>  target/riscv/cpu_cfg.h                      |  1 +
>  target/riscv/insn32.decode                  | 11 ++++++
>  target/riscv/insn_trans/trans_rvzimop.c.inc | 37 +++++++++++++++++++++
>  target/riscv/translate.c                    |  1 +
>  5 files changed, 52 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a2640cf259..d3853a5804 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
> @@ -1471,6 +1472,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]
> =3D {
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> +    MULTI_EXT_CFG_BOOL("zimop", ext_zimop, false),
>      MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
>      MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
>      MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index fb7eebde52..9f53512053 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -71,6 +71,7 @@ struct RISCVCPUConfig {
>      bool ext_zihintntl;
>      bool ext_zihintpause;
>      bool ext_zihpm;
> +    bool ext_zimop;
>      bool ext_ztso;
>      bool ext_smstateen;
>      bool ext_sstc;
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..60da673153 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -38,6 +38,8 @@
>  %imm_bs   30:2                   !function=3Dex_shift_3
>  %imm_rnum 20:4
>  %imm_z6   26:1 15:5
> +%imm_mop5 30:1 26:2 20:2
> +%imm_mop3 30:1 26:2
>
>  # Argument sets:
>  &empty
> @@ -56,6 +58,8 @@
>  &r2nfvm    vm rd rs1 nf
>  &rnfvm     vm rd rs1 rs2 nf
>  &k_aes     shamt rs2 rs1 rd
> +&mop5 imm rd rs1
> +&mop3 imm rd rs1 rs2
>
>  # Formats 32:
>  @r       .......   ..... ..... ... ..... ....... &r                %rs2
> %rs1 %rd
> @@ -98,6 +102,9 @@
>  @k_aes   .. ..... ..... .....  ... ..... ....... &k_aes  shamt=3D%imm_bs
>  %rs2 %rs1 %rd
>  @i_aes   .. ..... ..... .....  ... ..... ....... &i      imm=3D%imm_rnum
>     %rs1 %rd
>
> +@mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=3D%imm_mop5 %r=
d
> %rs1
> +@mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=3D%imm_mop3 %r=
d
> %rs1 %rs2
> +
>  # Formats 64:
>  @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=3D%sh5
> %rs1 %rd
>
> @@ -1010,3 +1017,7 @@ amocas_w    00101 . . ..... ..... 010 ..... 0101111
> @atom_st
>  amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
>  # *** RV64 Zacas Standard Extension ***
>  amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
> +
> +# *** Zimop may-be-operation extension ***
> +mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
> +mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
> diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc
> b/target/riscv/insn_trans/trans_rvzimop.c.inc
> new file mode 100644
> index 0000000000..165aacd2b6
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzimop.c.inc
> @@ -0,0 +1,37 @@
> +/*
> + * RISC-V translation routines for May-Be-Operation(zimop).
> + *
> + * Copyright (c) 2024 Alibaba Group.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZIMOP(ctx) do {           \
> +    if (!ctx->cfg_ptr->ext_zimop) {       \
> +        return false;                     \
> +    }                                     \
> +} while (0)
> +
> +static bool trans_mop_r_n(DisasContext *ctx, arg_mop_r_n *a)
> +{
> +    REQUIRE_ZIMOP(ctx);
> +    gen_set_gpr(ctx, a->rd, ctx->zero);
> +    return true;
> +}
> +
> +static bool trans_mop_rr_n(DisasContext *ctx, arg_mop_rr_n *a)
> +{
> +    REQUIRE_ZIMOP(ctx);
> +    gen_set_gpr(ctx, a->rd, ctx->zero);
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 0569224e53..379b68289f 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1099,6 +1099,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,
> target_ulong pc)
>  #include "insn_trans/trans_rvzacas.c.inc"
>  #include "insn_trans/trans_rvzawrs.c.inc"
>  #include "insn_trans/trans_rvzicbo.c.inc"
> +#include "insn_trans/trans_rvzimop.c.inc"
>  #include "insn_trans/trans_rvzfa.c.inc"
>  #include "insn_trans/trans_rvzfh.c.inc"
>  #include "insn_trans/trans_rvk.c.inc"
> --
> 2.25.1
>
>
>

--000000000000d53982061d092e8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Jim Shu &lt;<a href=3D"mailto:jim.shu@sifive.=
com">jim.shu@sifive.com</a>&gt;<br></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 9, 2024 at 7:39=E2=80=AFPM L=
IU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.com">zhiwei_liu@li=
nux.alibaba.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Zimop extension defines an encoding space for 40 MOPs.The Zi=
mop<br>
extension defines 32 MOP instructions named MOP.R.n, where n is<br>
an integer between 0 and 31, inclusive. The Zimop extension<br>
additionally defines 8 MOP instructions named MOP.RR.n, where n<br>
is an integer between 0 and 7.<br>
<br>
These 40 MOPs initially are defined to simply write zero to x[rd],<br>
but are designed to be redefined by later extensions to perform some<br>
other action.<br>
<br>
Signed-off-by: LIU Zhiwei &lt;<a href=3D"mailto:zhiwei_liu@linux.alibaba.co=
m" target=3D"_blank">zhiwei_liu@linux.alibaba.com</a>&gt;<br>
Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.co=
m" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
Reviewed-by: Deepak Gupta &lt;<a href=3D"mailto:debug@rivosinc.com" target=
=3D"_blank">debug@rivosinc.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/riscv/cpu_cfg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 11 ++++++<br>
=C2=A0target/riscv/insn_trans/trans_rvzimop.c.inc | 37 ++++++++++++++++++++=
+<br>
=C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A05 files changed, 52 insertions(+)<br>
=C2=A0create mode 100644 target/riscv/insn_trans/trans_rvzimop.c.inc<br>
<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index a2640cf259..d3853a5804 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -113,6 +113,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_=
zihintntl),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ex=
t_zihintpause),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihp=
m),<br>
+=C2=A0 =C2=A0 ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),<b=
r>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmu=
l),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_pri=
v_1_11),<br>
=C2=A0 =C2=A0 =C2=A0ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaam=
o),<br>
@@ -1471,6 +1472,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =
=3D {<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zicsr&quot;, ext_zicsr, true),=
<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zihintntl&quot;, ext_zihintntl=
, true),<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zihintpause&quot;, ext_zihintp=
ause, true),<br>
+=C2=A0 =C2=A0 MULTI_EXT_CFG_BOOL(&quot;zimop&quot;, ext_zimop, false),<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zacas&quot;, ext_zacas, false)=
,<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zaamo&quot;, ext_zaamo, false)=
,<br>
=C2=A0 =C2=A0 =C2=A0MULTI_EXT_CFG_BOOL(&quot;zalrsc&quot;, ext_zalrsc, fals=
e),<br>
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h<br>
index fb7eebde52..9f53512053 100644<br>
--- a/target/riscv/cpu_cfg.h<br>
+++ b/target/riscv/cpu_cfg.h<br>
@@ -71,6 +71,7 @@ struct RISCVCPUConfig {<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zihintntl;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zihintpause;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_zihpm;<br>
+=C2=A0 =C2=A0 bool ext_zimop;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_ztso;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_smstateen;<br>
=C2=A0 =C2=A0 =C2=A0bool ext_sstc;<br>
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode<br>
index f22df04cfd..60da673153 100644<br>
--- a/target/riscv/insn32.decode<br>
+++ b/target/riscv/insn32.decode<br>
@@ -38,6 +38,8 @@<br>
=C2=A0%imm_bs=C2=A0 =C2=A030:2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0!function=3Dex_shift_3<br>
=C2=A0%imm_rnum 20:4<br>
=C2=A0%imm_z6=C2=A0 =C2=A026:1 15:5<br>
+%imm_mop5 30:1 26:2 20:2<br>
+%imm_mop3 30:1 26:2<br>
<br>
=C2=A0# Argument sets:<br>
=C2=A0&amp;empty<br>
@@ -56,6 +58,8 @@<br>
=C2=A0&amp;r2nfvm=C2=A0 =C2=A0 vm rd rs1 nf<br>
=C2=A0&amp;rnfvm=C2=A0 =C2=A0 =C2=A0vm rd rs1 rs2 nf<br>
=C2=A0&amp;k_aes=C2=A0 =C2=A0 =C2=A0shamt rs2 rs1 rd<br>
+&amp;mop5 imm rd rs1<br>
+&amp;mop3 imm rd rs1 rs2<br>
<br>
=C2=A0# Formats 32:<br>
=C2=A0@r=C2=A0 =C2=A0 =C2=A0 =C2=A0.......=C2=A0 =C2=A0..... ..... ... ....=
. ....... &amp;r=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %rs=
2 %rs1 %rd<br>
@@ -98,6 +102,9 @@<br>
=C2=A0@k_aes=C2=A0 =C2=A0.. ..... ..... .....=C2=A0 ... ..... ....... &amp;=
k_aes=C2=A0 shamt=3D%imm_bs=C2=A0 =C2=A0%rs2 %rs1 %rd<br>
=C2=A0@i_aes=C2=A0 =C2=A0.. ..... ..... .....=C2=A0 ... ..... ....... &amp;=
i=C2=A0 =C2=A0 =C2=A0 imm=3D%imm_rnum=C2=A0 =C2=A0 =C2=A0 =C2=A0 %rs1 %rd<b=
r>
<br>
+@mop5 . . .. .. .... .. ..... ... ..... ....... &amp;mop5 imm=3D%imm_mop5 =
%rd %rs1<br>
+@mop3 . . .. .. . ..... ..... ... ..... ....... &amp;mop3 imm=3D%imm_mop3 =
%rd %rs1 %rs2<br>
+<br>
=C2=A0# Formats 64:<br>
=C2=A0@sh5=C2=A0 =C2=A0 =C2=A0.......=C2=A0 ..... .....=C2=A0 ... ..... ...=
.... &amp;shift=C2=A0 shamt=3D%sh5=C2=A0 =C2=A0 =C2=A0 %rs1 %rd<br>
<br>
@@ -1010,3 +1017,7 @@ amocas_w=C2=A0 =C2=A0 00101 . . ..... ..... 010 .....=
 0101111 @atom_st<br>
=C2=A0amocas_d=C2=A0 =C2=A0 00101 . . ..... ..... 011 ..... 0101111 @atom_s=
t<br>
=C2=A0# *** RV64 Zacas Standard Extension ***<br>
=C2=A0amocas_q=C2=A0 =C2=A0 00101 . . ..... ..... 100 ..... 0101111 @atom_s=
t<br>
+<br>
+# *** Zimop may-be-operation extension ***<br>
+mop_r_n=C2=A0 =C2=A0 =C2=A01 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5=
<br>
+mop_rr_n=C2=A0 =C2=A0 1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3<br>
diff --git a/target/riscv/insn_trans/trans_rvzimop.c.inc b/target/riscv/ins=
n_trans/trans_rvzimop.c.inc<br>
new file mode 100644<br>
index 0000000000..165aacd2b6<br>
--- /dev/null<br>
+++ b/target/riscv/insn_trans/trans_rvzimop.c.inc<br>
@@ -0,0 +1,37 @@<br>
+/*<br>
+ * RISC-V translation routines for May-Be-Operation(zimop).<br>
+ *<br>
+ * Copyright (c) 2024 Alibaba Group.<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify it=
<br>
+ * under the terms and conditions of the GNU General Public License,<br>
+ * version 2 or later, as published by the Free Software Foundation.<br>
+ *<br>
+ * This program is distributed in the hope it will be useful, but WITHOUT<=
br>
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or<b=
r>
+ * FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public Lice=
nse for<br>
+ * more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
 with<br>
+ * this program.=C2=A0 If not, see &lt;<a href=3D"http://www.gnu.org/licen=
ses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.org/licenses/</a>=
&gt;.<br>
+ */<br>
+<br>
+#define REQUIRE_ZIMOP(ctx) do {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+=C2=A0 =C2=A0 if (!ctx-&gt;cfg_ptr-&gt;ext_zimop) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 }=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
+} while (0)<br>
+<br>
+static bool trans_mop_r_n(DisasContext *ctx, arg_mop_r_n *a)<br>
+{<br>
+=C2=A0 =C2=A0 REQUIRE_ZIMOP(ctx);<br>
+=C2=A0 =C2=A0 gen_set_gpr(ctx, a-&gt;rd, ctx-&gt;zero);<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_mop_rr_n(DisasContext *ctx, arg_mop_rr_n *a)<br>
+{<br>
+=C2=A0 =C2=A0 REQUIRE_ZIMOP(ctx);<br>
+=C2=A0 =C2=A0 gen_set_gpr(ctx, a-&gt;rd, ctx-&gt;zero);<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
diff --git a/target/riscv/translate.c b/target/riscv/translate.c<br>
index 0569224e53..379b68289f 100644<br>
--- a/target/riscv/translate.c<br>
+++ b/target/riscv/translate.c<br>
@@ -1099,6 +1099,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)<br>
=C2=A0#include &quot;insn_trans/trans_rvzacas.c.inc&quot;<br>
=C2=A0#include &quot;insn_trans/trans_rvzawrs.c.inc&quot;<br>
=C2=A0#include &quot;insn_trans/trans_rvzicbo.c.inc&quot;<br>
+#include &quot;insn_trans/trans_rvzimop.c.inc&quot;<br>
=C2=A0#include &quot;insn_trans/trans_rvzfa.c.inc&quot;<br>
=C2=A0#include &quot;insn_trans/trans_rvzfh.c.inc&quot;<br>
=C2=A0#include &quot;insn_trans/trans_rvk.c.inc&quot;<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div>

--000000000000d53982061d092e8b--

