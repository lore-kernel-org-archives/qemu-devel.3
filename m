Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1908F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHR5-0004qT-BY; Fri, 10 Apr 2026 15:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHR4-0004qF-HZ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHR2-0001w8-EM
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LNuPoQo1Zb1a/2wcDI/iPeJu3JZHwmOC/OpCwhaFTQ=;
 b=L8Mn3QbVrMBopm7lAwWYT/Ypg1hU/ErKTCDV5LSyAg/3FingizjGTG3zRwgKDe/8DFfV2E
 7qnSsnGaP/1tjxU2493Okd4Zt1FCnxfa4nQM4E3Jzj+Zvogu5MMeYVaXCvRgxW7kvmgkXL
 Ll2sV8h8TWS6zQSS9YPcUsjaVzMhDAg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-R2EfsumIOjOSDrNkEd6olQ-1; Fri,
 10 Apr 2026 15:22:28 -0400
X-MC-Unique: R2EfsumIOjOSDrNkEd6olQ-1
X-Mimecast-MFC-AGG-ID: R2EfsumIOjOSDrNkEd6olQ_1775848947
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD981195608F; Fri, 10 Apr 2026 19:22:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9E753000C16; Fri, 10 Apr 2026 19:22:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:57 +0400
Subject: [PATCH v2 35/67] ui: move DisplaySurface functions to
 display-surface.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-35-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8074;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ip6J6xhBFa1TM9CJ2RiUKz+3a5NwlbQbCiticjMAo+4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VulXShd3rujT5uudBvVvm2e0/8h788nd6D
 iZ/oBTI4xuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5bgNEAC0C0YF6YMTJvLQqXbIEdYKE0ucWlk76Z1TualYN+GLQ+aHEOBeyWiwdDlRqCM+bYQQB0m
 47c1EdaZnTFzekLdYp7NHyG2gxDb+wQtsycZht+4DtNISwYzcp/hA09bz9o4vwOm7qxAoq1wLdS
 a1RuJ1Rgi25i67t3ld/Cnwuc+BWmcF/xwRrTr3YvccQyrfgu4kYvO2V589biTFVrYdt1zFQEnlo
 3w4vDeLeUi7bpqwhHpYKd8CGryMzEPBBmSO9lrHsRepgL5xHg33xW+QVShSrWR4hNvh+lyUqt9G
 iAqfc8DNU1EB0kWUYjV6n6W+NUM6IAPGTkny6ANCCFFEYgnZ9xdM+MrMncx2FJRZ0AC45isaRpR
 G/ttn+liX6JTyqNkiGIyyX8jPeDxUBU8uG042w3C1mGbmCAJEXPNYK2iJldxTi0KHkHqkSutXVB
 nup+ySJ4+c2XxzlfIkYpFOedjtXgz3b2IGJfBbuGiNzfkqebH+uZ/bX4hLEFSXjWN4ANmyKcuVH
 mcKUjCsKRReOmX8REM48RyekGnjXc1xdvC6UWvZ1U0QK3jOJ+9MgOQLZQQA7HugPepU6N8PGJ7C
 ABaxoCUZleW9jAB3kwRzdz7fmZEy1r4ZSZfIGmwHaf7ijOwz4It/ORbHEKe94e7XI4Ei07m6uvl
 x7BhcudVKurSxwA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Extract DisplaySurface creation and destruction functions from console.c
into their own file to reduce the size of console.c and improve code
organization.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c         |  96 ---------------------------------------------
 ui/display-surface.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++
 ui/meson.build       |   1 +
 3 files changed, 108 insertions(+), 96 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 7ffea2776ef..24794e5a9dc 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -507,102 +507,6 @@ qemu_graphic_console_init(Object *obj)
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
index 9ece6f262b6..bae6ea0d2dc 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -5,6 +5,7 @@ system_ss.add(files(
   'console.c',
   'cp437.c',
   'cursor.c',
+  'display-surface.c',
   'dmabuf.c',
   'input-keymap.c',
   'input-legacy.c',

-- 
2.53.0


