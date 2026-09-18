Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C8EC982E0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7XJl-0000Cp-RH; Fri, 18 Sep 2026 08:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqL-0006ts-9w; Fri, 18 Sep 2026 05:25:17 -0400
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqE-0002IG-J4; Fri, 18 Sep 2026 05:25:15 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=I/XWlbU9dLJPE5pSPEJjU6isaIAOGtOn1+56ifWRmvQ=;
 b=BWYCkJdLwQdQkFQQhzcg4v+78AqJqvyvQA9zb4MmYFLR9ZRdNSm219Gy8KoiEqxJ+xnu3u4t6
 sVXNvFl1A5VeJzwVxoACIfpNhzszDvtHRlTE+qduhnNeHma+q9ALYtebUq4a3ZocjBluvOLp4sU
 MeMaYP+QQRY1uaJRguRWNfc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hmRkb6nv7zcb4D;
 Fri, 18 Sep 2026 17:13:43 +0800 (CST)
Received: from dggpemr200003.china.huawei.com (unknown [7.185.36.25])
 by mail.maildlp.com (Postfix) with ESMTPS id 0E37140593;
 Fri, 18 Sep 2026 17:24:59 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemr200003.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 17:24:58 +0800
From: Yize Wang <wangyize7@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <peter.maydell@linaro.org>, <zhengchuan@huawei.com>,
 <jiangjiacheng@huawei.com>, <wangyize7@huawei.com>, <yize_w1110@163.com>
Subject: [PATCH 3/4] hw/intc/arm_gicv3_kvm: Refactor kvm_arm_gicv3_put for
 batch register access
Date: Fri, 18 Sep 2026 17:18:55 +0800
Message-ID: <20260918092120.370805-4-wangyize7@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918092120.370805-1-wangyize7@huawei.com>
References: <20260918092120.370805-1-wangyize7@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr200003.china.huawei.com (7.185.36.25)
Received-SPF: pass client-ip=113.46.200.217; envelope-from=wangyize7@huawei.com;
 helo=canpmsgout02.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2026 08:02:42 -0400
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

Refactor kvm_arm_gicv3_put and add auxiliary functions to implement batch
register access.
Auxiliary functions:
-kvm_arm_gic_batch_write_plpis: batch write to LPI
-kvm_arm_gic_batch_write_redist: batch write to Redistributor
-kvm_arm_gic_batch_write_cpuif: batch write to CPU Interface

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yize Wang <wangyize7@huawei.com>
---
 hw/intc/arm_gicv3_kvm.c | 524 ++++++++++++++++++++++++++++++++--------
 1 file changed, 425 insertions(+), 99 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index ea6c8462c7..1fdc554fe0 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -34,6 +34,7 @@
 #include "migration/misc.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
+#include "exec/cpu-defs.h"
 
 
 #define TYPE_KVM_ARM_GICV3 "kvm-arm-gicv3"
@@ -409,11 +410,298 @@ static void kvm_arm_gicv3_check(GICv3State *s)
     }
 }
 
