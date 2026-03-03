Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13B1EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWhI-00069O-1F; Tue, 03 Mar 2026 15:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh6-00060j-GO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:18 -0500
Received: from p-east2-cluster6-host4-snip4-10.eps.apple.com ([57.103.76.151]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh2-0000jK-SM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:15 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 7C4671800587; Tue,  3 Mar 2026 20:50:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571010; x=1775163010;
 bh=F9BWIbAr980ZBXELLnOIEZWMzo9HppGNpact1WFSAtU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=d1l2D66pY4vmD4C+ePacNPJgl8oymTcSvqgiM4NCkmSDtAEypkFuiWXAf4Bc9NK+MoEbaB+vrj9+UnAxZo2XriGuqJ6M7QbHytU1StQvrm9MT5zjgcjPlPpqV4CX3fyoWlLPNNTG01PE0Skh2/7KYuwHtAQf+/NHU7Wvhl192H0S1WNAGFMT2AEbJEBHwQmCvJBlEKjH7WPX9jcwppxXdKBtkwjCaKFbAP74ePsUb02QQIRFYnGlOvdqcDxBjFR27qtmw5IeXjbNcWZQJKvUkpl+fbxW/+bneOW1jilm1gOY4jRkWDEMxmDnH8t8ZUGHQtD5fzxKm52osGGmRh9EPQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 6C7C31800419; Tue,  3 Mar 2026 20:50:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 3/9] whpx: i386: apic: bring closer to MSHV code path
Date: Tue,  3 Mar 2026 21:49:53 +0100
Message-ID: <20260303204959.31156-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=LpyfC3dc c=1 sm=1 tr=0 ts=69a74982
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=a_U1oVfrAAAA:8 a=yMhMjlubAAAA:8 a=gZWPb2AKFxxsgVUQgu4A:9
X-Proofpoint-ORIG-GUID: 00pcw4N7N2WE1rkzhYDnracvH8FcImsY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfXxMSxjhqOTP6f
 tiJr2enEKpsBdKE+VR3tBbKArXsdGEkS+QuuaVPZWm64endM95tdu0+xl8g6W1waCnQzqWZ6kVp
 c41YOUY8jQ4JG8d3nM538BLZ7x3yUVKxUualdGQASxQjDcykcLcTm/4mobc9xWX3Lqjcm1VHQdc
 CWugN2U8AYxXE7B4NzHhF7olN4uiLYNBZLmHpfuxvN7cpPynuH8mf0LoV7BGx7PsarPLLSTR1Jt
 b39O/VoWvkngaXHFbqeR7UtscPWpmvp5sL01iKgDEvv5U2L+pU53dzfqvA/OMXCDBC59d7ixf5Z
 gbG4EISwKrs8BzS9gwpI0FLWmDk0fL0WQHXBDf/qSzPYuqAKTF/bJtreIjwo6I=
X-Proofpoint-GUID: 00pcw4N7N2WE1rkzhYDnracvH8FcImsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 clxscore=1030
 phishscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABNi11TVYEBvladhsLcsYD82rlnh5mEzJ+15SJvYO/n2TBb1uH2T2Zx7dWU8yJXOuaepyNwMxsT5AXvVRcuz7nb5fWCdQqZk1bQrJJzsScCK5ESwYvyVMaiMYMNaW1fNfecZNz5v7iUOHHaiRqkez0706EYm+58/OEZpPobIKa70Co+1NXhL38h/PuIM6j8Ly3C0gAdflS2QkK1P5/sGvaX4IF/cdSzCXzwdra4AWi2DyHP5Ud8EcHCKZI5UakArNTNt2ZJJvyNr/5JtRPCkQ+m9mONSkUxjSzKruBZPUxZqNuvanps/xTujnQBB4brfAAAvxrXLzHm79FPb+NWiYyEwGmYV0dFk459UjrzoqjHX2H7hS8wsJbRhZD1JdnBIJSiiZy5y4ag11pItOv+nAMNyAeaHTNnt1bGbWcPAaD5YjZEOuOf4gyBH2ur5xsL8bUtvOrqThGqHQs5gthoqfpKY8u+6q2WZpzFEPV8Leu1YCmQKP2b96dKHvO6w88WYAwWc4wJ+9hvJmcDnKiImJ01YUlYpzbMADNiORrOiu0nW0W4PZXfhv4rfS+ZnjnQWXI3xc4xinlOH8wKN4AxU/6XMsuG/vjh8dJzB64vbyrMVdQz4GLetnOYLaAIYuXuD4bvS10LbF+PM1LFIKJRUnJ6ckTdtV/ENPHNRqsUdd1wSzciQN9ph5TBh+hUFL8YOKiM5CYy3OAKsS7lWY0Wet//75/pcQgQ+Jw26FovJZH4j0hLXAfeJ+1eJaQnvNEuw==
