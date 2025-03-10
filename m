Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E46C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXXk-0002hJ-P4; Mon, 10 Mar 2025 03:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trXXV-0002gL-5g
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:27:07 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trXXP-0003E9-Qm
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741591620; x=1773127620;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dtga0v/Ir792RWLzkgeY1Rc/Z50MXyKQb9VMOzOY2JY=;
 b=BfGJZKgN6IktiXJyMmraUKg9yH+jMs6zPARAKGf0OqDo1gm/qfYtKluf
 OvnYRljY7HLiDZjO1bJstQaKBfox5Aamdr3NMGT/1Bfoi66HWqUUMDwxO
 I4u1dCoC7yPU3nqsMLB6IRktQ/LzBwdZhC/r24VrxU63XwXMaU8K07Py2
 xtCxot0RirNDGfr78+uTqnj7IcE8biexFsZFQRpKNBFVpbKnamb8WHdk1
 9PAgsTw5k1O3mKCwtyzNzDrTFKnBh/uGCMwSy73eXmBto+thGsEqrjxUH
 LoeN6VpyMW7fPtJHidJveK4yfpXAnycIQjovBExASaLGwmQU8XyF4OIGj A==;
X-CSE-ConnectionGUID: TZlIpGnjTrO1i1qf4C0glA==
X-CSE-MsgGUID: //iHjYVeTlOvyVuQyMpmwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42285208"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="42285208"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 00:26:56 -0700
X-CSE-ConnectionGUID: UW5bvEmlSIKwTZYALKXqew==
X-CSE-MsgGUID: mf5ohgmBSwKbuNOWYs58tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="124508499"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2025 00:26:50 -0700
Date: Mon, 10 Mar 2025 15:47:00 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
Message-ID: <Z86Y9BxV6p25A2Wo@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220112.17653-9-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

(+EwanHai for zhaoxin case...)

...

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

I understand we can get family by object_property_get_int() helper:

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4902694129f9..ff08c7bfee6c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2106,27 +2106,22 @@ static void kvm_init_pmu_info_intel(CPUX86State *env)
     }
 }

-static void kvm_init_pmu_info_amd(CPUX86State *env)
+static void kvm_init_pmu_info_amd(X86CPU *cpu)
 {
+    CPUX86State *env = &cpu->env;
     uint32_t eax, ebx, ecx;
     uint32_t unused;
     int64_t family;

     has_pmu_version = 0;

-    /*
-     * To determine the CPU family, the following code is derived from
-     * x86_cpuid_version_get_family().
-     */
-    family = (env->cpuid_version >> 8) & 0xf;
-    if (family == 0xf) {
-        family += (env->cpuid_version >> 20) & 0xff;
+    family = object_property_get_int(OBJECT(cpu), "family", &error_abort);
+    if (family < 0) {
+        return;
     }

-    /*
-     * Performance-monitoring supported from K7 and later.
-     */
     if (family < 6) {
+        error_report("AMD performance-monitoring is supported from K7 and later")
         return;
     }

@@ -2197,7 +2192,7 @@ static void kvm_init_pmu_info(CPUState *cs)
     if (IS_INTEL_CPU(env)) {
         kvm_init_pmu_info_intel(env);
     } else if (IS_AMD_CPU(env)) {
-        kvm_init_pmu_info_amd(env);
+        kvm_init_pmu_info_amd(cpu);
     }
 }

---
Then for consistency, kvm_init_pmu_info_intel() could also accept
"X86CPU *cpu" as the argument.

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

...

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

As I said in patch 7, we could return an error instead.

> +    /*
> +     * It is not supported to virtualize AMD PMU registers on Intel
> +     * processors, nor to virtualize Intel PMU registers on AMD processors.
> +     */
> +    if (!is_same_vendor(env)) {

Here it deserves a warning like:

error_report("host doesn't support requested feature: vPMU\n");

> +        return;
> +    }
>
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

Could we only check "cpu->enable_pmu" at the beginning of this function?
then if pmu is already disabled, we don't need to initialize the pmu info.

> +    if (IS_INTEL_CPU(env)) {

Zhaoxin also supports architectural PerfMon in 0xa.

I'm not sure if this check should also involve Zhaoxin CPU, so cc
zhaoxin guys for double check.

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

ditto.

>              if (has_pmu_version > 1) {
>                  /* Stop the counter.  */
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> @@ -4095,6 +4183,38 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>                                    env->msr_global_ctrl);
>              }
>          }
> +

...

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

ditto.

>          if (has_pmu_version > 1) {
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
> @@ -4558,6 +4679,35 @@ static int kvm_get_msrs(X86CPU *cpu)
>          }
>      }
>

Thanks,
Zhao



