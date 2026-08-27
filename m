Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576BCC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 07:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzUFM-0003Hb-3w; Thu, 27 Aug 2026 03:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzUFK-0003GM-8g
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzUFH-00041x-Va
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 03:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787814592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G6DrNHyZFGj9l31Wr7T1mKZMbMd3BAR8wdacwP7mjLQ=;
 b=jQ5zL7XF9eUExrW5hAFsEfkun1inMk8mntcVq3mW5eEVNySjtxfkKAKUypvnWvWA5vHt6U
 FIyTvia3Wbq+Rvr4VNQRDu92reHd1bpgGep8DHNAb/6SXO6t2Y+UqaVjVJUAlkLhhbzueH
 yl5rzr+ApQRYMuW8ckllD61H7/bfEJU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-5xVvPpkdP5mVuiiBYEeZxw-1; Thu,
 27 Aug 2026 03:09:47 -0400
X-MC-Unique: 5xVvPpkdP5mVuiiBYEeZxw-1
X-Mimecast-MFC-AGG-ID: 5xVvPpkdP5mVuiiBYEeZxw_1787814586
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE6981835ADB; Thu, 27 Aug 2026 07:09:45 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23B9B30001A2; Thu, 27 Aug 2026 07:09:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/display/virtio-gpu: introduce
 virtio_gpu_simple_resource_new()
Date: Thu, 27 Aug 2026 11:09:41 +0400
Message-ID: <20260827070941.2875721-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

All allocation sites used g_new0() which zero-initializes fields.
However share_handle must be SHAREABLE_NONE (-1 on Unix, NULL on
Windows) and dmabuf_fd must be -1, not 0. Centralize allocation and
field initialization in a single constructor to fix this and reduce
code duplication.

This fixes -display dbus with virtio-gpu blob resources. The other
end is currently receiving qemu fd 0.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c | 20 +++++-------------
 hw/display/virtio-gpu.c          | 35 +++++++++++++++++++++-----------
 include/hw/virtio/virtio-gpu.h   |  4 ++++
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 041216a10d04..234fe94b178b 100644
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
 
@@ -634,9 +626,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
 
     CHECK(cblob.resource_id != 0, cmd);
 
-    res = g_new0(struct virtio_gpu_simple_resource, 1);
-
-    res->resource_id = cblob.resource_id;
+    res = virtio_gpu_simple_resource_new(cblob.resource_id, 0, 0, 0);
     res->blob_size = cblob.size;
 
     if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 55a1c7f80fb8..d5405f0c715f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -41,6 +41,24 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
 
 static void virtio_gpu_reset_bh(void *opaque);
 
+struct virtio_gpu_simple_resource *
+virtio_gpu_simple_resource_new(uint32_t resource_id, uint32_t width,
+                               uint32_t height, uint32_t format)
+{
+    struct virtio_gpu_simple_resource *res =
+        g_new0(struct virtio_gpu_simple_resource, 1);
+
+    res->share_handle = SHAREABLE_NONE;
+    res->dmabuf_fd = -1;
+
+    res->resource_id = resource_id;
+    res->width = width;
+    res->height = height;
+    res->format = format;
+
+    return res;
+}
+
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id)
@@ -259,12 +277,8 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
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
@@ -345,8 +359,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
-    res = g_new0(struct virtio_gpu_simple_resource, 1);
-    res->resource_id = cblob.resource_id;
+    res = virtio_gpu_simple_resource_new(cblob.resource_id, 0, 0, 0);
     res->blob_size = cblob.size;
 
     if (cblob.nr_entries) {
@@ -1442,8 +1455,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res = g_new0(struct virtio_gpu_simple_resource, 1);
-        res->resource_id = resource_id;
+        res = virtio_gpu_simple_resource_new(resource_id, 0, 0, 0);
         res->width = qemu_get_be32(f);
         res->height = qemu_get_be32(f);
         res->format = qemu_get_be32(f);
@@ -1555,8 +1567,7 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
             return -EINVAL;
         }
 
-        res = g_new0(struct virtio_gpu_simple_resource, 1);
-        res->resource_id = resource_id;
+        res = virtio_gpu_simple_resource_new(resource_id, 0, 0, 0);
         res->blob_size = qemu_get_be32(f);
         res->iov_cnt = qemu_get_be32(f);
 
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 69b5ee2e382f..090719aa0522 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -64,6 +64,10 @@ struct virtio_gpu_simple_resource {
     QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
 };
 
+struct virtio_gpu_simple_resource *
+virtio_gpu_simple_resource_new(uint32_t resource_id, uint32_t width,
+                               uint32_t height, uint32_t format);
+
 struct virtio_gpu_framebuffer {
     pixman_format_code_t format;
     uint32_t width, height;
-- 
2.55.0.543.g5ebe2ebe4ea8


