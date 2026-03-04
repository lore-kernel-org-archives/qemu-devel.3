Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEF4EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR8-0003xE-JQ; Wed, 04 Mar 2026 11:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR5-0003uR-Ow
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:59 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR3-0002SV-Tf
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:50:59 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65c5a778923so10688592a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643056; x=1773247856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0gctoCs5t//bM1s9oVaZawXqSrhxbVS02uOrAaRAIA=;
 b=x+/mEeSg1Fhn8CFSSyklnY2bx/MCdAHDdDKoDTBHU6Ho8XeNrjsK1m07ofgaWip3Lf
 niQ3UnpixKjmDy1URHzhkZjZ+csLLcj4r3eJq/CAU4QhH/l7ClZFZK6nOw7YKQjiH6mj
 5QMqTlCfg8JcecKheKVUFjLr1p5tvDPGsm3ZwsVC1kFmoZcZF0s/UXLPcyyA3BycFblM
 3/AmB+m5RBQbEp+sWzWjYXaNSwvcROCdua5SgxIRTOTGsh/wYptAyxZfgaDpIAsPt2YM
 D49zy584bW0VBpp2/y/s54aGFvKnRKuS400G9SoeZ+gcxvuTU2P7McUoG6rIEaR/5SZq
 Iskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643056; x=1773247856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U0gctoCs5t//bM1s9oVaZawXqSrhxbVS02uOrAaRAIA=;
 b=taQjuChvXnpoPfniDD8eC8G5mlLWJB6YJXhR1sp+Ugzft1iC8upV7flNSkEWmoHpcR
 VrMHmqr8luVWj/2Z6Eou8jC9zNuVlpVNDhHjoxLuFxxwFDm1R/X5//hkrbeH/DKA/L/q
 nk3fP64r/5SazeUNZIu+9/HKpt6983S1+uR6CdaH7ODdbhn881pZV/5hyrpQA+zmqPA8
 WekJ06VUk+EK2DbfPk7eMMrIAftoeGt5QAOEJAKaOb+th0DDP3Kh3EYWb47jjgmoLU8L
 iq9MdnSFQc2cdKABaaLrsItHq5yFEDlpYm/DojTNbdqyODgSgsBgyrx2wr0lZOGlCwy5
 0RxQ==
X-Gm-Message-State: AOJu0YxU6QrT3g8U6Vi4AZs0HwbohkOusHMjQEH8atpeJcOoxOApYmmu
 K4x8giqc4XgMYJUf//FBoZPJYTLUjzi4ur8qhtXm0hS+UPsAzsjQJ0x1DUaGCKsXUk4=
X-Gm-Gg: ATEYQzxmYALF63QNYhkw5tL3fowcUJEK4I/41W1KWgGUfIRxBFILLwJUEk4PKj9L6Ik
 Im6dubngtiVcyJZF4pf/ubA8ioot5YmHc9pX+Wi8IrtdbCqRkzgBHmTTsZ1hLoVz4Ym/m4/5crs
 p/jDb6MYcI2To2Ko74WKCaZlpI3S2fGdNjQAj9mnKxa+2WEdZDB2DP2di89iej+bi4tSEEwNwNr
 CXwmQyJPS3k9PXzZPCJkpPTqBpoRbVQUL8plj1gsczcrj4fxna8nB37QvbEc1fi2P6DCb+SgkE3
 A/GsZw9kct4Q6VnARGWVR4rYiU55w6IV0Ra02eQiqNTyC9cIBq5lYX1iZ6M0HCVDr9YGCexsg7O
 eyGbiaUieAFDaTDUtSZ/cfBLlJMARH3AVRaAEcukL1L3HR/tcCmA4Nyy0Nys6qmCVBLNYuqXuo9
 CN+ztfzrvncBlDQjkCR9G4lYM=
X-Received: by 2002:a05:6402:5188:b0:660:af39:2d15 with SMTP id
 4fb4d7f45d1cf-660efec5fd7mr1853548a12.17.1772643056328; 
 Wed, 04 Mar 2026 08:50:56 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabd46753sm5747120a12.8.2026.03.04.08.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:55 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87DB762DAA;
 Wed, 04 Mar 2026 16:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yiwei Zhang <zzyiwei@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 20/20] virtio-gpu: Support mapping hostmem blobs with map_fixed
Date: Wed,  4 Mar 2026 16:50:42 +0000
Message-ID: <20260304165043.1437519-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-19-dmitry.osipenko@collabora.com>
---
 include/hw/virtio/virtio-gpu.h |  3 ++
 hw/display/virtio-gpu-gl.c     | 37 ++++++++++++++++++++-
 hw/display/virtio-gpu-virgl.c  | 59 +++++++++++++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index ec3db3b4123..f69fc194627 100644
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
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 8b71dd6fc26..2b7a41c4664 100644
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
@@ -136,6 +142,24 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
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
 }
 
@@ -172,6 +196,17 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
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
index 1819f9cb7e9..b7a2d160ddd 100644
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
-- 
2.47.3


