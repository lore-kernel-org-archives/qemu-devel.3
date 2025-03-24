Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0780CC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 09:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweFg-0007IB-A2; Mon, 24 Mar 2025 05:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tweFc-0007FF-3X
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tweFY-0001Rv-A8
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:43 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxqmrhJ+FnN_ujAA--.14258S3;
 Mon, 24 Mar 2025 17:37:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsfaJ+FnGn1dAA--.15661S6;
 Mon, 24 Mar 2025 17:37:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/16] hw/intc/loongarch_pch: Set version information at
 initial stage
Date: Mon, 24 Mar 2025 17:37:18 +0800
Message-Id: <20250324093730.3683378-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324093730.3683378-1-maobibo@loongson.cn>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfaJ+FnGn1dAA--.15661S6
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

Register PCH_PIC_INT_ID constains version and supported irq number
information, and it is read only register. The detailed value can
be set at initial stage, rather than read callback.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 17 ++++++++++-------
 include/hw/intc/loongarch_pic_common.h | 17 +++++++++++++++--
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index a2d9930ac9..7043b8b9f4 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -80,15 +80,10 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
 
     switch (offset) {
     case PCH_PIC_INT_ID:
-        val = PCH_PIC_INT_ID_VAL;
+        val = s->id.data & UINT_MAX;
         break;
     case PCH_PIC_INT_ID + 4:
-        /*
-         * With 7A1000 manual
-         *   bit  0-15 pch irqchip version
-         *   bit 16-31 irq number supported with pch irqchip
-         */
-        val = deposit32(PCH_PIC_INT_ID_VER, 16, 16, s->irq_num - 1);
+        val = s->id.data >> 32;
         break;
     case PCH_PIC_INT_MASK:
         val = (uint32_t)s->int_mask;
@@ -361,6 +356,14 @@ static void loongarch_pch_pic_reset(DeviceState *d)
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(d);
     int i;
 
+    /*
+     * With 7A1000 manual
+     *   bit  0-15 pch irqchip version
+     *   bit 16-31 irq number supported with pch irqchip
+     */
+    s->id.desc.id = PCH_PIC_INT_ID_VAL;
+    s->id.desc.version = PCH_PIC_INT_ID_VER;
+    s->id.desc.irq_num = s->irq_num - 1;
     s->int_mask = -1;
     s->htmsi_en = 0x0;
     s->intedge  = 0x0;
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index ef6edc15bf..fb848da4b8 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -10,9 +10,9 @@
 #include "hw/pci-host/ls7a.h"
 #include "hw/sysbus.h"
 
-#define PCH_PIC_INT_ID_VAL              0x7000000UL
-#define PCH_PIC_INT_ID_VER              0x1UL
 #define PCH_PIC_INT_ID                  0x00
+#define  PCH_PIC_INT_ID_VAL             0x7
+#define  PCH_PIC_INT_ID_VER             0x1
 #define PCH_PIC_INT_MASK                0x20
 #define PCH_PIC_HTMSI_EN                0x40
 #define PCH_PIC_INT_EDGE                0x60
@@ -30,10 +30,23 @@
 OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
                     LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
 
+union LoongArchPIC_ID {
+    struct {
+        uint64_t _reserved_0:24;
+        uint64_t id:8;
+        uint64_t version:8;
+        uint64_t _reserved_1:8;
+        uint64_t irq_num:8;
+        uint64_t _reserved_2:8;
+    } QEMU_PACKED desc;
+    uint64_t data;
+};
+
 struct LoongArchPICCommonState {
     SysBusDevice parent_obj;
 
     qemu_irq parent_irq[64];
+    union LoongArchPIC_ID id; /* 0x00  interrupt ID register */
     uint64_t int_mask;        /* 0x020 interrupt mask register */
     uint64_t htmsi_en;        /* 0x040 1=msi */
     uint64_t intedge;         /* 0x060 edge=1 level=0 */
-- 
2.39.3


