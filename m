Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70BAD1170E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 07:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Erp-0008Fe-H5; Fri, 25 Oct 2024 03:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1t4Erk-0008Ej-4l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:36:12 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1t4ErU-0005Kp-AV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:36:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2711:0:640:16b3:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AE22360FD7;
 Fri, 25 Oct 2024 10:35:50 +0300 (MSK)
Received: from d-tatianin-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:9e1f:69f6:8772:3b7])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hZPAuP0IWW20-WS91zpFB; Fri, 25 Oct 2024 10:35:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1729841749;
 bh=kwN7Eoew5aA5M2VDK5CTXe4nFhPV6kVl0Mlb0jqL+Vw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=MQGEjyKu55MWpkjdoDmxZq+LXw5zvTcvVSYWO6QE7WwQj6ratvwroja/nd5FF8FpA
 kiAeE/tC9BH07xMIXjsgmimUYa69bacLEVG4hhl20kCLC8KYi233fjCVkGQNF6R8GW
 mvV9YRVKuur8Z9eWXIs8tIykYkcVBK8KsUAfwJCU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, devel@lists.libvirt.org,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: [PATCH 1/2] net/stream: deprecate 'reconnect' in favor of
 'reconnect-ms'
Date: Fri, 25 Oct 2024 10:35:24 +0300
Message-Id: <20241025073525.976136-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025073525.976136-1-d-tatianin@yandex-team.ru>
References: <20241025073525.976136-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do the same thing we already did for chardev in c8e2b6b4d7e, and
introduce a new 'reconnect-ms' option to make it possible to specify
sub-second timeouts. This also changes the related documentaion and
tests to use reconnect-ms as well.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 docs/about/deprecated.rst   | 10 ++++++++++
 net/stream.c                | 34 ++++++++++++++++++++++------------
 qapi/net.json               | 13 ++++++++++++-
 qemu-options.hx             | 24 ++++++++++++------------
 tests/qtest/netdev-socket.c |  2 +-
 5 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ce38a3d0cf..1e1e9f5f18 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -400,6 +400,16 @@ Backend ``memory`` (since 9.0)
 The ``reconnect`` option only allows specifiying second granularity timeouts,
 which is not enough for all types of use cases, use ``reconnect-ms`` instead.
 
