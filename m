Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1EED2A555
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AN0-0005a4-8L; Wed, 16 Oct 2024 16:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMz-0005Y7-4e; Wed, 16 Oct 2024 16:11:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1AMx-0000kq-43; Wed, 16 Oct 2024 16:11:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7245F98FA2;
 Wed, 16 Oct 2024 23:10:11 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 58B75156382;
 Wed, 16 Oct 2024 23:10:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 48/49] ui/win32: fix potential use-after-free with dbus
 shared memory
Date: Wed, 16 Oct 2024 23:10:07 +0300
Message-Id: <20241016201025.256294-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

DisplaySurface may be free before the pixman image is freed, since the
image is refcounted and used by different objects, including pending
dbus messages.

Furthermore, setting the destroy function in
create_displaysurface_from() isn't appropriate, as it may not be used,
and may be overriden as in ramfb.

Set the destroy function when the shared handle is set, use the HANDLE
directly for destroy data, using a single common helper
qemu_pixman_win32_image_destroy().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-5-marcandre.lureau@redhat.com>
(cherry picked from commit 330ef31deb2e5461cff907488b710f5bd9cd2327)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3281842bfe..017a0f170c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -238,16 +238,6 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
     return height * stride;
 }
 
-#ifdef WIN32
-static void
-win32_pixman_image_destroy(pixman_image_t *image, void *data)
-{
-    HANDLE handle = data;
-
-    qemu_win32_map_free(pixman_image_get_data(image), handle, &error_warn);
-}
-#endif
-
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -308,7 +298,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
             bits, c2d.height ? res->hostmem / c2d.height : 0);
 #ifdef WIN32
         if (res->image) {
-            pixman_image_set_destroy_function(res->image, win32_pixman_image_destroy, res->handle);
+            pixman_image_set_destroy_function(res->image, qemu_pixman_win32_image_destroy, res->handle);
         }
 #endif
     }
@@ -1327,7 +1317,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 #ifdef WIN32
-        pixman_image_set_destroy_function(res->image, win32_pixman_image_destroy, res->handle);
+        pixman_image_set_destroy_function(res->image, qemu_pixman_win32_image_destroy, res->handle);
 #endif
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index ef13a8210c..e3dd72b9e3 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -97,6 +97,8 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
 
 void qemu_pixman_image_unref(pixman_image_t *image);
 
+void qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data);
+
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(pixman_image_t, qemu_pixman_image_unref)
 
 #endif /* QEMU_PIXMAN_H */
diff --git a/ui/console.c b/ui/console.c
index 105a0e2c70..8f416ff0b9 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -461,24 +461,6 @@ void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
     surface->handle = h;
     surface->handle_offset = offset;
 }
-
-static void
-win32_pixman_image_destroy(pixman_image_t *image, void *data)
-{
-    DisplaySurface *surface = data;
-
-    if (!surface->handle) {
-        return;
-    }
-
-    assert(surface->handle_offset == 0);
-
-    qemu_win32_map_free(
-        pixman_image_get_data(surface->image),
-        surface->handle,
-        &error_warn
-    );
-}
 #endif
 
 DisplaySurface *qemu_create_displaysurface(int width, int height)
@@ -504,6 +486,8 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
 
 #ifdef WIN32
     qemu_displaysurface_win32_set_handle(surface, handle, 0);
+    pixman_image_set_destroy_function(surface->image,
+                                      qemu_pixman_win32_image_destroy, handle);
 #endif
     return surface;
 }
@@ -519,10 +503,6 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
                                               width, height,
                                               (void *)data, linesize);
     assert(surface->image != NULL);
-#ifdef WIN32
-    pixman_image_set_destroy_function(surface->image,
-                                      win32_pixman_image_destroy, surface);
-#endif
 
     return surface;
 }
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 5ca55dd199..de6c88151c 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -4,6 +4,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "ui/console.h"
 #include "standard-headers/drm/drm_fourcc.h"
 #include "trace.h"
@@ -268,3 +269,17 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
     pixman_image_unref(ibg);
 }
 #endif /* CONFIG_PIXMAN */
+
+#ifdef WIN32
+void
+qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data)
+{
+    HANDLE handle = data;
+
+    qemu_win32_map_free(
+        pixman_image_get_data(image),
+        handle,
+        &error_warn
+    );
+}
+#endif
-- 
2.39.5


