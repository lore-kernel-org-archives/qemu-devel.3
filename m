Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B73EF587B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 11:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vraGa-0005Lx-72; Sun, 15 Feb 2026 06:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGP-0005G4-JG
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:10 -0500
Received: from p-west2-cluster1-host8-snip4-10.eps.apple.com ([57.103.68.103]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vraGG-0007wK-2s
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 06:26:05 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPS id
 164C01800182; Sun, 15 Feb 2026 11:25:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771154754; x=1773746754;
 bh=6AbFosTeO+22W6pzp7NhrRLKcRCIno0EsBShVb2QtOo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Oiu2XpOk2BYd75Ri2OgBZ2wO9bHjgR46PBHpa6XMRWVFV21WMfo+ythIm8LPOJNHuQFCUeVivfM6KM1rLnAu0xnkfWhuvtY/NcEWKmgm54N7WGqq75D9WbZ0RLkhQzlxv9gqEcFZotfQeJRw07GlpoufUhjWhh3oZoASlRKBEf5sIkEkE4ZD4pNEq+uacMA3WKlhM8XFMBzEGC0Jyxm6WzRGdoGBgcir4obnNCSINMoTXL1VHy1IZETWvBbPFvz6XBs9hT825j87oLf56VkiED9ZIwC5O6/l2yxmJ52eZSo0yhS5bidnTR0qPUbbzGl/DFtD1Cz5pJu4wIOVTcao3Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-0 (Postfix) with ESMTPSA id
 9352D18001B2; Sun, 15 Feb 2026 11:25:50 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v10 02/14] hw/intc: Add hvf vGIC interrupt controller support
Date: Sun, 15 Feb 2026 12:25:31 +0100
Message-ID: <20260215112543.4817-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260215112543.4817-1-mohamed@unpredictable.fr>
References: <20260215112543.4817-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FlvkAnNzmpBIHzpfwOTfe7esUKOdlvjE
X-Authority-Info-Out: v=2.4 cv=BNm+bVQG c=1 sm=1 tr=0 ts=6991ad41
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=D2JAlcJVxmvnjXxMMLIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDA5MiBTYWx0ZWRfX3pAq3gxHf1ro
 4LI84GaKF6VaAn52XDABp3Pz9d+k8SQRVpLlxFrGnxIM3IzHpnJnEfnLW/YzhgdNCX9sWpAFUcP
 BIKd/y9PeT7MKT6SWmcz8Tx2b8SyR4OrCUYOiZqf81ykEgt42ZUtiAptd4yK1O30KQz3a/K8oo5
 gDD4OrclZdjSiAU9zZByEXI1haTKWwPGNxD6rvODkc/qzP3H9ii6Pzmdlv66Y90PUjBsGg1+tbk
 EK/1Dp2+rjD81fzth6aakTJNmDiHsokx/Qgh5d9UrJK+mVfbvqBZ70O12nzUDOgxC0xqZIZXXbu
 t84XwsVKueGeXiqTlgUuJ/AaSQ+U6/6qTQuhR0I+DNp3lipJFvHX9sbUJj17/8=
X-Proofpoint-ORIG-GUID: FlvkAnNzmpBIHzpfwOTfe7esUKOdlvjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_04,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1030
 adultscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150092
X-JNJ: AAAAAAABB12dZ7kKuAHFacYPNA1v6dz6ZrchNpK3NdS7bHAdUtfy4ryQUrbkhNImrd8ntlTTo7p4DfCR6A10d86x/QVvs/ZS4k6UEIi7lkgTMIY2thp4vWgt3IWEgaOQOFWKg73UvUMXUw3vdSFKOQwvVLRCUbmup0i9yWka0ldtpvIVzhDjVj73QXxtszl5dzaQ6DuU84GN0HXsHKzu+Dhiw9pL2SAseX0XeuOljSxKnVmPMX+52HcACNPWjPjMAJlJPyHgLl6xoV0oI4RC94nAt0xFtKEmv8ER+nugs8DRrXfM44jeQqX559EGNCG+K9EZN7JSKKZ4ZdqFqD4TNdf1tzQeTsR/ZUCsukicTEQNlRrnedHhohFMqiWJc8MQA0Nw8Is1kz4rmRlC3VoZB9HmX/YZ9QivHoeFw+z+5S9Tgj3IkZxlfcZ1jp2pf3bKq87k8Qf7lhEzQMhWvtp+zsnADxqAvge4SeUbCMH9Tq8LHo+mxQYMMVP2E3SlMe/tvyycR0W4gCrGRju7JZIgGw3EvmOZ9CR7Id8YZCvi17l0ciDLnYgTpE4l4F5o/g9l9XyqplSOOWTKTtdswSlmb6z257pJ4MOkwVnoLHGKh6Wuv61xnY5VjSsg2Acsi9lfvlgGVoimYcoWHhS9MXEiS5bvKiKVYk3URcMfNg0Y/Z5O+hq6gMtGZAyAbBqrScGcP3Bg5N9ps5URA3evQh4RPrU06SVckXow6k8/zqaGug==
Received-SPF: pass client-ip=57.103.68.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

