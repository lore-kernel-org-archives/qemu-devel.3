Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FC0C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXaH-0002ze-Ow; Wed, 07 May 2025 01:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXaG-0002xi-FV
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXaE-0004Iq-ME
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746596681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqIiwI0nuPMPJMDZ848BPwmG+uxZqiqZjJU8OBeIAw0=;
 b=e5+AzP54C6kSDklbkpKUig9NgBIUrTZq3kZKYefjrxNJTVKlOoSHOFyNVp8Q36Ko3gdKjm
 hItG2ZL6ERdePaWjgAFQb1rv/AEFJ+hRtKRlqsV9hoLF2qj+N80czlVvzp/0bMbigh+1DE
 toflTbisEmWEK846ltk9cJf2be+8sDY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-wfGPzBYBOG2wQPX0kKhOSw-1; Wed,
 07 May 2025 01:44:40 -0400
X-MC-Unique: wfGPzBYBOG2wQPX0kKhOSw-1
X-Mimecast-MFC-AGG-ID: wfGPzBYBOG2wQPX0kKhOSw_1746596679
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 649B6195396F; Wed,  7 May 2025 05:44:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A761918001DA; Wed,  7 May 2025 05:44:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PULL 3/6] ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
Date: Wed,  7 May 2025 09:44:11 +0400
Message-ID: <20250507054414.2284129-4-marcandre.lureau@redhat.com>
In-Reply-To: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
References: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Qiang Yu <yuq825@gmail.com>

0 is used as DRM_FORMAT_MOD_LINEAR already.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Message-ID: <20250327025848.46962-4-yuq825@gmail.com>
---
 hw/display/vhost-user-gpu.c     | 3 ++-
 hw/display/virtio-gpu-udmabuf.c | 4 +++-
 ui/egl-helpers.c                | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index a367daac82..43d4c08a2e 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -18,6 +18,7 @@
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include "standard-headers/drm/drm_fourcc.h"
 
 typedef enum VhostUserGpuRequest {
     VHOST_USER_GPU_NONE = 0,
@@ -251,7 +252,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         int fd = qemu_chr_fe_get_msgfd(&g->vhost_chr);
         uint32_t offset = 0;
         uint32_t stride = m->fd_stride;
-        uint64_t modifier = 0;
+        uint64_t modifier = DRM_FORMAT_MOD_INVALID;
         QemuDmaBuf *dmabuf;
 
         if (m->scanout_id >= g->parent_obj.conf.max_outputs) {
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 01b0024ead..d804f321aa 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -25,6 +25,7 @@
 #include <linux/memfd.h>
 #include "qemu/memfd.h"
 #include "standard-headers/linux/udmabuf.h"
+#include "standard-headers/drm/drm_fourcc.h"
 
 static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 {
@@ -187,7 +188,8 @@ static VGPUDMABuf
                                   &offset, &fb->stride,
                                   r->x, r->y, fb->width, fb->height,
                                   qemu_pixman_to_drm_format(fb->format),
-                                  0, &res->dmabuf_fd, 1, true, false);
+                                  DRM_FORMAT_MOD_INVALID, &res->dmabuf_fd,
+                                  1, true, false);
     dmabuf->scanout_id = scanout_id;
     QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
 
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 432863d702..8c0e394d2b 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -23,6 +23,7 @@
 #include "system/system.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "standard-headers/drm/drm_fourcc.h"
 
 EGLDisplay *qemu_egl_display;
 EGLConfig qemu_egl_config;
@@ -333,7 +334,7 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     attrs[i++] = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
     attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
     attrs[i++] = 0;
-    if (modifier) {
+    if (modifier != DRM_FORMAT_MOD_INVALID) {
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
         attrs[i++] = (modifier >>  0) & 0xffffffff;
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
-- 
2.49.0


