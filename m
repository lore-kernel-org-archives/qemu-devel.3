Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F338CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcHV-0002w8-PV; Sat, 09 May 2026 03:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcHS-0002p6-Rn
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcHQ-0007Zj-5a
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9HfPgCd6Efsa5oTjlVY/lDr783HcOZnf69yIWnUX8U=;
 b=KbwA+gsYeGDS/dzJXl0ePcA2SxBSCiC62jokO4JVTu10jyElo8/3lDBeF4ZCG06Z9Kq1Hn
 s9if/x8u2mhVt0jiRXzlMtQY6HVNst/5tYEoItDWfItUWt1uD9Dy/8H2q+9yLeqh9R+Mf5
 XlsdHzjsUE8qeb8ii7qjRh8UwiriwK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-x_3Y_-bGMIimJ1pqo0lpFA-1; Sat,
 09 May 2026 03:39:17 -0400
X-MC-Unique: x_3Y_-bGMIimJ1pqo0lpFA-1
X-Mimecast-MFC-AGG-ID: x_3Y_-bGMIimJ1pqo0lpFA_1778312357
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D61AD195609E; Sat,  9 May 2026 07:39:16 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28F3B180034E; Sat,  9 May 2026 07:39:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 29/32] ui/vnc: replace VNC_DEBUG with trace-events
Date: Sat,  9 May 2026 11:36:15 +0400
Message-ID: <20260509073621.1011778-30-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace #ifdef printf() with run-time trace events.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h           |  8 -----
 ui/vnc-auth-sasl.c | 13 +++-----
 ui/vnc-enc-tight.c |  4 +--
 ui/vnc-enc-zlib.c  |  4 +--
 ui/vnc-ws.c        | 10 +++---
 ui/vnc.c           | 83 +++++++++++++++++-----------------------------
 ui/trace-events    | 29 +++++++++++++++-
 7 files changed, 73 insertions(+), 78 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 0b345246c8e..0750bf5f72f 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -46,14 +46,6 @@
 #include "vnc-enc-zrle.h"
 #include "ui/kbd-state.h"
 
