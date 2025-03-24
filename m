Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD59BC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 09:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweFt-0007MA-PH; Mon, 24 Mar 2025 05:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tweFq-0007L3-Qn
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tweFo-0001Tn-NJ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:58 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxC3LoJ+FnTfujAA--.13417S3;
 Mon, 24 Mar 2025 17:37:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsfaJ+FnGn1dAA--.15661S15;
 Mon, 24 Mar 2025 17:37:44 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/16] hw/intc/loongarch_pch: Use unified trace event for
 memory region ops
Date: Mon, 24 Mar 2025 17:37:27 +0800
Message-Id: <20250324093730.3683378-14-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324093730.3683378-1-maobibo@loongson.cn>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfaJ+FnGn1dAA--.15661S15
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
---
 hw/intc/loongarch_pch_pic.c | 24 ++++++------------------
 hw/intc/trace-events        |  8 ++------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index bc4dd697d2..ff1e5992bd 100644
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
         pch_pic_write(opaque, addr, value, 0xFF);
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


