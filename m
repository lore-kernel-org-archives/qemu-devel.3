Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8C4E83F1F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0K2-0001bG-0f; Thu, 05 Feb 2026 09:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Je-00014d-0n
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:42 -0500
Received: from qs-2003e-snip4-2.eps.apple.com ([57.103.86.45]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Ja-0007yw-3b
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:41 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 F111D1800117; Thu,  5 Feb 2026 14:26:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301593; x=1772893593;
 bh=jbpBkBFfXNX3BzKF2Q07er+vdtP2HICkvEt9c9jj/7w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UQOX0mrcRNUXYSYf0l85K4RGx82WmwjCu4NA6Ty9VHmY6tMb5zLjebB0UnL8IGVHFu3q8u/PsW0tZAdhhfWn57lWhEJVPA6vkLZdKklzUQ/Bm1T3xHeU3XsfPttT80wLG+ZvI8PrJ3eeD2e5Twr/fEeheI9aSXWHI/ZK1XdVqFgZXBayyS88ATZapIepjJFsb64ZQl0dO6X2fCAT+Oreo8FsbbzvGhkVAgUYzpz39XFiSJd3BMGkkAdsDdLh/lQp0cvrLhMC+OxP7pweZm37Dlz++AjE+WAcd581PJdXeAetthmHMxNvzmcFGq3G//XZgYueNQtRrFmoKwUYdxmzYQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 20D671800D83; Thu,  5 Feb 2026 14:26:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 13/22] hw, target,
 accel: whpx: change apic_in_platform to kernel_irqchip
Date: Thu,  5 Feb 2026 15:25:31 +0100
Message-ID: <20260205142543.64818-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AIp8DMUn c=1 sm=1 tr=0 ts=6984a897
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=kiID8kuSrMNj-W4hClMA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AmQKvvPGCtXJ-9ANSBWFJ_9Ic6OO0_YL
X-Proofpoint-ORIG-GUID: AmQKvvPGCtXJ-9ANSBWFJ_9Ic6OO0_YL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX9mZ8LembAjFb
 gbc5ckWZ+sdRkBVCkERbLQHho3hVtv851PW7ejpjbxL7pea6rFWd7/bYjX7uTMgvhXcKsiONImc
 5RTHMaqbFCC8x5KJ2RxLCKqZm0lpCTHF+FDxndLIFZl9mt2pGZy5LQ/liMNjqut98UTPVS8n2X3
 aRUjHlg9+GAaodQwKzrTjsYzQO00SLMxNKA9uzcxGue65zyjjQujFFzwfRRotojM7fVIdto/zoH
 MH2u0laR2kKC6WBLJpT7Q01gHEhiDF+eclN1sQb4su2CE9DB0silBDI5b/l7V1wJdnTN+MTdAKZ
 SXNvnHOZGOlpOD4rjJUvmlQMhBGAPpCTu9rcOTOSh3f9FZCGVvrBYqefKMlWF0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABUZzinEyxASTS//50Upcousa0QjE/A/1+zF8h7Ue0gcDuuLSCfL7BNBj8Jgm5aVkxbwpeks0hcI9a3okJJD5tvxUp7qBQYfxfsZn/6IGhcvMeh5ni9DVRAs0Q7TuBfo0O+psQ8Fi5713BJ+xzOMh8Ks8UbDqoYuS4aUX0eDldchwZR1OHARxtVXA77hMJ4/KxXssNdKp7oZSUyfywZBihPh6Zr9pUj+UhTcOfqM1G0DeDyAuyUMkN8+xxnWKv7OPe5EyfWX+XobQre+Z1+k2cXNGNyurh55BkboRPoaCnCR3JLm89zz8FJyj3EeMSunfJXCliirDPJ9imVv6bcF2DGt8XdE9AXn2G2W59mkrqM4F58xh7cLLN/9h5iWLrqDA4wCCRbBkSpYvfr6+a0gtX8jVYXIx8/ReNpU579ZhQWmVPYzfXVTA6L7cCqoAYb8c0pSgaz0i89uEklQ+RTmyDZCm4TUPPeIeW5HmhCIncee1wKRcKk/bqIadbfOqu6Y6nCw0PhCV5rY9+Xz6QWaTXW2knOW8QXeBfvQG89JwTKDxiQmUKP9qK+ZSKTMxi74dmNL3uzL96ATuaotvbJIbeJc1eO+33kFA9jyozNqFKg/GMYBv5JlL7iDt9wFhinmcMFHvKxzQC55gK6uwnKxiMTCRmjLm+T/LPABrX8wV43N1JQqejWr3iHq4AMlRvIOB6HuzfiGyDWkGdB2mnZmHvMLJwrKfSd3hk1e3cDRvIlWA/muf/t0ZqwKdP3cf1maoECBkDiiIcC+I7U5wvIQNcIyaaQemPXPzZoLCufoZCcTpAFE2SEz5mYYEO2sbeIqBbzFhKYHKeXHHSSK40oBM05gap8bJ5fCf7G2Pi7aZswWq8Z43HjsmtmRvds9xeovglIQdpV6z3ltKcOcn5YwrgebL1o0rCOxs5l+emx21c4cTa+rAWro/abSe+3N3XLVenTog/PD6MGwTkcA==
Received-SPF: pass client-ip=57.103.86.45;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Change terminology to match the KVM one, as APIC is x86-specific.

And move out whpx_irqchip_in_kernel() to make it usable from common
code even when not compiling with WHPX support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 MAINTAINERS                        |   1 +
 accel/stubs/whpx-stub.c            |   1 +
 accel/whpx/whpx-accel-ops.c        |   2 +-
 accel/whpx/whpx-common.c           |  10 +-
 hw/arm/virt.c                      |   9 ++
 hw/i386/x86-cpu.c                  |   4 +-
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_whpx.c           | 237 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   3 +
 include/system/whpx-internal.h     |   1 -
 include/system/whpx.h              |   5 +-
 target/i386/cpu-apic.c             |   2 +-
 target/i386/whpx/whpx-all.c        |  14 +-
 14 files changed, 270 insertions(+), 23 deletions(-)
 create mode 100644 hw/intc/arm_gicv3_whpx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 873d6628cd..126f72e587 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -566,6 +566,7 @@ M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: hw/intc/arm_gicv3_whpx.c
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
index c564c89fd0..4529dc4f78 100644
--- a/accel/stubs/whpx-stub.c
+++ b/accel/stubs/whpx-stub.c
@@ -10,3 +10,4 @@
 #include "system/whpx.h"
 
 bool whpx_allowed;
+bool whpx_irqchip_in_kernel;
diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index c84a25c273..50fadea0fd 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -78,7 +78,7 @@ static void whpx_kick_vcpu_thread(CPUState *cpu)
 
 static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
 {
-    return !whpx_apic_in_platform();
+    return !whpx_irqchip_in_kernel();
 }
 
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c0610815d9..05f9e520b7 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -35,6 +35,7 @@
 #include <winhvplatformdefs.h>
 
 bool whpx_allowed;
+bool whpx_irqchip_in_kernel;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
 #ifdef HOST_X86_64
@@ -488,15 +489,6 @@ static const TypeInfo whpx_cpu_accel_type = {
     .abstract = true,
 };
 
-/*
- * Partition support
- */
-
-bool whpx_apic_in_platform(void)
-{
-    return whpx_global.apic_in_platform;
-}
-
 static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index aa5e992712..b7eb0cec5e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -49,6 +49,7 @@
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/whpx.h"
 #include "system/qtest.h"
 #include "system/system.h"
 #include "hw/core/loader.h"
@@ -2114,6 +2115,8 @@ static void finalize_gic_version(VirtMachineState *vms)
         /* KVM w/o kernel irqchip can only deal with GICv2 */
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         accel_name = "KVM with kernel-irqchip=off";
+    } else if (whpx_enabled()) {
+        gics_supported |= VIRT_GIC_VERSION_3_MASK;
     } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         if (module_object_class_by_name("arm-gicv3")) {
@@ -2154,6 +2157,8 @@ static void finalize_msi_controller(VirtMachineState *vms)
     if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        } else if (whpx_enabled()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         } else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2169,6 +2174,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
             error_report("GICv2 + ITS is an invalid configuration.");
             exit(1);
         }
