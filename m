Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9C4C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 15:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFxS0-0000Tf-Ik; Fri, 16 May 2025 11:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRy-0000KW-Pe
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFxRw-0002ed-EE
 for qemu-devel@nongnu.org; Fri, 16 May 2025 11:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747411095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFMICsjYm62/z6PLh4qeoP8TmO0u9dpjXLy2gFguuw8=;
 b=XQibT9B9qOypPGkh6pmDdDfElqwa1+EX5NLYdDXcQuP0fP9V0pcj+eo/58dC4Ue0OOURD5
 B0sqsOQcWr6yWiAhOXjpfZK3Fgq628n16qmkAIr++YKwV4GyoYqKBU/hCgqlpaOs0TLFml
 /piGmVSLr1FQLTIl0PQ8YG857o0on+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-921KARWCNXmJibd9IuEkuA-1; Fri,
 16 May 2025 11:58:13 -0400
X-MC-Unique: 921KARWCNXmJibd9IuEkuA-1
X-Mimecast-MFC-AGG-ID: 921KARWCNXmJibd9IuEkuA_1747411093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 199A11800772; Fri, 16 May 2025 15:58:13 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D02518003FC; Fri, 16 May 2025 15:58:11 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 7/7] util/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Date: Fri, 16 May 2025 17:56:59 +0200
Message-ID: <20250516155710.2246148-8-jmarcin@redhat.com>
In-Reply-To: <20250516155710.2246148-1-jmarcin@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

With the default TCP stack configuration, it could be even 2 hours
before the connection times out due to the other side not being
reachable. However, in some cases, the application needs to be aware of
a connection issue much sooner.

This is the case, for example, for postcopy live migration. If there is
no traffic from the migration destination guest (server-side) to the
migration source guest (client-side), the destination keeps waiting for
pages indefinitely and does not switch to the postcopy-paused state.
This can happen, for example, if the destination QEMU instance is
started with the '-S' command line option and the machine is not started
yet, or if the machine is idle and produces no new page faults for
not-yet-migrated pages.

This patch introduces new inet socket parameters that control count,
idle period, and interval of TCP keep-alive packets before the
connection is considered broken. These parameters are available on
systems where the respective TCP socket options are defined, that
includes Linux, Windows, macOS, but not OpenBSD. Additionally, macOS
defines TCP_KEEPIDLE as TCP_KEEPALIVE instead, so the patch supplies its
own definition.

The default value for all is 0, which means the system configuration is
used.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 meson.build                    | 30 ++++++++++++
 qapi/sockets.json              | 19 ++++++++
 tests/unit/test-util-sockets.c | 33 ++++++++++++++
 util/qemu-sockets.c            | 83 ++++++++++++++++++++++++++++++++++
 4 files changed, 165 insertions(+)

diff --git a/meson.build b/meson.build
index ad2053f968..fdad3fb528 100644
--- a/meson.build
+++ b/meson.build
@@ -2760,6 +2760,36 @@ if linux_io_uring.found()
   config_host_data.set('HAVE_IO_URING_PREP_WRITEV2',
                        cc.has_header_symbol('liburing.h', 'io_uring_prep_writev2'))
 endif
+config_host_data.set('HAVE_TCP_KEEPCNT',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPCNT') or
+                     cc.compiles('''
+                     #include <ws2tcpip.h>
+                     #ifndef TCP_KEEPCNT
+                     #error
+                     #endif
+                     int main(void) { return 0; }''',
+                     name: 'Win32 TCP_KEEPCNT'))
+# On Darwin TCP_KEEPIDLE is available under different name, TCP_KEEPALIVE.
+# https://github.com/apple/darwin-xnu/blob/xnu-4570.1.46/bsd/man/man4/tcp.4#L172
+config_host_data.set('HAVE_TCP_KEEPIDLE',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPIDLE') or
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPALIVE') or
+                     cc.compiles('''
+                     #include <ws2tcpip.h>
+                     #ifndef TCP_KEEPIDLE
+                     #error
+                     #endif
+                     int main(void) { return 0; }''',
+                     name: 'Win32 TCP_KEEPIDLE'))
+config_host_data.set('HAVE_TCP_KEEPINTVL',
+                     cc.has_header_symbol('netinet/tcp.h', 'TCP_KEEPINTVL') or
+                     cc.compiles('''
+                     #include <ws2tcpip.h>
+                     #ifndef TCP_KEEPINTVL
+                     #error
+                     #endif
+                     int main(void) { return 0; }''',
+                     name: 'Win32 TCP_KEEPINTVL'))
 
 # has_member
 config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 62797cd027..f9f559daba 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -59,6 +59,22 @@
 # @keep-alive: enable keep-alive when connecting to/listening on this socket.
 #     (Since 4.2, not supported for listening sockets until 10.1)
 #
