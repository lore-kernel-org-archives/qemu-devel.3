Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3D3CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zDV-0001xZ-35; Tue, 23 Sep 2025 05:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0zDL-0001v7-H4
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:21:36 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1v0zDF-0002IQ-4u
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:21:33 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-74526ca7d64so5636666a34.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1758619286; x=1759224086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=67hMkwXZAAUqzin3wScDBUkjdBSc1sMjzHS7+cu770Q=;
 b=ljQ9s7Nru9YswEdahFy1XT7RXpxID/6q2yz1SJqybqx1xCAEUlRNxEMK1xxTv3nE4V
 AyrZ4K/kJUYjtXLhx48epaY4sJRiLmzHbjl60IPfOqRtG0T5zk+stD/SMGfeQ8xFHZXc
 8jF2cnjHGNO+YSB+kWtN2oL7V0SCUk3qV3NgoTlVJO8j6XfdtKBJEsNJSHS59BgMocuk
 R7xG68MP+hVO5o+hq0K1Kdvu6A7QnkN9vHmJ4BX2CCXeznpUytgJ+CTBWinZt9fKU24C
 Gptq6qI9pku63L5bwEMaW1JpCeUce+QX2wI0YXQ2CbR13uQarOq8oIAIGNIj23Q5eDlg
 OHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758619286; x=1759224086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=67hMkwXZAAUqzin3wScDBUkjdBSc1sMjzHS7+cu770Q=;
 b=ooZadptJo3rukOuK8glBYV5fXDQBjAAdur/kAqrRd26yoNy5NUPvexl0yTJyRu/9qy
 7rBIpuaGrlGfkrEsHy5gKBJEVdkilptU4bFhckL4+y7meDa4M8kasFkU2hq4bEMRGXLH
 PhG0BuoOe/NPhD2uiZfiODdUlcjc2V/uHI5ciWnS/EQRsvF98Nevsi46307Woui4bJUD
 cEvfHCohGlyxj+mqgbbMprXdQ2CfJhnuuWxzcM35DVbtlSxKb4TbXnK5NtG7jJAcKJCb
 PtNkEKe+WTw82DX1O7nPuTyNuKP62xEHcFz4JSi7vvNzXCqW2KK+WsqPpVFCYa7yJ1Lk
 52+A==
X-Gm-Message-State: AOJu0YwsGhyWJQjU5JpfRGLDasBCj8QPoy2y1sfRyNtqxRngFzXDryQz
 QmNZA9qm3GZrcBP8f1fv/RadOxE2YlvCYdY7A3mHnr9pesG99s5/xjgrnY+uIkKGoNaISqKtogu
 sseTqQ8IlM1+Zi8MU5ihSdh3EvPqae9Y5I6vrKWiNBQ43FEunV6DxxdI=
X-Gm-Gg: ASbGncs3yel2W3I9A+Fwfm59VcD9+ERZ0Lc7LNNn2y0cmx6jAbP50AuOgf+FL7Iu6GD
 VLjlTzZM0yze30jjStXUyLFx10cyJK23yAKbPVa985ZvK4plhmag3PtZbJ4GxD2VCpyKj05/OwZ
 JcyS28YlvhhmzdcQcM2eMFEjDsHiFDdjUM+xRF3DzBAcZt7kCEiWhjIuB2EWLLswLpvQnBXxOCE
 V93Ho2pvA==
X-Google-Smtp-Source: AGHT+IFZgumaHOGHHsPTkSyhl8KNXOjaQ7g+kC3BnkHKJG1BMJAKbANCwcjJTZF9ZfITLSBEEFuzLUZCj+i/Z8RvUnk=
X-Received: by 2002:a05:6808:3a17:b0:438:22cd:298e with SMTP id
 5614622812f47-43f2d28292fmr1090265b6e.1.1758619285695; Tue, 23 Sep 2025
 02:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250124073325.2467664-1-max.chou@sifive.com>
