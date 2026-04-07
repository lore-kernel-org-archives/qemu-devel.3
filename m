Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA97BFF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXb-0000HR-MP; Tue, 07 Apr 2026 14:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1wABUI-0003uc-DO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w9yg3-0003HK-8N
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 01:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775538518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSYhPjyMUCbINJQbYKmJPxVIaDBsqWDh+L4xXLOW1QQ=;
 b=D2wyNQjM/4xTm+h2D/OYZnLnTP25I6s/9oasKSK0l8OxQgVQrxJAbqm23Sa+KtM0e3757E
 og04+ETToayrMCBaxgENEZmI6Uf97uYuZMCHAHoK15h+i/S2XvVMpFyxlAbMLY0O3m/1K0
 rHYVTpds7q/VcLWwlkM4W/9Q5XyD84Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-Xke8I1JmOIud50myCEc5-g-1; Tue,
 07 Apr 2026 01:08:35 -0400
X-MC-Unique: Xke8I1JmOIud50myCEc5-g-1
X-Mimecast-MFC-AGG-ID: Xke8I1JmOIud50myCEc5-g_1775538514
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04146195609F; Tue,  7 Apr 2026 05:08:34 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 978301800351; Tue,  7 Apr 2026 05:08:30 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v4 2/5] chardev/socket: add AF_PACKET initialization
Date: Tue,  7 Apr 2026 13:05:49 +0800
Message-ID: <20260407050818.2249570-3-lulu@redhat.com>
In-Reply-To: <20260407050818.2249570-1-lulu@redhat.com>
References: <20260407050818.2249570-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Teach socket chardevs to recognize AF_PACKET fds and record the state
needed by later TX/RX support. Add af-packet-mode=capture|inject to
QAPI and command-line parsing, reject it for non-fd address types, and
validate after a client fd is attached that the supplied fd really is
AF_PACKET.

The socket chardev now tracks whether the underlying socket is
AF_PACKET, owns separate send/receive staging buffers, and resets that
state on connection teardown and reconnect. The follow-up TX and RX
commits use this setup to translate between the redirector's existing
length-prefixed chardev framing and raw L2 packets.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 chardev/char-socket.c         | 104 +++++++++++++++++++++++++++++++++-
 chardev/char.c                |   3 +
 include/chardev/char-socket.h |  13 +++++
 qapi/char.json                |  23 +++++++-
 qemu-options.hx               |   5 +-
 5 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 62852e3caf..c710fdb497 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -23,6 +23,9 @@
  */
 
 #include "qemu/osdep.h"
+#ifdef CONFIG_LINUX
+#include <netpacket/packet.h>
+#endif
 #include "chardev/char.h"
 #include "io/channel-socket.h"
 #include "io/channel-websock.h"
@@ -32,6 +35,7 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qapi/util.h"
 #include "qemu/yank.h"
 #include "trace.h"
 
@@ -326,6 +330,28 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
     return ret;
 }
 
+static bool tcp_chr_is_af_packet(SocketChardev *s)
+{
+#ifdef CONFIG_LINUX
+    return s->sioc && s->sioc->localAddr.ss_family == AF_PACKET;
+#else
+    return false;
+#endif
+}
+
+static void tcp_chr_reset_af_packet_buf(SocketChardev *s)
+{
+    s->af_packet_buf_len = 0;
+    s->af_packet_buf_offset = 0;
+}
+
+static void tcp_chr_reset_af_packet_send(SocketChardev *s)
+{
+    s->af_packet_send_len = 0;
+    s->af_packet_send_offset = 0;
+    s->af_packet_send_len_bytes = 0;
+}
+
 static GSource *tcp_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -384,6 +410,15 @@ static void tcp_chr_free_connection(Chardev *chr)
     s->sioc = NULL;
     object_unref(OBJECT(s->ioc));
     s->ioc = NULL;
+    g_free(s->af_packet_buf);
+    s->af_packet_buf = NULL;
+    s->af_packet_buf_size = 0;
+    tcp_chr_reset_af_packet_buf(s);
+    g_free(s->af_packet_send_buf);
+    s->af_packet_send_buf = NULL;
+    s->af_packet_send_buf_size = 0;
+    tcp_chr_reset_af_packet_send(s);
+    s->is_af_packet = false;
     g_free(chr->filename);
     chr->filename = NULL;
     tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
@@ -889,6 +924,26 @@ static void tcp_chr_set_client_ioc_name(Chardev *chr,
 
 }
 
