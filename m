Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA917C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 18:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZZH6-0008Kn-4j; Wed, 09 Jul 2025 14:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZZH3-0008GQ-GX
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:12:05 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZZH1-0005EF-Cf
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 14:12:05 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ef8df09ce9so100896fac.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752084721; x=1752689521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xVL6so1Zor4yB1ctCdOrVPtIytuMOBaIFdUxfXoGlc=;
 b=CF3Bc0fSCz/FLNyyAeuDrZzTRAq+De7xMXZLVwNkQy7JZEUpYvV8lF+YA79QnS8FMt
 JNYSSY2mT+DHAZvQPrdw1zZU062yX/CiCh7cgmFvHUNFVCjxyVuAsVgqj/VkfAAAYTaf
 CcOxGEKNDq83banTWM8TWSDmrDNZYER6P71NVUjw1CHI8SykWAQHct/NyQnU6IPJ2oWw
 aRRRfCtNyx7poS7XW7fQcStGWiQnl3dssk3DF8Xv36A+mYp8YiSch7bXmfqN4HSqriT1
 f2wVFBYiiysNyYB/QOmHSWU+Yk2wYu12TeFHWo/T9T3TBQiqNDk4QIpTdbgjPfmI7o61
 VjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752084721; x=1752689521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xVL6so1Zor4yB1ctCdOrVPtIytuMOBaIFdUxfXoGlc=;
 b=SZRQAFgbA21oUr8873EBT2GVHq7rs/HyCk9tnNJ/xKl6XU3J4pZyE09QSyggxnfg3G
 2NSF65bPFV2u5SnBMiQpxS//FLQzrfVmWw+uYEG3Tq0KgMHgQn0Oq45Iamw6w5FOTqgJ
 FFpMPb1mnM9vTTxlLnhCDZ1FfYzlW6h5h6SxPVoVTpShe2azggiiARAakx+ggej8R5cX
 LH2527V15h8hxbp1l2dRATz5cl1d7uZkbgSJtPNDvjAyXt+xCR/lKjJi+QJWZ9JbYeaF
 HCU7JK1Z480H32ra45oAu1PgJXUh0HPRUyYH0699kkB3ppBm89mG1e1KBQ8KDgfRpE7U
 H5FA==
X-Gm-Message-State: AOJu0YxxT9oGFOENiv2b/CmxrU/7xPZqYwkBO30rzAo8axAVZkeLbqeQ
 taw7Q5PWi/WiH+3dYWPE7F3oWeb1Mxky/Avd362NVcoOvf1VoRRAWbCQCcGcid7iPm0=
X-Gm-Gg: ASbGncvR2zjoZN8Ha2rdUimweLC1J4ina/5kIz1FhCklaxZlNtsTursjgc+yEVldPDC
 C6PUwMx/BZlkY6PDpCAlOBi7wV7JPlyDYKtKlRMd5gAokcCirNyl9kmNT1sbL99lBrOYHorAIZw
 xjoC88k+eW+zvF0EuhL/YQe8qYLJn39Xh57PxtokH+WvI6wNzquTWdwLT8Xx2g9Is++s/HTgY+O
 rfbKSIipN35p2/AiogWe6/c6TYNJ4M8XBZbrBAoKuchZ3KLzRP3ut1Qe2QEKau7EFPV/LZSbNwJ
 Wna/nLE3XUxrUTYc0SL1AvN+SlhtRH/8P3Igb5ilEtT8jJ4NoEQeWj466BA8OAgV26FKTxfhK8Y
 2Kxs=
X-Google-Smtp-Source: AGHT+IGyd3en96OIkbMggg51XMBzoltA1AhTVptgw8buhWFEbzMweVMq5e7S6IaJBn63ZQaAwMVtMQ==
X-Received: by 2002:a05:6870:6b0b:b0:29e:48d6:2e62 with SMTP id
 586e51a60fabf-2fef84bdef1mr2797960fac.9.1752084721300; 
 Wed, 09 Jul 2025 11:12:01 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f79020d10esm3582298fac.38.2025.07.09.11.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 11:12:00 -0700 (PDT)
Message-ID: <ddad508e-fbf2-44af-bb4a-481a39749bc2@linaro.org>
Date: Wed, 9 Jul 2025 12:11:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v3 3/5] target/arm: Add FEAT_SCTLR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250708191704.1068604-1-gustavo.romero@linaro.org>
 <20250708191704.1068604-4-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708191704.1068604-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 7/8/25 13:17, Gustavo Romero wrote:
