Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF01ECD981
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1FG-0005mW-7o; Thu, 05 Feb 2026 10:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1FF-0005gb-2P
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:26:13 -0500
Received: from p-west2-cluster1-host7-snip4-1.eps.apple.com ([57.103.68.84]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1FC-00028l-Jj
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:26:12 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 9DCA41804300; Thu,  5 Feb 2026 15:26:06 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305169; x=1772897169;
 bh=ytYj5J6mRWA1MZc5Ke/cgWypdvS6bPw8ua4WvIunSds=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=geq/IkA9fO75cElY9K9gmK/AUrRS/Yj77IzSIbcGbSGgo32br1IhxiHpZsizj8ehpTVB6EvSHCraIjp39wr45ezqdMfWx+SRTD9NzrAMm0LAEeZxoI60KhTmMyiSE2ay21aPI+7XoFegwYgKSCvU4AVRZpqiiEzUDGUsF550kvNBjEaX1xvJ+XNr1CK0ZQEVzUn5Jo9fY0L8s4V7+mKiFOH5R1EmFnNzeLIDJugS/Hu7plirxKX8tUGvy3V8TNBwy+dnsjgyALtvSnQPrzX2f80FauZG+6rHcR7CmgwSSNYC+bAVspYvF6ufybZg5JQKKekbJg+c+AOdsF6AAGUtSg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 878541800748; Thu,  5 Feb 2026 15:26:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 18/22] hw/arm, accel/hvf,
 whpx: unify get_physical_address_range between WHPX and HVF
Date: Thu,  5 Feb 2026 16:24:21 +0100
Message-ID: <20260205152432.78208-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xgPzoC-6nDS4zlVx2w2hNxfwh30YIn14
X-Authority-Info-Out: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=6984b690
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=2TttH9MEl-kxELt7c1gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX+dnGn1KnmpFN
 yIf72L0oTVwaBztaginztIMgS8SOrSZpGxLuog6LjO7X8sqaAec9oe2eYOUWtE6BH4GkJD5U6s7
 wT984QR4t+bcyKIHxO60Ue7BIfgWTbtRjerZIm1OE4wj6zhFQEmjYAUkA40HEN6UDmRtgndHtPD
 isHTHF3Ei/F4ozNBGAYZdP4EgqQfFWr7wymHpfnmipqJWH3qK+XvgauZHPcJW67uEgpZgLwQvRM
 y+DGgRYD+wXpnrDTY/Kdk9KO6iPBNQgdZ0y8KuuAp7B8YBtyXNDD5ghvAwNn/OnGqM5Aij6FC7J
 wmtA8vkJfqvd/G1zwvtG4u8avO9PGcP6M8+5btHvNk5RJbufi1AR0kE4iyLcO0=
X-Proofpoint-GUID: xgPzoC-6nDS4zlVx2w2hNxfwh30YIn14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABGjNl1mdt7yW12Ye86dO1JnW2U0Tml5u4Y/KRJ6E3XgJv6QplyzMzsJkjb0+TbFv/a7qVz6y86xckfhQyGekHimxc55jM0tVErqlzzNOEKjzI7cMZWad4Jq4bVIoBLocV3K+7W3gYcWXqqZkazIe60HIhZi/bTc32zw+hP4zgfmQdat49PWK5lPx6od6qX2bagFCJL1tgQmmKmqhmCokrCpOqfkJMPrP3C+m5djW0MF3IhsWEKuSgb+yJZSi8+CQNfiA+aybTyagiMniiXYmLy+J+ycODiHwql3rlxc2LVlWYHnEKg9XtPRBgzeOheprQv7PQTaQsQegLFEhb9f4Yr9v9FS5lO6g61bpLQSIEjZtGdz3dWn4PsyMgPrqz2PRBy7j8cgsZk7TeWDrCnkgjuISaT79Nl98Sr7maqSDyFxt41aQ4WWpvYO0yGasBRvOdIF4XQAjvbzb7ClmHPEnzusrgsPXAKVt+ucC1S5Nopn5EkFdyMgQjDEsGIkXur12fx7r0MOFNv0Dcfu2kWttolKBzjEug6rPN3rSt1SA4l95rucvAYtWL8uUlN0qQ0xGudZ2zMzwBDv4l2oY6YCO++dbEqyAT7WHx/3TZcM9VZgNvHSnMvita6/2Os/GN6BFSGwstTQ3wRwsJMp4usfZVHX3QPzGc8j+TJl9nI/V2j5RXc8x7zMhvznAX+gV9H3BTiAfFS2s4fq1gtM9s99ArTZvUGX4UAnmpv/WNxtdv/p7UUH6s6oRYSIN2uIkud+gvNdiN4kI7ZzSBuIQfw2u6DQXCqzh5apduwz0nNZc5SQWkCLV8TfZGh237EN85zKGhL0lfp3zNPK6drV8RTf4aNth+qh8IDLlIFsFZZskMLgBN1B8zeYJi8m5/WDmxdUBWHd+fQi2+UAkCz50YfgXWVBCguEjoO0J7UNNl77JouX+z2FwwI8m688Qdg7gLVx2BjEOolgSIaF/T991W2gUK6DJ
 xlXIU
