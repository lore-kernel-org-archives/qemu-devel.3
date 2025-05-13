Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32597C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmYs-000114-9J; Tue, 13 May 2025 06:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYq-0000xW-QB
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEmYo-0007wL-Ea
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747130909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XfPZGnVcznqOXADytatln/NurpYAkImISuSmDz/25IM=;
 b=bT5kpqFhufKaFONFA0+++72DaEtnMI437RRydRgPi7Uvlskb7W4A76r/EFHXkP/b5EWewQ
 VrwhekSYltVEcBRMPXxwi1qSCYBs5Sqvp+DlU38BoBvbH53nHwlGxe2R2v0zDLwfESs4GD
 z1s/7r0ZCoiaXjAIrSryhgAdqTqQI1s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-c1PPlWa6Mv-0LZXnFvPPUg-1; Tue,
 13 May 2025 06:08:27 -0400
X-MC-Unique: c1PPlWa6Mv-0LZXnFvPPUg-1
X-Mimecast-MFC-AGG-ID: c1PPlWa6Mv-0LZXnFvPPUg_1747130907
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BE281800264
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:08:27 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A323419560AB; Tue, 13 May 2025 10:08:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3] ui/vnc: take account of client byte order in pixman format
Date: Tue, 13 May 2025 11:08:18 +0100
Message-ID: <20250513100819.1179249-3-berrange@redhat.com>
In-Reply-To: <20250513100819.1179249-1-berrange@redhat.com>
References: <20250513100819.1179249-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/qemu-pixman.h |  4 ++--
 ui/qemu-pixman.c         | 15 ++++++++-------
 ui/vnc-enc-tight.c       |  2 +-
 ui/vnc.c                 |  3 ++-
 4 files changed, 13 insertions(+), 11 deletions(-)

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
index 6ef4376f4e..9ca420ff78 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -126,33 +126,34 @@ uint32_t qemu_pixman_to_drm_format(pixman_format_code_t pixman_format)
     return 0;
 }
 
-int qemu_pixman_get_type(int rshift, int gshift, int bshift)
+int qemu_pixman_get_type(int rshift, int gshift, int bshift, int endian)
 {
     int type = PIXMAN_TYPE_OTHER;
+    bool native = (endian == G_BYTE_ORDER);
 
     if (rshift > gshift && gshift > bshift) {
         if (bshift == 0) {
-            type = PIXMAN_TYPE_ARGB;
+            type = native ? PIXMAN_TYPE_ARGB : PIXMAN_TYPE_BGRA;
         } else {
-            type = PIXMAN_TYPE_RGBA;
+            type = native ? PIXMAN_TYPE_RGBA : PIXMAN_TYPE_ABGR;
         }
     } else if (rshift < gshift && gshift < bshift) {
         if (rshift == 0) {
-            type = PIXMAN_TYPE_ABGR;
+            type = native ? PIXMAN_TYPE_ABGR : PIXMAN_TYPE_RGBA;
         } else {
-            type = PIXMAN_TYPE_BGRA;
+            type = native ? PIXMAN_TYPE_BGRA : PIXMAN_TYPE_ARGB;
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
index f51f618e46..c6e8d71d4f 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -891,7 +891,7 @@ static void tight_pack24(VncState *vs, uint8_t *buf, size_t count, size_t *ret)
 
     buf8 = buf;
 
-    if (1 /* FIXME */) {
+    if (vs->client_bo == G_BYTE_ORDER) {
         rshift = vs->client_pf.rshift;
         gshift = vs->client_pf.gshift;
         bshift = vs->client_pf.bshift;
diff --git a/ui/vnc.c b/ui/vnc.c
index 2c640d8be4..c0b8ad9cc1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2240,7 +2240,8 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
 
 static void set_pixel_conversion(VncState *vs)
 {
-    pixman_format_code_t fmt = qemu_pixman_get_format(&vs->client_pf);
+    pixman_format_code_t fmt = qemu_pixman_get_format(&vs->client_pf,
+                                                      vs->client_bo);
 
     if (fmt == VNC_SERVER_FB_FORMAT) {
         vs->write_pixels = vnc_write_pixels_copy;
-- 
2.49.0


