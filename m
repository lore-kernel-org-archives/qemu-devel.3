Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF5FC36008
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 03:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txdSz-0006vM-KB; Wed, 26 Mar 2025 22:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSx-0006uE-I7
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSu-0007eh-Fo
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso612839a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743044370; x=1743649170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=th8ONn47n1N39VwqSrZXDPi4AfiPl05PuU27NT3wHrA=;
 b=le4GkD8gmqVfU7j/4Tzg+L3sqjPY/i7DuirQSpM+57vKu+HcUJPNP+RqAXy7lTjICw
 +un5p24QEcf+X/h2QLmtgkwUss388QWsG5lUPRvje/Cz9RZ37F6r6QvJY3YyYnCw6EL7
 9ftyPoqCbRS77U1pfedvkD0OO0546PxRVQP/HBWmM48Vl7dakyJPutEeUiMv5ieDN2Su
 cBZMTk6/p64twKdGHXpTOMemcIm9WSVWXRbYkhTRUF/S4GhNYppv3HoXzerY0I25iYVK
 WwXI0q15ErfOP09k4AWq/2Vl0X9x2/A0vpqyYrG+CKA0OfsGJBqzIcvXJGjmCciVF5Va
 Smcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743044370; x=1743649170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=th8ONn47n1N39VwqSrZXDPi4AfiPl05PuU27NT3wHrA=;
 b=lAkcPf8Len0phuJViYC+HPUBko7dMhr32S//uflpxaCulf1qxinqUEejpm2YzEyvSt
 AkllXrwtqzvH18awhmDUG7oSJ9jqMiq5Aljp/8SjvLSs3dQSOnAcb8an/jNphnBpWJpa
 tbR7h7ALtEdk6Gy2lumq4624LN8j5snm8RaBWCAH04rHstinZQrCkNTsQv8mLQWjN2SE
 Qk1kMjiNrOSgfXYjRh5go+OARZSXGQzwK0EFqprTtK2zJUodt9e3XR/HC9vwp7sTS8PO
 we5TR5A4FFPRea7XkWqhHqHMpJBw+TBZ58i9ih8IGxUIbCe/Kg9+djlS5TNWTjvMaP7F
 ksBQ==
X-Gm-Message-State: AOJu0YwwAUJzAnKq6arfWhXNHySH0/Wem4y+RuoTZyMsdyL1Sfva8QUB
 mm0oENdli0WjOG6t4n9SmMcCxm+0MEMWmpdUISGokNbvHVy6O/OIk4ZvDvXf
X-Gm-Gg: ASbGncuPlR5BM21EpScTDtTw0/1PiTDKv/MwqxxckAaG96MT1B+IK6Y0tEWjb9NaXqk
 AF9GVPySvPxaJ5nMHbX2zMlJxxOwR/plV2vf6MWtJsRKDJkRW8dNaw+InC977G4xz2Y2z8QQFs+
 +9NtTWztRQZXoz3c4ajiEIKd6M9T6wWGqE8RW1gpnGmQ6pQIYnAfB0ActADvd3Yr80M7O2p9+Xp
 Hf0WDnmBTGFuI8VghKkBDWgi1aZ7c3a4v0Lf+xArO7CJdq4R+rxEnaljWzVzUBVM7Gh1E+amzWu
 rkUweoFs03ZS5BMGw/EhjZ8DTZ2FaMvmnsx5sc8fLmmlr+ApmFNdu2NOXFU9pFxCvIg+XjH8xiz
 4LrbTBNEolqVpk4Lp18fh5ike1hVaBvU=
X-Google-Smtp-Source: AGHT+IGgnI9Efor6PynWNqg+OodWUk/k7SVKelEJTZhNU9XV3NyEu8W2964kUZdmWDET737zO3M+sQ==
X-Received: by 2002:a17:90b:534d:b0:2f9:c144:9d13 with SMTP id
 98e67ed59e1d1-303a906c683mr2954254a91.24.1743044370216; 
 Wed, 26 Mar 2025 19:59:30 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd37e5sm1027698a91.2.2025.03.26.19.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:59:29 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 3/6] ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
Date: Thu, 27 Mar 2025 10:58:45 +0800
Message-ID: <20250327025848.46962-4-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327025848.46962-1-yuq825@gmail.com>
References: <20250327025848.46962-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=yuq825@gmail.com; helo=mail-pj1-x1033.google.com
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


