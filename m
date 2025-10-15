Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A577CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t5i-0000MV-LO; Wed, 15 Oct 2025 00:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5g-0000K1-En; Wed, 15 Oct 2025 00:26:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5b-0002pp-QX; Wed, 15 Oct 2025 00:26:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7C10115D9CF;
 Wed, 15 Oct 2025 07:24:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1FAF829FE78;
 Wed, 15 Oct 2025 07:25:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hector Cao <hector.cao@canonical.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 10/11] target/i386: add compatibility property for
 arch_capabilities
Date: Wed, 15 Oct 2025 07:25:14 +0300
Message-ID: <20251015042520.68556-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251014173635@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Prior to v10.1, if requested by user, arch-capabilities is always on
despite the fact that CPUID advertises it to be off/unvailable.
This causes a migration issue for VMs that are run on a machine
without arch-capabilities and expect this feature to be present
on the destination host with QEMU 10.1.

Add a compatibility property to restore the legacy behavior for all
machines with version prior to 10.1.

To preserve the functionality (added by 10.1) of turning off
ARCH_CAPABILITIES where Windows does not like it, use directly
the guest CPU vendor: x86_cpu_get_supported_feature_word is not
KVM-specific and therefore should not necessarily use the host
CPUID.

Co-authored-by: Hector Cao <hector.cao@canonical.com>
Signed-off-by: Hector Cao <hector.cao@canonical.com>
Fixes: d3a24134e37 ("target/i386: do not expose ARCH_CAPABILITIES on AMD CPU", 2025-07-17)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e9efa4a77168ac2816bf9471f878252ce6224710)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2f58e73d33..2504365bc2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -84,6 +84,7 @@
 GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
     { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
+    { TYPE_X86_CPU, "x-arch-cap-always-on", "true" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6d85149e6e..fe369bb128 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7539,6 +7539,20 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 #endif
         break;
 
+    case FEAT_7_0_EDX:
+        /*
+         * Windows does not like ARCH_CAPABILITIES on AMD machines at all.
+         * Do not show the fake ARCH_CAPABILITIES MSR that KVM sets up,
+         * except if needed for migration.
+         *
+         * When arch_cap_always_on is removed, this tweak can move to
+         * kvm_arch_get_supported_cpuid.
+         */
+        if (cpu && IS_AMD_CPU(&cpu->env) && !cpu->arch_cap_always_on) {
+            unavail = CPUID_7_0_EDX_ARCH_CAPABILITIES;
+        }
+        break;
+
     default:
         break;
     }
@@ -10004,6 +10018,9 @@ static const Property x86_cpu_properties[] = {
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
     DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
+
+    DEFINE_PROP_BOOL("x-arch-cap-always-on", X86CPU,
+                     arch_cap_always_on, false),
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0be7a7406..414ca968e8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2314,6 +2314,12 @@ struct ArchCPU {
     /* Forcefully disable KVM PV features not exposed in guest CPUIDs */
     bool kvm_pv_enforce_cpuid;
 
+    /*
+     * Expose arch-capabilities unconditionally even on AMD models, for backwards
+     * compatibility with QEMU <10.1.
+     */
+    bool arch_cap_always_on;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5621200be0..96035c27cd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -503,12 +503,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
          * We can detect the bug by checking if MSR_IA32_ARCH_CAPABILITIES is
          * returned by KVM_GET_MSR_INDEX_LIST.
-         *
-         * But also, because Windows does not like ARCH_CAPABILITIES on AMD
-         * mcahines at all, do not show the fake ARCH_CAPABILITIES MSR that
-         * KVM sets up.
          */
-        if (!has_msr_arch_capabs || !(edx & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
+        if (!has_msr_arch_capabs) {
             ret &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
         }
     } else if (function == 7 && index == 1 && reg == R_EAX) {
-- 
2.47.3


