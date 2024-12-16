Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBFFE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 13:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBY8-0001OQ-TS; Mon, 16 Dec 2024 08:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNBY3-0001Hr-1u
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:54:11 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tNBY1-0005UY-2T
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:54:10 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21683192bf9so38558205ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734357247; x=1734962047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SkHvsKgz6+DXK3DMCZR+cWBTcN3mmgOK5I+saQICnnA=;
 b=UPnZH3PgiDPVV3Ky61AesfzzolZwwvkgWP1LsmIdbwmrtdud5EC1SDW69qVTchFBJ8
 kab+mcMDVcLXJGcf1/4Nbl1z1AmhKXen+RLtOW0JfscF/76GkgypMXV8USQi78eecw5S
 xZx4xRFLIh1e3MuQvVyipLNDf9/0Bz9gdRwBFLci+DCze65ShZb8Cp4bJYVg/zB0So54
 GJqkaB2n2M+6BxvFaWsMRQ55Z5h+Li2rlVnjmk9xIQB01YHOAoLA2zf+b4TRvJd1c9pb
 pRKL1MMdrNqUzTODUK3yKCtj+1g5QsrPNzYtyBxRnKa2P80oGpvsHwEGkdxyEI/h0e3o
 oj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734357247; x=1734962047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkHvsKgz6+DXK3DMCZR+cWBTcN3mmgOK5I+saQICnnA=;
 b=G1b57z96zOdqSYWfipEQlnQN4H+il7lHR7csFOkUaCQIPmEthmCMRJKWx7nCLivQya
 JryREVFWK0RWFpEeUyIsucDjWuXGZqFsfPj42nPpKsbKdPsxnMJ4RwCoZZqryBo3XSbG
 7t93pLc96KNiA4lOVGFF2Neq/R18PO7NHtXOturXMbva7qTdvBSLWllBjBPNDUnZuwY7
 teekOUquHgFcoXCOPtkBv+zppq1awiU+nIvvjwAZRBdOaoS6CNBLBz+m8GOyOc2aT7wy
 ILKNBowELwheDKn0OBO0Ow3pfC5+LuLMr8tgtbo9HwfKTDeEPC2W298NSAKeGr+iloGK
 ek5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQBVsJG8j7Tly3n9RBWcZLxhWdjJ08hL1uAAVRIZbpqP+EPDk+C6zdXAVxfvJ5ZjpjpieusVmuHmMg@nongnu.org
X-Gm-Message-State: AOJu0YwmpAsrc3V2b7HB0HTTZxuBG6YTEuwDSh4SDU/u+0w12lksULyf
 s1uK6WpueQBzoeMWTTyMf8H5yqD+O/ijR3AnWmzE7XSE8w6KfMElCR99Sx2TtOw=
X-Gm-Gg: ASbGnctdF5WRsT52BkrKraaduk+184SbkXTve8i5b8Sk1o2xPoyhqQbi6ZyWEOM1zUX
 Sf8j7CL58xQ48TjkLDrV6+4jEK5t6yeG70bhVAeoyPEjExDj/dX+UJq6ZBKiTCzaDOClX1/rWdb
 zC2XKji8T+na5/tEg2SXclsATvbS8g8ziplqKiN2/WhsQ178UTA5h6Tf85dALhBlCQndiRP6NDA
 DCopIXUePxKXMFXu2KJThbQi/W63++v1U60Pa5Bn2wbdioFdOki5qr4QJIHwky60NZzPA==
X-Google-Smtp-Source: AGHT+IGkbGEJa+ZSf1knfVNMOTpbSuwozg9/dnFgilVDB3CEF/WiT8pPA9Pts5kHKaK6mefTNTe7Xw==
X-Received: by 2002:a17:903:1cb:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-21892a62cc4mr156078285ad.52.1734357247052; 
 Mon, 16 Dec 2024 05:54:07 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1dcc748sm43227285ad.92.2024.12.16.05.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 05:54:06 -0800 (PST)
Message-ID: <a9ee09eb-157b-41c0-8476-f6b79145d1df@ventanamicro.com>
Date: Mon, 16 Dec 2024 10:54:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/7] target/riscv: Apply pointer masking for
 virtualized memory accesses
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
 <20241216121907.660504-7-baturo.alexey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241216121907.660504-7-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 12/16/24 9:19 AM, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h           |  1 +