> Add FEAT_SCTLR2, which introduces the SCTLR2_EL1, SCTLR2_EL2, and
> SCTLR2_EL3 registers. These registers are extensions of the SCTLR_ELx
> ones.
> 
> Because the bits in these registers depend on other CPU features, and
> only FEAT_MEC is supported at the moment, this commit only implements
> the EMEC bits in CTLR2_EL2 and SCTLR2_EL3.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   docs/system/arm/emulation.rst |  1 +
>   target/arm/cpu-features.h     |  5 +++
>   target/arm/cpu.h              | 15 +++++++
>   target/arm/helper.c           | 78 +++++++++++++++++++++++++++++++++++
>   target/arm/internals.h        |  1 +
>   target/arm/tcg/cpu64.c        |  1 +
>   6 files changed, 101 insertions(+)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 890dc6fee2..66043b0747 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -121,6 +121,7 @@ the following architecture extensions:
>   - FEAT_RPRES (Increased precision of FRECPE and FRSQRTE)
>   - FEAT_S2FWB (Stage 2 forced Write-Back)
>   - FEAT_SB (Speculation Barrier)
> +- FEAT_SCTLR2 (Extension to SCTLR_ELx)
>   - FEAT_SEL2 (Secure EL2)
>   - FEAT_SHA1 (SHA1 instructions)
>   - FEAT_SHA256 (SHA256 instructions)
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 552d8757b7..44d6b655a9 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -416,6 +416,11 @@ static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RDM) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
> +}
> +
>   static inline bool isar_feature_aa64_sha3(const ARMISARegisters *id)
>   {
>       return FIELD_EX64_IDREG(id, ID_AA64ISAR0, SHA3) != 0;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a93eebe077..32d30b7bb9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -337,6 +337,7 @@ typedef struct CPUArchState {
>               };
>               uint64_t sctlr_el[4];
>           };
> +        uint64_t sctlr2_el[4]; /* Extension to System control register. */
>           uint64_t vsctlr; /* Virtualization System control register. */
>           uint64_t cpacr_el1; /* Architectural feature access control register */
>           uint64_t cptr_el[4];  /* ARMv8 feature trap registers */
> @@ -1433,6 +1434,19 @@ void pmu_init(ARMCPU *cpu);
>   #define SCTLR_SPINTMASK (1ULL << 62) /* FEAT_NMI */
>   #define SCTLR_TIDCP   (1ULL << 63) /* FEAT_TIDCP1 */
>   
> +#define SCTLR2_EMEC (1ULL << 1) /* FEAT_MEC */
> +#define SCTLR2_NMEA (1ULL << 2) /* FEAT_DoubleFault2 */
> +#define SCTLR2_ENADERR (1ULL << 3) /* FEAT_ADERR */
> +#define SCTLR2_ENANERR (1ULL << 4) /* FEAT_ANERR */
> +#define SCTLR2_EASE (1ULL << 5) /* FEAT_DoubleFault2 */
> +#define SCTLR2_ENIDCP128 (1ULL << 6) /* FEAT_SYSREG128 */
> +#define SCTLR2_ENPACM (1ULL << 7) /* FEAT_PAuth_LR */
> +#define SCTLR2_ENPACM0 (1ULL << 8 /* FEAT_PAuth_LR */
> +#define SCTLR2_CPTA (1ULL << 9) /* FEAT_CPA2 */
> +#define SCTLR2_CPTA0 (1ULL << 10) /* FEAT_CPA2 */
> +#define SCTLR2_CPTM (1ULL << 11) /* FEAT_CPA2 */
> +#define SCTLR2_CPTM0 (1ULL << 12) /* FEAT_CAP2 */
> +
>   #define CPSR_M (0x1fU)
>   #define CPSR_T (1U << 5)
>   #define CPSR_F (1U << 6)
> @@ -1725,6 +1739,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
>   #define SCR_HXEN              (1ULL << 38)
>   #define SCR_TRNDR             (1ULL << 40)
>   #define SCR_ENTP2             (1ULL << 41)
> +#define SCR_SCTLR2EN          (1ULL << 44)
>   #define SCR_GPF               (1ULL << 48)
>   #define SCR_MECEN             (1ULL << 49)
>   #define SCR_NSE               (1ULL << 62)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 984406c945..5707eea822 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6144,6 +6144,8 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
>       static const struct E2HAlias aliases[] = {
>           { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
>             "SCTLR", "SCTLR_EL2", "SCTLR_EL12" },
> +        { K(3, 0,  1, 0, 3), K(3, 4,  1, 0, 3), K(3, 5, 1, 0, 3),
> +          "SCTLR2_EL1", "SCTLR2_EL2", "SCTLR2_EL12" },
>           { K(3, 0,  1, 0, 2), K(3, 4,  1, 1, 2), K(3, 5, 1, 0, 2),
>             "CPACR", "CPTR_EL2", "CPACR_EL12" },
>           { K(3, 0,  2, 0, 0), K(3, 4,  2, 0, 0), K(3, 5, 2, 0, 0),
> @@ -7816,6 +7818,78 @@ static const ARMCPRegInfo actlr2_hactlr2_reginfo[] = {
>         .resetvalue = 0 },
>   };
>   
> +static CPAccessResult sctlr2_el2_access(CPUARMState *env,
> +                                        const ARMCPRegInfo *ri,
> +                                        bool isread)
> +{
> +    if (arm_current_el(env) < 3 && !(env->cp15.scr_el3 & SCR_SCTLR2EN)) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }

Missing a check for arm_feature(env, ARM_FEATURE_EL3).

> +    return CP_ACCESS_OK;
> +};

Stray ;

> +
> +static CPAccessResult sctlr2_el1_access(CPUARMState *env,
> +                                        const ARMCPRegInfo *ri,
> +                                        bool isread)
> +{
> +    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
> +    if (ret != CP_ACCESS_OK) {
> +        return ret;
> +    }
> +    if (arm_current_el(env) < 2 && !(arm_hcrx_el2_eff(env) & HCRX_SCTLR2EN)) {
> +        return CP_ACCESS_TRAP_EL2;
> +    }
> +    return sctlr2_el2_access(env, ri, isread);
> +};

Stray ;

> +
> +static void sctlr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                             uint64_t value)
> +{
> +    /* This register does not control any feature yet. */
> +};

Stray ;

> +
> +static void sctlr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                             uint64_t value)
> +{
> +    uint64_t valid_mask = 0;
> +
> +    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
> +        valid_mask |= SCTLR2_EMEC;
> +    }
> +    value &= valid_mask;
> +    raw_write(env, ri, value);
> +};

Stray ;

> +
> +static void sctlr2_el3_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                             uint64_t value)
> +{
> +    uint64_t valid_mask = 0;
> +
> +    if (cpu_isar_feature(aa64_mec, env_archcpu(env))) {
> +        valid_mask |= SCTLR2_EMEC;
> +    }
> +    value &= valid_mask;
> +    raw_write(env, ri, value);
> +};

Stray ;

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

