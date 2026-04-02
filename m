Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C60CC6B00
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8AgV-0002QB-CF; Thu, 02 Apr 2026 01:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgT-0002Mi-Ft
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:37 -0400
Received: from qs-2007g-snip4-2.eps.apple.com ([57.103.84.193]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8AgR-0004vM-Pw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 01:33:37 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 3D7251800356; Thu, 02 Apr 2026 05:33:34 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775108015; x=1777700015;
 bh=3Qu07UyfMrl26rcCDLJRAW4udioYmmwydWihc/mbCYM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=g6XFp2sekZZ4YRzYuIyvnvmH3URVzCVOGYZCBzbAnSq7gx9oDS7PAL6k57TWn6384hT6thFW6USdhljB+7xqZbtgr/7C4SfFBh7xTG7lPzdYCyR9qb/P+GQhRlXunCUeHuDTQfOYFT/Riu2Bp1HZROEJrH+JoMB2fkVYXdxnsSgYgxagOhetjqfDaGVJZf/PvxF8ssk2ru45CN9mOwpU5TIuF96xJRJE8ZSRbLA2LP/h3x56kw2Bgzi5WKnO5D1aVm9R9BJ5Y5eE70AellCFES7b9moFgjx6p0bqHC4rrATEZEYSDo2S5dHqhy/swZIOYZEWOQIkjlBQRprJ14BHZg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 E587618000B0; Thu, 02 Apr 2026 05:33:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 3/4] whpx: i386: wire up feature probing
Date: Thu,  2 Apr 2026 07:33:25 +0200
Message-ID: <20260402053326.23402-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402053326.23402-1-mohamed@unpredictable.fr>
References: <20260402053326.23402-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0NyBTYWx0ZWRfXxAQhIMDEDrcc
 +cogWJeUNvHzEzEzOhQAYGTA/WGwMNJ9j7lzc5iv1kaaZpyDh6EKxkyCYSydopnFQ+nnOr6UgGn
 1hlPZGWcHQ10l+zqvhYnzdDFlm5PweY6OllLBrUHZ2Q61rCGtt9IIEg+kpGu68gVHt6tk9o2ouq
 wO9F4HOcVP8gXIkelKuLM7EX0dDrG83s/U7v9XI4gqfKmNihuIWIaxGOlF/1UFIvK/MUsVaT2W0
 4JTpNRCbdTl7igQEzRqLixMDk5SaUHZ6z4ceTkSyGLQpowR1XjtwoiBKowTdhmZDz2xl20yqIkG
 2RxIaysNu7eQ7bnGSyPAiYprJOhUl6T+31eEP78Gp1i10E3sKVbQsjn992P68c=
