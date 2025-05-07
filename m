Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0F0C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUfe-0001Bc-Hi; Tue, 06 May 2025 22:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uCUfc-0001Ao-1T
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:38:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uCUfZ-0001D2-7D
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:38:03 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx63GFxxpoqJ3XAA--.26120S3;
 Wed, 07 May 2025 10:37:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxrhuDxxpoyuO4AA--.24683S3;
 Wed, 07 May 2025 10:37:56 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 13/16] hw/intc/loongarch_pch: Use unified trace event for
 memory region ops
Date: Wed,  7 May 2025 10:37:51 +0800
Message-Id: <20250507023754.1877445-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250507023754.1877445-1-maobibo@loongson.cn>
References: <20250507023148.1877287-1-maobibo@loongson.cn>
 <20250507023754.1877445-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhuDxxpoyuO4AA--.24683S3
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

Add trace event trace_loongarch_pch_pic_read(), replaces the following
three events:
  trace_loongarch_pch_pic_low_readw()
  trace_loongarch_pch_pic_high_readw()
  trace_loongarch_pch_pic_readb()
The similiar with write trace event.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 24 ++++++------------------
 hw/intc/trace-events        |  8 ++------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 556349a150..c06ef0df3f 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -200,12 +200,15 @@ static uint64_t loongarch_pch_pic_read(void *opaque, hwaddr addr,
         break;
     }
 
+    trace_loongarch_pch_pic_read(size, addr, val);
     return val;
 }
 
 static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
                                     uint64_t value, unsigned size)
 {
+    trace_loongarch_pch_pic_write(size, addr, value);
+
     switch (size) {
     case 1:
         pch_pic_write(opaque, addr, value, UCHAR_MAX);
@@ -230,55 +233,40 @@ static void loongarch_pch_pic_write(void *opaque, hwaddr addr,
 static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
                                             unsigned size)
 {
-    uint64_t val;
-
-    val = loongarch_pch_pic_read(opaque, addr, size);
-    trace_loongarch_pch_pic_low_readw(size, addr, val);
-    return val;
+    return loongarch_pch_pic_read(opaque, addr, size);
 }
 
 static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
                                          uint64_t value, unsigned size)
 {
-    trace_loongarch_pch_pic_low_writew(size, addr, value);
     loongarch_pch_pic_write(opaque, addr, value, size);
 }
 
 static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
                                         unsigned size)
 {
-    uint64_t val;
-
     addr += PCH_PIC_INT_STATUS;
-    val = loongarch_pch_pic_read(opaque, addr, size);
-    trace_loongarch_pch_pic_high_readw(size, addr, val);
-    return val;
+    return loongarch_pch_pic_read(opaque, addr, size);
 }
 
 static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
                                      uint64_t value, unsigned size)
 {
     addr += PCH_PIC_INT_STATUS;
-    trace_loongarch_pch_pic_high_writew(size, addr, value);
     loongarch_pch_pic_write(opaque, addr, value, size);
 }
 
 static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
                                         unsigned size)
 {
-    uint64_t val;
-
     addr += PCH_PIC_ROUTE_ENTRY;
-    val = loongarch_pch_pic_read(opaque, addr, size);
-    trace_loongarch_pch_pic_readb(size, addr, val);
-    return val;
+    return loongarch_pch_pic_read(opaque, addr, size);
 }
 
 static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
                                      uint64_t data, unsigned size)
 {
     addr += PCH_PIC_ROUTE_ENTRY;
-    trace_loongarch_pch_pic_writeb(size, addr, data);
     loongarch_pch_pic_write(opaque, addr, data, size);
 }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 0ba9a02e73..334aa6a97b 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -314,12 +314,8 @@ loongson_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x
 loongson_ipi_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
 # loongarch_pch_pic.c
 loongarch_pch_pic_irq_handler(int irq, int level) "irq %d level %d"
-loongarch_pch_pic_low_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
-loongarch_pch_pic_low_writew(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
-loongarch_pch_pic_high_readw(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
-loongarch_pch_pic_high_writew(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
-loongarch_pch_pic_readb(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
-loongarch_pch_pic_writeb(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
+loongarch_pch_pic_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
+loongarch_pch_pic_write(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%" PRIx64
 
 # loongarch_pch_msi.c
 loongarch_msi_set_irq(int irq_num) "set msi irq %d"
-- 
2.39.3


