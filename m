Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE70CC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kJX-0004G5-I1; Wed, 16 Sep 2026 03:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJQ-0004Db-1t; Wed, 16 Sep 2026 03:44:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJN-0004tL-TC; Wed, 16 Sep 2026 03:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=p3ChUbqMH9myXP1ZNjKg/IYxjgkmlZU6nrNOxJMADV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rXXIkPURAStvZiAh0nahm7kYSfc/juJjGG8KkEZ33Ov0BZqQ11wiiWJPhNoA10KV+
 CKFoqtDiwVKrGYrjdRJ7dQrgQ9NVewcjO39TW2z4RX9mB8MlH3dS9PYiaSDbMKzICU
 10/VVi6be47dqQOnnRVrQaZZ5fnXPimkTEHfS8uu9hcEU4LJh5JWJ1pzDCbcfbog+P
 5eUAhCw0+Z5mI1OWByxl8GjHAJDlc57bI3FoaeJQcrpyOvOBWb0X0xsmMqgkkuS7+s
 879GLX+YvYA8xpHz57dIhTy8sF5oydnXSjtdpE8uYAqML3dI6MTN8FRrPb59tEY52k
 j50ItaIe6huOA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F9D41D558C;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9329C429B1E;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8E5435A6C3; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 01/49] hw/display/qxl: validate primary surface
 stride against width
Date: Wed, 16 Sep 2026 10:42:19 +0300
Message-ID: <20260916074346.671467-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

The existing validation in qxl_create_guest_primary() checks that
abs(stride) * height fits in vgamem_size and that stride is 4-byte
aligned, but never checks that abs(stride) is large enough to hold one
row of pixels for the declared width and format.

A malicious guest can create a primary surface with a stride much
smaller than width * bytes_per_pixel (e.g. stride=4 for a 64-wide 32bpp
surface). The spice server rejects this via red_validate_surface(), but
the return is void and QEMU unconditionally proceeds to set up the local
rendering state. On the next display refresh, VNC or SDL reads width *
bytes_pp per scanline from a region backed by only stride bytes per
row, causing a host-side out-of-bounds read.

Add three checks in qxl_create_guest_primary() before creating the
surface:
 - reject unknown surface formats
 - reject zero width or height
 - reject surfaces where abs(stride) < width * bytes_per_pixel

Also fix three related issues in qxl-render.c:
 - qxl_blit() used abs_stride to advance the dst pointer into the
   DisplaySurface, but when stride is negative the DisplaySurface is a
   packed buffer whose stride may be smaller. Use surface_stride()
   instead.
 - qxl_render_update_area_unlocked() uses guest_head0_width (set via
   QXL_IO_MONITORS_CONFIG_ASYNC) without validating it against
   abs_stride, bypassing the new validation. Clamp the effective width
   to abs_stride / bytes_pp to prevent out-of-bounds access while
   tolerating the normal transient where the monitor config arrives
   before the primary surface is resized to match.
 - Similarly, guest_head0_height bypasses qxl_create_guest_primary()
   validation. Without clamping, abs_stride * height can overrun
   vgamem_size, and the product can also overflow 32 bits (e.g.
   abs_stride=16 MiB, height=256 wraps to zero), defeating the
   qxl_phys2virt() bounds check. Clamp height to
   vgamem_size / abs_stride to prevent both.

While touch it, fix some endianness issues.

