Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310F8C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 16:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxoG-0005da-Lc; Sun, 30 Jun 2024 12:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxoC-0005cG-Uc; Sun, 30 Jun 2024 12:53:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxoB-0005Iz-5b; Sun, 30 Jun 2024 12:53:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E74475761;
 Sun, 30 Jun 2024 19:53:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 47D8CFAD5E;
 Sun, 30 Jun 2024 19:53:27 +0300 (MSK)
Received: (nullmailer pid 38212 invoked by uid 1000);
 Sun, 30 Jun 2024 16:53:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Zide Chen <zide.chen@intel.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 04/16] target/i386: Advertise MWAIT iff host supports
Date: Sun, 30 Jun 2024 19:53:14 +0300
Message-Id: <20240630165327.38153-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240630165327.38153-1-mjt@tls.msk.ru>
References: <20240630165327.38153-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zide Chen <zide.chen@intel.com>

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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/i386/host-cpu.c    | 12 ------------
 target/i386/kvm/kvm-cpu.c | 11 +++++++++--
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 280e427c01..8b8bf5afec 100644
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
index f9b99b5f50..d57a68a301 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -64,8 +64,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
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
2.39.2