+/* Write to the LPI base address registers in batches */
+static void kvm_arm_gic_batch_write_plpis(GICv3State *s,
+                                          GICv3BatchEntry **entries,
+                                          uint64_t redist_typer,
+                                          int *batch_n,
+                                          int *batch_capacity)
+{
+    if (!(redist_typer & GICR_TYPER_PLPIS)) {
+        return;
+    }
+
+    /*
+     * Allocate temporary buffers for the LPI base addresses
+     * of all CPUs.
+     */
+    uint32_t *plpis = g_new(uint32_t, s->num_cpu * 4);
+
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int base = ncpu * 4;
+
+        /* Split the 64-bit base address into two 32-bit values. */
+        plpis[base]     = (uint32_t)c->gicr_propbaser;
+        plpis[base + 1] = (uint32_t)(c->gicr_propbaser >> 32);
+        plpis[base + 2] = (uint32_t)c->gicr_pendbaser;
+        plpis[base + 3] = (uint32_t)(c->gicr_pendbaser >> 32);
+
+        /* Add to batch queueing */
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_PROPBASER, c->gicr_typer),
+                              &plpis[base]);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_PROPBASER + 4, c->gicr_typer),
+                              &plpis[base + 1]);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_PENDBASER, c->gicr_typer),
+                              &plpis[base + 2]);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_PENDBASER + 4, c->gicr_typer),
+                              &plpis[base + 3]);
+    }
+
+    /*
+     * Submit the LPI base address immediately.
+     * Note: After submission, the caller is responsible for resetting batch_n
+     * to reuse the entries array.
+     */
+    kvm_arm_gic_batch_commit(s->dev_fd, *entries, *batch_n, true);
+    g_free(plpis);
+}
+
+/* Write to the Redistributor common registers in batches */
+static void kvm_arm_gic_batch_write_redist(GICv3State *s,
+                                           GICv3BatchEntry **entries,
+                                           int *batch_n,
+                                           int *batch_capacity)
+{
+    uint32_t clear_all = ~0;
+    uint32_t *redist_icfgr1 = g_new(uint32_t, s->num_cpu);
+    uint32_t *redist_priority = g_new(uint32_t,
+                    s->num_cpu * (GIC_INTERNAL / 4));
+
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int pri_base = ncpu * (GIC_INTERNAL / 4);
+
+        redist_icfgr1[ncpu] = half_shuffle32(c->edge_trigger >> 16) << 1;
+
+        /* control and status register */
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_CTLR, c->gicr_typer),
+                              &c->gicr_ctlr);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_STATUSR, c->gicr_typer),
+                              &c->gicr_statusr[GICV3_NS]);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_WAKER, c->gicr_typer),
+                              &c->gicr_waker);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_IGROUPR0, c->gicr_typer),
+                              &c->gicr_igroupr0);
+
+        /* Enable register (clear-set mode) */
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ICENABLER0, c->gicr_typer),
+                              &clear_all);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ISENABLER0, c->gicr_typer),
+                              &c->gicr_ienabler0);
+
+        /* Configure register */
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ICFGR1, c->gicr_typer),
+                              &redist_icfgr1[ncpu]);
+
+        /* Level information */
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO,
+                              KVM_VGIC_ATTR(0, c->gicr_typer) |
+                              (VGIC_LEVEL_INFO_LINE_LEVEL <<
+                               KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT),
+                              &c->level);
+
+        /* Suspend register (Clear-Set mode) */
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ICPENDR0, c->gicr_typer),
+                              &clear_all);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ISPENDR0, c->gicr_typer),
+                              &c->gicr_ipendr0);
+
+        /* Activation register (Clear-Set mode) */
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ICACTIVER0, c->gicr_typer),
+                              &clear_all);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ISACTIVER0, c->gicr_typer),
+                              &c->gicr_iactiver0);
+
+        /* Priority register (written in packet mode) */
+        for (int i = 0; i < GIC_INTERNAL; i += 4) {
+            redist_priority[pri_base + i / 4] =
+                c->gicr_ipriorityr[i] |
+                (c->gicr_ipriorityr[i + 1] << 8) |
+                (c->gicr_ipriorityr[i + 2] << 16) |
+                (c->gicr_ipriorityr[i + 3] << 24);
+
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                                  KVM_VGIC_ATTR(GICR_IPRIORITYR + i,
+                                                c->gicr_typer),
+                                  &redist_priority[pri_base + i / 4]);
+        }
+    }
+
+    /* Submit all Redistributor statuses */
+    kvm_arm_gic_batch_commit(s->dev_fd, *entries, *batch_n, true);
+
+    g_free(redist_icfgr1);
+    g_free(redist_priority);
+}
+
+/* Batch Write to CPU Interface */
+static void kvm_arm_gic_batch_write_cpuif(GICv3State *s,
+                                          GICv3BatchEntry **entries,
+                                          int *batch_n,
+                                          int *batch_capacity)
+{
+    uint32_t *cpuif_sre = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_ctlr = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_igrpen0 = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_igrpen1 = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_pmr = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_bpr0 = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_bpr1 = g_new0(uint32_t, s->num_cpu);
+
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int num_pri_bits;
+
+        /* Basic system registers */
+        cpuif_sre[ncpu] = c->icc_sre_el1;
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_SRE_EL1, c->gicr_typer),
+                              &cpuif_sre[ncpu]);
+
+        cpuif_ctlr[ncpu] = c->icc_ctlr_el1[GICV3_NS];
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
+                              &cpuif_ctlr[ncpu]);
+
+        cpuif_igrpen0[ncpu] = c->icc_igrpen[GICV3_G0];
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_IGRPEN0_EL1, c->gicr_typer),
+                              &cpuif_igrpen0[ncpu]);
+
+        cpuif_igrpen1[ncpu] = c->icc_igrpen[GICV3_G1NS];
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_IGRPEN1_EL1, c->gicr_typer),
+                              &cpuif_igrpen1[ncpu]);
+
+        cpuif_pmr[ncpu] = c->icc_pmr_el1;
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_PMR_EL1, c->gicr_typer),
+                              &cpuif_pmr[ncpu]);
+
+        cpuif_bpr0[ncpu] = c->icc_bpr[GICV3_G0];
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_BPR0_EL1, c->gicr_typer),
+                              &cpuif_bpr0[ncpu]);
+
+        cpuif_bpr1[ncpu] = c->icc_bpr[GICV3_G1NS];
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                              KVM_VGIC_ATTR(ICC_BPR1_EL1, c->gicr_typer),
+                              &cpuif_bpr1[ncpu]);
+
+        /* Calculate the number of priority bits */
+        num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
+                        ICC_CTLR_EL1_PRIBITS_MASK) >>
+                        ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
+
+        /* Group 0 APR */
+        switch (num_pri_bits) {
+        case 7:
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP0R_EL1(3), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G0][3]);
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP0R_EL1(2), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G0][2]);
+            /* fall through */
+        case 6:
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP0R_EL1(1), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G0][1]);
+            /* fall through */
+        default:
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP0R_EL1(0), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G0][0]);
+        }
+
+        /* Group 1 APR */
+        switch (num_pri_bits) {
+        case 7:
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP1R_EL1(3), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G1NS][3]);
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP1R_EL1(2), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G1NS][2]);
+            /* fall through */
+        case 6:
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP1R_EL1(1), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G1NS][1]);
+            /* fall through */
+        default:
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
+                                  KVM_VGIC_ATTR(ICC_AP1R_EL1(0), c->gicr_typer),
+                                  (uint32_t *)&c->icc_apr[GICV3_G1NS][0]);
+        }
+    }
+
+    /* Submit all CPU Interface statuses */
+    kvm_arm_gic_batch_commit(s->dev_fd, *entries, *batch_n, true);
+
+    g_free(cpuif_sre);
+    g_free(cpuif_ctlr);
+    g_free(cpuif_igrpen0);
+    g_free(cpuif_igrpen1);
+    g_free(cpuif_pmr);
+    g_free(cpuif_bpr0);
+    g_free(cpuif_bpr1);
+}
+
 static void kvm_arm_gicv3_put(GICv3State *s)
 {
     uint32_t regl, regh, reg;
     uint64_t reg64, redist_typer;
     int ncpu, i;
+    bool batch_supported;
     int64_t start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
     kvm_arm_gicv3_check(s);
@@ -425,71 +713,95 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     reg = s->gicd_ctlr;
     kvm_gicd_access(s, GICD_CTLR, &reg, true);
 
-    if (redist_typer & GICR_TYPER_PLPIS) {
-        /*
-         * Restore base addresses before LPIs are potentially enabled by
-         * GICR_CTLR write
-         */
-        for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
-            GICv3CPUState *c = &s->cpu[ncpu];
+    batch_supported = kvm_arm_gic_batch_supported(s->dev_fd);
+
+    if (batch_supported) {
+        {
+            GICv3BatchEntry *entries = g_new(GICv3BatchEntry, 256);
+            int batch_n = 0;
+            int batch_capacity = 256;
+
+            /* write LPI */
+            kvm_arm_gic_batch_write_plpis(s, &entries, redist_typer,
+                                          &batch_n, &batch_capacity);
+
+            /* reset batch_n */
+            batch_n = 0;
+
+            /* write Redistributor status */
+            kvm_arm_gic_batch_write_redist(s, &entries, &batch_n,
+                                           &batch_capacity);
 
-            reg64 = c->gicr_propbaser;
-            regl = (uint32_t)reg64;
-            kvm_gicr_access(s, GICR_PROPBASER, ncpu, &regl, true);
-            regh = (uint32_t)(reg64 >> 32);
-            kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
-
-            reg64 = c->gicr_pendbaser;
-            regl = (uint32_t)reg64;
-            kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, true);
-            regh = (uint32_t)(reg64 >> 32);
-            kvm_gicr_access(s, GICR_PENDBASER + 4, ncpu, &regh, true);
+            g_free(entries);
+        }
+    } else {
+        if (redist_typer & GICR_TYPER_PLPIS) {
+            /*
+             * Restore base addresses before LPIs are potentially enabled by
+             * GICR_CTLR write
+             */
+            for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+                GICv3CPUState *c = &s->cpu[ncpu];
+
+                reg64 = c->gicr_propbaser;
+                regl = (uint32_t)reg64;
+                kvm_gicr_access(s, GICR_PROPBASER, ncpu, &regl, true);
+                regh = (uint32_t)(reg64 >> 32);
+                kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
+
+                reg64 = c->gicr_pendbaser;
+                regl = (uint32_t)reg64;
+                kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, true);
+                regh = (uint32_t)(reg64 >> 32);
+                kvm_gicr_access(s, GICR_PENDBASER + 4, ncpu, &regh, true);
+            }
         }
