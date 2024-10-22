Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5226CDD0CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 18:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3K1S-0007h1-EF; Tue, 22 Oct 2024 14:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3K1O-0007gI-Sq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:54:23 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3K1M-0004Uy-G4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 14:54:22 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7eab7622b61so4181719a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729623258; x=1730228058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jRPX6N1Lr33v+7DIkV3DeyxdurCpElPS6NcFAh/nlfo=;
 b=k+sMkZ7/Ci8ZP9zfPV8vVK0keQ/eGV2mMluzmzU7M+PBQuglNAM3YNMcG+5SJyDvBG
 uP38IYAP5lfnBjDuwh424ZHuqI529ONYgmaaNfXAApkiYc1Hpu9G1y+1q/W4nBRxuT4U
 XGXBHQlS/iiUoc6yl0RTUHUrG7XhhqdxqFKOEgW54mnZaLDMkhclyOWdbRm2N2I35Y6F
 61uVzW2IIapw/zPRNH4LRPODuWkvrA1j/ElRyDNBSEJNhSy1JiiUznu14iHyZVxaoYZD
 k8qmsQ0E/yCgNWEswyK7TzG1dALO74Ni9Vh8flKiwrjZh3CFxcCoITzcjJWWv1WMVzD8
 fANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729623258; x=1730228058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jRPX6N1Lr33v+7DIkV3DeyxdurCpElPS6NcFAh/nlfo=;
 b=SzAEX7/kUkbPISasgeq646VPB89aqmoFBo8ZUEypJWMn4U10inlXSvz0/7FOflY/P+
 5c3pDFjdU5rE4GoF77YQfByGPE6ppAUJ1LVJ5JTYxifFZI/ucRPU9cHNaCghPOaBf/zG
 3Y9fxetykcNQ9jGNjAx2G6xq0/x8XPNqBR/ie8pkQ+rAHvlIg3KcGTrg2aL4Rg/oLCZM
 IzkbgbQxatU5YcO2flLWohmBo2yn6gIHWNiozc9HCsCfncMBSgTLsyytJGXj4VwZDho+
 ZyNCYJOdDiy1R9L+dmltuXLtvyWdpA/dNy7kKQMzomcl7RZxvU9z1nYPfbfdKRZ20wqU
 FObQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4fIRNVEHmaP+Zc9YSh+WtL3K+mx8XBzyvP1OSrGDIFz24E2UrTcG7J0zFHJSrUl6NcjnRrGuJ/RIG@nongnu.org
X-Gm-Message-State: AOJu0YwgUup1iFUn6Wg1njlJBcZi3CFM4nxGmPQ7EIYnrqN6tBeCKYUO
 cDqP+PNMphHh86xPmgJ8mKbfn7uTtiHJHftKJtWE40RK3hdxRTnwfxcXJmOKwNZ3K2tB3FXtS52
 5
X-Google-Smtp-Source: AGHT+IFeRdTQA64mQGSXf8anUVF0o+s/m8eWY+sT/XqxVeW73xE9fTRTYpKupg63fMqboVSkAr+uSg==
X-Received: by 2002:a05:6a21:1304:b0:1d7:3d:6008 with SMTP id
 adf61e73a8af0-1d978b12ed4mr4695637.13.1729623258335; 
 Tue, 22 Oct 2024 11:54:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec132fef0sm5091456b3a.63.2024.10.22.11.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 11:54:18 -0700 (PDT)
Message-ID: <51c9f589-5ceb-42c0-8d02-b1a838141f55@linaro.org>
Date: Tue, 22 Oct 2024 11:54:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Use physical cpu id about CSR CPUID for
 sysemu
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20241022124247.873232-1-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241022124247.873232-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 10/22/24 05:42, Bibo Mao wrote:
> For user tcg, there is no physical cpu id provided and logic cpuid
> is used. For system emulation, physical cpu id is provided, initial
> value of register CSR CPUID can be set from physical cpu id.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_ipi.c           | 3 ++-
>   target/loongarch/cpu.c            | 7 ++++++-
>   target/loongarch/tcg/csr_helper.c | 4 ----
>   3 files changed, 8 insertions(+), 6 deletions(-)

Since cpu_index is arbitrary and assigned by hw/loongarch/virt.c anyway, why do these two 
values differ?  Surely arch_id is already unique per cpu?


r~


> 
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index 2ae1a42c46..78b6fce81b 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -42,7 +42,8 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
>       CPUArchId *archid;
>   
>       archid = find_cpu_by_archid(machine, arch_id);
> -    if (archid) {
> +    /* For offlined cpus, archid->cpu may be NULL */
> +    if (archid && archid->cpu) {
>           return CPU(archid->cpu);
>       }
>   
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 7212fb5f8f..d4659e8d45 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -510,8 +510,10 @@ static void loongarch_max_initfn(Object *obj)
>   static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>   {
>       CPUState *cs = CPU(obj);
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>       LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
>       CPULoongArchState *env = cpu_env(cs);
> +    int n;
>   
>       if (lacc->parent_phases.hold) {
>           lacc->parent_phases.hold(obj, type);
> @@ -522,7 +524,6 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>   #endif
>       env->fcsr0 = 0x0;
>   
> -    int n;
>       /* Set csr registers value after reset, see the manual 6.4. */
>       env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
>       env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
> @@ -543,7 +544,11 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>   
>       env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
>       env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
> +#ifndef CONFIG_USER_ONLY
> +    env->CSR_CPUID = cpu->phy_id;
> +#else
>       env->CSR_CPUID = cs->cpu_index;
> +#endif
>       env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
>       env->CSR_LLBCTL = FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
>       env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 15f94caefa..2aeca2343d 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -37,10 +37,6 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>   
>   target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
>   {
> -    LoongArchCPU *lac = env_archcpu(env);
> -
> -    env->CSR_CPUID = CPU(lac)->cpu_index;
> -
>       return env->CSR_CPUID;
>   }
>   
> 
> base-commit: cc5adbbd50d81555b8eb73602ec16fde40b55be4


