Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F39FCB61E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqB-0004G6-D1; Fri, 06 Mar 2026 11:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXq5-0004CD-7F
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:45 -0500
Received: from p-west3-cluster3-host12-snip4-10.eps.apple.com ([57.103.72.231]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXq3-000796-7r
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:44 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 B118118007A9; Fri,  6 Mar 2026 16:15:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813741; x=1775405741;
 bh=fRkaIzrsiHcpewkizPo+VGrzP1Gah0QVvX6PsUYTLv0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=chMFi4UkcubxVXGBiWSYk9OGHmdGQIfnv3/2JKFkruooQTaCfhUnjFoiabKTqltUam/uG5pvc19TVnLsClgDTI88KKACiPqF7Ia9wWQH1XOsoM16W16XK+vXJhiGF5ph1XDQDwNFAWykqI0rSrIzSabxY1wEGjCIT5Mknlhl00ckRMQ+vriJLd9b426wqbFnBoGVkOiy0mPBUY/GZbCJt7xbIsc7SbG4msvntLhcVEJRsbZ3bg9xFLQcSljZ/Lj3id08/RRWwnfPJUyjGq7IUQiruAkJkcxQ5nIg9SfrfbtvKvxV5vS7C6cN7299cwOCWWTLo+/NHGINlhTn0obywg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 E531A1800130; Fri,  6 Mar 2026 16:15:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 09/17] hw/arm, target/arm: nested virtualisation on HVF
Date: Fri,  6 Mar 2026 17:15:01 +0100
Message-ID: <20260306161509.79712-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0HWBRO9lZujlA-2hBTekDFrtCKQf_Ft1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX3zPzn2KcilTb
 oGlPZQHmkwWl60yUb2pkgpyT9OJB4R/TXTdEXkBSzKumnA9V5OAooRMZkg+FjcvUAmdOBqm0eSI
 LxuEWs5p8tHk+ewYS0tJ2gDPbgtVRatFhFuZqUdBLP+0X5lvJA19OSpWpKWKdQSwFNlofdb+Pe2
 HJiAGVNnTntj0nrd24FGgtfnBZJTF2FpfneZDlAcfF8wnWzEij1YtB3V0HUFe6Z0BTn9AVcNwfc
 oEeC+j0bOGxadHbacLVSjoomiNgO8cpIvAp+rnohh71zVfbgR9Bu7SRv0v8at1FGu1ZuDDRe6ow
 SH2h0o+hLxuGFWl93fen9n+5ZGNE7os2NQlewT9aDnZxgPL/RmwDC2/HJwnnDU=
X-Authority-Info-Out: v=2.4 cv=DrpbOW/+ c=1 sm=1 tr=0 ts=69aafdab
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=0QeE6rx795gg9bSW8oEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0HWBRO9lZujlA-2hBTekDFrtCKQf_Ft1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=862 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1030
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060154
X-JNJ: AAAAAAABSE8tqLauVW4DcaW7lmPQQeYQej9D4KMiZdP3xlM5B4vzsIAO04Lr721byrKv96ttQ7ldV8zGQcKILEppeX7Wqvz41+k50oOZz4sTDYG/2me3h5yj/cQkQW/cFiczdgwiJomQqZJWH87IO9ZE4zk1KvTf8BgOtDrPLWiVvlK9e4/BBPolp/B73/OXK9swtb2voWbRZZAnQShSHVzNhQWVxS6S4KoFkTsSYhf/+AlyiDynQIvfPZNnfm9tU0jBn8BDWL4A+XIWBVbetCEJgplL+4uvomdO00FqvH/6f0LUwKEF2m6HPhXMg51hatrT0d4FOgjGKicnlPdaX21PvEGFmJmH8k6q3GwhMWuhghE2YHAmDXUNrZOjF6kJ+EohEdPqOD5UeXlJcanZxnEWg0npxn0xYuzOaqd4AwbFHssrPEYx5eE/27PVfr4zwngLFHzIv+42xbyvPF9JH/jNlHiqYyTfp9Wrn5Z8NjnWm0UJsIcvyzxDc7VjPvKZXCAR9BEkdSXpXDhp/17Ue2WU1fhPClLJcN5b9Yr7+1ozbGnrZmcILxuqNODvNeQ5Wg7v+OOxtIzWzC0zR6/SeNKbKVJXWCwXfPFS6mh1k6lgISdpBGsA2nIHAPfBt/ejlrA3AXxT2vvVLE0ZzEDTdZiQ1PfhOWiJ084X/RY+PihjMmlcWSYcWfRHF2et30AgO/mJLrlGXTCe+HfbjjqE+XlxyuUfI2xuEWmBYshalU+iwo+lIi4yyjchS4nKNQH15d/S+cZ+iemd
Received-SPF: pass client-ip=57.103.72.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c    |  1 +
 accel/stubs/hvf-stub.c |  1 +
 hw/arm/virt.c          |  5 +++++
 include/system/hvf.h   |  5 +++++
 target/arm/hvf/hvf.c   | 43 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index a296b108bc..1c1437b467 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -24,6 +24,7 @@
 
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
index 2ed1268ac9..e4ff14e55f 100644
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
@@ -1218,6 +1223,20 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
+static bool hvf_arm_el2_supported(void)
+{
+    bool is_nested_virt_supported;
+    hv_return_t ret = 0;
+    if (__builtin_available(macOS 15.2, *)) {
+        hv_vm_config_get_el2_supported(&is_nested_virt_supported);
+    } else {
+        return false;
+    }
+    assert_hvf_ok(ret);
+    return is_nested_virt_supported;
+}
+
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     hv_return_t ret;
@@ -1229,6 +1248,20 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     }
     chosen_ipa_bit_size = pa_range;
 
+    if (__builtin_available(macOS 15.2, *)) {
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
     if (__builtin_available(macOS 15.2, *)) {
         if (hvf_irqchip_in_kernel()) {
@@ -1416,6 +1449,13 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
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
@@ -1437,7 +1477,6 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_arm_psci_call(param[0], param[1], param[2], param[3],
@@ -1491,7 +1530,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
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


