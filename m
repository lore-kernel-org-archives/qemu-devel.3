Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEDDC41513
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5rPg-0000Lv-67; Sat, 11 May 2024 14:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPe-0000Lk-De
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:38 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s5rPc-00050b-Q2
 for qemu-devel@nongnu.org; Sat, 11 May 2024 14:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715451935;
 bh=YMRHWgYwti+Jv3PdR+me58u5JXO1u8jgHFgCBurO6u0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mX6ErTr5F7EUxNL27uRqpm9ieLPk+hfAVMX+X485FV9XPdpTQkk+WJ5OUiR1TZvsv
 i6CEUiOH4T2B093P8IRADqjNy5g17IkV3rdI/Lj/jYff2MgSZuaCC+Z2lf+En05/P7
 2EqKusNZVR9HHkqFUFS6HiJ6YnLZTbZ9+Rim7wW4YzcWcwLsc745hQ9bcZUdmWIFFa
 ighmGtbxvykyPRVSj1dhPgg+VHsswAq3L8nJDBn98a487N47avfU3UnYanBXBljK/B
 cGiWJBL8uJgAq/DiRNuulbwZ22X+x5gcDSIdwgPKrwDWU1Nps6Lo/Bq0K/jwWgNq3o
 kDQDhFAD4Xbqw==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 35E863780BFE;
 Sat, 11 May 2024 18:25:33 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
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
Subject: [PATCH v11 09/10] virtio-gpu: Register capsets dynamically
Date: Sat, 11 May 2024 21:22:50 +0300
Message-ID: <20240511182251.1442078-10-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
like Venus and DRM capsets. Register capsets dynamically to avoid that problem.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |  6 ++++--
 hw/display/virtio-gpu-virgl.c  | 33 +++++++++++++++++++++------------
 include/hw/virtio/virtio-gpu.h |  4 +++-
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 95806999189e..431fc2881a00 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -124,8 +124,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
-    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
-        virtio_gpu_virgl_get_num_capsets(g);
+    g->capset_ids = virtio_gpu_virgl_get_capsets(g);
+    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
 
 #ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
@@ -148,6 +148,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     if (gl->renderer_inited) {
         virtio_gpu_virgl_deinit(g);
     }
+
+    g_array_unref(g->capset_ids);
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 3f2e406be3a4..135974431492 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -590,19 +590,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
     VIRTIO_GPU_FILL_CMD(info);
 
     memset(&resp, 0, sizeof(resp));
-    if (info.capset_index == 0) {
-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL;
-        virgl_renderer_get_cap_set(resp.capset_id,
-                                   &resp.capset_max_version,
-                                   &resp.capset_max_size);
-    } else if (info.capset_index == 1) {
-        resp.capset_id = VIRTIO_GPU_CAPSET_VIRGL2;
+
+    if (info.capset_index < g->capset_ids->len) {
+        resp.capset_id = g_array_index(g->capset_ids, uint32_t,
+                                       info.capset_index);
         virgl_renderer_get_cap_set(resp.capset_id,
                                    &resp.capset_max_version,
                                    &resp.capset_max_size);
-    } else {
-        resp.capset_max_version = 0;
-        resp.capset_max_size = 0;
     }
     resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
     virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
@@ -1123,14 +1117,29 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     return 0;
 }
 
-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
+static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t capset_id)
+{
+    g_array_append_val(capset_ids, capset_id);
+}
+
+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
 {
     uint32_t capset2_max_ver, capset2_max_size;
+    GArray *capset_ids;
+
+    capset_ids = g_array_new(false, false, sizeof(uint32_t));
+
+    /* VIRGL is always supported. */
+    virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
+
     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
                               &capset2_max_ver,
                               &capset2_max_size);
+    if (capset2_max_ver) {
+        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
+    }
 
-    return capset2_max_ver ? 2 : 1;
+    return capset_ids;
 }
 
 void virtio_gpu_virgl_deinit(VirtIOGPU *g)
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index c0b0b0eac08b..7bbc6ef268eb 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -212,6 +212,8 @@ struct VirtIOGPU {
     } dmabuf;
 
     QEMUBH *cmdq_resume_bh;
+
+    GArray *capset_ids;
 };
 
 struct VirtIOGPUClass {
@@ -346,6 +348,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 void virtio_gpu_virgl_deinit(VirtIOGPU *g);
-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
 
 #endif
-- 
2.44.0


