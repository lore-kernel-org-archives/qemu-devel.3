Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E60C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SJ-00007L-H8; Wed, 17 Jul 2024 07:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SG-0008TG-TM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:16 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SC-0006zN-Qr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:16 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id CDF8F379608; Mon, 15 Jul 2024 23:07:37 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 02/26] hw/vmapple/apple-gfx: BQL renaming update
Date: Mon, 15 Jul 2024 23:06:41 +0200
Message-Id: <20240715210705.32365-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

Since the original apple-gfx code was written, the BQL functions have
been renamed. This change updates the apple-gfx code to use the new
names.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/vmapple/apple-gfx.m | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/vmapple/apple-gfx.m b/hw/vmapple/apple-gfx.m
index f75da5c610..3b437e2519 100644
--- a/hw/vmapple/apple-gfx.m
+++ b/hw/vmapple/apple-gfx.m
@@ -168,9 +168,9 @@ static void apple_gfx_write(void *opaque, hwaddr offset, uint64_t val, unsigned
 
     trace_apple_gfx_write(offset, val);
 
-    qemu_mutex_unlock_iothread();
+    bql_unlock();
     [s->pgdev mmioWriteAtOffset:offset value:val];
-    qemu_mutex_lock_iothread();
+    bql_lock();
 }
 
 static const MemoryRegionOps apple_gfx_ops = {
@@ -192,9 +192,9 @@ static uint64_t apple_iosfc_read(void *opaque, hwaddr offset, unsigned size)
     AppleGFXState *s = opaque;
     uint64_t res = 0;
 
-    qemu_mutex_unlock_iothread();
+    bql_unlock();
     res = [s->pgiosfc mmioReadAtOffset:offset];
-    qemu_mutex_lock_iothread();
+    bql_lock();
 
     trace_apple_iosfc_read(offset, res);
 
@@ -396,7 +396,7 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
             PGPhysicalMemoryRange_t *range = &ranges[i];
             MemoryRegion *tmp_mr;
             /* TODO: Bounds checks? r/o? */
-            qemu_mutex_lock_iothread();
+            bql_lock();
             AppleGFXMR *mr = apple_gfx_mapMemory(s, task, virtualOffset,
                                                  range->physicalAddress,
                                                  range->physicalLength);
@@ -416,7 +416,7 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
             trace_apple_gfx_remap(retval, source, target);
             g_assert(retval == KERN_SUCCESS);
 
-            qemu_mutex_unlock_iothread();
+            bql_unlock();
 
             virtualOffset += mr->len;
         }
@@ -428,7 +428,7 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         AppleGFXMR *mr, *next;
 
         trace_apple_gfx_unmap_memory(task, virtualOffset, length);
-        qemu_mutex_lock_iothread();
+        bql_lock();
         QTAILQ_FOREACH_SAFE(mr, &s->mrs, node, next) {
             if (mr->va >= (task->mem + virtualOffset) &&
                 (mr->va + mr->len) <= (task->mem + virtualOffset + length)) {
@@ -438,7 +438,7 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
                 g_free(mr);
             }
         }
-        qemu_mutex_unlock_iothread();
+        bql_unlock();
         return (bool)true;
     };
 
@@ -452,13 +452,13 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
         bool locked;
 
         trace_apple_gfx_raise_irq(vector);
-        locked = qemu_mutex_iothread_locked();
+        locked = bql_locked();
         if (!locked) {
-            qemu_mutex_lock_iothread();
+            bql_lock();
         }
         qemu_irq_pulse(s->irq_gfx);
         if (!locked) {
-            qemu_mutex_unlock_iothread();
+            bql_unlock();
         }
     };
 
@@ -534,13 +534,13 @@ static void apple_gfx_realize(DeviceState *dev, Error **errp)
 
     iosfc_desc.raiseInterrupt = ^(uint32_t vector) {
         trace_apple_iosfc_raise_irq(vector);
-        bool locked = qemu_mutex_iothread_locked();
+        bool locked = bql_locked();
         if (!locked) {
-            qemu_mutex_lock_iothread();
+            bql_lock();
         }
         qemu_irq_pulse(s->irq_iosfc);
         if (!locked) {
-            qemu_mutex_unlock_iothread();
+            bql_unlock();
         }
         return (bool)true;
     };
-- 
2.39.3 (Apple Git-146)


