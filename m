Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F5BC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGHb-0001E8-Bg; Wed, 28 Feb 2024 04:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfGHP-00014R-Pn; Wed, 28 Feb 2024 04:31:12 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rfGHN-0001pw-OO; Wed, 28 Feb 2024 04:31:11 -0500
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tl8FB3lFmzpVTt;
 Wed, 28 Feb 2024 17:29:18 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 2BB1F18006C;
 Wed, 28 Feb 2024 17:31:07 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Feb
 2024 17:31:06 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v4 20/22] hw/intc/arm_gicv3: Report the VNMI interrupt
Date: Wed, 28 Feb 2024 09:29:44 +0000
Message-ID: <20240228092946.1768728-21-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228092946.1768728-1-ruanjinjie@huawei.com>
References: <20240228092946.1768728-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=ruanjinjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In vCPU Interface, if the vIRQ has the superpriority property, report
vNMI to the corresponding vPE.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/intc/arm_gicv3_cpuif.c | 14 ++++++++++++--
 hw/intc/gicv3_internal.h  |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index afba98ad87..0141d259e4 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -465,6 +465,7 @@ void gicv3_cpuif_virt_irq_fiq_update(GICv3CPUState *cs)
     int idx;
     int irqlevel = 0;
     int fiqlevel = 0;
+    int nmilevel = 0;
 
     idx = hppvi_index(cs);
     trace_gicv3_cpuif_virt_update(gicv3_redist_affid(cs), idx,
@@ -482,9 +483,17 @@ void gicv3_cpuif_virt_irq_fiq_update(GICv3CPUState *cs)
         uint64_t lr = cs->ich_lr_el2[idx];
 
         if (icv_hppi_can_preempt(cs, lr)) {
-            /* Virtual interrupts are simple: G0 are always FIQ, and G1 IRQ */
+            /*
+             * Virtual interrupts are simple: G0 are always FIQ, and G1 are
+             * IRQ or NMI which depends on the ICH_LR<n>_EL2.NMI to have
+             * non-maskable property.
+             */
             if (lr & ICH_LR_EL2_GROUP) {
-                irqlevel = 1;
+                if (cs->gic->nmi_support && (lr & ICH_LR_EL2_NMI)) {
+                    nmilevel = 1;
+                } else {
+                    irqlevel = 1;
+                }
             } else {
                 fiqlevel = 1;
             }
@@ -494,6 +503,7 @@ void gicv3_cpuif_virt_irq_fiq_update(GICv3CPUState *cs)
     trace_gicv3_cpuif_virt_set_irqs(gicv3_redist_affid(cs), fiqlevel, irqlevel);
     qemu_set_irq(cs->parent_vfiq, fiqlevel);
     qemu_set_irq(cs->parent_virq, irqlevel);
+    qemu_set_irq(cs->parent_vnmi, nmilevel);
 }
 
 static void gicv3_cpuif_virt_update(GICv3CPUState *cs)
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 93e56b3726..b6cb0115e7 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -242,6 +242,7 @@ FIELD(GICR_VPENDBASER, VALID, 63, 1)
 #define ICH_LR_EL2_PRIORITY_SHIFT 48
 #define ICH_LR_EL2_PRIORITY_LENGTH 8
 #define ICH_LR_EL2_PRIORITY_MASK (0xffULL << ICH_LR_EL2_PRIORITY_SHIFT)
+#define ICH_LR_EL2_NMI (1ULL << 59)
 #define ICH_LR_EL2_GROUP (1ULL << 60)
 #define ICH_LR_EL2_HW (1ULL << 61)
 #define ICH_LR_EL2_STATE_SHIFT 62
-- 
2.34.1


