Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2021C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua95H-0000jE-5r; Fri, 11 Jul 2025 04:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xY-0004c3-Ik; Fri, 11 Jul 2025 04:18:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xW-00041F-CJ; Fri, 11 Jul 2025 04:18:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AA9211356D4;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A1B1623FA49;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 09/39] ui/vnc: take account of client byte order in
 pixman format
Date: Fri, 11 Jul 2025 11:16:05 +0300
Message-ID: <20250711081745.1785806-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The set_pixel_conversion() method is responsible for determining whether
the VNC client pixel format matches the server format, and thus whether
we can use the fast path "copy" impl for sending pixels, or must use
the generic impl with bit swizzling.

The VNC server format is set at build time to VNC_SERVER_FB_FORMAT,
which corresponds to PIXMAN_x8r8g8b8.

The qemu_pixman_get_format() method is then responsible for converting
the VNC pixel format into a pixman format.

The VNC client pixel shifts are relative to the associated endianness.

The pixman formats are always relative to the host native endianness.

The qemu_pixman_get_format() method does not take into account the
VNC client endianness, and is thus returning a pixman format that is
only valid with the host endianness matches that of the VNC client.

This has been broken since pixman was introduced to the VNC server:

  commit 9f64916da20eea67121d544698676295bbb105a7
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Wed Oct 10 13:29:43 2012 +0200

    pixman/vnc: use pixman images in vnc.

The flaw can be demonstrated using the Tigervnc client by using

   vncviewer -AutoSelect=0 -PreferredEncoding=raw server:display

connecting from a LE client to a QEMU on a BE server, or the
reverse.

The bug was masked, however, because almost all VNC clients will
advertize support for the "tight" encoding and the QEMU VNC server
will prefer "tight" if advertized.

The tight_pack24 method is responsible for taking a set of pixels
which have already been converted into client endianness and then
repacking them into the TPIXEL format which the RFB spec defines
as

  "TPIXEL is only 3 bytes long, where the first byte is the
   red component, the second byte is the green component,
   and the third byte is the blue component of the pixel
   color value"

IOW, the TPIXEL format is fixed on the wire, regardless of what
the VNC client declare as its endianness.

Since the VNC pixel encoding code was failing to honour the endian
flag of the client, the tight_pack24 method was always operating
on data in native endianness. Its impl cancelled out the VNC pixel
encoding bug.

With the VNC pixel encoding code now fixed, the tight_pack24 method
needs to take into account that it is operating on data in client
endianness, not native endianness. It thus may need to invert the
pixel shifts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 70097442853c389a765c9f6502d861d182b092ae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 193bc046d1..2ca0ed7029 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -75,12 +75,12 @@ PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format);
 pixman_format_code_t qemu_default_pixman_format(int bpp, bool native_endian);
 pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format);
 uint32_t qemu_pixman_to_drm_format(pixman_format_code_t pixman);
-int qemu_pixman_get_type(int rshift, int gshift, int bshift);
+int qemu_pixman_get_type(int rshift, int gshift, int bshift, int endian);
 bool qemu_pixman_check_format(DisplayChangeListener *dcl,
                               pixman_format_code_t format);
 
 #ifdef CONFIG_PIXMAN
-pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf);
+pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf, int endian);
 pixman_image_t *qemu_pixman_linebuf_create(pixman_format_code_t format,
                                            int width);
 void qemu_pixman_linebuf_fill(pixman_image_t *linebuf, pixman_image_t *fb,
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 6ef4376f4e..ef4e71da11 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -126,33 +126,34 @@ uint32_t qemu_pixman_to_drm_format(pixman_format_code_t pixman_format)
     return 0;
 }
 
-int qemu_pixman_get_type(int rshift, int gshift, int bshift)
+int qemu_pixman_get_type(int rshift, int gshift, int bshift, int endian)
 {
     int type = PIXMAN_TYPE_OTHER;
+    bool native_endian = (endian == G_BYTE_ORDER);
 
     if (rshift > gshift && gshift > bshift) {
         if (bshift == 0) {
-            type = PIXMAN_TYPE_ARGB;
+            type = native_endian ? PIXMAN_TYPE_ARGB : PIXMAN_TYPE_BGRA;
         } else {
-            type = PIXMAN_TYPE_RGBA;
+            type = native_endian ? PIXMAN_TYPE_RGBA : PIXMAN_TYPE_ABGR;
         }
     } else if (rshift < gshift && gshift < bshift) {
         if (rshift == 0) {
-            type = PIXMAN_TYPE_ABGR;
+            type = native_endian ? PIXMAN_TYPE_ABGR : PIXMAN_TYPE_RGBA;
         } else {
-            type = PIXMAN_TYPE_BGRA;
+            type = native_endian ? PIXMAN_TYPE_BGRA : PIXMAN_TYPE_ARGB;
         }
     }
     return type;
 }
 
 #ifdef CONFIG_PIXMAN
-pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf)
+pixman_format_code_t qemu_pixman_get_format(PixelFormat *pf, int endian)
 {
     pixman_format_code_t format;
     int type;
 
-    type = qemu_pixman_get_type(pf->rshift, pf->gshift, pf->bshift);
+    type = qemu_pixman_get_type(pf->rshift, pf->gshift, pf->bshift, endian);
     format = PIXMAN_FORMAT(pf->bits_per_pixel, type,
                            pf->abits, pf->rbits, pf->gbits, pf->bbits);
     if (!pixman_format_supported_source(format)) {
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index f8aaa8f346..a5bdc19ebb 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -891,7 +891,7 @@ static void tight_pack24(VncState *vs, uint8_t *buf, size_t count, size_t *ret)
 
     buf8 = buf;
 
-    if (1 /* FIXME */) {
+    if (vs->client_endian == G_BYTE_ORDER) {
         rshift = vs->client_pf.rshift;
         gshift = vs->client_pf.gshift;
         bshift = vs->client_pf.bshift;
diff --git a/ui/vnc.c b/ui/vnc.c
index d47879f579..c96bd8ceea 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2242,7 +2242,8 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
 
 static void set_pixel_conversion(VncState *vs)
 {
-    pixman_format_code_t fmt = qemu_pixman_get_format(&vs->client_pf);
+    pixman_format_code_t fmt = qemu_pixman_get_format(&vs->client_pf,
+                                                      vs->client_endian);
 
     if (fmt == VNC_SERVER_FB_FORMAT) {
         vs->write_pixels = vnc_write_pixels_copy;
-- 
2.47.2


