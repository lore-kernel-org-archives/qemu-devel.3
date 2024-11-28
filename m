Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A20D69105
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGe20-0002Po-D4; Thu, 28 Nov 2024 07:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGe1x-0002PJ-IG
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:54:01 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tGe1u-0006cx-WB
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 07:54:01 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a76fd74099so3487805ab.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 04:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732798437; x=1733403237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dPLmJwNc+pV0Iizwf1pgyZEpp1ltsyJmp4X0CS2XaIM=;
 b=iIFpOXwyljv9ooh8ZjTc+SAhB9CJYi4xVmRa7oM8Dy5f2VzQGmP/adpn42UKO3SS0T
 RxEMozotdmfdivatQR+4bwoKwfVwE6ALIkNJL4jebiFIryrnpkck1tryM28gOGstfShn
 q/Fqc4vvJEyK60fzenFA94rG0OLBFFlm/jv7y/Oj57L3Z20aGpzRzaEDpDziulLKpqj2
 sfxUnnhuUExsDbiy4oHuBcAn/QBd/JI2TYxQDuet23Ul4jP3wCaExdd8rZSBthr8dZpB
 PCPTPjgtatHIG+l6M+ri16ZOtRINLOSoKIFie/3G5nPsrj9X/TouBwHK4hSqRIZs0SsO
 f5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732798437; x=1733403237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dPLmJwNc+pV0Iizwf1pgyZEpp1ltsyJmp4X0CS2XaIM=;
 b=M1KULwaRZhMICawGtFVAVqqZdNPSFrPSzQzzV25U6r5wzop/Lul23ri7A1apFyNmLj
 V/bhjp0o5AJZ9aRy2nnmWLxH4nZP38LEW04w5hP8xeUjqK1Rq8OzORpUtcUdlMb5HedV
 v001S9ftvFeDQUdew3JpKWv5m31K9lEzLwy3vNSXWw2iD0J/jK7j/ZK/E9WL/jQqh+xK
 XFD0Ccid9LdcJkbX/EGjCIJynOy28F/rqCxry7Lf8plzKdHuTnR8L7B5ViVfB7giSXbG
 QFvZwaUoTHpxqayio2G3t+ZMeFDjvYo3f00cuFNVHib4WNJlujlB6lX/aMg7sfjp+ZdS
 iMuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4VS7/W8CxQwE7GRN6Ny81iJ4EJMRgUa1yiiRRmbgNkxnskcYnkrYMwAApYDiGaZD5tV7IRfyqawby@nongnu.org
X-Gm-Message-State: AOJu0YzuFSH8BQdqOGS0tpqltQipkPObVQcVb5aYboeDBehLlirxCZcH
 PcxEdXGoR0aTG/Q17/rzK8z+IrRb594msHShrPVAMGY4clYwD6RrHttYuOY3LUM=
X-Gm-Gg: ASbGncvwHEtM6JijMk8Doa0k5zF4wJHM/hmnjEm9bXUTNfwlQHfKPq2dfh7fxcCIrm/
 /x96BsAYXFD9UrX+1WX6MQb/yxVEniLhWCy90wOWFDbhuQnCiDl55V84mHibE3eHfvSuclBybuu
 3K051VzlJd+oTYd9KKs+OFP5clpvKvgUHOBzwSYpUI+PJRf9XHo99kIIFxqsufTy1MFw3/XQy3m
 bg9lgcGeWgDB0nR0wyBqYqwe9jY4rcvDUUJ/leg9WOj6s65hGPBNAKvdQTQhcI=
X-Google-Smtp-Source: AGHT+IEQY6WUIgkoq40kbKhenx4pz8/uMR+MkQosK+QqylVJ3ZsST9/D0bC6Wz9O9B6uMb7UXNBwew==
X-Received: by 2002:a05:6602:6015:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-843ed0f782emr857667339f.14.1732798437201; 
 Thu, 28 Nov 2024 04:53:57 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fc9c3a0c3csm1232266a12.76.2024.11.28.04.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 04:53:56 -0800 (PST)
