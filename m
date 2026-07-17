Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C0DC44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8o-0004qD-Ba; Fri, 17 Jul 2026 07:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8j-0004oy-2t
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8h-0003SU-E1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/JocELUzciLrI2R+2g24aN1QWMe8pYZXVY3rWZQaXc=;
 b=cQhAuqKsr5JBPEYBasqk9Vz7xaArFpaJgmQjBm8cE5FLXJ4jOZ6+lrVxa6LKJAyDiZ8uSi
 z399/Ccs1hXcyjBAmkBCoezEIHVDyhAMs0X/le4r5tyBYP/rMDXMfCJaBfm4hDo6mRUyYV
 NN7aCoEnYKGmuUwyOD3KZrKM3b1Ss6U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-pJVjfXucOOeYH-kWZGdU7Q-1; Fri,
 17 Jul 2026 07:53:57 -0400
X-MC-Unique: pJVjfXucOOeYH-kWZGdU7Q-1
X-Mimecast-MFC-AGG-ID: pJVjfXucOOeYH-kWZGdU7Q_1784289236
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B297C180075F
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:56 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7CB51955D86
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:49 +0400
Subject: [GIT PULL 10/15] hw/display/qxl: fix TOCTOU in cursor chunk
 data_size handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-10-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5603;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GpIUqifl/gyolM0MgyVL0mom4t/4c7mPXqLdbQ0eOAs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheayjWEFXZK9oBDZ+zk+DJ1F8tKetKCULl5o
 SG77hA4w1qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5VTeEACByQei7qBPYuTnmmBuTNGOyrIrhE7B2TaC9NtmgjxCBv5MqRzjMenwnv/z5712gfKW9Q7
 NQhEPae+zZJWezDMYEaKhKqiDI/VbeB47M21xkFaCS8OUR0jV9vqcJ5Zs5rz6KfJRihQhrxXbuI
 Cv5VGobNLRQMY659NFZIbGVeMtPUZwHY0quc0HhgvkIBHJq+qDVF6S3ENrnJsPZYpWDRO/gZS33
 PSknwlVpO/k7xWw1svibOnJDr/ocfY8FKx6Zw1+RDVg0jKu5eX0yUGeHWUDD/VvkMlMqso5FlN1
 Y3IjDXvo49OBNuEFrrhvhnkS1ZNqu9rboG9oDcCjp7KCJlZ13KEELSN52jZi20C4YRU0A4R6AIa
 hmhVeWCluhhbh8JHvzFYOO3pCgtMvbkqkHViYxSGBKtuO7T4RZFqRM5iM6T/igAfKqeGyK0m63b
 6Gp9PrLxmFv4Ph0LuAoCiO5Hvyt5R5hCUcr7lvk7yKkD+2+7bWjnH0s3TWkJR0Q69zBeGh93Cql
 l2IYz70P0oZM/+nQTHYbE84j5L//7/j2cZYNIWsokxA63ftI/PwY0bxWIRzlL7x/N6OARigaxzY
 uYDiWH41tpzONVbG/wrZ4aFCCykQrQcYh8+8WryXdoqurYdYVm9PgedacuT1410u+gkfeiPfyBv
 7FMZdns1o5aEQqQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Snapshot chunk.data_size into a host-local variable before passing it to
qxl_phys2virt() for validation, and pass it through qxl_cursor() and
qxl_unpack_chunks() so that no subsequent code re-reads the field.

Without this, a racing vCPU can inflate data_size between the
qxl_phys2virt() validation and the memcpy in qxl_unpack_chunks(),
causing a source read past the validated region. In practice the read
stays within the guest's own VRAM mmap, so the impact is limited.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3757
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


