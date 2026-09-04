Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2587C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ti1-0006cl-GI; Fri, 04 Sep 2026 09:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thx-0006WT-5q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Thv-0005EP-Fx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0NIziQTq1h4MzDGVZ6bdGTJI7TGbe5OSJ55loeX+RE=;
 b=FjhGr8wjY0JxD2e36VuEgCIMikLEp1gHWCWtCTMMK0bJEfE3aRhnTA1w5hhv1WgBkjIj05
 VFBArT6vT3/MxH3H7pemUq8zfS1EhLn2tnOUWbmeRzpeT//uHCfuaSfiQGmgnP6VxbDgcd
 CUZLPxj15OzHL1TPYE+Oc3rsEjFyGds=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-lqXkkBCtNcyTiD9pcl16eg-1; Fri,
 04 Sep 2026 09:11:47 -0400
X-MC-Unique: lqXkkBCtNcyTiD9pcl16eg-1
X-Mimecast-MFC-AGG-ID: lqXkkBCtNcyTiD9pcl16eg_1788527506
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4918B1964CFF; Fri,  4 Sep 2026 13:11:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A78418005AC; Fri,  4 Sep 2026 13:11:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:27 +0400
Subject: [PATCH v2 23/25] virtio-gpu: extract
 virtio_gpu_disable_scanout_for_resource helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-23-15b5ae6b0023@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4638;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8xvsPIWc0Xnv3CBLlwXfGbLEVAJErRlne2ni4LLhj1M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMwF7WDek9O8pCXtOYlWrbceHoX3meZvEYGP
 HF9yczbwWyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDMAAKCRDa6OEJdZac
 5bCUD/9SFvoqwo3bhPOnp1qW4Z0d0FnVTuf04AY2J/7TEBWur7PbnUtYDChHPhF2ljV5eX8zIYm
 b8dy0y4lt4H2MzbeAFX6suY0Ro3tLuAtnDgLQEbe4aL8fVoDju/uAfEdZX5A/QcrJKlA54yBVtT
 6E5A6fXxVsPLiecMLmu4j+MQSuHkvCNmUwk71d6NPv1DhAL29Y8/89YJGdAhebFTZkfyDKZ1d/s
 uIb6lzkdHAJYCS/C+dgKKaS8l8VfDzfPzC46HsS/a31etaFnmwqx1vX7XsQqMHzVBIuZNup4wwt
 +HkHCoPSWiJhf8j+3FboRcVHCwKxI87VuqXPMNJFS4fImi9d13tZH5+nshyw/x29i9FpJC6a+tU
 PmoeeQNOA2CfleLLCI930nd/4N++DL3N5S9jjarITyCv/adlHPGUJbqbtUShrE2mrLwwFf9MvcG
 3O9rYxIEdI10DxJBCcGaddVnMqhcFWfifgYsfghhi4wFcdzf0z49b5CHL8mZiWKc7vLYD2xusWY
 ptLJ24hfuKRbL6SBkJT+4YMWHFJ8qLRi8yp/G8a/7Y6K6qcYnOOKRLWN6Y0x+H+3hYRBjLlU6/J
 fJKYrUylbN2ye1xeDfFTAQ5e6NiuXDo/IxbYj6GqdfPpLpg8c3I07yLINWO3Rh1v1Aav3f1Suab
 yu1g1Qu5sFqDorg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index cf624761610a..248aaf1a7149 100644
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
index cb096cb349cd..9995f7184610 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -447,17 +447,21 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
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
@@ -1065,13 +1069,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
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


