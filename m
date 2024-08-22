Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F27C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCxC-0003Q3-4a; Thu, 22 Aug 2024 14:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCxA-0003HM-Ex
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:36 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCx7-0004Br-Jz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352860; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iluU2Q00ycZ7qYrMj05LeynALUIT6XKNCddvDVryYQaizVVPgagJZbAcCmHbyaGHykcOFMdk1Hbl9xThk+JsmJjjEAsh7PwYflFZCtqMIFexpcTcqQvURH+KgDQbKjBphzmfnwaGpMCmwRW6p4kPsLA9PYOB5cURE+AfjLOpNyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352860;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UFsZQYPAifmGVoAnq32l06noSkTCS2DRkZcElIKgphI=; 
 b=RhfQplPr/MNfOatpNkjv5RARPevswMBHvI1oKhJNwF9g9UPJl4Zoh2J3wmcTmqYKCPFitPXy380sFqOEABdW18crZHuamU2DG+GSWAMcDoNEC6bnjL2z/wr/aSkHruWVtVqpWq/jwCSaN84byHcsZcEKUHTPb9SE+hXNIzVp6dM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352860; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=UFsZQYPAifmGVoAnq32l06noSkTCS2DRkZcElIKgphI=;
 b=LVQX4GUROPvI2RQM9NjQxCxpTKeZWHkkyU1y1fl5h9iwOk4SEgRGhGswf/w9WrKW
 BEkSOLkAn1NZkK+TNDQCLI4kqsJNj3fm1PnonzGQ1g3Bnh2+FKaKv0Ko3lNGFE8gllQ
 XmwIgrYSn8S8jWS9n07F4PxvqBYk0WI0ygQP+AEs=
Received: by mx.zohomail.com with SMTPS id 1724352859045687.1189330326481;
 Thu, 22 Aug 2024 11:54:19 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
Subject: [PATCH v17 11/13] virtio-gpu: Handle resource blob commands
Date: Thu, 22 Aug 2024 21:51:07 +0300
Message-ID: <20240822185110.1757429-12-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |   3 +
 hw/display/virtio-gpu-virgl.c  | 414 ++++++++++++++++++++++++++++++++-
 hw/display/virtio-gpu.c        |  18 +-
 include/hw/virtio/virtio-gpu.h |   9 +
 4 files changed, 434 insertions(+), 10 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index bf87ba423283..f2555673a18e 100644
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
index 3ffea478e723..b2f4e215a7ad 100644
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
index 5015f17f9242..6a9eb880ebbf 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -379,7 +379,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
-static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
+void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     struct virtio_gpu_simple_resource *res;
@@ -596,11 +596,11 @@ static void virtio_unref_resource(pixman_image_t *image, void *data)
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
@@ -1496,10 +1496,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 6e71d799e5da..775005abb337 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -239,6 +239,8 @@ struct VirtIOGPUGL {
 
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
+
+    QEMUBH *cmdq_resume_bh;
 };
 
 struct VhostUserGPU {
@@ -338,6 +340,13 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
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
-- 
2.45.2


