Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F87CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 01:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v32jx-0007m3-6C; Sun, 28 Sep 2025 21:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32jt-0007ll-6o
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:31:42 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32jk-0004TC-8q
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:31:40 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo200936966b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 18:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759109484; x=1759714284; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8k3TJy0qaO2jzUEjuZvTIEwClS0bsXt+xt6Xz7FY8nA=;
 b=U9cE7xAnPE0+iKfOjqxycUFgMJ48njHj5gcg5wY5FgT6VT+vbAS9kTeFA4oeXZtZJk
 NoDP0L2YgeJkRZKVNwlNhLPUb7poOhCXSDuZ5/V2N9RQ6jHBUAy+SQCvZRGTqE1gQH+u
 4nN6KjIp5crlaCM5y6vhpVIC9j7pKANwI9QimrejULeFBrz8awO5q/2rBNDfAmKnACLd
 HltqvXX/WhCvcwuQIqdHTubYAcm4zF/NG81FiOsMu1Zz8JARq230F3QGmGqZSIdBMfsa
 bFy+lbKyFRywCW4/XP+j07QW9hds9+sVC4CB9aZsgd8RsSSE4NaWpBmcoAuHVeuelT4u
 GZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759109484; x=1759714284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8k3TJy0qaO2jzUEjuZvTIEwClS0bsXt+xt6Xz7FY8nA=;
 b=sNuqv18miJLhSeVFThvfvbGu9VB4v2JoLYQQXCBQZ1QXlIDXXyS+EcHVk1k5psA15Z
 qtaDiT9vNiYpX4+A2y99nkdxc0ILUDsjVfFqBYnJ4zISZBboufIV9fHa+99vVJ6O3Kh+
 DP90YYkF2jFXXHHXFW0pXVfO9I8N7hapDYLK9q9KHzKvo+2AY7dezBx2hynvkRDIr6iK
 urQkEu2fyoMmg9f0iyUBnr8GaOZ2SqCmSwqUozreCJvThlAl1JHU4nH5mk5u5tNt3XMO
 f48zurMJlHQi2JwvyvCIxh33C1PmKskWAohIsS59v57Wzs2NL66TmKi7QxRGEbWQA2W+
 RlQQ==
X-Gm-Message-State: AOJu0YzZfn231x0YPcKkrdpj6baNSSReyjT3SGgPaqiCGbLlB/rtt/ci
 5DnFJYXT+msGxDyKQg6jHb11tmJJdvq4wwsOt6vTQclU8mspfcD9YBwZhLocgCeKkBjS2lEY69R
 RIVQrjIRJ4+wpp1HjVn5ica206LV2ieU=
X-Gm-Gg: ASbGnctRJWpj8KaKS8/3p0/Alak3f9HnOpxk3KMhqDJqROTR68xt4t+kD4Vtk3iQEWw
 cH43oe816/DsNFsuji+AOR332kFYY8mKymAglNVaNtM5Exm1JDco9bBgwjLUnnXCL/hMZw6UUFj
 cHQJ4NoW63VqVxhIJ09s1D2paigNuvNyjfIp1mkqHRSCNSTFPHi2FOflwL0dxYBL/TJwTTzrr+t
 7OPD5tCOzyl9lUTcPRXZSpsB6L8H5y4E46uAQ==
X-Google-Smtp-Source: AGHT+IGIhMzo93VNFfdFEr2+iP+S0HpSAAKYcicFThnp8oTjSm9U3V9pO5yr94LmwyoIGrs8HwW5xd4wY7LZS2n25bU=
X-Received: by 2002:a17:906:730a:b0:b2d:e514:534c with SMTP id
 a640c23a62f3a-b34ba5452a0mr1581292566b.42.1759109484455; Sun, 28 Sep 2025
 18:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250124073325.2467664-1-max.chou@sifive.com>
In-Reply-To: <20250124073325.2467664-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 11:30:58 +1000
X-Gm-Features: AS18NWCyssXNchnIh3dlYq8JIzNfktXxrIycSRMgzrzwGIIANYxXQ7HS9-oIcy4
Message-ID: <CAKmqyKNGeYg-oaNK2spnFbDpxVOkarzD_Dn=-gTNV=NWETUQLg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Fix vslide1[up|down].vx unexpected
 result when XLEN=32 and SEW=64
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Fri, Jan 24, 2025 at 5:34=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> When XLEN is 32 and SEW is 64, the original implementation of
> vslide1up.vx and vslide1down.vx helper functions fills the 32-bit value
> of rs1 into the first element of the destination vector register (rd),
> which is a 64-bit element.
>
> This commit attempted to resolve the issue by extending the rs1 value
> to 64 bits during the TCG translation phase to ensure that the helper
> functions won't lost the higer 32 bits.
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   | 16 ++++----
>  target/riscv/insn_trans/trans_rvv.c.inc | 50 ++++++++++++++++++++++++-
>  target/riscv/vector_helper.c            | 20 +++++-----
>  3 files changed, 66 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 16ea240d26d..0578d153bdf 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1099,14 +1099,14 @@ DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl,=
 ptr, env, i32)
