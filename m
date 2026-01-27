Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6586BD2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vko4w-0000pJ-DT; Tue, 27 Jan 2026 13:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4f-0000TW-5X
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:46:02 -0500
Received: from p-east2-cluster6-host7-snip4-10.eps.apple.com ([57.103.76.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vko4X-0007cl-6K
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:45:54 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 51285180013D; Tue, 27 Jan 2026 18:45:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769539539; x=1772131539;
 bh=0UYhPe2L2E2DORUUl57pMd+m3j/x5QVXXdWm9uEXuTA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HKFrCDOn2ojsPWAqoJycC5IAOl7vWC7z5rrBaieKQGzxCfSpQhjuPUyMo7WTW5/fnOAvpl3bwO808z/92PRUYaRt2DdBqingbBK4IXjOMYTqmgAkc1OfYgWfm0yMgS5M0XtCNkr4I/noDaZ0JkYumeZAtbKhKJlMc3hmkdN2TiTO26h1RN6oOUbBdIDMFCSHNyWrWrTEvWJgl/sl4KHtUAHk3RvOLVCePzVY2qwKjRKwvCrp1DyffxQW4ustH2jdetX7syK8YE2IW3XyQn8KfVjpLRXLCoY2VHlLQFMEVsep1DsFn6P1xYHmPEi8lEO/WdrQOjCnIEypqpgtYvfQAg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 0316E1800675; Tue, 27 Jan 2026 18:45:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v9 05/12] hw/arm, target/arm: nested virtualisation on HVF
Date: Tue, 27 Jan 2026 19:45:16 +0100
Message-ID: <20260127184523.5357-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127184523.5357-1-mohamed@unpredictable.fr>
References: <20260127184523.5357-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WRJzNoRtOWvh5fuPJH336cSPQKLP1tCl
X-Proofpoint-GUID: WRJzNoRtOWvh5fuPJH336cSPQKLP1tCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MyBTYWx0ZWRfXzCVDh2ouQ5MR
 xVOxc6Sm7cllvRGlF37zldG1UnuKWCVuZ1hnDQR5epUHp5zffW9GL6Ppt4kCDXuFOYogBwjppFG
 +noBRG6/5vxlJwIB7AQEuDPTqAX7Ohk+Cg+DNxvOU01LUv8G5EvJCQX2wNyhvf2FwRUtvAk4W+P
 gbRMI5DY3jyXV+/tuT8cFkO4MXm353C3/Z5cI7faJxzTcqMMXxfahZgurmkkSOQZon+EleFjeCb
 CEJGXpCwLf5iQigE6v0U2Chn4uElIMEVUyeqKAJBDAK+j0Y/tyCWAjt/PAPHDDJXoS15l3cmMB3
 QIJ2wyydxld+sLdUcPMtdM5HZOHl5GWatVmWyv2REB8aCSYba22cRBEarb+JYU=
X-Authority-Info-Out: v=2.4 cv=ZYoQ98VA c=1 sm=1 tr=0 ts=697907d1
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YLAFOksV-_wk3IE7wuMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 mlxlogscore=851 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270153
X-JNJ: AAAAAAABeQrysiMOb00CoyfEPSbiAEMxtEe4a0wykkz73fCNOHfdnVzj2hkp60OXJnGzgbe5d2whKn/LR2McjEpP3BGFNtQ7+luZ4ZKR9vCFYT/DtYQtkiALiZKVXv/x7OemgNp49GX9Jd8pxE+x1DgQQPXGQwlYLf3wpcrDi1oODrp1Eo5m7++HPsahElNGsV0pGcEpylgzrdqffcCAeq/NVFIf9e+Nm98Yr6DsE0Of7rMDEkRV/fKHVirtTsU11VtPlrxdbTBWpPunCSxVZWXKTqNzRgaDkArf3JR5okv7jlNyF4+Z2rq40a0I6jo7+Vkx7ENYQ63KWrsMdC2aNzNIDPYfz/eYN+8ESfd+R//MdqcL4Bn2Yeth+RqhqeqZMxh5RHzyzfKes/43LnLRWyMKcSnJ1tAxavo+YpE2OUXy1OWgFcpQBA4nrXQZ7JPOVaKJ0YR4rHXrOrMSIY0wT/ik9X0SQoTYJqyJ96gvv3geeAk2dLbVB7yKD8ZF59TeLUplCgzj+zRsYCns88D+5sJo9EsarZVidntx5HGeQOVxKqhqT5HTlD5/mqoiH5vnvgndx1FWyQ6Te+UV6dZLLZBGBpYTjlzoOHeqWnVdCZXrPRta0BpkOVxDFRaFHBnNDOvU7m9L7/LV8Fw6UaNZl85n7S10kHaXfXceuRGwqTxBEFWGtpBbPtuM5YUUhoK0Q4WVyC61WRJvtwX4
Received-SPF: pass client-ip=57.103.76.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d82fe10934..6ba7d6a6ef 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2651,6 +2651,11 @@ static void virt_set_virt(Object *obj, bool value, Error **errp)
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
index 55c21aa740..e239f47e15 100644
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
@@ -771,6 +772,10 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                      (1ULL << ARM_FEATURE_PMU) |
                      (1ULL << ARM_FEATURE_GENERIC_TIMER);
 
+    if (hvf_nested_virt_enabled()) {
+        ahcf->features |= 1ULL << ARM_FEATURE_EL2;
+    }
+
     for (i = 0; i < ARRAY_SIZE(regs); i++) {
         r |= hv_vcpu_config_get_feature_reg(config, regs[i].reg,
                                             &host_isar.idregs[regs[i].index]);
@@ -878,6 +883,15 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
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
@@ -889,6 +903,18 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
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
@@ -1039,6 +1065,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
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
@@ -1060,7 +1093,6 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_arm_psci_call(param[0], param[1], param[2], param[3],
@@ -1114,7 +1146,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
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


