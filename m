Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1333FCD5BC7
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR93J-0004xD-HI; Sun, 24 May 2026 09:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3Md-0008Nm-Nb
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:11 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3Mb-0002QY-F1
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:11 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id ABAF120202B6; Sun, 24 May 2026 16:35:07 +0900 (JST)
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
Subject: [PATCH 4/5] util/qemu-sockets: add TCP_USER_TIMEOUT support
Date: Sun, 24 May 2026 16:34:41 +0900
Message-ID: <20260524073442.435408-5-Mitsuru.Kariya@oss.nttdata.com>
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

The TCP_USER_TIMEOUT socket option (Linux-only) specifies the maximum
amount of time in milliseconds that transmitted data may remain
unacknowledged, or buffered data may remain untransmitted, before TCP
forcibly closes the connection and returns ETIMEDOUT to the
application.  Without it, a peer that becomes silently unreachable can
take well over an hour to be noticed (the kernel default), which is
particularly painful for use cases like QEMU live migration.

Expose user-timeout as a new optional InetSocketAddress member, gated
on a new HAVE_TCP_USER_TIMEOUT meson check, and apply it in
inet_set_sockopts() alongside the existing keep-alive options.  Plumb
the same option through the legacy QemuOpts-based inet_parse() path so
that URI-style users (-incoming tcp:, migrate tcp:, HMP
nbd_server_start, ...) can set it too.

Update the documentation for -netdev stream (addr.user-timeout=N) and
-incoming tcp: (user-timeout=N, flat key as for the other inet_opts
entries), and extend test_inet_parse_all_options_good accordingly.

Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 meson.build                    |  2 ++
 qapi/sockets.json              |  7 +++++++
 qemu-options.hx                | 13 +++++++++----
 tests/unit/test-util-sockets.c | 13 +++++++++++++
 util/qemu-sockets.c            | 24 ++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index eb07491819..c5afe8754d 100644
