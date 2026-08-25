Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26E8C61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoLQ-0002y7-4E; Tue, 25 Aug 2026 06:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoLO-0002sa-6U
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoLM-0006Wk-76
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwVqFklkTq51UFas2WYSPaXcHAFfeT0z9bfzAzXafOE=;
 b=eRcSq/6ObMM+r/UivZPQtlTDbQc6yK6pkGOauaZDQebYe7QCuEj8KBJcPFXEe7hJMOBl+s
 mwcGuKK9Zn0qERsM+0PvuUubJeAraYL/9MYqiE4tqrkq2RkQRQK8MnYCFnOnanfbizaTXO
 iTPl0eaNNDzjc9siGASMBpGdNO6JkTY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-sQEeRhHANC2igCYV-GKRtw-1; Tue,
 25 Aug 2026 06:25:21 -0400
X-MC-Unique: sQEeRhHANC2igCYV-GKRtw-1
X-Mimecast-MFC-AGG-ID: sQEeRhHANC2igCYV-GKRtw_1787653520
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 565911921EC5; Tue, 25 Aug 2026 10:25:20 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C72BB18005B6; Tue, 25 Aug 2026 10:25:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:54 +0400
Subject: [PATCH 17/18] virtio-gpu: initialize dmabuf_fd to -1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-17-d3bb612b9975@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4993;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=88hblmgOwlmVboP78rda7W48EMecEATnLDYPHwuMxY4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyZ/gQTVWF2BXVDicar+COhg8xIFIoxsaM7z
 YVFAHElFeaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smQAKCRDa6OEJdZac
 5d7eEACxlSrLNTafv4+FYVrX8RLjKd4ctIjhmzYOXk1SHKHy3ByQOqcHwMkH0dKn0lkJdiETD+x
 SzIdJ6V5Nin6Hg/o64ikOGYhhSX8g3wOC8YU0et2dW1/ewoB+G+4MVWD3XnGLKfgK+FAULPNAtE
 3svRYGemZerifAP/f2Jt78M2oM4gKAN5myELIW5zr22zHOsNOgXylSU+MU9VI+HwE0DzDME4cIL
 tBx+tfGfn1qwQ16KQNMiHkH2PINp+9utoPCQrJBsWLQ9TtImYIAB66gnuP6TZCzEamULzFljXYJ
 PNVO9Wg5MU33gsWVp63K8lHajJXvnPNPkz77g+GiPnCq3Gc6Era46HwcS2z0R/ah9amEl65d1HP
 E63UzcOZhfQ4r/5dOEJISnNNJwGquUfAPLh6FtLtCKk3B99Gabi3RI5orphxsXR5Js4ZWz27iCB
 hCGOYL/ZyPwjb4LsKFuV9n4ehvDmewiKIYhM3jWvoVWeSS/QMCCedXz/kaNEF4710LU+J828bRj
 hf+0j0kX32o2DPax0fhcVO6KJySgU26S+2HSIb9qztIelyBXYRcZhgHaOW5aToa4GglTx9TcUh9
 ZCCb2N5SIyr34IeGL6MpRPoy6XHAUYrNuqxMwJtr6fJbUf+9Z4olhBnfYeCwovLM5CRNazgp9ux
 T9jSpHHp92iYSfg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

FD fields should be initialized to a non-fd value to avoid confusion and
potential invalid closes. The following patch will change the guard to
finish/close dmabuf and rely on fd being initialized instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 4 +++-
 hw/display/virtio-gpu-udmabuf.c  | 3 ++-
 hw/display/virtio-gpu-virgl.c    | 6 +++---
 hw/display/virtio-gpu.c          | 5 ++++-
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 5344a5f9e26a..ae158de480f5 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -101,6 +101,7 @@ rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
     CHECK(!result, cmd);
 
     res = g_new0(struct virtio_gpu_simple_resource, 1);
+    res->dmabuf_fd = -1;
     res->width = c2d.width;
     res->height = c2d.height;
     res->format = c2d.format;
@@ -140,6 +141,7 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
     CHECK(!result, cmd);
 
     res = g_new0(struct virtio_gpu_simple_resource, 1);
+    res->dmabuf_fd = -1;
     res->width = c3d.width;
     res->height = c3d.height;
     res->format = c3d.format;
@@ -637,7 +639,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
     CHECK(cblob.resource_id != 0, cmd);
 
     res = g_new0(struct virtio_gpu_simple_resource, 1);
-
+    res->dmabuf_fd = -1;
     res->resource_id = cblob.resource_id;
     res->blob_size = cblob.size;
 
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 094646af8636..4e9806f82144 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -132,7 +132,8 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     void *pdata = NULL;
 
-    res->dmabuf_fd = -1;
+    assert(res->dmabuf_fd == -1);
+
     if (res->iov_cnt == 1 &&
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8b27fe3980d6..291373274dee 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -336,11 +336,11 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
     }
 
     res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.dmabuf_fd = -1;
     res->base.width = c2d.width;
     res->base.height = c2d.height;
     res->base.format = c2d.format;
     res->base.resource_id = c2d.resource_id;
-    res->base.dmabuf_fd = -1;
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c2d.resource_id;
@@ -384,11 +384,11 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
     }
 
     res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.dmabuf_fd = -1;
     res->base.width = c3d.width;
     res->base.height = c3d.height;
     res->base.format = c3d.format;
     res->base.resource_id = c3d.resource_id;
-    res->base.dmabuf_fd = -1;
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c3d.resource_id;
@@ -862,9 +862,9 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
     }
 
     res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.dmabuf_fd = -1;
     res->base.resource_id = cblob.resource_id;
     res->base.blob_size = cblob.size;
-    res->base.dmabuf_fd = -1;
 
     if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index a7f549a6a8b9..521d4800d872 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -274,7 +274,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
     }
 
     res = g_new0(struct virtio_gpu_simple_resource, 1);
-
+    res->dmabuf_fd = -1;
     res->width = c2d.width;
     res->height = c2d.height;
     res->format = c2d.format;
@@ -360,6 +360,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     }
 
     res = g_new0(struct virtio_gpu_simple_resource, 1);
+    res->dmabuf_fd = -1;
     res->resource_id = cblob.resource_id;
     res->blob_size = cblob.size;
 
@@ -1407,6 +1408,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         }
 
         res = g_new0(struct virtio_gpu_simple_resource, 1);
+        res->dmabuf_fd = -1;
         res->resource_id = resource_id;
         res->width = qemu_get_be32(f);
         res->height = qemu_get_be32(f);
@@ -1518,6 +1520,7 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
         }
 
         res = g_new0(struct virtio_gpu_simple_resource, 1);
+        res->dmabuf_fd = -1;
         res->resource_id = resource_id;
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);

-- 
2.55.0.543.g5ebe2ebe4ea8


