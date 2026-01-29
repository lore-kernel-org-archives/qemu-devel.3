Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A854D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 19:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlXaQ-0007m2-Pk; Thu, 29 Jan 2026 14:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZu-0006cE-ID
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:23 -0500
Received: from ci-2007f-snip4-2.eps.apple.com ([57.103.88.55]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlXZd-00065x-Jm
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 14:21:03 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPS id
 A6AF91800095; Thu, 29 Jan 2026 19:20:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769714459; x=1772306459;
 bh=GKBukT6k/OXRrrqEdKhY3Ivixj42K+1mYk6hbUj+KBM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=X0QFreNLdeTtPPqAE9f64CNfzKo1t3SSJ4NR50FRohpsP3VWVY6ywnnxFcIHth0mDq5Ds6YOcEPApIrRPS5p2jVWn7NkRfHJGkoYX0214RoeivMkrZ0D1bIweIMvXxFAg0S1VS135KygzJ6zHVFwct6pYCwSIUyTsq/wLy9Y4LSchpPLoouJdS+RszB9BSMuIxuB3UakZI4wnO2WJb1wWML/XxzR64pvMJ2iHdwqoxfq8s4j3zLYjyH38LnfZ7NI8S69o2AApxIyyQLXn4kcvEGt1Wqnf4gGwzjkiCWEBiEdtiaO1LcYyoc1vVOmo5pmu+mgYgX7UKyxCqvuigXMLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-2 (Postfix) with ESMTPSA id
 73AAE18005D0; Thu, 29 Jan 2026 19:20:52 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v19 13/22] whpx: interrupt controller support
Date: Thu, 29 Jan 2026 20:19:58 +0100
Message-ID: <20260129192009.14707-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260129192009.14707-1-mohamed@unpredictable.fr>
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uniluF_pYdK4k5iZHdebujuU2C-PmK4e
X-Proofpoint-GUID: uniluF_pYdK4k5iZHdebujuU2C-PmK4e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzOCBTYWx0ZWRfX3a6sdmhmOc3q
 /9ftxUMWjNyTq5tYrVchbBNIocHtbktKPr6tI/fZhMjt0FfY2WkzGY/eAXxOsqNQcQYm6e6cmC/
 sGa5ZHoMWQ+1Z80n/RbAVxYlLmZCXFDzkG7fW6F/fk3B6r1qwJvj2JgqlIAxrJUtV7HF68gzGOS
 NjdKxiPFe7WKsVttiLwPN6iSHSubKtqyYO3+F/tDB4/XmS0ljXCLfzC0LBt6YNCx1N0uJQavZiI
 GaSGRZzvPNN07zV5qXm3zvaPJxij8RZkioawlB2I2nyrFmBMY9rpK2KiB5fw1UsK4SBODso87r4
 sXq/VOLVEDKDSD0EmlfzenyYut7msqr1h7YbyDYH6OYvz0oCf+rrf/MTl6Gvs0=
X-Authority-Info-Out: v=2.4 cv=ZYoQ98VA c=1 sm=1 tr=0 ts=697bb319
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=PKxacjXS0JhB3XvmiyoA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1030
 bulkscore=0 mlxlogscore=999 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290138
X-JNJ: AAAAAAAB3yK+PS2Fm3QEVr2hEFnxWyerHCxfkZ6GO/dzYg5pxjnEEP5Q3XchFTe9IvJOFE4hsHu1dKFOCD7ZEe6vDQJWcrKNzjoZRk87QzJu+dgJssmpTdxJw3ivtjG7zV3ayuZFxHsCPGNh7lF4qU4yZP7fworgnV1a5grYw17gv0s+P27J/ppwp9HDkxNSNfUXYldNE1vLlr01gTGa2pW63k1YrzkfkJywQugelvmgXJMRTSq5L4oar5GUzvpThrH+9MKaEBpVAZF0rZnP3aU0EVdgglqFP0B7soQYhxhZSjhXkTnIayvD+X9lUYiEtSMrNs9LPdtPdB6h6PPgEZ3u1wqsVIxtFMBGqcBPFGBIZtwJlEBOR+ooVqw0rKK4SQViwJ5eS6f4u0/bQlFQHewstVJ38yhMRXWAeOZjytRupI59TZa1s9OKxWry58grqk81O6h/hH/SK466A0dP0OAHF6SSCjpJhJTRKY7+L46i8gn23JXILrdrXnEUPQarb0wiM0i4tXszo8PD1xQOMWInCVcr3GeKynE5gUKzGYgby+/FCA1JCZaGKMH658Ulu+XOLgRsE/BK7EvHcbMfXX6/fNm6hJP8d3u9/fvDa8iIbdyJ1yFVWLb2uzq4ZyeT0uLfGJZg080tunNX/hPt4UQVbLy3KMPp5h3jn0HUsQJijNU5dJWfFBk1dBx4MVpxPMrwj2uZlF+nJ0u/pDGYYQ8MV3jnhlntcrqzYIOgC7dkIqMjUEd3bkNIIrTUpMifRYfnrF5xpwEWfMmTevnHk8ITphLB64dHqtxSXM9K3nzxs5+yTRQUl/JmnLKf0fUkfh3gQErvA1hTPwvC6h2rVDO9gX7vlgRrnkG/eKwPHwlAv4Q3w0BK8JQ=
Received-SPF: pass client-ip=57.103.88.55;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                        |   1 +
 hw/arm/virt.c                      |  10 ++
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_whpx.c           | 237 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   3 +
 6 files changed, 255 insertions(+)
 create mode 100644 hw/intc/arm_gicv3_whpx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 070adac119..94e0a3832b 100644
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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dde43caba9..a4dc6201bf 100644
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
@@ -2156,6 +2159,9 @@ static void finalize_msi_controller(VirtMachineState *vms)
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         }
+        else if (whpx_enabled()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }
         else {
             vms->msi_controller = VIRT_MSI_CTRL_ITS;
         }
@@ -2171,6 +2177,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
             error_report("GICv2 + ITS is an invalid configuration.");
             exit(1);
         }
+        if (whpx_enabled()) {
+            error_report("ITS not supported on WHPX.");
+            exit(1);
+        }
     }
 
     assert(vms->msi_controller != VIRT_MSI_CTRL_AUTO);
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
-- 
2.50.1 (Apple Git-155)