>   target/riscv/cpu_helper.c    | 18 +++++++++++++++
>   target/riscv/internals.h     | 44 ++++++++++++++++++++++++++++++++++++
>   target/riscv/op_helper.c     | 16 ++++++-------
>   target/riscv/vector_helper.c | 21 -----------------
>   5 files changed, 71 insertions(+), 29 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 38231fe21e..536ad20fdd 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -773,6 +773,7 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>   
>   bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
>   RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
>   uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
>   
>   RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 480d2c2c8b..471d8d40a1 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -260,6 +260,24 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
>       return pmm;
>   }
>   
> +RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env)
> +{
> +    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
> +#ifndef CONFIG_USER_ONLY
> +    int priv_mode = cpu_address_mode(env);
> +    if (priv_mode == PRV_U) {
> +        pmm = get_field(env->hstatus, HSTATUS_HUPMM);
> +    } else {
> +        if (get_field(env->hstatus, HSTATUS_SPVP)) {
> +            pmm = get_field(env->henvcfg, HENVCFG_PMM);
> +        } else {
> +            pmm = get_field(env->senvcfg, SENVCFG_PMM);
> +        }
> +    }
> +#endif
> +    return pmm;
> +}
> +
>   bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
>   {
>       bool virt_mem_en = false;
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index ddbdee885b..017f33af1f 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -142,4 +142,48 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
>   /* Our implementation of CPUClass::has_work */
>   bool riscv_cpu_has_work(CPUState *cs);
>   
> +/* Zjpm addr masking routine */
> +static inline target_ulong adjust_addr_body(CPURISCVState *env,
> +                                            target_ulong addr,
> +                                            bool is_virt)
> +{
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        return addr;
> +    }
> +    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
> +    if (is_virt) {
> +        pmm = riscv_pm_get_virt_pmm(env);
> +    } else {
> +        pmm = riscv_pm_get_pmm(env);
> +    }
> +    if (pmm == PMM_FIELD_DISABLED) {
> +        return addr;
> +    }
> +    uint32_t pmlen = riscv_pm_get_pmlen(pmm);
> +    bool signext = false;
> +    if (!is_virt) {
> +        signext = riscv_cpu_virt_mem_enabled(env);
> +    }
> +    addr = addr << pmlen;
> +    /* sign/zero extend masked address by N-1 bit */
> +    if (signext) {
> +        addr = (target_long)addr >> pmlen;
> +    } else {
> +        addr = addr >> pmlen;
> +    }
> +    return addr;
> +}
> +
> +static inline target_ulong adjust_addr(CPURISCVState *env,
> +                                       target_ulong addr)
> +{
> +    return adjust_addr_body(env, addr, false);
> +}
> +
> +static inline target_ulong adjust_addr_virt(CPURISCVState *env,
> +                                            target_ulong addr)
> +{
> +    return adjust_addr_body(env, addr, true);
> +}
> +
>   #endif
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b..20e5bd5088 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -472,7 +472,7 @@ target_ulong helper_hyp_hlv_bu(CPURISCVState *env, target_ulong addr)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
>   
> -    return cpu_ldb_mmu(env, addr, oi, ra);
> +    return cpu_ldb_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>   }
>   
>   target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
> @@ -481,7 +481,7 @@ target_ulong helper_hyp_hlv_hu(CPURISCVState *env, target_ulong addr)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
>   
> -    return cpu_ldw_mmu(env, addr, oi, ra);
> +    return cpu_ldw_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>   }
>   
>   target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
> @@ -490,7 +490,7 @@ target_ulong helper_hyp_hlv_wu(CPURISCVState *env, target_ulong addr)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
>   
> -    return cpu_ldl_mmu(env, addr, oi, ra);
> +    return cpu_ldl_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>   }
>   
>   target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
> @@ -499,7 +499,7 @@ target_ulong helper_hyp_hlv_d(CPURISCVState *env, target_ulong addr)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
>   
> -    return cpu_ldq_mmu(env, addr, oi, ra);
> +    return cpu_ldq_mmu(env, adjust_addr_virt(env, addr), oi, ra);
>   }
>   
>   void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
> @@ -508,7 +508,7 @@ void helper_hyp_hsv_b(CPURISCVState *env, target_ulong addr, target_ulong val)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
>   
> -    cpu_stb_mmu(env, addr, val, oi, ra);
> +    cpu_stb_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>   }
>   
>   void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
> @@ -517,7 +517,7 @@ void helper_hyp_hsv_h(CPURISCVState *env, target_ulong addr, target_ulong val)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_TEUW, mmu_idx);
>   
> -    cpu_stw_mmu(env, addr, val, oi, ra);
> +    cpu_stw_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>   }
>   
>   void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
> @@ -526,7 +526,7 @@ void helper_hyp_hsv_w(CPURISCVState *env, target_ulong addr, target_ulong val)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_TEUL, mmu_idx);
>   
> -    cpu_stl_mmu(env, addr, val, oi, ra);
> +    cpu_stl_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>   }
>   
>   void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
> @@ -535,7 +535,7 @@ void helper_hyp_hsv_d(CPURISCVState *env, target_ulong addr, target_ulong val)
>       int mmu_idx = check_access_hlsv(env, false, ra);
>       MemOpIdx oi = make_memop_idx(MO_TEUQ, mmu_idx);
>   
> -    cpu_stq_mmu(env, addr, val, oi, ra);
> +    cpu_stq_mmu(env, adjust_addr_virt(env, addr), val, oi, ra);
>   }
>   
>   /*
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 37c6c198a5..a0093bcc9c 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -105,27 +105,6 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
>       return scale < 0 ? vlenb >> -scale : vlenb << scale;
>   }
>   
> -static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
> -{
> -    if (riscv_cpu_mxl(env) == MXL_RV32) {
> -        return addr;
> -    }
> -    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
> -    if (pmm == PMM_FIELD_DISABLED) {
> -        return addr;
> -    }
> -    int pmlen = riscv_pm_get_pmlen(pmm);
> -    bool signext = riscv_cpu_virt_mem_enabled(env);
> -    addr = addr << pmlen;
> -    /* sign/zero extend masked address by N-1 bit */
> -    if (signext) {
> -        addr = (target_long)addr >> pmlen;
> -    } else {
> -        addr = addr >> pmlen;
> -    }
> -    return addr;
> -}
> -
>   /*
>    * This function checks watchpoint before real load operation.
>    *


