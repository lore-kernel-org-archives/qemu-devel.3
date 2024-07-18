Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECCAC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYOL-0003Lw-P0; Thu, 18 Jul 2024 17:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOK-0003Im-1x
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:20 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOH-0007c1-3E
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721337017; x=1752873017;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Mu/jPdIQGHsNBN8Hn15TYNmcUp3/Eqvt1Dx7g67c8FI=;
 b=Dt6MefQyWF2CftGzKAofriY+kG3NIp1Tg2Kps5FAGuqMRRNHcYIQDN1r
 7ZZOLLeOnZzvqTqihxUZjD7ZOiFdZm/eYuOfBH6acOt832Kr6S7dW67PJ
 MEER23C8qRusTvFU3PqJJB/04TngzfD4APY82FOjsJBjZKjCqj9BgCmlx
 4wQdsxkk9gSXR/Wte+E8bppvmF9+vcpTv2xy5++L2nzYO71EDZSaZRQka
 kUxqBkgcDcnD7DnWnxEH5j02qm+BMU3jf89ouebSBS2RDVHiFQL0zyWRF
 mq7+ygmfcYbBLaZJDYk5WwF6BKmuKdI8Mw47uv40UG96cEgDXSJMmFAvX w==;
X-CSE-ConnectionGUID: a825Gh4RTW2vbCjhKgwSow==
X-CSE-MsgGUID: k6DaMfnHSnCLxU5zWHDScQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="21831710"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="21831710"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:10:15 -0700
X-CSE-ConnectionGUID: aXW8prndTe2V2GTOZUC36A==
X-CSE-MsgGUID: E6OJ4AytS2mYQBfS9lDnFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="55179108"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 14:10:15 -0700
Message-ID: <13e03ddc-d6e3-47a6-bb1a-2b6cbd57e1a7@intel.com>
Date: Thu, 18 Jul 2024 14:10:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] target/i386/kvm: Save/load MSRs of kvmclock2
 (KVM_FEATURE_CLOCKSOURCE2)
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-5-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 7/16/2024 9:10 AM, Zhao Liu wrote:
> MSR_KVM_SYSTEM_TIME_NEW and MSR_KVM_WALL_CLOCK_NEW are bound to
> kvmclock2 (KVM_FEATURE_CLOCKSOURCE2).
> 
> Add the save/load support for these 2 MSRs just like kvmclock MSRs.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zide Chen <zide.chen@intel.com>

> ---
>  target/i386/cpu.h     |  2 ++
>  target/i386/kvm/kvm.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index b59bdc1c9d9d..35dc68631989 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1826,6 +1826,8 @@ typedef struct CPUArchState {
>  
>      uint64_t system_time_msr;
>      uint64_t wall_clock_msr;
> +    uint64_t system_time_new_msr;
> +    uint64_t wall_clock_new_msr;
>      uint64_t steal_time_msr;
>      uint64_t async_pf_en_msr;
>      uint64_t async_pf_int_msr;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index ac434e83b64c..64e54beac7b3 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3423,6 +3423,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>              kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
>              kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
>          }
> +        if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK2) {
> +            kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME_NEW,
> +                              env->system_time_new_msr);
> +            kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK_NEW,
> +                              env->wall_clock_new_msr);
> +        }
>          if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
>              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
>          }
> @@ -3901,6 +3907,10 @@ static int kvm_get_msrs(X86CPU *cpu)
>          kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
>          kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
>      }
> +    if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK2) {
> +        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME_NEW, 0);
> +        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK_NEW, 0);
> +    }
>      if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
>          kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
>      }
> @@ -4167,6 +4177,12 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_KVM_WALL_CLOCK:
>              env->wall_clock_msr = msrs[i].data;
>              break;
> +        case MSR_KVM_SYSTEM_TIME_NEW:
> +            env->system_time_new_msr = msrs[i].data;
> +            break;
> +        case MSR_KVM_WALL_CLOCK_NEW:
> +            env->wall_clock_new_msr = msrs[i].data;
> +            break;
>          case MSR_MCG_STATUS:
>              env->mcg_status = msrs[i].data;
>              break;

