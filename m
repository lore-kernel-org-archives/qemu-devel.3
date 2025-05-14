Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C68C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF74L-0002dQ-Gd; Wed, 14 May 2025 04:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uF74J-0002cm-Lz
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uF74H-0002Dj-EH
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxWXEKTiRo2FbmAA--.47663S3;
 Wed, 14 May 2025 16:02:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XkTSRofwHRAA--.9319S13;
 Wed, 14 May 2025 16:02:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 11/17] hw/intc/loongarch_pch: Use generic write callback for
 iomem32_high region
Date: Wed, 14 May 2025 15:39:21 +0800
Message-Id: <20250514073927.2424543-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250514073927.2424543-1-gaosong@loongson.cn>
References: <20250514073927.2424543-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XkTSRofwHRAA--.9319S13
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

Add iomem32_high region register write operation emulation in generic
write function loongarch_pch_pic_write(), and use this function for
iomem32_high region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250507023148.1877287-12-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 07f9b07b09..50bcc23d7d 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -158,6 +158,9 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
     case PCH_PIC_AUTO_CTRL1:
         /* Discard auto_ctrl access */
         break;
+    case PCH_PIC_INT_POL:
+        s->int_polarity = (s->int_polarity & ~mask) | data;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "pch_pic_write: Bad address 0x%"PRIx64"\n", addr);
@@ -226,14 +229,6 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
     return val;
 }
 
-static uint64_t get_writew_val(uint64_t value, uint32_t target, bool hi)
-{
-    uint64_t mask = 0xffffffff00000000;
-    uint64_t data = target;
-
-    return hi ? (value & ~mask) | (data << 32) : (value & mask) | data;
-}
-
 static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
                                          uint64_t value, unsigned size)
 {
@@ -255,22 +250,9 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
 static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
                                      uint64_t value, unsigned size)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    uint32_t data = (uint32_t)value;
-
     addr += PCH_PIC_INT_STATUS;
-    trace_loongarch_pch_pic_high_writew(size, addr, data);
-
-    switch (addr) {
-    case PCH_PIC_INT_POL:
-        s->int_polarity = get_writew_val(s->int_polarity, data, 0);
-        break;
-    case PCH_PIC_INT_POL + 4:
-        s->int_polarity = get_writew_val(s->int_polarity, data, 1);
-        break;
-    default:
-        break;
-    }
+    trace_loongarch_pch_pic_high_writew(size, addr, value);
+    loongarch_pch_pic_write(opaque, addr, value, size);
 }
 
 static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
-- 
2.34.1


