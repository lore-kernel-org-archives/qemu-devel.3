Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0675BC48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 02:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWowH-00043b-6N; Sun, 04 Feb 2024 21:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWowF-00043A-Dm; Sun, 04 Feb 2024 21:42:27 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWowC-0003zn-4h; Sun, 04 Feb 2024 21:42:26 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d317aafbd1so1746644241.2; 
 Sun, 04 Feb 2024 18:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707100942; x=1707705742; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BHHN+7dyP2Mgw1yv1h+iqopUE85wZLWm5h4xUS4MuM=;
 b=fy5aBsR6UmeblQ0PMt7nsrJY9dqSpDtEMGhnJp7nO/gUcVYjjCflHxCHpGRwrM4B1m
 vCktefEpM2ergG2j5hy84JtVwmKu3QzzmFIdBQgoKPCTHIu6EPP3iz0GoBCQARcrzlNI
 L5SOczWW05cIGKoIhSqscQwc4+lSAYxO4847Ilk7nr71Vt2vtdRLGcU8Xzum0qhQbPyH
 ykbWa3VNx47d63b28bo9bZ9p0JJSYeGQuU+mlvdynxjSNZ/Q1RoBM9Rx0Ld044v34mzm
 9cXGcwbZ+Zq8SpmJj/lF56U8Peh1YKf+Ei34RGzlp6I/yFMLIiQfiNU2LfA84aWPl2sg
 ofVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707100942; x=1707705742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BHHN+7dyP2Mgw1yv1h+iqopUE85wZLWm5h4xUS4MuM=;
 b=soao/5LGvPhCEQi4w5e4ttJEdv+9OuwJM+aI8tWwgsm6JfNMLyumv2vCkKQtpYeXFB
 ab6nmMra7FmUdA49HdCu7/rgVq9VGOALhYApuMGq0/xQB+XsBnEQXIZSE0YYxsjLrY/W
 7ohsH6R4PRJYLdLEDWhwTVc3jP4bRvDKRD1nwQsi8psfREqMdB1AIGHQQyzWnNO7pf5W
 y2HhwnjebHfmAK/nQig/0JO/tNv1RLhN0eoQxwwwuuDqkY4ci1L1v8MBWXGKDA2Gl6Y5
 8bJ6txyqrJDFXph+0CZ25Z1aKv5DBy1BZ9Xyz8DW7V1wjzbOwEx8RaWs4LYL5guxtUFf
 F2xQ==
X-Gm-Message-State: AOJu0YxfQFyJSYL3mnOi/EDgAFXnTXzs7OvQkr9d3qPtXnq5d02NVN4d
 NVusxlrl5E2iPBRCTBTztEiYsQvO1i0BR9rsMHJlx8LzVQ0AmPlsk1SCMIhjiiPl0jgLOD5MI1r
 RWFbFZlBl1Aezq/2SLsjDG28HeyY=
X-Google-Smtp-Source: AGHT+IGzIkO6J8zNY7ZQ25uQjhpZydUjPwcZs9prrroeWRfFZiEAMj20YtgWLgfaa5oBC+TXJYVM7qutVv27nHcmOXU=
X-Received: by 2002:a67:ef98:0:b0:46d:2fa1:29d9 with SMTP id
 r24-20020a67ef98000000b0046d2fa129d9mr758365vsp.6.1707100942369; Sun, 04 Feb
 2024 18:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20240204054228.651-1-zhiwei_liu@linux.alibaba.com>
 <20240204054228.651-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240204054228.651-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 12:41:56 +1000
Message-ID: <CAKmqyKNGMjLg+JjJZAp+EsmfaWAyT7XiHZzBXZxeghS0hv6REg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: Support xtheadmaee for thead-c906
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 qemu-riscv@nongnu.org, christoph.muellner@vrull.eu, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Feb 4, 2024 at 3:44=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> This patch set fix the regression on kernel pointed by Bj=C3=B6rn T=C3=B6=
pel in
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg1018232.html.
>
> thead-c906 uses some flags in pte [60-63] bits. It has history reasons th=
at
> SVPBMT didn't exist when thead-c906 came to wotrld. We named this feature=
 as
