Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96EBCCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIyx5-00016V-Lm; Tue, 11 Nov 2025 19:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIyx3-00015O-H8
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:43:09 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIyx1-00048h-Cp
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:43:09 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b731b176b5eso59565266b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762908186; x=1763512986; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTe/nUNd852nMPXiIUEtygWnFyVsZ6dRNUvoruQuFKI=;
 b=cxzNWTcwiLCDIN3Jnzyx6Hh8TyT87ksth52Hkl0WnKjZUAvxeDpScyPhgZdaa6XEZr
 60Fj34G+PEpC6G8dOQ/x4ftHM0G10oU5vnvRAKk39yfgeBN3gdzd4dCitH3GU6rXCaco
 XXS8bp1QbfU0v5ZocPNCDUr12RFc0sswMtlts+9kcZRbbmjy6jxjv0Xn3CfXbzTReP7N
 uNTZBlwISWvZ/gKWXcsIZzZHECCCFPh2PWBFYs8RTW7iYqIVwuJAwuP2NcnR9hhQbfxF
 0wA6pBPCiIaYAFHRXXmgBl3vwpy51R1JzTSfFjDBGLamWS0XY19brxm4wSbd9y2yPZJk
 UXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762908186; x=1763512986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xTe/nUNd852nMPXiIUEtygWnFyVsZ6dRNUvoruQuFKI=;
 b=p+w1k32BRoyofv33xpX2pGyw5qAJV6o9v9YykKpWdabtPjh9SS1kg/+0yL8rcTHnG1
 1sf76ZI8OSGNsvG4JQ2dzhlpyiIUsMibiTHpeilx7GRjeMWhq04+Ch1Zo9UCApOfcre8
 gRLeBu9iTZpRl4G31diJVG08Q9whPE5PI7b7eVMo1K+wtMfoe+bs22XSxs3yDvA3VH4/
 bXUmWdCmDdJUb/jcLIKZCXSJxv9KfNyU9QE2h17WwzulmyIaeX/Xhsk/aLDZaDGYrVog
 ZQTOYYWSQqhTj6HMLubULJagxfrrmKIT2hs8EcokxJgfRJsOJy3xuQeM3H+qu6c1dEy1
 MCGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/h7kja+4CWU56giU5dhutqQHtOCF7KZVzeZv44HJ7QOUwPOK84hC9vPxw5ToZ7IMa6peakHim9R1k@nongnu.org
X-Gm-Message-State: AOJu0YwHmtdVkAJH2vzlZ1TVbgV3gpzsu1JavgTB1ziOdnvfUoc/CElv
 DQMiQU+GPFTInyYqXAKiGhtDWcG6qXaCZVbfxxIfvjZlHQJDTXHagHIosvI//ft3g/FJOQ7zeUe
 A36mgRV9hwa2z8hqcZBBM73wDXbn1GfI=
X-Gm-Gg: ASbGncuhAoYeFd2E/rxDUs2zzDseaeBnAcdBKaHEXjJv+TJKu5Y0DS+YSMVnuikGHRw
 0DLu0iBJ8Xz1M/VVNDOtnwTuEzOnzVUBnpRoNEqhUwAugcc8HUneHQEf4AP0+2vIw9YMWyyHo3D
 atr1dSDseTxesPj3Q1cGtTKhqZ0CJOIDPTKRARuORE/lfcBPOsYIrDZqkSQIoWKhNFiph9MGzgY
 GgSpYCUCCLkV6w7/K/Qoz9JLUfOvf5s96IK6Lm2YcTzTWC9JMxAGnNFymCAG1ugoPPMGaP1s2Nv
 Pn1AM3UDuC4hupZha2V05GKkAA==
X-Google-Smtp-Source: AGHT+IFADdD0lK2cHewge0p/LuakaxCJtdSua2828112yc5dvtvFFgn9pDbjuvnonaq1zar952hHcrLjUD4lyuO9E/U=
X-Received: by 2002:a17:907:6095:b0:b72:5983:db09 with SMTP id
 a640c23a62f3a-b7331a6b878mr105681466b.32.1762908185724; Tue, 11 Nov 2025
 16:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20251103101730.80749-1-roan.richmond@codethink.co.uk>