--- a/meson.build
+++ b/meson.build
@@ -2726,6 +2726,8 @@ config_host_data.set('HAVE_TCP_KEEPINTVL',
                      #endif
                      int main(void) { return 0; }''',
                      name: 'Win32 TCP_KEEPINTVL'))
+config_host_data.set('HAVE_TCP_USER_TIMEOUT',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_USER_TIMEOUT'))
 
 # has_member
 config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 473be2ac58..543689a2c7 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -79,6 +79,12 @@
 #     defined (this includes Linux, Windows, macOS, FreeBSD, but not
 #     OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
 #
+# @user-timeout: time in milliseconds that transmitted data may remain
+#     unacknowledged before the connection is closed.  Only supported
+#     for TCP sockets on systems where TCP_USER_TIMEOUT socket option
+#     is defined (Linux only).  When set to 0, system setting is used.
+#     (Since 11.1)
+#
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
 # Since: 1.3
@@ -94,6 +100,7 @@
     '*keep-alive-count': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPCNT' },
     '*keep-alive-idle': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
     '*keep-alive-interval': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPINTVL' },
+    '*user-timeout': { 'type': 'uint32', 'if': 'HAVE_TCP_USER_TIMEOUT' },
     '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
 
 ##
diff --git a/qemu-options.hx b/qemu-options.hx
index d2b816e16f..63587cccd3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3034,7 +3034,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "-netdev socket,id=str[,fd=h][,udp=host:port][,localaddr=host:port]\n"
     "                configure a network backend to connect to another network\n"
     "                using an UDP tunnel\n"
-    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
+    "-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.user-timeout=timeout][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]\n"
     "-netdev stream,id=str[,server=on|off],addr.type=unix,addr.path=path[,addr.abstract=on|off][,addr.tight=on|off][,reconnect-ms=milliseconds]\n"
     "-netdev stream,id=str[,server=on|off],addr.type=fd,addr.str=file-descriptor[,reconnect-ms=milliseconds]\n"
     "                configure a network backend to connect to another network\n"
@@ -3640,7 +3640,7 @@ SRST
                          -device e1000,netdev=n1,mac=52:54:00:12:34:56 \\
                          -netdev socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
 
-``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
+``-netdev stream,id=str[,server=on|off],addr.type=inet,addr.host=host,addr.port=port[,addr.to=maxport][,addr.numeric=on|off][,addr.keep-alive=on|off][,addr.keep-alive-count=count][,addr.keep-alive-idle=idle][,addr.keep-alive-interval=interval][,addr.user-timeout=timeout][,addr.mptcp=on|off][,addr.ipv4=on|off][,addr.ipv6=on|off][,reconnect-ms=milliseconds]``
     Configure a network backend to connect to another QEMU virtual machine or a proxy using a TCP/IP socket.
 
     ``server=on|off``
@@ -3670,6 +3670,11 @@ SRST
         time in seconds between individual keep-alive packets.
         Set to 0 to use the system default.  (default: 0)
 
+    ``addr.user-timeout=timeout``
+        time in milliseconds that transmitted data may remain unacknowledged
+        before the connection is forcibly closed.
+        Set to 0 to use the system default.  (default: 0)
+
     ``addr.mptcp=on|off``
         enable multipath TCP
 
@@ -5365,7 +5370,7 @@ SRST
 ERST
 
 DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
-    "-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]\n" \
+    "-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,user-timeout=timeout][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]\n" \
     "-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]\n" \
     "-incoming unix:socketpath\n" \
     "                prepare for incoming migration, listen on\n" \
@@ -5387,7 +5392,7 @@ migration channel types.  The channel type is specified in <channel>,
 or is 'main' for all other forms of -incoming.  If multiple -incoming
 options are specified for a channel type, the last one takes precedence.
 
-``-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]``
+``-incoming tcp:[host]:port[,to=maxport][,numeric=on|off][,keep-alive=on|off][,keep-alive-count=count][,keep-alive-idle=idle][,keep-alive-interval=interval][,user-timeout=timeout][,mptcp=on|off][,ipv4=on|off][,ipv6=on|off]``
   \ 
 ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
     Prepare for incoming migration, listen on a given tcp port.
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index b9f2453e29..a56efc1b83 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -382,6 +382,12 @@ static void inet_parse_test_helper(const char *str,
         g_assert_cmpint(addr.keep_alive_interval, ==,
                         exp_addr->keep_alive_interval);
 #endif
+#ifdef HAVE_TCP_USER_TIMEOUT
+        g_assert_cmpint(addr.has_user_timeout, ==,
+                        exp_addr->has_user_timeout);
+        g_assert_cmpint(addr.user_timeout, ==,
+                        exp_addr->user_timeout);
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         g_assert_cmpint(addr.has_mptcp, ==, exp_addr->has_mptcp);
         g_assert_cmpint(addr.mptcp, ==, exp_addr->mptcp);
@@ -495,6 +501,10 @@ static void test_inet_parse_all_options_good(void)
         .has_keep_alive_interval = true,
         .keep_alive_interval = 30,
 #endif
+#ifdef HAVE_TCP_USER_TIMEOUT
+        .has_user_timeout = true,
+        .user_timeout = 10000,
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         .has_mptcp = true,
         .mptcp = false,
@@ -511,6 +521,9 @@ static void test_inet_parse_all_options_good(void)
 #ifdef HAVE_TCP_KEEPINTVL
         ",keep-alive-interval=30"
 #endif
+#ifdef HAVE_TCP_USER_TIMEOUT
+        ",user-timeout=10000"
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         ",mptcp=off"
 #endif
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4773755fd5..f16f9b007c 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -263,6 +263,18 @@ static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
         }
 #endif
     }
+#ifdef HAVE_TCP_USER_TIMEOUT
+    if (saddr->has_user_timeout && saddr->user_timeout) {
+        int user_timeout = saddr->user_timeout;
+        int ret = setsockopt(sock, IPPROTO_TCP, TCP_USER_TIMEOUT, &user_timeout,
+                             sizeof(user_timeout));
+        if (ret < 0) {
+            error_setg_errno(errp, errno,
+                             "Unable to set TCP user timeout option on socket");
+            return -1;
+        }
+    }
+#endif
     return 0;
 }
 
@@ -692,6 +704,12 @@ static QemuOptsList inet_opts = {
             .type = QEMU_OPT_NUMBER,
         },
 #endif
+#ifdef HAVE_TCP_USER_TIMEOUT
+        {
+            .name = "user-timeout",
+            .type = QEMU_OPT_NUMBER,
+        },
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         {
             .name = "mptcp",
@@ -775,6 +793,12 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
         addr->keep_alive_interval = qemu_opt_get_number(opts, "keep-alive-interval", 0);
     }
 #endif
+#ifdef HAVE_TCP_USER_TIMEOUT
+    if (qemu_opt_find(opts, "user-timeout")) {
+        addr->has_user_timeout = true;
+        addr->user_timeout = qemu_opt_get_number(opts, "user-timeout", 0);
+    }
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
     if (qemu_opt_find(opts, "mptcp")) {
         addr->has_mptcp = true;
-- 
2.43.0


