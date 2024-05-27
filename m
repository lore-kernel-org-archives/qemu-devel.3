Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D54BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQe8-0005KW-2G; Sun, 26 May 2024 23:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdz-0005Ie-NI
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:27 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdx-0002MF-K8
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716779004;
 bh=BrPXfBLT4OK9hIVMJYTAuXzdMXeBIR++LJJ0eCKUIvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s5Mo7jDF+qB5BVgorYEyXaK+owBm7EmdtoeyI5WWTto50mmdrzohck2EcxqEE1dCi
 ZGDaAHmsS+DJgQ4KW3MDpWtLTJBpV8ubjxRq6PAkNVetCCoZuIGRBNRkxI6Lg0O5Tw
 LYwNQ0qzET9qRdyb8Xb0wYvGPjCkaAThQwGRMHnab8bscy0+gdu6dm9JCVy7F240mI
 clO01o6Z1zxuM7v1RiS8h/ke+NJzjt5/ME7u/F2zPwvWFuA3QUb5kYiq2avjw2Pu1d
 QPCyAR2IemcgqLJT0H0aobas2H4Nj872LWxBlm2UYCpVQSYxYW23JBrmGFJPPX1xKQ
 G7jHwur3VBEcQ==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id C9CD6378212E;
 Mon, 27 May 2024 03:03:22 +0000 (UTC)
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
Subject: [PATCH v13 12/13] virtio-gpu: Register capsets dynamically
Date: Mon, 27 May 2024 06:02:32 +0300
Message-ID: <20240527030233.3775514-13-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
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
index 9822d79c5e81..34a2bd2fa426 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -137,8 +137,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
-    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
-        virtio_gpu_virgl_get_num_capsets(g);
+    g->capset_ids = virtio_gpu_virgl_get_capsets(g);
+    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
 
 #ifdef HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
@@ -163,6 +163,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     }
 
     gl->renderer_state = RS_START;
+
+    g_array_unref(g->capset_ids);
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0c73d9ba65f9..d3ae3e3d4e24 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -636,19 +636,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
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
@@ -1171,14 +1165,29 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
index 368f96a813c9..b9de761fd673 100644
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
@@ -355,6 +357,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
 void virtio_gpu_virgl_deinit(VirtIOGPU *g);
-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
 
 #endif
-- 
2.44.0


