Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32592C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 12:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYlgg-00058J-R0; Fri, 17 Jan 2025 07:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYlgS-0004hi-4a
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:42:46 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYlgN-0008Sq-Ju
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:42:42 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so49632755ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 04:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737117757; x=1737722557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6IhwT9AnmVntpnTJLxSMiPQABBMpqMmzbDUZcN2lWss=;
 b=UTsUe9fCxfsY6d/1ghkuoeRjOBwRj6pLIC2WpXQAKP2/cwnoi5xHpCZLiGvJSltCAo
 Wl68QyoKgRTy7tFWn4dk1hUkgdLPsydN/+LaHgUFBiXAKcW6fxR9PVhsN+uQUpiqfjn6
 S9E8wK4Oz33eFl9jFrKgYvNRm0GU8XyVldKT9HMmrp0uR4S/7jWVVEiA69aUGqUBwcHC
 vEe8ITWTJdJlwsSBrTQZ346VR0/ObNSImiBbVU4EdmS2jCw80RiYVDMbVq7K2OpRbdVm
 rMJo+eZ1csskE6+DEfAMoZLcMn6txjgSGLltYMx88+lW9f5mkN8kCFHUJkxx22lQTDNw
 HByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737117757; x=1737722557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6IhwT9AnmVntpnTJLxSMiPQABBMpqMmzbDUZcN2lWss=;
 b=CJ68L0wRd0j67wkeJIserEX5Lc3zeRFLE3mAzBAtBboJgWjb3Lf9Q3uS2pN6trC3rX
 ZOd9GtTdnJV5ZlxWVtzhQCRx5WSK/smvBn18EI/onNnSS8KyqYRARzDRB1VqCiX/MzeE
 CRhnHRWG6QP5xZt7kOdJ8KGNIlR4yhyyPEycZMXHat8hCNtJM+e+CpymfjSz54iG71Ac
 JbnLEXF78QItDoFtfsZU8zzxOBn8wFLubc3ys0rPinVqhsaH/YVBjusBJStqbtnb8HdK
 m79u05+eH6k0As/JX3w/Gz7RFooa1lOqqBcNaHUiFOK26CE9yZWg3RHwFXxs6yKl/4aU
 L4Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWKqTz1BOE8f90RRAN3iy23l2mUESJfgcxSyWXDKMeV8cO52CUoUfq+rzivOuANi66rf8MB0T3wzhY@nongnu.org
X-Gm-Message-State: AOJu0YwUhx9Mdnb+Rvcu75F0C3CcNwnB9DvGHK1VeI8tcpsoiD3SwyIf
 I6AjHr2J2/RZ/GHeU2W6jzDXk0Ozv2YYuQuce2NM2e5HKN6LyW8yCQJCKN6MBbg=
X-Gm-Gg: ASbGnct+5pI4D4u4Hwb558cZNTMINzg9JfwqPDUfThMSy8durWSoeB7z4LliTaDEEl9
 aw47aeVid5TlaLOuWCDgLNusPjOnQNAIks3P65ZtmldiB7sTXbJhF8xRgEhNuI4Mii4bihcj4f8
 Ob7EV3YEo2a0yLn0vgc6K1F0yn0mTGYc+k8J5OceinfB758bFmV6r8/s6EKwpcgjJPuqqb6T6Ae
 c1di9ZaOL+txZBqoZ3tStjgcFo3oFl2o4IttsVxXCAcIYfq9zRl5OPkHeTqKXRhvikRI68=
X-Google-Smtp-Source: AGHT+IGY+qEe9UTn1vbPUKghQmY+PP5LcAa9KG0daTdjWvpAng3qreKYah0TLo1yH4XiiyKMQn6TnA==
X-Received: by 2002:a17:903:186:b0:216:69ca:772a with SMTP id
 d9443c01a7336-21c3563ee3fmr42031205ad.53.1737117757231; 
 Fri, 17 Jan 2025 04:42:37 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2ce9efb9sm15218605ad.45.2025.01.17.04.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 04:42:36 -0800 (PST)
Message-ID: <6e12dd1b-05fc-4094-b422-433ecba27936@ventanamicro.com>
Date: Fri, 17 Jan 2025 09:42:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] target/arm: Constify lot of helpers taking
 CPUARMState argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250116230435.87580-1-philmd@linaro.org>
 <20250116230435.87580-3-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250116230435.87580-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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



