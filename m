Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0CCD1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 04:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQeAQ-0002Ja-Na; Tue, 02 Dec 2025 23:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.k4ef0d26m0hjpq5=lta69ff2eskf=qk5ki1l7zbdzhh@em483429.getutm.app>)
 id 1vQeAM-0002Hq-Rn
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:35 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.k4ef0d26m0hjpq5=lta69ff2eskf=qk5ki1l7zbdzhh@em483429.getutm.app>)
 id 1vQeAL-0000Tm-BL
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734904; h=from : subject :
 to : message-id : date;
 bh=y9kSlBF0XTESB4AkIAMB416dSilaCjGWrQ+4K3SRvfk=;
 b=B1ogOoXkO8Dg4uwBHeNS9EUCo+8cdmPYhNCbBA1BC4li30/H0salP249aXRuNHTZ3oQHH
 UlhPAf4Y/y5jwPJrsuz225JUCoMCHxvNKAHeX54+QgxeMFzfRN29MHg87YhFvANSzE8pDuJ
 m0e8cFySlMpRsYJjcCvCfTIS8Hfx0HVwwo4f39UXlbT3+wYuJJ5XUamv//TPWhDGMouYZK2
 TqusXcReY9nWB+q4GirA0jrzFuysJfuJgzq6Rfgsg6949clHvRAUDoBtAvcIPkGtly3IvFt
 IfYyK6JSKN10yDHrdSP9RJ4qwjs7+hsGhkZaxlyMF8t8NrUuBbYnZ9zKtq5g==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQeA2-FnQW0hPv7oK-UTTy; Wed, 03 Dec 2025 04:08:14 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RFC 5/7] virtio-gpu-virgl: support scanout of Metal textures
Date: Tue,  2 Dec 2025 20:07:52 -0800
Message-ID: <20251203040754.94487-6-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20251203040754.94487-1-j@getutm.app>
References: <20251203040754.94487-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sRlcTQnisq
X-smtpcorp-track: dv_CflWhdwOb.innxFtf1XVAI.O0bLQAj_GoV
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.k4ef0d26m0hjpq5=lta69ff2eskf=qk5ki1l7zbdzhh@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When supported, virglrenderer will return a MTLTexture handle that can be
directly used for scanout.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 meson.build                   |  4 ++++
 include/ui/console.h          |  2 ++
 hw/display/virtio-gpu-virgl.c | 12 +++++++++++-
 hw/display/virtio-gpu.c       |  2 ++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d9293294d8..05bad66376 100644
--- a/meson.build
+++ b/meson.build
@@ -832,6 +832,7 @@ version_res = []
 coref = []
 iokit = []
 pvg = not_found
+metal = not_found
 emulator_link_args = []
 midl = not_found
 widl = not_found
@@ -859,6 +860,7 @@ elif host_os == 'darwin'
   host_dsosuf = '.dylib'
   pvg = dependency('appleframeworks', modules: ['ParavirtualizedGraphics', 'Metal'],
                    required: get_option('pvg'))
+  metal = dependency('appleframeworks', modules: 'Metal', required: false)
 elif host_os == 'sunos'
   socket = [cc.find_library('socket'),
             cc.find_library('nsl'),
@@ -2591,6 +2593,7 @@ if xen.found()
     ('0' + xen_version[2]).substring(-2)
   config_host_data.set('CONFIG_XEN_CTRL_INTERFACE_VERSION', xen_ctrl_version)
 endif
+config_host_data.set('CONFIG_METAL', metal.found())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
@@ -4874,6 +4877,7 @@ summary(summary_info, bool_yn: true, section: 'Crypto')
 summary_info = {}
 if host_os == 'darwin'
   summary_info += {'Cocoa support':           cocoa}
+  summary_info += {'Metal support':           metal}
 endif
 summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'SDL support':       sdl}
diff --git a/include/ui/console.h b/include/ui/console.h
index 25e45295d4..a45b524c57 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -134,12 +134,14 @@ struct QemuConsoleClass {
 typedef enum ScanoutTextureNativeType {
     SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
     SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
+    SCANOUT_TEXTURE_NATIVE_TYPE_METAL,
 } ScanoutTextureNativeType;
 
 typedef struct ScanoutTextureNative {
     ScanoutTextureNativeType type;
     union {
         void *d3d_tex2d;
+        void *metal_texture;
     } u;
 } ScanoutTextureNative;
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 36c670f988..e091eb0c76 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -452,6 +452,13 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
 #if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >= SUPPORTED_VIRGL_INFO_EXT_VERSION
         if (ext.version >= VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION) {
             switch (ext.native_type) {
+#ifdef CONFIG_METAL
+            case VIRGL_NATIVE_HANDLE_METAL_TEXTURE: {
+                native.type = SCANOUT_TEXTURE_NATIVE_TYPE_METAL;
+                native.u.metal_texture = ext.native_handle;
+                break;
+            }
+#endif
             case VIRGL_NATIVE_HANDLE_NONE:
             case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
                 /* already handled above */
@@ -1198,7 +1205,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #if VIRGL_VERSION_MAJOR >= 1
     if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
-        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
+        flags |= VIRGL_RENDERER_VENUS;
+#ifndef CONFIG_METAL /* Metal does not support render server */
+        flags |= VIRGL_RENDERER_RENDER_SERVER;
+#endif
     }
 #endif
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43e88a4daf..9cf2c15a43 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1485,12 +1485,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     VirtIOGPU *g = VIRTIO_GPU(qdev);
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
+#ifndef CONFIG_METAL
         if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
             !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
             !virtio_gpu_have_udmabuf()) {
             error_setg(errp, "need rutabaga or udmabuf for blob resources");
             return;
         }
+#endif
 
 #ifdef VIRGL_VERSION_MAJOR
     #if VIRGL_VERSION_MAJOR < 1
-- 
2.41.0