X-Authority-Info-Out: v=2.4 cv=Y4j1cxeN c=1 sm=1 tr=0 ts=69cdffae
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=buxp1bLQRU-tJDmZ5MUA:9
X-Proofpoint-GUID: oACnzBds3OnGknLzn4pAZUnOEiUgwejU
X-Proofpoint-ORIG-GUID: oACnzBds3OnGknLzn4pAZUnOEiUgwejU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020047
Received-SPF: pass client-ip=57.103.84.193;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Windows 10 doesn't have the API for this, so using this
only for Windows 11.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h |  3 ++
 target/i386/cpu.c              | 25 ++++++++++++++
 target/i386/whpx/whpx-all.c    | 63 +++++++++++++++++++++++++++++++++-
 target/i386/whpx/whpx-i386.h   |  4 +++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8482901f71..480d05fdca 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -89,6 +89,9 @@ void whpx_apic_get(APICCommonState *s);
          UINT32 StateSize)) \
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvGetVirtualProcessorCpuidOutput, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Eax, \
+         UINT32 Ecx, WHV_CPUID_OUTPUT* CpuidOutput))
 
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
     typedef return_type (WINAPI *function_name ## _t) signature;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00e..0000093fa3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,8 @@
 #include "tcg/helper-tcg.h"
 #include "exec/translation-block.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
+#include "whpx/whpx-i386.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
 #include "kvm/tdx.h"
@@ -8087,6 +8089,17 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r = hvf_get_supported_cpuid(wi->cpuid.eax,
                                     wi->cpuid.ecx,
                                     wi->cpuid.reg);
+    } else if (whpx_enabled()) {
+        if (wi->type != CPUID_FEATURE_WORD) {
+            return 0;
+        }
+        if (whpx_is_legacy_os()) {
+            r = wi->tcg_features;
+        } else {
+            r = whpx_get_supported_cpuid(wi->cpuid.eax,
+                                        wi->cpuid.ecx,
+                                        wi->cpuid.reg);
+        }
     } else if (tcg_enabled() || qtest_enabled()) {
         r = wi->tcg_features;
     } else {
@@ -8168,6 +8181,18 @@ static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
         *ebx = hvf_get_supported_cpuid(func, index, R_EBX);
         *ecx = hvf_get_supported_cpuid(func, index, R_ECX);
         *edx = hvf_get_supported_cpuid(func, index, R_EDX);
+    } else if (whpx_enabled()) {
+        if (whpx_is_legacy_os()) {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        } else {
+            *eax = whpx_get_supported_cpuid(func, index, R_EAX);
+            *ebx = whpx_get_supported_cpuid(func, index, R_EBX);
+            *ecx = whpx_get_supported_cpuid(func, index, R_ECX);
+            *edx = whpx_get_supported_cpuid(func, index, R_EDX);
+        }
     } else {
         *eax = 0;
         *ebx = 0;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f06474c31b..ad5ec3e700 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -36,6 +36,7 @@
 #include "system/whpx-accel-ops.h"
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
+#include "whpx-i386.h"
 
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
@@ -49,6 +50,8 @@
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
 
+bool is_legacy_os = false;
+
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
     /* X64 General purpose registers */
@@ -1062,6 +1065,65 @@ static void whpx_init_emu(void)
     init_emu(&whpx_x86_emul_ops);
 }
 
+bool whpx_is_legacy_os(void) 
+{
+    return is_legacy_os;
+}
+
+uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
+{
+    WHV_CPUID_OUTPUT output;
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t cpu_index = 0;
+    bool temp_cpu = true;
+    HRESULT hr;
+
+    hr = whp_dispatch.WHvCreateVirtualProcessor(
+        whpx_global.partition, cpu_index, 0);
+
+    /* This means that the CPU already exists... */
+    if (FAILED(hr)) {
+        temp_cpu = false;
+    }
+
+    hr = whp_dispatch.WHvGetVirtualProcessorCpuidOutput(whpx_global.partition,
+        cpu_index, func, idx, &output);
+    
+    if (FAILED(hr)) {
+        abort();
+    }
+
+    if (temp_cpu) {
+        hr = whp_dispatch.WHvDeleteVirtualProcessor(whpx_global.partition, cpu_index);
+        if (FAILED(hr)) {
+            abort();
+        }
+    }
+
+    eax = output.Eax;
+    ebx = output.Ebx;
+    ecx = output.Ecx;
+    edx = output.Edx;
+
+    /* We can emulate X2APIC even for the kernel-irqchip=off case */
+    if (func == 1) {
+        ecx |= CPUID_EXT_X2APIC;
+    }
+
+    switch (reg) {
+    case R_EAX:
+        return eax;
+    case R_EBX:
+        return ebx;
+    case R_ECX:
+        return ecx;
+    case R_EDX:
+        return edx;
+    default:
+        return 0;
+    }
+}
+
 /*
  * Controls whether we should intercept various exceptions on the guest,
  * namely breakpoint/single-step events.
@@ -2229,7 +2291,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    bool is_legacy_os = false;
     UINT32 cpuidExitList[] = {1};
 
     whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-i386.h b/target/i386/whpx/whpx-i386.h
new file mode 100644
index 0000000000..6db9a75d39
--- /dev/null
+++ b/target/i386/whpx/whpx-i386.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+uint32_t whpx_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+bool whpx_is_legacy_os(void);
-- 
2.50.1 (Apple Git-155)


