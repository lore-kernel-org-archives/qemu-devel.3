Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264C5FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHk2V-00021O-0u; Tue, 28 Apr 2026 11:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2Q-00020e-2k
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHk2N-0000aX-PV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777388866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/Xm9LflU3SgsoDBnOsWibNxJZvmoY9IP/DgB7vXa18=;
 b=aur0xz+5YKtdUa0+3ybgtUN8Px3FiQd1mRfYOEMG1MSGz1kFyV9rc/FHtbVkuWlQfFdF9L
 Iwptj1+Z5SSUmeohWH5dCnwn4p/3raRNrbtxKfnAYsLK0HDEaX0tf8i8m92lBZB76Lctcj
 qOzm1ox1XNwipFhw3pdZfeLdEN5We8w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-IZI9QCPtOH2Tv8A5W6faWg-1; Tue,
 28 Apr 2026 11:07:44 -0400
X-MC-Unique: IZI9QCPtOH2Tv8A5W6faWg-1
X-Mimecast-MFC-AGG-ID: IZI9QCPtOH2Tv8A5W6faWg_1777388863
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5DDE19560AF; Tue, 28 Apr 2026 15:07:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34B5C1943295; Tue, 28 Apr 2026 15:07:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 02/15] ui: move DisplaySurface functions to display-surface.c
Date: Tue, 28 Apr 2026 19:07:12 +0400
Message-ID: <20260428150726.1659814-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
References: <20260428150726.1659814-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Extract DisplaySurface creation and destruction functions from console.c
into their own file to reduce the size of console.c and improve code
organization.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c         |  96 --------------------------------------
 ui/display-surface.c | 107 +++++++++++++++++++++++++++++++++++++++++++
 ui/meson.build       |   1 +
 3 files changed, 108 insertions(+), 96 deletions(-)
 create mode 100644 ui/display-surface.c

diff --git a/ui/console.c b/ui/console.c
index 9606da7b1a6..475a72aa08f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -505,102 +505,6 @@ qemu_graphic_console_init(Object *obj)
 {
 }
 
