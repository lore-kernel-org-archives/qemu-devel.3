Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08EDD37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg19Z-0001Yg-8e; Wed, 14 Jan 2026 08:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19W-0001OB-So
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:14 -0500
Received: from p-east2-cluster4-host9-snip4-10.eps.apple.com ([57.103.78.221]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19U-0008SR-LJ
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:14 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 0D5A31800745; Wed, 14 Jan 2026 13:43:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=0bcIOI3LlXP+xiRF8XwgIxeQr5th/olwhYQiO6iSkA8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=abrxsGEXtQdxCPGWQcQkwFU+OqlvPeJlxsosPPgn+wA5KvjsRhgtVD8fI7rlTwtunf33IpYeLJqhJ3c9em6ZUl3Usn3ZK82w8naKcqsepGqkeexeHTXNksNhAeHjcruy3OlbRAXqulfMqUcqhfSXWIQeDWou23a6habz/zqumqeVJPKeZMm9LhFBWPdZmR7Cee9xa4HBT2Ev1NlfVAdD573VJlz1M4TIuqpmOyppaPFF6m8u4QoIeNmxEy6JCF8Uy+jMaMuw5aGO5ttkk9A6LW6oyUl/+Qf1XoQgIDTTI/u2K8WP3f9022iuaz0xViwL/YdXbFIewwtSVGTqBPFUSw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 15AAD180048A; Wed, 14 Jan 2026 13:43:03 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 19/26] hw/arm, accel/hvf,
 whpx: unify get_physical_address_range between WHPX and HVF
Date: Wed, 14 Jan 2026 14:41:36 +0100
Message-ID: <20260114134143.26198-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX0zRtmKyDo9zi
 U723+PfjQSkKKyMP66FGSGroFc0tigQbVomOBkG9PlokEKNwLMnhcvUgbcxvaHE0O9MhLzoMGQ4
 tf0NVoVUrrcP6wk1sZHFskDzU4/SLbuzQX7EBhoJOZKHFIjIx8WsSJcjRD/LpZhiq9EcaoFORrE
 cv2I026eSz49nOuPnYCGN0dwOkM+5+Gx8/6hKiLPyldflWc/K3u0n/l9OG0eW26X3YnH6gcBhJN
 4IKacyKu/+YoqYQhgBY7nDNJSIqUh8Rzdat2eYTiekjLRPNPSD2RDQL8Wkb7Yxp7AkfmVJlQ0hy
 H2dEDUBZ2iiVNNh8tn/
X-Proofpoint-GUID: 1R3Ew8QpJDGhj3hds5TKgneAXG6Dun3s
X-Proofpoint-ORIG-GUID: 1R3Ew8QpJDGhj3hds5TKgneAXG6Dun3s
X-Authority-Info: v=2.4 cv=esnSD4pX c=1 sm=1 tr=0 ts=69679d6d
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2RVAx2gzJTwwV__86OcA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 clxscore=1030 adultscore=0
 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABxOr2dA8dDR2l+CU3550mmXTy+MeUd0YdI7p0oyOp7Yk3XC2N4aL/dpZeHAPrZifz3PjGiKbZVjUhN1A2ZDBQD1rrV4aSeU3lLD3AlLN+uPw0V7ruWHrcxqzCJdN9SKhX7CiV9tFtuDuXD9DhUy4JCjQcV72kez7nyqoSGmSOaZm1QwFg2DrgtpMlfGmT/iAGXkOFDKS+LnNl9j6JFpvq4weBmb4RW81KS1tZ/Kc2a/dbep4xEQ6iX3CeEqpOWC9NA2Lkq795piFMrQ7D9BNVRe9IKc8nYwhNHEfnhJu5B/QLlvA80PxyDBJ7fLZjgc9ESRhUWmMjqXZVq2v5qn4MTCsB5kW5R85cCvVs+Rk+kAjGcTyvBBmP4wNweeeSVRpsjr83WivV6delYqhyN2tQUqYxApy4gYlMbD/nwk9YDFafyR78nJwFPgyKdHqkPxV7O7TPM12u05cLqEHO4VWfv3C1HCezW5PIYaY4WYUt8E4tPCp8qry74bVvJuhTfAPNJszz//Hu8iNnrpyuFHLLtSZCwJRYc/W1ZFI/EEW3s+84KAb+RTutL8WikS225nrn848950x0g5IK0IqQyVuSzYJuRWF0gbVtSNObykXgaQPLz129+g82qIerKYXU/dxYsgth6CiTLnWelPErCKGTtxO8NufMFRLLf67p/3GDGUUQfBN4KH5GMKU1BJ7lvivAFznH1zyyiw4/8ogJCEcdCmXQSje7Q6dtTOXCweZQCdMtYSxsBhwgEwktXlnxfqaiSYPoa4v93RU583o7puNKzhRE11lggbMUaShag/oBVOq0DaSkX4EE4o6cCVuflO6rE51Y4fxjmGlDIaMkJ7vgM4bn1XLpxO/FkCgyN91vH9weOCBuFdMKIFINLxj40BD9oswLnwDLAsCc8wVHG6qjYAxrkRIWdpL1pF9WDUor2X0NBpaYqCjwwo+N6w==