Fixes: CVE-2026-16271
Fixes: a19cbfb34642 ("spice: add qxl device")
Fixes: 979f7ef8966b ("qxl: use guest_monitor_config for local renderer.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3637
Reported-by: huntr bubble
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260806094028.640676-1-marcandre.lureau@redhat.com>
(cherry picked from commit ab7183ed4eecb4727532e3ffe5953d127e102c72)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index cf0f6849cd0..f2bc25f03ad 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -27,6 +27,7 @@
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
 {
     DisplaySurface *surface = qemu_console_surface(qxl->vga.con);
+    int dst_stride = surface_stride(surface);
     uint8_t *dst = surface_data(surface);
     uint8_t *src;
     int len, i;
@@ -45,14 +46,14 @@ static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
     } else {
         src += rect->top * qxl->guest_primary.abs_stride;
     }
-    dst += rect->top  * qxl->guest_primary.abs_stride;
+    dst += rect->top  * dst_stride;
     src += rect->left * qxl->guest_primary.bytes_pp;
     dst += rect->left * qxl->guest_primary.bytes_pp;
     len  = (rect->right - rect->left) * qxl->guest_primary.bytes_pp;
 
     for (i = rect->top; i < rect->bottom; i++) {
         memcpy(dst, src, len);
-        dst += qxl->guest_primary.abs_stride;
+        dst += dst_stride;
         src += qxl->guest_primary.qxl_stride;
     }
 }
@@ -61,30 +62,13 @@ void qxl_render_resize(PCIQXLDevice *qxl)
 {
     QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
 
-    qxl->guest_primary.qxl_stride = sc->stride;
-    qxl->guest_primary.abs_stride = abs(sc->stride);
+    qxl->guest_primary.qxl_stride = le32_to_cpu(sc->stride);
+    qxl->guest_primary.abs_stride = abs(qxl->guest_primary.qxl_stride);
     qxl->guest_primary.resized++;
-    switch (sc->format) {
-    case SPICE_SURFACE_FMT_16_555:
-        qxl->guest_primary.bytes_pp = 2;
-        qxl->guest_primary.bits_pp = 15;
-        break;
-    case SPICE_SURFACE_FMT_16_565:
-        qxl->guest_primary.bytes_pp = 2;
-        qxl->guest_primary.bits_pp = 16;
-        break;
-    case SPICE_SURFACE_FMT_32_xRGB:
-    case SPICE_SURFACE_FMT_32_ARGB:
-        qxl->guest_primary.bytes_pp = 4;
-        qxl->guest_primary.bits_pp = 32;
-        break;
-    default:
-        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
-                qxl->guest_primary.surface.format);
-        qxl->guest_primary.bytes_pp = 4;
-        qxl->guest_primary.bits_pp = 32;
-        break;
-    }
+    /* fallback to default bpp if format is unknown */
+    qxl_format_bpp(qxl, le32_to_cpu(sc->format),
+                   &qxl->guest_primary.bytes_pp,
+                   &qxl->guest_primary.bits_pp);
 }
 
 static void qxl_set_rect_to_surface(PCIQXLDevice *qxl, QXLRect *area)
@@ -101,15 +85,45 @@ static void qxl_render_update_area_unlocked(PCIQXLDevice *qxl)
     DisplaySurface *surface;
     int width = qxl->guest_head0_width ?: qxl->guest_primary.surface.width;
     int height = qxl->guest_head0_height ?: qxl->guest_primary.surface.height;
+    uint64_t map_height;
     int i;
 
+    if (width <= 0 || height <= 0) {
+        goto end;
+    }
+
+    if (qxl->guest_primary.bytes_pp > 0) {
+        int max_width = qxl->guest_primary.abs_stride
+                        / qxl->guest_primary.bytes_pp;
+        width = MIN(width, max_width);
+    }
+
+    if (qxl->guest_primary.qxl_stride < 0) {
+        /* qxl_blit() uses the primary height to find the first scanline. */
+        height = MIN(height, (int)qxl->guest_primary.surface.height);
+    }
+
+    if (qxl->guest_primary.abs_stride > 0) {
+        int max_height = qxl->vgamem_size / qxl->guest_primary.abs_stride;
+        height = MIN(height, max_height);
+    }
+
+    /*
+     * height limits the visible update, while map_height is the guest memory
+     * span validated by qxl_phys2virt().  With a negative stride qxl_blit()
+     * addresses scanlines from the declared primary height, so a shorter
+     * monitor still requires validating the full primary surface.
+     */
+    map_height = qxl->guest_primary.qxl_stride < 0 ?
+                 qxl->guest_primary.surface.height : height;
+
     if (qxl->guest_primary.resized) {
         qxl->guest_primary.resized = 0;
         qxl->guest_primary.data = qxl_phys2virt(qxl,
                                                 qxl->guest_primary.surface.mem,
                                                 MEMSLOT_GROUP_GUEST,
                                                 qxl->guest_primary.abs_stride
-                                                * height);
+                                                * map_height);
         if (!qxl->guest_primary.data) {
             goto end;
         }
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 2a599761b5a..7d7961a150f 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1507,6 +1507,47 @@ static void qxl_create_guest_primary_complete(PCIQXLDevice *qxl)
     qxl_render_resize(qxl);
 }
 
