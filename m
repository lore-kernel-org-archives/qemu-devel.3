Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A03C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9SZ-00037J-4j; Tue, 04 Aug 2026 03:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9SX-00031I-Hj
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9SU-0001XF-RT
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785828066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aULtpVcVtyCMV62+QOgZRcxVB09PF0BdgKmsWwfe87k=;
 b=TYeBL8bn3CbG0DeU2pcfp7Ne9bp1GjuAVDhUJ1puS98NEuTpzL0UOCU0LI86LbFIcmWMDg
 +6TGYRbqEsdySGwTdhpL04QTf48gmMnzLhFmLCRTt9eEG9WSdnIy7MVgoxdTsnuJ72bT1r
 arr8jhCAugen4Dc8Z+aJ5FgmGzX//Ug=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-cyhT4iOePwmBvpSmIOaEiw-1; Tue,
 04 Aug 2026 03:20:54 -0400
X-MC-Unique: cyhT4iOePwmBvpSmIOaEiw-1
X-Mimecast-MFC-AGG-ID: cyhT4iOePwmBvpSmIOaEiw_1785828053
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF54C195608E; Tue,  4 Aug 2026 07:20:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B57041956087; Tue,  4 Aug 2026 07:20:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 11:18:56 +0400
Subject: [GIT PULL 7/9] hw/display/virtio-gpu: Always reject invalid
 scanout bounds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v1-7-0c2be5390809@redhat.com>
References: <20260804-fix-v1-0-0c2be5390809@redhat.com>
In-Reply-To: <20260804-fix-v1-0-0c2be5390809@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7071;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lPEGPLPQO9o4Iq92ww7DSP/izILyow8FYE5uhd9yQZc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcZJdNehPbOYPJ7RAof/TVteawEb+DYMeuqiEn
 HMT57VOO/SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanGSXQAKCRDa6OEJdZac
 5SLvD/9YtGwf3H6wzGaZuctb5OEJgHhF0Ve4wYJ4RKlWMPGRWRrPqZRgajgCfhSGDTx8Z2SxZAR
 Nrs7ndEUcz+uokx883j4ORQGy82CuwcwRlN3G1WGJveaQhngb9HS7BvJ7Qm7fICkwIWQdyuVAuA
 8OtPzrHCkhqEFb+uxPqI08IiVSaiYqFyfWPqj6d8qomz4Ql/SakdbEwyQTvC16UdBi7Pr0uZZov
 hyh04SZieTPwML2lhl3WtcYzsV+Nr2T+KFBWcofMxC3ms5aAjxnu/vKQFlmBwSDjoFCp1Ok1Etx
 oJFYjZgJjoJrBz8ovWTfur0ggOq1nAh7GLv3SUtEWuoWb1AF0vZ9CoSjNuDq7tZdIZBMhWEvbHz
 pSOrcAs7NO1kJwFSgRVF2RGq8u6tfwHgbKNP01bazWOPB0TiL3Bfvdce19C6/87ATp1KHYGnIFR
 Ij5jJ5BrCfNqnBB0xohOFhZYXP/DVFaHmjqwy0USgqulrEDPLJ2VwwlKLzhs5BO4XJyDCGPEZIO
 0bFZgabzWN0ofbuGr4Ipb1HkpuRdXZPy923K7GMK+NB9v+3anaUfm2wvCXr6D/nVI7zJngR7o5c
 m06l3J0lQsQvEFFFj6ZqPXmzaXR9yyvtSoUR4a10u0dxTf5DCAxTaLjy/fWVyeYUuTW5Gu/2sB4
 znssjHff/nmgo9A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