+# @keep-alive-count: number of keep-alive packets sent before the connection is
+#     closed.  Only supported for TCP sockets on systems where TCP_KEEPCNT
+#     socket option is defined (this includes Linux, Windows, macOS, FreeBSD,
+#     but not OpenBSD).  When set to 0, system setting is used.  (Since 10.1)
+#
+# @keep-alive-idle: time in seconds the connection needs to be idle before
+#     sending a keepalive packet.  Only supported for TCP sockets on systems
+#     where TCP_KEEPIDLE socket option is defined (this includes Linux,
+#     Windows, macOS, FreeBSD, but not OpenBSD).  When set to 0, system setting
+#     is used.  (Since 10.1)
+#
+# @keep-alive-interval: time in seconds between keep-alive packets.  Only
+#     supported for TCP sockets on systems where TCP_KEEPINTVL is defined (this
+#     includes Linux, Windows, macOS, FreeBSD, but not OpenBSD).  When set to
+#     0, system setting is used.  (Since 10.1)
+#
 # @mptcp: enable multi-path TCP.  (Since 6.1)
 #
 # Since: 1.3
@@ -71,6 +87,9 @@
     '*ipv4': 'bool',
     '*ipv6': 'bool',
     '*keep-alive': 'bool',
+    '*keep-alive-count': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPCNT' },
+    '*keep-alive-idle': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPIDLE' },
+    '*keep-alive-interval': { 'type': 'uint32', 'if': 'HAVE_TCP_KEEPINTVL' },
     '*mptcp': { 'type': 'bool', 'if': 'HAVE_IPPROTO_MPTCP' } } }
 
 ##
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 77d0767b9b..e4fb5b702a 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -358,6 +358,18 @@ static void inet_parse_test_helper(const char *str, InetSocketAddress *exp_addr,
         g_assert_cmpint(addr.ipv6, ==, exp_addr->ipv6);
         g_assert_cmpint(addr.has_keep_alive, ==, exp_addr->has_keep_alive);
         g_assert_cmpint(addr.keep_alive, ==, exp_addr->keep_alive);
+#ifdef HAVE_TCP_KEEPCNT
+        g_assert_cmpint(addr.has_keep_alive_count, ==, exp_addr->has_keep_alive_count);
+        g_assert_cmpint(addr.keep_alive_count, ==, exp_addr->keep_alive_count);
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+        g_assert_cmpint(addr.has_keep_alive_idle, ==, exp_addr->has_keep_alive_idle);
+        g_assert_cmpint(addr.keep_alive_idle, ==, exp_addr->keep_alive_idle);
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+        g_assert_cmpint(addr.has_keep_alive_interval, ==, exp_addr->has_keep_alive_interval);
+        g_assert_cmpint(addr.keep_alive_interval, ==, exp_addr->keep_alive_interval);
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         g_assert_cmpint(addr.has_mptcp, ==, exp_addr->has_mptcp);
         g_assert_cmpint(addr.mptcp, ==, exp_addr->mptcp);
@@ -459,6 +471,18 @@ static void test_inet_parse_all_options_good(void)
         .ipv6 = true,
         .has_keep_alive = true,
         .keep_alive = true,
+#ifdef HAVE_TCP_KEEPCNT
+        .has_keep_alive_count = true,
+        .keep_alive_count = 10,
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+        .has_keep_alive_idle = true,
+        .keep_alive_idle = 60,
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+        .has_keep_alive_interval = true,
+        .keep_alive_interval = 30,
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         .has_mptcp = true,
         .mptcp = true,
@@ -466,6 +490,15 @@ static void test_inet_parse_all_options_good(void)
     };
     inet_parse_test_helper(
         "[::1]:5000,numeric,to=5006,ipv4=off,ipv6=on,keep-alive"
+#ifdef HAVE_TCP_KEEPCNT
+        ",keep-alive-count=10"
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+        ",keep-alive-idle=60"
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+        ",keep-alive-interval=30"
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         ",mptcp"
 #endif
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 403dc26b36..3da5c18870 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -45,6 +45,14 @@
 # define AI_NUMERICSERV 0
 #endif
 
+/*
+ * On macOS TCP_KEEPIDLE is available under a different name, TCP_KEEPALIVE.
+ * https://github.com/apple/darwin-xnu/blob/xnu-4570.1.46/bsd/man/man4/tcp.4#L172
+ */
+#if defined(TCP_KEEPALIVE) && !defined(TCP_KEEPIDLE)
+# define TCP_KEEPIDLE TCP_KEEPALIVE
+#endif
+
 
 static int inet_getport(struct addrinfo *e)
 {
@@ -218,6 +226,45 @@ static int inet_set_sockopts(int sock, InetSocketAddress *saddr, Error **errp)
                              "Unable to set keep-alive option on socket");
             return -1;
         }
