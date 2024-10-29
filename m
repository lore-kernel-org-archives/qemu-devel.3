Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A46D2AB2F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3o-0004fX-T3; Tue, 29 Oct 2024 08:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3d-0004co-Ox
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3b-0007U4-1e
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso51937085e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203841; x=1730808641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eiF4We6U1bIBZNQjR2pbzHUxPZUiAb1h+dbUtjDVgno=;
 b=RJf6E70Raw/+XMo+Imm1XWlDpTOU2tF6Ku8/j4F9loDMiXFBUmEaxBSde3kwSNtwP8
 ssjRcLyLnPlbi7ux1wDhdN+yYB8KOzpDvwJ4ElWQ4s9R7OFwv7L8X5cCtKvb47xK6aGc
 zdH5/Gpy+M7PFmb56xJqJe11isjvuIwfoJfszaVQjG61Zp5+AXeBriclQldbCvc085Ew
 HZ9sXrR5QcbCDhU2u8w6aDVaYdRQ7BAmE4rqKcH2rU4P8nZSYrLr76NRAZEnJa8cJ5Jn
 yvzF2wyC5z352zaxcYXUs//Z/r2r655zzSoFynjlQZ4uqbGzVvGunAzR446xHhpCSymT
 2Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203841; x=1730808641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiF4We6U1bIBZNQjR2pbzHUxPZUiAb1h+dbUtjDVgno=;
 b=e8drDyGjSgqkC/7dSnTfwJDJ64fOFE/5DcrP2F24hpkwMisZvqGrs7AUdy10GJESt1
 IeHXy7k7WvWC16n4Is8scnEqc8GpGQ6ksRApQAcjPE+tX9bsoZax79ZcZzYGMHaKcLSw
 bqzMZ9/jPt4HJZxhwNAi110CMNtwra3LVTSzUwKH+JcpALmjyjKugoW1hU9TFVnMCew6
 0g1UhjpEqoE5GJfzSdSkK5kReN+hITo9sPiygbqB5gCr5BsKa7mNBwn2baRW4L/Vim39
 qX2on3MErnnjmBIS7s62mF4aMU7cnceLaWACLZw4HqjA5Z3yuh362iK5NG7wtiwGa0jc
 H3pg==
X-Gm-Message-State: AOJu0YzXG/ggFw/Ucv06z7WxR39OTetG/CF64FbBb6rUI1tp51/Rx8yd
 uHrRPS/ZncOVg1Mfg3ZhbHVVezjZNARx/tbpaoq0+RJx6Y+yBJwGu/wWLhzgsQs=
X-Google-Smtp-Source: AGHT+IFfyjuOXzAhix1CnQobxCVbSp5IaqDAne7KD+mJinDyPnkPeyhxtVA4D86eHALcO8Vzxmm6NQ==
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4319ac6fb93mr105702185e9.5.1730203840954; 
 Tue, 29 Oct 2024 05:10:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b56ef06sm173199245e9.30.2024.10.29.05.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8772E5FB6B;
 Tue, 29 Oct 2024 12:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Robert Beckett <bob.beckett@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 11/13] virtio-gpu: Handle resource blob commands
Date: Tue, 29 Oct 2024 12:10:28 +0000
Message-Id: <20241029121030.4007014-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Support BLOB resources creation, mapping, unmapping and set-scanout by
calling the new stable virglrenderer 0.10 interface. Only enabled when
available and via the blob config. E.g. -device virtio-vga-gl,blob=true

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com> # added set_scanout_blob
Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-12-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 71775243e9..f9ed81071f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -237,6 +237,8 @@ struct VirtIOGPUGL {
 
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
+
+    QEMUBH *cmdq_resume_bh;
 };
 
 struct VhostUserGPU {
@@ -336,6 +338,13 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
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
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index bf87ba4232..f2555673a1 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -166,6 +166,9 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
 
     if (gl->renderer_state >= RS_INITED) {
+#if VIRGL_VERSION_MAJOR >= 1
+        qemu_bh_delete(gl->cmdq_resume_bh);
+#endif
         if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
             timer_free(gl->print_stats);
         }
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 3ffea478e7..b2f4e215a7 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -17,6 +17,8 @@
 #include "trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
+#include "hw/virtio/virtio-gpu-bswap.h"
+#include "hw/virtio/virtio-gpu-pixman.h"
 
 #include "ui/egl-helpers.h"
 
@@ -24,6 +26,7 @@
 
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
+    MemoryRegion *mr;
 };
 
 static struct virtio_gpu_virgl_resource *
@@ -47,6 +50,145 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 }
 #endif
 
