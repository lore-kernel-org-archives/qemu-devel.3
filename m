Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2169FCC062
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDJ-0005XF-BS; Fri, 06 Mar 2026 14:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCX-0004Eq-3U
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:09 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCV-0000Sr-4L
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:08 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so1468475e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826663; x=1773431463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uK3c2N7J7e+anI448dkPp4SW/OHMVl4XpP6gl2e8CWo=;
 b=Ol0tgEfCA8Zh9TJeWy+FcoilebqDo1wnFrq5a3kLwcnOUIRLzl62cQvIkhgnqE1s2a
 THbhsly3zd5ICrpoMbIOOjHt+JrzxMY9vuuPfn2aXNViWRpCJAV7/gy1hobZrmKFvlgC
 x1Px3vspLG/RRjqJ+TthwwGnzYUVyd1hx8CjYwSiYmK8rovwQy4HgU7fnLa1bhFejUxO
 eyQHUERKX4YuAphF1tJH6fVcp+Ew58xGMtRrYZ1BKS00KP0lzaqmOwnTeM1MWtPXKzWR
 GxTEX5l0OIcEVfLWwssWz4AQvEZY2LSAyF5WlhyuXu8p5WBAcHKY7NBjx6t0rWMmDJeg
 k/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826663; x=1773431463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uK3c2N7J7e+anI448dkPp4SW/OHMVl4XpP6gl2e8CWo=;
 b=TlKoj0RdWC0eA8nAwPz0A6e8c6GYpj3DMj5PXOBG/T25bD9KbXjeIBsjjw1L9C+WWC
 hh/XsJNqp4JRAl8W3kEVyzTMdDvN5lkwvU+ECZblFwRejIEk857Z3HdAa2bNH7gyuwhF
 dlCoaIWgFCOviP6/JWIIfa1DZXOoT0/nEgsKuGqDUXj6Cwnk0Suh4yq7h47fQXZu9cqX
 EBgxiMXSh2WIi2pcMipXzcX2hlDUtnQ4wSIMquTtxtG6VZiDXWLa++Bz6fg8eTdYyUmd
 CDQV4gTCpH3Fhc8bCXhV4ToeBvp3EBnUyGsdtCVioeaHvS/ltT32TlS95AAYp9cDSC91
 5t8Q==
X-Gm-Message-State: AOJu0YzeFSrnreUn4J+IiqD8qVv2kp1bnpxXex/vJRfBIlanGtkT+Y98
 F9XSm7nAwFHp68AO4VVn+w+zq54JSTBNFI8aewZK1M63mwpVL/pFM1ZrV6fm6aRwcxE=
X-Gm-Gg: ATEYQzzqHnF3OE7hNep/18aUD+xZuXMai22qsgiz+uQNz+bghLrk0bbbEnrlOGrFOWl
 62VOTkYvtypWQuPk13hI4+MAVriHYnO+RqXxcA710lQO/bhnB/7eli7E4VgZRtzCIx2GuiyfaI6
 peR+Vw3Q5f1guJjyg490S7EMij1OcAQc5G9+fPfQnNrIYArU+WP6SBvOC4APyH2pvQv9rtF9jEb
 SNuT/Kv4KvLDuFzbLIZWvtmYsY31Ho0xAYqeWxrz04exI+ZI7tgOMq7+xLikn2A+UYQC6l8k71S
 eC5BFBgAoy4LVYw0jFLwdp0zlp8Y360LXDdLO6Lbhu3siobP9gPwb4ilFN86bBba0IOLlKU+Ezj
 Dj6xAbMMe2mcopZd/dwfnM204G7rmeQx6E+wdCiR1FJKtA9qLboVeorH8W+7Eg4rG7htKE9a8v2
 RmcAkphQDQ4vv3WdlWt4SBnsc=
X-Received: by 2002:a05:600c:444f:b0:480:4b59:932e with SMTP id
 5b1f17b1804b1-4852692498emr50821475e9.11.1772826662764; 
 Fri, 06 Mar 2026 11:51:02 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852767d8e4sm53256055e9.2.2026.03.06.11.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:51:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E5639689E2;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 20/20] virtio-gpu: Support mapping hostmem blobs with map_fixed
Date: Fri,  6 Mar 2026 19:50:47 +0000
Message-ID: <20260306195048.2869788-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Message-ID: <20260304165043.1437519-21-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