>  DEF_HELPER_6(vslidedown_vx_h, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vslidedown_vx_w, void, ptr, ptr, tl, ptr, env, i32)
>  DEF_HELPER_6(vslidedown_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_b, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vslide1up_vx_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_b, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vslide1down_vx_d, void, ptr, ptr, i64, ptr, env, i32)
>
>  DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
>  DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index b9883a5d323..775fe1baae7 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3391,7 +3391,6 @@ static bool slideup_check(DisasContext *s, arg_rmrr=
 *a)
>  }
>
>  GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
> -GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
>  GEN_OPIVI_TRANS(vslideup_vi, IMM_ZX, vslideup_vx, slideup_check)
>
>  static bool slidedown_check(DisasContext *s, arg_rmrr *a)
> @@ -3402,9 +3401,56 @@ static bool slidedown_check(DisasContext *s, arg_r=
mrr *a)
>  }
>
>  GEN_OPIVX_TRANS(vslidedown_vx, slidedown_check)
> -GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
>  GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
>
> +typedef void gen_helper_vslide1_vx(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_pt=
r,
> +                                TCGv_env, TCGv_i32);
> +
> +#define GEN_OPIVX_VSLIDE1_TRANS(NAME, CHECK)                            =
\
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  =
\
> +{                                                                       =
\
> +    if (CHECK(s, a)) {                                                  =
\
> +        static gen_helper_vslide1_vx * const fns[4] =3D {               =
  \
> +            gen_helper_##NAME##_b, gen_helper_##NAME##_h,               =
\
> +            gen_helper_##NAME##_w, gen_helper_##NAME##_d,               =
\
> +        };                                                              =
\
> +                                                                        =
\
> +        TCGv_ptr dest, src2, mask;                                      =
\
> +        TCGv_i64 src1;                                                  =
\
> +        TCGv_i32 desc;                                                  =
\
> +        uint32_t data =3D 0;                                            =
  \
> +                                                                        =
\
> +        dest =3D tcg_temp_new_ptr();                                    =
  \
> +        mask =3D tcg_temp_new_ptr();                                    =
  \
> +        src2 =3D tcg_temp_new_ptr();                                    =
  \
> +        src1 =3D tcg_temp_new_i64();                                    =
  \
> +                                                                        =
\
> +        data =3D FIELD_DP32(data, VDATA, VM, a->vm);                    =
  \
> +        data =3D FIELD_DP32(data, VDATA, LMUL, s->lmul);                =
  \
> +        data =3D FIELD_DP32(data, VDATA, VTA, s->vta);                  =
  \
> +        data =3D FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);=
  \
> +        data =3D FIELD_DP32(data, VDATA, VMA, s->vma);                  =
  \
> +        desc =3D tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,          =
  \
> +                                s->cfg_ptr->vlenb, data));              =
\
> +                                                                        =
\
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            =
\
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));           =
\
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                =
\
> +        tcg_gen_ext_tl_i64(src1, get_gpr(s, a->rs1, EXT_SIGN));         =
\
> +                                                                        =
\
> +        fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             =
\
> +                                                                        =
\
> +        tcg_gen_movi_tl(cpu_vstart, 0);                                 =
\
> +        finalize_rvv_inst(s);                                           =
\
> +                                                                        =
\
> +        return true;                                                    =
\
> +    }                                                                   =
\
> +    return false;                                                       =
\
> +}
> +
> +GEN_OPIVX_VSLIDE1_TRANS(vslide1up_vx, slideup_check)
> +GEN_OPIVX_VSLIDE1_TRANS(vslide1down_vx, slidedown_check)
> +
>  /* Vector Floating-Point Slide Instructions */
>  static bool fslideup_check(DisasContext *s, arg_rmrr *a)
>  {
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 5386e3b97c5..c7fe3424c47 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5145,11 +5145,11 @@ GEN_VEXT_VSLIE1UP(16, H2)
>  GEN_VEXT_VSLIE1UP(32, H4)
>  GEN_VEXT_VSLIE1UP(64, H8)
>
> -#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                     \
> -void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
> -                  CPURISCVState *env, uint32_t desc)              \
> -{                                                                 \
> -    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);             \
> +#define GEN_VEXT_VSLIDE1UP_VX(NAME, BITWIDTH)                   \
> +void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
> +                  CPURISCVState *env, uint32_t desc)            \
> +{                                                               \
> +    vslide1up_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
>  }
>
>  /* vslide1up.vx vd, vs2, rs1, vm # vd[0]=3Dx[rs1], vd[i+1] =3D vs2[i] */
> @@ -5196,11 +5196,11 @@ GEN_VEXT_VSLIDE1DOWN(16, H2)
>  GEN_VEXT_VSLIDE1DOWN(32, H4)
>  GEN_VEXT_VSLIDE1DOWN(64, H8)
>
> -#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                   \
> -void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2, \
> -                  CPURISCVState *env, uint32_t desc)              \
> -{                                                                 \
> -    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);           \
> +#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, BITWIDTH)                 \
> +void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,   \
> +                  CPURISCVState *env, uint32_t desc)            \
> +{                                                               \
> +    vslide1down_##BITWIDTH(vd, v0, s1, vs2, env, desc);         \
>  }
>
>  /* vslide1down.vx vd, vs2, rs1, vm # vd[i] =3D vs2[i+1], vd[vl-1]=3Dx[rs=
1] */
> --
> 2.34.1
>
>

