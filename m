Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E41C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twd2I-0005y0-7s; Mon, 24 Mar 2025 04:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2D-0005xH-VS
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:50 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2A-0008UW-Gm
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:49 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fb0f619dso78751135ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742804383; x=1743409183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjHWsm3dx0YdITjXUi4M45f/K0Yu/f7nUohwYX78sQ4=;
 b=E11K1VlVXdc3J45pqvFLEdDzq23XF+vNNX3FL8gAWFbuw1XBcP9rGKcqDh08f9gN4I
 VsXLbprRRGp2u4eqoJ1pgeFZqzwbFPxI0q9e6KcRN9GwkDndC+bajCJkg/HqXF0Mcice
 mp4PHFRBgz9XckA16PaxIMDUL0PP6LvhgGUvHDd72JN20RIIfxeDYFGZsi/oh6V0re2q
 PvrK1UTCb03Sg+2TQVi9hlN+NrcxiYGWs/iVEZpQ5tzt2Zi9hawCqYdaQTALozX80OmI
 xmeFDSlg0nklgE8drw2guBvo+HoHgV3pVi6/+ZnNPHdpPAsunic1u4CgRHhGWXLBy/O2
 511A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804383; x=1743409183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjHWsm3dx0YdITjXUi4M45f/K0Yu/f7nUohwYX78sQ4=;
 b=tDqQmGVZPqu9QGlvDoLObOHNSe03p2iG9DM0f758Sb5tHi4BDge0RfaBoRm2IAGKQz
 /IqG3TSlLVmaUpkitGtfBcbQX8ELYYTXJmris2hBRB2tXrwI+70jtxLrhxks6V2fC9L5
 5h9E4xNRbrXPmocz0dfRNFLE41uMpF+TUKD05phGohSOCRkDkewhPVIpYKEaevi4gYaz
 7Gctg3qZE/vD7kZO+/SYf8WZN80eA03InZSTisnuV2LfkdB0qzLuFi9ZvU5dPhynL0QQ
 Kqfa6C1zl1Dm9tuNYYHa2Y30Dpy2TkvEXZ2JPCe2PfY0OXo9vP9yDEu41Qg8bLh2ykci
 NUbw==
X-Gm-Message-State: AOJu0YwBZIwS1Ue6/hYbQi7kM/VDNd5DMwoKRFzdpl93sPdN3N7K3ddw
 FqEIJafNikxcefMv1MF6d6+JlR9E+CaOsCL5c+04AOX5Zci4npG8u2YxXgrX
X-Gm-Gg: ASbGnct7ZCkpeJYM/DBo4MWPSMvCjN379OCSslBavEcz+iLw44TBjpk290PSPro7ZVq
 dNGFh8WcUdFvoNk3w2tIsfWuLFPT/biAyRFzfg82R+KCanDnobrXOYRkl9HqRZh5L+r50QEGsXz
 lZ22f7BQYn/bt/3ccUgAo4bZo4lQm3Sat+UlCUw3Sde3Msh8yazkah0om1q/WNvpZV/QK4rd37K
 yu0JLy8kC4pywPYQNTzs7adgc5vboOP2dbu3aWRdj3lO5pAkEyI02T6joIAiJImOn0tHcalMYH9
 9edt9QOiON5yUQlHWL0PHaSfNMvtoAmt5WelQMgln0HYpQmi+t5wQvy9K+Lv3vnXZs9ilH/rlDF
 Q2+WzQkcIiyhq+aAE4fNB
X-Google-Smtp-Source: AGHT+IFt36h/z8Y2C2iMDjfKnXELWBvzzCrnRKytF6Y6K1DFOCuBs339dO+RqY7qVATO1/els3HspA==
X-Received: by 2002:a17:902:cece:b0:221:7eae:163b with SMTP id
 d9443c01a7336-22780e261e7mr195628115ad.46.1742804383216; 
 Mon, 24 Mar 2025 01:19:43 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a5b6sm64717685ad.252.2025.03.24.01.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:19:42 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 3/6] ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
Date: Mon, 24 Mar 2025 16:19:18 +0800
Message-ID: <20250324081922.359369-4-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324081922.359369-1-yuq825@gmail.com>
References: <20250324081922.359369-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x634.google.com
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
index 45b1b0b700..970286325f 100644
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
     attrs[i++] = qemu_dmabuf_get_stride(dmabuf)[0];
     attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
     attrs[i++] = 0;
-    if (modifier) {
+    if (modifier != DRM_FORMAT_MOD_INVALID) {
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
         attrs[i++] = (modifier >>  0) & 0xffffffff;
         attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
-- 
2.43.0


