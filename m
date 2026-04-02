Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8A7D6AAFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Nlb-0000OZ-5X; Thu, 02 Apr 2026 15:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlG-0000KT-Im
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:26 -0400
Received: from p-west1-cluster6-host12-snip4-2.eps.apple.com ([57.103.67.15]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8NlC-0008G6-57
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 15:31:23 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id
 A532918006D5; Thu, 02 Apr 2026 19:31:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775158279; x=1777750279;
 bh=cyefbnzAY8JeNWB8ZblxzM/akFTBNEuF109YRmCP8Zo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=brQmm0MmA9G/8AHJC/ODt9sLASWXDluwRcPiBRvawfmQ+oruEh4I4vdo0RW0K3zQbSLFvyHh5fxXQF2rmaO40hX8dVdvzNdC/DRZhp9mNFfnImhL/P0Xq+B40mdmx8MPE02THXaIThhvUgyhZlU1ixRiFwtR+RiP8LCuSb/Fxu6rMUNZCmi68SRRWxv6j4mUkTYl/j8j76v/tGsqzyDWd4H394gGIZMD5NTUWZCE7jdKZhFsXYnTvr/tdltZ3ZrOs+hv2crMkHT7Z1XS4lu7l5+dhUMVmSPTv5HV0EWMcgjWMjkcDwD/s2aabJLfVm2AxX8rjV13zSggu1XD32ytaA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id
 150B41800228; Thu, 02 Apr 2026 19:31:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 3/6] whpx: i386: wire up feature probing
Date: Thu,  2 Apr 2026 21:31:01 +0200
Message-ID: <20260402193104.56331-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402193104.56331-1-mohamed@unpredictable.fr>
References: <20260402193104.56331-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: e_d36Na37oIKncrXiS-MwBSATp4BDfaK
X-Proofpoint-GUID: e_d36Na37oIKncrXiS-MwBSATp4BDfaK
X-Authority-Info-Out: v=2.4 cv=fuDRpV4f c=1 sm=1 tr=0 ts=69cec406
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=buxp1bLQRU-tJDmZ5MUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NSBTYWx0ZWRfX1GpISVQlwz8t
 ah4Fo6CVOkN8JbkAiXL8thEJX0vIJBuG2bACab6xZBQ+9+m8PBQwNT/kmy2yewA0ocm2DR1lFDS
 GV2hfLyrLXbLDgUOqGk5DuftMyUgJIRlJ2KDmFC7qPlE6+L7yvS9E8TxO2LbUxxRtl8t+/Yx+xt
 J6T9lV9umAEcHzNge1ftd0tZ4wl0TA9xpRUjzX1xH7Pd3Jz+GsDTExNmxKm8JDoPmhdoU2CeoTy
 Yn2iYFscV9vqxz+5//mzILJ64IVhBx18HWtJMDAYjeG1z0EbxrJU5wpwEFAC5ek6D7IBxyc9XEx
 HylaMCVd/LLxy3DCEowKPK9jY4dScxbbpHDkry/Cl+F6AXKCzJIjDNIIJpQAGc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604020175
Received-SPF: pass client-ip=57.103.67.15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
index 4127440c0c..db8855cbea 100644
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
@@ -2235,7 +2297,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