In-Reply-To: <20250124073325.2467664-1-max.chou@sifive.com>
From: Max Chou <max.chou@sifive.com>
Date: Tue, 23 Sep 2025 17:21:14 +0800
X-Gm-Features: AS18NWDFmfIDz4pP7nkblrJbCu3T3ROP4bule0IdT4p0EqbrXEfOlDzlGpGrqsc
Message-ID: <CANiaA1tnP1vrVQtE77AvBK=Lckw9zr96Rb3n-m_bhkk6D7z13Q@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Fix vslide1[up|down].vx unexpected
 result when XLEN=32 and SEW=64
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d1c62d063f747505"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=max.chou@sifive.com; helo=mail-ot1-x32f.google.com
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

--000000000000d1c62d063f747505
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

On Fri, Jan 24, 2025 at 3:33=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:

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
> @@ -1099,14 +1099,14 @@ DEF_HELPER_6(vslidedown_vx_b, void, ptr, ptr, tl,
> ptr, env, i32)
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
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc
> b/target/riscv/insn_trans/trans_rvv.c.inc
> index b9883a5d323..775fe1baae7 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3391,7 +3391,6 @@ static bool slideup_check(DisasContext *s, arg_rmrr
> *a)
>  }
>
>  GEN_OPIVX_TRANS(vslideup_vx, slideup_check)
> -GEN_OPIVX_TRANS(vslide1up_vx, slideup_check)
>  GEN_OPIVI_TRANS(vslideup_vi, IMM_ZX, vslideup_vx, slideup_check)
>
>  static bool slidedown_check(DisasContext *s, arg_rmrr *a)
> @@ -3402,9 +3401,56 @@ static bool slidedown_check(DisasContext *s,
> arg_rmrr *a)
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