+#if VIRGL_VERSION_MAJOR >= 1
+struct virtio_gpu_virgl_hostmem_region {
+    MemoryRegion mr;
+    struct VirtIOGPU *g;
+    bool finish_unmapping;
+};
+
+static struct virtio_gpu_virgl_hostmem_region *
+to_hostmem_region(MemoryRegion *mr)
+{
+    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
+}
+
+static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_process_cmdq(g);
+}
+
+static void virtio_gpu_virgl_hostmem_region_free(void *obj)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    struct virtio_gpu_virgl_hostmem_region *vmr;
+    VirtIOGPUBase *b;
+    VirtIOGPUGL *gl;
+
+    vmr = to_hostmem_region(mr);
+    vmr->finish_unmapping = true;
+
+    b = VIRTIO_GPU_BASE(vmr->g);
+    b->renderer_blocked--;
+
+    /*
+     * memory_region_unref() is executed from RCU thread context, while
+     * virglrenderer works only on the main-loop thread that's holding GL
+     * context.
+     */
+    gl = VIRTIO_GPU_GL(vmr->g);
+    qemu_bh_schedule(gl->cmdq_resume_bh);
+}
+
+static int
+virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
+                                   struct virtio_gpu_virgl_resource *res,
+                                   uint64_t offset)
+{
+    struct virtio_gpu_virgl_hostmem_region *vmr;
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    MemoryRegion *mr;
+    uint64_t size;
+    void *data;
+    int ret;
+
+    if (!virtio_gpu_hostmem_enabled(b->conf)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: hostmem disabled\n", __func__);
+        return -EOPNOTSUPP;
+    }
+
+    ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
+                      __func__, strerror(-ret));
+        return ret;
+    }
+
+    vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
+    vmr->g = g;
+
+    mr = &vmr->mr;
+    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_add_subregion(&b->hostmem, offset, mr);
+    memory_region_set_enabled(mr, true);
+
+    /*
+     * MR could outlive the resource if MR's reference is held outside of
+     * virtio-gpu. In order to prevent unmapping resource while MR is alive,
+     * and thus, making the data pointer invalid, we will block virtio-gpu
+     * command processing until MR is fully unreferenced and freed.
+     */
+    OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
+
+    res->mr = mr;
+
+    return 0;
+}
+
+static int
+virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
+                                     struct virtio_gpu_virgl_resource *res,
+                                     bool *cmd_suspended)
+{
+    struct virtio_gpu_virgl_hostmem_region *vmr;
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    MemoryRegion *mr = res->mr;
+    int ret;
+
+    if (!mr) {
+        return 0;
+    }
+
+    vmr = to_hostmem_region(res->mr);
+
+    /*
+     * Perform async unmapping in 3 steps:
+     *
+     * 1. Begin async unmapping with memory_region_del_subregion()
+     *    and suspend/block cmd processing.
+     * 2. Wait for res->mr to be freed and cmd processing resumed
+     *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
+     * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
+     */
+    if (vmr->finish_unmapping) {
+        res->mr = NULL;
+        g_free(vmr);
+
+        ret = virgl_renderer_resource_unmap(res->base.resource_id);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: failed to unmap virgl resource: %s\n",
+                          __func__, strerror(-ret));
+            return ret;
+        }
+    } else {
+        *cmd_suspended = true;
+
+        /* render will be unblocked once MR is freed */
+        b->renderer_blocked++;
+
+        /* memory region owns self res->mr object and frees it by itself */
+        memory_region_set_enabled(mr, false);
+        memory_region_del_subregion(&b->hostmem, mr);
+        object_unparent(OBJECT(mr));
+    }
+
+    return 0;
+}
+#endif
+
 static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
                                          struct virtio_gpu_ctrl_command *cmd)
 {
@@ -78,6 +220,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
     res->base.height = c2d.height;
     res->base.format = c2d.format;
     res->base.resource_id = c2d.resource_id;
+    res->base.dmabuf_fd = -1;
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c2d.resource_id;
@@ -125,6 +268,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
     res->base.height = c3d.height;
     res->base.format = c3d.format;
     res->base.resource_id = c3d.resource_id;
+    res->base.dmabuf_fd = -1;
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c3d.resource_id;
@@ -142,7 +286,8 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
 }
 
 static void virgl_cmd_resource_unref(VirtIOGPU *g,
-                                     struct virtio_gpu_ctrl_command *cmd)
+                                     struct virtio_gpu_ctrl_command *cmd,
+                                     bool *cmd_suspended)
 {
     struct virtio_gpu_resource_unref unref;
     struct virtio_gpu_virgl_resource *res;
@@ -160,6 +305,16 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
         return;
     }
 
+#if VIRGL_VERSION_MAJOR >= 1
+    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+    if (*cmd_suspended) {
+        return;
+    }
+#endif
+
     virgl_renderer_resource_detach_iov(unref.resource_id,
                                        &res_iovs,
                                        &num_iovs);
@@ -509,9 +664,241 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
     g_free(resp);
 }
 
