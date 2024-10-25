Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E981D11717
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 07:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Erz-0008Jp-9Q; Fri, 25 Oct 2024 03:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1t4Erk-0008Ep-N4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:36:12 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1t4ErV-0005Kv-Op
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 03:36:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2711:0:640:16b3:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7FE6E60A96;
 Fri, 25 Oct 2024 10:35:51 +0300 (MSK)
Received: from d-tatianin-lin.yandex.net (unknown
 [2a02:6bf:8011:f00:9e1f:69f6:8772:3b7])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hZPAuP0IWW20-PwIOj9NT; Fri, 25 Oct 2024 10:35:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1729841750;
 bh=eR++ZBj++vpYFE5XSXEmJVeFVO/NeJb3cI6kemHHU2E=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=SF5bBalfyWXl3gT2ugFlVXFL7ZLn1hyhiEADZTjcXDWNPPjmNRixEKdXAwQ/D5fgZ
 JkwhO4E/6RZI9xcNFl2OrPlK/4N+dngRQCXEvYsPxuX+kA2rbLPvPJJj1xNIdiHNwx
 Wn/rtp0lgCyxif5o3vBUjL7prdsPjnio+TsyMQ1w=
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
Subject: [PATCH 2/2] chardev: finalize 'reconnect' deprecation
Date: Fri, 25 Oct 2024 10:35:25 +0300
Message-Id: <20241025073525.976136-3-d-tatianin@yandex-team.ru>
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

Change all related docs and tests to use the new 'reconnect-ms' option
instead of the now deprecated 'reconnect'.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 docs/COLO-FT.txt              |  4 ++--
 docs/system/ppc/powernv.rst   |  2 +-
 qemu-options.hx               | 22 +++++++++++-----------
 tests/qtest/ipmi-bt-test.c    |  2 +-
 tests/qtest/vhost-user-test.c |  2 +-
 tests/unit/test-char.c        |  8 ++++----
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index 2e760a4aee..2283a09c08 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -193,8 +193,8 @@ any IP's here, except for the $primary_ip variable.
    -device piix3-usb-uhci -device usb-tablet -name secondary \
    -netdev tap,id=hn0,vhost=off,helper=/usr/lib/qemu/qemu-bridge-helper \
    -device rtl8139,id=e0,netdev=hn0 \
-   -chardev socket,id=red0,host=$primary_ip,port=9003,reconnect=1 \
-   -chardev socket,id=red1,host=$primary_ip,port=9004,reconnect=1 \
+   -chardev socket,id=red0,host=$primary_ip,port=9003,reconnect-ms=1000 \
+   -chardev socket,id=red1,host=$primary_ip,port=9004,reconnect-ms=1000 \
    -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0 \
    -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1 \
    -object filter-rewriter,id=rew0,netdev=hn0,queue=all \
diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index 09f3965858..de7a807ac7 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -181,7 +181,7 @@ connected to a remote QEMU machine acting as BMC, using these options
 
 .. code-block:: bash
 
-  -chardev socket,id=ipmi0,host=localhost,port=9002,reconnect=10 \
+  -chardev socket,id=ipmi0,host=localhost,port=9002,reconnect-ms=10000 \
   -device ipmi-bmc-extern,id=bmc0,chardev=ipmi0 \
   -device isa-ipmi-bt,bmc=bmc0,irq=10 \
   -nodefaults
diff --git a/qemu-options.hx b/qemu-options.hx
index bb228f6200..dacc9790a4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1102,7 +1102,7 @@ SRST
     external entity that provides the IPMI services.
 
     A connection is made to an external BMC simulator. If you do this,
-    it is strongly recommended that you use the "reconnect=" chardev
+    it is strongly recommended that you use the "reconnect-ms=" chardev
     option to reconnect to the simulator if the connection is lost. Note
     that if this is not used carefully, it can be a security issue, as
     the interface has the ability to send resets, NMIs, and power off
@@ -3318,8 +3318,8 @@ SRST
     ``ipv6=on|off``
         whether to accept IPv6 addresses, default to try both IPv4 and IPv6
 
-    ``reconnect=seconds``
-        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+    ``reconnect-ms=milliseconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of milliseconds.
         Setting this to zero disables this function.  (default: 0)
 
     Example (two guests connected using a TCP/IP socket):
@@ -3388,8 +3388,8 @@ SRST
     ``addr.str=file-descriptor``
         file descriptor number to use as a socket
 
-    ``reconnect=seconds``
-        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of seconds.
+    ``reconnect-ms=milliseconds``
+        for a client socket, if a socket is disconnected, then attempt a reconnect after the given number of milliseconds.
         Setting this to zero disables this function.  (default: 0)
 
 ``-netdev dgram,id=str,remote.type=inet,remote.host=maddr,remote.port=port[,local.type=inet,local.host=addr]``
@@ -3679,9 +3679,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
     "-chardev help\n"
     "-chardev null,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
     "-chardev socket,id=id[,host=host],port=port[,to=to][,ipv4=on|off][,ipv6=on|off][,nodelay=on|off]\n"
