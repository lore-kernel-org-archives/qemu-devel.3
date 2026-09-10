Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962F3C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4et6-0007Ei-Ug; Thu, 10 Sep 2026 09:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4et5-0007Do-5X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4et3-00044D-Ci
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V84QzPH/ZEq2TiJ9XyXdltoKoWTWmtnH7WW8clVTLuY=;
 b=FUiAA9zynmwvfHlRuP/cXo3WIB5TOAgiie+tXZa3pcjVrcBVFqtQ2kmBrF6C16WyPl8IWl
 sK0zuSGncNAKDmNhmbLroCyZfDPeQc/fA/XD2FHA8kpD5xc0hkifsqNAlIOdpVr46O5v2+
 aAlQ1nghwgB76Q4wATaHk3p6pW4U/NY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-bUaCtbzbPGC2X3S5C0mXyg-1; Thu,
 10 Sep 2026 09:32:16 -0400
X-MC-Unique: bUaCtbzbPGC2X3S5C0mXyg-1
X-Mimecast-MFC-AGG-ID: bUaCtbzbPGC2X3S5C0mXyg_1789047135
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F9AC18007FE; Thu, 10 Sep 2026 13:32:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61B541956095; Thu, 10 Sep 2026 13:32:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 17:30:18 +0400
Subject: [GIT PULL 23/24] virtio-gpu: extract
 virtio_gpu_disable_scanout_for_resource helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v1-23-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4697;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RamBfzyG9xTGsBDqH0oHs3capJBKx8ywVXh3V5ZPY1w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDdiGr4MhL4ZAGek/4z2wHm8QgNnyrZchqfL
 XWfVg/RJpiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw3QAKCRDa6OEJdZac
 5UuvD/9G2zNZnml4w9bojLZI+3Mh+qE3O8z4i/cZA1hU7nClqg7LKzyg79deN0Ndme6C6R33Sfu
 56OC9qFJJb0nPficLBAvpLoN5rK+0OJgYezQT68LIsRgDCZo6VN7Ox2ZncmhjmXWVN/mVW/XZsz
 fTlgck+NipCArdKFI2EaTfBWnHJFYnNbAJDSgD1nJMd0nsBsGdcsNxFeDoE1taEvUJRQ4rFhzBE
 OOAYrN/k0yGE15Tl8SI+XNBz987WGsETGVSsm8PdNFwMmfafcTopYF3PHRKBuGYHkL/XFSP//A6
 BfEoDGBAU+Ax5L/IgJxhTzTbL6Yp81DNVuD8zp3INiC7fPZF9/B2c49t3anJuNngxbznHn/oAp7
 rBDINIWnC+6l+QlVp3LEI6GlDi1HfHqhJ/26KP63NjfTDtwsOXR1/XY9HZmm/W0SMYtt58ml0TV
 Ptrv09fpR8D5GpLQfEIMn/ahXSbQTGkAQi5UTUFon/6pl6cUeHdqsVKA2R2Y8Ddf6ytibY1eznt
 bodZNmu99OSZ8u1xkBaBlUats3+98SRqLkQM112QhxMJtsic9BWSvarSYAmVwQwOZAEIVdTG9Oo
 vVk7NpI+Z2tGZ8MrVYhvVErp9A8MkhCVH0wQ/uWFvIGfkbM7rpV37UDQYtd6Bqt2xeSDbX31AaI
 MAIcBbzeOXP+MTw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The same loop iterating scanouts and disabling those matching a given
resource_id was duplicated across four call sites in three backends.
Factor it into a shared helper.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-rutabaga.c |  7 +------
 hw/display/virtio-gpu-virgl.c    |  7 +------
 hw/display/virtio-gpu.c          | 26 ++++++++++++--------------
 include/hw/virtio/virtio-gpu.h   |  2 ++
 4 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 8697dd6936ba..3aafa4dc66cd 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -146,14 +146,9 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
                                    Error **errp)
 {
     int32_t result;
-    int i;
     VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
 
-    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
-            virtio_gpu_disable_scanout(g, i);
-        }
-    }
+    virtio_gpu_disable_scanout_for_resource(g, res->resource_id);
 
     result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
     if (result) {
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 494be3fb4f8d..1c9380e2a6d2 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -431,7 +431,6 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
 {
     struct iovec *res_iovs = NULL;
     int num_iovs = 0;
-    int i;
 #if VIRGL_VERSION_MAJOR >= 1
     int ret;
 
@@ -444,11 +443,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
     }
 #endif
 
-    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        if (g->parent_obj.scanout[i].resource_id == res->base.resource_id) {
-            virtio_gpu_disable_scanout(g, i);
-        }
-    }
+    virtio_gpu_disable_scanout_for_resource(g, res->base.resource_id);
 
     virgl_renderer_force_ctx_0();
     virgl_renderer_resource_detach_iov(res->base.resource_id,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e8a0dd24c873..bb0f41bb1e05 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -444,17 +444,21 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
     scanout->height = 0;
 }
 
+void virtio_gpu_disable_scanout_for_resource(VirtIOGPU *g,
+                                             uint32_t resource_id)
+{
+    for (int i = 0; i < g->parent_obj.conf.max_outputs; i++) {
+        if (g->parent_obj.scanout[i].resource_id == resource_id) {
+            virtio_gpu_disable_scanout(g, i);
+        }
+    }
+}
+
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
                                         struct virtio_gpu_simple_resource *res,
                                         Error **errp)
 {
-    int i;
-
-    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
-        if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
-            virtio_gpu_disable_scanout(g, i);
-        }
-    }
+    virtio_gpu_disable_scanout_for_resource(g, res->resource_id);
 
     qemu_pixman_image_unref(res->image);
     virtio_gpu_cleanup_mapping(g, res);
@@ -1062,13 +1066,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                 struct virtio_gpu_simple_resource *res)
 {
     if (res->blob) {
-        int i, max_outputs = g->parent_obj.conf.max_outputs;
-
-        for (i = 0; i < max_outputs; i++) {
-            if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
-                virtio_gpu_disable_scanout(g, i);
-            }
-        }
+        virtio_gpu_disable_scanout_for_resource(g, res->resource_id);
     }
 
     virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 2f18d839ccd3..631dfc63a4d4 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -404,6 +404,8 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
                                struct virtio_gpu_framebuffer *fb,
                                struct virtio_gpu_rect *r);
 void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id);
+void virtio_gpu_disable_scanout_for_resource(VirtIOGPU *g,
+                                             uint32_t resource_id);
 
 /* virtio-gpu-3d.c */
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,

-- 
2.55.0.543.g5ebe2ebe4ea8


