Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F49C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9SK-0006ju-4q; Mon, 03 Jun 2024 11:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sE9SJ-0006jA-0l
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sE9SH-0005rR-AV
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717427915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8kzX9DrYOhcqIvJMNJmWCuMKiFj8etOtZj3EnRy0I8=;
 b=jEij77NljRtk9MaRyBMqu88wmKToxvkls4ykpQvnqdKwfZtcYDs4zhNUUUHB6tBIDSUFom
 JbZA1kVpguKgQxkV+6YXfMTY+Auh+GMeZqkwrG9v1jqFcaDyrqakdcWVWg80TCVldbX9hE
 wKpvtKdT2oqULjkR0m99pp3cN9lNJlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-On8TU32lNrWFK8D0XWJUxg-1; Mon, 03 Jun 2024 11:18:30 -0400
X-MC-Unique: On8TU32lNrWFK8D0XWJUxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDB9D85A58C;
 Mon,  3 Jun 2024 15:18:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BC29C15C05;
 Mon,  3 Jun 2024 15:18:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2456C1801F28; Mon,  3 Jun 2024 17:18:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH v2 2/3] ui+display: rename is_buffer_shared() ->
 surface_is_borrowed()
Date: Mon,  3 Jun 2024 17:18:24 +0200
Message-ID: <20240603151825.188353-3-kraxel@redhat.com>
In-Reply-To: <20240603151825.188353-1-kraxel@redhat.com>
References: <20240603151825.188353-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

No functional change.

Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/surface.h    |  2 +-
 hw/display/qxl-render.c |  2 +-
 hw/display/vga.c        | 10 +++++-----
 hw/display/xenfb.c      |  4 ++--
 ui/console.c            |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index 4244e0ca4a32..96f9b1611c1c 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -45,7 +45,7 @@ void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
 DisplaySurface *qemu_create_displaysurface(int width, int height);
 void qemu_free_displaysurface(DisplaySurface *surface);
 
-static inline int is_buffer_shared(DisplaySurface *surface)
+static inline int surface_is_borrowed(DisplaySurface *surface)
 {
     return !(surface->flags & QEMU_ALLOCATED_FLAG);
 }
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index ec99ec887a6e..bfdf2c59bdbe 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -31,7 +31,7 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
     uint8_t *src;
     int len, i;
 
-    if (is_buffer_shared(surface)) {
+    if (surface_is_borrowed(surface)) {
         return;
     }
     trace_qxl_render_blit(qxl->guest_primary.qxl_stride,
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 474b6b14c327..bd800a683e45 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1620,7 +1620,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         height != s->last_height ||
         s->last_depth != depth ||
         s->last_byteswap != byteswap ||
-        share_surface != is_buffer_shared(surface)) {
+        share_surface != surface_is_borrowed(surface)) {
         /* display parameters changed -> need new display surface */
         s->last_scr_width = disp_width;
         s->last_scr_height = height;
@@ -1635,7 +1635,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         full_update = 1;
     }
     if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
-        && is_buffer_shared(surface)) {
+        && surface_is_borrowed(surface)) {
         /* base address changed (page flip) -> shared display surfaces
          * must be updated with the new base address */
         full_update = 1;
@@ -1655,7 +1655,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     vga_draw_line = vga_draw_line_table[v];
 
-    if (!is_buffer_shared(surface) && s->cursor_invalidate) {
+    if (!surface_is_borrowed(surface) && s->cursor_invalidate) {
         s->cursor_invalidate(s);
     }
 
@@ -1707,7 +1707,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         if (update) {
             if (y_start < 0)
                 y_start = y;
-            if (!(is_buffer_shared(surface))) {
+            if (!(surface_is_borrowed(surface))) {
                 uint8_t *p;
                 p = vga_draw_line(s, d, addr, width, hpel);
                 if (p) {
@@ -1762,7 +1762,7 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
     if (s->last_scr_width <= 0 || s->last_scr_height <= 0)
         return;
 
-    if (is_buffer_shared(surface)) {
+    if (surface_is_borrowed(surface)) {
         /* unshare buffer, otherwise the blanking corrupts vga vram */
         surface = qemu_create_displaysurface(s->last_scr_width, s->last_scr_height);
         dpy_gfx_replace_surface(s->con, surface);
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 27536bfce0cb..a9bc5a08cdc2 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -637,7 +637,7 @@ static void xenfb_guest_copy(struct XenFB *xenfb, int x, int y, int w, int h)
     int linesize = surface_stride(surface);
     uint8_t *data = surface_data(surface);
 
-    if (!is_buffer_shared(surface)) {
+    if (!surface_is_borrowed(surface)) {
         switch (xenfb->depth) {
         case 8:
             if (bpp == 16) {
@@ -755,7 +755,7 @@ static void xenfb_update(void *opaque)
         xen_pv_printf(&xenfb->c.xendev, 1,
                       "update: resizing: %dx%d @ %d bpp%s\n",
                       xenfb->width, xenfb->height, xenfb->depth,
-                      is_buffer_shared(surface) ? " (shared)" : "");
+                      surface_is_borrowed(surface) ? " (borrowed)" : "");
         xenfb->up_fullscreen = 1;
     }
 
diff --git a/ui/console.c b/ui/console.c
index 1b2cd0c7365d..d7967ddb0d1a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1510,7 +1510,7 @@ void qemu_console_resize(QemuConsole *s, int width, int height)
     assert(QEMU_IS_GRAPHIC_CONSOLE(s));
 
     if ((s->scanout.kind != SCANOUT_SURFACE ||
-         (surface && !is_buffer_shared(surface) && !is_placeholder(surface))) &&
+         (surface && !surface_is_borrowed(surface) && !is_placeholder(surface))) &&
         qemu_console_get_width(s, -1) == width &&
         qemu_console_get_height(s, -1) == height) {
         return;
-- 
2.45.1