-// #define _VNC_DEBUG 1
-
-#ifdef _VNC_DEBUG
-#define VNC_DEBUG(fmt, ...) do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define VNC_DEBUG(fmt, ...) do { } while (0)
-#endif
-
 /*****************************************************************************
  *
  * Core data structures
diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 3f4cfc471d5..9964b969ac2 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -73,10 +73,10 @@ size_t vnc_client_write_sasl(VncState *vs)
 {
     size_t ret;
 
-    VNC_DEBUG("Write SASL: Pending output %p size %zd offset %zd "
-              "Encoded: %p size %d offset %d\n",
-              vs->output.buffer, vs->output.capacity, vs->output.offset,
-              vs->sasl.encoded, vs->sasl.encodedLength, vs->sasl.encodedOffset);
+    trace_vnc_sasl_write_pending(vs, vs->output.buffer, vs->output.capacity,
+                                 vs->output.offset, vs->sasl.encoded,
+                                 vs->sasl.encodedLength,
+                                 vs->sasl.encodedOffset);
 
     if (!vs->sasl.encoded) {
         int err;
@@ -157,8 +157,7 @@ size_t vnc_client_read_sasl(VncState *vs)
 
     if (err != SASL_OK)
         return vnc_client_io_error(vs, -1, NULL);
-    VNC_DEBUG("Read SASL Encoded %p size %ld Decoded %p size %d\n",
-              encoded, ret, decoded, decodedLen);
+    trace_vnc_sasl_read_decoded(vs, encoded, ret, decoded, decodedLen);
     buffer_reserve(&vs->input, decodedLen);
     buffer_append(&vs->input, decoded, decodedLen);
     return decodedLen;
@@ -717,5 +716,3 @@ void start_auth_sasl(VncState *vs)
     error_free(local_err);
     vnc_client_error(vs);
 }
-
-
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 9dfe6ae5a24..ca671427018 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -46,6 +46,7 @@
 #include "vnc.h"
 #include "vnc-enc-tight.h"
 #include "vnc-palette.h"
+#include "trace.h"
 
 /* Compression level stuff. The following array contains various
    encoder parameters for each of 10 compression levels (0..9).
@@ -795,8 +796,7 @@ static int tight_init_stream(VncState *vs, VncTight *tight, int stream_id,
     if (zstream->opaque == NULL) {
         int err;
 
-        VNC_DEBUG("VNC: TIGHT: initializing zlib stream %d\n", stream_id);
-        VNC_DEBUG("VNC: TIGHT: opaque = %p | vs = %p\n", zstream->opaque, vs);
+        trace_vnc_tight_zlib_init(vs, stream_id, zstream->opaque);
         zstream->zalloc = vnc_zlib_zalloc;
         zstream->zfree = vnc_zlib_zfree;
 
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index a6d287118aa..657b47ceb2b 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "vnc.h"
+#include "trace.h"
 
 #define ZALLOC_ALIGNMENT 16
 
@@ -71,8 +72,7 @@ static int vnc_zlib_stop(VncState *vs, VncWorker *worker)
     if (zstream->opaque != vs) {
         int err;
 
-        VNC_DEBUG("VNC: initializing zlib stream\n");
-        VNC_DEBUG("VNC: opaque = %p | vs = %p\n", zstream->opaque, vs);
+        trace_vnc_zlib_init(vs, zstream->opaque);
         zstream->zalloc = vnc_zlib_zalloc;
         zstream->zfree = vnc_zlib_zfree;
 
diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
index 65e8b344b65..fad5dbce342 100644
--- a/ui/vnc-ws.c
+++ b/ui/vnc-ws.c
@@ -32,11 +32,11 @@ static void vncws_tls_handshake_done(QIOTask *task,
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
-        VNC_DEBUG("Handshake failed %s\n", error_get_pretty(err));
+        trace_vnc_ws_tls_handshake_fail(vs, error_get_pretty(err));
         vnc_client_error(vs);
         error_free(err);
     } else {
-        VNC_DEBUG("TLS handshake complete, starting websocket handshake\n");
+        trace_vnc_ws_tls_handshake_complete(vs);
         if (vs->ioc_tag) {
             g_source_remove(vs->ioc_tag);
         }
@@ -67,7 +67,7 @@ gboolean vncws_tls_handshake_io(QIOChannel *ioc G_GNUC_UNUSED,
         vs->vd->tlsauthzid,
         &err);
     if (!tls) {
-        VNC_DEBUG("Failed to setup TLS %s\n", error_get_pretty(err));
+        trace_vnc_ws_tls_setup_fail(vs, error_get_pretty(err));
         error_free(err);
         vnc_client_error(vs);
         return TRUE;
@@ -97,11 +97,11 @@ static void vncws_handshake_done(QIOTask *task,
     Error *err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
-        VNC_DEBUG("Websock handshake failed %s\n", error_get_pretty(err));
+        trace_vnc_ws_handshake_fail(vs, error_get_pretty(err));
         vnc_client_error(vs);
         error_free(err);
     } else {
-        VNC_DEBUG("Websock handshake complete, starting VNC protocol\n");
+        trace_vnc_ws_handshake_complete(vs);
         vnc_start_protocol(vs);
         if (vs->ioc_tag) {
             g_source_remove(vs->ioc_tag);
diff --git a/ui/vnc.c b/ui/vnc.c
index d3dfabede03..56dd43d53ff 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -75,17 +75,7 @@ static void vnc_disconnect_finish(VncState *vs);
 
 static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
 {
-#ifdef _VNC_DEBUG
-    static const char *mn[] = {
-        [0]                           = "undefined",
-        [VNC_SHARE_MODE_CONNECTING]   = "connecting",
-        [VNC_SHARE_MODE_SHARED]       = "shared",
-        [VNC_SHARE_MODE_EXCLUSIVE]    = "exclusive",
-        [VNC_SHARE_MODE_DISCONNECTED] = "disconnected",
-    };
-    fprintf(stderr, "%s/%p: %s -> %s\n", __func__,
-            vs->ioc, mn[vs->share_mode], mn[mode]);
-#endif
+    trace_vnc_set_share_mode(vs, vs->ioc, vs->share_mode, mode);
 
     switch (vs->share_mode) {
     case VNC_SHARE_MODE_CONNECTING:
@@ -185,8 +175,9 @@ static void vnc_init_basic_info_from_remote_addr(QIOChannelSocket *ioc,
     qapi_free_SocketAddress(addr);
 }
 
-static const char *vnc_auth_name(VncDisplay *vd) {
-    switch (vd->auth) {
+static const char *vnc_auth_name(int auth, int subauth)
+{
+    switch (auth) {
     case VNC_AUTH_INVALID:
         return "invalid";
     case VNC_AUTH_NONE:
@@ -204,7 +195,7 @@ static const char *vnc_auth_name(VncDisplay *vd) {
     case VNC_AUTH_TLS:
         return "tls";
     case VNC_AUTH_VENCRYPT:
-        switch (vd->subauth) {
+        switch (subauth) {
         case VNC_AUTH_VENCRYPT_PLAIN:
             return "vencrypt+plain";
         case VNC_AUTH_VENCRYPT_TLSNONE:
@@ -244,7 +235,7 @@ static VncServerInfo *vnc_server_info_get(VncDisplay *vd)
     info = g_malloc0(sizeof(*info));
     vnc_init_basic_info_from_server_addr(qio_net_listener_sioc(vd->listener, 0),
                                          qapi_VncServerInfo_base(info), &err);
-    info->auth = g_strdup(vnc_auth_name(vd));
+    info->auth = g_strdup(vnc_auth_name(vd->auth, vd->subauth));
     if (err) {
         qapi_free_VncServerInfo(info);
         info = NULL;
@@ -421,7 +412,7 @@ VncInfo *qmp_query_vnc(Error **errp)
 
         info->has_family = true;
 
-        info->auth = g_strdup(vnc_auth_name(vd));
+        info->auth = g_strdup(vnc_auth_name(vd->auth, vd->subauth));
     }
 
     qapi_free_SocketAddress(addr);
@@ -1383,7 +1374,7 @@ size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
 
 void vnc_client_error(VncState *vs)
 {
-    VNC_DEBUG("Closing down client sock: protocol error\n");
+    trace_vnc_client_protocol_error(vs);
     vnc_disconnect_start(vs);
 }
 
@@ -1408,7 +1399,7 @@ size_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen)
     Error *err = NULL;
     ssize_t ret;
     ret = qio_channel_write(vs->ioc, (const char *)data, datalen, &err);
-    VNC_DEBUG("Wrote wire %p %zd -> %ld\n", data, datalen, ret);
+    trace_vnc_client_write_wire(vs, data, datalen, ret);
     return vnc_client_io_error(vs, ret, err);
 }
 
@@ -1429,9 +1420,9 @@ static size_t vnc_client_write_plain(VncState *vs)
     size_t ret;
 
 #ifdef CONFIG_VNC_SASL
-    VNC_DEBUG("Write Plain: Pending output %p size %zd offset %zd. Wait SSF %d\n",
-              vs->output.buffer, vs->output.capacity, vs->output.offset,
-              vs->sasl.waitWriteSSF);
+    trace_vnc_client_write_plain(vs, vs->output.buffer,
+                                 vs->output.capacity, vs->output.offset,
+                                 vs->sasl.waitWriteSSF);
 
     if (vs->sasl.conn &&
         vs->sasl.runSSF &&
@@ -1532,7 +1523,7 @@ size_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen)
     ssize_t ret;
     Error *err = NULL;
     ret = qio_channel_read(vs->ioc, (char *)data, datalen, &err);
-    VNC_DEBUG("Read wire %p %zd -> %ld\n", data, datalen, ret);
+    trace_vnc_client_read_wire(vs, data, datalen, ret);
     return vnc_client_io_error(vs, ret, err);
 }
 
@@ -1549,8 +1540,8 @@ size_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen)
 static size_t vnc_client_read_plain(VncState *vs)
 {
     size_t ret;
-    VNC_DEBUG("Read plain %p size %zd offset %zd\n",
-              vs->input.buffer, vs->input.capacity, vs->input.offset);
+    trace_vnc_client_read_plain(vs, vs->input.buffer,
+                                vs->input.capacity, vs->input.offset);
     buffer_reserve(&vs->input, 4096);
     ret = vnc_client_read_buf(vs, buffer_end(&vs->input), 4096);
     if (!ret)
@@ -2213,7 +2204,7 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             }
             break;
         default:
-            VNC_DEBUG("Unknown encoding: %d (0x%.8x): %d\n", i, enc, enc);
+            trace_vnc_client_unknown_encoding(vs, i, enc);
             break;
         }
     }
@@ -2581,14 +2572,13 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                 case 4: vs->as.fmt = AUDIO_FORMAT_U32; break;
                 case 5: vs->as.fmt = AUDIO_FORMAT_S32; break;
                 default:
-                    VNC_DEBUG("Invalid audio format %d\n", read_u8(data, 4));
+                    trace_vnc_client_invalid_audio_format(vs, read_u8(data, 4));
                     vnc_client_error(vs);
                     break;
                 }
                 vs->as.nchannels = read_u8(data, 5);
                 if (vs->as.nchannels != 1 && vs->as.nchannels != 2) {
-                    VNC_DEBUG("Invalid audio channel count %d\n",
-                              read_u8(data, 5));
+                    trace_vnc_client_invalid_audio_channels(vs, read_u8(data, 5));
                     vnc_client_error(vs);
                     break;
                 }
@@ -2598,7 +2588,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                  * protects calculations involving 'vs->as.freq' later.
                  */
                 if (freq > 48000) {
-                    VNC_DEBUG("Invalid audio frequency %u > 48000", freq);
+                    trace_vnc_client_invalid_audio_freq(vs, freq);
                     vnc_client_error(vs);
                     break;
                 }