-void qemu_displaysurface_set_share_handle(DisplaySurface *surface,
-                                          qemu_pixman_shareable handle,
-                                          uint32_t offset)
-{
-    assert(surface->share_handle == SHAREABLE_NONE);
-
-    surface->share_handle = handle;
-    surface->share_handle_offset = offset;
-
-}
-
-DisplaySurface *qemu_create_displaysurface(int width, int height)
-{
-    trace_displaysurface_create(width, height);
-
-    return qemu_create_displaysurface_from(
-        width, height,
-        PIXMAN_x8r8g8b8,
-        width * 4, NULL
-    );
-}
-
-DisplaySurface *qemu_create_displaysurface_from(int width, int height,
-                                                pixman_format_code_t format,
-                                                int linesize, uint8_t *data)
-{
-    DisplaySurface *surface = g_new0(DisplaySurface, 1);
-
-    trace_displaysurface_create_from(surface, width, height, format);
-    surface->share_handle = SHAREABLE_NONE;
-
-    if (data) {
-        surface->image = pixman_image_create_bits(format,
-                                                  width, height,
-                                                  (void *)data, linesize);
-    } else {
-        qemu_pixman_image_new_shareable(&surface->image,
-                                        &surface->share_handle,
-                                        "displaysurface",
-                                        format,
-                                        width,
-                                        height,
-                                        linesize,
-                                        &error_abort);
-        surface->flags = QEMU_ALLOCATED_FLAG;
-    }
-
-    assert(surface->image != NULL);
-    return surface;
-}
-
-DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
-{
-    DisplaySurface *surface = g_new0(DisplaySurface, 1);
-
-    trace_displaysurface_create_pixman(surface);
-    surface->share_handle = SHAREABLE_NONE;
-    surface->image = pixman_image_ref(image);
-
-    return surface;
-}
-
-DisplaySurface *qemu_create_placeholder_surface(int w, int h,
-                                                const char *msg)
-{
-    DisplaySurface *surface = qemu_create_displaysurface(w, h);
-#ifdef CONFIG_PIXMAN
-    pixman_color_t bg = QEMU_PIXMAN_COLOR_BLACK;
-    pixman_color_t fg = QEMU_PIXMAN_COLOR_GRAY;
-    pixman_image_t *glyph;
-    int len, x, y, i;
-
-    len = strlen(msg);
-    x = (w / FONT_WIDTH  - len) / 2;
-    y = (h / FONT_HEIGHT - 1)   / 2;
-    for (i = 0; i < len; i++) {
-        glyph = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, msg[i]);
-        qemu_pixman_glyph_render(glyph, surface->image, &fg, &bg,
-                                 x+i, y, FONT_WIDTH, FONT_HEIGHT);
-        qemu_pixman_image_unref(glyph);
-    }
-#endif
-    surface->flags |= QEMU_PLACEHOLDER_FLAG;
-    return surface;
-}
-
-void qemu_free_displaysurface(DisplaySurface *surface)
-{
-    if (surface == NULL) {
-        return;
-    }
-    trace_displaysurface_free(surface);
-    qemu_pixman_image_unref(surface->image);
-    g_free(surface);
-}
-
 bool console_has_gl(QemuConsole *con)
 {
     return con->gl != NULL;
diff --git a/ui/display-surface.c b/ui/display-surface.c
new file mode 100644
index 00000000000..38e408513cc
--- /dev/null
+++ b/ui/display-surface.c
@@ -0,0 +1,107 @@
+/*
+ * QEMU graphical console surface helper
+ *
+ * Copyright (c) 2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+#include "qemu/osdep.h"
+#include "ui/console.h"
+#include "ui/vgafont.h"
+#include "trace.h"
+
+void qemu_displaysurface_set_share_handle(DisplaySurface *surface,
+                                          qemu_pixman_shareable handle,
+                                          uint32_t offset)
+{
+    assert(surface->share_handle == SHAREABLE_NONE);
+
+    surface->share_handle = handle;
+    surface->share_handle_offset = offset;
+
+}
+
+DisplaySurface *qemu_create_displaysurface(int width, int height)
+{
+    trace_displaysurface_create(width, height);
+
+    return qemu_create_displaysurface_from(
+        width, height,
+        PIXMAN_x8r8g8b8,
+        width * 4, NULL
+    );
+}
+
+DisplaySurface *qemu_create_displaysurface_from(int width, int height,
+                                                pixman_format_code_t format,
+                                                int linesize, uint8_t *data)
+{
+    DisplaySurface *surface = g_new0(DisplaySurface, 1);
+
+    trace_displaysurface_create_from(surface, width, height, format);
+    surface->share_handle = SHAREABLE_NONE;
+
+    if (data) {
+        surface->image = pixman_image_create_bits(format,
+                                                  width, height,
+                                                  (void *)data, linesize);
+    } else {
+        qemu_pixman_image_new_shareable(&surface->image,
+                                        &surface->share_handle,
+                                        "displaysurface",
+                                        format,
+                                        width,
+                                        height,
+                                        linesize,
+                                        &error_abort);
+        surface->flags = QEMU_ALLOCATED_FLAG;
+    }
+
+    assert(surface->image != NULL);
+    return surface;
+}
+
+DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
+{
+    DisplaySurface *surface = g_new0(DisplaySurface, 1);
+
+    trace_displaysurface_create_pixman(surface);
+    surface->share_handle = SHAREABLE_NONE;
+    surface->image = pixman_image_ref(image);
+
+    return surface;
+}
+
+DisplaySurface *qemu_create_placeholder_surface(int w, int h,
+                                                const char *msg)
+{
+    DisplaySurface *surface = qemu_create_displaysurface(w, h);
+#ifdef CONFIG_PIXMAN
+    pixman_color_t bg = QEMU_PIXMAN_COLOR_BLACK;
+    pixman_color_t fg = QEMU_PIXMAN_COLOR_GRAY;
+    pixman_image_t *glyph;
+    int len, x, y, i;
+
+    len = strlen(msg);
+    x = (w / FONT_WIDTH  - len) / 2;
+    y = (h / FONT_HEIGHT - 1)   / 2;
+    for (i = 0; i < len; i++) {
+        glyph = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, msg[i]);
+        qemu_pixman_glyph_render(glyph, surface->image, &fg, &bg,
+                                 x + i, y, FONT_WIDTH, FONT_HEIGHT);
+        qemu_pixman_image_unref(glyph);
+    }
+#endif
+    surface->flags |= QEMU_PLACEHOLDER_FLAG;
+    return surface;
+}
+
+void qemu_free_displaysurface(DisplaySurface *surface)
+{
+    if (surface == NULL) {
+        return;
+    }
+    trace_displaysurface_free(surface);
+    qemu_pixman_image_unref(surface->image);
+    g_free(surface);
+}
diff --git a/ui/meson.build b/ui/meson.build
index 4e533d30460..3d15ff96287 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -4,6 +4,7 @@ system_ss.add(files(
   'clipboard.c',
   'console.c',
   'cursor.c',
+  'display-surface.c',
   'dmabuf.c',
   'input-keymap.c',
   'input-legacy.c',
-- 
2.54.0


