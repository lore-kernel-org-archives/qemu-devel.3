Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937DECCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB27-00080I-Ah; Sat, 17 Oct 2026 16:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1F-0006Qq-UT; Sat, 17 Oct 2026 16:28:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1E-00040A-16; Sat, 17 Oct 2026 16:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268846; bh=/ILOQd/M8FwF35Uq6itv0TONqfJkBHBNThJfrD3Mu+8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RsDLNFeTQ9cNLArg5Ajg/id9j5o+9Eq1yXSq6wiFlNJVJlO/yDf/neKUoU61moX9A
 G/N6fuzifp4UVzwKoj/CZESB5pjnyOFPU6hYV/UHd4yJzY1oEO6N5v+GPYm14ZmA5D
 exDVuDCQ9lMWedSGZctI6Lgc0KSlwLTBQ1E1tD9texxhDhxgv7hbLXO6OJ05yOEcyr
 EUYOMHE4+1PmMLppNGvRa2PLzrXVcK5PMkmq6bHcZQaocK1diff5EocUwPrHearp1F
 8cxS/vH1cKv7iZxrfSC1bWvbt1YVWiOvbEvchp2oV8Xv0p5SSwKphbMzMluX0/G/0v
 pCP6iOBmDUwJw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82F4B1DE752;
 Sat, 17 Oct 2026 23:27:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C4FDF443428;
 Sat, 17 Oct 2026 23:27:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 22/73] hw/display/qxl: factor out qxl_guest_phys2virt()
Date: Sat, 17 Oct 2026 23:25:40 +0300
Message-ID: <20261017202638.728621-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Split the GROUP_GUEST half of qxl_phys2virt() into the helper
qxl_guest_phys2virt().  Also add a bool 'report_bug' param to the
qxl_get_check_slot_offset() called from it: when it's false, a failing
check just returns false without calling qxl_set_guest_bug().  All
existing callers pass true, so there's no functional change.  This
is in preparation for a quiet caller that validates guest addresses
which might be legitimately stale, when flagging a guest bug would be
wrong.

Message-ID: <20260825172051.435372-2-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
(cherry picked from commit 050f5408bfcff56a65aed6d9ab81e35f4ba82631)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c4f547e88b..b6bc182fc2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1409,7 +1409,7 @@ static void qxl_reset_surfaces(PCIQXLDevice *d)
 /* can be also called from spice server thread context */
 static bool qxl_get_check_slot_offset(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
                                       uint32_t *s, uint64_t *o,
-                                      size_t size_requested)
+                                      size_t size_requested, bool report_bug)
 {
     uint64_t phys   = le64_to_cpu(pqxl);
     uint32_t slot   = (phys >> (64 -  8)) & 0xff;
@@ -1417,42 +1417,55 @@ static bool qxl_get_check_slot_offset(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
     uint64_t size_available;
 
     if (slot >= NUM_MEMSLOTS) {
-        qxl_set_guest_bug(qxl, "slot too large %d >= %d", slot,
-                          NUM_MEMSLOTS);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl, "slot too large %d >= %d", slot,
+                              NUM_MEMSLOTS);
+        }
         return false;
     }
     if (!qxl->guest_slots[slot].active) {
-        qxl_set_guest_bug(qxl, "inactive slot %d\n", slot);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl, "inactive slot %d\n", slot);
+        }
         return false;
     }
     if (offset < qxl->guest_slots[slot].delta) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" < delta %"PRIu64"\n",
-                          slot, offset, qxl->guest_slots[slot].delta);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" < delta %"PRIu64"\n",
+                              slot, offset, qxl->guest_slots[slot].delta);
+        }
         return false;
     }
     offset -= qxl->guest_slots[slot].delta;
     if (offset > qxl->guest_slots[slot].size) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" > size %"PRIu64"\n",
-                          slot, offset, qxl->guest_slots[slot].size);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" > size %"PRIu64"\n",
+                              slot, offset, qxl->guest_slots[slot].size);
+        }
         return false;
     }
     size_available = memory_region_size(qxl->guest_slots[slot].mr);
     if (qxl->guest_slots[slot].offset + offset >= size_available) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" > region size %"PRIu64"\n",
-                          slot, qxl->guest_slots[slot].offset + offset,
-                          size_available);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" > region size %"PRIu64
+                              "\n", slot,
+                              qxl->guest_slots[slot].offset + offset,
+                              size_available);
+        }
         return false;
     }
     size_available -= qxl->guest_slots[slot].offset + offset;
     if (size_requested > size_available) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" size %zu: "
-                          "overrun by %"PRIu64" bytes\n",
-                          slot, offset, size_requested,
-                          size_requested - size_available);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" size %zu: "
+                              "overrun by %"PRIu64" bytes\n",
+                              slot, offset, size_requested,
+                              size_requested - size_available);
+        }
         return false;
     }
 
@@ -1462,25 +1475,31 @@ static bool qxl_get_check_slot_offset(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
 }
 
 /* can be also called from spice server thread context */
-void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL pqxl, int group_id,
-                    size_t size)
+static void *qxl_guest_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
+                                 size_t size, bool report_bug)
 {
     uint64_t offset;
     uint32_t slot;
-    void *ptr;
+    uint8_t *ptr;
 
+    if (!qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size,
+                                   report_bug)) {
+        return NULL;
+    }
+    ptr  = memory_region_get_ram_ptr(qxl->guest_slots[slot].mr);
+    ptr += qxl->guest_slots[slot].offset;
+    ptr += offset;
+    return ptr;
+}
+
+void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL pqxl, int group_id,
+                    size_t size)
+{
     switch (group_id) {
     case MEMSLOT_GROUP_HOST:
-        offset = le64_to_cpu(pqxl) & 0xffffffffffff;
-        return (void *)(intptr_t)offset;
+        return (void *)(intptr_t)(le64_to_cpu(pqxl) & 0xffffffffffff);
     case MEMSLOT_GROUP_GUEST:
-        if (!qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size)) {
-            return NULL;
-        }
-        ptr = memory_region_get_ram_ptr(qxl->guest_slots[slot].mr);
-        ptr += qxl->guest_slots[slot].offset;
-        ptr += offset;
-        return ptr;
+        return qxl_guest_phys2virt(qxl, pqxl, size, true);
     }
     return NULL;
 }
@@ -2003,7 +2022,7 @@ static void qxl_dirty_one_surface(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
     bool rc;
 
     size = (uint64_t)height * abs(stride);
-    rc = qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size);
+    rc = qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size, true);
     assert(rc == true);
     trace_qxl_surfaces_dirty(qxl->id, offset, size);
     qxl_set_dirty(qxl->guest_slots[slot].mr,
-- 
2.47.3


