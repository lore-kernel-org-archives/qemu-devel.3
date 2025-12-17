Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F9CD66B86
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwdg-0005pa-6l; Wed, 17 Dec 2025 13:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwdL-0005nR-Ei
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:52:23 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVwdJ-0005FA-AO
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:52:23 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso47060505ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765997534; x=1766602334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AVdEp4mpT1E59xpkC2vm4GpVRC7IE4+bfaZnrGctLBc=;
 b=skLqYR+2v7GB+HwCReFJkGjtbChrSs6Ph4pBj4jx5GRU29bazQCn14RyZhkmMG1E85
 Ck3FvnrfhjgoAoi7BSrxDUApj6cTTi2ufxH+6gI8M3mxHOmFOMPpJLeJDtUJcHqEPZZK
 nEVFS+o9YyJmDevhVUSCYNN8XEK6oTFIMp4ZDK6/J2Qm3SnOYpXkXBBfg0qWZ9/QTcRH
 FPA4fk8dgRvcsnO4o0yvfkoxjLJZSHu17Z4oTdqIua0eZj3dbscr74ZLuo2CKYh6SvSo
 b+NKe+hr3WPAYV/e7IObxL8y2ls6l0BjQ46wfkmLcNBEggE/mPeNGpU3/GJqMKXKA7PH
 ZRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765997534; x=1766602334;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AVdEp4mpT1E59xpkC2vm4GpVRC7IE4+bfaZnrGctLBc=;
 b=dVQMO+RGrhe8/UTOFA/rqIrKdeA8Iafu7kTR5lhovJ2T0ANaH8+KUZhCpfIkdqfoKy
 c1G7fSb3m/Isvh8tWH1Y5fQqDymAKFY+wucjywYimY5eyuC5vkmf2/W08IKSh5ULW1lv
 6KTCjSoc1uygkPymXEEWtVpHFwnI8dvzwx9YqDcvosRKgLlcgdgRm8L9ob4iwloli2zU
 b93ZxdgumFx3PCBzFwJgjLzSIr+lIyPxl9d1Y9GrSGhkaDGc8syRTyky1rywA7gfZI+9
 8O/UU07alChj+/hAvbO2cZzYGc2hV/r21HNTi0N28B6PYmL/HwC83QQ+xP69nXhcOy5K
 mDZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUai8/E00iOMBVbFMVH5iAAwDUpuJWP0m8ZNxLoxKHCBFYtqy4YcKX1BFJB8Y38MBGsJwEwNo0ZfG+@nongnu.org
X-Gm-Message-State: AOJu0YyjCqSP5Iu13HmGSw7BKKwVWbNzmgHoPkY4tMKLyt5QSAqjDiRf
 f4xcQm+OhGL566swqVZ2YpDRwLbFaCw6ms953psmloxTNdDk2FX4opMbk3+OtFrudpZsAxa6x4W
 CJJ+9/mw=
X-Gm-Gg: AY/fxX4C+Fh/ucmn9j5dc99kIL0e9lZUcsmXCy3Jg0x28e5QdrRftYA/yxxIzZ1t3Pr
 WC4YeduK4arFJzWQRzWayezuNI7Qx5wO32FzMFst9HpTKddD085OW3c861ZLSjJQgsKKD79Aq6N
 pqo4aWhYXT+AdyyWvB24Pr8FuOqSYDIwoJY+XbqJnXFJmdz7ZxTllg4FIGUvAMUnMypdppnKUbG
 rGBtwgeWoQNnzZZEJXnXdIVpDvStmBvufqQLDk7Ii578IxGkkFcR+gH4FGkcwZADHpdRkuhL4xs
 eYCLsiWrusBQS5EhPZaKt7BT/iN/j3ZmuQpbLEXt7JatC35MfBZtCjAwmvDhfu5G2hSXZMyyGBz
 dVyfwFTQYw0ampDtv1XoMhfCxz7CLhenvIKM27pIoKHwmtrj/FL88rzeMusrXwdpVjV7Snl/pjM
 PMfcD0JEJC/w7pdOaFKXzawxpAhoHZAA==
