Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D012C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 00:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXU3t-00073y-Qu; Thu, 03 Jul 2025 20:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXU3q-000737-DI; Thu, 03 Jul 2025 20:13:51 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXU3o-0003AG-A9; Thu, 03 Jul 2025 20:13:50 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-87f2ba094dcso61048241.3; 
 Thu, 03 Jul 2025 17:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751588026; x=1752192826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31U0OZqZqxRftEY3O+tr2DE2qwh/OJDxpBdMCC/56Sc=;
 b=L7u27lgleGPyshp862sT+RGt6hYbAYEkdwpI7fFOlGeqxkN/4gIQd/uzhg3ANapPEi
 PJg73EpAteMrVBza1zbc62cLi1qA8dbwpJDUhDc8LWxWBiyNCdZnuYvJEeqzgHpF+3GF
 E5l1T49BefqVE6WOa0sqcC2ezxS0+whRx/muaaMrMgH/pNrW4gdB63CzIWtKCC2/KGeL
 AD5WXS4DvU5kuC+xYBohcc/ncTIKgSGeBZ/joQxjfflUTKLXRuAaCSinwEt1KrtcmtZI
 k9+Hw8ezivU+0xwTogjtPLiZ1UfkIxlfX2c0isgQ79V3mw2OzM0otQLptcRj0zF5FjPd
 mtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751588026; x=1752192826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31U0OZqZqxRftEY3O+tr2DE2qwh/OJDxpBdMCC/56Sc=;
 b=ZWIQ2EdjpBoiMwnSWxr3Y7yxswPWHchwAag72QzMJWH1S9HDKr8talUlIPKkFipzEr
 lgfHpylGTGcCMgIOcA1SYlZ+sRyVagq4OfJfOazsUwwevrI0zDaOiCAAG9WRvFiZ05WG
 thKltPaddk6celcnhmJOVDCmNgAeH2HHO746/MX6IujGPmXmoZpaiCqm4+3RRgM82xIG
 uWRbarJ5AE1hi7NnDke9k9b88XRf9XhiGZKGBYACueX4aeWgqakNFfyjrqlm8CcfzUFd
 XZI8EdteRaxtHgDa9lDvtTs7cRakPV6SmIzks6PVW8sWrMn2tPd/aS2OhG1awVLBD5pS
 p8sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXzlEha6GmyaBgQzUDmEDL1AffNBrqKZ6T2Jhgzb4W1o/e2f/V9jHTQufGQUlXzZWwtTy2w/PykDHy@nongnu.org
X-Gm-Message-State: AOJu0YxyxEDbRywHtLv3iI/HYDRnYMptkx4PTuywgJw+VEqjJ4DZbSOc
 B94AicqD680CaeF1ncuaGAC/FMotoN0OOeO9mh2ak58yu2gdNBx0HV3CWnLD50XOHLgxMzCrLq5
 NrhWCxSS1MsrThW3xObEfkbN8gCE8qsA=
X-Gm-Gg: ASbGncuYW61XU+V7MZQpq7EB14OwoHQM5WJt593hREkiP/vhbC4zjSXeepPMxQOlpSf
 87TzqbTMp2VIFNMV75/DcRH4K84jynChCp4i30adXNU6QU83LGxpCnzlIHl1BAzc1gO9ZUXjdrg
 yAQbC2gpu2lw/kz2L03wIlUUPEcx8Z2eErGOxDJBe1g7eeWHRIexQUwxfmAxFy9KzkLN5JuLHAu
 g==
X-Google-Smtp-Source: AGHT+IFgg7hHQGuJ7KxOUymH0y1rLWKEygaG3rKHxa2eScBnjDTI3ephzwwm+jnGZCrtNRwRv8pyO4YFj1zqQeiKOCE=
X-Received: by 2002:a05:6102:6d5:b0:4ec:d3a:46e9 with SMTP id
 ada2fe7eead31-4f2f1dbe163mr83141137.1.1751588026339; Thu, 03 Jul 2025
 17:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250619135545.61956-1-roan.richmond@codethink.co.uk>
In-Reply-To: <20250619135545.61956-1-roan.richmond@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 10:13:20 +1000
X-Gm-Features: Ac12FXw25wI1AKV-WVpcLLfQbKndMtDXQ2Prr-COKZLUeXcT5wWU9g0rUDguZvY
Message-ID: <CAKmqyKOk6cKO_BPwexFOY-tYEzjJ-irHZz9Xub=XyrWDzh6crg@mail.gmail.com>
Subject: Re: [PATCH v3] Add RISCV ZALASR extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jun 19, 2025 at 11:56=E2=80=AFPM Roan Richmond
<roan.richmond@codethink.co.uk> wrote:
>
> This is based on version v0.8.3 of the ZALASR specification [1].
> The specification is listed as in Frozen state [2].
>
> [1]: https://github.com/riscv/riscv-zalasr/tree/v0.8.3
> [2]: https://lf-riscv.atlassian.net/wiki/spaces/HOME/pages/16154882/All+R=
ISC-V+Specifications+Under+Active+Development
>
> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Ping! resending this as no movement on previous send.
>
> V3:
>   - rebased patch onto master branch
>   - added check for aq on Load Acquire, as pointed out by Alistair Franci=
s
>   - added check for rl on Store Release, as mentioned by Alistair Francis
>
>  target/riscv/cpu.c                           |   1 +
>  target/riscv/insn32.decode                   |  10 ++
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 120 +++++++++++++++++++
>  target/riscv/translate.c                     |   1 +
>  4 files changed, 132 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..b52bbf0936 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -128,6 +128,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
>      ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
> +    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
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
> index d7a6de02df..4cd2d68e46 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1183,6 +1183,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
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

