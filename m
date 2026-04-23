Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76463FAD3E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFiue-0007Il-6c; Wed, 22 Apr 2026 21:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFiua-0007IT-Sa
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:31:24 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFiuY-0007b8-Rx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:31:24 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-50fbd79350dso19358761cf.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776907881; x=1777512681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dv6bnWUqNOiCYQ1NV231msB+bVQzjf6WOcvm08JjPwM=;
 b=xVeyJSDweKiO7/4U851Ok66x6exRk99bY/UZdQvdtWaZFSgitA7j0U5i4uRl874pot
 dEFY67Tv9zHLbhEg09GMY9G8ijVKsvH/OJLqGaa3MdzBlGAKf17zZHNK5jL8hAJlbVjl
 wDDtqhIKsz8/JoFaC1+fA9It23reDKbXz/H0wfDYwvhgVLK30siXiW9DdJT7Q1wi4Ibb
 Tegw7xh33kGYag4AX53nDqdL80fKYFZ0lTf6jzYRzihiKXddjFv9EHWBNnkzTjKpWSEJ
 1mGPpRM41hIp+aMNXBPF5ZDBpEwAkyJ/dJeEUBFPIDURnFwf+0VaN3lW0axPWHJ6+Cqq
 tOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776907881; x=1777512681;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dv6bnWUqNOiCYQ1NV231msB+bVQzjf6WOcvm08JjPwM=;
 b=A5E99+1uNxfaUR0RHAEsllRpuHNjIWLdm9mXpO8Do9dhZomd3H7EOmIJ6mIoCX/abf
 TmfWHFSygIsPhll2OegG5Ok9w7vlO9njZwi+BkSTOtTKlAH3BeSi0rXOvPwHvQRsUP0C
 LBkn3RH/NdZdfXpiUGNjfNtOGIET/2FjUEfGx7yi3AOVaA1a4gB32GEnbviFEEhUyjqE
 rYLRwcHe+5OxFgscKMlwK9a82E6pIiNkmB8UUDr2A8JIEq9tSDCSbepQ3fJNNTFO90FM
 vpL7AW5O/+iFNIImOm9y6s57Ui93Mqjmeh17bsHhQDxvZplOlzLLDs7xuLCROmAHadTi
 10xg==
X-Gm-Message-State: AOJu0Yz1k9oEvuGHruVOZhMdq8QfhbyChipsGWqcvOXSLM72cF0U+k0n
 vscrDqcj3uviPuNGH/m1CMqcgWWyApHYThZ+PiFE3MP05DPv8YZk+5ms1AW541QIZzpgxHp9dpj
 TXKilOho=
X-Gm-Gg: AeBDievhq2nuB+WqjmZnW+rCgmkIWwLZnBxzL61Wv57lnIy/m/6qWkQrytshGdVpye1
 SPSSvE5az7lBoKZzTU1toSZ+JW4pfBOtVATEe5Z2pUFVnx9ZAXdEoXyYfWZIFbWvsVWdyNT5LXg
 n8MsSmzj2L4WNeBY9pCrit3383e4RBlZdIakYJVMI6UwGCo25gKHhAZ9nuzJSp7gZuwCoDaxm4m
 uDWge++tcRJ+XoNiMrCYv33zwF8iGp+i01sQRAxg2hCSagODmDxXsuluwsOh8W+GbNn6hQ9U3pT
 evHMUZKKrYwyf8wPmoDGumQ8j3zDsnFsoDbHae+8qAIWUpovLwGYHYx4K04lxo+yWV9rlAjAbBq
 837BNFuzSKS4qkTe3O91ZhU3Y6SbfIVZYzNnLtxWemGTWc1G6RBOjtr6whheK0z2WjXdLFc2us+
 4uQpL9rutRtcKQq2Yx0cz+KZwnFcd4qDVTfvRJW3PIKCqEeOYUPentDUJmR2i/SfR96xhKUXmR0
 VDzPBRxy4tFhznhRbUj2om6PXHD
X-Received: by 2002:ac8:5fc9:0:b0:50f:b137:3099 with SMTP id
 d75a77b69052e-50fb137350fmr163684061cf.33.1776907881255; 
 Wed, 22 Apr 2026 18:31:21 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50f13ba2509sm80051851cf.8.2026.04.22.18.31.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 18:31:20 -0700 (PDT)
Message-ID: <66a7a9ef-bdec-44a2-89e3-28cf77d6684b@linaro.org>
Date: Thu, 23 Apr 2026 11:31:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] target/arm/mshv: implement vcpu state operations
 for ARM64
