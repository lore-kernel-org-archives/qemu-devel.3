Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8EAE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIor2-0004rT-2Y; Wed, 04 Dec 2024 07:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIor0-0004rA-9A
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:51:42 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIoqx-00013i-TT
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:51:41 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2155157c31fso6782285ad.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733316698; x=1733921498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EDVgM7YswkzMCupvuHUZvSx9m09yCbEdkJpSYkwV1Ao=;
 b=HBAFl9SmNvYUBaYXbAW5Yy77ubhTd8+2zIsSltXhlZLCHgz09ZH5Jvc2KDfUXd0z3B
 /ncLEOvIcvvpkacZjW+rccanzyW9AXRpWtbDgDHnXFluM/C7bakmswyPcJl2L3HjyMJV
 pMG264nfSxQVSZMBDXNN0TIb40kKZv0E+bt+PI1CW0rDY2omMhnHroH57OWPLzw6KY9f
 mgSIFk07mmdHNEVrQ26vXCV7UboPZ4U6CzfBh3Jo37Ssni68CSYDY6p2+fpewtiscNj/
 /7tTvkb8bYw7E1OWgPm07Cv/qfXKnmCiFoXec9zTBY4jt5HwNCMhBbUi/v9h11XML/NI
 LreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733316698; x=1733921498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDVgM7YswkzMCupvuHUZvSx9m09yCbEdkJpSYkwV1Ao=;
 b=npTQDckAd+I+m3i0oDMjgqUKf6F505L14mcvn5sh1Ld+H6E7JTwIZGVsnoYXZqFDoi
 B5RkN9sXvRUOEOOyUs7cpiBg43duNM3zdcgtGkkQ9U6UMYZV/1n1CDttlLQLlqcFO9Eu
 h1qSRLibs+UrTIYBSwxzBBeo1Ah40mMEkJfVTuxby37eCvncCPVGEdu58d77haO0wiCx
 6dtlSqemsR+p26VJ6yql3KW6pReHt6xDbkA7JdQ1w/dKAkLWPASByX2S3uc/Cq4uE21z
 YceJ5UsOaVK2m/Yh/W+0B9tFL8YheuMbW4FPm5l5o+mE/BxUi1/G6zhbtb84Z90GOdE9
 Y1EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWylEtEDQ3HJvJCOUq19h6vSkzmVK9OTQYA0kxTtetLzhXA3vuYq6rdk9Nuu3/eB9lVTDUEP0GMi3Gd@nongnu.org
X-Gm-Message-State: AOJu0YwlJuaTZ4PKZD04QZgPYa3eNvn5Kt3IqC0UvJVzI2k8fxb6u4dQ
 KYR531ZDYZFpWFidiCvJTmiA8ytP7NzGNSDzCuEgtLgB5Mn6c7klz8iM/CoIQnw=
X-Gm-Gg: ASbGncul2kZE5rhoMY7HFqxpS9Y6+NgDdGCJi1KH72XCnAldOEiZTy+zkOTiUuTiz9w
 OZ+ZHSwifwX1397A81exOYtb4l3O4T0wQ7QdtWSEbcTvwfV8G1A5zgPb3uKGLw20YUGHLiq26dL
 jx9r2+Iad+zIqyg3rlRbrRIjvOIGc2JsflD6FmVwX80jL7frcJkW/vkzCtuw6joS6fDnt0ZoLo1
 mjHg9//Wk6A50VqUP2EWyy5RVc+7/XcsvZdsqn8bO1PByd5U1KRb0cpCCJ+B7o=
X-Google-Smtp-Source: AGHT+IEi/9gB+Fp+4XVqWw1+DCIn8X1s3bLPGm4HgDXYa3EwByrBQE+oW5LN+WBq0htY2Cwd+dl1LA==
X-Received: by 2002:a17:903:4091:b0:215:2d2c:dd0c with SMTP id
 d9443c01a7336-2152d2cdec9mr278935055ad.14.1733316698446; 
 Wed, 04 Dec 2024 04:51:38 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215a6fd6f57sm43344035ad.127.2024.12.04.04.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 04:51:38 -0800 (PST)
Message-ID: <30f0dc2d-b258-4cd7-98c3-d66718cb6fde@ventanamicro.com>
Date: Wed, 4 Dec 2024 09:51:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] target/riscv: Add counter
 delegation/configuration support
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, Kaiwen Xue <kaiwenx@rivosinc.com>
References: <20241203-counter_delegation-v4-0-c12a89baed86@rivosinc.com>
 <20241203-counter_delegation-v4-8-c12a89baed86@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241203-counter_delegation-v4-8-c12a89baed86@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 12/3/24 8:14 PM, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> The Smcdeleg/Ssccfg adds the support for counter delegation via