Received-SPF: pass client-ip=57.103.76.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

MSHV doesn't have a dedicated apic_type and uses the common class. Make WHPX do the same thing.

As VM save/restore isn't currently supported anyway, this doesn't break functionality.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/apic.c                 |   9 ++
 include/system/whpx-internal.h |  10 +-
 target/i386/cpu-apic.c         |   3 -
 target/i386/whpx/irq.c         | 153 ++++++++++++++++++
 target/i386/whpx/irq.h         |  10 ++
 target/i386/whpx/meson.build   |   2 +-
 target/i386/whpx/whpx-all.c    |  17 +-
 target/i386/whpx/whpx-apic.c   | 286 ---------------------------------
 8 files changed, 183 insertions(+), 307 deletions(-)
 create mode 100644 target/i386/whpx/irq.c
 create mode 100644 target/i386/whpx/irq.h
 delete mode 100644 target/i386/whpx/whpx-apic.c

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 8766ed00b9..4920043063 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -28,6 +28,8 @@
 #include "qemu/host-utils.h"
 #include "system/kvm.h"
 #include "system/mshv.h"
+#include "system/whpx.h"
+#include "whpx/irq.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
 #include "exec/cpu-common.h"
@@ -915,6 +917,13 @@ static void apic_send_msi(MSIMessage *msi)
                                dest_mode, trigger_mode);
         return;
     }
+#endif
+#ifdef CONFIG_WHPX
+    if (whpx_enabled() && whpx_irqchip_in_kernel()) {
+        whpx_request_interrupt(delivery, vector, dest,
+                               dest_mode, trigger_mode);
+        return;
+    }
 #endif
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 7a1c9871f1..e7b915ccbf 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,7 +4,6 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
-#include "hw/i386/apic.h"
 #include "exec/vaddr.h"
 
 typedef enum WhpxBreakpointState {
@@ -45,7 +44,6 @@ struct whpx_state {
 };
 
 extern struct whpx_state whpx_global;
-void whpx_apic_get(APICCommonState *s);
 
 #define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
 
@@ -85,6 +83,14 @@ void whpx_apic_get(APICCommonState *s);
          UINT32 StateSize)) \
   X(HRESULT, WHvResetPartition, \
         (WHV_PARTITION_HANDLE Partition)) \
+  X(HRESULT, WHvGetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes, UINT32 *BytesWritten)) \
+  X(HRESULT, WHvSetVirtualProcessorState, \
+        (WHV_PARTITION_HANDLE Partition, UINT32 VpIndex, \
+        WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, PVOID Buffer, \
+        UINT32 BufferSizeInBytes)) \
 
 #define WHP_DEFINE_TYPE(return_type, function_name, signature) \
     typedef return_type (WINAPI *function_name ## _t) signature;
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index eaa10ad2a3..77073ad455 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -33,10 +33,7 @@ APICCommonClass *apic_get_class(Error **errp)
         apic_type = "kvm-apic";
     } else if (xen_enabled()) {
         apic_type = "xen-apic";
-    } else if (whpx_irqchip_in_kernel()) {
-        apic_type = "whpx-apic";
     }
-
     return APIC_COMMON_CLASS(object_class_by_name(apic_type));
 }
 
