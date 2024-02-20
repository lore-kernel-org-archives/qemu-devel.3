Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AF2C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQsG-00027f-Fv; Tue, 20 Feb 2024 09:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcP5j-00009A-A0; Tue, 20 Feb 2024 07:19:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcP5b-0004MS-Em; Tue, 20 Feb 2024 07:19:18 -0500
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TfJLF6gQgz2Bd4t;
 Tue, 20 Feb 2024 20:16:53 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id EE37618001A;
 Tue, 20 Feb 2024 20:19:01 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 20:19:01 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH 3/3] hw/intc/arm_gicv3: Implement FEAT_GICv3_NMI feature
 to support FEAT_NMI
Date: Tue, 20 Feb 2024 12:17:52 +0000
Message-ID: <20240220121752.490665-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220121752.490665-1-ruanjinjie@huawei.com>
References: <20240220121752.490665-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=ruanjinjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Feb 2024 09:13:26 -0500
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Connect NMI wire from GICv3 to every Arm PE.

         +-------------------------------------------------+
         |               Distributor                       |
         +-------------------------------------------------+
                 |  NMI                         |  NMI
                \ /                            \ /
            +--------+                     +-------+
            | redist |                     | redist|
            +--------+                     +-------+
                 | NMI                         | NMI
                \ /                           \ /
          +-------------+             +---------------+
          |CPU interface|   ...       | CPU interface |
          +-------------+             +---------------+
               | NMI                          | NMI
              \ /                            \ /
            +-----+                       +-----+
            |  PE |                       |  PE |
            +-----+                       +-----+

Support the superpriority property for SPI/SGI/PPI interrupt and these
interrupts with a NMI high priority.

Also support configure a interrupt with superpriority property with
GICR_INMIR0 or GICD_INMIR register.

Support ack a NMI interrupt with ICC_NMIAR1_EL1 register. and support PE to
distinguish IRQ from FIQ for a NMI.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c                      |  2 +
 hw/intc/arm_gicv3.c                | 61 ++++++++++++++++++++++++++----
 hw/intc/arm_gicv3_common.c         |  4 ++
 hw/intc/arm_gicv3_cpuif.c          | 57 ++++++++++++++++++++++++++--
 hw/intc/arm_gicv3_dist.c           | 39 +++++++++++++++++++
 hw/intc/arm_gicv3_redist.c         | 23 +++++++++++
 hw/intc/gicv3_internal.h           |  5 +++
 include/hw/core/cpu.h              |  1 +
 include/hw/intc/arm_gic_common.h   |  1 +
 include/hw/intc/arm_gicv3_common.h |  6 +++
 target/arm/helper.c                |  5 ++-
 11 files changed, 191 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0af1943697..5f2683a553 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -848,6 +848,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
         sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
     }
 
     fdt_add_gic_node(vms);
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 0b8f79a122..e3281cffdc 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -21,7 +21,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "gicv3_internal.h"
 
