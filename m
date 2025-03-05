Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB3FC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjFv-0006lB-DO; Wed, 05 Mar 2025 02:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tpjFs-0006kq-0o
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:33:24 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tpjFp-00056G-A6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741160001; x=1772696001;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KeOlT8gHm5Ta6pFCUJc5qwT0LHx0Q/LUtX/54yZDZdc=;
 b=UmpvEbEmRuCVG0SrPR/RSSw21Y5CiaW9rJgpykcT5ct8ylBTvEi1+H1V
 qBVpNTnvlhKC4lC3mXb4bz1shid1NFAGQDbjxigNAJ45P8jmTmJKjUt0u
 Yyo2RV6n4tJbyMM8r7Im7VZyjsiJUqY5gg4WC9kX2zNytXoPKNmCkQNAN
 4d+MBxIPD/EywxRmBcL+KcXqmecck//qwYcAgF8aRNNdC2sApr44P4M0+
 cMmZOozByfPxPXCCFxJaLL7nGujamil6WQQ1M9mbDgB1QqZAQr9PoJIJe
 HeyBw/UnM1e0H7sS1aFNFzKM9UWsb/LuR575pe7RlKBjopKtVy49X8MdL Q==;
X-CSE-ConnectionGUID: 7qNMnEnfSqabI7dzwKwhaw==
X-CSE-MsgGUID: 7BTa+S8pSPiPG6aW/kHXnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52746497"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="52746497"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 23:33:18 -0800
X-CSE-ConnectionGUID: icbHFNd+RhO/Be2+TyGJ5A==
X-CSE-MsgGUID: JpHkFnC7QwmhTQV+61aGOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="149568964"
Received: from unknown (HELO [10.238.2.135]) ([10.238.2.135])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 23:33:15 -0800
Message-ID: <7aed3b14-d81c-441b-a092-d9be9f81c90c@linux.intel.com>
Date: Wed, 5 Mar 2025 15:33:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250302220112.17653-9-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 3/3/2025 6:00 AM, Dongli Zhang wrote:
> QEMU uses the kvm_get_msrs() function to save Intel PMU registers from KVM
> and kvm_put_msrs() to restore them to KVM. However, there is no support for
> AMD PMU registers. Currently, has_pmu_version and num_pmu_gp_counters are
> initialized based on cpuid(0xa), which does not apply to AMD processors.
> For AMD CPUs, prior to PerfMonV2, the number of general-purpose registers
> is determined based on the CPU version.
>
> To address this issue, we need to add support for AMD PMU registers.
> Without this support, the following problems can arise:
>
> 1. If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
> running "perf top", the PMU registers are not disabled properly.
>
> 2. Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
> does not handle AMD PMU registers, causing some PMU events to remain
> enabled in KVM.
>
> 3. The KVM kvm_pmc_speculative_in_use() function consistently returns true,
> preventing the reclamation of these events. Consequently, the
> kvm_pmc->perf_event remains active.
>
> 4. After a reboot, the VM kernel may report the following error:
>
> [    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
> [    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)
>
> 5. In the worst case, the active kvm_pmc->perf_event may inject unknown
> NMIs randomly into the VM kernel:
>
> [...] Uhhuh. NMI received for unknown reason 30 on CPU 0.
>
> To resolve these issues, we propose resetting AMD PMU registers during the
> VM reset process.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - Modify "MSR_K7_EVNTSEL0 + 3" and "MSR_K7_PERFCTR0 + 3" by using
>     AMD64_NUM_COUNTERS (suggested by Sandipan Das).
>   - Use "AMD64_NUM_COUNTERS_CORE * 2 - 1", not "MSR_F15H_PERF_CTL0 + 0xb".
>     (suggested by Sandipan Das).
>   - Switch back to "-pmu" instead of using a global "pmu-cap-disabled".
>   - Don't initialize PMU info if kvm.enable_pmu=N.
>
>  target/i386/cpu.h     |   8 ++
>  target/i386/kvm/kvm.c | 173 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 177 insertions(+), 4 deletions(-)
>
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c67b42d34f..319600672b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -490,6 +490,14 @@ typedef enum X86Seg {
>  #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
>  #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
>  
> +#define MSR_K7_EVNTSEL0                 0xc0010000
> +#define MSR_K7_PERFCTR0                 0xc0010004
> +#define MSR_F15H_PERF_CTL0              0xc0010200
> +#define MSR_F15H_PERF_CTR0              0xc0010201
> +
> +#define AMD64_NUM_COUNTERS              4
> +#define AMD64_NUM_COUNTERS_CORE         6
> +
>  #define MSR_MC0_CTL                     0x400
>  #define MSR_MC0_STATUS                  0x401
>  #define MSR_MC0_ADDR                    0x402
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index efba3ae7a4..d4be8a0d2e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2069,7 +2069,7 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>      return 0;
>  }
>  
> -static void kvm_init_pmu_info(CPUX86State *env)
> +static void kvm_init_pmu_info_intel(CPUX86State *env)
>  {
>      uint32_t eax, edx;
>      uint32_t unused;
> @@ -2106,6 +2106,94 @@ static void kvm_init_pmu_info(CPUX86State *env)
>      }
>  }
>  
> +static void kvm_init_pmu_info_amd(CPUX86State *env)
> +{
> +    uint32_t unused;
> +    int64_t family;
> +    uint32_t ecx;
> +
> +    has_pmu_version = 0;
> +
> +    /*
> +     * To determine the CPU family, the following code is derived from
> +     * x86_cpuid_version_get_family().
> +     */
> +    family = (env->cpuid_version >> 8) & 0xf;
> +    if (family == 0xf) {
> +        family += (env->cpuid_version >> 20) & 0xff;
> +    }
> +
> +    /*
> +     * Performance-monitoring supported from K7 and later.
> +     */
> +    if (family < 6) {
> +        return;
> +    }
> +
> +    has_pmu_version = 1;
> +
> +    cpu_x86_cpuid(env, 0x80000001, 0, &unused, &unused, &ecx, &unused);
> +
> +    if (!(ecx & CPUID_EXT3_PERFCORE)) {
> +        num_pmu_gp_counters = AMD64_NUM_COUNTERS;
> +        return;
> +    }
> +
> +    num_pmu_gp_counters = AMD64_NUM_COUNTERS_CORE;
> +}
> +
> +static bool is_same_vendor(CPUX86State *env)
> +{
> +    static uint32_t host_cpuid_vendor1;
> +    static uint32_t host_cpuid_vendor2;
> +    static uint32_t host_cpuid_vendor3;
> +
> +    host_cpuid(0x0, 0, NULL, &host_cpuid_vendor1, &host_cpuid_vendor3,
> +               &host_cpuid_vendor2);
> +
> +    return env->cpuid_vendor1 == host_cpuid_vendor1 &&
> +           env->cpuid_vendor2 == host_cpuid_vendor2 &&
> +           env->cpuid_vendor3 == host_cpuid_vendor3;
> +}
> +
> +static void kvm_init_pmu_info(CPUState *cs)
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +
> +    /*
> +     * The PMU virtualization is disabled by kvm.enable_pmu=N.
> +     */
> +    if (kvm_pmu_disabled) {
> +        return;
> +    }
> +
> +    /*
> +     * It is not supported to virtualize AMD PMU registers on Intel
> +     * processors, nor to virtualize Intel PMU registers on AMD processors.
> +     */
> +    if (!is_same_vendor(env)) {
> +        return;
> +    }
> +
> +    /*
> +     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
> +     * disable the AMD pmu virtualization.
> +     *
> +     * If KVM_CAP_PMU_CAPABILITY is supported !cpu->enable_pmu
> +     * indicates the KVM has already disabled the PMU virtualization.
> +     */
> +    if (has_pmu_cap && !cpu->enable_pmu) {
> +        return;
> +    }
> +
> +    if (IS_INTEL_CPU(env)) {
> +        kvm_init_pmu_info_intel(env);
> +    } else if (IS_AMD_CPU(env)) {
> +        kvm_init_pmu_info_amd(env);
> +    }
> +}
> +
>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      struct {
> @@ -2288,7 +2376,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
>      cpuid_data.cpuid.nent = cpuid_i;
>  
> -    kvm_init_pmu_info(env);
> +    kvm_init_pmu_info(cs);
>  
>      if (((env->cpuid_version >> 8)&0xF) >= 6
>          && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
> @@ -4064,7 +4152,7 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>              kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
>          }
>  
> -        if (has_pmu_version > 0) {
> +        if (IS_INTEL_CPU(env) && has_pmu_version > 0) {
>              if (has_pmu_version > 1) {
>                  /* Stop the counter.  */
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> @@ -4095,6 +4183,38 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>                                    env->msr_global_ctrl);
>              }
>          }
> +
> +        if (IS_AMD_CPU(env) && has_pmu_version > 0) {
> +            uint32_t sel_base = MSR_K7_EVNTSEL0;
> +            uint32_t ctr_base = MSR_K7_PERFCTR0;
> +            /*
> +             * The address of the next selector or counter register is
> +             * obtained by incrementing the address of the current selector
> +             * or counter register by one.
> +             */
> +            uint32_t step = 1;
> +
> +            /*
> +             * When PERFCORE is enabled, AMD PMU uses a separate set of
> +             * addresses for the selector and counter registers.
> +             * Additionally, the address of the next selector or counter
> +             * register is determined by incrementing the address of the
> +             * current register by two.
> +             */
> +            if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
> +                sel_base = MSR_F15H_PERF_CTL0;
> +                ctr_base = MSR_F15H_PERF_CTR0;
> +                step = 2;
> +            }
> +
> +            for (i = 0; i < num_pmu_gp_counters; i++) {
> +                kvm_msr_entry_add(cpu, ctr_base + i * step,
> +                                  env->msr_gp_counters[i]);
> +                kvm_msr_entry_add(cpu, sel_base + i * step,
> +                                  env->msr_gp_evtsel[i]);
> +            }
> +        }
> +
>          /*
>           * Hyper-V partition-wide MSRs: to avoid clearing them on cpu hot-add,
>           * only sync them to KVM on the first cpu
> @@ -4542,7 +4662,8 @@ static int kvm_get_msrs(X86CPU *cpu)
>      if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
>          kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
>      }
> -    if (has_pmu_version > 0) {
> +
> +    if (IS_INTEL_CPU(env) && has_pmu_version > 0) {
>          if (has_pmu_version > 1) {
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
> @@ -4558,6 +4679,35 @@ static int kvm_get_msrs(X86CPU *cpu)
>          }
>      }
>  
> +    if (IS_AMD_CPU(env) && has_pmu_version > 0) {
> +        uint32_t sel_base = MSR_K7_EVNTSEL0;
> +        uint32_t ctr_base = MSR_K7_PERFCTR0;
> +        /*
> +         * The address of the next selector or counter register is
> +         * obtained by incrementing the address of the current selector
> +         * or counter register by one.
> +         */
> +        uint32_t step = 1;
> +
> +        /*
> +         * When PERFCORE is enabled, AMD PMU uses a separate set of
> +         * addresses for the selector and counter registers.
> +         * Additionally, the address of the next selector or counter
> +         * register is determined by incrementing the address of the
> +         * current register by two.
> +         */
> +        if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
> +            sel_base = MSR_F15H_PERF_CTL0;
> +            ctr_base = MSR_F15H_PERF_CTR0;
> +            step = 2;
> +        }
> +
> +        for (i = 0; i < num_pmu_gp_counters; i++) {
> +            kvm_msr_entry_add(cpu, ctr_base + i * step, 0);
> +            kvm_msr_entry_add(cpu, sel_base + i * step, 0);
> +        }
> +    }
> +
>      if (env->mcg_cap) {
>          kvm_msr_entry_add(cpu, MSR_MCG_STATUS, 0);
>          kvm_msr_entry_add(cpu, MSR_MCG_CTL, 0);
> @@ -4869,6 +5019,21 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
>              env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
>              break;
> +        case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL0 + AMD64_NUM_COUNTERS - 1:
> +            env->msr_gp_evtsel[index - MSR_K7_EVNTSEL0] = msrs[i].data;
> +            break;
> +        case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR0 + AMD64_NUM_COUNTERS - 1:
> +            env->msr_gp_counters[index - MSR_K7_PERFCTR0] = msrs[i].data;
> +            break;
> +        case MSR_F15H_PERF_CTL0 ...
> +             MSR_F15H_PERF_CTL0 + AMD64_NUM_COUNTERS_CORE * 2 - 1:
> +            index = index - MSR_F15H_PERF_CTL0;
> +            if (index & 0x1) {
> +                env->msr_gp_counters[index] = msrs[i].data;
> +            } else {
> +                env->msr_gp_evtsel[index] = msrs[i].data;
> +            }
> +            break;
>          case HV_X64_MSR_HYPERCALL:
>              env->msr_hv_hypercall = msrs[i].data;
>              break;

LGTM, but leave it to AMD PMU expert to review.



