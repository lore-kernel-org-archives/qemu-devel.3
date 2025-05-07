Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7144FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUaT-0002du-Cl; Tue, 06 May 2025 22:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uCUaM-0002cb-Gj
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:32:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uCUaJ-0000q4-R5
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:32:38 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx32s2xhpospvXAA--.26446S3;
 Wed, 07 May 2025 10:32:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxj8UUxhpoKeC4AA--.11788S12;
 Wed, 07 May 2025 10:32:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 10/16] hw/intc/loongarch_pch: Use generic write callback
 for iomem32_low region
Date: Wed,  7 May 2025 10:31:42 +0800
Message-Id: <20250507023148.1877287-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250507023148.1877287-1-maobibo@loongson.cn>
References: <20250507023148.1877287-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8UUxhpoKeC4AA--.11788S12
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

For memory region iomem32_low, generic write callback is used.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 140 +++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 67 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index dbfc178e5d..07f9b07b09 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -118,6 +118,53 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
     return (val >> (offset * 8)) & field_mask;
 }
 
+static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
+                          uint64_t field_mask)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
+    uint32_t offset;
+    uint64_t old, mask, data;
+
+    offset = addr & 7;
+    addr -= offset;
+    mask = field_mask << (offset * 8);
+    data = (value & field_mask) << (offset * 8);
+    switch (addr) {
+    case PCH_PIC_INT_MASK:
+        old = s->int_mask;
+        s->int_mask = (old & ~mask) | data;
+        if (old & ~data) {
+            pch_pic_update_irq(s, old & ~data, 1);
+        }
+
+        if (~old & data) {
+            pch_pic_update_irq(s, ~old & data, 0);
+        }
+        break;
+    case PCH_PIC_INT_EDGE:
+        s->intedge = (s->intedge & ~mask) | data;
+        break;
+    case PCH_PIC_INT_CLEAR:
+        if (s->intedge & data) {
+            s->intirr &= ~data;
+            pch_pic_update_irq(s, data, 0);
+            s->intisr &= ~data;
+        }
+        break;
+    case PCH_PIC_HTMSI_EN:
+        s->htmsi_en = (s->htmsi_en & ~mask) | data;
+        break;
+    case PCH_PIC_AUTO_CTRL0:
+    case PCH_PIC_AUTO_CTRL1:
+        /* Discard auto_ctrl access */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pch_pic_write: Bad address 0x%"PRIx64"\n", addr);
+        break;
+    }
+}
+
 static uint64_t loongarch_pch_pic_read(void *opaque, hwaddr addr,
                                        unsigned size)
 {
@@ -145,6 +192,30 @@ static uint64_t loongarch_pch_pic_read(void *opaque, hwaddr addr,
     return val;
 }
 
+static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        pch_pic_write(opaque, addr, value, UCHAR_MAX);
+        break;
+    case 2:
+        pch_pic_write(opaque, addr, value, USHRT_MAX);
+        break;
+        break;
+    case 4:
+        pch_pic_write(opaque, addr, value, UINT_MAX);
+        break;
+    case 8:
+        pch_pic_write(opaque, addr, value, UINT64_MAX);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "loongarch_pch_pic_write: Bad size %d\n", size);
+        break;
+    }
+}
+
 static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
                                             unsigned size)
 {
@@ -166,73 +237,8 @@ static uint64_t get_writew_val(uint64_t value, uint32_t target, bool hi)
 static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
                                          uint64_t value, unsigned size)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    uint32_t old_valid, data = (uint32_t)value;
-    uint64_t old, int_mask;
-
-    trace_loongarch_pch_pic_low_writew(size, addr, data);
-
-    switch (addr) {
-    case PCH_PIC_INT_MASK:
-        old = s->int_mask;
-        s->int_mask = get_writew_val(old, data, 0);
-        old_valid = (uint32_t)old;
-        if (old_valid & ~data) {
-            pch_pic_update_irq(s, (old_valid & ~data), 1);
-        }
-        if (~old_valid & data) {
-            pch_pic_update_irq(s, (~old_valid & data), 0);
-        }
-        break;
-    case PCH_PIC_INT_MASK + 4:
-        old = s->int_mask;
-        s->int_mask = get_writew_val(old, data, 1);
-        old_valid = (uint32_t)(old >> 32);
-        int_mask = old_valid & ~data;
-        if (int_mask) {
-            pch_pic_update_irq(s, int_mask << 32, 1);
-        }
-        int_mask = ~old_valid & data;
-        if (int_mask) {
-            pch_pic_update_irq(s, int_mask << 32, 0);
-        }
-        break;
-    case PCH_PIC_INT_EDGE:
-        s->intedge = get_writew_val(s->intedge, data, 0);
-        break;
-    case PCH_PIC_INT_EDGE + 4:
-        s->intedge = get_writew_val(s->intedge, data, 1);
-        break;
-    case PCH_PIC_INT_CLEAR:
-        if (s->intedge & data) {
-            s->intirr &= (~data);
-            pch_pic_update_irq(s, data, 0);
-            s->intisr &= (~data);
-        }
-        break;
-    case PCH_PIC_INT_CLEAR + 4:
-        value <<= 32;
-        if (s->intedge & value) {
-            s->intirr &= (~value);
-            pch_pic_update_irq(s, value, 0);
-            s->intisr &= (~value);
-        }
-        break;
-    case PCH_PIC_HTMSI_EN:
-        s->htmsi_en = get_writew_val(s->htmsi_en, data, 0);
-        break;
-    case PCH_PIC_HTMSI_EN + 4:
-        s->htmsi_en = get_writew_val(s->htmsi_en, data, 1);
-        break;
-    case PCH_PIC_AUTO_CTRL0:
-    case PCH_PIC_AUTO_CTRL0 + 4:
-    case PCH_PIC_AUTO_CTRL1:
-    case PCH_PIC_AUTO_CTRL1 + 4:
-        /* discard auto_ctrl access */
-        break;
-    default:
-        break;
-    }
+    trace_loongarch_pch_pic_low_writew(size, addr, value);
+    loongarch_pch_pic_write(opaque, addr, value, size);
 }
 
 static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
-- 
2.39.3


