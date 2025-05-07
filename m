Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F37C3ABBC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUfc-0001Av-A3; Tue, 06 May 2025 22:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uCUfa-0001Ad-LM
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:38:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uCUfY-0001Ct-Js
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:38:02 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxYa+ExxpopJ3XAA--.50850S3;
 Wed, 07 May 2025 10:37:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxrhuDxxpoyuO4AA--.24683S2;
 Wed, 07 May 2025 10:37:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 12/16] hw/intc/loongarch_pch: Use generic write callback
 for iomem8 region
Date: Wed,  7 May 2025 10:37:50 +0800
Message-Id: <20250507023754.1877445-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250507023148.1877287-1-maobibo@loongson.cn>
References: <20250507023148.1877287-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhuDxxpoyuO4AA--.24683S2
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

Add iomem8 region register write operation emulation in generic write
function loongarch_pch_pic_write(), and use this function for iomem8
region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 50bcc23d7d..556349a150 100644
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


