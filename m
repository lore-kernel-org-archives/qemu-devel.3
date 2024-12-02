Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28A4E69E97
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEIk-0004KH-D9; Mon, 02 Dec 2024 16:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIEIj-0004K0-5N
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:49:53 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tIEIg-0000YH-Nc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:49:52 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so1604744a91.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733176189; x=1733780989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJ/gWEE8dinutoPMuLX4TBPxO47UAfzwDPl5zhq9EcI=;
 b=hrzn1mWS4+b/BNWLcSRljgF24BPEvQcJokJACIuZDhTo5nsgQplwB5NCDUm3a7vdTF
 H//JZMHE/d/QN4qkC35RhCj9NTVd8KGkImWbP9Mxb0bv5ovXNQcY5+m81bgl/H/Z/SJQ
 yt2qsS4jtcHrhbWR1hMZaMI9o8ETsjZBusnRGra14CV6I5TY3tjGQ2HRrRZxiOMgufSd
 5ih03CBOcWs9n65ifHQPyL8US64dwSFZlN1FOK8SQChgxYkazvcPM6Wv/cnD1mBhkXm+
 LQq6vQFDiuy8qEXyUl6+L01Bz8hcbhSYQ6FRFq8W26UmH4UnEFsekCnzsb8GUEhDm9g5
 2Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733176189; x=1733780989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yJ/gWEE8dinutoPMuLX4TBPxO47UAfzwDPl5zhq9EcI=;
 b=S3aCxelFVYcJTSyxTc77gE7AZik0xooltrgqZe9+kV7IVqv7RLKRGRl96zn5c+53ir
 LV9dAZwnc1/kPCU4RGnryjsdevq7ildznJqfTMmnXJ44KbtbK7d1cZb+FTuLf4PHB8mX
 xmZB9DEq7Mo4hkmpvAb9/VUI/ne53y9+fFYMEX+vr9d5Zeu7hYFjh/1ucjqXRtnniQ8L
 pLZcsCy+DxfKKM6YzQSePGgdWVMyf6+QlhObtiis8FDh9KUOTyk2Uslmxc89ESTt3dRf
 JNSP5LDd+ujq3qz4q7bwjqWZW9X1qqzVivrF7+T31BG0A9inA14s8xpkIB+jf2aSOiLS
 +LiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmhtH5XklSRXCiIm5hO34r7oPzr8s5Fj6U3XEPviCaWGv21pFvfCHKQ4bhBYKrJ4wN+/xylwS0A0t4@nongnu.org
X-Gm-Message-State: AOJu0YxQX54xdiqmyz0wqACqx5Q+nNGmZ0K4NN/zrpjoD3aAvECrSQJl
 FPK+YMOeiysiMIN1yoUgkdqoIVj9wB/7buaaGxKqHpFIcFtAFms1LYCVcqR1wWc=
X-Gm-Gg: ASbGncuqjR75W42wIABUiFItCHwt+B3Ee/doRQe7k5iCdw49yOwCvRW/VBlQAI7vMlF
 PGZeMua+oM6KS5rEPgASPdC9JazWfG7bz+31ulnPTXytjh0TfnmTL8shaCugw46sAiENtTB3APY
 1QCwk9Wypemcpumnp1AvU+GxFcg6EZfq7wrAqIE5iTsyACoUL7lG5nmozb+dVDi6oRhDSgmKyXs
 JSgIXWxaEV8ectsaRAWVXqhLpLcW+Ovjr0O9fNw02PgaDg8LEBT8uS53pUZo7Y=
X-Google-Smtp-Source: AGHT+IHwmw0PWfIomJ7FTT6ocnZQbzbxoXA4c2VCOESJ9HQGSCLE8DxwU40mXS8EN5IUX/mv4inMTg==
X-Received: by 2002:a17:90b:1c10:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2ef011dedcemr192157a91.1.1733176188640; 
 Mon, 02 Dec 2024 13:49:48 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee925715f2sm4854425a91.29.2024.12.02.13.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 13:49:48 -0800 (PST)
