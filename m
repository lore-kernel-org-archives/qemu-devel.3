Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37A9EC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVS-0007nj-Vm; Tue, 03 Mar 2026 08:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPV9-0007RH-Nm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:36 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxPUz-0000Ni-9J
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:22 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 623D90Jc018783
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 22:09:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SProQHUBdazPBUcxN+pk1vSRrVcqnXiyNpUMfkAiDRw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772543351; v=1;
 b=qUxjDk/i/psGgQepkrcs0MEUNHFm/OgkvAiYXCplA4BJj7BI+DNOr93085C0Ks76
 jTNtJE3sK/Ek3gKY99JYACTkhGhlKYQwGn4jLL2zagqCcYF1QMCRZQY+tJqLBf5K
 hd+qXvCpHb0FB64uVHI/fptznsjKDyLCH05yWJKhK0ZR3dZJNQe04bkd2HdtDDZS
 EtDDjScV3gscM57Ysnxf4p3Ebz3ayFfhicVprIbRO+WYTbXXJ6UltliZpoFTrHGB
 skB+9cdaWOtl/5IWM/6uZ2+bP0ZPudE3PCANwfg6azr9E/CqQpayPfGMTwXA/Wdx
 4uwDQnCMdA8ofUSBZBC0VA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 03 Mar 2026 22:08:54 +0900
Subject: [PATCH 1/3] ui/console: Unify pixman-OpenGL format mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-gl-v1-1-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
References: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260303-gl-v1-0-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
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

console_gl_check_format() was supposed to check if the pixman format is
supported by surface_gl_create_texture(), but it missed
PIXMAN_BE_x8r8g8b8 and PIXMAN_BE_a8r8g8b8, which are properly mapped to
OpenGL formats by surface_gl_create_texture().

Fix the discrepancy of the two functions by sharing the code to map
pixman formats to OpenGL ones.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/console-gl.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/ui/console-gl.c b/ui/console-gl.c
index 403fc36fbdf2..22e9787c4156 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -31,19 +31,38 @@
 
 /* ---------------------------------------------------------------------- */
 
-bool console_gl_check_format(DisplayChangeListener *dcl,
-                             pixman_format_code_t format)
+static bool map_format(pixman_format_code_t format,
+                       GLenum *glformat, GLenum *gltype)
 {
     switch (format) {
     case PIXMAN_BE_b8g8r8x8:
     case PIXMAN_BE_b8g8r8a8:
+        *glformat = GL_BGRA_EXT;
+        *gltype = GL_UNSIGNED_BYTE;
+        return true;
+    case PIXMAN_BE_x8r8g8b8:
+    case PIXMAN_BE_a8r8g8b8:
+        *glformat = GL_RGBA;
+        *gltype = GL_UNSIGNED_BYTE;
+        return true;
     case PIXMAN_r5g6b5:
+        *glformat = GL_RGB;
+        *gltype = GL_UNSIGNED_SHORT_5_6_5;
         return true;
     default:
         return false;
     }
 }
 
+bool console_gl_check_format(DisplayChangeListener *dcl,
+                             pixman_format_code_t format)
+{
+    GLenum glformat;
+    GLenum gltype;
+
+    return map_format(format, &glformat, &gltype);
+}
+
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface)
 {
@@ -54,25 +73,7 @@ void surface_gl_create_texture(QemuGLShader *gls,
         return;
     }
 
-    switch (surface_format(surface)) {
-    case PIXMAN_BE_b8g8r8x8:
-    case PIXMAN_BE_b8g8r8a8:
-        surface->glformat = GL_BGRA_EXT;
-        surface->gltype = GL_UNSIGNED_BYTE;
-        break;
-    case PIXMAN_BE_x8r8g8b8:
-    case PIXMAN_BE_a8r8g8b8:
-        surface->glformat = GL_RGBA;
-        surface->gltype = GL_UNSIGNED_BYTE;
-        break;
-    case PIXMAN_r5g6b5:
-        surface->glformat = GL_RGB;
-        surface->gltype = GL_UNSIGNED_SHORT_5_6_5;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
+    assert(map_format(surface_format(surface), &surface->glformat, &surface->gltype));
     glGenTextures(1, &surface->texture);
     glEnable(GL_TEXTURE_2D);
     glBindTexture(GL_TEXTURE_2D, surface->texture);

-- 
2.53.0


