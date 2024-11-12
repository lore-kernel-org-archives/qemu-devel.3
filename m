Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CE4D32D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 12:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAqO5-0002L3-FB; Tue, 12 Nov 2024 07:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAqO3-0002Kf-Ee
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:52:51 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAqO0-0001QA-Lb
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 07:52:51 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20ca1b6a80aso60311865ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 04:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731415966; x=1732020766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MptEZjcrsnaEHxB1AuaEJOiLzKYeAZFOPQUUaBDxNM=;
 b=N4t5CZNhd82qr80aK4KahtS06vxG7z7Te7HqjQRBiSnD95iLyFC/ZxM5Ej9c6Ohaxq
 jMq6Q47V1kQaduvxgoCzR64zBr68vyXdZ9nvxEh5NGUOJJdNFripHPcWGA1YlG+7FYmW
 y6G/FcTk0W1oGXFvCML75gxpuMo5rLEK/TJZXAFxgpa13aAZv98pigCLXFEfm3E1xicH
 2aGLhUM7FjqDAoHnE4A4Oxr0zBhvrgu7Vxyc5uwz6W9UVNS5B+VrXQslD92+itm27Zbm
 qXv4MnOz33UBT+27KHYrLMTfdQJrJRYSDwB6rLudlVDyJfKJVgMrNr8NO9smUht/K03m
 C7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731415966; x=1732020766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MptEZjcrsnaEHxB1AuaEJOiLzKYeAZFOPQUUaBDxNM=;
 b=LIO/yGMEtZqPVzgGECFhfVKKZfiOOSOEngoEjAssrvIa0WJZybslX2bqQoxh5ZxbxB
 wKDxy1DJss/c0jXZ/91CAQrwEGKgqCkT964qmpZoYdb/kdaXZkgTSdbfkwDLXjyP9++o
 /zGXWGR/SogJN3g1oiwO85GI4rEmCY0ieX71SmzNgXsXKxCt0vjyvY2f6RNguc/OWo1P
 +ZN1D+KTASy3Ev3tX/AJgAAcy8Fvie6Bt9oqm5m9dptm9kZp34b/46EWKpUmFR9GKJ8w
 ZIDn/7kaIq48H2/dCYtbgb8O8XgDEFIRe08IVtkMGdjOjv5mOIBdM0sBudU7Co8H7ZUG
 OMww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhuAfy0qvzmmj+sOrUcEZTQNuEzLOrEANOiJfi5iOktOJmTzua0GPVGyxsduKbceNj3puBKp87eL+m@nongnu.org
X-Gm-Message-State: AOJu0YwuT4wLuuOXpm+Ei85GozTBAa8tly5LpH0bpLMbnWzjl9AsXzNM
 LT/h/0o5FrVa89IpqdXAETzpqv/Kzr6qNW1lHhnJqhZZHbBJw1DeFZxsIsM6eKQ=
X-Google-Smtp-Source: AGHT+IHu3m9oXggas9+wwdfNZSMwKcKIkLkSUZII90siDNVmGJneHWKTySTqij0B4POevZNmpJluCA==
X-Received: by 2002:a17:902:cec1:b0:20c:8763:b3f7 with SMTP id
 d9443c01a7336-21183ca7259mr235748305ad.17.1731415966502; 
 Tue, 12 Nov 2024 04:52:46 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e85419sm92129215ad.273.2024.11.12.04.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 04:52:46 -0800 (PST)
Message-ID: <980f6830-8fa1-41d2-997f-ed16fdfb7557@ventanamicro.com>
Date: Tue, 12 Nov 2024 09:52:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] target/riscv: Check memory access to meet svukte
 rule
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-5-fea.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241112091423.2529583-5-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
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



On 11/12/24 6:14 AM, Fea.Wang wrote:
> Follow the Svukte spec, do the memory access address checking
> 
> 1. Include instruction fetches or explicit memory accesses
> 2. System run in effective privilege U or VU
> 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
> instruction is HLV, HLVX, HSV and execute from U mode to VU mode
> 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
> 5. Raises a page-fault exception corresponding to the original access
> type.
> 
> Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> ---
>   target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69ea..5b29344c4f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -857,6 +857,61 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>       return TRANSLATE_SUCCESS;
>   }
>   
> +/* Returns 'true' if a svukte address check is needed */
> +static bool do_svukte_check(CPURISCVState *env, bool first_stage,
> +                             int mode, bool virt)
> +{
> +    bool ukte;
> +
> +    /* Svukte extension depends on Sv39. */
> +    if (!(env_archcpu(env)->cfg.ext_svukte ||
> +        !first_stage ||
> +        VM_1_10_SV39 != get_field(env->satp, SATP64_MODE))) {
> +        return false;
> +    }
> +
> +    /*
> +     * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
> +     * executing HLV/HLVX/HSV in U-mode.
> +     * For other cases, check senvcfg.UKTE.
> +     */
> +    if (env->priv == PRV_U && !env->virt_enabled && virt) {
> +        ukte = !!(env->hstatus & HSTATUS_HUKTE);
> +    } else {
> +        ukte = !!(env->senvcfg & SENVCFG_UKTE);
> +    }
> +
> +    if (!ukte) {
> +        return false;
> +    }
> +
> +    /*
> +     * Svukte extension is qualified only in U or VU-mode.
> +     *
> +     * Effective mode can be switched to U or VU-mode by:
> +     *   - M-mode + mstatus.MPRV=1 + mstatus.MPP=U-mode.
> +     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=0.
> +     *   - U-mode.
> +     *   - VU-mode.
> +     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=1.
> +     */
> +    if (mode != PRV_U) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
> +{
> +    uint32_t sxl = riscv_cpu_sxl(env);
> +    sxl = (sxl == 0) ? MXL_RV32 : sxl;
> +    uint32_t sxlen = 32 * sxl;
> +    uint64_t high_bit = addr & (1UL << (sxlen - 1));
> +
> +    return !high_bit;
> +}
> +
>   /*
>    * get_physical_address - get the physical address for this virtual address
>    *
> @@ -894,6 +949,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       MemTxResult res;
>       MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       int mode = mmuidx_priv(mmu_idx);
> +    bool virt = mmuidx_2stage(mmu_idx);
>       bool use_background = false;
>       hwaddr ppn;
>       int napot_bits = 0;
> @@ -901,6 +957,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
>       bool sstack_page = false;
>   
> +    if (do_svukte_check(env, first_stage, mode, virt) &&
> +        !check_svukte_addr(env, addr)) {
> +        return TRANSLATE_FAIL;
> +    }
> +
>       /*
>        * Check if we should use the background registers for the two
>        * stage translation. We don't need to check if we actually need


