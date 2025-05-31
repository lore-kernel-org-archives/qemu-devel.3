Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC25FC5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 14:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLN5L-0002mN-AE; Sat, 31 May 2025 10:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLN5I-0002kW-I1
 for qemu-devel@nongnu.org; Sat, 31 May 2025 10:21:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLN5D-0007nP-Bj
 for qemu-devel@nongnu.org; Sat, 31 May 2025 10:21:16 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 54VEKrPZ069146
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 May 2025 23:20:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=N3zRNOnIY0rmK69A6CJyDWRJa8HBaTriZ18mL56dbOs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1748701259; v=1;
 b=AiE8jpzskrTWVCDQq6FtVJ0/jrtU1BWX3F17rcgXeK9iQGvfKI0CR2vRgHuQ0ATb
 T+zQRYqXKRaeEwTqVl1xNYDlJPCxuHTm+CJhOSkIsziIa3xlxHKpwTCZ8CXQWmHX
 1aUqoN8HVzRJnRUSrgSBqPH6ieSxAq/++2jWjihNX4TX0d6cQNUYhLMUGQZlQHaR
 4wLezmgIF290fIZX/0TdrmDlJPfBeoQWBPdCA7AlK6V9rijB7cAWaugOegEoeWu8
 bhs7bnhDrYvZjSl5pKBrXQ/N+nwI3VeyC6XlnNFXuS8RimN1NKhzawC4Lj8pGQex
 TB18xVhZxbQJ7DCbMQMORQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 31 May 2025 23:20:41 +0900
Subject: [PATCH v2 1/2] ui/vnc: Introduce the VncWorker type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250531-zlib-v2-1-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
References: <20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, PDS_OTHER_BAD_TLD=1.997,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The worker thread copies data in VncState to avoid race, but some
data are too big to copy. Such data are held with pointers to avoid
the overhead to copy, but it requires tedious memory management and
makes them vulnerable to race.

