Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3907FCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybIl-0004sd-P3; Fri, 06 Mar 2026 14:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybId-0004rH-Bs
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:57:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybIb-0001Wt-3r
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:57:26 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48372efa020so85609355e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772827042; x=1773431842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwOC0PCe7NzEBubZnw5hYS6oFj5OnELU54pqMdnKW7c=;
 b=W8wurtGf32nkLv3iMFIq9FOaM0DM+J+dBCyrFC1oUfSGgR6ljx0tubkKeUQz6Vptav
 XZgVDBcaDsOXOw1mirVeWcOgqj4D8UB4H/q00Q/vJ8EbZ7jZQfppB+H4VNRKX+R2GZLL
 kFqbfWscdm+5qffV4Jbfx80AagGmHluyxbm6arcRGtMOretSlEziXmf9PVY+gWJOlPQX
 R97QmPSOiOJA89l1dNUNeIQQ2FDZMOb/8gm37KNklCJkQ7VA+y7OgqTcxKdjq/Vyy3IL
 /ASsmPBSnheUWxzVHTc7PMHDWL9Y8+SyvK35SJlLx0deh2S76YrsHDN9jXJSLHJjsEu3
 LpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772827042; x=1773431842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UwOC0PCe7NzEBubZnw5hYS6oFj5OnELU54pqMdnKW7c=;
 b=TA/tDu+SX6H3IHbugX2Oda6jrPFvAYXtwt4uT2Ecp0jOVfB13eGICEcpek6FhOznC8
 9JMrSuA1UKNTI7F18rPDdX7txRmBXcYAGtFbifX9GBjenfgoyv88C69+t5iD779DunCw
 sGHPrSWtUf94mNHRkMYw8VupoBHdR5al+ERX4PrHJlTiq3CpU6LHf+uKEw+KdupLPy0v
 z3H0zowvEH/pVhzUX0xvEc1OGDW12yHWC7+c8US87YLT1+huKwa+Ce9BHryBDNtEUwTw
 2dpSbMnXHb2P+S9vizFxCZzuaOLQrLSVesoTENSDwa/6wtwYE10VFQhlpCHnhwqOaXbU
 gDpw==
X-Gm-Message-State: AOJu0YzybUuhVVRW9pzf8/CyKfIxTBP7ROdTgCnaFl51j4QVsdVmmZU9
 VT1WFmj0FrEKU/AOteMvnu3RDljGo/CsEZO5AjW9/XIvsisCrVVkr21NI7fNi1G8Psg=
X-Gm-Gg: ATEYQzzPmbz/5jc9tR0OCY5EOc38Uthw5F9OmVPwTptHTsbWQepMIyymm2NHvVK7TR+
 bywZ3JMFZcMarq1VpF9u2DRXFUvLDkAN1Q79qLTPRu/hcC3/pl1AnL76AtFRP2Brq5G3yeTk1xf
 iI14eiiwpbFWkOXZ2LyhTq0tRC3aJWIaVpb5ri1UDQXKO4xIHx8k8m3YTYD4FF+SqFduQpQU9wG
 K7YcCN7GwDOUWxe8/pxO4BirmFGT5woMktA0XA3Ko6BSx+Vx1WeuEGryM9vClPczFXfRhNT5tLv
 xxN6/cg/LKzDMramFjlZ+rAIvh7HkMk6+7+UmJxQApbkIM9N221Z7kyOiDUA0xs/9OGH0/+BRYi
 pZ0eYMA7VlPO+o0SLulr/HYUm8yf9n6AqQZhrs6rp+gx9c14eSGfezvTMnEu4k8XiORTER95MIo
 gNU2kul5AczARl4y1fvWzDubs=
X-Received: by 2002:a05:600c:3acf:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-48526979e65mr54746975e9.26.1772827041697; 
 Fri, 06 Mar 2026 11:57:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48523803b5fsm25147495e9.7.2026.03.06.11.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:57:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB758689D1;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 19/20] virtio-gpu: Destroy virgl resources on virtio-gpu reset
Date: Fri,  6 Mar 2026 19:50:46 +0000
Message-ID: <20260306195048.2869788-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Properly destroy virgl resources on virtio-gpu reset to not leak resources
on a hot reboot of a VM.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-18-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-20-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 1a999887481..ec3db3b4123 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -390,9 +390,11 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
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
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b941e9a4b78..8b71dd6fc26 100644
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
index d1b5162f440..1819f9cb7e9 100644
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
@@ -1291,6 +1321,10 @@ static void virtio_gpu_fence_poll(void *opaque)
     VirtIOGPU *g = opaque;
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+    if (!virtio_gpu_virgl_update_render_state(g)) {
+        return;
+    }
+
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
     if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
@@ -1313,14 +1347,30 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
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
@@ -1398,6 +1448,35 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     return 0;
 }
 
+bool virtio_gpu_virgl_update_render_state(VirtIOGPU *g)
+{
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    switch (gl->renderer_state) {
+    case RS_RESET:
+        virgl_renderer_force_ctx_0();
+
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
-- 
2.47.3


