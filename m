Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50793CAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqQE-0002rQ-6i; Wed, 17 Sep 2025 07:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyqQ9-0002qj-Ol
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:33:58 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uyqQ5-0007Au-Qp
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 07:33:56 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6296f6ce5ddso2199623d50.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 04:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758108832; x=1758713632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZCLycGSctS9nUiQ2ptFxl7W8ZiF6zfMkmnFkuhYOYoM=;
 b=WNlO9L9Ys+QdAOAsk07IJ+PS3Dg7cRxrP/wpB6m5rsdvWiDUID4cC+VxlHukn7D5+9
 +2OCmczcEbXTa0BH5NUFLR3hhcNH69tSiJbdGsniJJJgI/TsYgH+/Mhwu5PXradY+/6G
 guZEGg7SLa53JZHjC6jswKjfsfvpySTEeMJHywe4apQPfjpQIOHwybpzHQqnKcxonJ21
 RMKPyUhVAGIosyCOF8r2mX7pOpoV2QypiHC791HqIm8wa0oH+jdCyM2s7NzJUIoz8lA8
 o5oh/SPtnrGHz2sgo9xT/+asacVED+wx8c+TsXkTG6eT9PTjfUtXE5XrBjPodwQ9ehAA
 wIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758108832; x=1758713632;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCLycGSctS9nUiQ2ptFxl7W8ZiF6zfMkmnFkuhYOYoM=;
 b=sDNdwILoYjW1rIN1F5KYg8g9B4166dy/JigskdxMy22CqutH3G8jmMtBD8Fzraw5mt
 gKAYx6zfmhUe7rG2EKlkisFBhfjsqzhiSLmvuv+VchS2nCA8gnQsTVqCrgdyYFnPchG0
 vgboDakPJnqQH48a6PDRJ797WzAXH2ae4ssrlqz1LJGRhkKDvfkZ/c6+tq4U5GKKPm6A
 cCff3xwmhPrJkAT19LV0BXTk4v6mK2m8RON8/Yz+iSSnGUpG/w+gLrbRfMpaRTlToXdl
 eetI4SmpB4Ze8GwWSeX/NoMAoQNLrPlzD9vL2RjCDBlITsUpKvAKABaVqFSu5jrkIaFA
 3+8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9T0FreAIQDJiPmFt/7qAfkpC+6ZAYLLfuhemiddGs4jWXOf1kihxkRQRjd2M4bpyAofNhPLHBxkTp@nongnu.org
X-Gm-Message-State: AOJu0YyhNf1Tw5zpwYxXDM8exM0G4Sq8ZEL5xWU9VBNFTTfDFfx/DpcP
 BNF80oH6S1cejsJIkwJ7R2up3hITDIILhn1FTKVtrEemDe2cL4/Y6F+roRVnsf75pts=
X-Gm-Gg: ASbGncsrSkGZWyFT6vevp2+EWFaKxL2WDS1L0g+SteTvW55rD4uT52sBvNt8DW5+8tZ
 xMndCYOdY4VHRCcuhyA0nkQjgODqJAwNrRb4KuveyqyMdceFvOVZS5EMeIeS9rlFeoEFWH/S2YN
 1Rd96ZI3fFGGsz8A1wfB7KDKpsmN/OJUjO2XZks3O+sGX3w3cvyFP+ghLSmYxbzkYMsB0YlHAN6
 O59Kk6X4NRuetCUddTqkgUIW+fho2aGf/4Z5IKX7vLo3ouKGjtxLrxtfFO+a8Akiel1+cR/Glst
 xe+vex+gfXMf/05i1ABWZXawTWXABPq2pUZSZLzlMJA0Yifx7LmQcLd9H+aRjN77Ibso51Qm0xv
 uTObND/eXxz0D9DLxp5aG4IbDSokCB00A8Ue2+Zb3yddK436rbYJYgVpDfs/GrKjZ2d/MYt6noI
 W/
X-Google-Smtp-Source: AGHT+IEhM/NjdYcSA7GNgp9MWAmEVDgpU7WUpEWAIpl6HYmd0lmmGXsyYkCVRmolgQ9iv9Dt83ZwiQ==
X-Received: by 2002:a53:cd8a:0:b0:628:9b45:5e29 with SMTP id
 956f58d0204a3-633b05f11eamr1084041d50.15.1758108831238; 
 Wed, 17 Sep 2025 04:33:51 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea?
 ([2804:7f0:bcc0:ba1a:8719:7c4c:526a:fdea])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-633b8c8442bsm118972d50.5.2025.09.17.04.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:33:50 -0700 (PDT)
Message-ID: <9f9a3c62-de35-4290-a046-e0928bf67831@ventanamicro.com>
Date: Wed, 17 Sep 2025 08:33:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/5] target/riscv: Integrate SMMPT checks into MMU and
 TLB fill
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <20250909132533.32205-4-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250909132533.32205-4-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yx1-xb12c.google.com
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



