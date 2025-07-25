Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDF5C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 08:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufDtQ-0005pB-3M; Fri, 25 Jul 2025 04:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtO-0005ma-Dl
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:35:02 -0400
Received: from p-west3-cluster6-host10-snip4-3.eps.apple.com ([57.103.75.96]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ufDtL-0003Q0-TQ
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 04:35:01 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPS id
 C5A49180030A; Fri, 25 Jul 2025 08:34:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=zYoKhug/4pWA3nspJYK5o5YznfSEDBdDyldDYHvNhx0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=HLc1iZRotlxAgbGjx+fkmbHUzXlmXPLMHmK+bevGaMZ9LjBF3TpXfBA/rbI4bzkX3py3xMirwmOzyLbUomSGklXR6SCXBFrO+8boS0DizGfp6ptAv5Z7wg/FYd4/8+1Ib02s8ITsEuqnUPO6cQ3bscZvTuO0WwYrUUmAwzLdz2vRfdkJfOdjHPwK5ODpTqdASSC/gHxu3eCGDOYtB09AJr3KQvXk89QwKcYsLjxkeTYGs3r7th4L3zu7+wvc2KABC2QpVGo1c72pyq1PvOTHm2CzeRE75ZZHFdMqhTtY0H3ty4HPl9UocykQUQTnfByOpU4vSrGte3HghkU3Z5cBeA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (ms-asmtp-me-k8s.p00.prod.me.com
 [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-2 (Postfix) with ESMTPSA id
 C308D18000B4; Fri, 25 Jul 2025 08:34:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 6/9] hw/arm, target/arm: nested virtualisation on HVF
Date: Fri, 25 Jul 2025 10:34:28 +0200
Message-Id: <20250725083431.91450-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250725083431.91450-1-mohamed@unpredictable.fr>
References: <20250725083431.91450-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA3MiBTYWx0ZWRfX1NLx//hlqJxi
 AkYjvZaqEUKBrHip6zYfSEIYXcfZCxiCVOaJN8flrqQsMMcBdQ35IRuY9hcwGdg2f5/csJCVsIl
 YH6BVioNMmuQiGgGKynH+7/WdAQD5Uj3dw1r20yvs+lA8uhhIJdTQ2789Iz+WFrWdNSVLnen8/d
 Mg1DXhh0AZNnRtWWi96412bjCw6Hd8nqu+jhc2wCxYFATTp0CxvSXSCu217rT4xBGYmO3FZxXgH
 EzwVdyJp5PojEe5tYuGC62dNlgHp3aoMCYJTaDr1vrXoORHSKzNked9ZreLYKORAt5l1F6pf4=
X-Proofpoint-GUID: fEM7CnpPScA0J4xV56Zuspa7IZ8HfrQS
X-Proofpoint-ORIG-GUID: fEM7CnpPScA0J4xV56Zuspa7IZ8HfrQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0
 phishscore=0 clxscore=1030 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507250072
Received-SPF: pass client-ip=57.103.75.96;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/arm/virt.c         |  6 +++---
 target/arm/hvf-stub.c | 15 +++++++++++++++
 target/arm/hvf/hvf.c  | 35 +++++++++++++++++++++++++++++++++++
 target/arm/hvf_arm.h  |  3 +++
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a26bde4c75..df77a1d911 100644
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
@@ -2278,7 +2277,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
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
index 7b4e8297af..c32e6ab289 100644
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


