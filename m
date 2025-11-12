Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F234CD4F27
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 23:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJKKH-00026E-Mv; Wed, 12 Nov 2025 18:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vJKJt-0001u7-7h
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 18:32:15 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vJKJp-00009K-DL
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 18:32:08 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762990305; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LtFetJiRha60YPNtxqjGOqkHyZLTI67UeedW7HWNHGRAYbIEm0EzswS/LPEr9R3JFQksyxGNeuRIinwvv3k6IIegaTJvqEBqNn/t55Tyi23EayUu/rn298E/qO+0Uao8MmSyIgRkouYTsQmoLca/F/5W8q+1umuXGI4I2EEODzU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762990305;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=zO6LefTKOtoHo15yY77AFhGu23bL9EytvkBAn9FNtZM=; 
 b=kF4WLK0swp7hUK96okpj63qOh5B5HqMDKZFNkWUecq/9c8YeAg/pRlk43x/XpkbLcDI2lVS4jnj5cAgqeMVUD3uedthRrVn2rp/NQmwkUrFS68RmTHlYNp5EFP7h62abzBVZnFJrIj/I41mzeRT4EpxFVF2k1a1k+ZDylmB+pVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762990305; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=zO6LefTKOtoHo15yY77AFhGu23bL9EytvkBAn9FNtZM=;
 b=W+mN1QifW3/vR0SkHFaRPq8Xx7VvoO1lC/rmw5i+IOVskI4eAM9mMzzlAbYJA1Ea
 bs2PRr+Un4dnPMmbz3voRoFZS+aPJaFNUpBDNc05nuKw7tOEYWg+GKdnYWYHwbIGdUg
 SCBTYdy5jQOO4xMd8/XanTCjNbvnjrRnB/toqPnI=
Received: by mx.zohomail.com with SMTPS id 176299030415793.88056646782422;
 Wed, 12 Nov 2025 15:31:44 -0800 (PST)
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
Subject: [RFC PATCH v1 1/1] virtio-gpu: Support mapping hostmem blobs with
 map_fixed
Date: Thu, 13 Nov 2025 02:31:18 +0300
Message-ID: <20251112233118.1475381-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112233118.1475381-1-dmitry.osipenko@collabora.com>
References: <20251112233118.1475381-1-dmitry.osipenko@collabora.com>
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

Support mapping virgl blobs to a fixed location of a hostmem memory
region using new virglrenderer MAP_FIXED API.

This new feature closes multiple problems for virtio-gpu on QEMU:

- Having dedicated memory region for each mapped blob works notoriously
slow due to QEMU's memory region software design built around RCU that
isn't optimized for frequent removal of the regions

- KVM isn't optimized for a frequent slot changes too

- QEMU/KVM has a limit for a total number of created memory regions,
crashing QEMU when limit is reached

This patch makes virtio-gpu-gl to pre-create a single anonymous memory
region covering whole hostmem area to which blobs will be mapped using
the MAP_FIXED API.

Not all virgl resources will support mapping at a fixed memory address. For
them, we will continue to create individual nested memory sub-regions. In
particular, vrend resources may not have MAP_FIXED capability.

