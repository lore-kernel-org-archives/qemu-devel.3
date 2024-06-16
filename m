Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B157C27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 01:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIeKL-0005PH-DV; Sat, 15 Jun 2024 21:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIeKJ-0005Op-T5
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 21:04:59 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sIeKI-00033x-8u
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 21:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1718499897;
 bh=Z6MjLbiKooZYqlLdMDZ0uN10TxmA9WpuEPuquaL7vQw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OokfGiTyOhChuCiD7y6c32FjS18Qdx5I/ytGCqey3EHElHri/YB7VZp1kTE5VEcB6
 C4qm8EfrayJZcPMwbvbFbbkTc4uTJT5jDuHE+T74Z8aHp4sL4qc5wVtzpS8uq43Lxl
 SNxh344UU+Tcn/mQHi7UGe/U1yUSoOPvfse4dm+ntaMKATtycP3oG53JB0epmmPDcB
 1r7tOWxQkF5dlyTZiYVgMnxz2ueiRqfIRvwU7Cm1zhAEzgCcWwIWObeMoyMmtV7Iqn
 5WoDPIhxfWAhJgzgynBBlHwrmk3acCiG6eY95a73JoCO3Uzt8oPuiFvPRDyiHXsBIZ
 fpIYD6oelOLCQ==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4BCDC3782163;
 Sun, 16 Jun 2024 01:04:55 +0000 (UTC)
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
Subject: [PATCH v14 14/14] virtio-gpu: Support Venus context
Date: Sun, 16 Jun 2024 04:03:57 +0300
Message-ID: <20240616010357.2874662-15-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
References: <20240616010357.2874662-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 8f3920800517..ec923cf36ef7 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1132,6 +1132,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
@@ -1165,7 +1170,7 @@ static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
 
 GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 {
-    uint32_t capset2_max_ver, capset2_max_size;
+    uint32_t capset_max_ver, capset_max_size;
     GArray *capset_ids;
 
     capset_ids = g_array_new(false, false, sizeof(uint32_t));
@@ -1174,11 +1179,20 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
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
2.44.0


