Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E06CC61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoLA-0002Jj-D4; Tue, 25 Aug 2026 06:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoL9-0002DQ-5C
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoL6-0006PN-2O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MJrzXyFMbPp4Y4K5SAU9Emf58IWqZfzzL0ndx68q+U=;
 b=WBXnbosOqnuhCWZjsNPfZiOeEcOMwHBL4Khg8Pg3Gt6V/drabwGl9cQRJ9aV+kesqAmAJO
 1I7A78Y8Q/MU4n53o0b57gMlwXh+tYI/MTi8PHY4o/2JYKWR9QSi0zpvYBA6yiTJLjeEKL
 JDZfbID7yV92gXnOnyuihfhEipbWmus=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-o45GIaTiPeWTI2G5ASG9Jw-1; Tue,
 25 Aug 2026 06:25:04 -0400
X-MC-Unique: o45GIaTiPeWTI2G5ASG9Jw-1
X-Mimecast-MFC-AGG-ID: o45GIaTiPeWTI2G5ASG9Jw_1787653502
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7D15186A726; Tue, 25 Aug 2026 10:25:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75A6C18005B7; Tue, 25 Aug 2026 10:24:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:52 +0400
Subject: [PATCH 15/18] virtio-gpu: minor refactoring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-15-d3bb612b9975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3742;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=M+DsU7i5OHamO9hpXgnfHT8LBl3WTiNZ0wK3pgCSQJ0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyYdPA7Pq5KyHtvAtQhI9LJqn6WbSpG5kUA0
 zTQnDz1R9GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1smAAKCRDa6OEJdZac
 5abaD/9v5bYiBxoepkOLHSjSn+8G3TDaCoIqUfxuxAjZOsNg5W7iXbz9kXk/whRoufUYc8HW49g
 eyCZe9M5xZWdevOe6WW5O46eqnB6J5j/EMiF1L7iMiRMsUDuWSFUtlGqaAs7giDP3VIbMemtJJg
 O0xQ5Ee7lWNPf+iEZ1bUxo1g3VswU/HBVHVxkkaXLVsuXXWqnj0SD0KOTyLPXapA16M/81ubg1D
 zYGnyPktBqm7jhcVbLCESszSsMAJc2xHIXM9/abfzFEORF6RbTqqDZumprTcGe9YoaiAqB4D3VZ
 Fzkyyi/iN+b+RdJ0S6ujn8q1d+tVOgrGLf4Ae/yg5SzMG0K3m6ntq0YVcyBXxgLtyZ4lIUuqXZz
 JhvqXys+YoSPVBjE9BFBZJZaOGo7mdljX7HFM5DTcGsrUM5Xf545/+Nt+ZLZpYGGAeKWBQPwd+1
 UlD3Ef5QB19Wm1OmMNqHKH9y9f+O0kTUWotq2zBAwj6Xff5HDBD2lORe+ONnBrM8+u5XpNLFhTI
 BZ3j1lmw7SgSWBksesPPIl/W5EKvO14KDAmJfjb2Wesp+O88OBrdpepL5amNGhYBlCwrgvI8Z8S
 J+heuDNbGXagSnO1CsUSEvrv1jY2aGyQKRKF7g5w/PbZnb+j3OitLlY+jdGDtPiRIYa7r0/lYvV
 oPPzjEGptiWT8zA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Move disable_scanout() branch earlier, return early.
(scanout->resource_id is cleared there)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 61 +++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 6cb9365a714f..e2ad27343da5 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -546,6 +546,8 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_set_scanout ss;
+    struct virgl_renderer_resource_info info;
+    void *d3d_tex2d = NULL;
     int ret;
 
     VIRTIO_GPU_FILL_CMD(ss);
@@ -560,10 +562,12 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
     }
     g->parent_obj.enable = 1;
 
-    if (ss.resource_id) {
-        struct virgl_renderer_resource_info info;
-        void *d3d_tex2d = NULL;
+    if (!ss.resource_id) {
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
+        return;
+    }
 
+    {
 #if VIRGL_VERSION_MAJOR >= 1
         struct virgl_renderer_resource_info_ext ext;
         memset(&ext, 0, sizeof(ext));
@@ -574,33 +578,32 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
         memset(&info, 0, sizeof(info));
         ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
 #endif
-        if (ret) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: illegal resource specified %d\n",
-                          __func__, ss.resource_id);
-            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
-            return;
-        }
-        if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
-                                             info.width, info.height, &ss.r,
-                                             &cmd->error)) {
-            return;
-        }
-
-        virtio_gpu_release_scanout_dmabuf(g, ss.scanout_id);
-
-        qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
-                            ss.r.width, ss.r.height);
-        virgl_renderer_force_ctx_0();
-        qemu_console_gl_scanout_texture(
-            g->parent_obj.scanout[ss.scanout_id].con, info.tex_id,
-            info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
-            info.width, info.height,
-            ss.r.x, ss.r.y, ss.r.width, ss.r.height,
-            d3d_tex2d);
-    } else {
-        virtio_gpu_disable_scanout(g, ss.scanout_id);
     }
+
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                        "%s: illegal resource specified %d\n",
+                        __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+    if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
+                                            info.width, info.height, &ss.r,
+                                            &cmd->error)) {
+        return;
+    }
+
+    virtio_gpu_release_scanout_dmabuf(g, ss.scanout_id);
+
+    qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
+                        ss.r.width, ss.r.height);
+    virgl_renderer_force_ctx_0();
+    qemu_console_gl_scanout_texture(
+        g->parent_obj.scanout[ss.scanout_id].con, info.tex_id,
+        info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
+        info.width, info.height,
+        ss.r.x, ss.r.y, ss.r.width, ss.r.height,
+        d3d_tex2d);
     g->parent_obj.scanout[ss.scanout_id].resource_id = ss.resource_id;
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


