Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF93C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 13:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viYjg-00009U-C3; Wed, 21 Jan 2026 08:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjD-0008Sd-Le
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:38 -0500
Received: from p-west3-cluster6-host5-snip4-5.eps.apple.com ([57.103.75.108]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viYjA-0007GK-PW
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 08:58:35 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPS id
 666E41801C40; Wed, 21 Jan 2026 13:58:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769003911; x=1771595911;
 bh=dpxKaoyvLq36tuLjK3N6LQyXgvP0j6ERPd1KiEucaio=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cQdjz/pBAYLgAvpGMaEk7JUMjNwNZdm1BAoylheSLvONOeTPpELyxHVEdq5aW3HWInwD2Nu0oMMlZwONi0G4ibFQUWZX8OD47xiwEyt6dWGr+Ejnot5AT3gVVlU9TB9qfS/VkhNPQmqRRidNFe+zQCp5rpRrtvtS68ZkL3Fmm8Sdk8D4cSNAEGRn+Rq0al/i5GYAmXu5u/WWWvpN3GKoH/gIpq8sfeHupc/yarji62SHTf6c+JkKFz7r2PgNMXiyBH+WoUTwCXBjJJcxlYOkrzFBISwLqPX2M6VOuLDm4x9C21jdgHdU4hdvCGROtLfOL76GZS9iDhbKMOImw54gpw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-3 (Postfix) with ESMTPSA id
 2556E180105A; Wed, 21 Jan 2026 13:58:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v8 04/11] hw/arm, target/arm: nested virtualisation on HVF
Date: Wed, 21 Jan 2026 14:58:09 +0100
Message-ID: <20260121135816.21258-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121135816.21258-1-mohamed@unpredictable.fr>
References: <20260121135816.21258-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -nJf3H4A6i47e2YtAju1OaH_nFfP_a5f
X-Authority-Info-Out: v=2.4 cv=AYy83nXG c=1 sm=1 tr=0 ts=6970db86
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0QeE6rx795gg9bSW8oEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfX+IYMcpxOvMKZ
 PeiUFjZayAVqd5YuJTny9jgkIdZTjmxrVtbEGiVOGgdWVMtpchsNrRSYKaZK2seizj+Q7cEd6kW
 4OalrEN0znIXHBKp8xR3HbLUmw9nbwqVLF2PCK7B06iVp3VpOZPykW0j8gHdLcNC0HNYf44LbSI
 ea8nH3HuI59AHoBW4ymiRqLKaJnQ5Hj9iGvn+I7hTqyBwiAaDyzEcPK2hUN5zRQOFT4skInTWhi
 HsmyyG4fPdzK8zjIf71IWXqiz8J5VHIyM3jA7rXm6mrlDyn0ULOQhDfC6OEsFlUwNbHv75oyV4S
 gf/LR2MH5n1R/9imvEO
