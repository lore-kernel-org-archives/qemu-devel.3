Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6425DCCD19A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 14:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKdXV-0004Fu-0i; Sun, 16 Nov 2025 09:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdXU-0004Dl-8B
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 09:15:36 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKdXQ-0006YF-GJ
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 09:15:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763302516; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BjJiVUU7b3tvFN0GtG4dV6VthH7MAyjxVyq+A8CVM/fjue6DAOlRkazdiKWMWV9PEukEoxU/HyhcdgJgxxeHVaGlZkaFiGR6gjt+Red39BdAp1cdEWTPYArYvh3dnMCx8b8Rr8g4sju7gIo1Kvfcj6MELrFhXetV62d92AUMz/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763302516;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bXsQEwDMNiReSU8XvgUr5CPJNk/OZu/U3WLto1psaY0=; 
 b=DByiAGRsGECzq7tWFpVOCSSfVMToQoZAdn5Zr0OdVEhfK5ZMPtn/OzegdLjio1TV5ULfXVhy+FqKhdi/b5q4Z+ijQ2E+3uqHQE53QiqOHlsYfxW4vCuHVoIl4zffujyBOlCUquJNtSLUizGS+nzDQevct6XbJd8w4i6k8D/xRfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763302516; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=bXsQEwDMNiReSU8XvgUr5CPJNk/OZu/U3WLto1psaY0=;
 b=B9BnCpwdJthrSQF0G8+HMlHU+uLIY00rncwndINlbNo10MCzuFnhiBUnjDG/QT41
 UXue4dB4BoCfvEv2mNa5QghhORtMcT0df91Kuws8YjvVIrVOCIAWKIaQ7BHFTW6lxNC
 rTDMvaUkolMWl1WPunezdDWNTaH3gntnwcFJBX7Y=
Received: by mx.zohomail.com with SMTPS id 1763302513883533.804153260273;
 Sun, 16 Nov 2025 06:15:13 -0800 (PST)
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
Subject: [RFC PATCH v2 2/2] virtio-gpu: Support mapping hostmem blobs with
 map_fixed
Date: Sun, 16 Nov 2025 17:14:27 +0300
Message-ID: <20251116141427.2325372-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
References: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 hw/display/virtio-gpu-gl.c     | 45 ++++++++++++++++++++-
 hw/display/virtio-gpu-virgl.c  | 74 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-gpu.h |  3 ++
 3 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index b640900fc6f1..23e0dd26c67b 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -121,7 +121,12 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
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
@@ -152,6 +157,33 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 #endif
 
     virtio_gpu_device_realize(qdev, errp);
+
+    /*
+     * Check whether virtio_gpu_device_realize() failed.
+     */
+    if (*errp) {
+        return;
+    }
+
+#if !defined(CONFIG_WIN32)
+    if (virtio_gpu_hostmem_enabled(b->conf)) {
+        map = mmap(NULL, b->conf.hostmem, PROT_READ | PROT_WRITE,
+                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+        if (map == MAP_FAILED) {
+            error_setg(errp,
+                       "virgl hostmem region could not be initialized: %s",
+                       strerror(errno));
+            return;
+        }
+
+        gl->hostmem_mmap = map;
+        gl->hostmem_background = g_new0(MemoryRegion, 1);
+        memory_region_init_ram_ptr(gl->hostmem_background, NULL,
+                                   "hostmem-background", b->conf.hostmem,
+                                   gl->hostmem_mmap);
+        memory_region_add_subregion(&b->hostmem, 0, gl->hostmem_background);
+    }
+#endif
 }
 
 static const Property virtio_gpu_gl_properties[] = {
@@ -165,6 +197,7 @@ static const Property virtio_gpu_gl_properties[] = {
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
 {
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev);
     VirtIOGPU *g = VIRTIO_GPU(qdev);
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
 
@@ -187,6 +220,16 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     gl->renderer_state = RS_START;
 
     g_array_unref(g->capset_ids);
+
+    /*
+     * It is not guaranteed that the memory region will be finalized
+     * immediately with memory_region_del_subregion(), there can be
+     * a remaining reference to gl->hostmem_mmap. VirtIO-GPU is not
+     * hotpluggable, hence no need to worry about the leaked mapping.
+     */
+    if (gl->hostmem_background) {
+        memory_region_del_subregion(&b->hostmem, gl->hostmem_background);
+    }
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index a6860f63b563..5a663ad2acfa 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -41,9 +41,14 @@
      VIRGL_VERSION_MICRO >= (micro))
 #endif
 
+#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(CONFIG_WIN32)
+    #define VIRGL_HAS_MAP_FIXED
+#endif
+
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
     MemoryRegion *mr;
+    void *map_fixed;
 };
 
 static struct virtio_gpu_virgl_resource *
@@ -116,6 +121,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 {
     struct virtio_gpu_virgl_hostmem_region *vmr;
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     MemoryRegion *mr;
     uint64_t size;
     void *data;
@@ -126,6 +132,41 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
         return -EOPNOTSUPP;
     }
 
+#ifdef VIRGL_HAS_MAP_FIXED
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
+         * -MAP_FIXED is unsupported by this resource.
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
@@ -138,7 +179,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
 
     mr = &vmr->mr;
     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
-    memory_region_add_subregion(&b->hostmem, offset, mr);
+    memory_region_add_subregion_overlap(gl->hostmem_background, offset, mr, 1);
 
     /*
      * MR could outlive the resource if MR's reference is held outside of
@@ -162,9 +203,28 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 {
     struct virtio_gpu_virgl_hostmem_region *vmr;
     VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
     MemoryRegion *mr = res->mr;
     int ret;
 
+#ifdef VIRGL_HAS_MAP_FIXED
+    if (res->map_fixed) {
+        res->map_fixed = mmap(res->map_fixed, res->base.blob_size,
+                              PROT_READ | PROT_WRITE,
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
@@ -200,7 +260,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
         b->renderer_blocked++;
 
         /* memory region owns self res->mr object and frees it by itself */
-        memory_region_del_subregion(&b->hostmem, mr);
+        memory_region_del_subregion(gl->hostmem_background, mr);
         object_unparent(OBJECT(mr));
     }
 
@@ -1265,6 +1325,16 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
 
 void virtio_gpu_virgl_reset(VirtIOGPU *g)
 {
+#ifdef VIRGL_HAS_MAP_FIXED
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+
+    if (gl->hostmem_mmap &&
+        mmap(gl->hostmem_mmap, b->conf.hostmem, PROT_READ | PROT_WRITE,
+             MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) == MAP_FAILED) {
+        error_report("failed to reset virgl hostmem: %s", strerror(errno));
+    }
+#endif
     virgl_renderer_reset();
 
     virtio_gpu_virgl_reset_async_fences(g);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 718332284305..bfe85a4e0449 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -263,6 +263,9 @@ struct VirtIOGPUGL {
 
     QEMUBH *async_fence_bh;
     QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
+
+    MemoryRegion *hostmem_background;
+    void *hostmem_mmap;
 };
 
 struct VhostUserGPU {
-- 
2.51.1


