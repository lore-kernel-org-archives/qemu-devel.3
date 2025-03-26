Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FBAC3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txN9s-0000ys-VX; Wed, 26 Mar 2025 05:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9q-0000xl-66
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:46 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9o-0003X4-FH
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22622ddcc35so14329555ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742981682; x=1743586482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=th8ONn47n1N39VwqSrZXDPi4AfiPl05PuU27NT3wHrA=;
 b=EONQOk9AYgGTLyrbwjGomnL9WOcqW5yrmaf2a8rhcg2Z+glOkqDlDq0zR97GAWPVzM
 wAr07Y2XkFRJj5HUVib3mEiHL79ZC4/7qHzqhR1n6xjlxvRXlK5E8EHOj20znW1fOV1w
 VY2Y4a/cEvvoDnH9GA87l2J48e8TFCkGs7UwH3VUC1e/IeCvUVZjba+guSRLhOnT9YRZ
 vpu9erIX/M1F05i80OA1HpAuRHdvgYrU7oFlX3arTO+ii63W2Ufoyb01CoMGsLFPdHNd
 kgBxqfcEmfMrYhUQhZMUbh4A/6cXVX6t0oB+uuuVjDuY94MgDeS5Qx+bjcp0Qxekck6i
 LvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742981682; x=1743586482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=th8ONn47n1N39VwqSrZXDPi4AfiPl05PuU27NT3wHrA=;
 b=mKN1bXu/m0OdqotD4V6csdoi9eoiRMoOmGrnZa/wbfDSNWsmP2AJTgXYvyHuEXZt98
 JtNSuIhA0F3i9u0tILpS+m9l2HRpQluG6FfgYFYoxv/g1GLpoY2sXzs+z6+JpVkWPnvP
 WiAsjKILb+YEmE9Rfq1hbjoL3TDQcXUfuPXUbN9aGyCvNS39mwDb1UN7UpfavJSnI5Za
 xkWbaJA4K0/gx9BCW0ry0CONLUp6HB6URCCr0byHMVzZ9EcziShgdfje9K+JCSKiidxb
 zOc+SKZ2dy2Q8bBaVIeCRpTKVRK5huIeyTFb4rbxSlHQazBBX1LFLzBKIHBzBgU8Yr2A
 g96Q==
X-Gm-Message-State: AOJu0YzVC3XlQGXj6XEj8w0ZFAAOfGZJ5K/EPoZB+gzOaBSLldLDWaVB
 7CFfjtdzL31GLYVOgx48843wRlD4ks/MGWQ9dmcQLtp62nPpvCSAnasGUB1I
X-Gm-Gg: ASbGnctdZ33Ybz2E5j3mc86fAw47AJV9rUzmKHs6WruY8hJzVgcF7B8gWZGgmHMMxzr
 9AaHk8Y3guFrhrDOnMZki30RKATbX4kiXd5fFfKdkFsMt5zs1VYbteGriBca6n5PXdPqWakNkvq
 tI5ueF6sVFBrsap6UmiWlFWdoK0DTrmZ4BGFUfOqK+ipMZCqtJW6r26xUcQU8ULrYT48MYhTkpz
 ni9zYHOyF+IJtN6dmOg4LeDSHJSLIiruSQBRVuh3PAYVEmfvEOOsjsdYmCBTD9tNKO/euPUkxOO
 ok4/dakBzbeBQv+yc8GcMdGW/AkO24YeDgHSgjg6aKTlkSh1XrBO5/BWbBHklRpp0DrJqcebybw
 8EzureRPphCZcECpl/Bkx
X-Google-Smtp-Source: AGHT+IHaPVvPdserpOCVlBnFuoEp9navTALSTvk7t0Q+gzPtz42rR9AsPZ81HCxglpPg2ZVC9ybJ2g==
X-Received: by 2002:a05:6a00:2ea0:b0:736:a8db:93b8 with SMTP id
 d2e1a72fcca58-739059803cfmr31423982b3a.3.1742981682046; 
 Wed, 26 Mar 2025 02:34:42 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd57f7sm11729684b3a.44.2025.03.26.02.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 02:34:41 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 3/6] ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
Date: Wed, 26 Mar 2025 17:34:15 +0800
Message-ID: <20250326093418.397269-4-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326093418.397269-1-yuq825@gmail.com>
References: <20250326093418.397269-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/display/vhost-user-gpu.c     | 3 ++-
 hw/display/virtio-gpu-udmabuf.c | 4 +++-
 ui/egl-helpers.c                | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index a7949c7078..a6a510db65 100644
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
index 34fbe05b7a..de6ce53f16 100644
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
2.43.0


