Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63820C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPI3W-0003Im-W5; Wed, 11 Jun 2025 05:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPI3T-0003Hz-1M; Wed, 11 Jun 2025 05:47:35 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPI3Q-0003Pg-L7; Wed, 11 Jun 2025 05:47:34 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4e7b9cbd19dso269958137.3; 
 Wed, 11 Jun 2025 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749635251; x=1750240051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awRc/DNO5eRGkLv4XopLH+BD4TWdYKkoQJMFk3+KXbU=;
 b=KcKSn3JSfkzP5rRy/fmOBiCBCBFN/IIFtaiJ9dLNGoXrVWS+T+DirI9Th4kSXr2dZm
 0ayJuTPRJqy8pakJBEKVA0xHl29rLdNUhPIga6BQ/IACy1s8crA8fLieIMvT+TYKDgx9
 fmQJYf3HJZhG7nsq0LsH8M14uMDIIFx9zJwwqdPVKOICKG3kEK7YPMmXYqlCrsKLq01c
 +gK/tHxMke481leQo5uw8qHZSNWCZw2Cgkx+ViWQ9K6Aj66xL0SOyf92qMtT96Dn5xEb
 /jO7e7M1N925Xuk78yitlXjYX5biAh6hYiF5e2Z2rSN5TtI0F/lKSeHwR3rG6Sbt61Bf
 N7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749635251; x=1750240051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awRc/DNO5eRGkLv4XopLH+BD4TWdYKkoQJMFk3+KXbU=;
 b=T6vYgwxRmcSnR3fzqcFpGJJlg4eI8Hy2DPmgiLRQygn74WWK7ugIB4yi/3zpi29arY
 NTEf2NtuSkm6nkONcI+vB+im1YlwKeqovSJ/+Gva00WG2SugFqKpNm9E6tLxJB+NJ/bD
 KwHySjnTSHgLwQIjx4CbWJ4MQkKibwwTzCxnUnlI5QsfEeQKO/SbM+XWDJjEZjVvr1FJ
 lzQ9R6lO5r2nO+3YN2LapgzgiKHZQAyrGSpgJG2VZlxetzieqvM2wyRQruN4H4DXjcpr
 aH0wEEeTwPCczDkxvjujly2aG6Ky1n/RiyKK0dIDdUyr5VZ6/HwAKpkQcXVXpT/PA+5y
 jiew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEFUcWGefKvRVGJI//x/bXZVsh1GuDKpmOhNxRInHmyr/J1m/BtjRaP7dEpdzuVU7bxwU55tZtCXcP@nongnu.org
X-Gm-Message-State: AOJu0Yy+k+MXz77s4RmW1TIFVy+Mf0tw8NaJUu+xn/UZTzGUNq/gdpxh
 Q50jb+5XHHS+WHgsjlMhyolBFtl0A/gwVVxg3m+rkmGClBX97Wwki9sgYhHuLi4urXw0NwAhcuw
 yrbAwGjlbamaBKmeZGMKTV02rgMQHUJ0=
X-Gm-Gg: ASbGncuOKyROm8m9W1m8Em9sI9dAe2jL2vnS9tPUZNUTaBYcUy4GQkMG7ujdfDIaomM
 cUKb351mlBBpzzzvRE0ajWeLMjtMXLRf1U2wCXnP+Dgw8YEqy9K0/6bA1YGEGqz2BNW+ij9tlKi
 NDqJodDjLB6P2x/N8vIz0JciMXg4zF2ix4KoPAGmAOC0AdbJqIZfy0itxskFkuugK2V3UnlKJse
 A==
X-Google-Smtp-Source: AGHT+IGTCUlvslnNcQ36mlqZcFrGz8G8bJ7JZiNdyv9t91/Xnn4x60oQaCW7pKwo4zTGPQIEgfdZgPTZ26BV8r5quwg=
X-Received: by 2002:a05:6102:1588:b0:4cb:5d6c:9946 with SMTP id
 ada2fe7eead31-4e7bbab6d2cmr1545468137.10.1749635250587; Wed, 11 Jun 2025
 02:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250610083309.992724-1-roan.richmond@codethink.co.uk>
 <20250610083309.992724-2-roan.richmond@codethink.co.uk>
 <CAKmqyKMG_wNPNdAYhsUFJ4K7o4g+LNYwUDUAO_8V14=GezDKPg@mail.gmail.com>
 <786197e2-360b-4723-99d6-445b8a2076ae@codethink.co.uk>
