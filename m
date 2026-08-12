Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A10EC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8mu-0004Uz-VW; Wed, 12 Aug 2026 09:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ki-0003WR-OC; Wed, 12 Aug 2026 09:12:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kd-0006Ow-EL; Wed, 12 Aug 2026 09:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=aQQGrRcKm5bHvJ7ZMCPVyBhjCqpWw2v2gqePAzmnCgg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sTbduJUMgyhaW59oyXYHIATvitD3Y0/EEdFlEDUnMmQwefeIR8ySMGg0MdfwxikzL
 wn6aABiiARbnHiw0ofQlZhVfE7HSBEjDlpLsOywwsXjWJ7KWmdWTJTQe5HwEd+Ikx0
 75otRtsH8VQvzjTtrW4vfWOp2y4CLQkLOOwbdjLHJxdNwQp2bZG6Vxw1QhmYGmGtx9
 6ZsJxWhvNGk13UhsaIYWI2zs/cVFUs0iNIuIzNAhAcyYBbbBZLRZW0G/OTSLoUejNc
 V9rnWlyq+uJjnzaoZYQR5VOHLR9Oryiq4Q5FP5IOVymwcX/uACeWo0FEWHClWSVdaM
 PDi0sYXYQo8sw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B911E1CA4DC;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EFB7C409BBF;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C475D2F94E; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 093/102] hw/display/virtio-gpu: Always reject invalid
 scanout bounds
Date: Wed, 12 Aug 2026 16:02:08 +0300
Message-ID: <20260812130233.621965-93-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

virtio-gpu does not consistently check scanout bounds with wraparound
handling. In the unchecked virgl SET_SCANOUT path, guest dimensions
reach qemu_console_resize(), qemu_create_displaysurface(), and
ultimately qemu_pixman_image_new_shareable(..., &error_abort), so an
invalid rectangle can terminate QEMU. Implement a check with proper
wraparound handling and apply it consistently.

Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260803-scanout-v1-1-c9831dafdab2@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit d513c644b89361ab645a50a627a1d846aefc3eb2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index dbf9270fab0..cfa91b9e8a5 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -315,6 +315,12 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
     res = virtio_gpu_find_resource(g, ss.resource_id);
     CHECK(res, cmd);
 
+    if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
+                                         res->width, res->height, &ss.r,
+                                         &cmd->error)) {
+        return;
+    }
+
     if (!res->image) {
         pixman_format_code_t pformat;
         pformat = virtio_gpu_get_pixman_format(res->format);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 30bf5b5029e..d4d46148b5d 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -438,7 +438,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
     }
     g->parent_obj.enable = 1;
 
-    if (ss.resource_id && ss.r.width && ss.r.height) {
+    if (ss.resource_id) {
         struct virgl_renderer_resource_info info;
         void *d3d_tex2d = NULL;
 
@@ -459,6 +459,11 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
             return;
         }
+        if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
+                                             info.width, info.height, &ss.r,
+                                             &cmd->error)) {
+            return;
+        }
         qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
                             ss.r.width, ss.r.height);
         virgl_renderer_force_ctx_0();
@@ -856,16 +861,9 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
         return;
     }
 
-    if (ss.width < 16 ||
-        ss.height < 16 ||
-        ss.r.x + ss.r.width > ss.width ||
-        ss.r.y + ss.r.height > ss.height) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
-                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
-                      __func__, ss.scanout_id, ss.resource_id,
-                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
-                      ss.width, ss.height);
-        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+    if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
+                                         ss.width, ss.height, &ss.r,
+                                         &cmd->error)) {
         return;
     }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index bd32543dc70..4f1c6e64b12 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -629,6 +629,26 @@ static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
     return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
 }
 
+bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
+                                     uint32_t width, uint32_t height,
+                                     const struct virtio_gpu_rect *r,
+                                     uint32_t *error)
+{
+    if (r->width < 16 ||
+        r->height < 16 ||
+        (uint64_t)r->x + r->width > width ||
+        (uint64_t)r->y + r->height > height) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
+                      " resource %d, fb %d %d, rect (%d,%d)+%d,%d\n",
+                      __func__, scanout_id, resource_id, width, height,
+                      r->x, r->y, r->width, r->height);
+        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return false;
+    }
+
+    return true;
+}
+
 static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
                                       uint32_t scanout_id,
                                       struct virtio_gpu_framebuffer *fb,
@@ -642,20 +662,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
     scanout = &g->parent_obj.scanout[scanout_id];
 
-    if (r->x > fb->width ||
-        r->y > fb->height ||
-        r->width < 16 ||
-        r->height < 16 ||
-        r->width > fb->width ||
-        r->height > fb->height ||
-        r->x + r->width > fb->width ||
-        r->y + r->height > fb->height) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
-                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
-                      __func__, scanout_id, res->resource_id,
-                      r->x, r->y, r->width, r->height,
-                      fb->width, fb->height);
-        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+    if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
+                                         fb->width, fb->height, r, error)) {
         return false;
     }
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7f4dd42ff65..354c7ae515b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -347,6 +347,11 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id);
 
+bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
+                                     uint32_t width, uint32_t height,
+                                     const struct virtio_gpu_rect *r,
+                                     uint32_t *error);
+
 /**
  * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
  * fb: the frame-buffer descriptor to fill out
-- 
2.47.3


