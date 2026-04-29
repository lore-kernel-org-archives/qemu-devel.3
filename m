Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34E0CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAET-0001kh-GD; Wed, 29 Apr 2026 15:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAER-0001j8-FI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:59 -0400
Received: from p-west3-cluster3-host11-snip4-1.eps.apple.com ([57.103.72.212]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wIAEO-0000Kl-SC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:05:59 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 217F218002FE; Wed, 29 Apr 2026 19:05:52 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJB01fDl4fBBdGGVUERx5dVl4eGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCAEkKXQJYAF4LTgZeD0YEXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777489555; x=1780081555;
 bh=yZx98LY09BbocJ00r+qP/G0lHxvenoMAqxbVzoJVGvM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Sr6Qp476EEXI24h9Ujz6MKi0y9lVP4PcMrVelIzu5nS+Uea+p8jS8CBgHyJaefMZHB2xARe3qrjvZBKTDKVlw0lJ675UIYtYSItjMDBq/mtmF+aMBhbNVVvSMKO/D26ptnFwKJhp+CmmUIjSM5oCfV8tNIHXbjy/W9flthJz98bmaO977tEPvNYkGGp1md8C9ULoDK5WktVo6nMXvM/ouQm5QDMDIvdpqZKH3Y1olIgdl2oihSsktbyAgJgZiFUkHdi8Aqhrsk0E+TcliOV1LWE28gZ3BSfJn4IHFlOSVMLVNJKT7dJeK/+YNbCEUfkAbX3LgnsVjVdB+IeRPYvsYw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 0656718000C6; Wed, 29 Apr 2026 19:05:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v21 05/15] hw/arm, target/arm: nested virtualisation on HVF
Date: Wed, 29 Apr 2026 21:05:22 +0200
Message-ID: <20260429190532.26538-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260429190532.26538-1-mohamed@unpredictable.fr>
References: <20260429190532.26538-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kspU_qUsSzrKKmFb6jubd9SpNh7-zUtU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE5MCBTYWx0ZWRfX6F4K8/9kStRJ
 CMR6ZKTunqQ6Td2vjHQwDjXKDrgLYjRU7vt92usi3TJXkR6MRFi5e4vu+L/CB23GoNQP/AYzza0
 30jjTPZi2UUB6uMdeCPSq3KdQvhP82ot/rHEOIYBGljibb41nRRti1yy8nqwmAJgABHM+jxWSI8
 EKEonzrY1JJ26v6gj7hModGeQsmJnfztVlKDXYIyX0TZwtUtGUjiE42h/S/bdNpSN6MiEh01Ht+
 WuI6ODetJIxdQA5u+8J8YayVVMOUvhHBYtcEvdpExhgAjrPm6aSsbl/5+zgbZTmBk59b6x8jE4C
 wcAENiX6c4aoKH/vNumrVO5LhFEuRFuRwFftE1FsJabW2l6d0S9+ZkxgnC6ozM=
X-Proofpoint-GUID: kspU_qUsSzrKKmFb6jubd9SpNh7-zUtU
X-Authority-Info-Out: v=2.4 cv=d7H4CBjE c=1 sm=1 tr=0 ts=69f25692
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=G65AtosZd4T4P2EQXfAA:9
 a=cvBusfyB2V15izCimMoJ:22
Received-SPF: pass client-ip=57.103.72.212;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add hvf_arm_el2_supported for querying EL2 availability.
An hvf_nested_virt_enable workaround is added as nested virt has
to be enabled early on HVF.

And adds hvf_nested_virt_enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 accel/hvf/hvf-all.c    |  5 +++++
 accel/stubs/hvf-stub.c | 10 ++++++++++
 hw/arm/virt.c          |  5 +++++
 include/system/hvf.h   |  5 +++++
 target/arm/hvf/hvf.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index add265e0c8..48c653630f 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -24,6 +24,11 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
