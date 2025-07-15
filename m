Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DCDC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZHC-00050H-T2; Tue, 15 Jul 2025 02:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZEK-0002lt-0r
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZED-0003dT-U6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAbA28er3Wh+Wn24OIlK+6Gdf/fmAKSekDmuw4NbbEc=;
 b=Zyw1oCZdCgoELam783zJ/WT/CutaAL6Fg2B2/wmHmktf1XDgaqTu40nsARHfUjScOIHY9a
 tLVprHH8bQjiO6SuBNW9Ky4m0bIr+CFeZiy7ch1OsP80tkOMkZRiSjgoXwbcBebUObqXMJ
 12tuCmyWDM3k44KrY8ARMYea4zrfEBI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-NBwPz0oNNbW3mxsxBNzknQ-1; Tue,
 15 Jul 2025 02:33:21 -0400
X-MC-Unique: NBwPz0oNNbW3mxsxBNzknQ-1
X-Mimecast-MFC-AGG-ID: NBwPz0oNNbW3mxsxBNzknQ_1752561201
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F8C319560B0; Tue, 15 Jul 2025 06:33:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A38BC1956094; Tue, 15 Jul 2025 06:33:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 02/13] ui/vnc: Introduce the VncWorker type
Date: Tue, 15 Jul 2025 10:32:48 +0400
Message-ID: <20250715063301.145191-3-marcandre.lureau@redhat.com>
In-Reply-To: <20250715063301.145191-1-marcandre.lureau@redhat.com>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The worker thread copies data in VncState to avoid race, but some
data are too big to copy. Such data are held with pointers to avoid
the overhead to copy, but it requires tedious memory management and
makes them vulnerable to race.

Introduce the VncWorker type to contain all data shared without copying.
It allows allocating and freeing all shared data at once and shows that
the race with the worker thread needs to be taken care of when
accessing them.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20250603-zlib-v3-2-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/vnc.h              |  49 +++--
 ui/vnc-enc-tight.c    | 456 ++++++++++++++++++++++--------------------
 ui/vnc-enc-zlib.c     |  47 ++---
 ui/vnc-enc-zrle.c     | 122 +++++------
 ui/vnc-jobs.c         |  13 +-
 ui/vnc.c              |  86 ++++----
 ui/vnc-enc-zrle.c.inc |  20 +-
 7 files changed, 405 insertions(+), 388 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 8df0cbab25..f2dab2f4d9 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -272,8 +272,6 @@ struct VncState
     gboolean disconnecting;
 
     DECLARE_BITMAP(dirty[VNC_MAX_HEIGHT], VNC_DIRTY_BITS);
-    uint8_t **lossy_rect; /* Not an Array to avoid costly memcpy in
-                           * vnc-jobs-async.c */
 
     VncDisplay *vd;
     VncStateUpdate update; /* Most recent pending request from client */
@@ -341,10 +339,7 @@ struct VncState
     /* Encoding specific, if you add something here, don't forget to
      *  update vnc_async_encoding_start()
      */
-    VncTight *tight;
-    VncZlib *zlib;
     VncHextile hextile;
-    VncZrle *zrle;
     VncZywrle zywrle;
 
     Notifier mouse_mode_notifier;
@@ -356,6 +351,19 @@ struct VncState
     QTAILQ_ENTRY(VncState) next;
 };
 
+typedef struct VncWorker {
+    uint8_t lossy_rect[VNC_STAT_ROWS][VNC_STAT_COLS];
+
+    VncTight tight;
+    VncZlib zlib;
+    VncZrle zrle;
+} VncWorker;
+
+typedef struct VncConnection {
+    VncState vs;
+    VncWorker worker;
+} VncConnection;
+
 
 /*****************************************************************************
  *
@@ -602,10 +610,11 @@ int vnc_server_fb_stride(VncDisplay *vd);
 
 void vnc_convert_pixel(VncState *vs, uint8_t *buf, uint32_t v);
 double vnc_update_freq(VncState *vs, int x, int y, int w, int h);
-void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h);
+void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h);
 
 /* Encodings */
-int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
+int vnc_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                int x, int y, int w, int h);
 
 int vnc_raw_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
 
@@ -615,17 +624,21 @@ void vnc_hextile_set_pixel_conversion(VncState *vs, int generic);
 
 void *vnc_zlib_zalloc(void *x, unsigned items, unsigned size);
 void vnc_zlib_zfree(void *x, void *addr);
-int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
-void vnc_zlib_clear(VncState *vs);
-
-int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
-int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,
-                                          int w, int h);
-void vnc_tight_clear(VncState *vs);
-
-int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
-int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h);
-void vnc_zrle_clear(VncState *vs);
+int vnc_zlib_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                     int x, int y, int w, int h);
+void vnc_zlib_clear(VncWorker *worker);
+
+int vnc_tight_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                      int x, int y, int w, int h);
+int vnc_tight_png_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                          int x, int y, int w, int h);
+void vnc_tight_clear(VncWorker *worker);
+
+int vnc_zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                     int x, int y, int w, int h);
+int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                       int x, int y, int w, int h);
+void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
 void vnc_server_cut_text_caps(VncState *vs);
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 25c7b2c788..9dfe6ae5a2 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -72,8 +72,8 @@ static const struct {
 };
 
 
