Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39B5C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 04:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzpPi-0007Lz-Lt; Wed, 02 Apr 2025 00:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzpPT-0007KB-0c
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:09:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzpPQ-0007FA-Sd
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 00:09:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso59363945e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743566939; x=1744171739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i7ob2Qv6SJizBJ26WLxI/2hPmEjkY2C/7n20ks9PPdU=;
 b=h4A2liRZX6LHzwef5bcWBp+GsvxRzVXnbA/awmnYbwphew4chyUMD0MTVzsXNd6akC
 iOOmtcFuEkMdJd7pdm4qAs8xtx/7honr0FU4gUrXk8xPTzWqy9N/W4mxOQe54JRiTo4i
 3r1Hb1S588yFVjSCQzvl34cn5WLltk4U1qTi/DTvoYR4q7K1zmSpHIKczLrOhMd7gXgB
 jGZ6AnXPJU24XIJUlROTZpHCGA4K0ktY4Nu1qrM/zh43ZDAFQ77Wk80RUV4ey4XCWPPf
 L7O6GjjlLcR9pzlqItWKieUitrcqhL5hMyGDQ/WRTL4eoQji1lhe/n0l3qpjUx4z3Pqh
 dDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743566939; x=1744171739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i7ob2Qv6SJizBJ26WLxI/2hPmEjkY2C/7n20ks9PPdU=;
 b=VoinJudaqBimnC63iedfWdcFSh+9rG5XWfxr077vOAMInsnEVsc4/U/Vd5XN+/vfSF
 q8ojqVoCInofBWY0Aktv+RuT2W27MnSR9ZCV2RIMPzVu7UhORVKnAnNtY9NdDQLJxWPD
 h+KZRkRiWtKVL1lwDshRsvvtdIuxI/Qbfw4kHNuSOBru9clwJCeOZbJDuEtj3dkT+GS7
 eWcCnfIAzi5QoeoqDTVT0AQzCjl/x4n0gSHFs8+YVOYv71Why9P2DULKK+GNmlY1Wmb4
 AQSJRG3ZPrGeT5tEhtE0/rp7fylMHCzz7y0RzIFDpUKWYco1Jj7wm4WaU9emw+VQ8K5p
 mIbQ==
X-Gm-Message-State: AOJu0Ywq9CCqw95E9TYQoLEp7weY7JlflDTe8Y95OMDRUyxClcXmZWsa
 dZbGHCkgOozH1errODH8mAeUVZZHp8mKJorUhTno5QkQ6Uxyfz/AbluvmZsVrwhnIxJBzzGm5cV
 j
X-Gm-Gg: ASbGncvG+80m7ukM3eoHilbCGiXdIZIowDm3bhqSLp7YTV8ZING5hEydrJKjxqca7l0
 qSU/Ish4+19B4LGMF5YWYAT1YkuyAaOEF1giBVblGuViWBQIIi1/iyiKO6aBiF/skCqF4uS1cKF
 UM6x0MKNKYuG4Hl7iO4aYKONuC7laaTIAnoKjF3eKKr5U6d9DJy/lJSJwk6y8MERg24ddVIRWJK
 /Sfyjf8zmgkUrI0+FpBU/MJcPSGMcaqbM/EQu98MSAcVYx0zwLz7MA9YoeOqgR3SRpqA1OjXx+K
 oPdZ6+H2nDZTpbCan9t1nHCitycPvAXNlvqi4BqR7LwpmDMYE6Lhx4IVSdUG+/qdLoN58ZKg7yW
 OeNxoG3ALjnFj
X-Google-Smtp-Source: AGHT+IH1+Cc/Zo1DWo48nPIMtxYpkkmAcYv2KlTn+be2Su73XHhfhv7BiGLY3l4FVAuA7CMRdhxRrw==
X-Received: by 2002:a05:600c:1ca9:b0:43c:fe5e:f03b with SMTP id
 5b1f17b1804b1-43db62bf723mr165889975e9.30.1743566938862; 
 Tue, 01 Apr 2025 21:08:58 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb60d3627sm8001405e9.24.2025.04.01.21.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 21:08:58 -0700 (PDT)
Message-ID: <ddc338b7-4a7e-4353-bc19-1d98c48dcb21@linaro.org>
Date: Wed, 2 Apr 2025 06:08:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] target/arm: Move CPU definitions consumed by HW
 model to "hw/arm/cpu.h"
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: ale@rev.ng, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Rob Herring <robh@kernel.org>, Antony Pavlov <antonynpavlov@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Beniamino Galvani <b.galvani@gmail.com>
References: <20230110164406.94366-1-philmd@linaro.org>
 <20230110164406.94366-7-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230110164406.94366-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Cc'ing Pierrick

On 10/1/23 17:43, Philippe Mathieu-Daudé wrote:
> Units including "target/arm/cpu.h" can't be built once via meson's
> softmmu_ss[] source set. Since this header depends on specific
> definitions such the word size (32 or 64-bit), for ARM such units
> must go to the per-target arm_ss[].
> 
> We want to expose few architectural definitions to hardware models.
> 
> Expose the ARM architectural definitions used by hardware models,
> in order to reduce the inclusion of "target/arm/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/cpu.h | 49 ++++++++++++++++++++++++++++++++++++++++++++

Richard, WRT your comment in previous patch (target/ shouldn't access
hw/), WDYT of "target/arm/hw-defs.h" for this header?