Message-ID: <f2da7270-8d38-403a-bebe-1064d7f627dd@ventanamicro.com>
Date: Mon, 2 Dec 2024 18:49:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] target/riscv: Add counter
 delegation/configuration support
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 bin.meng@windriver.com, alistair.francis@wdc.com,
 Kaiwen Xue <kaiwenx@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
 <20241117-counter_delegation-v3-8-476d6f36e3c8@rivosinc.com>
 <ac472499-b9af-4e40-8796-fdea9ef2b69c@ventanamicro.com>
 <CAHBxVyF4A8byvg51SgjF_XhUp7TDsc0ZVYm3u+y9M3oN_EN06Q@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAHBxVyF4A8byvg51SgjF_XhUp7TDsc0ZVYm3u+y9M3oN_EN06Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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



On 12/2/24 6:15 PM, Atish Kumar Patra wrote:
> On Thu, Nov 28, 2024 at 4:53 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 11/17/24 10:15 PM, Atish Patra wrote:
>>> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>>>
>>> The Smcdeleg/Ssccfg adds the support for counter delegation via
>>> S*indcsr and Ssccfg.
>>>
>>> It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE)
>>> to enable this extension and scountovf virtualization.
>>>
>>> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
>>> Co-developed-by: Atish Patra <atishp@rivosinc.com>
>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> ---
>>>    target/riscv/csr.c | 300 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>    1 file changed, 289 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>> index 97cc8059ad37..31ea8b8ec20d 100644
>>> --- a/target/riscv/csr.c
>>> +++ b/target/riscv/csr.c
>>> @@ -385,6 +385,21 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>>>        return smode32(env, csrno);
>>>    }
>>>
>>> +static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
>>> +{
>>> +    RISCVCPU *cpu = env_archcpu(env);
>>> +
>>> +    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
>>> +        return RISCV_EXCP_ILLEGAL_INST;
>>> +    }
>>> +
>>> +    if (env->virt_enabled) {
>>> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>>> +    }
>>> +
>>> +    return smode(env, csrno);
>>> +}
>>> +
>>>    static bool csrind_extensions_present(CPURISCVState *env)
>>>    {
>>>        return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind;
>>> @@ -1222,10 +1237,9 @@ done:
>>>        return result;
>>>    }
>>>
>>> -static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>>> -                                        target_ulong val)
>>> +static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
>>> +                                          uint32_t ctr_idx)
>>>    {
>>> -    int ctr_idx = csrno - CSR_MCYCLE;
>>>        PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>>>        uint64_t mhpmctr_val = val;
>>>
>>> @@ -1250,10 +1264,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
>>>        return RISCV_EXCP_NONE;
>>>    }
>>>
>>> -static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>>> -                                         target_ulong val)
>>> +static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
>>> +                                          uint32_t ctr_idx)
>>>    {
>>> -    int ctr_idx = csrno - CSR_MCYCLEH;
>>>        PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
>>>        uint64_t mhpmctr_val = counter->mhpmcounter_val;
>>>        uint64_t mhpmctrh_val = val;
>>> @@ -1275,6 +1288,20 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
>>>        return RISCV_EXCP_NONE;
>>>    }
>>>
>>> +static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
>>> +{
>>> +    int ctr_idx = csrno - CSR_MCYCLE;
>>> +
>>> +    return riscv_pmu_write_ctr(env, val, ctr_idx);
>>> +}
>>> +
>>> +static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
>>> +{
>>> +    int ctr_idx = csrno - CSR_MCYCLEH;
>>> +
>>> +    return riscv_pmu_write_ctrh(env, val, ctr_idx);
>>> +}
>>> +
>>>    RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>>>                                             bool upper_half, uint32_t ctr_idx)
>>>    {
>>> @@ -1340,6 +1367,167 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
>>>        return riscv_pmu_read_ctr(env, val, true, ctr_index);
>>>    }
>>>
>>> +static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
>>> +                              target_ulong *val, target_ulong new_val,
>>> +                              target_ulong wr_mask)
>>> +{
>>> +    if (wr_mask != 0 && wr_mask != -1) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!wr_mask && val) {
>>> +        riscv_pmu_read_ctr(env, val, false, ctr_idx);
>>> +    } else if (wr_mask) {
>>> +        riscv_pmu_write_ctr(env, new_val, ctr_idx);
>>> +    } else {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
>>> +                               target_ulong *val, target_ulong new_val,
>>> +                               target_ulong wr_mask)
>>> +{
>>> +    if (wr_mask != 0 && wr_mask != -1) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!wr_mask && val) {
>>> +        riscv_pmu_read_ctr(env, val, true, ctr_idx);
>>> +    } else if (wr_mask) {
>>> +        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
>>> +    } else {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
>>> +                            target_ulong *val, target_ulong new_val,
>>> +                            target_ulong wr_mask)
>>> +{
>>> +    uint64_t mhpmevt_val = new_val;
>>> +
>>> +    if (wr_mask != 0 && wr_mask != -1) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!wr_mask && val) {
>>> +        *val = env->mhpmevent_val[evt_index];
>>> +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
>>> +            *val &= ~MHPMEVENT_BIT_MINH;
>>> +        }
>>> +    } else if (wr_mask) {
>>> +        wr_mask &= ~MHPMEVENT_BIT_MINH;
>>> +        mhpmevt_val = (new_val & wr_mask) |
>>> +                      (env->mhpmevent_val[evt_index] & ~wr_mask);
>>> +        if (riscv_cpu_mxl(env) == MXL_RV32) {
>>> +            mhpmevt_val = mhpmevt_val |
>>> +                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
>>> +        }
>>> +        env->mhpmevent_val[evt_index] = mhpmevt_val;
>>> +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
>>> +    } else {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
>>> +                             target_ulong *val, target_ulong new_val,
>>> +                             target_ulong wr_mask)
>>> +{
>>> +    uint64_t mhpmevth_val;
>>> +    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
>>> +
>>> +    if (wr_mask != 0 && wr_mask != -1) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!wr_mask && val) {
>>> +        *val = env->mhpmeventh_val[evt_index];
>>> +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
>>> +            *val &= ~MHPMEVENTH_BIT_MINH;
>>> +        }
>>> +    } else if (wr_mask) {
>>> +        wr_mask &= ~MHPMEVENTH_BIT_MINH;
>>> +        env->mhpmeventh_val[evt_index] =
>>> +            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
>>> +        mhpmevth_val = env->mhpmeventh_val[evt_index];
>>> +        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
>>> +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
>>> +    } else {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
>>> +                            target_ulong new_val, target_ulong wr_mask)
>>> +{
>>> +    switch (cfg_index) {
>>> +    case 0:             /* CYCLECFG */
>>> +        if (wr_mask) {
>>> +            wr_mask &= ~MCYCLECFG_BIT_MINH;
>>> +            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
>>> +        } else {
>>> +            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
>>> +        }
>>> +        break;
>>> +    case 2:             /* INSTRETCFG */
>>> +        if (wr_mask) {
>>> +            wr_mask &= ~MINSTRETCFG_BIT_MINH;
>>> +            env->minstretcfg = (new_val & wr_mask) |
>>> +                               (env->minstretcfg & ~wr_mask);
>>> +        } else {
>>> +            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
>>> +        }
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
>>> +                            target_ulong new_val, target_ulong wr_mask)
>>> +{
>>> +
>>> +    if (riscv_cpu_mxl(env) != MXL_RV32) {
>>> +        return RISCV_EXCP_ILLEGAL_INST;
>>> +    }
>>> +
>>> +    switch (cfg_index) {
>>> +    case 0:         /* CYCLECFGH */
>>> +        if (wr_mask) {
>>> +            wr_mask &= ~MCYCLECFGH_BIT_MINH;
>>> +            env->mcyclecfgh = (new_val & wr_mask) |
>>> +                              (env->mcyclecfgh & ~wr_mask);
>>> +        } else {
>>> +            *val = env->mcyclecfgh;
>>> +        }
>>> +        break;
>>> +    case 2:          /* INSTRETCFGH */
>>> +        if (wr_mask) {
>>> +            wr_mask &= ~MINSTRETCFGH_BIT_MINH;
>>> +            env->minstretcfgh = (new_val & wr_mask) |
>>> +                                (env->minstretcfgh & ~wr_mask);
>>> +        } else {
>>> +            *val = env->minstretcfgh;
>>> +        }
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +
>>>    static RISCVException read_scountovf(CPURISCVState *env, int csrno,
>>>                                         target_ulong *val)
>>>    {
>>> @@ -1349,6 +1537,14 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
>>>        target_ulong *mhpm_evt_val;
>>>        uint64_t of_bit_mask;
>>>
>>> +    /* Virtualize scountovf for counter delegation */
>>> +    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
>>> +        riscv_cpu_cfg(env)->ext_ssccfg &&
>>> +        get_field(env->menvcfg, MENVCFG_CDE) &&
>>> +        env->virt_enabled) {
>>> +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>>> +    }
>>> +
>>>        if (riscv_cpu_mxl(env) == MXL_RV32) {
>>>            mhpm_evt_val = env->mhpmeventh_val;
>>>            of_bit_mask = MHPMEVENTH_BIT_OF;
>>> @@ -2292,11 +2488,70 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
>>>                            target_ulong isel, target_ulong *val,
>>>                            target_ulong new_val, target_ulong wr_mask)
>>>    {
>>> -    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
>>> +    int ret = -EINVAL;
>>
>> It seems like both 'ret' and the 'done' label are being used as shortcuts to do
>> 'return ret', and every time 'ret' is assigned to something else can be replaced
>> by an early 'return' exit.
>>
>> I would remove 'ret' and the 'done' label and:
>>
>>
>>
>>> +    int ctr_index = isel - ISELECT_CD_FIRST;
>>> +    int isel_hpm_start = ISELECT_CD_FIRST + 3;
>>> +
>>> +    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
>>>            return RISCV_EXCP_ILLEGAL_INST;
>>>        }
>>> -    /* TODO: Implement the functionality later */
>>> -    return RISCV_EXCP_NONE;
>>> +
>>> +    /* Invalid siselect value for reserved */
>>> +    if (ctr_index == 1) {
>>> +        goto done;
>>
>>              return -EINVAL;
>>> +    }
>>> +
>>> +    /* sireg4 and sireg5 provides access RV32 only CSRs */
>>> +    if (((csrno == CSR_SIREG5) || (csrno == CSR_SIREG4)) &&
>>> +        (riscv_cpu_mxl(env) != MXL_RV32)) {
>>> +        return RISCV_EXCP_ILLEGAL_INST;
>>> +    }
>>> +
>>> +    /* Check Sscofpmf dependancy */
>>> +    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno == CSR_SIREG5 &&
>>> +        (isel_hpm_start <= isel && isel <= ISELECT_CD_LAST)) {
>>> +        goto done;
>>
>>              return -EINVAL;
>>
>>> +    }
>>> +
>>> +    /* Check smcntrpmf dependancy */
>>> +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
>>> +        (csrno == CSR_SIREG2 || csrno == CSR_SIREG5) &&
>>> +        (ISELECT_CD_FIRST <= isel && isel < isel_hpm_start)) {
>>> +        goto done;
>>
>>              return -EINVAL;
>>
>>> +    }
>>> +
>>> +    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
>>> +        !get_field(env->menvcfg, MENVCFG_CDE)) {
>>> +        goto done;
>>
>>              return -EINVAL;
>>
>>> +    }
>>> +
>>> +    switch (csrno) {
>>> +    case CSR_SIREG:
>>> +        ret = rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);
>>
>>              return  rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);
>>> +        break;
>>> +    case CSR_SIREG4:
>>> +        ret = rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);
>>
>>              return rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);
>>> +        break;
>>> +    case CSR_SIREG2:
>>> +        if (ctr_index <= 2) {
>>> +            ret = rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);
>>
>>                  return rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);
>>> +        } else {
>>> +            ret = rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);
>>
>>                  return rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);
>>
>>> +        }
>>> +        break;
>>> +    case CSR_SIREG5:
>>> +        if (ctr_index <= 2) {
>>> +            ret = rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);
>>
>>                  return rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);
>>
>>> +        } else {
>>> +            ret = rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);
>>
>>                  return rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);
>>
>>> +        }
>>> +        break;
>>> +    default:
>>> +        goto done;
>>
>>              return -EINVAL;
>>
>>> +    }
>>> +
>>> +done:
>>> +    return ret;
>>
>> And remove this last 'return' since we're doing all possible returns already.
>>
> 
> Personally, I prefer a single return in a switch case block. That's
> why I have the jump label.
> If you feel too strongly about that, I can change as per your suggestion though.


