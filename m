Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA890CF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJvS-0000jh-Cs; Thu, 03 Oct 2024 07:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJvQ-0000jY-M4
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJvO-0004sU-Tt
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+5a5aBlZpy1qKcXr/Ng3p5ltqt69gTqRbu3f7L7pJo=;
 b=dwwXrP+7DWzdks3+2GvitzZ9s+eMLkUkqadxhW1iyOMt3hjPvVIuAD5jpGrV8n874xNICO
 IrSQoBprY7Sq/EwNlWfm48DyEKYmr+tFzXUsX+0lP8rjKaNmYC6P4kKy3xvE/tkxj1ZPoc
 Xy3mTYpwlczqxGFmYLp80qXYOJmIs40=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-aLWmoE6pNVSma5PIWXX0Tg-1; Thu,
 03 Oct 2024 07:23:11 -0400
X-MC-Unique: aLWmoE6pNVSma5PIWXX0Tg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B14919560A6; Thu,  3 Oct 2024 11:23:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 468BD1956054; Thu,  3 Oct 2024 11:23:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 04/16] ui/win32: fix potential use-after-free with dbus shared
 memory
Date: Thu,  3 Oct 2024 15:22:31 +0400
Message-ID: <20241003112244.3340697-5-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 include/ui/qemu-pixman.h |  2 ++
 hw/display/virtio-gpu.c  | 14 ++------------
 ui/console.c             | 24 ++----------------------
 ui/qemu-pixman.c         | 15 +++++++++++++++
 4 files changed, 21 insertions(+), 34 deletions(-)

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
index 6cada8b45e..3870e1a215 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -4,6 +4,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "ui/console.h"
 #include "standard-headers/drm/drm_fourcc.h"
 #include "trace.h"
@@ -267,3 +268,17 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
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
2.45.2.827.g557ae147e6


