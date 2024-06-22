Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEA7C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 21:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL8iA-0007gf-Gx; Sat, 22 Jun 2024 17:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8i8-0007g1-FB
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:52 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sL8i6-0001Ev-Nv
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 17:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1719093349;
 bh=oQ78lWZEXD0E7bvsiUbvhtYOyDzCsfb3Cc+M/iVaecg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bZMqtjAPk3rE0aQcZvAi6f/i+DTzSuVBK7B2a18INZtSixK9IkQaZjZAKnzvMqT4Z
 HEfmH5/7wZEIJw+OQT17Sc0snaoPRDlHaBfhQpb05LXRVxcQdCoU/PinmpGjHWsTjB
 fNS/lTD6fOZs4fN5VwqfpoR5ToWg/WkSjQmI4oxVJkXLT5+2fiiXE/yHYURGDAkXq1
 jVIuOOL9UB+EHbPvIo1fN+rRgIHb8RUCT9KGZQPdG2WhJVs8LmTdyko3WS6HCQ3lmy
 LxqZ62UWBZ1N6AOB4KW+iNlaeVvIL5UzumvcfiQBjk8i09mTdpvLXs5MLgpIRAFuzF
 XXCBMsN0CwrJQ==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id A6CC4378205A;
 Sat, 22 Jun 2024 21:55:47 +0000 (UTC)
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
Subject: [PATCH v15 13/14] virtio-gpu: Register capsets dynamically
Date: Sun, 23 Jun 2024 00:55:10 +0300
Message-ID: <20240622215511.154763-14-dmitry.osipenko@collabora.com>
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

virtio_gpu_virgl_get_num_capsets will return "num_capsets", but we can't
assume that capset_index 1 is always VIRGL2 once we'll support more capsets,
like Venus and DRM capsets. Register capsets dynamically to avoid that problem.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-gl.c     |  6 ++++--
 hw/display/virtio-gpu-virgl.c  | 33 +++++++++++++++++++++------------
 include/hw/virtio/virtio-gpu.h |  4 +++-
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 5f27568d3ec8..20a7c316bb23 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -138,8 +138,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
-    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
-        virtio_gpu_virgl_get_num_capsets(g);
+    g->capset_ids = virtio_gpu_virgl_get_capsets(g);
+    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
 
 #if VIRGL_VERSION_MAJOR >= 1
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
@@ -171,6 +171,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     }
 
     gl->renderer_state = RS_START;
+
+    g_array_unref(g->capset_ids);
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index f6cb4fe5b28e..58693dfa2afa 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -629,19 +629,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
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
@@ -1167,12 +1161,27 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 775005abb337..83232f4b4bfa 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -209,6 +209,8 @@ struct VirtIOGPU {
         QTAILQ_HEAD(, VGPUDMABuf) bufs;
         VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
     } dmabuf;
+
+    GArray *capset_ids;
 };
 
 struct VirtIOGPUClass {
@@ -354,6 +356,6 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
 
 #endif
-- 
2.45.2


