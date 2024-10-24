Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1104D10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4513-0002oY-QI; Thu, 24 Oct 2024 17:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t4511-0002gV-0N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:05:07 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t450y-0002RC-Vu
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:05:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1729803890; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ly8hbjYqazJiXn+RFwulkiYaIXjuDlMSzl+/VCkTWKVcb9/ELQIB549RSHuavtv6ZWxtCqYO9PLAjFiSMwsfrq/7NNAwwEmtzxmx6V4arfehejpjlsCxbo/8X+dpogiXprdoJa+cDFykwHDwOu6J/ZYGFVPmaA6YwtFaaf3lAd0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1729803890;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D8V4HEUmzsTG0wc2dRYJbBhLBAOcpnXd81Nmke0Ykvo=; 
 b=lWVv8qCnlRKvLs2CVWw2F/b28s8/Hy9j6Bw9I89kL0c967kmI9VuVyU3NFqHMmH29CY1ATe0rHk4+ZB3WXOTBBXsGm3ZwoNZXlhAopz6Kj+DIKb6d6d+3kHOcb5313m1Khezu+4Vo/t+/UmYaj1Vfw5riPONFf7zYpK1V3Q71Qw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729803890; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=D8V4HEUmzsTG0wc2dRYJbBhLBAOcpnXd81Nmke0Ykvo=;
 b=JU3EOBkaCD7erkMvZnWq/fDBckRrZh0MHj2Z3d5IuW6XGzWuy9p7QA68CG1pBkx5
 NlO2zbv5mxdz1CisDFEPMcsKVJk2/ZWLZ8/M0XiAkEmGgyjKbebsahTxFnyvhez3Y8B
 DXNrz1yyAvB7i9OL/jI1FfOceIUJXZLE1Vpt8cIg=
Received: by mx.zohomail.com with SMTPS id 1729803889745633.5168546981427;
 Thu, 24 Oct 2024 14:04:49 -0700 (PDT)
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
Subject: [PATCH v18 12/13] virtio-gpu: Register capsets dynamically
Date: Fri, 25 Oct 2024 00:03:10 +0300
Message-ID: <20241024210311.118220-13-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
References: <20241024210311.118220-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index f2555673a18e..e859c0dff055 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -144,8 +144,8 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     }
 
     g->parent_obj.conf.flags |= (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);
-    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
-        virtio_gpu_virgl_get_num_capsets(g);
+    g->capset_ids = virtio_gpu_virgl_get_capsets(g);
+    VIRTIO_GPU_BASE(g)->virtio_config.num_capsets = g->capset_ids->len;
 
 #if VIRGL_VERSION_MAJOR >= 1
     g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
@@ -177,6 +177,8 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
     }
 
     gl->renderer_state = RS_START;
+
+    g_array_unref(g->capset_ids);
 }
 
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b2f4e215a7ad..5a881c58a11d 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -622,19 +622,13 @@ static void virgl_cmd_get_capset_info(VirtIOGPU *g,
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
@@ -1160,12 +1154,27 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
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
index f9ed81071f1b..07131d8eb9a1 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -207,6 +207,8 @@ struct VirtIOGPU {
         QTAILQ_HEAD(, VGPUDMABuf) bufs;
         VGPUDMABuf *primary[VIRTIO_GPU_MAX_SCANOUTS];
     } dmabuf;
+
+    GArray *capset_ids;
 };
 
 struct VirtIOGPUClass {
@@ -352,6 +354,6 @@ void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
 void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
 void virtio_gpu_virgl_reset(VirtIOGPU *g);
 int virtio_gpu_virgl_init(VirtIOGPU *g);
-int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
+GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
 
 #endif
-- 
2.47.0


