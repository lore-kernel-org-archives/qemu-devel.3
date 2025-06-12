Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17519C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 04:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPZyO-0006WC-NI; Thu, 12 Jun 2025 00:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPZyM-0006W0-GU
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 00:55:30 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPZyJ-0005N5-12
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 00:55:29 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4e7b3363c5aso972333137.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 21:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749704125; x=1750308925; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4YOTkGpuCk2oD5Bs/Qq8xdTwhaYQln1b5GiISMtD5c=;
 b=lLbSBbKA8/fd6bsixk60dXyjBd7NxxPzcA/Jr9mhWdfoc4b0OxYohmNadVCL5owURo
 3f3NI//rBaGqgs0UP8cBK+fsWNxOlim/zbVXc0wHI6DlRwFnJi7zxCV4MSP5JgqAkqQY
 kV7k3s9fRtjFZKCiVN9hwEhlJ8c8w18N41Icwa30APWR0CEN1rCkMFRz0EqkB+taeS38
 TbYyq7rxAThGtY+jHV27uRBuTmtJN6anCW0CMTSB446QysJGX/OTMDhF0lw3C+l7EFJy
 X3ZY0KFR5b6Mm/+wxwt0pBRw9nRLqSM9+a/2ewRD4ltKLfB2bx0vZB6dd5b6oxWjdgnT
 tHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749704125; x=1750308925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4YOTkGpuCk2oD5Bs/Qq8xdTwhaYQln1b5GiISMtD5c=;
 b=FFzjTFiXITwtFjVlKBukudUymW0OvunMynkCnGM7FxRtK3jPHQt0AR10NX8H1a4PAJ
 VfGS0qJNXeNKO+axoBkBsM4vBM5/+zSj1Ed64LWe/PZkdv479UCKPBM2GQh0ZPZ/D6gv
 9AJzPr51vml1F6cflLJbrtMIyRSMycUl52L7/gGRZv4daC5ay0cbkUk5a3uihn80/724
 FuQf65Ev3f6eTB3VhmTsbqGmjlvI5hqZc2dGpklOvv9jn57oQ8PJ/ln3iWogs6riMB6c
 qTMI9YeENpPlcWo5eCKgH8qNUjS8boFJ9SQ6SwEXFHy53g5zli54ak+HFJItd5YW3eQk
 bvqg==
X-Gm-Message-State: AOJu0YxMgBRbSMdNIsbOu5sQihD1XsLKoMAyca9yqbU+uKduYIcOiSJK
 y9l+pgZvmwbp9tuMJA/bQaf5hsUtmcGDdN/sS5TWQrO9bjZYtFnk/MVe3Gz/w2zy0wrIHCLNZys
 48pjwLVHAOy9YYj797+6CqC5FK67q4tBERGqD
X-Gm-Gg: ASbGnctGXtDU674pIyCd9rB0u7h+4xBfNajPX5uy/SBSmedI/3TAn+WUpZ7xjnrFroL
 VGSEFiztI/FDDtdaikNyvG2UfHKTtLiE0+FQWOuqnW6b4YmP49oovlVFEJftqHevWBvbGIxvT9E
 rKE0Lb2Te5RO2RuFNyGakZU07ZCEcJeAQGLsB6BTc/BkZZB0MlNzFoLpfbekovWKbnvnbVyfrVC
 be82KrJj5Il
X-Google-Smtp-Source: AGHT+IGDGcduE23JyWmEoCHiTGKYuHaWkklye7EbXtMHE8Er872+7vsDcAvi0tIhgPkozdK2aRF8ITXjF9p9oQoqbvw=
X-Received: by 2002:a05:6102:26c3:b0:4c5:2c3e:3841 with SMTP id
 ada2fe7eead31-4e7cd728b8dmr2148895137.5.1749704125573; Wed, 11 Jun 2025
 21:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7A4FF9227FF4329F4698E08F@qq.com>
In-Reply-To: <tencent_7A4FF9227FF4329F4698E08F@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Jun 2025 14:54:59 +1000
X-Gm-Features: AX0GCFuh8p4cfnTugzTmhHOLVibCwB88pqO1Z2TnSE7kI8kf5AmqQQuGzqJZCac
Message-ID: <CAKmqyKNhfXVchHMuCGm-fArrzm_EYk8v47XsOd3C92zSmGfTkA@mail.gmail.com>
Subject: Re: Re: [PATCH qemu v7 1/1] target/riscv: Add Zilsd and Zclsd
 extension support
