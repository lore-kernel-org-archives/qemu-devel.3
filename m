Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F9C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 23:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPk3-0003US-Fl; Sun, 09 Mar 2025 19:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trPjt-0003Tz-0A
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:07:21 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trPjp-0004iP-2R
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1741561621; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XXEm63TajpQ8o/gE+R8Lx26d3Zt1nq2SNBVWgWJ1qM3Ia1uploJHTUIl3ZniliC17yoQYsOj5lLc1yTInJyH9p6DXrkPr2NJ7rTadoSZ1RXF5BGVU6Ga8GYXbC9fqs1mz6HaFiZK95Wi+qQ52PdKfoDCdUJLqTo1c2VOK7H9QKk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741561621;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Hej6mWYgpW41fDB3UbZ/wzMu6eoGmKcFAugjQBMZPSw=; 
 b=OsO8XiGWVND8dqqrpNS8+zJO0LA9rAXndZ6AqAX+ASravs5HmitwYx8rlol5ofTlajlin6e05YGSjkhOBCgvzBlx0zwjESbinbz7ih2WRotea+8d5Q0Fv9HMcFshQ1A4hMN+bv1z6V+aO9MhlRCJBCW3wl4TcTp0b2wwF16yDlQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741561621; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Hej6mWYgpW41fDB3UbZ/wzMu6eoGmKcFAugjQBMZPSw=;
 b=TpuXx7KmgYPE3914jlqDD3sRHsD/ZvCXL5FjuF5+PXaqwUTNfLG/fz45FieR8sOi
 baqOIS86UDYeA2ZY+XhoDMm4nNGUfZTqYUt7RgH0c6uzo1sMNr192z2LpYXGkXb5gpE
 F1GbKXzNj9qLvfozm3/VIix6VI6bMvF1Q/v4PrwY=
Received: by mx.zohomail.com with SMTPS id 1741561619222499.68247778226555;
 Sun, 9 Mar 2025 16:06:59 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v9 04/10] virtio-gpu: Support asynchronous fencing
Date: Mon, 10 Mar 2025 02:05:33 +0300
Message-ID: <20250309230539.125374-5-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309230539.125374-1-dmitry.osipenko@collabora.com>
References: <20250309230539.125374-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Support asynchronous fencing feature of virglrenderer. It allows Qemu to
handle fence as soon as it's signalled instead of periodically polling
the fence status. This feature is required for enabling DRM context
support in Qemu because legacy fencing mode isn't supported for DRM
contexts in virglrenderer.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |   3 +
 hw/display/virtio-gpu-virgl.c  | 147 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-gpu.h |  13 +++
 3 files changed, 154 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 683fad3bf8a8..d9bb50ac1d4a 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -169,6 +169,9 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     if (gl->renderer_state >= RS_INITED) {
 #if VIRGL_VERSION_MAJOR >= 1
         qemu_bh_delete(gl->cmdq_resume_bh);
+
+        virtio_gpu_virgl_reset_async_fences(g);
+        qemu_bh_delete(gl->async_fence_bh);
 #endif
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             timer_free(gl->print_stats);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 2eb6aaab4e84..ee896eced67c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -871,6 +871,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     bool cmd_suspended = false;
     int ret;
 
@@ -972,15 +973,34 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
 
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 
-    /*
-     * Unlike other virglrenderer functions, this one returns a positive
-     * error code.
-     */
-    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
-    if (ret) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: virgl_renderer_create_fence error: %s",
-                      __func__, strerror(ret));
+    if (gl->context_fence_enabled &&
+        (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX)) {
+#if VIRGL_VERSION_MAJOR >= 1
+        uint32_t flags = 0;
+
+        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
+                                                  cmd->cmd_hdr.ring_idx,
+                                                  cmd->cmd_hdr.fence_id);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: virgl_renderer_context_create_fence error: %s",
+                          __func__, strerror(-ret));
+        }
+#else
+        /* gl->context_fence_enabled cannot be set with older virglrenderer */
+        g_assert_not_reached();
+#endif
+    } else {
+        /*
+         * Unlike other virglrenderer functions, this one returns a positive
+         * error code.
+         */
+        ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: virgl_renderer_create_fence error: %s",
+                          __func__, strerror(ret));
+        }
     }
 }
 
@@ -1008,6 +1028,102 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
     }
 }
 
