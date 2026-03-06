Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2EBF0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4r-0007WR-FV; Fri, 06 Mar 2026 02:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4q-0007W9-05
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:28 -0500
Received: from p-west2-cluster1-host11-snip4-10.eps.apple.com ([57.103.68.33]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4o-00067i-9f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:27 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 7B7751800249; Fri,  6 Mar 2026 07:58:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783905; x=1775375905;
 bh=8XH+Hhnj5QM/AUysPNVtOAslN9RQQb3vjnIJaHs60Yw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=anhmAZX+Ddz0BkornuZpjGtrtxsV92PjdNo54nHNcBqwx0xYz0bRtSPh9qjQYmK4vnAVipSkpXJxeOz+tdrTKc3IQfBdHkcBWu+uCbRAX+9yfaJAS7zYh3VsnzGDe0aDy9nAcu2nVy1w4P4aWaEuhewVdSTiPVte+iPhc4TSk308JusqTFPeqpl2u6qVmuRdefzXsYLgzJoWyW6zVckNukoU3Rk5fLMoaTiMiKDBTxm3wZEwVYgxO97xrRXNY7SA/ZtFepHM3juoEiTVG/Ou8TdPUCloBaInjMrUnK2LtZqSXvrSGi2il3uYYJrZkgbErUK+H62ibOTSGjmmekzWEA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 AD170180010C; Fri,  6 Mar 2026 07:58:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 08/17] hw/arm, target/arm: nested virtualisation on HVF
Date: Fri,  6 Mar 2026 08:57:47 +0100
Message-ID: <20260306075756.88922-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=KJ5XzVFo c=1 sm=1 tr=0 ts=69aa8920
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=0QeE6rx795gg9bSW8oEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lCAPGNXyYUlwoW0j0yxzEezJOu2onX05
X-Proofpoint-ORIG-GUID: lCAPGNXyYUlwoW0j0yxzEezJOu2onX05
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX842Kyn26Z8bh
 I6dZUZMnOyFcLuoM/MwCv8p4HiwS48Aloz86UMX1gPCP039GQS6k7WVzfnpSrEs2KqulFHXgRIP
 gr0gk5wwtEuR0zTMGjRV0Gns/2+QefS87HtGG3e9TTuuU7TKcYAjnVtCEkYp1+DyMJw2LmP28OR
 qaf/5WzxNfd7C5JJGf9BRfk2eDlfv0eBTvd/IsjNggoYXlwzYJAznw7CwJpzQ8l2nJ6TFsAHvSx
 VPTlv3bkoPBDQgOtVDB7OiOGRPJ2Tc0nK9NYOo6KfiAl+znWhX4YWF1m/OapT/acT3lgCK6qe8i
 0csp1I2oIevNj599hQJhY9jsSZ461ad2qq8dbvjjGmg4PYx2dAEQlotYX62ubQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=869 spamscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAABrFTTu0QX1tavo6wfZtcI8AfNFwK5cgqQt7UIYWgeqKKT7qhgb7NR/LVZolTGuZMQNOVgtKGOOrgF7d/ijaYuX9vitzTqVuCmCNMCNW1sDM9INmURKibyxz0HsMBMU8yb1/exm6joycVo26eXwA4Sddsr4lHOtibRnBfRxo/Plu93RwqbviHvLY2Z01I512XKRxL8fmtMCvLRoQECu5BLl/VXlrUr5ohUAcdmZWcgqzjaN6auyDQHrFrFTkuYcX2EOMbHZdNLkUknQ+/XPMfISs56jM93Xitine+qXHCBm5KIZPJIIi4z01ukNZ9uLs0v/FNCcl+81kq5QSTslq2NDjHuDVc93rdmxulFb0SFdpNU5kJx0COuLG7HzB3jmY+ObrluyCtXnDiU1XvFZxaD/O7PtEUeiCwZhPhxQ90g7tIXVrtLrWpIkWdoiKINCrBny9TM2//KVofaoydzlDDsI9FfgeOlypDT6wPu0Bvo+TeGo2Hge04qEVLc6TwtzgvBP+t4nJp8vTWVdAjJSqH0qTxdXpv8j0BdaPhUnxxG7k1SZO+BfCW9uv7vTNhwg+3H1u6+LADUzOfidJbC3J4SDYzEePyHGI4652JH9h3nR89JxO91jrVv8nrYe3QkU3dTEtPo6jpLVJIqamHKugj83AXCbqRK/NTf5jNJ6M1zBfcUUP2rDZ5Fq5lvPNGTdKgvntXeztPLrHkGncP3K9WuRKsuVtxU1KfLEMtaBPqsouHpuqc=
Received-SPF: pass client-ip=57.103.68.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c    |  1 +
 accel/stubs/hvf-stub.c |  1 +
 hw/arm/virt.c          |  5 +++++
 include/system/hvf.h   |  5 +++++
 target/arm/hvf/hvf.c   | 36 ++++++++++++++++++++++++++++++++++--
 5 files changed, 46 insertions(+), 2 deletions(-)

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
index c37493b92a..c90124338f 100644
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
@@ -1200,6 +1205,15 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
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
@@ -1211,6 +1225,18 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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
     if (hvf_irqchip_in_kernel()) {
         /*
@@ -1392,6 +1418,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
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
@@ -1413,7 +1446,6 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_arm_psci_call(param[0], param[1], param[2], param[3],
@@ -1467,7 +1499,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
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