This opens up the door to nested virtualisation support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_hvf.c            | 735 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 3 files changed, 737 insertions(+)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
new file mode 100644
index 0000000000..d6a46b7d53
--- /dev/null
+++ b/hw/intc/arm_gicv3_hvf.c
@@ -0,0 +1,735 @@
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
+#include "system/hvf.h"
+#include "system/hvf_int.h"
+#include "hvf_arm.h"
+#include "gicv3_internal.h"
+#include "vgic_common.h"
+#include "qom/object.h"
+#include "target/arm/cpregs.h"
+#include <Hypervisor/Hypervisor.h>
+
+struct HVFARMGICv3Class {
+    ARMGICv3CommonClass parent_class;
+    DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
+};
+
+typedef struct HVFARMGICv3Class HVFARMGICv3Class;
+
+/* This is reusing the GICv3State typedef from ARM_GICV3_ITS_COMMON */
+DECLARE_OBJ_CHECKERS(GICv3State, HVFARMGICv3Class,
+                     HVF_GICV3, TYPE_HVF_GICV3);
+
+/*
+ * Loop through each distributor IRQ related register; since bits
+ * corresponding to SPIs and PPIs are RAZ/WI when affinity routing
+ * is enabled, we skip those.
+ */
+#define for_each_dist_irq_reg(_irq, _max, _field_width) \
+    for (_irq = GIC_INTERNAL; _irq < _max; _irq += (32 / _field_width))
+
+/*
+ * Wrap calls to the vGIC APIs to assert_hvf_ok()
+ * as a macro to keep the code clean.
+ */
+#define hv_gic_get_distributor_reg(offset, reg) \
+    assert_hvf_ok(hv_gic_get_distributor_reg(offset, reg))
+
+#define hv_gic_set_distributor_reg(offset, reg) \
+    assert_hvf_ok(hv_gic_set_distributor_reg(offset, reg))
+
+#define hv_gic_get_redistributor_reg(vcpu, reg, value) \
+    assert_hvf_ok(hv_gic_get_redistributor_reg(vcpu, reg, value))
+
+#define hv_gic_set_redistributor_reg(vcpu, reg, value) \
+    assert_hvf_ok(hv_gic_set_redistributor_reg(vcpu, reg, value))
+
+#define hv_gic_get_icc_reg(vcpu, reg, value) \
+    assert_hvf_ok(hv_gic_get_icc_reg(vcpu, reg, value))
+
+#define hv_gic_set_icc_reg(vcpu, reg, value) \
+    assert_hvf_ok(hv_gic_set_icc_reg(vcpu, reg, value))
+
+#define hv_gic_get_ich_reg(vcpu, reg, value) \
+    assert_hvf_ok(hv_gic_get_ich_reg(vcpu, reg, value))
+
+#define hv_gic_set_ich_reg(vcpu, reg, value) \
+    assert_hvf_ok(hv_gic_set_ich_reg(vcpu, reg, value))
+
+static void hvf_dist_get_priority(GICv3State *s, hv_gic_distributor_reg_t offset
+    , uint8_t *bmp)
+{
+    uint64_t reg;
+    uint32_t *field;
+    int irq;
+    field = (uint32_t *)(bmp);
+
+    for_each_dist_irq_reg(irq, s->num_irq, 8) {
+        hv_gic_get_distributor_reg(offset, &reg);
+        *field = reg;
+        offset += 4;
+        field++;
+    }
+}
+
+static void hvf_dist_put_priority(GICv3State *s, hv_gic_distributor_reg_t offset
+    , uint8_t *bmp)
+{
+    uint32_t reg, *field;
+    int irq;
+    field = (uint32_t *)(bmp);
+
+    for_each_dist_irq_reg(irq, s->num_irq, 8) {
+        reg = *field;
+        hv_gic_set_distributor_reg(offset, reg);
+        offset += 4;
+        field++;
+    }
+}
+
+static void hvf_dist_get_edge_trigger(GICv3State *s, hv_gic_distributor_reg_t offset,
+                                      uint32_t *bmp)
+{
+    uint64_t reg;
+    int irq;
+
+    for_each_dist_irq_reg(irq, s->num_irq, 2) {
+        hv_gic_get_distributor_reg(offset, &reg);
+        reg = half_unshuffle32(reg >> 1);
+        if (irq % 32 != 0) {
+            reg = (reg << 16);
+        }
+        *gic_bmp_ptr32(bmp, irq) |= reg;
+        offset += 4;
+    }
+}
+
+static void hvf_dist_put_edge_trigger(GICv3State *s, hv_gic_distributor_reg_t offset,
+                                      uint32_t *bmp)
+{
+    uint32_t reg;
+    int irq;
+
+    for_each_dist_irq_reg(irq, s->num_irq, 2) {
+        reg = *gic_bmp_ptr32(bmp, irq);
+        if (irq % 32 != 0) {
+            reg = (reg & 0xffff0000) >> 16;
+        } else {
+            reg = reg & 0xffff;
+        }
+        reg = half_shuffle32(reg) << 1;
+        hv_gic_set_distributor_reg(offset, reg);
+        offset += 4;
+    }
+}
+
+/* Read a bitmap register group from the kernel VGIC. */
+static void hvf_dist_getbmp(GICv3State *s, hv_gic_distributor_reg_t offset, uint32_t *bmp)
+{
+    uint64_t reg;
+    int irq;
+
+    for_each_dist_irq_reg(irq, s->num_irq, 1) {
+
+        hv_gic_get_distributor_reg(offset, &reg);
+        *gic_bmp_ptr32(bmp, irq) = reg;
+        offset += 4;
+    }
+}
+
+static void hvf_dist_putbmp(GICv3State *s, hv_gic_distributor_reg_t offset,
+                            hv_gic_distributor_reg_t clroffset, uint32_t *bmp)
+{
+    uint32_t reg;
+    int irq;
+
+    for_each_dist_irq_reg(irq, s->num_irq, 1) {
+        /*
+         * If this bitmap is a set/clear register pair, first write to the
+         * clear-reg to clear all bits before using the set-reg to write
+         * the 1 bits.
+         */
+        if (clroffset != 0) {
+            reg = 0;
+            hv_gic_set_distributor_reg(clroffset, reg);
+            clroffset += 4;
+        }
+        reg = *gic_bmp_ptr32(bmp, irq);
+        hv_gic_set_distributor_reg(offset, reg);
+        offset += 4;
+    }
+}
+
+static void hvf_gicv3_check(GICv3State *s)
+{
+    uint64_t reg;
+    uint32_t num_irq;
+
+    /* Sanity checking s->num_irq */
+    hv_gic_get_distributor_reg(HV_GIC_DISTRIBUTOR_REG_GICD_TYPER, &reg);
+    num_irq = ((reg & 0x1f) + 1) * 32;
+
+    if (num_irq < s->num_irq) {
+        error_report("Model requests %u IRQs, but HVF supports max %u",
+                     s->num_irq, num_irq);
+        abort();
+    }
+}
+
+static void hvf_gicv3_put_cpu_el2(CPUState *cpu_state, run_on_cpu_data arg)
+{
+    int num_pri_bits;
+
+    /* Redistributor state */
+    GICv3CPUState *c = arg.host_ptr;
+    hv_vcpu_t vcpu = c->cpu->accel->fd;
+
+    hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_VMCR_EL2, c->ich_vmcr_el2);
+    hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_HCR_EL2, c->ich_hcr_el2);
+
+    for (int i = 0; i < GICV3_LR_MAX; i++) {
+        hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_LR0_EL2, c->ich_lr_el2[i]);
+    }
+
+    num_pri_bits = c->vpribits;
+
+    switch (num_pri_bits) {
+    case 7:
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 3,
+                         c->ich_apr[GICV3_G0][3]);
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 2,
+                         c->ich_apr[GICV3_G0][2]);
+      /* fall through */
+    case 6:
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 1,
+                         c->ich_apr[GICV3_G0][1]);
+      /* fall through */
+    default:
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2,
+                         c->ich_apr[GICV3_G0][0]);
+    }
+
+    switch (num_pri_bits) {
+    case 7:
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 3,
+                         c->ich_apr[GICV3_G1NS][3]);
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 2,
+                         c->ich_apr[GICV3_G1NS][2]);
+      /* fall through */
+    case 6:
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 1,
+                         c->ich_apr[GICV3_G1NS][1]);
+      /* fall through */
+    default:
+      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2,
+                         c->ich_apr[GICV3_G1NS][0]);
+    }
+}
+
+static void hvf_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
+{
+    uint32_t reg;
+    uint64_t reg64;
+    int i, num_pri_bits;
+
+    /* Redistributor state */
+    GICv3CPUState *c = arg.host_ptr;
+    hv_vcpu_t vcpu = c->cpu->accel->fd;
+
+    reg = c->gicr_waker;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
+
+    reg = c->gicr_igroupr0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
+
+    reg = ~0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICENABLER0, reg);
+    reg = c->gicr_ienabler0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISENABLER0, reg);
+
+    /* Restore config before pending so we treat level/edge correctly */
+    reg = half_shuffle32(c->edge_trigger >> 16) << 1;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICFGR1, reg);
+
+    reg = ~0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICPENDR0, reg);
+    reg = c->gicr_ipendr0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISPENDR0, reg);
+
+    reg = ~0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICACTIVER0, reg);
+    reg = c->gicr_iactiver0;
+    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISACTIVER0, reg);
+
+    for (i = 0; i < GIC_INTERNAL; i += 4) {
+        reg = c->gicr_ipriorityr[i] |
+            (c->gicr_ipriorityr[i + 1] << 8) |
+            (c->gicr_ipriorityr[i + 2] << 16) |
+            (c->gicr_ipriorityr[i + 3] << 24);
+        hv_gic_set_redistributor_reg(vcpu,
+            HV_GIC_REDISTRIBUTOR_REG_GICR_IPRIORITYR0 + i, reg);
+    }
+
+    /* CPU interface state */
+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_SRE_EL1, c->icc_sre_el1);
+
+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_CTLR_EL1,
+                    c->icc_ctlr_el1[GICV3_NS]);
+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN0_EL1,
+                    c->icc_igrpen[GICV3_G0]);
+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN1_EL1,
+                    c->icc_igrpen[GICV3_G1NS]);
+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_PMR_EL1, c->icc_pmr_el1);
+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_BPR0_EL1, c->icc_bpr[GICV3_G0]);
+    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_BPR1_EL1, c->icc_bpr[GICV3_G1NS]);
+
+    num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
+                    ICC_CTLR_EL1_PRIBITS_MASK) >>
+                    ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
+
+    switch (num_pri_bits) {
+    case 7:
+           reg64 = c->icc_apr[GICV3_G0][3];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 3, reg64);
+        reg64 = c->icc_apr[GICV3_G0][2];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 2, reg64);
+        /* fall through */
+    case 6:
+        reg64 = c->icc_apr[GICV3_G0][1];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 1, reg64);
+        /* fall through */
+    default:
+        reg64 = c->icc_apr[GICV3_G0][0];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1, reg64);
+    }
+
+    switch (num_pri_bits) {
+    case 7:
+        reg64 = c->icc_apr[GICV3_G1NS][3];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 3, reg64);
+        reg64 = c->icc_apr[GICV3_G1NS][2];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 2, reg64);
+        /* fall through */
+    case 6:
+        reg64 = c->icc_apr[GICV3_G1NS][1];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 1, reg64);
+        /* fall through */
+    default:
+        reg64 = c->icc_apr[GICV3_G1NS][0];
+        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1, reg64);
+    }
+
+    /* Registers beyond this point are with nested virt only */
+    if (c->gic->maint_irq) {
+        hvf_gicv3_put_cpu_el2(cpu_state, arg);
+    }
+}
+
+static void hvf_gicv3_put(GICv3State *s)
+{
+    uint32_t reg;
+    int ncpu, i;
+
+    hvf_gicv3_check(s);
+
+    reg = s->gicd_ctlr;
+    hv_gic_set_distributor_reg(HV_GIC_DISTRIBUTOR_REG_GICD_CTLR, reg);
+
+    /* per-CPU state */
+
+    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        run_on_cpu_data data;
+        data.host_ptr = &s->cpu[ncpu];
+        run_on_cpu(s->cpu[ncpu].cpu, hvf_gicv3_put_cpu, data);
+    }
+
+    /* s->enable bitmap -> GICD_ISENABLERn */
+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISENABLER0
+        , HV_GIC_DISTRIBUTOR_REG_GICD_ICENABLER0, s->enabled);
+
+    /* s->group bitmap -> GICD_IGROUPRn */
+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_IGROUPR0
+        , 0, s->group);
+
+    /* Restore targets before pending to ensure the pending state is set on
+     * the appropriate CPU interfaces in the kernel
+     */
+
+    /* s->gicd_irouter[irq] -> GICD_IROUTERn */
+    for (i = GIC_INTERNAL; i < s->num_irq; i++) {
+        uint32_t offset = HV_GIC_DISTRIBUTOR_REG_GICD_IROUTER32 + (8 * i)
+            - (8 * GIC_INTERNAL);
+        hv_gic_set_distributor_reg(offset, s->gicd_irouter[i]);
+    }
+
+    /*
+     * s->trigger bitmap -> GICD_ICFGRn
+     * (restore configuration registers before pending IRQs so we treat
+     * level/edge correctly)
+     */
+    hvf_dist_put_edge_trigger(s, HV_GIC_DISTRIBUTOR_REG_GICD_ICFGR0, s->edge_trigger);
+
+    /* s->pending bitmap -> GICD_ISPENDRn */
+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0,
+        HV_GIC_DISTRIBUTOR_REG_GICD_ICPENDR0, s->pending);
+
+    /* s->active bitmap -> GICD_ISACTIVERn */
+    hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISACTIVER0,
+        HV_GIC_DISTRIBUTOR_REG_GICD_ICACTIVER0, s->active);
+
+    /* s->gicd_ipriority[] -> GICD_IPRIORITYRn */
+    hvf_dist_put_priority(s, HV_GIC_DISTRIBUTOR_REG_GICD_IPRIORITYR0, s->gicd_ipriority);
+}
+
+static void hvf_gicv3_get_cpu_el2(CPUState *cpu_state, run_on_cpu_data arg)
+{
+    int num_pri_bits;
+
+    /* Redistributor state */
+    GICv3CPUState *c = arg.host_ptr;
+    hv_vcpu_t vcpu = c->cpu->accel->fd;
+
+    hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_VMCR_EL2, &c->ich_vmcr_el2);
+    hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_HCR_EL2, &c->ich_hcr_el2);
+
+    for (int i = 0; i < GICV3_LR_MAX; i++) {
+        hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_LR0_EL2, &c->ich_lr_el2[i]);
+    }
+
+    num_pri_bits = c->vpribits;
+
+    switch (num_pri_bits) {
+    case 7:
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 3,
+                         &c->ich_apr[GICV3_G0][3]);
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 2,
+                         &c->ich_apr[GICV3_G0][2]);
+      /* fall through */
+    case 6:
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 1,
+                         &c->ich_apr[GICV3_G0][1]);
+      /* fall through */
+    default:
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2,
+                         &c->ich_apr[GICV3_G0][0]);
+    }
+
+    switch (num_pri_bits) {
+    case 7:
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 3,
+                         &c->ich_apr[GICV3_G1NS][3]);
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 2,
+                         &c->ich_apr[GICV3_G1NS][2]);
+      /* fall through */
+    case 6:
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 1,
+                         &c->ich_apr[GICV3_G1NS][1]);
+      /* fall through */
+    default:
+      hv_gic_get_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2,
+                         &c->ich_apr[GICV3_G1NS][0]);
+    }
+}
+
+static void hvf_gicv3_get_cpu(CPUState *cpu_state, run_on_cpu_data arg)
+{
+    uint64_t reg;
+    int i, num_pri_bits;
+
+    /* Redistributor state */
+    GICv3CPUState *c = arg.host_ptr;
+    hv_vcpu_t vcpu = c->cpu->accel->fd;
+
+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0,
+                                 &reg);
+    c->gicr_igroupr0 = reg;
+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISENABLER0,
+                                 &reg);
+    c->gicr_ienabler0 = reg;
+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICFGR1,
+                                 &reg);
+    c->edge_trigger = half_unshuffle32(reg >> 1) << 16;
+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISPENDR0,
+                                 &reg);
+    c->gicr_ipendr0 = reg;
+    hv_gic_get_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISACTIVER0,
+                                 &reg);
+    c->gicr_iactiver0 = reg;
+
+    for (i = 0; i < GIC_INTERNAL; i += 4) {
+        hv_gic_get_redistributor_reg(
+          vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IPRIORITYR0 + i, &reg);
+        c->gicr_ipriorityr[i] = extract32(reg, 0, 8);
+        c->gicr_ipriorityr[i + 1] = extract32(reg, 8, 8);
+        c->gicr_ipriorityr[i + 2] = extract32(reg, 16, 8);
+        c->gicr_ipriorityr[i + 3] = extract32(reg, 24, 8);
+    }
+
+    /* CPU interface */
+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_SRE_EL1, &c->icc_sre_el1);
+
+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_CTLR_EL1,
+                       &c->icc_ctlr_el1[GICV3_NS]);
+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN0_EL1,
+                       &c->icc_igrpen[GICV3_G0]);
+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN1_EL1,
+                       &c->icc_igrpen[GICV3_G1NS]);
+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_PMR_EL1, &c->icc_pmr_el1);
+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_BPR0_EL1, &c->icc_bpr[GICV3_G0]);
+    hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_BPR1_EL1, &c->icc_bpr[GICV3_G1NS]);
+    num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] & ICC_CTLR_EL1_PRIBITS_MASK) >>
+                    ICC_CTLR_EL1_PRIBITS_SHIFT) +
+                   1;
+
+    switch (num_pri_bits) {
+    case 7:
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 3,
+                         &c->icc_apr[GICV3_G0][3]);
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 2,
+                         &c->icc_apr[GICV3_G0][2]);
+      /* fall through */
+    case 6:
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 1,
+                         &c->icc_apr[GICV3_G0][1]);
+      /* fall through */
+    default:
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1,
+                         &c->icc_apr[GICV3_G0][0]);
+    }
+
+    switch (num_pri_bits) {
+    case 7:
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 3,
+                         &c->icc_apr[GICV3_G1NS][3]);
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 2,
+                         &c->icc_apr[GICV3_G1NS][2]);
+      /* fall through */
+    case 6:
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 1,
+                         &c->icc_apr[GICV3_G1NS][1]);
+      /* fall through */
+    default:
+      hv_gic_get_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1,
+                         &c->icc_apr[GICV3_G1NS][0]);
+    }
+
+    /* Registers beyond this point are with nested virt only */
+    if (c->gic->maint_irq) {
+        hvf_gicv3_get_cpu_el2(cpu_state, arg);
+    }
+}
+
+static void hvf_gicv3_get(GICv3State *s)
+{
+    uint64_t reg;
+    int ncpu, i;
+
+    hvf_gicv3_check(s);
+
+    hv_gic_get_distributor_reg(HV_GIC_DISTRIBUTOR_REG_GICD_CTLR, &reg);
+    s->gicd_ctlr = reg;
+
+    /* Redistributor state (one per CPU) */
+
+    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        run_on_cpu_data data;
+        data.host_ptr = &s->cpu[ncpu];
+        run_on_cpu(s->cpu[ncpu].cpu, hvf_gicv3_get_cpu, data);
+    }
+
+    /* GICD_IGROUPRn -> s->group bitmap */
+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_IGROUPR0, s->group);
+
+    /* GICD_ISENABLERn -> s->enabled bitmap */
+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISENABLER0, s->enabled);
+
+    /* GICD_ISPENDRn -> s->pending bitmap */
+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0, s->pending);
+
+    /* GICD_ISACTIVERn -> s->active bitmap */
+    hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISACTIVER0, s->active);
+
+    /* GICD_ICFGRn -> s->trigger bitmap */
+    hvf_dist_get_edge_trigger(s, HV_GIC_DISTRIBUTOR_REG_GICD_ICFGR0
+        , s->edge_trigger);
+
+    /* GICD_IPRIORITYRn -> s->gicd_ipriority[] */
+    hvf_dist_get_priority(s, HV_GIC_DISTRIBUTOR_REG_GICD_IPRIORITYR0
+        , s->gicd_ipriority);
+
+    /* GICD_IROUTERn -> s->gicd_irouter[irq] */
+    for (i = GIC_INTERNAL; i < s->num_irq; i++) {
+        uint32_t offset = HV_GIC_DISTRIBUTOR_REG_GICD_IROUTER32
+            + (8 * i) - (8 * GIC_INTERNAL);
+        hv_gic_get_distributor_reg(offset, &s->gicd_irouter[i]);
+    }
+}
+
+static void hvf_gicv3_set_irq(void *opaque, int irq, int level)
+{
+    GICv3State *s = opaque;
+    if (irq > s->num_irq) {
+        return;
+    }
+    hv_gic_set_spi(GIC_INTERNAL + irq, !!level);
+}
+
+static void hvf_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *c;
+
+    c = env->gicv3state;
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
+static void hvf_gicv3_reset_hold(Object *obj, ResetType type)
+{
+    GICv3State *s = ARM_GICV3_COMMON(obj);
+    HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
+
+    if (kgc->parent_phases.hold) {
+        kgc->parent_phases.hold(obj, type);
+    }
+
+    hvf_gicv3_put(s);
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
+      .resetfn = hvf_gicv3_icc_reset,
+    },
+};
+
+static void hvf_gicv3_realize(DeviceState *dev, Error **errp)
+{
+    ERRP_GUARD();
+    GICv3State *s = HVF_GICV3(dev);
+    HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
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
+                   "supported by HVF");
+        error_append_hint(errp, "A maximum of %d VCPUs can be used",
+                          s->redist_region_count[0]);
+        return;
+    }
+
+    gicv3_init_irqs_and_mmio(s, hvf_gicv3_set_irq, NULL);
+
+    for (i = 0; i < s->num_cpu; i++) {
+        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
+
+        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+    }
+
+    if (s->maint_irq && s->maint_irq != HV_GIC_INT_MAINTENANCE) {
+        error_setg(errp, "vGIC maintenance IRQ mismatch with the hardcoded one in HVF.");
+        return;
+    }
+}
+
+static void hvf_gicv3_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
+    HVFARMGICv3Class *kgc = HVF_GICV3_CLASS(klass);
+
+    agcc->pre_save = hvf_gicv3_get;
+    agcc->post_load = hvf_gicv3_put;
+
+    device_class_set_parent_realize(dc, hvf_gicv3_realize,
+                                    &kgc->parent_realize);
+    resettable_class_set_parent_phases(rc, NULL, hvf_gicv3_reset_hold, NULL,
+                                       &kgc->parent_phases);
+}
+
+static const TypeInfo hvf_arm_gicv3_info = {
+    .name = TYPE_HVF_GICV3,
+    .parent = TYPE_ARM_GICV3_COMMON,
+    .instance_size = sizeof(GICv3State),
+    .class_init = hvf_gicv3_class_init,
+    .class_size = sizeof(HVFARMGICv3Class),
+};
+
+static void hvf_gicv3_register_types(void)
+{
+    type_register_static(&hvf_arm_gicv3_info);
+}
+
+type_init(hvf_gicv3_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 96742df090..b7baf8a0f6 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -42,6 +42,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common
 arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files('arm_gicv3_whpx.c'))
+specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index c55cf18120..9adcab0a0c 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -315,6 +315,7 @@ DECLARE_OBJ_CHECKERS(GICv3State, ARMGICv3CommonClass,
 
 /* Types for GICv3 kernel-irqchip */
 #define TYPE_WHPX_GICV3 "whpx-arm-gicv3"
+#define TYPE_HVF_GICV3 "hvf-arm-gicv3"
 
 struct ARMGICv3CommonClass {
     /*< private >*/
-- 
2.50.1 (Apple Git-155)


