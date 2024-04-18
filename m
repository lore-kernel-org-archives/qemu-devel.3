Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60598C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxX0j-0003v7-0y; Thu, 18 Apr 2024 15:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rxX0b-0003t3-FL
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:01:21 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rxX0Z-0002zd-24
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713466878;
 bh=aZYA/bQW3htg5nfm+UqfKgrjpTYDzPmZLdYEJ2tmekU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U3T7nQcpIE/6fdLQ5e/gbzqZTj9L9EARnkhpeWKMXEwb9NIOUIC/gYWLzO6uqQ4fn
 DwGz6PzANRK1YR1UtrRPbk24DrhgMbWS0A0a7ne+MRyviC0VU5cQ+VLRWc2mlPihO1
 UHsvAk+9RJ8zoAbpQVlrnfKuv5ih+aiBhIKbtnckXYhWGZ9LDjXbu7a59bvCntYplq
 pjyiWlOgF8gfZ2OmYMHd9s9HZc6j5NRKNf/vli/qZ2XOkN6ZZHyZI5pNvLxqs9scsP
 ljioPpqp4dMZH9uPkxUyxq7MCPEqy31TKDSaoR7DABbfTHSbKGf3TeeiptufueokYl
 sQlXqkcAfQP5Q==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 16CB03782137;
 Thu, 18 Apr 2024 19:01:16 +0000 (UTC)
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
Subject: [PATCH v8 10/11] virtio-gpu: Register capsets dynamically
Date: Thu, 18 Apr 2024 22:00:39 +0300
Message-ID: <20240418190040.1110210-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
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

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 37 ++++++++++++++++++++++------------
 include/hw/virtio/virtio-gpu.h |  3 +++
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index eee3816b987f..c0e1ca3ff339 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -558,19 +558,12 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
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
+    if (info.capset_index < g->num_capsets) {
+        resp.capset_id = g->capset_ids[info.capset_index];
         virgl_renderer_get_cap_set(resp.capset_id,
                                    &resp.capset_max_version,
                                    &resp.capset_max_size);
-    } else {
-        resp.capset_max_version = 0;
-        resp.capset_max_size = 0;
     }
     resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
     virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
@@ -1120,12 +1113,30 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     return 0;
 }
 
+static void virtio_gpu_virgl_add_capset(VirtIOGPU *g, uint32_t capset_id)
+{
+    g->capset_ids = g_realloc_n(g->capset_ids, g->num_capsets + 1,
+                                sizeof(*g->capset_ids));
+    g->capset_ids[g->num_capsets++] = capset_id;
+}
+
 int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
 {
     uint32_t capset2_max_ver, capset2_max_size;
+
+    if (g->num_capsets) {
+        return g->num_capsets;
+    }
+
+    /* VIRGL is always supported. */
+    virtio_gpu_virgl_add_capset(g, VIRTIO_GPU_CAPSET_VIRGL);
+
     virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
-                              &capset2_max_ver,
-                              &capset2_max_size);
+                               &capset2_max_ver,
+                               &capset2_max_size);
+    if (capset2_max_ver) {
+        virtio_gpu_virgl_add_capset(g, VIRTIO_GPU_CAPSET_VIRGL2);
+    }
 
-    return capset2_max_ver ? 2 : 1;
+    return g->num_capsets;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index d2a0d542fbb3..3d7d001a85c5 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -218,6 +218,9 @@ struct VirtIOGPU {
         QTAILQ_HEAD(, VGPUDMABuf) bufs;
         VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
     } dmabuf;
+
+    uint32_t *capset_ids;
+    uint32_t num_capsets;
 };
 
 struct VirtIOGPUClass {
-- 
2.44.0


