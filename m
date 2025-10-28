Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D512BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeyA-0002dH-0p; Tue, 28 Oct 2025 04:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDey5-0002cd-TF
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:22:14 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vDexz-000396-8x
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761639727; x=1793175727;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dY2iVd/Mn+6MsIGW/ZBQhZZVDr9eenfNUId7Aq8nd1o=;
 b=YVdsvR2EsLYiHfcD58YexZRDjUytA+7jcQDwaago3Rh0jNKRFJN0j8UM
 YY8r/NGT+OMh1WlUMP2hvqZlxohNLAgrUUV7nbpwxK3UNq/66kPRbL6aQ
 im7055/8q7yEHqAl8deH1zPr9CzVWOuAz7XoIrQDUPAEkLWaAYE5IOWWs
 TzJhlIy/AWlD1H6fE3Ar59XMIga3l2YXatByf/lCp5jiwqlBhZA+G9iGA
 qO2dYb4s2fxhAOtP/UpaGVcUiWM/mobM4Q53mBD5WsIU9W/QHzm/C5xpd
 bQCdE0nUggsa7xZDO9EoF0fynubhRz9Qshc1tSJRNoHC7MN2T5NHR6Fsd A==;
X-CSE-ConnectionGUID: bF49kOXIS3+TRBdNd1FPvA==
X-CSE-MsgGUID: Pkj9URr8SQqboocEfgwGaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63633378"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63633378"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:22:03 -0700
X-CSE-ConnectionGUID: Lhk7nHssRn+H6jBPTXySuw==
X-CSE-MsgGUID: 8+Aw1TbUSNS84gBW9effLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189338684"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 01:21:59 -0700
Message-ID: <9c5d49a8-c049-4ab0-bd0a-cc24dbee93f4@intel.com>
Date: Tue, 28 Oct 2025 16:21:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/20] i386/kvm: Add save/load support for
 KVM_REG_GUEST_SSP
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Chao Gao
 <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-15-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251024065632.1448606-15-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.574, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/2025 2:56 PM, Zhao Liu wrote:
> From: Yang Weijiang <weijiang.yang@intel.com>
> 
> CET provides a new architectural register, shadow stack pointer (SSP),
> which cannot be directly encoded as a source, destination or memory
> operand in instructions. But Intel VMCS & VMCB provide fields to
> save/load guest & host's ssp.
> 
> It's necessary to save & load Guest's ssp before & after migration. To
> support this, KVM implements Guest's SSP as a special KVM internal
> register - KVM_REG_GUEST_SSP, and allows QEMU to save & load it via
> KVM_GET_ONE_REG/KVM_SET_ONE_REG.
> 
> Cache KVM_REG_GUEST_SSP in X86CPUState.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Co-developed-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.h     |  1 +
>   target/i386/kvm/kvm.c | 39 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 4edb977575e2..ad4287822831 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2105,6 +2105,7 @@ typedef struct CPUArchState {
>       uint64_t pl2_ssp;
>       uint64_t pl3_ssp;
>       uint64_t int_ssp_table;
> +    uint64_t guest_ssp;
>   
>       /* Fields up to this point are cleared by a CPU reset */
>       struct {} end_reset_fields;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 92c2fd6d6aee..412e99ba5b53 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4280,6 +4280,35 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
>       return kvm_buf_set_msrs(cpu);
>   }
>   
> +static int kvm_put_kvm_regs(X86CPU *cpu)
> +{
> +    CPUX86State *env = &cpu->env;
> +    int ret;
> +
> +    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
> +        ret = kvm_set_one_reg(CPU(cpu), KVM_X86_REG_KVM(KVM_REG_GUEST_SSP),
> +                              &env->guest_ssp);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int kvm_get_kvm_regs(X86CPU *cpu)
> +{
> +    CPUX86State *env = &cpu->env;
> +    int ret;
> +
> +    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK)) {
> +        ret = kvm_get_one_reg(CPU(cpu), KVM_X86_REG_KVM(KVM_REG_GUEST_SSP),
> +                              &env->guest_ssp);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
>   
>   static int kvm_get_xsave(X86CPU *cpu)
>   {
> @@ -5425,6 +5454,11 @@ int kvm_arch_put_registers(CPUState *cpu, KvmPutState level, Error **errp)
>           error_setg_errno(errp, -ret, "Failed to set MSRs");
>           return ret;
>       }
> +    ret = kvm_put_kvm_regs(x86_cpu);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to set KVM type registers");
> +        return ret;
> +    }
>       ret = kvm_put_vcpu_events(x86_cpu, level);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "Failed to set vCPU events");
> @@ -5497,6 +5531,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>           error_setg_errno(errp, -ret, "Failed to get MSRs");
>           goto out;
>       }
> +    ret = kvm_get_kvm_regs(cpu);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to get KVM type registers");
> +        goto out;
> +    }
>       ret = kvm_get_apic(cpu);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret, "Failed to get APIC");


