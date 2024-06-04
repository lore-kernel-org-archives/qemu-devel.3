Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15AC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEHdu-0000Po-Ga; Mon, 03 Jun 2024 20:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEHdr-0000Os-Jy; Mon, 03 Jun 2024 20:03:07 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sEHdp-0000ML-Si; Mon, 03 Jun 2024 20:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717459386; x=1748995386;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=48VUZgnmiGXhvF6KdpwRb9P2+6jdiRU05eVhOiCgRk8=;
 b=TWB9VUckUavocwvQ0KVOll28h09ADWPq43dwOKq88Q3JheTJUMEREwPA
 AETVW181zFqEjyzuJ1WAfKGyj37+uNMIxjuBIP9X2wAr3lTb5J2xharnw
 qGIWLGNiKjQvd8Qi2/kKoCO7EVM2blnBQDTu9zgLiGS1W+ORnItzomBzz
 +Aau92yHt1Mx5sXZG4V0s9VHXJAg8JR7cVY0e1RIJptCwcad+Wx+oAJts
 hBukL7difka77KdnxFJXkicXrvQzBvCcXaLxhMb5bY4yCEKYsSmkwIOEm
 ygX7aJsn/vrHR2pnD9EN8hwmpJfyd5wNvTYtqTAvtWKbLqxHoICo2BwQV w==;
X-CSE-ConnectionGUID: bFKmixXsR5aEajhgd/BC5w==
X-CSE-MsgGUID: 7He7SkpuQGKYHxHFtgGKBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13924793"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="13924793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 17:03:01 -0700
X-CSE-ConnectionGUID: XKeE7sPtRdee3vPKeCYNOg==
X-CSE-MsgGUID: zTGuPn8VR8WoUZ4ePjdfEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; d="scan'208";a="74529690"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.100])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 17:03:01 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, thuth@redhat.com, cfontana@suse.de,
 xiaoyao.li@intel.com, qemu-trivial@nongnu.org, seanjc@google.com,
 zhao1.liu@intel.com, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 2/2] target/i386: Advertise MWAIT iff host supports
Date: Mon,  3 Jun 2024 17:02:22 -0700
Message-Id: <20240604000222.75065-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604000222.75065-1-zide.chen@intel.com>
References: <20240604000222.75065-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

host_cpu_realizefn() sets CPUID_EXT_MONITOR without consulting host/KVM
capabilities. This may cause problems:

- If MWAIT/MONITOR is not available on the host, advertising this
  feature to the guest and executing MWAIT/MONITOR from the guest
  triggers #UD and the guest doesn't boot.  This is because typically
  #UD takes priority over VM-Exit interception checks and KVM doesn't
  emulate MONITOR/MWAIT on #UD.

- If KVM doesn't support KVM_X86_DISABLE_EXITS_MWAIT, MWAIT/MONITOR
  from the guest are intercepted by KVM, which is not what cpu-pm=on
  intends to do.

In these cases, MWAIT/MONITOR should not be exposed to the guest.

The logic in kvm_arch_get_supported_cpuid() to handle CPUID_EXT_MONITOR
is correct and sufficient, and we can't set CPUID_EXT_MONITOR after
x86_cpu_filter_features().

This was not an issue before commit 662175b91ff ("i386: reorder call to
cpu_exec_realizefn") because the feature added in the accel-specific
realizefn could be checked against host availability and filtered out.

Additionally, it seems not a good idea to handle guest CPUID leaves in
host_cpu_realizefn(), and this patch merges host_cpu_enable_cpu_pm()
into kvm_cpu_realizefn().

Fixes: f5cc5a5c1686 ("i386: split cpu accelerators from cpu.c, using AccelCPUClass")
Fixes: 662175b91ff2 ("i386: reorder call to cpu_exec_realizefn")
Signed-off-by: Zide Chen <zide.chen@intel.com>
---

V3:
- don't set CPUID_EXT_MONITOR in kvm_cpu_realizefn().
- Change title to reflect the main purpose of this patch.

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
index f76972e47e61..148d10ce3711 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -65,8 +65,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
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
+            if (env->features[FEAT_1_ECX] & CPUID_EXT_MONITOR) {
+                host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
+                           &cpu->mwait.ecx, &cpu->mwait.edx);
+	    }
         }
         if (cpu->ucode_rev == 0) {
             cpu->ucode_rev =
-- 
2.34.1


