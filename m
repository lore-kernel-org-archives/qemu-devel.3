Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB3C71133
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 04:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPD5r-0001hj-Uk; Wed, 11 Jun 2025 00:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPD5n-0001gr-8s; Wed, 11 Jun 2025 00:29:39 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPD5l-0001Ce-6f; Wed, 11 Jun 2025 00:29:39 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-87ec7acddd3so1000136241.2; 
 Tue, 10 Jun 2025 21:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749616175; x=1750220975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2eUFn/IbyRHJNYqhIoePao7Sh3XI1A2p/i1bR89VZE=;
 b=gynOFi1k7HrQnO/KmBn7Hw/QiMF9Dw+PlbblqEFUTnIQZ00HO7DAM6tb/Yv9p11l5g
 6Rs+MHxQusbyWq6ZAy2smzQW+XKMBCbcix8L0My0PiGqOv1TU5gZJuQgZcBQTP7cvQPe
 eBWKrbpcutE9MD0E4dPgFqL6sKLnwhptrXCQj0XmvElz/0WxPvv8I6v8gW8QCmxTX0oL
 +oisutxyIcrZid5cl3wICSOI58M0YDoY47x5ciIPK89bimENHTwGfOsiZuSrXE3mFS2W
 Xx3xNZIb4iv7FA6zNP0OrrzXVotfbtPhnR4YoFam5jlQGszV+Nihe+cgY15gwWNFocJW
 ng0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749616175; x=1750220975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2eUFn/IbyRHJNYqhIoePao7Sh3XI1A2p/i1bR89VZE=;
 b=jgPpSthn++qhwerOh5rmZ9bzMS9Pxv3N0MJA5hCdbIrHLmSDGkZoBWIoMih8o8dJLm
 7UarEiTQpbESs80FfcUVQf5GrYY9EsUDLZ3WLXHL8d85xoLHXoL9QZnwq/Dfb4AeCrlh
 TWX89yg8ZONPouG4LG3S+V/kmg/0llUoNo3LEusUOAxc7WAzFfFueqZ9Q35GEzs7se9p
 kpnlO6WPyOZ4PF20+j2wc5oMILeHEneep4+JN339lv4YIKolMxhXVpF6qhuASG2MfNfo
 e+EtQce4e1AK8XPMOqRlqaVqK4rrhGfIyI8kBaaUWuonEiUQU2a1myZ6Y9O2QY1sCPmx
 SRfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW68Aj3x67j/gWUO0CE8GPlQjvgQYAmvu7ngNYxj3steG3tzATb18MAirEE8DwzCJSlpGarg8CnQlt@nongnu.org
X-Gm-Message-State: AOJu0YyHfa4qCd9Su+hrRpWC88EODhj9SOp498cFp7oJqiG09HfeQOoG
 7Yf1ljk+Uxcl+RqkhypFNNoZRo4/fAFx7bNovmYBpIqnoG73Ur8pZHQhzeGPeGBgSsDyPdfwi0M
 hCM9ujOgbAR3dhzuQfJiBuTbRyTj27ME4Cw==
X-Gm-Gg: ASbGncte2uJbCoDynC4ycqwmU+NM68oQXk4taGfLhiBYb7N4keyhCcRm9nL4D0OqWkO
 TY8GVB0SH+XJY2UPLQQdcqbQvzKkbInRfYGZ9y5ek29aXxJ1Jhquw6BYVUQQaGj3zrleEY6y3qc
 P1fz+yYrCUQZg/kpfhp4SKGKu69B891u0QvyjhwRjXptSGmj3/x9IEaFqV2jW3UQ0cpSWHybngK
 A==
X-Google-Smtp-Source: AGHT+IGJtKBS8OiqPGKxno5chxV/sS9fZoMQH+gfrHyZOr/UEenWGgULW3p5F8up0qWWBYX8J+X1BU03yeJOHlZfE+c=
X-Received: by 2002:a05:6102:54a9:b0:4e7:4f6c:b275 with SMTP id
 ada2fe7eead31-4e7bbb69436mr1213906137.21.1749616175452; Tue, 10 Jun 2025
 21:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250610083309.992724-1-roan.richmond@codethink.co.uk>
 <20250610083309.992724-2-roan.richmond@codethink.co.uk>
In-Reply-To: <20250610083309.992724-2-roan.richmond@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 11 Jun 2025 14:29:09 +1000
X-Gm-Features: AX0GCFsjPuVjUH5TCZgw4dXIfvZfebWvzVPZgnRFKoBsF1DyPzY8X4IDZ-nOJC8
Message-ID: <CAKmqyKMG_wNPNdAYhsUFJ4K7o4g+LNYwUDUAO_8V14=GezDKPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Add RISCV ZALASR extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Tue, Jun 10, 2025 at 6:33=E2=80=AFPM Roan Richmond
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
> ---
>  target/riscv/cpu.c                           |   1 +
>  target/riscv/insn32.decode                   |  10 ++
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 110 +++++++++++++++++++
>  target/riscv/translate.c                     |   1 +
>  4 files changed, 122 insertions(+)
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
> index 0000000000..2f2934e731
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> @@ -0,0 +1,110 @@
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

I think we should check that aq isn't set

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

and check here that rq isn't set either

Alistair

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

