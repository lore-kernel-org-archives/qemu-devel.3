Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF43EC01DD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4duX-0000MW-70; Mon, 23 Mar 2026 07:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4duV-0000M4-Mi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:57:31 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4duU-0003g4-8V
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:57:31 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id A0E2920B710C;
 Mon, 23 Mar 2026 04:57:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0E2920B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774267049;
 bh=vE3ebHrN7UQ629WB+JSY974v1w4xk1/XwHXJu7IONSA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jzY//GmMuaFC3r2ftYJL24fjjhKE69HjOdp+0SnW5H4GGLQFJ9sdnaTq0VMjmy+//
 iO2vEx6ySdruV0cMNXRMeUZRjOhjBmOWu0kSHSZc550QVJ7wGWYVBHvzzTQtyIrDgO
 wRjD2zSOg4BzHVO7HfAwdgnhVTjHT7RV73m4G1dA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 6/9] target/i386: query mshv accel for supported cpuids
Date: Mon, 23 Mar 2026 12:57:08 +0100
Message-Id: <20260323115711.353793-7-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
References: <20260323115711.353793-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We implement mshv_get_supported_cpuid() and invoke it in
x86_cpu_get_supported_feature_word() retrieve the cpu features that the
host is supporting. Initially we mask the virtualization capabilitities
potentially we might need to mask more in the future.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |  3 +++
 target/i386/cpu.c           |  8 ++++++++
 target/i386/mshv/mshv-cpu.c | 27 +++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 75286baf16..51b0420735 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -60,4 +60,7 @@ int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
 
+/* cpuid */
+uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e483e8cd..21e42fb4f6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,7 @@
 #include "tcg/helper-tcg.h"
 #include "exec/translation-block.h"
 #include "system/hvf.h"
+#include "system/mshv.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "kvm/tdx.h"
@@ -8087,6 +8088,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r = hvf_get_supported_cpuid(wi->cpuid.eax,
                                     wi->cpuid.ecx,
                                     wi->cpuid.reg);
+     } else if (mshv_enabled()) {
+        if (wi->type != CPUID_FEATURE_WORD) {
+            return 0;
+        }
+        r = mshv_get_supported_cpuid(wi->cpuid.eax,
+                                     wi->cpuid.ecx,
+                                     wi->cpuid.reg);
     } else if (tcg_enabled()) {
         r = wi->tcg_features;
     } else {
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 09878ef357..3b392533b4 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1639,6 +1639,33 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     g_clear_pointer(&env->emu_mmio_buf, g_free);
 }
 
+uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
+{
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t ret = 0;
+
+    host_cpuid(func, idx, &eax, &ebx, &ecx, &edx);
+    switch (reg) {
+    case R_EAX:
+        ret = eax; break;
+    case R_EBX:
+        ret = ebx; break;
+    case R_ECX:
+        ret = ecx; break;
+    case R_EDX:
+        ret = edx; break;
+    }
+
+    /* Disable nested virtualization features not yet supported by MSHV */
+    if (func == 0x80000001 && reg == R_ECX) {
+        ret &= ~CPUID_EXT3_SVM;
+    }
+    if (func == 0x01       && reg == R_ECX) {
+        ret &= ~CPUID_EXT_VMX;
+    }
+    return ret;
+}
+
 /*
  * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
  * fault to the guest if it tries to access it. It is possible to override
-- 
2.34.1


