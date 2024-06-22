Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E54EC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 21:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL8i2-0007er-7f; Sat, 22 Jun 2024 17:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8i0-0007ec-Sd
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:44 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8hz-0001E9-2M
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1719093342;
 bh=RWNgiURSpB1QcXOAiWzME6Eav8jxvwe2G+oqAn44zis=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WANVoax/Fu9aU0TUDfByFHXiOEFU8qQ43T7ANIoxJFwwCz9GvgQx+Pe+LTqo4kACC
 IleojQGrDvMgBSuT9MVSeoPH+3T888Hcm94bVYBPoypLJQGLvZrKEr2ykXcwrYHjgW
 gJIVwLURffOf57x4gPZr1tnuZ03RPYYtlwj/MUQYW122lfgaegy8ADeVLtQ61y0EDr
 bnS88z7lphkXu9zZJSAC8ku6URemKr8Cq0qC5ThYLLzkKmKmUv98Xwmnuh9xHkRBWP
 64808dHWvhjaYJEEdcVZRMpygHW3QMwkxXVROFkU5rhtH1Ndtmt6WCOj2+disF3bt/
 AI4DFSEz3h1Eg==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2298A378205A;
 Sat, 22 Jun 2024 21:55:40 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v15 10/14] virtio-gpu: Support blob scanout using dmabuf fd
Date: Sun, 23 Jun 2024 00:55:07 +0300
Message-ID: <20240622215511.154763-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
References: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Robert Beckett <bob.beckett@collabora.com>

Support displaying blob resources by handling SET_SCANOUT_BLOB
command.

Signed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 109 +++++++++++++++++++++++++++++++++
 hw/display/virtio-gpu.c        |  12 ++--
 include/hw/virtio/virtio-gpu.h |   7 +++
 3 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 3ffea478e723..60befab7efc2 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -17,6 +17,8 @@
 #include "trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
+#include "hw/virtio/virtio-gpu-bswap.h"
+#include "hw/virtio/virtio-gpu-pixman.h"
 
 #include "ui/egl-helpers.h"
 
@@ -78,6 +80,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
     res->base.height = c2d.height;
     res->base.format = c2d.format;
     res->base.resource_id = c2d.resource_id;
+    res->base.dmabuf_fd = -1;
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c2d.resource_id;
@@ -125,6 +128,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
     res->base.height = c3d.height;
     res->base.format = c3d.format;
     res->base.resource_id = c3d.resource_id;
+    res->base.dmabuf_fd = -1;
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c3d.resource_id;
@@ -509,6 +513,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
     g_free(resp);
 }
 
+#if VIRGL_VERSION_MAJOR >= 1
+static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
+                                       struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_framebuffer fb = { 0 };
+    struct virgl_renderer_resource_info info;
+    struct virtio_gpu_virgl_resource *res;
+    struct virtio_gpu_set_scanout_blob ss;
+    uint64_t fbend;
+
+    VIRTIO_GPU_FILL_CMD(ss);
+    virtio_gpu_scanout_blob_bswap(&ss);
+    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
+                                          ss.r.width, ss.r.height, ss.r.x,
+                                          ss.r.y);
+
+    if (ss.scanout_id >= g->parent_obj.conf.max_outputs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified %d",
+                      __func__, ss.scanout_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
+        return;
+    }
+
+    if (ss.resource_id == 0) {
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
+        return;
+    }
+
+    if (ss.width < 16 ||
+        ss.height < 16 ||
+        ss.r.x + ss.r.width > ss.width ||
+        ss.r.y + ss.r.height > ss.height) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
+                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
+                      __func__, ss.scanout_id, ss.resource_id,
+                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
+                      ss.width, ss.height);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    res = virtio_gpu_virgl_find_resource(g, ss.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not have info %d\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+    if (res->base.dmabuf_fd < 0) {
+        res->base.dmabuf_fd = info.fd;
+    }
+    if (res->base.dmabuf_fd < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource not backed by dmabuf %d\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    fb.format = virtio_gpu_get_pixman_format(ss.format);
+    if (!fb.format) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: pixel format not supported %d\n",
+                      __func__, ss.format);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    fb.bytes_pp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
+    fb.width = ss.width;
+    fb.height = ss.height;
+    fb.stride = ss.strides[0];
+    fb.offset = ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
+
+    fbend = fb.offset;
+    fbend += fb.stride * (ss.r.height - 1);
+    fbend += fb.bytes_pp * ss.r.width;
+    if (fbend > res->base.blob_size) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: fb end out of range\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    g->parent_obj.enable = 1;
+    if (virtio_gpu_update_dmabuf(g, ss.scanout_id, &res->base, &fb, &ss.r)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to update dmabuf\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    virtio_gpu_update_scanout(g, ss.scanout_id, &res->base, &fb, &ss.r);
+}
+#endif
+
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
@@ -575,6 +679,11 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_GET_EDID:
         virtio_gpu_get_edid(g, cmd);
         break;
+#if VIRGL_VERSION_MAJOR >= 1
+    case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
+        virgl_cmd_set_scanout_blob(g, cmd);
+        break;
+#endif
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 40a9d089710c..95091c4b7924 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -380,7 +380,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
-static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
+void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     struct virtio_gpu_simple_resource *res;
@@ -597,11 +597,11 @@ static void virtio_unref_resource(pixman_image_t *image, void *data)
     pixman_image_unref(data);
 }
 
-static void virtio_gpu_update_scanout(VirtIOGPU *g,
-                                      uint32_t scanout_id,
-                                      struct virtio_gpu_simple_resource *res,
-                                      struct virtio_gpu_framebuffer *fb,
-                                      struct virtio_gpu_rect *r)
+void virtio_gpu_update_scanout(VirtIOGPU *g,
+                               uint32_t scanout_id,
+                               struct virtio_gpu_simple_resource *res,
+                               struct virtio_gpu_framebuffer *fb,
+                               struct virtio_gpu_rect *r)
 {
     struct virtio_gpu_simple_resource *ores;
     struct virtio_gpu_scanout *scanout;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 6e71d799e5da..1e9257005b76 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -338,6 +338,13 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
                              struct virtio_gpu_framebuffer *fb,
                              struct virtio_gpu_rect *r);
 
+void virtio_gpu_update_scanout(VirtIOGPU *g,
+                               uint32_t scanout_id,
+                               struct virtio_gpu_simple_resource *res,
+                               struct virtio_gpu_framebuffer *fb,
+                               struct virtio_gpu_rect *r);
+void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id);
+
 /* virtio-gpu-3d.c */
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd);
-- 
2.45.2