+#ifdef HAVE_TCP_KEEPCNT
+        if (saddr->has_keep_alive_count &&
+            saddr->keep_alive_count) {
+            int keep_count = saddr->has_keep_alive_count;
+            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPCNT, &keep_count,
+                             sizeof(keep_count));
+            if (ret < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to set TCP keep-alive count option on socket");
+                return -1;
+            }
+        }
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+        if (saddr->has_keep_alive_idle &&
+            saddr->keep_alive_idle) {
+            int keep_idle = saddr->has_keep_alive_idle;
+            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPIDLE, &keep_idle,
+                             sizeof(keep_idle));
+            if (ret < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to set TCP keep-alive idle option on socket");
+                return -1;
+            }
+        }
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+        if (saddr->has_keep_alive_interval &&
+            saddr->keep_alive_interval) {
+            int keep_interval = saddr->has_keep_alive_interval;
+            ret = setsockopt(sock, IPPROTO_TCP, TCP_KEEPINTVL, &keep_interval,
+                             sizeof(keep_interval));
+            if (ret < 0) {
+                error_setg_errno(errp, errno,
+                                 "Unable to set TCP keep-alive interval option on socket");
+                return -1;
+            }
+        }
+#endif
     }
     return 0;
 }
@@ -630,6 +677,24 @@ static QemuOptsList inet_opts = {
             .name = "keep-alive",
             .type = QEMU_OPT_BOOL,
         },
+#ifdef HAVE_TCP_KEEPCNT
+        {
+            .name = "keep-alive-count",
+            .type = QEMU_OPT_NUMBER,
+        },
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+        {
+            .name = "keep-alive-idle",
+            .type = QEMU_OPT_NUMBER,
+        },
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+        {
+            .name = "keep-alive-interval",
+            .type = QEMU_OPT_NUMBER,
+        },
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
         {
             .name = "mptcp",
@@ -695,6 +760,24 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
         addr->has_keep_alive = true;
         addr->keep_alive = qemu_opt_get_bool(opts, "keep-alive", false);
     }
+#ifdef HAVE_TCP_KEEPCNT
+    if (qemu_opt_find(opts, "keep-alive-count")) {
+        addr->has_keep_alive_count = true;
+        addr->keep_alive_count = qemu_opt_get_number(opts, "keep-alive-count", 0);
+    }
+#endif
+#ifdef HAVE_TCP_KEEPIDLE
+    if (qemu_opt_find(opts, "keep-alive-idle")) {
+        addr->has_keep_alive_idle = true;
+        addr->keep_alive_idle = qemu_opt_get_number(opts, "keep-alive-idle", 0);
+    }
+#endif
+#ifdef HAVE_TCP_KEEPINTVL
+    if (qemu_opt_find(opts, "keep-alive-interval")) {
+        addr->has_keep_alive_interval = true;
+        addr->keep_alive_interval = qemu_opt_get_number(opts, "keep-alive-interval", 0);
+    }
+#endif
 #ifdef HAVE_IPPROTO_MPTCP
     if (qemu_opt_find(opts, "mptcp")) {
         addr->has_mptcp = true;
-- 
2.49.0