-    "         [,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds][,mux=on|off]\n"
+    "         [,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect-ms=milliseconds][,mux=on|off]\n"
     "         [,logfile=PATH][,logappend=on|off][,tls-creds=ID][,tls-authz=ID] (tcp)\n"
-    "-chardev socket,id=id,path=path[,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds]\n"
+    "-chardev socket,id=id,path=path[,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect-ms=milliseconds]\n"
     "         [,mux=on|off][,logfile=PATH][,logappend=on|off][,abstract=on|off][,tight=on|off] (unix)\n"
     "-chardev udp,id=id[,host=host],port=port[,localaddr=localaddr]\n"
     "         [,localport=localport][,ipv4=on|off][,ipv6=on|off][,mux=on|off]\n"
@@ -3792,7 +3792,7 @@ The available backends are:
     A void device. This device will not emit any data, and will drop any
     data it receives. The null backend does not take any options.
 
-``-chardev socket,id=id[,TCP options or unix options][,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect=seconds][,tls-creds=id][,tls-authz=id]``
+``-chardev socket,id=id[,TCP options or unix options][,server=on|off][,wait=on|off][,telnet=on|off][,websocket=on|off][,reconnect-ms=milliseconds][,tls-creds=id][,tls-authz=id]``
     Create a two-way stream socket, which can be either a TCP or a unix
     socket. A unix socket will be created if ``path`` is specified.
     Behaviour is undefined if TCP options are specified for a unix
@@ -3809,9 +3809,9 @@ The available backends are:
     ``websocket=on|off`` specifies that the socket uses WebSocket protocol for
     communication.
 
-    ``reconnect`` sets the timeout for reconnecting on non-server
+    ``reconnect-ms`` sets the timeout for reconnecting on non-server
     sockets when the remote end goes away. qemu will delay this many
-    seconds and then attempt to reconnect. Zero disables reconnecting,
+    milliseconds and then attempt to reconnect. Zero disables reconnecting,
     and is the default.
 
     ``tls-creds`` requests enablement of the TLS protocol for
@@ -4427,7 +4427,7 @@ SRST
         The WebSocket protocol is used instead of raw tcp socket. The
         port acts as a WebSocket server. Client mode is not supported.
 
-    ``unix:path[,server=on|off][,wait=on|off][,reconnect=seconds]``
+    ``unix:path[,server=on|off][,wait=on|off][,reconnect-ms=milliseconds]``
         A unix domain socket is used instead of a tcp socket. The option
         works the same as if you had specified ``-serial tcp`` except
         the unix domain socket path is used for connections.
diff --git a/tests/qtest/ipmi-bt-test.c b/tests/qtest/ipmi-bt-test.c
index 13f7c841f5..637732fd5a 100644
--- a/tests/qtest/ipmi-bt-test.c
+++ b/tests/qtest/ipmi-bt-test.c
@@ -411,7 +411,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     global_qtest = qtest_initf(
-        " -chardev socket,id=ipmi0,host=127.0.0.1,port=%d,reconnect=10"
+        " -chardev socket,id=ipmi0,host=127.0.0.1,port=%d,reconnect-ms=10000"
         " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
         " -device isa-ipmi-bt,bmc=bmc0", emu_port);
     qtest_irq_intercept_in(global_qtest, "ioapic");
diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d6075001e7..8948fb81ef 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -920,7 +920,7 @@ static void wait_for_rings_started(TestServer *s, size_t count)
 
 static inline void test_server_connect(TestServer *server)
 {
-    test_server_create_chr(server, ",reconnect=1");
+    test_server_create_chr(server, ",reconnect-ms=1000");
 }
 
 static gboolean
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index a1c6bb874c..a6e8753e1c 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1545,18 +1545,18 @@ int main(int argc, char **argv)
     static CharSocketClientTestConfig client2 ## name =                 \
         { addr, NULL, true, false, char_socket_event };                 \
     static CharSocketClientTestConfig client3 ## name =                 \
-        { addr, ",reconnect=1", false, false, char_socket_event };      \
+        { addr, ",reconnect-ms=1000", false, false, char_socket_event }; \
     static CharSocketClientTestConfig client4 ## name =                 \
-        { addr, ",reconnect=1", true, false, char_socket_event };       \
+        { addr, ",reconnect-ms=1000", true, false, char_socket_event }; \
     static CharSocketClientTestConfig client5 ## name =                 \
         { addr, NULL, false, true, char_socket_event };                 \
     static CharSocketClientTestConfig client6 ## name =                 \
         { addr, NULL, true, true, char_socket_event };                  \
     static CharSocketClientTestConfig client7 ## name =                 \
-        { addr, ",reconnect=1", true, false,                            \
+        { addr, ",reconnect-ms=1000", true, false,                      \
             char_socket_event_with_error };                             \
     static CharSocketClientTestConfig client8 ## name =                 \
-        { addr, ",reconnect=1", false, false, char_socket_event };      \
+        { addr, ",reconnect-ms=1000", false, false, char_socket_event };\
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
-- 
2.34.1


