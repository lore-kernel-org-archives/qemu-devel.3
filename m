Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD3EC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqTUa-0006fq-BN; Fri, 07 Mar 2025 03:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqTUY-0006fh-T2
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:55:39 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqTUV-00022Z-BT
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 03:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741337735; x=1772873735;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RpN/LeNWfGyP6YXcs9FmCYAJxwp+Z5cSq5y5kR3MKmw=;
 b=Gvx3CdWvGlrYvQJLL8sPHKnewXAyHigChSyIlqYuT0YJC4/DnXMBMaKU
 s96AjykxWQ9xKouG8676yMx35opkVrp9Ct6g3LeteluVcG+dwPaj7qALM
 Hhj2seqxnCqCeZuFwCVjIFQIjjSjHzBxQUz//FrMSWDzoscra7tEBjcgm
 Pez4JlLPXgoYG1KEncZ1MPO+E9BWqNB00t9WKV+gvi7Tl4ghOUMkeJPFv
 e1vDYH524z6Dj79RkBLrTkVQclbfz+A9wdHTuj6TYK+KL4k8nUHe84BH1
 E+4d52MBQ0QBTz40aSHqxAtQG9d8JVcfhahhLWGcgemfJQXaajk1ocgdm w==;
X-CSE-ConnectionGUID: mD2BNG5CQfaEGixPsjaJoA==
X-CSE-MsgGUID: uNA1CVVMQjK9eg+d0kPTkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="29961615"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="29961615"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2025 00:55:31 -0800
X-CSE-ConnectionGUID: bm/QiMATQDK5kl9bpcb14Q==
X-CSE-MsgGUID: c+VQWqPuQSmOZZgXgIJGBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119789356"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 07 Mar 2025 00:55:24 -0800
Date: Fri, 7 Mar 2025 17:15:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 05/10] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
Message-ID: <Z8q5NHQeIgXxTmPO@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-6-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220112.17653-6-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

> +static void kvm_init_pmu_info(CPUX86State *env)
> +{
> +    uint32_t eax, edx;
> +    uint32_t unused;
> +    uint32_t limit;
> +
> +    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);

At this stage, CPUID has already been filled and we should not use
cpu_x86_cpuid() to get the "raw" CPUID info.

Instead, after kvm_x86_build_cpuid(), the cpuid_find_entry() helper
should be preferred.

With cpuid_find_entry(), we don't even need to check the limit again.

> +
> +    if (limit < 0x0a) {
> +        return;
> +    }

...

>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      struct {
> @@ -2267,6 +2277,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
>      cpuid_data.cpuid.nent = cpuid_i;
>  
> +    kvm_init_pmu_info(env);
> +

Referring what has_msr_feature_control did, what about the following
change?

 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
@@ -2277,8 +2240,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;

-    kvm_init_pmu_info(env);
-
     if (((env->cpuid_version >> 8)&0xF) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
            (CPUID_MCE | CPUID_MCA)) {
@@ -2329,6 +2290,31 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_feature_control = true;
     }

+    c = cpuid_find_entry(&cpuid_data.cpuid, 0xa, 0);
+    if (c) {
+        has_architectural_pmu_version = c->eax & 0xff;
+        if (has_architectural_pmu_version > 0) {
+            num_architectural_pmu_gp_counters = (c->eax & 0xff00) >> 8;
+
+            /*
+             * Shouldn't be more than 32, since that's the number of bits
+             * available in EBX to tell us _which_ counters are available.
+             * Play it safe.
+             */
+            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
+                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
+            }
+
+            if (has_architectural_pmu_version > 1) {
+                num_architectural_pmu_fixed_counters = c->edx & 0x1f;
+
+                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
+                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
+                }
+            }
+        }
+    }
+
     if (env->mcg_cap & MCG_LMCE_P) {
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
---

The above codes check 0xa after 0x1 and 0x7, and uses the local variable
`c`, so that it doesn't need to wrap another new function.

Regards,
Zhao




