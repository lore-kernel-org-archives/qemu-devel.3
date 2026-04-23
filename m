Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298FEFAD3EF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjB5-0001Sk-5h; Wed, 22 Apr 2026 21:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjB0-0001SR-D8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:48:22 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjAy-0004XB-Ky
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:48:22 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8ea8563c693so455905485a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776908899; x=1777513699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ls1cWy5bWT1K1BiqbcNilCVJNgqfpxtGKXsFcG+aowI=;
 b=m5S7HZY3CMU/FZJRfYyoiDruism3kNM7NMRCvsIFZYtXblW51RbiA7q4GvD6uQzTDR
 1v524YVpL2v7bDiOLkf8xS/vrd0U+OOTpS/Sgd7uZXyotNhT68YbNWPWNI5QF+euyTgE
 lmQmn5fehKcQEabxGABWEfV+frdGYDvBWNzRMVkqp+CdGH05jKB033ScTb/qnHdvPvsH
 FnbHZnnwAbXAzNYNo5IJHvF+/0lzi66Kt78UoPP+FJJNJiGUEj+flwv8GqAIBE9ooOc8
 17mAMGiacuphDcx1fNRdgh+FaLirLE3hay5lEK4cVu0mcWYI6KRcPTWaWvqLr7iJgiiz
 YWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776908899; x=1777513699;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ls1cWy5bWT1K1BiqbcNilCVJNgqfpxtGKXsFcG+aowI=;
 b=k7NTWsQyLAUeW8oddT9KOD47PgtCCokKlkQr3sVDv/HTCMESyhAdAtrG0t7Pc/fTrt
 XRHdSzG7RoaXysMVAWZozQB7dhp20QHGymiJ+IgSigLXxHX1PsoPotte9AzMD2m7hf3m
 q6dxyaoKhfBRlP14O5++W6IXhY47kym3ASroup0vkpIx2Mf2OZzj6+LUM9Al2bOJLSW6
 5T8EfwhcvxRbpAXNOexFVjeG4t4X6/p7rbJ64IBGyf3jdx+YdH6RNy2iWiEuLRs9tZso
 QgOZJF1Hw3MLdRcprqSetdNKAU0Sea3lA81wreVZpCrxXeDaVjY5sOveoqgOI3Sdy/yq
 66Lg==
X-Gm-Message-State: AOJu0YxareV5wf3lQFLPlxFtqxy6DQsM/EkUFE4W8vOv/fgI+qqK+IHU
 o50koqIQ21xdFkfC/jZm3bhSxxxPwyrJl6M1yLb+uwBykUNXFrpp1JGEb7TIuwp2FNQDyqF7hxQ
 9OGnUO6I=
X-Gm-Gg: AeBDieuwEwrEGaqu/2p6jlT5W9fy0cfE2R5x25V/+LouVR8v30N5ZAnLgXbo5ytRpHi
 qbmx80X1/pOKdJcGpayoxDJ0oFHGB7CR+jS0thKiTLs5W9ZTAe3q5Rz6lNM2bCsD5PcH+v9RUn/
 ROpwYQE6k10fc5INx85/PoRp9cofiZNOo+dwvSm4tddGDTJLjvFdePMPn55SXUh6/OmqrC6noC8
 WUe68T6rCJtEYnTCFgsvY6IKQxJ0SOemfNSSFvb5uEC7Jw+38cC2IA/fWRDqgkpWPMOTOI/CXl+
 DcflQr4ABzK2sxF7qXMj82oAf9PJbSXc9WITW+ruk5O6Mqvvoe4yag+Y3RtURYF+K3VK/DGz7gp
 OcP5sUmiUhuFsYnHcFC+vLdBRL1ZDIQIU1VXegzRTqz6Ksi9OyLTl4ZlxXRIngeou6WunEkVSeV
 rPI2o4ljbrilHWJNyeSxevdhZt5LsEEFepLEUru8w1EJBG0V5iHP2k652skUmE1CUqbhqDNJA0/
 b9pwFF5BGsIPMTqeBQsQXVsJQnf
