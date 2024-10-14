Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D88D16261
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LKz-0003qu-Q5; Mon, 14 Oct 2024 09:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LK2-00034P-Iu
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LJw-00045a-9c
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728913271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aDPpFX5DLEm9zmiyLMs7pY3vXptKKQ32+254JvuIV2E=;
 b=hhnTdFnZJ3RfEzBtlTrRZjP6/mtSAxdV613GSIA6jTLv7oOzuP2Ki1ma4Jb91pbHjyeuDa
 w0wjOOsFPVHawsGaORIq8JvkyFEdWSYezDkv2IdYDhPejagMjGLlzK6jbDb/dKmQ6SVjyW
 3BDs2Nk4keRV4sLb06Y77Vx2BEH18ZI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-5rCfL9rZOZK0rW7CZaYcYA-1; Mon,
 14 Oct 2024 09:41:10 -0400
X-MC-Unique: 5rCfL9rZOZK0rW7CZaYcYA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 438F519560B6; Mon, 14 Oct 2024 13:41:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 922A219560A2; Mon, 14 Oct 2024 13:41:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 18/20] ui: refactor using a common qemu_pixman_shareable
Date: Mon, 14 Oct 2024 17:39:33 +0400
Message-ID: <20241014133935.470709-19-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-1-marcandre.lureau@redhat.com>
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Use a common shareable type for win32 & unix, and helper functions.
This simplify the code as it avoids a lot of #ifdef'ery.