In-Reply-To: <20251103101730.80749-1-roan.richmond@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 10:42:39 +1000
X-Gm-Features: AWmQ_bmWO55ZVKesB4a4EIjdbjCRQW00dj0BLJ-4CbwEMEKQ2BkKfjNCewlnmF0
Message-ID: <CAKmqyKPzGPhpZbwOm51M3MzX4c-bLWcY7oLv3sfVEX0jfy988g@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Add RISCV ZALASR extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 3, 2025 at 8:17=E2=80=AFPM Roan Richmond
<roan.richmond@codethink.co.uk> wrote:
>
> This is based on version v0.9 of the ZALASR specification [1].
> The specification is listed as in Ratified state [2].
>
> [1]: https://github.com/riscv/riscv-zalasr/tree/v0.9
> [2]: https://lf-riscv.atlassian.net/wiki/spaces/HOME/pages/16154882/All+R=
ISC-V+Specifications+Under+Active+Development
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> V4:
>   - rebased onto newest master branch
>   - added config option for ZALASR into RISCVCPUMultiExtConfig
>     which was missed off in V3 version
>
>  target/riscv/cpu.c                           |   2 +
>  target/riscv/cpu_cfg_fields.h.inc            |   1 +
>  target/riscv/insn32.decode                   |  10 ++
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 120 +++++++++++++++++++
>  target/riscv/translate.c                     |   1 +
>  5 files changed, 134 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 73d4280d7c..96e33ee10f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -127,6 +127,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> +    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>      ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
> @@ -1253,6 +1254,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
>      MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
>      MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
> +    MULTI_EXT_CFG_BOOL("zalasr", ext_zalasr, false),
>      MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
>      MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
>      MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index a154ecdc79..7d3d5d0d57 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -65,6 +65,7 @@ BOOL_FIELD(ext_zaamo)
>  BOOL_FIELD(ext_zacas)
>  BOOL_FIELD(ext_zama16b)
>  BOOL_FIELD(ext_zabha)
> +BOOL_FIELD(ext_zalasr)
>  BOOL_FIELD(ext_zalrsc)
>  BOOL_FIELD(ext_zawrs)
>  BOOL_FIELD(ext_zfa)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cd23b1f3a9..c848c0c1c5 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1066,3 +1066,13 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101111=
 @atom_st
>  amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
>  amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
>  amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
> +
> +# *** Zalasr Standard Extension ***
> +lb_aqrl  00110 . . ..... ..... 000 ..... 0101111 @atom_st
> +lh_aqrl  00110 . . ..... ..... 001 ..... 0101111 @atom_st
> +lw_aqrl  00110 . . ..... ..... 010 ..... 0101111 @atom_st
> +ld_aqrl  00110 . . ..... ..... 011 ..... 0101111 @atom_st
> +sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
> +sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
> +sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
> +sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/=
insn_trans/trans_rvzalasr.c.inc
> new file mode 100644
> index 0000000000..8761508de3
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -0,0 +1,120 @@
> +/*
> + * RISC-V translation routines for the ZALASR (Load-Aquire and Store-Rel=
ease)
> + * Extension.
> + *
> + * Copyright (c) 2025 Roan Richmond, roan.richmond@codethink.co.uk
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define REQUIRE_ZALASR(ctx) do {     \
> +    if (!ctx->cfg_ptr->ext_zalasr) { \
> +        return false;                \
> +    }                                \
> +} while (0)
> +
> +static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp me=
mop)
> +{
> +    decode_save_opc(ctx, 0);
> +
> +    TCGv addr =3D get_address(ctx, a->rs1, 0);
> +    TCGv dest =3D get_gpr(ctx, a->rd, EXT_NONE);
> +    TCGBar bar =3D (a->rl) ? TCG_BAR_STRL : 0;
> +
> +    /* Check that AQ is set, as this is mandatory */
> +    if (!a->aq) {
> +        return false;
> +    }
> +
> +    memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> +
> +    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
> +    gen_set_gpr(ctx, a->rd, dest);
> +
> +    /* Add a memory barrier implied by AQ (mandatory) and RL (optional) =
*/
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ | bar);
> +
> +    return true;
> +}
> +
> +static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
> +}
> +
> +static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
> +}
> +
> +static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_ZALASR(ctx);
> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
> +}
> +
> +static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp m=
emop)
> +{
> +    decode_save_opc(ctx, 0);
> +
> +    TCGv addr =3D get_address(ctx, a->rs1, 0);
> +    TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGBar bar =3D (a->aq) ? TCG_BAR_LDAQ : 0;
> +
> +    /* Check that RL is set, as this is mandatory */
> +    if (!a->rl) {
> +        return false;
> +    }
> +
> +    memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> +
> +    /* Add a memory barrier implied by RL (mandatory) and AQ (optional) =
*/
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
> +
> +    tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
> +    return true;
> +}
> +
> +static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
> +}
> +
> +static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
> +}
> +
> +static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
> +{
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
> +}
> +
> +static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_ZALASR(ctx);
> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index e1f4dc5ffd..f89a99c849 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1199,6 +1199,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  #include "insn_trans/trans_rvzicond.c.inc"
>  #include "insn_trans/trans_rvzacas.c.inc"
>  #include "insn_trans/trans_rvzabha.c.inc"
> +#include "insn_trans/trans_rvzalasr.c.inc"
>  #include "insn_trans/trans_rvzawrs.c.inc"
>  #include "insn_trans/trans_rvzicbo.c.inc"
>  #include "insn_trans/trans_rvzimop.c.inc"
> --
> 2.43.0
>