X-Received: by 2002:a05:620a:4044:b0:8ef:3de6:c5b1 with SMTP id
 af79cd13be357-8ef3de6cb02mr1174207285a.43.1776908898967; 
 Wed, 22 Apr 2026 18:48:18 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe9638sm1493636185a.1.2026.04.22.18.48.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 18:48:18 -0700 (PDT)
Message-ID: <55515ca0-3185-4b5d-9bbb-5da1245b8cc3@linaro.org>
Date: Thu, 23 Apr 2026 11:48:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] target/arm/mshv: implement -cpu host for MSHV
To: qemu-devel@nongnu.org
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-5-469f544778ba@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-5-469f544778ba@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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

On 4/21/26 15:21, Aastha Rawat wrote:
> This commit enables support for the `-cpu host` option with MSHV
> accelerator on ARM64. The implementation queries the partition's CPU's
> ID registers and features via hypervisor interface, allowing to pass all
> CPU capabilities for the host CPU to the guest.
> 
> Replace preprocessor config checks with runtime calls to mshv_enabled(),
> kvm_enabled(), etc. This ensures that the correct accelerator is
> selected at runtime when both MSHV and KVM are enabled.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>   accel/mshv/mshv-all.c          |   3 +-
>   hw/arm/virt.c                  |   3 +-
>   include/hw/hyperv/hvgdk_mini.h |  17 ++++
>   include/hw/hyperv/hvhdk.h      |  10 ++
>   include/system/hw_accel.h      |   3 +-
>   target/arm/cpu.c               |   6 +-
>   target/arm/cpu64.c             |  24 +++--
>   target/arm/mshv/mshv-all.c     | 204 +++++++++++++++++++++++++++++++++++++++++
>   target/arm/mshv_arm.h          |  18 ++++
>   9 files changed, 273 insertions(+), 15 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d4cc7f5371..44f35a1463 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -400,13 +400,14 @@ static int mshv_init_vcpu(CPUState *cpu)
>       int ret;
>   
>       cpu->accel = g_new0(AccelCPUState, 1);
> -    mshv_arch_init_vcpu(cpu);
>   
>       ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
>       if (ret < 0) {
>           return -1;
>       }
>   
> +    mshv_arch_init_vcpu(cpu);
> +
>       cpu->accel->dirty = true;
>   
>       return 0;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7456614d05..34eb5248a9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -50,6 +50,7 @@
>   #include "system/kvm.h"
>   #include "system/hvf.h"
>   #include "system/whpx.h"
> +#include "system/mshv.h"
>   #include "system/qtest.h"
>   #include "system/system.h"
>   #include "hw/core/loader.h"
> @@ -3450,7 +3451,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
>       if (target_aarch64()) {
>           g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
>           g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
> -        if (kvm_enabled() || hvf_enabled()) {
> +        if (kvm_enabled() || hvf_enabled() || mshv_enabled()) {
>               g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
>           }
>       }
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index dfe94050f4..d56be0d70f 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -48,6 +48,20 @@ typedef enum hv_register_name {
>       HV_ARM64_REGISTER_LR    = 0x0002001E,
>       HV_ARM64_REGISTER_PC    = 0x00020022,
>   
> +    /* AArch64 System Register Descriptions: ID Registers */
> +    HV_ARM64_REGISTER_ID_MIDR_EL1         = 0x00022000,
> +    HV_ARM64_REGISTER_ID_MPIDR_EL1        = 0x00022005,
> +    HV_ARM64_REGISTER_ID_AA64_PFR0_EL1    = 0x00022020,
> +    HV_ARM64_REGISTER_ID_AA64_PFR1_EL1    = 0x00022021,
> +    HV_ARM64_REGISTER_ID_AA64_ISAR0_EL1   = 0x00022030,
> +    HV_ARM64_REGISTER_ID_AA64_ISAR1_EL1   = 0x00022031,
> +    HV_ARM64_REGISTER_ID_AA64_ISAR2_EL1   = 0x00022032,
> +    HV_ARM64_REGISTER_ID_AA64_MMFR0_EL1   = 0x00022038,
> +    HV_ARM64_REGISTER_ID_AA64_MMFR1_EL1   = 0x00022039,
> +    HV_ARM64_REGISTER_ID_AA64_MMFR2_EL1   = 0x0002203a,
> +    HV_ARM64_REGISTER_ID_AA64_DFR0_EL1    = 0x00022028,
> +    HV_ARM64_REGISTER_ID_AA64_DFR1_EL1    = 0x00022029,

Please use the actual name of the register and not add the extra _ after AA64.

> -#if defined(CONFIG_KVM)
> -    kvm_arm_set_cpu_features_from_host(cpu);
> -    aarch64_add_sve_properties(obj);
> -#elif defined(CONFIG_HVF)
> -    hvf_arm_set_cpu_features_from_host(cpu);
> -#elif defined(CONFIG_WHPX)
> -    whpx_arm_set_cpu_features_from_host(cpu);
> -#else
> -    g_assert_not_reached();
> -#endif
> +    if (mshv_enabled()) {
> +        mshv_arm_set_cpu_features_from_host(cpu);
> +    } else if (kvm_enabled()) {
> +        kvm_arm_set_cpu_features_from_host(cpu);
> +        aarch64_add_sve_properties(obj);
> +    } else if (hvf_enabled()) {
> +        hvf_arm_set_cpu_features_from_host(cpu);
> +    } else if (whpx_enabled()) {
> +        whpx_arm_set_cpu_features_from_host(cpu);
> +    } else {
> +        g_assert_not_reached();
> +    }

If this is because both mshv and kvm can be enabled simultaneously, then this should be a 
separate patch to transform the ifdef ladder.

> +static void clamp_id_aa64mmfr0_parange_to_ipa_size(int mshv_fd,
> +                                                   ARMISARegisters *isar)
> +{
> +    uint32_t ipa_size = mshv_arm_get_ipa_bit_size(mshv_fd);
> +    uint64_t id_aa64mmfr0;
> +
> +    /* Clamp down the PARange to the IPA size the kernel supports. */
> +    uint8_t index = round_down_to_parange_index(ipa_size);
> +    id_aa64mmfr0 = GET_IDREG(isar, ID_AA64MMFR0);
> +    id_aa64mmfr0 = (id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;

id_aa64_mmfr0 = FIELD_DPREG64(id_aa64mmfr0, AA64MMFR0, PARANGE, index);

> +    args.in_ptr = (uintptr_t)(in_buffer);
> +    args.out_sz = values_sz;
> +    args.out_ptr = (uintptr_t)(out_buffer);

Drop unnecessary ().

> +    args.reps =  (uint16_t) n_regs;

Unnecessary cast.

> +static bool mshv_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> +{
> +    int mshv_fd = mshv_state->fd;
> +    int vm_fd = mshv_state->vm;
> +    int i, ret;
> +    bool success = true;
> +    uint64_t pfr0, pfr1;
> +    gchar *contents = NULL;
> +
> +    const struct {

static

> +        hv_register_name name;
> +        int isar_idx;
> +    } regs[] = {
> +        { HV_ARM64_REGISTER_ID_AA64_PFR0_EL1,  ID_AA64PFR0_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_PFR1_EL1,  ID_AA64PFR1_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_ISAR2_EL1, ID_AA64ISAR2_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_DFR0_EL1,  ID_AA64DFR0_EL1_IDX },
> +        { HV_ARM64_REGISTER_ID_AA64_DFR1_EL1,  ID_AA64DFR1_EL1_IDX },

Per above, if you use matching names, you can macroize to avoid typos:

#define R(X)  { HV_ARM64_REGISTER_##X, X##_IDX }

     R(ID_AA64PFR0_EL1),
     R(ID_AA64PFR1_EL1),
     ...

#undef R

Also, there are a *lot* more id registers.
Any chance all, or at least more, are defined by MSHV?


r~