Note: if it helps review, commits could be reordered to introduce the
common type before introducing shareable memory for unix.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-19-marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  6 +--
 include/ui/qemu-pixman.h       | 24 +++++++++-
 include/ui/surface.h           | 20 +++------
 hw/display/virtio-gpu.c        | 72 ++++++++----------------------
 ui/console.c                   | 80 ++++++++++++----------------------
 ui/dbus-listener.c             | 12 ++---
 ui/qemu-pixman.c               | 68 +++++++++++++++++++++++++----
 7 files changed, 142 insertions(+), 140 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7509d13265..e343110e23 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -51,11 +51,7 @@ struct virtio_gpu_simple_resource {
     unsigned int iov_cnt;
     uint32_t scanout_bitmask;
     pixman_image_t *image;
-#ifdef WIN32
-    HANDLE handle;
-#else
-    int shmfd;
-#endif
+    qemu_pixman_shareable share_handle;
     uint64_t hostmem;
 
     uint64_t blob_size;
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index a97f56d09a..193bc046d1 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -12,6 +12,8 @@
 #include "pixman-minimal.h"
 #endif
 
+#include "qapi/error.h"
+
 /*
  * pixman image formats are defined to be native endian,
  * that means host byte order on qemu.  So we go define
@@ -97,7 +99,27 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
 
 void qemu_pixman_image_unref(pixman_image_t *image);
 
-void qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data);
+#ifdef WIN32
+typedef HANDLE qemu_pixman_shareable;
+#define SHAREABLE_NONE (NULL)
+#define SHAREABLE_TO_PTR(handle) (handle)
+#define PTR_TO_SHAREABLE(ptr) (ptr)
+#else
+typedef int qemu_pixman_shareable;
+#define SHAREABLE_NONE (-1)
+#define SHAREABLE_TO_PTR(handle) GINT_TO_POINTER(handle)
+#define PTR_TO_SHAREABLE(ptr) GPOINTER_TO_INT(ptr)
+#endif
+
+bool qemu_pixman_image_new_shareable(
+    pixman_image_t **image,
+    qemu_pixman_shareable *handle,
+    const char *name,
+    pixman_format_code_t format,
+    int width,
+    int height,
+    int rowstride_bytes,
+    Error **errp);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(pixman_image_t, qemu_pixman_image_unref)
 
diff --git a/include/ui/surface.h b/include/ui/surface.h
index 37d03be4af..f16f7be8be 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -23,13 +23,8 @@ typedef struct DisplaySurface {
     GLenum gltype;
     GLuint texture;
 #endif
-#ifdef WIN32
-    HANDLE handle;
-    uint32_t handle_offset;
-#else
-    int shmfd;
-    uint32_t shmfd_offset;
-#endif
+    qemu_pixman_shareable share_handle;
+    uint32_t share_handle_offset;
 } DisplaySurface;
 
 PixelFormat qemu_default_pixelformat(int bpp);
@@ -40,13 +35,10 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
 DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
 DisplaySurface *qemu_create_placeholder_surface(int w, int h,
                                                 const char *msg);
-#ifdef WIN32
-void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
-                                          HANDLE h, uint32_t offset);
-#else
-void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
-                                   int shmfd, uint32_t offset);
-#endif
+
+void qemu_displaysurface_set_share_handle(DisplaySurface *surface,
+                                          qemu_pixman_shareable handle,
+                                          uint32_t offset);
 
 DisplaySurface *qemu_create_displaysurface(int width, int height);
 void qemu_free_displaysurface(DisplaySurface *surface);
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 23ebefa59c..49fd803393 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -239,20 +239,6 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
     return height * stride;
 }
 
-static void
-resource_set_image_destroy(struct virtio_gpu_simple_resource *res)
-{
-    if (!res) {
-        return;
-    }
-#ifdef WIN32
-    void *data = res->handle;
-#else
-    void *data = GINT_TO_POINTER(res->shmfd);
-#endif
-    pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, data);
-}
-
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -299,21 +285,17 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
 
     res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
     if (res->hostmem + g->hostmem < g->conf_max_hostmem) {
-        void *bits = NULL;
-#ifdef WIN32
-        bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
-#else
-        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
-#endif
-        if (!bits) {
+        if (!qemu_pixman_image_new_shareable(
+                &res->image,
+                &res->share_handle,
+                "virtio-gpu res",
+                pformat,
+                c2d.width,
+                c2d.height,
+                c2d.height ? res->hostmem / c2d.height : 0,
+                &error_warn)) {
             goto end;
         }
-        res->image = pixman_image_create_bits(
-            pformat,
-            c2d.width,
-            c2d.height,
-            bits, c2d.height ? res->hostmem / c2d.height : 0);
-        resource_set_image_destroy(res);
     }
 
 end:
@@ -687,11 +669,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
         /* realloc the surface ptr */
         scanout->ds = qemu_create_displaysurface_pixman(rect);
-#ifdef WIN32
-        qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, fb->offset);
-#else
-        qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, fb->offset);
-#endif
+        qemu_displaysurface_set_share_handle(scanout->ds, res->share_handle, fb->offset);
 
         pixman_image_unref(rect);
         dpy_gfx_replace_surface(g->parent_obj.scanout[scanout_id].con,
@@ -1287,7 +1265,6 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
     uint32_t resource_id, pformat;
-    void *bits = NULL;
     int i;
 
     g->hostmem = 0;
@@ -1314,24 +1291,17 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         }
 
         res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
-#ifdef WIN32
-        bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
-#else
-        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
-#endif
-        if (!bits) {
-            g_free(res);
-            return -EINVAL;
-        }
-        res->image = pixman_image_create_bits(
-            pformat,
-            res->width, res->height,
-            bits, res->height ? res->hostmem / res->height : 0);
-        if (!res->image) {
+        if (!qemu_pixman_image_new_shareable(&res->image,
+                                             &res->share_handle,
+                                             "virtio-gpu res",
+                                             pformat,
+                                             res->width,
+                                             res->height,
+                                             res->height ? res->hostmem / res->height : 0,
+                                             &error_warn)) {
             g_free(res);
             return -EINVAL;
         }
-        resource_set_image_destroy(res);
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
@@ -1464,11 +1434,7 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
                 return -EINVAL;
             }
             scanout->ds = qemu_create_displaysurface_pixman(res->image);
-#ifdef WIN32
-            qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
-#else
-            qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, 0);
-#endif
+            qemu_displaysurface_set_share_handle(scanout->ds, res->share_handle, 0);
             dpy_gfx_replace_surface(scanout->con, scanout->ds);
         }
 