To: =?UTF-8?B?5YiY5pet?= <liuxu@nucleisys.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Wed, Jun 11, 2025 at 5:10=E2=80=AFPM =E5=88=98=E6=97=AD <liuxu@nucleisys=
.com> wrote:
>
> Thanks for your reply.
>
> However, regarding the issue of register restrictions, since I continued =
to use the format in the basic C extension in insn16.deocode,  I think the =
register range has thus been compatible with `!function=3Dex_rvc_register`.

You are right!

In future please reply inline and in plain text though.

This is good to go then, do you mind rebasing it on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next and
sending a v8

Alistair

>
> Alistair Francis<alistair23@gmail.com> =E5=9C=A8 2025=E5=B9=B46=E6=9C=881=
1=E6=97=A5 =E5=91=A8=E4=B8=89 12:47 =E5=86=99=E9=81=93=EF=BC=9A
> On Thu, May 15, 2025 at 2:07=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
> >
> > From: lxx <1733205434@qq.com>
> >
> > This patch adds support for the Zilsd and Zclsd extension,
> > which is documented at https://github.com/riscv/riscv-zilsd/releases/ta=
g/v1.0
> >
> > Co-developed-by: SUN Dongya <sundongya@nucleisys.com>
> > Co-developed-by: LIU Xu <liuxu@nucleisys.com>
> > Co-developed-by: ZHAO Fujin <zhaofujin@nucleisys.com>
> > ---
> >  target/riscv/cpu.c                        |   4 +
> >  target/riscv/cpu_cfg.h                    |   2 +
> >  target/riscv/insn16.decode                |   8 ++
> >  target/riscv/insn32.decode                |  12 ++-
> >  target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
> >  target/riscv/tcg/tcg-cpu.c                |  20 ++++
> >  target/riscv/translate.c                  |   1 +
> >  7 files changed, 157 insertions(+), 2 deletions(-)
> >  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 09ded6829a..54072e284d 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -115,6 +115,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
> >      ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpau=
se),
> >      ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
> > +    ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
> >      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
> >      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> >      ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> > @@ -138,6 +139,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(zcmop, PRIV_VERSION_1_13_0, ext_zcmop),
> >      ISA_EXT_DATA_ENTRY(zcmp, PRIV_VERSION_1_12_0, ext_zcmp),
> >      ISA_EXT_DATA_ENTRY(zcmt, PRIV_VERSION_1_12_0, ext_zcmt),
> > +    ISA_EXT_DATA_ENTRY(zclsd, PRIV_VERSION_1_12_0, ext_zclsd),
> >      ISA_EXT_DATA_ENTRY(zba, PRIV_VERSION_1_12_0, ext_zba),
> >      ISA_EXT_DATA_ENTRY(zbb, PRIV_VERSION_1_12_0, ext_zbb),
> >      ISA_EXT_DATA_ENTRY(zbc, PRIV_VERSION_1_12_0, ext_zbc),
> > @@ -1653,6 +1655,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions=
[] =3D {
> >
> >      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
> >      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> > +    MULTI_EXT_CFG_BOOL("zilsd", ext_zilsd, false),
> >
> >      MULTI_EXT_CFG_BOOL("zba", ext_zba, true),
> >      MULTI_EXT_CFG_BOOL("zbb", ext_zbb, true),
> > @@ -1692,6 +1695,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions=
[] =3D {
> >      MULTI_EXT_CFG_BOOL("zcmp", ext_zcmp, false),
> >      MULTI_EXT_CFG_BOOL("zcmt", ext_zcmt, false),
> >      MULTI_EXT_CFG_BOOL("zicond", ext_zicond, false),
> > +    MULTI_EXT_CFG_BOOL("zclsd", ext_zclsd, false),
> >
> >      /* Vector cryptography extensions */
> >      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index 8a843482cc..1ca11f99f1 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -51,6 +51,7 @@ struct RISCVCPUConfig {
> >      bool ext_zcf;
> >      bool ext_zcmp;
> >      bool ext_zcmt;
> > +    bool ext_zclsd;
> >      bool ext_zk;
> >      bool ext_zkn;
> >      bool ext_zknd;
> > @@ -73,6 +74,7 @@ struct RISCVCPUConfig {
> >      bool ext_zihintntl;
> >      bool ext_zihintpause;
> >      bool ext_zihpm;
> > +    bool ext_zilsd;
> >      bool ext_zimop;
> >      bool ext_zcmop;
> >      bool ext_ztso;
> > diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
> > index bf893d1c2e..c34020e4dc 100644
> > --- a/target/riscv/insn16.decode
> > +++ b/target/riscv/insn16.decode
> > @@ -130,10 +130,14 @@ sw                110  ... ... .. ... 00 @cs_w
> >  {
> >    ld              011  ... ... .. ... 00 @cl_d
> >    c_flw           011  ... ... .. ... 00 @cl_w
> > +  # *** Zclsd Extension ***
> > +  zclsd_ld        011  ... ... .. ... 00 @cl_d
> >  }
> >  {
> >    sd              111  ... ... .. ... 00 @cs_d
> >    c_fsw           111  ... ... .. ... 00 @cs_w
> > +  # *** Zclsd Extension ***
> > +  zclsd_sd        111  ... ... .. ... 00 @cs_d
> >  }
> >
> >  # *** RV32/64C Standard Extension (Quadrant 1) ***
> > @@ -212,10 +216,14 @@ sw                110 .  .....  ..... 10 @c_swsp
> >    c64_illegal     011 -  00000  ----- 10 # c.ldsp, RES rd=3D0
> >    ld              011 .  .....  ..... 10 @c_ldsp
> >    c_flw           011 .  .....  ..... 10 @c_lwsp
> > +  # *** Zclsd Extension ***
> > +  zclsd_ldsp      011 .  .....  ..... 10 @c_ldsp
> >  }
> >  {
> >    sd              111 .  .....  ..... 10 @c_sdsp
> >    c_fsw           111 .  .....  ..... 10 @c_swsp
> > +  # *** Zclsd Extension ***
> > +  zclsd_sd        111 .  .....  ..... 10 @c_sdsp
> >  }
> >
> >  # *** RV64 and RV32 Zcb Extension ***
> > diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> > index 6d1a13c826..57c242c3bb 100644
> > --- a/target/riscv/insn32.decode
> > +++ b/target/riscv/insn32.decode
> > @@ -182,8 +182,16 @@ csrrci   ............     ..... 111 ..... 1110011 =
@csr
> >
> >  # *** RV64I Base Instruction Set (in addition to RV32I) ***
> >  lwu      ............   ..... 110 ..... 0000011 @i
> > -ld       ............   ..... 011 ..... 0000011 @i
> > -sd       ....... .....  ..... 011 ..... 0100011 @s
> > +{
> > +  ld       ............   ..... 011 ..... 0000011 @i
> > +  # *** Zilsd instructions ***
> > +  zilsd_ld ............   ..... 011 ..... 0000011 @i
> > +}
> > +{
> > +  sd       ....... .....  ..... 011 ..... 0100011 @s
> > +  # *** Zilsd instructions ***
> > +  zilsd_sd ....... .....  ..... 011 ..... 0100011 @s
> > +}
> >  addiw    ............   ..... 000 ..... 0011011 @i
> >  slliw    0000000 .....  ..... 001 ..... 0011011 @sh5
> >  srliw    0000000 .....  ..... 101 ..... 0011011 @sh5
> > diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/i=
nsn_trans/trans_zilsd.c.inc
> > new file mode 100644
> > index 0000000000..1e3ab362de
> > --- /dev/null
> > +++ b/target/riscv/insn_trans/trans_zilsd.c.inc
> > @@ -0,0 +1,112 @@
> > +/*
> > + * RISC-V translation routines for the Zilsd & Zclsd Extension.
> > + *
> > + * Copyright (c) 2024 Nucleisys, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITH=
OUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Licen=
se for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#define REQUIRE_ZILSD(ctx) do {    \
> > +    if (!ctx->cfg_ptr->ext_zilsd)  \
> > +        return false;              \
> > +} while (0)
> > +
> > +#define REQUIRE_ZCLSD(ctx) do {    \
> > +    if (!ctx->cfg_ptr->ext_zclsd)  \
> > +        return false;              \
> > +} while (0)
> > +
> > +static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
> > +{
> > +    if ((a->rd) % 2) {
> > +        return false;
> > +    }
> > +
> > +    TCGv dest_low =3D dest_gpr(ctx, a->rd);
> > +    TCGv dest_high =3D dest_gpr(ctx, a->rd + 1);
> > +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> > +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> > +
> > +    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> > +
> > +    if (a->rd =3D=3D 0) {
> > +        return true;
> > +    }
> > +
> > +    tcg_gen_extr_i64_tl(dest_low, dest_high, tmp);
> > +
> > +    gen_set_gpr(ctx, a->rd, dest_low);
> > +    gen_set_gpr(ctx, a->rd + 1, dest_high);
> > +
> > +    return true;
> > +}
> > +
> > +static bool trans_zilsd_ld(DisasContext *ctx, arg_zilsd_ld *a)
> > +{
> > +    REQUIRE_32BIT(ctx);
> > +    REQUIRE_ZILSD(ctx);
> > +    return gen_load_i64(ctx, a);
> > +}
> > +
> > +static bool trans_zclsd_ld(DisasContext *ctx, arg_zclsd_ld *a)
> > +{
> > +    REQUIRE_32BIT(ctx);
> > +    REQUIRE_ZCLSD(ctx);
>
> Shouldn't there be a check that only x8-15 is used?
>
> > +    return gen_load_i64(ctx, a);
> > +}
> > +
> > +static bool trans_zclsd_ldsp(DisasContext *ctx, arg_zclsd_ldsp *a)
> > +{
> > +    REQUIRE_32BIT(ctx);
> > +    REQUIRE_ZCLSD(ctx);
> > +
> > +    if (a->rd =3D=3D 0) {
> > +        return false;
> > +    }
> > +    return gen_load_i64(ctx, a);
> > +}
> > +
> > +static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
> > +{
> > +    if ((a->rs2) % 2) {
> > +        return false;
> > +    }
> > +
> > +    TCGv data_low =3D get_gpr(ctx, a->rs2, EXT_NONE);
> > +    TCGv data_high =3D get_gpr(ctx, a->rs2 + 1, EXT_NONE);
> > +    TCGv addr =3D get_address(ctx, a->rs1, a->imm);
> > +    TCGv_i64 tmp =3D tcg_temp_new_i64();
> > +
> > +    if (a->rs2 =3D=3D 0) {
> > +        tmp =3D tcg_constant_i64(0);
> > +    } else {
> > +        tcg_gen_concat_tl_i64(tmp, data_low, data_high);
> > +    }
> > +    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TESQ);
> > +
> > +    return true;
> > +}
> > +
> > +static bool trans_zilsd_sd(DisasContext *ctx, arg_zilsd_sd *a)
> > +{
> > +    REQUIRE_32BIT(ctx);
> > +    REQUIRE_ZILSD(ctx);
> > +    return gen_store_i64(ctx, a);
> > +}
> > +
> > +static bool trans_zclsd_sd(DisasContext *ctx, arg_zclsd_sd *a)
> > +{
> > +    REQUIRE_32BIT(ctx);
> > +    REQUIRE_ZCLSD(ctx);
>
> and a x8-15 check here as well
>
> Otherwise:
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > +    return gen_store_i64(ctx, a);
> > +}
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index 5aef9eef36..ea25817ffc 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -673,6 +673,26 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *c=
pu, Error **errp)
> >          cpu->pmu_avail_ctrs =3D 0;
> >      }
> >
> > +    if (cpu->cfg.ext_zilsd && riscv_has_ext(env, RVC)) {
> > +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zclsd), true);
> > +    }
> > +
> > +    if (cpu->cfg.ext_zclsd) {
> > +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
> > +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zilsd), true);
> > +
> > +        if (riscv_has_ext(env, RVC) && riscv_has_ext(env, RVF)) {
> > +            error_setg(errp,
> > +                    "Zclsd cannot be supported together with C and F e=
xtension");
> > +            return;
> > +        }
> > +        if (cpu->cfg.ext_zcf) {
> > +            error_setg(errp,
> > +                    "Zclsd cannot be supported together with Zcf exten=
sion");
> > +            return;
> > +        }
> > +    }
> > +
> >      if (cpu->cfg.ext_zicfilp && !cpu->cfg.ext_zicsr) {
> >          error_setg(errp, "zicfilp extension requires zicsr extension")=
;
> >          return;
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index d6651f244f..2cf1378dfd 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -1201,6 +1201,7 @@ static uint32_t opcode_at(DisasContextBase *dcbas=
e, target_ulong pc)
> >  /* Include the auto-generated decoder for 16 bit insn */
> >  #include "decode-insn16.c.inc"
> >  #include "insn_trans/trans_rvzce.c.inc"
> > +#include "insn_trans/trans_zilsd.c.inc"
> >  #include "insn_trans/trans_rvzcmop.c.inc"
> >  #include "insn_trans/trans_rvzicfiss.c.inc"
> >
> > --
> > 2.45.3