+
+Net device options
+''''''''''''''''''
+
+Stream ``reconnect`` (since 9.2)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``reconnect`` option only allows specifiying second granularity timeouts,
+which is not enough for all types of use cases, use ``reconnect-ms`` instead.
+
 CPU device properties
 '''''''''''''''''''''
 
diff --git a/net/stream.c b/net/stream.c
index 97e6ec6679..4de5613844 100644
--- a/net/stream.c
+++ b/net/stream.c
@@ -51,7 +51,7 @@ typedef struct NetStreamState {
     guint ioc_write_tag;
     SocketReadState rs;
     unsigned int send_index;      /* number of bytes sent*/
-    uint32_t reconnect;
+    uint32_t reconnect_ms;
     guint timer_tag;
     SocketAddress *addr;
 } NetStreamState;
@@ -387,10 +387,9 @@ static gboolean net_stream_reconnect(gpointer data)
 
 static void net_stream_arm_reconnect(NetStreamState *s)
 {
-    if (s->reconnect && s->timer_tag == 0) {
+    if (s->reconnect_ms && s->timer_tag == 0) {
         qemu_set_info_str(&s->nc, "connecting");
-        s->timer_tag = g_timeout_add_seconds(s->reconnect,
-                                             net_stream_reconnect, s);
+        s->timer_tag = g_timeout_add(s->reconnect_ms, net_stream_reconnect, s);
     }
 }
 
@@ -398,7 +397,7 @@ static int net_stream_client_init(NetClientState *peer,
                                   const char *model,
                                   const char *name,
                                   SocketAddress *addr,
-                                  uint32_t reconnect,
+                                  uint32_t reconnect_ms,
                                   Error **errp)
 {
     NetStreamState *s;
@@ -412,8 +411,8 @@ static int net_stream_client_init(NetClientState *peer,
     s->ioc = QIO_CHANNEL(sioc);
     s->nc.link_down = true;
 
-    s->reconnect = reconnect;
-    if (reconnect) {
+    s->reconnect_ms = reconnect_ms;
+    if (reconnect_ms) {
         s->addr = QAPI_CLONE(SocketAddress, addr);
     }
     qio_channel_socket_connect_async(sioc, addr,
@@ -432,13 +431,24 @@ int net_init_stream(const Netdev *netdev, const char *name,
     sock = &netdev->u.stream;
 
     if (!sock->has_server || !sock->server) {
+        uint32_t reconnect_ms = 0;
+
+        if (sock->has_reconnect && sock->has_reconnect_ms) {
+            error_setg(errp, "'reconnect' and 'reconnect-ms' are mutually "
+                             "exclusive");
+            return -1;
+        } else if (sock->has_reconnect_ms) {
+            reconnect_ms = sock->reconnect_ms;
+        } else if (sock->has_reconnect) {
+            reconnect_ms = sock->reconnect * 1000u;
+        }
+
         return net_stream_client_init(peer, "stream", name, sock->addr,
-                                      sock->has_reconnect ? sock->reconnect : 0,
-                                      errp);
+                                      reconnect_ms, errp);
     }
-    if (sock->has_reconnect) {
-        error_setg(errp, "'reconnect' option is incompatible with "
-                         "socket in server mode");
+    if (sock->has_reconnect || sock->has_reconnect_ms) {
+        error_setg(errp, "'reconnect' and 'reconnect-ms' options are "
+                         "incompatible with socket in server mode");
         return -1;
     }
     return net_stream_server_init(peer, "stream", name, sock->addr, errp);
diff --git a/qapi/net.json b/qapi/net.json
index 87fc0d0b28..2739a2f423 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -650,15 +650,26 @@
 #     attempt a reconnect after the given number of seconds.  Setting
 #     this to zero disables this function.  (default: 0) (since 8.0)
 #
+# @reconnect-ms: For a client socket, if a socket is disconnected, then
+#     attempt a reconnect after the given number of milliseconds.  Setting
+#     this to zero disables this function.  This member is mutually
+#     exclusive with @reconnect.  (default: 0) (Since: 9.2)
+#
 # Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
 #
+# Features:
+#
+# @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
+#     instead.
+#
 # Since: 7.2
 ##
 { 'struct': 'NetdevStreamOptions',
   'data': {
     'addr':   'SocketAddress',
     '*server': 'bool',
-    '*reconnect': 'uint32' } }
+    '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
+    '*reconnect-ms': 'int' } }
 
 ##
 # @NetdevDgramOptions:
diff --git a/qemu-options.hx b/qemu-options.hx
index daae494147..bb228f6200 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2833,9 +2833,9 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "-netdev socket,id=str[,fd=h][,udp=host:port][,localaddr=host:port]\n"
     "                configure a network backend to connect to another network\n"
     "                using an UDP tunnel\n"
-    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect=seconds]\n"
-    "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect=seconds]\n"
-    "-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect=seconds]\n"
+    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
+    "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect-ms=milliseconds]\n"
+    "-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect-ms=milliseconds]\n"
     "                configure a network backend to connect to another network\n"
     "                using a socket connection in stream mode.\n"
     "-netdev dgram,id=str,remote.type=inet,remote.host=maddr,remote.port=port[,local.type=inet,local.host=addr]\n"
@@ -3291,7 +3291,7 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
-``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect=seconds]``
+``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
 
     ``server=on|off``
@@ -3333,9 +3333,9 @@ SRST
         # second VM
         |qemu_system| linux.img \\
                       -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
-                      -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234,reconnect=5
+                      -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234,reconnect-ms=5000
 
-``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect=seconds]``
+``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect-ms=milliseconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented unix domain socket.
 
     ``server=on|off``
@@ -3350,8 +3350,8 @@ SRST
     ``tight=on|off``
         if false, pad an abstract socket address with enough null bytes to make it fill struct sockaddr_un member sun_path.
 
-    ``reconnect=seconds``
-        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+    ``reconnect-ms=milliseconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of milliseconds.
         Setting this to zero disables this function.  (default: 0)
 
     Example (using passt as a replacement of -netdev user):
@@ -3377,9 +3377,9 @@ SRST
         # second VM
         |qemu_system| linux.img \\
                       -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
-                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/qemu0,reconnect=5
+                      -netdev stream,id=net0,server=off,addr.type=unix,addr.path=/tmp/qemu0,reconnect-ms=5000
 
-``-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect=seconds]``
+``-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect-ms=milliseconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented socket file descriptor.
 
     ``server=on|off``
@@ -4390,14 +4390,14 @@ SRST
         ``telnet options:``
             localhost 5555
 
-    ``tcp:[host]:port[,server=on|off][,wait=on|off][,nodelay=on|off][,reconnect=seconds]``
+    ``tcp:[host]:port[,server=on|off][,wait=on|off][,nodelay=on|off][,reconnect-ms=milliseconds]``
         The TCP Net Console has two modes of operation. It can send the
         serial I/O to a location or wait for a connection from a
         location. By default the TCP Net Console is sent to host at the
         port. If you use the ``server=on`` option QEMU will wait for a client
         socket application to connect to the port before continuing,
         unless the ``wait=on|off`` option was specified. The ``nodelay=on|off``
-        option disables the Nagle buffering algorithm. The ``reconnect=on``
+        option disables the Nagle buffering algorithm. The ``reconnect-ms``
         option only applies if ``server=no`` is set, if the connection goes
         down it will attempt to reconnect at the given interval. If host
         is omitted, 0.0.0.0 is assumed. Only one TCP connection at a
diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index fc7d11961e..317af03817 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -204,7 +204,7 @@ static void test_stream_unix_reconnect(void)
 
     qts1 = qtest_initf("-nodefaults -M none "
                        "-netdev stream,server=false,id=st0,addr.type=unix,"
-                       "addr.path=%s,reconnect=1", path);
+                       "addr.path=%s,reconnect-ms=1000", path);
 
     wait_stream_connected(qts0, "st0", &addr);
     g_assert_cmpint(addr->type, ==, SOCKET_ADDRESS_TYPE_UNIX);
-- 
2.34.1


