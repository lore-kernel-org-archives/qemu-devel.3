Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3350FC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYL4-0002te-4H; Thu, 18 Jul 2024 17:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYL1-0002tA-Ol
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:06:56 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYKz-0006na-3e
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721336813; x=1752872813;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vAaCHtwYnbkbBkOZZEJdDXWbZZGdjgoy0QnEu92hXnc=;
 b=Ph+A/7fPrbXuKX7H48dh0B4iycKd0TEX6f/Z1YcV1qZcL9eN6Y+XoM0m
 mys6ZsTQjOw1P1NUz7yTHEBiA6Pi/ayl7OMDm18nXboZr5abE4uIr3Ohq
 ncl9QJk65vA9GBWYX2qtPj4fZegdc8q1Wzm0b+1GO/F/PT8ljlUItQhBc
 lM0CFHe2TVjU0+q+NZ7LDJiQ6zQmjRda0FgHExgPrYDztWwfl8vsrYJ0q
 oYgaBkGFVTiG4SrWqP3Yuhw8Xf0iNHYN2NuQI8HjeXE+d18AecHHYutqx
 j5b2i+wEQRvMjLzsOKZo3PRa6ddnPnJm/8zGWl7SD8r6aFCHe3uRceRyq Q==;
X-CSE-ConnectionGUID: QkyGW5tlRPeQc1E/rPZ51w==
X-CSE-MsgGUID: GTM9n757Q9ivM504IdYdjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="21831244"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="21831244"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:06:43 -0700
X-CSE-ConnectionGUID: Ir5Vn0A3QQmNkHzVwzzhaQ==
X-CSE-MsgGUID: 48JvaiOcSYmldTGN/ItyFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="55178660"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 14:06:43 -0700
Message-ID: <fe4d90aa-144c-46b6-bb7c-00133c10fc16@intel.com>
Date: Thu, 18 Jul 2024 14:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] target/i386/kvm: Add feature bit definitions for
 KVM CPUID
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-2-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-2-zhao1.liu@intel.com>
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
> Add feature definitions for KVM_CPUID_FEATURES in CPUID (
> CPUID[4000_0001].EAX and CPUID[4000_0001].EDX), to get rid of lots of
> offset calculations.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: zide.chen@intel.com