>   target/arm/cpu-qom.h | 15 --------------
>   target/arm/cpu.h     | 34 ------------------------------
>   3 files changed, 49 insertions(+), 49 deletions(-)
> 
> diff --git a/include/hw/arm/cpu.h b/include/hw/arm/cpu.h
> index 0c5d6ca2a8..6758bffe34 100644
> --- a/include/hw/arm/cpu.h
> +++ b/include/hw/arm/cpu.h
> @@ -25,4 +25,53 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU, TYPE_AARCH64_CPU)
>   #define ARM_CPU_TYPE_SUFFIX "-" TYPE_ARM_CPU
>   #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
>   
> +enum QemuPsciConduit {
> +    QEMU_PSCI_CONDUIT_DISABLED = 0,
> +    QEMU_PSCI_CONDUIT_SMC = 1,
> +    QEMU_PSCI_CONDUIT_HVC = 2,
> +};
> +
> +/* Meanings of the ARMCPU object's four inbound GPIO lines */
> +#define ARM_CPU_IRQ 0
> +#define ARM_CPU_FIQ 1
> +#define ARM_CPU_VIRQ 2
> +#define ARM_CPU_VFIQ 3
> +
> +#define GTIMER_PHYS     0
> +#define GTIMER_VIRT     1
> +#define GTIMER_HYP      2
> +#define GTIMER_SEC      3
> +#define GTIMER_HYPVIRT  4
> +#define NUM_GTIMERS     5
> +
> +/* For M profile, some registers are banked secure vs non-secure;
> + * these are represented as a 2-element array where the first element
> + * is the non-secure copy and the second is the secure copy.
> + * When the CPU does not have implement the security extension then
> + * only the first element is used.
> + * This means that the copy for the current security state can be
> + * accessed via env->registerfield[env->v7m.secure] (whether the security
> + * extension is implemented or not).
> + */
> +enum {
> +    M_REG_NS = 0,
> +    M_REG_S = 1,
> +    M_REG_NUM_BANKS = 2,
> +};
> +
> +#define ARM_AFF0_SHIFT 0
> +#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
> +#define ARM_AFF1_SHIFT 8
> +#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
> +#define ARM_AFF2_SHIFT 16
> +#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
> +#define ARM_AFF3_SHIFT 32
> +#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
> +#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
> +
> +#define ARM32_AFFINITY_MASK (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK)
> +#define ARM64_AFFINITY_MASK \
> +    (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK|ARM_AFF3_MASK)
> +#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
> +
>   #endif
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index b98904b6bc..d37037e214 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -68,19 +68,4 @@ void arm_gt_htimer_cb(void *opaque);
>   void arm_gt_stimer_cb(void *opaque);
>   void arm_gt_hvtimer_cb(void *opaque);
>   
> -#define ARM_AFF0_SHIFT 0
> -#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
> -#define ARM_AFF1_SHIFT 8
> -#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
> -#define ARM_AFF2_SHIFT 16
> -#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
> -#define ARM_AFF3_SHIFT 32
> -#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
> -#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
> -
> -#define ARM32_AFFINITY_MASK (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK)
> -#define ARM64_AFFINITY_MASK \
> -    (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK|ARM_AFF3_MASK)
> -#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
> -
>   #endif
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 52ac99cad3..ab6fdecf48 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -72,21 +72,6 @@
>   #define ARMV7M_EXCP_PENDSV  14
>   #define ARMV7M_EXCP_SYSTICK 15
>   
> -/* For M profile, some registers are banked secure vs non-secure;
> - * these are represented as a 2-element array where the first element
> - * is the non-secure copy and the second is the secure copy.
> - * When the CPU does not have implement the security extension then
> - * only the first element is used.
> - * This means that the copy for the current security state can be
> - * accessed via env->registerfield[env->v7m.secure] (whether the security
> - * extension is implemented or not).
> - */
> -enum {
> -    M_REG_NS = 0,
> -    M_REG_S = 1,
> -    M_REG_NUM_BANKS = 2,
> -};
> -
>   /* ARM-specific interrupt pending bits.  */
>   #define CPU_INTERRUPT_FIQ   CPU_INTERRUPT_TGT_EXT_1
>   #define CPU_INTERRUPT_VIRQ  CPU_INTERRUPT_TGT_EXT_2
> @@ -107,12 +92,6 @@ enum {
>   #define offsetofhigh32(S, M) (offsetof(S, M) + sizeof(uint32_t))
>   #endif
>   
> -/* Meanings of the ARMCPU object's four inbound GPIO lines */
> -#define ARM_CPU_IRQ 0
> -#define ARM_CPU_FIQ 1
> -#define ARM_CPU_VIRQ 2
> -#define ARM_CPU_VFIQ 3
> -
>   /* ARM-specific extra insn start words:
>    * 1: Conditional execution bits
>    * 2: Partial exception syndrome for data aborts
> @@ -160,13 +139,6 @@ typedef struct ARMGenericTimer {
>       uint64_t ctl; /* Timer Control register */
>   } ARMGenericTimer;
>   
> -#define GTIMER_PHYS     0
> -#define GTIMER_VIRT     1
> -#define GTIMER_HYP      2
> -#define GTIMER_SEC      3
> -#define GTIMER_HYPVIRT  4
> -#define NUM_GTIMERS     5
> -
>   #define VTCR_NSW (1u << 29)
>   #define VTCR_NSA (1u << 30)
>   #define VSTCR_SW VTCR_NSW
> @@ -3323,12 +3295,6 @@ static inline bool arm_cpu_bswap_data(CPUARMState *env)
>   void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                             target_ulong *cs_base, uint32_t *flags);
>   
> -enum {
> -    QEMU_PSCI_CONDUIT_DISABLED = 0,
> -    QEMU_PSCI_CONDUIT_SMC = 1,
> -    QEMU_PSCI_CONDUIT_HVC = 2,
> -};
> -
>   #ifndef CONFIG_USER_ONLY
>   /* Return the address space index to use for a memory access */
>   static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)