Venus and DRM native contexts will largely benefit from the MAP_FIXED
feature in terms of performance and stability improvement.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     | 37 +++++++++++++++++
 hw/display/virtio-gpu-virgl.c  | 72 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-gpu.h |  3 ++
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b640900fc6f1..e1481291948a 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -122,6 +122,9 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 {
     ERRP_GUARD();
     VirtIOGPU *g = VIRTIO_GPU(qdev);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    void *map;
 
 #if HOST_BIG_ENDIAN
     error_setg(errp, "virgl is not supported on bigendian platforms");
@@ -152,6 +155,31 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 #endif
 
     virtio_gpu_device_realize(qdev, errp);
+
+    /*
+     * Check whether virtio_gpu_device_realize() failed.
+     */
+    if (!g->ctrl_bh) {
+        return;
+    }
+
+    if (virtio_gpu_hostmem_enabled(b->conf)) {
+        map = mmap(NULL, b->conf.hostmem, PROT_NONE,
+                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        if (map == MAP_FAILED) {
+            error_setg(errp,
+                       "virgl hostmem region could not be initialized: %s",
+                       strerror(errno));
+            return;
+        }
+
+        gl->hostmem_mmap = map;
+        gl->hostmem_mr = g_new0(MemoryRegion, 1);
+        memory_region_init_ram_ptr(gl->hostmem_mr, NULL, "hostmem-anon",
+                                   b->conf.hostmem, gl->hostmem_mmap);
+        memory_region_add_subregion(&b->hostmem, 0, gl->hostmem_mr);
+        memory_region_set_enabled(gl->hostmem_mr, true);
+    }
 }
 
 static const Property virtio_gpu_gl_properties[] = {
@@ -167,6 +195,7 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPU *g = VIRTIO_GPU(qdev);
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
 
     if (gl->renderer_state >= RS_INITED) {
 #if VIRGL_VERSION_MAJOR >= 1
@@ -187,6 +216,14 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     gl->renderer_state = RS_START;
 
     g_array_unref(g->capset_ids);
+
+    if (gl->hostmem_mr) {
+        memory_region_set_enabled(gl->hostmem_mr, false);
+        memory_region_del_subregion(&b->hostmem, gl->hostmem_mr);
+    }
+    if (gl->hostmem_mmap) {
+        munmap(gl->hostmem_mmap, b->conf.hostmem);
+    }
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 5c9a9ee84392..d4188cf1d6b2 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -21,6 +21,7 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 
 #include "ui/egl-helpers.h"
+#include <stdio.h>
 
 #include <virglrenderer.h>
 
@@ -44,6 +45,7 @@
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
     MemoryRegion *mr;
+    void *map_fixed;
 };
 
 static struct virtio_gpu_virgl_resource *
@@ -116,6 +118,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 {
     struct virtio_gpu_virgl_hostmem_region *vmr;
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     MemoryRegion *mr;
     uint64_t size;
     void *data;
@@ -126,6 +129,40 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
         return -EOPNOTSUPP;
     }
 
+#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)
+    /*
+     * virgl_renderer_resource_map_fixed() allows to create multiple
+     * mappings of the same resource, while virgl_renderer_resource_map()
+     * not.
+     */
+    if (res->map_fixed || res->mr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to map(fixed) virgl resource: already mapped\n",
+                      __func__);
+        return -EBUSY;
+    }
+
+    /*
+     * -EOPNOTSUPP is returned if MAP_FIXED unsupported by this resource,
+     * mapping falls back to a blob subregion method in that case.
+     */
+    ret = virgl_renderer_resource_map_fixed(res->base.resource_id,
+                                            gl->hostmem_mmap + offset);
+    if (ret && ret != -EOPNOTSUPP) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to map(fixed) virgl resource: %s\n",
+                      __func__, strerror(-ret));
+        return ret;
+    }
+
+    if (ret == 0) {
+        fprintf(stderr, "virgl_renderer_resource_map_fixed\n");
+
+        res->map_fixed = gl->hostmem_mmap + offset;
+        return 0;
+    }
+#endif
+
     ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
     if (ret) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
@@ -138,7 +175,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
-    memory_region_add_subregion(&b->hostmem, offset, mr);
+    memory_region_add_subregion(gl->hostmem_mr, offset, mr);
     memory_region_set_enabled(mr, true);
 
     /*
@@ -163,9 +200,27 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 {
     struct virtio_gpu_virgl_hostmem_region *vmr;
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     MemoryRegion *mr = res->mr;
     int ret;
 
+#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)
+    if (res->map_fixed) {
+        res->map_fixed = mmap(res->map_fixed, res->base.blob_size, PROT_NONE,
+                              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+                              -1, 0);
+        if (res->map_fixed == MAP_FAILED) {
+            ret = -errno;
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: failed to unmap(fixed) virgl resource: %s\n",
+                          __func__, strerror(-ret));
+            return ret;
+        }
+
+        res->map_fixed = NULL;
+    }
+#endif
+
     if (!mr) {
         return 0;
     }
@@ -202,7 +257,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 
         /* memory region owns self res->mr object and frees it by itself */
         memory_region_set_enabled(mr, false);
-        memory_region_del_subregion(&b->hostmem, mr);
+        memory_region_del_subregion(gl->hostmem_mr, mr);
         object_unparent(OBJECT(mr));
     }
 
@@ -1270,9 +1325,22 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
 
 void virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
+#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+#endif
+
     virgl_renderer_reset();
 
     virtio_gpu_virgl_reset_async_fences(g);
+
+#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)
+    if (gl->hostmem_mmap &&
+        mmap(gl->hostmem_mmap, b->conf.hostmem, PROT_NONE,
+             MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) == MAP_FAILED) {
+        error_report("failed to reset virgl hostmem: %s", strerror(errno));
+    }
+#endif
 }
 
 int virtio_gpu_virgl_init(VirtIOGPU *g)
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 172f5ffce3ed..e1122edd6eeb 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -263,6 +263,9 @@ struct VirtIOGPUGL {
 
     QEMUBH *async_fence_bh;
     QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+
+    MemoryRegion *hostmem_mr;
+    void *hostmem_mmap;
 };
 
 struct VhostUserGPU {
-- 
2.51.1


