Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186EEC27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 21:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL8iC-0007hA-2T; Sat, 22 Jun 2024 17:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8iA-0007gg-I9
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:54 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8i8-0001FC-Tz
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1719093351;
 bh=dhn1QGTnheY2trxKHo7eMKwl/XR1sz3KUehlQ+d3xDc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pr/6hKf41SnHZkqh3suKMtuNDtb0VbdUGhaxlX/99WgyAwsGIecqVj7i3eOAML07r
 SdTd2hEoudtEmvHCjGZjTNBywKHoOJGjmm3er/7aabS/y19gJskcmp5lZZL8mcT7nT
 EF4m7Rff+UlDu7Q456S9ZH1l1hlRdZ5CH9d+tr2jTBGBRqqRpqVLWPxgMKupQXQC5U
 9zKHX/9+2+A7iinTRfAdHCozQ+gVxtWRvez++6dcrJkig2yFXEjcciFtFcNXIko/O8
 lVGs0/Sh08q9pV1ehFUSHt8B9iEKWTUeEGtkyDLHHbrA0WjXxvNlxYYwNfjePLdY5F
 5Ge+mAk/aoA0A==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E385D3782113;
 Sat, 22 Jun 2024 21:55:49 +0000 (UTC)
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
Subject: [PATCH v15 14/14] virtio-gpu: Support Venus context
Date: Sun, 23 Jun 2024 00:55:11 +0300
Message-ID: <20240622215511.154763-15-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
References: <20240622215511.154763-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
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

Request Venus when initializing VirGL and if venus=true flag is set for
virtio-gpu-gl device.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |  2 ++
 hw/display/virtio-gpu-virgl.c  | 22 ++++++++++++++++++----
 hw/display/virtio-gpu.c        | 15 +++++++++++++++
 include/hw/virtio/virtio-gpu.h |  3 +++
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 20a7c316bb23..9be452547322 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -151,6 +151,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
 static Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_BIT("stats", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
+    DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
+                    VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 58693dfa2afa..08b0e7e49337 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1135,6 +1135,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
     }
 #endif
+#if VIRGL_VERSION_MAJOR >= 1
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
+    }
+#endif
 
     ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
@@ -1168,7 +1173,7 @@ static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
 
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 {
-    uint32_t capset2_max_ver, capset2_max_size;
+    uint32_t capset_max_ver, capset_max_size;
     GArray *capset_ids;
 
     capset_ids = g_array_new(false, false, sizeof(uint32_t));
@@ -1177,11 +1182,20 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
     virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
 
     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
-                              &capset2_max_ver,
-                              &capset2_max_size);
-    if (capset2_max_ver) {
+                               &capset_max_ver,
+                               &capset_max_size);
+    if (capset_max_ver) {
         virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
     }
 
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VENUS,
+                                   &capset_max_ver,
+                                   &capset_max_size);
+        if (capset_max_size) {
+            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VENUS);
+        }
+    }
+
     return capset_ids;
 }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index a5db2256a4bb..50b5634af13f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1507,6 +1507,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 #endif
     }
 
+    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
+#ifdef VIRGL_VERSION_MAJOR
+    #if VIRGL_VERSION_MAJOR >= 1
+        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
+            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
+            error_setg(errp, "venus requires enabled blob and hostmem options");
+            return;
+        }
+    #else
+        error_setg(errp, "old virglrenderer, venus unsupported");
+        return;
+    #endif
+#endif
+    }
+
     if (!virtio_gpu_base_device_realize(qdev,
                                         virtio_gpu_handle_ctrl_cb,
                                         virtio_gpu_handle_cursor_cb,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 83232f4b4bfa..230fa0c4ee0a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -99,6 +99,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
     VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
+    VIRTIO_GPU_FLAG_VENUS_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -117,6 +118,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
 #define virtio_gpu_hostmem_enabled(_cfg) \
     (_cfg.hostmem > 0)
+#define virtio_gpu_venus_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.45.2


