Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03CCCEF166
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 12:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9h2-0008I1-O3; Tue, 08 Oct 2024 08:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9gW-0007an-D6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9gU-0002TO-9O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728391885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgYzvGfMU9ZP3288OSkdcgQovJGODKQfEShGEk8xYmc=;
 b=KC5rR0GFPuw9/yGTWSc8WiJGx5E/Wm6O6LEh97WrI4AxzkQe4O3ROE6Enn9hYB8zXwa2dQ
 n8ckP6doqxpq9HGSSotjYQSKUReTdI7jBazLemeS0yWsgxBg8HyZugqBhDfA6laP+fzXBj
 0X3e72nhBoSzfcOJdcl+QnbyWd04Jkc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-5poxncyoMleKhuymLAGbqA-1; Tue,
 08 Oct 2024 08:51:22 -0400
X-MC-Unique: 5poxncyoMleKhuymLAGbqA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB3831943CFB; Tue,  8 Oct 2024 12:51:20 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 631DD19560A3; Tue,  8 Oct 2024 12:51:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, belmouss@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 09/19] ui/pixman: generalize shared_image_destroy
Date: Tue,  8 Oct 2024 16:50:18 +0400
Message-ID: <20241008125028.1177932-10-marcandre.lureau@redhat.com>
In-Reply-To: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
References: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Learn to free memfd-allocated shared memory.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-pixman.h |  2 +-
 hw/display/virtio-gpu.c  |  4 ++--
 ui/console.c             |  2 +-
 ui/qemu-pixman.c         | 20 ++++++++++++--------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index e3dd72b9e3..a97f56d09a 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -97,7 +97,7 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
 
 void qemu_pixman_image_unref(pixman_image_t *image);
 
-void qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data);
+void qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(pixman_image_t, qemu_pixman_image_unref)
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 017a0f170c..77f6e76f23 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -298,7 +298,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
             bits, c2d.height ? res->hostmem / c2d.height : 0);
 #ifdef WIN32
         if (res->image) {
-            pixman_image_set_destroy_function(res->image, qemu_pixman_win32_image_destroy, res->handle);
+            pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
         }
 #endif
     }
@@ -1317,7 +1317,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 #ifdef WIN32
-        pixman_image_set_destroy_function(res->image, qemu_pixman_win32_image_destroy, res->handle);
+        pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
 #endif
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
diff --git a/ui/console.c b/ui/console.c
index 8f416ff0b9..fdd76c2be4 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -487,7 +487,7 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
 #ifdef WIN32
     qemu_displaysurface_win32_set_handle(surface, handle, 0);
     pixman_image_set_destroy_function(surface->image,
-                                      qemu_pixman_win32_image_destroy, handle);
+                                      qemu_pixman_shared_image_destroy, handle);
 #endif
     return surface;
 }
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 3870e1a215..46a91e7f7a 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "ui/console.h"
+#include "qemu/memfd.h"
 #include "standard-headers/drm/drm_fourcc.h"
 #include "trace.h"
 
@@ -269,16 +270,19 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
 }
 #endif /* CONFIG_PIXMAN */
 
-#ifdef WIN32
 void
-qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data)
+qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data)
 {
+    void *ptr = pixman_image_get_data(image);
+
+#ifdef WIN32
     HANDLE handle = data;
 
-    qemu_win32_map_free(
-        pixman_image_get_data(image),
-        handle,
-        &error_warn
-    );
-}
+    qemu_win32_map_free(ptr, handle, &error_warn);
+#else
+    int shmfd = GPOINTER_TO_INT(data);
+    size_t size = pixman_image_get_height(image) * pixman_image_get_stride(image);
+
+    qemu_memfd_free(ptr, size, shmfd);
 #endif
+}
-- 
2.47.0


