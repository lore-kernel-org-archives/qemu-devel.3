Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7806D3CCAE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 04:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgFK5-0004YO-CG; Wed, 14 Jan 2026 23:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFJx-0004Xw-Qs
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:50:59 -0500
Received: from p-west3-cluster2-host9-snip4-10.eps.apple.com ([57.103.74.13]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgFJu-00061K-0v
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 23:50:56 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id
 7488A18007C3; Thu, 15 Jan 2026 04:50:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jrhZicJ7Vwi+Dzo43etHkFmonAGBEFihKllJcaDx3E8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GXHSP0c/OHTRySGZ12T0FfszJvPo9woSPKoq4fqEjFIoPER3Ej77Xu8mAnndFnGz46cl1Sbgf/6TvBJhiuaOFkAbOHDCgA6plWncgi4WGxRZn8mS8fbMq3oJSzW5YdgDP2kPYP/wYx605oMXDrvFI15xMRlu7QmJfnO+9KMG/ijhxGkk4av7twRPh6owkXcOAAw8WWXQ8LHmr2e9y8gtqqkWa9XPW2mmst+HpKz7J/BMGqo7NDuDNWQkecVZ5Rr+MNHJy8+t2EBRYMlcbl/XD4ddE+z+cBnZcy8tD0ZuLzJN34RfEXaU+h+FRU/GMmigp+1goS3Yq1xjaL3NFFklOQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id
 CA097180010D; Thu, 15 Jan 2026 04:50:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v7 01/10] hw/intc: Add hvf vGIC interrupt controller support
Date: Thu, 15 Jan 2026 05:50:33 +0100
Message-ID: <20260115045042.70086-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115045042.70086-1-mohamed@unpredictable.fr>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=QeZrf8bv c=1 sm=1 tr=0 ts=6968722b
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=D2JAlcJVxmvnjXxMMLIA:9
X-Proofpoint-GUID: wIU2gXAQeStr9vjQ5X7qa-J2qm2WLvHK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAyOSBTYWx0ZWRfXy9h7MUAcWcms
 wphg0l2VzzuBrDR5+3foBpWMu0a1BKHiOHt7RjsDEDftXE93/pM2hiYCS1Xn90EZAQahUvlM1vT
 xodB+C4Spc2SHns8smK90C3WTBUg9d3a8knVfyhQ9AO66dCHj4XuymYIr0r5vh6YP40E0sdwAxR
 vw2fvzeFWkrR7jCog1ntFQgrcxcSe01FIOe6ljduI4Hj+SsYN/hlB6SVAbgyZvqfhjG1/UKzTQ+
 VHlHvzK/aYN7vnZjAfxrP7lmswi8FXYP0ZLW2L5HmhcMvuSdwfojAAhC5g++TZ17jgHOMewXLmd
 BbR0716q+mR3gYwYMZp
X-Proofpoint-ORIG-GUID: wIU2gXAQeStr9vjQ5X7qa-J2qm2WLvHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1030 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601150029
X-JNJ: AAAAAAABbVZZePUSnJp4hAnXnws3XxFCmmf/Y77jdXpvgN9nXc/r9AmGyJUZ9q8JjmJaktCFBZtlBip6HkDdEW7fBIlbzOStTWYuLwn3frdSbNBMsPoQ6p7Rdlw0ybKRemK/+pFNavTcRS+8OmzI3qKXNdxUZsDt5jq5rt7e7Rql/JyOEbMoNlx4zR/wwm+eKtqfco+DxcjOCJTV7yPJw6I762osiu0XbT6Y2UWoKK3+5CEqfzxgQOVqOm6qkKqpMgmnPMCRsG5mBIE7FpavAfbMQVhKqDFxOJCLKiV3doB1bQ/AdKVRAZ4ixIiDLuGBuOApduYjhFSAXHOYo7/dCUu94HacJBcghrh70BCil1FwAde98yBsCfvoajBZ+otiOjn+gj05ymMvYE296GVE7FPbjuYA1v6IZ/3ZvTntNmGT0tWJ0tevUDMq/xbIbs3jo8+WrtaCiMvV1H2jrYjXlYTMtz5czGg1Tqpyt3PaZP2+ESDZkgFR5mZGa+Vd1EobIPWlHUTKjag73JfIJL2xKLYXQuWGnsxCTTexYfZcFo7VGjW+Bly9dxvROnAWr9Qe0/Egm4n0euHBf3gj0bdVdkfXykX4RM3nDYI1jiWWG3IB6RLzo++4fhUp8WLnmpUCvC372aGxo3fOjiMeDM4HcWWaHz57vT7+amHYwib/PPTaQ42wN1bN/pNTIXVY/fqfSFIpaoMsObaZ9XYsmGj7bhHtcGoTJKlPuF16TZSv
Received-SPF: pass client-ip=57.103.74.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This opens up the door to nested virtualisation support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv3_hvf.c            | 743 +++++++++++++++++++++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 3 files changed, 745 insertions(+)
 create mode 100644 hw/intc/arm_gicv3_hvf.c

diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
new file mode 100644
index 0000000000..fc390e6a9d
--- /dev/null
+++ b/hw/intc/arm_gicv3_hvf.c
@@ -0,0 +1,743 @@
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
+    GICv3State *s;
+    GICv3CPUState *c;
+
+    c = env->gicv3state;
+    s = c->gic;
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
+
+    if (s->migration_blocker) {
+        return;
+    }
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
+    GICv3State *s = HVF_GICV3(dev);
+    HVFARMGICv3Class *kgc = HVF_GICV3_GET_CLASS(s);
+    Error *local_err = NULL;
+    int i;
+
+    kgc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
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


