Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F08E9A04A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsT0R-0002uH-PI; Tue, 17 Feb 2026 16:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsT0Q-0002do-K2
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:53:18 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vsT0O-0001me-Nt
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:53:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771365182; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FFEYN3+weoDnzuH3YB3BTUURHHwJTzpAZa1kvZR+1x8Q/ZGgpZutXO3/1EC+jWmuSEIrAt+rrawIyYWhUhV2d2vQMRH4/8xxKIZAxdUaDB1VW+pn9lj7xH2tk9OczB5aNA35QCdeTRuIetRpt7UcxCZXDVSsWg6k1HJIlwZHAWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771365182;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7oFd8GvwoYK0Q9kvM4T5G54GMzT8vsBrFX08OYyTJrc=; 
 b=TX64+kNztapwxsvjtK0JaqwrXyiGzGopXEzpTDkiiNlwKnza3gBWorhhMPdFQwVWmyBpeW3j0vSg1i/HPj7URwsx/0iIbDVA/Ya+LuLeNfvaZOyVmdk/Ih+Ya2DgVMH9V6Ppo0QgQphRYSVVRra7Pq9lSj9/KY/HW/1blm3opCk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771365182; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=7oFd8GvwoYK0Q9kvM4T5G54GMzT8vsBrFX08OYyTJrc=;
 b=i1LH42vIGchw11bbLXJA3dFlBXSw+AlWc/VkRv1Ed7mWeiD3CWPMycoqSOAanUFj
 SZLSqy6i+ztwVOa8/Pi+2CpCfwsitqYUnBV9XPeLSLCstggjznROLG3OVXoBGpEFxg2
 a8lB4wFw9S3fgTyuOexDETg5Sh2NyoiJdKMCz8cU=
Received: by mx.zohomail.com with SMTPS id 1771365181458112.25496983983214;
 Tue, 17 Feb 2026 13:53:01 -0800 (PST)
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
Subject: [PATCH v18 18/19] virtio-gpu: Destroy virgl resources on virtio-gpu
 reset
Date: Wed, 18 Feb 2026 00:49:27 +0300
Message-ID: <20260217214928.2970885-19-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
References: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Properly destroy virgl resources on virtio-gpu reset to not leak resources
on a hot reboot of a VM.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |  18 +----
 hw/display/virtio-gpu-virgl.c  | 121 +++++++++++++++++++++++++++------
 include/hw/virtio/virtio-gpu.h |   6 +-
 3 files changed, 105 insertions(+), 40 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b941e9a4b789..8b71dd6fc26f 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -63,29 +63,14 @@ static void virtio_gpu_gl_flushed(VirtIOGPUBase *b)
 static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
-    VirtIOGPUGL *gl = VIRTIO_GPU_GL(vdev);
     struct virtio_gpu_ctrl_command *cmd;
 
     if (!virtio_queue_ready(vq)) {
         return;
     }
 
-    switch (gl->renderer_state) {
-    case RS_RESET:
-        virtio_gpu_virgl_reset(g);
-        /* fallthrough */
-    case RS_START:
-        if (virtio_gpu_virgl_init(g)) {
-            gl->renderer_state = RS_INIT_FAILED;
-            return;
-        }
-
-        gl->renderer_state = RS_INITED;
-        break;
-    case RS_INIT_FAILED:
+    if (!virtio_gpu_virgl_update_render_state(g)) {
         return;
-    case RS_INITED:
-        break;
     }
 
     cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
@@ -201,6 +186,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
     vgc->process_cmd = virtio_gpu_virgl_process_cmd;
     vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
 
+    vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
     vdc->realize = virtio_gpu_gl_device_realize;
     vdc->unrealize = virtio_gpu_gl_device_unrealize;
     vdc->reset = virtio_gpu_gl_reset;
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8cbbe890d282..a99c08382b1c 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -96,6 +96,10 @@ static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
 {
     VirtIOGPU *g = opaque;
 
+    if (!virtio_gpu_virgl_update_render_state(g)) {
+        return;
+    }
+
     virtio_gpu_process_cmdq(g);
 }
 
@@ -344,14 +348,46 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
     virgl_renderer_resource_create(&args, NULL, 0);
 }
 
