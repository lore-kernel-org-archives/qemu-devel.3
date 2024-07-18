Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D981C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYO9-00038v-49; Thu, 18 Jul 2024 17:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYO7-00038L-R2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:07 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYO6-0007aX-5P
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721337006; x=1752873006;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lP4GxxkF/SjGcy24DAmJFjrxoGFi/IJ2iaI63uiNFtI=;
 b=Zo2AjLKyrOZMVmHcrlSkB3A/ctYia83dylxmk0hH7MlBg5PmUYQ4QIO8
 QzYYxGwInTC9McHwIOk/fmX5i6H0Js4TjXLNeIAxbLV1MiL+x09xjqYoA
 VscqQuF7O/vpgdxlTtnTh4TcmzFr6wITMcVN5vzQMSMQrRq6habQDLQjB
 WTjW8lixIUoR7Sx8NicgjA7XaNxicU7HKVfFi3hwMg8a52u+nHRL9UMWf
 07cojhnhbMcO2aCkcXrJqZAUdfRYrSCRVtOX3ao1XvOx9abp2UhSJGm4J
 S9Tnk6SORsq4GU/hZc//QK/NQaCd+QeeU6AWUN+UFSkyPJZcvEdZKcWqt A==;
X-CSE-ConnectionGUID: Fpqc9jQ/QpqQtquk/xe4mA==
X-CSE-MsgGUID: L4VcuckXTDOZSHgAh3GUHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="21831680"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="21831680"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:10:04 -0700
X-CSE-ConnectionGUID: 6UCt2pXZQkmkUPbzUyLDKg==
X-CSE-MsgGUID: 1tSgln86RBOP8GmMhUTd2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="55179092"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 14:10:04 -0700
Message-ID: <bc4daffc-0fcc-4e24-9472-0b18f6189f83@intel.com>
Date: Thu, 18 Jul 2024 14:10:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] target/i386/kvm: Only save/load kvmclock MSRs when
 kvmclock enabled
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-4-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-4-zhao1.liu@intel.com>
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
> MSR_KVM_SYSTEM_TIME and MSR_KVM_WALL_CLOCK are attached with the (old)
> kvmclock feature (KVM_FEATURE_CLOCKSOURCE).
> 
> So, just save/load them only when kvmclock (KVM_FEATURE_CLOCKSOURCE) is
> enabled.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

 Reviewed-by: Zide Chen <zide.chen@intel.com>


> ---
>  target/i386/kvm/kvm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 6ad5a7dbf1fd..ac434e83b64c 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3419,8 +3419,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>       */
>      if (level >= KVM_PUT_RESET_STATE) {
>          kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
> -        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
> -        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
> +        if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK) {
> +            kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
> +            kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
> +        }
>          if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
>              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
>          }
> @@ -3895,8 +3897,10 @@ static int kvm_get_msrs(X86CPU *cpu)
>          }
>      }
>  #endif
> -    kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
> -    kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
> +    if (env->features[FEAT_KVM] & CPUID_KVM_CLOCK) {
> +        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
> +        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
> +    }
>      if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
>          kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
>      }

