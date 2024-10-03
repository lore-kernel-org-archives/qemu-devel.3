Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCCACF857D
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJwI-0001Wj-SJ; Thu, 03 Oct 2024 07:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwG-0001Pm-Mm
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwE-00052a-Fu
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLtN/eJi0jEtNnqKXNI/I3UkikTEjDXYtaunchUMmik=;
 b=SNs3s4nj4AvUqBNZDHEGnCTkjcqH+mAiWoF4DU2fxHEcgDmRYxYb3GUPzIGcPfHNh1arYM
 mNh47kLsjKDqroUGqmMyLzTy2xy/8ZMCWFJbgkqpEN1XB+bvCVedAaMTldxeHDRqplBBFs
 r4sovost/RtDEITE5Hj3DJVPrQgqqwU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-GpZXzFWSMQutBH7OHymI-g-1; Thu,
 03 Oct 2024 07:24:04 -0400
X-MC-Unique: GpZXzFWSMQutBH7OHymI-g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AA091955EB4; Thu,  3 Oct 2024 11:24:03 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 877321956054; Thu,  3 Oct 2024 11:24:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 15/16] virtio-gpu: allocate shareable 2d resources on !win32
Date: Thu,  3 Oct 2024 15:22:42 +0400
Message-ID: <20241003112244.3340697-16-marcandre.lureau@redhat.com>
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

Similar to what was done in commit 9462ff46 ("virtio-gpu/win32: allocate
shareable 2d resources/images") for win32, allocate resource memory with
memfd, so the associated display surface memory can be shared with a
different process.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  4 ++-
 hw/display/virtio-gpu.c        | 47 ++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a59379f5a..a0d715198b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -51,7 +51,9 @@ struct virtio_gpu_simple_resource {
     unsigned int iov_cnt;
     uint32_t scanout_bitmask;
     pixman_image_t *image;
-#ifdef WIN32
+#ifndef WIN32
+    int shmfd;
+#else
     HANDLE handle;
 #endif
     uint64_t hostmem;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 77f6e76f23..295d0afca3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -28,6 +28,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
+#include "qemu/memfd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -238,6 +239,20 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
     return height * stride;
 }
 
+static void
+resource_set_image_destroy(struct virtio_gpu_simple_resource *res)
+{
+    if (!res) {
+        return;
+    }
+#ifndef WIN32
+    void *data = GINT_TO_POINTER(res->shmfd);
+#else
+    void *data = res->handle;
+#endif
+    pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, data);
+}
+
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -285,27 +300,23 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
     if (res->hostmem + g->hostmem < g->conf_max_hostmem) {
         void *bits = NULL;
-#ifdef WIN32
+#ifndef WIN32
+        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
+#else
         bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+#endif
         if (!bits) {
             goto end;
         }
-#endif
         res->image = pixman_image_create_bits(
             pformat,
             c2d.width,
             c2d.height,
             bits, c2d.height ? res->hostmem / c2d.height : 0);
-#ifdef WIN32
-        if (res->image) {
-            pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
-        }
-#endif
+        resource_set_image_destroy(res);
     }
 
-#ifdef WIN32
 end:
-#endif
     if (!res->image) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: resource creation failed %d %d %d\n",
@@ -676,7 +687,9 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
         /* realloc the surface ptr */
         scanout->ds = qemu_create_displaysurface_pixman(rect);
-#ifdef WIN32
+#ifndef WIN32
+        qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, fb->offset);
+#else
         qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, fb->offset);
 #endif
 
@@ -1301,13 +1314,15 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         }
 
         res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
-#ifdef WIN32
+#ifndef WIN32
+        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
+#else
         bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+#endif
         if (!bits) {
             g_free(res);
             return -EINVAL;
         }
-#endif
         res->image = pixman_image_create_bits(
             pformat,
             res->width, res->height,
@@ -1316,9 +1331,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             g_free(res);
             return -EINVAL;
         }
-#ifdef WIN32
-        pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
-#endif
+        resource_set_image_destroy(res);
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
@@ -1451,7 +1464,9 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
                 return -EINVAL;
             }
             scanout->ds = qemu_create_displaysurface_pixman(res->image);
-#ifdef WIN32
+#ifndef WIN32
+            qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, 0);
+#else
             qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
 #endif
             dpy_gfx_replace_surface(scanout->con, scanout->ds);
-- 
2.45.2.827.g557ae147e6


