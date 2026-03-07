Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B86F55103
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyw0H-0001kn-W6; Sat, 07 Mar 2026 13:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0G-0001jw-FM
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:52 -0500
Received: from p-west2-cluster4-host4-snip4-10.eps.apple.com ([57.103.69.251]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyw0D-0003UA-GE
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:03:52 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPS id
 678DA1800626; Sat,  7 Mar 2026 18:03:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772906628; x=1775498628;
 bh=Ov64POP+pZwVBL2apOExReA3NsH1PM1K6fyKkqQNOAI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=d6TR8q+kAYzvITKEc+Kq/+9aGHoh310zym2g65fE+BVa1Fh8AlUTL2KE8qQHFD6aVHZfxFqjRS5AAtPlMjLFWufbU28Pj/ME6DFxafyCqT+1OjOdIC+eXj3Auiy0vMWfN35pABiviZB3lxxVxxvMfWYzlyWcINnPjoIhlgzMJKvp7bqHClYdMnXBWg/ex4oWRsy/jvTxGXwqgzneRFLpaoYsvIGsGq2FHeKVWrHajmEg7zoT+HTj/+9alrmTcVTDyg+yfvi5Ai8BKVZI/ucqkZx9kUn31xwjiw9SO0A1oSpUZ/zdKFaMdVEuI/KVHeZ/7KqXx0inLpgSFNI7FHl7fg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-5 (Postfix) with ESMTPSA id
 4B489180018B; Sat,  7 Mar 2026 18:03:45 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v19 05/13] hw/arm, target/arm: nested virtualisation on HVF
Date: Sat,  7 Mar 2026 19:03:22 +0100
Message-ID: <20260307180330.75168-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307180330.75168-1-mohamed@unpredictable.fr>
References: <20260307180330.75168-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: D5ChkuGs16k9bFnxfvCQDDXFFMnO_nLZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3MSBTYWx0ZWRfX9AdGyn2CMVCo
 eS7hwE9JO26KnUSkqkW0Uo2OKujgVyZSOJQsZlFp31Tv7ZDBpXrTy4JlWAWn2nc8KKHdO700rMz
 iUl04ig//HM2tG0g+Wepz6HKeNvLZXe+udrPPdMZwaccpzp2lO0KCMY1h9XzF7uBHdmjHa3pemy
 nNxDdiLdbqZLdek7H7NT3lfIUOs1Y5sRVstRPPqTwdp0k+YLV7kHJQFQ/eCcNYy3EZAQ02TsW1l
 ZFff7YvOG1I/BK/10TLfat9220BHCPkaiQuqnDZgpW4NHpC3zg9MLvidbrrqSCs1FpANji85oB6
 m6s+yMtuRTKnWd6rNPViN1PRwUhH9XNhKDjuWQ3xJ63eP63EGLYHoKVT1PbjWI=
X-Authority-Info-Out: v=2.4 cv=KqNAGGWN c=1 sm=1 tr=0 ts=69ac6883
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=G65AtosZd4T4P2EQXfAA:9
X-Proofpoint-GUID: D5ChkuGs16k9bFnxfvCQDDXFFMnO_nLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=871 clxscore=1030 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070171
X-JNJ: AAAAAAABE3kmyF2notVUPoC1COsCKE7D7q0IPEz+SnY8GdrLjTnU4xFT9t0LN9Q3xk0P5NkXzg0qs+7WHS9tYJWo5zI+Azm4AWzTMqFRQZC359bahcz7L62fteN6Ac5QDYpo+ftdGpA7pdMhbIcabHlUc7ag0bmO0FbXf9V+uRRsunULHeiR3WuINbPGqolGvK/BfiLmonz9IO40f4J9wetxY/lZzH3e/QqcJ9N8erieD3IMUQ9xMYPvrEdnY1H91wqI0IFy0570r/8nRLUyHXilE/ZPh2pz4yBAbBb6UbQ70NCSVOSVQIpY/ojE5tneR/9CP9w5mugucjPjl4KI5f+xdX0YtbEyzDWIK5ZUN7ftun6ejWpXqm8h3VjCTSMvNC7815K+5/REHgdDhjVXH3AwNPadXURHv7QbMvSn7yuUAg/8sPzBbahC2WMjtCoQgrXNe8BXF6rK3UDp1PtYyCCFFmAVd7fImN8D/lJ0jTWQExoVWc8Om+tqoz1lyfu+R4QeLitVhDjQG6kH/MFHb/K8QIGuc3WK3dQxi3FQk3a5aR3wB7ryUXKehSTIIGBCjFh/yR6Wv9mAx6rJn1jT6e7gu7uJNDdh8cHuk7T/uanu5OppX3kga+zqMzbkPSBbI0iWI18Q6u1wuz/6C6UkE4HYl50xZ6T6euKyPMZeh2vPVyL0Sqnwwqq4LxpYU6x6p7S+c2iP1j5LEV+hxurKK1YddgnD+4CL2ZYLQYjjyZUCgsgq
Received-SPF: pass client-ip=57.103.69.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
---
 accel/hvf/hvf-all.c    |  5 +++++
 accel/stubs/hvf-stub.c | 10 ++++++++++
 hw/arm/virt.c          |  5 +++++
 include/system/hvf.h   |  5 +++++
 target/arm/hvf/hvf.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index a296b108bc..66c3b48608 100644
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


