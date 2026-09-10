Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32657C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zz1-0003HA-1Z; Thu, 10 Sep 2026 04:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zyz-0003Gx-7W
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zyx-0004se-Ci
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ngT2cCLD1QZ+H2eW9Nvud+V6k97Yyz3vx5HyUPP+dw=;
 b=jGXkrNT6Y+l/mFFm/jNlYIMiZjVsXN3TiZ7WdzSl0P+3QJTkJCg8wpM9fVDh8EcnX4XyKW
 87wS3TVANWtH0tL/KWgYyhd+8Cz1lnw3oxcB+hDsm73inusH3ozAM7y/2zkceRoecspgf9
 evCiKsOW+mNwIKrweFRdbGrADFnz5lg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-RuADn1BYMJOmoVdDPR5SUQ-1; Thu,
 10 Sep 2026 04:18:02 -0400
X-MC-Unique: RuADn1BYMJOmoVdDPR5SUQ-1
X-Mimecast-MFC-AGG-ID: RuADn1BYMJOmoVdDPR5SUQ_1789028281
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC3A71954213; Thu, 10 Sep 2026 08:18:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B33B51800351; Thu, 10 Sep 2026 08:18:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:31 +0400
Subject: [PATCH v4 03/24] hw/display/virtio-gpu: introduce
 virtio_gpu_{simple,virgl}_resource_new()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-3-7d623714bd71@redhat.com>
References: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10567;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=w3w7Q50Jg6Ng9Xo0v3C94n/99pxWsT7TSnCepItsbx4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeobk4/6RYOmltxNjFIUNvX5wK02NtXBEkbo
 DqFs5ks97OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5b/bEACkqCfpDdAZpCq3uGunjvx8pnxqym/7VOqfRhP5jO9wfv96qu83Yf9y3rYvaXVFOIBCkOY
 p9XFNQwKZB7qjpczYnt8VciK4XEcxRwhnXoVJzfzQtl4IJB1Fpap2ZqJ4f5ubQbeiTtjeYEN4DN
 YzcQ+ec+/hCQgCYdTa9nUcCFpaRzrCXfnNGSPsmJcGHJZypO1vIsZMufaBY45NurfNPg3+4LNck
 lswDij4eewkCIC3XQtQ3qz9OMJE/jsXuQtrVFUVb0aVrwsBsJ7HkN4MNALneSy3cB0Jb8WPCEjY
 1fS9TmYsLEgzNjyeVYGsBFQc8udSDnoQ3zUNacQ0Nbh+P9jIqSZL3hvKfF6PGWZQPg3EYfiSOd2
 U+O+/nCBOFZfrH6qlb8cvDSMYcRt3D9OCsmJswgNIATc9KMKk8aXaHbIbOphSVXPXJ+PQatcj4C
 NQDbct/ZpclnDEgmfuA/HXjaFstbJLqZtBUYdyttH8FZqunUJYsmRZvKkfgAJoAXpWQqjk1wmzJ
 Z3QVkPSVlrXvl5EiM3y9UvhjvaO8cVQNcyt7KeUm+6ZEl3TGIjS9x6J17tgb/BEeTHaOcLH5rEG
 WToSQTlZwYA57ab3Sm+5Z4f2mAWWXeXZSXiDD30egzE9YjdbXpldbYjo8PSx2hJRKsWswmU21dV
 wNzSDo5JErdVeZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

All allocation sites used g_new0() which zero-initializes fields.
However share_handle must be SHAREABLE_NONE (-1 on Unix, NULL on
Windows) and dmabuf_fd must be -1, not 0. Centralize allocation and
field initialization in new constructors fix this and reduce code
duplication.

This fixes -display dbus with virtio-gpu blob resources. The other
end is currently receiving qemu fd 0.

Fixes: 5f899c34af1d (“virtio-gpu: allocate shareable 2d resources on !win32”)
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 21 +++----------
 hw/display/virtio-gpu-virgl.c    | 48 +++++++++++++++++++----------
 hw/display/virtio-gpu.c          | 66 +++++++++++++++++++++++++++++-----------
 include/hw/virtio/virtio-gpu.h   | 11 +++++++
 4 files changed, 97 insertions(+), 49 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 041216a10d04..b8f8a2068d0b 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -100,12 +100,8 @@ rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
     result = rutabaga_resource_create_3d(vr->rutabaga, c2d.resource_id, &rc_3d);
     CHECK(!result, cmd);
 
