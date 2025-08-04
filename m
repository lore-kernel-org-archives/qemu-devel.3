Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE10C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uixLi-00082B-34; Mon, 04 Aug 2025 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1uivuf-0000hQ-CG
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:11:42 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1uivud-0006lh-BD
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:11:41 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-556fd896c99so3103631e87.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754316696; x=1754921496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zj79clsOkfFXZ1MLGEEaSPBDYKCr2RqHzGVuinyox68=;
 b=Dk4tTJTle27LWwJSXexzTGLf6TE7/X2AeIUYI9dqtcxr/TNgbGHdWLlG5YbY36IZpW
 Z2aD/1wvuQ6xv0yDuaYSsj98jvftbDwjj3CNFOp+U3pUEGWnyJiIO8N/21LEfRv94fyU
 H0R7hxQaJNfQ21bnt6xJ0RO6ySG+B7lKzdmW4KhUYH+5L1e7TWO6QkztxwMucfDrC2Pk
 /xrwkcDEYZyhk67vi4rVuUUhii7BbQ+Eh9K8NK177VpS74vxGroFZTrsInQJnZ0UdotH
 ca4vFd6U8MKvJlRLXNkIUyY6j4QV/HUMy02F3rhDCkbBWg73UyQbkMzXubq1TYvpIFhE
 0Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754316696; x=1754921496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zj79clsOkfFXZ1MLGEEaSPBDYKCr2RqHzGVuinyox68=;
 b=Pgcr4JQCt4vMU7uIO6NBIdKGScczDukkpihkd3A7HExf/NqDnSIPc+5lo/BORhawaa
 bRstDkbmHXdZUbOJPJIWIMJ3K6LfAXJZrCZ9K2SpDXDyAilY4aUDRRzM/BPJEMSuK3vT
 kGYJSSaTNNNfP3pfIHiTsqRE7KwYm9X8XL000uFDOmMPWvffJ0Don4zaUc/jCceEXGOg
 m4A+zV6LxoaYKumEEyBI3vZwEihfLbSfzzwjj0pgus8hfwU2TgonHSYn5Rb+KkaMqKFN
 p0CrE3743WSp//XtZd5MSt2hZJMpZQxlcRp2gujNKJ7jXw7kKC35DGx0ZYuvs1JOyEqQ
 Snhw==
X-Gm-Message-State: AOJu0YyzWmLYbgP2YYPR7xHjEYC40IvS/coe8g/TPURuC5M9W69ZLXRW
 NC52fhi+wymu7LD91PyQKt5f7+4HqA4xRbjChYoqVGcUf7Q9Jkz0YIrWYeR/wiAw
X-Gm-Gg: ASbGncs2ip/BGK5l5kBtHDEWi/yjcp5kYvjV+8QD8cpOh9C9PWas1TiAKJIbWPhrZRh
 wBFuSme14safAtLsGzkn3V5nThcn+fGC00IfN9PZaO3U7SrWmVpAThY/rDQv+9ChWmK/jnOBQUs
 XQWT5G7139eDakksYEZLSQn+9Xk4htEiEagl0GFrCEzUHl1jTAgC8oamSgZ3cQTyClVEwJ7w3kA
 wZcHmPJHBrHuOTXYLYYAoe4+FsNLqjqbhJ0BfLwrWowEPWmAQ4MBIeAfV7l04jKZXSZQzjaaOh7
 7LrAC6LL+Wn/tGoxH95m1V7XGPVioUjb8mkgUflAFfeRQ7r/UZ4Kjkoli6b13oa1TI5uwT27jn3
 ZYB3pe9/0HhGXsR4zhvKtijAGUK9PzOOhkYk1eajBxdd1xQ==
X-Google-Smtp-Source: AGHT+IEBp5V0QGmBCOuj49O+gY9nXakVjuBcRuOJeWf1hO+6GiZieC6kUbqNZYYNsEmMui7xc70v3w==
X-Received: by 2002:a05:6512:3c91:b0:553:c9fb:5bad with SMTP id
 2adb3069b0e04-55b97a842e2mr2450341e87.1.1754316695802; 
 Mon, 04 Aug 2025 07:11:35 -0700 (PDT)
Received: from MURLOC (l37-193-36-68.novotelecom.ru. [37.193.36.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b88ca40f8sm1663397e87.139.2025.08.04.07.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 07:11:35 -0700 (PDT)
From: Viktor Kurilko <murlockkinght@gmail.com>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org,
	Viktor Kurilko <murlockkinght@gmail.com>
Subject: [PATCH v3] Add a feature for mapping a host unix socket to a guest
 tcp socket
Date: Mon,  4 Aug 2025 21:05:01 +0700
Message-ID: <20250804141125.313313-1-murlockkinght@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=murlockkinght@gmail.com; helo=mail-lf1-x130.google.com
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

Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>
---
Fixed initialization of the inet structure.

> Does that not behave oddly when given a path?

I didn't quite understand what you meant. If you mean that we try to parse the
host address despite the fact that it doesn't make sense for a unix socket, then
I added a check that in the case of using a unix socket, the host address should
be empty. As an alternative solution, I can suggest specifying the unix socket
path in the host address place and omitting the port initialization in this case.


 net/slirp.c | 69 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9657e86a84..71c8419762 100644
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
@@ -814,6 +815,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     int is_udp;
     const char *end;
     const char *fail_reason = "Unknown reason";
+    socklen_t host_addr_size;
 
     p = redir_str;
     if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
@@ -833,7 +835,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         fail_reason = "Missing : separator";
         goto fail_syntax;
     }
-    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
+    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.in.sin_addr)) {
         fail_reason = "Bad host address";
         goto fail_syntax;
     }
@@ -842,12 +844,53 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         fail_reason = "Bad host port separator";
         goto fail_syntax;
     }
-    err = qemu_strtoi(buf, &end, 0, &host_port);
-    if (err || host_port < 0 || host_port > 65535) {
-        fail_reason = "Bad host port";
-        goto fail_syntax;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    if (buf[0] == '/') {
+        if (is_udp) {
+            fail_reason = "Mapping unix to udp is not supported";
+            goto fail_syntax;
+        }
+
+        if (host_addr.in.sin_addr.s_addr != 0) {
+            fail_reason =
+                "the host address must be empty when using a unix socket";
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
@@ -867,7 +910,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if SLIRP_CHECK_VERSION(4, 5, 0)
     err = slirp_add_hostxfwd(s->slirp,
-            (struct sockaddr *) &host_addr, sizeof(host_addr),
+            (struct sockaddr *) &host_addr, host_addr_size,
             (struct sockaddr *) &guest_addr, sizeof(guest_addr),
             is_udp ? SLIRP_HOSTFWD_UDP : 0);
 #else
-- 
2.50.1


