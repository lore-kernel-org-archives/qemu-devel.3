Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FA8F9EDDB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFYIC-0007Kh-Nb; Wed, 22 Apr 2026 10:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wFYI7-0007K6-0f
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:11:00 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wFYHx-0004L8-EX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 10:10:55 -0400
Received: by mail-ua1-x944.google.com with SMTP id
 a1e0cc1a2514c-9540bb77b1aso3148269241.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776867046; x=1777471846; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XDwRjbLNosE3ApFGLbO2kBOqWGS300M2od7l07HoBVs=;
 b=FXhm+I9sn7MORyWOvciL/o/Vk77oci8/fjtA3cT+OlH6QTfXsrz8ruHErHVk6eAmqk
 D1+PtmrlrNEUI5Z+MQP9fX+4TIykV9rKPo/gH/zBjoUfwPelPlkv6smOo6mt+JWbl1Bt
 16bTeCbJp8IB1Kn0B+1PeVphxwVgdnIPyy+Qu5gUj8gOhrUGIk0HhbqyD8jCV3UsyFao
 8+83jZglz3/15jONRn2VauXuC0AHOIu0J46Bc7eavU5PxOZfdjZkQpAYJrLW1rCGBIPv
 s4ON8jR14ikPvsYBIuEEXAHU5ej9FT3EN1Wtz/8tekoKSGleRWAUfFxMBs/+OVkYrc2D
 3enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776867046; x=1777471846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDwRjbLNosE3ApFGLbO2kBOqWGS300M2od7l07HoBVs=;
 b=Wrh6riEW6cxIfwBBziYLHOgn2iLoon2ZS7BIwMuero6cfWdmd5eUF8dS8+sR6SLIWy
 Xx8k3j53ms4hhiOTKbqSg6rHk89P7EoJxPabbg1khst4KFi80TthH8G4d3VQaWJoKPwo
 WXifaQ2zy/dsLguCkZNnTo/ak0b2ZRHVrZ1ERPnuKu6s2u3PIyrJ4X72gWV5BQSbMBHG
 97CP8xaI7G6JbqqrYCyYyj0juTgMKXa4w7Ryly5UJo2qGpOvyo7NIV/GkK2yv59C/rlL
 ytpa33Oj0Q5iCSZ/1LNF5trr888WudxB48huRnYZ147zZRtOZESFfafQjRZUFr5d38VI
 Xsdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EYsf/1vaI4ihUNy0rw1tyJY9kRIA4JtcdsgTGmiBf1lddUwHiSr3indRb5EEAVS0Xvx+Mlu3IR5QL@nongnu.org
X-Gm-Message-State: AOJu0Yw5A1Ctj9dqHx3rTojr5kDMmXxYiB0F4YYL5H+Yi5ELzxqgNk9w
 nYVuakZ2tcImXAmo2dKjsk2sci+q72uJ11oScXqtEMIS3XW8AJB6pv8I
X-Gm-Gg: AeBDiesE0alqiD4AWk+FywcexSSQOu9wwjbV3R2YuynYjvD73VRAT+bakdi4N81/AnT
 pxy0zRq+xX9zDRspowo/duR6azD+iLzzso8vLzrI1yGeu0Q9rqFPRiBT6y77c+ywz+YT5foC68k
 NeSwztvEA13XfvDscv+BTD1dRP688v9JP7U1hzLpMFDshht8qspKgYinQ3/EoQR44eAK6ogGHDq
 1IlnEf0YLrlfswg7m+zx0nNyWFMcWwdf2MmeeVpFrI9LqiqGxk8ICGcw6NBHvsmY6gP3xt/A+VY
 dyycQPcuarLqRXf211b9doE/RLMSkL96065dIWd5/ZjQ8L45YRguzbdcQf9B8893Kq8pgSr15sh
 6n39uR8yhUp4rjf4+24cTMIkjOGOCvZcDnOcLlzDIcUCY20tSW104axKcdXRsJ+h1BWaV+AoliD
 31d4wxaWorc2uWxMDdLG74dBwf9JR0xkf8+6LoATDhl3mH3kZ0oLV0X5ineIVRljeCDUhDa0up3
 ifLm9++LlY=
X-Received: by 2002:a05:6102:41a6:b0:60f:c9ba:b992 with SMTP id
 ada2fe7eead31-616f68d760dmr11780212137.16.1776867045815; 
 Wed, 22 Apr 2026 07:10:45 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-61745d93542sm7793366137.6.2026.04.22.07.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:10:45 -0700 (PDT)
Date: Wed, 22 Apr 2026 22:10:28 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Molly Chen <xiaoou@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 02/14] target/riscv: rvp: add arithmetic
 instructions,including saturating and non-saturating operations