+        if (whpx_enabled()) {
+            error_report("ITS not supported on WHPX.");
+            exit(1);
+        }
     }
 
     assert(vms->msi_controller != VIRT_MSI_CTRL_AUTO);
diff --git a/hw/i386/x86-cpu.c b/hw/i386/x86-cpu.c
index 276f2b0cdf..95e08e3c2a 100644
--- a/hw/i386/x86-cpu.c
+++ b/hw/i386/x86-cpu.c
@@ -45,7 +45,7 @@ static void pic_irq_request(void *opaque, int irq, int level)
 
     trace_x86_pic_interrupt(irq, level);
     if (cpu_is_apic_enabled(cpu->apic_state) && !kvm_irqchip_in_kernel() &&
-        !whpx_apic_in_platform()) {
+        !whpx_irqchip_in_kernel()) {
         CPU_FOREACH(cs) {
             cpu = X86_CPU(cs);
             if (apic_accept_pic_intr(cpu->apic_state)) {
@@ -71,7 +71,7 @@ int cpu_get_pic_interrupt(CPUX86State *env)
     X86CPU *cpu = env_archcpu(env);
     int intno;
 
-    if (!kvm_irqchip_in_kernel() && !whpx_apic_in_platform()) {
+    if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
         intno = apic_get_interrupt(cpu->apic_state);
         if (intno >= 0) {
             return intno;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 0a2e5a3e2f..9054143ea7 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -32,6 +32,7 @@
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
 #include "system/kvm.h"
+#include "system/whpx.h"
 
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
@@ -663,6 +664,8 @@ const char *gicv3_class_name(void)
 {
     if (kvm_irqchip_in_kernel()) {
         return "kvm-arm-gicv3";
+    } else if (whpx_enabled()) {
+        return TYPE_WHPX_GICV3;
     } else {
         if (kvm_enabled()) {
             error_report("Userspace GICv3 is not supported with KVM");
diff --git a/hw/intc/arm_gicv3_whpx.c b/hw/intc/arm_gicv3_whpx.c
new file mode 100644
index 0000000000..849a005242
--- /dev/null
+++ b/hw/intc/arm_gicv3_whpx.c
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * ARM Generic Interrupt Controller using HVF platform support
+ *
+ * Copyright (c) 2025 Mohamed Mediouni
+ * Based on vGICv3 KVM code by Pavel Fedin
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "system/runstate.h"
+#include "system/whpx.h"
+#include "system/whpx-internal.h"
+#include "gicv3_internal.h"
+#include "vgic_common.h"
+#include "migration/blocker.h"
+#include "qom/object.h"
+#include "target/arm/cpregs.h"
+
+#include "hw/arm/bsa.h"
+#include <winhvplatform.h>
+#include <winhvplatformdefs.h>
+#include <winnt.h>
+
+struct WHPXARMGICv3Class {
+    ARMGICv3CommonClass parent_class;
+    DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
+};
+
+OBJECT_DECLARE_TYPE(GICv3State, WHPXARMGICv3Class, WHPX_GICV3)
+
+/* TODO: Implement GIC state save-restore */
+static void whpx_gicv3_check(GICv3State *s)
+{
+}
+
+static void whpx_gicv3_put(GICv3State *s)
+{
+    whpx_gicv3_check(s);
+}
+
+static void whpx_gicv3_get(GICv3State *s)
+{
+}
+
+static void whpx_gicv3_set_irq(void *opaque, int irq, int level)
+{
+    struct whpx_state *whpx = &whpx_global;
+    GICv3State *s = opaque;
+    WHV_INTERRUPT_CONTROL interrupt_control = {
+        .InterruptControl.InterruptType = WHvArm64InterruptTypeFixed,
+        .RequestedVector = GIC_INTERNAL + irq,
+        .InterruptControl.Asserted = level
+    };
+
+    if (irq > s->num_irq) {
+        return;
+    }
+
+
+    whp_dispatch.WHvRequestInterrupt(whpx->partition, &interrupt_control,
+         sizeof(interrupt_control));
+}
+
+static void whpx_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *c;
+
+    c = env->gicv3state;
+
+    c->icc_pmr_el1 = 0;
+    /*
+     * Architecturally the reset value of the ICC_BPR registers
+     * is UNKNOWN. We set them all to 0 here; when the kernel
+     * uses these values to program the ICH_VMCR_EL2 fields that
+     * determine the guest-visible ICC_BPR register values, the
+     * hardware's "writing a value less than the minimum sets
+     * the field to the minimum value" behaviour will result in
+     * them effectively resetting to the correct minimum value
+     * for the host GIC.
+     */
+    c->icc_bpr[GICV3_G0] = 0;
+    c->icc_bpr[GICV3_G1] = 0;
+    c->icc_bpr[GICV3_G1NS] = 0;
+
+    c->icc_sre_el1 = 0x7;
+    memset(c->icc_apr, 0, sizeof(c->icc_apr));
+    memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
+}
+
+static void whpx_gicv3_reset_hold(Object *obj, ResetType type)
+{
+    GICv3State *s = ARM_GICV3_COMMON(obj);
+    WHPXARMGICv3Class *kgc = WHPX_GICV3_GET_CLASS(s);
+
+    if (kgc->parent_phases.hold) {
+        kgc->parent_phases.hold(obj, type);
+    }
+
+    whpx_gicv3_put(s);
+}
+
+
+/*
+ * CPU interface registers of GIC needs to be reset on CPU reset.
+ * For the calling arm_gicv3_icc_reset() on CPU reset, we register
+ * below ARMCPRegInfo. As we reset the whole cpu interface under single
+ * register reset, we define only one register of CPU interface instead
+ * of defining all the registers.
+ */
+static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
+    { .name = "ICC_CTLR_EL1", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 4,
+      /*
+       * If ARM_CP_NOP is used, resetfn is not called,
+       * So ARM_CP_NO_RAW is appropriate type.
+       */
+      .type = ARM_CP_NO_RAW,
+      .access = PL1_RW,
+      .readfn = arm_cp_read_zero,
+      .writefn = arm_cp_write_ignore,
+      /*
+       * We hang the whole cpu interface reset routine off here
+       * rather than parcelling it out into one little function
+       * per register
+       */
+      .resetfn = whpx_gicv3_icc_reset,
+    },
+};
+
+static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
+         &reg, 1, &val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
+    }
+}
+
+static void whpx_gicv3_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    GICv3State *s = WHPX_GICV3(dev);
+    WHPXARMGICv3Class *kgc = WHPX_GICV3_GET_CLASS(s);
+    int i;
+
+    kgc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    if (s->revision != 3) {
+        error_setg(errp, "unsupported GIC revision %d for platform GIC",
+                   s->revision);
+        return;
+    }
+
+    if (s->security_extn) {
+        error_setg(errp, "the platform vGICv3 does not implement the "
+                   "security extensions");
+        return;
+    }
+
+    if (s->nmi_support) {
+        error_setg(errp, "NMI is not supported with the platform GIC");
+        return;
+    }
+
+    if (s->nb_redist_regions > 1) {
+        error_setg(errp, "Multiple VGICv3 redistributor regions are not "
+                   "supported by WHPX");
+        error_append_hint(errp, "A maximum of %d VCPUs can be used",
+                          s->redist_region_count[0]);
+        return;
+    }
+
+    gicv3_init_irqs_and_mmio(s, whpx_gicv3_set_irq, NULL);
+
+    for (i = 0; i < s->num_cpu; i++) {
+        CPUState *cpu_state = qemu_get_cpu(i);
+        ARMCPU *cpu = ARM_CPU(cpu_state);
+        WHV_REGISTER_VALUE val = {.Reg64 = 0x080A0000 + (GICV3_REDIST_SIZE * i)};
+        whpx_set_reg(cpu_state, WHvArm64RegisterGicrBaseGpa, val);
+        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+    }
+
+    if (s->maint_irq) {
+        error_setg(errp, "Nested virtualisation not currently supported by WHPX.");
+        return;
+    }
+
+    error_setg(&s->migration_blocker,
+        "Live migration disabled because GIC state save/restore not supported on WHPX");
+    if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+        error_report_err(*errp);
+    }
+}
+
+static void whpx_gicv3_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
+    WHPXARMGICv3Class *kgc = WHPX_GICV3_CLASS(klass);
+
+    agcc->pre_save = whpx_gicv3_get;
+    agcc->post_load = whpx_gicv3_put;
+
+    device_class_set_parent_realize(dc, whpx_gicv3_realize,
+                                    &kgc->parent_realize);
+    resettable_class_set_parent_phases(rc, NULL, whpx_gicv3_reset_hold, NULL,
+                                       &kgc->parent_phases);
+}
+
+static const TypeInfo whpx_arm_gicv3_info = {
+    .name = TYPE_WHPX_GICV3,
+    .parent = TYPE_ARM_GICV3_COMMON,
+    .instance_size = sizeof(GICv3State),
+    .class_init = whpx_gicv3_class_init,
+    .class_size = sizeof(WHPXARMGICv3Class),
+};
+
+static void whpx_gicv3_register_types(void)
+{
+    type_register_static(&whpx_arm_gicv3_info);
+}
+
+type_init(whpx_gicv3_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index faae20b93d..96742df090 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -41,6 +41,7 @@ specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
+specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 3d24ad22d2..c55cf18120 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -313,6 +313,9 @@ typedef struct ARMGICv3CommonClass ARMGICv3CommonClass;
 DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3CommonClass,
                      ARM_GICV3_COMMON, TYPE_ARM_GICV3_COMMON)
 
+/* Types for GICv3 kernel-irqchip */
+#define TYPE_WHPX_GICV3 "whpx-arm-gicv3"
+
 struct ARMGICv3CommonClass {
     /*< private >*/
     SysBusDeviceClass parent_class;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 609d0e1c08..8ded54a39b 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -45,7 +45,6 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
-    bool apic_in_platform;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/include/system/whpx.h b/include/system/whpx.h
index 00f6a3e523..4217a27e91 100644
--- a/include/system/whpx.h
+++ b/include/system/whpx.h
@@ -25,11 +25,12 @@
 
 #ifdef CONFIG_WHPX_IS_POSSIBLE
 extern bool whpx_allowed;
+extern bool whpx_irqchip_in_kernel;
 #define whpx_enabled() (whpx_allowed)
-bool whpx_apic_in_platform(void);
+#define whpx_irqchip_in_kernel() (whpx_irqchip_in_kernel)
 #else /* !CONFIG_WHPX_IS_POSSIBLE */
 #define whpx_enabled() 0
-#define whpx_apic_in_platform() (0)
+#define whpx_irqchip_in_kernel() (0)
 #endif /* !CONFIG_WHPX_IS_POSSIBLE */
 
 #endif /* QEMU_WHPX_H */
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index f7ad7b5139..eaa10ad2a3 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -33,7 +33,7 @@ APICCommonClass *apic_get_class(Error **errp)
         apic_type = "kvm-apic";
     } else if (xen_enabled()) {
         apic_type = "xen-apic";
-    } else if (whpx_apic_in_platform()) {
+    } else if (whpx_irqchip_in_kernel()) {
         apic_type = "whpx-apic";
     }
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 052cda42bf..8210250dc3 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -607,7 +607,7 @@ void whpx_get_registers(CPUState *cpu)
                      hr);
     }
 
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         /*
          * Fetch the TPR value from the emulated APIC. It may get overwritten
          * below with the value from CR8 returned by
@@ -749,7 +749,7 @@ void whpx_get_registers(CPUState *cpu)
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
 
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         whpx_apic_get(x86_cpu->apic_state);
     }
 
@@ -1379,7 +1379,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Get pending hard interruption or replay one that was overwritten */
-    if (!whpx_apic_in_platform()) {
+    if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
             vcpu->interruptable && (env->eflags & IF_MASK)) {
             assert(!new_int.InterruptionPending);
@@ -1553,7 +1553,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
     if (exclusive_step_mode == WHPX_STEP_NONE) {
         whpx_vcpu_process_async_events(cpu);
-        if (cpu->halted && !whpx_apic_in_platform()) {
+        if (cpu->halted && !whpx_irqchip_in_kernel()) {
             cpu->exception_index = EXCP_HLT;
             qatomic_set(&cpu->exit_request, false);
             return 0;
@@ -1642,7 +1642,7 @@ int whpx_vcpu_run(CPUState *cpu)
             break;
 
         case WHvRunVpExitReasonX64ApicEoi:
-            assert(whpx_apic_in_platform());
+            assert(whpx_irqchip_in_kernel());
             ioapic_eoi_broadcast(vcpu->exit_ctx.ApicEoi.InterruptVector);
             break;
 
@@ -2187,7 +2187,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
                 goto error;
             }
         } else {
-            whpx->apic_in_platform = true;
+            whpx_irqchip_in_kernel = true;
         }
     }
 
@@ -2196,7 +2196,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     prop.ExtendedVmExits.X64MsrExit = 1;
     prop.ExtendedVmExits.X64CpuidExit = 1;
     prop.ExtendedVmExits.ExceptionExit = 1;
-    if (whpx_apic_in_platform()) {
+    if (whpx_irqchip_in_kernel()) {
         prop.ExtendedVmExits.X64ApicInitSipiExitTrap = 1;
     }
 
-- 
2.50.1 (Apple Git-155)


