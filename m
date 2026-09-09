Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12198C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G76-0007LQ-SU; Wed, 09 Sep 2026 07:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6o-0006iU-RL
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G6m-0005NL-ES
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QzWw/3YpuNlpbbtK3De1nZgXPTUKbTQhhI4hImd84U=;
 b=bnKrbzJxjopSJEUG+Ccj/j75JDhcv94EgynhJgf/mDd4PGoYWm0cWjRZfTprPyg07XO8ZG
 5EJFwZj6oRU0dNE25zacZ5IKIw9pN47XCt7waaP7dkhQkHgYmhpHnEm+LX8NOsiWMYjRjC
 46blsErXx5GhVIVecyDm8mHc3DOp+N4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-KG6ZqEUiOvmlDEKIz5ZAsw-1; Wed,
 09 Sep 2026 07:04:48 -0400
X-MC-Unique: KG6ZqEUiOvmlDEKIz5ZAsw-1
X-Mimecast-MFC-AGG-ID: KG6ZqEUiOvmlDEKIz5ZAsw_1788951887
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99D9118005BA; Wed,  9 Sep 2026 11:04:47 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB11E1955F19; Wed,  9 Sep 2026 11:04:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:26 +0400
Subject: [PATCH v3 21/24] virtio-gpu: minor refactoring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-21-99266590e79d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4171;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=36qNtf5VJCj4Rho3xGqwfp3/DDQJNjPDldw5TS9Jilw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzzqatNIWCuYCfv6puHdF1X6tv4zO/LwV2/J
 EUPKdRlkOmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88wAKCRDa6OEJdZac
 5Q5WEACPq0jzrwpTboBX6PyCaQ9Zk+JjeoptNL1gttG/ytOGAG2YHs0a1798qPEJmrwq4YN8z/Z
 pBlLoJhqq6kitO7ocLO999M1LHOnm0jbu2tSgYDqqIuNns3LjZ57817oZ1J2WHOtc5px+VUXQ9M
 pelRgxslyYcJQV8kkiJfmHX8wvC6g0jAzQr4BdQVEhBNVKV/AwRZxkPJ5C03H5TGqj08DYyhDB5
 uUmMFWVqSXd34lxU6+VD4fnYWzvgjUddZj41ugIDQMMn26KMlBSA26AkOO7JClVpV1UCRqmKkqk
 DclD3ezL4mSdMRodxxQ2JeNkgUfPSeyD1AX3w2tTcjy6ZI53UJEg3otp42EyaabpAOaJ+ksTiMq
 KWSnDI9Ev62IwvS7v3kin2jmTKER9JinkVtTKKm7xHoj1GDedM9OHTTGICd79U85bhkWjOCTfPM
 8ybsUyIX1BZfUQelIaDCWuhxbVFzxCthJcsEmMHUV4R0mUbLAvuITO7QF3QjjUdyOggB1L4PpBZ
 Ii8DWOZOc3F0B5RXM63264kKyTHa91jVgjlpecwGVaOKUA88djWzU38Qc49MgH0MlOlpNQKyHa2
 F2Le7NPZymBb4b00Qa5eztUuWZ+TyFHtcwMQkHPS35K9fmAc9BTHeOAyfhFymULQaaaaZHGVJZs
 F/e2LuPKw77wgKQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 127.0.0.2
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

Move disable_scanout() branch earlier, return early.
(scanout->resource_id is cleared there)

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 71 ++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 87d1fc3d5f65..118419171ff0 100644
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


