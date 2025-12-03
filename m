Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84312D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 04:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQeAI-0002Fd-HN; Tue, 02 Dec 2025 23:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.yuaz7qs5vfhjsv0=kllqm2owx64x=ksegn939lhphuv@em483429.getutm.app>)
 id 1vQeAE-0002Em-Fx
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:28 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.yuaz7qs5vfhjsv0=kllqm2owx64x=ksegn939lhphuv@em483429.getutm.app>)
 id 1vQeAD-0000Tm-6O
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 23:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764734892; h=from : subject :
 to : message-id : date;
 bh=Q0rWBXh0v74nPYlqDvxdhFdl4JiMuFiyO+nCGeKih+Q=;
 b=mR/7m6ei9XkxMBciEDZTYaflaDH5JROIPnomMoC8lv7WPUQ4oCTBWAF1p5leBuRApbQAJ
 cSHvTXRFJ99NJW9iRKF6z7y20Sa0aQPJnP0YMwAQARwBQNOLSebMy55ghaA18T1NAa5+lT5
 kwZVdA2OWA6BSxP+l0I7QWR8n9OgRREYln7DkKzZQ/cxqEx6ZWJXQGc/0wteG5LmxMmxdqA
 HJqOraYC58cUWRIWls2aYqrcO+PTKye1ftZUTpQ8xE5e8gjJ0K6I1LRlGTaH0GuFXmyk79q
 OC4Yjits4UjSI4h2hNiF+M6KKl94uxYeE6qjTBAG5p4wxPewyVvh102PMxrg==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vQe9r-FnQW0hPv7oK-Vbf4; Wed, 03 Dec 2025 04:08:03 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH RFC 1/7] egl-helpers: store handle to native device
Date: Tue,  2 Dec 2025 20:07:48 -0800
Message-ID: <20251203040754.94487-2-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20251203040754.94487-1-j@getutm.app>
References: <20251203040754.94487-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429stcnh_z_wb
X-smtpcorp-track: 68q7XsSCTGWE.y9JzzDj-leir.geuvvw6AcI_
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.yuaz7qs5vfhjsv0=kllqm2owx64x=ksegn939lhphuv@em483429.getutm.app;
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

Make way for other platforms by making the variable more general. Also we
will be using the device in the future so let's save the pointer in the
global instead of just a boolean flag.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/ui/egl-helpers.h      | 2 +-
 hw/display/virtio-gpu-virgl.c | 2 +-
 ui/egl-helpers.c              | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index acf993fcf5..c239d32317 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -12,7 +12,7 @@
 extern EGLDisplay *qemu_egl_display;
 extern EGLConfig qemu_egl_config;
 extern DisplayGLMode qemu_egl_mode;
-extern bool qemu_egl_angle_d3d;
+extern void *qemu_egl_angle_native_device;
 
 typedef struct egl_fb {
     int width;
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad6..20c856c04e 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1152,7 +1152,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 #endif
 #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
-    if (qemu_egl_angle_d3d) {
+    if (qemu_egl_angle_native_device) {
         flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
     }
 #endif
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e3f2872cc1..57bcf99498 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -28,7 +28,7 @@
 EGLDisplay *qemu_egl_display;
 EGLConfig qemu_egl_config;
 DisplayGLMode qemu_egl_mode;
-bool qemu_egl_angle_d3d;
+void *qemu_egl_angle_native_device;
 
 /* ------------------------------------------------------------------ */
 
@@ -651,7 +651,7 @@ int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode)
         }
 
         trace_egl_init_d3d11_device(device);
-        qemu_egl_angle_d3d = device != NULL;
+        qemu_egl_angle_native_device = d3d11_device;
     }
 #endif
 
-- 
2.41.0


