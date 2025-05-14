Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BDEC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF748-0002Z9-Ai; Wed, 14 May 2025 04:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uF746-0002YI-9N
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uF743-0002Ad-SK
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxvnP8TSRov1bmAA--.14603S3;
 Wed, 14 May 2025 16:02:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XkTSRofwHRAA--.9319S7;
 Wed, 14 May 2025 16:02:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 05/17] hw/intc/loongarch_pch: Use relative address in
 MemoryRegionOps
Date: Wed, 14 May 2025 15:39:15 +0800
Message-Id: <20250514073927.2424543-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250514073927.2424543-1-gaosong@loongson.cn>
References: <20250514073927.2424543-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XkTSRofwHRAA--.9319S7
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

Parameter address for read and write callback in MemoryRegionOps is
relative offset with base address of this MemoryRegionOps. It can
be directly used as offset and offset calculation can be removed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250507023148.1877287-6-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
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
2.34.1