+#if VIRGL_VERSION_MAJOR >= 1
+static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
+                                           struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
+    g_autofree struct virtio_gpu_virgl_resource *res = NULL;
+    struct virtio_gpu_resource_create_blob cblob;
+    struct virgl_renderer_resource_info info;
+    int ret;
+
+    if (!virtio_gpu_blob_enabled(g->parent_obj.conf)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    VIRTIO_GPU_FILL_CMD(cblob);
+    virtio_gpu_create_blob_bswap(&cblob);
+    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
+
+    if (cblob.resource_id == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
+    if (res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
+                      __func__, cblob.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.resource_id = cblob.resource_id;
+    res->base.blob_size = cblob.size;
+    res->base.dmabuf_fd = -1;
+
+    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
+        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
+                                            cmd, &res->base.addrs,
+                                            &res->base.iov, &res->base.iov_cnt);
+        if (!ret) {
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return;
+        }
+    }
+
+    virgl_args.res_handle = cblob.resource_id;
+    virgl_args.ctx_id = cblob.hdr.ctx_id;
+    virgl_args.blob_mem = cblob.blob_mem;
+    virgl_args.blob_id = cblob.blob_id;
+    virgl_args.blob_flags = cblob.blob_flags;
+    virgl_args.size = cblob.size;
+    virgl_args.iovecs = res->base.iov;
+    virgl_args.num_iovs = res->base.iov_cnt;
+
+    ret = virgl_renderer_resource_create_blob(&virgl_args);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error: %s\n",
+                      __func__, strerror(-ret));
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        virtio_gpu_cleanup_mapping(g, &res->base);
+        return;
+    }
+
+    ret = virgl_renderer_resource_get_info(cblob.resource_id, &info);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: resource does not have info %d: %s\n",
+                      __func__, cblob.resource_id, strerror(-ret));
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        virtio_gpu_cleanup_mapping(g, &res->base);
+        virgl_renderer_resource_unref(cblob.resource_id);
+        return;
+    }
+
+    res->base.dmabuf_fd = info.fd;
+
+    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
+    res = NULL;
+}
+
+static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
+                                        struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_map_blob mblob;
+    struct virtio_gpu_virgl_resource *res;
+    struct virtio_gpu_resp_map_info resp;
+    int ret;
+
+    VIRTIO_GPU_FILL_CMD(mblob);
+    virtio_gpu_map_blob_bswap(&mblob);
+
+    res = virtio_gpu_virgl_find_resource(g, mblob.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, mblob.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    ret = virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
+    if (ret) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+
+    memset(&resp, 0, sizeof(resp));
+    resp.hdr.type = VIRTIO_GPU_RESP_OK_MAP_INFO;
+    virgl_renderer_resource_get_map_info(mblob.resource_id, &resp.map_info);
+    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
+}
+
+static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
+                                          struct virtio_gpu_ctrl_command *cmd,
+                                          bool *cmd_suspended)
+{
+    struct virtio_gpu_resource_unmap_blob ublob;
+    struct virtio_gpu_virgl_resource *res;
+    int ret;
+
+    VIRTIO_GPU_FILL_CMD(ublob);
+    virtio_gpu_unmap_blob_bswap(&ublob);
+
+    res = virtio_gpu_virgl_find_resource(g, ublob.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, ublob.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
+    if (ret) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+}
+
+static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
+                                       struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_framebuffer fb = { 0 };
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
+    if (res->base.dmabuf_fd < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource not backed by dmabuf %d\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
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
+    bool cmd_suspended = false;
+
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
     virgl_renderer_force_ctx_0();
@@ -553,7 +940,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virgl_cmd_resource_flush(g, cmd);
         break;
     case VIRTIO_GPU_CMD_RESOURCE_UNREF:
-        virgl_cmd_resource_unref(g, cmd);
+        virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
         break;
     case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
         /* TODO add security */
@@ -575,12 +962,26 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     case VIRTIO_GPU_CMD_GET_EDID:
         virtio_gpu_get_edid(g, cmd);
         break;
+#if VIRGL_VERSION_MAJOR >= 1
+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
+        virgl_cmd_resource_create_blob(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
+        virgl_cmd_resource_map_blob(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
+        virgl_cmd_resource_unmap_blob(g, cmd, &cmd_suspended);
+        break;
+    case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
+        virgl_cmd_set_scanout_blob(g, cmd);
+        break;
+#endif
     default:
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         break;
     }
 
-    if (cmd->finished) {
+    if (cmd_suspended || cmd->finished) {
         return;
     }
     if (cmd->error) {
@@ -749,6 +1150,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         timer_mod(gl->print_stats,
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
     }
+
+#if VIRGL_VERSION_MAJOR >= 1
+    gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
+                                    virtio_gpu_virgl_resume_cmdq_bh,
+                                    g);
+#endif
+
     return 0;
 }
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 180d882f0a..b6cd9fe567 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -362,7 +362,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
-static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
+void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     struct virtio_gpu_simple_resource *res;
@@ -579,11 +579,11 @@ static void virtio_unref_resource(pixman_image_t *image, void *data)
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
@@ -1467,10 +1467,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
             return;
         }
 
+#ifdef VIRGL_VERSION_MAJOR
+    #if VIRGL_VERSION_MAJOR < 1
         if (virtio_gpu_virgl_enabled(g->parent_obj.conf)) {
-            error_setg(errp, "blobs and virgl are not compatible (yet)");
+            error_setg(errp, "old virglrenderer, blob resources unsupported");
             return;
         }
+    #endif
+#endif
     }
 
     if (!virtio_gpu_base_device_realize(qdev,
-- 
2.39.5


