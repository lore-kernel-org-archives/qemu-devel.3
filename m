Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E12C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWSg-0004do-2w; Wed, 22 Jul 2026 08:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRL-0002hv-P4; Wed, 22 Jul 2026 08:52:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRJ-0002S5-Jp; Wed, 22 Jul 2026 08:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=W9ZWu8jClDeBqXTuB10O9Lz+YYopjsdes2bAYV10UE8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z4rJEghBTF/QXmaG3ZYor177TzFnCAH+d7sJIUrhCFvf9LY4lQdrdDX+O4HA/bDFj
 Cqhb0vk7fitS186GNNwg5A0ug8zX14ke0TTL7xQoHOyEbfzHblc2HGkDv8278lUWgb
 jhEGpG75mJ8MwB2UEHE5SVp61IW64sulns8kkTvwm4KnPV5roAo4CPXIQTjhiulxZ6
 lBwwZmoc1dxpwIIjHMlDsN7YXqxVELPdnD9c+kihuj/B/3srSGiZT9Fe64BvoZkTWn
 1AokqLIsHxMFBcfZgROe1Do/L7CycO4u/FWJ/x6qe7MX/a/atRcOgfpTUqZmpP1EBA
 E9GKjhLGY5GKw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA8711C3B3D;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1F3A93F378D;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B58DA17F4F; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 096/127] hw/display/qxl: fix TOCTOU in cursor chunk
 data_size handling
Date: Wed, 22 Jul 2026 15:48:21 +0300
Message-ID: <20260722124859.32371-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260710134352.2313675-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit a3cc0069e151e5eb5db57bb4e86b00861d5b97ab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 1fe63b6f5ca..cf0f6849cd0 100644
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
2.47.3