> xtheadmaee[1]. this feature is controlled by an custom CSR named mxstatus=
,
> whose maee field encodes whether enable the pte [60-63] bits.
>
> [1]:https://github.com/T-head-Semi/thead-extension-spec/blob/master/xthea=
dmaee.adoc
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
> v1->v2:
> 1) Remove mxstatus user mode access
> 2) Add reference documentation to the commit log
> ---
>  target/riscv/cpu.c         |  6 ++++
>  target/riscv/cpu.h         |  9 ++++++
>  target/riscv/cpu_bits.h    |  6 ++++
>  target/riscv/cpu_cfg.h     |  4 ++-
>  target/riscv/cpu_helper.c  | 25 ++++++++-------
>  target/riscv/meson.build   |  1 +
>  target/riscv/tcg/tcg-cpu.c |  7 +++-
>  target/riscv/xthead_csr.c  | 65 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 110 insertions(+), 13 deletions(-)
>  create mode 100644 target/riscv/xthead_csr.c
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2dcbc9ff32..bfdbb0539a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -171,6 +171,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(xtheadmemidx, PRIV_VERSION_1_11_0, ext_xtheadmemi=
dx),
>      ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmem=
pair),
>      ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
> +    ISA_EXT_DATA_ENTRY(xtheadmaee, PRIV_VERSION_1_11_0, ext_xtheadmaee),
>      ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentan=
aCondOps),
>
>      DEFINE_PROP_END_OF_LIST(),
> @@ -506,6 +507,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>
>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>  #ifndef CONFIG_USER_ONLY
> +    cpu->cfg.ext_xtheadmaee =3D true;
>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>  #endif
>
> @@ -949,6 +951,9 @@ static void riscv_cpu_reset_hold(Object *obj)
>      }
>
>      pmp_unlock_entries(env);
> +    if (riscv_cpu_cfg(env)->ext_xtheadmaee) {
> +        env->th_mxstatus |=3D TH_MXSTATUS_MAEE;
> +    }
>  #endif
>      env->xl =3D riscv_cpu_mxl(env);
>      riscv_cpu_update_mask(env);
> @@ -1439,6 +1444,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>      MULTI_EXT_CFG_BOOL("xtheadmemidx", ext_xtheadmemidx, false),
>      MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
>      MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
> +    MULTI_EXT_CFG_BOOL("xtheadmaee", ext_xtheadmaee, false),
>      MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
>
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5f3955c38d..1bacf40355 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -412,6 +412,14 @@ struct CPUArchState {
>      target_ulong cur_pmmask;
>      target_ulong cur_pmbase;
>
> +    union {
> +        /* Custom CSR for Xuantie CPU */
> +        struct {
> +#ifndef CONFIG_USER_ONLY
> +            target_ulong th_mxstatus;
> +#endif
> +        };
> +    };
>      /* Fields from here on are preserved across CPU reset. */
>      QEMUTimer *stimer; /* Internal timer for S-mode interrupt */
>      QEMUTimer *vstimer; /* Internal timer for VS-mode interrupt */
> @@ -799,6 +807,7 @@ void riscv_add_satp_mode_properties(Object *obj);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>
>  /* CSR function table */
> +extern riscv_csr_operations th_csr_ops[CSR_TABLE_SIZE];
>  extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
>
>  extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e116f6c252..67ebb1cefe 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -897,4 +897,10 @@ typedef enum RISCVException {
>  /* JVT CSR bits */
>  #define JVT_MODE                           0x3F
>  #define JVT_BASE                           (~0x3F)
> +
> +/* Xuantie custom CSRs */
> +#define CSR_TH_MXSTATUS 0x7c0
> +
> +#define TH_MXSTATUS_MAEE_SHIFT  21
> +#define TH_MXSTATUS_MAEE        (0x1 << TH_MXSTATUS_MAEE_SHIFT)
>  #endif
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 780ae6ef17..3735c69fd6 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -136,6 +136,7 @@ struct RISCVCPUConfig {
>      bool ext_xtheadmemidx;
>      bool ext_xtheadmempair;
>      bool ext_xtheadsync;
> +    bool ext_xtheadmaee;
>      bool ext_XVentanaCondOps;
>
>      uint32_t pmu_mask;
> @@ -176,7 +177,8 @@ static inline bool has_xthead_p(const RISCVCPUConfig =
*cfg)
>             cfg->ext_xtheadcondmov ||
>             cfg->ext_xtheadfmemidx || cfg->ext_xtheadfmv ||
>             cfg->ext_xtheadmac || cfg->ext_xtheadmemidx ||
> -           cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
> +           cfg->ext_xtheadmempair || cfg->ext_xtheadsync ||
> +           cfg->ext_xtheadmaee;
>  }
>
>  #define MATERIALISE_EXT_PREDICATE(ext) \
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index c7cc7eb423..5c1f380276 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -812,6 +812,7 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>      int napot_bits =3D 0;
>      target_ulong napot_mask;
>
> +    bool skip_pte_check =3D env->th_mxstatus & TH_MXSTATUS_MAEE;
>      /*
>       * Check if we should use the background registers for the two
>       * stage translation. We don't need to check if we actually need
> @@ -974,18 +975,19 @@ restart:
>          if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
>              ppn =3D pte >> PTE_PPN_SHIFT;
>          } else {
> -            if (pte & PTE_RESERVED) {
> -                return TRANSLATE_FAIL;
> -            }
> +            if (!skip_pte_check) {
> +                if (pte & PTE_RESERVED) {
> +                    return TRANSLATE_FAIL;
> +                }
>
> -            if (!pbmte && (pte & PTE_PBMT)) {
> -                return TRANSLATE_FAIL;
> -            }
> +                if (!pbmte && (pte & PTE_PBMT)) {
> +                    return TRANSLATE_FAIL;
> +                }
>
> -            if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> -                return TRANSLATE_FAIL;
> +                if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> +                    return TRANSLATE_FAIL;
> +                }
>              }
> -
>              ppn =3D (pte & (target_ulong)PTE_PPN_MASK) >> PTE_PPN_SHIFT;

Unfortunately we won't be able to take this upstream. This is core
QEMU RISC-V code that is now being changed against the spec. I think
adding the CSR is fine, but we can't take this core change.

A fix that works for everyone should be supporting the th_mxstatus
CSR, but don't support setting the TH_MXSTATUS_MAEE bit. That way
guests can detect that the bit isn't set and not use the reserved bits
in the PTE. From my understanding the extra PTE bits are related to
cache control in the hardware, which we don't need here

Alistair

>          }
>
> @@ -998,7 +1000,8 @@ restart:
>          }
>
>          /* Inner PTE, continue walking */
> -        if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
> +        if ((pte & (PTE_D | PTE_A | PTE_U)) ||
> +            (!skip_pte_check && (pte & PTE_ATTR))) {
>              return TRANSLATE_FAIL;
>          }
>          base =3D ppn << PGSHIFT;
> @@ -1012,7 +1015,7 @@ restart:
>          /* Misaligned PPN */
>          return TRANSLATE_FAIL;
>      }
> -    if (!pbmte && (pte & PTE_PBMT)) {
> +    if (!skip_pte_check && !pbmte && (pte & PTE_PBMT)) {
>          /* Reserved without Svpbmt. */
>          return TRANSLATE_FAIL;
>      }
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index a5e0734e7f..d7f675881d 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -12,6 +12,7 @@ riscv_ss.add(files(
>    'cpu.c',
>    'cpu_helper.c',
>    'csr.c',
> +  'xthead_csr.c',
>    'fpu_helper.c',
>    'gdbstub.c',
>    'op_helper.c',
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 559bf373f3..4b1184c8ab 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -763,7 +763,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu,=
 Error **errp)
>          cpu->cfg.pmu_mask =3D 0;
>          cpu->pmu_avail_ctrs =3D 0;
>      }
> -
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
> @@ -871,12 +870,18 @@ static void riscv_cpu_validate_profiles(RISCVCPU *c=
pu)
>      }
>  }
>
> +static inline bool th_csr_p(const RISCVCPUConfig *cfg)
> +{
> +    return cfg->ext_xtheadmaee;
> +}
> +
>  void riscv_tcg_cpu_register_vendor_csr(RISCVCPU *cpu)
>  {
>      static const struct {
>          bool (*guard_func)(const RISCVCPUConfig *);
>          riscv_csr_operations *csr_ops;
>      } vendors[] =3D {
> +        { th_csr_p, th_csr_ops },
>      };
>      for (int i =3D 0; i < ARRAY_SIZE(vendors); ++i) {
>          if (!vendors[i].guard_func(&cpu->cfg)) {
> diff --git a/target/riscv/xthead_csr.c b/target/riscv/xthead_csr.c
> new file mode 100644
> index 0000000000..9f88fa50db
> --- /dev/null
> +++ b/target/riscv/xthead_csr.c
> @@ -0,0 +1,65 @@
> +/*
> + * Xuantie implementation for RISC-V Control and Status Registers.
> + *
> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
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
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "cpu.h"
> +#include "tcg/tcg-cpu.h"
> +#include "exec/exec-all.h"
> +#include "exec/tb-flush.h"
> +#include "qapi/error.h"
> +
> +#if !defined(CONFIG_USER_ONLY)
> +static RISCVException th_maee_check(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_xtheadmaee) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException
> +read_th_mxstatus(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val =3D env->th_mxstatus;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException
> +write_th_mxstatus(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    uint64_t mxstatus =3D env->th_mxstatus;
> +    uint64_t mask =3D TH_MXSTATUS_MAEE;
> +
> +    if ((val ^ mxstatus) & TH_MXSTATUS_MAEE) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    mxstatus =3D (mxstatus & ~mask) | (val & mask);
> +    env->th_mxstatus =3D mxstatus;
> +    return RISCV_EXCP_NONE;
> +}
> +#endif
> +
> +riscv_csr_operations th_csr_ops[CSR_TABLE_SIZE] =3D {
> +#if !defined(CONFIG_USER_ONLY)
> +    [CSR_TH_MXSTATUS]     =3D { "th_mxstatus", th_maee_check, read_th_mx=
status,
> +                                                            write_th_mxs=
tatus},
> +#endif /* !CONFIG_USER_ONLY */
> +};
> --
> 2.25.1
>
>