-    }
 
-    /* Redistributor state (one per CPU) */
+        /* Redistributor state (one per CPU) */
 
-    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
-        GICv3CPUState *c = &s->cpu[ncpu];
+        for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+            GICv3CPUState *c = &s->cpu[ncpu];
+            uint32_t clear_all = ~0;
 
-        reg = c->gicr_ctlr;
-        kvm_gicr_access(s, GICR_CTLR, ncpu, &reg, true);
+            reg = c->gicr_ctlr;
+            kvm_gicr_access(s, GICR_CTLR, ncpu, &reg, true);
 
-        reg = c->gicr_statusr[GICV3_NS];
-        kvm_gicr_access(s, GICR_STATUSR, ncpu, &reg, true);
+            reg = c->gicr_statusr[GICV3_NS];
+            kvm_gicr_access(s, GICR_STATUSR, ncpu, &reg, true);
 
-        reg = c->gicr_waker;
-        kvm_gicr_access(s, GICR_WAKER, ncpu, &reg, true);
+            reg = c->gicr_waker;
+            kvm_gicr_access(s, GICR_WAKER, ncpu, &reg, true);
 
-        reg = c->gicr_igroupr0;
-        kvm_gicr_access(s, GICR_IGROUPR0, ncpu, &reg, true);
+            reg = c->gicr_igroupr0;
+            kvm_gicr_access(s, GICR_IGROUPR0, ncpu, &reg, true);
 
