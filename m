Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF6EC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugO7J-0007bD-2t; Mon, 28 Jul 2025 09:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6h-0004dJ-I6
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:41 -0400
Received: from p-east3-cluster1-host5-snip4-5.eps.apple.com ([57.103.87.48]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ugO6d-0004HQ-Mq
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 09:41:34 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 5D43B1819D29; Mon, 28 Jul 2025 13:41:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=evefjghnv7Z5+Cuhv/lLMHRS85VgDNofks7QkKkDkj8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Vc615MdjR+zltypIfQExvlDV8CTnAShG/GLxYAJ1Mtl0ivI/aqclbGZr2mNkLFoDfMVnQ9xBcgJfMqazz1Dv3v6SqfXvEb+rEu3MiW748gyQO3ha6xPgn5Ea/KyzFEFiJZde8x4zZkbjqAfOpY8n9Bv2oW/mlM714cU5qcIuK0/efSSDmjEGkwN4D5+QFkCaOxrhlPisNIeYXk30jfBwUmtT6zSwbj557KxHWXVc0jEK5LqlEPRNPTbatfJ9h6v3iaEpqo/5ZWtT3FGaiVfDHzthfbUvCkYLPjZnUzM8QhyRIHe1Ln07qDf7fxVvcHleSYL+bXUEExbOxYMMIXDNng==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 255AB181977E; Mon, 28 Jul 2025 13:41:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 04/13] hw/arm, target/arm: nested virtualisation on HVF
Date: Mon, 28 Jul 2025 15:41:05 +0200
Message-Id: <20250728134114.77545-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250728134114.77545-1-mohamed@unpredictable.fr>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hmJqNe0pQ8U2Vn9W8HMGn4NQKZjNURTK
X-Proofpoint-ORIG-GUID: hmJqNe0pQ8U2Vn9W8HMGn4NQKZjNURTK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMSBTYWx0ZWRfXwKVI6URmPhdq
 ZrOsyxt4xqw7mmmVHxUMw2AHCGL6l69Cq8m8Kg4MHKs7X3/dHAb35woAVq2rJYtZg40BOvDusIv
 qfs8Yz83b0TqO7u7aYDTYjlg+oThZY1+HZmzOup2ztSp+55UAv0/R/O9Y588gruBoGNq4UCzWFf
 KUo6QTMB+qxgdFAv3fdIs8HRuCdsuo5eJTyZXa8owuKazrz3WHiqcR7M0TWvJD4xPV0gC/gRzm3
 i4mlLOk5WU9eTpSwbJRSePyl0DEu7qbE+tH9fWVY6BM5Egq4FEbbFS+ImyIp5rX7sSJUv4BNM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507280101
Received-SPF: pass client-ip=57.103.87.48;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c         |  9 ++++++---
 target/arm/hvf-stub.c | 15 +++++++++++++++
 target/arm/hvf/hvf.c  | 41 +++++++++++++++++++++++++++++++++++++++--
 target/arm/hvf_arm.h  |  3 +++
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7da1176cda..7348d55104 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -817,8 +817,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         g_assert_not_reached();
     }
 
-    if (kvm_enabled() && vms->virt &&
-        (revision != 3 || !kvm_irqchip_in_kernel())) {
+    if (kvm_enabled() && vms->virt && (revision != 3 || !kvm_irqchip_in_kernel())) {
         error_report("KVM EL2 is only supported with in-kernel GICv3");
         exit(1);
     }
@@ -2279,7 +2278,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
@@ -2549,6 +2549,9 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
     vms->virt = value;
+#if defined(CONFIG_HVF) && defined(__aarch64__)
+    hvf_arm_el2_enable(value);
+#endif
 }
 
 static bool virt_get_highmem(Object *obj, Error **errp)
diff --git a/target/arm/hvf-stub.c b/target/arm/hvf-stub.c
index ff137267a0..95ec4ea62f 100644
--- a/target/arm/hvf-stub.c
+++ b/target/arm/hvf-stub.c
@@ -18,3 +18,18 @@ uint32_t hvf_arm_get_max_ipa_bit_size(void)
 {
     g_assert_not_reached();
 }
+
+bool hvf_arm_el2_supported(void)
+{
+    g_assert_not_reached();
+}
+
+bool hvf_arm_el2_enabled(void)
+{
+    g_assert_not_reached();
+}
+
+void hvf_arm_el2_enable(bool)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5ee0df17e3..4ac42bda32 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -26,6 +26,7 @@
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "hw/boards.h"
+#include "hw/arm/virt.h"
 #include "hw/irq.h"
 #include "qemu/main-loop.h"
 #include "system/cpus.h"
@@ -891,6 +892,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                      (1ULL << ARM_FEATURE_PMU) |
                      (1ULL << ARM_FEATURE_GENERIC_TIMER);
 
+    if (hvf_arm_el2_enabled()) {
+        ahcf->features |= 1ULL << ARM_FEATURE_EL2;
+    }
+
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
         r |= hv_vcpu_config_get_feature_reg(hv_vcpu_config, regs[i].reg, regs[i].val);
     }
@@ -957,6 +962,25 @@ uint32_t hvf_arm_get_max_ipa_bit_size(void)
     return round_down_to_parange_bit_size(max_ipa_size);
 }
 
+bool hvf_arm_el2_supported(void)
+{
+    bool is_nested_virt_supported;
+    hv_return_t ret = hv_vm_config_get_el2_supported(&is_nested_virt_supported);
+    assert_hvf_ok(ret);
+    return is_nested_virt_supported;
+}
+
+static bool is_nested_virt_enabled = false;
+bool hvf_arm_el2_enabled(void)
+{
+    return is_nested_virt_enabled;
+}
+
+void hvf_arm_el2_enable(bool enable)
+{
+    is_nested_virt_enabled = enable;
+}
+
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 {
     if (!arm_host_cpu_features.dtb_compatible) {
@@ -993,6 +1017,13 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    if (hvf_arm_el2_enabled()) {
+        ret = hv_vm_config_set_el2_enabled(config, true);
+        if (ret != HV_SUCCESS) {
+            goto cleanup;
+        }
+    }
+
     ret = hv_vm_create(config);
 
 cleanup:
@@ -1100,6 +1131,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
     assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
 }
 
+static int hvf_psci_get_target_el(void)
+{
+    if (hvf_arm_el2_enabled()) {
+        return 2;
+    }
+    return 1;
+}
 /*
  * Handle a PSCI call.
  *
@@ -1121,7 +1159,6 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_hvf_psci_call(param[0], param[1], param[2], param[3],
@@ -1175,7 +1212,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
         entry = param[2];
         context_id = param[3];
         ret = arm_set_cpu_on(mpidr, entry, context_id,
-                             target_el, target_aarch64);
+                             hvf_psci_get_target_el(), target_aarch64);
         break;
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index ea82f2691d..bf55e7ae28 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -24,5 +24,8 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
 uint32_t hvf_arm_get_default_ipa_bit_size(void);
 uint32_t hvf_arm_get_max_ipa_bit_size(void);
+bool hvf_arm_el2_supported(void);
+bool hvf_arm_el2_enabled(void);
+void hvf_arm_el2_enable(bool);
 
 #endif
-- 
2.39.5 (Apple Git-154)


