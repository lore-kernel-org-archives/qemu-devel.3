Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0385C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLa-0001LX-Ci; Fri, 07 Feb 2025 10:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKQ-0008BS-KW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:39 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKD-00042b-IA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:38 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so350971566b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942283; x=1739547083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6N9ryvNx2tTT6HdSFLFKVlKftlNVXYRqQdp7SLQm3o=;
 b=QDOCmzDnR6lDCWbGxrpptVcpOr+EZC3ASYjZSPsGMtmu61FBUAaT/GhsYOwEeYknZq
 hFNizwhIbcB2Aif3N5VdHMZ/0wGOFoHO+IJBDPbOFjbVOjb+ly2YIlDSYyok6g7M4nzS
 LYs0x+DFNwI6vxj/HM22CIIumO54jXzTXclnPHyhKXspmtM32zOm22+ZBYNrT5XK50Km
 Vho4sauydB4Xn8o6As7aK3mKEp7xXGoTZXmI01TM8ZY6vbEcLJakSRoeZhbWBb+LlKkD
 hG8QKseSfQkO7ValAELFl3UuVo2O+jL+So9apNTC9JGcRGXt+ldUv47iEa7V4vZvVZps
 pefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942283; x=1739547083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6N9ryvNx2tTT6HdSFLFKVlKftlNVXYRqQdp7SLQm3o=;
 b=LJv0bvgBF3Q7EvCSZZDK6ZeqSkDNP/RIOmo+Vn/E+MzbcljW19J82M9GX1y64B/cV8
 0Qy5p5QZsbSZzm9ooJSgxxqzscU6qoylZjA/8VjvY3uHt4nIP8yMUk/7fjj5fjVimJMF
 EEdLRWDTCp1OoNYBd8q38bCaovI512cm/Iv3uyookwtSeeDUYTKExhXYfwVmvsmp//i1
 cKPa+Efm2MxsNrZfdr/dZYTc/2xUd5YQBp6NGCdGskPp0w0LFubAqR7hXAuR2t4WjXeh
 fv74k4JkrP/1Iwdqfj7YujUiozOkJkxB8onJCWd815ZHLUiULjmB/29ylLXqAEAFBE4+
 9sNQ==
X-Gm-Message-State: AOJu0Yz59SQ8LPoz73NEVDXpe+VKHcpfRRJGbd5eKu2kR+C4GyxYT+PG
 mK0GZKJTIvvcZzEfZj9i5VYYj9V0MklyWL6bY5ZxktudrXku9WZI7o22iUlr13g=
X-Gm-Gg: ASbGnctqQeBDkwyPdi5MTxfhd/2NrjYBsrhVt0Ni3RAqA3VL3ylXExZSC6bisa79eYp
 pibu5qB6cYEMNhGWNCi+FEjakEzwFuxu7MWAkcbi99ATUyk6m+Bu7DW04zh5cK1FQcrV2ySf4Vz
 EB0yfAokXN6X2sH1q2OGXiskPhYWEchc2cMRZxQkq7ZlJQHDYgXLcBnQh2wR7zYcKvPjAZvxiDu
 SzNe+LQv0Rd8weBigiZk6zZNakE+L6fXpOnr5TNM0PQ4TM7LaqGYVOHIPDILXuc3xpWNVOE6yYm
 N2AdX4O4JJxS6k9JnQ==
X-Google-Smtp-Source: AGHT+IGEqyms4T0+QP+oLlTpKko3AJZAofeuvgE+M7sIMrTL7r4br1e6xECR9X/F93EiULGYnjARpw==
X-Received: by 2002:a17:906:f6c4:b0:ab7:9285:3442 with SMTP id
 a640c23a62f3a-ab7928534f3mr176977466b.3.1738942283134; 
 Fri, 07 Feb 2025 07:31:23 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab78e82cc0csm105485566b.12.2025.02.07.07.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 665686099F;
 Fri,  7 Feb 2025 15:31:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 11/17] gdbstub: Try unlinking the unix socket before binding
Date: Fri,  7 Feb 2025 15:31:06 +0000
Message-Id: <20250207153112.3939799-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

In case an emulated process execve()s another emulated process, bind()
will fail, because the socket already exists. So try deleting it. Use
the existing unix_listen() function which does this. Link qemu-user
with qemu-sockets.c and add the monitor_get_fd() stub.

Note that it is not possible to handle this in do_execv(): deleting
gdbserver_user_state.socket_path before safe_execve() is not correct,
because the latter may fail, and afterwards we may lose control.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250117001542.8290-3-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/user.c     | 29 +++--------------------------
 stubs/monitor-fd.c |  9 +++++++++
 stubs/meson.build  |  2 ++
 util/meson.build   |  2 ++
 4 files changed, 16 insertions(+), 26 deletions(-)
 create mode 100644 stubs/monitor-fd.c

diff --git a/gdbstub/user.c b/gdbstub/user.c
index fd29d595f4..8225b70280 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -315,12 +315,10 @@ static bool gdb_accept_socket(int gdb_fd)
     return true;
 }
 
-static int gdbserver_open_socket(const char *path)
+static int gdbserver_open_socket(const char *path, Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
-    struct sockaddr_un sockaddr = {};
     char *pid_placeholder;
-    int fd, ret;
 
     pid_placeholder = strstr(path, "%d");
     if (pid_placeholder != NULL) {
@@ -330,28 +328,7 @@ static int gdbserver_open_socket(const char *path)
         path = buf->str;
     }
 
-    fd = socket(AF_UNIX, SOCK_STREAM, 0);
-    if (fd < 0) {
-        perror("create socket");
-        return -1;
-    }
-
-    sockaddr.sun_family = AF_UNIX;
-    pstrcpy(sockaddr.sun_path, sizeof(sockaddr.sun_path) - 1, path);
-    ret = bind(fd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
-    if (ret < 0) {
-        perror("bind socket");
-        close(fd);
-        return -1;
-    }
-    ret = listen(fd, 1);
-    if (ret < 0) {
-        perror("listen socket");
-        close(fd);
-        return -1;
-    }
-
-    return fd;
+    return unix_listen(path, errp);
 }
 
 static bool gdb_accept_tcp(int gdb_fd)
@@ -424,7 +401,7 @@ bool gdbserver_start(const char *port_or_path, Error **errp)
     if (port > 0) {
         gdb_fd = gdbserver_open_port(port, errp);
     } else {
-        gdb_fd = gdbserver_open_socket(port_or_path);
+        gdb_fd = gdbserver_open_socket(port_or_path, errp);
     }
 
     if (gdb_fd < 0) {
diff --git a/stubs/monitor-fd.c b/stubs/monitor-fd.c
new file mode 100644
index 0000000000..9bb6749885
--- /dev/null
+++ b/stubs/monitor-fd.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+
+int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
+{
+    abort();
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index a8b3aeb564..b0fee37e05 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -61,6 +61,8 @@ if have_user
   if not have_system
     stub_ss.add(files('qdev.c'))
   endif
+
+  stub_ss.add(files('monitor-fd.c'))
 endif
 
 if have_system
diff --git a/util/meson.build b/util/meson.build
index 5d8bef9891..780b5977a8 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -84,6 +84,8 @@ if have_block or have_ga
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
   util_ss.add(files(f'coroutine-@coroutine_backend@.c'))
   util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
+endif
+if have_block or have_ga or have_user
   util_ss.add(files('qemu-sockets.c'))
 endif
 if have_block
-- 
2.39.5