In-Reply-To: <786197e2-360b-4723-99d6-445b8a2076ae@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 11 Jun 2025 19:47:03 +1000
X-Gm-Features: AX0GCFubRgLRedORCkEA6xa5qp2EsZt0bdpE4Valg3xoyPsIOksWMQ8rM5MXAg4
Message-ID: <CAKmqyKMsUoHhps1osLNqkX6kRz2sP1q=UWYLteks+SoDuOjXVQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Add RISCV ZALASR extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Wed, Jun 11, 2025 at 7:33=E2=80=AFPM Roan Richmond
<roan.richmond@codethink.co.uk> wrote:
>
>
> On 11/06/2025 05:29, Alistair Francis wrote:
> > On Tue, Jun 10, 2025 at 6:33=E2=80=AFPM Roan Richmond
> > <roan.richmond@codethink.co.uk> wrote:
> >> This is based on version v0.8.3 of the ZALASR specification [1].
> >> The specification is listed as in Frozen state [2].
> >>
> >> [1]: https://github.com/riscv/riscv-zalasr/tree/v0.8.3
> >> [2]: https://lf-riscv.atlassian.net/wiki/spaces/HOME/pages/16154882/Al=
l+RISC-V+Specifications+Under+Active+Development
> >>
> >> Signed-off-by: Roan Richmond <roan.richmond@codethink.co.uk>
> >> ---
> >>   target/riscv/cpu.c                           |   1 +
> >>   target/riscv/insn32.decode                   |  10 ++
> >>   target/riscv/insn_trans/trans_rvzalasr.c.inc | 110 +++++++++++++++++=
++
> >>   target/riscv/translate.c                     |   1 +
> >>   4 files changed, 122 insertions(+)
> >>   create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
> >>
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index 629ac37501..b52bbf0936 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -128,6 +128,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >>       ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
> >>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> >>       ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
> >> +    ISA_EXT_DATA_ENTRY(zalasr, PRIV_VERSION_1_12_0, ext_zalasr),
> >>       ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
> >>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
> >>       ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
> >> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> >> index cd23b1f3a9..c848c0c1c5 100644
> >> --- a/target/riscv/insn32.decode
> >> +++ b/target/riscv/insn32.decode
> >> @@ -1066,3 +1066,13 @@ amominu_h  11000 . . ..... ..... 001 ..... 0101=
111 @atom_st
> >>   amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
> >>   amocas_b    00101 . . ..... ..... 000 ..... 0101111 @atom_st
> >>   amocas_h    00101 . . ..... ..... 001 ..... 0101111 @atom_st
> >> +
> >> +# *** Zalasr Standard Extension ***
> >> +lb_aqrl  00110 . . ..... ..... 000 ..... 0101111 @atom_st
> >> +lh_aqrl  00110 . . ..... ..... 001 ..... 0101111 @atom_st
> >> +lw_aqrl  00110 . . ..... ..... 010 ..... 0101111 @atom_st
> >> +ld_aqrl  00110 . . ..... ..... 011 ..... 0101111 @atom_st
> >> +sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
> >> +sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
> >> +sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
> >> +sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> >> diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/ris=
cv/insn_trans/trans_rvzalasr.c.inc
> >> new file mode 100644
> >> index 0000000000..2f2934e731
> >> --- /dev/null
> >> +++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
> >> @@ -0,0 +1,110 @@
> >> +/*
> >> + * RISC-V translation routines for the ZALASR (Load-Aquire and Store-=
Release)
> >> + * Extension.
> >> + *
> >> + * Copyright (c) 2025 Roan Richmond, roan.richmond@codethink.co.uk
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy it
> >> + * under the terms and conditions of the GNU General Public License,
> >> + * version 2 or later, as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope it will be useful, but WIT=
HOUT
> >> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or
> >> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lice=
nse for
> >> + * more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License =
along with
> >> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> >> + */
> >> +
> >> +#define REQUIRE_ZALASR(ctx) do {     \
> >> +    if (!ctx->cfg_ptr->ext_zalasr) { \
> >> +        return false;                \
> >> +    }                                \
> >> +} while (0)
> >> +
> >> +static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp=
 memop)
