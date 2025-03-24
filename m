Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B23C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 09:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweFh-0007Ja-MT; Mon, 24 Mar 2025 05:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tweFd-0007GY-QJ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tweFa-0001ST-5O
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:45 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxqmrkJ+FnQfujAA--.14260S3;
 Mon, 24 Mar 2025 17:37:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsfaJ+FnGn1dAA--.15661S10;
 Mon, 24 Mar 2025 17:37:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/16] hw/intc/loongarch_pch: Use generic read callback for
 iomem32_high region
Date: Mon, 24 Mar 2025 17:37:22 +0800
Message-Id: <20250324093730.3683378-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324093730.3683378-1-maobibo@loongson.cn>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfaJ+FnGn1dAA--.15661S10
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

Add register read operation emulation in generic read function
loongarch_pch_pic_read(), and use this function for iomem32_high region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index b495bd3a4d..0057b0f357 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -95,6 +95,12 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
     case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
         /* PCH PIC connect to EXTIOI always, discard auto_ctrl access */
         break;
+    case PCH_PIC_INT_STATUS ... PCH_PIC_INT_STATUS + 7:
+        val = s->intisr & (~s->int_mask);
+        break;
+    case PCH_PIC_INT_POL ... PCH_PIC_INT_POL + 7:
+        val = s->int_polarity;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "pch_pic_read: Bad address 0x%"PRIx64"\n", addr);
@@ -224,27 +230,10 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
 static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
                                         unsigned size)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    uint64_t val = 0;
+    uint64_t val;
 
     addr += PCH_PIC_INT_STATUS;
-    switch (addr) {
-    case PCH_PIC_INT_STATUS:
-        val = (uint32_t)(s->intisr & (~s->int_mask));
-        break;
-    case PCH_PIC_INT_STATUS + 4:
-        val = (s->intisr & (~s->int_mask)) >> 32;
-        break;
-    case PCH_PIC_INT_POL:
-        val = (uint32_t)s->int_polarity;
-        break;
-    case PCH_PIC_INT_POL + 4:
-        val = s->int_polarity >> 32;
-        break;
-    default:
-        break;
-    }
-
+    val = loongarch_pch_pic_read(opaque, addr, size);
     trace_loongarch_pch_pic_high_readw(size, addr, val);
     return val;
 }
-- 
2.39.3


