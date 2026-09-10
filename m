Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEFBC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4a06-0005Lq-Ix; Thu, 10 Sep 2026 04:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4a02-00058a-5w
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4a00-0004xq-0l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=902u+6hgzHqWrogcJHQVHdXlrrsugRKXQmYtn6d7nPM=;
 b=Oud782us3JT+R0olZcsy112n9OKJQ6fCq0iKERNKmR/BNehEppHidYCtHQ1IZYvDAoN31d
 xue4u0awqinZ+JIPFBsVKe4jhI1saHIIq5YU4M09u0sXUXz1EbXsNJ4UhRTS4H+VGJ9YV3
 HXGnR2KxrOKDOKwldgsqKjNT5cm2a1Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-FxK9E4S2P76Gl4P-aymjWA-1; Thu,
 10 Sep 2026 04:19:09 -0400
X-MC-Unique: FxK9E4S2P76Gl4P-aymjWA-1
X-Mimecast-MFC-AGG-ID: FxK9E4S2P76Gl4P-aymjWA_1789028348
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6107A1954223; Thu, 10 Sep 2026 08:19:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDB931956040; Thu, 10 Sep 2026 08:19:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 10 Sep 2026 12:17:49 +0400
Subject: [PATCH v4 21/24] virtio-gpu: minor refactoring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-virtio-gpu-cleanup-v4-21-7d623714bd71@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4171;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IklnvtowgSiW7XcZhDXrwO6dFmeBIZQTUPYB+WJoMZk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomeovZSFXAFrMTlyl1U1lfRraHcAZkQkaRn+B
 eaiN+JvQRCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnqAAKCRDa6OEJdZac
 5YjSD/9JfuTrZMLUbfgX7cSw4b+yTvTEC2U0L35rfdn2WdHayo1Z8bOj20WSPb/SBapXEm/Tpeb
 M/cg1TWYZ2Fju3cfrc6FCuYdyIK2nlLLrNyjwQqDOqNnzis8tad4I3U8FGWm7YQel7ag7+ts/IZ
 pyeWezLYX1NLDAD9Wa+L+E6HrdRROSFMyNo3YMPC9npjgNIJf/wV9PJt6ePSl/nEanvyZP1EGcU
 xpVykYhkMhf+yqNsyI9pLuD6vyw3xAjjLiuWC+aCd0leZXc+3ho8nmx4A3i1xnDBQqlYWgFb7lo
 H06Z7odlJ52ALE1hZxxOi4pBGBcabziw4s3F4wRJbprYTI3XZmUCleoJ90LEzc/xkyZgk7C8TOE
 gEJsm89Wwtk89nSexzLDiZEqk1VC4rx6Zso8Ass3i1zdiZB1i8ATp6O306CHVVazFe0JUgSXPU9
 La2loOcNrBdV4jZrHXF6+N5bQIfg9ygUsVCpW3WRUImQs5vVzs6aHaGkx+TAf0QnMtIWz6ePaU1
 kHYFRmdlsIH2cWUlhQxxvNGzXoJEMb3EBhVFd0oO1r8uC29VFrzKOZPTUzwcLI6/FQOA+JPEWLC
 8TwlqyqCfp6a/Dt7LOQW93w/PUfPId31wl6dvk8jgB11TWwYq0q4elnklqCLKbGRLl6B5B8nMrM
 TQTxrAyuW95enZw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Move disable_scanout() branch earlier, return early.
(scanout->resource_id is cleared there)

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 71 ++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9ca7b946ac65..439a6e1c1cff 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -565,6 +565,8 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_set_scanout ss;
+    struct virgl_renderer_resource_info info;
+    void *d3d_tex2d = NULL;
     int ret;
 
     VIRTIO_GPU_FILL_CMD(ss);
@@ -579,47 +581,46 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
     }
     g->parent_obj.enable = 1;
 
-    if (ss.resource_id) {
-        struct virgl_renderer_resource_info info;
-        void *d3d_tex2d = NULL;
+    if (!ss.resource_id) {
+        virtio_gpu_disable_scanout(g, ss.scanout_id);
+        return;
+    }
 
 #if VIRGL_VERSION_MAJOR >= 1
-        struct virgl_renderer_resource_info_ext ext;
-        memset(&ext, 0, sizeof(ext));
-        ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
-        info = ext.base;
-        d3d_tex2d = ext.d3d_tex2d;
+    struct virgl_renderer_resource_info_ext ext;
+    memset(&ext, 0, sizeof(ext));
+    ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
+    info = ext.base;
+    d3d_tex2d = ext.d3d_tex2d;
 #else
-        memset(&info, 0, sizeof(info));
-        ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
+    memset(&info, 0, sizeof(info));
+    ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
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
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: illegal resource specified %d\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
     }
+    if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
+                                         info.width, info.height, &ss.r,
+                                         &cmd->error)) {
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


