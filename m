Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2359CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UiH-0001ON-1M; Sun, 05 Oct 2025 15:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=F64V=4O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1v5UiF-0001O6-D7
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:48:07 -0400
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]
 helo=sonata.ens-lyon.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=F64V=4O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1v5UiC-0001nW-VF
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:48:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 781F6A0282;
 Sun,  5 Oct 2025 21:48:01 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGPj9FFrodQ4; Sun,  5 Oct 2025 21:48:01 +0200 (CEST)
Received: from begin (38.127.95.79.rev.sfr.net [79.95.127.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id 31631A0283;
 Sun,  5 Oct 2025 21:48:01 +0200 (CEST)
Received: from samy by begin with local (Exim 4.98.2)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1v5Uhj-0000000H8cx-0M6s; Sun, 05 Oct 2025 21:47:35 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Viktor Kurilko <murlockkinght@gmail.com>, stefanha@redhat.com,
 jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PULL 1/1] Add a feature for mapping a host unix socket to a guest
 tcp socket
Date: Sun,  5 Oct 2025 21:47:34 +0200
Message-ID: <20251005194734.4084726-2-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
References: <20251005194734.4084726-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=F64V=4O=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Viktor Kurilko <murlockkinght@gmail.com>

This patch adds the ability to map a host unix socket to a guest tcp socket when
using the slirp backend. This feature was added in libslirp version 4.7.0.

A new syntax for unix socket: -hostfwd=unix:hostpath-[guestaddr]:guestport

Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-ID: <20250808143904.363907-1-murlockkinght@gmail.com>
---
 docs/system/devices/net.rst |   2 +-
 hmp-commands.hx             |   4 +-
 net/slirp.c                 | 114 +++++++++++++++++++++++++++---------
 qapi/net.json               |   2 +-
 qemu-options.hx             |  11 +++-
 5 files changed, 100 insertions(+), 33 deletions(-)

diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
index 7d76fe88c4..13199a44fd 100644
--- a/docs/system/devices/net.rst
+++ b/docs/system/devices/net.rst
@@ -79,7 +79,7 @@ those sockets. To allow ping for GID 100 (usually users group)::
 
 When using the built-in TFTP server, the router is also the TFTP server.
 
-When using the ``'-netdev user,hostfwd=...'`` option, TCP or UDP
+When using the ``'-netdev user,hostfwd=...'`` option, TCP, UDP or UNIX
 connections can be redirected from the host to the guest. It allows for
 example to redirect X11, telnet or SSH connections.
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 3cace8f1f7..15f6082596 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1357,8 +1357,8 @@ ERST
     {
         .name       = "hostfwd_add",
         .args_type  = "arg1:s,arg2:s?",
-        .params     = "[netdev_id] [tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport",
-        .help       = "redirect TCP or UDP connections from host to guest (requires -net user)",
+        .params     = "[netdev_id] [tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestaddr]:guestport",
+        .help       = "redirect TCP, UDP or UNIX connections from host to guest (requires -net user)",
         .cmd        = hmp_hostfwd_add,
     },
 #endif
diff --git a/net/slirp.c b/net/slirp.c
index 0a1c2a5eac..c627a9dd24 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -732,6 +732,7 @@ static SlirpState *slirp_lookup(Monitor *mon, const char *id)
 
 void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
 {
+    /* TODO: support removing unix fwd */
     struct sockaddr_in host_addr = {
         .sin_family = AF_INET,
         .sin_addr = {
@@ -800,12 +801,13 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
 
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 {
-    struct sockaddr_in host_addr = {
-        .sin_family = AF_INET,
-        .sin_addr = {
-            .s_addr = INADDR_ANY,
-        },
-    };
+    union {
+        struct sockaddr_in in;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+        struct sockaddr_un un;
+#endif
+    } host_addr = {0};
+
     struct sockaddr_in guest_addr = {
         .sin_family = AF_INET,
         .sin_addr = {
@@ -816,9 +818,13 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     int host_port, guest_port;
     const char *p;
     char buf[256];
-    int is_udp;
+    int is_udp = 0;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    int is_unix = 0;
+#endif
     const char *end;
     const char *fail_reason = "Unknown reason";
+    socklen_t host_addr_size;
 
     p = redir_str;
     if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
@@ -829,30 +835,83 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         is_udp = 0;
     } else if (!strcmp(buf, "udp")) {
         is_udp = 1;
-    } else {
-        fail_reason = "Bad protocol name";
-        goto fail_syntax;
     }
-
-    if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
-        fail_reason = "Missing : separator";
-        goto fail_syntax;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    else if (!strcmp(buf, "unix")) {
+        is_unix = 1;
     }
-    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
-        fail_reason = "Bad host address";
+#endif
+    else {
+        fail_reason = "Bad protocol name";
         goto fail_syntax;
     }
 
-    if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
-        fail_reason = "Bad host port separator";
-        goto fail_syntax;
-    }
-    err = qemu_strtoi(buf, &end, 0, &host_port);
-    if (err || host_port < 0 || host_port > 65535) {
-        fail_reason = "Bad host port";
-        goto fail_syntax;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    if (is_unix) {
+        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+            fail_reason = "Missing - separator";
+            goto fail_syntax;
+        }
+        if (buf[0] == '\0') {
+            fail_reason = "Missing unix socket path";
+            goto fail_syntax;
+        }
+        if (buf[0] != '/') {
+            fail_reason = "unix socket path must be absolute";
+            goto fail_syntax;
+        }
+
+        size_t path_len = strlen(buf);
+        if (path_len > sizeof(host_addr.un.sun_path) - 1) {
+            fail_reason = "Unix socket path is too long";
+            goto fail_syntax;
+        }
+
+        struct stat st;
+        if (stat(buf, &st) == 0) {
+            if (!S_ISSOCK(st.st_mode)) {
+                fail_reason = "file exists and it's not unix socket";
+                goto fail_syntax;
+            }
+
+            if (unlink(buf) < 0) {
+                error_setg_errno(errp, errno, "Failed to unlink '%s'", buf);
+                goto fail_syntax;
+            }
+        }
+        host_addr.un.sun_family = AF_UNIX;
+        memcpy(host_addr.un.sun_path, buf, path_len);
+        host_addr_size = sizeof(host_addr.un);
+    } else
+#endif
+    {
+        host_addr.in.sin_family = AF_INET;
+        host_addr.in.sin_addr.s_addr = INADDR_ANY;
+
+        if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+            fail_reason = "Missing : separator";
+            goto fail_syntax;
+        }
+
+        if (buf[0] != '\0' && !inet_aton(buf, &host_addr.in.sin_addr)) {
+            fail_reason = "Bad host address";
+            goto fail_syntax;
+        }
+
+        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+            fail_reason = "Bad host port separator";
+            goto fail_syntax;
+        }
+
+        err = qemu_strtoi(buf, &end, 0, &host_port);
+        if (err || host_port < 0 || host_port > 65535) {
+            fail_reason = "Bad host port";
+            goto fail_syntax;
+        }
+
+        host_addr.in.sin_port = htons(host_port);
+        host_addr_size = sizeof(host_addr.in);
     }
-    host_addr.sin_port = htons(host_port);
 
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
         fail_reason = "Missing guest address";
@@ -872,12 +931,13 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if SLIRP_CHECK_VERSION(4, 5, 0)
     err = slirp_add_hostxfwd(s->slirp,
-            (struct sockaddr *) &host_addr, sizeof(host_addr),
+            (struct sockaddr *) &host_addr, host_addr_size,
             (struct sockaddr *) &guest_addr, sizeof(guest_addr),
             is_udp ? SLIRP_HOSTFWD_UDP : 0);
 #else
+    (void) host_addr_size;
     err = slirp_add_hostfwd(s->slirp, is_udp,
-            host_addr.sin_addr, host_port,
+            host_addr.in.sin_addr, host_port,
             guest_addr.sin_addr, guest_port);
 #endif
 
diff --git a/qapi/net.json b/qapi/net.json
index 78bcc9871e..60d196afe5 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -281,7 +281,7 @@
 #
 # @smbserver: IP address of the built-in SMB server
 #
-# @hostfwd: redirect incoming TCP or UDP host connections to guest
+# @hostfwd: redirect incoming TCP, UDP or UNIX host connections to guest
 #     endpoints
 #
 # @guestfwd: forward guest TCP connections
diff --git a/qemu-options.hx b/qemu-options.hx
index 075f4be2e3..a9d640d9e6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3324,8 +3324,8 @@ SRST
 
         Note that a SAMBA server must be installed on the host OS.
 
-    ``hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport``
-        Redirect incoming TCP or UDP connections to the host port
+    ``hostfwd=[tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestaddr]:guestport``
+        Redirect incoming TCP, UDP or UNIX connections to the host port
         hostport to the guest IP address guestaddr on guest port
         guestport. If guestaddr is not specified, its value is x.x.x.15
         (default first address given by the built-in DHCP server). By
@@ -3355,6 +3355,13 @@ SRST
         Then when you use on the host ``telnet localhost 5555``, you
         connect to the guest telnet server.
 
+        To redirect host unix socket /tmp/vm to guest tcp socket 23 use
+        following:
+
+        .. parsed-literal::
+            # on the host
+            |qemu_system| -nic user,hostfwd=unix:/tmp/vm-:23
+
     ``guestfwd=[tcp]:server:port-dev``; \ ``guestfwd=[tcp]:server:port-cmd:command``
         Forward guest TCP connections to the IP address server on port
         port to the character device dev or to a program executed by
-- 
2.51.0


