Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6094C531F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 00:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtEH0-00076k-KP; Thu, 19 Feb 2026 19:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEGt-0006wq-S7
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:21:29 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vtEGr-0004ry-Kt
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 19:21:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771546871; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MldpLII1d6qDEJCOsdkxNKtYBvsiEDrHMl1Wi4VOl3rO2+36r+nm5gFcDp1O9Sni+twPQEpqMVwQj19dQdYVX+/9HcgU0PgLYLPVM9WKA/i+jF4gX7kQ5ZaAEX0k4VZewMA17AROOxWkN04olMqT2tZtKHVj24hUu5BcK4CeK0c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771546871;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wl2UYZ3048tYXoIzJo0diJme2SqjTetCI4S1haIDMH0=; 
 b=UL0Fg/1RggfJPLEI626hpZEhskJnzwTueVCWgXijJJm8nN2TWPAdjUFyHH+KlI7nPR++WOCHj5iWYa00A+kGS3sulo3AOqDsMAtdjEJdkpGdb736me+znNDz1MwkRppo+7LU0BeXbEyq/rCCaGThIH+n/LuV19rQDwEW0UwtxTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771546871; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wl2UYZ3048tYXoIzJo0diJme2SqjTetCI4S1haIDMH0=;
 b=hE1+3o3kCHIeoTJFO7JizYFgTUERULkzMAvlT30U7QUV08ByCHD2AShYL7UBV/sc
 ThQso4WJZ2AX1jg4xtKu+Sex4CyUNr6TdXk5eCKyN0EIcWyYEgyFmPpqdiYxk0LStXA
 Yc8zn9tDINfSJkWNjzi4Kb9P9RUz9u1fKlahb0iw=
Received: by mx.zohomail.com with SMTPS id 1771546869258915.3532811891511;
 Thu, 19 Feb 2026 16:21:09 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v19 11/20] virtio-gpu: Support asynchronous fencing
Date: Fri, 20 Feb 2026 03:16:25 +0300
Message-ID: <20260220001634.3579257-12-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
References: <20260220001634.3579257-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Support asynchronous fencing feature of virglrenderer. It allows Qemu to
handle fence as soon as it's signalled instead of periodically polling
the fence status. This feature is required for enabling DRM context
support in Qemu because legacy fencing mode isn't supported for DRM
contexts in virglrenderer.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |   5 ++
 hw/display/virtio-gpu-virgl.c  | 127 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-gpu.h |  11 +++
 meson.build                    |   2 +
 4 files changed, 145 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b98ef2ef9877..3e0680880e14 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -169,6 +169,11 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     if (gl->renderer_state >= RS_INITED) {
 #if VIRGL_VERSION_MAJOR >= 1
         qemu_bh_delete(gl->cmdq_resume_bh);
+
+        if (gl->async_fence_bh) {
+            virtio_gpu_virgl_reset_async_fences(g);
+            qemu_bh_delete(gl->async_fence_bh);
+        }
 #endif
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             timer_free(gl->print_stats);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 7cfd9531a8e4..310b2154a718 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -24,6 +24,23 @@
 
 #include <virglrenderer.h>
 
+/*
+ * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was fixed
+ * in 1.1.0. Undefine bugged version of the macro and provide our own.
+ */
+#if defined(VIRGL_CHECK_VERSION) && \
+    VIRGL_VERSION_MAJOR == 1 && VIRGL_VERSION_MINOR < 1
+#undef VIRGL_CHECK_VERSION
+#endif
+
+#ifndef VIRGL_CHECK_VERSION
+#define VIRGL_CHECK_VERSION(major, minor, micro) \
+    (VIRGL_VERSION_MAJOR > (major) || \
+     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR > (minor) || \
+     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR == (minor) && \
+     VIRGL_VERSION_MICRO >= (micro))
+#endif
+
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
     MemoryRegion *mr;
@@ -1093,6 +1110,103 @@ static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
 }
 #endif
 
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
+#if VIRGL_CHECK_VERSION(1, 1, 2)
+static void virtio_gpu_virgl_async_fence_bh(void *opaque)
+{
+    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+    struct virtio_gpu_ctrl_command *cmd, *tmp;
+    struct virtio_gpu_virgl_context_fence *f;
+    VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    if (gl->renderer_state != RS_INITED) {
+        return;
+    }
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
+                                  uint32_t ring_idx, uint64_t fence_id)
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
+    virtio_gpu_virgl_push_async_fence(g, 0, UINT32_MAX, fence);
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
@@ -1194,6 +1308,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
 void virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
     virgl_renderer_reset();
+
+    virtio_gpu_virgl_reset_async_fences(g);
 }
 
 int virtio_gpu_virgl_init(VirtIOGPU *g)
@@ -1206,6 +1322,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (qemu_egl_display) {
         virtio_gpu_3d_cbs.version = 4;
         virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
+#if VIRGL_CHECK_VERSION(1, 1, 2)
+        virtio_gpu_3d_cbs.write_fence         = virgl_write_async_fence;
+        virtio_gpu_3d_cbs.write_context_fence = virgl_write_async_context_fence;
+        flags |= VIRGL_RENDERER_ASYNC_FENCE_CB;
+        flags |= VIRGL_RENDERER_THREAD_SYNC;
+#endif
     }
 #endif
 #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
@@ -1239,6 +1361,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
                                     virtio_gpu_virgl_resume_cmdq_bh,
                                     g);
+#if VIRGL_CHECK_VERSION(1, 1, 2)
+    gl->async_fence_bh = aio_bh_new(qemu_get_aio_context(),
+                                    virtio_gpu_virgl_async_fence_bh,
+                                    g);
+#endif
 #endif
 
     return 0;
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 58e0f91fda65..16e9f6914f07 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -233,6 +233,13 @@ struct VirtIOGPUClass {
                              Error **errp);
 };
 
+struct virtio_gpu_virgl_context_fence {
+    uint32_t ctx_id;
+    uint32_t ring_idx;
+    uint64_t fence_id;
+    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
+};
+
 /* VirtIOGPUGL renderer states */
 typedef enum {
     RS_START,       /* starting state */
@@ -250,6 +257,9 @@ struct VirtIOGPUGL {
     QEMUTimer *print_stats;
 
     QEMUBH *cmdq_resume_bh;
+
+    QEMUBH *async_fence_bh;
+    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
 };
 
 struct VhostUserGPU {
@@ -379,5 +389,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
+void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
 
 #endif
diff --git a/meson.build b/meson.build
index 2ccd206c962a..2c92134654e4 100644
--- a/meson.build
+++ b/meson.build
@@ -2515,6 +2515,8 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 if virgl.found()
   config_host_data.set('VIRGL_VERSION_MAJOR', virgl.version().split('.')[0])
+  config_host_data.set('VIRGL_VERSION_MINOR', virgl.version().split('.')[1])
+  config_host_data.set('VIRGL_VERSION_MICRO', virgl.version().split('.')[2])
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
-- 
2.52.0


