Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8919F531CF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 20:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOGf-0007NF-DY; Mon, 13 Apr 2026 16:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGc-0007MA-Ax
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:22 -0400
Received: from ci-2007a-snip4-2.eps.apple.com ([57.103.88.5]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCOGa-0007u8-CF
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 16:52:22 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 8A551180014C; Mon, 13 Apr 2026 20:52:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776113539; x=1778705539;
 bh=Ash1yi3VlTyxdP0Aar5CNwwUDY+XErFVJjyfbU7EpDA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JdJiR1ST+AYlf1CnHTprZEco84Dv0XFHLSyHjvBnJ1PRrtK6BhV8eEQTiQxpYtl4gQmBgPAWYyg45qwxhZ8RvKw9m0rO9DlI7Uho3Gr2NysScOlKflU7Z6tNiW0cp2T1oZoBAeYVidp2vPbDwPFOTLKplpssl1uKUFT9BKctlKKlvnNv5MkjLZ0pFF7Y8VWkuHdGeCptOwbfaSAjrQK29CakCyANCybZalUSs0DnMTcPK1mhGeCcx9gfG23dXgkSotz9GUjL1lU6rpRdLvxG2Yt0+/hB6JYuGncwmPAL0b4fum+tdOsg7WO/LZ0O9jcfz7aDquW926yq6H80y61OZA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 824121800167; Mon, 13 Apr 2026 20:52:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v12 03/15] whpx: i386: wire up feature probing
Date: Mon, 13 Apr 2026 22:51:55 +0200
Message-ID: <20260413205208.50643-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413205208.50643-1-mohamed@unpredictable.fr>
References: <20260413205208.50643-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 07dG4wjafw9-7E62iZAK4epn35sBgK1r
X-Proofpoint-GUID: 07dG4wjafw9-7E62iZAK4epn35sBgK1r
X-Authority-Info-Out: v=2.4 cv=QKdlhwLL c=1 sm=1 tr=0 ts=69dd5782
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Gr33WSPopR-aU8k7cJUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX3/aibxZE5Ekv
 DQcYEgQulM6BtCDclyJztKGS84WBkwuaoi2Hd9y31WVSyu1itT2ffdneoEaIZLfwIZWKQ178qOg
 MZZRRHhT02ieLrXrsS2tn191QTriq4xhKPOMqSzxDgCMim+kdVkQzfsR1cvyVUoXGKWojwfccTY
 0gKsi/ZeDAQ43HQfXw7nyvl/t5zTGdS1KxnijbFhVSYS+7M0QC613ENlGhq3ZJdfIlJjBNeP/SE
 L6A/QKFWD7puiDStL+BCAR4lqNuXzMEJHoZi0F9tL7p7AoChcwkKWJb4HFTtYtBlNX7/PCAE2si
 SMMj1ayjrJqpdDQIcXi8E1PXhd/nKAKMlkLyISsh/vCNIieEGQtGraJy3rZ3PA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0
 bulkscore=0 clxscore=1030 phishscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130205
Received-SPF: pass client-ip=57.103.88.5;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Windows 10 doesn't have the API for this, so using this
only for Windows 11.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h |  9 ++++
 target/i386/cpu.c              | 25 ++++++++++++
 target/i386/whpx/whpx-all.c    | 75 ++++++++++++++++++++++++++++++++--
 target/i386/whpx/whpx-i386.h   |  4 ++
 4 files changed, 109 insertions(+), 4 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 8482901f71..5902124b63 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -73,6 +73,14 @@ void whpx_apic_get(APICCommonState *s);
   X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, WHV_REGISTER_VALUE* RegisterValues)) \
   X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 RegisterCount, const WHV_REGISTER_VALUE* RegisterValues)) \
 
+#ifdef __x86_64__
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X) \
+    X(HRESULT, WHvGetVirtualProcessorCpuidOutput, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, UINT32 Eax, \
+         UINT32 Ecx, WHV_CPUID_OUTPUT *CpuidOutput))
+#else
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
+#endif
 /*
  * These are supplemental functions that may not be present
  * on all versions and are not critical for basic functionality.
@@ -89,6 +97,7 @@ void whpx_apic_get(APICCommonState *s);
          UINT32 StateSize)) \
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
+  LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL_ARCH(X)
 
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
index 4127440c0c..2d527b90dd 100644
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
 
+static bool is_modern_os = true;
+
 static const WHV_REGISTER_NAME whpx_register_names[] = {
 
     /* X64 General purpose registers */
@@ -1062,6 +1065,71 @@ static void whpx_init_emu(void)
     init_emu(&whpx_x86_emul_ops);
 }
 
+bool whpx_is_legacy_os(void)
+{
+    return !is_modern_os;
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
+    /*
+     * We can emulate X2APIC even for the kernel-irqchip=off case.
+     * CPUID_EXT_HYPERVISOR and CPUID_HT should be considered present
+     * always, so report them as unconditionally supported here.
+     */
+    if (func == 1) {
+        ecx |= CPUID_EXT_X2APIC;
+        ecx |= CPUID_EXT_HYPERVISOR;
+        edx |= CPUID_HT;
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
@@ -2235,7 +2303,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
-    bool is_legacy_os = false;
     UINT32 cpuidExitList[] = {1};
 
     whpx = &whpx_global;
@@ -2395,7 +2462,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     if (FAILED(hr)) {
         warn_report("WHPX: Failed to get performance "
                     "monitoring features, hr=%08lx", hr);
-        is_legacy_os = true;
+        is_modern_os = false;
     } else {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
@@ -2435,7 +2502,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
+    if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2446,7 +2513,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             ret = -EINVAL;
             goto error;
         }
-    } else if (is_legacy_os && whpx->hyperv_enlightenments_required) {
+    } else if (!is_modern_os && whpx->hyperv_enlightenments_required) {
         error_report("Hyper-V enlightenments not available on legacy Windows");
         ret = -EINVAL;
         goto error;
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


