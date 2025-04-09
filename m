Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BC1C369A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LKh-0007YC-QE; Tue, 08 Apr 2025 22:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u2LKe-0007QQ-Ph
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:38:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u2LKc-0007tm-Jm
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:38:28 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8BxrOJf3fVnJa+1AA--.1208S3;
 Wed, 09 Apr 2025 10:37:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowMBxLsdY3fVnnsR1AA--.28294S13;
 Wed, 09 Apr 2025 10:37:18 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 11/16] hw/intc/loongarch_pch: Use generic write callback
 for iomem32_high region
Date: Wed,  9 Apr 2025 10:37:06 +0800
Message-Id: <20250409023711.2960618-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250409023711.2960618-1-maobibo@loongson.cn>
References: <20250409023711.2960618-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsdY3fVnnsR1AA--.28294S13
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFykJr1DJF4fAF15Ar1fAFc_yoW8tryxpr
 W3Zry3Ka1DtFnrXF1kAa45Zr97JFn7W34a9anIk3409rn8Zrn8uF1kJFyIgFyjk34fJryj
 qr4ruFyYga1UG3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
 0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2F4iUUUUU
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

Add iomem32_high region register write operation emulation in generic
write function loongarch_pch_pic_write(), and use this function for
iomem32_high region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 84f3bd1a2e..7477e92ac5 100644
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
2.39.3