Yeah I forgot to mention in my reply that this was more a code style suggestion than
"please change it". Feel free to keep it as is.

If you want consistency with the label + return pattern throughout the function you could
remove the instances of  'return RISCV_EXCP_ILLEGAL_INST' and do

  ret = return RISCV_EXCP_ILLEGAL_INST;
  goto done;

That way we don't have early 'return' exits in some places and 'goto done' in others.

And again, optional code style comments. Thanks,


Daniel


> 
>>
>> Thanks,
>>
>> Daniel
>>
>>>    }
>>>
>>>    /*
>>> @@ -2578,6 +2833,21 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
>>>        return RISCV_EXCP_NONE;
>>>    }
>>>
>>> +static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
>>> +                                         target_ulong *val)
>>> +{
>>> +    /* S-mode can only access the bits delegated by M-mode */
>>> +    *val = env->mcountinhibit & env->mcounteren;
>>> +    return RISCV_EXCP_NONE;
>>> +}
>>> +
>>> +static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
>>> +                                          target_ulong val)
>>> +{
>>> +    write_mcountinhibit(env, csrno, val & env->mcounteren);
>>> +    return RISCV_EXCP_NONE;
>>> +}
>>> +
>>>    static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
>>>                                          target_ulong *val)
>>>    {
>>> @@ -2680,11 +2950,13 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>>>                                        target_ulong val)
>>>    {
>>>        const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>>> -    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | MENVCFG_CBZE;
>>> +    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
>>> +                    MENVCFG_CBZE | MENVCFG_CDE;
>>>
>>>        if (riscv_cpu_mxl(env) == MXL_RV64) {
>>>            mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>>>                    (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>>> +                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
>>>                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>>>
>>>            if (env_archcpu(env)->cfg.ext_zicfilp) {
>>> @@ -2713,7 +2985,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>>>        const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>>>        uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>>>                        (cfg->ext_sstc ? MENVCFG_STCE : 0) |
>>> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
>>> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
>>> +                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
>>>        uint64_t valh = (uint64_t)val << 32;
>>>
>>>        env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
>>> @@ -5498,6 +5771,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>>>                            write_sstateen_1_3,
>>>                            .min_priv_ver = PRIV_VERSION_1_12_0 },
>>>
>>> +    /* Supervisor Counter Delegation */
>>> +    [CSR_SCOUNTINHIBIT] = {"scountinhibit", scountinhibit_pred,
>>> +                            read_scountinhibit, write_scountinhibit,
>>> +                           .min_priv_ver = PRIV_VERSION_1_12_0 },
>>> +
>>>        /* Supervisor Trap Setup */
>>>        [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
>>>                             NULL,                read_sstatus_i128              },
>>>
>>


