Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8940AC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKn2-0007Oz-W9; Tue, 04 Aug 2026 15:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKn1-0007OF-HD
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmz-0005Cd-QC
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aULtpVcVtyCMV62+QOgZRcxVB09PF0BdgKmsWwfe87k=;
 b=PObb58lvyhWABZKGv93cZIHXksBwsNSIigWFLLNOsOd46rai894UnX7V757boqq1reb1KT
 B1XhKRLNtZ3e1aaCLxAMTw5RUi1uiO1QEqw+F87HcL4ELtafO1TEkGqfsES6zrOw2yUvM5
 pBQchVV6qncLJzPjeR9parqA93dxXoE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-udWmfHzmOv2CzEqFc-gymg-1; Tue,
 04 Aug 2026 15:26:57 -0400
X-MC-Unique: udWmfHzmOv2CzEqFc-gymg-1
X-Mimecast-MFC-AGG-ID: udWmfHzmOv2CzEqFc-gymg_1785871616
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 477181956050; Tue,  4 Aug 2026 19:26:56 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D12A8180044F; Tue,  4 Aug 2026 19:26:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:54 +0400
Subject: [GIT PULL v2 7/9] hw/display/virtio-gpu: Always reject invalid
 scanout bounds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-7-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7071;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lPEGPLPQO9o4Iq92ww7DSP/izILyow8FYE5uhd9yQZc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzUIqDqLY40uS979+CYdcrX0QvxY6fMyf+iy
 3X5FBYgOiqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI81AAKCRDa6OEJdZac
 5WTdD/9SM9yHKtV5QlsYp/tblRA4hwpcBm1ySxc+F6HkgPsrWqU5x9yCwiYJ1VVg7eAXCWbnYPM
 PxAf4ukCc5XLOuwebVxvAT1wiF/gvlVY6en+9WL+vDePqmMhGhEsM141zWghw+q0kt9SaA0Q7F1
 Wzght4MjdQxK7JjCLIaY+MGDRJrM6o99SQSlOHb4hs8dQzacIXPYqqLOp02XQlm3QZ1ea9QNXCd
 oUgM13qKwTzF0DS7+Z6Ab9GOmUf091IHqZl9Mvf20bTuYgfowzMdfx2wlxGPkHi3zScAq8OsQCu
 QSgWm0hp4+t+xOhNLztZEV+9gvfNGzRQH5rLv5LcnsVxuuVHpJQbDYz0e3ubEGyvxgdcgLjYL+f
 uBV0Tsx8i4b/UhfjzGMDELpJ4NMDkgtB+opWaWY6lv3x1XcWwEVO1FT228PUy96QVoZ0MONg60F
 tBw9ACe2QdCgFCWKEaPVZAfSNIfW/P0faPNVBf0YiaGCBRNAk2YRFhGkHcz+iJgLZOKOUHngAvB
 LeyuW6nCbIkVuNTjQcVDRElM6x8A+UHZpGAVKGCtyhZt3xCCtb0vK3hDUiANHxWHglNRMN867we
 B3OH2mmwoF/YPkY5ocZHEyFgWAmUqYOMrzdaoCt1xEV2+MlLA1bgpdxVR9klElQQCjgJqrrwx0q
 I7IuFu9UUwblj/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 include/hw/virtio/virtio-gpu.h   |  5 +++++
 hw/display/virtio-gpu-rutabaga.c |  6 ++++++
 hw/display/virtio-gpu-virgl.c    | 20 +++++++++-----------
 hw/display/virtio-gpu.c          | 36 ++++++++++++++++++++++--------------
 4 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f965defa6b25..220231ec9d43 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -366,6 +366,11 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
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
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index e28aad94eead..a054f8117f14 100644
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
index d9e5b0110497..6e298f997d66 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -560,7 +560,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
     }
     g->parent_obj.enable = 1;
 
-    if (ss.resource_id && ss.r.width && ss.r.height) {
+    if (ss.resource_id) {
         struct virgl_renderer_resource_info info;
         void *d3d_tex2d = NULL;
 
@@ -581,6 +581,11 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
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
@@ -987,16 +992,9 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
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
index 51592b49c21e..c15d4b527d0e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -633,6 +633,26 @@ static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
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
@@ -646,20 +666,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
 
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
 

-- 
2.55.0


