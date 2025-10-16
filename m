Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D71CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Sxr-0001gn-IV; Thu, 16 Oct 2025 14:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxp-0001fU-13
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:37 -0400
Received: from p-east3-cluster6-host5-snip4-3.eps.apple.com ([57.103.85.174]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxg-000268-SX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:36 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 4CFB41800161; Thu, 16 Oct 2025 18:44:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=PC8lHa9L/eTJ6vFt+Ut95xvBVS4mUtYzEzdzPpMOvK8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ko+Gl0rDACHcJ9VsMHbjMjVVskx5gHaEIVXXNqnskakSuQBIyourn5dHAlWE0K5SBfeJRya50ctnnCHvxFj8DVAa6i+rjYUDZbRcEfO3TAVpHN5Ic5U/TlDs0rmIyMrcUL1aEDW8XQlTb38At9CEMn5RcG/NnFDlisIVuttC7wpf8ZQrgtH3SMfEwXGIAwtAt+v+kEgtljzvjhh6yBhzkpB2SixFDHRE2kDKb4KcZncGYec5gGuIvUW8xn5JG4PKIOLxTXGVUm5Q31oaoMzDOgdraLp/20rxwfpkjsdh0mYCtoAf9K9MZrztfXuuqhd7oUVZXev4+wxuPnr5eUwInA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 38BAA18004C7; Thu, 16 Oct 2025 18:44:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 18/24] hw/arm, accel/hvf,
 whpx: unify get_physical_address_range between WHPX and HVF
Date: Thu, 16 Oct 2025 20:44:07 +0200
Message-ID: <20251016184413.69870-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzOCBTYWx0ZWRfX805o4vKAQkkp
 eCxDrUffrLGmu1KW7D8f7CAUxESH462nMZSozi4Esk5XwH6yRYKjGAEsN8SFlJjBwkP7gtVSV/o
 UaO4+HPh7FW57fL8kmjEKMqcMFQQT6CWyMJm4VXnmzHZO9LugH5IFuUr6j2xPfpkiTeOWyqDoJA
 ykYOOzoUmtEusUC10LqcOEi1CCaXPsQzpeXfAAJCjKErxPYy1PS556ggtiJ7yw2MeIRZ3qA7vcx
 CTxIHzqb8VipMqHNI2ILCLjO7ufjtT05HRXx172P2tvd2AO4LS90UW1cAuwGNmAXkkKetBTAo=
X-Proofpoint-GUID: zLVWPcA20SnFIxa4y3Nq6RVvQQX8iFv4
X-Proofpoint-ORIG-GUID: zLVWPcA20SnFIxa4y3Nq6RVvQQX8iFv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1030
 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160138
X-JNJ: AAAAAAABDmWJNOdaVQIsyHuorBUWHkejTQMdw9now/Jt1g3L5j9Z+anof+6JSaOfzNOiDQH/UAOsPLKbOUSJrrLxW82tlws6mP1UtqdylePej4wPRDJmi7UAfAF4xd/VLsuz04s8oyGzfl/EXiPnld6TZn3hOcXaQ1Gy07hSkNdOevYbe2GNxXAz9R3OvUQwXpeBPi7ET2lAu9biIEfSCgVWL8MvKPQ590yengVm5xTXOMdvowfofbX3zGtUC8MHuLCW9V8iGcX8V4Wvtd1UPSO4JFmZbXFHQnA+oF4K0VAaNKDgsVHFPx6FNSrOmmU7/jbwD5mFQfOaScmYsFO+xsnsd8hsh5Eb2Hv9Bxx94x723GZwCcA3GlJc37wFO4FWRYIUm+4uV2q+v7iUxBrAW/u8UC/PqVGyBoyMTn0LcFM9k96j12w0STlnwBKmNsdcpGZifkmjEjGWG+S3rSscirKbOK0Y7Gi7PCrmG3gXeup0Lg3YvIrfb2JXkwiYU7a/MF7yBxCjtIczh+8WxOn+eNVJVm2pure9vspZan2f5yuayXt+AZs15yVK1N5vcweUb1rKNOihJd40BuUpmV4etAkHUTil613H+fm5cv3vCk42eXabyAsGav5lVDQ1OyPm9XwXVwt1DLxilRNC0I6RHNCYhlv9xy0GPjMRTrErp9QpZOAC6GmgWHmQm/ZyrwK/dy29cym/79Rgd8XCkK2IM5P/XLAZaNDyPnKte1WC31MkrQ659A==
Received-SPF: pass client-ip=57.103.85.174;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 7afc275f79..fc8298bae8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3254,43 +3254,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
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
 
@@ -3299,7 +3267,7 @@ static int virt_hvf_get_physical_address_range(MachineState *ms)
     /*
      * If we're <= the default IPA size just use the default.
      * If we're above the default but below the maximum, round up to
-     * the maximum. hvf_arm_get_max_ipa_bit_size() conveniently only
+     * the maximum. hvf_arch_get_max_ipa_bit_size() conveniently only
      * returns values that are valid ARM PARange values.
      */
     if (requested_ipa_size <= default_ipa_size) {
@@ -3375,8 +3343,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
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
index 3d01fb8cc9..aecf5ca92e 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -275,8 +275,8 @@ struct MachineClass {
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
index 8445cadece..0994b8643d 100644
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


