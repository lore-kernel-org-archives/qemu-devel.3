Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A725C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 02:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRMFj-00085i-Fj; Mon, 16 Jun 2025 22:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uRMFi-00085a-Ig
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 22:40:46 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uRMFg-0001uV-8k
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 22:40:46 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4e7f367ea11so1074880137.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750128043; x=1750732843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zVaB+b7OPu+khFMAUPccjK/AM+vGrU2rhDXtxGhlAY=;
 b=WV382soEzcFRu1WqsKdm1uAuKZtduodCXMK7tasZJwW+hT1A02lbuny4Jllr9hbG+S
 ZU0s6c2e9Jbo+yyBKYRxgER76oQ7bU5Cyc+FaDfLiNMVE8m8JhA5KkeJN/9SQddCAVe2
 d9PxIiy3LF7wFzJpinJJaWxwn2j1F0Wa91deIDxQIkcNCif7hiqZBcdEZk4KeooG8D03
 Qw1jkiWmadR0O6WIjF5CI5dVCbcc4dNtr+jH1aLEhS4ErARlSCIcNxgWaKu73z3YUO93
 gT9pBzAQ9i5ZssRjx+UuBw6vbdaSqEeM9uSXX2L9hhI/q/7S8MkVhRkSUgjWqDEVQEbN
 pk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750128043; x=1750732843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zVaB+b7OPu+khFMAUPccjK/AM+vGrU2rhDXtxGhlAY=;
 b=i0rzFj8S6O3P24uR163m5gajJj9KE9Yce6F4ez4HMJF9Mnxha5PxoCB8GFAuQKbs9M
 fU4LT9StvXVeEe2sTwszijaiBQLi5N1If8Ui6K6JceyV5zqBUwOyKEcY+CS+UXuxdVxy
 IWJLIduyj+s8QRuM8QMp7IBVA82xULn0y0IPCmqjk/Hp65O4XGDjk+Cq2lcs1s6S3adR
 NvfJQVEUxhrcEHE6dnBVDgMP5s52OFEqKkB58kUTPobP1r+mBpTUdTwMkrAyZBax/dg1
 m44F3CRFpweHtVb2lFacbou/t1o1KKcbq4CDs7LTZVmPBTTHgPtqegeDjyVwTiWTT3QL
 L9hQ==
X-Gm-Message-State: AOJu0YxwTCcuDSkWwxAdjOaDp3V+Au9muQ/+w+Wpm3UFiu6p7wvqoKDh
 +vMUPQaXcCIjhYpfjS+Rcpe2PzOwQ2+n71xRW+qSyfXQCmZoYMzbpq/MUMCDjgP7fr2yR8/hw9M
 TJj8/rhh22+uWexszpwFYRju5OfNXkS4=
X-Gm-Gg: ASbGnctqFmdf5NuUtafa4v0zP++FJ1rP5LuIKHVEVc8a/+qwWHT9RqKy7x4oh9v2nV0
 EE/DP6ny1RKoZbfRWygrVyGY3N/Ocla1/WzgDQ/8T8fRWos3BdDtS2wMiDFjByrX/kLoz6yVH2R
 GWy1Fr2EzviIliHcRsMrvcN5eT6jclRAcZEigrNJfJt3BsHscISUvWYVxdNjdV3WJbC1ZlOeDeu
 lJEItOzj7vn
X-Google-Smtp-Source: AGHT+IHUA+mkaDPUhgY6oIjyaADiFuC6gXx8dyD2MrXW6Y6aMSckUd8zf+GJ9Mj7kGl5BG5nHHz4gL8I0uUbUGoCmA4=
X-Received: by 2002:a05:6102:418d:b0:4dd:b82d:e0de with SMTP id
 ada2fe7eead31-4e7f6223165mr7809924137.17.1750128042935; Mon, 16 Jun 2025
 19:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <174971620915.19456.15836954551382475540-0@git.sr.ht>
 <174971620915.19456.15836954551382475540-1@git.sr.ht>