-static int tight_send_framebuffer_update(VncState *vs, int x, int y,
-                                         int w, int h);
+static int tight_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                         int x, int y, int w, int h);
 
 #ifdef CONFIG_VNC_JPEG
 static const struct {
@@ -111,12 +111,12 @@ static const struct {
     { 9, PNG_ALL_FILTERS },
 };
 
-static int send_png_rect(VncState *vs, int x, int y, int w, int h,
-                         VncPalette *palette);
+static int send_png_rect(VncState *vs, VncWorker *worker,
+                         int x, int y, int w, int h, VncPalette *palette);
 
-static bool tight_can_send_png_rect(VncState *vs, int w, int h)
+static bool tight_can_send_png_rect(VncState *vs, VncTight *tight, int w, int h)
 {
-    if (vs->tight->type != VNC_ENCODING_TIGHT_PNG) {
+    if (tight->type != VNC_ENCODING_TIGHT_PNG) {
         return false;
     }
 
@@ -135,7 +135,7 @@ static bool tight_can_send_png_rect(VncState *vs, int w, int h)
  */
 
 static unsigned int
-tight_detect_smooth_image24(VncState *vs, int w, int h)
+tight_detect_smooth_image24(VncState *vs, VncTight *tight, int w, int h)
 {
     int off;
     int x, y, d, dx;
@@ -144,7 +144,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
     int pixels = 0;
     int pix, left[3];
     unsigned int errors;
-    unsigned char *buf = vs->tight->tight.buffer;
+    unsigned char *buf = tight->tight.buffer;
 
     /*
      * If client is big-endian, color samples begin from the second
@@ -205,7 +205,8 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
 #define DEFINE_DETECT_FUNCTION(bpp)                                     \
                                                                         \
     static unsigned int                                                 \
-    tight_detect_smooth_image##bpp(VncState *vs, int w, int h) {        \
+    tight_detect_smooth_image##bpp(VncState *vs, VncTight *tight,       \
+                                   int w, int h) {                      \
         bool endian;                                                    \
         uint##bpp##_t pix;                                              \
         int max[3], shift[3];                                           \
@@ -215,7 +216,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
         int pixels = 0;                                                 \
         int sample, sum, left[3];                                       \
         unsigned int errors;                                            \
-        unsigned char *buf = vs->tight->tight.buffer;                    \
+        unsigned char *buf = tight->tight.buffer;                       \
                                                                         \
         endian = 0; /* FIXME */                                         \
                                                                         \
@@ -293,11 +294,11 @@ DEFINE_DETECT_FUNCTION(16)
 DEFINE_DETECT_FUNCTION(32)
 
 static int
-tight_detect_smooth_image(VncState *vs, int w, int h)
+tight_detect_smooth_image(VncState *vs, VncTight *tight, int w, int h)
 {
     unsigned int errors;
-    int compression = vs->tight->compression;
-    int quality = vs->tight->quality;
+    int compression = tight->compression;
+    int quality = tight->quality;
 
     if (!vs->vd->lossy) {
         return 0;
@@ -309,7 +310,7 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
         return 0;
     }
 
-    if (vs->tight->quality != (uint8_t)-1) {
+    if (tight->quality != (uint8_t)-1) {
         if (w * h < VNC_TIGHT_JPEG_MIN_RECT_SIZE) {
             return 0;
         }
@@ -320,17 +321,17 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
     }
 
     if (vs->client_pf.bytes_per_pixel == 4) {
-        if (vs->tight->pixel24) {
-            errors = tight_detect_smooth_image24(vs, w, h);
-            if (vs->tight->quality != (uint8_t)-1) {
+        if (tight->pixel24) {
+            errors = tight_detect_smooth_image24(vs, tight, w, h);
+            if (tight->quality != (uint8_t)-1) {
                 return (errors < tight_conf[quality].jpeg_threshold24);
             }
             return (errors < tight_conf[compression].gradient_threshold24);
         } else {
-            errors = tight_detect_smooth_image32(vs, w, h);
+            errors = tight_detect_smooth_image32(vs, tight, w, h);
         }
     } else {
-        errors = tight_detect_smooth_image16(vs, w, h);
+        errors = tight_detect_smooth_image16(vs, tight, w, h);
     }
     if (quality != (uint8_t)-1) {
         return (errors < tight_conf[quality].jpeg_threshold);
@@ -344,15 +345,15 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
 #define DEFINE_FILL_PALETTE_FUNCTION(bpp)                               \
                                                                         \
     static int                                                          \
-    tight_fill_palette##bpp(VncState *vs, int x, int y,                 \
-                            int max, size_t count,                      \
+    tight_fill_palette##bpp(VncState *vs, VncTight *tight,              \
+                            int x, int y, int max, size_t count,        \
                             uint32_t *bg, uint32_t *fg,                 \
                             VncPalette *palette) {                      \
         uint##bpp##_t *data;                                            \
         uint##bpp##_t c0, c1, ci;                                       \
         int i, n0, n1;                                                  \
                                                                         \
-        data = (uint##bpp##_t *)vs->tight->tight.buffer;                \
+        data = (uint##bpp##_t *)tight->tight.buffer;                    \
                                                                         \
         c0 = data[0];                                                   \
         i = 1;                                                          \
@@ -417,15 +418,15 @@ DEFINE_FILL_PALETTE_FUNCTION(8)
 DEFINE_FILL_PALETTE_FUNCTION(16)
 DEFINE_FILL_PALETTE_FUNCTION(32)
 
-static int tight_fill_palette(VncState *vs, int x, int y,
+static int tight_fill_palette(VncState *vs, VncTight *tight, int x, int y,
                               size_t count, uint32_t *bg, uint32_t *fg,
                               VncPalette *palette)
 {
     int max;
 
-    max = count / tight_conf[vs->tight->compression].idx_max_colors_divisor;
+    max = count / tight_conf[tight->compression].idx_max_colors_divisor;
     if (max < 2 &&
-        count >= tight_conf[vs->tight->compression].mono_min_rect_size) {
+        count >= tight_conf[tight->compression].mono_min_rect_size) {
         max = 2;
     }
     if (max >= 256) {
@@ -434,12 +435,15 @@ static int tight_fill_palette(VncState *vs, int x, int y,
 
     switch (vs->client_pf.bytes_per_pixel) {
     case 4:
-        return tight_fill_palette32(vs, x, y, max, count, bg, fg, palette);
+        return tight_fill_palette32(vs, tight, x, y, max, count, bg, fg,
+                                    palette);
     case 2:
-        return tight_fill_palette16(vs, x, y, max, count, bg, fg, palette);
+        return tight_fill_palette16(vs, tight, x, y, max, count, bg, fg,
+                                    palette);
     default:
         max = 2;
-        return tight_fill_palette8(vs, x, y, max, count, bg, fg, palette);
+        return tight_fill_palette8(vs, tight, x, y, max, count, bg, fg,
+                                   palette);
     }
     return 0;
 }
@@ -547,7 +551,8 @@ DEFINE_MONO_ENCODE_FUNCTION(32)
  */
 
 static void
-tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
+tight_filter_gradient24(VncState *vs, VncTight *tight, uint8_t *buf,
+                        int w, int h)
 {
     uint32_t *buf32;
     uint32_t pix32;
@@ -558,7 +563,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
     int x, y, c;
 
     buf32 = (uint32_t *)buf;
-    memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));
+    memset(tight->gradient.buffer, 0, w * 3 * sizeof(int));
 
     if (1 /* FIXME */) {
         shift[0] = vs->client_pf.rshift;
@@ -575,7 +580,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
             upper[c] = 0;
             here[c] = 0;
         }
-        prev = (int *)vs->tight->gradient.buffer;
+        prev = (int *)tight->gradient.buffer;
         for (x = 0; x < w; x++) {
             pix32 = *buf32++;
             for (c = 0; c < 3; c++) {
@@ -605,8 +610,8 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
 #define DEFINE_GRADIENT_FILTER_FUNCTION(bpp)                            \
                                                                         \
     static void                                                         \
-    tight_filter_gradient##bpp(VncState *vs, uint##bpp##_t *buf,        \
-                               int w, int h) {                          \
+    tight_filter_gradient##bpp(VncState *vs, VncTight *tight,           \
+                               uint##bpp##_t *buf, int w, int h) {      \
         uint##bpp##_t pix, diff;                                        \
         bool endian;                                                    \
         int *prev;                                                      \
@@ -615,7 +620,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
         int prediction;                                                 \
         int x, y, c;                                                    \
                                                                         \
-        memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));     \
+        memset(tight->gradient.buffer, 0, w * 3 * sizeof(int));         \
                                                                         \
         endian = 0; /* FIXME */                                         \
                                                                         \
@@ -631,7 +636,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
                 upper[c] = 0;                                           \
                 here[c] = 0;                                            \
             }                                                           \
-            prev = (int *)vs->tight->gradient.buffer;                    \
+            prev = (int *)tight->gradient.buffer;                       \
             for (x = 0; x < w; x++) {                                   \
                 pix = *buf;                                             \
                 if (endian) {                                           \
@@ -782,10 +787,10 @@ static void extend_solid_area(VncState *vs, int x, int y, int w, int h,
     *w_ptr += cx - (*x_ptr + *w_ptr);
 }
 
-static int tight_init_stream(VncState *vs, int stream_id,
+static int tight_init_stream(VncState *vs, VncTight *tight, int stream_id,
                              int level, int strategy)
 {
-    z_streamp zstream = &vs->tight->stream[stream_id];
+    z_streamp zstream = &tight->stream[stream_id];
 
     if (zstream->opaque == NULL) {
         int err;
@@ -803,15 +808,15 @@ static int tight_init_stream(VncState *vs, int stream_id,
             return -1;
         }
 
-        vs->tight->levels[stream_id] = level;
+        tight->levels[stream_id] = level;
         zstream->opaque = vs;
     }
 
-    if (vs->tight->levels[stream_id] != level) {
+    if (tight->levels[stream_id] != level) {
         if (deflateParams(zstream, level, strategy) != Z_OK) {
             return -1;
         }
-        vs->tight->levels[stream_id] = level;
+        tight->levels[stream_id] = level;
     }
     return 0;
 }
@@ -836,29 +841,29 @@ static void tight_send_compact_size(VncState *vs, size_t len)
     }
 }
 
-static int tight_compress_data(VncState *vs, int stream_id, size_t bytes,
-                               int level, int strategy)
+static int tight_compress_data(VncState *vs, VncTight *tight, int stream_id,
+                               size_t bytes, int level, int strategy)
 {
-    z_streamp zstream = &vs->tight->stream[stream_id];
+    z_streamp zstream = &tight->stream[stream_id];
     int previous_out;
 
     if (bytes < VNC_TIGHT_MIN_TO_COMPRESS) {
-        vnc_write(vs, vs->tight->tight.buffer, vs->tight->tight.offset);
+        vnc_write(vs, tight->tight.buffer, tight->tight.offset);
         return bytes;
     }
 
-    if (tight_init_stream(vs, stream_id, level, strategy)) {
+    if (tight_init_stream(vs, tight, stream_id, level, strategy)) {
         return -1;
     }
 
     /* reserve memory in output buffer */
-    buffer_reserve(&vs->tight->zlib, bytes + 64);
+    buffer_reserve(&tight->zlib, bytes + 64);
 
     /* set pointers */
-    zstream->next_in = vs->tight->tight.buffer;
-    zstream->avail_in = vs->tight->tight.offset;
-    zstream->next_out = vs->tight->zlib.buffer + vs->tight->zlib.offset;
-    zstream->avail_out = vs->tight->zlib.capacity - vs->tight->zlib.offset;
+    zstream->next_in = tight->tight.buffer;
+    zstream->avail_in = tight->tight.offset;
+    zstream->next_out = tight->zlib.buffer + tight->zlib.offset;
+    zstream->avail_out = tight->zlib.capacity - tight->zlib.offset;
     previous_out = zstream->avail_out;
     zstream->data_type = Z_BINARY;
 
@@ -868,14 +873,14 @@ static int tight_compress_data(VncState *vs, int stream_id, size_t bytes,
         return -1;
     }
 
-    vs->tight->zlib.offset = vs->tight->zlib.capacity - zstream->avail_out;
+    tight->zlib.offset = tight->zlib.capacity - zstream->avail_out;
     /* ...how much data has actually been produced by deflate() */
     bytes = previous_out - zstream->avail_out;
 
     tight_send_compact_size(vs, bytes);
-    vnc_write(vs, vs->tight->zlib.buffer, bytes);
+    vnc_write(vs, tight->zlib.buffer, bytes);
 
-    buffer_reset(&vs->tight->zlib);
+    buffer_reset(&tight->zlib);
 
     return bytes;
 }
@@ -914,67 +919,69 @@ static void tight_pack24(VncState *vs, uint8_t *buf, size_t count, size_t *ret)
     }
 }
 
-static int send_full_color_rect(VncState *vs, int x, int y, int w, int h)
+static int send_full_color_rect(VncState *vs, VncWorker *worker,
+                                int x, int y, int w, int h)
 {
+    VncTight *tight = &worker->tight;
+    int level = tight_conf[tight->compression].raw_zlib_level;
     int stream = 0;
     ssize_t bytes;
 
 #ifdef CONFIG_PNG
-    if (tight_can_send_png_rect(vs, w, h)) {
-        return send_png_rect(vs, x, y, w, h, NULL);
+    if (tight_can_send_png_rect(vs, tight, w, h)) {
+        return send_png_rect(vs, worker, x, y, w, h, NULL);
     }
 #endif
 
     vnc_write_u8(vs, stream << 4); /* no flushing, no filter */
 
-    if (vs->tight->pixel24) {
-        tight_pack24(vs, vs->tight->tight.buffer, w * h,
-                     &vs->tight->tight.offset);
+    if (tight->pixel24) {
+        tight_pack24(vs, tight->tight.buffer, w * h, &tight->tight.offset);
         bytes = 3;
     } else {
         bytes = vs->client_pf.bytes_per_pixel;
     }
 
-    bytes = tight_compress_data(vs, stream, w * h * bytes,
-                            tight_conf[vs->tight->compression].raw_zlib_level,
+    bytes = tight_compress_data(vs, tight, stream, w * h * bytes, level,
                             Z_DEFAULT_STRATEGY);
 
     return (bytes >= 0);
 }
 
-static int send_solid_rect(VncState *vs)
+static int send_solid_rect(VncState *vs, VncWorker *worker)
 {
+    VncTight *tight = &worker->tight;
     size_t bytes;
 
     vnc_write_u8(vs, VNC_TIGHT_FILL << 4); /* no flushing, no filter */
 
-    if (vs->tight->pixel24) {
-        tight_pack24(vs, vs->tight->tight.buffer, 1, &vs->tight->tight.offset);
+    if (tight->pixel24) {
+        tight_pack24(vs, tight->tight.buffer, 1, &tight->tight.offset);
         bytes = 3;
     } else {
         bytes = vs->client_pf.bytes_per_pixel;
     }
 
-    vnc_write(vs, vs->tight->tight.buffer, bytes);
+    vnc_write(vs, tight->tight.buffer, bytes);
     return 1;
 }
 
-static int send_mono_rect(VncState *vs, int x, int y,
+static int send_mono_rect(VncState *vs, VncWorker *worker, int x, int y,
                           int w, int h, uint32_t bg, uint32_t fg)
 {
     ssize_t bytes;
     int stream = 1;
-    int level = tight_conf[vs->tight->compression].mono_zlib_level;
+    int level = tight_conf[worker->tight.compression].mono_zlib_level;
 
 #ifdef CONFIG_PNG
-    if (tight_can_send_png_rect(vs, w, h)) {
+    if (tight_can_send_png_rect(vs, &worker->tight, w, h)) {
         int ret;
         int bpp = vs->client_pf.bytes_per_pixel * 8;
         VncPalette *palette = palette_new(2, bpp);
 
         palette_put(palette, bg);
         palette_put(palette, fg);
-        ret = send_png_rect(vs, x, y, w, h, palette);
+        ret = send_png_rect(vs, worker, x, y, w, h, palette);
         palette_destroy(palette);
         return ret;
     }
@@ -992,12 +999,12 @@ static int send_mono_rect(VncState *vs, int x, int y,
         uint32_t buf[2] = {bg, fg};
         size_t ret = sizeof (buf);
 
-        if (vs->tight->pixel24) {
+        if (worker->tight.pixel24) {
             tight_pack24(vs, (unsigned char*)buf, 2, &ret);
         }
         vnc_write(vs, buf, ret);
 
-        tight_encode_mono_rect32(vs->tight->tight.buffer, w, h, bg, fg);
+        tight_encode_mono_rect32(worker->tight.tight.buffer, w, h, bg, fg);
         break;
     }
     case 2:
@@ -1006,7 +1013,7 @@ static int send_mono_rect(VncState *vs, int x, int y,
         uint16_t fg16 = fg;
         vnc_write(vs, &bg16, 2);
         vnc_write(vs, &fg16, 2);
-        tight_encode_mono_rect16(vs->tight->tight.buffer, w, h, bg, fg);
+        tight_encode_mono_rect16(worker->tight.tight.buffer, w, h, bg, fg);
         break;
     }
     default:
@@ -1015,18 +1022,20 @@ static int send_mono_rect(VncState *vs, int x, int y,
         uint8_t fg8 = fg;
         vnc_write_u8(vs, bg8);
         vnc_write_u8(vs, fg8);
-        tight_encode_mono_rect8(vs->tight->tight.buffer, w, h, bg, fg);
+        tight_encode_mono_rect8(worker->tight.tight.buffer, w, h, bg, fg);
         break;
     }
     }
-    vs->tight->tight.offset = bytes;
+    worker->tight.tight.offset = bytes;
 
-    bytes = tight_compress_data(vs, stream, bytes, level, Z_DEFAULT_STRATEGY);
+    bytes = tight_compress_data(vs, &worker->tight, stream, bytes, level,
+                                Z_DEFAULT_STRATEGY);
     return (bytes >= 0);
 }
 
 struct palette_cb_priv {
     VncState *vs;
+    VncTight *tight;
     uint8_t *header;
 #ifdef CONFIG_PNG
     png_colorp png_palette;
@@ -1046,53 +1055,58 @@ static void write_palette(int idx, uint32_t color, void *opaque)
     }
 }
 
-static bool send_gradient_rect(VncState *vs, int x, int y, int w, int h)
+static bool send_gradient_rect(VncState *vs, VncWorker *worker,
+                               int x, int y, int w, int h)
 {
+    VncTight *tight = &worker->tight;
     int stream = 3;
-    int level = tight_conf[vs->tight->compression].gradient_zlib_level;
+    int level = tight_conf[tight->compression].gradient_zlib_level;
     ssize_t bytes;
 
     if (vs->client_pf.bytes_per_pixel == 1) {
-        return send_full_color_rect(vs, x, y, w, h);
+        return send_full_color_rect(vs, worker, x, y, w, h);
     }
 
     vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
     vnc_write_u8(vs, VNC_TIGHT_FILTER_GRADIENT);
 
-    buffer_reserve(&vs->tight->gradient, w * 3 * sizeof(int));
+    buffer_reserve(&tight->gradient, w * 3 * sizeof(int));
 
-    if (vs->tight->pixel24) {
-        tight_filter_gradient24(vs, vs->tight->tight.buffer, w, h);
+    if (tight->pixel24) {
+        tight_filter_gradient24(vs, tight, tight->tight.buffer, w, h);
         bytes = 3;
     } else if (vs->client_pf.bytes_per_pixel == 4) {
-        tight_filter_gradient32(vs, (uint32_t *)vs->tight->tight.buffer, w, h);
+        tight_filter_gradient32(vs, tight, (uint32_t *)tight->tight.buffer,
+                                w, h);
         bytes = 4;
     } else {
-        tight_filter_gradient16(vs, (uint16_t *)vs->tight->tight.buffer, w, h);
+        tight_filter_gradient16(vs, tight, (uint16_t *)tight->tight.buffer,
+                                w, h);
         bytes = 2;
     }
 
-    buffer_reset(&vs->tight->gradient);
+    buffer_reset(&tight->gradient);
 
     bytes = w * h * bytes;
-    vs->tight->tight.offset = bytes;
+    tight->tight.offset = bytes;
 
-    bytes = tight_compress_data(vs, stream, bytes,
+    bytes = tight_compress_data(vs, tight, stream, bytes,
                                 level, Z_FILTERED);
     return (bytes >= 0);
 }
 
-static int send_palette_rect(VncState *vs, int x, int y,
+static int send_palette_rect(VncState *vs, VncWorker *worker, int x, int y,
                              int w, int h, VncPalette *palette)
 {
+    VncTight *tight = &worker->tight;
     int stream = 2;
-    int level = tight_conf[vs->tight->compression].idx_zlib_level;
+    int level = tight_conf[tight->compression].idx_zlib_level;
     int colors;
     ssize_t bytes;
 
 #ifdef CONFIG_PNG
-    if (tight_can_send_png_rect(vs, w, h)) {
-        return send_png_rect(vs, x, y, w, h, palette);
+    if (tight_can_send_png_rect(vs, tight, w, h)) {
+        return send_png_rect(vs, worker, x, y, w, h, palette);
     }
 #endif
 
@@ -1107,38 +1121,38 @@ static int send_palette_rect(VncState *vs, int x, int y,
     {
         size_t old_offset, offset, palette_sz = palette_size(palette);
         g_autofree uint32_t *header = g_new(uint32_t, palette_sz);
-        struct palette_cb_priv priv = { vs, (uint8_t *)header };
+        struct palette_cb_priv priv = { vs, tight, (uint8_t *)header };
 
         old_offset = vs->output.offset;
         palette_iter(palette, write_palette, &priv);
         vnc_write(vs, header, palette_sz * sizeof(uint32_t));
 
-        if (vs->tight->pixel24) {
+        if (tight->pixel24) {
             tight_pack24(vs, vs->output.buffer + old_offset, colors, &offset);
             vs->output.offset = old_offset + offset;
         }
 
-        tight_encode_indexed_rect32(vs->tight->tight.buffer, w * h, palette);
+        tight_encode_indexed_rect32(tight->tight.buffer, w * h, palette);
         break;
     }
     case 2:
     {
         size_t palette_sz = palette_size(palette);
         g_autofree uint16_t *header = g_new(uint16_t, palette_sz);
-        struct palette_cb_priv priv = { vs, (uint8_t *)header };
+        struct palette_cb_priv priv = { vs, tight, (uint8_t *)header };
 
         palette_iter(palette, write_palette, &priv);
         vnc_write(vs, header, palette_sz * sizeof(uint16_t));
-        tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h, palette);
+        tight_encode_indexed_rect16(tight->tight.buffer, w * h, palette);
         break;
     }
     default:
         return -1; /* No palette for 8bits colors */
     }
     bytes = w * h;
-    vs->tight->tight.offset = bytes;
+    tight->tight.offset = bytes;
 
-    bytes = tight_compress_data(vs, stream, bytes,
+    bytes = tight_compress_data(vs, tight, stream, bytes,
                                 level, Z_DEFAULT_STRATEGY);
     return (bytes >= 0);
 }
@@ -1154,8 +1168,8 @@ static int send_palette_rect(VncState *vs, int x, int y,
 /* This is called once per encoding */
 static void jpeg_init_destination(j_compress_ptr cinfo)
 {
-    VncState *vs = cinfo->client_data;
-    Buffer *buffer = &vs->tight->jpeg;
+    VncTight *tight = cinfo->client_data;
+    Buffer *buffer = &tight->jpeg;
 
     cinfo->dest->next_output_byte = (JOCTET *)buffer->buffer + buffer->offset;
     cinfo->dest->free_in_buffer = (size_t)(buffer->capacity - buffer->offset);
@@ -1164,8 +1178,8 @@ static void jpeg_init_destination(j_compress_ptr cinfo)
 /* This is called when we ran out of buffer (shouldn't happen!) */
 static boolean jpeg_empty_output_buffer(j_compress_ptr cinfo)
 {
-    VncState *vs = cinfo->client_data;
-    Buffer *buffer = &vs->tight->jpeg;
+    VncTight *tight = cinfo->client_data;
+    Buffer *buffer = &tight->jpeg;
 
     buffer->offset = buffer->capacity;
     buffer_reserve(buffer, 2048);
@@ -1176,13 +1190,14 @@ static boolean jpeg_empty_output_buffer(j_compress_ptr cinfo)
 /* This is called when we are done processing data */
 static void jpeg_term_destination(j_compress_ptr cinfo)
 {
-    VncState *vs = cinfo->client_data;
-    Buffer *buffer = &vs->tight->jpeg;
+    VncTight *tight = cinfo->client_data;
+    Buffer *buffer = &tight->jpeg;
 
     buffer->offset = buffer->capacity - cinfo->dest->free_in_buffer;
 }
 
-static int send_jpeg_rect(VncState *vs, int x, int y, int w, int h, int quality)
+static int send_jpeg_rect(VncState *vs, VncWorker *worker,
+                          int x, int y, int w, int h, int quality)
 {
     struct jpeg_compress_struct cinfo;
     struct jpeg_error_mgr jerr;
@@ -1193,15 +1208,15 @@ static int send_jpeg_rect(VncState *vs, int x, int y, int w, int h, int quality)
     int dy;
 
     if (surface_bytes_per_pixel(vs->vd->ds) == 1) {
-        return send_full_color_rect(vs, x, y, w, h);
+        return send_full_color_rect(vs, worker, x, y, w, h);
     }
 
-    buffer_reserve(&vs->tight->jpeg, 2048);
+    buffer_reserve(&worker->tight.jpeg, 2048);
 
     cinfo.err = jpeg_std_error(&jerr);
     jpeg_create_compress(&cinfo);
 
-    cinfo.client_data = vs;
+    cinfo.client_data = &worker->tight;
     cinfo.image_width = w;
     cinfo.image_height = h;
     cinfo.input_components = 3;
@@ -1231,9 +1246,9 @@ static int send_jpeg_rect(VncState *vs, int x, int y, int w, int h, int quality)
 
     vnc_write_u8(vs, VNC_TIGHT_JPEG << 4);
 
-    tight_send_compact_size(vs, vs->tight->jpeg.offset);
-    vnc_write(vs, vs->tight->jpeg.buffer, vs->tight->jpeg.offset);
-    buffer_reset(&vs->tight->jpeg);
+    tight_send_compact_size(vs, worker->tight.jpeg.offset);
+    vnc_write(vs, worker->tight.jpeg.buffer, worker->tight.jpeg.offset);
+    buffer_reset(&worker->tight.jpeg);
 
     return 1;
 }
@@ -1249,7 +1264,7 @@ static void write_png_palette(int idx, uint32_t pix, void *opaque)
     VncState *vs = priv->vs;
     png_colorp color = &priv->png_palette[idx];
 
-    if (vs->tight->pixel24)
+    if (priv->tight->pixel24)
     {
         color->red = (pix >> vs->client_pf.rshift) & vs->client_pf.rmax;
         color->green = (pix >> vs->client_pf.gshift) & vs->client_pf.gmax;
@@ -1274,12 +1289,12 @@ static void write_png_palette(int idx, uint32_t pix, void *opaque)
 static void png_write_data(png_structp png_ptr, png_bytep data,
                            png_size_t length)
 {
-    VncState *vs = png_get_io_ptr(png_ptr);
+    VncWorker *worker = png_get_io_ptr(png_ptr);
 
-    buffer_reserve(&vs->tight->png, vs->tight->png.offset + length);
-    memcpy(vs->tight->png.buffer + vs->tight->png.offset, data, length);
+    buffer_reserve(&worker->tight.png, worker->tight.png.offset + length);
+    memcpy(worker->tight.png.buffer + worker->tight.png.offset, data, length);
 
-    vs->tight->png.offset += length;
+    worker->tight.png.offset += length;
 }
 
 static void png_flush_data(png_structp png_ptr)
@@ -1296,16 +1311,16 @@ static void vnc_png_free(png_structp png_ptr, png_voidp ptr)
     g_free(ptr);
 }
 
-static int send_png_rect(VncState *vs, int x, int y, int w, int h,
-                         VncPalette *palette)
+static int send_png_rect(VncState *vs, VncWorker *worker,
+                         int x, int y, int w, int h, VncPalette *palette)
 {
     png_byte color_type;
     png_structp png_ptr;
     png_infop info_ptr;
     png_colorp png_palette = NULL;
     pixman_image_t *linebuf;
-    int level = tight_png_conf[vs->tight->compression].png_zlib_level;
-    int filters = tight_png_conf[vs->tight->compression].png_filters;
+    int level = tight_png_conf[worker->tight.compression].png_zlib_level;
+    int filters = tight_png_conf[worker->tight.compression].png_filters;
     uint8_t *buf;
     int dy;
 
@@ -1322,7 +1337,7 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
         return -1;
     }
 
-    png_set_write_fn(png_ptr, (void *) vs, png_write_data, png_flush_data);
+    png_set_write_fn(png_ptr, worker, png_write_data, png_flush_data);
     png_set_compression_level(png_ptr, level);
     png_set_filter(png_ptr, PNG_FILTER_TYPE_DEFAULT, filters);
 
@@ -1343,29 +1358,30 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
                                  palette_size(palette));
 
         priv.vs = vs;
+        priv.tight = &worker->tight;
         priv.png_palette = png_palette;
         palette_iter(palette, write_png_palette, &priv);
 
         png_set_PLTE(png_ptr, info_ptr, png_palette, palette_size(palette));
 
         if (vs->client_pf.bytes_per_pixel == 4) {
-            tight_encode_indexed_rect32(vs->tight->tight.buffer, w * h,
+            tight_encode_indexed_rect32(worker->tight.tight.buffer, w * h,
                                         palette);
         } else {
-            tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h,
+            tight_encode_indexed_rect16(worker->tight.tight.buffer, w * h,
                                         palette);
         }
     }
 
     png_write_info(png_ptr, info_ptr);
 
-    buffer_reserve(&vs->tight->png, 2048);
+    buffer_reserve(&worker->tight.png, 2048);
     linebuf = qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, w);
     buf = (uint8_t *)pixman_image_get_data(linebuf);
     for (dy = 0; dy < h; dy++)
     {
         if (color_type == PNG_COLOR_TYPE_PALETTE) {
-            memcpy(buf, vs->tight->tight.buffer + (dy * w), w);
+            memcpy(buf, worker->tight.tight.buffer + (dy * w), w);
         } else {
             qemu_pixman_linebuf_fill(linebuf, vs->vd->server, w, x, y + dy);
         }
@@ -1383,46 +1399,47 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
 
     vnc_write_u8(vs, VNC_TIGHT_PNG << 4);
 
-    tight_send_compact_size(vs, vs->tight->png.offset);
-    vnc_write(vs, vs->tight->png.buffer, vs->tight->png.offset);
-    buffer_reset(&vs->tight->png);
+    tight_send_compact_size(vs, worker->tight.png.offset);
+    vnc_write(vs, worker->tight.png.buffer, worker->tight.png.offset);
+    buffer_reset(&worker->tight.png);
     return 1;
 }
 #endif /* CONFIG_PNG */
 
-static void vnc_tight_start(VncState *vs)
+static void vnc_tight_start(VncState *vs, VncTight *tight)
 {
-    buffer_reset(&vs->tight->tight);
+    buffer_reset(&tight->tight);
 
     // make the output buffer be the zlib buffer, so we can compress it later
-    vs->tight->tmp = vs->output;
-    vs->output = vs->tight->tight;
+    tight->tmp = vs->output;
+    vs->output = tight->tight;
 }
 
-static void vnc_tight_stop(VncState *vs)
+static void vnc_tight_stop(VncState *vs, VncTight *tight)
 {
     // switch back to normal output/zlib buffers
-    vs->tight->tight = vs->output;
-    vs->output = vs->tight->tmp;
+    tight->tight = vs->output;
+    vs->output = tight->tmp;
 }
 
-static int send_sub_rect_nojpeg(VncState *vs, int x, int y, int w, int h,
+static int send_sub_rect_nojpeg(VncState *vs, VncWorker *worker,
+                                int x, int y, int w, int h,
                                 int bg, int fg, int colors, VncPalette *palette)
 {
     int ret;
 
     if (colors == 0) {
-        if (tight_detect_smooth_image(vs, w, h)) {
-            ret = send_gradient_rect(vs, x, y, w, h);
+        if (tight_detect_smooth_image(vs, &worker->tight, w, h)) {
+            ret = send_gradient_rect(vs, worker, x, y, w, h);
         } else {
-            ret = send_full_color_rect(vs, x, y, w, h);
+            ret = send_full_color_rect(vs, worker, x, y, w, h);
         }
     } else if (colors == 1) {
-        ret = send_solid_rect(vs);
+        ret = send_solid_rect(vs, worker);
     } else if (colors == 2) {
-        ret = send_mono_rect(vs, x, y, w, h, bg, fg);
+        ret = send_mono_rect(vs, worker, x, y, w, h, bg, fg);
     } else if (colors <= 256) {
-        ret = send_palette_rect(vs, x, y, w, h, palette);
+        ret = send_palette_rect(vs, worker, x, y, w, h, palette);
     } else {
         ret = 0;
     }
@@ -1430,34 +1447,35 @@ static int send_sub_rect_nojpeg(VncState *vs, int x, int y, int w, int h,
 }
 
 #ifdef CONFIG_VNC_JPEG
-static int send_sub_rect_jpeg(VncState *vs, int x, int y, int w, int h,
+static int send_sub_rect_jpeg(VncState *vs, VncWorker *worker,
+                              int x, int y, int w, int h,
                               int bg, int fg, int colors,
                               VncPalette *palette, bool force)
 {
     int ret;
 
     if (colors == 0) {
-        if (force || (tight_jpeg_conf[vs->tight->quality].jpeg_full &&
-                      tight_detect_smooth_image(vs, w, h))) {
-            int quality = tight_conf[vs->tight->quality].jpeg_quality;
+        if (force || (tight_jpeg_conf[worker->tight.quality].jpeg_full &&
+                      tight_detect_smooth_image(vs, &worker->tight, w, h))) {
+            int quality = tight_conf[worker->tight.quality].jpeg_quality;
 
-            ret = send_jpeg_rect(vs, x, y, w, h, quality);
+            ret = send_jpeg_rect(vs, worker, x, y, w, h, quality);
         } else {
-            ret = send_full_color_rect(vs, x, y, w, h);
+            ret = send_full_color_rect(vs, worker, x, y, w, h);
         }
     } else if (colors == 1) {
-        ret = send_solid_rect(vs);
+        ret = send_solid_rect(vs, worker);
     } else if (colors == 2) {
-        ret = send_mono_rect(vs, x, y, w, h, bg, fg);
+        ret = send_mono_rect(vs, worker, x, y, w, h, bg, fg);
     } else if (colors <= 256) {
         if (force || (colors > 96 &&
-                      tight_jpeg_conf[vs->tight->quality].jpeg_idx &&
-                      tight_detect_smooth_image(vs, w, h))) {
-            int quality = tight_conf[vs->tight->quality].jpeg_quality;
+                      tight_jpeg_conf[worker->tight.quality].jpeg_idx &&
+                      tight_detect_smooth_image(vs, &worker->tight, w, h))) {
+            int quality = tight_conf[worker->tight.quality].jpeg_quality;
 
-            ret = send_jpeg_rect(vs, x, y, w, h, quality);
+            ret = send_jpeg_rect(vs, worker, x, y, w, h, quality);
         } else {
-            ret = send_palette_rect(vs, x, y, w, h, palette);
+            ret = send_palette_rect(vs, worker, x, y, w, h, palette);
         }
     } else {
         ret = 0;
@@ -1475,8 +1493,10 @@ static void vnc_tight_cleanup(Notifier *n, void *value)
     color_count_palette = NULL;
 }
 
-static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
+static int send_sub_rect(VncState *vs, VncWorker *worker,
+                         int x, int y, int w, int h)
 {
+    VncTight *tight = &worker->tight;
     uint32_t bg = 0, fg = 0;
     int colors;
     int ret = 0;
@@ -1491,57 +1511,59 @@ static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
         qemu_thread_atexit_add(&vnc_tight_cleanup_notifier);
     }
 
-    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
+    vnc_framebuffer_update(vs, x, y, w, h, tight->type);
 
-    vnc_tight_start(vs);
+    vnc_tight_start(vs, tight);
     vnc_raw_send_framebuffer_update(vs, x, y, w, h);
-    vnc_tight_stop(vs);
+    vnc_tight_stop(vs, tight);
 
 #ifdef CONFIG_VNC_JPEG
-    if (!vs->vd->non_adaptive && vs->tight->quality != (uint8_t)-1) {
+    if (!vs->vd->non_adaptive && tight->quality != (uint8_t)-1) {
         double freq = vnc_update_freq(vs, x, y, w, h);
 
-        if (freq < tight_jpeg_conf[vs->tight->quality].jpeg_freq_min) {
+        if (freq < tight_jpeg_conf[tight->quality].jpeg_freq_min) {
             allow_jpeg = false;
         }
-        if (freq >= tight_jpeg_conf[vs->tight->quality].jpeg_freq_threshold) {
+        if (freq >= tight_jpeg_conf[tight->quality].jpeg_freq_threshold) {
             force_jpeg = true;
-            vnc_sent_lossy_rect(vs, x, y, w, h);
+            vnc_sent_lossy_rect(worker, x, y, w, h);
         }
     }
 #endif
 
-    colors = tight_fill_palette(vs, x, y, w * h, &bg, &fg, color_count_palette);
+    colors = tight_fill_palette(vs, tight, x, y, w * h, &bg, &fg,
+                                color_count_palette);
 
 #ifdef CONFIG_VNC_JPEG
-    if (allow_jpeg && vs->tight->quality != (uint8_t)-1) {
-        ret = send_sub_rect_jpeg(vs, x, y, w, h, bg, fg, colors,
+    if (allow_jpeg && tight->quality != (uint8_t)-1) {
+        ret = send_sub_rect_jpeg(vs, worker, x, y, w, h, bg, fg, colors,
                                  color_count_palette, force_jpeg);
     } else {
-        ret = send_sub_rect_nojpeg(vs, x, y, w, h, bg, fg, colors,
-                                   color_count_palette);
+        ret = send_sub_rect_nojpeg(vs, worker, x, y, w, h, bg, fg,
+                                   colors, color_count_palette);
     }
 #else
-    ret = send_sub_rect_nojpeg(vs, x, y, w, h, bg, fg, colors,
+    ret = send_sub_rect_nojpeg(vs, worker, x, y, w, h, bg, fg, colors,
                                color_count_palette);
 #endif
 
     return ret;
 }
 
-static int send_sub_rect_solid(VncState *vs, int x, int y, int w, int h)
+static int send_sub_rect_solid(VncState *vs, VncWorker *worker,
+                               int x, int y, int w, int h)
 {
-    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
+    vnc_framebuffer_update(vs, x, y, w, h, worker->tight.type);
 
-    vnc_tight_start(vs);
+    vnc_tight_start(vs, &worker->tight);
     vnc_raw_send_framebuffer_update(vs, x, y, w, h);
-    vnc_tight_stop(vs);
+    vnc_tight_stop(vs, &worker->tight);
 
-    return send_solid_rect(vs);
+    return send_solid_rect(vs, worker);
 }
 
-static int send_rect_simple(VncState *vs, int x, int y, int w, int h,
-                            bool split)
+static int send_rect_simple(VncState *vs, VncWorker *worker,
+                            int x, int y, int w, int h, bool split)
 {
     int max_size, max_width;
     int max_sub_width, max_sub_height;
@@ -1549,8 +1571,8 @@ static int send_rect_simple(VncState *vs, int x, int y, int w, int h,
     int rw, rh;
     int n = 0;
 
-    max_size = tight_conf[vs->tight->compression].max_rect_size;
-    max_width = tight_conf[vs->tight->compression].max_rect_width;
+    max_size = tight_conf[worker->tight.compression].max_rect_size;
+    max_width = tight_conf[worker->tight.compression].max_rect_width;
 
     if (split && (w > max_width || w * h > max_size)) {
         max_sub_width = (w > max_width) ? max_width : w;
@@ -1560,18 +1582,18 @@ static int send_rect_simple(VncState *vs, int x, int y, int w, int h,
             for (dx = 0; dx < w; dx += max_width) {
                 rw = MIN(max_sub_width, w - dx);
                 rh = MIN(max_sub_height, h - dy);
-                n += send_sub_rect(vs, x+dx, y+dy, rw, rh);
+                n += send_sub_rect(vs, worker, x + dx, y + dy, rw, rh);
             }
         }
     } else {
-        n += send_sub_rect(vs, x, y, w, h);
+        n += send_sub_rect(vs, worker, x, y, w, h);
     }
 
     return n;
 }
 
-static int find_large_solid_color_rect(VncState *vs, int x, int y,
-                                       int w, int h, int max_rows)
+static int find_large_solid_color_rect(VncState *vs, VncWorker *worker,
+                                       int x, int y, int w, int h, int max_rows)
 {
     int dx, dy, dw, dh;
     int n = 0;
@@ -1583,7 +1605,7 @@ static int find_large_solid_color_rect(VncState *vs, int x, int y,
         /* If a rectangle becomes too large, send its upper part now. */
 
         if (dy - y >= max_rows) {
-            n += send_rect_simple(vs, x, y, w, max_rows, true);
+            n += send_rect_simple(vs, worker, x, y, w, max_rows, true);
             y += max_rows;
             h -= max_rows;
         }
@@ -1622,26 +1644,28 @@ static int find_large_solid_color_rect(VncState *vs, int x, int y,
             /* Send rectangles at top and left to solid-color area. */
 
             if (y_best != y) {
-                n += send_rect_simple(vs, x, y, w, y_best-y, true);
+                n += send_rect_simple(vs, worker, x, y, w, y_best - y, true);
             }
             if (x_best != x) {
-                n += tight_send_framebuffer_update(vs, x, y_best,
+                n += tight_send_framebuffer_update(vs, worker, x, y_best,
                                                    x_best-x, h_best);
             }
 
             /* Send solid-color rectangle. */
-            n += send_sub_rect_solid(vs, x_best, y_best, w_best, h_best);
+            n += send_sub_rect_solid(vs, worker,
+                                     x_best, y_best, w_best, h_best);
 
             /* Send remaining rectangles (at right and bottom). */
 
             if (x_best + w_best != x + w) {
-                n += tight_send_framebuffer_update(vs, x_best+w_best,
+                n += tight_send_framebuffer_update(vs, worker, x_best + w_best,
                                                    y_best,
                                                    w-(x_best-x)-w_best,
                                                    h_best);
             }
             if (y_best + h_best != y + h) {
-                n += tight_send_framebuffer_update(vs, x, y_best+h_best,
+                n += tight_send_framebuffer_update(vs, worker,
+                                                   x, y_best + h_best,
                                                    w, h-(y_best-y)-h_best);
             }
 
@@ -1649,73 +1673,73 @@ static int find_large_solid_color_rect(VncState *vs, int x, int y,
             return n;
         }
     }
-    return n + send_rect_simple(vs, x, y, w, h, true);
+    return n + send_rect_simple(vs, worker, x, y, w, h, true);
 }
 
-static int tight_send_framebuffer_update(VncState *vs, int x, int y,
-                                         int w, int h)
+static int tight_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                         int x, int y, int w, int h)
 {
     int max_rows;
 
     if (vs->client_pf.bytes_per_pixel == 4 && vs->client_pf.rmax == 0xFF &&
         vs->client_pf.bmax == 0xFF && vs->client_pf.gmax == 0xFF) {
-        vs->tight->pixel24 = true;
+        worker->tight.pixel24 = true;
     } else {
-        vs->tight->pixel24 = false;
+        worker->tight.pixel24 = false;
     }
 
 #ifdef CONFIG_VNC_JPEG
-    if (vs->tight->quality != (uint8_t)-1) {
+    if (worker->tight.quality != (uint8_t)-1) {
         double freq = vnc_update_freq(vs, x, y, w, h);
 
-        if (freq > tight_jpeg_conf[vs->tight->quality].jpeg_freq_threshold) {
-            return send_rect_simple(vs, x, y, w, h, false);
+        if (freq > tight_jpeg_conf[worker->tight.quality].jpeg_freq_threshold) {
+            return send_rect_simple(vs, worker, x, y, w, h, false);
         }
     }
 #endif
 
     if (w * h < VNC_TIGHT_MIN_SPLIT_RECT_SIZE) {
-        return send_rect_simple(vs, x, y, w, h, true);
+        return send_rect_simple(vs, worker, x, y, w, h, true);
     }
 
     /* Calculate maximum number of rows in one non-solid rectangle. */
 
-    max_rows = tight_conf[vs->tight->compression].max_rect_size;
-    max_rows /= MIN(tight_conf[vs->tight->compression].max_rect_width, w);
+    max_rows = tight_conf[worker->tight.compression].max_rect_size;
+    max_rows /= MIN(tight_conf[worker->tight.compression].max_rect_width, w);
 
-    return find_large_solid_color_rect(vs, x, y, w, h, max_rows);
+    return find_large_solid_color_rect(vs, worker, x, y, w, h, max_rows);
 }
 
-int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y,
-                                      int w, int h)
+int vnc_tight_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                      int x, int y, int w, int h)
 {
-    vs->tight->type = VNC_ENCODING_TIGHT;
-    return tight_send_framebuffer_update(vs, x, y, w, h);
+    worker->tight.type = VNC_ENCODING_TIGHT;
+    return tight_send_framebuffer_update(vs, worker, x, y, w, h);
 }
 
-int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,
-                                          int w, int h)
+int vnc_tight_png_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                          int x, int y, int w, int h)
 {
-    vs->tight->type = VNC_ENCODING_TIGHT_PNG;
-    return tight_send_framebuffer_update(vs, x, y, w, h);
+    worker->tight.type = VNC_ENCODING_TIGHT_PNG;
+    return tight_send_framebuffer_update(vs, worker, x, y, w, h);
 }
 
-void vnc_tight_clear(VncState *vs)
+void vnc_tight_clear(VncWorker *worker)
 {
     int i;
-    for (i = 0; i < ARRAY_SIZE(vs->tight->stream); i++) {
-        if (vs->tight->stream[i].opaque) {
-            deflateEnd(&vs->tight->stream[i]);
+    for (i = 0; i < ARRAY_SIZE(worker->tight.stream); i++) {
+        if (worker->tight.stream[i].opaque) {
+            deflateEnd(&worker->tight.stream[i]);
         }
     }
 
-    buffer_free(&vs->tight->tight);
-    buffer_free(&vs->tight->zlib);
-    buffer_free(&vs->tight->gradient);
+    buffer_free(&worker->tight.tight);
+    buffer_free(&worker->tight.zlib);
+    buffer_free(&worker->tight.gradient);
 #ifdef CONFIG_VNC_JPEG
-    buffer_free(&vs->tight->jpeg);
+    buffer_free(&worker->tight.jpeg);
 #endif
 #ifdef CONFIG_PNG
-    buffer_free(&vs->tight->png);
+    buffer_free(&worker->tight.png);
 #endif
 }
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index 52e9193eab..a6d287118a 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -46,23 +46,23 @@ void vnc_zlib_zfree(void *x, void *addr)
     g_free(addr);
 }
 
-static void vnc_zlib_start(VncState *vs)
+static void vnc_zlib_start(VncState *vs, VncWorker *worker)
 {
-    buffer_reset(&vs->zlib->zlib);
+    buffer_reset(&worker->zlib.zlib);
 
     // make the output buffer be the zlib buffer, so we can compress it later
-    vs->zlib->tmp = vs->output;
-    vs->output = vs->zlib->zlib;
+    worker->zlib.tmp = vs->output;
+    vs->output = worker->zlib.zlib;
 }
 
-static int vnc_zlib_stop(VncState *vs)
+static int vnc_zlib_stop(VncState *vs, VncWorker *worker)
 {
-    z_streamp zstream = &vs->zlib->stream;
+    z_streamp zstream = &worker->zlib.stream;
     int previous_out;
 
     // switch back to normal output/zlib buffers
-    vs->zlib->zlib = vs->output;
-    vs->output = vs->zlib->tmp;
+    worker->zlib.zlib = vs->output;
+    vs->output = worker->zlib.tmp;
 
     // compress the zlib buffer
 
@@ -76,7 +76,7 @@ static int vnc_zlib_stop(VncState *vs)
         zstream->zalloc = vnc_zlib_zalloc;
         zstream->zfree = vnc_zlib_zfree;
 
-        err = deflateInit2(zstream, vs->tight->compression, Z_DEFLATED,
+        err = deflateInit2(zstream, worker->tight.compression, Z_DEFLATED,
                            MAX_WBITS,
                            MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
 
@@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)
             return -1;
         }
 
-        vs->zlib->level = vs->tight->compression;
+        worker->zlib.level = worker->tight.compression;
         zstream->opaque = vs;
     }
 
-    if (vs->tight->compression != vs->zlib->level) {
-        if (deflateParams(zstream, vs->tight->compression,
+    if (worker->tight.compression != worker->zlib.level) {
+        if (deflateParams(zstream, worker->tight.compression,
                           Z_DEFAULT_STRATEGY) != Z_OK) {
             return -1;
         }
-        vs->zlib->level = vs->tight->compression;
+        worker->zlib.level = worker->tight.compression;
     }
 
     // reserve memory in output buffer
-    buffer_reserve(&vs->output, vs->zlib->zlib.offset + 64);
+    buffer_reserve(&vs->output, worker->zlib.zlib.offset + 64);
 
     // set pointers
-    zstream->next_in = vs->zlib->zlib.buffer;
-    zstream->avail_in = vs->zlib->zlib.offset;
+    zstream->next_in = worker->zlib.zlib.buffer;
+    zstream->avail_in = worker->zlib.zlib.offset;
     zstream->next_out = vs->output.buffer + vs->output.offset;
     zstream->avail_out = vs->output.capacity - vs->output.offset;
     previous_out = zstream->avail_out;
@@ -118,7 +118,8 @@ static int vnc_zlib_stop(VncState *vs)
     return previous_out - zstream->avail_out;
 }
 
-int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
+int vnc_zlib_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                     int x, int y, int w, int h)
 {
     int old_offset, new_offset, bytes_written;
 
@@ -129,9 +130,9 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
     vnc_write_s32(vs, 0);
 
     // compress the stream
-    vnc_zlib_start(vs);
+    vnc_zlib_start(vs, worker);
     vnc_raw_send_framebuffer_update(vs, x, y, w, h);
-    bytes_written = vnc_zlib_stop(vs);
+    bytes_written = vnc_zlib_stop(vs, worker);
 
     if (bytes_written == -1)
         return 0;
@@ -145,10 +146,10 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
     return 1;
 }
 
-void vnc_zlib_clear(VncState *vs)
+void vnc_zlib_clear(VncWorker *worker)
 {
-    if (vs->zlib->stream.opaque) {
-        deflateEnd(&vs->zlib->stream);
+    if (worker->zlib.stream.opaque) {
+        deflateEnd(&worker->zlib.stream);
     }
-    buffer_free(&vs->zlib->zlib);
+    buffer_free(&worker->zlib.zlib);
 }
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index 97ec6c7119..7679014c9e 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -35,45 +35,45 @@ static const int bits_per_packed_pixel[] = {
 };
 
 
-static void vnc_zrle_start(VncState *vs)
+static void vnc_zrle_start(VncState *vs, VncZrle *zrle)
 {
-    buffer_reset(&vs->zrle->zrle);
+    buffer_reset(&zrle->zrle);
 
     /* make the output buffer be the zlib buffer, so we can compress it later */
-    vs->zrle->tmp = vs->output;
-    vs->output = vs->zrle->zrle;
+    zrle->tmp = vs->output;
+    vs->output = zrle->zrle;
 }
 
-static void vnc_zrle_stop(VncState *vs)
+static void vnc_zrle_stop(VncState *vs, VncZrle *zrle)
 {
     /* switch back to normal output/zlib buffers */
-    vs->zrle->zrle = vs->output;
-    vs->output = vs->zrle->tmp;
+    zrle->zrle = vs->output;
+    vs->output = zrle->tmp;
 }
 
-static void *zrle_convert_fb(VncState *vs, int x, int y, int w, int h,
-                             int bpp)
+static void *zrle_convert_fb(VncState *vs, VncZrle *zrle,
+                             int x, int y, int w, int h, int bpp)
 {
     Buffer tmp;
 
-    buffer_reset(&vs->zrle->fb);
-    buffer_reserve(&vs->zrle->fb, w * h * bpp + bpp);
+    buffer_reset(&zrle->fb);
+    buffer_reserve(&zrle->fb, w * h * bpp + bpp);
 
     tmp = vs->output;
-    vs->output = vs->zrle->fb;
+    vs->output = zrle->fb;
 
     vnc_raw_send_framebuffer_update(vs, x, y, w, h);
 
-    vs->zrle->fb = vs->output;
+    zrle->fb = vs->output;
     vs->output = tmp;
-    return vs->zrle->fb.buffer;
+    return zrle->fb.buffer;
 }
 
-static int zrle_compress_data(VncState *vs, int level)
+static int zrle_compress_data(VncState *vs, VncZrle *zrle, int level)
 {
-    z_streamp zstream = &vs->zrle->stream;
+    z_streamp zstream = &zrle->stream;
 
-    buffer_reset(&vs->zrle->zlib);
+    buffer_reset(&zrle->zlib);
 
     if (zstream->opaque != vs) {
         int err;
@@ -93,13 +93,13 @@ static int zrle_compress_data(VncState *vs, int level)
     }
 
     /* reserve memory in output buffer */
-    buffer_reserve(&vs->zrle->zlib, vs->zrle->zrle.offset + 64);
+    buffer_reserve(&zrle->zlib, zrle->zrle.offset + 64);
 
     /* set pointers */
-    zstream->next_in = vs->zrle->zrle.buffer;
-    zstream->avail_in = vs->zrle->zrle.offset;
-    zstream->next_out = vs->zrle->zlib.buffer;
-    zstream->avail_out = vs->zrle->zlib.capacity;
+    zstream->next_in = zrle->zrle.buffer;
+    zstream->avail_in = zrle->zrle.offset;
+    zstream->next_out = zrle->zlib.buffer;
+    zstream->avail_out = zrle->zlib.capacity;
     zstream->data_type = Z_BINARY;
 
     /* start encoding */
@@ -108,8 +108,8 @@ static int zrle_compress_data(VncState *vs, int level)
         return -1;
     }
 
-    vs->zrle->zlib.offset = vs->zrle->zlib.capacity - zstream->avail_out;
-    return vs->zrle->zlib.offset;
+    zrle->zlib.offset = zrle->zlib.capacity - zstream->avail_out;
+    return zrle->zlib.offset;
 }
 
 /* Try to work out whether to use RLE and/or a palette.  We do this by
@@ -252,21 +252,21 @@ static void zrle_write_u8(VncState *vs, uint8_t value)
 #undef ZRLE_COMPACT_PIXEL
 #undef ZRLE_BPP
 
-static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
-                                        int w, int h)
+static int zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                        int x, int y, int w, int h)
 {
     bool be = vs->client_endian == G_BIG_ENDIAN;
     size_t bytes;
     int zywrle_level;
 
-    if (vs->zrle->type == VNC_ENCODING_ZYWRLE) {
-        if (!vs->vd->lossy || vs->tight->quality == (uint8_t)-1
-            || vs->tight->quality == 9) {
+    if (worker->zrle.type == VNC_ENCODING_ZYWRLE) {
+        if (!vs->vd->lossy || worker->tight.quality == (uint8_t)-1
+            || worker->tight.quality == 9) {
             zywrle_level = 0;
-            vs->zrle->type = VNC_ENCODING_ZRLE;
-        } else if (vs->tight->quality < 3) {
+            worker->zrle.type = VNC_ENCODING_ZRLE;
+        } else if (worker->tight.quality < 3) {
             zywrle_level = 3;
-        } else if (vs->tight->quality < 6) {
+        } else if (worker->tight.quality < 6) {
             zywrle_level = 2;
         } else {
             zywrle_level = 1;
@@ -275,25 +275,25 @@ static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
         zywrle_level = 0;
     }
 
-    vnc_zrle_start(vs);
+    vnc_zrle_start(vs, &worker->zrle);
 
     switch (vs->client_pf.bytes_per_pixel) {
     case 1:
-        zrle_encode_8ne(vs, x, y, w, h, zywrle_level);
+        zrle_encode_8ne(vs, &worker->zrle, x, y, w, h, zywrle_level);
         break;
 
     case 2:
         if (vs->client_pf.gmax > 0x1F) {
             if (be) {
-                zrle_encode_16be(vs, x, y, w, h, zywrle_level);
+                zrle_encode_16be(vs, &worker->zrle, x, y, w, h, zywrle_level);
             } else {
-                zrle_encode_16le(vs, x, y, w, h, zywrle_level);
+                zrle_encode_16le(vs, &worker->zrle, x, y, w, h, zywrle_level);
             }
         } else {
             if (be) {
-                zrle_encode_15be(vs, x, y, w, h, zywrle_level);
+                zrle_encode_15be(vs, &worker->zrle, x, y, w, h, zywrle_level);
             } else {
-                zrle_encode_15le(vs, x, y, w, h, zywrle_level);
+                zrle_encode_15le(vs, &worker->zrle, x, y, w, h, zywrle_level);
             }
         }
         break;
@@ -314,53 +314,55 @@ static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
 
         if ((fits_in_ls3bytes && !be) || (fits_in_ms3bytes && be)) {
             if (be) {
-                zrle_encode_24abe(vs, x, y, w, h, zywrle_level);
+                zrle_encode_24abe(vs, &worker->zrle, x, y, w, h, zywrle_level);
             } else {
-                zrle_encode_24ale(vs, x, y, w, h, zywrle_level);
+                zrle_encode_24ale(vs, &worker->zrle, x, y, w, h, zywrle_level);
           }
         } else if ((fits_in_ls3bytes && be) || (fits_in_ms3bytes && !be)) {
             if (be) {
-                zrle_encode_24bbe(vs, x, y, w, h, zywrle_level);
+                zrle_encode_24bbe(vs, &worker->zrle, x, y, w, h, zywrle_level);
             } else {
-                zrle_encode_24ble(vs, x, y, w, h, zywrle_level);
+                zrle_encode_24ble(vs, &worker->zrle, x, y, w, h, zywrle_level);
             }
         } else {
             if (be) {
-                zrle_encode_32be(vs, x, y, w, h, zywrle_level);
+                zrle_encode_32be(vs, &worker->zrle, x, y, w, h, zywrle_level);
             } else {
-                zrle_encode_32le(vs, x, y, w, h, zywrle_level);
+                zrle_encode_32le(vs, &worker->zrle, x, y, w, h, zywrle_level);
             }
         }
     }
     break;
     }
 
-    vnc_zrle_stop(vs);
-    bytes = zrle_compress_data(vs, Z_DEFAULT_COMPRESSION);
-    vnc_framebuffer_update(vs, x, y, w, h, vs->zrle->type);
+    vnc_zrle_stop(vs, &worker->zrle);
+    bytes = zrle_compress_data(vs, &worker->zrle, Z_DEFAULT_COMPRESSION);
+    vnc_framebuffer_update(vs, x, y, w, h, worker->zrle.type);
     vnc_write_u32(vs, bytes);
-    vnc_write(vs, vs->zrle->zlib.buffer, vs->zrle->zlib.offset);
+    vnc_write(vs, worker->zrle.zlib.buffer, worker->zrle.zlib.offset);
     return 1;
 }
 
-int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
+int vnc_zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                     int x, int y, int w, int h)
 {
-    vs->zrle->type = VNC_ENCODING_ZRLE;
-    return zrle_send_framebuffer_update(vs, x, y, w, h);
+    worker->zrle.type = VNC_ENCODING_ZRLE;
+    return zrle_send_framebuffer_update(vs, worker, x, y, w, h);
 }
 
-int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
+int vnc_zywrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                       int x, int y, int w, int h)
 {
-    vs->zrle->type = VNC_ENCODING_ZYWRLE;
-    return zrle_send_framebuffer_update(vs, x, y, w, h);
+    worker->zrle.type = VNC_ENCODING_ZYWRLE;
+    return zrle_send_framebuffer_update(vs, worker, x, y, w, h);
 }
 
-void vnc_zrle_clear(VncState *vs)
+void vnc_zrle_clear(VncWorker *worker)
 {
-    if (vs->zrle->stream.opaque) {
-        deflateEnd(&vs->zrle->stream);
+    if (worker->zrle.stream.opaque) {
+        deflateEnd(&worker->zrle.stream);
     }
-    buffer_free(&vs->zrle->zrle);
-    buffer_free(&vs->zrle->fb);
-    buffer_free(&vs->zrle->zlib);
+    buffer_free(&worker->zrle.zrle);
+    buffer_free(&worker->zrle.fb);
+    buffer_free(&worker->zrle.zlib);
 }
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index d3486af9e2..bed33950a8 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -185,14 +185,10 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->vnc_encoding = orig->vnc_encoding;
     local->features = orig->features;
     local->vd = orig->vd;
-    local->lossy_rect = orig->lossy_rect;
     local->write_pixels = orig->write_pixels;
     local->client_pf = orig->client_pf;
     local->client_endian = orig->client_endian;
-    local->tight = orig->tight;
-    local->zlib = orig->zlib;
     local->hextile = orig->hextile;
-    local->zrle = orig->zrle;
     local->client_width = orig->client_width;
     local->client_height = orig->client_height;
 }
@@ -200,11 +196,7 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
 static void vnc_async_encoding_end(VncState *orig, VncState *local)
 {
     buffer_free(&local->output);
-    orig->tight = local->tight;
-    orig->zlib = local->zlib;
     orig->hextile = local->hextile;
-    orig->zrle = local->zrle;
-    orig->lossy_rect = local->lossy_rect;
 }
 
 static bool vnc_worker_clamp_rect(VncState *vs, VncJob *job, VncRect *rect)
@@ -237,6 +229,7 @@ static bool vnc_worker_clamp_rect(VncState *vs, VncJob *job, VncRect *rect)
 
 static int vnc_worker_thread_loop(VncJobQueue *queue)
 {
+    VncConnection *vc;
     VncJob *job;
     VncRectEntry *entry, *tmp;
     VncState vs = {};
@@ -256,6 +249,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
     }
 
     assert(job->vs->magic == VNC_MAGIC);
+    vc = container_of(job->vs, VncConnection, vs);
 
     vnc_lock_output(job->vs);
     if (job->vs->ioc == NULL || job->vs->abort == true) {
@@ -295,7 +289,8 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
         }
 
         if (vnc_worker_clamp_rect(&vs, job, &entry->rect)) {
-            n = vnc_send_framebuffer_update(&vs, entry->rect.x, entry->rect.y,
+            n = vnc_send_framebuffer_update(&vs, &vc->worker,
+                                            entry->rect.x, entry->rect.y,
                                             entry->rect.w, entry->rect.h);
 
             if (n >= 0) {
diff --git a/ui/vnc.c b/ui/vnc.c
index ab74154e4c..1df35832d5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -56,11 +56,6 @@
 #include "io/dns-resolver.h"
 #include "monitor/monitor.h"
 
-typedef struct VncConnection {
-    VncState vs;
-    VncZlib zlib;
-} VncConnection;
-
 #define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT
 #define VNC_REFRESH_INTERVAL_INC  50
 #define VNC_REFRESH_INTERVAL_MAX  GUI_REFRESH_INTERVAL_IDLE
@@ -951,29 +946,30 @@ int vnc_raw_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
     return 1;
 }
 
-int vnc_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
+int vnc_send_framebuffer_update(VncState *vs, VncWorker *worker,
+                                int x, int y, int w, int h)
 {
     int n = 0;
 
     switch(vs->vnc_encoding) {
         case VNC_ENCODING_ZLIB:
-            n = vnc_zlib_send_framebuffer_update(vs, x, y, w, h);
+            n = vnc_zlib_send_framebuffer_update(vs, worker, x, y, w, h);
             break;
         case VNC_ENCODING_HEXTILE:
             vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_HEXTILE);
             n = vnc_hextile_send_framebuffer_update(vs, x, y, w, h);
             break;
         case VNC_ENCODING_TIGHT:
-            n = vnc_tight_send_framebuffer_update(vs, x, y, w, h);
+            n = vnc_tight_send_framebuffer_update(vs, worker, x, y, w, h);
             break;
         case VNC_ENCODING_TIGHT_PNG:
-            n = vnc_tight_png_send_framebuffer_update(vs, x, y, w, h);
+            n = vnc_tight_png_send_framebuffer_update(vs, worker, x, y, w, h);
             break;
         case VNC_ENCODING_ZRLE:
-            n = vnc_zrle_send_framebuffer_update(vs, x, y, w, h);
+            n = vnc_zrle_send_framebuffer_update(vs, worker, x, y, w, h);
             break;
         case VNC_ENCODING_ZYWRLE:
-            n = vnc_zywrle_send_framebuffer_update(vs, x, y, w, h);
+            n = vnc_zywrle_send_framebuffer_update(vs, worker, x, y, w, h);
             break;
         default:
             vnc_framebuffer_update(vs, x, y, w, h, VNC_ENCODING_RAW);
@@ -1311,7 +1307,7 @@ static void vnc_disconnect_start(VncState *vs)
 
 void vnc_disconnect_finish(VncState *vs)
 {
-    int i;
+    VncConnection *vc = container_of(vs, VncConnection, vs);
 
     trace_vnc_client_disconnect_finish(vs, vs->ioc);
 
@@ -1325,9 +1321,9 @@ void vnc_disconnect_finish(VncState *vs)
 
     qapi_free_VncClientInfo(vs->info);
 
-    vnc_zlib_clear(vs);
-    vnc_tight_clear(vs);
-    vnc_zrle_clear(vs);
+    vnc_zlib_clear(&vc->worker);
+    vnc_tight_clear(&vc->worker);
+    vnc_zrle_clear(&vc->worker);
 
 #ifdef CONFIG_VNC_SASL
     vnc_sasl_client_cleanup(vs);
@@ -1355,19 +1351,12 @@ void vnc_disconnect_finish(VncState *vs)
     }
     buffer_free(&vs->jobs_buffer);
 
-    for (i = 0; i < VNC_STAT_ROWS; ++i) {
-        g_free(vs->lossy_rect[i]);
-    }
-    g_free(vs->lossy_rect);
-
     object_unref(OBJECT(vs->ioc));
     vs->ioc = NULL;
     object_unref(OBJECT(vs->sioc));
     vs->sioc = NULL;
     vs->magic = 0;
-    g_free(vs->zrle);
-    g_free(vs->tight);
-    g_free(container_of(vs, VncConnection, vs));
+    g_free(vc);
 }
 
 size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
@@ -2131,13 +2120,14 @@ static void send_xvp_message(VncState *vs, int code)
 
 static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
 {
+    VncConnection *vc = container_of(vs, VncConnection, vs);
     int i;
     unsigned int enc = 0;
 
     vs->features = 0;
     vs->vnc_encoding = 0;
-    vs->tight->compression = 9;
-    vs->tight->quality = -1; /* Lossless by default */
+    vc->worker.tight.compression = 9;
+    vc->worker.tight.quality = -1; /* Lossless by default */
     vs->absolute = -1;
 
     /*
@@ -2225,11 +2215,11 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vnc_server_cut_text_caps(vs);
             break;
         case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
-            vs->tight->compression = (enc & 0x0F);
+            vc->worker.tight.compression = (enc & 0x0F);
             break;
         case VNC_ENCODING_QUALITYLEVEL0 ... VNC_ENCODING_QUALITYLEVEL0 + 9:
             if (vs->vd->lossy) {
-                vs->tight->quality = (enc & 0x0F);
+                vc->worker.tight.quality = (enc & 0x0F);
             }
             break;
         default:
@@ -2958,7 +2948,7 @@ static VncRectStat *vnc_stat_rect(VncDisplay *vd, int x, int y)
     return &vs->stats[y / VNC_STAT_RECT][x / VNC_STAT_RECT];
 }
 
-void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h)
+void vnc_sent_lossy_rect(VncWorker *worker, int x, int y, int w, int h)
 {
     int i, j;
 
@@ -2969,7 +2959,7 @@ void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h)
 
     for (j = y; j <= h; j++) {
         for (i = x; i <= w; i++) {
-            vs->lossy_rect[j][i] = 1;
+            worker->lossy_rect[j][i] = 1;
         }
     }
 }
@@ -2985,6 +2975,7 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
     x = QEMU_ALIGN_DOWN(x, VNC_STAT_RECT);
 
     QTAILQ_FOREACH(vs, &vd->clients, next) {
+        VncConnection *vc = container_of(vs, VncConnection, vs);
         int j;
 
         /* kernel send buffers are full -> refresh later */
@@ -2992,11 +2983,11 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
             continue;
         }
 
-        if (!vs->lossy_rect[sty][stx]) {
+        if (!vc->worker.lossy_rect[sty][stx]) {
             continue;
         }
 
-        vs->lossy_rect[sty][stx] = 0;
+        vc->worker.lossy_rect[sty][stx] = 0;
         for (j = 0; j < VNC_STAT_RECT; ++j) {
             bitmap_set(vs->dirty[y + j],
                        x / VNC_DIRTY_PIXELS_PER_BIT,
@@ -3249,12 +3240,8 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     VncConnection *vc = g_new0(VncConnection, 1);
     VncState *vs = &vc->vs;
     bool first_client = QTAILQ_EMPTY(&vd->clients);
-    int i;
 
     trace_vnc_client_connect(vs, sioc);
-    vs->zlib = &vc->zlib;
-    vs->zrle = g_new0(VncZrle, 1);
-    vs->tight = g_new0(VncTight, 1);
     vs->magic = VNC_MAGIC;
     vs->sioc = sioc;
     object_ref(OBJECT(vs->sioc));
@@ -3262,23 +3249,23 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     object_ref(OBJECT(vs->ioc));
     vs->vd = vd;
 
-    buffer_init(&vs->input,          "vnc-input/%p", sioc);
-    buffer_init(&vs->output,         "vnc-output/%p", sioc);
-    buffer_init(&vs->jobs_buffer,    "vnc-jobs_buffer/%p", sioc);
+    buffer_init(&vs->input,                 "vnc-input/%p", sioc);
+    buffer_init(&vs->output,                "vnc-output/%p", sioc);
+    buffer_init(&vs->jobs_buffer,           "vnc-jobs_buffer/%p", sioc);
 
-    buffer_init(&vs->tight->tight,    "vnc-tight/%p", sioc);
-    buffer_init(&vs->tight->zlib,     "vnc-tight-zlib/%p", sioc);
-    buffer_init(&vs->tight->gradient, "vnc-tight-gradient/%p", sioc);
+    buffer_init(&vc->worker.tight.tight,    "vnc-tight/%p", sioc);
+    buffer_init(&vc->worker.tight.zlib,     "vnc-tight-zlib/%p", sioc);
+    buffer_init(&vc->worker.tight.gradient, "vnc-tight-gradient/%p", sioc);
 #ifdef CONFIG_VNC_JPEG
-    buffer_init(&vs->tight->jpeg,     "vnc-tight-jpeg/%p", sioc);
+    buffer_init(&vc->worker.tight.jpeg,     "vnc-tight-jpeg/%p", sioc);
 #endif
 #ifdef CONFIG_PNG
-    buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
+    buffer_init(&vc->worker.tight.png,      "vnc-tight-png/%p", sioc);
 #endif
-    buffer_init(&vc->zlib.zlib,      "vnc-zlib/%p", sioc);
-    buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
-    buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
-    buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);
+    buffer_init(&vc->worker.zlib.zlib,      "vnc-zlib/%p", sioc);
+    buffer_init(&vc->worker.zrle.zrle,      "vnc-zrle/%p", sioc);
+    buffer_init(&vc->worker.zrle.fb,        "vnc-zrle-fb/%p", sioc);
+    buffer_init(&vc->worker.zrle.zlib,      "vnc-zrle-zlib/%p", sioc);
 
     if (skipauth) {
         vs->auth = VNC_AUTH_NONE;
@@ -3295,11 +3282,6 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     VNC_DEBUG("Client sioc=%p ws=%d auth=%d subauth=%d\n",
               sioc, websocket, vs->auth, vs->subauth);
 
-    vs->lossy_rect = g_malloc0(VNC_STAT_ROWS * sizeof (*vs->lossy_rect));
-    for (i = 0; i < VNC_STAT_ROWS; ++i) {
-        vs->lossy_rect[i] = g_new0(uint8_t, VNC_STAT_COLS);
-    }
-
     VNC_DEBUG("New client on socket %p\n", vs->sioc);
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
     qio_channel_set_blocking(vs->ioc, false, NULL);
diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
index 2ef7501d52..68d28f58b7 100644
--- a/ui/vnc-enc-zrle.c.inc
+++ b/ui/vnc-enc-zrle.c.inc
@@ -62,16 +62,16 @@
 #define ZRLE_ENCODE_TILE     ZRLE_CONCAT2(zrle_encode_tile,  ZRLE_ENCODE_SUFFIX)
 #define ZRLE_WRITE_PALETTE   ZRLE_CONCAT2(zrle_write_palette,ZRLE_ENCODE_SUFFIX)
 
-static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
-                             int zywrle_level);
+static void ZRLE_ENCODE_TILE(VncState *vs, VncZrle *zrle, ZRLE_PIXEL *data,
+                             int w, int h, int zywrle_level);
 
 #if ZRLE_BPP != 8
 #include "vnc-enc-zywrle-template.c"
 #endif
 
 
-static void ZRLE_ENCODE(VncState *vs, int x, int y, int w, int h,
-                        int zywrle_level)
+static void ZRLE_ENCODE(VncState *vs, VncZrle *zrle,
+                        int x, int y, int w, int h, int zywrle_level)
 {
     int ty;
 
@@ -87,16 +87,16 @@ static void ZRLE_ENCODE(VncState *vs, int x, int y, int w, int h,
 
             tw = MIN(VNC_ZRLE_TILE_WIDTH, x + w - tx);
 
-            buf = zrle_convert_fb(vs, tx, ty, tw, th, ZRLE_BPP);
-            ZRLE_ENCODE_TILE(vs, buf, tw, th, zywrle_level);
+            buf = zrle_convert_fb(vs, zrle, tx, ty, tw, th, ZRLE_BPP);
+            ZRLE_ENCODE_TILE(vs, zrle, buf, tw, th, zywrle_level);
         }
     }
 }
 
-static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
-                             int zywrle_level)
+static void ZRLE_ENCODE_TILE(VncState *vs, VncZrle *zrle, ZRLE_PIXEL *data,
+                             int w, int h, int zywrle_level)
 {
-    VncPalette *palette = &vs->zrle->palette;
+    VncPalette *palette = &zrle->palette;
 
     int runs = 0;
     int single_pixels = 0;
@@ -236,7 +236,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
 #if ZRLE_BPP != 8
         if (zywrle_level > 0 && !(zywrle_level & 0x80)) {
             ZYWRLE_ANALYZE(data, data, w, h, w, zywrle_level, vs->zywrle.buf);
-            ZRLE_ENCODE_TILE(vs, data, w, h, zywrle_level | 0x80);
+            ZRLE_ENCODE_TILE(vs, zrle, data, w, h, zywrle_level | 0x80);
         }
         else
 #endif
-- 
2.50.0


