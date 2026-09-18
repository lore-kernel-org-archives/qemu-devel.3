Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF505C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7XKB-0000Qq-3O; Fri, 18 Sep 2026 08:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqL-0006tr-9O; Fri, 18 Sep 2026 05:25:17 -0400
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyize7@huawei.com>)
 id 1x7UqE-0002IE-Ik; Fri, 18 Sep 2026 05:25:15 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oiMc5094IuzNP38KU2sYyZD8Az71EFWawwwkB2DwgYQ=;
 b=DZiCYfOrhjNQtsaH+HW+92ZqCJdDAViY+rvOKTXEQ2CKTfpt2wkgfQ1QdPjpsNTlCiqa05cjJ
 if0dsd1v6Fkz6aGYpHw5TvWRAqcW1NDgNzXZuIMp8CNmBlz+4i8f2pQsJuXGXKHiOgoBeON0ZDQ
 yDtklMs47L1+3rH5hU02YH0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hmRjy5SnPzpStW;
 Fri, 18 Sep 2026 17:13:10 +0800 (CST)
Received: from dggpemr200003.china.huawei.com (unknown [7.185.36.25])
 by mail.maildlp.com (Postfix) with ESMTPS id D6DB340537;
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
Subject: [PATCH 4/4] hw/intc/arm_gicv3_kvm: Refactor kvm_arm_gicv3_get for
 batch register access
Date: Fri, 18 Sep 2026 17:18:56 +0800
Message-ID: <20260918092120.370805-5-wangyize7@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918092120.370805-1-wangyize7@huawei.com>
References: <20260918092120.370805-1-wangyize7@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemr200003.china.huawei.com (7.185.36.25)
Received-SPF: pass client-ip=113.46.200.218; envelope-from=wangyize7@huawei.com;
 helo=canpmsgout03.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2026 08:02:37 -0400
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

Replace the kvm_arm_gicv3_get function with a batched implementation that
uses the batch helpers added in Task 4.
The new function:
1. Detects batch support using kvm_arm_gic_batch_supported()
2. When batch is supported:
   - Batches redistributor register accesses for all vCPUs and commits
     after the loop, with post-processing for ICFGR1 transformation
     and IPRIORITYR byte splitting
   - Batches PLPIS propbaser/pendbaser accesses when applicable
   - Batches CPU interface basic registers for all enabled vCPUs
   - Batches CPU interface APR registers based on num_pri_bits
3. Falls back to existing per-register ioctl calls when batch is not
   supported
4. Keeps all distributor accesses unchanged

Also add auxiliary functions to implement batch operations:
-kvm_arm_gic_batch_get_redist: read Redistributor common registers
 in batches
-kvm_arm_gic_batch_get_plpis: read the LPI base address registers
 in batches
-kvm_arm_gic_batch_get_cpuif_basic: read the CPU interface basic registers
 in batches
-kvm_arm_gic_batch_get_cpuif_apr: read the CPU Interface APR Registers
 in batches

This reduces the number of KVM device attribute ioctls from
O(num_cpu * registers_per_cpu) to a small constant number of batch commits.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yize Wang <wangyize7@huawei.com>
---
 hw/intc/arm_gicv3_kvm.c | 500 +++++++++++++++++++++++++++++++++-------
 1 file changed, 412 insertions(+), 88 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 1fdc554fe0..16f851b0ae 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -923,11 +923,293 @@ static void kvm_arm_gicv3_put(GICv3State *s)
     info_report("kvm_arm_gicv3_put, time=%ldms", end_time - start_time);
 }
 