-    res = g_new0(struct virtio_gpu_simple_resource, 1);
-    res->width = c2d.width;
-    res->height = c2d.height;
-    res->format = c2d.format;
-    res->resource_id = c2d.resource_id;
-
+    res = virtio_gpu_simple_resource_new(c2d.resource_id, c2d.width,
+                                         c2d.height, c2d.format);
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
@@ -139,12 +135,8 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
     result = rutabaga_resource_create_3d(vr->rutabaga, c3d.resource_id, &rc_3d);
     CHECK(!result, cmd);
 
-    res = g_new0(struct virtio_gpu_simple_resource, 1);
-    res->width = c3d.width;
-    res->height = c3d.height;
-    res->format = c3d.format;
-    res->resource_id = c3d.resource_id;
-
+    res = virtio_gpu_simple_resource_new(c3d.resource_id, c3d.width,
+                                         c3d.height, c3d.format);
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
@@ -634,10 +626,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
 
     CHECK(cblob.resource_id != 0, cmd);
 
-    res = g_new0(struct virtio_gpu_simple_resource, 1);
-
-    res->resource_id = cblob.resource_id;
-    res->blob_size = cblob.size;
+    res = virtio_gpu_simple_resource_new_blob(cblob.resource_id, cblob.size);
 
     if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
         result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9bda572426b2..742d9dde4a32 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -309,6 +309,33 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
 }
 #endif
 
+static struct virtio_gpu_virgl_resource *
+virtio_gpu_virgl_resource_new(uint32_t resource_id, uint32_t width,
+                              uint32_t height, uint32_t format)
+{
+    struct virtio_gpu_virgl_resource *res;
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    virtio_gpu_simple_resource_init(&res->base, resource_id);
+    res->base.width = width;
+    res->base.height = height;
+    res->base.format = format;
+
+    return res;
+}
+
+static struct virtio_gpu_virgl_resource *
+virtio_gpu_virgl_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
+{
+    struct virtio_gpu_virgl_resource *res;
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    virtio_gpu_simple_resource_init(&res->base, resource_id);
+    res->base.blob_size = blob_size;
+
+    return res;
+}
+
 static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
                                          struct virtio_gpu_ctrl_command *cmd)
 {
@@ -335,12 +362,8 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
         return;
     }
 
-    res = g_new0(struct virtio_gpu_virgl_resource, 1);
-    res->base.width = c2d.width;
-    res->base.height = c2d.height;
-    res->base.format = c2d.format;
-    res->base.resource_id = c2d.resource_id;
-    res->base.dmabuf_fd = -1;
+    res = virtio_gpu_virgl_resource_new(c2d.resource_id, c2d.width,
+                                        c2d.height, c2d.format);
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c2d.resource_id;
@@ -383,12 +406,8 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
         return;
     }
 
-    res = g_new0(struct virtio_gpu_virgl_resource, 1);
-    res->base.width = c3d.width;
-    res->base.height = c3d.height;
-    res->base.format = c3d.format;
-    res->base.resource_id = c3d.resource_id;
-    res->base.dmabuf_fd = -1;
+    res = virtio_gpu_virgl_resource_new(c3d.resource_id, c3d.width,
+                                        c3d.height, c3d.format);
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
 
     args.handle = c3d.resource_id;
@@ -853,10 +872,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
-    res = g_new0(struct virtio_gpu_virgl_resource, 1);
-    res->base.resource_id = cblob.resource_id;
-    res->base.blob_size = cblob.size;
-    res->base.dmabuf_fd = -1;
+    res = virtio_gpu_virgl_resource_new_blob(cblob.resource_id, cblob.size);
 
     if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3c3539e337fb..cb45360e769e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -41,6 +41,42 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
 
 static void virtio_gpu_reset_bh(void *opaque);
 
