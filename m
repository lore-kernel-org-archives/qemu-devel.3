Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D371AD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9Gt-0006TG-8J; Tue, 20 Jan 2026 05:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9Gq-0006PM-8L
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:47:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9Go-0000R2-8N
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:47:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so32465445e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768906052; x=1769510852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IM/Z3bTuyXiXpLSSkAwcwNsLw/7dR2j+eDpQWSwcgWE=;
 b=Zqjqhm9sAJskeycDFtZq5dFyC+hu9PxORb5/XYG0GPHCCBc+F/AyK6FC5XRS1qX/Ra
 xSPtT9TN6Flq4h4Fp9GtoIr58NgiXHfX4ZJloL1KzUCf2KOMGHCp4dwVaY2to0a+wNOd
 80MQPZ83c38FiL1s8VVcVFSOb5LmpZ7Z1FD9Mba5HbX3okQof+tHxH+kVg+RAiS8u0wZ
 7n2lL1kxkOh+hfa2fgLXlJZIGaaIBCI56PXfMSm8mpW9nCUTMknFHZGke2dLt7GjII3s
 fP8TVaY9wZs2fWtVEA45lVWFpNLlgPHD2wXjMhVfjOsRPYgNOaC4f1G6sZc86vXP39kR
 ROEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768906052; x=1769510852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IM/Z3bTuyXiXpLSSkAwcwNsLw/7dR2j+eDpQWSwcgWE=;
 b=A9NsMlduIDJ1L80fTJ1/2G4aaG1qyamtJrzhUBE8t9Ok7AxQjAV76oKN7OSe7bSoJO
 i4BydRyspFKaKpNolJo8SjqG/DIqt8D5tM7ZwE4B94c76Ka/7Qfq3PI4DPBy581G5Ot9
 NpnDWngRbx+k/2EQ5C6IStZiZzw/XSQ5byx6Bv08KpWGmyZijUhDiRgC/c0ja8T4zYem
 4tXFspw8UZtBja3YkZLKraoOfPWnpIklspV6USNNV/J/RrvLB31b7n18t7biCLHONxW5
 A60E6fMAFmgOyuAgMJ2qBK6jt0alFD4ZKf6oEuBmIca8qXx/uMRBjIJxYPt67bKLiVKb
 glvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULnO21cwiTTmiUfy9x4iqR01KJUyk6/tIUGysw38NZJz4K4+cx9HyQaysHhN06AxqI/WIWZuXnLRx4@nongnu.org
X-Gm-Message-State: AOJu0YxoKdSNHWwzA6+TUgl2vAdiZqVM+wCy1gL5F7w8otohFi/t4Eso
 mqZ2KYeuXqCTpSfkvkMh/bzqWlWDMBbzRBPPOXRv3PyGFq1DZ+hM43aZAI7zOtvgZv0=
X-Gm-Gg: AY/fxX5M4uhC1tZoHscwVY5ByEr1o65eA/nlDkdllIl47WJ/C97x02T4SdyqLNhc76y
 ovNzqKAvZh4ghpHcn+YVSavEFAKZqYipljP+AwQM2Umo6EYYnAL0OVnfIIEfsqN1JMkCk/eisRR
 qvaE+4MmW5iWOXksg/EvujevgT2mWu2BNp6cIdsFZ3801bhnOtJ6swECpqflago8vV4f8E1lOXD
 xSYmwQDyz3PVZ1PTI4QcR6MYaf7pWmB2e9cK99IJMqBAlsjA3r2t/mhpBeCVtua1EFuWUnaz/Ma
 RUBTkk57EbhnGVVJed9+COZ6YtbrV5CO4IKvIxD43gOUpM0OkwFEvFqAnzs9pgNak1blO9Aghg/
 xbzHp32vKNcchiwLzJv40kvKLqJAlKzcQ6ExC1Gwma9RQSmathZk1nJuiZ3WwVVXYvU/I9grM/m
 Z1WAPs4ePzskXVYFmXOWJCXTP8taObpzIFO1GugA4IiJqGu1UsEaRBhw==
X-Received: by 2002:a05:600c:4e86:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-4801eac4779mr164811925e9.14.1768906052309; 
 Tue, 20 Jan 2026 02:47:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm29801141f8f.6.2026.01.20.02.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 02:47:31 -0800 (PST)
Message-ID: <1b0bd534-dd41-4ace-b5b3-37d854ae3d31@linaro.org>
Date: Tue, 20 Jan 2026 11:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hvf/arm: handle FEAT_SME2 migration
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260115-sme2-hvf-v2-0-2eca481bd7ee@linaro.org>
 <20260115-sme2-hvf-v2-1-2eca481bd7ee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115-sme2-hvf-v2-1-2eca481bd7ee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Manos,

Mostly nitpicking comments :)