-        reg = ~0;
-        kvm_gicr_access(s, GICR_ICENABLER0, ncpu, &reg, true);
-        reg = c->gicr_ienabler0;
-        kvm_gicr_access(s, GICR_ISENABLER0, ncpu, &reg, true);
+            reg = clear_all;
+            kvm_gicr_access(s, GICR_ICENABLER0, ncpu, &reg, true);
+            reg = c->gicr_ienabler0;
+            kvm_gicr_access(s, GICR_ISENABLER0, ncpu, &reg, true);
 
-        /* Restore config before pending so we treat level/edge correctly */
-        reg = half_shuffle32(c->edge_trigger >> 16) << 1;
-        kvm_gicr_access(s, GICR_ICFGR1, ncpu, &reg, true);
+            /* Restore config before pending so we treat level/edge correctly */
+            reg = half_shuffle32(c->edge_trigger >> 16) << 1;
+            kvm_gicr_access(s, GICR_ICFGR1, ncpu, &reg, true);
 
-        reg = c->level;
-        kvm_gic_line_level_access(s, 0, ncpu, &reg, true);
+            reg = c->level;
+            kvm_gic_line_level_access(s, 0, ncpu, &reg, true);
 
-        reg = c->gicr_ipendr0;
-        kvm_gicr_access(s, GICR_ISPENDR0, ncpu, &reg, true);
+            reg = c->gicr_ipendr0;
+            kvm_gicr_access(s, GICR_ISPENDR0, ncpu, &reg, true);
 