Received-SPF: pass client-ip=57.103.68.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c        |  7 +++++--
 hw/arm/virt.c              | 43 +++++---------------------------------
 include/hw/core/boards.h   |  4 ++--
 include/system/hvf_int.h   |  4 ++++
 target/arm/hvf-stub.c      | 20 ------------------
 target/arm/hvf/hvf.c       |  6 +++---
 target/arm/hvf_arm.h       |  3 ---
 target/arm/meson.build     |  1 -
 target/arm/whpx/whpx-all.c |  5 +++--
 target/i386/hvf/hvf.c      | 11 ++++++++++
 10 files changed, 33 insertions(+), 71 deletions(-)
 delete mode 100644 target/arm/hvf-stub.c

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0fbe27dfa2..033c677b6f 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -18,6 +18,7 @@
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
 #include "hw/core/boards.h"
+#include "target/arm/hvf_arm.h"
 #include "trace.h"
 
 bool hvf_allowed;
@@ -186,8 +187,10 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (mc->hvf_get_physical_address_range) {
-        pa_range = mc->hvf_get_physical_address_range(ms);
+
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            hvf_arch_get_default_ipa_bit_size(), hvf_arch_get_max_ipa_bit_size());
         if (pa_range < 0) {
             return -EINVAL;
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 77832b566e..5c31695d37 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3361,43 +3361,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     return fixed_ipa ? 0 : requested_pa_size;
 }
 
-static int virt_whpx_get_physical_address_range(MachineState *ms)
+static int virt_get_physical_address_range(MachineState *ms,
+    int default_ipa_size, int max_ipa_size)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
 
