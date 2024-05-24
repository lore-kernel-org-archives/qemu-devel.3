Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8E1C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 20:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAb6K-0002JB-02; Fri, 24 May 2024 16:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb67-0002AN-VX; Fri, 24 May 2024 16:01:05 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sAb65-00050y-8Q; Fri, 24 May 2024 16:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716580861; x=1748116861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CfBulfqouTJD2KFyY/RsB2TzLeKk14JepRumF3y0b/o=;
 b=W9Qd0V68JuFXL+/effeT7LWe/8z5ESNY53WrWP8v6x//wlWKkvjyCl1C
 LDVMD3CF2qfRUbUPs83sNtj5e8gs2w/vW2fL/x35DHXJ7dbFjyJ4ANtPo
 3gwizdpfNuuXQfmKq+7fRBNPOQy6HLj6VhV17ru+opYKrT3NhFFCVYJNS
 0TouAkppXZcoPxXebo7f1gNfn5UC6p1IlMN/lZRfTNpx/CLgFFhX+U+6a
 oZYP9f3E72T1LpSk9LECCKpodSUKNhxUW63UkmhKXJH3MJF7ECzSbLolB
 NSD4kyFRzVWvXlszJE3zBmUjaKOy8A8nplYM2zS0mAbHBlR2uhjOiM1Ly g==;
X-CSE-ConnectionGUID: XVCOb9HDTO6U9wxfKnNKow==
X-CSE-MsgGUID: 7nlj2i+mS6C2Guhi/Qfgkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="15918269"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="15918269"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:47 -0700
X-CSE-ConnectionGUID: 8eAWJbomQI6p/IR+TlvkVA==
X-CSE-MsgGUID: pS5GDOZTTWK8qgYDfYh2nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; d="scan'208";a="39108914"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 13:00:47 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org,
 Zide Chen <zide.chen@intel.com>
Subject: [PATCH V2 3/3] target/i386: Move host_cpu_enable_cpu_pm into
 kvm_cpu_realizefn()
Date: Fri, 24 May 2024 13:00:17 -0700
Message-Id: <20240524200017.150339-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524200017.150339-1-zide.chen@intel.com>
References: <20240524200017.150339-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It seems not a good idea to expand features in host_cpu_realizefn,
which is for host CPU only.  Additionally, cpu-pm option is KVM
specific, and it's cleaner to put it in kvm_cpu_realizefn(), together
with the WAITPKG code.

Fixes: f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 target/i386/host-cpu.c    | 12 ------------
 target/i386/kvm/kvm-cpu.c | 11 +++++++++--
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 280e427c017c..8b8bf5afeccf 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -42,15 +42,6 @@ static uint32_t host_cpu_phys_bits(void)
     return host_phys_bits;
 }
 
-static void host_cpu_enable_cpu_pm(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-
-    host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
-               &cpu->mwait.ecx, &cpu->mwait.edx);
-    env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
-}
-
 static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
 {
     uint32_t host_phys_bits = host_cpu_phys_bits();
@@ -83,9 +74,6 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (cpu->max_features && enable_cpu_pm) {
-        host_cpu_enable_cpu_pm(cpu);
-    }
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
         uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 3adcedf0dbc3..197c892da89a 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -64,9 +64,16 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *   cpu_common_realizefn() (via xcc->parent_realize)
      */
     if (cpu->max_features) {
-        if (enable_cpu_pm && kvm_has_waitpkg()) {
-            env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
+        if (enable_cpu_pm) {
+            if (kvm_has_waitpkg()) {
+                env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
+            }
+
+            host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
+                       &cpu->mwait.ecx, &cpu->mwait.edx);
+            env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
         }
+
         if (cpu->ucode_rev == 0) {
             cpu->ucode_rev =
                 kvm_arch_get_supported_msr_feature(kvm_state,
-- 
2.34.1