On 15/1/26 12:20, Manos Pitsidianakis wrote:
> SME2 support adds the following state for HVF guests:
> 
> - Vector registers Z0, ... , Z31 (introduced by FEAT_SVE but HVF does
>    not support it)
> - Predicate registers P0, .., P15 (also FEAT_SVE)
> - ZA register
> - ZT0 register
> - PSTATE.{SM,ZA} bits (SVCR pseudo-register)
> - SMPRI_EL1 which handles the PE's priority in the SMCU
> - TPIDR2_EL0 the thread local ID register for SME
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   target/arm/hvf/hvf.c           | 285 ++++++++++++++++++++++++++++++++++++++++-
>   target/arm/hvf/hvf_sme_stubs.h | 158 +++++++++++++++++++++++
>   target/arm/hvf/sysreg.c.inc    |   8 ++
>   target/arm/hvf_arm.h           |  41 ++++++
>   target/arm/machine.c           |   2 +-
>   5 files changed, 491 insertions(+), 3 deletions(-)


>   int hvf_arch_get_registers(CPUState *cpu)
>   {
> @@ -465,6 +698,10 @@ int hvf_arch_get_registers(CPUState *cpu)
>           uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
>           int hvf_id = KVMID_TO_HVF(kvm_id);
>   
> +        if (kvm_id == HVF_TO_KVMID(SVCR)) {
> +            continue;
> +        }
> +
>           if (cpu->accel->guest_debug_enabled) {
>               /* Handle debug registers */
>               switch (hvf_id) {
> @@ -558,6 +795,11 @@ int hvf_arch_get_registers(CPUState *cpu)
>   
>           arm_cpu->cpreg_values[i] = val;
>       }
> +    if (__builtin_available(macOS 15.2, *)) {
> +        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> +            hvf_arch_get_sme(cpu);
> +        }
> +    }

What about:

        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
            if (__builtin_available(macOS 15.2, *)) {
                hvf_arch_get_sme(cpu);
            } else {
                g_assert_not_reached();
            }
        }

?

>       assert(write_list_to_cpustate(arm_cpu));
>   
>       aarch64_restore_sp(env, arm_current_el(env));
> @@ -603,6 +845,10 @@ int hvf_arch_put_registers(CPUState *cpu)
>           uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
>           int hvf_id = KVMID_TO_HVF(kvm_id);
>   
> +        if (kvm_id == HVF_TO_KVMID(SVCR)) {
> +            continue;
> +        }
> +
>           if (cpu->accel->guest_debug_enabled) {
>               /* Handle debug registers */
>               switch (hvf_id) {
> @@ -687,6 +933,11 @@ int hvf_arch_put_registers(CPUState *cpu)
>       ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
>       assert_hvf_ok(ret);
>   
> +    if (__builtin_available(macOS 15.2, *)) {
> +        if (cpu_isar_feature(aa64_sme, arm_cpu)) {
> +            hvf_arch_put_sme(cpu);
> +        }
> +    }
>       return 0;
>   }
>   
> @@ -909,6 +1160,18 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>       hv_return_t ret;
>       int i;
>   
> +    if (__builtin_available(macOS 15.2, *)) {
> +        sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
> +
> +#define DEF_SYSREG_15_02(HVF_ID, ...) \
> +        g_assert(HVF_ID == KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
> +#define DEF_SYSREG(...)
> +
> +#include "sysreg.c.inc"
> +
> +#undef DEF_SYSREG
> +#undef DEF_SYSREG_15_02
> +    }
>       env->aarch64 = true;
>       asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
>   
> @@ -927,7 +1190,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>       memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
>   
>       /* Populate cp list for all known sysregs */
> -    for (i = 0; i < sregs_match_len; i++) {
> +    for (i = 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
>           hv_sys_reg_t hvf_id = hvf_sreg_list[i];
>           uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
>           uint32_t key = kvm_to_cpreg_id(kvm_id);
> @@ -938,6 +1201,24 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>               arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
>           }
>       }
> +    if (__builtin_available(macOS 15.2, *)) {
> +        for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> +            hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i];
> +            uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
> +            uint32_t key = kvm_to_cpreg_id(kvm_id);
> +            const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> +
> +            if (ri) {
> +                assert(!(ri->type & ARM_CP_NO_RAW));
> +                arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
> +            }
> +        }
> +        /*
> +         * Add SVCR last. It is elsewhere assumed its index is after
> +         * hvf_sreg_list and hvf_sreg_list_sme2.
> +         */
> +        arm_cpu->cpreg_indexes[sregs_cnt++] = HVF_TO_KVMID(SVCR);
> +    }

Could we add as a hvf_arch_init_sme() helper instead?

>       arm_cpu->cpreg_array_len = sregs_cnt;
>       arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
>   
> diff --git a/target/arm/hvf/hvf_sme_stubs.h b/target/arm/hvf/hvf_sme_stubs.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..9c679b711017448681e532b88ce10a07ebfd5122
> --- /dev/null
> +++ b/target/arm/hvf/hvf_sme_stubs.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +typedef int32_t hv_return_t;
> +typedef uint64_t hv_vcpu_t;

