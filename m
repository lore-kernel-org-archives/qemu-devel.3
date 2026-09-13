Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6A0C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5hg4-0005er-05; Sun, 13 Sep 2026 06:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hg2-0005eV-8F
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x5hg0-0008CO-3A
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 06:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789296191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qo5UBUa5Wq7reICBsnDuVY/Ka3F5JtSwMy+sXWo0EP0=;
 b=LhPZ0rsL2kq3ftxi9xHmfCc30FM/veMWiDP2LPsDC6W9aTVk25XltkZkY9fmm8i82SqSf4
 NdxmReoZY09gUf8ZuGg5s/69hl1yFPtdVwlD5+D6R0hlzJKMgNrcBh2enmUreK5E9+VIam
 qqWoiqPMgf9hr445kwFQGkT/yAfbNpU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-MUQ8jYzYN4u5VFy4byKGWQ-1; Sun,
 13 Sep 2026 06:43:09 -0400
X-MC-Unique: MUQ8jYzYN4u5VFy4byKGWQ-1
X-Mimecast-MFC-AGG-ID: MUQ8jYzYN4u5VFy4byKGWQ_1789296188
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABC401944F2C
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1191180034C
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 10:43:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 13 Sep 2026 14:41:24 +0400
Subject: [GIT PULL 06/14] hw/display/qxl: factor out qxl_guest_phys2virt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260913-ui-v1-6-7a8d89d0423a@redhat.com>
References: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
In-Reply-To: <20260913-ui-v1-0-7a8d89d0423a@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=6743;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6o0iPNSXLAZxa0vvrSViy75OeaV1i5OvNEudE6qCI98=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpn4iIta/bi8VxX5rPUgEV6T2T3zyZFoDItA2K
 GjDwC11ZtuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqZ+IgAKCRDa6OEJdZac
 5S35D/9eLFtRboCKLF3PcJTeZ4lgSXFmLjSY1YvFEIPmCNZjrNC3By7x/Ic+uK7kBpirwjRS2ZZ
 MpNtu2EXa/Hs8vnCNmuwLbWzUk6qpAWep4WViGX/pOCMz8l2MsyP4hkJUJM96ll/d0nqe2nlpli
 cXfyRwEdhc4ZhIBQAyN2K+QK1zwM2UuvvtluTAlHf6hw9uWNkp1aD/vfhC0UYqeAMGXgNLova0w
 1JOnPqlQto33f90gdvJ4/1pwRYHyrhoTr05hfQTT2kGhCN2CucBi1P+/YimASWbHbCLtUllvUla
 +sVEgzyFWHZBeilVAIYwuJ4yZc5VzVraigUd+BTyeoxbagxuOOsXwZNVUMqwnx2dd30uCf1QMaV
 sj94850xyJMQ4WcfXvo6l3uobanYKyUifupTbg39oqJotznudo3Sz4VEXdJuVOs+5q3PjU8wbrB
 jQkGx9xPinMnyQ6T7CMejevo+Tk4Cc2s/UJsI3MMvxHXNuGbtNI1ysGDgczKfH6DvnA8Jkjgi7p
 BPxxVgw1g0x9TtZ2iquDgX8Cskf362FmXZ+3EBeLjGq4JtITQMiY3V8U/dZAv2KzjL76QJlAKhE
 b6GmWK/Lz3yUWaxxOaLXN2jiNVEW5E8wn2l0LebiBu3lJfPL49GTnyYlWI5CUqK+zBX1UB0v4AV
 aEertiBdL/yxo+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/display/qxl.c | 83 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index c4f547e88bd5..b6bc182fc2c3 100644
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
2.55.0.543.g5ebe2ebe4ea8


