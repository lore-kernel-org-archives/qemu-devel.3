Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC4E7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoqZ-0004oz-E0; Wed, 04 Dec 2024 07:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIoqV-0004oL-L4
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:51:13 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIoqR-0000YL-Dt
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:51:11 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71d537b50beso3210480a34.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733316664; x=1733921464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rcx1pLo0/Zyy0zIp8EdQzBFmGX98vAkWfgl5g90Yogw=;
 b=pdyVel1CZB/PqD64unxWsxMNiGXa96DU3kfHz2+LUio/1mfxJ4VZ4016ozfxBXj41C
 jyxJPMIEqUUCZ+6tE7CNRMos5brL053mFXg4wywuHVWoR/AFopoz4Nl2CEjNBdK9dX+A
 BEFjw3pLbY/v294WZHFeG5yqRDxhqljTuVxm+yZspp2/lCSP7QY1WjtG60ar7ioDA2HV
 0Iaku7HnOyqkSbrdb/fhZ4owrgJDEfh5ejWpJqC/uqU5Uu9BIIzAtNX2FURmoLgZhbct
 g7aDKVFGmdHxg5CQJzjIreuPxB+LXugukY9/tBLfz2INe3+r2vMbZxnyiBTmbqIdBHme
 5DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733316664; x=1733921464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rcx1pLo0/Zyy0zIp8EdQzBFmGX98vAkWfgl5g90Yogw=;
 b=niohTSJIYBSc9mNuohSMUM8lMx7Me6cldNEpdiGl8RZZKrXDsG1hhmla4myZB14LQn
 vutzGLUdSETjHpNIqRZ/NNhyXGSPHUCsv0c2zRmu5DsR/xwUQuDggeiKYssYXeF5bKZg
 jQ1A5zsu1e1QvcVp3MWeC3j6M7dS3XWhjotCXldlQ/TVM169qGKPV+nQiAuPS4TvID2q
 nMBwpO8ny25xud40CWXWZlQvM2zIaKX/gMC2YO02UOk5MOf0D6GZhJT6jMHPwV1yhhm2
 rWVtsog/x75J4apkdi2NVQzbDI3s9c/dkfqq7TziOiRBzVqU8MZYAI62T0m1UTXAGUkf
 adCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ6cNlodrJtRUqB5EbTNuIrqvHrTr8J3ZyZC7FOergqQsLXMxAnD7RAhWZzwr7RxDr0MgdCUi+KaBX@nongnu.org
X-Gm-Message-State: AOJu0YyXnCynkyn43Yhw65gHNYrSDnx0DpysTyE8CXi8FW8spNeEEybU
 mrYCj4nfQxn1OOSgMRY4JrsVQcg2BiEjyt4IHUgbPtlzpejoRcfaNfoxdmU2gdk=
X-Gm-Gg: ASbGncvBq2xvOmvXwStOxd7mCUIUi9Nb7jltUdEOdje4ZEqYJmmOaTCGBK35Nxjag+0
 bKN78C/1FCoQIIgCT1RtdSdISCMJR8Ek8cBVzcrUO3XtuQlcpOpziJlFXMmZQfIWrW5wwyNs8cG
 Ah6+lDVj7yjtfCsmbznIuB11xsZ6xMPy41Blz76KBeH1h0qCvJTF9hZ0Ekdy03FKJoEc/PBKLhh
 zjNZrwPQ6LKrRM08RG8Bu5wreOgdDznHbUSsoMobcJtj2cgKA+1mHhX3SzKO+M=
X-Google-Smtp-Source: AGHT+IH2elXo5Q/uNYmWB1Ti1fM674T5U1z3ZUBBAzt7fAUJqoT3qVQESbvTGuO0pr2NtCbOE/HrEA==
X-Received: by 2002:a05:6830:43a2:b0:71d:421f:5bd with SMTP id
 46e09a7af769-71dad62d728mr7589836a34.11.1733316664583; 
 Wed, 04 Dec 2024 04:51:04 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd0d1417absm591582a12.32.2024.12.04.04.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 04:51:04 -0800 (PST)
