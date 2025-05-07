Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D3EC3ABBE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 02:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCUaK-0002cD-G8; Tue, 06 May 2025 22:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uCUaB-0002aY-JW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:32:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uCUa8-0000pR-5v
 for qemu-devel@nongnu.org; Tue, 06 May 2025 22:32:27 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxlnAyxhpohZvXAA--.25648S3;
 Wed, 07 May 2025 10:32:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxj8UUxhpoKeC4AA--.11788S7;
 Wed, 07 May 2025 10:32:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 05/16] hw/intc/loongarch_pch: Use relative address in
 MemoryRegionOps
Date: Wed,  7 May 2025 10:31:37 +0800
Message-Id: <20250507023148.1877287-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250507023148.1877287-1-maobibo@loongson.cn>
References: <20250507023148.1877287-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8UUxhpoKeC4AA--.11788S7
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

Parameter address for read and write callback in MemoryRegionOps is
relative offset with base address of this MemoryRegionOps. It can
be directly used as offset and offset calculation can be removed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index f732c292f8..9b64bf938f 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -76,9 +76,8 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
-    uint32_t offset = addr & 0xfff;
 
-    switch (offset) {
+    switch (addr) {
     case PCH_PIC_INT_ID:
         val = s->id.data & UINT_MAX;
         break;
@@ -129,13 +128,12 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
                                          uint64_t value, unsigned size)
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    uint32_t offset, old_valid, data = (uint32_t)value;
+    uint32_t old_valid, data = (uint32_t)value;
     uint64_t old, int_mask;
-    offset = addr & 0xfff;
 
     trace_loongarch_pch_pic_low_writew(size, addr, data);
 
-    switch (offset) {
+    switch (addr) {
     case PCH_PIC_INT_MASK:
         old = s->int_mask;
         s->int_mask = get_writew_val(old, data, 0);
@@ -203,9 +201,9 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
-    uint32_t offset = addr + PCH_PIC_INT_STATUS;
 
-    switch (offset) {
+    addr += PCH_PIC_INT_STATUS;
+    switch (addr) {
     case PCH_PIC_INT_STATUS:
         val = (uint32_t)(s->intisr & (~s->int_mask));
         break;
@@ -230,12 +228,12 @@ static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
                                      uint64_t value, unsigned size)
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    uint32_t offset, data = (uint32_t)value;
-    offset = addr + PCH_PIC_INT_STATUS;
+    uint32_t data = (uint32_t)value;
 
+    addr += PCH_PIC_INT_STATUS;
     trace_loongarch_pch_pic_high_writew(size, addr, data);
 
-    switch (offset) {
+    switch (addr) {
     case PCH_PIC_INT_STATUS:
         s->intisr = get_writew_val(s->intisr, data, 0);
         break;
@@ -258,18 +256,18 @@ static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     uint64_t val = 0;
-    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
     int64_t offset_tmp;
 
-    switch (offset) {
+    addr += PCH_PIC_ROUTE_ENTRY;
+    switch (addr) {
     case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
-        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
+        offset_tmp = addr - PCH_PIC_HTMSI_VEC;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             val = s->htmsi_vector[offset_tmp];
         }
         break;
     case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
-        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
+        offset_tmp = addr - PCH_PIC_ROUTE_ENTRY;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             val = s->route_entry[offset_tmp];
         }
@@ -287,19 +285,19 @@ static void loongarch_pch_pic_writeb(void *opaque, hwaddr addr,
 {
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
     int32_t offset_tmp;
-    uint32_t offset = (addr & 0xfff) + PCH_PIC_ROUTE_ENTRY;
 
+    addr += PCH_PIC_ROUTE_ENTRY;
     trace_loongarch_pch_pic_writeb(size, addr, data);
 
-    switch (offset) {
+    switch (addr) {
     case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
-        offset_tmp = offset - PCH_PIC_HTMSI_VEC;
+        offset_tmp = addr - PCH_PIC_HTMSI_VEC;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             s->htmsi_vector[offset_tmp] = (uint8_t)(data & 0xff);
         }
         break;
     case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
-        offset_tmp = offset - PCH_PIC_ROUTE_ENTRY;
+        offset_tmp = addr - PCH_PIC_ROUTE_ENTRY;
         if (offset_tmp >= 0 && offset_tmp < 64) {
             s->route_entry[offset_tmp] = (uint8_t)(data & 0xff);
         }
-- 
2.39.3