@@ -2607,14 +2597,14 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                     vs, vs->ioc, vs->as.fmt, vs->as.nchannels, vs->as.freq);
                 break;
             default:
-                VNC_DEBUG("Invalid audio message %d\n", read_u8(data, 2));
+                trace_vnc_client_invalid_audio_msg(vs, read_u8(data, 2));
                 vnc_client_error(vs);
                 break;
             }
             break;
 
         default:
-            VNC_DEBUG("Msg: %d\n", read_u16(data, 0));
+            trace_vnc_client_unknown_qemu_msg(vs, read_u16(data, 0));
             vnc_client_error(vs);
             break;
         }
@@ -2649,7 +2639,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         break;
     }
     default:
-        VNC_DEBUG("Msg: %d\n", data[0]);
+        trace_vnc_client_unknown_msg(vs, data[0]);
         vnc_client_error(vs);
         break;
     }
@@ -2929,18 +2919,18 @@ static int protocol_version(VncState *vs, uint8_t *version, size_t len)
     local[12] = 0;
 
     if (sscanf(local, "RFB %03d.%03d\n", &vs->major, &vs->minor) != 2) {
-        VNC_DEBUG("Malformed protocol version %s\n", local);
+        trace_vnc_client_protocol_version_malformed(vs, local);
         vnc_client_error(vs);
         return 0;
     }
