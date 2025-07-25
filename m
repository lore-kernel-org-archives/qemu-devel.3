Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BFBC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 22:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufQyU-0007Vp-OT; Fri, 25 Jul 2025 18:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQx0-0006fq-1i
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:39 -0400
Received: from p-east3-cluster3-host11-snip4-9.eps.apple.com ([57.103.86.112]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufQwd-0003nA-8T
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 18:31:20 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 9E50D180015B; Fri, 25 Jul 2025 22:30:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=NU3Hu1rx9Rx7hevDcj15AMvNTbIWTQANbIz+11VVeZI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=DNpBOxL3g6K2nxuRqfgglSbJ8W/A3NtJdEDAYwfsa+F0gLe8LDEJ719Rp73q0OyKRd+V3v5i+PKyD4FL/T8RDzNhjmhKMGbfMRRQl2L+G5/K8IjrXEO71fplJ6831KMmvHWNbomHTOuTGfPXHnAe6mA0idFc8hLPGcv4nd9kp9WH0MCLMGCDOn2HlvJxCDFBrTD+fS5vpi+GjIUjtEgN9f3Uog/ya+nMaLCbPNqGqs4VjVWLGoIYSOF9YDuwEApcBryFp3wE+uRdwyXZ0pX9BXjsPgnp3jkCfec+nODG692bjBxEEI/mIMMhTGx4My0yUKrtHLMIlNY2qBQgbmge3A==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 4254018000B1; Fri, 25 Jul 2025 22:30:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v3 5/9] hw/arm, target/arm: nested virtualisation on HVF
Date: Sat, 26 Jul 2025 00:30:31 +0200
Message-Id: <20250725223035.52284-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725223035.52284-1-mohamed@unpredictable.fr>
References: <20250725223035.52284-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: W3Yn_c6TgROg2D8CG0qfI13KJQEUBuzE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE5NSBTYWx0ZWRfX6sYEv4ElXLmb
 jNWfAcg6tvwmXxmGQyvnwmFc3CPQQoPDuTWywkFg1C/WdPLau7jsqc5ae/0FRkk30MhDE2/tvYr
 aJDpBX8zPN6wFmK3MoeR8uiFUl3yRb8dbGYDfSpEyyCWIP0B8XzspO2eZAU1NDBeUAldzw+hOiq
 oMB883/iBRswkQuzp1U3lzmTV8Ly6NvgSnBppXhEvSTU/5aa4GfGa3PrLNv67KW3iHZ2VRh4Uky
 ktxPPhOcoCef9g0KT++j81cP4uWmIspuT8s34uK+THXLhFsW7xQXq8bQbVQQzzvi3TjGJa27w=
X-Proofpoint-ORIG-GUID: W3Yn_c6TgROg2D8CG0qfI13KJQEUBuzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 clxscore=1030 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250195
Received-SPF: pass client-ip=57.103.86.112;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 target/arm/hvf/hvf.c  | 35 +++++++++++++++++++++++++++++++++++
 target/arm/hvf_arm.h  |  3 +++
 4 files changed, 59 insertions(+), 3 deletions(-)

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
index 7beb47caad..affc22ff61 100644
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
     /* We set up a small vcpu to extract host registers */
 
     if (hv_vcpu_create(&fd, &exit, NULL) != HV_SUCCESS) {
@@ -964,6 +969,25 @@ uint32_t hvf_arm_get_max_ipa_bit_size(void)
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
@@ -1000,6 +1024,13 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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
     if (hvf_irqchip_in_kernel()) {
         /*
@@ -1146,6 +1177,10 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     int target_el = 1;
     int32_t ret = 0;
 
+    if (hvf_arm_el2_enabled()) {
+        target_el = 2;
+    }
+
     trace_hvf_psci_call(param[0], param[1], param[2], param[3],
                         arm_cpu_mp_affinity(arm_cpu));
 
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


