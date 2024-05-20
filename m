Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A4C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 17:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s977U-0002CM-Kw; Mon, 20 May 2024 13:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s977R-0002Bm-Vt
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:48:18 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s977O-0003k1-Ko
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716227295; x=1747763295;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CfBulfqouTJD2KFyY/RsB2TzLeKk14JepRumF3y0b/o=;
 b=HhZzu8Sotl014qdC5FiqMS3S2jvbPU5viutRyXX3ebvu6AsEyqk+TQg7
 C6zSKnv64bA4fgPeNEzSk//5bbe4rMTkt+UT9zbZ696/J2J/6l1/EQoM+
 sZ2aRqCyKYtQgEAd5GDqmtZOQxaUMv1PnSPTVDgOxxs2IwVn0TGP6SFf4
 b4iaW09vlDPrkh6m8WuFODI8mPOaZKoHQh2uyIkJVWVHI1JJ/VZkXyP8I
 PhAs9XGQ4Wh1duNAbFrEGjXlhQMUxvnrDPkndHRH0Y6qRuGjlHhQzCvaj
 tWQW9a3xBhSmVEpa36xGXqqGK7ylZmkCeY6t6PcUubQ/RAO8PlLyTyQ1u w==;
X-CSE-ConnectionGUID: GeIXK0HsShuKmzYJX0W76A==
X-CSE-MsgGUID: m1ckPSbsT2+Lri7MqS7osw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12222100"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; d="scan'208";a="12222100"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 10:47:58 -0700
X-CSE-ConnectionGUID: oQ9wEy1SRO6iM5NDUC4qoA==
X-CSE-MsgGUID: UAKUAeTuSK6HfBecV+NT2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; d="scan'208";a="32746638"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 10:47:58 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, Zide Chen <zide.chen@intel.com>
Subject: [PATCH 3/3] target/i386: Move host_cpu_enable_cpu_pm into
 kvm_cpu_realizefn()
Date: Mon, 20 May 2024 10:47:33 -0700
Message-Id: <20240520174733.32979-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520174733.32979-1-zide.chen@intel.com>
References: <20240520174733.32979-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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


