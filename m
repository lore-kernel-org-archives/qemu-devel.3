Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9787C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 13:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEqTj-0008GN-Kd; Wed, 05 Jun 2024 09:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEqTh-0008FL-4C
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sEqTe-0006EC-4l
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 09:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717593292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVLB8maweI2YBdW9cqwpRepDTGxsDFjVZsXbEwlXhJ4=;
 b=CTX0Cg2Q+g1JgdQlygjljBqFICqZRCAMwiK/+Z7AnVsQDwjoMSF/ySI+yOz4jMGrow6waw
 7tKugUF4LeYbjepI1GK+CYGnug6JeZ7ax3+oCc2+g2U5I94G6bRngdpEs2mL/O04DemDkj
 l1O+RVn98KZBFV974OMUs8xigIbdfzs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-tXfqlkJlNb2AyTUOjfHNLw-1; Wed,
 05 Jun 2024 09:14:50 -0400
X-MC-Unique: tXfqlkJlNb2AyTUOjfHNLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 756BE1C05122;
 Wed,  5 Jun 2024 13:14:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F38F937D1;
 Wed,  5 Jun 2024 13:14:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 713EA1800DDB; Wed,  5 Jun 2024 15:14:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Gerd Hoffmann <kraxel@redhat.com>, Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH v3 3/3] ui+display: rename is_buffer_shared() ->
 surface_is_allocated()
Date: Wed,  5 Jun 2024 15:14:43 +0200
Message-ID: <20240605131444.797896-4-kraxel@redhat.com>
In-Reply-To: <20240605131444.797896-1-kraxel@redhat.com>
References: <20240605131444.797896-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

Boolean return value is reversed, to align with QEMU_ALLOCATED_FLAG, so
all callers must be adapted.  Also rename share_surface variable in
vga_draw_graphic() to reduce confusion.

No functional change.

Suggested-by: Marc-André Lureau <marcandre.lureau@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/ui/surface.h    |  4 ++--
 hw/display/qxl-render.c |  2 +-
 hw/display/vga.c        | 20 ++++++++++----------
 hw/display/xenfb.c      |  5 +++--
 ui/console.c            |  3 ++-
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index 273bb4769a02..345b19169d2e 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -45,9 +45,9 @@ void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
 DisplaySurface *qemu_create_displaysurface(int width, int height);
 void qemu_free_displaysurface(DisplaySurface *surface);
 
-static inline int is_buffer_shared(DisplaySurface *surface)
+static inline int surface_is_allocated(DisplaySurface *surface)
 {
-    return !(surface->flags & QEMU_ALLOCATED_FLAG);
+    return surface->flags & QEMU_ALLOCATED_FLAG;
 }
 
 static inline int surface_is_placeholder(DisplaySurface *surface)
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index ec99ec887a6e..8daae72c8d04 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -31,7 +31,7 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
     uint8_t *src;
     int len, i;
 
-    if (is_buffer_shared(surface)) {
+    if (!surface_is_allocated(surface)) {
         return;
     }
     trace_qxl_render_blit(qxl->guest_primary.qxl_stride,
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 474b6b14c327..0ed933596584 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1487,7 +1487,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     uint8_t *d;
     uint32_t v, addr1, addr;
     vga_draw_line_func *vga_draw_line = NULL;
-    bool share_surface, force_shadow = false;
+    bool allocate_surface, force_shadow = false;
     pixman_format_code_t format;
 #if HOST_BIG_ENDIAN
     bool byteswap = !s->big_endian_fb;
@@ -1609,10 +1609,10 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
      */
     format = qemu_default_pixman_format(depth, !byteswap);
     if (format) {
-        share_surface = dpy_gfx_check_format(s->con, format)
-            && !s->force_shadow && !force_shadow;
+        allocate_surface = !dpy_gfx_check_format(s->con, format)
+            || s->force_shadow || force_shadow;
     } else {
-        share_surface = false;
+        allocate_surface = true;
     }
 
     if (s->params.line_offset != s->last_line_offset ||
@@ -1620,7 +1620,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         height != s->last_height ||
         s->last_depth != depth ||
         s->last_byteswap != byteswap ||
-        share_surface != is_buffer_shared(surface)) {
+        allocate_surface != surface_is_allocated(surface)) {
         /* display parameters changed -> need new display surface */
         s->last_scr_width = disp_width;
         s->last_scr_height = height;
@@ -1635,14 +1635,14 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         full_update = 1;
     }
     if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
-        && is_buffer_shared(surface)) {
+        && !surface_is_allocated(surface)) {
         /* base address changed (page flip) -> shared display surfaces
          * must be updated with the new base address */
         full_update = 1;
     }
 
     if (full_update) {
-        if (share_surface) {
+        if (!allocate_surface) {
             surface = qemu_create_displaysurface_from(disp_width,
                     height, format, s->params.line_offset,
                     s->vram_ptr + (s->params.start_addr * 4));
@@ -1655,7 +1655,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 
     vga_draw_line = vga_draw_line_table[v];
 
-    if (!is_buffer_shared(surface) && s->cursor_invalidate) {
+    if (surface_is_allocated(surface) && s->cursor_invalidate) {
         s->cursor_invalidate(s);
     }
 
@@ -1707,7 +1707,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         if (update) {
             if (y_start < 0)
                 y_start = y;
-            if (!(is_buffer_shared(surface))) {
+            if (surface_is_allocated(surface)) {
                 uint8_t *p;
                 p = vga_draw_line(s, d, addr, width, hpel);
                 if (p) {
@@ -1762,7 +1762,7 @@ static void vga_draw_blank(VGACommonState *s, int full_update)
     if (s->last_scr_width <= 0 || s->last_scr_height <= 0)
         return;
 
-    if (is_buffer_shared(surface)) {
+    if (!surface_is_allocated(surface)) {
         /* unshare buffer, otherwise the blanking corrupts vga vram */
         surface = qemu_create_displaysurface(s->last_scr_width, s->last_scr_height);
         dpy_gfx_replace_surface(s->con, surface);
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 27536bfce0cb..06f84ed39d64 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -637,7 +637,7 @@ static void xenfb_guest_copy(struct XenFB *xenfb, int x, int y, int w, int h)
     int linesize = surface_stride(surface);
     uint8_t *data = surface_data(surface);
 
-    if (!is_buffer_shared(surface)) {
+    if (surface_is_allocated(surface)) {
         switch (xenfb->depth) {
         case 8:
             if (bpp == 16) {
@@ -755,7 +755,8 @@ static void xenfb_update(void *opaque)
         xen_pv_printf(&xenfb->c.xendev, 1,
                       "update: resizing: %dx%d @ %d bpp%s\n",
                       xenfb->width, xenfb->height, xenfb->depth,
-                      is_buffer_shared(surface) ? " (shared)" : "");
+                      surface_is_allocated(surface)
+                      ? " (allocated)" : " (borrowed)");
         xenfb->up_fullscreen = 1;
     }
 
diff --git a/ui/console.c b/ui/console.c
index c2173fc0b1e5..1a7eb7fe8e8c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1510,7 +1510,8 @@ void qemu_console_resize(QemuConsole *s, int width, int height)
     assert(QEMU_IS_GRAPHIC_CONSOLE(s));
 
     if ((s->scanout.kind != SCANOUT_SURFACE ||
-         (surface && !is_buffer_shared(surface) && !surface_is_placeholder(surface))) &&
+         (surface && surface_is_allocated(surface) &&
+          !surface_is_placeholder(surface))) &&
         qemu_console_get_width(s, -1) == width &&
         qemu_console_get_height(s, -1) == height) {
         return;
-- 
2.45.1