+static bool tcp_chr_validate_af_packet_mode_fd(Chardev *chr,
+                                               QIOChannelSocket *sioc,
+                                               Error **errp)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+
+    if (!s->af_packet_mode_set) {
+        return true;
+    }
+
+#ifdef CONFIG_LINUX
+    if (sioc->localAddr.ss_family == AF_PACKET) {
+        return true;
+    }
+#endif
+
+    error_setg(errp, "'af-packet-mode' requires an AF_PACKET fd");
+    return false;
+}
+
 static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
@@ -907,6 +962,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOChannelSocket *sioc)
     object_ref(OBJECT(sioc));
     s->sioc = sioc;
     object_ref(OBJECT(sioc));
+    s->is_af_packet = tcp_chr_is_af_packet(s);
+    tcp_chr_reset_af_packet_buf(s);
+    tcp_chr_reset_af_packet_send(s);
 
     if (s->do_nodelay) {
         qio_channel_set_delay(s->ioc, false);
@@ -951,6 +1009,11 @@ static int tcp_chr_add_client(Chardev *chr, int fd)
                                char_socket_yank_iochannel,
                                QIO_CHANNEL(sioc));
     }
+    if (!tcp_chr_validate_af_packet_mode_fd(chr, sioc, NULL)) {
+        tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
+        object_unref(OBJECT(sioc));
+        return -1;
+    }
     ret = tcp_chr_new_client(chr, sioc);
     object_unref(OBJECT(sioc));
     return ret;
@@ -990,7 +1053,17 @@ static int tcp_chr_connect_client_sync(Chardev *chr, Error **errp)
                                char_socket_yank_iochannel,
                                QIO_CHANNEL(sioc));
     }
-    tcp_chr_new_client(chr, sioc);
+    if (!tcp_chr_validate_af_packet_mode_fd(chr, sioc, errp)) {
+        tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
+        object_unref(OBJECT(sioc));
+        return -1;
+    }
+    if (tcp_chr_new_client(chr, sioc) < 0) {
+        tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
+        object_unref(OBJECT(sioc));
+        error_setg(errp, "failed to initialize socket chardev client");
+        return -1;
+    }
     object_unref(OBJECT(sioc));
     return 0;
 }
@@ -1312,6 +1385,11 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
         break;
 
     case SOCKET_ADDRESS_TYPE_UNIX:
