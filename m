Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A075CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxhQ-000172-49; Wed, 03 Apr 2024 06:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrxh8-0000yk-C0; Wed, 03 Apr 2024 06:18:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrxgt-0006fk-QF; Wed, 03 Apr 2024 06:18:14 -0400
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V8gbx3lbXz1RB9y;
 Wed,  3 Apr 2024 18:15:09 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C6E618002D;
 Wed,  3 Apr 2024 18:17:55 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 18:17:54 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v12 19/23] hw/intc/arm_gicv3: Implement NMI interrupt priority
Date: Wed, 3 Apr 2024 10:16:07 +0000
Message-ID: <20240403101611.3204086-20-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403101611.3204086-1-ruanjinjie@huawei.com>
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ruanjinjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If GICD_CTLR_DS bit is zero and the NMI is non-secure, the NMI priority is
higher than 0x80, otherwise it is higher than 0x0. And save the interrupt
non-maskable property in hppi.nmi to deliver NMI exception. Since both GICR
and GICD can deliver NMI, it is both necessary to check whether the pending
irq is NMI in gicv3_redist_update_noirqset and gicv3_update_noirqset. And
In irqbetter(), only a non-NMI with the same priority and a smaller interrupt
number can be preempted but not NMI.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
v12:
- Fix the typo, "prioirty" -> "priority"
- Update the commit message, hppi.superprio -> hppi.nmi
  super priority -> non-maskable property.
- Add Reviewed-by.
v10:
- has_superprio -> nmi.
- superpriority -> non-maskable property.
- gicr_isuperprio -> gicr_inmir0.
- superprio -> nmi.
v8:
- Add Reviewed-by.
v7:
- Reorder the irqbetter() code for clarity.
- Eliminate the has_superprio local variable for gicv3_get_priority().
- false -> cs->hpplpi.superprio in gicv3_redist_update_noirqset().
- 0x0 -> false in arm_gicv3_common_reset_hold().
- Clear superprio in several places for hppi, hpplpi and hppvlpi.
v6:
- Put the "extract superprio info" logic into gicv3_get_priority().
- Update the comment in irqbetter().
- Reset the cs->hppi.superprio to 0x0.
- Set hppi.superprio to false for LPI.
v4:
- Replace is_nmi with has_superprio to not a mix NMI and superpriority.
- Update the comment in irqbetter().
- Extract gicv3_get_priority() to avoid code repeat.
---
v3:
- Add missing brace
---
 hw/intc/arm_gicv3.c        | 67 +++++++++++++++++++++++++++++++++-----
 hw/intc/arm_gicv3_common.c |  3 ++
 hw/intc/arm_gicv3_redist.c |  3 ++
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 0b8f79a122..6704190d9d 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -21,7 +21,7 @@
 #include "hw/intc/arm_gicv3.h"
 #include "gicv3_internal.h"
 
