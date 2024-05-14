Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05845C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s33-0005Dm-2a; Tue, 14 May 2024 09:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2r-0004mG-R9
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2n-0002Mg-St
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715692693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ja/8CcGWzEA2LvmI/FXjMkaeuhb0Up64DQcr8MGG3Qo=;
 b=bY1S3s1c6CJClgMpYvZnD7CaZzEovDWRJsujFfRkG/1AtMas3VSzEP/9Qv6/aiIcPwGKPw
 oBz2cOuiMj9+kjPtUNE3ppf66lJ6u3ZKjoDMCchgmC3uHFWuzVF5ospcN154EfoUWieEoE
 4FzaftlvOZZc9JCYiyacUqPZuHoeneY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-BH5IEWSOPDSE8Ophjkrrwg-1; Tue,
 14 May 2024 09:17:57 -0400
X-MC-Unique: BH5IEWSOPDSE8Ophjkrrwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6550429AA2CD;
 Tue, 14 May 2024 13:17:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E34A3103A3AA;
 Tue, 14 May 2024 13:17:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/11] ui/console: Use qemu_dmabuf_set_..() helpers instead
Date: Tue, 14 May 2024 17:17:20 +0400
Message-ID: <20240514131725.931234-7-marcandre.lureau@redhat.com>
In-Reply-To: <20240514131725.931234-1-marcandre.lureau@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

This commit updates all occurrences where these fields were
set directly have been updated to utilize helper functions.

v7: removed prefix, "dpy_gl_" from all helpers

v8: Introduction of helpers was removed as those were already added
    by the previous commit

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20240508175403.3399895-5-dongwon.kim@intel.com>
---
 ui/egl-helpers.c | 16 +++++++++-------
 ui/gtk-egl.c     |  4 ++--
 ui/gtk-gl-area.c |  4 ++--
 ui/gtk.c         |  6 +++---
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 3f96e63d25..99b2ebbe23 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -348,8 +348,8 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
         return;
     }
 
-    glGenTextures(1, &dmabuf->texture);
-    texture = qemu_dmabuf_get_texture(dmabuf);
+    glGenTextures(1, &texture);
+    qemu_dmabuf_set_texture(dmabuf, texture);
     glBindTexture(GL_TEXTURE_2D, texture);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
@@ -368,7 +368,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
     }
 
     glDeleteTextures(1, &texture);
-    dmabuf->texture = 0;
+    qemu_dmabuf_set_texture(dmabuf, 0);
 }
 
 void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
@@ -382,7 +382,7 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
         sync = eglCreateSyncKHR(qemu_egl_display,
                                 EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
         if (sync != EGL_NO_SYNC_KHR) {
-            dmabuf->sync = sync;
+            qemu_dmabuf_set_sync(dmabuf, sync);
         }
     }
 }
@@ -390,12 +390,14 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
 void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
 {
     void *sync = qemu_dmabuf_get_sync(dmabuf);
+    int fence_fd;
 
     if (sync) {
-        dmabuf->fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
-                                                      sync);
+        fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
+                                              sync);
+        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
         eglDestroySyncKHR(qemu_egl_display, sync);
-        dmabuf->sync = NULL;
+        qemu_dmabuf_set_sync(dmabuf, NULL);
     }
 }
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 5d7744ae4d..0473f689c9 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -87,7 +87,7 @@ void gd_egl_draw(VirtualConsole *vc)
             if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
-                dmabuf->draw_submitted = false;
+                qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
         }
 #endif
@@ -382,7 +382,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_egl_set_scanout_mode(vc, true);
         gtk_widget_queue_draw_area(area, x, y, w, h);
         return;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 86360fe79b..b628b35451 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -63,7 +63,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
             if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
-                dmabuf->draw_submitted = false;
+                qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
         }
 #endif
@@ -292,7 +292,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_gl_area_set_scanout_mode(vc, true);
     }
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
diff --git a/ui/gtk.c b/ui/gtk.c
index 237c913b26..3a6832eb1b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -598,11 +598,11 @@ void gd_hw_gl_flushed(void *vcon)
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
     int fence_fd;
 
-    if (dmabuf->fence_fd >= 0) {
-        fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+    fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+    if (fence_fd >= 0) {
         qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
         close(fence_fd);
-        dmabuf->fence_fd = -1;
+        qemu_dmabuf_set_fence_fd(dmabuf, -1);
         graphic_hw_gl_block(vc->gfx.dcl.con, false);
     }
 }
-- 
2.41.0.28.gd7d8841f67


