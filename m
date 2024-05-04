Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A65EC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 20:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3M13-0007Ry-8V; Sat, 04 May 2024 16:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0w-0007P9-7w
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:46 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s3M0u-0005Wg-9K
 for qemu-devel@nongnu.org; Sat, 04 May 2024 16:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1714854583;
 bh=EOAXu9KGUD6uBVP/oywxmG43LYAn5lH1Xu8BfqS0JZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PbpLzt3BG1m3jtS1zfd5AkiFnzXfhP4fbxDwPVdY9FxNUjIGMdpnwnBlxCIHmdRRg
 C7SPVKWJA90q2iAT+EeQbDieILKRx3/B0LwO936yKC5fSShO3Ib9BJK8JY21T2uUzY
 UPqlzFQ0KOdmOc9bG/h123VlWW+zmZVt1+x5jAqbOGVoQ6y5oWBUixpsKdK14YF6kR
 EC1bdLtqSdIEipFiBQYfOI0WBkmeruC6Q0HPa9lUZLFml4s85e1ndTEYVVksev1eat
 PgkpKByGnqcNyWEnCRhmSbBTafoZhsyxMaX0w+UgyC0EwLhDZ86yJ4Rvm+W0aCmGv3
 AdSjEHgf/oeOg==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id F176F378205D;
 Sat,  4 May 2024 20:29:40 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
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
Subject: [PATCH v10 06/10] virtio-gpu: Support blob scanout using dmabuf fd
Date: Sat,  4 May 2024 23:28:30 +0300
Message-ID: <20240504202834.399780-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
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
 meson.build                    |   1 +
 4 files changed, 123 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index a040324f5024..2fedccb1fc8d 100644
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
@@ -507,6 +511,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
     g_free(resp);
 }
 
+#ifdef HAVE_VIRGL_RESOURCE_BLOB
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
+#endif /* HAVE_VIRGL_RESOURCE_BLOB */
+
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
@@ -573,6 +677,11 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_GET_EDID:
         virtio_gpu_get_edid(g, cmd);
         break;
+#ifdef HAVE_VIRGL_RESOURCE_BLOB
+    case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
+        virgl_cmd_set_scanout_blob(g, cmd);
+        break;
+#endif /* HAVE_VIRGL_RESOURCE_BLOB */
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index dac272ecadb1..1e57a53d346c 100644
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
index b657187159d9..ba36497c477f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -329,6 +329,13 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
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
diff --git a/meson.build b/meson.build
index 513cb2ea6d03..9a00e29a80cf 100644
--- a/meson.build
+++ b/meson.build
@@ -2289,6 +2289,7 @@ config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 if virgl.version().version_compare('>=1.0.0')
   config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
   config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS', 1)
+  config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
-- 
2.44.0


