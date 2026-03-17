Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BFFFED9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y6F-0002d2-5N; Tue, 17 Mar 2026 13:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5z-0002RP-UN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5y-0005cM-4a
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QOJFna4uS6y0l2Y//8zT9IKmV+9rc6k0M7hg1PiLWI=;
 b=CNJbTVQMeDxh5Q7WC7tGnKdu/1uRXSdSwVPg6sBWFKnZUqz9Y3gorE7lCsCUINSEpuoxMn
 b7h0RLTh0h8wXVdE9vUbRvPOyTcAysDMYG5xVBd8+hK+RpGfb42s2NGeOojBGyiml44dwo
 VWkHaJLWMMe/tzyW29XK8qLCTiFVcyM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-uXL8NLHVNOaj0PsClM_3kA-1; Tue,
 17 Mar 2026 13:20:30 -0400
X-MC-Unique: uXL8NLHVNOaj0PsClM_3kA-1
X-Mimecast-MFC-AGG-ID: uXL8NLHVNOaj0PsClM_3kA_1773768028
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9456B19560B5; Tue, 17 Mar 2026 17:20:28 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 922F430001A1; Tue, 17 Mar 2026 17:20:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 10/16] ui/console: Unify pixman-OpenGL format mapping
Date: Tue, 17 Mar 2026 21:19:10 +0400
Message-ID: <20260317171916.438575-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

console_gl_check_format() was supposed to check if the pixman format is
supported by surface_gl_create_texture(), but it missed
PIXMAN_BE_x8r8g8b8 and PIXMAN_BE_a8r8g8b8, which are properly mapped to
OpenGL formats by surface_gl_create_texture().

Fix the discrepancy of the two functions by sharing the code to map
pixman formats to OpenGL ones.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260303-gl-v1-1-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/console-gl.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/ui/console-gl.c b/ui/console-gl.c
index 403fc36fbdf..22e9787c415 100644
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