diff --git a/ui/console.c b/ui/console.c
index 3a2aaba3c7..5165f17125 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -453,61 +453,26 @@ qemu_graphic_console_init(Object *obj)
 {
 }
 
-#ifdef WIN32
-void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
-                                          HANDLE h, uint32_t offset)
+void qemu_displaysurface_set_share_handle(DisplaySurface *surface,
+                                          qemu_pixman_shareable handle,
+                                          uint32_t offset)
 {
-    assert(!surface->handle);
+    assert(surface->share_handle == SHAREABLE_NONE);
 
-    surface->handle = h;
-    surface->handle_offset = offset;
-}
-#else
-void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
-                                   int shmfd, uint32_t offset)
-{
-    assert(surface->shmfd == -1);
+    surface->share_handle = handle;
+    surface->share_handle_offset = offset;
 
-    surface->shmfd = shmfd;
-    surface->shmfd_offset = offset;
 }
-#endif
 
 DisplaySurface *qemu_create_displaysurface(int width, int height)
 {
-    DisplaySurface *surface;
-    void *bits = NULL;
-#ifdef WIN32
-    HANDLE handle = NULL;
-#else
-    int shmfd = -1;
-#endif
-
     trace_displaysurface_create(width, height);
 
-#ifdef WIN32
-    bits = qemu_win32_map_alloc(width * height * 4, &handle, &error_abort);
-#else
-    bits = qemu_memfd_alloc("displaysurface", width * height * 4, 0, &shmfd, &error_abort);
-#endif
-
-    surface = qemu_create_displaysurface_from(
+    return qemu_create_displaysurface_from(
         width, height,
         PIXMAN_x8r8g8b8,
-        width * 4, bits
+        width * 4, NULL
     );
-    surface->flags = QEMU_ALLOCATED_FLAG;
-
-#ifdef WIN32
-    qemu_displaysurface_win32_set_handle(surface, handle, 0);
-    void *data = handle;
-#else
-    qemu_displaysurface_set_shmfd(surface, shmfd, 0);
-    void *data = GINT_TO_POINTER(shmfd);
-#endif
-    pixman_image_set_destroy_function(surface->image, qemu_pixman_shared_image_destroy, data);
-
-    return surface;
 }
 
 DisplaySurface *qemu_create_displaysurface_from(int width, int height,
@@ -517,14 +482,25 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
     DisplaySurface *surface = g_new0(DisplaySurface, 1);
 
     trace_displaysurface_create_from(surface, width, height, format);
-#ifndef WIN32
-    surface->shmfd = -1;
-#endif
-    surface->image = pixman_image_create_bits(format,
-                                              width, height,
-                                              (void *)data, linesize);
-    assert(surface->image != NULL);
+    surface->share_handle = SHAREABLE_NONE;
 
+    if (data) {
+        surface->image = pixman_image_create_bits(format,
+                                                  width, height,
+                                                  (void *)data, linesize);
+    } else {
+        qemu_pixman_image_new_shareable(&surface->image,
+                                        &surface->share_handle,
+                                        "displaysurface",
+                                        format,
+                                        width,
+                                        height,
+                                        linesize,
+                                        &error_abort);
+        surface->flags = QEMU_ALLOCATED_FLAG;
+    }
+
+    assert(surface->image != NULL);
     return surface;
 }
 
@@ -533,9 +509,7 @@ DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
     DisplaySurface *surface = g_new0(DisplaySurface, 1);
 
     trace_displaysurface_create_pixman(surface);
-#ifndef WIN32
-    surface->shmfd = -1;
-#endif
+    surface->share_handle = SHAREABLE_NONE;
     surface->image = pixman_image_ref(image);
 
     return surface;
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index ec47946282..99738e769b 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -336,13 +336,13 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
         return true;
     }
 
