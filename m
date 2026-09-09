Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE7EC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G75-0007A3-EM; Wed, 09 Sep 2026 07:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6v-0006ys-I5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6t-0005PB-Jr
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EI6Q6kP08E6KWYuu4ZM6QP4gQmBboshB5ItlxzoczRs=;
 b=MFKYgm2Ig0uCcxnf2M+DH+9TIbnkX9p2oaRRC0Br7eoftDiAl0tccMEhzExyEhPvNZhY7c
 y4hGDo1wyrNfzU8+RIs+xSrNRu+xf9nLzfuZSwqekT5cLirlMBjBlSg2/tcn/2eXq0Id+a
 R3GMtGz44kwM2B2cWH5OkpD33ZhBxhg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-VhSzLt1BNkig5XJnkczOQQ-1; Wed,
 09 Sep 2026 07:04:55 -0400
X-MC-Unique: VhSzLt1BNkig5XJnkczOQQ-1
X-Mimecast-MFC-AGG-ID: VhSzLt1BNkig5XJnkczOQQ_1788951894
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99EA0180058A; Wed,  9 Sep 2026 11:04:54 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD52A41B; Wed,  9 Sep 2026 11:04:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:28 +0400
Subject: [PATCH v3 23/24] virtio-gpu: extract
 virtio_gpu_disable_scanout_for_resource helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-23-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4697;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Q5S8IS9e1gbpCRM7oO2tMg0ySKbDiw+oSBRzVfR9zT4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzzyqz/1rgiqP/VY+Pd2kjVNIGtLyh7mVnvS
 c1VLb3A/d+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88wAKCRDa6OEJdZac
 5fDlEACSEJOKkdwriHYMIgmap52zx3Cv3FFpYjAj7KKV5DJ2dCbhWVl++it7oI+y9hw4/LIsbIb
 J8vx8LtgUv9wnUn4ihuXRGDtAeu8xV7TS91Qj7+JN/jIcSWlEivTrdau8WoiCxzV5QUfid6Qvd+
 Y45VwrTJLjZDWxRwM7/hpXj/mFeKTqAehKEwZjCY0HObraThWScpoDy0fvcspblpw2IXa5A+g1F
 kVTXWNud3HWOXYjAJ9EEiHLdE2rGyql9oSbgtQ/lxrSbl0nwBgHUVqRX8qeEE/W1bqeNiFdj43K
 PM6/Yb5YUWqH3Lg1I+agluGoiIxy8QKtYegC34eJ52WOPKNmvNSWEhBKRFekZ1SZ4d7h79KtzFi
 JgK3Ux98qDZEnvoZ8s6astEahZoAv1KWTf+2ZcYe6ZjYRBypuL5bW+3OilAZmmpFKi8OC5okeTt
 rZP4hz86gyENFoMuc+K4S+t698wE3jm0UH6ENmOt8DnW0w9C+4mwB7UCdujAsUdcF/ypxeQ36bV
 6Pcu5c+C5ukcYuis2NGd6ie10TR1JTmK0On1kGhpMHOS3Zd+TjHGEvqKR/GUclg8wd+9vkGV/va
 Kv0ZbLhMrO6sWVDYY9ceVqZja7/77fT0cBtc3IscE7qkfQol6/S1Jh7ywNhUKCj3ObjVtJ8nks8
 9QquTRpwuthwaow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index dc5b2da9a43f..7a6eca944310 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -446,17 +446,21 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
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
@@ -1064,13 +1068,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
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


