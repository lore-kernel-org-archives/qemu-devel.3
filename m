Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2E4C25B4F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5rPc-0000LR-Py; Sat, 11 May 2024 14:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPc-0000L2-2o
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:36 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPZ-00050R-VB
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715451933;
 bh=pSicoZFh2EkLxZ4xgYNpW8EmwB8gyFSjTuMQTY4v8BI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tzo+9OhnzTaIIqC6kpGtRhs2BAzxoPi+4vQo4aLcB2r4JC8OBdwKvLqgHsINeXt8C
 RVrIhHIMl//EtJnzl8/Wx5TEeOp0ke1hY9En4+c43xvnDqYh3qcB6oppp1MwbRdCAF
 vDFY5DP2QESLQYZvvOzkTzMaI24LEb1LnmF0H6sq7VrWJuabUW2GJnHGKsf6uzZfE1
 QL+S52moX8kEJjv9xUTJ/k07POS9DyLk95nhAIKhNsHY5/I8tI8z94dq/dTSgP1mjg
 2SQ5TdYE7wrdAzFm27FlKK2XmLzbuzbnFXo+OaCs9LqxFhVXerMRcVxVN0xd6A86Zu
 BH7apEde8sYFw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id A7A633782192;
 Sat, 11 May 2024 18:25:30 +0000 (UTC)
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
Subject: [PATCH v11 08/10] virtio-gpu: Handle resource blob commands
Date: Sat, 11 May 2024 21:22:49 +0300
Message-ID: <20240511182251.1442078-9-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

Support BLOB resources creation, mapping and unmapping by calling the
new stable virglrenderer 0.10 interface. Only enabled when available and
via the blob config. E.g. -device virtio-vga-gl,blob=true

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 274 ++++++++++++++++++++++++++++++++-
 hw/display/virtio-gpu.c        |   4 +-
 include/hw/virtio/virtio-gpu.h |   2 +
 3 files changed, 277 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 524f15220b7f..3f2e406be3a4 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -26,6 +26,7 @@
 
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
+    MemoryRegion *mr;
 };
 
 static struct virtio_gpu_virgl_resource *
@@ -49,6 +50,117 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 }
 #endif
 
+#ifdef HAVE_VIRGL_RESOURCE_BLOB
+struct virtio_gpu_virgl_hostmem_region {
+    MemoryRegion mr;
+    struct VirtIOGPU *g;
+    struct virtio_gpu_virgl_resource *res;
+};
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
+
+    vmr = container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
+    vmr->res->mr = NULL;
+
+    b = VIRTIO_GPU_BASE(vmr->g);
+    b->renderer_blocked--;
+
+    /*
+     * memory_region_unref() is executed from RCU thread context, while
+     * virglrenderer works only on the main-loop thread that's holding GL
+     * context.
+     */
+    qemu_bh_schedule(vmr->g->cmdq_resume_bh);
+    g_free(vmr);
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
+    vmr->res = res;
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
+virtio_gpu_virgl_async_unmap_resource_blob(VirtIOGPU *g,
+                                           struct virtio_gpu_virgl_resource *res)
+{
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    MemoryRegion *mr = res->mr;
+    int ret;
+
+    if (mr) {
+        /* render will be unblocked once MR is freed */
+        b->renderer_blocked++;
+
+        /* memory region owns self res->mr object and frees it by itself */
+        memory_region_set_enabled(mr, false);
+        memory_region_del_subregion(&b->hostmem, mr);
+        object_unparent(OBJECT(mr));
+    } else {
+        ret = virgl_renderer_resource_unmap(res->base.resource_id);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: failed to unmap virgl resource: %s\n",
+                          __func__, strerror(-ret));
+            return ret;
+        }
+    }
+
+    return 0;
+}
+#endif /* HAVE_VIRGL_RESOURCE_BLOB */
+
 static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
                                          struct virtio_gpu_ctrl_command *cmd)
 {
@@ -146,7 +258,8 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
 }
 
 static void virgl_cmd_resource_unref(VirtIOGPU *g,
-                                     struct virtio_gpu_ctrl_command *cmd)
+                                     struct virtio_gpu_ctrl_command *cmd,
+                                     bool *cmd_suspended)
 {
     struct virtio_gpu_resource_unref unref;
     struct virtio_gpu_virgl_resource *res;
@@ -164,6 +277,12 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
         return;
     }
 
+    if (res->mr) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource is mapped\n", __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+
     virgl_renderer_resource_detach_iov(unref.resource_id,
                                        &res_iovs,
                                        &num_iovs);
@@ -514,6 +633,134 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
 }
 
 #ifdef HAVE_VIRGL_RESOURCE_BLOB
+static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
+                                           struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
+    struct virtio_gpu_resource_create_blob cblob;
+    struct virtio_gpu_virgl_resource *res;
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
+            g_free(res);
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return;
+        }
+    }
+
+    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
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
+    }
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
+    ret = virtio_gpu_virgl_async_unmap_resource_blob(g, res);
+    if (ret) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+
+    if (res->mr) {
+        *cmd_suspended = true;
+    }
+}
+
 static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
                                        struct virtio_gpu_ctrl_command *cmd)
 {
@@ -616,6 +863,8 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
+    bool cmd_suspended = false;
+
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
     virgl_renderer_force_ctx_0();
@@ -657,7 +906,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virgl_cmd_resource_flush(g, cmd);
         break;
     case VIRTIO_GPU_CMD_RESOURCE_UNREF:
-        virgl_cmd_resource_unref(g, cmd);
+        virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
         break;
     case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
         /* TODO add security */
@@ -680,6 +929,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virtio_gpu_get_edid(g, cmd);
         break;
 #ifdef HAVE_VIRGL_RESOURCE_BLOB
+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
+        virgl_cmd_resource_create_blob(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
+        virgl_cmd_resource_map_blob(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
+        virgl_cmd_resource_unmap_blob(g, cmd, &cmd_suspended);
+        break;
     case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
         virgl_cmd_set_scanout_blob(g, cmd);
         break;
@@ -689,6 +947,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         break;
     }
 
+    if (cmd_suspended) {
+        return;
+    }
     if (cmd->finished) {
         return;
     }
@@ -854,6 +1115,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
                                       virtio_gpu_print_stats, g);
         timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
     }
+
+    g->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
+                                   virtio_gpu_virgl_resume_cmdq_bh,
+                                   g);
+
     return 0;
 }
 
@@ -869,6 +1135,10 @@ int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
 
 void virtio_gpu_virgl_deinit(VirtIOGPU *g)
 {
+    if (g->cmdq_resume_bh) {
+        qemu_bh_delete(g->cmdq_resume_bh);
+    }
+
     if (g->fence_poll) {
         timer_free(g->fence_poll);
     }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 6c8c7213bafa..052ab493a00b 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1483,10 +1483,12 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
             return;
         }
 
+#ifndef HAVE_VIRGL_RESOURCE_BLOB
         if (virtio_gpu_virgl_enabled(g->parent_obj.conf)) {
-            error_setg(errp, "blobs and virgl are not compatible (yet)");
+            error_setg(errp, "old virglrenderer, blob resources unsupported");
             return;
         }
+#endif
     }
 
     if (!virtio_gpu_base_device_realize(qdev,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ba36497c477f..c0b0b0eac08b 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -210,6 +210,8 @@ struct VirtIOGPU {
         QTAILQ_HEAD(, VGPUDMABuf) bufs;
         VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
     } dmabuf;
+
+    QEMUBH *cmdq_resume_bh;
 };
 
 struct VirtIOGPUClass {
-- 
2.44.0