-    VNC_DEBUG("Client request protocol version %d.%d\n", vs->major, vs->minor);
+    trace_vnc_client_protocol_version(vs, vs->major, vs->minor);
     if (vs->major != 3 ||
         (vs->minor != 3 &&
          vs->minor != 4 &&
          vs->minor != 5 &&
          vs->minor != 7 &&
          vs->minor != 8)) {
-        VNC_DEBUG("Unsupported client version\n");
+        trace_vnc_client_protocol_version_unsupported(vs);
         vnc_write_u32(vs, VNC_AUTH_INVALID);
         vnc_flush(vs);
         vnc_client_error(vs);
@@ -2960,7 +2950,7 @@ static int protocol_version(VncState *vs, uint8_t *version, size_t len)
             trace_vnc_auth_pass(vs, vs->auth);
             start_client_init(vs);
        } else if (vs->auth == VNC_AUTH_VNC) {
-            VNC_DEBUG("Tell client VNC auth\n");
+            trace_vnc_client_auth_method(vs, vs->auth);
             vnc_write_u32(vs, vs->auth);
             vnc_flush(vs);
             start_auth_vnc(vs);
@@ -3319,10 +3309,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
             vs->subauth = vd->subauth;
         }
     }
-    VNC_DEBUG("Client sioc=%p ws=%d auth=%d subauth=%d\n",
-              sioc, websocket, vs->auth, vs->subauth);
-
-    VNC_DEBUG("New client on socket %p\n", vs->sioc);
+    trace_vnc_client_setup(vs, sioc, websocket, vs->auth, vs->subauth);
     qemu_console_listener_set_refresh(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
     qio_channel_set_blocking(vs->ioc, false, &error_abort);
     g_clear_handle_id(&vs->ioc_tag, g_source_remove);
@@ -3727,13 +3714,10 @@ vnc_display_setup_auth(int *auth,
      */
     if (websocket || !tlscreds) {
         if (password) {
-            VNC_DEBUG("Initializing VNC server with password auth\n");
             *auth = VNC_AUTH_VNC;
         } else if (sasl) {
-            VNC_DEBUG("Initializing VNC server with SASL auth\n");
             *auth = VNC_AUTH_SASL;
         } else {
-            VNC_DEBUG("Initializing VNC server with no auth\n");
             *auth = VNC_AUTH_NONE;
         }
         *subauth = VNC_AUTH_INVALID;
@@ -3752,27 +3736,20 @@ vnc_display_setup_auth(int *auth,
         *auth = VNC_AUTH_VENCRYPT;
         if (password) {
             if (is_x509) {
-                VNC_DEBUG("Initializing VNC server with x509 password auth\n");
                 *subauth = VNC_AUTH_VENCRYPT_X509VNC;
             } else {
-                VNC_DEBUG("Initializing VNC server with TLS password auth\n");
                 *subauth = VNC_AUTH_VENCRYPT_TLSVNC;
             }
-
         } else if (sasl) {
             if (is_x509) {
-                VNC_DEBUG("Initializing VNC server with x509 SASL auth\n");
                 *subauth = VNC_AUTH_VENCRYPT_X509SASL;
             } else {
-                VNC_DEBUG("Initializing VNC server with TLS SASL auth\n");
                 *subauth = VNC_AUTH_VENCRYPT_TLSSASL;
             }
         } else {
             if (is_x509) {
-                VNC_DEBUG("Initializing VNC server with x509 no auth\n");
                 *subauth = VNC_AUTH_VENCRYPT_X509NONE;
             } else {
-                VNC_DEBUG("Initializing VNC server with TLS no auth\n");
                 *subauth = VNC_AUTH_VENCRYPT_TLSNONE;
             }
         }
@@ -4221,14 +4198,16 @@ static bool vnc_display_open(VncDisplay *vd, Error **errp)
                                sasl, false, errp) < 0) {
         return false;
     }
-    trace_vnc_auth_init(vd, 0, vd->auth, vd->subauth);
+    trace_vnc_auth_init(vd, 0, vd->auth, vd->subauth,
+                        vnc_auth_name(vd->auth, vd->subauth));
 
     if (vnc_display_setup_auth(&vd->ws_auth, &vd->ws_subauth,
                                vd->tlscreds, password,
                                sasl, true, errp) < 0) {
         return false;
     }
-    trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth);
+    trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth,
+                        vnc_auth_name(vd->ws_auth, vd->ws_subauth));
 
 #ifdef CONFIG_VNC_SASL
     if (sasl && !vnc_sasl_server_init(errp)) {
diff --git a/ui/trace-events b/ui/trace-events
index 3eba9ca3a82..c1ea56874ee 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -83,7 +83,7 @@ vnc_job_discard_rect(void *state, void *job, int x, int y, int w, int h) "VNC jo
 vnc_job_clamp_rect(void *state, void *job, int x, int y, int w, int h) "VNC job clamp rect state=%p job=%p offset=%d,%d size=%dx%d"
 vnc_job_clamped_rect(void *state, void *job, int x, int y, int w, int h) "VNC job clamp rect state=%p job=%p offset=%d,%d size=%dx%d"
 vnc_job_nrects(void *state, void *job, int nrects) "VNC job state=%p job=%p nrects=%d"
-vnc_auth_init(void *display, int websock, int auth, int subauth) "VNC auth init state=%p websock=%d auth=%d subauth=%d"
+vnc_auth_init(void *display, int websock, int auth, int subauth, const char *name) "VNC auth init state=%p websock=%d auth=%d subauth=%d name=%s"
 vnc_auth_start(void *state, int method) "VNC client auth start state=%p method=%d"
 vnc_auth_pass(void *state, int method) "VNC client auth passed state=%p method=%d"
 vnc_auth_fail(void *state, int method, const char *message, const char *reason) "VNC client auth failed state=%p method=%d message=%s reason=%s"
@@ -97,6 +97,33 @@ vnc_auth_sasl_step(void *state, const void *clientdata, size_t clientlen, const
 vnc_auth_sasl_ssf(void *state, int ssf) "VNC client auth SASL SSF state=%p size=%d"
 vnc_auth_sasl_username(void *state, const char *name) "VNC client auth SASL user state=%p name=%s"
 vnc_auth_sasl_acl(void *state, int allow) "VNC client auth SASL ACL state=%p allow=%d"
+vnc_set_share_mode(void *state, void *ioc, int old_mode, int new_mode) "VNC set share mode state=%p ioc=%p old=%d new=%d"
+vnc_client_protocol_error(void *state) "VNC client protocol error state=%p"
+vnc_client_write_wire(void *state, const void *data, size_t datalen, ssize_t ret) "VNC client write wire state=%p data=%p len=%zu ret=%zd"
+vnc_client_write_plain(void *state, const void *buffer, size_t capacity, size_t offset, int wait_ssf) "VNC client write plain state=%p buffer=%p capacity=%zu offset=%zu wait_ssf=%d"
+vnc_client_read_wire(void *state, const void *data, size_t datalen, ssize_t ret) "VNC client read wire state=%p data=%p len=%zu ret=%zd"
+vnc_client_read_plain(void *state, const void *buffer, size_t capacity, size_t offset) "VNC client read plain state=%p buffer=%p capacity=%zu offset=%zu"
+vnc_client_unknown_encoding(void *state, int index, int encoding) "VNC client unknown encoding state=%p index=%d encoding=0x%x"
+vnc_client_invalid_audio_format(void *state, int fmt) "VNC client invalid audio format state=%p fmt=%d"
+vnc_client_invalid_audio_channels(void *state, int channels) "VNC client invalid audio channel count state=%p channels=%d"
+vnc_client_invalid_audio_freq(void *state, unsigned int freq) "VNC client invalid audio frequency state=%p freq=%u"
+vnc_client_invalid_audio_msg(void *state, int msg) "VNC client invalid audio message state=%p msg=%d"
+vnc_client_unknown_qemu_msg(void *state, int msg) "VNC client unknown QEMU msg state=%p msg=%d"
+vnc_client_unknown_msg(void *state, int msg) "VNC client unknown msg state=%p msg=%d"
+vnc_client_protocol_version(void *state, int major, int minor) "VNC client protocol version state=%p version=%d.%d"
+vnc_client_protocol_version_malformed(void *state, const char *version) "VNC client malformed protocol version state=%p version=%s"
+vnc_client_protocol_version_unsupported(void *state) "VNC client unsupported protocol version state=%p"
+vnc_client_auth_method(void *state, int auth) "VNC client auth method state=%p auth=%d"
+vnc_client_setup(void *state, void *ioc, int websocket, int auth, int subauth) "VNC client setup state=%p ioc=%p websocket=%d auth=%d subauth=%d"
+vnc_ws_tls_handshake_fail(void *state, const char *msg) "VNC WS TLS handshake failed state=%p msg=%s"
+vnc_ws_tls_handshake_complete(void *state) "VNC WS TLS handshake complete state=%p"
+vnc_ws_tls_setup_fail(void *state, const char *msg) "VNC WS TLS setup failed state=%p msg=%s"
+vnc_ws_handshake_fail(void *state, const char *msg) "VNC WS handshake failed state=%p msg=%s"
+vnc_ws_handshake_complete(void *state) "VNC WS handshake complete state=%p"
+vnc_sasl_write_pending(void *state, const void *buffer, size_t capacity, size_t offset, const void *encoded, int encoded_len, int encoded_offset) "VNC SASL write pending state=%p buffer=%p capacity=%zu offset=%zu encoded=%p encoded_len=%d encoded_offset=%d"
+vnc_sasl_read_decoded(void *state, const void *encoded, size_t encoded_len, const void *decoded, unsigned int decoded_len) "VNC SASL read decoded state=%p encoded=%p encoded_len=%zu decoded=%p decoded_len=%u"
+vnc_zlib_init(void *state, const void *opaque) "VNC zlib init state=%p opaque=%p"
+vnc_tight_zlib_init(void *state, int stream_id, const void *opaque) "VNC tight zlib init state=%p stream=%d opaque=%p"
 
 
 # input.c
-- 
2.54.0