+void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
+{
+    struct virtio_gpu_virgl_context_fence *f;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    while (!QSLIST_EMPTY(&gl->async_fenceq)) {
+        f = QSLIST_FIRST(&gl->async_fenceq);
+
+        QSLIST_REMOVE_HEAD(&gl->async_fenceq, next);
+
+        g_free(f);
+    }
+}
+
+#if VIRGL_VERSION_MAJOR >= 1
+static void virtio_gpu_virgl_async_fence_bh(void *opaque)
+{
+    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+    struct virtio_gpu_ctrl_command *cmd, *tmp;
+    struct virtio_gpu_virgl_context_fence *f;
+    VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    QSLIST_MOVE_ATOMIC(&async_fenceq, &gl->async_fenceq);
+
+    while (!QSLIST_EMPTY(&async_fenceq)) {
+        f = QSLIST_FIRST(&async_fenceq);
+
+        QSLIST_REMOVE_HEAD(&async_fenceq, next);
+
+        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
+            /*
+             * the guest can end up emitting fences out of order
+             * so we should check all fenced cmds not just the first one.
+             */
+            if (cmd->cmd_hdr.fence_id > f->fence_id) {
+                continue;
+            }
+            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
+                if (cmd->cmd_hdr.ring_idx != f->ring_idx) {
+                    continue;
+                }
+                if (cmd->cmd_hdr.ctx_id != f->ctx_id) {
+                    continue;
+                }
+            } else if (f->ring_idx >= 0) {
+                /* ctx0 GL-query fences don't have ring info */
+                continue;
+            }
+            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
+            QTAILQ_REMOVE(&g->fenceq, cmd, next);
+            g_free(cmd);
+        }
+
+        trace_virtio_gpu_fence_resp(f->fence_id);
+        g_free(f);
+        g->inflight--;
+        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+            trace_virtio_gpu_dec_inflight_fences(g->inflight);
+        }
+    }
+}
+
+static void
+virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
+                                  int64_t ring_idx, uint64_t fence_id)
+{
+    struct virtio_gpu_virgl_context_fence *f;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    f = g_new(struct virtio_gpu_virgl_context_fence, 1);
+    f->ctx_id = ctx_id;
+    f->ring_idx = ring_idx;
+    f->fence_id = fence_id;
+
+    QSLIST_INSERT_HEAD_ATOMIC(&gl->async_fenceq, f, next);
+
+    qemu_bh_schedule(gl->async_fence_bh);
+}
+
+static void virgl_write_async_fence(void *opaque, uint32_t fence)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
+}
+
+static void virgl_write_async_context_fence(void *opaque, uint32_t ctx_id,
+                                            uint32_t ring_idx, uint64_t fence)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
+}
+#endif
+
 static virgl_renderer_gl_context
 virgl_create_context(void *opaque, int scanout_idx,
                      struct virgl_renderer_gl_ctx_param *params)
@@ -1095,6 +1211,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
         dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
         dpy_gl_scanout_disable(g->parent_obj.scanout[i].con);
     }
+
+    virtio_gpu_virgl_reset_async_fences(g);
 }
 
 void virtio_gpu_virgl_reset(VirtIOGPU *g)
@@ -1112,6 +1230,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
         virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
+#if VIRGL_VERSION_MAJOR >= 1
+        virtio_gpu_3d_cbs.write_fence         = virgl_write_async_fence;
+        virtio_gpu_3d_cbs.write_context_fence = virgl_write_async_context_fence;
+        flags |= VIRGL_RENDERER_ASYNC_FENCE_CB;
+        flags |= VIRGL_RENDERER_THREAD_SYNC;
+        gl->context_fence_enabled = true;
+#endif
     }
 #endif
 #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
@@ -1145,6 +1270,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
                                     virtio_gpu_virgl_resume_cmdq_bh,
                                     g);
+
+    gl->async_fence_bh = aio_bh_new(qemu_get_aio_context(),
+                                    virtio_gpu_virgl_async_fence_bh,
+                                    g);
 #endif
 
     return 0;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a42957c4e2cc..bd2cccdc60d7 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -230,6 +230,13 @@ struct VirtIOGPUClass {
                              Error **errp);
 };
 
+struct virtio_gpu_virgl_context_fence {
+    uint32_t ctx_id;
+    int64_t ring_idx;
+    uint64_t fence_id;
+    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
+};
+
 /* VirtIOGPUGL renderer states */
 typedef enum {
     RS_START,       /* starting state */
@@ -247,6 +254,11 @@ struct VirtIOGPUGL {
     QEMUTimer *print_stats;
 
     QEMUBH *cmdq_resume_bh;
+
+    QEMUBH *async_fence_bh;
+    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+
+    bool context_fence_enabled;
 };
 
 struct VhostUserGPU {
@@ -376,5 +388,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
+void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
 
 #endif
-- 
2.48.1