-static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
+static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio, bool nmi)
 {
     /* Return true if this IRQ at this priority should take
      * precedence over the current recorded highest priority
@@ -30,14 +30,23 @@ static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio)
      * is the same as this one (a property which the calling code
      * relies on).
      */
-    if (prio < cs->hppi.prio) {
-        return true;
+    if (prio != cs->hppi.prio) {
+        return prio < cs->hppi.prio;
+    }
+
+    /*
+     * The same priority IRQ with non-maskable property should signal to
+     * the CPU as it have the priority higher than the labelled 0x80 or 0x00.
+     */
+    if (nmi != cs->hppi.nmi) {
+        return nmi;
     }
+
     /* If multiple pending interrupts have the same priority then it is an
      * IMPDEF choice which of them to signal to the CPU. We choose to
      * signal the one with the lowest interrupt number.
      */
-    if (prio == cs->hppi.prio && irq <= cs->hppi.irq) {
+    if (irq <= cs->hppi.irq) {
         return true;
     }
     return false;
@@ -129,6 +138,40 @@ static uint32_t gicr_int_pending(GICv3CPUState *cs)
     return pend;
 }
 
+static bool gicv3_get_priority(GICv3CPUState *cs, bool is_redist,
+                               uint8_t *prio, int irq)
+{
+    uint32_t nmi = 0x0;
+
+    if (is_redist) {
+        nmi = extract32(cs->gicr_inmir0, irq, 1);
+    } else {
+        nmi = *gic_bmp_ptr32(cs->gic->nmi, irq);
+        nmi = nmi & (1 << (irq & 0x1f));
+    }
+
+    if (nmi) {
+        /* DS = 0 & Non-secure NMI */
+        if (!(cs->gic->gicd_ctlr & GICD_CTLR_DS) &&
+            ((is_redist && extract32(cs->gicr_igroupr0, irq, 1)) ||
+             (!is_redist && gicv3_gicd_group_test(cs->gic, irq)))) {
+            *prio = 0x80;
+        } else {
+            *prio = 0x0;
+        }
+
+        return true;
+    }
+
+    if (is_redist) {
+        *prio = cs->gicr_ipriorityr[irq];
+    } else {
+        *prio = cs->gic->gicd_ipriority[irq];
+    }
+
+    return false;
+}
+
 /* Update the interrupt status after state in a redistributor
  * or CPU interface has changed, but don't tell the CPU i/f.
  */
@@ -141,6 +184,7 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
     uint8_t prio;
     int i;
     uint32_t pend;
+    bool nmi = false;
 
     /* Find out which redistributor interrupts are eligible to be
      * signaled to the CPU interface.
@@ -152,10 +196,11 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
             if (!(pend & (1 << i))) {
                 continue;
             }
-            prio = cs->gicr_ipriorityr[i];
-            if (irqbetter(cs, i, prio)) {
+            nmi = gicv3_get_priority(cs, true, &prio, i);
+            if (irqbetter(cs, i, prio, nmi)) {
                 cs->hppi.irq = i;
                 cs->hppi.prio = prio;
+                cs->hppi.nmi = nmi;
                 seenbetter = true;
             }
         }
@@ -168,9 +213,10 @@ static void gicv3_redist_update_noirqset(GICv3CPUState *cs)
     if ((cs->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) && cs->gic->lpi_enable &&
         (cs->gic->gicd_ctlr & GICD_CTLR_EN_GRP1NS) &&
         (cs->hpplpi.prio != 0xff)) {
-        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio)) {
+        if (irqbetter(cs, cs->hpplpi.irq, cs->hpplpi.prio, cs->hpplpi.nmi)) {
             cs->hppi.irq = cs->hpplpi.irq;
             cs->hppi.prio = cs->hpplpi.prio;
+            cs->hppi.nmi = cs->hpplpi.nmi;
             cs->hppi.grp = cs->hpplpi.grp;
             seenbetter = true;
         }
@@ -213,6 +259,7 @@ static void gicv3_update_noirqset(GICv3State *s, int start, int len)
     int i;
     uint8_t prio;
     uint32_t pend = 0;
+    bool nmi = false;
 
     assert(start >= GIC_INTERNAL);
     assert(len > 0);
@@ -240,10 +287,11 @@ static void gicv3_update_noirqset(GICv3State *s, int start, int len)
              */
             continue;
         }
-        prio = s->gicd_ipriority[i];
-        if (irqbetter(cs, i, prio)) {
+        nmi = gicv3_get_priority(cs, false, &prio, i);
+        if (irqbetter(cs, i, prio, nmi)) {
             cs->hppi.irq = i;
             cs->hppi.prio = prio;
+            cs->hppi.nmi = nmi;
             cs->seenbetter = true;
         }
     }
@@ -293,6 +341,7 @@ void gicv3_full_update_noirqset(GICv3State *s)
 
     for (i = 0; i < s->num_cpu; i++) {
         s->cpu[i].hppi.prio = 0xff;
+        s->cpu[i].hppi.nmi = false;
     }
 
     /* Note that we can guarantee that these functions will not
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 9810558b07..207f8417e1 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -536,8 +536,11 @@ static void arm_gicv3_common_reset_hold(Object *obj)
         memset(cs->gicr_ipriorityr, 0, sizeof(cs->gicr_ipriorityr));
 
         cs->hppi.prio = 0xff;
+        cs->hppi.nmi = false;
         cs->hpplpi.prio = 0xff;
+        cs->hpplpi.nmi = false;
         cs->hppvlpi.prio = 0xff;
+        cs->hppvlpi.nmi = false;
 
         /* State in the CPU interface must *not* be reset here, because it
          * is part of the CPU's reset domain, not the GIC device's.
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index ed1f9d1e44..90b238fac0 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -120,6 +120,7 @@ static void update_for_one_lpi(GICv3CPUState *cs, int irq,
         ((prio == hpp->prio) && (irq <= hpp->irq))) {
         hpp->irq = irq;
         hpp->prio = prio;
+        hpp->nmi = false;
         /* LPIs and vLPIs are always non-secure Grp1 interrupts */
         hpp->grp = GICV3_G1NS;
     }
@@ -156,6 +157,7 @@ static void update_for_all_lpis(GICv3CPUState *cs, uint64_t ptbase,
     int i, bit;
 
     hpp->prio = 0xff;
+    hpp->nmi = false;
 
     for (i = GICV3_LPI_INTID_START / 8; i < pendt_size / 8; i++) {
         address_space_read(as, ptbase + i, MEMTXATTRS_UNSPECIFIED, &pend, 1);
@@ -241,6 +243,7 @@ static void gicv3_redist_update_vlpi_only(GICv3CPUState *cs)
 
     if (!FIELD_EX64(cs->gicr_vpendbaser, GICR_VPENDBASER, VALID)) {
         cs->hppvlpi.prio = 0xff;
+        cs->hppvlpi.nmi = false;
         return;
     }
 
-- 
2.34.1