+/* Read Redistributor common registers in batches */
+static void kvm_arm_gic_batch_get_redist(GICv3State *s,
+                                         GICv3BatchEntry **entries,
+                                         int *batch_n,
+                                         int *batch_capacity)
+{
+    uint32_t *redist_priority = g_new(uint32_t,
+                                      s->num_cpu * (GIC_INTERNAL / 4));
+
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int pri_base = ncpu * (GIC_INTERNAL / 4);
+
+        /* Redistributor state (one per CPU) */
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
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ISENABLER0, c->gicr_typer),
+                              &c->gicr_ienabler0);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ICFGR1, c->gicr_typer),
+                              &c->edge_trigger);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO,
+                              KVM_VGIC_ATTR(0, c->gicr_typer) |
+                              (VGIC_LEVEL_INFO_LINE_LEVEL <<
+                               KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT),
+                              &c->level);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ISPENDR0, c->gicr_typer),
+                              &c->gicr_ipendr0);
+        kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                              KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                              KVM_VGIC_ATTR(GICR_ISACTIVER0, c->gicr_typer),
+                              &c->gicr_iactiver0);
+
+        for (int i = 0; i < GIC_INTERNAL; i += 4) {
+            kvm_arm_gic_batch_add(entries, batch_n, batch_capacity,
+                                  KVM_DEV_ARM_VGIC_GRP_REDIST_REGS,
+                                  KVM_VGIC_ATTR(GICR_IPRIORITYR + i,
+                                                c->gicr_typer),
+                                  &redist_priority[pri_base + i / 4]);
+        }
+    }
+    kvm_arm_gic_batch_commit(s->dev_fd, *entries, *batch_n, false);
+
+    /* Post-process redistributor results */
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int pri_base = ncpu * (GIC_INTERNAL / 4);
+
+        c->edge_trigger = half_unshuffle32(c->edge_trigger >> 1) << 16;
+
+        for (int i = 0; i < GIC_INTERNAL; i += 4) {
+            uint32_t val = redist_priority[pri_base + i / 4];
+            c->gicr_ipriorityr[i] = extract32(val, 0, 8);
+            c->gicr_ipriorityr[i + 1] = extract32(val, 8, 8);
+            c->gicr_ipriorityr[i + 2] = extract32(val, 16, 8);
+            c->gicr_ipriorityr[i + 3] = extract32(val, 24, 8);
+        }
+    }
+
+    g_free(redist_priority);
+}
+
+/* Read the LPI base address registers in batches */
+static void kvm_arm_gic_batch_get_plpis(GICv3State *s,
+                                        GICv3BatchEntry **entries,
+                                        uint64_t redist_typer,
+                                        int *batch_n,
+                                        int *batch_capacity)
+{
+    if (!(redist_typer & GICR_TYPER_PLPIS)) {
+        return;
+    }
+
+    uint32_t *plpis = g_new(uint32_t, s->num_cpu * 4);
+
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int base = ncpu * 4;
+
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
+    kvm_arm_gic_batch_commit(s->dev_fd, *entries, *batch_n, false);
+
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int base = ncpu * 4;
+
+        c->gicr_propbaser = ((uint64_t)plpis[base + 1] << 32) | plpis[base];
+        c->gicr_pendbaser = ((uint64_t)plpis[base + 3] << 32) | plpis[base + 2];
+    }
+
+    g_free(plpis);
+}
+
+/* Read the CPU interface basic registers in batches */
+static void kvm_arm_gic_batch_get_cpuif_basic(GICv3State *s,
+                                              GICv3BatchEntry **entries,
+                                              int *batch_n,
+                                              int *batch_capacity)
+{
+    uint32_t *cpuif_sre = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_ctlr = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_igrpen0 = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_igrpen1 = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_pmr = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_bpr0 = g_new0(uint32_t, s->num_cpu);
+    uint32_t *cpuif_bpr1 = g_new0(uint32_t, s->num_cpu);
+
+    /* CPU Interface - basic registers */
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+
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
+    }
+    kvm_arm_gic_batch_commit(s->dev_fd, *entries, *batch_n, false);
+
+    /* Copy back basic CPU interface registers */
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+
+        c->icc_sre_el1 = cpuif_sre[ncpu];
+        c->icc_ctlr_el1[GICV3_NS] = cpuif_ctlr[ncpu];
+        c->icc_igrpen[GICV3_G0] = cpuif_igrpen0[ncpu];
+        c->icc_igrpen[GICV3_G1NS] = cpuif_igrpen1[ncpu];
+        c->icc_pmr_el1 = cpuif_pmr[ncpu];
+        c->icc_bpr[GICV3_G0] = cpuif_bpr0[ncpu];
+        c->icc_bpr[GICV3_G1NS] = cpuif_bpr1[ncpu];
+    }
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
+/* Read the CPU Interface APR Registers in Batches */
+static void kvm_arm_gic_batch_get_cpuif_apr(GICv3State *s,
+                                            GICv3BatchEntry **entries,
+                                            int *batch_n,
+                                            int *batch_capacity)
+{
+    for (int ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+        GICv3CPUState *c = &s->cpu[ncpu];
+        int num_pri_bits;
+
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
+    kvm_arm_gic_batch_commit(s->dev_fd, *entries, *batch_n, false);
+}
+
 static void kvm_arm_gicv3_get(GICv3State *s)
 {
     uint32_t regl, regh, reg;
     uint64_t reg64, redist_typer;
     int ncpu, i;
+    bool batch_supported;
     int64_t start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
     kvm_arm_gicv3_check(s);
@@ -939,58 +1221,80 @@ static void kvm_arm_gicv3_get(GICv3State *s)
     kvm_gicd_access(s, GICD_CTLR, &reg, false);
     s->gicd_ctlr = reg;
 
-    /* Redistributor state (one per CPU) */
+    /* Check whether the kernel supports batch operations */
+    batch_supported = kvm_arm_gic_batch_supported(s->dev_fd);
 
-    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
-        GICv3CPUState *c = &s->cpu[ncpu];
+    if (batch_supported) {
+        {
+            GICv3BatchEntry *entries = g_new(GICv3BatchEntry, 256);
+            int batch_n = 0;
+            int batch_capacity = 256;
 
-        kvm_gicr_access(s, GICR_CTLR, ncpu, &reg, false);
-        c->gicr_ctlr = reg;
-
-        kvm_gicr_access(s, GICR_STATUSR, ncpu, &reg, false);
-        c->gicr_statusr[GICV3_NS] = reg;
-
-        kvm_gicr_access(s, GICR_WAKER, ncpu, &reg, false);
-        c->gicr_waker = reg;
-
-        kvm_gicr_access(s, GICR_IGROUPR0, ncpu, &reg, false);
-        c->gicr_igroupr0 = reg;
-        kvm_gicr_access(s, GICR_ISENABLER0, ncpu, &reg, false);
-        c->gicr_ienabler0 = reg;
-        kvm_gicr_access(s, GICR_ICFGR1, ncpu, &reg, false);
-        c->edge_trigger = half_unshuffle32(reg >> 1) << 16;
-        kvm_gic_line_level_access(s, 0, ncpu, &reg, false);
-        c->level = reg;
-        kvm_gicr_access(s, GICR_ISPENDR0, ncpu, &reg, false);
-        c->gicr_ipendr0 = reg;
-        kvm_gicr_access(s, GICR_ISACTIVER0, ncpu, &reg, false);
-        c->gicr_iactiver0 = reg;
-
-        for (i = 0; i < GIC_INTERNAL; i += 4) {
-            kvm_gicr_access(s, GICR_IPRIORITYR + i, ncpu, &reg, false);
-            c->gicr_ipriorityr[i] = extract32(reg, 0, 8);
-            c->gicr_ipriorityr[i + 1] = extract32(reg, 8, 8);
-            c->gicr_ipriorityr[i + 2] = extract32(reg, 16, 8);
-            c->gicr_ipriorityr[i + 3] = extract32(reg, 24, 8);
-        }
-    }
+            /* Redistributor state (one per CPU) */
+            kvm_arm_gic_batch_get_redist(s, &entries, &batch_n,
+                                         &batch_capacity);
+
+            /* reset batch_n */
+            batch_n = 0;
+
+            /* PLPIS */
+            kvm_arm_gic_batch_get_plpis(s, &entries, redist_typer,
+                                        &batch_n, &batch_capacity);
 
-    if (redist_typer & GICR_TYPER_PLPIS) {
+            g_free(entries);
+        }
+    } else {
+        /* Redistributor state (one per CPU) */
         for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
             GICv3CPUState *c = &s->cpu[ncpu];
 
-            kvm_gicr_access(s, GICR_PROPBASER, ncpu, &regl, false);
-            kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, false);
-            c->gicr_propbaser = ((uint64_t)regh << 32) | regl;
+            kvm_gicr_access(s, GICR_CTLR, ncpu, &reg, false);
+            c->gicr_ctlr = reg;
+
+            kvm_gicr_access(s, GICR_STATUSR, ncpu, &reg, false);
+            c->gicr_statusr[GICV3_NS] = reg;
+
+            kvm_gicr_access(s, GICR_WAKER, ncpu, &reg, false);
+            c->gicr_waker = reg;
+
+            kvm_gicr_access(s, GICR_IGROUPR0, ncpu, &reg, false);
+            c->gicr_igroupr0 = reg;
+            kvm_gicr_access(s, GICR_ISENABLER0, ncpu, &reg, false);
+            c->gicr_ienabler0 = reg;
+            kvm_gicr_access(s, GICR_ICFGR1, ncpu, &reg, false);
+            c->edge_trigger = half_unshuffle32(reg >> 1) << 16;
+            kvm_gic_line_level_access(s, 0, ncpu, &reg, false);
+            c->level = reg;
+            kvm_gicr_access(s, GICR_ISPENDR0, ncpu, &reg, false);
+            c->gicr_ipendr0 = reg;
+            kvm_gicr_access(s, GICR_ISACTIVER0, ncpu, &reg, false);
+            c->gicr_iactiver0 = reg;
+
+            for (i = 0; i < GIC_INTERNAL; i += 4) {
+                kvm_gicr_access(s, GICR_IPRIORITYR + i, ncpu, &reg, false);
+                c->gicr_ipriorityr[i] = extract32(reg, 0, 8);
+                c->gicr_ipriorityr[i + 1] = extract32(reg, 8, 8);
+                c->gicr_ipriorityr[i + 2] = extract32(reg, 16, 8);
+                c->gicr_ipriorityr[i + 3] = extract32(reg, 24, 8);
+            }
+        }
+
+        if (redist_typer & GICR_TYPER_PLPIS) {
+            for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+                GICv3CPUState *c = &s->cpu[ncpu];
 
-            kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, false);
-            kvm_gicr_access(s, GICR_PENDBASER + 4, ncpu, &regh, false);
-            c->gicr_pendbaser = ((uint64_t)regh << 32) | regl;
+                kvm_gicr_access(s, GICR_PROPBASER, ncpu, &regl, false);
+                kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, false);
+                c->gicr_propbaser = ((uint64_t)regh << 32) | regl;
+
+                kvm_gicr_access(s, GICR_PENDBASER, ncpu, &regl, false);
+                kvm_gicr_access(s, GICR_PENDBASER + 4, ncpu, &regh, false);
+                c->gicr_pendbaser = ((uint64_t)regh << 32) | regl;
+            }
         }
     }
 
     /* Distributor state (shared between all CPUs */