diff --git a/target/i386/whpx/irq.c b/target/i386/whpx/irq.c
new file mode 100644
index 0000000000..966916779e
--- /dev/null
+++ b/target/i386/whpx/irq.c
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "cpu.h"
+#include "hw/i386/apic_internal.h"
+#include "hw/i386/apic-msidef.h"
+#include "hw/pci/msi.h"
+#include "system/hw_accel.h"
+#include "system/whpx.h"
+#include "system/whpx-internal.h"
+#include "irq.h"
+#include "system/whpx-accel-ops.h"
+#include "system/whpx-all.h"
+#include "system/whpx-common.h"
+#include "qemu/memalign.h"
+#include "qemu/main-loop.h"
+
+
+/* Structure definition from Hyper-V, to keep unaltered */
+typedef struct _HV_X64_INTERRUPT_CONTROLLER_STATE
+{
+    UINT32 ApicId;
+    UINT32 ApicVersion;
+    UINT32 ApicLdr;
+    UINT32 ApicDfr;
+    UINT32 ApicSpurious;
+    UINT32 ApicIsr[8];
+    UINT32 ApicTmr[8];
+    UINT32 ApicIrr[8];
+    UINT32 ApicEsr;
+    UINT32 ApicIcrHigh;
+    UINT32 ApicIcrLow;
+    UINT32 ApicLvtTimer;
+    UINT32 ApicLvtThermal;
+    UINT32 ApicLvtPerfmon;
+    UINT32 ApicLvtLint0;
+    UINT32 ApicLvtLint1;
+    UINT32 ApicLvtError;
+    UINT32 ApicLvtCmci;
+    UINT32 ApicErrorStatus;
+    UINT32 ApicInitialCount;
+    UINT32 ApicCounterValue;
+    UINT32 ApicDivideConfiguration;
+    UINT32 ApicRemoteRead;
+
+} HV_X64_INTERRUPT_CONTROLLER_STATE, *PHV_X64_INTERRUPT_CONTROLLER_STATE;
+
+int whpx_request_interrupt(uint32_t interrupt_type, uint32_t vector,
+                           uint32_t vp_index, bool logical_dest_mode,
+                           bool level_triggered)
+{
+    HRESULT hr;
+
+    if (vector == 0) {
+        warn_report("Ignoring request for interrupt vector 0");
+        return 0;
+    }
+
+    WHV_INTERRUPT_CONTROL interrupt = {
+        .Type = interrupt_type,
+        .DestinationMode = logical_dest_mode ?
+            WHvX64InterruptDestinationModeLogical :
+            WHvX64InterruptDestinationModePhysical,
+
+        .TriggerMode = level_triggered ?
+            WHvX64InterruptTriggerModeLevel : WHvX64InterruptTriggerModeEdge,
+        .Reserved = 0,
+        .Vector = vector,
+        .Destination = vp_index,
+    };
+
+    hr = whp_dispatch.WHvRequestInterrupt(whpx_global.partition,
+                     &interrupt, sizeof(interrupt));
+    if (FAILED(hr)) {
+        error_report("Failed to request interrupt");
+        return -errno;
+    }
+    return 0;
+}
+
+static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
+{
+    return ((reg) & ~0x700) | ((mode) << 8);
+}
+
+static int get_lapic(CPUState* cpu, HV_X64_INTERRUPT_CONTROLLER_STATE* state)
+{
+    HRESULT hr;
+    UINT32 BytesWritten;
+
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+
+    hr = whp_dispatch.WHvGetVirtualProcessorState(
+            whpx_global.partition,
+            cpu->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            buffer,
+            size, &BytesWritten);
+    
+    if (!FAILED(hr)) {
+        memcpy(state, buffer, sizeof(*state));
+    } else {
+        error_report("Failed to get LAPIC");
+        return -1;
+    }
+    return 0;
+}
+
+static int set_lapic(CPUState* cpu, HV_X64_INTERRUPT_CONTROLLER_STATE* state)
+{
+    HRESULT hr;
+
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    memcpy(buffer, state, sizeof(*state));
+
+    hr = whp_dispatch.WHvSetVirtualProcessorState(
+            whpx_global.partition,
+            cpu->cpu_index,
+            WHvVirtualProcessorStateTypeInterruptControllerState2,
+            state,
+            sizeof(HV_X64_INTERRUPT_CONTROLLER_STATE));
+    if (FAILED(hr)) {
+        error_report("Failed to set LAPIC");
+        return -1;
+    }
+    return 0;
+}
+
+int whpx_set_lint(CPUState* cpu)
+{
+    int ret;
+    uint32_t *lvt_lint0, *lvt_lint1;
+
+    HV_X64_INTERRUPT_CONTROLLER_STATE lapic_state = { 0 };
+    ret = get_lapic(cpu, &lapic_state);
+    if (ret < 0) {
+        return ret;
+    }
+
+    lvt_lint0 = &lapic_state.ApicLvtLint0;
+    *lvt_lint0 = set_apic_delivery_mode(*lvt_lint0, APIC_DM_EXTINT);
+
+    lvt_lint1 = &lapic_state.ApicLvtLint1;
+    *lvt_lint1 = set_apic_delivery_mode(*lvt_lint1, APIC_DM_NMI);
+
+    /* TODO: should we skip setting lapic if the values are the same? */
+
+    return set_lapic(cpu, &lapic_state);
+}
diff --git a/target/i386/whpx/irq.h b/target/i386/whpx/irq.h
new file mode 100644
index 0000000000..02debc9e85
--- /dev/null
+++ b/target/i386/whpx/irq.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QEMU_X86_WHPX_H
+#define QEMU_X86_WHPX_H
+
+int whpx_request_interrupt(uint32_t interrupt_type, uint32_t vector,
+                           uint32_t vp_index, bool logical_dest_mode,
+                           bool level_triggered);
+
+int whpx_set_lint(CPUState* cpu);
+#endif /* QEMU_X86_WHPX_H */
diff --git a/target/i386/whpx/meson.build b/target/i386/whpx/meson.build
index c3aaaff9fd..5c13274b77 100644
--- a/target/i386/whpx/meson.build
+++ b/target/i386/whpx/meson.build
@@ -1,4 +1,4 @@
 i386_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