On 1/16/25 8:04 PM, Philippe Mathieu-Daudé wrote:
> When methods don't modify the CPUARMState* argument,
> we can mark it const. This allow enforcing places where
> the CPU env shouldn't be modified at all,
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

We should use 'const' more often in general IMO. It forces a better usage and
understanding of our own APIs.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>








> I went via the "modify one and fix until it builds" path,
> and the result seemed trivial enough, but can try to split
> if requested.
> ---
>   target/arm/cpu-features.h |  2 +-
>   target/arm/cpu.h          | 71 ++++++++++++++++++++-------------------
>   target/arm/internals.h    | 10 +++---
>   target/arm/helper.c       | 25 +++++++-------
>   target/arm/ptw.c          |  2 +-
>   target/arm/tcg/m_helper.c |  8 ++---
>   target/arm/vfp_helper.c   |  6 ++--
>   7 files changed, 63 insertions(+), 61 deletions(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 30302d6c5b4..899b2cfb4b1 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1091,6 +1091,6 @@ static inline uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc,
>    * Forward to the above feature tests given an ARMCPU pointer.
>    */
>   #define cpu_isar_feature(name, cpu) \
> -    ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
> +    ({ const ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
>   
>   #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9a6e8e589cc..de54ae6a211 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1267,7 +1267,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm);
>   /* Likewise, but using @sm = PSTATE.SM. */
>   uint32_t sve_vqm1_for_el(CPUARMState *env, int el);
>   
> -static inline bool is_a64(CPUARMState *env)
> +static inline bool is_a64(const CPUARMState *env)
>   {
>       return env->aarch64;
>   }
> @@ -1503,7 +1503,7 @@ static inline unsigned int aarch64_pstate_mode(unsigned int el, bool handler)
>    * interprocessing, so we don't attempt to sync with the cpsr state used by
>    * the 32 bit decoder.
>    */
> -static inline uint32_t pstate_read(CPUARMState *env)
> +static inline uint32_t pstate_read(const CPUARMState *env)
>   {
>       int ZF;
>   
> @@ -1525,7 +1525,7 @@ static inline void pstate_write(CPUARMState *env, uint32_t val)
>   }
>   
>   /* Return the current CPSR value.  */
> -uint32_t cpsr_read(CPUARMState *env);
> +uint32_t cpsr_read(const CPUARMState *env);
>   
>   typedef enum CPSRWriteType {
>       CPSRWriteByInstr = 0,         /* from guest MSR or CPS */
> @@ -1545,7 +1545,7 @@ void cpsr_write(CPUARMState *env, uint32_t val, uint32_t mask,
>                   CPSRWriteType write_type);
>   
>   /* Return the current xPSR value.  */
> -static inline uint32_t xpsr_read(CPUARMState *env)
> +static inline uint32_t xpsr_read(const CPUARMState *env)
>   {
>       int ZF;
>       ZF = (env->ZF == 0);
> @@ -1765,7 +1765,7 @@ QEMU_BUILD_BUG_ON(FPSCR_FPSR_MASK & FPSCR_FPCR_MASK);
>    *
>    * Return the current AArch64 FPSR value
>    */
> -uint32_t vfp_get_fpsr(CPUARMState *env);
> +uint32_t vfp_get_fpsr(const CPUARMState *env);
>   
>   /**
>    * vfp_get_fpcr: read the AArch64 FPCR
> @@ -2445,7 +2445,7 @@ enum arm_features {
>       ARM_FEATURE_BACKCOMPAT_CNTFRQ, /* 62.5MHz timer default */
>   };
>   
> -static inline int arm_feature(CPUARMState *env, int feature)
> +static inline int arm_feature(const CPUARMState *env, int feature)
>   {
>       return (env->features & (1ULL << feature)) != 0;
>   }
> @@ -2486,7 +2486,7 @@ static inline ARMSecuritySpace arm_secure_to_space(bool secure)
>    * an exception return to those levels.  Unlike arm_security_space,
>    * this doesn't care about the current EL.
>    */
> -ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env);
> +ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env);
>   
>   /**
>    * arm_is_secure_below_el3:
> @@ -2495,14 +2495,14 @@ ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env);
>    * Return true if exception levels below EL3 are in secure state,
>    * or would be following an exception return to those levels.
>    */
> -static inline bool arm_is_secure_below_el3(CPUARMState *env)
> +static inline bool arm_is_secure_below_el3(const CPUARMState *env)
>   {
>       ARMSecuritySpace ss = arm_security_space_below_el3(env);
>       return ss == ARMSS_Secure;
>   }
>   
>   /* Return true if the CPU is AArch64 EL3 or AArch32 Mon */
> -static inline bool arm_is_el3_or_mon(CPUARMState *env)
> +static inline bool arm_is_el3_or_mon(const CPUARMState *env)
>   {
>       assert(!arm_feature(env, ARM_FEATURE_M));
>       if (arm_feature(env, ARM_FEATURE_EL3)) {
> @@ -2524,7 +2524,7 @@ static inline bool arm_is_el3_or_mon(CPUARMState *env)
>    *
>    * Return the current security space of the cpu.
>    */
> -ARMSecuritySpace arm_security_space(CPUARMState *env);
> +ARMSecuritySpace arm_security_space(const CPUARMState *env);
>   
>   /**
>    * arm_is_secure:
> @@ -2532,7 +2532,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env);
>    *
>    * Return true if the processor is in secure state.
>    */
> -static inline bool arm_is_secure(CPUARMState *env)
> +static inline bool arm_is_secure(const CPUARMState *env)
>   {
>       return arm_space_is_secure(arm_security_space(env));
>   }
> @@ -2541,7 +2541,7 @@ static inline bool arm_is_secure(CPUARMState *env)
>    * Return true if the current security state has AArch64 EL2 or AArch32 Hyp.
>    * This corresponds to the pseudocode EL2Enabled().
>    */
> -static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
> +static inline bool arm_is_el2_enabled_secstate(const CPUARMState *env,
>                                                  ARMSecuritySpace space)
>   {
>       assert(space != ARMSS_Root);
> @@ -2549,39 +2549,39 @@ static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
>              && (space != ARMSS_Secure || (env->cp15.scr_el3 & SCR_EEL2));
>   }
>   
> -static inline bool arm_is_el2_enabled(CPUARMState *env)
> +static inline bool arm_is_el2_enabled(const CPUARMState *env)
>   {
>       return arm_is_el2_enabled_secstate(env, arm_security_space_below_el3(env));
>   }
>   
>   #else
> -static inline ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
> +static inline ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)
>   {
>       return ARMSS_NonSecure;
>   }
>   
> -static inline bool arm_is_secure_below_el3(CPUARMState *env)
> +static inline bool arm_is_secure_below_el3(const CPUARMState *env)
>   {
>       return false;
>   }
>   
> -static inline ARMSecuritySpace arm_security_space(CPUARMState *env)
> +static inline ARMSecuritySpace arm_security_space(const CPUARMState *env)
>   {
>       return ARMSS_NonSecure;
>   }
>   
> -static inline bool arm_is_secure(CPUARMState *env)
> +static inline bool arm_is_secure(const CPUARMState *env)
>   {
>       return false;
>   }
>   
> -static inline bool arm_is_el2_enabled_secstate(CPUARMState *env,
> +static inline bool arm_is_el2_enabled_secstate(const CPUARMState *env,
>                                                  ARMSecuritySpace space)
>   {
>       return false;
>   }
>   
> -static inline bool arm_is_el2_enabled(CPUARMState *env)
> +static inline bool arm_is_el2_enabled(const CPUARMState *env)
>   {
>       return false;
>   }
> @@ -2593,12 +2593,13 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
>    * "for all purposes other than a direct read or write access of HCR_EL2."
>    * Not included here is HCR_RW.
>    */
> -uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
> -uint64_t arm_hcr_el2_eff(CPUARMState *env);
> -uint64_t arm_hcrx_el2_eff(CPUARMState *env);
> +uint64_t arm_hcr_el2_eff_secstate(const CPUARMState *env,
> +                                  ARMSecuritySpace space);
> +uint64_t arm_hcr_el2_eff(const CPUARMState *env);
> +uint64_t arm_hcrx_el2_eff(const CPUARMState *env);
>   
>   /* Return true if the specified exception level is running in AArch64 state. */
> -static inline bool arm_el_is_aa64(CPUARMState *env, int el)
> +static inline bool arm_el_is_aa64(const CPUARMState *env, int el)
>   {
>       /* This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
>        * and if we're not in EL0 then the state of EL0 isn't well defined.)
> @@ -2637,7 +2638,7 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
>    * it doesn't exist at all) then there is no register banking, and all
>    * accesses are to the non-secure version.
>    */
> -static inline bool access_secure_reg(CPUARMState *env)
> +static inline bool access_secure_reg(const CPUARMState *env)
>   {
>       bool ret = (arm_feature(env, ARM_FEATURE_EL3) &&
>                   !arm_el_is_aa64(env, 3) &&
> @@ -2677,7 +2678,7 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
>                                    uint32_t cur_el, bool secure);
>   
>   /* Return the highest implemented Exception Level */
> -static inline int arm_highest_el(CPUARMState *env)
> +static inline int arm_highest_el(const CPUARMState *env)
>   {
>       if (arm_feature(env, ARM_FEATURE_EL3)) {
>           return 3;
> @@ -2689,7 +2690,7 @@ static inline int arm_highest_el(CPUARMState *env)
>   }
>   
>   /* Return true if a v7M CPU is in Handler mode */
> -static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
> +static inline bool arm_v7m_is_handler_mode(const CPUARMState *env)
>   {
>       return env->v7m.exception != 0;
>   }
> @@ -2697,7 +2698,7 @@ static inline bool arm_v7m_is_handler_mode(CPUARMState *env)
>   /* Return the current Exception Level (as per ARMv8; note that this differs
>    * from the ARMv7 Privilege Level).
>    */
> -static inline int arm_current_el(CPUARMState *env)
> +static inline int arm_current_el(const CPUARMState *env)
>   {
>       if (arm_feature(env, ARM_FEATURE_M)) {
>           return arm_v7m_is_handler_mode(env) ||
> @@ -3004,7 +3005,7 @@ static inline ARMSecuritySpace arm_phys_to_space(ARMMMUIdx idx)
>       return idx - ARMMMUIdx_Phys_S;
>   }
>   
> -static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
> +static inline bool arm_v7m_csselr_razwi(const ARMCPU *cpu)
>   {
>       /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
>        * CSSELR is RAZ/WI.
> @@ -3012,7 +3013,7 @@ static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
>       return (cpu->clidr & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
>   }
>   
> -static inline bool arm_sctlr_b(CPUARMState *env)
> +static inline bool arm_sctlr_b(const CPUARMState *env)
>   {
>       return
>           /* We need not implement SCTLR.ITD in user-mode emulation, so
> @@ -3025,9 +3026,9 @@ static inline bool arm_sctlr_b(CPUARMState *env)
>           (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
>   }
>   
> -uint64_t arm_sctlr(CPUARMState *env, int el);
> +uint64_t arm_sctlr(const CPUARMState *env, int el);
>   
> -static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
> +static inline bool arm_cpu_data_is_big_endian_a32(const CPUARMState *env,
>                                                     bool sctlr_b)
>   {
>   #ifdef CONFIG_USER_ONLY
> @@ -3057,7 +3058,7 @@ static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
>   }
>   
>   /* Return true if the processor is in big-endian mode. */
> -static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
> +static inline bool arm_cpu_data_is_big_endian(const CPUARMState *env)
>   {
>       if (!is_a64(env)) {
>           return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
> @@ -3219,7 +3220,7 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
>    *
>    * Return the VL cached within env->hflags, in units of quadwords.
>    */
> -static inline int sve_vq(CPUARMState *env)
> +static inline int sve_vq(const CPUARMState *env)
>   {
>       return EX_TBFLAG_A64(env->hflags, VL) + 1;
>   }
> @@ -3230,7 +3231,7 @@ static inline int sve_vq(CPUARMState *env)
>    *
>    * Return the SVL cached within env->hflags, in units of quadwords.
>    */
> -static inline int sme_vq(CPUARMState *env)
> +static inline int sme_vq(const CPUARMState *env)
>   {
>       return EX_TBFLAG_A64(env->hflags, SVL) + 1;
>   }
> @@ -3252,7 +3253,7 @@ static inline bool bswap_code(bool sctlr_b)
>   }
>   
>   #ifdef CONFIG_USER_ONLY
> -static inline bool arm_cpu_bswap_data(CPUARMState *env)
> +static inline bool arm_cpu_bswap_data(const CPUARMState *env)
>   {
>       return TARGET_BIG_ENDIAN ^ arm_cpu_data_is_big_endian(env);
>   }
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 863a84edf81..06155816ab4 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -832,7 +832,7 @@ static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
>   int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
>   
>   /* Return the MMU index for a v7M CPU in the specified security state */
> -ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
> +ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate);
>   
>   /*
>    * Return true if the stage 1 translation regime is using LPAE
> @@ -1189,7 +1189,7 @@ void arm_cpu_update_vserr(ARMCPU *cpu);
>    *
>    * Return the full ARMMMUIdx for the translation regime for EL.
>    */
> -ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
> +ARMMMUIdx arm_mmu_idx_el(const CPUARMState *env, int el);
>   
>   /**
>    * arm_mmu_idx:
> @@ -1197,7 +1197,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el);
>    *
>    * Return the full ARMMMUIdx for the current translation regime.
>    */
> -ARMMMUIdx arm_mmu_idx(CPUARMState *env);
> +ARMMMUIdx arm_mmu_idx(const CPUARMState *env);
>   
>   /**
>    * arm_stage1_mmu_idx:
> @@ -1210,13 +1210,13 @@ static inline ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
>   {
>       return ARMMMUIdx_Stage1_E0;
>   }
> -static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
> +static inline ARMMMUIdx arm_stage1_mmu_idx(const CPUARMState *env)
>   {
>       return ARMMMUIdx_Stage1_E0;
>   }
>   #else
>   ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx);
> -ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
> +ARMMMUIdx arm_stage1_mmu_idx(const CPUARMState *env);
>   #endif
>   
>   /**
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 63997678513..cf11a8c7736 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -264,7 +264,7 @@ void init_cpreg_list(ARMCPU *cpu)
>       g_list_free(keys);
>   }
>   
> -static bool arm_pan_enabled(CPUARMState *env)
> +static bool arm_pan_enabled(const CPUARMState *env)
>   {
>       if (is_a64(env)) {
>           if ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1)) {
> @@ -5229,7 +5229,8 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
>    * Bits that are not included here:
>    * RW       (read from SCR_EL3.RW as needed)
>    */
> -uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
> +uint64_t arm_hcr_el2_eff_secstate(const CPUARMState *env,
> +                                  ARMSecuritySpace space)
>   {
>       uint64_t ret = env->cp15.hcr_el2;
>   
> @@ -5294,7 +5295,7 @@ uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space)
>       return ret;
>   }
>   
> -uint64_t arm_hcr_el2_eff(CPUARMState *env)
> +uint64_t arm_hcr_el2_eff(const CPUARMState *env)
>   {
>       if (arm_feature(env, ARM_FEATURE_M)) {
>           return 0;
> @@ -5396,7 +5397,7 @@ static const ARMCPRegInfo hcrx_el2_reginfo = {
>   };
>   
>   /* Return the effective value of HCRX_EL2.  */
> -uint64_t arm_hcrx_el2_eff(CPUARMState *env)
> +uint64_t arm_hcrx_el2_eff(const CPUARMState *env)
>   {
>       /*
>        * The bits in this register behave as 0 for all purposes other than
> @@ -5411,7 +5412,7 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
>        */
>       if (!arm_is_el2_enabled(env)) {
>           uint64_t hcrx = 0;
> -        if (cpu_isar_feature(aa64_mops, env_archcpu(env))) {
> +        if (cpu_isar_feature(aa64_mops, const_env_archcpu(env))) {
>               /* MSCEn behaves as 1 if EL2 is not enabled */
>               hcrx |= HCRX_MSCEN;
>           }
> @@ -9333,7 +9334,7 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
>       }
>   }
>   
> -uint32_t cpsr_read(CPUARMState *env)
> +uint32_t cpsr_read(const CPUARMState *env)
>   {
>       int ZF;
>       ZF = (env->ZF == 0);
> @@ -10703,7 +10704,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   
> -uint64_t arm_sctlr(CPUARMState *env, int el)
> +uint64_t arm_sctlr(const CPUARMState *env, int el)
>   {
>       /* Only EL0 needs to be adjusted for EL1&0 or EL2&0 or EL3&0 */
>       if (el == 0) {
> @@ -11127,7 +11128,7 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
>   }
>   #endif
>   
> -ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
> +ARMMMUIdx arm_mmu_idx_el(const CPUARMState *env, int el)
>   {
>       ARMMMUIdx idx;
>       uint64_t hcr;
> @@ -11180,7 +11181,7 @@ ARMMMUIdx arm_mmu_idx_el(CPUARMState *env, int el)
>       return idx;
>   }
>   
> -ARMMMUIdx arm_mmu_idx(CPUARMState *env)
> +ARMMMUIdx arm_mmu_idx(const CPUARMState *env)
>   {
>       return arm_mmu_idx_el(env, arm_current_el(env));
>   }
> @@ -11412,7 +11413,7 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
>   #endif
>   
>   #ifndef CONFIG_USER_ONLY
> -ARMSecuritySpace arm_security_space(CPUARMState *env)
> +ARMSecuritySpace arm_security_space(const CPUARMState *env)
>   {
>       if (arm_feature(env, ARM_FEATURE_M)) {
>           return arm_secure_to_space(env->v7m.secure);
> @@ -11429,7 +11430,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env)
>       /* Check for AArch64 EL3 or AArch32 Mon. */
>       if (is_a64(env)) {
>           if (extract32(env->pstate, 2, 2) == 3) {
> -            if (cpu_isar_feature(aa64_rme, env_archcpu(env))) {
> +            if (cpu_isar_feature(aa64_rme, const_env_archcpu(env))) {
>                   return ARMSS_Root;
>               } else {
>                   return ARMSS_Secure;
> @@ -11444,7 +11445,7 @@ ARMSecuritySpace arm_security_space(CPUARMState *env)
>       return arm_security_space_below_el3(env);
>   }
>   
> -ARMSecuritySpace arm_security_space_below_el3(CPUARMState *env)
> +ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)
>   {
>       assert(!arm_feature(env, ARM_FEATURE_M));
>   
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 64bb6878a48..613d13b50be 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -158,7 +158,7 @@ ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
>       }
>   }
>   
> -ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
> +ARMMMUIdx arm_stage1_mmu_idx(const CPUARMState *env)
>   {
>       return stage_1_mmu_idx(arm_mmu_idx(env));
>   }
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index f7354f3c6e0..2c792928944 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -156,14 +156,14 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
>       return 0;
>   }
>   
> -ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
> +ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate)
>   {
>       return ARMMMUIdx_MUser;
>   }
>   
>   #else /* !CONFIG_USER_ONLY */
>   
> -static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
> +static ARMMMUIdx arm_v7m_mmu_idx_all(const CPUARMState *env,
>                                        bool secstate, bool priv, bool negpri)
>   {
>       ARMMMUIdx mmu_idx = ARM_MMU_IDX_M;
> @@ -183,7 +183,7 @@ static ARMMMUIdx arm_v7m_mmu_idx_all(CPUARMState *env,
>       return mmu_idx;
>   }
>   
> -static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
> +static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(const CPUARMState *env,
>                                                          bool secstate, bool priv)
>   {
>       bool negpri = armv7m_nvic_neg_prio_requested(env->nvic, secstate);
> @@ -192,7 +192,7 @@ static ARMMMUIdx arm_v7m_mmu_idx_for_secstate_and_priv(CPUARMState *env,
>   }
>   
>   /* Return the MMU index for a v7M CPU in the specified security state */
> -ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
> +ARMMMUIdx arm_v7m_mmu_idx_for_secstate(const CPUARMState *env, bool secstate)
>   {
>       bool priv = arm_v7m_is_handler_mode(env) ||
>           !(env->v7m.control[secstate] & 1);
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index fc20a567530..f1bb86832f9 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -59,7 +59,7 @@ static inline int vfp_exceptbits_from_host(int host_bits)
>       return target_bits;
>   }
>   
> -static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
> +static uint32_t vfp_get_fpsr_from_host(const CPUARMState *env)
>   {
>       uint32_t i;
>   
> @@ -132,7 +132,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val, uint32_t mask)
>   
>   #else
>   
> -static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
> +static uint32_t vfp_get_fpsr_from_host(const CPUARMState *env)
>   {
>       return 0;
>   }
> @@ -162,7 +162,7 @@ uint32_t vfp_get_fpcr(CPUARMState *env)
>       return fpcr;
>   }
>   
> -uint32_t vfp_get_fpsr(CPUARMState *env)
> +uint32_t vfp_get_fpsr(const CPUARMState *env)
>   {
>       uint32_t fpsr = env->vfp.fpsr;
>       uint32_t i;


