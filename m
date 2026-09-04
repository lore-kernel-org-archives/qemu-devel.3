Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E3BC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Tgo-0003P1-6S; Fri, 04 Sep 2026 09:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tgi-0003Fl-C6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tge-000513-53
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUPxGBpIGz75Sy/ExR+TV3Z7/8jhXGFZP/237UKrcQ0=;
 b=Vqv36/yp4KF9ncjFAc/XMBlSY/4EdmloUXIdcIYCuRpLWFyx1avuumjKf2BT+2M46O0WQA
 II9uvYTXRvkTFgzXA7NNW9fZT6W6ISKv2ebqDUsWRtwD+3riI7S49ymNVD4PpMUdLh8nQ5
 4HzCkVrF3FPxpN4pTfI4VlqCSP2CFu0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-p2Kd2QGnPU-psQTNcUdAag-1; Fri,
 04 Sep 2026 09:10:28 -0400
X-MC-Unique: p2Kd2QGnPU-psQTNcUdAag-1
X-Mimecast-MFC-AGG-ID: p2Kd2QGnPU-psQTNcUdAag_1788527427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D31B419CA46C; Fri,  4 Sep 2026 13:10:26 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DEF01955F70; Fri,  4 Sep 2026 13:10:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:07 +0400
Subject: [PATCH v2 03/25] hw/display/virtio-gpu: introduce
 virtio_gpu_{simple,virgl}_resource_new()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-3-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10508;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PZ3VYE8SzLnC436rfDHqvS0WQkqn6kH670gwHeicr/s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvUk8RUjYvOXlgKVAkJegSYIVpPbK+SPiR7
 8gbD/oVWv6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5cuSD/wMMfjmh9iD+3IKqMBrEeqWagjhXEL0Om55CzWi7NJ3v0l/zs6Iky6IFQUqBc3RJMp27sc
 ElYAjb29dBYuPUHQV1NmLrOzl/DZsOp6KklJL5b/pBP0q1VOqhhefZFt8l/AA0y+2KL/gZ/STnq
 YuDsBzBfHiebhWITFZQqcyqUlCHMJx33P1xwfxAIIzk1710e7LNCa9CuulIuqwEazsTWQtPJmVB
 IjwadWiFI3ERdLWM7gMsisPHIwSOa6gv++nmN/bdaMMWO3/w5nkULYIKyhIEpFZ19qFQ2X2rObR
 ahor+3cq2S0FbsdpQSXSWo0ZE8HiO+kDH4gsfqpYlEYeOYRxqOMo89j9W5ldtX2R2yXDNy+SjSU
 nNVkWMgpa3psTLPKiRqOQigxczxBKQi/X735/4gNnY3JpwqKg6UGJ0QUvtCOu58ky0Q96fqi6Ox
 5xJ8r3McTLRBAqnuA7wdJ4B+vTtr0SYKKn4VIKoeQNR3NdI5CmG25sSC5FC9qG+XpCM11siUdvp
 soQ4I3QvSOgZ0A/WCm1Pjg7B/+8gC1IR3OHMXHcZH+rRI9Pf511dfal/h+WuUHO8StvAQCC+DAw
 O20sBYBF2Wl7DYDK+2FTWqKoZYRRRnl2BkFYmYCoNd+xh9qZTS/ve08DoFLWUW8pEttMO8DZeCl
 H/jF+pqIHCEvbdA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
index aeb6155130d0..1b89d939cfd3 100644
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