Message-ID: <ac472499-b9af-4e40-8796-fdea9ef2b69c@ventanamicro.com>
Date: Thu, 28 Nov 2024 09:53:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] target/riscv: Add counter
 delegation/configuration support
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, Kaiwen Xue <kaiwenx@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
 <20241117-counter_delegation-v3-8-476d6f36e3c8@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241117-counter_delegation-v3-8-476d6f36e3c8@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x134.google.com
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



On 11/17/24 10:15 PM, Atish Patra wrote:
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
>   target/riscv/csr.c | 300 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 289 insertions(+), 11 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 97cc8059ad37..31ea8b8ec20d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -385,6 +385,21 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
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
> @@ -1222,10 +1237,9 @@ done:
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
> @@ -1250,10 +1264,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
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
> @@ -1275,6 +1288,20 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
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
> @@ -1340,6 +1367,167 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
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
> @@ -1349,6 +1537,14 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
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
> @@ -2292,11 +2488,70 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
>                           target_ulong isel, target_ulong *val,
>                           target_ulong new_val, target_ulong wr_mask)
>   {
> -    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
> +    int ret = -EINVAL;

It seems like both 'ret' and the 'done' label are being used as shortcuts to do
'return ret', and every time 'ret' is assigned to something else can be replaced
by an early 'return' exit.

I would remove 'ret' and the 'done' label and:



> +    int ctr_index = isel - ISELECT_CD_FIRST;
> +    int isel_hpm_start = ISELECT_CD_FIRST + 3;
> +
> +    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
>           return RISCV_EXCP_ILLEGAL_INST;
>       }
> -    /* TODO: Implement the functionality later */
> -    return RISCV_EXCP_NONE;
> +
> +    /* Invalid siselect value for reserved */
> +    if (ctr_index == 1) {
> +        goto done;

            return -EINVAL;
> +    }
> +
> +    /* sireg4 and sireg5 provides access RV32 only CSRs */
> +    if (((csrno == CSR_SIREG5) || (csrno == CSR_SIREG4)) &&
> +        (riscv_cpu_mxl(env) != MXL_RV32)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    /* Check Sscofpmf dependancy */
> +    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno == CSR_SIREG5 &&
> +        (isel_hpm_start <= isel && isel <= ISELECT_CD_LAST)) {
> +        goto done;

            return -EINVAL;

> +    }
> +
> +    /* Check smcntrpmf dependancy */
> +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
> +        (csrno == CSR_SIREG2 || csrno == CSR_SIREG5) &&
> +        (ISELECT_CD_FIRST <= isel && isel < isel_hpm_start)) {
> +        goto done;

            return -EINVAL;

> +    }
> +
> +    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
> +        !get_field(env->menvcfg, MENVCFG_CDE)) {
> +        goto done;

            return -EINVAL;

> +    }
> +
> +    switch (csrno) {
> +    case CSR_SIREG:
> +        ret = rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);

            return  rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);
> +        break;
> +    case CSR_SIREG4:
> +        ret = rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);

            return rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);
> +        break;
> +    case CSR_SIREG2:
> +        if (ctr_index <= 2) {
> +            ret = rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);

                return rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);
> +        } else {
> +            ret = rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);

                return rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);

> +        }
> +        break;
> +    case CSR_SIREG5:
> +        if (ctr_index <= 2) {
> +            ret = rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);

                return rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);

> +        } else {
> +            ret = rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);

                return rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);

> +        }
> +        break;
> +    default:
> +        goto done;

            return -EINVAL;

> +    }
> +
> +done:
> +    return ret;

And remove this last 'return' since we're doing all possible returns already.


Thanks,

Daniel

>   }
>   
>   /*
> @@ -2578,6 +2833,21 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
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
> @@ -2680,11 +2950,13 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
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
> @@ -2713,7 +2985,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>       uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
>       uint64_t valh = (uint64_t)val << 32;
>   
>       env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
> @@ -5498,6 +5771,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