-
     kvm_gicd_access(s, GICD_STATUSR, &reg, false);
     s->gicd_statusr[GICV3_NS] = reg;
 
@@ -1025,58 +1329,78 @@ static void kvm_arm_gicv3_get(GICv3State *s)
         s->gicd_irouter[i] = ((uint64_t)regh << 32) | regl;
     }
 
-    /*****************************************************************
-     * CPU Interface(s) State
-     */
+    /* CPU Interface(s) State */
+    if (batch_supported) {
+        {
+            GICv3BatchEntry *entries = g_new(GICv3BatchEntry, 256);
+            int batch_n = 0;
+            int batch_capacity = 256;
 
-    for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
-        GICv3CPUState *c = &s->cpu[ncpu];
-        int num_pri_bits;
+            /* CPU Interface - basic registers */
+            kvm_arm_gic_batch_get_cpuif_basic(s, &entries, &batch_n,
+                                              &batch_capacity);
 
-        kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
-        kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
-                        &c->icc_ctlr_el1[GICV3_NS], false);
-        kvm_gicc_access(s, ICC_IGRPEN0_EL1, ncpu,
-                        &c->icc_igrpen[GICV3_G0], false);
-        kvm_gicc_access(s, ICC_IGRPEN1_EL1, ncpu,
-                        &c->icc_igrpen[GICV3_G1NS], false);
-        kvm_gicc_access(s, ICC_PMR_EL1, ncpu, &c->icc_pmr_el1, false);
-        kvm_gicc_access(s, ICC_BPR0_EL1, ncpu, &c->icc_bpr[GICV3_G0], false);
-        kvm_gicc_access(s, ICC_BPR1_EL1, ncpu, &c->icc_bpr[GICV3_G1NS], false);
-        num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
-                        ICC_CTLR_EL1_PRIBITS_MASK) >>
-                        ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
+            /* reset batch_n */
+            batch_n = 0;
 