+        if (sock->has_af_packet_mode) {
+            error_setg(errp,
+                       "'af-packet-mode' option requires 'fd' address type");
+            return false;
+        }
         if (sock->tls_creds) {
             error_setg(errp,
                        "'tls_creds' option is incompatible with "
@@ -1321,9 +1399,19 @@ static bool qmp_chardev_validate_socket(ChardevSocket *sock,
         break;
 
     case SOCKET_ADDRESS_TYPE_INET:
+        if (sock->has_af_packet_mode) {
+            error_setg(errp,
+                       "'af-packet-mode' option requires 'fd' address type");
+            return false;
+        }
         break;
 
     case SOCKET_ADDRESS_TYPE_VSOCK:
+        if (sock->has_af_packet_mode) {
+            error_setg(errp,
+                       "'af-packet-mode' option requires 'fd' address type");
+            return false;
+        }
         if (sock->tls_creds) {
             error_setg(errp,
                        "'tls_creds' option is incompatible with "
@@ -1386,6 +1474,10 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->is_tn3270 = is_tn3270;
     s->is_websock = is_websock;
     s->do_nodelay = do_nodelay;
+    s->af_packet_mode_set = sock->has_af_packet_mode;
+    if (sock->has_af_packet_mode) {
+        s->af_packet_mode = sock->af_packet_mode;
+    }
     if (sock->tls_creds) {
         Object *creds;
         creds = object_resolve_path_component(
@@ -1463,6 +1555,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
     const char *fd = qemu_opt_get(opts, "fd");
+    const char *af_packet_mode = qemu_opt_get(opts, "af-packet-mode");
 #ifdef CONFIG_LINUX
     bool tight = qemu_opt_get_bool(opts, "tight", true);
     bool abstract = qemu_opt_get_bool(opts, "abstract", false);
@@ -1516,6 +1609,15 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->wait = qemu_opt_get_bool(opts, "wait", true);
     sock->has_reconnect_ms = qemu_opt_find(opts, "reconnect-ms");
     sock->reconnect_ms = qemu_opt_get_number(opts, "reconnect-ms", 0);
+    if (af_packet_mode) {
+        sock->af_packet_mode =
+            qapi_enum_parse(&ChardevSocketAfPacketMode_lookup,
+                            af_packet_mode, -1, errp);
+        if (*errp) {
+            return;
+        }
+        sock->has_af_packet_mode = true;
+    }
 
     sock->tls_creds = g_strdup(qemu_opt_get(opts, "tls-creds"));
     sock->tls_authz = g_strdup(qemu_opt_get(opts, "tls-authz"));
diff --git a/chardev/char.c b/chardev/char.c
index 3e432195a5..39bb0d5b68 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -910,6 +910,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "websocket",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "af-packet-mode",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "width",
             .type = QEMU_OPT_NUMBER,
diff --git a/include/chardev/char-socket.h b/include/chardev/char-socket.h
index d6d13ad37f..8af8af6cf8 100644
--- a/include/chardev/char-socket.h
+++ b/include/chardev/char-socket.h
@@ -63,6 +63,19 @@ struct SocketChardev {
     int *write_msgfds;
     size_t write_msgfds_num;
     bool registered_yank;
+    bool is_af_packet;
+    bool af_packet_mode_set;
+    ChardevSocketAfPacketMode af_packet_mode;
+    uint8_t *af_packet_buf;
+    size_t af_packet_buf_size;
+    size_t af_packet_buf_len;
+    size_t af_packet_buf_offset;
+    uint8_t *af_packet_send_buf;
+    size_t af_packet_send_buf_size;
+    size_t af_packet_send_len;
+    size_t af_packet_send_offset;
+    uint8_t af_packet_send_len_buf[sizeof(uint32_t)];
+    size_t af_packet_send_len_bytes;
 
     SocketAddress *addr;
     bool is_listen;
diff --git a/qapi/char.json b/qapi/char.json
index 140614f82c..61a785727d 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -237,6 +237,22 @@
   'data': { 'device': 'str' },
   'base': 'ChardevCommon' }
 
+##
+# @ChardevSocketAfPacketMode:
+#
+# AF_PACKET fd mode for socket chardevs.
+#
+# @capture: use recvfrom() to capture raw L2 frames and forward them
+#     through the existing chardev packet framing
+#
+# @inject: use sendmsg() to inject framed chardev packets back as raw
+#     L2 frames
+#
+# Since: 10.1
+##
+{ 'enum': 'ChardevSocketAfPacketMode',
+  'data': [ 'capture', 'inject' ] }
+
 ##
 # @ChardevSocket:
 #
@@ -274,6 +290,10 @@
 #     Setting this to zero disables this function.
 #     (default: 0) (Since: 9.2)
 #
+# @af-packet-mode: when @addr is an fd that refers to an AF_PACKET
+#     socket, use raw packet capture or inject instead of stream
+#     socket I/O (Since: 10.1)
+#
 # Since: 1.4
 ##
 { 'struct': 'ChardevSocket',
@@ -286,7 +306,8 @@
             '*telnet': 'bool',
             '*tn3270': 'bool',
             '*websocket': 'bool',
-            '*reconnect-ms': 'int' },
+            '*reconnect-ms': 'int',
+            '*af-packet-mode': 'ChardevSocketAfPacketMode' },
   'base': 'ChardevCommon' }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index fca2b7bc74..0e3ce7f493 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4062,7 +4062,7 @@ The available backends are:
     A void device. This device will not emit any data, and will drop any
     data it receives. The null backend does not take any options.
 
-``-chardev socket,id=id[,TCP options or unix options][,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect-ms=milliseconds][,tls-creds=id][,tls-authz=id]``
+``-chardev socket,id=id[,TCP options or unix options][,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect-ms=milliseconds][,tls-creds=id][,tls-authz=id][,af-packet-mode=capture|inject]``
     Create a two-way stream socket, which can be either a TCP or a unix
     socket. A unix socket will be created if ``path`` is specified.
     Behaviour is undefined if TCP options are specified for a unix
@@ -4095,6 +4095,9 @@ The available backends are:
     deleted and recreated on the fly while the chardev server is active.
     If missing, it will default to denying access.
 
+    ``af-packet-mode=capture|inject`` is only valid with ``fd=...`` when
+    the provided file descriptor is an AF_PACKET socket.
+
     TCP and unix socket options are given below:
 
     ``TCP options: port=port[,host=host][,to=to][,ipv4=on|off][,ipv6=on|off][,nodelay=on|off]``
-- 
2.52.0


