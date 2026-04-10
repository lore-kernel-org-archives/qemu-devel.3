Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ED1F36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0HT-0000F4-ET; Thu, 09 Apr 2026 21:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0HS-0000Ew-99
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:03:30 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0HQ-000160-7v
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:03:30 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6708acbfb85so264109a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775783006; cv=none;
 d=google.com; s=arc-20240605;
 b=DtMYBbpuLMRbFq5+s2X4daApWR1U2cSMyN5aX84kexpjtvJYa3DdBw8AO7XsmpY4Mo
 aDrbrI2zMbSXGzBTeAyr98iPtAzVYMZ3ngyjVuDcsgjwCx4TJOWtAIPXrJ9KGQEPslnT
 v7c1bg8l84bQURiYXzi1k++Tjxa4Wz9Rn3iJG+g/ieVUn5zvpa/zUPbJQYjW/7o/jVoq
 avCrDXf4hfg71U8X15nl5WTnNAW0JOSvQ7FDT5nqkJbpb7ObuPOBJ89XfX43C4WJd3Ye
 Nc6eAs29xQdQ4FwHh6NwpOIRsVOPr8ZnQLNfX3GaYQRk06MfxRCChnBEAosinlK45h0p
 KtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hg5y4Rd1dRcXwXlqxjWgyzDtjjjMqJHUInJRnIharY4=;
 fh=cWfiSq/oFyTN/DKvcJSgQUgJ4u5YSKmpf6by/WUOfgI=;
 b=X0yyM7LOzokxHaeDKVdokgs57jzerGP38mL6TSKSIX3C0pDVbPgl52JvLlk2cIQVax
 2U2M6D6aToNk/UBqXsa6T42ggiGNZmk4Vl1b8Tb9psuQZmEvKpTclOAXni9vTcmTEUZx
 HgeHN9Hn6lmR4tkSRJ+BX6gyf9KIwBO0ONVJq4s/kbD42AFNzBYVIK+HgqREmRhChah2
 HicOdniCrHvdoD1RoTQ7lbwymvz+SWgeaY0hY8z/AtSjjoek3zQfZtNSWkVaP9g0Ow0J
 LP9x4uY66J8IfvV9VAJN5dXTQQWo82NnMiUYUEy3DQ0yMLRv3rADoMGW4vgZAvCCRsFp
 cvhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775783006; x=1776387806; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hg5y4Rd1dRcXwXlqxjWgyzDtjjjMqJHUInJRnIharY4=;
 b=Zii6M/FcgsRcmoCnFUPNzuTlMMUBldn+YEZ4i42o3E6yJUa1kxL+Nzafc50SG8qizJ
 PRthclxztAWsh9yHDwhY5i3MYUJq8iXlWGs6sxKWQVd41wmm1tcsphBxoINiZ/L++1O0
 TmDWNhbKLJUcs9SYtJ/FjsV8/fw5n/MsW8WFbbVe16OQKG8LUzmGke6m43biza2CZVQ7
 x1nQK0GAeTwjNBA9gk3nw7fAgciJEDv0X7yCwd8OEsEzepqQTpQ12y7agZN2kMZmYRWp
 nSiS1Va/CoNLYRRS+K/dwFD+t/ekaTwxwm6enni8k9Gw2xd7ziOLV50zB/3jaklU4Ydk
 sxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775783006; x=1776387806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hg5y4Rd1dRcXwXlqxjWgyzDtjjjMqJHUInJRnIharY4=;
 b=E4qeK/M0ks4hrvwT0ZoPHc4HhGctugtX6wSFXERyR46am1usax7s0peSs9PeuwPrpg
 41ACXBZLP9TGLQKaKZVxID6NRc2OTLEfDeJImK5f7RMx18fIHnTE2/N8HrYrb1l7r7qZ
 3vqYVlFBCAQe10OOrnKuT9v09Ewf78dDYn6/k3oyjF/21gjBS8vKLKx5btVYHZvAJCIQ
 YvBM/8CnfowR37Zg23umjouL6c7WEWAQYl0Q37XwViP5k8f8edSmiNbHGayiBhysK6mo
 n6vBxtEjpQBraiXCN5cXGWn2J+wQzjs3DltIfWOdd3QSrDm7jSCfAavJIiuDiL2a34Mr
 T7fw==