-        reg = ~0;
-        kvm_gicr_access(s, GICR_ICACTIVER0, ncpu, &reg, true);
-        reg = c->gicr_iactiver0;
-        kvm_gicr_access(s, GICR_ISACTIVER0, ncpu, &reg, true);
+            reg = clear_all;
+            kvm_gicr_access(s, GICR_ICACTIVER0, ncpu, &reg, true);
+            reg = c->gicr_iactiver0;
+            kvm_gicr_access(s, GICR_ISACTIVER0, ncpu, &reg, true);
 
-        for (i = 0; i < GIC_INTERNAL; i += 4) {
-            reg = c->gicr_ipriorityr[i] |
-                (c->gicr_ipriorityr[i + 1] << 8) |
-                (c->gicr_ipriorityr[i + 2] << 16) |
-                (c->gicr_ipriorityr[i + 3] << 24);
-            kvm_gicr_access(s, GICR_IPRIORITYR + i, ncpu, &reg, true);
+            for (i = 0; i < GIC_INTERNAL; i += 4) {
+                reg = c->gicr_ipriorityr[i] |
+                    (c->gicr_ipriorityr[i + 1] << 8) |
+                    (c->gicr_ipriorityr[i + 2] << 16) |
+                    (c->gicr_ipriorityr[i + 3] << 24);
+                kvm_gicr_access(s, GICR_IPRIORITYR + i, ncpu, &reg, true);
+            }
         }
     }
 
@@ -540,57 +852,71 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     /* s->gicd_ipriority[] -> GICD_IPRIORITYRn */
     kvm_dist_put_priority(s, GICD_IPRIORITYR, s->gicd_ipriority);
 
