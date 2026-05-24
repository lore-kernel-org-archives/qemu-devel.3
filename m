Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11567CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR93c-00050V-4T; Sun, 24 May 2026 09:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3Mf-0008OH-0G
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:13 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <Mitsuru.Kariya@oss.nttdata.com>)
 id 1wR3Md-0002RN-7G
 for qemu-devel@nongnu.org; Sun, 24 May 2026 03:35:12 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 468C820202B8; Sun, 24 May 2026 16:35:09 +0900 (JST)
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
Subject: [PATCH 5/5] tests/qtest/netdev-socket: smoke test -netdev stream inet
 option set
Date: Sun, 24 May 2026 16:34:42 +0900
Message-ID: <20260524073442.435408-6-Mitsuru.Kariya@oss.nttdata.com>
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

The existing /netdev/stream/inet/ipv4 and /ipv6 tests only exercise
addr.type, addr.host, addr.port and addr.ipv4/ipv6.  None of the other
optional InetSocketAddress members (numeric, to, keep-alive,
keep-alive-count, keep-alive-idle, keep-alive-interval, user-timeout,
mptcp) have any test coverage on the QAPI keyval parsing path used by
netdev_parse_modern().  That gap let the qemu-options.hx synopsis drift
out of sync with reality (multiple options were documented without the
required "addr." prefix, which the QAPI input visitor would have
rejected).

Add /netdev/stream/inet/options that sets all those options on the
server and client -netdev stream invocations.  The options conditionally
compiled by HAVE_TCP_KEEP*/HAVE_TCP_USER_TIMEOUT/HAVE_IPPROTO_MPTCP are
gated the same way here, mirroring inet_set_sockopts() and the QAPI
schema.

This is a smoke test: it verifies QEMU accepts the options and the
netdev reaches "listening"/"tcp:..." state.  It does not read the
options back from the kernel; that path is already covered indirectly
by test_inet_parse_all_options_good which exercises inet_set_sockopts()
through the QemuOpts inet_parse() path.

Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 tests/qtest/netdev-socket.c | 71 +++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index b731af0ad9..d1718813eb 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -146,6 +146,76 @@ static void test_stream_inet_ipv4(void)
     qtest_quit(qts0);
 }
 
+/*
+ * Smoke test that -netdev stream accepts all optional InetSocketAddress
+ * members (numeric, to, keep-alive*, user-timeout, mptcp).  Catches
+ * regressions in the QAPI schema, the keyval parsing path, and the
+ * synopsis spelling in qemu-options.hx.
+ */
+static void test_stream_inet_options(void)
+{
+    QTestState *qts0, *qts1;
+    char *expect;
+    int port;
+
+    port = inet_get_free_port(false);
+    qts0 = qtest_initf("-nodefaults -M none "
+                       "-netdev stream,id=st0,server=true,addr.type=inet,"
+                       "addr.ipv4=on,addr.ipv6=off,addr.numeric=on,"
+                       "addr.host=127.0.0.1,addr.port=%d,addr.to=%d,"
+                       "addr.keep-alive=on"
+#ifdef HAVE_TCP_KEEPCNT
+                       ",addr.keep-alive-count=3"
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+                       ",addr.keep-alive-idle=10"
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+                       ",addr.keep-alive-interval=5"
+#endif
+#ifdef HAVE_TCP_USER_TIMEOUT
+                       ",addr.user-timeout=10000"
+#endif
+#ifdef HAVE_IPPROTO_MPTCP
+                       ",addr.mptcp=off"
+#endif
+                       , port, port);
+
+    EXPECT_STATE(qts0, "st0: index=0,type=stream,listening\r\n", 0);
+
+    qts1 = qtest_initf("-nodefaults -M none "
+                       "-netdev stream,server=false,id=st0,addr.type=inet,"
+                       "addr.ipv4=on,addr.ipv6=off,addr.numeric=on,"
+                       "addr.host=127.0.0.1,addr.port=%d,"
+                       "addr.keep-alive=on"
+#ifdef HAVE_TCP_KEEPCNT
+                       ",addr.keep-alive-count=3"
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+                       ",addr.keep-alive-idle=10"
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+                       ",addr.keep-alive-interval=5"
+#endif
+#ifdef HAVE_TCP_USER_TIMEOUT
+                       ",addr.user-timeout=10000"
+#endif
+#ifdef HAVE_IPPROTO_MPTCP
+                       ",addr.mptcp=off"
+#endif
+                       , port);
+
+    expect = g_strdup_printf("st0: index=0,type=stream,tcp:127.0.0.1:%d\r\n",
+                             port);
+    EXPECT_STATE(qts1, expect, 0);
+    g_free(expect);
+
+    EXPECT_STATE(qts0, "st0: index=0,type=stream,tcp:127.0.0.1", ':');
+
+    qtest_quit(qts1);
+    qtest_quit(qts0);
+}
+
 static void wait_stream_connected(QTestState *qts, const char *id,
                                   SocketAddress **addr)
 {
@@ -512,6 +582,7 @@ int main(int argc, char **argv)
 
     if (has_ipv4) {
         qtest_add_func("/netdev/stream/inet/ipv4", test_stream_inet_ipv4);
+        qtest_add_func("/netdev/stream/inet/options", test_stream_inet_options);
         qtest_add_func("/netdev/dgram/inet", test_dgram_inet);
 #if !defined(_WIN32) && !defined(CONFIG_DARWIN)
         qtest_add_func("/netdev/dgram/mcast", test_dgram_mcast);
-- 
2.43.0


