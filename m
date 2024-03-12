Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2ADC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2j0-0001uj-DX; Tue, 12 Mar 2024 10:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2iV-0001e9-SK
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1rk2iR-0008Rd-3p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nRAyJeY2x33dvmwZDqay6qGt0gfRKNRzAy2DtSFyxc=;
 b=HnrX9Mn2yBd8x3ZMsnDIkKD0yYn/nlvxjn+y9cWBpiVrEAn/4SDLY7IkQl7qSI6xwtk7+o
 f0OHQO8D2B5WTC2JN06psK7y8r3Tn8AcycjASTDNTJPeVexuSA99wTdD8vf/RjdSe57YZe
 KXT4CkwPyeTRMevtSBoMZeQGwS0wFpI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-R7XkFR3kNxiHghg9eN6kiw-1; Tue,
 12 Mar 2024 10:02:48 -0400
X-MC-Unique: R7XkFR3kNxiHghg9eN6kiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ED033CBDF63;
 Tue, 12 Mar 2024 14:02:48 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC49E1121306;
 Tue, 12 Mar 2024 14:02:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 5/5] virtio-gpu: fix scanout migration post-load
Date: Tue, 12 Mar 2024 18:02:16 +0400
Message-ID: <20240312140216.313618-6-marcandre.lureau@redhat.com>
In-Reply-To: <20240312140216.313618-1-marcandre.lureau@redhat.com>
References: <20240312140216.313618-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The current post-loading code for scanout has a FIXME: it doesn't take
the resource region/rect into account. But there is more, when adding
blob migration support in commit f66767f75c9, I didn't realize that blob
resources could be used for scanouts. This situationn leads to a crash
during post-load, as they don't have an associated res->image.

virtio_gpu_do_set_scanout() handle all cases, but requires the
associated virtio_gpu_framebuffer, which is currently not saved during
migration.

Add a v2 of "virtio-gpu-one-scanout" with the framebuffer fields, so we
can restore blob scanouts, as well as fixing the existing FIXME.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu.c        | 51 +++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index b28e7ef0d2..ed44cdad6b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -81,6 +81,7 @@ struct virtio_gpu_scanout {
     uint32_t resource_id;
     struct virtio_gpu_update_cursor cursor;
     QEMUCursor *current_cursor;
+    struct virtio_gpu_framebuffer fb;
 };
 
 struct virtio_gpu_requested_state {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ccbe31d759..78d5a4f164 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -600,6 +600,7 @@ static void virtio_unref_resource(pixman_image_t *image, void *data)
 static void virtio_gpu_update_scanout(VirtIOGPU *g,
                                       uint32_t scanout_id,
                                       struct virtio_gpu_simple_resource *res,
+                                      struct virtio_gpu_framebuffer *fb,
                                       struct virtio_gpu_rect *r)
 {
     struct virtio_gpu_simple_resource *ores;
@@ -617,9 +618,10 @@ static void virtio_gpu_update_scanout(VirtIOGPU *g,
     scanout->y = r->y;
     scanout->width = r->width;
     scanout->height = r->height;
+    scanout->fb = *fb;
 }
 
-static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
+static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
                                       uint32_t scanout_id,
                                       struct virtio_gpu_framebuffer *fb,
                                       struct virtio_gpu_simple_resource *res,
@@ -645,7 +647,7 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
                       r->x, r->y, r->width, r->height,
                       fb->width, fb->height);
         *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
-        return;
+        return false;
     }
 
     g->parent_obj.enable = 1;
@@ -653,11 +655,12 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
     if (res->blob) {
         if (console_has_gl(scanout->con)) {
             if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
-                virtio_gpu_update_scanout(g, scanout_id, res, r);
+                virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
             } else {
                 *error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
+                return false;
             }
-            return;
+            return true;
         }
 
         data = res->blob;
@@ -693,7 +696,8 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
                                 scanout->ds);
     }
 
-    virtio_gpu_update_scanout(g, scanout_id, res, r);
+    virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
+    return true;
 }
 
 static void virtio_gpu_set_scanout(VirtIOGPU *g,
@@ -1164,7 +1168,8 @@ static void virtio_gpu_cursor_bh(void *opaque)
 
 static const VMStateDescription vmstate_virtio_gpu_scanout = {
     .name = "virtio-gpu-one-scanout",
-    .version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(resource_id, struct virtio_gpu_scanout),
         VMSTATE_UINT32(width, struct virtio_gpu_scanout),
@@ -1176,6 +1181,12 @@ static const VMStateDescription vmstate_virtio_gpu_scanout = {
         VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
         VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
+        VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
+        VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -1347,6 +1358,7 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
         if (!res->blob_size) {
             continue;
         }
+        assert(!res->image);
         qemu_put_be32(f, res->resource_id);
         qemu_put_be32(f, res->blob_size);
         qemu_put_be32(f, res->iov_cnt);
@@ -1409,21 +1421,40 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
     int i;
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        /* FIXME: should take scanout.r.{x,y} into account */
         scanout = &g->parent_obj.scanout[i];
         if (!scanout->resource_id) {
             continue;
         }
+
         res = virtio_gpu_find_resource(g, scanout->resource_id);
         if (!res) {
             return -EINVAL;
         }
-        scanout->ds = qemu_create_displaysurface_pixman(res->image);
+
+        if (scanout->fb.format != 0) {
+            uint32_t error = 0;
+            struct virtio_gpu_rect r = {
+                .x = scanout->x,
+                .y = scanout->y,
+                .width = scanout->width,
+                .height = scanout->height
+            };
+
+            if (!virtio_gpu_do_set_scanout(g, i, &scanout->fb, res, &r, &error)) {
+                return -EINVAL;
+            }
+        } else {
+            /* legacy v1 migration support */
+            if (!res->image) {
+                return -EINVAL;
+            }
+            scanout->ds = qemu_create_displaysurface_pixman(res->image);
 #ifdef WIN32
-        qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
+            qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
 #endif
+            dpy_gfx_replace_surface(scanout->con, scanout->ds);
+        }
 
-        dpy_gfx_replace_surface(scanout->con, scanout->ds);
         dpy_gfx_update_full(scanout->con);
         if (scanout->cursor.resource_id) {
             update_cursor(g, &scanout->cursor);
-- 
2.44.0


