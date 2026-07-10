Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED5FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBWU-0005h8-Ix; Fri, 10 Jul 2026 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBWR-0005gy-9b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wiBWP-0007wf-8O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783691043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o10a9PmdrxxnK12AiOG0SQyRxqkkmB7MBvnveQHEQ2Y=;
 b=HBzhNopaMUsMSFnUG8/OIzs3xB5FkqLXlbd0PWsETqxwMPKzATbp7zKLesUlhdp/GQZwui
 Kx73qxtUiyLT0BPSZn+KQcfIz9V07qb7gfegDvFKYcAgnvAWk4TaN7y2D+y20ImF/f6zaW
 tPhbrY4O4o/huaL6LGBLsAld2b+YIJM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-UTkbOYn4Mgedty-TfxhqrQ-1; Fri,
 10 Jul 2026 09:44:02 -0400
X-MC-Unique: UTkbOYn4Mgedty-TfxhqrQ-1
X-Mimecast-MFC-AGG-ID: UTkbOYn4Mgedty-TfxhqrQ_1783691041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7847A1955D7E
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:43:58 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3132F1800594; Fri, 10 Jul 2026 13:43:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
Date: Fri, 10 Jul 2026 17:43:52 +0400
Message-ID: <20260710134352.2313675-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Snapshot chunk.data_size into a host-local variable before passing it to
qxl_phys2virt() for validation, and pass it through qxl_cursor() and
qxl_unpack_chunks() so that no subsequent code re-reads the field.

Without this, a racing vCPU can inflate data_size between the
qxl_phys2virt() validation and the memcpy in qxl_unpack_chunks(),
causing a source read past the validated region. In practice the read
stays within the guest's own VRAM mmap, so the impact is limited.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3757
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 hw/display/qxl-render.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 3bf634ee059..4799c9e8bef 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -217,7 +217,8 @@ void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie)
 }
 
 static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
-                              QXLDataChunk *chunk, uint32_t group_id)
+                              QXLDataChunk *chunk, uint32_t group_id,
+                              uint32_t chunk_data_size)
 {
     uint32_t max_chunks = 32;
     size_t offset = 0;
@@ -225,22 +226,21 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
     QXLPHYSICAL next_chunk_phys = 0;
 
     for (;;) {
-        bytes = MIN(size - offset, chunk->data_size);
+        bytes = MIN(size - offset, chunk_data_size);
         memcpy(dest + offset, chunk->data, bytes);
         offset += bytes;
         if (offset == size) {
             return;
         }
         next_chunk_phys = chunk->next_chunk;
-        /* fist time, only get the next chunk's data size */
         chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
                               sizeof(QXLDataChunk));
         if (!chunk) {
             return;
         }
-        /* second time, check data size and get data */
+        chunk_data_size = chunk->data_size;
         chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
-                              sizeof(QXLDataChunk) + chunk->data_size);
+                              sizeof(QXLDataChunk) + chunk_data_size);
         if (!chunk) {
             return;
         }
@@ -252,7 +252,7 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
 }
 
 static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
-                              uint32_t group_id)
+                              uint32_t group_id, uint32_t chunk_data_size)
 {
     QEMUCursor *c;
     uint8_t *and_mask, *xor_mask;
@@ -272,11 +272,11 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
     case SPICE_CURSOR_TYPE_MONO:
         /* Assume that the full cursor is available in a single chunk. */
         size = 2 * cursor_get_mono_bpl(c) * c->height;
-        if (size != cursor->data_size || cursor->chunk.data_size < size) {
+        if (size != cursor->data_size || chunk_data_size < size) {
             qxl_set_guest_bug(qxl, "%s: bad monochrome cursor %ux%u"
                               " data_size %u chunk_size %u",
                               __func__, c->width, c->height,
-                              cursor->data_size, cursor->chunk.data_size);
+                              cursor->data_size, chunk_data_size);
             goto fail;
         }
         and_mask = cursor->chunk.data;
@@ -288,7 +288,8 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
         break;
     case SPICE_CURSOR_TYPE_ALPHA:
         size = sizeof(uint32_t) * c->width * c->height;
-        qxl_unpack_chunks(c->data, size, qxl, &cursor->chunk, group_id);
+        qxl_unpack_chunks(c->data, size, qxl, &cursor->chunk, group_id,
+                          chunk_data_size);
         if (qxl->debug > 2) {
             cursor_print_ascii_art(c, "qxl/alpha");
         }
@@ -325,19 +326,23 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
     }
     switch (cmd->type) {
     case QXL_CURSOR_SET:
+    {
+        uint32_t chunk_data_size;
+
         /* First read the QXLCursor to get QXLDataChunk::data_size ... */
         cursor = qxl_phys2virt(qxl, cmd->u.set.shape, ext->group_id,
                                sizeof(QXLCursor));
         if (!cursor) {
             return 1;
         }
+        chunk_data_size = cursor->chunk.data_size;
         /* Then read including the chunked data following QXLCursor. */
         cursor = qxl_phys2virt(qxl, cmd->u.set.shape, ext->group_id,
-                               sizeof(QXLCursor) + cursor->chunk.data_size);
+                               sizeof(QXLCursor) + chunk_data_size);
         if (!cursor) {
             return 1;
         }
-        c = qxl_cursor(qxl, cursor, ext->group_id);
+        c = qxl_cursor(qxl, cursor, ext->group_id, chunk_data_size);
         if (c == NULL) {
             c = cursor_builtin_left_ptr();
         }
@@ -351,6 +356,7 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
         qemu_mutex_unlock(&qxl->ssd.lock);
         qemu_bh_schedule(qxl->ssd.cursor_bh);
         break;
+    }
     case QXL_CURSOR_MOVE:
         qemu_mutex_lock(&qxl->ssd.lock);
         qxl->ssd.mouse_x = cmd->u.position.x;
-- 
2.55.0


