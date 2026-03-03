Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D0BEDA688
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRWl-00072p-Ky; Tue, 03 Mar 2026 10:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRVQ-0005qJ-Ih
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:17:54 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vxRVL-0005Hv-1K
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:17:51 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1772551046; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CLv+IW46DR/icFuZtYvz/DtkklxG4CKTShEeMs7MHKy2srjt4aWv7kA1hecmkaTM52jpa8LzwOKX9ihLxGOHPYtBrZfpUrmBhBccMZ+TPFSIdiTSS2GZxqkRnnoEK61w1G2NdSlqjlCUT3U4ZZtOFT7HCw8SRa+PoRwsJ81agc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1772551046;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mlafvaavzFb8hbIh7dyaYf4UHQ8v0sMSE2LAPljIEVk=; 
 b=L5H3U0MNhqyuOrgg0zh/q8jK0YXsv7yruQfNh67aXkTG18Kg69mIurQVZcBxA5VdJLGNs7IlDDdxuELbnXBlB7EI4piS6TKaDm0qbkL8D96eDO3dCO5b6qbKoOSYeW3Iiy77qyonNlazns9OEUA8gQsOjoctzCEdjL1PW/aZPW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772551046; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=mlafvaavzFb8hbIh7dyaYf4UHQ8v0sMSE2LAPljIEVk=;
 b=ddXlbR6CE8ZTZcjeg2Zizo8MOdLOTSv4dQk5iSSxncW42BOOVT9XbjcZl+DGFg+H
 S1pzFvJ72kZpc6O/V0ltDFxMIaOMA+bTROd+tLe++0RdxeCO3yrJPAAvWj9PjRG9PM5
 K7U+yLB4A83bbqu5ghcZxDBfSbSuvNKcrqROaWko=
Received: by mx.zohomail.com with SMTPS id 1772551044893224.86843884888776;
 Tue, 3 Mar 2026 07:17:24 -0800 (PST)
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
Subject: [PATCH v22 16/18] virtio-gpu: Replace finish_unmapping with
 mapping_state
Date: Tue,  3 Mar 2026 18:14:19 +0300
Message-ID: <20260303151422.977399-17-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
References: <20260303151422.977399-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/trace-events       |  2 +-
 hw/display/virtio-gpu-virgl.c | 28 ++++++++++++++++++++++------
 2 files changed, 23 insertions(+), 7 deletions(-)

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
index f4d1113827e3..d1b5162f4408 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -68,11 +68,17 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 #endif
 
 #if VIRGL_VERSION_MAJOR >= 1
+enum virtio_gpu_virgl_hostmem_region_mapping_state {
+    VIRTIO_GPU_MR_MAPPED,
+    VIRTIO_GPU_MR_UNMAP_STARTED,
+    VIRTIO_GPU_MR_UNMAP_COMPLETED,
+};
+
 struct virtio_gpu_virgl_hostmem_region {
     Object parent_obj;
     MemoryRegion mr;
     struct VirtIOGPU *g;
-    bool finish_unmapping;
+    enum virtio_gpu_virgl_hostmem_region_mapping_state mapping_state;
 };
 
 #define TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION "virtio-gpu-virgl-hostmem-region"
@@ -109,7 +115,7 @@ static void virtio_gpu_virgl_hostmem_region_finalize(Object *obj)
         return;
     }
 
-    vmr->finish_unmapping = true;
+    vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_COMPLETED;
 
     b = VIRTIO_GPU_BASE(vmr->g);
     b->renderer_blocked--;
@@ -167,6 +173,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     object_initialize_child(OBJECT(g), name, vmr,
                             TYPE_VIRTIO_GPU_VIRGL_HOSTMEM_REGION);
     vmr->g = g;
+    vmr->mapping_state = VIRTIO_GPU_MR_MAPPED;
 
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(vmr), "mr", size, data);
@@ -195,7 +202,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 
     vmr = to_hostmem_region(res->mr);
 
-    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr, vmr->finish_unmapping);
+    trace_virtio_gpu_cmd_res_unmap_blob(res->base.resource_id, mr,
+                                        vmr->mapping_state);
 
     /*
      * Perform async unmapping in 3 steps:
@@ -206,7 +214,8 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      *    asynchronously by virtio_gpu_virgl_hostmem_region_finalize().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
-    if (vmr->finish_unmapping) {
+    switch (vmr->mapping_state) {
+    case VIRTIO_GPU_MR_UNMAP_COMPLETED:
         res->mr = NULL;
         g_free(vmr);
 
@@ -217,15 +226,22 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
                           __func__, strerror(-ret));
             return ret;
         }
-    } else {
-        *cmd_suspended = true;
+        break;
 
+    case VIRTIO_GPU_MR_MAPPED:
         /* render will be unblocked once MR is freed */
         b->renderer_blocked++;
 
+        vmr->mapping_state = VIRTIO_GPU_MR_UNMAP_STARTED;
+
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_del_subregion(&b->hostmem, mr);
         object_unparent(OBJECT(vmr));
+
+        /* Fallthrough */
+    case VIRTIO_GPU_MR_UNMAP_STARTED:
+        *cmd_suspended = true;
+        break;
     }
 
     return 0;
-- 
2.52.0