We certainly already have these.

> +
> +static inline bool hvf_arm_sme2_supported(void)
> +{
> +    return false;
> +}
> +
> +static inline uint32_t hvf_arm_sme2_get_svl(void)
> +{
> +    g_assert_not_reached();
> +}
> +
> +typedef enum hv_sme_p_reg_t {
> +    HV_SME_P_REG_0,
> +    HV_SME_P_REG_1,
> +    HV_SME_P_REG_2,
> +    HV_SME_P_REG_3,
> +    HV_SME_P_REG_4,
> +    HV_SME_P_REG_5,
> +    HV_SME_P_REG_6,
> +    HV_SME_P_REG_7,
> +    HV_SME_P_REG_8,
> +    HV_SME_P_REG_9,
> +    HV_SME_P_REG_10,
> +    HV_SME_P_REG_11,
> +    HV_SME_P_REG_12,
> +    HV_SME_P_REG_13,
> +    HV_SME_P_REG_14,
> +    HV_SME_P_REG_15,
> +} hv_sme_p_reg_t;
> +
> +typedef __attribute__((ext_vector_type(64))) uint8_t hv_sme_zt0_uchar64_t;
> +
> +typedef enum hv_sme_z_reg_t {
> +    HV_SME_Z_REG_0,
> +    HV_SME_Z_REG_1,
> +    HV_SME_Z_REG_2,
> +    HV_SME_Z_REG_3,
> +    HV_SME_Z_REG_4,
> +    HV_SME_Z_REG_5,
> +    HV_SME_Z_REG_6,
> +    HV_SME_Z_REG_7,
> +    HV_SME_Z_REG_8,
> +    HV_SME_Z_REG_9,
> +    HV_SME_Z_REG_10,
> +    HV_SME_Z_REG_11,
> +    HV_SME_Z_REG_12,
> +    HV_SME_Z_REG_13,
> +    HV_SME_Z_REG_14,
> +    HV_SME_Z_REG_15,
> +    HV_SME_Z_REG_16,
> +    HV_SME_Z_REG_17,
> +    HV_SME_Z_REG_18,
> +    HV_SME_Z_REG_19,
> +    HV_SME_Z_REG_20,
> +    HV_SME_Z_REG_21,
> +    HV_SME_Z_REG_22,
> +    HV_SME_Z_REG_23,
> +    HV_SME_Z_REG_24,
> +    HV_SME_Z_REG_25,
> +    HV_SME_Z_REG_26,
> +    HV_SME_Z_REG_27,
> +    HV_SME_Z_REG_28,
> +    HV_SME_Z_REG_29,
> +    HV_SME_Z_REG_30,
> +    HV_SME_Z_REG_31,
> +} hv_sme_z_reg_t;

Hmm do we need those? Could we just define the typedef?

   typedef uint32_t hv_sme_p_reg_t;
   typedef uint32_t hv_sme_z_reg_t;
   typedef void *hv_sme_zt0_uchar64_t;

> +
> +enum {
> +  HV_SYS_REG_SMCR_EL1,
> +  HV_SYS_REG_SMPRI_EL1,
> +  HV_SYS_REG_TPIDR2_EL0,
> +  HV_SYS_REG_ID_AA64ZFR0_EL1,
> +  HV_SYS_REG_ID_AA64SMFR0_EL1,
> +};
> +
> +typedef struct {
> +    bool streaming_sve_mode_enabled;
> +    bool za_storage_enabled;
> +} hv_vcpu_sme_state_t;
> +
> +static inline hv_return_t hv_sme_config_get_max_svl_bytes(size_t *value)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_state(hv_vcpu_t vcpu,
> +                                                hv_vcpu_sme_state_t *sme_state)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_state(hv_vcpu_t vcpu,
> +                                                const hv_vcpu_sme_state_t *sme_state)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_z_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_z_reg_t reg,
> +                                                uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_z_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_z_reg_t reg,
> +                                                const uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_p_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_p_reg_t reg,
> +                                                uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_p_reg(hv_vcpu_t vcpu,
> +                                                hv_sme_p_reg_t reg,
> +                                                const uint8_t *value,
> +                                                size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_za_reg(hv_vcpu_t vcpu,
> +                                                 uint8_t *value,
> +                                                 size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_za_reg(hv_vcpu_t vcpu,
> +                                                 const uint8_t *value,
> +                                                 size_t length)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_get_sme_zt0_reg(hv_vcpu_t vcpu,
> +                                                  hv_sme_zt0_uchar64_t *value)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline hv_return_t hv_vcpu_set_sme_zt0_reg(hv_vcpu_t vcpu,
> +                                                  const hv_sme_zt0_uchar64_t *value)
> +{
> +    g_assert_not_reached();
> +}

