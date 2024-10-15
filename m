Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1E5CFC265
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 04:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ZIF-0007mS-Gu; Tue, 15 Oct 2024 00:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t0ZID-0007lm-Ll
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 00:36:21 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t0ZIB-0007LD-PC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 00:36:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728966968; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RYuKz+hQu8pbEDVjHJVs1NzWesT9aTjr4jRxraylnz6bkGrtVzcUW7NMq8WEhd6v2WMidtAIKPRHP1M+9MWDcLcAyawnZGkWC4mtVRdvED/J4u12p8q/QeicUHEC1PASWIlyTZWyjoQI1En06Le3IScB7L8py0Wh4/WXsLEz63U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728966968;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wC/v00gBBAEN4hF1BP/qlMRXm5V1zNBcKm03Z1vxLjY=; 
 b=nQa5k1CiiWIZBjYT30Jzayez28KS5Xk/zoV9k+SEw7soW299vOk+wAN4hJSaNec4fVBLaUSMynYACSWkyjmld1c8M6hzRb3fC7OdkAWbDs7Zi1esHBjLGwMQZTacfXi/Mq8On8kWfZ2yhmC2pBkxN6sZ8bpHxyFeAz9S7QKd7wE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728966968; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wC/v00gBBAEN4hF1BP/qlMRXm5V1zNBcKm03Z1vxLjY=;
 b=DrYGLMCH5VPcTLz7UaXagQV2Z4e8JV7TYbWmwC9CTQ0iC+HQ2V+ajA9nZdfvxjR1
 d1QeCadtVTSlkWEcW/yXMHsGB5K4Ypf4/ZgQv2bWjHj417FE30gwpjLL+mxCFUnzDX1
 e7qStxD8b9UAvxMo5PPbWFr8gWrk/QMX8AOKBmR8=
Received: by mx.zohomail.com with SMTPS id 17289669670551.7062978064949448;
 Mon, 14 Oct 2024 21:36:07 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v2 5/6] virtio-gpu: Support asynchronous fencing
Date: Tue, 15 Oct 2024 07:32:37 +0300
Message-ID: <20241015043238.114034-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |   3 +
 hw/display/virtio-gpu-virgl.c  | 134 ++++++++++++++++++++++++++++-----
 include/hw/virtio/virtio-gpu.h |  14 ++++
 3 files changed, 133 insertions(+), 18 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 7c0e448b4661..53d938f23f20 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -170,6 +170,9 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
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
index b32ce44ba2b1..ad6512987079 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -891,6 +891,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     bool cmd_suspended = false;
     int ret;
 
@@ -992,35 +993,117 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
 
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 
-    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
-    if (ret)
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: virgl_renderer_create_fence error: %s",
-                      __func__, strerror(-ret));
+    if (gl->context_fence_enabled &&
+        (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX)) {
+        uint32_t flags = 0;
+
+        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
+                                                  cmd->cmd_hdr.ring_idx,
+                                                  cmd->cmd_hdr.fence_id);
+        if (ret)
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: virgl_renderer_context_create_fence error: %s",
+                          __func__, strerror(ret));
+    } else {
+        ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
+        if (ret)
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: virgl_renderer_create_fence error: %s",
+                          __func__, strerror(-ret));
+    }
 }
 
-static void virgl_write_fence(void *opaque, uint32_t fence)
+static void virtio_gpu_virgl_async_fence_bh(void *opaque)
 {
-    VirtIOGPU *g = opaque;
+    struct virtio_gpu_virgl_context_fence *f, *f_tmp;
     struct virtio_gpu_ctrl_command *cmd, *tmp;
+    VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
-    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
-        /*
-         * the guest can end up emitting fences out of order
-         * so we should check all fenced cmds not just the first one.
-         */
-        if (cmd->cmd_hdr.fence_id > fence) {
-            continue;
+    qemu_mutex_lock(&gl->async_fence_lock);
+
+    QSLIST_FOREACH_SAFE(f, &gl->async_fenceq, next, f_tmp) {
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
         }
-        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
-        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
-        QTAILQ_REMOVE(&g->fenceq, cmd, next);
-        g_free(cmd);
+
+        trace_virtio_gpu_fence_resp(f->fence_id);
+        QSLIST_REMOVE(&gl->async_fenceq, f, virtio_gpu_virgl_context_fence,
+                      next);
+        g_free(f);
         g->inflight--;
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             trace_virtio_gpu_dec_inflight_fences(g->inflight);
         }
     }
+
+    qemu_mutex_unlock(&gl->async_fence_lock);
+}
+
+void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
+{
+    struct virtio_gpu_virgl_context_fence *f, *f_tmp;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    QSLIST_FOREACH_SAFE(f, &gl->async_fenceq, next, f_tmp) {
+        QSLIST_REMOVE(&gl->async_fenceq, f, virtio_gpu_virgl_context_fence,
+                      next);
+        g_free(f);
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
+    qemu_mutex_lock(&gl->async_fence_lock);
+    QSLIST_INSERT_HEAD(&gl->async_fenceq, f, next);
+    qemu_mutex_unlock(&gl->async_fence_lock);
+
+    qemu_bh_schedule(gl->async_fence_bh);
+}
+
+static void virgl_write_fence(void *opaque, uint32_t fence)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
+}
+
+static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
+                                      uint32_t ring_idx, uint64_t fence)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
 }
 
 static virgl_renderer_gl_context
@@ -1110,6 +1193,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
         dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
         dpy_gl_scanout_disable(g->parent_obj.scanout[i].con);
     }
+
+    virtio_gpu_virgl_reset_async_fences(g);
 }
 
 void virtio_gpu_virgl_reset(VirtIOGPU *g)
@@ -1127,6 +1212,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
         virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
+#if VIRGL_VERSION_MAJOR >= 1
+        virtio_gpu_3d_cbs.write_context_fence = virgl_write_context_fence;
+        flags |= VIRGL_RENDERER_ASYNC_FENCE_CB;
+        flags |= VIRGL_RENDERER_THREAD_SYNC;
+        gl->context_fence_enabled = true;
+#endif
     }
 #endif
 #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
@@ -1160,6 +1251,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
                                     virtio_gpu_virgl_resume_cmdq_bh,
                                     g);
+
+    gl->async_fence_bh = aio_bh_new(qemu_get_aio_context(),
+                                    virtio_gpu_virgl_async_fence_bh,
+                                    g);
+
+    qemu_mutex_init(&gl->async_fence_lock);
+    QSLIST_INIT(&gl->async_fenceq);
 #endif
 
     return 0;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 230fa0c4ee0a..5673f0be85f4 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -229,6 +229,13 @@ struct VirtIOGPUClass {
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
@@ -246,6 +253,12 @@ struct VirtIOGPUGL {
     QEMUTimer *print_stats;
 
     QEMUBH *cmdq_resume_bh;
+
+    QEMUBH *async_fence_bh;
+    QemuMutex async_fence_lock;
+    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+
+    bool context_fence_enabled;
 };
 
 struct VhostUserGPU {
@@ -360,5 +373,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
+void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
 
 #endif
-- 
2.47.0


