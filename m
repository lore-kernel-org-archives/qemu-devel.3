Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D130C5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLN5K-0002kx-8B; Sat, 31 May 2025 10:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLN5G-0002kD-C2
 for qemu-devel@nongnu.org; Sat, 31 May 2025 10:21:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uLN5D-0007nM-Bj
 for qemu-devel@nongnu.org; Sat, 31 May 2025 10:21:14 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 54VEKrPa069146
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 31 May 2025 23:20:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0TzJO7aszXohfGSpFv6MxysdZXOeS4wdCSQFZAFq2lQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1748701259; v=1;
 b=Csh1visLiz9H3y8aldDZuQvfugmyShs906h96UGZGV3WTbxkNMD88UOFnxlLWZim
 BoZ8MiIuwbeR5OT+j8V/kQdBztWpy0qx//9C3A2V+ODZhG23wem1hI6VMDg264Bo
 a3vXTKnDNvbJiJ0ppZgB1WcR7oZ8Tr0n7d/UEAPCjR+I6p0CbxfZRxTOOOdkLQOa
 N5IFWDulrbFwVHxHJBA5s3S9fs9Mu8BgbcwRrYvZWF4jfTBFv533rNTqxJ13eii+
 E0+KL8TahXLUDbpoFkwkKzKC7bAYChWt6QIhJMuSgR6xY9HbAWbWuVQgEFquAwSX
 x3tgy+Ha3vZ0zdlwkUJrGA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 31 May 2025 23:20:42 +0900
Subject: [PATCH v2 2/2] ui/vnc: Do not copy z_stream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250531-zlib-v2-2-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
References: <20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250531-zlib-v2-0-b75c4b4769e1@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

vnc_worker_thread_loop() copies z_stream stored in its local VncState to
the persistent VncState, and the copied one is freed with deflateEnd()
later. However, deflateEnd() refuses to operate with a copied z_stream
and returns Z_STREAM_ERROR, leaking the allocated memory.

Avoid copying the zlib state to fix the memory leak.

Fixes: bd023f953e5e ("vnc: threaded VNC server")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/vnc.h          |  2 +-
 ui/vnc-enc-zlib.c | 30 +++++++++++++++---------------
 ui/vnc-jobs.c     |  2 --
 ui/vnc.c          |  2 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 1dc76c270c35..78a5fdfdc0d0 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -265,6 +265,7 @@ typedef struct VncWorker {
     uint8_t lossy_rect[VNC_STAT_ROWS][VNC_STAT_COLS];
 
     VncTight tight;
+    VncZlib zlib;
     VncZrle zrle;
 } VncWorker;
 
@@ -345,7 +346,6 @@ struct VncState
     /* Encoding specific, if you add something here, don't forget to
      *  update vnc_async_encoding_start()
      */
-    VncZlib zlib;
     VncHextile hextile;
     VncZywrle zywrle;
 
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index 605030730a44..d8b4cf038b02 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -48,21 +48,21 @@ void vnc_zlib_zfree(void *x, void *addr)
 
 static void vnc_zlib_start(VncState *vs)
 {
-    buffer_reset(&vs->zlib.zlib);
+    buffer_reset(&vs->worker->zlib.zlib);
 
     // make the output buffer be the zlib buffer, so we can compress it later
-    vs->zlib.tmp = vs->output;
-    vs->output = vs->zlib.zlib;
+    vs->worker->zlib.tmp = vs->output;
+    vs->output = vs->worker->zlib.zlib;
 }
 
 static int vnc_zlib_stop(VncState *vs)
 {
-    z_streamp zstream = &vs->zlib.stream;
+    z_streamp zstream = &vs->worker->zlib.stream;
     int previous_out;
 
     // switch back to normal output/zlib buffers
-    vs->zlib.zlib = vs->output;
-    vs->output = vs->zlib.tmp;
+    vs->worker->zlib.zlib = vs->output;
+    vs->output = vs->worker->zlib.tmp;
 
     // compress the zlib buffer
 
@@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)
             return -1;
         }
 
-        vs->zlib.level = vs->worker->tight.compression;
+        vs->worker->zlib.level = vs->worker->tight.compression;
         zstream->opaque = vs;
     }
 
-    if (vs->worker->tight.compression != vs->zlib.level) {
+    if (vs->worker->tight.compression != vs->worker->zlib.level) {
         if (deflateParams(zstream, vs->worker->tight.compression,
                           Z_DEFAULT_STRATEGY) != Z_OK) {
             return -1;
         }
-        vs->zlib.level = vs->worker->tight.compression;
+        vs->worker->zlib.level = vs->worker->tight.compression;
     }
 
     // reserve memory in output buffer
-    buffer_reserve(&vs->output, vs->zlib.zlib.offset + 64);
+    buffer_reserve(&vs->output, vs->worker->zlib.zlib.offset + 64);
 
     // set pointers
-    zstream->next_in = vs->zlib.zlib.buffer;
-    zstream->avail_in = vs->zlib.zlib.offset;
+    zstream->next_in = vs->worker->zlib.zlib.buffer;
+    zstream->avail_in = vs->worker->zlib.zlib.offset;
     zstream->next_out = vs->output.buffer + vs->output.offset;
     zstream->avail_out = vs->output.capacity - vs->output.offset;
     previous_out = zstream->avail_out;
@@ -147,8 +147,8 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 
 void vnc_zlib_clear(VncState *vs)
 {
-    if (vs->zlib.stream.opaque) {
-        deflateEnd(&vs->zlib.stream);
+    if (vs->worker->zlib.stream.opaque) {
+        deflateEnd(&vs->worker->zlib.stream);
     }
-    buffer_free(&vs->zlib.zlib);
+    buffer_free(&vs->worker->zlib.zlib);
 }
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index d019d88536b7..dbbf62212c79 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -189,7 +189,6 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->write_pixels = orig->write_pixels;
     local->client_pf = orig->client_pf;
     local->client_be = orig->client_be;
-    local->zlib = orig->zlib;
     local->hextile = orig->hextile;
     local->client_width = orig->client_width;
     local->client_height = orig->client_height;
@@ -198,7 +197,6 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
 static void vnc_async_encoding_end(VncState *orig, VncState *local)
 {
     buffer_free(&local->output);
-    orig->zlib = local->zlib;
     orig->hextile = local->hextile;
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 17fcf377d7f8..b55d80b9b003 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3258,7 +3258,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 #ifdef CONFIG_PNG
     buffer_init(&vs->worker->tight.png,      "vnc-tight-png/%p", sioc);
 #endif
-    buffer_init(&vs->zlib.zlib,              "vnc-zlib/%p", sioc);
+    buffer_init(&vs->worker->zlib.zlib,      "vnc-zlib/%p", sioc);
     buffer_init(&vs->worker->zrle.zrle,      "vnc-zrle/%p", sioc);
     buffer_init(&vs->worker->zrle.fb,        "vnc-zrle-fb/%p", sioc);
     buffer_init(&vs->worker->zrle.zlib,      "vnc-zrle-zlib/%p", sioc);

-- 
2.49.0


