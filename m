Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A7AD2FED8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknq6-0006yT-S0; Tue, 27 Jan 2026 13:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknoX-000252-Su
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:28 -0500
Received: from p-west2-cluster5-host9-snip4-6.eps.apple.com ([57.103.71.29]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vknoV-0003aL-1D
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:21 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id
 03FC618000A8; Tue, 27 Jan 2026 18:29:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769538557; x=1772130557;
 bh=z38U8z2pvhlkmptNgeCa7Ea0550xfUb9CPrMfDy3AdE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=NeuPtEsb3Bi01Qu1c37SIw+F0H80cKt8hxUHnBBpQ+oC+ZmYNmovnZyBJllBpLuZvS7cGNNZg1a5IDQK+ryx3+cbUtkBNNo6otbwfMAsNX/JrBX0MPlyj7KJKbhL6cZ+JdXLzU0jsoE2bKVEJRGC0Mc4iwVT4kXH4T8tZ6EWnVyzNd40+pjGcnUBrRAaMkTNzs04d+/scLFhlFxtPbpIH8eWyAGY90+kzPVNOxWFWnR86q4t7ogNI0XuxN4et5LQTXjjoU9FWRTZ7F+pYF8SoBOoxrjU96tWbWmu90Du6ZySx/Acglg3lYhnXnZBUZU8YfMvCPuY9ITNTuqk4qbfVg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id
 46836180097A; Tue, 27 Jan 2026 18:29:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v18 13/22] whpx: interrupt controller support
Date: Tue, 27 Jan 2026 19:27:53 +0100
Message-ID: <20260127182805.73212-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127182805.73212-1-mohamed@unpredictable.fr>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Uu5u9uwB c=1 sm=1 tr=0 ts=697903fc
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PKxacjXS0JhB3XvmiyoA:9
X-Proofpoint-GUID: JXbuf6yE_JVPtiG_KQIbtiNxFDUqQuSX
X-Proofpoint-ORIG-GUID: JXbuf6yE_JVPtiG_KQIbtiNxFDUqQuSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE1MCBTYWx0ZWRfX/qdPduXP3CsN
 JEgGQ3J15IbD1F2RE5LAanQH4zTK0d3LguAO3YGH9BgWPuBosoukoOG38l8XEAKSpjz7zjzoq5Q
 MEf9QMRnQcscduweIiKPlZSspPnkXXl8hEB8Ru+SZoUOLRvb4g94+bOzI8QcJvDcbLufKPsF2I4
 liZOnCd5qCeGnmPXkxXu8iRD5fKZjMsRP8rxwyB2qRmcFWuzKfmXh/a+eieWZ2A5cDnLwB+tRuD
 RCOusz3WY5sFATNsP+dMNM5CKvddgo0Pz325/n7VTUIcDAFqTYJ148BvHcH4i+45DQHugVLPUGH
 7vduTMU4UAfyc1+iZvWX8Brra+8wS3tqB/ziXXB92Fl4PQ9KCTDAVV5YejcIbg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270150
X-JNJ: AAAAAAABJdBcvlR6Dsx9UlZLIPP7s0ZDdPTtoWUQdhhHpHrHPEXxhiuenKQK5rCTKjY2Rxv4ybQUj9R6kMOaGEa3ynw71gCoM8sJnN0PnyBiL5OMIcLSVs2YxiEG3qZWtOh6g/k4G1LUdR19pMZq6mjUeivV9cOOu+S6z12TtQMRQP2CGwYOCbgGkze/CkiVwXEzJ7NKhFDYE1fUkN/Bz4JH1N4haXJVU20EyNXTk33MTUCUwUk/200xM6vI1mreBMGHUKrHt2oCxz4hYIITYDbAWrUUzRfcAx8ZwHKFffPTDNqg/jmjPtAjn9ZYAcGuof+NJcqOSxjUQ6dSEpyd/XkJ5MvYKoqJbXF5OUOSwbC1ORk2AUhAHRgsCHPvwyAuazf20iFGzmm4ikmAkMT8HhwExTM15k5gXHWxeb+n56vxrmq9L05dId+9UsJWiLkCnVtv5Iyxbd2FJ4bbanjTApXAgY9UaymhRavf+5OmZmybKysUh+Y5QXk/kL3pwIEvpQ50UmHGBSaDV46yN8Zk5hw0DUKQVZI5RN8XBDcyWbIi9GlV9F6xJGEqkYzDBplRK0KFb0+phIiq80eciv4xr+huTzWeM+CARFnBiZrTPZznAz1JYRw1dxF2cIPk4z8ZCIkjbQTfZuB/qcq4etA/SOQvMNQfeOv8PkkFioD1UyK2ffOiDg8oPKyjLE+7TSpODLSR2BIpUy/Tapq5K8Ob+TZuBLoH5CQvsW+oGIC/FhxCrgdysG3Hz1Qm1xOG5kFYCay8tNoWxjEQmPsllNTTi38YR4+h9MPtfIcq5z5MuShpLTYNgskH18yrVat930j3okGQrj+fNk/F28N/g4SjM+0FttbAxHnD4V3WaYYhotf8mTQ+yg/SJbGiFDD9nTEEHSVSMcsX3x8o+2jb/fTQAnkRvR8ba8cv/J+XIjMG/w==
Received-SPF: pass client-ip=57.103.71.29;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
 MAINTAINERS                        |   1 +
 hw/arm/virt.c                      |  10 ++
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_whpx.c           | 237 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   3 +
 6 files changed, 255 insertions(+)
 create mode 100644 hw/intc/arm_gicv3_whpx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a7b955111..d18978a36b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -567,6 +567,7 @@ M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: hw/intc/arm_gicv3_whpx.c
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3d7f02ce0e..9e989b721b 100644
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
@@ -2110,6 +2111,8 @@ static void finalize_gic_version(VirtMachineState *vms)
         /* KVM w/o kernel irqchip can only deal with GICv2 */
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         accel_name = "KVM with kernel-irqchip=off";
+    } else if (whpx_enabled()) {
+        gics_supported |= VIRT_GIC_VERSION_3_MASK;
     } else if (tcg_enabled() || hvf_enabled() || qtest_enabled())  {
         gics_supported |= VIRT_GIC_VERSION_2_MASK;
         if (module_object_class_by_name("arm-gicv3")) {
@@ -2143,6 +2146,9 @@ static void finalize_msi_controller(VirtMachineState *vms)
         }
     }
     if (vms->msi_controller == VIRT_MSI_CTRL_AUTO) {
+        if (whpx_enabled() && whpx_irqchip_in_kernel()) {
+            vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+        }
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
             vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
         }
@@ -2157,6 +2163,10 @@ static void finalize_msi_controller(VirtMachineState *vms)
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


