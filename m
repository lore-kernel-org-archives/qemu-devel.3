Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18CDCCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 01:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEeOV-0002Pb-WB; Thu, 30 Oct 2025 21:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEeOR-0002PQ-G6
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:57:31 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEeOJ-0003iu-Kl
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 21:57:31 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c4b41b38cso3489459a12.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875834; x=1762480634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCB7RZS9oe/YNNjh3MSj0NRYu5lrDPHxW+5XFPECsWI=;
 b=QHcB5bYOHa7aWqAPl+xgSuP0YIUb6kFfaxfEgKF6nnYaCsjFazx/ZQb4OjVNm/qm8b
 OhdNhT3u7+KQ049aY16YEdFLluUZLf01M/BsZCWxxp9jAWLDFqqASv+Dm6nFKGqGF5Vk
 2kw3oRcEbfX8UpIq+pZObowpWz0FlcGybaT8RPfksYfYDhsqYH5o6WqGh+mR/lF08ygC
 zFHz7yUXE0R58IC5yaZsxYx+ps5RtxYDxdEglkGSJtM4brrprnmRVQbdtKTmmNM2w2Oy
 uXalJvtSxSp8p5thvCTXCE/N+c9QldWGICjnmrC2PWuJdzFRThWPUN6vQ+Y6qkkl9sHR
 0wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875834; x=1762480634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCB7RZS9oe/YNNjh3MSj0NRYu5lrDPHxW+5XFPECsWI=;
 b=EE2O/FH1gpY0aYx7WlRPfFeALVu9+rRjgi0XILb6UGvbE2ID30zbl5WoO00Ah7CXUM
 9aKgOwykcUYdMwGvxd6HIHD1zpWbbiu0Fw5kfJ+Rerfd2NgERDQ36ykJoyYrEI0Inc7W
 2RJMFEms0X8De8yrv60QWYQO1m0yCQOIuRwUczeCRxflFIfLEEdzzX0fEX6ebkYm+Jjo
 9bZFjyZ9LmdeJ1D9z3bP07LIa5+coQ0TvzORwLOIfBzDkzXzjQ42ZuBwGX+h7YcqFTrG
 ts62TyMI0rkwpeAETU2R1566KmV3MUN2iHWUnH+l0F6rU7lhzNuDv6Fq4lQeKALnO8rl
 qkAA==
X-Gm-Message-State: AOJu0YzStbz7Q111lSEqVkrp71+w6x2nDTXNPmuxM6SvezeRZiUkgBQJ
 36gBXwiNkm1yGJaH+5PizGVRbrxnb6/9ZI/BDQ9Zgr7TN/Cw2jvxuu8rNi3sm89vIYYbuOZesrQ
 zvil8YUi96RvUcglrHSVSfBRei/gd7po=
X-Gm-Gg: ASbGncuhLmMQjvxLVnkgYazSDOzUz2xAb6S1Tk7kOf/kxyBRpXD69Mz9yFfW85PyoQx
 tsdCL9zg5P3dRuoofJIHMj9XA5N7Ske8KulGft+aRHGaUoZswBzTCxGUub2ldo4HwFiwj5a6RD+
 cOsIQmiWwz+swsHkh5VH3arhoC/gDJFTdYMELzJcLV0Q527omll8D+D21B+n9NRFl56dkFmXm6y
 YfBRo+brW3ewNT/2J6vU3rrhE8/2lFIlzmi/1T1j+CZvNsl3LwsLbWoXA/Fknw0JCwhtM0jglyW
 t4VjzHrbHruRIsay8duLbsj1uA==
X-Google-Smtp-Source: AGHT+IHQwKe3hEz4PjtXP7lf00D9VdDUe7o8U1P374uMWhvD++0Ix6Tomx9zNwect/BKim6te9KktVPRpsTcH6fuoZk=
X-Received: by 2002:a05:6402:268e:b0:63e:2d46:cc5d with SMTP id
 4fb4d7f45d1cf-64076f71156mr1340145a12.7.1761875834092; Thu, 30 Oct 2025
 18:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-11-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-11-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 11:56:47 +1000
