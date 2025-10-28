Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C1CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRm-0002Gn-5B; Tue, 28 Oct 2025 19:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRb-0002CP-8v
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:40 -0400
Received: from p-east1-cluster6-host5-snip4-5.eps.apple.com ([57.103.90.176]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQy-0004ot-Pq
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:37 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 20E5B18034D3; Tue, 28 Oct 2025 23:48:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=2LnAPGX4HuFpDCVnU0NG6yresAdDa/+GNcrH6VwGz6k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ekd9FnRVGP2nhLxHLAbJl3W6S2+ptUNz8/3Pk05AWImizdALG6cHCN5LoVj0WHZZUMJjxGDU12Nbee3loFD/9i9XiOVtSUNPqd6b9AvD56hY9Ad3/SLg5WALcB7Wp7C1MWCJnMoWPR8UGnlFr9pwZLxD6uSkhRjmjHOAnBLy9+XoC1s1FZI0n7r5Mbtth9CRbKgMQpaUZ371PSiq/ND7Mg0MHFs2ZrCNzFDpn0L6f/lVsOKXpbX7SNDRkImmPmS+dZRVBArGML6JFG/iRSPXx1I3JDN6df8GiBU3lDcKZb6retX3YAPicMuYMq4Dsm1A3dfeRDUjBn0ABWTlpBVi7w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 F074818034F3; Tue, 28 Oct 2025 23:48:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 20/27] hw/arm, accel/hvf,
 whpx: unify get_physical_address_range between WHPX and HVF
Date: Wed, 29 Oct 2025 00:47:50 +0100
Message-ID: <20251028234757.39609-21-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: H_rqGxZ96ueDSjB1GTMrqSVTZHdyMyeT
X-Proofpoint-GUID: H_rqGxZ96ueDSjB1GTMrqSVTZHdyMyeT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX29swaxWCAQKG
 2S90lbuFH/Po1WASqZi7FsgfDZdVajgWoWKDHfZUjau1FQcjzNzQeecDHUd9IO8ZAP6SNcKxoz5
 1dXTmmDgTI1oRYXbnJJmZrlnJPqszPCEWZdaMa6x9f4+YtLpvzi6jN06YILVy0r6fzylgSJ/sAj
 I4EXcadn7SEBbDLw/s3SRQOdi14qZR5Qj7wkZxkBrf2NTeqfb18cUewuk14WSF+3NlOKfC/6Kab
 NVw3IXURk6UrJg9RbMTUaVC4HvDNMLdcqzw9MMt6tUUj8zIkAzsOeFP46OH++S0chAAq/ge1U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABcbpnk/kvcdAV8LOzJSgW6Vru9OBuAKT8ezlDcWouSv+n/XFa3Qdb3XVG95XFFM01Xg2yE0hcv2BXBVPUfNNzrwCcfc8YRdXPbWUgGqjnbFEldzhXQo63z8fM+ILX960wDzzMeeY8hRzHDgmiuJSkbZe4pVUR3BRtP+C4G5vZtHucxkeoR1BbbbZlkiErFrG4CdybOBKbD9Z4hym5QNQHu0VYZ97xWSX0jJPhdG7JnD8cV5wr0PtMJJXZbnTG9vnMhG4whA9TMyU6ZT96jJHv05pqunPGT2i5UoizWCow0ERCzh97A2tj9PBQ55dbROqmSaCE3hJMleljR9uS1or5VMpKnlN9oePKnyqIXMWSqvNs87IQsDfx29cc1jnCbCw9lxFfr/vGD53OiY2MLRmSZ29qASx+VKfiiTowSoFDHixh7bEGERHOoBE4tlcGjZhIhObQZXWGEIJkpkbktJY8iEKiZMBZvxrQfMuAi3EnpLvl3a7FXbu/yixLlcyq4gf28etQcWtLbKfRt8pjtylRL1cMky7d7Hi7cpiZdIXoqq4BM7iOeJqNtV2kCaHBs1rIAEeJWt5CdWph51nKdLy5GInXfBOl8gYnthFgEnMdvSYNrqHExTUdoa7aBPJmeG7Ihmrkgn8Z4O2vNRJ2LMBHYg0ELEcafLVyWOOTTosPX5gO7ZDO3IRpE8N03VSXfAhCHbjDx+yLqgtIHc+J65PFbh9yBfLYt8flEoiRFcn3cxm7MK2gBfan4wJwtlc/8kceT4Q4W2Dqzt08g2oXpcBLHYFmk//ivpdb8LxhLGhhYPZdZ7VaFTevs6DC67gRbnA=
