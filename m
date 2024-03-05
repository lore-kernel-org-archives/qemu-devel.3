Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0685BC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOtn-0007K9-Rx; Tue, 05 Mar 2024 02:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rhOrh-0004TG-Bs; Tue, 05 Mar 2024 02:05:30 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rhOrf-00008A-DK; Tue, 05 Mar 2024 02:05:29 -0500
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tpmks1QC9zbcjv;
 Tue,  5 Mar 2024 15:04:05 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 15C7C14037C;
 Tue,  5 Mar 2024 15:04:47 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 15:04:46 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v6 15/23] hw/intc/arm_gicv3: Implement GICD_INMIR
Date: Tue, 5 Mar 2024 07:03:23 +0000
Message-ID: <20240305070331.2151131-16-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305070331.2151131-1-ruanjinjie@huawei.com>
References: <20240305070331.2151131-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=ruanjinjie@huawei.com; helo=szxga02-in.huawei.com
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

Add GICD_INMIR, GICD_INMIRnE register and support access GICD_INMIR0.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v4:
- Make the GICD_INMIR implementation more clearer.
- Udpate the commit message.
v3:
- Add Reviewed-by.
---
 hw/intc/arm_gicv3_dist.c | 34 ++++++++++++++++++++++++++++++++++
 hw/intc/gicv3_internal.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 35e850685c..9739404e35 100644
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
@@ -543,6 +566,11 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
         /* RAZ/WI since affinity routing is always enabled */
         *data = 0;
         return true;
+    case GICD_INMIR ... GICD_INMIR + 0x7f:
+        *data = (!s->nmi_support) ? 0 :
+                gicd_read_bitmap_reg(s, attrs, s->superprio, NULL,
+                                     offset - GICD_INMIR);
+        return true;
     case GICD_IROUTER ... GICD_IROUTER + 0x1fdf:
     {
         uint64_t r;
@@ -752,6 +780,12 @@ static bool gicd_writel(GICv3State *s, hwaddr offset,
     case GICD_SPENDSGIR ... GICD_SPENDSGIR + 0xf:
         /* RAZ/WI since affinity routing is always enabled */
         return true;
+    case GICD_INMIR ... GICD_INMIR + 0x7f:
+        if (s->nmi_support) {
+            gicd_write_bitmap_reg(s, attrs, s->superprio, NULL,
+                                  offset - GICD_INMIR, value);
+        }
+        return true;
     case GICD_IROUTER ... GICD_IROUTER + 0x1fdf:
     {
         uint64_t r;
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index f35b7d2f03..a1fc34597e 100644
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
 
-- 
2.34.1


