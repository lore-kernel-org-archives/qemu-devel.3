Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C91CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI8bT-0001SO-VQ; Sun, 09 Nov 2025 11:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8bS-0001S8-UY
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:23 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8bQ-00008Z-V5
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762706947; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MtLLJT2tGNmVT1CXKMAK4Nqn5GaihncDbSgUuDYZI3pdF/1O4A0aztVMMT/N00ZHjfKgaYPeCCWtbKoqrJrdWfdQhcwlAJd8hDyoEVYXVwXoshWOrCEaqRAGZ7D+ZYdsX/avL/2yTbg7ELAY93NjTK40RBTLB2ZSq//kI9n0O30=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762706947;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gwEKPGdjvrhpbEyNWHcFyhwt4X2SWfAOljvC/xMTnUs=; 
 b=f1PHYq3cmteV1GPYF3NCR52tB9OLF6DfChUxc8khhaYPgMd0DixLcU+flx92pJQrF6qCWWYERgA/9JSg9oBaaB9yIdGDBawQhuj+7eyOqqg7SWInMaIL9BC+CSfhWSgtVfOLNKZKVZAoYX07UScM8LvtfFAbHUs3M4QSMT3Moe4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762706946; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=gwEKPGdjvrhpbEyNWHcFyhwt4X2SWfAOljvC/xMTnUs=;
 b=AbXqSfhbWOQLSLV5j32PvelliVhTtgVpA6BCNu0aHxjplR1BSvX+7kZmOUI3S9wt
 P7PVmB2x/AnPXASRLwQ/TroSDNc8kRKEI+e1kw4AficnbfaQgMPaInPvkwmdnwYDV4+
 +z7Hr3LQrusQZjx65aqZY1Lnd0KusJRDYbJa4wso=
Received: by mx.zohomail.com with SMTPS id 1762706945101903.548906605195;
 Sun, 9 Nov 2025 08:49:05 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v15 05/10] virtio-gpu: Support DRM native context
Date: Sun,  9 Nov 2025 19:47:06 +0300
Message-ID: <20251109164711.686873-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109164711.686873-1-dmitry.osipenko@collabora.com>
References: <20251109164711.686873-1-dmitry.osipenko@collabora.com>
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

Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
using a new virtio-gpu-gl device option "drm_native_context=on".

Unlike Virgl and Venus contexts that operate on application API level,
DRM native contexts work on a kernel UAPI level. This lower level results
in a lightweight context implementations that yield better performance.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio/virtio-gpu.rst | 11 +++++++++
 hw/display/virtio-gpu-gl.c                |  2 ++
 hw/display/virtio-gpu-virgl.c             | 28 +++++++++++++++++++++++
 hw/display/virtio-gpu.c                   | 15 ++++++++++++
 include/hw/virtio/virtio-gpu.h            |  3 +++
 5 files changed, 59 insertions(+)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 0f4bb304a9b8..086e2fcf27b9 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -84,6 +84,17 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 
 .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
 
+DRM native context is supported since release of `virglrenderer`_ v1.0.0
+using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") requires
+host blob support (``hostmem`` and ``blob`` fields) and should be enabled
+using ``drm_native_context`` field.  The ``hostmem`` field specifies the size
+of virtio-gpu host memory window. This is typically between 256M and 8G.
+
+.. parsed-literal::
+    -device virtio-gpu-gl,hostmem=8G,blob=on,drm_native_context=on
+
+.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/src/drm
+
 virtio-gpu rutabaga
 -------------------
 
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 1468c6ed1467..b640900fc6f1 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -159,6 +159,8 @@ static const Property virtio_gpu_gl_properties[] = {
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
+    DEFINE_PROP_BIT("drm_native_context", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
 };
 
 static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 09e41ff6aad5..5c9a9ee84392 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1302,6 +1302,25 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
         flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
     }
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+        flags |= VIRGL_RENDERER_DRM;
+
+        if (!(flags & VIRGL_RENDERER_ASYNC_FENCE_CB)) {
+            /*
+             * Virglrenderer skips enabling DRM context support without
+             * enabled async-fence feature. VirtIO-GPU will initialize
+             * successfully, but DRM context won't be available in guest.
+             *
+             * For vrend async-fencing can be enabled only if EGL display
+             * is used. Vrend can't be disabled in QEMU, hence DRM implicitly
+             * requires EGL too.
+             *
+             * Async-fence was bugged in virglrenderer versions <= 1.1.1.
+             */
+            error_report("drm requires egl display and virglrenderer >= 1.2.0");
+            return -EINVAL;
+        }
+    }
 #endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
@@ -1365,5 +1384,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
         }
     }
 
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_DRM,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_DRM);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43e88a4daffd..672e81d3671e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1517,6 +1517,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
+#ifdef VIRGL_VERSION_MAJOR
+    #if VIRGL_VERSION_MAJOR >= 1
+        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
+            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+            error_setg(errp, "drm requires enabled blob and hostmem options");
+            return;
+        }
+    #else
+        error_setg(errp, "old virglrenderer, drm unsupported");
+        return;
+    #endif
+#endif
+    }
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index a0be704bb0ef..172f5ffce3ed 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -100,6 +100,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
     VIRTIO_GPU_FLAG_VENUS_ENABLED,
     VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
+    VIRTIO_GPU_FLAG_DRM_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -122,6 +123,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.hostmem > 0)
 #define virtio_gpu_venus_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
+#define virtio_gpu_drm_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.51.1


