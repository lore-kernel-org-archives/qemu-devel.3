Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679D7CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR93A-0004oe-86; Sun, 24 May 2026 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3MZ-0008NM-Ka
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:07 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3MX-0002PQ-Es
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:07 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 180EE20202A1; Sun, 24 May 2026 16:35:03 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/5] qemu-options: document keep-alive-count/idle/interval for
 -netdev stream
Date: Sun, 24 May 2026 16:34:39 +0900
Message-ID: <20260524073442.435408-3-Mitsuru.Kariya@oss.nttdata.com>
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
X-Mailman-Approved-At: Sun, 24 May 2026 09:39:19 -0400
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

The keep-alive-count, keep-alive-idle and keep-alive-interval members of
InetSocketAddress have been available for -netdev stream (and every
other QAPI SocketAddress consumer) since the qemu-sockets keep-alive
options were extended in 10.1, but were never documented in
qemu-options.hx.

Add their descriptions, and drop the "Not supported for passive sockets"
remark from addr.keep-alive=on|off: as of 10.1 keep-alive on listening
sockets is also supported (see the SocketAddress @keep-alive QAPI doc
comment, which records "(Since 4.2, not supported for listening sockets
until 10.1)").

Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 qemu-options.hx | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 527fc12494..7432b77571 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3034,7 +3034,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "-netdev socket,id=str[,fd=h][,udp=host:port][,localaddr=host:port]\n"
     "                configure a network backend to connect to another network\n"
     "                using an UDP tunnel\n"
-    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
+    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
     "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,addr.abstract=on|off][,addr.tight=on|off][,reconnect-ms=milliseconds]\n"
     "-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect-ms=milliseconds]\n"
     "                configure a network backend to connect to another network\n"
@@ -3640,7 +3640,7 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
-``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
+``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
 
     ``server=on|off``
@@ -3656,7 +3656,19 @@ SRST
         if ``on`` ``host`` and ``port`` are guaranteed to be numeric, otherwise a name resolution should be attempted (default: ``off``)
 
     ``addr.keep-alive=on|off``
-        enable keep-alive when connecting to this socket.  Not supported for passive sockets.
+        enable keep-alive when connecting to this socket.
+
+    ``addr.keep-alive-count=count``
+        number of keep-alive packets to send before dropping the connection.
+        Set to 0 to use the system default.  (default: 0)
+
+    ``addr.keep-alive-idle=idle``
+        time in seconds the connection needs to be idle before sending keep-alive packets.
+        Set to 0 to use the system default.  (default: 0)
+
+    ``addr.keep-alive-interval=interval``
+        time in seconds between individual keep-alive packets.
+        Set to 0 to use the system default.  (default: 0)
 
     ``addr.mptcp=on|off``
         enable multipath TCP
-- 
2.43.0


