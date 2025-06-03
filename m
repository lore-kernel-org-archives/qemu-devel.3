Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC1AC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNnW-0008DP-1K; Tue, 03 Jun 2025 05:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uMNnQ-0008CT-P4
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:19:00 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uMNnO-0006qZ-4I
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:19:00 -0400
Received: from [157.82.207.189] ([157.82.207.189]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5539IXBr068202
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Jun 2025 18:18:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=i+9IXxLbNNTv0+eQeCmOrjhMgfmv8aIWRVgOi+1Dim0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1748942324; v=1;
 b=M1jmFjabE+mYbZHew1AsOQj25s5kZuPS5XqpedRqz95i81mtBsgCzP8mS1LfMqwz
 dSRFEDs7nNA7cORTDcxfLOKFqRT5+iR6t8sIx3pYuui7VB3oMf48XAU/yqxUTjnL
 v8svHdFVTZ+4l/2lkZC8xD6RcPUqJ3USKLBzmPn9ftY933t926v/L48pABoDTY7e
 5oVpYq307oErV/q/07HQn1xp9hQo5rv6W3fzCLNWJ+4JSU+/gcmCNK/tCHDLvp7O
 icFai2eDCX1qPh0XuSbtbqhs8VwPJoiIrZIAdUUUGtzOgCbdiJ5lMOdIKH9Q1b8m
 fk8jrWwRLRxogELicQ6Gjg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 03 Jun 2025 18:18:28 +0900
Subject: [PATCH v3 1/2] ui/vnc: Do not copy z_stream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-zlib-v3-1-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
References: <20250603-zlib-v3-0-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250603-zlib-v3-0-20b857bd8d05@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@daynix.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
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
---
 ui/vnc.h          |  2 +-
 ui/vnc-enc-zlib.c | 30 +++++++++++++++---------------
 ui/vnc.c          | 13 ++++++++++---
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 02613aa63a170901734a04aee84abff7b58d8736..82b883bb69fa5ce331945dcffe25588d5fd73f50 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -340,7 +340,7 @@ struct VncState
      *  update vnc_async_encoding_start()
      */
     VncTight *tight;
-    VncZlib zlib;
+    VncZlib *zlib;
     VncHextile hextile;
     VncZrle *zrle;
     VncZywrle zywrle;
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index 900ae5b30f6bd2ddbcd797d212c010c48d451094..52e9193eab572a79733b11c89bde81daf01679e7 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -48,21 +48,21 @@ void vnc_zlib_zfree(void *x, void *addr)
 
 static void vnc_zlib_start(VncState *vs)
 {
-    buffer_reset(&vs->zlib.zlib);
+    buffer_reset(&vs->zlib->zlib);
 
     // make the output buffer be the zlib buffer, so we can compress it later
-    vs->zlib.tmp = vs->output;
-    vs->output = vs->zlib.zlib;
+    vs->zlib->tmp = vs->output;
+    vs->output = vs->zlib->zlib;
 }
 
 static int vnc_zlib_stop(VncState *vs)
 {
-    z_streamp zstream = &vs->zlib.stream;
+    z_streamp zstream = &vs->zlib->stream;
     int previous_out;
 
     // switch back to normal output/zlib buffers
-    vs->zlib.zlib = vs->output;
-    vs->output = vs->zlib.tmp;
+    vs->zlib->zlib = vs->output;
+    vs->output = vs->zlib->tmp;
 
     // compress the zlib buffer
 
@@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)
             return -1;
         }
 
-        vs->zlib.level = vs->tight->compression;
+        vs->zlib->level = vs->tight->compression;
         zstream->opaque = vs;
     }
 
-    if (vs->tight->compression != vs->zlib.level) {
+    if (vs->tight->compression != vs->zlib->level) {
         if (deflateParams(zstream, vs->tight->compression,
                           Z_DEFAULT_STRATEGY) != Z_OK) {
             return -1;
         }
-        vs->zlib.level = vs->tight->compression;
+        vs->zlib->level = vs->tight->compression;
     }
 
     // reserve memory in output buffer
-    buffer_reserve(&vs->output, vs->zlib.zlib.offset + 64);
+    buffer_reserve(&vs->output, vs->zlib->zlib.offset + 64);
 
     // set pointers
-    zstream->next_in = vs->zlib.zlib.buffer;
-    zstream->avail_in = vs->zlib.zlib.offset;
+    zstream->next_in = vs->zlib->zlib.buffer;
+    zstream->avail_in = vs->zlib->zlib.offset;
     zstream->next_out = vs->output.buffer + vs->output.offset;
     zstream->avail_out = vs->output.capacity - vs->output.offset;
     previous_out = zstream->avail_out;
@@ -147,8 +147,8 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 
 void vnc_zlib_clear(VncState *vs)
 {
-    if (vs->zlib.stream.opaque) {
-        deflateEnd(&vs->zlib.stream);
+    if (vs->zlib->stream.opaque) {
+        deflateEnd(&vs->zlib->stream);
     }
-    buffer_free(&vs->zlib.zlib);
+    buffer_free(&vs->zlib->zlib);
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index d095cd7da31e2fe0d7241894b7ed5d2cbb21f72c..59009ff61b350487153960d0236eb438f93e665b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -56,6 +56,11 @@
 #include "io/dns-resolver.h"
 #include "monitor/monitor.h"
 
+typedef struct VncConnection {
+    VncState vs;
+    VncZlib zlib;
+} VncConnection;
+
 #define VNC_REFRESH_INTERVAL_BASE GUI_REFRESH_INTERVAL_DEFAULT
 #define VNC_REFRESH_INTERVAL_INC  50
 #define VNC_REFRESH_INTERVAL_MAX  GUI_REFRESH_INTERVAL_IDLE
@@ -1362,7 +1367,7 @@ void vnc_disconnect_finish(VncState *vs)
     vs->magic = 0;
     g_free(vs->zrle);
     g_free(vs->tight);
-    g_free(vs);
+    g_free(container_of(vs, VncConnection, vs));
 }
 
 size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
@@ -3241,11 +3246,13 @@ static void vnc_refresh(DisplayChangeListener *dcl)
 static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
                         bool skipauth, bool websocket)
 {
-    VncState *vs = g_new0(VncState, 1);
+    VncConnection *vc = g_new0(VncConnection, 1);
+    VncState *vs = &vc->vs;
     bool first_client = QTAILQ_EMPTY(&vd->clients);
     int i;
 
     trace_vnc_client_connect(vs, sioc);
+    vs->zlib = &vc->zlib;
     vs->zrle = g_new0(VncZrle, 1);
     vs->tight = g_new0(VncTight, 1);
     vs->magic = VNC_MAGIC;
@@ -3268,7 +3275,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 #ifdef CONFIG_PNG
     buffer_init(&vs->tight->png,      "vnc-tight-png/%p", sioc);
 #endif
-    buffer_init(&vs->zlib.zlib,      "vnc-zlib/%p", sioc);
+    buffer_init(&vc->zlib.zlib,      "vnc-zlib/%p", sioc);
     buffer_init(&vs->zrle->zrle,      "vnc-zrle/%p", sioc);
     buffer_init(&vs->zrle->fb,        "vnc-zrle-fb/%p", sioc);
     buffer_init(&vs->zrle->zlib,      "vnc-zrle-zlib/%p", sioc);

-- 
2.49.0