> >> +{
> >> +    decode_save_opc(ctx, 0);
> >> +
> >> +    TCGv addr =3D get_address(ctx, a->rs1, 0);
> >> +    TCGv dest =3D get_gpr(ctx, a->rd, EXT_NONE);
> >> +    TCGBar bar =3D (a->rl) ? TCG_BAR_STRL : 0;
> > I think we should check that aq isn't set
> According to the spec, it is valid for both of `rl` and `aq` to be set.

The spec states:

"The versions without the aq bit set are RESERVED"

> For the Load Acquire instruction it just states that `aq` must be set,
> and `rl` is optionally set.

Exactly, so we need to ensure that aq is set, otherwise it's an
invalid instruction.

Alistair

> Therefore, I don't think we should check that `aq` isn't set here.
> >> +
> >> +    memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> >> +
> >> +    tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
> >> +    gen_set_gpr(ctx, a->rd, dest);
> >> +
> >> +    /* Add a memory barrier implied by AQ (mandatory) and RL (optiona=
l) */
> >> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ | bar);
> >> +
> >> +    return true;
> >> +}
> >> +
> >> +static bool trans_lb_aqrl(DisasContext *ctx, arg_lb_aqrl *a)
> >> +{
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_SB));
> >> +}
> >> +
> >> +static bool trans_lh_aqrl(DisasContext *ctx, arg_lh_aqrl *a)
> >> +{
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESW));
> >> +}
> >> +
> >> +static bool trans_lw_aqrl(DisasContext *ctx, arg_lw_aqrl *a)
> >> +{
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TESL));
> >> +}
> >> +
> >> +static bool trans_ld_aqrl(DisasContext *ctx, arg_ld_aqrl *a)
> >> +{
> >> +    REQUIRE_64BIT(ctx);
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_load_acquire(ctx, a, (MO_ALIGN | MO_TEUQ));
> >> +}
> >> +
> >> +static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemO=
p memop)
> >> +{
> >> +    decode_save_opc(ctx, 0);
> >> +
> >> +    TCGv addr =3D get_address(ctx, a->rs1, 0);
> >> +    TCGv data =3D get_gpr(ctx, a->rs2, EXT_NONE);
> >> +    TCGBar bar =3D (a->aq) ? TCG_BAR_LDAQ : 0;
> > and check here that rq isn't set either
> >
> > Alistair
> For the Store Release instruction it the spec just states that `rl` must
> be set, and `aq` is optionally set.
> Therefore, I don't think we should check that `rl` isn't set here.
> >> +
> >> +    memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
> >> +
> >> +    /* Add a memory barrier implied by RL (mandatory) and AQ (optiona=
l) */
> >> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL | bar);
> >> +
> >> +    tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
> >> +    return true;
> >> +}
> >> +
> >> +static bool trans_sb_aqrl(DisasContext *ctx, arg_sb_aqrl *a)
> >> +{
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_SB));
> >> +}
> >> +
> >> +static bool trans_sh_aqrl(DisasContext *ctx, arg_sh_aqrl *a)
> >> +{
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESW));
> >> +}
> >> +
> >> +static bool trans_sw_aqrl(DisasContext *ctx, arg_sw_aqrl *a)
> >> +{
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TESL));
> >> +}
> >> +
> >> +static bool trans_sd_aqrl(DisasContext *ctx, arg_sd_aqrl *a)
> >> +{
> >> +    REQUIRE_64BIT(ctx);
> >> +    REQUIRE_ZALASR(ctx);
> >> +    return gen_store_release(ctx, a, (MO_ALIGN | MO_TEUQ));
> >> +}
> >> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> >> index d7a6de02df..4cd2d68e46 100644
> >> --- a/target/riscv/translate.c
> >> +++ b/target/riscv/translate.c
> >> @@ -1183,6 +1183,7 @@ static uint32_t opcode_at(DisasContextBase *dcba=
se, target_ulong pc)
> >>   #include "insn_trans/trans_rvzicond.c.inc"
> >>   #include "insn_trans/trans_rvzacas.c.inc"
> >>   #include "insn_trans/trans_rvzabha.c.inc"
> >> +#include "insn_trans/trans_rvzalasr.c.inc"
> >>   #include "insn_trans/trans_rvzawrs.c.inc"
> >>   #include "insn_trans/trans_rvzicbo.c.inc"
> >>   #include "insn_trans/trans_rvzimop.c.inc"
> >> --
> >> 2.43.0
> >>
> Thanks,
> Roan
>
> --
> Roan Richmond (he/him)
> Software Engineer
> Codethink Ltd
>

