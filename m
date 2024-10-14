Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868E9D16265
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LKj-0003N8-VU; Mon, 14 Oct 2024 09:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LJt-0002pc-8a
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LJr-000442-KG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728913265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbWpuOVJIQm9Y8bC0kcGQOhaiCG1voTob5RmCV0zBno=;
 b=U0+gE0GYiOyaDCoHsj0+2keCXEG3XEpcBLjX4IvPbtPzNaR9MgMgBo8Nve6dNytngSAX7t
 BX6hlOZA6vgkDHygQk/ewmmZ2mTGftbQ6iN/h7N5voNP9JWiynukBNCv949x9y++74UNRY
 Vk5oDWohX+YZxS64e37ftZbonQN4tyU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-iRSZ5c8zMnGwK9dd_n6pTQ-1; Mon,
 14 Oct 2024 09:41:04 -0400
X-MC-Unique: iRSZ5c8zMnGwK9dd_n6pTQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3797195421D; Mon, 14 Oct 2024 13:41:03 +0000 (UTC)
Received: from localhost (unknown [10.39.208.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18F4F3000198; Mon, 14 Oct 2024 13:41:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 17/20] virtio-gpu: allocate shareable 2d resources on !win32
Date: Mon, 14 Oct 2024 17:39:32 +0400
Message-ID: <20241014133935.470709-18-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-1-marcandre.lureau@redhat.com>
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Similar to what was done in commit 9462ff46 ("virtio-gpu/win32: allocate
shareable 2d resources/images") for win32, allocate resource memory with
memfd, so the associated display surface memory can be shared with a
different process.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-18-marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  2 ++
 hw/display/virtio-gpu.c        | 39 +++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a59379f5a..7509d13265 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -53,6 +53,8 @@ struct virtio_gpu_simple_resource {
     pixman_image_t *image;
 #ifdef WIN32
     HANDLE handle;
+#else
+    int shmfd;
 #endif
     uint64_t hostmem;
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 77f6e76f23..23ebefa59c 100644
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
+#ifdef WIN32
+    void *data = res->handle;
+#else
+    void *data = GINT_TO_POINTER(res->shmfd);
+#endif
+    pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, data);
+}
+
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -287,25 +302,21 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         void *bits = NULL;
 #ifdef WIN32
         bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+#else
+        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
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
@@ -678,6 +689,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         scanout->ds = qemu_create_displaysurface_pixman(rect);
 #ifdef WIN32
         qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, fb->offset);
+#else
+        qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, fb->offset);
 #endif
 
         pixman_image_unref(rect);
@@ -1303,11 +1316,13 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
 #ifdef WIN32
         bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+#else
+        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
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
@@ -1453,6 +1466,8 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
             scanout->ds = qemu_create_displaysurface_pixman(res->image);
 #ifdef WIN32
             qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
+#else
+            qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, 0);
 #endif
             dpy_gfx_replace_surface(scanout->con, scanout->ds);
         }
-- 
2.47.0


