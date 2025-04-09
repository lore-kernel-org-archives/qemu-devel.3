Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08477C369A5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LKj-0007gZ-Q9; Tue, 08 Apr 2025 22:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u2LKf-0007UD-T7
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:38:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u2LKd-0007tq-Th
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:38:29 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8DxC3Jg3fVnJ6+1AA--.40159S3;
 Wed, 09 Apr 2025 10:37:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowMBxLsdY3fVnnsR1AA--.28294S14;
 Wed, 09 Apr 2025 10:37:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 12/16] hw/intc/loongarch_pch: Use generic write callback
 for iomem8 region
Date: Wed,  9 Apr 2025 10:37:07 +0800
Message-Id: <20250409023711.2960618-13-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250409023711.2960618-1-maobibo@loongson.cn>
References: <20250409023711.2960618-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsdY3fVnnsR1AA--.28294S14
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyfKrW3WFWfGF1xtw1xXrc_yoW5Jr47pr
 W3Zryaqr4DJFsrWFs7Ja4DZr1xWFn7W34S9a90ka40kr98ZryDXFyDJ34kWFyjk34xArW8
 Xrs5CryY9a1UW3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
 x0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
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

Add iomem8 region register write operation emulation in generic write
function loongarch_pch_pic_write(), and use this function for iomem8
region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 7477e92ac5..adff2288a0 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -123,7 +123,7 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint32_t offset;
-    uint64_t old, mask, data;
+    uint64_t old, mask, data, *ptemp;
 
     offset = addr & 7;
     addr -= offset;
@@ -161,6 +161,14 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
     case PCH_PIC_INT_POL:
         s->int_polarity = (s->int_polarity & ~mask) | data;
         break;
+    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
+        ptemp = (uint64_t *)(s->htmsi_vector + addr - PCH_PIC_HTMSI_VEC);
+        *ptemp = (*ptemp & ~mask) | data;
+        break;
+    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
+        ptemp = (uint64_t *)(s->route_entry + addr - PCH_PIC_ROUTE_ENTRY);
+        *ptemp = (*ptemp & ~mask) | data;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "pch_pic_write: Bad address 0x%"PRIx64"\n", addr);
@@ -269,28 +277,9 @@ static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
 static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
                                      uint64_t data, unsigned size)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    int32_t offset_tmp;
-
     addr += PCH_PIC_ROUTE_ENTRY;
     trace_loongarch_pch_pic_writeb(size, addr, data);
-
-    switch (addr) {
-    case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
-        offset_tmp = addr - PCH_PIC_HTMSI_VEC;
-        if (offset_tmp >= 0 && offset_tmp < 64) {
-            s->htmsi_vector[offset_tmp] = (uint8_t)(data & 0xff);
-        }
-        break;
-    case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
-        offset_tmp = addr - PCH_PIC_ROUTE_ENTRY;
-        if (offset_tmp >= 0 && offset_tmp < 64) {
-            s->route_entry[offset_tmp] = (uint8_t)(data & 0xff);
-        }
-        break;
-    default:
-        break;
-    }
+    loongarch_pch_pic_write(opaque, addr, data, size);
 }
 
 static const MemoryRegionOps loongarch_pch_pic_reg32_low_ops = {
-- 
2.39.3