-static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
+static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio, bool is_nmi)
 {
     /* Return true if this IRQ at this priority should take
      * precedence over the current recorded highest priority
@@ -33,11 +33,21 @@ static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
     if (prio < cs->hppi.prio) {
         return true;
     }
+
+    /*
+     * Current highest prioirity pending interrupt is not a NMI
+     * and the new IRQ is a NMI with same priority.
+     */
+    if (prio == cs->hppi.prio && !cs->hppi.superprio && is_nmi) {
+        return true;
+    }
+
     /* If multiple pending interrupts have the same priority then it is an
      * IMPDEF choice which of them to signal to the CPU. We choose to
      * signal the one with the lowest interrupt number.
      */
-    if (prio == cs->hppi.prio && irq <= cs->hppi.irq) {
+    if (prio == cs->hppi.prio && !cs->hppi.superprio &&
+        !is_nmi && irq <= cs->hppi.irq) {
         return true;
     }
     return false;
@@ -141,6 +151,8 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
     uint8_t prio;
     int i;
     uint32_t pend;
+    bool is_nmi = 0;
+    uint32_t superprio = 0;
 
     /* Find out which redistributor interrupts are eligible to be
      * signaled to the CPU interface.
@@ -152,10 +164,26 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
             if (!(pend & (1 << i))) {
                 continue;
             }
-            prio = cs->gicr_ipriorityr[i];
-            if (irqbetter(cs, i, prio)) {
+            superprio = extract32(cs->gicr_isuperprio, i, 1);
+
+            /* NMI */
+            if (superprio) {
+                is_nmi = 1;
+
+                /* DS = 0 & Non-secure NMI */
+                if ((!(cs->gic->gicd_ctlr & GICD_CTLR_DS)) &&
+                    extract32(cs->gicr_igroupr0, i, 1))
+                    prio = 0x80;
+                else
+                    prio = 0x0;
+            } else {
+               is_nmi = 0;
+               prio = cs->gicr_ipriorityr[i];
+            }
+            if (irqbetter(cs, i, prio, is_nmi)) {
                 cs->hppi.irq = i;
                 cs->hppi.prio = prio;
+                cs->hppi.superprio = is_nmi;
                 seenbetter = true;
             }
         }
@@ -168,7 +196,7 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
     if ((cs->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) && cs->gic->lpi_enable &&
         (cs->gic->gicd_ctlr & GICD_CTLR_EN_GRP1NS) &&
         (cs->hpplpi.prio != 0xff)) {
-        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio)) {
+        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio, false)) {
             cs->hppi.irq = cs->hpplpi.irq;
             cs->hppi.prio = cs->hpplpi.prio;
             cs->hppi.grp = cs->hpplpi.grp;
@@ -212,7 +240,9 @@ static void gicv3_update_noirqset(GICv3State *s, int start, int len)
 {
     int i;
     uint8_t prio;
+    bool is_nmi = 0;
     uint32_t pend = 0;
+    uint32_t superprio = 0;
 
     assert(start >= GIC_INTERNAL);
     assert(len > 0);
@@ -240,10 +270,27 @@ static void gicv3_update_noirqset(GICv3State *s, int start, int len)
              */
             continue;
         }
-        prio = s->gicd_ipriority[i];
-        if (irqbetter(cs, i, prio)) {
+
+        superprio = *gic_bmp_ptr32(s->superprio, i);
+        /* NMI */
+        if (superprio & (1 << (i & 0x1f))) {
+            is_nmi = 1;
+
+            /* DS = 0 & Non-secure NMI */
+            if ((!(s->gicd_ctlr & GICD_CTLR_DS)) &&
+                gicv3_gicd_group_test(s, i))
+                    prio = 0x80;
+            else
+                    prio = 0x0;
+        } else {
+            is_nmi = 0;
+            prio = s->gicd_ipriority[i];
+        }
+
+        if (irqbetter(cs, i, prio, is_nmi)) {
             cs->hppi.irq = i;
             cs->hppi.prio = prio;
+            cs->hppi.superprio = is_nmi;
             cs->seenbetter = true;
         }
     }
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index cb55c72681..4a56140f4c 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -299,6 +299,9 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
     for (i = 0; i < s->num_cpu; i++) {
         sysbus_init_irq(sbd, &s->cpu[i].parent_vfiq);
     }
+    for (i = 0; i < s->num_cpu; i++) {
+        sysbus_init_irq(sbd, &s->cpu[i].parent_nmi);
+    }
 
     memory_region_init_io(&s->iomem_dist, OBJECT(s), ops, s,
                           "gicv3_dist", 0x10000);
@@ -563,6 +566,7 @@ static Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
     DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
     DEFINE_PROP_BOOL("has-lpi", GICv3State, lpi_enable, 0),
+    DEFINE_PROP_BOOL("has-nmi", GICv3State, nmi_support, 1),
     DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
     /*
      * Compatibility property: force 8 bits of physical priority, even
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index e1a60d8c15..9b0ee0cfec 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -931,6 +931,7 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     /* Tell the CPU about its highest priority pending interrupt */
     int irqlevel = 0;
     int fiqlevel = 0;
+    int nmilevel = 0;
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
@@ -967,7 +968,14 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
             g_assert_not_reached();
         }
 
-        if (isfiq) {
+        if (cs->hppi.superprio) {
+            nmilevel = 1;
+            if (isfiq) {
+                cs->cpu->nmi_irq = false;
+            } else {
+                cs->cpu->nmi_irq = true;
+            }
+        } else if (isfiq) {
             fiqlevel = 1;
         } else {
             irqlevel = 1;
@@ -978,6 +986,7 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
 
     qemu_set_irq(cs->parent_fiq, fiqlevel);
     qemu_set_irq(cs->parent_irq, irqlevel);
+    qemu_set_irq(cs->parent_nmi, nmilevel);
 }
 
 static uint64_t icc_pmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -1097,7 +1106,8 @@ static uint64_t icc_hppir0_value(GICv3CPUState *cs, CPUARMState *env)
     return cs->hppi.irq;
 }
 