In-Reply-To: <174971620915.19456.15836954551382475540-1@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Jun 2025 12:40:15 +1000
X-Gm-Features: AX0GCFvhTe7lMR2QWGsjlfASKTiMChv4LNr2u0d6720nCk5BY_WbcKZhkAFcshI
Message-ID: <CAKmqyKMHJgh9bf7S1rJjhmrMkNK9dQy4Wh_dfVfn5LLZS4pzqA@mail.gmail.com>
Subject: Re: [PATCH qemu v8 1/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: "~liuxu" <liuxu@nucleisys.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Thu, Jun 12, 2025 at 6:16=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
>
> From: lxx <1733205434@qq.com>
>
> This patch adds support for the Zilsd and Zclsd extension,
> which is documented at https://github.com/riscv/riscv-zilsd/releases/tag/=
v1.0
>
> Signed-off-by: LIU Xu <liuxu@nucleisys.com>
> Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
> Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c                        |   4 +
>  target/riscv/cpu_cfg_fields.h.inc         |   2 +
>  target/riscv/insn16.decode                |   8 ++
>  target/riscv/insn32.decode                |  12 ++-
>  target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                |  30 ++++++
>  target/riscv/translate.c                  |   1 +
>  7 files changed, 167 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 758f254c15..778816901a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -121,6 +121,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
>      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause=
),
>      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
>      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> @@ -144,6 +145,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
>      ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
>      ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
> +    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
>      ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
>      ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
>      ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
> @@ -1289,6 +1291,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
>
>      MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
>      MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
> @@ -1328,6 +1331,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
>      MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
>      MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
> +    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
>
>      /* Vector cryptography extensions */
>      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 33c4f9bac8..9833d592bd 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -19,6 +19,7 @@ BOOL_FIELD(ext_zce)
>  BOOL_FIELD(ext_zcf)
>  BOOL_FIELD(ext_zcmp)
>  BOOL_FIELD(ext_zcmt)
> +BOOL_FIELD(ext_zclsd)
>  BOOL_FIELD(ext_zk)
>  BOOL_FIELD(ext_zkn)
>  BOOL_FIELD(ext_zknd)
> @@ -41,6 +42,7 @@ BOOL_FIELD(ext_zicond)
>  BOOL_FIELD(ext_zihintntl)
>  BOOL_FIELD(ext_zihintpause)
>  BOOL_FIELD(ext_zihpm)
> +BOOL_FIELD(ext_zilsd)
>  BOOL_FIELD(ext_zimop)
>  BOOL_FIELD(ext_zcmop)
>  BOOL_FIELD(ext_ztso)
> diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> index bf893d1c2e..c34020e4dc 100644
> --- a/target/riscv/insn16.decode
> +++ b/target/riscv/insn16.decode
> @@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
>  {
>    ld              011  ... ... .. ... 00 @cl_d
>    c_flw           011  ... ... .. ... 00 @cl_w
> +  # *** Zclsd Extension ***
> +  zclsd_ld        011  ... ... .. ... 00 @cl_d
>  }
>  {
>    sd              111  ... ... .. ... 00 @cs_d
>    c_fsw           111  ... ... .. ... 00 @cs_w
> +  # *** Zclsd Extension ***
> +  zclsd_sd        111  ... ... .. ... 00 @cs_d
>  }
>
>  # *** RV32/64C Standard Extension (Quadrant 1) ***
> @@ -212,10 +216,14 @@ sw                110 .  .....  ..... 10 @c_swsp
>    c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=3D0
>    ld              011 .  .....  ..... 10 @c_ldsp
>    c_flw           011 .  .....  ..... 10 @c_lwsp
> +  # *** Zclsd Extension ***
> +  zclsd_ldsp      011 .  .....  ..... 10 @c_ldsp
>  }
>  {
>    sd              111 .  .....  ..... 10 @c_sdsp
>    c_fsw           111 .  .....  ..... 10 @c_swsp
> +  # *** Zclsd Extension ***
> +  zclsd_sd        111 .  .....  ..... 10 @c_sdsp
>  }
>
>  # *** RV64 and RV32 Zcb Extension ***
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cd23b1f3a9..b341832e41 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -182,8 +182,16 @@ csrrci   ............     ..... 111 ..... 1110011 @c=
sr
>
>  # *** RV64I Base Instruction Set (in addition to RV32I) ***
>  lwu      ............   ..... 110 ..... 0000011 @i
> -ld       ............   ..... 011 ..... 0000011 @i
> -sd       ....... .....  ..... 011 ..... 0100011 @s
> +{
> +  ld       ............   ..... 011 ..... 0000011 @i
> +  # *** Zilsd instructions ***
> +  zilsd_ld ............   ..... 011 ..... 0000011 @i
> +}
> +{
> +  sd       ....... .....  ..... 011 ..... 0100011 @s
> +  # *** Zilsd instructions ***
> +  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s
> +}
>  addiw    ............   ..... 000 ..... 0011011 @i
>  slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
>  srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
> diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/ins=
n_trans/trans_zilsd.c.inc
> new file mode 100644
> index 0000000000..7bdc303298
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> @@ -0,0 +1,112 @@
> +/*
> + * RISC-V translation routines for the Zilsd & Zclsd Extension.
> + *
> + * Copyright (c) 2025 Nucleisys, Inc.
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
> +#define REQUIRE_ZILSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zilsd)  \
> +        return false;              \
> +} while (0)
> +
> +#define REQUIRE_ZCLSD(ctx) do {    \
> +    if (!ctx->cfg_ptr->ext_zclsd)  \
> +        return false;              \
> +} while (0)
> +
> +static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
> +{
> +    if ((a->rd) % 2) {
> +        return false;
> +    }
> +
> +    TCGv dest_low =3D dest_gpr(ctx, a->rd);
> +    TCGv dest_high =3D dest_gpr(ctx, a->rd + 1);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +    if (a->rd =3D=3D 0) {
> +        return true;
> +    }
> +
> +    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
> +
> +    gen_set_gpr(ctx, a->rd, dest_low);
> +    gen_set_gpr(ctx, a->rd + 1, dest_high);
> +
> +    return true;
> +}
> +
> +static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZILSD(ctx);
> +    return gen_load_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);
> +    return gen_load_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_ldsp(DisasContext *ctx, arg_zclsd_ldsp *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);
> +
> +    if (a->rd =3D=3D 0) {
> +        return false;
> +    }
> +    return gen_load_i64(ctx, a);
> +}
> +
> +static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
> +{
> +    if ((a->rs2) % 2) {
> +        return false;
> +    }
> +
> +    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv data_high =3D get_gpr(ctx, a->rs2 + 1, EXT_NONE);
> +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +
> +    if (a->rs2 =3D=3D 0) {
> +        tmp =3D tcg_constant_i64(0);
> +    } else {
> +        tcg_gen_concat_tl_i64(tmp, data_low, data_high);
> +    }
> +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> +
> +    return true;
> +}
> +
> +static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZILSD(ctx);
> +    return gen_store_i64(ctx, a);
> +}
> +
> +static bool trans_zclsd_sd(DisasContext *ctx, arg_zclsd_sd *a)
> +{
> +    REQUIRE_32BIT(ctx);
> +    REQUIRE_ZCLSD(ctx);
> +    return gen_store_i64(ctx, a);
> +}
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 163e7ce364..0944426b38 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -818,6 +818,19 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu->pmu_avail_ctrs =3D 0;
>      }
>
> +    if (cpu->cfg.ext_zclsd) {
> +        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {
> +            error_setg(errp,
> +                    "Zclsd cannot be supported together with C and F ext=
ension");
> +            return;
> +        }
> +        if (cpu->cfg.ext_zcf) {
> +            error_setg(errp,
> +                    "Zclsd cannot be supported together with Zcf extensi=
on");
> +            return;
> +        }
> +    }
> +
>      if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
>          error_setg(errp, "zicfilp extension requires zicsr extension");
>          return;
> @@ -1075,6 +1088,20 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *=
cpu)
>      }
>  }
>
> +static void cpu_enable_zilsd_implied_rules(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);
> +    }
> +
> +    if (cpu->cfg.ext_zclsd) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);
> +    }
> +}
> +
>  static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
>  {
>      RISCVCPUImpliedExtsRule *rule;
> @@ -1083,6 +1110,9 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU=
 *cpu)
>      /* Enable the implied extensions for Zc. */
>      cpu_enable_zc_implied_rules(cpu);
>
> +    /* Enable the implied extensions for Zilsd. */
> +    cpu_enable_zilsd_implied_rules(cpu);
> +
>      /* Enable the implied MISAs. */
>      for (i =3D 0; (rule =3D riscv_misa_ext_implied_rules[i]); i++) {
>          if (riscv_has_ext(&cpu->env, rule->ext)) {
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 9ddef2d6e2..62f714034f 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1200,6 +1200,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase,=
 target_ulong pc)
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode-insn16.c.inc"
>  #include "insn_trans/trans_rvzce.c.inc"
> +#include "insn_trans/trans_zilsd.c.inc"
>  #include "insn_trans/trans_rvzcmop.c.inc"
>  #include "insn_trans/trans_rvzicfiss.c.inc"
>
> --
> 2.45.3