Message-ID: <a25a34b4-e3aa-4a24-bc44-ed87b5d6bdd7@ventanamicro.com>
Date: Wed, 4 Dec 2024 09:50:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] target/riscv: Support generic CSR indirect access
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, Kaiwen Xue <kaiwenx@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <20241203-counter_delegation-v4-4-c12a89baed86@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241203-counter_delegation-v4-4-c12a89baed86@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 12/3/24 8:14 PM, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds the indirect access registers required by sscsrind/smcsrind
> and the operations on them. Note that xiselect and xireg are used for
> both AIA and sxcsrind, and the behavior of accessing them depends on
> whether each extension is enabled and the value stored in xiselect.
> 
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h |  28 +++++++++-
>   target/riscv/csr.c      | 144 ++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 166 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 385a2c67c24b..e13c5420a251 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -173,6 +173,13 @@
>   #define CSR_MISELECT        0x350
>   #define CSR_MIREG           0x351
>   
> +/* Machine Indirect Register Alias */
> +#define CSR_MIREG2          0x352
> +#define CSR_MIREG3          0x353
> +#define CSR_MIREG4          0x355
> +#define CSR_MIREG5          0x356
> +#define CSR_MIREG6          0x357
> +
>   /* Machine-Level Interrupts (AIA) */
>   #define CSR_MTOPEI          0x35c
>   #define CSR_MTOPI           0xfb0
> @@ -222,6 +229,13 @@
>   #define CSR_SISELECT        0x150
>   #define CSR_SIREG           0x151
>   
> +/* Supervisor Indirect Register Alias */
> +#define CSR_SIREG2          0x152
> +#define CSR_SIREG3          0x153
> +#define CSR_SIREG4          0x155
> +#define CSR_SIREG5          0x156
> +#define CSR_SIREG6          0x157
> +
>   /* Supervisor-Level Interrupts (AIA) */
>   #define CSR_STOPEI          0x15c
>   #define CSR_STOPI           0xdb0
> @@ -288,6 +302,13 @@
>   #define CSR_VSISELECT       0x250
>   #define CSR_VSIREG          0x251
>   
> +/* Virtual Supervisor Indirect Alias */
> +#define CSR_VSIREG2         0x252
> +#define CSR_VSIREG3         0x253
> +#define CSR_VSIREG4         0x255
> +#define CSR_VSIREG5         0x256
> +#define CSR_VSIREG6         0x257
> +
>   /* VS-Level Interrupts (H-extension with AIA) */
>   #define CSR_VSTOPEI         0x25c
>   #define CSR_VSTOPI          0xeb0
> @@ -863,10 +884,13 @@ typedef enum RISCVException {
>   #define ISELECT_IMSIC_EIE63                0xff
>   #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
>   #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
> -#define ISELECT_MASK                       0x1ff
> +#define ISELECT_MASK_AIA                   0x1ff
> +
> +/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
> +#define ISELECT_MASK_SXCSRIND              0xfff
>   
>   /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
> -#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
> +#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
>   
>   /* IMSIC bits (AIA) */
>   #define IMSIC_TOPEI_IID_SHIFT              16
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index c91a26a52ef6..424e9dbbd4ff 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -306,6 +306,15 @@ static RISCVException aia_any32(CPURISCVState *env, int csrno)
>       return any32(env, csrno);
>   }
>   
> +static RISCVException csrind_any(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smcsrind) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
> @@ -389,6 +398,15 @@ static bool csrind_or_aia_extensions_present(CPURISCVState *env)
>       return csrind_extensions_present(env) || aia_extensions_present(env);
>   }
>   
> +static RISCVException csrind_smode(CPURISCVState *env, int csrno)
> +{
> +    if (!csrind_extensions_present(env)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return smode(env, csrno);
> +}
> +
>   static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csrno)
>   {
>       if (!csrind_or_aia_extensions_present(env)) {
> @@ -417,6 +435,15 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
>   
>   }
>   
> +static RISCVException csrind_hmode(CPURISCVState *env, int csrno)
> +{
> +    if (!csrind_extensions_present(env)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return hmode(env, csrno);
> +}
> +
>   static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csrno)
>   {
>       if (!csrind_or_aia_extensions_present(env)) {
> @@ -2065,7 +2092,12 @@ static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
>       case CSR_SISELECT:
>           return CSR_VSISELECT;
>       case CSR_SIREG:
> -        return CSR_VSIREG;
> +    case CSR_SIREG2:
> +    case CSR_SIREG3:
> +    case CSR_SIREG4:
> +    case CSR_SIREG5:
> +    case CSR_SIREG6:
> +        return CSR_VSIREG + (csrno - CSR_SIREG);
>       default:
>           return csrno;
>       };
> @@ -2105,7 +2137,12 @@ static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
>           *val = *iselect;
>       }
>   
> -    wr_mask &= ISELECT_MASK;
> +    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind) {
> +        wr_mask &= ISELECT_MASK_SXCSRIND;
> +    } else {
> +        wr_mask &= ISELECT_MASK_AIA;
> +    }
> +
>       if (wr_mask) {
>           *iselect = (*iselect & ~wr_mask) | (new_val & wr_mask);
>       }
> @@ -2244,6 +2281,56 @@ done:
>       return RISCV_EXCP_NONE;
>   }
>   
> +/*
> + * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
> + *
> + * Perform indirect access to xireg and xireg2-xireg6.
> + * This is a generic interface for all xireg CSRs. Apart from AIA, all other
> + * extension using csrind should be implemented here.
> + */
> +static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
> +                              target_ulong isel, target_ulong *val,
> +                              target_ulong new_val, target_ulong wr_mask)
> +{
> +    return -EINVAL;
> +}
> +
> +static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
> +                      target_ulong new_val, target_ulong wr_mask)
> +{
> +    bool virt = false;
> +    int ret = -EINVAL;
> +    target_ulong isel;
> +
> +    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Translate CSR number for VS-mode */
> +    csrno = csrind_xlate_vs_csrno(env, csrno);
> +
> +    if (CSR_MIREG <= csrno && csrno <= CSR_MIREG6 &&
> +        csrno != CSR_MIREG4 - 1) {
> +        isel = env->miselect;
> +    } else if (CSR_SIREG <= csrno && csrno <= CSR_SIREG6 &&
> +               csrno != CSR_SIREG4 - 1) {
> +        isel = env->siselect;
> +    } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
> +               csrno != CSR_VSIREG4 - 1) {
> +        isel = env->vsiselect;
> +        virt = true;
> +    } else {
> +        goto done;
> +    }
> +
> +    return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
> +
> +done:
> +    return (env->virt_enabled && virt) ?
> +            RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
> +}
> +
>   static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
>                                   target_ulong *val, target_ulong new_val,
>                                   target_ulong wr_mask)
> @@ -2276,8 +2363,21 @@ static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
>            goto done;
>       };
>   
> +    /*
> +     * Use the xiselect range to determine actual op on xireg.
> +     *
> +     * Since we only checked the existence of AIA or Indirect Access in the
> +     * predicate, we should check the existence of the exact extension when
> +     * we get to a specific range and return illegal instruction exception even
> +     * in VS-mode.
> +     */
>       if (xiselect_aia_range(isel)) {
>           return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
> +    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
> +               riscv_cpu_cfg(env)->ext_sscsrind) {
> +        return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
>       }
>   
>   done:
> @@ -2735,7 +2835,7 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
>           wr_mask |= SMSTATEEN0_P1P13;
>       }
>   
> -    if (riscv_cpu_cfg(env)->ext_smaia) {
> +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
>           wr_mask |= SMSTATEEN0_SVSLCT;
>       }
>   
> @@ -2828,7 +2928,7 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
>   
> -    if (riscv_cpu_cfg(env)->ext_ssaia) {
> +    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
>           wr_mask |= SMSTATEEN0_SVSLCT;
>       }
>   
> @@ -5261,6 +5361,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MIREG]    = { "mireg",    csrind_or_aia_any,   NULL, NULL,
>                          rmw_xireg                                       },
>   
> +    /* Machine Indirect Register Alias */
> +    [CSR_MIREG2]   = { "mireg2", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG3]   = { "mireg3", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG4]   = { "mireg4", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG5]   = { "mireg5", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG6]   = { "mireg6", csrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +
>       /* Machine-Level Interrupts (AIA) */
>       [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
>       [CSR_MTOPI]    = { "mtopi",    aia_any, read_mtopi },
> @@ -5382,6 +5494,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_SIREG]      = { "sireg",      csrind_or_aia_smode, NULL, NULL,
>                            rmw_xireg                                          },
>   
> +    /* Supervisor Indirect Register Alias */
> +    [CSR_SIREG2]      = { "sireg2", csrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG3]      = { "sireg3", csrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG4]      = { "sireg4", csrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG5]      = { "sireg5", csrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG6]      = { "sireg6", csrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +
>       /* Supervisor-Level Interrupts (AIA) */
>       [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
>       [CSR_STOPI]      = { "stopi",      aia_smode, read_stopi },
> @@ -5464,6 +5588,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_VSIREG]      = { "vsireg",      csrind_or_aia_hmode, NULL, NULL,
>                             rmw_xireg                                         },
>   
> +    /* Virtual Supervisor Indirect Alias */
> +    [CSR_VSIREG2]     = { "vsireg2", csrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG3]     = { "vsireg3", csrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG4]     = { "vsireg4", csrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG5]     = { "vsireg5", csrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG6]     = { "vsireg6", csrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +
>       /* VS-Level Interrupts (H-extension with AIA) */
>       [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },
>       [CSR_VSTOPI]      = { "vstopi",      aia_hmode, read_vstopi },
> 


