Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D91F506D4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w27fW-0000s9-GS; Mon, 16 Mar 2026 09:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fU-0000qY-3o
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:36 -0400
Received: from p-west1-cluster3-host8-snip4-4.eps.apple.com ([57.103.66.57]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w27fS-0003bL-9z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 09:07:35 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id
 451C81803666; Mon, 16 Mar 2026 13:07:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773666453; x=1776258453;
 bh=4us1IaAjiJrMXg7NiG5qx/XtU2pODGZnDkONnsaRDvs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LBnnoUdMqC/vkTZi3MBrdtXVjBYogC008LE5evcKQPC3+kewl0vtUHPCm71XkQ2TXsYbHh1oX+31CAlrMWF03hbbhO1YllOlj12q2kBi/U2maqgv6WW+N+o6xjrHbwPc0LL1h77P78oEN+nm+Bwpb8pvJN17tQJB28mjE788Qty7JQ2DBKCjgX/5rQk/pjBfeMAUFnhEAgo0dQL6KGk0LyvQnMXS7RZNJJiuFmL7Xi/8N5JwEzZZAwTsb8d/q80CKzrP3Xr4wrFOGdRZQXYoRAgLObFZfmnLs0xz27Dw2aVmwHigt+Lgwh+JnoEFxwtSxsG3W/bzZjVwoBn4YiPlzQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id
 E2DE61807B3D; Mon, 16 Mar 2026 13:06:59 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v20 05/15] hw/arm, target/arm: nested virtualisation on HVF
Date: Mon, 16 Mar 2026 14:06:32 +0100
Message-ID: <20260316130642.13246-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260316130642.13246-1-mohamed@unpredictable.fr>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=INcPywvG c=1 sm=1 tr=0 ts=69b80094
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=G65AtosZd4T4P2EQXfAA:9
X-Proofpoint-GUID: wKD8ioij3kSEtaezQV_Zch39L2pAN2Fv
X-Proofpoint-ORIG-GUID: wKD8ioij3kSEtaezQV_Zch39L2pAN2Fv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMCBTYWx0ZWRfXzlG+o2JxVLl9
 buxFKBOd/1VeLyC4ijEQk/j09jKXBLNPIzuGswzi5hm/MZ64sbSlc2xo1bcCiR7fSz/OAFXOC61
 1/wRTPjNimJT3629Vq26vfnLcMUrtR5+LFwmZLDZsC9p4AwPD33B7xBUNzhcjAmS/56t3K9SmDQ
 5TOXR/dJ4Wp9UnT6IDbd0mj0ES3ZWdFZHiwFCDtEjDZNPGnDSTIikKd//HHCO0Xj3r82B73v4lO
 vQIPDlj9JP9zsp2DscSZN6k/qC/oB7Ott/3GVdjj/c4KiQWWPC9Yly+XIsWCnBygZAX9Y/uddxE
 p0MBsk7OjY1G4/mLEsxWJQoeppsNFOBV2LuFdXmh8vK0lUzDY7TL0CmC+M2jTU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0
 clxscore=1030 lowpriorityscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603160100
Received-SPF: pass client-ip=57.103.66.57;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
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
index 7a6fad1094..90769936d0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2661,6 +2661,11 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
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
index d431d96ba3..d6ef4488fa 100644
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
     target_ulong entry;
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


