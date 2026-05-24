Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9438CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR93e-00051O-2c; Sun, 24 May 2026 09:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3Mt-0008Qv-4F; Sun, 24 May 2026 03:35:27 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3Mq-0002Dw-Up; Sun, 24 May 2026 03:35:26 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id E84822020286; Sun, 24 May 2026 16:34:59 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/5] qemu-options: fix missing addr. prefix on -netdev stream
 inet/unix options
Date: Sun, 24 May 2026 16:34:38 +0900
Message-ID: <20260524073442.435408-2-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
References: <20260524073442.435408-1-Mitsuru.Kariya@oss.nttdata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at oss.nttdata.com
X-Virus-Status: Clean
Received-SPF: pass client-ip=49.212.34.109;
 envelope-from=Mitsuru.Kariya@oss.nttdata.com; helo=oss.nttdata.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 24 May 2026 09:39:20 -0400
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

-netdev stream uses modern syntax parsed by netdev_parse_modern() which
goes through the QAPI keyval visitor (qobject_input_visitor_new_str() ->
keyval_parse() -> qobject_input_visitor_new_keyval() -> visit_type_Netdev()).
Options nested under addr (of type SocketAddress) must therefore be
written with the "addr." prefix: a top-level "keep-alive=on" is rejected
by the QAPI input visitor with "Parameter 'keep-alive' is unexpected",
because NetdevStreamOptions has no such member.

The documentation listed several InetSocketAddress members (to, numeric,
keep-alive, mptcp, ipv4, ipv6) and UnixSocketAddress members (abstract,
tight) without the prefix, which never actually worked.  Only
addr.type/addr.host/addr.port/addr.path/addr.str were spelled correctly
in the synopsis.

Add the missing addr. prefix to all affected option names.

Fixes: bb1326abd9df ("net: update netdev stream/dgram man page")
Cc: qemu-stable@nongnu.org
Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 qemu-options.hx | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..527fc12494 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3034,8 +3034,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "-netdev socket,id=str[,fd=h][,udp=host:port][,localaddr=host:port]\n"
     "                configure a network backend to connect to another network\n"
     "                using an UDP tunnel\n"
-    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
-    "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect-ms=milliseconds]\n"
+    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
+    "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,addr.abstract=on|off][,addr.tight=on|off][,reconnect-ms=milliseconds]\n"
     "-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect-ms=milliseconds]\n"
     "                configure a network backend to connect to another network\n"
     "                using a socket connection in stream mode.\n"
@@ -3640,7 +3640,7 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
-``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
+``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
 
     ``server=on|off``
@@ -3649,22 +3649,22 @@ SRST
     ``addr.host=host,addr.port=port``
         socket address to listen on (server=on) or connect to (server=off)
 
-    ``to=maxport``
+    ``addr.to=maxport``
         if present, this is range of possible addresses, with port between ``port`` and ``maxport``.
 
-    ``numeric=on|off``
+    ``addr.numeric=on|off``
         if ``on`` ``host`` and ``port`` are guaranteed to be numeric, otherwise a name resolution should be attempted (default: ``off``)
 
-    ``keep-alive=on|off``
+    ``addr.keep-alive=on|off``
         enable keep-alive when connecting to this socket.  Not supported for passive sockets.
 
-    ``mptcp=on|off``
+    ``addr.mptcp=on|off``
         enable multipath TCP
 
-    ``ipv4=on|off``
+    ``addr.ipv4=on|off``
         whether to accept IPv4 addresses, default to try both IPv4 and IPv6
 
-    ``ipv6=on|off``
+    ``addr.ipv6=on|off``
         whether to accept IPv6 addresses, default to try both IPv4 and IPv6
 
     ``reconnect-ms=milliseconds``
@@ -3684,7 +3684,7 @@ SRST
                       -device virtio-net,netdev=net0,mac=52:54:00:12:34:57 \\
                       -netdev stream,id=net0,server=off,addr.type=inet,addr.host=localhost,addr.port=1234,reconnect-ms=5000
 
-``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,abstract=on|off][,tight=on|off][,reconnect-ms=milliseconds]``
+``-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,addr.abstract=on|off][,addr.tight=on|off][,reconnect-ms=milliseconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a stream oriented unix domain socket.
 
     ``server=on|off``
@@ -3693,10 +3693,10 @@ SRST
     ``addr.path=path``
         filesystem path to use
 
-    ``abstract=on|off``
+    ``addr.abstract=on|off``
         if ``on``, this is a Linux abstract socket address.
 
-    ``tight=on|off``
+    ``addr.tight=on|off``
         if false, pad an abstract socket address with enough null bytes to make it fill struct sockaddr_un member sun_path.
 
     ``reconnect-ms=milliseconds``
-- 
2.43.0