To: qemu-devel@nongnu.org
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-4-469f544778ba@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-4-469f544778ba@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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
> Add support for reading and writing ARM64 CPU registers in the MSHV
> accelerator. This includes functions to set and get registers,
> initialize and destroy VCPU state, and manage register state
> synchronization between QEMU and hypervisor.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>   include/hw/hyperv/hvgdk_mini.h |  42 +++++++++++++
>   target/arm/mshv/mshv-all.c     | 138 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 180 insertions(+)
> 
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index cb52cc9de2..dfe94050f4 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -13,6 +13,46 @@ typedef enum hv_register_name {
>       /* Pending Interruption Register */
>       HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
>   
> +#if defined(__aarch64__)

Not ideal, having target/host-specific stuff in a global header.
That said, you don't actually need the ifdefs at all.

> +    HV_ARM64_REGISTER_XZR   = 0x0002FFFE,
> +    HV_ARM64_REGISTER_X0    = 0x00020000,
> +    HV_ARM64_REGISTER_X1    = 0x00020001,
> +    HV_ARM64_REGISTER_X2    = 0x00020002,
> +    HV_ARM64_REGISTER_X3    = 0x00020003,
> +    HV_ARM64_REGISTER_X4    = 0x00020004,
> +    HV_ARM64_REGISTER_X5    = 0x00020005,
> +    HV_ARM64_REGISTER_X6    = 0x00020006,
> +    HV_ARM64_REGISTER_X7    = 0x00020007,
> +    HV_ARM64_REGISTER_X8    = 0x00020008,
> +    HV_ARM64_REGISTER_X9    = 0x00020009,
> +    HV_ARM64_REGISTER_X10   = 0x0002000A,
> +    HV_ARM64_REGISTER_X11   = 0x0002000B,
> +    HV_ARM64_REGISTER_X12   = 0x0002000C,
> +    HV_ARM64_REGISTER_X13   = 0x0002000D,
> +    HV_ARM64_REGISTER_X14   = 0x0002000E,
> +    HV_ARM64_REGISTER_X15   = 0x0002000F,
> +    HV_ARM64_REGISTER_X16   = 0x00020010,
> +    HV_ARM64_REGISTER_X17   = 0x00020011,
> +    HV_ARM64_REGISTER_X18   = 0x00020012,
> +    HV_ARM64_REGISTER_X19   = 0x00020013,
> +    HV_ARM64_REGISTER_X20   = 0x00020014,
> +    HV_ARM64_REGISTER_X21   = 0x00020015,
> +    HV_ARM64_REGISTER_X22   = 0x00020016,
> +    HV_ARM64_REGISTER_X23   = 0x00020017,
> +    HV_ARM64_REGISTER_X24   = 0x00020018,
> +    HV_ARM64_REGISTER_X25   = 0x00020019,
> +    HV_ARM64_REGISTER_X26   = 0x0002001A,
> +    HV_ARM64_REGISTER_X27   = 0x0002001B,
> +    HV_ARM64_REGISTER_X28   = 0x0002001C,
> +    HV_ARM64_REGISTER_FP    = 0x0002001D,
> +    HV_ARM64_REGISTER_LR    = 0x0002001E,
> +    HV_ARM64_REGISTER_PC    = 0x00020022,
> +
> +    /* AArch64 System Register Descriptions: General system control registers */
> +    HV_ARM64_REGISTER_MIDR_EL1   = 0x00040051,
> +    HV_ARM64_REGISTER_MPIDR_EL1  = 0x00040001,
> +
> +#elif defined(__x86_64__)

> +static enum hv_register_name STANDARD_REGISTER_NAMES[32] = {

const.

> +    HV_ARM64_REGISTER_X0,
> +    HV_ARM64_REGISTER_X1,
> +    HV_ARM64_REGISTER_X2,
> +    HV_ARM64_REGISTER_X3,
> +    HV_ARM64_REGISTER_X4,
> +    HV_ARM64_REGISTER_X5,
> +    HV_ARM64_REGISTER_X6,
> +    HV_ARM64_REGISTER_X7,
> +    HV_ARM64_REGISTER_X8,
> +    HV_ARM64_REGISTER_X9,
> +    HV_ARM64_REGISTER_X10,
> +    HV_ARM64_REGISTER_X11,
> +    HV_ARM64_REGISTER_X12,
> +    HV_ARM64_REGISTER_X13,
> +    HV_ARM64_REGISTER_X14,
> +    HV_ARM64_REGISTER_X15,
> +    HV_ARM64_REGISTER_X16,
> +    HV_ARM64_REGISTER_X17,
> +    HV_ARM64_REGISTER_X18,
> +    HV_ARM64_REGISTER_X19,
> +    HV_ARM64_REGISTER_X20,
> +    HV_ARM64_REGISTER_X21,
> +    HV_ARM64_REGISTER_X22,
> +    HV_ARM64_REGISTER_X23,
> +    HV_ARM64_REGISTER_X24,
> +    HV_ARM64_REGISTER_X25,
> +    HV_ARM64_REGISTER_X26,
> +    HV_ARM64_REGISTER_X27,
> +    HV_ARM64_REGISTER_X28,
> +    HV_ARM64_REGISTER_FP,
> +    HV_ARM64_REGISTER_LR,
> +    HV_ARM64_REGISTER_PC,

Why are you placing PC at name[31], given that you have to special case it everywhere else 
below?

> +static int set_standard_regs(const CPUState *cpu)
> +{
> +    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
> +    struct hv_register_assoc *assocs;
> +    int ret;
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +
> +    assocs = g_new0(hv_register_assoc, n_regs);

This is small enough to allocate in the local stack frame.
Same for get_standard_regs.

> +static void populate_standard_regs(const hv_register_assoc *assocs,
> +                                   CPUARMState *env)
> +{
> +    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
> +
> +    for (size_t i = 0; i < n_regs - 1; i++) {
> +        env->xregs[i] = assocs[i].value.reg64;
> +    }
> +
> +    /* Last register is the program counter */
> +    env->pc = assocs[n_regs - 1].value.reg64;
> +}

Why is this separate from get_standard_regs?
You don't have a similar split for set_standard_regs...

> +int mshv_get_standard_regs(CPUState *cpu)

I'll note that this isn't used outside of this file, and similarly for i386/mshv.  It 
doesn't need to be declared globally at all.


r~