X-Proofpoint-ORIG-GUID: -nJf3H4A6i47e2YtAju1OaH_nFfP_a5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1030 mlxlogscore=905 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601210118
X-JNJ: AAAAAAABv4/GCSNvhA3HNXacqbSZJoIWjwQ1zHHdQFhSOmvXemRXx7icfz/IhI3kscNAn02/RCDu0fkk2Y/mmAI24rKY616xwAeJf2UqEzOq4HMAQkU6xeZr/OO4Ln3owttq/XTjKV/tPrOkJFsqNzkTgp2CWqX2reMJgBwU0cM3FmJemeNOoXmJlaOHKFoWLNhqmag2eTJlnX5T6M60od0lOpzi4UqwPc5hh+YcqD9E7khjAGiDtjP8pvUwqoI2wFldMskSd25HD3/X9Ueuh1Pcr4NyRhifHsSdyWZDctrO9AuHpL7WZU5ZjC0NlRgJnq8KCGqcYSgvIHZXtoUk5r+BFeV2zaHc2XzCuQjmlatcRZA+4drPYJxllBsT7eVKxvRK300BwcZGwBR5gNlQobJjJGaM/kRQlSz+LNEG2FBN8oXZ+7E1LEDtwP3WbZqLriPOJjxON9fKV3kvfk/G4HEIztaLV8d+YMlAHbOqwcACyEdRK2BIdFPk6orGga7sg4r6acKuDwoEuELl0+XvSxr0boGgCStg4CKgw+N5IyCMQvwp21ObidHshKv9PzJQ01ImbGAdm8nYIa4H6zR876g7qGqi3R6lvoMldqtjD9WmRo9FrffLk32BmFVScYIWDxi6CAPtP9KjO+ZmyJKxTUnd9SYUgUELy7PlGvAsF2LCi+/INfuys69ZXmZL2+YBqpmCkTZy+oE=
Received-SPF: pass client-ip=57.103.75.108;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c    |  1 +
 accel/stubs/hvf-stub.c |  1 +
 hw/arm/virt.c          |  8 +++++++-
 include/system/hvf.h   |  5 +++++
 target/arm/hvf/hvf.c   | 36 ++++++++++++++++++++++++++++++++++--
 5 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 929f53fd37..88f6d5accb 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -25,6 +25,7 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
 
 const char *hvf_return_string(hv_return_t ret)
 {
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index 6bd08759ba..cec1cbb056 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -11,3 +11,4 @@
 
 bool hvf_allowed;
 bool hvf_kernel_irqchip;
+bool hvf_nested_virt;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4b4f572f9f..d39e190076 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2383,7 +2383,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && !kvm_enabled() && !tcg_enabled()
+       && !hvf_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
@@ -2651,6 +2652,11 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
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
index dc8da85979..0f0632f7ae 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -28,9 +28,14 @@ extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
 extern bool hvf_kernel_irqchip;
 #define hvf_irqchip_in_kernel()  (hvf_kernel_irqchip)
+extern bool hvf_nested_virt;
+#define hvf_nested_virt_enabled()  (hvf_nested_virt)
+#define hvf_nested_virt_enable(enable) hvf_nested_virt = enable
 #else /* !CONFIG_HVF_IS_POSSIBLE */
 #define hvf_enabled() 0
 #define hvf_irqchip_in_kernel() 0
+#define hvf_nested_virt_enabled() 0
+#define hvf_nested_virt_enable(enable) 0
 #endif /* !CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a220699077..fe9b63bc76 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -28,6 +28,7 @@
 #include "system/memory.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
+#include "hw/arm/virt.h"
 #include "qemu/main-loop.h"
 #include "system/cpus.h"
 #include "arm-powerctl.h"
@@ -772,6 +773,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                      (1ULL << ARM_FEATURE_PMU) |
                      (1ULL << ARM_FEATURE_GENERIC_TIMER);
 
+    if (hvf_nested_virt_enabled()) {
+        ahcf->features |= 1ULL << ARM_FEATURE_EL2;
+    }
+
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
@@ -879,6 +884,15 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
+static bool hvf_arm_el2_supported(void)
+{
+    bool is_nested_virt_supported;
+    hv_return_t ret = hv_vm_config_get_el2_supported(&is_nested_virt_supported);
+    assert_hvf_ok(ret);
+    return is_nested_virt_supported;
+}
+
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
@@ -890,6 +904,18 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    if (hvf_nested_virt_enabled()) {
+        if (!hvf_arm_el2_supported()) {
+            error_report("Nested virtualization not supported on this system.");
+            goto cleanup;
+        }
+        ret = hv_vm_config_set_el2_enabled(config, true);
+        if (ret != HV_SUCCESS) {
+            error_report("Failed to enable nested virtualization.");
+            goto cleanup;
+        }
+    }
+
     ret = hv_vm_create(config);
 
 cleanup:
@@ -1024,6 +1050,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
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
@@ -1045,7 +1078,6 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_arm_psci_call(param[0], param[1], param[2], param[3],
@@ -1099,7 +1131,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
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