Message-ID: <aejRC51hrTYRLDEY@ZEVORN-PC.localdomain>
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <20260417104652.17857-3-xiaoou@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417104652.17857-3-xiaoou@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::944;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-ua1-x944.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 17, 2026 at 06:46:39PM +0800, Molly Chen wrote:
> Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
> ---
>  target/riscv/helper.h                   |   40 +
>  target/riscv/insn32.decode              |   65 ++
>  target/riscv/insn_trans/trans_rvp.c.inc |  564 ++++++++++++
>  target/riscv/meson.build                |    3 +-
>  target/riscv/psimd_helper.c             | 1069 +++++++++++++++++++++++
>  target/riscv/translate.c                |    1 +
>  6 files changed, 1741 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvp.c.inc
>  create mode 100644 target/riscv/psimd_helper.c
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 54d2331966..76bc6583fb 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1351,3 +1351,43 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_1(ssamoswap_disabled, void, env)
>  #endif
> +
> +/* Packed SIMD */
> +DEF_HELPER_3(padd_b, tl, env, tl, tl)
> +DEF_HELPER_3(padd_h, tl, env, tl, tl)
> +DEF_HELPER_3(padd_w, i64, env, i64, i64)
> +DEF_HELPER_3(padd_bs, tl, env, tl, tl)
> +DEF_HELPER_3(padd_hs, tl, env, tl, tl)
> +DEF_HELPER_3(padd_ws, i64, env, i64, i64)
> +DEF_HELPER_3(psub_b, tl, env, tl, tl)
> +DEF_HELPER_3(psub_h, tl, env, tl, tl)
> +DEF_HELPER_3(psub_w, i64, env, i64, i64)
> +DEF_HELPER_3(psh1add_h, tl, env, tl, tl)
> +DEF_HELPER_3(psh1add_w, i64, env, i64, i64)
> +DEF_HELPER_3(pssh1sadd_h, tl, env, tl, tl)
> +DEF_HELPER_3(pssh1sadd_w, i64, env, i64, i64)
> +DEF_HELPER_3(ssh1sadd, i32, env, i32, i32)
> +DEF_HELPER_3(psadd_b, tl, env, tl, tl)
> +DEF_HELPER_3(psadd_h, tl, env, tl, tl)
> +DEF_HELPER_3(psadd_w, i64, env, i64, i64)
> +DEF_HELPER_3(psaddu_b, tl, env, tl, tl)
> +DEF_HELPER_3(psaddu_h, tl, env, tl, tl)
> +DEF_HELPER_3(psaddu_w, i64, env, i64, i64)
> +DEF_HELPER_3(sadd, i32, env, i32, i32)
> +DEF_HELPER_3(saddu, i32, env, i32, i32)
> +DEF_HELPER_3(pssub_b, tl, env, tl, tl)
> +DEF_HELPER_3(pssub_h, tl, env, tl, tl)
> +DEF_HELPER_3(pssub_w, i64, env, i64, i64)
> +DEF_HELPER_3(pssubu_b, tl, env, tl, tl)
> +DEF_HELPER_3(pssubu_h, tl, env, tl, tl)
> +DEF_HELPER_3(pssubu_w, i64, env, i64, i64)
> +DEF_HELPER_3(ssub, i32, env, i32, i32)
> +DEF_HELPER_3(ssubu, i32, env, i32, i32)
> +DEF_HELPER_3(psati_h, tl, env, tl, tl)
> +DEF_HELPER_3(pusati_h, tl, env, tl, tl)
> +DEF_HELPER_3(psati_w, i64, env, i64, i64)
> +DEF_HELPER_3(pusati_w, i64, env, i64, i64)
> +DEF_HELPER_3(sati_32, i32, env, i32, i32)
> +DEF_HELPER_3(usati_32, i32, env, i32, i32)
> +DEF_HELPER_3(sati_64, i64, env, i64, i64)
> +DEF_HELPER_3(usati_64, i64, env, i64, i64)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..6043eb39cf 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -40,6 +40,9 @@
>  %imm_z6   26:1 15:5
>  %imm_mop5 30:1 26:2 20:2
>  %imm_mop3 30:1 26:2
> +%imm_p_ui16 20:4
> +%imm_p_ui32 20:5
> +%imm_p_ui64 20:6
>  
>  # Argument sets:
>  &empty
> @@ -105,6 +108,10 @@
>  @mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
>  @mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
>  
> +@p_ui16 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui16 %rs1 %rd
> +@p_ui32 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui32 %rs1 %rd
> +@p_ui64 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui64 %rs1 %rd
> +
>  # Formats 64:
>  @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
>  
> @@ -1084,3 +1091,61 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
>  sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
>  sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
>  sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
> +
> +
> +# *** P Experimental Extension Version v018 ***
> +# Arithmetic Operations(Non-Saturating and Saturating)
> +padd_b     1000010 ..... ..... 000 ..... 0111011 @r
> +padd_h     1000000 ..... ..... 000 ..... 0111011 @r
> +padd_w     1000001 ..... ..... 000 ..... 0111011 @r
> +padd_bs    1001110 ..... ..... 010 ..... 0011011 @r
> +padd_hs    1001100 ..... ..... 010 ..... 0011011 @r
> +padd_ws    1001101 ..... ..... 010 ..... 0011011 @r
> +psub_b     1100010 ..... ..... 000 ..... 0111011 @r
> +psub_h     1100000 ..... ..... 000 ..... 0111011 @r
> +psub_w     1100001 ..... ..... 000 ..... 0111011 @r
> +psh1add_h  1010000 ..... ..... 010 ..... 0111011 @r
> +psh1add_w  1010001 ..... ..... 010 ..... 0111011 @r
> +pssh1sadd_h   1011000 ..... ..... 010 ..... 0111011 @r
> +{
> +  ssh1sadd    1011001 ..... ..... 010 ..... 0111011 @r
> +  pssh1sadd_w 1011001 ..... ..... 010 ..... 0111011 @r
> +}
> +psadd_b    1001010 ..... ..... 000 ..... 0111011 @r
> +psadd_h    1001000 ..... ..... 000 ..... 0111011 @r
> +{
> +  sadd     1001001 ..... ..... 000 ..... 0111011 @r
> +  psadd_w  1001001 ..... ..... 000 ..... 0111011 @r
> +}
> +psaddu_b   1011010 ..... ..... 000 ..... 0111011 @r
> +psaddu_h   1011000 ..... ..... 000 ..... 0111011 @r
> +{
> +  saddu    1011001 ..... ..... 000 ..... 0111011 @r
> +  psaddu_w 1011001 ..... ..... 000 ..... 0111011 @r
> +}
> +pssub_b    1101010 ..... ..... 000 ..... 0111011 @r
> +pssub_h    1101000 ..... ..... 000 ..... 0111011 @r
> +{
> +  ssub     1101001 ..... ..... 000 ..... 0111011 @r
> +  pssub_w  1101001 ..... ..... 000 ..... 0111011 @r
> +}
> +pssubu_b   1111010 ..... ..... 000 ..... 0111011 @r
> +pssubu_h   1111000 ..... ..... 000 ..... 0111011 @r
> +{
> +  ssubu      1111001 ..... ..... 000 ..... 0111011 @r
> +  pssubu_w   1111001 ..... ..... 000 ..... 0111011 @r
> +}
> +psati_h    11100 001.... ..... 100 ..... 0011011 @p_ui16
> +pusati_h   10100 001.... ..... 100 ..... 0011011 @p_ui16
> +{
> +  sati_32    11100 01..... ..... 100 ..... 0011011 @p_ui32
> +  psati_w      11100 01..... ..... 100 ..... 0011011 @p_ui32
> +}
> +{
> +  usati_32   10100 01..... ..... 100 ..... 0011011 @p_ui32
> +  pusati_w     10100 01..... ..... 100 ..... 0011011 @p_ui32
> +}
> +
> +sati_64    111001 ...... ..... 100 ..... 0011011 @p_ui64
> +usati_64   101001 ...... ..... 100 ..... 0011011 @p_ui64
> +
> diff --git a/target/riscv/insn_trans/trans_rvp.c.inc b/target/riscv/insn_trans/trans_rvp.c.inc
> new file mode 100644
> index 0000000000..6f7246b563
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvp.c.inc
> @@ -0,0 +1,564 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* RISC-V translation routines for the P Standard Extensions. */
> +/* Copyright (c) 2026 ISRC ISCAS. */
> +
> +#define GEN_SIMD_TRANS(NAME)                                \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +   REQUIRE_EXT(ctx, RVP);                                   \
> +   TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);              \
> +   TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);              \
> +   TCGv dest = dest_gpr(ctx, a->rd);                        \
> +   gen_helper_##NAME(dest, tcg_env, src1, src2);            \
> +   return true;                                             \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_32(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1, src2);           \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_32(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_64(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
> +{                                                           \
> +   REQUIRE_64BIT(ctx);                                      \
> +   return true;                                             \
> +}
> +#else
> +#define GEN_SIMD_TRANS_64(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)  \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1, src2);           \
> +    return true;                                            \
> +}
> +#endif
> +
> +#define GEN_SIMD_TRANS_ACC(NAME)                            \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    TCGv t = tcg_temp_new();                                \
> +    gen_helper_##NAME(t, tcg_env, src1, src2, dest);        \
> +    gen_set_gpr(ctx, a->rd, t);                             \
> +    return true;                                            \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_ACC_32(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    TCGv t = tcg_temp_new();                                \
> +    gen_helper_##NAME(t, tcg_env, src1, src2, dest);        \
> +    gen_set_gpr(ctx, a->rd, t);                             \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_ACC_32(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_ACC_64(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_ACC_64(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    TCGv t = tcg_temp_new();                                \
> +    gen_helper_##NAME(t, tcg_env, src1, src2, dest);        \
> +    gen_set_gpr(ctx, a->rd, t);                             \
> +    return true;                                            \
> +}
> +#endif
> +
> +#define GEN_SIMD_TRANS_R1(NAME)                             \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1);                 \
> +    gen_set_gpr(ctx, a->rd, dest);                          \
> +    return true;                                            \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_R1_64(NAME)                          \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_R1_64(NAME)                          \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1);                 \
> +    return true;                                            \
> +}
> +#endif
> +
> +#define GEN_SIMD_TRANS_IMM(NAME)                            \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv imm = tcg_constant_tl(a->imm);                     \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1, imm);            \
> +    return true;                                            \
> +}
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_IMM_32(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                   \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv imm = tcg_constant_tl(a->imm);                     \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1, imm);            \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_IMM_32(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_IMM_64(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_IMM_64(NAME)                         \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_64BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                   \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv imm = tcg_constant_tl(a->imm);                     \
> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
> +    gen_helper_##NAME(dest, tcg_env, src1, imm);            \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_1(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv_i32 src1 = get_gpr(ctx, a->rs1, EXT_NONE);         \
> +    TCGv_i32 src2 = get_gpr(ctx, a->rs2, EXT_NONE);         \
> +    TCGv_i64 t = tcg_temp_new_i64();                        \
> +    gen_helper_##NAME(t, tcg_env, src1, src2);              \
> +    set_pair_regs(ctx, (a->rd) * 2, t);                       \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_1(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_2(INSN, HELPER)                \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    REQUIRE_EXT(ctx, RVP);                                     \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);          \
> +    TCGv src2_0 = get_gpr(ctx, (a->rs2) * 2, EXT_NONE);          \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
> +    TCGv src2_1 = get_gpr(ctx, (a->rs2) * 2 + 1, EXT_NONE);        \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2_0);      \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2_1);      \
> +    return true;                                               \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_2(INSN, HELPER)                \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    return true;                                               \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_3(INSN, HELPER)                \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_EXT(ctx, RVP);                                     \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);          \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
> +    TCGv src2   = get_gpr(ctx, a->rs2, EXT_NONE);              \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);        \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2);        \
> +    return true;                                               \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_3(INSN, HELPER)                \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    return true;                                               \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_DW(INSN, HELPER)               \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    REQUIRE_EXT(ctx, RVP);                                     \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);          \
> +    TCGv src2_0 = get_gpr(ctx, (a->rs2) * 2, EXT_NONE);          \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
> +    TCGv src2_1 = get_gpr(ctx, (a->rs2) * 2 + 1, EXT_NONE);        \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2_0);      \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2_1);      \
> +    return true;                                               \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_DW(INSN, HELPER)               \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    return true;                                               \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_DW_IMM(INSN, HELPER)           \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    REQUIRE_EXT(ctx, RVP);                                     \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);          \
> +    TCGv imm_0 = tcg_constant_tl(a->imm);                      \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
> +    TCGv imm_1 = tcg_constant_tl(a->imm);                      \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, imm_0);       \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, imm_1);       \
> +    return true;                                               \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_DW_IMM(INSN, HELPER)           \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    return true;                                               \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_DW_IMM_2(INSN, HELPER)         \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    REQUIRE_EXT(ctx, RVP);                                     \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);          \
> +    TCGv imm_0 = tcg_constant_tl(a->imm);                      \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
> +    TCGv imm_1 = tcg_constant_tl(a->imm);                      \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
> +    gen_helper_##HELPER##_32(dest_0, tcg_env, src1_0, imm_0);  \
> +    gen_helper_##HELPER##_32(dest_1, tcg_env, src1_1, imm_1);  \
> +    return true;                                               \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_DW_IMM_2(INSN, HELPER)         \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)     \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    return true;                                               \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_5(INSN, HELPER)                \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_EXT(ctx, RVP);                                     \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);          \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0);              \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1);              \
> +    gen_set_gpr(ctx, (a->rd) * 2, dest_0);                       \
> +    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);                     \
> +    return true;                                               \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_5(INSN, HELPER)                \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
> +{                                                              \
> +    REQUIRE_32BIT(ctx);                                        \
> +    return true;                                               \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_IMM(NAME)                   \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv_i32 imm = tcg_constant_i32(a->imm);                \
> +    TCGv_i64 t = tcg_temp_new_i64();                        \
> +    gen_helper_##NAME(t, tcg_env, src1, imm);               \
> +    set_pair_regs(ctx, (a->rd) * 2, t);                       \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_IMM(NAME)                   \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_IMM_2(INSN, HELPER)          \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)  \
> +{                                                            \
> +    REQUIRE_32BIT(ctx);                                      \
> +    REQUIRE_EXT(ctx, RVP);                                   \
> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);        \
> +    TCGv imm_0 = tcg_constant_tl(a->imm);                    \
> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                  \
> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);      \
> +    TCGv imm_1 = tcg_constant_tl(a->imm);                    \
> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                \
> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, imm_0);     \
> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, imm_1);     \
> +    return true;                                             \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_IMM_2(INSN, HELPER)          \
> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)  \
> +{                                                            \
> +    REQUIRE_32BIT(ctx);                                      \
> +    return true;                                             \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_ACC_REG_PAIR_1(NAME)                 \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
> +    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
> +    TCGv_i64 t = tcg_temp_new_i64();                        \
> +    if (a->rd == 0) {                                         \
> +        tcg_gen_movi_i64(t, 0);                             \
> +    } else {                                                  \
> +        get_pair_regs(ctx, t, (a->rd) * 2);                   \
> +    }                                                       \
> +    gen_helper_##NAME(t, tcg_env, src1, src2, t);           \
> +    set_pair_regs(ctx, (a->rd) * 2, t);                       \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_ACC_REG_PAIR_1(NAME)                 \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_REG_PAIR_PREDSUM(NAME)               \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    REQUIRE_EXT(ctx, RVP);                                  \
> +    TCGv_i32 src1_l;                                        \
> +    TCGv_i32 src1_h;                                        \
> +    TCGv_i32 src2 = get_gpr(ctx, a->rs2, EXT_NONE);         \
> +    TCGv_i32 dest = dest_gpr(ctx, a->rd);                   \
> +    if (a->rs1 == 0) {                                        \
> +        src1_l = tcg_temp_new_i32();                        \
> +        src1_h = tcg_temp_new_i32();                        \
> +        tcg_gen_movi_i32(src1_l, 0);                        \
> +        tcg_gen_movi_i32(src1_h, 0);                        \
> +    } else {                                                  \
> +        src1_l = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);        \
> +        src1_h = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);      \
> +    }                                                       \
> +    gen_helper_##NAME(dest, tcg_env, src1_l, src1_h, src2); \
> +    return true;                                            \
> +}
> +#else
> +#define GEN_SIMD_TRANS_REG_PAIR_PREDSUM(NAME)               \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                           \
> +    REQUIRE_32BIT(ctx);                                     \
> +    return true;                                            \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_PN_OP_IMM(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                          \
> +    REQUIRE_32BIT(ctx);                                    \
> +    REQUIRE_EXT(ctx, RVP);                                 \
> +    TCGv_i64 s1 = tcg_temp_new_i64();                      \
> +    if (a->rs1 == 0) {                                     \
> +        tcg_gen_mov_i64(s1, 0);                            \
> +    } else {                                               \
> +        get_pair_regs(ctx, s1, a->rs1 * 2);                \
> +    }                                                      \
> +    TCGv shamt = tcg_constant_tl(a->imm);                  \
> +    TCGv_i32 dest = dest_gpr(ctx, a->rd);                  \
> +    gen_helper_##NAME(dest, tcg_env, s1, shamt);           \
> +    return true;                                           \
> +}
> +#else
> +#define GEN_SIMD_TRANS_PN_OP_IMM(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                          \
> +    REQUIRE_32BIT(ctx);                                    \
> +    return true;                                           \
> +}
> +#endif
> +
> +#if defined(TARGET_RISCV32)
> +#define GEN_SIMD_TRANS_PN_OP_REG(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                          \
> +    REQUIRE_32BIT(ctx);                                    \
> +    REQUIRE_EXT(ctx, RVP);                                 \
> +    TCGv_i64 s1 = tcg_temp_new_i64();                      \
> +    if (a->rs1 == 0) {                                     \
> +        tcg_gen_mov_i64(s1, 0);                            \
> +    } else {                                               \
> +        get_pair_regs(ctx, s1, a->rs1 * 2);                \
> +    }                                                      \
> +    TCGv_i32 rs2 = get_gpr(ctx, a->rs2, EXT_NONE);         \
> +    TCGv_i32 dest = dest_gpr(ctx, a->rd);                  \
> +    gen_helper_##NAME(dest, tcg_env, s1, rs2);             \
> +    return true;                                           \
> +}
> +#else
> +#define GEN_SIMD_TRANS_PN_OP_REG(NAME)                     \
> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +{                                                          \
> +    REQUIRE_32BIT(ctx);                                    \
> +    return true;                                           \
> +}
> +#endif
> +
> +GEN_SIMD_TRANS(padd_b)
> +GEN_SIMD_TRANS(padd_h)
> +GEN_SIMD_TRANS_64(padd_w)
> +GEN_SIMD_TRANS(padd_bs)
> +GEN_SIMD_TRANS(padd_hs)
> +GEN_SIMD_TRANS_64(padd_ws)
> +GEN_SIMD_TRANS(psub_b)
> +GEN_SIMD_TRANS(psub_h)
> +GEN_SIMD_TRANS_64(psub_w)
> +GEN_SIMD_TRANS(psh1add_h)
> +GEN_SIMD_TRANS_64(psh1add_w)
> +GEN_SIMD_TRANS(pssh1sadd_h)
> +GEN_SIMD_TRANS_64(pssh1sadd_w)
> +GEN_SIMD_TRANS_32(ssh1sadd)
> +GEN_SIMD_TRANS(psadd_b)
> +GEN_SIMD_TRANS(psadd_h)
> +GEN_SIMD_TRANS_64(psadd_w)
> +GEN_SIMD_TRANS(psaddu_b)
> +GEN_SIMD_TRANS(psaddu_h)
> +GEN_SIMD_TRANS_64(psaddu_w)
> +GEN_SIMD_TRANS_32(sadd)
> +GEN_SIMD_TRANS_32(saddu)
> +GEN_SIMD_TRANS(pssub_b)
> +GEN_SIMD_TRANS(pssub_h)
> +GEN_SIMD_TRANS_64(pssub_w)
> +GEN_SIMD_TRANS(pssubu_b)
> +GEN_SIMD_TRANS(pssubu_h)
> +GEN_SIMD_TRANS_64(pssubu_w)
> +GEN_SIMD_TRANS_32(ssub)
> +GEN_SIMD_TRANS_32(ssubu)
> +GEN_SIMD_TRANS_IMM(psati_h)
> +GEN_SIMD_TRANS_IMM(pusati_h)
> +GEN_SIMD_TRANS_IMM_64(psati_w)
> +GEN_SIMD_TRANS_IMM_64(pusati_w)
> +GEN_SIMD_TRANS_IMM_32(sati_32)
> +GEN_SIMD_TRANS_IMM_32(usati_32)
> +GEN_SIMD_TRANS_IMM_64(sati_64)
> +GEN_SIMD_TRANS_IMM_64(usati_64)
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 79f36abd63..45ed7f8d8a 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -28,7 +28,8 @@ riscv_ss.add(files(
>    'm128_helper.c',
>    'crypto_helper.c',
>    'zce_helper.c',
> -  'vcrypto_helper.c'
> +  'vcrypto_helper.c',
> +  'psimd_helper.c'
>  ))
>  
>  riscv_system_ss = ss.source_set()
> diff --git a/target/riscv/psimd_helper.c b/target/riscv/psimd_helper.c
> new file mode 100644
> index 0000000000..a754ee3b5e
> --- /dev/null
> +++ b/target/riscv/psimd_helper.c
> @@ -0,0 +1,1069 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* RISC-V Packed SIMD Extension Helpers for QEMU. */
> +/* Copyright (C) 2026 ISRC ISCAS. */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "qemu/host-utils.h"
> +#include "exec/helper-proto.h"
> +#include "fpu/softfloat.h"
> +#include "internals.h"
> +
> +
> +/* Helper macros */
> +
> +/* Element count calculations */
> +#define ELEMS_B(target) (sizeof(target) * 8 / 8)    /* byte elements count */
> +#define ELEMS_H(target) (sizeof(target) * 8 / 16)
> +#define ELEMS_W(target) (sizeof(target) * 8 / 32)   /* word elements count */
> +
> +/* Element extraction macros - unsigned to avoid sign extension */
> +#define EXTRACT8(val, idx)  (((val) >> ((idx) * 8)) & 0xFF)
> +#define EXTRACT16(val, idx) (((val) >> ((idx) * 16)) & 0xFFFF)
> +#define EXTRACT32(val, idx) (((val) >> ((idx) * 32)) & 0xFFFFFFFF)
> +
> +/* Element insertion macros */
> +#define INSERT8(val, res, idx) \
> +    ((val) | ((target_ulong)(uint8_t)(res) << ((idx) * 8)))
> +#define INSERT16(val, res, idx) \
> +    ((val) | ((target_ulong)(uint16_t)(res) << ((idx) * 16)))
> +#define INSERT32(val, res, idx) \
> +    ((val) | ((target_ulong)(uint32_t)(res) << ((idx) * 32)))
> +
> +/* Saturation constants */
> +static const int8_t   SAT_MAX_B = 127;
> +static const int8_t   SAT_MIN_B = -128;
> +static const int16_t  SAT_MAX_H = 32767;
> +static const int16_t  SAT_MIN_H = -32768;
> +static const int32_t  SAT_MAX_W = 2147483647;
> +static const int32_t  SAT_MIN_W = -2147483648LL;
> +static const uint8_t  USAT_MAX_B = 255;
> +static const uint16_t USAT_MAX_H = 65535;
> +static const uint32_t USAT_MAX_W = 4294967295U;
> +
> +
> +/* Saturation helper functions */
> +
> +/**
> + * Signed saturation for 8-bit elements
> + * Returns saturated value and sets *sat if saturation occurred
> + */
> +static inline int8_t signed_saturate_b(int32_t val, int *sat)
> +{
> +    if (val > SAT_MAX_B) {
> +        *sat = 1;
> +        return SAT_MAX_B;
> +    }
> +    if (val < SAT_MIN_B) {
> +        *sat = 1;
> +        return SAT_MIN_B;
> +    }
> +    return (int8_t)val;
> +}
> +
> +/**
> + * Signed saturation for 16-bit elements
> + */
> +static inline int16_t signed_saturate_h(int32_t val, int *sat)
> +{
> +    if (val > SAT_MAX_H) {
> +        *sat = 1;
> +        return SAT_MAX_H;
> +    }
> +    if (val < SAT_MIN_H) {
> +        *sat = 1;
> +        return SAT_MIN_H;
> +    }
> +    return (int16_t)val;
> +}
> +
> +/**
> + * Signed saturation for 32-bit elements
> + */
> +static inline int32_t signed_saturate_w(int64_t val, int *sat)
> +{
> +    if (val > SAT_MAX_W) {
> +        *sat = 1;
> +        return SAT_MAX_W;
> +    }
> +    if (val < SAT_MIN_W) {
> +        *sat = 1;
> +        return SAT_MIN_W;
> +    }
> +    return (int32_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 8-bit elements
> + */
> +static inline uint8_t unsigned_saturate_b(uint32_t val, int *sat)
> +{
> +    if (val > USAT_MAX_B) {
> +        *sat = 1;
> +        return USAT_MAX_B;
> +    }
> +    return (uint8_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 16-bit elements
> + */
> +static inline uint16_t unsigned_saturate_h(uint32_t val, int *sat)
> +{
> +    if (val > USAT_MAX_H) {
> +        *sat = 1;
> +        return USAT_MAX_H;
> +    }
> +    return (uint16_t)val;
> +}
> +
> +/**
> + * Unsigned saturation for 32-bit elements
> + */
> +static inline uint32_t unsigned_saturate_w(uint64_t val, int *sat)
> +{
> +    if (val > USAT_MAX_W) {
> +        *sat = 1;
> +        return USAT_MAX_W;
> +    }
> +    return (uint32_t)val;
> +}
> +
> +/* Basic addition operations (non-saturating) */
> +
> +/**
> + * PADD.B - Packed 8-bit addition
> + * For each byte: rd[i] = rs1[i] + rs2[i] (modular)
> + */
> +target_ulong HELPER(padd_b)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t e2 = EXTRACT8(rs2, i);
> +        uint8_t res = e1 + e2;
> +        rd = INSERT8(rd, res, i);
> +    }
> +    return rd;
> +}
If we don't care about performance in the early patchset,
but considering maintainability, I'd suggest providing unified
helper macros for these operations.

The current SIMD implementations all share a similar loop
structure, differing only in element types. We could follow the
approach used in vector_helper.c and define a few groups of
helper macros to reduce the boilerplate.

e.g.

```
  #define DO_ADD(a, b) ((a) + (b))
  #define DO_SUB(a, b) ((a) - (b))

  #define GEN_PSIMD_VV_B(NAME, OP)                              \
  target_ulong HELPER(NAME)(CPURISCVState *env,                 \
                            target_ulong rs1, target_ulong rs2) \
  {                                                             \
      target_ulong rd = 0;                                      \
      for (int i = 0; i < ELEMS_B(rd); i++) {                   \
          uint8_t e1 = EXTRACT8(rs1, i);                        \
          uint8_t e2 = EXTRACT8(rs2, i);                        \
          rd = INSERT8(rd, (uint8_t)OP(e1, e2), i);             \
      }                                                         \
      return rd;                                                \
  }

  GEN_PSIMD_VV_B(padd_b, DO_ADD)
  GEN_PSIMD_VV_B(psub_b, DO_SUB)
```

The same applies to the helper functions for other instructions
as well.

Thanks,
Chao
> +
> +/**
> + * PADD.H - Packed 16-bit addition
> + * For each halfword: rd[i] = rs1[i] + rs2[i] (modular)
> + */
> +target_ulong HELPER(padd_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint16_t e1 = EXTRACT16(rs1, i);
> +        uint16_t e2 = EXTRACT16(rs2, i);
> +        uint16_t res = e1 + e2;
> +        rd = INSERT16(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PADD.W - Packed 32-bit addition (RV64 only)
> + * For each word: rd[i] = rs1[i] + rs2[i] (modular)
> + */
> +uint64_t HELPER(padd_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;  /* 2 words in 64-bit */
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint32_t e1 = EXTRACT32(rs1, i);
> +        uint32_t e2 = EXTRACT32(rs2, i);
> +        uint32_t res = e1 + e2;
> +        rd = INSERT32(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PADD.BS - Packed 8-bit addition with scalar second operand
> + * For each byte: rd[i] = rs1[i] + rs2[0] (modular)
> + */
> +target_ulong HELPER(padd_bs)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +    uint8_t e2 = EXTRACT8(rs2, 0);  /* Scalar, take least significant byte */
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t res = e1 + e2;
> +        rd = INSERT8(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PADD.HS - Packed 16-bit addition with scalar second operand
> + * For each halfword: rd[i] = rs1[i] + rs2[0] (modular)
> + */
> +target_ulong HELPER(padd_hs)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    uint16_t e2 = EXTRACT16(rs2, 0);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint16_t e1 = EXTRACT16(rs1, i);
> +        uint16_t res = e1 + e2;
> +        rd = INSERT16(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PADD.WS - Packed 32-bit addition with scalar second operand (RV64 only)
> + * For each word: rd[i] = rs1[i] + rs2[0] (modular)
> + */
> +uint64_t HELPER(padd_ws)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    uint32_t e2 = EXTRACT32(rs2, 0);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint32_t e1 = EXTRACT32(rs1, i);
> +        uint32_t res = e1 + e2;
> +        rd = INSERT32(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +
> +/* Basic subtraction operations (non-saturating) */
> +
> +/**
> + * PSUB.B - Packed 8-bit subtraction
> + * For each byte: rd[i] = rs1[i] - rs2[i] (modular)
> + */
> +target_ulong HELPER(psub_b)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t e2 = EXTRACT8(rs2, i);
> +        uint8_t res = e1 - e2;
> +        rd = INSERT8(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSUB.H - Packed 16-bit subtraction
> + * For each halfword: rd[i] = rs1[i] - rs2[i] (modular)
> + */
> +target_ulong HELPER(psub_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint16_t e1 = EXTRACT16(rs1, i);
> +        uint16_t e2 = EXTRACT16(rs2, i);
> +        uint16_t res = e1 - e2;
> +        rd = INSERT16(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSUB.W - Packed 32-bit subtraction (RV64 only)
> + * For each word: rd[i] = rs1[i] - rs2[i] (modular)
> + */
> +uint64_t HELPER(psub_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint32_t e1 = EXTRACT32(rs1, i);
> +        uint32_t e2 = EXTRACT32(rs2, i);
> +        uint32_t res = e1 - e2;
> +        rd = INSERT32(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/* Shift-left-by-one and add operations */
> +
> +/**
> + * PSH1ADD.H - Shift left by 1 and add (16-bit)
> + * For each halfword: rd[i] = (rs1[i] << 1) + rs2[i]
> + */
> +target_ulong HELPER(psh1add_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint16_t e1 = EXTRACT16(rs1, i);
> +        uint16_t e2 = EXTRACT16(rs2, i);
> +        uint16_t res = (e1 << 1) + e2;
> +        rd = INSERT16(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSH1ADD.W - Shift left by 1 and add (32-bit, RV64 only)
> + * For each word: rd[i] = (rs1[i] << 1) + rs2[i]
> + */
> +uint64_t HELPER(psh1add_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint32_t e1 = EXTRACT32(rs1, i);
> +        uint32_t e2 = EXTRACT32(rs2, i);
> +        uint32_t res = (e1 << 1) + e2;
> +        rd = INSERT32(rd, res, i);
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSSH1SADD.H - Saturating shift left by 1 and saturating add (16-bit)
> + * For each halfword: rd[i] = sat16(sat16(rs1[i] << 1) + rs2[i])
> + */
> +target_ulong HELPER(pssh1sadd_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
> +        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
> +        int32_t shifted;
> +
> +        /* Check if shift-left-1 would overflow */
> +        if (e1 > 0x3FFF || e1 < -0x4000) {
> +            shifted = (e1 < 0) ? 0xFFFF8000LL : 0x7FFF;
> +            sat = 1;
> +        } else {
> +            shifted = e1 << 1;
> +        }
> +
> +        int32_t sum = shifted + e2;
> +        int16_t res = signed_saturate_h(sum, &sat);
> +        rd = INSERT16(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSSH1SADD.W - Saturating shift left by 1 and add
> + * with saturation (32-bit, RV64 only)
> + * For each word: rd[i] = sat32(sat32(rs1[i] << 1) + rs2[i])
> + */
> +uint64_t HELPER(pssh1sadd_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
> +        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
> +        int64_t shifted;
> +
> +        /* Check if shift-left-1 would overflow */
> +        if (e1 > 0x3FFFFFFF || e1 < -0x40000000) {
> +            shifted = (e1 < 0) ? 0xFFFFFFFF80000000LL : 0x7FFFFFFF;
> +            sat = 1;
> +        } else {
> +            shifted = (int64_t)e1 << 1;
> +        }
> +
> +        int64_t sum = shifted + e2;
> +        int32_t res = signed_saturate_w(sum, &sat);
> +        rd = INSERT32(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * SSH1SADD - 32-bit scalar saturating shift left by 1 and saturating add
> + */
> +uint32_t HELPER(ssh1sadd)(CPURISCVState *env,
> +                     uint32_t rs1, uint32_t rs2)
> +{
> +    int32_t a = (int32_t)rs1;
> +    int32_t b = (int32_t)rs2;
> +    int64_t shifted;
> +    int sat = 0;
> +
> +    /* Check if shift-left-1 would overflow */
> +    if (a > 0x3FFFFFFF || a < -0x40000000) {
> +        shifted = (a < 0) ? 0xFFFFFFFF80000000LL : 0x7FFFFFFF;
> +        sat = 1;
> +    } else {
> +        shifted = (int64_t)a << 1;
> +    }
> +
> +    int64_t sum = shifted + b;
> +    int32_t res = signed_saturate_w(sum, &sat);
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return (uint32_t)res;
> +}
> +
> +/* Saturating addition operations */
> +
> +/**
> + * PSADD.B - Packed 8-bit signed saturating addition
> + * For each byte: rd[i] = sat8(rs1[i] + rs2[i])
> + */
> +target_ulong HELPER(psadd_b)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
> +        int8_t e2 = (int8_t)EXTRACT8(rs2, i);
> +        int32_t sum = (int32_t)e1 + (int32_t)e2;
> +        int8_t res = signed_saturate_b(sum, &sat);
> +        rd = INSERT8(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSADD.H - Packed 16-bit signed saturating addition
> + * For each halfword: rd[i] = sat16(rs1[i] + rs2[i])
> + */
> +target_ulong HELPER(psadd_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
> +        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
> +        int32_t sum = (int32_t)e1 + (int32_t)e2;
> +        int16_t res = signed_saturate_h(sum, &sat);
> +        rd = INSERT16(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSADD.W - Packed 32-bit signed saturating addition (RV64 only)
> + * For each word: rd[i] = sat32(rs1[i] + rs2[i])
> + */
> +uint64_t HELPER(psadd_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
> +        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
> +        int64_t sum = (int64_t)e1 + (int64_t)e2;
> +        int32_t res = signed_saturate_w(sum, &sat);
> +        rd = INSERT32(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSADDU.B - Packed 8-bit unsigned saturating addition
> + * For each byte: rd[i] = usat8(rs1[i] + rs2[i])
> + */
> +target_ulong HELPER(psaddu_b)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t e2 = EXTRACT8(rs2, i);
> +        uint32_t sum = (uint32_t)e1 + (uint32_t)e2;
> +        uint8_t res = unsigned_saturate_b(sum, &sat);
> +        rd = INSERT8(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSADDU.H - Packed 16-bit unsigned saturating addition
> + * For each halfword: rd[i] = usat16(rs1[i] + rs2[i])
> + */
> +target_ulong HELPER(psaddu_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint16_t e1 = EXTRACT16(rs1, i);
> +        uint16_t e2 = EXTRACT16(rs2, i);
> +        uint32_t sum = (uint32_t)e1 + (uint32_t)e2;
> +        uint16_t res = unsigned_saturate_h(sum, &sat);
> +        rd = INSERT16(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSADDU.W - Packed 32-bit unsigned saturating addition (RV64 only)
> + * For each word: rd[i] = usat32(rs1[i] + rs2[i])
> + */
> +uint64_t HELPER(psaddu_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint32_t e1 = EXTRACT32(rs1, i);
> +        uint32_t e2 = EXTRACT32(rs2, i);
> +        uint64_t sum = (uint64_t)e1 + (uint64_t)e2;
> +        uint32_t res = unsigned_saturate_w(sum, &sat);
> +        rd = INSERT32(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * SADD - 32-bit signed saturating addition
> + */
> +uint32_t HELPER(sadd)(CPURISCVState *env,
> +                     uint32_t rs1, uint32_t rs2)
> +{
> +    int32_t a = (int32_t)rs1;
> +    int32_t b = (int32_t)rs2;
> +    int64_t sum = (int64_t)a + (int64_t)b;
> +    int sat = 0;
> +    int32_t res = signed_saturate_w(sum, &sat);
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return (uint32_t)res;
> +}
> +
> +/**
> + * SADDU - 32-bit unsigned saturating addition
> + */
> +uint32_t HELPER(saddu)(CPURISCVState *env,
> +                     uint32_t rs1, uint32_t rs2)
> +{
> +    uint32_t a = rs1;
> +    uint32_t b = rs2;
> +    uint64_t sum = (uint64_t)a + (uint64_t)b;
> +    int sat = 0;
> +    uint32_t res = unsigned_saturate_w(sum, &sat);
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return res;
> +}
> +
> +/* Saturating subtraction operations */
> +
> +/**
> + * PSSUB.B - Packed 8-bit signed saturating subtraction
> + * For each byte: rd[i] = sat8(rs1[i] - rs2[i])
> + */
> +target_ulong HELPER(pssub_b)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int8_t e1 = (int8_t)EXTRACT8(rs1, i);
> +        int8_t e2 = (int8_t)EXTRACT8(rs2, i);
> +        int32_t diff = (int32_t)e1 - (int32_t)e2;
> +        int8_t res = signed_saturate_b(diff, &sat);
> +        rd = INSERT8(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSSUB.H - Packed 16-bit signed saturating subtraction
> + * For each halfword: rd[i] = sat16(rs1[i] - rs2[i])
> + */
> +target_ulong HELPER(pssub_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
> +        int16_t e2 = (int16_t)EXTRACT16(rs2, i);
> +        int32_t diff = (int32_t)e1 - (int32_t)e2;
> +        int16_t res = signed_saturate_h(diff, &sat);
> +        rd = INSERT16(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSSUB.W - Packed 32-bit signed saturating subtraction (RV64 only)
> + * For each word: rd[i] = sat32(rs1[i] - rs2[i])
> + */
> +uint64_t HELPER(pssub_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
> +        int32_t e2 = (int32_t)EXTRACT32(rs2, i);
> +        int64_t diff = (int64_t)e1 - (int64_t)e2;
> +        int32_t res = signed_saturate_w(diff, &sat);
> +        rd = INSERT32(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSSUBU.B - Packed 8-bit unsigned saturating subtraction
> + * For each byte: rd[i] = usat8(rs1[i] - rs2[i])
> + */
> +target_ulong HELPER(pssubu_b)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_B(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint8_t e1 = EXTRACT8(rs1, i);
> +        uint8_t e2 = EXTRACT8(rs2, i);
> +        uint32_t diff = e1 - e2;  /* Unsigned subtraction may underflow */
> +        uint8_t res = unsigned_saturate_b(diff, &sat);
> +        rd = INSERT8(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSSUBU.H - Packed 16-bit unsigned saturating subtraction
> + * For each halfword: rd[i] = usat16(rs1[i] - rs2[i])
> + */
> +target_ulong HELPER(pssubu_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong rs2)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint16_t e1 = EXTRACT16(rs1, i);
> +        uint16_t e2 = EXTRACT16(rs2, i);
> +        uint32_t diff = e1 - e2;
> +        uint16_t res = unsigned_saturate_h(diff, &sat);
> +        rd = INSERT16(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSSUBU.W - Packed 32-bit unsigned saturating subtraction (RV64 only)
> + * For each word: rd[i] = usat32(rs1[i] - rs2[i])
> + */
> +uint64_t HELPER(pssubu_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t rs2)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        uint32_t e1 = EXTRACT32(rs1, i);
> +        uint32_t e2 = EXTRACT32(rs2, i);
> +        uint32_t res = (e1 >= e2) ? (e1 - e2) : 0;
> +        if (e1 < e2) {
> +            sat = 1;
> +        }
> +        rd = INSERT32(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * SSUB - 32-bit signed saturating subtraction
> + */
> +uint32_t HELPER(ssub)(CPURISCVState *env,
> +                     uint32_t rs1, uint32_t rs2)
> +{
> +    int32_t a = (int32_t)rs1;
> +    int32_t b = (int32_t)rs2;
> +    int64_t diff = (int64_t)a - (int64_t)b;
> +    int sat = 0;
> +    int32_t res = signed_saturate_w(diff, &sat);
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return (uint32_t)res;
> +}
> +
> +/**
> + * SSUBU - 32-bit unsigned saturating subtraction
> + */
> +uint32_t HELPER(ssubu)(CPURISCVState *env,
> +                     uint32_t rs1, uint32_t rs2)
> +{
> +    uint32_t a = rs1;
> +    uint32_t b = rs2;
> +    uint64_t diff = (uint64_t)a - (uint64_t)b;
> +    int sat = 0;
> +    uint32_t res = unsigned_saturate_w(diff, &sat);
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return res;
> +}
> +
> +/* Saturation instructions (SAT, USAT) */
> +
> +/**
> + * PSATI.H - Packed 16-bit signed saturate to immediate bit-width
> + * For each halfword: rd[i] = sat(rs1[i], imm+1 bits)
> + */
> +target_ulong HELPER(psati_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong imm)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    int range = (imm & 0x0F) + 1;  /* imm specifies bits-1 */
> +    int64_t max = (1LL << (range - 1)) - 1;
> +    int64_t min = -(1LL << (range - 1));
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
> +        int16_t res;
> +
> +        if (e1 > max) {
> +            res = max;
> +            sat = 1;
> +        } else if (e1 < min) {
> +            res = min;
> +            sat = 1;
> +        } else {
> +            res = e1;
> +        }
> +
> +        rd = INSERT16(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PUSATI.H - Packed 16-bit unsigned saturate to immediate bit-width
> + * For each halfword: rd[i] = usat(rs1[i], imm bits)
> + */
> +target_ulong HELPER(pusati_h)(CPURISCVState *env,
> +                          target_ulong rs1, target_ulong imm)
> +{
> +    target_ulong rd = 0;
> +    int elems = ELEMS_H(rd);
> +    uint32_t max = (1U << imm) - 1;
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int16_t e1 = (int16_t)EXTRACT16(rs1, i);
> +        int16_t res;
> +
> +        if (e1 < 0) {
> +            res = 0;
> +            sat = 1;
> +        } else if ((uint16_t)e1 > max) {
> +            res = max;
> +            sat = 1;
> +        } else {
> +            res = e1;
> +        }
> +
> +        rd = INSERT16(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PSATI.W - Packed 32-bit signed saturate to immediate bit-width (RV64 only)
> + * For each word: rd[i] = sat(rs1[i], imm+1 bits)
> + */
> +uint64_t HELPER(psati_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t imm)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    int range = (imm & 0x1F) + 1;
> +    int64_t max = (1LL << (range - 1)) - 1;
> +    int64_t min = -(1LL << (range - 1));
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
> +        int32_t res;
> +
> +        if (e1 > max) {
> +            res = max;
> +            sat = 1;
> +        } else if (e1 < min) {
> +            res = min;
> +            sat = 1;
> +        } else {
> +            res = e1;
> +        }
> +
> +        rd = INSERT32(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * PUSATI.W - Packed 32-bit unsigned saturate to immediate bit-width (RV64 only)
> + * For each word: rd[i] = usat(rs1[i], imm bits)
> + */
> +uint64_t HELPER(pusati_w)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t imm)
> +{
> +    uint64_t rd = 0;
> +    int elems = 2;
> +    uint64_t max = (1ULL << imm) - 1;
> +    int sat = 0;
> +
> +    for (int i = 0; i < elems; i++) {
> +        int32_t e1 = (int32_t)EXTRACT32(rs1, i);
> +        int32_t res;
> +
> +        if (e1 < 0) {
> +            res = 0;
> +            sat = 1;
> +        } else if ((uint32_t)e1 > max) {
> +            res = max;
> +            sat = 1;
> +        } else {
> +            res = e1;
> +        }
> +
> +        rd = INSERT32(rd, res, i);
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return rd;
> +}
> +
> +/**
> + * SATI_32 - 32-bit scalar signed saturation with immediate range
> + */
> +uint32_t HELPER(sati_32)(CPURISCVState *env,
> +                         uint32_t rs1, uint32_t imm)
> +{
> +    int32_t a = (int32_t)rs1;
> +    int range = (imm & 0x1F) + 1;  /* imm specifies bits-1 */
> +    int64_t max = (1LL << (range - 1)) - 1;
> +    int64_t min = -(1LL << (range - 1));
> +    int sat = 0;
> +
> +    if (a > max) {
> +        a = max;
> +        sat = 1;
> +    } else if (a < min) {
> +        a = min;
> +        sat = 1;
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return (uint32_t)a;
> +}
> +
> +/**
> + * USATI_32 - 32-bit scalar unsigned saturation with immediate range
> + */
> +uint32_t HELPER(usati_32)(CPURISCVState *env,
> +                          uint32_t rs1, uint32_t imm)
> +{
> +    int32_t a = (int32_t)rs1;
> +    uint32_t max = (1U << imm) - 1;
> +    int sat = 0;
> +
> +    if (a < 0) {
> +        a = 0;
> +        sat = 1;
> +    } else if ((uint32_t)a > max) {
> +        a = max;
> +        sat = 1;
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return (uint32_t)a;
> +}
> +
> +/**
> + * SATI_64 - 64-bit scalar signed saturation with immediate range
> + */
> +uint64_t HELPER(sati_64)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t imm)
> +{
> +    int64_t a = (int64_t)rs1;
> +    int range = (imm & 0x3F) + 1;
> +    int64_t max = (1LL << (range - 1)) - 1;
> +    int64_t min = -(1LL << (range - 1));
> +    int sat = 0;
> +
> +    if (a > max) {
> +        a = max;
> +        sat = 1;
> +    } else if (a < min) {
> +        a = min;
> +        sat = 1;
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return (uint64_t)a;
> +}
> +
> +/**
> + * USATI_64 - 64-bit scalar unsigned saturation with immediate range
> + */
> +uint64_t HELPER(usati_64)(CPURISCVState *env,
> +                     uint64_t rs1, uint64_t imm)
> +{
> +    int64_t a = (int64_t)rs1;
> +    uint64_t max = (1ULL << imm) - 1;
> +    int sat = 0;
> +
> +    if (a < 0) {
> +        a = 0;
> +        sat = 1;
> +    } else if ((uint64_t)a > max) {
> +        a = max;
> +        sat = 1;
> +    }
> +
> +    if (sat) {
> +        env->vxsat = 1;
> +    }
> +    return (uint64_t)a;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 81087e0a5d..de3ec7a7ec 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1206,6 +1206,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>  #include "insn_trans/trans_rvh.c.inc"
>  #include "insn_trans/trans_rvv.c.inc"
>  #include "insn_trans/trans_rvb.c.inc"
> +#include "insn_trans/trans_rvp.c.inc"
>  #include "insn_trans/trans_rvzicond.c.inc"
>  #include "insn_trans/trans_rvzacas.c.inc"
>  #include "insn_trans/trans_rvzabha.c.inc"
> -- 
> 2.34.1
> 