> S*indcsr and Ssccfg.
> 
> It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE)
> to enable this extension and scountovf virtualization.
> 
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 304 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 292 insertions(+), 12 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0985dbdca76d..a77b6ed4c9f3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -383,6 +383,21 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>       return smode32(env, csrno);
>   }
>   
> +static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    if (env->virt_enabled) {
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
> +    return smode(env, csrno);
> +}
> +
>   static bool csrind_extensions_present(CPURISCVState *env)
>   {
>       return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind;
> @@ -1220,10 +1235,9 @@ done:
>       return result;
>   }
>   
> -static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> -                                        target_ulong val)
> +static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
> +                                          uint32_t ctr_idx)
>   {
> -    int ctr_idx = csrno - CSR_MCYCLE;
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>       uint64_t mhpmctr_val = val;
>   
> @@ -1248,10 +1262,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
> -                                         target_ulong val)
> +static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
> +                                          uint32_t ctr_idx)
>   {
> -    int ctr_idx = csrno - CSR_MCYCLEH;
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>       uint64_t mhpmctr_val = counter->mhpmcounter_val;
>       uint64_t mhpmctrh_val = val;
> @@ -1273,6 +1286,20 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    int ctr_idx = csrno - CSR_MCYCLE;
> +
> +    return riscv_pmu_write_ctr(env, val, ctr_idx);
> +}
> +
> +static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    int ctr_idx = csrno - CSR_MCYCLEH;
> +
> +    return riscv_pmu_write_ctrh(env, val, ctr_idx);
> +}
> +
>   RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>                                            bool upper_half, uint32_t ctr_idx)
>   {
> @@ -1338,6 +1365,167 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
>       return riscv_pmu_read_ctr(env, val, true, ctr_index);
>   }
>   
> +static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
> +                              target_ulong *val, target_ulong new_val,
> +                              target_ulong wr_mask)
> +{
> +    if (wr_mask != 0 && wr_mask != -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        riscv_pmu_read_ctr(env, val, false, ctr_idx);
> +    } else if (wr_mask) {
> +        riscv_pmu_write_ctr(env, new_val, ctr_idx);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
> +                               target_ulong *val, target_ulong new_val,
> +                               target_ulong wr_mask)
> +{
> +    if (wr_mask != 0 && wr_mask != -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        riscv_pmu_read_ctr(env, val, true, ctr_idx);
> +    } else if (wr_mask) {
> +        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
> +                            target_ulong *val, target_ulong new_val,
> +                            target_ulong wr_mask)
> +{
> +    uint64_t mhpmevt_val = new_val;
> +
> +    if (wr_mask != 0 && wr_mask != -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        *val = env->mhpmevent_val[evt_index];
> +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> +            *val &= ~MHPMEVENT_BIT_MINH;
> +        }
> +    } else if (wr_mask) {
> +        wr_mask &= ~MHPMEVENT_BIT_MINH;
> +        mhpmevt_val = (new_val & wr_mask) |
> +                      (env->mhpmevent_val[evt_index] & ~wr_mask);
> +        if (riscv_cpu_mxl(env) == MXL_RV32) {
> +            mhpmevt_val = mhpmevt_val |
> +                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
> +        }
> +        env->mhpmevent_val[evt_index] = mhpmevt_val;
> +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
> +                             target_ulong *val, target_ulong new_val,
> +                             target_ulong wr_mask)
> +{
> +    uint64_t mhpmevth_val;
> +    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
> +
> +    if (wr_mask != 0 && wr_mask != -1) {
> +        return -EINVAL;
> +    }
> +
> +    if (!wr_mask && val) {
> +        *val = env->mhpmeventh_val[evt_index];
> +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> +            *val &= ~MHPMEVENTH_BIT_MINH;
> +        }
> +    } else if (wr_mask) {
> +        wr_mask &= ~MHPMEVENTH_BIT_MINH;
> +        env->mhpmeventh_val[evt_index] =
> +            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
> +        mhpmevth_val = env->mhpmeventh_val[evt_index];
> +        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
> +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> +    } else {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
> +                            target_ulong new_val, target_ulong wr_mask)
> +{
> +    switch (cfg_index) {
> +    case 0:             /* CYCLECFG */
> +        if (wr_mask) {
> +            wr_mask &= ~MCYCLECFG_BIT_MINH;
> +            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
> +        } else {
> +            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
> +        }
> +        break;
> +    case 2:             /* INSTRETCFG */
> +        if (wr_mask) {
> +            wr_mask &= ~MINSTRETCFG_BIT_MINH;
> +            env->minstretcfg = (new_val & wr_mask) |
> +                               (env->minstretcfg & ~wr_mask);
> +        } else {
> +            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
> +        }
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
> +                            target_ulong new_val, target_ulong wr_mask)
> +{
> +
> +    if (riscv_cpu_mxl(env) != MXL_RV32) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    switch (cfg_index) {
> +    case 0:         /* CYCLECFGH */
> +        if (wr_mask) {
> +            wr_mask &= ~MCYCLECFGH_BIT_MINH;
> +            env->mcyclecfgh = (new_val & wr_mask) |
> +                              (env->mcyclecfgh & ~wr_mask);
> +        } else {
> +            *val = env->mcyclecfgh;
> +        }
> +        break;
> +    case 2:          /* INSTRETCFGH */
> +        if (wr_mask) {
> +            wr_mask &= ~MINSTRETCFGH_BIT_MINH;
> +            env->minstretcfgh = (new_val & wr_mask) |
> +                                (env->minstretcfgh & ~wr_mask);
> +        } else {
> +            *val = env->minstretcfgh;
> +        }
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +
>   static RISCVException read_scountovf(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>   {
> @@ -1347,6 +1535,14 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
>       target_ulong *mhpm_evt_val;
>       uint64_t of_bit_mask;
>   
> +    /* Virtualize scountovf for counter delegation */
> +    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
> +        riscv_cpu_cfg(env)->ext_ssccfg &&
> +        get_field(env->menvcfg, MENVCFG_CDE) &&
> +        env->virt_enabled) {
> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> +    }
> +
>       if (riscv_cpu_mxl(env) == MXL_RV32) {
>           mhpm_evt_val = env->mhpmeventh_val;
>           of_bit_mask = MHPMEVENTH_BIT_OF;
> @@ -2290,11 +2486,72 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
>                           target_ulong isel, target_ulong *val,
>                           target_ulong new_val, target_ulong wr_mask)
>   {
> -    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
> -        return RISCV_EXCP_ILLEGAL_INST;
> +    int ret = -EINVAL;
> +    int ctr_index = isel - ISELECT_CD_FIRST;
> +    int isel_hpm_start = ISELECT_CD_FIRST + 3;
> +
> +    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
> +        ret = RISCV_EXCP_ILLEGAL_INST;
> +        goto done;
>       }
> -    /* TODO: Implement the functionality later */
> -    return RISCV_EXCP_NONE;
> +
> +    /* Invalid siselect value for reserved */
> +    if (ctr_index == 1) {
> +        goto done;
> +    }
> +
> +    /* sireg4 and sireg5 provides access RV32 only CSRs */
> +    if (((csrno == CSR_SIREG5) || (csrno == CSR_SIREG4)) &&
> +        (riscv_cpu_mxl(env) != MXL_RV32)) {
> +        ret = RISCV_EXCP_ILLEGAL_INST;
> +        goto done;
> +    }
> +
> +    /* Check Sscofpmf dependancy */
> +    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno == CSR_SIREG5 &&
> +        (isel_hpm_start <= isel && isel <= ISELECT_CD_LAST)) {
> +        goto done;
> +    }
> +
> +    /* Check smcntrpmf dependancy */
> +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
> +        (csrno == CSR_SIREG2 || csrno == CSR_SIREG5) &&
> +        (ISELECT_CD_FIRST <= isel && isel < isel_hpm_start)) {
> +        goto done;
> +    }
> +
> +    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
> +        !get_field(env->menvcfg, MENVCFG_CDE)) {
> +        goto done;
> +    }
> +
> +    switch (csrno) {
> +    case CSR_SIREG:
> +        ret = rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);
> +        break;
> +    case CSR_SIREG4:
> +        ret = rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);
> +        break;
> +    case CSR_SIREG2:
> +        if (ctr_index <= 2) {
> +            ret = rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);
> +        } else {
> +            ret = rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);
> +        }
> +        break;
> +    case CSR_SIREG5:
> +        if (ctr_index <= 2) {
> +            ret = rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);
> +        } else {
> +            ret = rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);
> +        }
> +        break;
> +    default:
> +        goto done;
> +    }
> +
> +done:
> +    return ret;
>   }
>   
>   /*
> @@ -2573,6 +2830,21 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
> +                                         target_ulong *val)
> +{
> +    /* S-mode can only access the bits delegated by M-mode */
> +    *val = env->mcountinhibit & env->mcounteren;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
> +                                          target_ulong val)
> +{
> +    write_mcountinhibit(env, csrno, val & env->mcounteren);
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
>                                         target_ulong *val)
>   {
> @@ -2675,11 +2947,13 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
> -    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | MENVCFG_CBZE;
> +    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> +                    MENVCFG_CBZE | MENVCFG_CDE;
>   
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>           mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> +                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
>                   (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>   
>           if (env_archcpu(env)->cfg.ext_zicfilp) {
> @@ -2708,7 +2982,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>       uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
>       uint64_t valh = (uint64_t)val << 32;
>   
>       env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
> @@ -5493,6 +5768,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                           write_sstateen_1_3,
>                           .min_priv_ver = PRIV_VERSION_1_12_0 },
>   
> +    /* Supervisor Counter Delegation */
> +    [CSR_SCOUNTINHIBIT] = {"scountinhibit", scountinhibit_pred,
> +                            read_scountinhibit, write_scountinhibit,
> +                           .min_priv_ver = PRIV_VERSION_1_12_0 },
> +
>       /* Supervisor Trap Setup */
>       [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
>                            NULL,                read_sstatus_i128              },
> 