> ---
> v3: Resolved a rebasing conflict.
> v2: Changed the prefix from CPUID_FEAT_KVM_* to CPUID_KVM_*. (Xiaoyao)
> ---
>  hw/i386/kvm/clock.c   |  5 ++---
>  target/i386/cpu.h     | 23 +++++++++++++++++++++++
>  target/i386/kvm/kvm.c | 28 ++++++++++++++--------------
>  3 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 40aa9a32c32c..ce416c05a3d0 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -27,7 +27,6 @@
>  #include "qapi/error.h"
>  
>  #include <linux/kvm.h>
> -#include "standard-headers/asm-x86/kvm_para.h"
>  #include "qom/object.h"
>  
>  #define TYPE_KVM_CLOCK "kvmclock"
> @@ -334,8 +333,8 @@ void kvmclock_create(bool create_always)
>  
>      assert(kvm_enabled());
>      if (create_always ||
> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
> +        cpu->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
> +                                       CPUID_KVM_CLOCK2)) {
>          sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>      }
>  }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c43ac01c794a..b59bdc1c9d9d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -28,6 +28,7 @@
>  #include "qapi/qapi-types-common.h"
>  #include "qemu/cpu-float.h"
>  #include "qemu/timer.h"
> +#include "standard-headers/asm-x86/kvm_para.h"
>  
>  #define XEN_NR_VIRQS 24
>  
> @@ -988,6 +989,28 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
>  #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
>  
> +/* (Old) KVM paravirtualized clocksource */
> +#define CPUID_KVM_CLOCK            (1U << KVM_FEATURE_CLOCKSOURCE)
> +/* (New) KVM specific paravirtualized clocksource */
> +#define CPUID_KVM_CLOCK2           (1U << KVM_FEATURE_CLOCKSOURCE2)
> +/* KVM asynchronous page fault */
> +#define CPUID_KVM_ASYNCPF          (1U << KVM_FEATURE_ASYNC_PF)
> +/* KVM stolen (when guest vCPU is not running) time accounting */
> +#define CPUID_KVM_STEAL_TIME       (1U << KVM_FEATURE_STEAL_TIME)
> +/* KVM paravirtualized end-of-interrupt signaling */
> +#define CPUID_KVM_PV_EOI           (1U << KVM_FEATURE_PV_EOI)
> +/* KVM paravirtualized spinlocks support */
> +#define CPUID_KVM_PV_UNHALT        (1U << KVM_FEATURE_PV_UNHALT)
> +/* KVM host-side polling on HLT control from the guest */
> +#define CPUID_KVM_POLL_CONTROL     (1U << KVM_FEATURE_POLL_CONTROL)
> +/* KVM interrupt based asynchronous page fault*/
> +#define CPUID_KVM_ASYNCPF_INT      (1U << KVM_FEATURE_ASYNC_PF_INT)
> +/* KVM 'Extended Destination ID' support for external interrupts */
> +#define CPUID_KVM_MSI_EXT_DEST_ID  (1U << KVM_FEATURE_MSI_EXT_DEST_ID)
> +
> +/* Hint to KVM that vCPUs expect never preempted for an unlimited time */
> +#define CPUID_KVM_HINTS_REALTIME    (1U << KVM_HINTS_REALTIME)
> +
>  /* CLZERO instruction */
>  #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
>  /* Always save/restore FP error pointers */
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index becca2efa5b4..86e42beb78bf 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -539,13 +539,13 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>           * be enabled without the in-kernel irqchip
>           */
>          if (!kvm_irqchip_in_kernel()) {
> -            ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
> +            ret &= ~CPUID_KVM_PV_UNHALT;
>          }
>          if (kvm_irqchip_is_split()) {
> -            ret |= 1U << KVM_FEATURE_MSI_EXT_DEST_ID;
> +            ret |= CPUID_KVM_MSI_EXT_DEST_ID;
>          }
>      } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
> -        ret |= 1U << KVM_HINTS_REALTIME;
> +        ret |= CPUID_KVM_HINTS_REALTIME;
>      }
>  
>      if (current_machine->cgs) {
> @@ -3424,20 +3424,20 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>          kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
>          kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
>          kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
> +        if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
>              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
>          }
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> +        if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF) {
>              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
>          }
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
> +        if (env->features[FEAT_KVM] & CPUID_KVM_PV_EOI) {
>              kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, env->pv_eoi_en_msr);
>          }
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
> +        if (env->features[FEAT_KVM] & CPUID_KVM_STEAL_TIME) {
>              kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, env->steal_time_msr);
>          }
>  
> -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
> +        if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
>              kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
>          }
>  
> @@ -3900,19 +3900,19 @@ static int kvm_get_msrs(X86CPU *cpu)
>  #endif
>      kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
>      kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF_INT)) {
> +    if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
>          kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
>      }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> +    if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF) {
>          kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, 0);
>      }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
> +    if (env->features[FEAT_KVM] & CPUID_KVM_PV_EOI) {
>          kvm_msr_entry_add(cpu, MSR_KVM_PV_EOI_EN, 0);
>      }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_STEAL_TIME)) {
> +    if (env->features[FEAT_KVM] & CPUID_KVM_STEAL_TIME) {
>          kvm_msr_entry_add(cpu, MSR_KVM_STEAL_TIME, 0);
>      }
> -    if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_POLL_CONTROL)) {
> +    if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
>          kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
>      }
>      if (has_architectural_pmu_version > 0) {
> @@ -5613,7 +5613,7 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address)
>          return address;
>      }
>      env = &X86_CPU(first_cpu)->env;
> -    if (!(env->features[FEAT_KVM] & (1 << KVM_FEATURE_MSI_EXT_DEST_ID))) {
> +    if (!(env->features[FEAT_KVM] & CPUID_KVM_MSI_EXT_DEST_ID)) {
>          return address;
>      }
>  

