Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BC9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 01:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v32oY-0000H9-7K; Sun, 28 Sep 2025 21:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32oV-0000Gw-1n
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:36:27 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32oJ-0005BX-Rt
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:36:26 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-62fbfeb097eso5577409a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759109766; x=1759714566; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cb7P7XC7HZhSTbC6kBn0pAtnDdiqhjZj+Ed6F3mvlWE=;
 b=OnS5yLhuFiocTwl6/9sRz+3wz0EuW8mO1yMjIE0RbovuvyQqoA4intMcU8Z5PmlsFl
 GiAgX5D/ijG0h2DfXM9xy5c3A849jEPMnqukak8TPGdlkhCIPuTQfKWzHRhjdLDdU4ME
 +DpsJKXtbJQPpWZ7QEXr6LT8x+8OiOfhbr/B+B3I0L0xKbswCyKd+oTf3LvA6Kybx+A9
 re0w0uLCgkIpDhL9AD7KGrBoG7B4tYG4JBFxSeQEMH0+i2TtZKe7Z56dCxk+oOdWZv6D
 iN0bMnVgcocNU0q85whKSqI35suLBl67uOaWoeG5RPkVFOi7js9N4Uyy0GfBD2yXr3Nn
 v8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759109766; x=1759714566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cb7P7XC7HZhSTbC6kBn0pAtnDdiqhjZj+Ed6F3mvlWE=;
 b=YfNT0UrJL1q+HH509mnLi0Aa5YcuNfWs7chd4gh3yV8JXSFg47wx555Vph6/9qdedG
 pPJr/C4ffbqbEjUw4S0ibris092M47AFcy8FyeT4utyfG0n5t+K0I+7s9tMtfkyNmBRl
 jwHoElAo7o4RNrPob4e6pg79NpdqFmI4Ai39Ahx431P4hGjB2Q6fVZsDJE2dGjaah+qy
 RpCObuGayT3Ep2TmOTa0e4LlPW7CMdUpd0NfyM3VaUB8vE/VIKCuhMjQQlU5J81nBDIQ
 ny6r8YGbaexxFT9m6hfthuupBMxiCdmupbRHty0PvA7mXiL/AtFGcO5sAt5pB5Ob/ZA8
 GHXQ==
X-Gm-Message-State: AOJu0YxlqU5+DiADcS9qd8XLXAcKf5SwWaK73YIfPmboBX1Lrx4Rlkb+
 hECMq+fK3ZO++qSP9FPmnoBzAuKFAChs4E/26tqIr/OLS4Uf9L3tDA+/OgxofUHMvyeb6W+QtFb
 tbt4ArDcVpoydh9OXhpWFDl3OffZp8Mo=
X-Gm-Gg: ASbGncumh6SNcvfmCxuNJe+5PVGPcsouDiiE+/lWuHPx46dih9lASVxywYMCsUuni8F
 MGnouNzLJyW+h6/RrkXRAx+UNPxOdWFHQXOC2jV/VZ9lB8tSSBQZoBq4Uyv3YBOP+IATdrsJOPx
 bMxeYHJrWIqVNNZ7+np8n1RthX22KHGZpADDMH1DNFo4adMUQtin/+GsnGKGURlEitSoJmAcCKt
 ZZXxEvrNmQynQ++gWltO2nlwjRuU7torm1i95BKNwcK27OC
X-Google-Smtp-Source: AGHT+IHTyDCuRgEYBwLfdEa2SuWgS4tzp0ReCt9m5R9DPCF1+mIinPlY/lRezOqI3PEGr5+i+yd3MlkfJbH2jIKhthM=
X-Received: by 2002:a17:907:9719:b0:b04:6973:1ee9 with SMTP id
 a640c23a62f3a-b34b7105a20mr1665929466b.16.1759109766500; Sun, 28 Sep 2025
 18:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250124073325.2467664-1-max.chou@sifive.com>
In-Reply-To: <20250124073325.2467664-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 11:35:40 +1000
X-Gm-Features: AS18NWASlC-RivbTcKE_GZ0Gyi-ENNMYL9xMzvocsbprbcglCrwLKeSfe1eHRCM
Message-ID: <CAKmqyKPWbC2kOL5hU2hhKOiiQrsEuM-e9MB4yYB8Zp9CSZ0Nrg@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Thanks!

Applied to riscv-to-apply.next

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

