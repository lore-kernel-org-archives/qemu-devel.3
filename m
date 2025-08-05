Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E9AC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 14:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujJ5D-0005wN-D4; Tue, 05 Aug 2025 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1ujJ59-0005uS-1U
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:56:03 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1ujJ56-0005wr-Oi
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 10:56:02 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55b827aba01so3892559e87.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754405758; x=1755010558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=80sokCbuzeFnZxYz1dl1PXf1ZIasxaii32lG9OAv164=;
 b=W1QeBZiXNHm5BUWqVl65j6JbkznfUeYPEuRxSnWX+xxSyPPHiWTsey9g7oVSi1ozw4
 yMx6n2ratCgrFMj7vWUV1JMudqeNGn8EcqKen7MTotrFtcyr5YxQxQh0w/Tp5oXGaB/q
 LLg8FY5/+BkxbyzOex3Ezru53rofD13XovtdFLcMOqmpBy5Wi+mw6cTqosAESh+4fflN
 gtKeUqbPZ0tgtnkGDlLx1tiZw9SCa3I/v+8AkVYombtwcbK6TaauqXV8WkeP+jF9n4oq
 LFax1hLFfz9lUPmYFItsVT0Z7lHh1cNOVZPRK0AnOoMMXn91BcoIfENlVeFDitUfg37d
 DwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405758; x=1755010558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=80sokCbuzeFnZxYz1dl1PXf1ZIasxaii32lG9OAv164=;
 b=QPdsTxHtEkKs9aIuOoqwMJKbtSMx/VN3KtFytpTEBgXFgiarhI9FZhs9M1x7tbmc+l
 4KZTrxh7DkBOLAmLhWsp85IJwGlYl3L79k5+9MahNyyTFiPaIAjNzBc57iUNtGiN/klB
 u0PJJ4g4bpFAI0PndajKJTjxGMhDz3KroN3UmYTsbzeh+DVH/7RaxwcjwRxbQ7vz18ZU
 AaYSIPVGUKEzzkG2lHvXHxQBVX/7DekOlp7YeQHAbKGzNWOXzhoXl6egGf3p7SwXkthw
 d514w5Y72ZdJVb8edOWSD7xxu//WIakJlQ2ub62/fgaE9T2543QQo2bGuET6k10JzOx0
 +Vxw==
X-Gm-Message-State: AOJu0YyxZNpyGNiBWjWY2agML/Ytu4ARXDGm+22OSkow8/RclNYRCVh2
 +xcZm0/BQmJkyBklxFf0OZ/ybPG1BZei622KrfgHcFbDyBJh1R88z3BM6+wXoTv9
X-Gm-Gg: ASbGncvV4IcN+1YSJuIsQBuPaKw6RSTpn7RV0JfHQev/7ro26bx0RHaFpQXjsw0Rh35
 38XgY5hRWvWdaCu9oYobasZdCAMX1ZgWs08v2nwedtUyUe6RWgAfcFnEh9JycqBafNgeSvn64KN
 A637ZQQdmDhHqhmX8BiEmNoUwKC6wYn53p9wX9SLtq2cH80p+dt3/hPxGo32nKSBxnlc72Byec/
 IHnMfL3c7yIL3+1DqKEW1n0ZgbEW0B3bIA4Ae1oTYMimOrsk/wcqgUyRswfHhzBlsOiFdLbtCZK
 P7kf1IiPYL27bs5yPFezP0r8VqoOQSnKZx+SAMRWos26yUEfO8ztAG9Z3PKeYDYKzfpYrqu+8rv
 DIh3Qd0DqwXjcEjZUgMyJFTdHHhQuwvGV7Kdfh0DXX/oBAFs=
X-Google-Smtp-Source: AGHT+IFa823LBxFFOdrDfTbLZ2KWuwC9d1EV/mxRxkPpkESdLP87ni4eeZO2Apf38yR8SyNiz+89mQ==
X-Received: by 2002:a05:6512:3b97:b0:55b:827d:e373 with SMTP id
 2adb3069b0e04-55b97abe626mr3473389e87.12.1754405757292; 
 Tue, 05 Aug 2025 07:55:57 -0700 (PDT)
