Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47915C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 09:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweFh-0007JV-IA; Mon, 24 Mar 2025 05:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tweFd-0007G5-EN
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tweFZ-0001SP-Hj
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:45 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxOGrjJ+FnP_ujAA--.14815S3;
 Mon, 24 Mar 2025 17:37:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsfaJ+FnGn1dAA--.15661S9;
 Mon, 24 Mar 2025 17:37:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 07/16] hw/intc/loongarch_pch: Use generic read callback for
 iomem32_low region
Date: Mon, 24 Mar 2025 17:37:21 +0800
Message-Id: <20250324093730.3683378-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324093730.3683378-1-maobibo@loongson.cn>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfaJ+FnGn1dAA--.15661S9
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For memory region iomem32_low, generic read callback is used.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 71 +++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 10b4231464..b495bd3a4d 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/intc/loongarch_pch_pic.h"
 #include "trace.h"
@@ -71,47 +72,71 @@ static void pch_pic_irq_handler(void *opaque, int irq, int level)
     pch_pic_update_irq(s, mask, level);
 }
 
-static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
-                                            unsigned size)
+static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
+    uint32_t offset = addr & 7;
 
     switch (addr) {
-    case PCH_PIC_INT_ID:
-        val = s->id.data & UINT_MAX;
+    case PCH_PIC_INT_ID ... PCH_PIC_INT_ID + 7:
+        val = s->id.data;
         break;
-    case PCH_PIC_INT_ID + 4:
-        val = s->id.data >> 32;
+    case PCH_PIC_INT_MASK ... PCH_PIC_INT_MASK + 7:
+        val = s->int_mask;
         break;
-    case PCH_PIC_INT_MASK:
-        val = (uint32_t)s->int_mask;
+    case PCH_PIC_INT_EDGE ... PCH_PIC_INT_EDGE + 7:
+        val = s->intedge;
         break;
-    case PCH_PIC_INT_MASK + 4:
-        val = s->int_mask >> 32;
+    case PCH_PIC_HTMSI_EN ... PCH_PIC_HTMSI_EN + 7:
+        val = s->htmsi_en;
         break;
-    case PCH_PIC_INT_EDGE:
-        val = (uint32_t)s->intedge;
+    case PCH_PIC_AUTO_CTRL0 ... PCH_PIC_AUTO_CTRL0 + 7:
+    case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
+        /* PCH PIC connect to EXTIOI always, discard auto_ctrl access */
         break;
-    case PCH_PIC_INT_EDGE + 4:
-        val = s->intedge >> 32;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pch_pic_read: Bad address 0x%"PRIx64"\n", addr);
         break;
-    case PCH_PIC_HTMSI_EN:
-        val = (uint32_t)s->htmsi_en;
+    }
+
+    return (val >> (offset * 8)) & field_mask;
+}
+
+static uint64_t loongarch_pch_pic_read(void *opaque, hwaddr addr,
+                                       unsigned size)
+{
+    uint64_t val = 0;
+
+    switch (size) {
+    case 1:
+        val = pch_pic_read(opaque, addr, 0xFF);
         break;
-    case PCH_PIC_HTMSI_EN + 4:
-        val = s->htmsi_en >> 32;
+    case 2:
+        val = pch_pic_read(opaque, addr, 0xFFFF);
         break;
-    case PCH_PIC_AUTO_CTRL0:
-    case PCH_PIC_AUTO_CTRL0 + 4:
-    case PCH_PIC_AUTO_CTRL1:
-    case PCH_PIC_AUTO_CTRL1 + 4:
-        /* PCH PIC connect to EXTIOI always, discard auto_ctrl access */
+    case 4:
+        val = pch_pic_read(opaque, addr, UINT_MAX);
+        break;
+    case 8:
+        val = pch_pic_read(opaque, addr, UINT64_MAX);
         break;
     default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "loongarch_pch_pic_read: Bad size %d\n", size);
         break;
     }
 
+    return val;
+}
+
+static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
+                                            unsigned size)
+{
+    uint64_t val;
+
+    val = loongarch_pch_pic_read(opaque, addr, size);
     trace_loongarch_pch_pic_low_readw(size, addr, val);
     return val;
 }
-- 
2.39.3