X-Gm-Message-State: AOJu0YyEidqrabTUcvGd1u/lQ3E2keB/+YKJNEe5DYml2xdfF6NoWgys
 HRs2APqIHqBrJsLBkA+dJdENQgT2vp+ZgO1cI/w8ez5FlKPpqLq9LONbyBhepqftc+n1eNmBvjQ
 RdErtAwkYFvTu64X54VFw96/HO2bcfJU=
X-Gm-Gg: AeBDietfaBEeXD4XfBIxZzZZbB0ZoMR+O2m4k8z+Ivs5cDuB6+AdLDInDpceqkXBWTi
 4LIdkmCe8hBOUimXVnO9hHhj2l/Zea9vmTR7sTQhu8z0MbGKqhH0pBLDRzzSWrO1kMdc4SLAofc
 kHV/RrkoycVe6HIlsmuYTQZ/kXbB8KeOynZ5lmlbgHwNagdDOPzW692HeKF5NxPZFvbvhVWtgF7
 F9wtKqhbcVi44E3ONGy/CIbWgV2g/lRObufcRqC53ZBR+Q+BKiMSEV+wLsq3By1sQDQGgojNBHO
 Xvy2r1N5A3K6SpVIuRKi1B3yzLZkgBD8+gB4cA==
X-Received: by 2002:a17:906:eec7:b0:b98:528b:844a with SMTP id
 a640c23a62f3a-b9d72ac40e6mr68016266b.51.1775783005971; Thu, 09 Apr 2026
 18:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-2-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:02:58 +1000