-  'whpx-apic.c',
+  'irq.c'
 ))
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c172e86886..8dd6f68ff9 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -36,6 +36,7 @@
 #include "system/whpx-accel-ops.h"
 #include "system/whpx-all.h"
 #include "system/whpx-common.h"
+#include "whpx/irq.h"
 
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
@@ -390,6 +391,7 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
      */
     if (level >= WHPX_LEVEL_RESET_STATE) {
         whpx_set_tsc(cpu);
+        whpx_set_lint(cpu);
     }
 
     memset(&vcxt, 0, sizeof(struct whpx_register_set));
@@ -621,17 +623,6 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
                      hr);
     }
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
-        /*
-         * Fetch the TPR value from the emulated APIC. It may get overwritten
-         * below with the value from CR8 returned by
-         * WHvGetVirtualProcessorRegisters().
-         */
-        whpx_apic_get(x86_cpu->apic_state);
-        vcpu->tpr = whpx_apic_tpr_to_cr8(
-            cpu_get_apic_tpr(x86_cpu->apic_state));
-    }
-
     idx = 0;
 
     /* Indexes for first 16 registers match between HV and QEMU definitions */
@@ -764,10 +755,6 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (level > WHPX_LEVEL_FAST_RUNTIME_STATE && whpx_irqchip_in_kernel()) {
-        whpx_apic_get(x86_cpu->apic_state);
-    }
-
     x86_update_hflags(env);
 }
 
diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
deleted file mode 100644
index f26ecaf6e8..0000000000
--- a/target/i386/whpx/whpx-apic.c
+++ /dev/null
@@ -1,286 +0,0 @@
-/*
- * WHPX platform APIC support
- *
- * Copyright (c) 2011 Siemens AG
- *
- * Authors:
- *  Jan Kiszka          <jan.kiszka@siemens.com>
- *  John Starks         <jostarks@microsoft.com>
- *
- * This work is licensed under the terms of the GNU GPL version 2.
- * See the COPYING file in the top-level directory.
- */
-#include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "cpu.h"
-#include "hw/i386/apic_internal.h"
-#include "hw/i386/apic-msidef.h"
-#include "hw/pci/msi.h"
-#include "system/hw_accel.h"
-#include "system/whpx.h"
-#include "system/whpx-internal.h"
-
-struct whpx_lapic_state {
-    struct {
-        uint32_t data;
-        uint32_t padding[3];
-    } fields[256];
-};
-
-static void whpx_put_apic_state(APICCommonState *s,
-                                struct whpx_lapic_state *kapic)
-{
-    int i;
-
-    memset(kapic, 0, sizeof(*kapic));
-    kapic->fields[0x2].data = s->id << 24;
-    kapic->fields[0x3].data = s->version | ((APIC_LVT_NB - 1) << 16);
-    kapic->fields[0x8].data = s->tpr;
-    kapic->fields[0xd].data = s->log_dest << 24;
-    kapic->fields[0xe].data = s->dest_mode << 28 | 0x0fffffff;
-    kapic->fields[0xf].data = s->spurious_vec;
-    for (i = 0; i < 8; i++) {
-        kapic->fields[0x10 + i].data = s->isr[i];
-        kapic->fields[0x18 + i].data = s->tmr[i];
-        kapic->fields[0x20 + i].data = s->irr[i];
-    }
-
-    kapic->fields[0x28].data = s->esr;
-    kapic->fields[0x30].data = s->icr[0];
-    kapic->fields[0x31].data = s->icr[1];
-    for (i = 0; i < APIC_LVT_NB; i++) {
-        kapic->fields[0x32 + i].data = s->lvt[i];
-    }
-
-    kapic->fields[0x38].data = s->initial_count;
-    kapic->fields[0x3e].data = s->divide_conf;
-}
-
-static void whpx_get_apic_state(APICCommonState *s,
-                                struct whpx_lapic_state *kapic)
-{
-    int i, v;
-
-    s->id = kapic->fields[0x2].data >> 24;
-    s->tpr = kapic->fields[0x8].data;
-    s->arb_id = kapic->fields[0x9].data;
-    s->log_dest = kapic->fields[0xd].data >> 24;
-    s->dest_mode = kapic->fields[0xe].data >> 28;
-    s->spurious_vec = kapic->fields[0xf].data;
-    for (i = 0; i < 8; i++) {
-        s->isr[i] = kapic->fields[0x10 + i].data;
-        s->tmr[i] = kapic->fields[0x18 + i].data;
-        s->irr[i] = kapic->fields[0x20 + i].data;
-    }
-
-    s->esr = kapic->fields[0x28].data;
-    s->icr[0] = kapic->fields[0x30].data;
-    s->icr[1] = kapic->fields[0x31].data;
-    for (i = 0; i < APIC_LVT_NB; i++) {
-        s->lvt[i] = kapic->fields[0x32 + i].data;
-    }
-
-    s->initial_count = kapic->fields[0x38].data;
-    s->divide_conf = kapic->fields[0x3e].data;
-
-    v = (s->divide_conf & 3) | ((s->divide_conf >> 1) & 4);
-    s->count_shift = (v + 1) & 7;
-
-    s->initial_count_load_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    apic_next_timer(s, s->initial_count_load_time);
-}
-
-static int whpx_apic_set_base(APICCommonState *s, uint64_t val)
-{
-    s->apicbase = val;
-    return 0;
-}
-
-static void whpx_put_apic_base(CPUState *cpu, uint64_t val)
-{
-    HRESULT hr;
-    WHV_REGISTER_VALUE reg_value = {.Reg64 = val};
-    WHV_REGISTER_NAME reg_name = WHvX64RegisterApicBase;
-
-    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
-             whpx_global.partition,
-             cpu->cpu_index,
-             &reg_name, 1,
-             &reg_value);
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set MSR APIC base, hr=%08lx", hr);
-    }
-}
-
-static void whpx_apic_set_tpr(APICCommonState *s, uint8_t val)
-{
-    s->tpr = val;
-}
-
-static uint8_t whpx_apic_get_tpr(APICCommonState *s)
-{
-    return s->tpr;
-}
-
-static void whpx_apic_vapic_base_update(APICCommonState *s)
-{
-    /* not implemented yet */
-}
-
-static void whpx_apic_put(CPUState *cs, run_on_cpu_data data)
-{
-    APICCommonState *s = data.host_ptr;
-    struct whpx_lapic_state kapic;
-    HRESULT hr;
-
-    whpx_put_apic_base(CPU(s->cpu), s->apicbase);
-    whpx_put_apic_state(s, &kapic);
-
-    hr = whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cs->cpu_index,
-        &kapic,
-        sizeof(kapic));
-    if (FAILED(hr)) {
-        fprintf(stderr,
-            "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
-             hr);
-
-        abort();
-    }
-}
-
-void whpx_apic_get(APICCommonState *s)
-{
-    CPUState *cpu = CPU(s->cpu);
-    struct whpx_lapic_state kapic;
-
-    HRESULT hr = whp_dispatch.WHvGetVirtualProcessorInterruptControllerState2(
-        whpx_global.partition,
-        cpu->cpu_index,
-        &kapic,
-        sizeof(kapic),
-        NULL);
-    if (FAILED(hr)) {
-        fprintf(stderr,
-            "WHvSetVirtualProcessorInterruptControllerState failed: %08lx\n",
-            hr);
-
-        abort();
-    }
-
-    whpx_get_apic_state(s, &kapic);
-}
-
-static void whpx_apic_post_load(APICCommonState *s)
-{
-    run_on_cpu(CPU(s->cpu), whpx_apic_put, RUN_ON_CPU_HOST_PTR(s));
-}
-
-static void whpx_apic_external_nmi(APICCommonState *s)
-{
-}
-
-static void whpx_send_msi(MSIMessage *msg)
-{
-    uint64_t addr = msg->address;
-    uint32_t data = msg->data;
-    uint8_t dest = (addr & MSI_ADDR_DEST_ID_MASK) >> MSI_ADDR_DEST_ID_SHIFT;
-    uint8_t vector = (data & MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
-    uint8_t dest_mode = (addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
-    uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
-    uint8_t delivery = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
-
-    if (vector == 0) {
-        warn_report("Ignoring request for interrupt vector 0");
-        return;
-    }
-
-    WHV_INTERRUPT_CONTROL interrupt = {
-        /* Values correspond to delivery modes */
-        .Type = delivery,
-        .DestinationMode = dest_mode ?
-            WHvX64InterruptDestinationModeLogical :
-            WHvX64InterruptDestinationModePhysical,
-
-        .TriggerMode = trigger_mode ?
-            WHvX64InterruptTriggerModeLevel : WHvX64InterruptTriggerModeEdge,
-        .Reserved = 0,
-        .Vector = vector,
-        .Destination = dest,
-    };
-    HRESULT hr = whp_dispatch.WHvRequestInterrupt(whpx_global.partition,
-                     &interrupt, sizeof(interrupt));
-    if (FAILED(hr)) {
-        fprintf(stderr, "whpx: injection failed, MSI (%llx, %x) delivery: %d, "
-                "dest_mode: %d, trigger mode: %d, vector: %d, lost (%08lx)\n",
-                addr, data, delivery, dest_mode, trigger_mode, vector, hr);
-    }
-}
-
-static uint64_t whpx_apic_mem_read(void *opaque, hwaddr addr,
-                                   unsigned size)
-{
-    return ~(uint64_t)0;
-}
-
-static void whpx_apic_mem_write(void *opaque, hwaddr addr,
-                                uint64_t data, unsigned size)
-{
-    MSIMessage msg = { .address = addr, .data = data };
-    whpx_send_msi(&msg);
-}
-
-static const MemoryRegionOps whpx_apic_io_ops = {
-    .read = whpx_apic_mem_read,
-    .write = whpx_apic_mem_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void whpx_apic_reset(APICCommonState *s)
-{
-    /* Not used by WHPX. */
-    s->wait_for_sipi = 0;
-
-    run_on_cpu(CPU(s->cpu), whpx_apic_put, RUN_ON_CPU_HOST_PTR(s));
-}
-
-static void whpx_apic_realize(DeviceState *dev, Error **errp)
-{
-    APICCommonState *s = APIC_COMMON(dev);
-
-    memory_region_init_io(&s->io_memory, OBJECT(s), &whpx_apic_io_ops, s,
-                          "whpx-apic-msi", APIC_SPACE_SIZE);
-
-    msi_nonbroken = true;
-}
-
-static void whpx_apic_class_init(ObjectClass *klass, const void *data)
-{
-    APICCommonClass *k = APIC_COMMON_CLASS(klass);
-
-    k->realize = whpx_apic_realize;
-    k->reset = whpx_apic_reset;
-    k->set_base = whpx_apic_set_base;
-    k->set_tpr = whpx_apic_set_tpr;
-    k->get_tpr = whpx_apic_get_tpr;
-    k->post_load = whpx_apic_post_load;
-    k->vapic_base_update = whpx_apic_vapic_base_update;
-    k->external_nmi = whpx_apic_external_nmi;
-    k->send_msi = whpx_send_msi;
-}
-
-static const TypeInfo whpx_apic_info = {
-    .name = "whpx-apic",
-    .parent = TYPE_APIC_COMMON,
-    .instance_size = sizeof(APICCommonState),
-    .class_init = whpx_apic_class_init,
-};
-
-static void whpx_apic_register_types(void)
-{
-    type_register_static(&whpx_apic_info);
-}
-
-type_init(whpx_apic_register_types)
-- 
2.50.1 (Apple Git-155)


