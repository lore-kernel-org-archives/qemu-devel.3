Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95CBC369A5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LJj-0006Vv-RO; Tue, 08 Apr 2025 22:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u2LJh-0006Uh-DS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:37:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u2LJc-0007nT-Si
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:37:29 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8AxDGte3fVnIq+1AA--.39723S3;
 Wed, 09 Apr 2025 10:37:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowMBxLsdY3fVnnsR1AA--.28294S12;
 Wed, 09 Apr 2025 10:37:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 10/16] hw/intc/loongarch_pch: Use generic write callback
 for iomem32_low region
Date: Wed,  9 Apr 2025 10:37:05 +0800
Message-Id: <20250409023711.2960618-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250409023711.2960618-1-maobibo@loongson.cn>
References: <20250409023711.2960618-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsdY3fVnnsR1AA--.28294S12
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF48AFyUuF1xKF1rCw47Jrc_yoWrtFy3pr
 W3ZF9IyF4DtF17WFs7u3s8Zr1xJFn7u3saga9xK3409rWDJ3s5WF1DXr92gF1Yk3sxJr4j
 gr45uFWY9a1UX3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 hw/intc/loongarch_pch_pic.c | 140 +++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 67 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 06fac16211..84f3bd1a2e 100644
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