+void
+virtio_gpu_simple_resource_init(struct virtio_gpu_simple_resource *res,
+                               uint32_t resource_id)
+{
+    res->share_handle = SHAREABLE_NONE;
+    res->dmabuf_fd = -1;
+    res->resource_id = resource_id;
+}
+
+struct virtio_gpu_simple_resource *
+virtio_gpu_simple_resource_new(uint32_t resource_id, uint32_t width,
+                               uint32_t height, uint32_t format)
+{
+    struct virtio_gpu_simple_resource *res;
+
+    res = g_new0(struct virtio_gpu_simple_resource, 1);
+    virtio_gpu_simple_resource_init(res, resource_id);
+    res->width = width;
+    res->height = height;
+    res->format = format;
+
+    return res;
+}
+
+struct virtio_gpu_simple_resource *
+virtio_gpu_simple_resource_new_blob(uint32_t resource_id, uint64_t blob_size)
+{
+    struct virtio_gpu_simple_resource *res;
+
+    res = g_new0(struct virtio_gpu_simple_resource, 1);
+    virtio_gpu_simple_resource_init(res, resource_id);
+    res->blob_size = blob_size;
+
+    return res;
+}
+
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id)
@@ -267,12 +303,8 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         return;
     }
 
-    res = g_new0(struct virtio_gpu_simple_resource, 1);
-
-    res->width = c2d.width;
-    res->height = c2d.height;
-    res->format = c2d.format;
-    res->resource_id = c2d.resource_id;
+    res = virtio_gpu_simple_resource_new(c2d.resource_id, c2d.width,
+                                         c2d.height, c2d.format);
 
     pformat = virtio_gpu_get_pixman_format(c2d.format);
     if (!pformat) {
@@ -353,9 +385,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
-    res = g_new0(struct virtio_gpu_simple_resource, 1);
-    res->resource_id = cblob.resource_id;
-    res->blob_size = cblob.size;
+    res = virtio_gpu_simple_resource_new_blob(cblob.resource_id, cblob.size);
 
     if (cblob.nr_entries) {
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
@@ -1455,16 +1485,17 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
 
     resource_id = qemu_get_be32(f);
     while (resource_id != 0) {
+        uint32_t width, height, format;
+
         res = virtio_gpu_find_resource(g, resource_id);
         if (res) {
             return -EINVAL;
         }
 
-        res = g_new0(struct virtio_gpu_simple_resource, 1);
-        res->resource_id = resource_id;
-        res->width = qemu_get_be32(f);
-        res->height = qemu_get_be32(f);
-        res->format = qemu_get_be32(f);
+        width = qemu_get_be32(f);
+        height = qemu_get_be32(f);
+        format = qemu_get_be32(f);
+        res = virtio_gpu_simple_resource_new(resource_id, width, height, format);
         res->iov_cnt = qemu_get_be32(f);
 
         /* allocate */
@@ -1568,14 +1599,15 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
 
     resource_id = qemu_get_be32(f);
     while (resource_id != 0) {
+        uint32_t blob_size;
+
         res = virtio_gpu_find_resource(g, resource_id);
         if (res) {
             return -EINVAL;
         }
 
-        res = g_new0(struct virtio_gpu_simple_resource, 1);
-        res->resource_id = resource_id;
-        res->blob_size = qemu_get_be32(f);
+        blob_size = qemu_get_be32(f);
+        res = virtio_gpu_simple_resource_new_blob(resource_id, blob_size);
         res->iov_cnt = qemu_get_be32(f);
 
         if (res->iov_cnt) {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 69b5ee2e382f..8c0df60b3b7e 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -64,6 +64,17 @@ struct virtio_gpu_simple_resource {
     QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
 };
 
+void
+virtio_gpu_simple_resource_init(struct virtio_gpu_simple_resource *res,
+                               uint32_t resource_id);
+
+struct virtio_gpu_simple_resource *
+virtio_gpu_simple_resource_new(uint32_t resource_id, uint32_t width,
+                               uint32_t height, uint32_t format);
+
+struct virtio_gpu_simple_resource *
+virtio_gpu_simple_resource_new_blob(uint32_t resource_id, uint64_t blob_size);
+
 struct virtio_gpu_framebuffer {
     pixman_format_code_t format;
     uint32_t width, height;

-- 
2.55.0.543.g5ebe2ebe4ea8


