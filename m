Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C3FED9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y6L-0002nr-47; Tue, 17 Mar 2026 13:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y68-0002an-4N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y66-0005dl-8A
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rR90AFdo1Am/JLo89PgA9Iv5kx1gqs6R7n5iAEgk20=;
 b=CdiqFOUXAf2/Bu+2CwrCERyftBmZZxzTHJxsnAKTzYpVdevrpS2QqtmAu8Xl0AiHWriMDj
 5cJ1J6pIFdZWp4uMJZkt3mk7Fam9f6owiTOzEX43d+EnOF0foSY/j6La4PRMpTmuISK/19
 n0CoAJ4nbe3DW0xIAYEY5drGHUhYvhc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-0kv6Y4hdPsu58QUQYHrU3A-1; Tue,
 17 Mar 2026 13:20:44 -0400
X-MC-Unique: 0kv6Y4hdPsu58QUQYHrU3A-1
X-Mimecast-MFC-AGG-ID: 0kv6Y4hdPsu58QUQYHrU3A_1773768042
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE6791944EAA; Tue, 17 Mar 2026 17:20:42 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 584A830002C3; Tue, 17 Mar 2026 17:20:38 +0000 (UTC)
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
Subject: [PULL 12/16] ui/surface: Avoid including epoxy/gl.h in header files
Date: Tue, 17 Mar 2026 21:19:12 +0400
Message-ID: <20260317171916.438575-13-marcandre.lureau@redhat.com>
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

include/ui/shader.h and include/ui/surface.h are included by files that
do not depend on Epoxy so they shouldn't include epoxy/gl.h. Otherwise,
compilations of these files can fail because the path to the directory
containing epoxy/gl.h may not be passed to the compiler.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260303-gl-v1-3-d90f0a237a52@rsg.ci.i.u-tokyo.ac.jp>
---
 include/ui/console.h |  4 ++--
 include/ui/shader.h  |  2 --
 include/ui/surface.h |  5 +----
 ui/console-gl.c      | 27 ++++++++++++++-------------
 ui/shader.c          |  1 +
 5 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 3677a9d334d..08082389f71 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -423,8 +423,8 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
 bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
-                                       int fd, GLuint *texture,
-                                       GLuint *mem_obj);
+                                       int fd, uint32_t *texture,
+                                       uint32_t *mem_obj);
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h);
diff --git a/include/ui/shader.h b/include/ui/shader.h
index 4c5acb2ce8b..e82213263c4 100644
--- a/include/ui/shader.h
+++ b/include/ui/shader.h
@@ -1,8 +1,6 @@
 #ifndef QEMU_SHADER_H
 #define QEMU_SHADER_H
 
-#include <epoxy/gl.h>
-
 typedef struct QemuGLShader QemuGLShader;
 
 void qemu_gl_run_texture_blit(QemuGLShader *gls, bool flip);
diff --git a/include/ui/surface.h b/include/ui/surface.h
index f16f7be8be8..d2542d3ace5 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -8,7 +8,6 @@
 #include "ui/qemu-pixman.h"
 
 #ifdef CONFIG_OPENGL
-# include <epoxy/gl.h>
 # include "ui/shader.h"
 #endif
 
@@ -19,9 +18,7 @@ typedef struct DisplaySurface {
     pixman_image_t *image;
     uint8_t flags;
 #ifdef CONFIG_OPENGL
-    GLenum glformat;
-    GLenum gltype;
-    GLuint texture;
+    uint32_t texture;
 #endif
     qemu_pixman_shareable share_handle;
     uint32_t share_handle_offset;
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 73be35c1fc7..d4b9017b53d 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include <epoxy/gl.h>
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/shader.h"
@@ -66,6 +67,9 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface)
 {
+    GLenum glformat;
+    GLenum gltype;
+
     assert(gls);
     assert(QEMU_IS_ALIGNED(surface_stride(surface), surface_bytes_per_pixel(surface)));
 
@@ -73,7 +77,7 @@ void surface_gl_create_texture(QemuGLShader *gls,
         return;
     }
 
-    assert(map_format(surface_format(surface), &surface->glformat, &surface->gltype));
+    assert(map_format(surface_format(surface), &glformat, &gltype));
     glGenTextures(1, &surface->texture);
     glEnable(GL_TEXTURE_2D);
     glBindTexture(GL_TEXTURE_2D, surface->texture);
@@ -81,16 +85,12 @@ void surface_gl_create_texture(QemuGLShader *gls,
                   surface_stride(surface) / surface_bytes_per_pixel(surface));
     if (epoxy_is_desktop_gl()) {
         glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB,
-                     surface_width(surface),
-                     surface_height(surface),
-                     0, surface->glformat, surface->gltype,
-                     surface_data(surface));
+                     surface_width(surface), surface_height(surface), 0,
+                     glformat, gltype, surface_data(surface));
     } else {
-        glTexImage2D(GL_TEXTURE_2D, 0, surface->glformat,
-                     surface_width(surface),
-                     surface_height(surface),
-                     0, surface->glformat, surface->gltype,
-                     surface_data(surface));
+        glTexImage2D(GL_TEXTURE_2D, 0, glformat,
+                     surface_width(surface), surface_height(surface), 0,
+                     glformat, gltype, surface_data(surface));
         glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_SWIZZLE_A, GL_ONE);
     }
 
@@ -150,17 +150,18 @@ void surface_gl_update_texture(QemuGLShader *gls,
                                int x, int y, int w, int h)
 {
     uint8_t *data = (void *)surface_data(surface);
+    GLenum glformat;
+    GLenum gltype;
 
     assert(gls);
+    assert(map_format(surface_format(surface), &glformat, &gltype));
 
     if (surface->texture) {
         glBindTexture(GL_TEXTURE_2D, surface->texture);
         glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
                       surface_stride(surface)
                       / surface_bytes_per_pixel(surface));
-        glTexSubImage2D(GL_TEXTURE_2D, 0,
-                        x, y, w, h,
-                        surface->glformat, surface->gltype,
+        glTexSubImage2D(GL_TEXTURE_2D, 0, x, y, w, h, glformat, gltype,
                         data + surface_stride(surface) * y
                         + surface_bytes_per_pixel(surface) * x);
     }
diff --git a/ui/shader.c b/ui/shader.c
index ab448c41d4c..76ee4c32785 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include <epoxy/gl.h>
 #include "ui/shader.h"
 
 #include "ui/shader/texture-blit-vert.h"
-- 
2.53.0