X-Gm-Features: AWmQ_bmYjWsYO8aeICo1cuuEkjZezWZXLmvl6rAab-3-lu_xr7qqakj8hK16Mmk
Message-ID: <CAKmqyKOW2NOqCWO0LW6MsxLvjHboLzkzquJ4sV_xbL7xjSvDgw@mail.gmail.com>
Subject: Re: [PATCH v4 10/33] target/riscv: Fix size of vector CSRs
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
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

On Tue, Oct 28, 2025 at 4:28=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> According to version 20250508 of the unprivileged specification:
> - vtype: bits 0..7 used, bit XLEN-1 illegal, rest reserved
>   =3D> fix to 64-bits.
>
> - vxsat: bit 0 used, vxrm which would occupy bits 1..2 is stored
>   separately, and bits 3..31 are set to 0
>   =3D> fix to 8-bits.
>
> - vxrm: 2 lowest bits are used for rounding mode, rest set to 0
>   =3D> fix to 8-bits.
>
> - vstart: maximum value of VLMAX-1, where VLMAX is at most 2^16
>   =3D> fix to 32-bits as vstart is mapped to a TCG global.
>
> - vl: maximum value of VLEN which is at most 2^16
>   =3D> fix to 32-bits as vl is mapped to a TCG global.
>
> Fields are shuffled for reduced padding.
>
> Note, the cpu/vector VMSTATE version is bumped, breaking migration from
> older versions.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                      | 12 ++++++------
>  target/riscv/machine.c                  | 14 +++++++-------
>  target/riscv/translate.c                | 12 ++++++++----
>  target/riscv/vector_helper.c            | 22 ++++++++++++++++++----
>  target/riscv/insn_trans/trans_rvv.c.inc | 24 ++++++++++++------------
>  5 files changed, 51 insertions(+), 33 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6b4edbfe9e..bd200ccad4 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -192,7 +192,7 @@ FIELD(VTYPE, VSEW, 3, 3)
>  FIELD(VTYPE, VTA, 6, 1)
>  FIELD(VTYPE, VMA, 7, 1)
>  FIELD(VTYPE, VEDIV, 8, 2)
> -FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
> +FIELD(VTYPE, RESERVED, 10, sizeof(uint64_t) * 8 - 11)
>
>  typedef struct PMUCTRState {
>      /* Current value of a counter */
> @@ -218,11 +218,11 @@ struct CPUArchState {
>
>      /* vector coprocessor state. */
>      uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
> -    target_ulong vxrm;
> -    target_ulong vxsat;
> -    target_ulong vl;
> -    target_ulong vstart;
> -    target_ulong vtype;
> +    uint64_t vtype;
> +    uint32_t vl;
> +    uint32_t vstart;
> +    uint8_t vxrm;
> +    uint8_t vxsat;
>      bool vill;
>
>      target_ulong pc;
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 7349383eab..440b09fc32 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -137,16 +137,16 @@ static bool vector_needed(void *opaque)
>
>  static const VMStateDescription vmstate_vector =3D {
>      .name =3D "cpu/vector",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .needed =3D vector_needed,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
> -        VMSTATE_UINTTL(env.vxrm, RISCVCPU),
> -        VMSTATE_UINTTL(env.vxsat, RISCVCPU),
> -        VMSTATE_UINTTL(env.vl, RISCVCPU),
> -        VMSTATE_UINTTL(env.vstart, RISCVCPU),
> -        VMSTATE_UINTTL(env.vtype, RISCVCPU),
> +        VMSTATE_UINT64(env.vtype, RISCVCPU),
> +        VMSTATE_UINT32(env.vl, RISCVCPU),
> +        VMSTATE_UINT32(env.vstart, RISCVCPU),
> +        VMSTATE_UINT8(env.vxrm, RISCVCPU),
> +        VMSTATE_UINT8(env.vxsat, RISCVCPU),
>          VMSTATE_BOOL(env.vill, RISCVCPU),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 8df1a2ed3c..15eee7f6ee 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -39,8 +39,9 @@
>  #include "tcg/tcg-cpu.h"
>
>  /* global register indices */
> -static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc, cpu_vl, cpu_vstart;
> +static TCGv cpu_gpr[32], cpu_gprh[32], cpu_pc;
>  static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
> +static TCGv_i32 cpu_vl, cpu_vstart;
>  static TCGv load_res;
>  static TCGv load_val;
>
> @@ -1455,6 +1456,10 @@ void riscv_translate_init(void)
>      size_t field_offset =3D 0;
>  #endif
>
> +    /* 32 bits in size, no offset needed */
> +    size_t vl_offset =3D offsetof(CPURISCVState, vl);
> +    size_t vstart_offset =3D offsetof(CPURISCVState, vstart);
> +
>      for (i =3D 1; i < 32; i++) {
>          cpu_gpr[i] =3D tcg_global_mem_new(tcg_env,
>              offsetof(CPURISCVState, gpr[i]) + field_offset,
> @@ -1470,9 +1475,8 @@ void riscv_translate_init(void)
>      }
>
>      cpu_pc =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), =
"pc");
> -    cpu_vl =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, vl), =
"vl");
> -    cpu_vstart =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, v=
start),
> -                            "vstart");
> +    cpu_vl =3D tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
> +    cpu_vstart =3D tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstar=
t");
>      load_res =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_res),
>                               "load_res");
>      load_val =3D tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, loa=
d_val),
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 2de3358ee8..cf9a199566 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -360,6 +360,12 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, targ=
et_ulong addr,
>      uint32_t evl =3D env->vstart + elems;
>      MMUAccessType access_type =3D is_load ? MMU_DATA_LOAD : MMU_DATA_STO=
RE;
>
> +    /*
> +     * Maximum vector length is VLMAX =3D=3D 2^16 =3D=3D LMUL * VL / SEW=
, and
> +     * occurs for LMUL =3D=3D 8, SEW =3D=3D 8, VL =3D=3D 2^16.
> +     */
> +    g_assert(env->vstart < UINT16_MAX && UINT16_MAX - env->vstart >=3D e=
lems);
> +
>      /* Check page permission/pmp/watchpoint/etc. */
>      probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &fla=
gs,
>                  true);
> @@ -2594,19 +2600,27 @@ static inline uint8_t get_round(int vxrm, uint64_=
t v, uint8_t shift)
>
>      d1 =3D extract64(v, shift - 1, 1);
>      D1 =3D extract64(v, 0, shift);
> -    if (vxrm =3D=3D 0) { /* round-to-nearest-up (add +0.5 LSB) */
> +    switch (vxrm) {
> +    case 0:
> +        /* round-to-nearest-up (add +0.5 LSB) */
>          return d1;
> -    } else if (vxrm =3D=3D 1) { /* round-to-nearest-even */
> +    case 1:
> +        /* round-to-nearest-even */
>          if (shift > 1) {
>              D2 =3D extract64(v, 0, shift - 1);
>              return d1 & ((D2 !=3D 0) | d);
>          } else {
>              return d1 & d;
>          }
> -    } else if (vxrm =3D=3D 3) { /* round-to-odd (OR bits into LSB, aka "=
jam") */
> +    case 2:
> +        /* round-down (truncate) */
> +        return 0;
> +    case 3:
> +        /* round-to-odd (OR bits into LSB, aka "jam") */
>          return !d & (D1 !=3D 0);
> +    default:
> +        g_assert_not_reached();
>      }
> -    return 0; /* round-down (truncate) */
>  }
>
>  static inline int32_t aadd32(CPURISCVState *env, int vxrm, int32_t a,
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 2a487179f6..32474a21dc 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -194,7 +194,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs=
1, TCGv s2)
>
>      if (rd =3D=3D 0 && rs1 =3D=3D 0) {
>          s1 =3D tcg_temp_new();
> -        tcg_gen_mov_tl(s1, cpu_vl);
> +        tcg_gen_ext_i32_tl(s1, cpu_vl);
>      } else if (rs1 =3D=3D 0) {
>          /* As the mask is at least one bit, RV_VLEN_MAX is >=3D VLMAX */
>          s1 =3D tcg_constant_tl(RV_VLEN_MAX);
> @@ -1213,9 +1213,9 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t =
rs1, uint32_t nf,
>                              MO_LE | MO_64 | atomicity);
>                  }
>                  if (i =3D=3D size - 8) {
> -                    tcg_gen_movi_tl(cpu_vstart, 0);
> +                    tcg_gen_movi_i32(cpu_vstart, 0);
>                  } else {
> -                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_es=
z);
> +                    tcg_gen_addi_i32(cpu_vstart, cpu_vstart, 8 >> log2_e=
sz);
>                  }
>              }
>          } else {
> @@ -1231,9 +1231,9 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t =
rs1, uint32_t nf,
>                              MO_LE | MO_32 | atomicity);
>                  }
>                  if (i =3D=3D size - 4) {
> -                    tcg_gen_movi_tl(cpu_vstart, 0);
> +                    tcg_gen_movi_i32(cpu_vstart, 0);
>                  } else {
> -                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_es=
z);
> +                    tcg_gen_addi_i32(cpu_vstart, cpu_vstart, 4 >> log2_e=
sz);
>                  }
>              }
>          }
> @@ -3459,7 +3459,7 @@ static bool trans_vmv_x_s(DisasContext *s, arg_vmv_=
x_s *a)
>          vec_element_loadi(s, t1, a->rs2, 0, true);
>          tcg_gen_trunc_i64_tl(dest, t1);
>          gen_set_gpr(s, a->rd, dest);
> -        tcg_gen_movi_tl(cpu_vstart, 0);
> +        tcg_gen_movi_i32(cpu_vstart, 0);
>          finalize_rvv_inst(s);
>          return true;
>      }
> @@ -3476,7 +3476,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_=
s_x *a)
>          TCGv s1;
>          TCGLabel *over =3D gen_new_label();
>
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> +        tcg_gen_brcond_i32(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          t1 =3D tcg_temp_new_i64();
>
> @@ -3488,7 +3488,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_=
s_x *a)
>          tcg_gen_ext_tl_i64(t1, s1);
>          vec_element_storei(s, a->rd, 0, t1);
>          gen_set_label(over);
> -        tcg_gen_movi_tl(cpu_vstart, 0);
> +        tcg_gen_movi_i32(cpu_vstart, 0);
>          finalize_rvv_inst(s);
>          return true;
>      }
> @@ -3516,7 +3516,7 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfm=
v_f_s *a)
>          }
>
>          mark_fs_dirty(s);
> -        tcg_gen_movi_tl(cpu_vstart, 0);
> +        tcg_gen_movi_i32(cpu_vstart, 0);
>          finalize_rvv_inst(s);
>          return true;
>      }
> @@ -3536,7 +3536,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfm=
v_s_f *a)
>          TCGLabel *over =3D gen_new_label();
>
>          /* if vstart >=3D vl, skip vector register write back */
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> +        tcg_gen_brcond_i32(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
>          /* NaN-box f[rs1] */
>          t1 =3D tcg_temp_new_i64();
> @@ -3545,7 +3545,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfm=
v_s_f *a)
>          vec_element_storei(s, a->rd, 0, t1);
>
>          gen_set_label(over);
> -        tcg_gen_movi_tl(cpu_vstart, 0);
> +        tcg_gen_movi_i32(cpu_vstart, 0);
>          finalize_rvv_inst(s);
>          return true;
>      }
> @@ -3610,7 +3610,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr =
*a)                  \
>                                                                          =
\
>          fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             =
\
>                                                                          =
\
> -        tcg_gen_movi_tl(cpu_vstart, 0);                                 =
\
> +        tcg_gen_movi_i32(cpu_vstart, 0);                                =
\
>          finalize_rvv_inst(s);                                           =
\
>                                                                          =
\
>          return true;                                                    =
\
> --
> 2.51.0
>
>