+
+void hvf_nested_virt_enable(bool nested_virt) {
+    hvf_nested_virt = nested_virt;
+}
 
 const char *hvf_return_string(hv_return_t ret)
 {
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index 6bd08759ba..dc365c5307 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -11,3 +11,13 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
+
+void hvf_nested_virt_enable(bool nested_virt) {
+    /*
+     * This is called unconditionally from hw/arm/virt.c
+     * because we don't know if HVF is going to be used
+     * as that step of initialisation happens later.
+     * As such, do nothing here instead of marking as unreachable.
+     */
+}
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 47400214a2..ca50411020 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2987,6 +2987,11 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     vms->virt = value;
+    /*
+     * At this point, HVF is not initialised yet.
+     * However, it needs to know if nested virt is enabled at init time.
+     */
+    hvf_nested_virt_enable(value);
 }
 
 static bool virt_get_highmem(Object *obj, Error **errp)
diff --git a/include/system/hvf.h b/include/system/hvf.h
index dc8da85979..a961df8b95 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -28,11 +28,16 @@ extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
 extern bool hvf_kernel_irqchip;
 #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
+extern bool hvf_nested_virt;
+#define hvf_nested_virt_enabled()  (hvf_nested_virt)
 #else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
 #define hvf_irqchip_in_kernel() 0
+#define hvf_nested_virt_enabled() 0
 #endif /* !CONFIG_HVF_IS_POSSIBLE */
 
+void hvf_nested_virt_enable(bool nested_virt);
+
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
 typedef struct HVFState HVFState;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a028c99e24..09f41094e5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -27,6 +27,7 @@
 #include "system/memory.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
+#include "hw/arm/virt.h"
 #include "qemu/main-loop.h"
 #include "system/cpus.h"
 #include "arm-powerctl.h"
@@ -1103,6 +1104,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                      (1ULL << ARM_FEATURE_PMU) |
                      (1ULL << ARM_FEATURE_GENERIC_TIMER);
 
+    if (hvf_nested_virt_enabled()) {
+        ahcf->features |= 1ULL << ARM_FEATURE_EL2;
+    }
+
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
@@ -1218,6 +1223,19 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
+static bool hvf_arm_el2_supported(void)
+{
+    bool is_nested_virt_supported;
+    if (__builtin_available(macOS 15.0, *)) {
+        hv_return_t ret = hv_vm_config_get_el2_supported(&is_nested_virt_supported);
+        assert_hvf_ok(ret);
+    } else {
+        return false;
+    }
+    return is_nested_virt_supported;
+}
+
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
@@ -1229,6 +1247,20 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    if (__builtin_available(macOS 15.0, *)) {
+        if (hvf_nested_virt_enabled()) {
+            if (!hvf_arm_el2_supported()) {
+                error_report("Nested virtualization not supported on this system.");
+                goto cleanup;
+            }
+            ret = hv_vm_config_set_el2_enabled(config, true);
+            if (ret != HV_SUCCESS) {
+                error_report("Failed to enable nested virtualization.");
+                goto cleanup;
+            }
+        }
+    }
+
     ret = hv_vm_create(config);
     if (hvf_irqchip_in_kernel()) {
         if (__builtin_available(macOS 15.0, *)) {
@@ -1420,6 +1452,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
     assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
 }
 
+static int hvf_psci_get_target_el(void)
+{
+    if (hvf_nested_virt_enabled()) {
+        return 2;
+    }
+    return 1;
+}
 /*
  * Handle a PSCI call.
  *
@@ -1441,7 +1480,6 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     uint64_t entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_arm_psci_call(param[0], param[1], param[2], param[3],
@@ -1495,7 +1533,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
         entry = param[2];
         context_id = param[3];
         ret = arm_set_cpu_on(mpidr, entry, context_id,
-                             target_el, target_aarch64);
+                             hvf_psci_get_target_el(), target_aarch64);
         break;
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
-- 
2.50.1 (Apple Git-155)