X-Google-Smtp-Source: AGHT+IH7fiESJQ4m2cvicQ1gZw+RrnvQqyFhYO0OWK8RBUhHZUBMEVpOVVLTd97TxNxr7u+uVyzowg==
X-Received: by 2002:a17:903:1aa5:b0:297:c048:fb60 with SMTP id
 d9443c01a7336-29f23e54506mr198482645ad.25.1765997534231; 
 Wed, 17 Dec 2025 10:52:14 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d16127b8sm421535ad.52.2025.12.17.10.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:52:13 -0800 (PST)
Message-ID: <f2c0144b-62fa-4ffe-be2c-82b0aff7a72f@linaro.org>
Date: Thu, 18 Dec 2025 05:52:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/arm/ptw: make granule_protection_check
 usable without a cpu
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eric.auger@redhat.com>
References: <20251216000122.763264-1-pierrick.bouvier@linaro.org>
 <20251216000122.763264-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251216000122.763264-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 12/16/25 11:01, Pierrick Bouvier wrote:
> By removing cpu details and use a config struct, we can use the
> same granule_protection_check with other devices, like SMMU.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h | 34 ++++++++++++++++++++++++++++
>   target/arm/ptw.c | 59 +++++++++++++++++++++++++++++++-----------------
>   2 files changed, 72 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index efbef0341da..5752e1f58fb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1216,6 +1216,40 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
>   
>   hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>                                            MemTxAttrs *attrs);
> +
> +typedef struct ARMGranuleProtectionConfig {
> +    /* GPCCR_EL3 */
> +    uint64_t gpccr;
> +    /* GPTBR_EL3 */
> +    uint64_t gptbr;
> +    /* ID_AA64MMFR0_EL1.PARange */
> +    uint8_t parange;
> +    /* FEAT_SEL2 */
> +    bool support_sel2;
> +    /* Address space to access Granule Protection Table */
> +    AddressSpace *gpt_as;
> +} ARMGranuleProtectionConfig;
> +
> +/**
> + * arm_granule_protection_check
> + * @config: granule protection configuration
> + * @paddress: address accessed
> + * @pspace: physical address space accessed
> + * @ss: security state for access
> + * @fi: fault information in case a fault is detected
> + *
> + * Checks if @paddress can be accessed in physical adress space @pspace
> + * for @ss secure state, following granule protection setup with @config.
> + * If a fault is detected, @fi is set accordingly.
> + * See GranuleProtectionCheck() in A-profile manual.
> + *
> + * Returns: true if access is authorized, else false.
> + */
> +bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
> +                                  uint64_t paddress,
> +                                  ARMSecuritySpace pspace,
> +                                  ARMSecuritySpace ss,
> +                                  ARMMMUFaultInfo *fi);
>   #endif /* !CONFIG_USER_ONLY */
>   
>   int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 2e6b149b2d1..cdc14b1735b 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -330,26 +330,26 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
>       return (regime_sctlr(env, mmu_idx) & SCTLR_M) == 0;
>   }
>   
> -static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
> -                                     ARMSecuritySpace pspace,
> -                                     ARMSecuritySpace ss,
> -                                     ARMMMUFaultInfo *fi)
> +bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
> +                                  uint64_t paddress,
> +                                  ARMSecuritySpace pspace,
> +                                  ARMSecuritySpace ss,
> +                                  ARMMMUFaultInfo *fi)
>   {
>       MemTxAttrs attrs = {
>           .secure = true,
>           .space = ARMSS_Root,
>       };
> -    ARMCPU *cpu = env_archcpu(env);
> -    uint64_t gpccr = env->cp15.gpccr_el3;
> +    const uint64_t gpccr = config.gpccr;
>       unsigned pps, pgs, l0gptsz, level = 0;
>       uint64_t tableaddr, pps_mask, align, entry, index;
> -    AddressSpace *as;
>       MemTxResult result;
>       int gpi;
>   
> -    if (!FIELD_EX64(gpccr, GPCCR, GPC)) {
> -        return true;
> -    }
> +    /*
> +     * We assume Granule Protection Check is enabled when
> +     * calling this function (GPCCR.GPC == 1).
> +     */
>   
>       /*
>        * GPC Priority 1 (R_GMGRR):
> @@ -362,7 +362,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>        * physical address size is invalid.
>        */
>       pps = FIELD_EX64(gpccr, GPCCR, PPS);
> -    if (pps > FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE)) {
> +    if (pps > config.parange) {
>           goto fault_walk;
>       }
>       pps = pamax_map[pps];
> @@ -432,7 +432,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>       }
>   
>       /* GPC Priority 4: the base address of GPTBR_EL3 exceeds PPS. */
> -    tableaddr = env->cp15.gptbr_el3 << 12;
> +    tableaddr = config.gptbr << 12;
>       if (tableaddr & ~pps_mask) {
>           goto fault_size;
>       }
> @@ -446,12 +446,10 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>       align = MAKE_64BIT_MASK(0, align);
>       tableaddr &= ~align;
>   
> -    as = arm_addressspace(env_cpu(env), attrs);
> -
>       /* Level 0 lookup. */
>       index = extract64(paddress, l0gptsz, pps - l0gptsz);
>       tableaddr += index * 8;
> -    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
> +    entry = address_space_ldq_le(config.gpt_as, tableaddr, attrs, &result);
>       if (result != MEMTX_OK) {
>           goto fault_eabt;
>       }
> @@ -479,7 +477,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>       level = 1;
>       index = extract64(paddress, pgs + 4, l0gptsz - pgs - 4);
>       tableaddr += index * 8;
> -    entry = address_space_ldq_le(as, tableaddr, attrs, &result);
> +    entry = address_space_ldq_le(config.gpt_as, tableaddr, attrs, &result);
>       if (result != MEMTX_OK) {
>           goto fault_eabt;
>       }
> @@ -513,7 +511,7 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
>       case 0b1111: /* all access */
>           return true;
>       case 0b1000: /* secure */
> -        if (!cpu_isar_feature(aa64_sel2, cpu)) {
> +        if (!config.support_sel2) {
>               goto fault_walk;
>           }
>           /* fall through */
> @@ -3786,11 +3784,30 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
>                               memop, result, fi)) {
>           return true;
>       }
> -    if (!granule_protection_check(env, result->f.phys_addr,
> -                                  result->f.attrs.space, ptw->in_space, fi)) {
> -        fi->type = ARMFault_GPCFOnOutput;
> -        return true;
> +
> +    const uint64_t gpccr = env->cp15.gpccr_el3;
> +    const bool gpc_enabled = FIELD_EX64(gpccr, GPCCR, GPC);
> +    if (gpc_enabled) {
> +        ARMCPU *cpu = env_archcpu(env);
> +        MemTxAttrs attrs = {
> +            .secure = true,
> +            .space = ARMSS_Root,
> +        };
> +        struct ARMGranuleProtectionConfig config = {
> +            .gpccr = env->cp15.gpccr_el3,
> +            .gptbr = env->cp15.gptbr_el3,
> +            .parange = FIELD_EX64_IDREG(&cpu->isar, ID_AA64MMFR0, PARANGE),
> +            .support_sel2 = cpu_isar_feature(aa64_sel2, cpu),
> +            .gpt_as = arm_addressspace(env_cpu(env), attrs)
> +        };
> +        if (!arm_granule_protection_check(config, result->f.phys_addr,
> +                                          result->f.attrs.space, ptw->in_space,
> +                                          fi)) {
> +            fi->type = ARMFault_GPCFOnOutput;
> +            return true;
> +        }
>       }
> +
>       return false;
>   }
>   