Received-SPF: pass client-ip=57.103.78.221;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 accel/hvf/hvf-all.c        |  7 +++++--
 hw/arm/virt.c              | 43 +++++---------------------------------
 include/hw/core/boards.h   |  4 ++--
 include/system/hvf_int.h   |  5 +++++
 target/arm/hvf-stub.c      | 20 ------------------
 target/arm/hvf/hvf.c       |  6 +++---
 target/arm/hvf_arm.h       |  3 ---
 target/arm/meson.build     |  1 -
 target/arm/whpx/whpx-all.c |  5 +++--
 target/i386/hvf/hvf.c      | 11 ++++++++++
 10 files changed, 34 insertions(+), 71 deletions(-)
 delete mode 100644 target/arm/hvf-stub.c

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 77f4e4e4f3..ce18bc0dac 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -17,6 +17,7 @@
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
 #include "hw/core/boards.h"
+#include "target/arm/hvf_arm.h"
 #include "trace.h"
 
 bool hvf_allowed;
@@ -256,8 +257,10 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
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
index 283935ae76..c59bcaa000 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3314,43 +3314,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
 
@@ -3359,8 +3327,8 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
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
@@ -3442,8 +3410,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
index 3d2be4092e..cecd4617d2 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -73,6 +73,8 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
+uint32_t hvf_arch_get_default_ipa_bit_size(void);
+uint32_t hvf_arch_get_max_ipa_bit_size(void);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
@@ -120,4 +122,7 @@ int hvf_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+uint32_t hvf_arch_get_default_ipa_bit_size(void);
+uint32_t hvf_arch_get_max_ipa_bit_size(void);
+
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
index fa26f63a61..5e93c42047 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -731,7 +731,7 @@ static uint64_t hvf_get_reg(CPUState *cpu, int rt)
 static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
 {
     uint32_t ipa_size = chosen_ipa_bit_size ?
-            chosen_ipa_bit_size : hvf_arm_get_max_ipa_bit_size();
+            chosen_ipa_bit_size : hvf_arch_get_max_ipa_bit_size();
     uint64_t id_aa64mmfr0;
 
     /* Clamp down the PARange to the IPA size the kernel supports. */
@@ -827,7 +827,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return r == HV_SUCCESS;
 }
 
-uint32_t hvf_arm_get_default_ipa_bit_size(void)
+uint32_t hvf_arch_get_default_ipa_bit_size(void)
 {
     uint32_t default_ipa_size;
     hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
@@ -836,7 +836,7 @@ uint32_t hvf_arm_get_default_ipa_bit_size(void)
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
index fce4e1ba10..038a9dcfd7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -775,8 +775,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->whpx_get_physical_address_range) {
-        pa_range = mc->whpx_get_physical_address_range(ms);
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
         if (pa_range < 0) {
             ret = -EINVAL;
             goto error;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2023a7bfbb..9d41e51b83 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -225,6 +225,17 @@ int hvf_arch_init(void)
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