-    /* CPU Interface state (one per CPU) */
-
-    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
-        GICv3CPUState *c = &s->cpu[ncpu];
-        int num_pri_bits;
+    /* write CPU Interface status */
+    if (batch_supported) {
+        {
+            GICv3BatchEntry *entries = g_new(GICv3BatchEntry, 256);
+            int batch_n = 0;
+            int batch_capacity = 256;
 
-        kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
-        kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
-                        &c->icc_ctlr_el1[GICV3_NS], true);
-        kvm_gicc_access(s, ICC_IGRPEN0_EL1, ncpu,
-                        &c->icc_igrpen[GICV3_G0], true);
-        kvm_gicc_access(s, ICC_IGRPEN1_EL1, ncpu,
-                        &c->icc_igrpen[GICV3_G1NS], true);
-        kvm_gicc_access(s, ICC_PMR_EL1, ncpu, &c->icc_pmr_el1, true);
-        kvm_gicc_access(s, ICC_BPR0_EL1, ncpu, &c->icc_bpr[GICV3_G0], true);
-        kvm_gicc_access(s, ICC_BPR1_EL1, ncpu, &c->icc_bpr[GICV3_G1NS], true);
+            kvm_arm_gic_batch_write_cpuif(s, &entries, &batch_n,
+                                          &batch_capacity);
 
-        num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
-                        ICC_CTLR_EL1_PRIBITS_MASK) >>
-                        ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
-
-        switch (num_pri_bits) {
-        case 7:
-            reg64 = c->icc_apr[GICV3_G0][3];
-            kvm_gicc_access(s, ICC_AP0R_EL1(3), ncpu, &reg64, true);
-            reg64 = c->icc_apr[GICV3_G0][2];
-            kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, true);
-            /* fall through */
-        case 6:
-            reg64 = c->icc_apr[GICV3_G0][1];
-            kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, true);
-            /* fall through */
-        default:
-            reg64 = c->icc_apr[GICV3_G0][0];
-            kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, true);
+            g_free(entries);
         }
-
-        switch (num_pri_bits) {
-        case 7:
-            reg64 = c->icc_apr[GICV3_G1NS][3];
-            kvm_gicc_access(s, ICC_AP1R_EL1(3), ncpu, &reg64, true);
-            reg64 = c->icc_apr[GICV3_G1NS][2];
-            kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, true);
-            /* fall through */
-        case 6:
-            reg64 = c->icc_apr[GICV3_G1NS][1];
-            kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, true);
-            /* fall through */
-        default:
-            reg64 = c->icc_apr[GICV3_G1NS][0];
-            kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, true);
+    } else {
+        /* CPU Interface state (one per CPU) */
+        for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+            GICv3CPUState *c = &s->cpu[ncpu];
+            int num_pri_bits;
+
+            kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
+            kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
+                            &c->icc_ctlr_el1[GICV3_NS], true);
+            kvm_gicc_access(s, ICC_IGRPEN0_EL1, ncpu,
+                            &c->icc_igrpen[GICV3_G0], true);
+            kvm_gicc_access(s, ICC_IGRPEN1_EL1, ncpu,
+                            &c->icc_igrpen[GICV3_G1NS], true);
+            kvm_gicc_access(s, ICC_PMR_EL1, ncpu, &c->icc_pmr_el1, true);
+            kvm_gicc_access(s, ICC_BPR0_EL1, ncpu, &c->icc_bpr[GICV3_G0], true);
+            kvm_gicc_access(s, ICC_BPR1_EL1, ncpu, &c->icc_bpr[GICV3_G1NS],
+                            true);
+
+            num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
+                            ICC_CTLR_EL1_PRIBITS_MASK) >>
+                            ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
+
+            switch (num_pri_bits) {
+            case 7:
+                reg64 = c->icc_apr[GICV3_G0][3];
+                kvm_gicc_access(s, ICC_AP0R_EL1(3), ncpu, &reg64, true);
+                reg64 = c->icc_apr[GICV3_G0][2];
+                kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, true);
+                /* fall through */
+            case 6:
+                reg64 = c->icc_apr[GICV3_G0][1];
+                kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, true);
+                /* fall through */
+            default:
+                reg64 = c->icc_apr[GICV3_G0][0];
+                kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, true);
+            }
+
+            switch (num_pri_bits) {
+            case 7:
+                reg64 = c->icc_apr[GICV3_G1NS][3];
+                kvm_gicc_access(s, ICC_AP1R_EL1(3), ncpu, &reg64, true);
+                reg64 = c->icc_apr[GICV3_G1NS][2];
+                kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, true);
+                /* fall through */
+            case 6:
+                reg64 = c->icc_apr[GICV3_G1NS][1];
+                kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, true);
+                /* fall through */
+            default:
+                reg64 = c->icc_apr[GICV3_G1NS][0];
+                kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, true);
+            }
         }
     }
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-- 
2.43.0