On 9/9/25 10:25 AM, LIU Zhiwei wrote:
> With the core MPT lookup logic in place, this patch integrates the
> permission checks into QEMU's main MMU processing functions.
> 
> A new helper, `get_physical_address_mpt`, is introduced to check the
> permissions for a given physical address against the MPT. This helper
> is then called at two critical points:
> 
> 1. During page table walks (`get_physical_address`): The physical
>     address of the Page Table Entry (PTE) itself is checked to ensure
>     the supervisor has permission to read it.
> 
> 2. After successful address translation (`riscv_cpu_tlb_fill`): The final
>     guest-physical address is checked against the MPT before the access
>     is allowed to proceed.
> 
> This ensures that SMMPT protection is enforced for both the translation
> process and the final memory access, as required by the specification.
> 
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu_helper.c | 81 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3479a62cc7..f8ca74ef61 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1089,9 +1089,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>    * @access_type: The type of MMU access
>    * @mode: Indicates current privilege level.
>    */
> -static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> -                                    int size, MMUAccessType access_type,
> -                                    int mode)
> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
> +                             int size, MMUAccessType access_type, int mode)
>   {
>       pmp_priv_t pmp_priv;
>       bool pmp_has_privs;
> @@ -1162,6 +1161,60 @@ static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
>       return !high_bit;
>   }
>   
> +/*
> + * get_physical_address_mpt - check mpt permission for this physical address
> + *
> + * Lookup the Memory Protection Table and check permission for this
> + * physical address. Returns 0 if the permission checking was successful
> + *
> + * @env: CPURISCVState
> + * @prot: The returned protection attributes
> + * @addr: The physical address to be checked permission
> + * @access_type: The type of MMU access
> + * @mode: Indicates current privilege level.
> + */
> +static int get_physical_address_mpt(CPURISCVState *env, int *prot, hwaddr addr,
> +                                    MMUAccessType access_type, int mode)
> +{
> +    mpt_access_t mpt_access;
> +    bool mpt_has_access;
> +
> +    /*
> +     * If the extension is not supported or the mmpt.mode is Bare,
> +     * there is no protection, return success.
> +     */
> +    if (!riscv_cpu_cfg(env)->ext_smmpt || env->mptmode == 0) {
> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return TRANSLATE_SUCCESS;
> +    }
> +
> +    /*
> +     * MPT is checked for all accesses to physical memory, unless the
> +     * effective privilege mode is M.
> +     *
> +     * Data accesses in M-mode when the MPRV bit in mstatus is set and
> +     * the MPP field in mstatus contains S or U are subject to MPT checks.
> +     *
> +     * In riscv_env_mmu_index, The MPRV and MPP bits are already checked and
> +     * encoded to mmu_idx, So we do not need to check it here.
> +     */
> +    if (mode == PRV_M) {
> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return TRANSLATE_SUCCESS;
> +    }
> +
> +    mpt_has_access = smmpt_check_access(env, addr,
> +                                      &mpt_access, access_type);
> +    if (!mpt_has_access) {
> +        *prot = 0;
> +        return TRANSLATE_MPT_FAIL;
> +    }
> +
> +    *prot = smmpt_access_to_page_prot(mpt_access);
> +
> +    return TRANSLATE_SUCCESS;
> +}
> +
>   /*
>    * get_physical_address - get the physical address for this virtual address
>    *
> @@ -1356,6 +1409,13 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>               pte_addr = base + idx * ptesize;
>           }
>   
> +        int mpt_prot;
> +        int mpt_ret = get_physical_address_mpt(env, &mpt_prot, pte_addr,
> +                                               MMU_DATA_LOAD, PRV_S);
> +        if (mpt_ret != TRANSLATE_SUCCESS) {
> +            return TRANSLATE_MPT_FAIL;
> +        }
> +
>           int pmp_prot;
>           int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
>                                                  sxlen_bytes,
> @@ -1766,7 +1826,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       CPURISCVState *env = &cpu->env;
>       vaddr im_address;
>       hwaddr pa = 0;
> -    int prot, prot2, prot_pmp;
> +    int prot, prot2, prot_pmp, mpt_prot;
>       bool pmp_violation = false;
>       bool first_stage_error = true;
>       bool two_stage_lookup = mmuidx_2stage(mmu_idx);
> @@ -1820,6 +1880,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>               prot &= prot2;
>   
>               if (ret == TRANSLATE_SUCCESS) {
> +                ret = get_physical_address_mpt(env, &mpt_prot, pa,
> +                                               access_type, mode);
> +                qemu_log_mask(CPU_LOG_MMU,
> +                              "%s MPT address=" HWADDR_FMT_plx " ret %d prot"
> +                              " %d\n",
> +                              __func__, pa, ret, mpt_prot);
> +                prot &= mpt_prot;
>                   ret = get_physical_address_pmp(env, &prot_pmp, pa,
>                                                  size, access_type, mode);
>                   tlb_size = pmp_get_tlb_size(env, pa);
> @@ -1855,6 +1922,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                         __func__, address, ret, pa, prot);
>   
>           if (ret == TRANSLATE_SUCCESS) {
> +            ret = get_physical_address_mpt(env, &mpt_prot, pa,
> +                                           access_type, mode);
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "%s MPT address=" HWADDR_FMT_plx " ret %d prot %d\n",
> +                          __func__, pa, ret, mpt_prot);
> +            prot &= mpt_prot;
>               ret = get_physical_address_pmp(env, &prot_pmp, pa,
>                                              size, access_type, mode);
>               tlb_size = pmp_get_tlb_size(env, pa);


