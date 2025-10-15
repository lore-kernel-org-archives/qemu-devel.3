Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7885ACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t5l-0000RL-FD; Wed, 15 Oct 2025 00:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5i-0000N3-La; Wed, 15 Oct 2025 00:26:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t5e-0002qR-Jh; Wed, 15 Oct 2025 00:26:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8AFBF15D9D0;
 Wed, 15 Oct 2025 07:24:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2ECE829FE79;
 Wed, 15 Oct 2025 07:25:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hector Cao <hector.cao@canonical.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 11/11] target/i386: add compatibility property for
 pdcm feature
Date: Wed, 15 Oct 2025 07:25:15 +0300
Message-ID: <20251015042520.68556-11-mjt@tls.msk.ru>
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

From: Hector Cao <hector.cao@canonical.com>

The pdcm feature is supposed to be disabled when PMU is not
available. Up until v10.1, pdcm feature is enabled even when PMU
is off. This behavior has been fixed but this change breaks the
migration of VMs that are run with QEMU < 10.0 and expect the pdcm
feature to be enabled on the destination host.

This commit restores the legacy behavior for machines with version
prior to 10.1 to allow the migration from older QEMU to QEMU 10.1.

Signed-off-by: Hector Cao <hector.cao@canonical.com>
Link: https://lore.kernel.org/r/20250910115733.21149-3-hector.cao@canonical.com
Fixes: e68ec298090 ("i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] check", 2025-06-20)
[Move property from migration object to CPU. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6529f31e0dccadb532c80b36e3efe7aef83f9cad)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2504365bc2..0861e329b5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -85,6 +85,7 @@ GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
     { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
     { TYPE_X86_CPU, "x-arch-cap-always-on", "true" },
+    { TYPE_X86_CPU, "x-pdcm-on-even-without-pmu", "true" },
 };
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fe369bb128..ab18de894e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7908,6 +7908,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /* Fixup overflow: max value for bits 23-16 is 255. */
             *ebx |= MIN(num, 255) << 16;
         }
+        if (cpu->pdcm_on_even_without_pmu) {
+            if (!cpu->enable_pmu) {
+                *ecx &= ~CPUID_EXT_PDCM;
+            }
+        }
         break;
     case 2: { /* cache info: needed for Pentium Pro compatibility */
         const CPUCaches *caches;
@@ -8958,9 +8963,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    /* PDCM is fixed1 bit for TDX */
-    if (!cpu->enable_pmu && !is_tdx_vm()) {
-        env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+    if (!cpu->pdcm_on_even_without_pmu) {
+        /* PDCM is fixed1 bit for TDX */
+        if (!cpu->enable_pmu && !is_tdx_vm()) {
+            env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
@@ -10021,6 +10028,8 @@ static const Property x86_cpu_properties[] = {
 
     DEFINE_PROP_BOOL("x-arch-cap-always-on", X86CPU,
                      arch_cap_always_on, false),
+    DEFINE_PROP_BOOL("x-pdcm-on-even-without-pmu", X86CPU,
+                     pdcm_on_even_without_pmu, false),
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 414ca968e8..42168f1d6d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2320,6 +2320,12 @@ struct ArchCPU {
      */
     bool arch_cap_always_on;
 
+    /*
+     * Backwards compatibility with QEMU <10.1. The PDCM feature is now disabled when
+     * PMU is not available, but prior to 10.1 it was enabled even if PMU is off.
+     */
+    bool pdcm_on_even_without_pmu;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
-- 
2.47.3