Received: from MURLOC (l37-193-36-68.novotelecom.ru. [37.193.36.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b88cabb67sm2038494e87.152.2025.08.05.07.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:55:56 -0700 (PDT)
From: Viktor Kurilko <murlockkinght@gmail.com>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org,
	Viktor Kurilko <murlockkinght@gmail.com>
Subject: [PATCH v4] Add a feature for mapping a host unix socket to a guest
 tcp socket
Date: Tue,  5 Aug 2025 21:52:50 +0700
Message-ID: <20250805145543.580526-1-murlockkinght@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=murlockkinght@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds the ability to map a host unix socket to a guest tcp socket when
using the slirp backend. This feature was added in libslirp version 4.7.0.

A new syntax for unix socket: -hostfwd=unix:hostpath-[guestaddr]:guestport

Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>
---
A reworked solution. Now the host address is not parsed when using a unix socket.
Documentation has also been added.

 docs/system/devices/net.rst |   2 +-
 hmp-commands.hx             |   4 +-
 net/slirp.c                 | 102 +++++++++++++++++++++++++++---------
 qapi/net.json               |   2 +-
 qemu-options.hx             |  11 +++-
 5 files changed, 91 insertions(+), 30 deletions(-)

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
index d0e4f35a30..64a463b15b 100644
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
index 9657e86a84..5a63ca476e 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -795,12 +795,13 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
 
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
@@ -811,9 +812,11 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     int host_port, guest_port;
     const char *p;
     char buf[256];
-    int is_udp;
+    int is_udp = 0;
+    int is_unix = 0;
     const char *end;
     const char *fail_reason = "Unknown reason";
+    socklen_t host_addr_size;
 
     p = redir_str;
     if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
@@ -824,30 +827,81 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
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
+    if (get_str_sep(buf, sizeof(buf), &p, is_unix ? '-' : ':') < 0) {
+        if (is_unix) {
+            fail_reason = "Missing - separator";
+        } else {
+            fail_reason = "Missing : separator";
+        }
         goto fail_syntax;
     }
-    err = qemu_strtoi(buf, &end, 0, &host_port);
-    if (err || host_port < 0 || host_port > 65535) {
-        fail_reason = "Bad host port";
-        goto fail_syntax;
+
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    if (is_unix) {
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
+        host_addr.in.sin_family = AF_INET;
+        host_addr.in.sin_addr.s_addr = INADDR_ANY;
+        host_addr.in.sin_port = htons(host_port);
+        host_addr_size = sizeof(host_addr.in);
     }
-    host_addr.sin_port = htons(host_port);
 
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
         fail_reason = "Missing guest address";
@@ -867,7 +921,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if SLIRP_CHECK_VERSION(4, 5, 0)
     err = slirp_add_hostxfwd(s->slirp,
-            (struct sockaddr *) &host_addr, sizeof(host_addr),
+            (struct sockaddr *) &host_addr, host_addr_size,
             (struct sockaddr *) &guest_addr, sizeof(guest_addr),
             is_udp ? SLIRP_HOSTFWD_UDP : 0);
 #else
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
index ab23f14d21..86a70e0315 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3317,8 +3317,8 @@ SRST
 
         Note that a SAMBA server must be installed on the host OS.
 
-    ``hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport``
-        Redirect incoming TCP or UDP connections to the host port
+    ``hostfwd=[tcp|udp|unix]:[[hostaddr]:hostport|hostpath]-[guestaddr]:guestport``
+        Redirect incoming TCP, UDP or UNIX connections to the host port
         hostport to the guest IP address guestaddr on guest port
         guestport. If guestaddr is not specified, its value is x.x.x.15
         (default first address given by the built-in DHCP server). By
@@ -3348,6 +3348,13 @@ SRST
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
2.50.1


