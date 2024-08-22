Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC4CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 18:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shCww-0001P1-Jp; Thu, 22 Aug 2024 14:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwv-0001IW-Dh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:21 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1shCwt-0004Av-Lm
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 14:54:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1724352846; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VuSOF6te56kNY6QE7sLJjZ4Yq2ZQ7aL3dGBCXX2B+obvvAhEPdAEB6OwTckQD2fryJEXNap26IGado6njvUoErh6EDKxy91PB9lp4nbe8sg/0/7IvmXhYWIhChpDaKvQpLjA2zHaNLOdiGXITaMAc4PUZozAlKdEBFvTBwAAdoo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1724352846;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JZ3CE94iMfwKNVDCKKGzXRaXe17mNDp9U+OqlcaMGJk=; 
 b=eNvsXz9m5Ob8uKpKZkw0gF3SU/m+p3w7VC4PSwcTYQtCGi5GrlSh8OYkKOOZPzAj5SOg3DS82+CSdauNn4JjfqfdH6wo8zX1jprjVpqjBFLPMwj9m3JcDXyr71oHHHgtSpHBZkzJkokn9ifOSZ0cZ2Mg430qcpxNnU8468dOg5I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724352846; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=JZ3CE94iMfwKNVDCKKGzXRaXe17mNDp9U+OqlcaMGJk=;
 b=ODjAOvZpi1aavTq00AWjWKb6BY7qlPy3XoEGhlAnxDHRU0OB/Q8dwUd+tx+1jb87
 yjAZJsix30lpnalB2dT8AHc7GlLozEv1RVG+ttCYqM/AUqrF23XzjN20L6/DdJV3PrQ
 GKavu1TY515s89aTzGvYNyDkR6inYfYgkm8Tsr5s=
Received: by mx.zohomail.com with SMTPS id 1724352845487604.7867112313961;
 Thu, 22 Aug 2024 11:54:05 -0700 (PDT)
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
Subject: [PATCH v17 09/13] virtio-gpu: Add virgl resource management
Date: Thu, 22 Aug 2024 21:51:05 +0300
Message-ID: <20240822185110.1757429-10-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Huang Rui <ray.huang@amd.com>

In a preparation to adding host blobs support to virtio-gpu, add virgl
resource management that allows to retrieve resource based on its ID
and virgl resource wrapper on top of simple resource that will be contain
fields specific to virgl.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 76 +++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b3aa444bcfa5..3ffea478e723 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -22,6 +22,23 @@
 
 #include <virglrenderer.h>
 
+struct virtio_gpu_virgl_resource {
+    struct virtio_gpu_simple_resource base;
+};
+
+static struct virtio_gpu_virgl_resource *
+virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
+{
+    struct virtio_gpu_simple_resource *res;
+
+    res = virtio_gpu_find_resource(g, resource_id);
+    if (!res) {
+        return NULL;
+    }
+
+    return container_of(res, struct virtio_gpu_virgl_resource, base);
+}
+
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
 static void *
 virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
@@ -35,11 +52,34 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
 {
     struct virtio_gpu_resource_create_2d c2d;
     struct virgl_renderer_resource_create_args args;
+    struct virtio_gpu_virgl_resource *res;
 
     VIRTIO_GPU_FILL_CMD(c2d);
     trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
                                        c2d.width, c2d.height);
 
+    if (c2d.resource_id == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = virtio_gpu_virgl_find_resource(g, c2d.resource_id);
+    if (res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
+                      __func__, c2d.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.width = c2d.width;
+    res->base.height = c2d.height;
+    res->base.format = c2d.format;
+    res->base.resource_id = c2d.resource_id;
+    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
+
     args.handle = c2d.resource_id;
     args.target = 2;
     args.format = c2d.format;
@@ -59,11 +99,34 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
 {
     struct virtio_gpu_resource_create_3d c3d;
     struct virgl_renderer_resource_create_args args;
+    struct virtio_gpu_virgl_resource *res;
 
     VIRTIO_GPU_FILL_CMD(c3d);
     trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
                                        c3d.width, c3d.height, c3d.depth);
 
+    if (c3d.resource_id == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = virtio_gpu_virgl_find_resource(g, c3d.resource_id);
+    if (res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
+                      __func__, c3d.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.width = c3d.width;
+    res->base.height = c3d.height;
+    res->base.format = c3d.format;
+    res->base.resource_id = c3d.resource_id;
+    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
+
     args.handle = c3d.resource_id;
     args.target = c3d.target;
     args.format = c3d.format;
@@ -82,12 +145,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
                                      struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_resource_unref unref;
+    struct virtio_gpu_virgl_resource *res;
     struct iovec *res_iovs = NULL;
     int num_iovs = 0;
 
     VIRTIO_GPU_FILL_CMD(unref);
     trace_virtio_gpu_cmd_res_unref(unref.resource_id);
 
+    res = virtio_gpu_virgl_find_resource(g, unref.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, unref.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
     virgl_renderer_resource_detach_iov(unref.resource_id,
                                        &res_iovs,
                                        &num_iovs);
@@ -95,6 +167,10 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
         virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
     }
     virgl_renderer_resource_unref(unref.resource_id);
+
+    QTAILQ_REMOVE(&g->reslist, &res->base, next);
+
+    g_free(res);
 }
 
 static void virgl_cmd_context_create(VirtIOGPU *g,
-- 
2.45.2