Introduce the VncWorker type to contain all data shared without copying.
It allows allocating and freeing all shared data at once and shows that
the race with the worker thread needs to be taken care of when
accessing them.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/vnc.h              |  12 +-
 ui/vnc-enc-tight.c    | 341 ++++++++++++++++++++++++++------------------------
 ui/vnc-enc-zlib.c     |  10 +-
 ui/vnc-enc-zrle.c     |  69 +++++-----
 ui/vnc-jobs.c         |   7 +-
 ui/vnc.c              |  56 ++++-----
 ui/vnc-enc-zrle.c.inc |   2 +-
 7 files changed, 245 insertions(+), 252 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index acc53a2cc114..1dc76c270c35 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -261,6 +261,13 @@ typedef enum {
 
 #define VNC_MAGIC ((uint64_t)0x05b3f069b3d204bb)
 
+typedef struct VncWorker {
+    uint8_t lossy_rect[VNC_STAT_ROWS][VNC_STAT_COLS];
+
+    VncTight tight;
+    VncZrle zrle;
+} VncWorker;
+
 struct VncState
 {
     uint64_t magic;
@@ -270,8 +277,7 @@ struct VncState
     gboolean disconnecting;
 
     DECLARE_BITMAP(dirty[VNC_MAX_HEIGHT], VNC_DIRTY_BITS);
-    uint8_t **lossy_rect; /* Not an Array to avoid costly memcpy in
-                           * vnc-jobs-async.c */
+    VncWorker *worker;
 
     VncDisplay *vd;
     VncStateUpdate update; /* Most recent pending request from client */
@@ -339,10 +345,8 @@ struct VncState
     /* Encoding specific, if you add something here, don't forget to
      *  update vnc_async_encoding_start()
      */
-    VncTight *tight;
     VncZlib zlib;
     VncHextile hextile;
-    VncZrle *zrle;
     VncZywrle zywrle;
 
     Notifier mouse_mode_notifier;
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 41f559eb837e..a8d06a125044 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -116,7 +116,7 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
 
 static bool tight_can_send_png_rect(VncState *vs, int w, int h)
 {
-    if (vs->tight->type != VNC_ENCODING_TIGHT_PNG) {
+    if (vs->worker->tight.type != VNC_ENCODING_TIGHT_PNG) {
         return false;
     }
 
@@ -144,7 +144,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
     int pixels = 0;
     int pix, left[3];
     unsigned int errors;
-    unsigned char *buf = vs->tight->tight.buffer;
+    unsigned char *buf = vs->worker->tight.tight.buffer;
 
     /*
      * If client is big-endian, color samples begin from the second
@@ -215,7 +215,7 @@ tight_detect_smooth_image24(VncState *vs, int w, int h)
         int pixels = 0;                                                 \
         int sample, sum, left[3];                                       \
         unsigned int errors;                                            \
-        unsigned char *buf = vs->tight->tight.buffer;                    \
+        unsigned char *buf = vs->worker->tight.tight.buffer;            \
                                                                         \
         endian = 0; /* FIXME */                                         \
                                                                         \
@@ -296,8 +296,8 @@ static int
 tight_detect_smooth_image(VncState *vs, int w, int h)
 {
     unsigned int errors;
-    int compression = vs->tight->compression;
-    int quality = vs->tight->quality;
+    int compression = vs->worker->tight.compression;
+    int quality = vs->worker->tight.quality;
 
     if (!vs->vd->lossy) {
         return 0;
@@ -309,7 +309,7 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
         return 0;
     }
 
-    if (vs->tight->quality != (uint8_t)-1) {
+    if (vs->worker->tight.quality != (uint8_t)-1) {
         if (w * h < VNC_TIGHT_JPEG_MIN_RECT_SIZE) {
             return 0;
         }
@@ -320,9 +320,9 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
     }
 
     if (vs->client_pf.bytes_per_pixel == 4) {
-        if (vs->tight->pixel24) {
+        if (vs->worker->tight.pixel24) {
             errors = tight_detect_smooth_image24(vs, w, h);
-            if (vs->tight->quality != (uint8_t)-1) {
+            if (vs->worker->tight.quality != (uint8_t)-1) {
                 return (errors < tight_conf[quality].jpeg_threshold24);
             }
             return (errors < tight_conf[compression].gradient_threshold24);
@@ -352,7 +352,7 @@ tight_detect_smooth_image(VncState *vs, int w, int h)
         uint##bpp##_t c0, c1, ci;                                       \
         int i, n0, n1;                                                  \
                                                                         \
-        data = (uint##bpp##_t *)vs->tight->tight.buffer;                \
+        data = (uint##bpp##_t *)vs->worker->tight.tight.buffer;         \
                                                                         \
         c0 = data[0];                                                   \
         i = 1;                                                          \
@@ -421,11 +421,12 @@ static int tight_fill_palette(VncState *vs, int x, int y,
                               size_t count, uint32_t *bg, uint32_t *fg,
                               VncPalette *palette)
 {
+    uint8_t compression = vs->worker->tight.compression;
     int max;
 
-    max = count / tight_conf[vs->tight->compression].idx_max_colors_divisor;
+    max = count / tight_conf[compression].idx_max_colors_divisor;
     if (max < 2 &&
-        count >= tight_conf[vs->tight->compression].mono_min_rect_size) {
+        count >= tight_conf[compression].mono_min_rect_size) {
         max = 2;
     }
     if (max >= 256) {
@@ -558,7 +559,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
     int x, y, c;
 
     buf32 = (uint32_t *)buf;
-    memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));
+    memset(vs->worker->tight.gradient.buffer, 0, w * 3 * sizeof(int));
 
     if (1 /* FIXME */) {
         shift[0] = vs->client_pf.rshift;
@@ -575,7 +576,7 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
             upper[c] = 0;
             here[c] = 0;
         }
-        prev = (int *)vs->tight->gradient.buffer;
+        prev = (int *)vs->worker->tight.gradient.buffer;
         for (x = 0; x < w; x++) {
             pix32 = *buf32++;
             for (c = 0; c < 3; c++) {
@@ -602,64 +603,64 @@ tight_filter_gradient24(VncState *vs, uint8_t *buf, int w, int h)
  * ``Gradient'' filter for other color depths.
  */
 
-#define DEFINE_GRADIENT_FILTER_FUNCTION(bpp)                            \
-                                                                        \
-    static void                                                         \
-    tight_filter_gradient##bpp(VncState *vs, uint##bpp##_t *buf,        \
-                               int w, int h) {                          \
-        uint##bpp##_t pix, diff;                                        \
-        bool endian;                                                    \
-        int *prev;                                                      \
-        int max[3], shift[3];                                           \
-        int here[3], upper[3], left[3], upperleft[3];                   \
-        int prediction;                                                 \
-        int x, y, c;                                                    \
-                                                                        \
-        memset(vs->tight->gradient.buffer, 0, w * 3 * sizeof(int));     \
-                                                                        \
-        endian = 0; /* FIXME */                                         \
-                                                                        \
-        max[0] = vs->client_pf.rmax;                                    \
-        max[1] = vs->client_pf.gmax;                                    \
-        max[2] = vs->client_pf.bmax;                                    \
-        shift[0] = vs->client_pf.rshift;                                \
-        shift[1] = vs->client_pf.gshift;                                \
-        shift[2] = vs->client_pf.bshift;                                \
-                                                                        \
-        for (y = 0; y < h; y++) {                                       \
-            for (c = 0; c < 3; c++) {                                   \
-                upper[c] = 0;                                           \
-                here[c] = 0;                                            \
-            }                                                           \
-            prev = (int *)vs->tight->gradient.buffer;                    \
-            for (x = 0; x < w; x++) {                                   \
-                pix = *buf;                                             \
-                if (endian) {                                           \
-                    pix = bswap##bpp(pix);                              \
-                }                                                       \
-                diff = 0;                                               \
-                for (c = 0; c < 3; c++) {                               \
-                    upperleft[c] = upper[c];                            \
-                    left[c] = here[c];                                  \
-                    upper[c] = *prev;                                   \
-                    here[c] = (int)(pix >> shift[c] & max[c]);          \
-                    *prev++ = here[c];                                  \
-                                                                        \
-                    prediction = left[c] + upper[c] - upperleft[c];     \
-                    if (prediction < 0) {                               \
-                        prediction = 0;                                 \
-                    } else if (prediction > max[c]) {                   \
-                        prediction = max[c];                            \
-                    }                                                   \
-                    diff |= ((here[c] - prediction) & max[c])           \
-                        << shift[c];                                    \
-                }                                                       \
-                if (endian) {                                           \
-                    diff = bswap##bpp(diff);                            \
-                }                                                       \
-                *buf++ = diff;                                          \
-            }                                                           \
-        }                                                               \
+#define DEFINE_GRADIENT_FILTER_FUNCTION(bpp)                                \
+                                                                            \
+    static void                                                             \
+    tight_filter_gradient##bpp(VncState *vs, uint##bpp##_t *buf,            \
+                               int w, int h) {                              \
+        uint##bpp##_t pix, diff;                                            \
+        bool endian;                                                        \
+        int *prev;                                                          \
+        int max[3], shift[3];                                               \
+        int here[3], upper[3], left[3], upperleft[3];                       \
+        int prediction;                                                     \
+        int x, y, c;                                                        \
+                                                                            \
+        memset(vs->worker->tight.gradient.buffer, 0, w * 3 * sizeof(int));  \
+                                                                            \
+        endian = 0; /* FIXME */                                             \
+                                                                            \
+        max[0] = vs->client_pf.rmax;                                        \
+        max[1] = vs->client_pf.gmax;                                        \
+        max[2] = vs->client_pf.bmax;                                        \
+        shift[0] = vs->client_pf.rshift;                                    \
+        shift[1] = vs->client_pf.gshift;                                    \
+        shift[2] = vs->client_pf.bshift;                                    \
+                                                                            \
+        for (y = 0; y < h; y++) {                                           \
+            for (c = 0; c < 3; c++) {                                       \
+                upper[c] = 0;                                               \
+                here[c] = 0;                                                \
+            }                                                               \
+            prev = (int *)vs->worker->tight.gradient.buffer;                \
+            for (x = 0; x < w; x++) {                                       \
+                pix = *buf;                                                 \
+                if (endian) {                                               \
+                    pix = bswap##bpp(pix);                                  \
+                }                                                           \
+                diff = 0;                                                   \
+                for (c = 0; c < 3; c++) {                                   \
+                    upperleft[c] = upper[c];                                \
+                    left[c] = here[c];                                      \
+                    upper[c] = *prev;                                       \
+                    here[c] = (int)(pix >> shift[c] & max[c]);              \
+                    *prev++ = here[c];                                      \
+                                                                            \
+                    prediction = left[c] + upper[c] - upperleft[c];         \
+                    if (prediction < 0) {                                   \
+                        prediction = 0;                                     \
+                    } else if (prediction > max[c]) {                       \
+                        prediction = max[c];                                \
+                    }                                                       \
+                    diff |= ((here[c] - prediction) & max[c])               \
+                        << shift[c];                                        \
+                }                                                           \
+                if (endian) {                                               \
+                    diff = bswap##bpp(diff);                                \
+                }                                                           \
+                *buf++ = diff;                                              \
+            }                                                               \
+        }                                                                   \
     }
 
 DEFINE_GRADIENT_FILTER_FUNCTION(16)
@@ -785,7 +786,7 @@ static void extend_solid_area(VncState *vs, int x, int y, int w, int h,
 static int tight_init_stream(VncState *vs, int stream_id,
                              int level, int strategy)
 {
-    z_streamp zstream = &vs->tight->stream[stream_id];
+    z_streamp zstream = &vs->worker->tight.stream[stream_id];
 
     if (zstream->opaque == NULL) {
         int err;
@@ -803,15 +804,15 @@ static int tight_init_stream(VncState *vs, int stream_id,
             return -1;
         }
 
-        vs->tight->levels[stream_id] = level;
+        vs->worker->tight.levels[stream_id] = level;
         zstream->opaque = vs;
     }
 
-    if (vs->tight->levels[stream_id] != level) {
+    if (vs->worker->tight.levels[stream_id] != level) {
         if (deflateParams(zstream, level, strategy) != Z_OK) {
             return -1;
         }
-        vs->tight->levels[stream_id] = level;
+        vs->worker->tight.levels[stream_id] = level;
     }
     return 0;
 }
@@ -839,11 +840,12 @@ static void tight_send_compact_size(VncState *vs, size_t len)
 static int tight_compress_data(VncState *vs, int stream_id, size_t bytes,
                                int level, int strategy)
 {
-    z_streamp zstream = &vs->tight->stream[stream_id];
+    VncTight *tight = &vs->worker->tight;
+    z_streamp zstream = &vs->worker->tight.stream[stream_id];
     int previous_out;
 
     if (bytes < VNC_TIGHT_MIN_TO_COMPRESS) {
-        vnc_write(vs, vs->tight->tight.buffer, vs->tight->tight.offset);
+        vnc_write(vs, tight->tight.buffer,  tight->tight.offset);
         return bytes;
     }
 
@@ -852,13 +854,13 @@ static int tight_compress_data(VncState *vs, int stream_id, size_t bytes,
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
 
@@ -868,14 +870,14 @@ static int tight_compress_data(VncState *vs, int stream_id, size_t bytes,
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
@@ -916,6 +918,7 @@ static void tight_pack24(VncState *vs, uint8_t *buf, size_t count, size_t *ret)
 
 static int send_full_color_rect(VncState *vs, int x, int y, int w, int h)
 {
+    int level = tight_conf[vs->worker->tight.compression].raw_zlib_level;
     int stream = 0;
     ssize_t bytes;
 
@@ -927,16 +930,15 @@ static int send_full_color_rect(VncState *vs, int x, int y, int w, int h)
 
     vnc_write_u8(vs, stream << 4); /* no flushing, no filter */
 
-    if (vs->tight->pixel24) {
-        tight_pack24(vs, vs->tight->tight.buffer, w * h,
-                     &vs->tight->tight.offset);
+    if (vs->worker->tight.pixel24) {
+        tight_pack24(vs, vs->worker->tight.tight.buffer, w * h,
+                     &vs->worker->tight.tight.offset);
         bytes = 3;
     } else {
         bytes = vs->client_pf.bytes_per_pixel;
     }
 
-    bytes = tight_compress_data(vs, stream, w * h * bytes,
-                            tight_conf[vs->tight->compression].raw_zlib_level,
+    bytes = tight_compress_data(vs, stream, w * h * bytes, level,
                             Z_DEFAULT_STRATEGY);
 
     return (bytes >= 0);
@@ -944,18 +946,19 @@ static int send_full_color_rect(VncState *vs, int x, int y, int w, int h)
 
 static int send_solid_rect(VncState *vs)
 {
+    VncTight *tight = &vs->worker->tight;
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
 
@@ -964,7 +967,7 @@ static int send_mono_rect(VncState *vs, int x, int y,
 {
     ssize_t bytes;
     int stream = 1;
-    int level = tight_conf[vs->tight->compression].mono_zlib_level;
+    int level = tight_conf[vs->worker->tight.compression].mono_zlib_level;
 
 #ifdef CONFIG_PNG
     if (tight_can_send_png_rect(vs, w, h)) {
@@ -992,26 +995,26 @@ static int send_mono_rect(VncState *vs, int x, int y,
         uint32_t buf[2] = {bg, fg};
         size_t ret = sizeof (buf);
 
-        if (vs->tight->pixel24) {
+        if (vs->worker->tight.pixel24) {
             tight_pack24(vs, (unsigned char*)buf, 2, &ret);
         }
         vnc_write(vs, buf, ret);
 
-        tight_encode_mono_rect32(vs->tight->tight.buffer, w, h, bg, fg);
+        tight_encode_mono_rect32(vs->worker->tight.tight.buffer, w, h, bg, fg);
         break;
     }
     case 2:
         vnc_write(vs, &bg, 2);
         vnc_write(vs, &fg, 2);
-        tight_encode_mono_rect16(vs->tight->tight.buffer, w, h, bg, fg);
+        tight_encode_mono_rect16(vs->worker->tight.tight.buffer, w, h, bg, fg);
         break;
     default:
         vnc_write_u8(vs, bg);
         vnc_write_u8(vs, fg);
-        tight_encode_mono_rect8(vs->tight->tight.buffer, w, h, bg, fg);
+        tight_encode_mono_rect8(vs->worker->tight.tight.buffer, w, h, bg, fg);
         break;
     }
-    vs->tight->tight.offset = bytes;
+    vs->worker->tight.tight.offset = bytes;
 
     bytes = tight_compress_data(vs, stream, bytes, level, Z_DEFAULT_STRATEGY);
     return (bytes >= 0);
@@ -1040,8 +1043,9 @@ static void write_palette(int idx, uint32_t color, void *opaque)
 
 static bool send_gradient_rect(VncState *vs, int x, int y, int w, int h)
 {
+    VncTight *tight = &vs->worker->tight;
     int stream = 3;
-    int level = tight_conf[vs->tight->compression].gradient_zlib_level;
+    int level = tight_conf[tight->compression].gradient_zlib_level;
     ssize_t bytes;
 
     if (vs->client_pf.bytes_per_pixel == 1) {
@@ -1051,23 +1055,23 @@ static bool send_gradient_rect(VncState *vs, int x, int y, int w, int h)
     vnc_write_u8(vs, (stream | VNC_TIGHT_EXPLICIT_FILTER) << 4);
     vnc_write_u8(vs, VNC_TIGHT_FILTER_GRADIENT);
 
-    buffer_reserve(&vs->tight->gradient, w * 3 * sizeof(int));
+    buffer_reserve(&tight->gradient, w * 3 * sizeof(int));
 
-    if (vs->tight->pixel24) {
-        tight_filter_gradient24(vs, vs->tight->tight.buffer, w, h);
+    if (tight->pixel24) {
+        tight_filter_gradient24(vs, tight->tight.buffer, w, h);
         bytes = 3;
     } else if (vs->client_pf.bytes_per_pixel == 4) {
-        tight_filter_gradient32(vs, (uint32_t *)vs->tight->tight.buffer, w, h);
+        tight_filter_gradient32(vs, (uint32_t *)tight->tight.buffer, w, h);
         bytes = 4;
     } else {
-        tight_filter_gradient16(vs, (uint16_t *)vs->tight->tight.buffer, w, h);
+        tight_filter_gradient16(vs, (uint16_t *)tight->tight.buffer, w, h);
         bytes = 2;
     }
 
-    buffer_reset(&vs->tight->gradient);
+    buffer_reset(&tight->gradient);
 
     bytes = w * h * bytes;
-    vs->tight->tight.offset = bytes;
+    tight->tight.offset = bytes;
 
     bytes = tight_compress_data(vs, stream, bytes,
                                 level, Z_FILTERED);
@@ -1077,8 +1081,9 @@ static bool send_gradient_rect(VncState *vs, int x, int y, int w, int h)
 static int send_palette_rect(VncState *vs, int x, int y,
                              int w, int h, VncPalette *palette)
 {
+    VncTight *tight = &vs->worker->tight;
     int stream = 2;
-    int level = tight_conf[vs->tight->compression].idx_zlib_level;
+    int level = tight_conf[tight->compression].idx_zlib_level;
     int colors;
     ssize_t bytes;
 
@@ -1105,12 +1110,12 @@ static int send_palette_rect(VncState *vs, int x, int y,
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
@@ -1121,14 +1126,14 @@ static int send_palette_rect(VncState *vs, int x, int y,
 
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
 
     bytes = tight_compress_data(vs, stream, bytes,
                                 level, Z_DEFAULT_STRATEGY);
@@ -1147,7 +1152,7 @@ static int send_palette_rect(VncState *vs, int x, int y,
 static void jpeg_init_destination(j_compress_ptr cinfo)
 {
     VncState *vs = cinfo->client_data;
-    Buffer *buffer = &vs->tight->jpeg;
+    Buffer *buffer = &vs->worker->tight.jpeg;
 
     cinfo->dest->next_output_byte = (JOCTET *)buffer->buffer + buffer->offset;
     cinfo->dest->free_in_buffer = (size_t)(buffer->capacity - buffer->offset);
@@ -1157,7 +1162,7 @@ static void jpeg_init_destination(j_compress_ptr cinfo)
 static boolean jpeg_empty_output_buffer(j_compress_ptr cinfo)
 {
     VncState *vs = cinfo->client_data;
-    Buffer *buffer = &vs->tight->jpeg;
+    Buffer *buffer = &vs->worker->tight.jpeg;
 
     buffer->offset = buffer->capacity;
     buffer_reserve(buffer, 2048);
@@ -1169,7 +1174,7 @@ static boolean jpeg_empty_output_buffer(j_compress_ptr cinfo)
 static void jpeg_term_destination(j_compress_ptr cinfo)
 {
     VncState *vs = cinfo->client_data;
-    Buffer *buffer = &vs->tight->jpeg;
+    Buffer *buffer = &vs->worker->tight.jpeg;
 
     buffer->offset = buffer->capacity - cinfo->dest->free_in_buffer;
 }
@@ -1188,7 +1193,7 @@ static int send_jpeg_rect(VncState *vs, int x, int y, int w, int h, int quality)
         return send_full_color_rect(vs, x, y, w, h);
     }
 
-    buffer_reserve(&vs->tight->jpeg, 2048);
+    buffer_reserve(&vs->worker->tight.jpeg, 2048);
 
     cinfo.err = jpeg_std_error(&jerr);
     jpeg_create_compress(&cinfo);
@@ -1223,9 +1228,9 @@ static int send_jpeg_rect(VncState *vs, int x, int y, int w, int h, int quality)
 
     vnc_write_u8(vs, VNC_TIGHT_JPEG << 4);
 
-    tight_send_compact_size(vs, vs->tight->jpeg.offset);
-    vnc_write(vs, vs->tight->jpeg.buffer, vs->tight->jpeg.offset);
-    buffer_reset(&vs->tight->jpeg);
+    tight_send_compact_size(vs, vs->worker->tight.jpeg.offset);
+    vnc_write(vs, vs->worker->tight.jpeg.buffer, vs->worker->tight.jpeg.offset);
+    buffer_reset(&vs->worker->tight.jpeg);
 
     return 1;
 }
@@ -1241,7 +1246,7 @@ static void write_png_palette(int idx, uint32_t pix, void *opaque)
     VncState *vs = priv->vs;
     png_colorp color = &priv->png_palette[idx];
 
-    if (vs->tight->pixel24)
+    if (vs->worker->tight.pixel24)
     {
         color->red = (pix >> vs->client_pf.rshift) & vs->client_pf.rmax;
         color->green = (pix >> vs->client_pf.gshift) & vs->client_pf.gmax;
@@ -1266,12 +1271,12 @@ static void write_png_palette(int idx, uint32_t pix, void *opaque)
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
@@ -1296,8 +1301,8 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
     png_infop info_ptr;
     png_colorp png_palette = NULL;
     pixman_image_t *linebuf;
-    int level = tight_png_conf[vs->tight->compression].png_zlib_level;
-    int filters = tight_png_conf[vs->tight->compression].png_filters;
+    int level = tight_png_conf[vs->worker->tight.compression].png_zlib_level;
+    int filters = tight_png_conf[vs->worker->tight.compression].png_filters;
     uint8_t *buf;
     int dy;
 
@@ -1314,7 +1319,7 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
         return -1;
     }
 
-    png_set_write_fn(png_ptr, (void *) vs, png_write_data, png_flush_data);
+    png_set_write_fn(png_ptr, vs->worker, png_write_data, png_flush_data);
     png_set_compression_level(png_ptr, level);
     png_set_filter(png_ptr, PNG_FILTER_TYPE_DEFAULT, filters);
 
@@ -1341,23 +1346,23 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
         png_set_PLTE(png_ptr, info_ptr, png_palette, palette_size(palette));
 
         if (vs->client_pf.bytes_per_pixel == 4) {
-            tight_encode_indexed_rect32(vs->tight->tight.buffer, w * h,
+            tight_encode_indexed_rect32(vs->worker->tight.tight.buffer, w * h,
                                         palette);
         } else {
-            tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h,
+            tight_encode_indexed_rect16(vs->worker->tight.tight.buffer, w * h,
                                         palette);
         }
     }
 
     png_write_info(png_ptr, info_ptr);
 
-    buffer_reserve(&vs->tight->png, 2048);
+    buffer_reserve(&vs->worker->tight.png, 2048);
     linebuf = qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, w);
     buf = (uint8_t *)pixman_image_get_data(linebuf);
     for (dy = 0; dy < h; dy++)
     {
         if (color_type == PNG_COLOR_TYPE_PALETTE) {
-            memcpy(buf, vs->tight->tight.buffer + (dy * w), w);
+            memcpy(buf, vs->worker->tight.tight.buffer + (dy * w), w);
         } else {
             qemu_pixman_linebuf_fill(linebuf, vs->vd->server, w, x, y + dy);
         }
@@ -1375,27 +1380,27 @@ static int send_png_rect(VncState *vs, int x, int y, int w, int h,
 
     vnc_write_u8(vs, VNC_TIGHT_PNG << 4);
 
-    tight_send_compact_size(vs, vs->tight->png.offset);
-    vnc_write(vs, vs->tight->png.buffer, vs->tight->png.offset);
-    buffer_reset(&vs->tight->png);
+    tight_send_compact_size(vs, vs->worker->tight.png.offset);
+    vnc_write(vs, vs->worker->tight.png.buffer, vs->worker->tight.png.offset);
+    buffer_reset(&vs->worker->tight.png);
     return 1;
 }
 #endif /* CONFIG_PNG */
 
 static void vnc_tight_start(VncState *vs)
 {
-    buffer_reset(&vs->tight->tight);
+    buffer_reset(&vs->worker->tight.tight);
 
     // make the output buffer be the zlib buffer, so we can compress it later
-    vs->tight->tmp = vs->output;
-    vs->output = vs->tight->tight;
+    vs->worker->tight.tmp = vs->output;
+    vs->output = vs->worker->tight.tight;
 }
 
 static void vnc_tight_stop(VncState *vs)
 {
     // switch back to normal output/zlib buffers
-    vs->tight->tight = vs->output;
-    vs->output = vs->tight->tmp;
+    vs->worker->tight.tight = vs->output;
+    vs->output = vs->worker->tight.tmp;
 }
 
 static int send_sub_rect_nojpeg(VncState *vs, int x, int y, int w, int h,
@@ -1429,9 +1434,9 @@ static int send_sub_rect_jpeg(VncState *vs, int x, int y, int w, int h,
     int ret;
 
     if (colors == 0) {
-        if (force || (tight_jpeg_conf[vs->tight->quality].jpeg_full &&
+        if (force || (tight_jpeg_conf[vs->worker->tight.quality].jpeg_full &&
                       tight_detect_smooth_image(vs, w, h))) {
-            int quality = tight_conf[vs->tight->quality].jpeg_quality;
+            int quality = tight_conf[vs->worker->tight.quality].jpeg_quality;
 
             ret = send_jpeg_rect(vs, x, y, w, h, quality);
         } else {
@@ -1443,9 +1448,9 @@ static int send_sub_rect_jpeg(VncState *vs, int x, int y, int w, int h,
         ret = send_mono_rect(vs, x, y, w, h, bg, fg);
     } else if (colors <= 256) {
         if (force || (colors > 96 &&
-                      tight_jpeg_conf[vs->tight->quality].jpeg_idx &&
+                      tight_jpeg_conf[vs->worker->tight.quality].jpeg_idx &&
                       tight_detect_smooth_image(vs, w, h))) {
-            int quality = tight_conf[vs->tight->quality].jpeg_quality;
+            int quality = tight_conf[vs->worker->tight.quality].jpeg_quality;
 
             ret = send_jpeg_rect(vs, x, y, w, h, quality);
         } else {
@@ -1469,6 +1474,7 @@ static void vnc_tight_cleanup(Notifier *n, void *value)
 
 static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
 {
+    VncTight *tight = &vs->worker->tight;
     uint32_t bg = 0, fg = 0;
     int colors;
     int ret = 0;
@@ -1483,20 +1489,20 @@ static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
         qemu_thread_atexit_add(&vnc_tight_cleanup_notifier);
     }
 
-    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
+    vnc_framebuffer_update(vs, x, y, w, h, tight->type);
 
     vnc_tight_start(vs);
     vnc_raw_send_framebuffer_update(vs, x, y, w, h);
     vnc_tight_stop(vs);
 
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
             vnc_sent_lossy_rect(vs, x, y, w, h);
         }
@@ -1506,7 +1512,7 @@ static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
     colors = tight_fill_palette(vs, x, y, w * h, &bg, &fg, color_count_palette);
 
 #ifdef CONFIG_VNC_JPEG
-    if (allow_jpeg && vs->tight->quality != (uint8_t)-1) {
+    if (allow_jpeg && tight->quality != (uint8_t)-1) {
         ret = send_sub_rect_jpeg(vs, x, y, w, h, bg, fg, colors,
                                  color_count_palette, force_jpeg);
     } else {
@@ -1523,7 +1529,7 @@ static int send_sub_rect(VncState *vs, int x, int y, int w, int h)
 
 static int send_sub_rect_solid(VncState *vs, int x, int y, int w, int h)
 {
-    vnc_framebuffer_update(vs, x, y, w, h, vs->tight->type);
+    vnc_framebuffer_update(vs, x, y, w, h, vs->worker->tight.type);
 
     vnc_tight_start(vs);
     vnc_raw_send_framebuffer_update(vs, x, y, w, h);
@@ -1541,8 +1547,8 @@ static int send_rect_simple(VncState *vs, int x, int y, int w, int h,
     int rw, rh;
     int n = 0;
 
-    max_size = tight_conf[vs->tight->compression].max_rect_size;
-    max_width = tight_conf[vs->tight->compression].max_rect_width;
+    max_size = tight_conf[vs->worker->tight.compression].max_rect_size;
+    max_width = tight_conf[vs->worker->tight.compression].max_rect_width;
 
     if (split && (w > max_width || w * h > max_size)) {
         max_sub_width = (w > max_width) ? max_width : w;
@@ -1647,20 +1653,21 @@ static int find_large_solid_color_rect(VncState *vs, int x, int y,
 static int tight_send_framebuffer_update(VncState *vs, int x, int y,
                                          int w, int h)
 {
+    VncTight *tight = &vs->worker->tight;
     int max_rows;
 
     if (vs->client_pf.bytes_per_pixel == 4 && vs->client_pf.rmax == 0xFF &&
         vs->client_pf.bmax == 0xFF && vs->client_pf.gmax == 0xFF) {
-        vs->tight->pixel24 = true;
+        tight->pixel24 = true;
     } else {
-        vs->tight->pixel24 = false;
+        tight->pixel24 = false;
     }
 
 #ifdef CONFIG_VNC_JPEG
-    if (vs->tight->quality != (uint8_t)-1) {
+    if (tight->quality != (uint8_t)-1) {
         double freq = vnc_update_freq(vs, x, y, w, h);
 
-        if (freq > tight_jpeg_conf[vs->tight->quality].jpeg_freq_threshold) {
+        if (freq > tight_jpeg_conf[tight->quality].jpeg_freq_threshold) {
             return send_rect_simple(vs, x, y, w, h, false);
         }
     }
@@ -1672,8 +1679,8 @@ static int tight_send_framebuffer_update(VncState *vs, int x, int y,
 
     /* Calculate maximum number of rows in one non-solid rectangle. */
 
-    max_rows = tight_conf[vs->tight->compression].max_rect_size;
-    max_rows /= MIN(tight_conf[vs->tight->compression].max_rect_width, w);
+    max_rows = tight_conf[tight->compression].max_rect_size;
+    max_rows /= MIN(tight_conf[tight->compression].max_rect_width, w);
 
     return find_large_solid_color_rect(vs, x, y, w, h, max_rows);
 }
@@ -1681,33 +1688,33 @@ static int tight_send_framebuffer_update(VncState *vs, int x, int y,
 int vnc_tight_send_framebuffer_update(VncState *vs, int x, int y,
                                       int w, int h)
 {
-    vs->tight->type = VNC_ENCODING_TIGHT;
+    vs->worker->tight.type = VNC_ENCODING_TIGHT;
     return tight_send_framebuffer_update(vs, x, y, w, h);
 }
 
 int vnc_tight_png_send_framebuffer_update(VncState *vs, int x, int y,
                                           int w, int h)
 {
-    vs->tight->type = VNC_ENCODING_TIGHT_PNG;
+    vs->worker->tight.type = VNC_ENCODING_TIGHT_PNG;
     return tight_send_framebuffer_update(vs, x, y, w, h);
 }
 
 void vnc_tight_clear(VncState *vs)
 {
     int i;
-    for (i = 0; i < ARRAY_SIZE(vs->tight->stream); i++) {
-        if (vs->tight->stream[i].opaque) {
-            deflateEnd(&vs->tight->stream[i]);
+    for (i = 0; i < ARRAY_SIZE(vs->worker->tight.stream); i++) {
+        if (vs->worker->tight.stream[i].opaque) {
+            deflateEnd(&vs->worker->tight.stream[i]);
         }
     }
 
-    buffer_free(&vs->tight->tight);
-    buffer_free(&vs->tight->zlib);
-    buffer_free(&vs->tight->gradient);
+    buffer_free(&vs->worker->tight.tight);
+    buffer_free(&vs->worker->tight.zlib);
+    buffer_free(&vs->worker->tight.gradient);
 #ifdef CONFIG_VNC_JPEG
-    buffer_free(&vs->tight->jpeg);
+    buffer_free(&vs->worker->tight.jpeg);
 #endif
 #ifdef CONFIG_PNG
-    buffer_free(&vs->tight->png);
+    buffer_free(&vs->worker->tight.png);
 #endif
 }
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index 900ae5b30f6b..605030730a44 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -76,7 +76,7 @@ static int vnc_zlib_stop(VncState *vs)
         zstream->zalloc = vnc_zlib_zalloc;
         zstream->zfree = vnc_zlib_zfree;
 
-        err = deflateInit2(zstream, vs->tight->compression, Z_DEFLATED,
+        err = deflateInit2(zstream, vs->worker->tight.compression, Z_DEFLATED,
                            MAX_WBITS,
                            MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
 
@@ -85,16 +85,16 @@ static int vnc_zlib_stop(VncState *vs)
             return -1;
         }
 
-        vs->zlib.level = vs->tight->compression;
+        vs->zlib.level = vs->worker->tight.compression;
         zstream->opaque = vs;
     }
 
-    if (vs->tight->compression != vs->zlib.level) {
-        if (deflateParams(zstream, vs->tight->compression,
+    if (vs->worker->tight.compression != vs->zlib.level) {
+        if (deflateParams(zstream, vs->worker->tight.compression,
                           Z_DEFAULT_STRATEGY) != Z_OK) {
             return -1;
         }
-        vs->zlib.level = vs->tight->compression;
+        vs->zlib.level = vs->worker->tight.compression;
     }
 
     // reserve memory in output buffer
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index bd33b890639f..4ed3d17d17a0 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -37,18 +37,18 @@ static const int bits_per_packed_pixel[] = {
 
 static void vnc_zrle_start(VncState *vs)
 {
-    buffer_reset(&vs->zrle->zrle);
+    buffer_reset(&vs->worker->zrle.zrle);
 
     /* make the output buffer be the zlib buffer, so we can compress it later */
-    vs->zrle->tmp = vs->output;
-    vs->output = vs->zrle->zrle;
+    vs->worker->zrle.tmp = vs->output;
+    vs->output = vs->worker->zrle.zrle;
 }
 
 static void vnc_zrle_stop(VncState *vs)
 {
     /* switch back to normal output/zlib buffers */
-    vs->zrle->zrle = vs->output;
-    vs->output = vs->zrle->tmp;
+    vs->worker->zrle.zrle = vs->output;
+    vs->output = vs->worker->zrle.tmp;
 }
 
 static void *zrle_convert_fb(VncState *vs, int x, int y, int w, int h,
@@ -56,24 +56,25 @@ static void *zrle_convert_fb(VncState *vs, int x, int y, int w, int h,
 {
     Buffer tmp;
 
-    buffer_reset(&vs->zrle->fb);
-    buffer_reserve(&vs->zrle->fb, w * h * bpp + bpp);
+    buffer_reset(&vs->worker->zrle.fb);
+    buffer_reserve(&vs->worker->zrle.fb, w * h * bpp + bpp);
 
     tmp = vs->output;
-    vs->output = vs->zrle->fb;
+    vs->output = vs->worker->zrle.fb;
 
     vnc_raw_send_framebuffer_update(vs, x, y, w, h);
 
-    vs->zrle->fb = vs->output;
+    vs->worker->zrle.fb = vs->output;
     vs->output = tmp;
-    return vs->zrle->fb.buffer;
+    return vs->worker->zrle.fb.buffer;
 }
 
 static int zrle_compress_data(VncState *vs, int level)
 {
-    z_streamp zstream = &vs->zrle->stream;
+    VncZrle *zrle = &vs->worker->zrle;
+    z_streamp zstream = &zrle->stream;
 
-    buffer_reset(&vs->zrle->zlib);
+    buffer_reset(&zrle->zlib);
 
     if (zstream->opaque != vs) {
         int err;
@@ -93,13 +94,13 @@ static int zrle_compress_data(VncState *vs, int level)
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
@@ -108,8 +109,8 @@ static int zrle_compress_data(VncState *vs, int level)
         return -1;
     }
 
-    vs->zrle->zlib.offset = vs->zrle->zlib.capacity - zstream->avail_out;
-    return vs->zrle->zlib.offset;
+    zrle->zlib.offset = zrle->zlib.capacity - zstream->avail_out;
+    return zrle->zlib.offset;
 }
 
 /* Try to work out whether to use RLE and/or a palette.  We do this by
@@ -259,14 +260,14 @@ static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
     size_t bytes;
     int zywrle_level;
 
-    if (vs->zrle->type == VNC_ENCODING_ZYWRLE) {
-        if (!vs->vd->lossy || vs->tight->quality == (uint8_t)-1
-            || vs->tight->quality == 9) {
+    if (vs->worker->zrle.type == VNC_ENCODING_ZYWRLE) {
+        if (!vs->vd->lossy || vs->worker->tight.quality == (uint8_t)-1
+            || vs->worker->tight.quality == 9) {
             zywrle_level = 0;
-            vs->zrle->type = VNC_ENCODING_ZRLE;
-        } else if (vs->tight->quality < 3) {
+            vs->worker->zrle.type = VNC_ENCODING_ZRLE;
+        } else if (vs->worker->tight.quality < 3) {
             zywrle_level = 3;
-        } else if (vs->tight->quality < 6) {
+        } else if (vs->worker->tight.quality < 6) {
             zywrle_level = 2;
         } else {
             zywrle_level = 1;
@@ -337,30 +338,30 @@ static int zrle_send_framebuffer_update(VncState *vs, int x, int y,
 
     vnc_zrle_stop(vs);
     bytes = zrle_compress_data(vs, Z_DEFAULT_COMPRESSION);
-    vnc_framebuffer_update(vs, x, y, w, h, vs->zrle->type);
+    vnc_framebuffer_update(vs, x, y, w, h, vs->worker->zrle.type);
     vnc_write_u32(vs, bytes);
-    vnc_write(vs, vs->zrle->zlib.buffer, vs->zrle->zlib.offset);
+    vnc_write(vs, vs->worker->zrle.zlib.buffer, vs->worker->zrle.zlib.offset);
     return 1;
 }
 
 int vnc_zrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 {
-    vs->zrle->type = VNC_ENCODING_ZRLE;
+    vs->worker->zrle.type = VNC_ENCODING_ZRLE;
     return zrle_send_framebuffer_update(vs, x, y, w, h);
 }
 
 int vnc_zywrle_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 {
-    vs->zrle->type = VNC_ENCODING_ZYWRLE;
+    vs->worker->zrle.type = VNC_ENCODING_ZYWRLE;
     return zrle_send_framebuffer_update(vs, x, y, w, h);
 }
 
 void vnc_zrle_clear(VncState *vs)
 {
-    if (vs->zrle->stream.opaque) {
-        deflateEnd(&vs->zrle->stream);
+    if (vs->worker->zrle.stream.opaque) {
+        deflateEnd(&vs->worker->zrle.stream);
     }
-    buffer_free(&vs->zrle->zrle);
-    buffer_free(&vs->zrle->fb);
-    buffer_free(&vs->zrle->zlib);
+    buffer_free(&vs->worker->zrle.zrle);
+    buffer_free(&vs->worker->zrle.fb);
+    buffer_free(&vs->worker->zrle.zlib);
 }
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index fcca7ec632b1..d019d88536b7 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -185,14 +185,12 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->vnc_encoding = orig->vnc_encoding;
     local->features = orig->features;
     local->vd = orig->vd;
-    local->lossy_rect = orig->lossy_rect;
+    local->worker = orig->worker;
     local->write_pixels = orig->write_pixels;
     local->client_pf = orig->client_pf;
     local->client_be = orig->client_be;
-    local->tight = orig->tight;
     local->zlib = orig->zlib;
     local->hextile = orig->hextile;
-    local->zrle = orig->zrle;
     local->client_width = orig->client_width;
     local->client_height = orig->client_height;
 }
@@ -200,11 +198,8 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
 static void vnc_async_encoding_end(VncState *orig, VncState *local)
 {
     buffer_free(&local->output);
-    orig->tight = local->tight;
     orig->zlib = local->zlib;
     orig->hextile = local->hextile;
-    orig->zrle = local->zrle;
-    orig->lossy_rect = local->lossy_rect;
 }
 
 static bool vnc_worker_clamp_rect(VncState *vs, VncJob *job, VncRect *rect)
diff --git a/ui/vnc.c b/ui/vnc.c
index 9e097dc4b46d..17fcf377d7f8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1306,8 +1306,6 @@ static void vnc_disconnect_start(VncState *vs)
 
 void vnc_disconnect_finish(VncState *vs)
 {
-    int i;
-
     trace_vnc_client_disconnect_finish(vs, vs->ioc);
 
     vnc_jobs_join(vs); /* Wait encoding jobs */
@@ -1350,18 +1348,13 @@ void vnc_disconnect_finish(VncState *vs)
     }
     buffer_free(&vs->jobs_buffer);
 
-    for (i = 0; i < VNC_STAT_ROWS; ++i) {
-        g_free(vs->lossy_rect[i]);
-    }
-    g_free(vs->lossy_rect);
+    g_free(vs->worker);
 
     object_unref(OBJECT(vs->ioc));
     vs->ioc = NULL;
     object_unref(OBJECT(vs->sioc));
     vs->sioc = NULL;
     vs->magic = 0;
-    g_free(vs->zrle);
-    g_free(vs->tight);
     g_free(vs);
 }
 
@@ -2131,8 +2124,8 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
 
     vs->features = 0;
     vs->vnc_encoding = 0;
-    vs->tight->compression = 9;
-    vs->tight->quality = -1; /* Lossless by default */
+    vs->worker->tight.compression = 9;
+    vs->worker->tight.quality = -1; /* Lossless by default */
     vs->absolute = -1;
 
     /*
@@ -2220,11 +2213,11 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vnc_server_cut_text_caps(vs);
             break;
         case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
-            vs->tight->compression = (enc & 0x0F);
+            vs->worker->tight.compression = (enc & 0x0F);
             break;
         case VNC_ENCODING_QUALITYLEVEL0 ... VNC_ENCODING_QUALITYLEVEL0 + 9:
             if (vs->vd->lossy) {
-                vs->tight->quality = (enc & 0x0F);
+                vs->worker->tight.quality = (enc & 0x0F);
             }
             break;
         default:
@@ -2963,7 +2956,7 @@ void vnc_sent_lossy_rect(VncState *vs, int x, int y, int w, int h)
 
     for (j = y; j <= h; j++) {
         for (i = x; i <= w; i++) {
-            vs->lossy_rect[j][i] = 1;
+            vs->worker->lossy_rect[j][i] = 1;
         }
     }
 }
@@ -2986,11 +2979,11 @@ static int vnc_refresh_lossy_rect(VncDisplay *vd, int x, int y)
             continue;
         }
 
-        if (!vs->lossy_rect[sty][stx]) {
+        if (!vs->worker->lossy_rect[sty][stx]) {
             continue;
         }
 
-        vs->lossy_rect[sty][stx] = 0;
+        vs->worker->lossy_rect[sty][stx] = 0;
         for (j = 0; j < VNC_STAT_RECT; ++j) {
             bitmap_set(vs->dirty[y + j],
                        x / VNC_DIRTY_PIXELS_PER_BIT,
@@ -3242,11 +3235,9 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 {
     VncState *vs = g_new0(VncState, 1);
     bool first_client = QTAILQ_EMPTY(&vd->clients);
-    int i;
 
     trace_vnc_client_connect(vs, sioc);
-    vs->zrle = g_new0(VncZrle, 1);
-    vs->tight = g_new0(VncTight, 1);
+    vs->worker = g_new0(VncWorker, 1);
     vs->magic = VNC_MAGIC;
     vs->sioc = sioc;
     object_ref(OBJECT(vs->sioc));
@@ -3254,23 +3245,23 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     object_ref(OBJECT(vs->ioc));
     vs->vd = vd;
 
-    buffer_init(&vs->input,          "vnc-input/%p", sioc);
-    buffer_init(&vs->output,         "vnc-output/%p", sioc);
-    buffer_init(&vs->jobs_buffer,    "vnc-jobs_buffer/%p", sioc);
+    buffer_init(&vs->input,                  "vnc-input/%p", sioc);
+    buffer_init(&vs->output,                 "vnc-output/%p", sioc);
+    buffer_init(&vs->jobs_buffer,            "vnc-jobs_buffer/%p", sioc);
 
-    buffer_init(&vs->tight->tight,    "vnc-tight/%p", sioc);
-    buffer_init(&vs->tight->zlib,     "vnc-tight-zlib/%p", sioc);
-    buffer_init(&vs->tight->gradient, "vnc-tight-gradient/%p", sioc);
+    buffer_init(&vs->worker->tight.tight,    "vnc-tight/%p", sioc);
+    buffer_init(&vs->worker->tight.zlib,     "vnc-tight-zlib/%p", sioc);
+    buffer_init(&vs->worker->tight.gradient, "vnc-tight-gradient/%p", sioc);
 #ifdef CONFIG_VNC_JPEG
-    buffer_init(&vs->tight->jpeg,     "vnc-tight-jpeg/%p", sioc);
+    buffer_init(&vs->worker->tight.jpeg,     "vnc-tight-jpeg/%p", sioc);
 #endif
 #ifdef CONFIG_PNG
-    buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
+    buffer_init(&vs->worker->tight.png,      "vnc-tight-png/%p", sioc);
 #endif
-    buffer_init(&vs->zlib.zlib,      "vnc-zlib/%p", sioc);
-    buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
-    buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
-    buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);
+    buffer_init(&vs->zlib.zlib,              "vnc-zlib/%p", sioc);
+    buffer_init(&vs->worker->zrle.zrle,      "vnc-zrle/%p", sioc);
+    buffer_init(&vs->worker->zrle.fb,        "vnc-zrle-fb/%p", sioc);
+    buffer_init(&vs->worker->zrle.zlib,      "vnc-zrle-zlib/%p", sioc);
 
     if (skipauth) {
         vs->auth = VNC_AUTH_NONE;
@@ -3287,11 +3278,6 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
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
index 2ef7501d5216..964beef74bdd 100644
--- a/ui/vnc-enc-zrle.c.inc
+++ b/ui/vnc-enc-zrle.c.inc
@@ -96,7 +96,7 @@ static void ZRLE_ENCODE(VncState *vs, int x, int y, int w, int h,
 static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
                              int zywrle_level)
 {
-    VncPalette *palette = &vs->zrle->palette;
+    VncPalette *palette = &vs->worker->zrle.palette;
 
     int runs = 0;
     int single_pixels = 0;

-- 
2.49.0