+/*
+ * Convert a SpiceSurfaceFormat to bytes per pixel and bits per pixel.
+ *
+ * Only valid for surface suitable for rendering.
+ */
+bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
+                    uint32_t *bytes_pp, uint32_t *bits_pp)
+{
+    uint32_t bypp = 4;
+    uint32_t bipp = 32;
+    bool ret = true;
+
+    switch (format) {
+    case SPICE_SURFACE_FMT_16_555:
+        bypp = 2;
+        bipp = 15;
+        break;
+    case SPICE_SURFACE_FMT_16_565:
+        bypp = 2;
+        bipp = 16;
+        break;
+    case SPICE_SURFACE_FMT_32_xRGB:
+    case SPICE_SURFACE_FMT_32_ARGB:
+        bypp = 4;
+        bipp = 32;
+        break;
+    default:
+        ret = false;
+        qxl_set_guest_bug(qxl, "%s: unhandled format: %x", __func__, format);
+    }
+
+    if (bytes_pp != NULL) {
+        *bytes_pp = bypp;
+    }
+    if (bits_pp != NULL) {
+        *bits_pp = bipp;
+    }
+
+    return ret;
+}
+
 static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
                                      qxl_async_io async)
 {
@@ -1514,6 +1555,7 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
     QXLSurfaceCreate *sc = &qxl->guest_primary.surface;
     uint32_t requested_height = le32_to_cpu(sc->height);
     int requested_stride = le32_to_cpu(sc->stride);
+    uint32_t bytes_pp;
 
     if (requested_stride == INT32_MIN ||
         abs(requested_stride) * (uint64_t)requested_height
@@ -1550,6 +1592,23 @@ static void qxl_create_guest_primary(PCIQXLDevice *qxl, int loadvm,
         return;
     }
 
+    if (!qxl_format_bpp(qxl, surface.format, &bytes_pp, NULL)) {
+        return;
+    }
+
+    if (surface.width == 0 || surface.height == 0) {
+        qxl_set_guest_bug(qxl, "%s: zero dimension %ux%u",
+                          __func__, surface.width, surface.height);
+        return;
+    }
+
+    if ((uint64_t)surface.width * bytes_pp > abs(surface.stride)) {
+        qxl_set_guest_bug(qxl, "%s: stride too small for width:"
+                          " stride %d width %u bpp %u",
+                          __func__, surface.stride, surface.width, bytes_pp);
+        return;
+    }
+
     surface.mouse_mode = true;
     surface.group_id   = MEMSLOT_GROUP_GUEST;
     if (loadvm) {
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index ddbab3d693a..10b3d1a043a 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -181,6 +181,8 @@ void qxl_spice_oom(PCIQXLDevice *qxl);
 void qxl_spice_reset_memslots(PCIQXLDevice *qxl);
 void qxl_spice_reset_image_cache(PCIQXLDevice *qxl);
 void qxl_spice_reset_cursor(PCIQXLDevice *qxl);
+bool qxl_format_bpp(PCIQXLDevice *qxl, SpiceSurfaceFmt format,
+                    uint32_t *bytes_pp, uint32_t *bits_pp);
 
 /* qxl-logger.c */
 int qxl_log_cmd_cursor(PCIQXLDevice *qxl, QXLCursorCmd *cmd, int group_id);
-- 
2.47.3