+static int
+virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
+                                struct virtio_gpu_virgl_resource *res,
+                                bool *suspended)
+{
+    struct iovec *res_iovs = NULL;
+    int num_iovs = 0;
+#if VIRGL_VERSION_MAJOR >= 1
+    int ret;
+
+    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, suspended);
+    if (ret) {
+        return ret;
+    }
+    if (*suspended) {
+        return 0;
+    }
+#endif
+
+    virgl_renderer_resource_detach_iov(res->base.resource_id,
+                                       &res_iovs,
+                                       &num_iovs);
+    if (res_iovs != NULL && num_iovs != 0) {
+        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
+    }
+    virgl_renderer_resource_unref(res->base.resource_id);
+
+    QTAILQ_REMOVE(&g->reslist, &res->base, next);
+
+    g_free(res);
+
+    return 0;
+}
+
 static void virgl_cmd_resource_unref(VirtIOGPU *g,
                                      struct virtio_gpu_ctrl_command *cmd,
                                      bool *cmd_suspended)
 {
     struct virtio_gpu_resource_unref unref;
     struct virtio_gpu_virgl_resource *res;
-    struct iovec *res_iovs = NULL;
-    int num_iovs = 0;
 
     VIRTIO_GPU_FILL_CMD(unref);
     trace_virtio_gpu_cmd_res_unref(unref.resource_id);
@@ -364,27 +400,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
         return;
     }
 
-#if VIRGL_VERSION_MAJOR >= 1
-    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
-        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-        return;
-    }
-    if (*cmd_suspended) {
-        return;
-    }
-#endif
+    virtio_gpu_virgl_resource_unref(g, res, cmd_suspended);
+}
 
-    virgl_renderer_resource_detach_iov(unref.resource_id,
-                                       &res_iovs,
-                                       &num_iovs);
-    if (res_iovs != NULL && num_iovs != 0) {
-        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
-    }
-    virgl_renderer_resource_unref(unref.resource_id);
+void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
+                                       struct virtio_gpu_simple_resource *base,
+                                       Error **errp)
+{
+    struct virtio_gpu_virgl_resource *res;
+    bool suspended = false;
 
-    QTAILQ_REMOVE(&g->reslist, &res->base, next);
+    res = container_of(base, struct virtio_gpu_virgl_resource, base);
 
-    g_free(res);
+    if (virtio_gpu_virgl_resource_unref(g, res, &suspended)) {
+        error_setg(errp, "failed to destroy virgl resource");
+    }
 }
 
 static void virgl_cmd_context_create(VirtIOGPU *g,
@@ -1305,6 +1335,10 @@ static void virtio_gpu_fence_poll(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+    if (!virtio_gpu_virgl_update_render_state(g)) {
+        return;
+    }
+
     virgl_renderer_force_ctx_0();
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
@@ -1329,14 +1363,30 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
     }
 }
 
-void virtio_gpu_virgl_reset(VirtIOGPU *g)
+static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
+    struct virtio_gpu_simple_resource *res, *tmp;
+
+    /*
+     * Virgl blob resource unmapping can be suspended and
+     * deferred on unref, ensure that destruction is completed.
+     */
+    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
+        virtio_gpu_virgl_resource_destroy(g, res, NULL);
+    }
+
+    if (!QTAILQ_EMPTY(&g->reslist)) {
+        return false;
+    }
+
     virgl_renderer_reset();
 
     virtio_gpu_virgl_reset_async_fences(g);
+
+    return true;
 }
 
-int virtio_gpu_virgl_init(VirtIOGPU *g)
+static int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
     uint32_t flags = 0;
@@ -1414,6 +1464,33 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     return 0;
 }
 
+bool virtio_gpu_virgl_update_render_state(VirtIOGPU *g)
+{
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    switch (gl->renderer_state) {
+    case RS_RESET:
+        if (!virtio_gpu_virgl_reset(g)) {
+            return false;
+        }
+        /* fallthrough */
+    case RS_START:
+        if (virtio_gpu_virgl_init(g)) {
+            gl->renderer_state = RS_INIT_FAILED;
+            return false;
+        }
+
+        gl->renderer_state = RS_INITED;
+        break;
+    case RS_INIT_FAILED:
+        return false;
+    case RS_INITED:
+        break;
+    }
+
+    return true;
+}
+
 static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
 {
     g_array_append_val(capset_ids, capset_id);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 718332284305..1f509d0d5beb 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -389,9 +389,11 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd);
 void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
-void virtio_gpu_virgl_reset(VirtIOGPU *g);
-int virtio_gpu_virgl_init(VirtIOGPU *g);
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
 void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
+void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
+                                       struct virtio_gpu_simple_resource *res,
+                                       Error **errp);
+bool virtio_gpu_virgl_update_render_state(VirtIOGPU *g);
 
 #endif
-- 
2.52.0