-        switch (num_pri_bits) {
-        case 7:
-            kvm_gicc_access(s, ICC_AP0R_EL1(3), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G0][3] = reg64;
-            kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G0][2] = reg64;
-            /* fall through */
-        case 6:
-            kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G0][1] = reg64;
-            /* fall through */
-        default:
-            kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G0][0] = reg64;
+            /* CPU Interface - APR registers */
+            kvm_arm_gic_batch_get_cpuif_apr(s, &entries, &batch_n,
+                                            &batch_capacity);
+
+            g_free(entries);
         }
+    } else {
+        for (ncpu = 0; ncpu < s->num_cpu; ncpu++) {
+            GICv3CPUState *c = &s->cpu[ncpu];
+            int num_pri_bits;
 
-        switch (num_pri_bits) {
-        case 7:
-            kvm_gicc_access(s, ICC_AP1R_EL1(3), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G1NS][3] = reg64;
-            kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G1NS][2] = reg64;
-            /* fall through */
-        case 6:
-            kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G1NS][1] = reg64;
-            /* fall through */
-        default:
-            kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, false);
-            c->icc_apr[GICV3_G1NS][0] = reg64;
+            kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
+            kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
+                            &c->icc_ctlr_el1[GICV3_NS], false);
+            kvm_gicc_access(s, ICC_IGRPEN0_EL1, ncpu,
+                            &c->icc_igrpen[GICV3_G0], false);
+            kvm_gicc_access(s, ICC_IGRPEN1_EL1, ncpu,
+                            &c->icc_igrpen[GICV3_G1NS], false);
+            kvm_gicc_access(s, ICC_PMR_EL1, ncpu, &c->icc_pmr_el1, false);
+            kvm_gicc_access(s, ICC_BPR0_EL1, ncpu, &c->icc_bpr[GICV3_G0],
+                            false);
+            kvm_gicc_access(s, ICC_BPR1_EL1, ncpu, &c->icc_bpr[GICV3_G1NS],
+                            false);
+            num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
+                            ICC_CTLR_EL1_PRIBITS_MASK) >>
+                            ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
+
+            switch (num_pri_bits) {
+            case 7:
+                kvm_gicc_access(s, ICC_AP0R_EL1(3), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G0][3] = reg64;
+                kvm_gicc_access(s, ICC_AP0R_EL1(2), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G0][2] = reg64;
+                /* fall through */
+            case 6:
+                kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G0][1] = reg64;
+                /* fall through */
+            default:
+                kvm_gicc_access(s, ICC_AP0R_EL1(0), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G0][0] = reg64;
+            }
+
+            switch (num_pri_bits) {
+            case 7:
+                kvm_gicc_access(s, ICC_AP1R_EL1(3), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G1NS][3] = reg64;
+                kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G1NS][2] = reg64;
+                /* fall through */
+            case 6:
+                kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G1NS][1] = reg64;
+                /* fall through */
+            default:
+                kvm_gicc_access(s, ICC_AP1R_EL1(0), ncpu, &reg64, false);
+                c->icc_apr[GICV3_G1NS][0] = reg64;
+            }
         }
     }
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-- 
2.43.0


