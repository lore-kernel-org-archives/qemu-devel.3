Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D06E83828
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 19:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs43q-0001lC-Q4; Mon, 16 Feb 2026 14:15:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vs43b-0001cb-Ex
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 14:14:57 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vs43Z-0003eW-Io
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 14:14:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771269278; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZKVacDiNmUjWYqsoBa6S0BwQ6kaw/llYJd2s2rOSL65p4d06NGnONvpyXP2aI3PNKJv/wR4qYggWHt53islcPp7UrYAV/H/8/6jViV4x/xu8afdnJUu2V9Jr3yzDu3N2IP+lHxPaJToylUDnMjB80ce3FuJdZ6jzSsGqNXcch8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771269278;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=f33EyM850Pwg8IoPfEFrVAH8hkLh8qSKlEOC99ZgHrc=; 
 b=oFkOcCnbfkTFXPyMRsuaqgpj8+N1dqYuYg/8tpWyMwF5vaKL986qQsqD12Qzblhhp6nXzYfY5WK3R++7UbTtpdZYu5osxEI2SjnfKUddTrUBJRqUyPAV39o5z+szlrnYgy7W/n/KLWh/MBZ2V1lysjNMLocH45I6ZWH+82QaDok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771269278; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=f33EyM850Pwg8IoPfEFrVAH8hkLh8qSKlEOC99ZgHrc=;
 b=dL4GGhuIHzUz29iJqMxaLVm9scnFy6Jizsu6MbPVNPt6i78ysMeVmLQKaYpK1fEV
 1xjrj1CcYAOtp0pHCxCYPbrXA9V8IQ3+yV/ZpOuoR7W6xGwflWja1rbrJP0wc3VQWix
 GSzWsKA+9q2UjH/KFPDALXCtMqrkXHS86ahKeS5I=
Received: by mx.zohomail.com with SMTPS id 1771269275839527.6168215559057;
 Mon, 16 Feb 2026 11:14:35 -0800 (PST)
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
Subject: [PATCH v17 18/18] virtio-gpu: Support mapping hostmem blobs with
 map_fixed
Date: Mon, 16 Feb 2026 22:12:13 +0300
Message-ID: <20260216191213.2556073-19-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216191213.2556073-1-dmitry.osipenko@collabora.com>
References: <20260216191213.2556073-1-dmitry.osipenko@collabora.com>
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

Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     | 40 ++++++++++++++++++++++-
 hw/display/virtio-gpu-virgl.c  | 59 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-gpu.h |  3 ++
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 8b71dd6fc26f..48eeea32547c 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
+#include "qemu/mmap-alloc.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -106,7 +107,12 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
 static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 {
     ERRP_GUARD();
-    VirtIOGPU *g = VIRTIO_GPU(qdev);
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev);
+    VirtIOGPU *g = VIRTIO_GPU(b);
+#if !defined(CONFIG_WIN32)
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+    void *map;
+#endif
 
 #if HOST_BIG_ENDIAN
     error_setg(errp, "virgl is not supported on bigendian platforms");
@@ -136,7 +142,28 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
 #endif
 
+#if !defined(CONFIG_WIN32)
+    if (virtio_gpu_hostmem_enabled(b->conf)) {
+        map = qemu_ram_mmap(-1, b->conf.hostmem, qemu_real_host_page_size(),
+                            0, 0);
+        if (map == MAP_FAILED) {
+            error_setg_errno(errp, errno,
+                             "virgl hostmem region could not be initialized");
+            return;
+        }
+
+        gl->hostmem_mmap = map;
+        memory_region_init_ram_ptr(&gl->hostmem_background, NULL,
+                                   "hostmem-background", b->conf.hostmem,
+                                   gl->hostmem_mmap);
+        memory_region_add_subregion(&b->hostmem, 0, &gl->hostmem_background);
+    }
+#endif
+
     virtio_gpu_device_realize(qdev, errp);
+    if (*errp) {
+        return;
+    }
 }
 
 static const Property virtio_gpu_gl_properties[] = {
@@ -172,6 +199,17 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     gl->renderer_state = RS_START;
 
     g_array_unref(g->capset_ids);
+
+    /*
+     * It is not guaranteed that the memory region will be finalized
+     * immediately with memory_region_del_subregion(), there can be
+     * a remaining reference to gl->hostmem_mmap. VirtIO-GPU is not
+     * hotpluggable, hence no need to worry about the leaked mapping.
+     *
+     * The memory_region_del_subregion(gl->hostmem_background) is unnecessary
+     * because b->hostmem  and gl->hostmem_background belong to the same
+     * device and will be gone at the same time.
+     */
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 3f77946c7a3a..093ab8942805 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -41,9 +41,13 @@
      VIRGL_VERSION_MICRO >= (micro))
 #endif
 
+#define VIRGL_HAS_MAP_FIXED \
+    (VIRGL_CHECK_VERSION(1, 3, 0) && !IS_ENABLED(CONFIG_WIN32))
+
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
     MemoryRegion *mr;
+    void *map_fixed;
 };
 
 static struct virtio_gpu_virgl_resource *
@@ -155,6 +159,9 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
     g_autofree char *name = NULL;
     struct virtio_gpu_virgl_hostmem_region *vmr;
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+#if VIRGL_HAS_MAP_FIXED
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+#endif
     MemoryRegion *mr;
     uint64_t size;
     void *data;
@@ -165,6 +172,41 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
         return -EOPNOTSUPP;
     }
 
+#if VIRGL_HAS_MAP_FIXED
+    /*
+     * virgl_renderer_resource_map_fixed() allows to create multiple
+     * mappings of the same resource, while virgl_renderer_resource_map()
+     * not. Don't allow mapping same resource twice.
+     */
+    if (res->map_fixed || res->mr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to map(fixed) virgl resource: already mapped\n",
+                      __func__);
+        return -EBUSY;
+    }
+
+    ret = virgl_renderer_resource_map_fixed(res->base.resource_id,
+                                            gl->hostmem_mmap + offset);
+    switch (ret) {
+    case 0:
+        res->map_fixed = gl->hostmem_mmap + offset;
+        return 0;
+
+    case -EOPNOTSUPP:
+        /*
+         * MAP_FIXED is unsupported by this resource.
+         * Mapping falls back to a blob subregion method in that case.
+         */
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: failed to map(fixed) virgl resource: %s\n",
+                      __func__, strerror(-ret));
+        return ret;
+    }
+#endif
+
     ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
     if (ret) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
@@ -181,7 +223,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(vmr), "mr", size, data);
-    memory_region_add_subregion(&b->hostmem, offset, mr);
+    memory_region_add_subregion_overlap(&b->hostmem, offset, mr, 1);
 
     res->mr = mr;
 
@@ -200,6 +242,21 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
     MemoryRegion *mr = res->mr;
     int ret;
 
+#if VIRGL_HAS_MAP_FIXED
+    if (res->map_fixed) {
+        if (mmap(res->map_fixed, res->base.blob_size, PROT_READ | PROT_WRITE,
+                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
+                 -1, 0) == MAP_FAILED) {
+            ret = -errno;
+            error_report("%s: failed to unmap(fixed) virgl resource: %s",
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
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 1f509d0d5beb..a48b50d4c825 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -263,6 +263,9 @@ struct VirtIOGPUGL {
 
     QEMUBH *async_fence_bh;
     QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+
+    MemoryRegion hostmem_background;
+    void *hostmem_mmap;
 };
 
 struct VhostUserGPU {
-- 
2.52.0