-    int max_ipa_size = whpx_arm_get_ipa_bit_size();
-
-    /* We freeze the memory map to compute the highest gpa */
-    virt_set_memmap(vms, max_ipa_size);
-
-    int requested_ipa_size = 64 - clz64(vms->highest_gpa);
-
-    /*
-     * If we're <= the default IPA size just use the default.
-     * If we're above the default but below the maximum, round up to
-     * the maximum. whpx_arm_get_max_ipa_bit_size() conveniently only
-     * returns values that are valid ARM PARange values.
-     */
-    if (requested_ipa_size <= max_ipa_size) {
-        requested_ipa_size = max_ipa_size;
-    } else {
-        error_report("-m and ,maxmem option values "
-                     "require an IPA range (%d bits) larger than "
-                     "the one supported by the host (%d bits)",
-                     requested_ipa_size, max_ipa_size);
-        return -1;
-    }
-
-    return requested_ipa_size;
-}
-
-static int virt_hvf_get_physical_address_range(MachineState *ms)
-{
-    VirtMachineState *vms = VIRT_MACHINE(ms);
-
-    int default_ipa_size = hvf_arm_get_default_ipa_bit_size();
-    int max_ipa_size = hvf_arm_get_max_ipa_bit_size();
-
     /* We freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_ipa_size);
 
@@ -3406,8 +3374,8 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     /*
      * If we're <= the default IPA size just use the default.
      * If we're above the default but below the maximum, round up to
-     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only
-     * returns values that are valid ARM PARange values.
+     * the maximum. hvf/whpx_arch_get_max_ipa_bit_size() conveniently only
+     * return values that are valid ARM PARange values.
      */
     if (requested_ipa_size <= default_ipa_size) {
         requested_ipa_size = default_ipa_size;
@@ -3489,8 +3457,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->get_valid_cpu_types = virt_get_valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
-    mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
-    mc->whpx_get_physical_address_range = virt_whpx_get_physical_address_range;
+    mc->get_physical_address_range = virt_get_physical_address_range;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 0b2aefb126..26e0879e1a 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -277,8 +277,8 @@ struct MachineClass {
     void (*reset)(MachineState *state, ResetType type);
     void (*wakeup)(MachineState *state);
     int (*kvm_type)(MachineState *machine, const char *arg);
-    int (*hvf_get_physical_address_range)(MachineState *machine);
-    int (*whpx_get_physical_address_range)(MachineState *machine);
+    int (*get_physical_address_range)(MachineState *machine,
+        int default_ipa_size, int max_ipa_size);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 96790b4938..2621164cb2 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -57,6 +57,8 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
+uint32_t hvf_arch_get_default_ipa_bit_size(void);
+uint32_t hvf_arch_get_max_ipa_bit_size(void);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
@@ -107,5 +109,7 @@ int hvf_update_guest_debug(CPUState *cpu);
 bool hvf_arch_supports_guest_debug(void);
 
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
+uint32_t hvf_arch_get_default_ipa_bit_size(void);
+uint32_t hvf_arch_get_max_ipa_bit_size(void);
 
 #endif
diff --git a/target/arm/hvf-stub.c b/target/arm/hvf-stub.c
deleted file mode 100644
index ff137267a0..0000000000
--- a/target/arm/hvf-stub.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * QEMU Hypervisor.framework (HVF) stubs for ARM
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "hvf_arm.h"
-
-uint32_t hvf_arm_get_default_ipa_bit_size(void)
-{
-    g_assert_not_reached();
-}
-
-uint32_t hvf_arm_get_max_ipa_bit_size(void)
-{
-    g_assert_not_reached();
-}
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9ce720793d..1b19d9713e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -825,7 +825,7 @@ static uint64_t hvf_get_reg(CPUState *cpu, int rt)
 static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
 {
     uint32_t ipa_size = chosen_ipa_bit_size ?
-            chosen_ipa_bit_size : hvf_arm_get_max_ipa_bit_size();
+            chosen_ipa_bit_size : hvf_arch_get_max_ipa_bit_size();
     uint64_t id_aa64mmfr0;
 
     /* Clamp down the PARange to the IPA size the kernel supports. */
@@ -921,7 +921,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return r == HV_SUCCESS;
 }
 
-uint32_t hvf_arm_get_default_ipa_bit_size(void)
+uint32_t hvf_arch_get_default_ipa_bit_size(void)
 {
     uint32_t default_ipa_size;
     hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
@@ -930,7 +930,7 @@ uint32_t hvf_arm_get_default_ipa_bit_size(void)
     return default_ipa_size;
 }
 
-uint32_t hvf_arm_get_max_ipa_bit_size(void)
+uint32_t hvf_arch_get_max_ipa_bit_size(void)
 {
     uint32_t max_ipa_size;
     hv_return_t ret = hv_vm_config_get_max_ipa_size(&max_ipa_size);
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index ea82f2691d..5d19d82e5d 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -22,7 +22,4 @@ void hvf_arm_init_debug(void);
 
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
-uint32_t hvf_arm_get_default_ipa_bit_size(void);
-uint32_t hvf_arm_get_max_ipa_bit_size(void);
-
 #endif
diff --git a/target/arm/meson.build b/target/arm/meson.build
index ce155ba9b4..1ddc4b2a54 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -41,7 +41,6 @@ arm_common_system_ss.add(files('cpu.c'))
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-arm_common_system_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
 arm_common_system_ss.add(files(
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 850f6ec81f..6067918b27 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -770,8 +770,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->whpx_get_physical_address_range) {
-        pa_range = mc->whpx_get_physical_address_range(ms);
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
         if (pa_range < 0) {
             return -EINVAL;
         }
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 7cfaee389e..ce54020f00 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -228,6 +228,17 @@ int hvf_arch_init(void)
     return 0;
 }
 
+/* 48-bit on all Intel Macs. Function currently unused. */
+uint32_t hvf_arch_get_default_ipa_bit_size(void)
+{
+    g_assert_not_reached();
+}
+
+uint32_t hvf_arch_get_max_ipa_bit_size(void)
+{
+    g_assert_not_reached();
+}
+
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
 {
     return hv_vm_create(HV_VM_DEFAULT);
-- 
2.50.1 (Apple Git-155)


