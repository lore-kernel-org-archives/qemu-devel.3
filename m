Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF79D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfOO-0003AB-6d; Fri, 19 Dec 2025 13:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.horvf1th2k03hy3=eebysjnebmei=e6liisoimp5l8j@em483429.getutm.app>)
 id 1vWfOL-00039s-Um
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:53 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.horvf1th2k03hy3=eebysjnebmei=e6liisoimp5l8j@em483429.getutm.app>)
 id 1vWfOK-0007xN-BX
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170477; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=rAWT498IGawnHLiuDp1wiQjNXziO++mZAeG8x9+lDQI=; b=tLK+9UqmGlHKyEcwvQ0YxUHoS4
 tcnyQhqHCt/oYtZ1AxVjvV7EXDAZznF8Fy4O18uKKUDuqXFAEB6YBiotmbJ3ItDf9C9ukntxQxCxV
 7aUoU8Ndxrd9zQJ2jnbHvXCqYW4Z8pC79TprspQ1UYyEXYGe9plTnzbtO8NyUM55H/mpLR6qGDb9E
 eKYF7TXMxo4gbFLeM11PFJ8Evw+rgoJupRb3IPab/qvmz9jy4bqwu+GjLSmCQSrfKK0pKmT6JAtrC
 KRc8Hugks0qGwEl5J2JoXEJn2toCocEEVT12GmEiJpIcMVahLmu3FqxtwAEAIWwyfJkmcoJYGM88g
 Ne0NzZmw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169577; h=from : subject :
 to : message-id : date;
 bh=rAWT498IGawnHLiuDp1wiQjNXziO++mZAeG8x9+lDQI=;
 b=i8+N6hLJYb0HApqQwEjn5e0FJ8LSrJXzKAV1PoarAMVLbwNPgee+2VFljVPyUAJRzVIrw
 8slaL2FXdMSCjVrjafEfJO7iuHLEk4fLVAKo8hhhucEwqLPxG+p4sa2gsaWFlwoCPiwD8nI
 eaGZlP0fBMt1JrMsxgC8nLQNoQFN572kQp2IUdkpUTBsInCVkqIKabHMbDmmx8Fyxbbn+hw
 vve8iZm83ofQtlKiYh0IAVPq/ZpbLrJV3gDlilMKIZW6qiu6Ou3X7VtdB61zMmVNzYuT0PU
 rG/FHiSHY2b29390qYokiwtHA7La71Qvp4FTEbnl+YkkHFyngDr9xtegdzxA==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfO4-pH9S01-SL; Fri, 19 Dec 2025 18:39:36 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfO3-AIkwcC8uKAK-EyS3; Fri, 19 Dec 2025 18:39:36 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RFC v2 6/6] virtio-gpu-virgl: add support for native blob
 scanout
Date: Fri, 19 Dec 2025 10:38:52 -0800
Message-ID: <20251219183853.4426-7-j@getutm.app>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251219183853.4426-1-j@getutm.app>
References: <20251219183853.4426-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: RWLY3qsDmsQv.gqyUcfvK__Ql.IcEMJQeNepB
Feedback-ID: 483429m:483429abrvJvs:483429sGAFVcKRIz
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.horvf1th2k03hy3=eebysjnebmei=e6liisoimp5l8j@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On macOS we do not have dmabuf and so we use MTLTexture as our scanout
source. For blob scanout, the buffer is untyped and so we cannot get a
MTLTexture until we pass more information to virglrenderer (surface size,
pixel format, etc). The new API to do this is currently unstable so we
need to define `VIRGL_RENDERER_UNSTABLE_APIS`. This should be removed after
the ABI becomes stable.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 meson.build                   |  5 +++
 hw/display/virtio-gpu-virgl.c | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/meson.build b/meson.build
index 05bad663764..8917aff044c 100644
--- a/meson.build
+++ b/meson.build
@@ -2549,6 +2549,11 @@ config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 if virgl.found()
+  config_host_data.set('HAVE_VIRGL_RENDERER_NATIVE_SCANOUT',
+                        cc.has_function('virgl_renderer_create_handle_for_scanout',
+                                        args: '-DVIRGL_RENDERER_UNSTABLE_APIS',
+                                        prefix: '#include <virglrenderer.h>',
+                                        dependencies: virgl))
   config_host_data.set('VIRGL_VERSION_MAJOR', virgl.version().split('.')[0])
 endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index c01587bd25c..18404be5892 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -22,6 +22,7 @@
 
 #include "ui/egl-helpers.h"
 
+#define VIRGL_RENDERER_UNSTABLE_APIS
 #include <virglrenderer.h>
 
 #define NATIVE_HANDLE_SUPPORT_VERSION (1)
@@ -834,6 +835,59 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
     }
 }
 
+#if defined(HAVE_VIRGL_RENDERER_NATIVE_SCANOUT)
+static void virgl_scanout_native_blob_cleanup(ScanoutTextureNative *native)
+{
+    assert(native->type == SCANOUT_TEXTURE_NATIVE_TYPE_METAL);
+    virgl_renderer_release_handle_for_scanout(VIRGL_NATIVE_HANDLE_METAL_TEXTURE,
+                                              native->u.metal_texture);
+}
+
+static bool virgl_scanout_native_blob(VirtIOGPU *g,
+                                      struct virtio_gpu_set_scanout_blob *ss)
+{
+    struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[ss->scanout_id];
+    enum virgl_renderer_native_handle_type type;
+    virgl_renderer_native_handle handle;
+    ScanoutTextureNative native;
+
+    type = virgl_renderer_create_handle_for_scanout(ss->resource_id,
+                                                    ss->width,
+                                                    ss->height,
+                                                    ss->format,
+                                                    ss->padding,
+                                                    ss->strides[0],
+                                                    ss->offsets[0],
+                                                    &handle);
+#ifdef CONFIG_METAL
+    if (type == VIRGL_NATIVE_HANDLE_METAL_TEXTURE) {
+        native = (ScanoutTextureNative){
+            .type = SCANOUT_TEXTURE_NATIVE_TYPE_METAL,
+            .u.metal_texture = handle,
+        };
+        qemu_console_resize(scanout->con,
+                            ss->r.width, ss->r.height);
+        dpy_gl_scanout_texture(
+            scanout->con, 0,
+            false,
+            ss->width, ss->height,
+            ss->r.x, ss->r.y, ss->r.width, ss->r.height,
+            native, virgl_scanout_native_blob_cleanup);
+        scanout->resource_id = ss->resource_id;
+
+        return true;
+    }
+#endif
+
+    /* don't leak memory if handle type is unknown */
+    if (type != VIRGL_NATIVE_HANDLE_NONE) {
+        virgl_renderer_release_handle_for_scanout(type, handle);
+    }
+
+    return false;
+}
+#endif
+
 static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
                                        struct virtio_gpu_ctrl_command *cmd)
 {
@@ -872,6 +926,12 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
         return;
     }
 
+#if defined(HAVE_VIRGL_RENDERER_NATIVE_SCANOUT)
+    if (virgl_scanout_native_blob(g, &ss)) {
+        return;
+    }
+#endif
+
     res = virtio_gpu_virgl_find_resource(g, ss.resource_id);
     if (!res) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
-- 
2.50.1 (Apple Git-155)


