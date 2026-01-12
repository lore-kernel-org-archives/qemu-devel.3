Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1056DCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQoN-0002Jq-3e; Mon, 12 Jan 2026 17:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vfQoK-0001nS-2F
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:56 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vfQoI-0003qR-CL
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:54:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1768258479; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fyc3bxxveTanVn20+kGnhyxKCr2fHmkxDVLrzXPBtdhvS5yu9gXTJGaYfps/JQkCimJC1Ia74FIbrdiYBKRFcPmGTgMdudEzl+DVd49ubfW87kggTW21rC9WPISPBk4iu1GZxJLKjkx7Qu6ruZsDyD7AYUv6qJruIIbTYXHCxfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768258479;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O1l2kepzrFLu8Ed525OLoEBgvlYq2v2ycersF8BUxgY=; 
 b=kc4bzoVPlhv3UIwBmEyPpkb3GJ7hWlfTJ8K9+Q6C7CkPsKoG6EVAixR+we9iXgO9Fz+wSq0qJXnnlyuShsokUzL58uiJDGF8u+HBnamdvg4C4tv9JiaSFsWmHKhYmG+dcYIotWG61ieW+nBd00y2affSTL/pgxoI78NFT894GaU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768258479; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=O1l2kepzrFLu8Ed525OLoEBgvlYq2v2ycersF8BUxgY=;
 b=JE2l8cS1iUDHUj95CfLud9CZ4FQJ051jyXoxK6+1KXb8ZNRYMzqSXmxRJqxOS88V
 2P2iH7XeTgu84TaWAuKCuQED26ldM0erSA3bPyRjlhlaACol7/OwnxUaHFOeV67bZpb
 0w4/0aOYIdagoOqo6WtkeAdu5c/75QlI1eE+rG+0=
Received: by mx.zohomail.com with SMTPS id 1768258478476556.4472182448446;
 Mon, 12 Jan 2026 14:54:38 -0800 (PST)
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
Subject: [RFC PATCH v9 3/5] virtio-gpu: Replace finish_unmapping with
 mapping_state
Date: Tue, 13 Jan 2026 01:52:44 +0300
Message-ID: <20260112225246.3526313-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112225246.3526313-1-dmitry.osipenko@collabora.com>
References: <20260112225246.3526313-1-dmitry.osipenko@collabora.com>
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

Allow virtio_gpu_virgl_unmap_resource_blob() to be invoked while async
unmapping is in progress. Do it in preparation to improvement of virtio-gpu
resetting that will require this change.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/trace-events       |  2 +-
 hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/display/trace-events b/hw/display/trace-events
index e323a82cff24..4bfc457fbac1 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -39,7 +39,7 @@ virtio_gpu_cmd_res_create_2d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h)
 virtio_gpu_cmd_res_create_3d(uint32_t res, uint32_t fmt, uint32_t w, uint32_t h, uint32_t d) "res 0x%x, fmt 0x%x, w %d, h %d, d %d"
 virtio_gpu_cmd_res_create_blob(uint32_t res, uint64_t size) "res 0x%x, size %" PRId64
 virtio_gpu_cmd_res_map_blob(uint32_t res, void *vmr, void *mr) "res 0x%x, vmr %p, mr %p"
-virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, bool finish_unmapping) "res 0x%x, mr %p, finish_unmapping %d"
+virtio_gpu_cmd_res_unmap_blob(uint32_t res, void *mr, int mapping_state) "res 0x%x, mr %p, mapping_state %d"
 virtio_gpu_cmd_res_unref(uint32_t res) "res 0x%x"
 virtio_gpu_cmd_res_back_attach(uint32_t res) "res 0x%x"
 virtio_gpu_cmd_res_back_detach(uint32_t res) "res 0x%x"
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 6a2aac0b6e5c..342e93728df0 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -68,10 +68,16 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 #endif
 
 #if VIRGL_VERSION_MAJOR >= 1
+enum virtio_gpu_virgl_hostmem_region_mapping_state {
+    VIRTIO_GPU_MR_MAPPED,
+    VIRTIO_GPU_MR_UNMAP_STARTED,
+    VIRTIO_GPU_MR_UNMAP_COMPLETED,
+};
+
 struct virtio_gpu_virgl_hostmem_region {
     MemoryRegion mr;
     struct VirtIOGPU *g;
-    bool finish_unmapping;
+    enum virtio_gpu_virgl_hostmem_region_mapping_state mapping_state;
 };
 
 static struct virtio_gpu_virgl_hostmem_region *
@@ -95,7 +101,7 @@ static void virtio_gpu_virgl_hostmem_region_free(void *obj)
     VirtIOGPUGL *gl;
 
     vmr = to_hostmem_region(mr);
-    vmr->finish_unmapping = true;
+    vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_COMPLETED;
 
     b = VIRTIO_GPU_BASE(vmr->g);
     b->renderer_blocked--;
@@ -135,6 +141,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 
     vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
     vmr->g = g;
+    vmr->mapping_state = VIRTIO_GPU_MR_MAPPED;
 
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
@@ -171,7 +178,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 
     vmr = to_hostmem_region(res->mr);
 
-    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
+    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr,
+                                        vmr->mapping_state);
 
     /*
      * Perform async unmapping in 3 steps:
@@ -182,7 +190,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
-    if (vmr->finish_unmapping) {
+    switch (vmr->mapping_state) {
+    case VIRTIO_GPU_MR_UNMAP_COMPLETED:
         res->mr = NULL;
         g_free(vmr);
 
@@ -193,15 +202,24 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
                           __func__, strerror(-ret));
             return ret;
         }
-    } else {
+        break;
+
+    case VIRTIO_GPU_MR_MAPPED:
         *cmd_suspended = true;
 
         /* render will be unblocked once MR is freed */
         b->renderer_blocked++;
 
+        vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED;
+
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_del_subregion(&b->hostmem, mr);
         object_unparent(OBJECT(mr));
+        break;
+
+    case VIRTIO_GPU_MR_UNMAP_STARTED:
+        *cmd_suspended = true;
+        break;
     }
 
     return 0;
-- 
2.52.0