Received-SPF: pass client-ip=57.103.90.176;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/hvf/hvf-all.c        |  7 +++++--
 hw/arm/virt.c              | 41 ++++----------------------------------
 include/hw/boards.h        |  4 ++--
 include/system/hvf_int.h   |  2 ++
 target/arm/hvf-stub.c      | 20 -------------------
 target/arm/hvf/hvf.c       |  6 +++---
 target/arm/hvf_arm.h       |  3 ---
 target/arm/meson.build     |  1 -
 target/arm/whpx/whpx-all.c |  5 +++--
 target/i386/hvf/hvf.c      | 11 ++++++++++
 10 files changed, 30 insertions(+), 70 deletions(-)
 delete mode 100644 target/arm/hvf-stub.c

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 0a4b498e83..8229ad8640 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -17,6 +17,7 @@
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
 #include "hw/boards.h"
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
index 480d165ebc..58fa657cae 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3317,43 +3317,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
-     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only
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
 
@@ -3362,7 +3330,7 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     /*
      * If we're <= the default IPA size just use the default.
      * If we're above the default but below the maximum, round up to
-     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only
+     * the maximum. hvf_arch_get_max_ipa_bit_size() conveniently only
      * returns values that are valid ARM PARange values.
      */
     if (requested_ipa_size <= default_ipa_size) {
@@ -3438,8 +3406,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->valid_cpu_types = valid_cpu_types;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
     mc->kvm_type = virt_kvm_type;
-    mc->hvf_get_physical_address_range = virt_hvf_get_physical_address_range;
-    mc->whpx_get_physical_address_range = virt_whpx_get_physical_address_range;
+    mc->get_physical_address_range = virt_get_physical_address_range;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->pre_plug = virt_machine_device_pre_plug_cb;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fb2c531018..fa5f71471d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
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
index a3b06a3e75..8b6447c238 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,6 +71,8 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
+uint32_t hvf_arch_get_default_ipa_bit_size(void);
+uint32_t hvf_arch_get_max_ipa_bit_size(void);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 int hvf_vcpu_exec(CPUState *);
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
index 0658a99a2d..ecca1a63ec 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -725,7 +725,7 @@ static uint64_t hvf_get_reg(CPUState *cpu, int rt)
 static void clamp_id_aa64mmfr0_parange_to_ipa_size(ARMISARegisters *isar)
 {
     uint32_t ipa_size = chosen_ipa_bit_size ?
-            chosen_ipa_bit_size : hvf_arm_get_max_ipa_bit_size();
+            chosen_ipa_bit_size : hvf_arch_get_max_ipa_bit_size();
     uint64_t id_aa64mmfr0;
 
     /* Clamp down the PARange to the IPA size the kernel supports. */
@@ -816,7 +816,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     return r == HV_SUCCESS;
 }
 
-uint32_t hvf_arm_get_default_ipa_bit_size(void)
+uint32_t hvf_arch_get_default_ipa_bit_size(void)
 {
     uint32_t default_ipa_size;
     hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
@@ -825,7 +825,7 @@ uint32_t hvf_arm_get_default_ipa_bit_size(void)
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
index 61277a627c..9f2eb91635 100644
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
index e6bafb0601..23c7beefaf 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -805,8 +805,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
index 33f723a76a..1d7ec47f59 100644
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