X-Gm-Features: AQROBzDXDBGUyTo4BCdsqBSJGHskmPShpLN3I8WLwzfjjs4ObjTM2Us40bQjpkY
Message-ID: <CAKmqyKNK7xf50rMVcagfdeem+abRF8NG1JVRC0f9Vho8t8rPcA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] target/riscv: Add basic definitions and CSRs for
 SMMPT
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, 
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Thu, Apr 9, 2026 at 12:07=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> This patch lays the groundwork for the SMMPT (Supervisor Domains Access
> Protection) extension by introducing its fundamental components.
>
> It adds:
> - New CPU configuration flags, `ext_smmpt` and `ext_smsdid`, to enable
>   the extension.
> - Bit-field definitions for the `mmpt` CSR in `cpu_bits.h`.
> - The `mmpt` and `msdcfg` CSR numbers and their read/write handlers in
>   `csr.c`.
> - New fields in `CPUArchState` to store the state of these new CSRs.
> - A new translation failure reason `TRANSLATE_MPT_FAIL`.
>
> This provides the necessary infrastructure for the core MPT logic and
> MMU integration that will follow.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h                |  9 ++-
>  target/riscv/cpu_bits.h           | 27 +++++++++
>  target/riscv/cpu_cfg_fields.h.inc |  2 +
>  target/riscv/csr.c                | 95 +++++++++++++++++++++++++++++++
>  target/riscv/riscv_smmpt.h        | 21 +++++++
>  5 files changed, 153 insertions(+), 1 deletion(-)
>  create mode 100644 target/riscv/riscv_smmpt.h
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 35d1f6362c..f8265c2cc2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -130,7 +130,8 @@ enum {
>      TRANSLATE_SUCCESS,
>      TRANSLATE_FAIL,
>      TRANSLATE_PMP_FAIL,
> -    TRANSLATE_G_STAGE_FAIL
> +    TRANSLATE_G_STAGE_FAIL,
> +    TRANSLATE_MPT_FAIL
>  };
>
>  /* Extension context status */
> @@ -181,6 +182,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_impli=
ed_rules[];
>  #if !defined(CONFIG_USER_ONLY)
>  #include "pmp.h"
>  #include "debug.h"
> +#include "riscv_smmpt.h"
>  #endif
>
>  #define RV_VLEN_MAX 1024
> @@ -481,6 +483,11 @@ struct CPUArchState {
>      uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t sstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t henvcfg;
> +    /* Smsdid */
> +    uint32_t mptmode;
> +    uint32_t sdid;
> +    uint64_t mptppn;
> +    uint32_t msdcfg;
>  #endif
>
>      /* Fields from here on are preserved across CPU reset. */
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..c6a34863d1 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -1164,4 +1164,31 @@ typedef enum CTRType {
>  #define MCONTEXT64                         0x0000000000001FFFULL
>  #define MCONTEXT32_HCONTEXT                0x0000007F
>  #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
> +
> +/* Smsdid */
> +#define CSR_MMPT        0xbc0
> +#define CSR_MSDCFG      0xbd1
> +
> +#define MMPT_MODE_MASK_32   0xC0000000
> +#define MMPT_SDID_MASK_32   0x3F000000
> +#define MMPT_PPN_MASK_32    0x003FFFFF
> +
> +#define MMPT_MODE_SHIFT_32  30
> +#define MMPT_SDID_SHIFT_32  24
> +
> +#define MMPT_MODE_MASK_64   0xF000000000000000ULL
> +#define MMPT_SDID_MASK_64   0x0FC0000000000000ULL
> +#define MMPT_PPN_MASK_64    0x000FFFFFFFFFFFFFULL
> +
> +#define MPTE_L3_VALID       0x0000100000000000ULL
> +#define MPTE_L3_RESERVED    0xFFFFE00000000000ULL
> +
> +#define MPTE_L2_RESERVED_64    0xFFFF800000000000ULL
> +#define MPTE_L2_RESERVED_32    0xFE000000
> +
> +#define MPTE_L1_RESERVED_64    0xFFFFFFFF00000000ULL
> +#define MPTE_L1_RESERVED_32    0xFFFF0000
> +
> +#define MMPT_MODE_SHIFT_64  60
> +#define MMPT_SDID_SHIFT_64  54
>  #endif
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index cd1a5ec56b..80644948dd 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -63,6 +63,8 @@ BOOL_FIELD(ext_smpmpmt)
>  BOOL_FIELD(ext_svrsw60t59b)
>  BOOL_FIELD(ext_svvptc)
>  BOOL_FIELD(ext_svukte)
> +BOOL_FIELD(ext_smmpt)
> +BOOL_FIELD(ext_smsdid)
>  BOOL_FIELD(ext_zdinx)
>  BOOL_FIELD(ext_zaamo)
>  BOOL_FIELD(ext_zacas)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a75281539b..081d2fc2c3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -793,6 +793,15 @@ static RISCVException rnmi(CPURISCVState *env, int c=
srno)
>
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> +
> +static RISCVException smsdid(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_smsdid) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
>  #endif
>
>  static RISCVException seed(CPURISCVState *env, int csrno)
> @@ -5446,6 +5455,89 @@ static RISCVException write_mnstatus(CPURISCVState=
 *env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> +static RISCVException read_mmpt(CPURISCVState *env, int csrno,
> +                                target_ulong *val)
> +{
> +    if (riscv_cpu_xlen(env) =3D=3D 32) {
> +        uint32_t value =3D 0;
> +        value |=3D env->mptmode << MMPT_MODE_SHIFT_32;
> +        value |=3D (env->sdid << MMPT_SDID_SHIFT_32) & MMPT_SDID_MASK_32=
;
> +        value |=3D env->mptppn & MMPT_PPN_MASK_32;
> +        *val =3D value;
> +    } else if (riscv_cpu_xlen(env) =3D=3D 64) {
> +        uint64_t value_64 =3D 0;
> +        uint32_t mode_value =3D env->mptmode;
> +        /* mpt_mode_t convert to mmpt.mode value */
> +        if (mode_value) {
> +            mode_value -=3D SMMPT43 - SMMPT34;
> +        }
> +        value_64 |=3D (uint64_t)mode_value << MMPT_MODE_SHIFT_64;
> +        value_64 |=3D ((uint64_t)env->sdid << MMPT_SDID_SHIFT_64)
> +                    & MMPT_SDID_MASK_64;
> +        value_64 |=3D (uint64_t)env->mptppn & MMPT_PPN_MASK_64;
> +        *val =3D value_64;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mmpt(CPURISCVState *env, int csrno,
> +                                 target_ulong val, uintptr_t ra)
> +{
> +    uint32_t mode_value =3D 0;
> +    if (!riscv_cpu_cfg(env)->ext_smmpt) {
> +        goto set_remaining_fields_zero;
> +    }
> +
> +    if (riscv_cpu_xlen(env) =3D=3D 32) {
> +        mode_value =3D (val & MMPT_MODE_MASK_32) >> MMPT_MODE_SHIFT_32;
> +        /* If mode is bare, the remaining fields in mmpt must be zero */
> +        if (mode_value =3D=3D SMMPTBARE) {
> +            goto set_remaining_fields_zero;
> +        } else if (mode_value <=3D SMMPT34) {
> +            /* Only write the legal value */
> +            env->mptmode =3D mode_value;
> +        }
> +        env->sdid =3D (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
> +        env->mptppn =3D val & MMPT_PPN_MASK_32;
> +    } else if (riscv_cpu_xlen(env) =3D=3D 64) {
> +        mode_value =3D (val & MMPT_MODE_MASK_64) >> MMPT_MODE_SHIFT_64;
> +        if (mode_value =3D=3D SMMPTBARE) {
> +            goto set_remaining_fields_zero;
> +        } else if (mode_value < SMMPTMAX) {
> +            /* convert to mpt_mode_t */
> +            mode_value +=3D SMMPT43 - SMMPT34;
> +            env->mptmode =3D mode_value;
> +        }
> +        env->sdid =3D (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
> +        env->mptppn =3D val & MMPT_PPN_MASK_64;
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +
> +set_remaining_fields_zero:
> +    env->sdid =3D 0;
> +    env->mptmode =3D SMMPTBARE;
> +    env->mptppn =3D 0;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_msdcfg(CPURISCVState *env, int csrno,
> +                                   target_ulong *val)
> +{
> +    *val =3D env->msdcfg;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_msdcfg(CPURISCVState *env, int csrno,
> +                                    target_ulong val, uintptr_t ra)
> +{
> +    env->msdcfg =3D val;
> +    return RISCV_EXCP_NONE;
> +}
> +
>  #endif
>
>  /* Crypto Extension */
> @@ -6660,6 +6752,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>                               write_mhpmcounterh                         =
},
>      [CSR_SCOUNTOVF]      =3D { "scountovf", sscofpmf,  read_scountovf,
>                               .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> +    /* Supervisor Domain Identifier and Protection Registers */
> +    [CSR_MMPT] =3D    { "mmpt",   smsdid,  read_mmpt,   write_mmpt   },
> +    [CSR_MSDCFG] =3D  { "msdcfg", smsdid,  read_msdcfg, write_msdcfg },
>
>  #endif /* !CONFIG_USER_ONLY */
>  };
> diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
> new file mode 100644
> index 0000000000..74dcccf4be
> --- /dev/null
> +++ b/target/riscv/riscv_smmpt.h
> @@ -0,0 +1,21 @@
> +/*
> + * QEMU RISC-V Smmpt (Memory Protection Table)
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_SMMPT_H
> +#define RISCV_SMMPT_H
> +
> +typedef enum {
> +    SMMPTBARE =3D 0,
> +    SMMPT34   =3D 1,
> +    SMMPT43   =3D 2,
> +    SMMPT52   =3D 3,
> +    SMMPT64   =3D 4,
> +    SMMPTMAX
> +} mpt_mode_t;
> +
> +#endif
> --
> 2.43.0
>