-static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
+static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env,
+                                 bool is_nmi, bool is_hppi)
 {
     /* Return the highest priority pending interrupt register value
      * for group 1.
@@ -1108,6 +1118,16 @@ static uint64_t icc_hppir1_value(GICv3CPUState *cs, CPUARMState *env)
         return INTID_SPURIOUS;
     }
 
+    if (!is_hppi) {
+        if (is_nmi && (!cs->hppi.superprio)) {
+            return INTID_SPURIOUS;
+        }
+
+        if ((!is_nmi) && cs->hppi.superprio) {
+            return INTID_NMI;
+        }
+    }
+
     /* Check whether we can return the interrupt or if we should return
      * a special identifier, as per the CheckGroup1ForSpecialIdentifiers
      * pseudocode. (We can simplify a little because for us ICC_SRE_EL1.RM
@@ -1168,7 +1188,30 @@ static uint64_t icc_iar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
     if (!icc_hppi_can_preempt(cs)) {
         intid = INTID_SPURIOUS;
     } else {
-        intid = icc_hppir1_value(cs, env);
+        intid = icc_hppir1_value(cs, env, false, false);
+    }
+
+    if (!gicv3_intid_is_special(intid)) {
+        icc_activate_irq(cs, intid);
+    }
+
+    trace_gicv3_icc_iar1_read(gicv3_redist_affid(cs), intid);
+    return intid;
+}
+
+static uint64_t icc_nmiar1_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    GICv3CPUState *cs = icc_cs_from_env(env);
+    uint64_t intid;
+
+    if (icv_access(env, HCR_IMO)) {
+        return icv_iar_read(env, ri);
+    }
+
+    if (!icc_hppi_can_preempt(cs)) {
+        intid = INTID_SPURIOUS;
+    } else {
+        intid = icc_hppir1_value(cs, env, true, false);
     }
 
     if (!gicv3_intid_is_special(intid)) {
@@ -1555,7 +1598,7 @@ static uint64_t icc_hppir1_read(CPUARMState *env, const ARMCPRegInfo *ri)
         return icv_hppir_read(env, ri);
     }
 
-    value = icc_hppir1_value(cs, env);
+    value = icc_hppir1_value(cs, env, false, true);
     trace_gicv3_icc_hppir1_read(gicv3_redist_affid(cs), value);
     return value;
 }
@@ -2344,6 +2387,12 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
       .access = PL1_R, .accessfn = gicv3_irq_access,
       .readfn = icc_iar1_read,
     },
+    { .name = "ICC_NMIAR1_EL1", .state = ARM_CP_STATE_BOTH,
+      .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 9, .opc2 = 5,
+      .type = ARM_CP_IO | ARM_CP_NO_RAW,
+      .access = PL1_R, .accessfn = gicv3_irq_access,
+      .readfn = icc_nmiar1_read,
+    },
     { .name = "ICC_EOIR1_EL1", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 1,
       .type = ARM_CP_IO | ARM_CP_NO_RAW,
diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 35e850685c..a234df44dd 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -89,6 +89,29 @@ static int gicd_ns_access(GICv3State *s, int irq)
     return extract32(s->gicd_nsacr[irq / 16], (irq % 16) * 2, 2);
 }
 
+static void gicd_write_bitmap_reg(GICv3State *s, MemTxAttrs attrs,
+                                  uint32_t *bmp, maskfn *maskfn,
+                                  int offset, uint32_t val)
+{
+    /*
+     * Helper routine to implement writing to a "set" register
+     * (GICD_INMIR, etc).
+     * Semantics implemented here:
+     * RAZ/WI for SGIs, PPIs, unimplemented IRQs
+     * Bits corresponding to Group 0 or Secure Group 1 interrupts RAZ/WI.
+     * offset should be the offset in bytes of the register from the start
+     * of its group.
+     */
+    int irq = offset * 8;
+
+    if (irq < GIC_INTERNAL || irq >= s->num_irq) {
+        return;
+    }
+    val &= mask_group_and_nsacr(s, attrs, maskfn, irq);
+    *gic_bmp_ptr32(bmp, irq) = val;
+    gicv3_update(s, irq, 32);
+}
+
 static void gicd_write_set_bitmap_reg(GICv3State *s, MemTxAttrs attrs,
                                       uint32_t *bmp,
                                       maskfn *maskfn,
@@ -402,6 +425,7 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
         bool dvis = s->revision >= 4;
 
         *data = (1 << 25) | (1 << 24) | (dvis << 18) | (sec_extn << 10) |
+            (s->nmi_support << GICD_TYPER_NMI_SHIFT) |
             (s->lpi_enable << GICD_TYPER_LPIS_SHIFT) |
             (0xf << 19) | itlinesnumber;
         return true;
@@ -543,6 +567,14 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
         /* RAZ/WI since affinity routing is always enabled */
         *data = 0;
         return true;
+    case GICD_INMIR ... GICD_INMIR + 0x7f:
+        if (!s->nmi_support) {
+            *data = 0;
+            return true;
+        }
+        *data = gicd_read_bitmap_reg(s, attrs, s->superprio, NULL,
+                                     offset - GICD_INMIR);
+        return true;
     case GICD_IROUTER ... GICD_IROUTER + 0x1fdf:
     {
         uint64_t r;
@@ -752,6 +784,13 @@ static bool gicd_writel(GICv3State *s, hwaddr offset,
     case GICD_SPENDSGIR ... GICD_SPENDSGIR + 0xf:
         /* RAZ/WI since affinity routing is always enabled */
         return true;
+    case GICD_INMIR ... GICD_INMIR + 0x7f:
+        if (!s->nmi_support) {
+            return true;
+        }
+        gicd_write_bitmap_reg(s, attrs, s->superprio, NULL,
+                              offset - GICD_INMIR, value);
+        return true;
     case GICD_IROUTER ... GICD_IROUTER + 0x1fdf:
     {
         uint64_t r;
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 8153525849..87e7823f34 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -35,6 +35,15 @@ static int gicr_ns_access(GICv3CPUState *cs, int irq)
     return extract32(cs->gicr_nsacr, irq * 2, 2);
 }
 
+static void gicr_write_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
+                                  uint32_t *reg, uint32_t val)
+{
+    /* Helper routine to implement writing to a "set" register */
+    val &= mask_group(cs, attrs);
+    *reg = val;
+    gicv3_redist_update(cs);
+}
+
 static void gicr_write_set_bitmap_reg(GICv3CPUState *cs, MemTxAttrs attrs,
                                       uint32_t *reg, uint32_t val)
 {
@@ -406,6 +415,13 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
         *data = value;
         return MEMTX_OK;
     }
+    case GICR_INMIR0:
+        if (!cs->gic->nmi_support) {
+            *data = 0;
+            return MEMTX_OK;
+        }
+        *data = gicr_read_bitmap_reg(cs, attrs, cs->gicr_isuperprio);
+        return MEMTX_OK;
     case GICR_ICFGR0:
     case GICR_ICFGR1:
     {
@@ -555,6 +571,13 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
         gicv3_redist_update(cs);
         return MEMTX_OK;
     }
+    case GICR_INMIR0:
+        if (!cs->gic->nmi_support) {
+            return MEMTX_OK;
+        }
+        gicr_write_bitmap_reg(cs, attrs, &cs->gicr_isuperprio, value);
+        return MEMTX_OK;
+
     case GICR_ICFGR0:
         /* Register is all RAZ/WI or RAO/WI bits */
         return MEMTX_OK;
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 29d5cdc1b6..93e56b3726 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -52,6 +52,8 @@
 #define GICD_SGIR            0x0F00
 #define GICD_CPENDSGIR       0x0F10
 #define GICD_SPENDSGIR       0x0F20
+#define GICD_INMIR           0x0F80
+#define GICD_INMIRnE         0x3B00
 #define GICD_IROUTER         0x6000
 #define GICD_IDREGS          0xFFD0
 
@@ -68,6 +70,7 @@
 #define GICD_CTLR_E1NWF             (1U << 7)
 #define GICD_CTLR_RWP               (1U << 31)
 
+#define GICD_TYPER_NMI_SHIFT           9
 #define GICD_TYPER_LPIS_SHIFT          17
 
 /* 16 bits EventId */
@@ -109,6 +112,7 @@
 #define GICR_ICFGR1           (GICR_SGI_OFFSET + 0x0C04)
 #define GICR_IGRPMODR0        (GICR_SGI_OFFSET + 0x0D00)
 #define GICR_NSACR            (GICR_SGI_OFFSET + 0x0E00)
+#define GICR_INMIR0           (GICR_SGI_OFFSET + 0x0F80)
 
 /* VLPI redistributor registers, offsets from VLPI_base */
 #define GICR_VPROPBASER       (GICR_VLPI_OFFSET + 0x70)
@@ -507,6 +511,7 @@ FIELD(VTE, RDBASE, 42, RDBASE_PROCNUM_LENGTH)
 /* Special interrupt IDs */
 #define INTID_SECURE 1020
 #define INTID_NONSECURE 1021
+#define INTID_NMI 1022
 #define INTID_SPURIOUS 1023
 
 /* Functions internal to the emulated GICv3 */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4385ce54c9..6c9dc25e5b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -541,6 +541,7 @@ struct CPUState {
     uint32_t tcg_cflags;
     uint32_t halted;
     int32_t exception_index;
+    bool nmi_irq;
 
     AccelCPUState *accel;
     /* shared by kvm and hvf */
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index 7080375008..140f531758 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -69,6 +69,7 @@ struct GICState {
 
     qemu_irq parent_irq[GIC_NCPU];
     qemu_irq parent_fiq[GIC_NCPU];
+    qemu_irq parent_nmi[GIC_NCPU];
     qemu_irq parent_virq[GIC_NCPU];
     qemu_irq parent_vfiq[GIC_NCPU];
     qemu_irq maintenance_irq[GIC_NCPU];
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 4e2fb518e7..8f9bcdfac9 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -146,6 +146,7 @@ typedef struct {
     int irq;
     uint8_t prio;
     int grp;
+    bool superprio;
 } PendingIrq;
 
 struct GICv3CPUState {
@@ -155,6 +156,7 @@ struct GICv3CPUState {
     qemu_irq parent_fiq;
     qemu_irq parent_virq;
     qemu_irq parent_vfiq;
+    qemu_irq parent_nmi;
 
     /* Redistributor */
     uint32_t level;                  /* Current IRQ level */
@@ -170,6 +172,7 @@ struct GICv3CPUState {
     uint32_t gicr_ienabler0;
     uint32_t gicr_ipendr0;
     uint32_t gicr_iactiver0;
+    uint32_t gicr_isuperprio;
     uint32_t edge_trigger; /* ICFGR0 and ICFGR1 even bits */
     uint32_t gicr_igrpmodr0;
     uint32_t gicr_nsacr;
@@ -247,6 +250,7 @@ struct GICv3State {
     uint32_t num_irq;
     uint32_t revision;
     bool lpi_enable;
+    bool nmi_support;
     bool security_extn;
     bool force_8bit_prio;
     bool irq_reset_nonsecure;
@@ -272,6 +276,7 @@ struct GICv3State {
     GIC_DECLARE_BITMAP(active);       /* GICD_ISACTIVER */
     GIC_DECLARE_BITMAP(level);        /* Current level */
     GIC_DECLARE_BITMAP(edge_trigger); /* GICD_ICFGR even bits */
+    GIC_DECLARE_BITMAP(superprio);    /* GICD_INMIR */
     uint8_t gicd_ipriority[GICV3_MAXIRQ];
     uint64_t gicd_irouter[GICV3_MAXIRQ];
     /* Cached information: pointer to the cpu i/f for the CPUs specified
@@ -311,6 +316,7 @@ GICV3_BITMAP_ACCESSORS(pending)
 GICV3_BITMAP_ACCESSORS(active)
 GICV3_BITMAP_ACCESSORS(level)
 GICV3_BITMAP_ACCESSORS(edge_trigger)
+GICV3_BITMAP_ACCESSORS(superprio)
 
 #define TYPE_ARM_GICV3_COMMON "arm-gicv3-common"
 typedef struct ARMGICv3CommonClass ARMGICv3CommonClass;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8d525c6b82..9bf0073840 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2023,7 +2023,7 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
             ret |= CPSR_I;
         }
 
-        if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
+        if ((cs->interrupt_request & CPU_INTERRUPT_NMI) && cs->nmi_irq) {
             ret |= ISR_IS;
         }
     }
@@ -2037,7 +2037,7 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
             ret |= CPSR_F;
         }
 
-        if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
+        if ((cs->interrupt_request & CPU_INTERRUPT_NMI) && !cs->nmi_irq) {
             ret |= ISR_FS;
         }
     }
@@ -11452,6 +11452,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         break;
     case EXCP_IRQ:
     case EXCP_VIRQ:
+    case EXCP_NMI:
         addr += 0x80;
         break;
     case EXCP_FIQ:
-- 
2.34.1


