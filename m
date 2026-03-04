Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A1AEFCE2A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqkl-0005Pa-Fg; Wed, 04 Mar 2026 13:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkh-0005Mo-Pa
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:19 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkf-0004QO-W1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648118; x=1804184118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G+6wuOIAslBmGP2VHNPLDcT/YnyVPtn5n6sa0myOq+o=;
 b=JVCpPY40UakVbnMKld6Q+jNoONg1aruwxjnuyg3Qai1nEEjdL0SSKwh5
 CC6VP+2glz8zioF3pyGHtEx2zpSscq3HhStcc1di6m2V2tpySpgDJoTBu
 1MUTFb3xAk2CCSQJ/EBx3nDSABdNv0YuonwID/N7L+6cUCEqocIsgmUCW
 H1j16HQjux0bl8eXlqJtrL1KYx3ZyxMxtpU6jhrJRXlYi5nFZJ2ig4SXd
 2yPY+NDYqpYh5GDFI3tmVeV2qSwvXxzI3wwwmDhamcuoLYWKa/Gt6Kc82
 T+3m/comksGJ0YBH3oEzWBWuj1tkC+oZCMDjiNCoW/l2pwMbg9dhsWRW4 g==;
X-CSE-ConnectionGUID: rLtf0q/uQ9CD5W0ztsIjEg==
X-CSE-MsgGUID: 7bhjZD/JTXa8z/gRqsc+Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909304"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909304"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:11 -0800
X-CSE-ConnectionGUID: mC2OaaPJSnmC5rsDc7JRiA==
X-CSE-MsgGUID: /ZP5qbglRt+apVyzw0uYKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542792"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:10 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 03/13] target/i386: Gate enable_pmu on kvm_enabled()
Date: Wed,  4 Mar 2026 10:07:02 -0800
Message-ID: <20260304180713.360471-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

Guest PMU support requires KVM.  Clear cpu->enable_pmu when KVM is not
enabled, so PMU-related code can rely solely on cpu->enable_pmu.

This reduces duplication and avoids bugs where one of the checks is
missed.  For example, cpu_x86_cpuid() enables CPUID.0AH when
cpu->enable_pmu is set but does not check kvm_enabled(). This is
implicitly fixed by this patch:

if (cpu->enable_pmu) {
	x86_cpu_get_supported_cpuid(0xA, count, eax, ebx, ecx, edx);
}

Also fix two places that check kvm_enabled() but not cpu->enable_pmu.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
V2:
- Replace a tab with spaces.
---
 target/i386/cpu.c     | 9 ++++++---
 target/i386/kvm/kvm.c | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9b9ed2d1e38e..a69c3108f64b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8661,7 +8661,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = 0;
         *edx = 0;
         if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
-            !kvm_enabled()) {
+            !cpu->enable_pmu) {
             break;
         }
 
@@ -9008,7 +9008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 0x80000022:
         *eax = *ebx = *ecx = *edx = 0;
         /* AMD Extended Performance Monitoring and Debug */
-        if (kvm_enabled() && cpu->enable_pmu &&
+        if (cpu->enable_pmu &&
             (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
             *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
             *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,
@@ -9630,7 +9630,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
      * are advertised by cpu_x86_cpuid().  Keep these two in sync.
      */
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
-        kvm_enabled()) {
+        cpu->enable_pmu) {
         x86_cpu_get_supported_cpuid(0x14, 0,
                                     &eax_0, &ebx_0, &ecx_0, &edx_0);
         x86_cpu_get_supported_cpuid(0x14, 1,
@@ -9778,6 +9778,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
     unsigned requested_lbr_fmt;
 
+    if (!kvm_enabled())
+        cpu->enable_pmu = false;
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     /* Use pc-relative instructions in system-mode */
     tcg_cflags_set(cs, CF_PCREL);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1131c350d352..144585df5ba6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4400,7 +4400,7 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                               env->msr_xfd_err);
         }
 
-        if (kvm_enabled() && cpu->enable_pmu &&
+        if (cpu->enable_pmu &&
             (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             uint64_t depth;
             int ret;
@@ -4912,7 +4912,7 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_XFD_ERR, 0);
     }
 
-    if (kvm_enabled() && cpu->enable_pmu &&
+    if (cpu->enable_pmu &&
         (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
         uint64_t depth;
 
-- 
2.53.0