--000000000000d1c62d063f747505
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5waW5nPC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIGdtYWlsX3F1b3RlX2NvbnRhaW5lciI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWls
X2F0dHIiPk9uIEZyaSwgSmFuIDI0LCAyMDI1IGF0IDM6MzPigK9QTSBNYXggQ2hvdSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOm1heC5jaG91QHNpZml2ZS5jb20iPm1heC5jaG91QHNpZml2ZS5jb208L2E+
Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHls
ZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0LXdpZHRoOjFweDtib3JkZXIt
bGVmdC1zdHlsZTpzb2xpZDtib3JkZXItbGVmdC1jb2xvcjpyZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPldoZW4gWExFTiBpcyAzMiBhbmQgU0VXIGlzIDY0LCB0aGUgb3JpZ2luYWwg
aW1wbGVtZW50YXRpb24gb2Y8YnI+DQp2c2xpZGUxdXAudnggYW5kIHZzbGlkZTFkb3duLnZ4IGhl
bHBlciBmdW5jdGlvbnMgZmlsbHMgdGhlIDMyLWJpdCB2YWx1ZTxicj4NCm9mIHJzMSBpbnRvIHRo
ZSBmaXJzdCBlbGVtZW50IG9mIHRoZSBkZXN0aW5hdGlvbiB2ZWN0b3IgcmVnaXN0ZXIgKHJkKSw8
YnI+DQp3aGljaCBpcyBhIDY0LWJpdCBlbGVtZW50Ljxicj4NCjxicj4NClRoaXMgY29tbWl0IGF0
dGVtcHRlZCB0byByZXNvbHZlIHRoZSBpc3N1ZSBieSBleHRlbmRpbmcgdGhlIHJzMSB2YWx1ZTxi
cj4NCnRvIDY0IGJpdHMgZHVyaW5nIHRoZSBUQ0cgdHJhbnNsYXRpb24gcGhhc2UgdG8gZW5zdXJl
IHRoYXQgdGhlIGhlbHBlcjxicj4NCmZ1bmN0aW9ucyB3b24mIzM5O3QgbG9zdCB0aGUgaGlnZXIg
MzIgYml0cy48YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBNYXggQ2hvdSAmbHQ7PGEgaHJlZj0i
bWFpbHRvOm1heC5jaG91QHNpZml2ZS5jb20iIHRhcmdldD0iX2JsYW5rIj5tYXguY2hvdUBzaWZp
dmUuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoHRhcmdldC9yaXNjdi9oZWxwZXIuaMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfCAxNiArKysrLS0tLTxicj4NCsKgdGFyZ2V0L3Jpc2N2
L2luc25fdHJhbnMvdHJhbnNfcnZ2LmMuaW5jIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysr
LTxicj4NCsKgdGFyZ2V0L3Jpc2N2L3ZlY3Rvcl9oZWxwZXIuY8KgIMKgIMKgIMKgIMKgIMKgIHwg
MjAgKysrKystLS0tLTxicj4NCsKgMyBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCAy
MCBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2hlbHBl
ci5oIGIvdGFyZ2V0L3Jpc2N2L2hlbHBlci5oPGJyPg0KaW5kZXggMTZlYTI0MGQyNmQuLjA1Nzhk
MTUzYmRmIDEwMDY0NDxicj4NCi0tLSBhL3RhcmdldC9yaXNjdi9oZWxwZXIuaDxicj4NCisrKyBi
L3RhcmdldC9yaXNjdi9oZWxwZXIuaDxicj4NCkBAIC0xMDk5LDE0ICsxMDk5LDE0IEBAIERFRl9I
RUxQRVJfNih2c2xpZGVkb3duX3Z4X2IsIHZvaWQsIHB0ciwgcHRyLCB0bCwgcHRyLCBlbnYsIGkz
Mik8YnI+DQrCoERFRl9IRUxQRVJfNih2c2xpZGVkb3duX3Z4X2gsIHZvaWQsIHB0ciwgcHRyLCB0
bCwgcHRyLCBlbnYsIGkzMik8YnI+DQrCoERFRl9IRUxQRVJfNih2c2xpZGVkb3duX3Z4X3csIHZv
aWQsIHB0ciwgcHRyLCB0bCwgcHRyLCBlbnYsIGkzMik8YnI+DQrCoERFRl9IRUxQRVJfNih2c2xp
ZGVkb3duX3Z4X2QsIHZvaWQsIHB0ciwgcHRyLCB0bCwgcHRyLCBlbnYsIGkzMik8YnI+DQotREVG
X0hFTFBFUl82KHZzbGlkZTF1cF92eF9iLCB2b2lkLCBwdHIsIHB0ciwgdGwsIHB0ciwgZW52LCBp
MzIpPGJyPg0KLURFRl9IRUxQRVJfNih2c2xpZGUxdXBfdnhfaCwgdm9pZCwgcHRyLCBwdHIsIHRs
LCBwdHIsIGVudiwgaTMyKTxicj4NCi1ERUZfSEVMUEVSXzYodnNsaWRlMXVwX3Z4X3csIHZvaWQs
IHB0ciwgcHRyLCB0bCwgcHRyLCBlbnYsIGkzMik8YnI+DQotREVGX0hFTFBFUl82KHZzbGlkZTF1
cF92eF9kLCB2b2lkLCBwdHIsIHB0ciwgdGwsIHB0ciwgZW52LCBpMzIpPGJyPg0KLURFRl9IRUxQ
RVJfNih2c2xpZGUxZG93bl92eF9iLCB2b2lkLCBwdHIsIHB0ciwgdGwsIHB0ciwgZW52LCBpMzIp
PGJyPg0KLURFRl9IRUxQRVJfNih2c2xpZGUxZG93bl92eF9oLCB2b2lkLCBwdHIsIHB0ciwgdGws
IHB0ciwgZW52LCBpMzIpPGJyPg0KLURFRl9IRUxQRVJfNih2c2xpZGUxZG93bl92eF93LCB2b2lk
LCBwdHIsIHB0ciwgdGwsIHB0ciwgZW52LCBpMzIpPGJyPg0KLURFRl9IRUxQRVJfNih2c2xpZGUx
ZG93bl92eF9kLCB2b2lkLCBwdHIsIHB0ciwgdGwsIHB0ciwgZW52LCBpMzIpPGJyPg0KK0RFRl9I
RUxQRVJfNih2c2xpZGUxdXBfdnhfYiwgdm9pZCwgcHRyLCBwdHIsIGk2NCwgcHRyLCBlbnYsIGkz
Mik8YnI+DQorREVGX0hFTFBFUl82KHZzbGlkZTF1cF92eF9oLCB2b2lkLCBwdHIsIHB0ciwgaTY0
LCBwdHIsIGVudiwgaTMyKTxicj4NCitERUZfSEVMUEVSXzYodnNsaWRlMXVwX3Z4X3csIHZvaWQs
IHB0ciwgcHRyLCBpNjQsIHB0ciwgZW52LCBpMzIpPGJyPg0KK0RFRl9IRUxQRVJfNih2c2xpZGUx
dXBfdnhfZCwgdm9pZCwgcHRyLCBwdHIsIGk2NCwgcHRyLCBlbnYsIGkzMik8YnI+DQorREVGX0hF
TFBFUl82KHZzbGlkZTFkb3duX3Z4X2IsIHZvaWQsIHB0ciwgcHRyLCBpNjQsIHB0ciwgZW52LCBp
MzIpPGJyPg0KK0RFRl9IRUxQRVJfNih2c2xpZGUxZG93bl92eF9oLCB2b2lkLCBwdHIsIHB0ciwg
aTY0LCBwdHIsIGVudiwgaTMyKTxicj4NCitERUZfSEVMUEVSXzYodnNsaWRlMWRvd25fdnhfdywg
dm9pZCwgcHRyLCBwdHIsIGk2NCwgcHRyLCBlbnYsIGkzMik8YnI+DQorREVGX0hFTFBFUl82KHZz
bGlkZTFkb3duX3Z4X2QsIHZvaWQsIHB0ciwgcHRyLCBpNjQsIHB0ciwgZW52LCBpMzIpPGJyPg0K
PGJyPg0KwqBERUZfSEVMUEVSXzYodmZzbGlkZTF1cF92Zl9oLCB2b2lkLCBwdHIsIHB0ciwgaTY0
LCBwdHIsIGVudiwgaTMyKTxicj4NCsKgREVGX0hFTFBFUl82KHZmc2xpZGUxdXBfdmZfdywgdm9p
ZCwgcHRyLCBwdHIsIGk2NCwgcHRyLCBlbnYsIGkzMik8YnI+DQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZ2LmMuaW5jIGIvdGFyZ2V0L3Jpc2N2L2luc25fdHJh
bnMvdHJhbnNfcnZ2LmMuaW5jPGJyPg0KaW5kZXggYjk4ODNhNWQzMjMuLjc3NWZlMWJhYWU3IDEw
MDY0NDxicj4NCi0tLSBhL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYzxi
cj4NCisrKyBiL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYzxicj4NCkBA
IC0zMzkxLDcgKzMzOTEsNiBAQCBzdGF0aWMgYm9vbCBzbGlkZXVwX2NoZWNrKERpc2FzQ29udGV4
dCAqcywgYXJnX3JtcnIgKmEpPGJyPg0KwqB9PGJyPg0KPGJyPg0KwqBHRU5fT1BJVlhfVFJBTlMo
dnNsaWRldXBfdngsIHNsaWRldXBfY2hlY2spPGJyPg0KLUdFTl9PUElWWF9UUkFOUyh2c2xpZGUx
dXBfdngsIHNsaWRldXBfY2hlY2spPGJyPg0KwqBHRU5fT1BJVklfVFJBTlModnNsaWRldXBfdmks
IElNTV9aWCwgdnNsaWRldXBfdngsIHNsaWRldXBfY2hlY2spPGJyPg0KPGJyPg0KwqBzdGF0aWMg
Ym9vbCBzbGlkZWRvd25fY2hlY2soRGlzYXNDb250ZXh0ICpzLCBhcmdfcm1yciAqYSk8YnI+DQpA
QCAtMzQwMiw5ICszNDAxLDU2IEBAIHN0YXRpYyBib29sIHNsaWRlZG93bl9jaGVjayhEaXNhc0Nv
bnRleHQgKnMsIGFyZ19ybXJyICphKTxicj4NCsKgfTxicj4NCjxicj4NCsKgR0VOX09QSVZYX1RS
QU5TKHZzbGlkZWRvd25fdngsIHNsaWRlZG93bl9jaGVjayk8YnI+DQotR0VOX09QSVZYX1RSQU5T
KHZzbGlkZTFkb3duX3Z4LCBzbGlkZWRvd25fY2hlY2spPGJyPg0KwqBHRU5fT1BJVklfVFJBTlMo
dnNsaWRlZG93bl92aSwgSU1NX1pYLCB2c2xpZGVkb3duX3Z4LCBzbGlkZWRvd25fY2hlY2spPGJy
Pg0KPGJyPg0KK3R5cGVkZWYgdm9pZCBnZW5faGVscGVyX3ZzbGlkZTFfdngoVENHdl9wdHIsIFRD
R3ZfcHRyLCBUQ0d2X2k2NCwgVENHdl9wdHIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFRDR3ZfZW52LCBUQ0d2X2kzMik7PGJyPg0KKzxicj4N
CisjZGVmaW5lIEdFTl9PUElWWF9WU0xJREUxX1RSQU5TKE5BTUUsIENIRUNLKcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorc3RhdGljIGJvb2wgdHJhbnNf
IyNOQU1FKERpc2FzQ29udGV4dCAqcywgYXJnX3JtcnIgKmEpwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgXDxicj4NCit7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPg0KK8KgIMKgIGlmIChDSEVDSyhzLCBhKSkge8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFw8YnI+DQorwqAgwqAgwqAgwqAgc3RhdGljIGdlbl9oZWxwZXJfdnNsaWRlMV92eCAqIGNvbnN0
IGZuc1s0XSA9IHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgZ2VuX2hlbHBlcl8jI05BTUUjI19iLCBnZW5faGVscGVyXyMjTkFNRSMjX2gswqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGdlbl9oZWxwZXJfIyNO
QU1FIyNfdywgZ2VuX2hlbHBlcl8jI05BTUUjI19kLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCivCoCDCoCDCoCDCoCB9O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCivCoCDCoCDCoCDCoCBUQ0d2X3B0ciBkZXN0LCBzcmMyLCBtYXNrO8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAg
wqAgwqAgwqAgVENHdl9pNjQgc3JjMTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKg
IMKgIFRDR3ZfaTMyIGRlc2M7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCB1
aW50MzJfdCBkYXRhID0gMDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgwqAgwqAgZGVzdCA9
IHRjZ190ZW1wX25ld19wdHIoKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIG1hc2sgPSB0Y2dfdGVtcF9u
ZXdfcHRyKCk7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCBzcmMyID0gdGNnX3RlbXBfbmV3X3B0cigpO8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQorwqAgwqAgwqAgwqAgc3JjMSA9IHRjZ190ZW1wX25ld19pNjQoKTvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAg
wqAgwqAgwqAgZGF0YSA9IEZJRUxEX0RQMzIoZGF0YSwgVkRBVEEsIFZNLCBhLSZndDt2bSk7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCBkYXRhID0g
RklFTERfRFAzMihkYXRhLCBWREFUQSwgTE1VTCwgcy0mZ3Q7bG11bCk7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCBkYXRhID0gRklFTERfRFAzMihkYXRhLCBW
REFUQSwgVlRBLCBzLSZndDt2dGEpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+
DQorwqAgwqAgwqAgwqAgZGF0YSA9IEZJRUxEX0RQMzIoZGF0YSwgVkRBVEEsIFZUQV9BTExfMVMs
IHMtJmd0O2NmZ192dGFfYWxsXzFzKTvCoCBcPGJyPg0KK8KgIMKgIMKgIMKgIGRhdGEgPSBGSUVM
RF9EUDMyKGRhdGEsIFZEQVRBLCBWTUEsIHMtJmd0O3ZtYSk7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCBkZXNjID0gdGNnX2NvbnN0YW50X2kzMihzaW1k
X2Rlc2Mocy0mZ3Q7Y2ZnX3B0ci0mZ3Q7dmxlbmIswqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzLSZndDtjZmdf
cHRyLSZndDt2bGVuYiwgZGF0YSkpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDC
oCDCoCDCoCB0Y2dfZ2VuX2FkZGlfcHRyKGRlc3QsIHRjZ19lbnYsIHZyZWdfb2ZzKHMsIGEtJmd0
O3JkKSk7wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCB0Y2dfZ2VuX2FkZGlf
cHRyKHNyYzIsIHRjZ19lbnYsIHZyZWdfb2ZzKHMsIGEtJmd0O3JzMikpO8KgIMKgIMKgIMKgIMKg
IMKgXDxicj4NCivCoCDCoCDCoCDCoCB0Y2dfZ2VuX2FkZGlfcHRyKG1hc2ssIHRjZ19lbnYsIHZy
ZWdfb2ZzKHMsIDApKTvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKg
IHRjZ19nZW5fZXh0X3RsX2k2NChzcmMxLCBnZXRfZ3ByKHMsIGEtJmd0O3JzMSwgRVhUX1NJR04p
KTvCoCDCoCDCoCDCoCDCoFw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCivCoCDCoCDCoCDCoCBmbnNbcy0mZ3Q7c2V3XShkZXN0
LCBtYXNrLCBzcmMxLCBzcmMyLCB0Y2dfZW52LCBkZXNjKTvCoCDCoCDCoCDCoCDCoCDCoCDCoFw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj4NCivCoCDCoCDCoCDCoCB0Y2dfZ2VuX21vdmlfdGwoY3B1X3ZzdGFydCwgMCk7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKg
IMKgIMKgIGZpbmFsaXplX3J2dl9pbnN0KHMpO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KK8KgIMKgIMKgIMKg
IHJldHVybiB0cnVlO8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQorwqAgwqAgfcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCByZXR1cm4g
ZmFsc2U7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK308YnI+DQorPGJyPg0KK0dF
Tl9PUElWWF9WU0xJREUxX1RSQU5TKHZzbGlkZTF1cF92eCwgc2xpZGV1cF9jaGVjayk8YnI+DQor
R0VOX09QSVZYX1ZTTElERTFfVFJBTlModnNsaWRlMWRvd25fdngsIHNsaWRlZG93bl9jaGVjayk8
YnI+DQorPGJyPg0KwqAvKiBWZWN0b3IgRmxvYXRpbmctUG9pbnQgU2xpZGUgSW5zdHJ1Y3Rpb25z
ICovPGJyPg0KwqBzdGF0aWMgYm9vbCBmc2xpZGV1cF9jaGVjayhEaXNhc0NvbnRleHQgKnMsIGFy
Z19ybXJyICphKTxicj4NCsKgezxicj4NCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdmVjdG9y
X2hlbHBlci5jIGIvdGFyZ2V0L3Jpc2N2L3ZlY3Rvcl9oZWxwZXIuYzxicj4NCmluZGV4IDUzODZl
M2I5N2M1Li5jN2ZlMzQyNGM0NyAxMDA2NDQ8YnI+DQotLS0gYS90YXJnZXQvcmlzY3YvdmVjdG9y
X2hlbHBlci5jPGJyPg0KKysrIGIvdGFyZ2V0L3Jpc2N2L3ZlY3Rvcl9oZWxwZXIuYzxicj4NCkBA
IC01MTQ1LDExICs1MTQ1LDExIEBAIEdFTl9WRVhUX1ZTTElFMVVQKDE2LCBIMik8YnI+DQrCoEdF
Tl9WRVhUX1ZTTElFMVVQKDMyLCBINCk8YnI+DQrCoEdFTl9WRVhUX1ZTTElFMVVQKDY0LCBIOCk8
YnI+DQo8YnI+DQotI2RlZmluZSBHRU5fVkVYVF9WU0xJREUxVVBfVlgoTkFNRSwgQklUV0lEVEgp
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLXZvaWQgSEVMUEVSKE5BTUUp
KHZvaWQgKnZkLCB2b2lkICp2MCwgdGFyZ2V0X3Vsb25nIHMxLCB2b2lkICp2czIsIFw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50MzJfdCBk
ZXNjKcKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQote8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCB2c2xpZGUxdXBfIyNCSVRXSURUSCh2ZCwg
djAsIHMxLCB2czIsIGVudiwgZGVzYyk7wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KKyNkZWZp
bmUgR0VOX1ZFWFRfVlNMSURFMVVQX1ZYKE5BTUUsIEJJVFdJRFRIKcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4NCit2b2lkIEhFTFBFUihOQU1FKSh2b2lkICp2ZCwgdm9pZCAqdjAs
IHVpbnQ2NF90IHMxLCB2b2lkICp2czIswqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIENQVVJJU0NWU3RhdGUgKmVudiwgdWludDMyX3QgZGVzYynCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPg0KK3vCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQor
wqAgwqAgdnNsaWRlMXVwXyMjQklUV0lEVEgodmQsIHYwLCBzMSwgdnMyLCBlbnYsIGRlc2MpO8Kg
IMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgfTxicj4NCjxicj4NCsKgLyogdnNsaWRlMXVwLnZ4IHZk
LCB2czIsIHJzMSwgdm0gIyB2ZFswXT14W3JzMV0sIHZkW2krMV0gPSB2czJbaV0gKi88YnI+DQpA
QCAtNTE5NiwxMSArNTE5NiwxMSBAQCBHRU5fVkVYVF9WU0xJREUxRE9XTigxNiwgSDIpPGJyPg0K
wqBHRU5fVkVYVF9WU0xJREUxRE9XTigzMiwgSDQpPGJyPg0KwqBHRU5fVkVYVF9WU0xJREUxRE9X
Tig2NCwgSDgpPGJyPg0KPGJyPg0KLSNkZWZpbmUgR0VOX1ZFWFRfVlNMSURFMURPV05fVlgoTkFN
RSwgQklUV0lEVEgpwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLXZvaWQgSEVM
UEVSKE5BTUUpKHZvaWQgKnZkLCB2b2lkICp2MCwgdGFyZ2V0X3Vsb25nIHMxLCB2b2lkICp2czIs
IFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQ1BVUklTQ1ZTdGF0ZSAqZW52LCB1
aW50MzJfdCBkZXNjKcKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQote8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCi3CoCDCoCB2c2xpZGUxZG93bl8jI0JJ
VFdJRFRIKHZkLCB2MCwgczEsIHZzMiwgZW52LCBkZXNjKTvCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
DQorI2RlZmluZSBHRU5fVkVYVF9WU0xJREUxRE9XTl9WWChOQU1FLCBCSVRXSURUSCnCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQordm9pZCBIRUxQRVIoTkFNRSkodm9pZCAqdmQsIHZv
aWQgKnYwLCB1aW50NjRfdCBzMSwgdm9pZCAqdnMyLMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBDUFVSSVNDVlN0YXRlICplbnYsIHVpbnQzMl90IGRlc2MpwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj4NCit7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPg0KK8KgIMKgIHZzbGlkZTFkb3duXyMjQklUV0lEVEgodmQsIHYwLCBzMSwgdnMyLCBlbnYs
IGRlc2MpO8KgIMKgIMKgIMKgIMKgXDxicj4NCsKgfTxicj4NCjxicj4NCsKgLyogdnNsaWRlMWRv
d24udnggdmQsIHZzMiwgcnMxLCB2bSAjIHZkW2ldID0gdnMyW2krMV0sIHZkW3ZsLTFdPXhbcnMx
XSAqLzxicj4NCi0tIDxicj4NCjIuMzQuMTxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj4N
Cg==
--000000000000d1c62d063f747505--