-    if (!ddl->can_share_map || !ddl->ds->handle) {
+    if (!ddl->can_share_map || !ddl->ds->share_handle) {
         return false;
     }
 
     success = DuplicateHandle(
         GetCurrentProcess(),
-        ddl->ds->handle,
+        ddl->ds->share_handle,
         ddl->peer_process,
         &target_handle,
         FILE_MAP_READ | SECTION_QUERY,
@@ -359,7 +359,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     if (!qemu_dbus_display1_listener_win32_map_call_scanout_map_sync(
             ddl->map_proxy,
             GPOINTER_TO_UINT(target_handle),
-            ddl->ds->handle_offset,
+            ddl->ds->share_handle_offset,
             surface_width(ddl->ds),
             surface_height(ddl->ds),
             surface_stride(ddl->ds),
@@ -453,13 +453,13 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
         return true;
     }
 
-    if (!ddl->can_share_map || ddl->ds->shmfd == -1) {
+    if (!ddl->can_share_map || ddl->ds->share_handle == SHAREABLE_NONE) {
         return false;
     }
 
     ddl_discard_display_messages(ddl);
     fd_list = g_unix_fd_list_new();
-    if (g_unix_fd_list_append(fd_list, ddl->ds->shmfd, &err) != 0) {
+    if (g_unix_fd_list_append(fd_list, ddl->ds->share_handle, &err) != 0) {
         g_debug("Failed to setup scanout map fdlist: %s", err->message);
         ddl->can_share_map = false;
         return false;
@@ -468,7 +468,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     if (!qemu_dbus_display1_listener_unix_map_call_scanout_map_sync(
             ddl->map_proxy,
             g_variant_new_handle(0),
-            ddl->ds->shmfd_offset,
+            ddl->ds->share_handle_offset,
             surface_width(ddl->ds),
             surface_height(ddl->ds),
             surface_stride(ddl->ds),
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 46a91e7f7a..6ef4376f4e 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -270,19 +270,71 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
 }
 #endif /* CONFIG_PIXMAN */
 
-void
-qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data)
+static void *
+qemu_pixman_shareable_alloc(const char *name, size_t size,
+                            qemu_pixman_shareable *handle,
+                            Error **errp)
 {
-    void *ptr = pixman_image_get_data(image);
-
 #ifdef WIN32
-    HANDLE handle = data;
+    return qemu_win32_map_alloc(size, handle, errp);
+#else
+    return qemu_memfd_alloc(name, size, 0, handle, errp);
+#endif
+}
 
+static void
+qemu_pixman_shareable_free(qemu_pixman_shareable handle,
+                           void *ptr, size_t size)
+{
+#ifdef WIN32
     qemu_win32_map_free(ptr, handle, &error_warn);
 #else
-    int shmfd = GPOINTER_TO_INT(data);
+    qemu_memfd_free(ptr, size, handle);
+#endif
+}
+
+static void
+qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data)
+{
+    qemu_pixman_shareable handle = PTR_TO_SHAREABLE(data);
+    void *ptr = pixman_image_get_data(image);
     size_t size = pixman_image_get_height(image) * pixman_image_get_stride(image);
 
-    qemu_memfd_free(ptr, size, shmfd);
-#endif
+    qemu_pixman_shareable_free(handle, ptr, size);
+}
+
+bool
+qemu_pixman_image_new_shareable(pixman_image_t **image,
+                                qemu_pixman_shareable *handle,
+                                const char *name,
+                                pixman_format_code_t format,
+                                int width,
+                                int height,
+                                int rowstride_bytes,
+                                Error **errp)
+{
+    ERRP_GUARD();
+    size_t size = height * rowstride_bytes;
+    void *bits = NULL;
+
+    g_return_val_if_fail(image != NULL, false);
+    g_return_val_if_fail(handle != NULL, false);
+
+    bits = qemu_pixman_shareable_alloc(name, size, handle, errp);
+    if (!bits) {
+        return false;
+    }
+
+    *image = pixman_image_create_bits(format, width, height, bits, rowstride_bytes);
+    if (!*image) {
+        error_setg(errp, "Failed to allocate image");
+        qemu_pixman_shareable_free(*handle, bits, size);
+        return false;
+    }
+
+    pixman_image_set_destroy_function(*image,
+                                      qemu_pixman_shared_image_destroy,
+                                      SHAREABLE_TO_PTR(*handle));
+
+    return true;
 }
-- 
2.47.0


