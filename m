Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52FFC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdd-0003sX-9v; Mon, 03 Feb 2025 09:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdY-0003oZ-7t
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:20 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdG-0002Sc-J9
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:19 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so736091066b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593661; x=1739198461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6N9ryvNx2tTT6HdSFLFKVlKftlNVXYRqQdp7SLQm3o=;
 b=m/cZ7HPpkdKAqBdfoXW/kFoIg8MkBsNFYWBlmLbcP8UYigF01sHNbRQTlqunWobX+m
 ztIiPzaJnVr80A/hEYl4fMV/BWMsIZYULbeFy3PhMod+Sh4AOejPYn8ugfrZQWx75vBy
 64sqqMFzPWCJH7ko2sBEAtLnKtL2b2Mhd3X0L8qqK8xdI9c9t112IVFwAl6+wKn2I6bK
 r3bK+F2u/CHopPS9DY26qZYlppRgXQMjjC5qIWWc5ilZAiy3dUMfhzkddKhBYRdToQXo
 i9mBGuZOaQ0/UQR+TxLrj31A1z5+lXRHK3wgqSMQhwnzQ8W8IMMcK7G0vayVdGusNTYk
 q1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593661; x=1739198461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6N9ryvNx2tTT6HdSFLFKVlKftlNVXYRqQdp7SLQm3o=;
 b=hXWIXFruJ0dAC1aA2EQDLLWeEwKBlucWD7aJ+JRhfZncPREkx6vi+fAZqltlL9GXgS
 j+iSbnRHgKB4ykCS4OXrbO7vdLQ/xrXTaGQspEZgA5bdZSAkOhvzr7RCi8fyI7VGval4
 ic5SewpCK/g9KZF/jkvSXVTdqKpAS5qH7nIRwICgDAvCnCIyHwmdqgsv23ajQF0J8vk0
 HfVsUMDrcmsSBetXTq9jz5KZlw7JRF2V3W7HfjoASKEm/30brvfAtYJ7FR2hA4SBH14D
 h9JxrPfc1p4itLlAijz5WqDYS5OeEI1Kt2lPZui0W0dzG1LIl9RXSGrrwkiZArNUwch/
 uQ5A==
X-Gm-Message-State: AOJu0Yzpywaf15SUTL6wjzq9nsPLZuXKAwwe9evZA6ttyuTy/al9X2BG
 ebot1dDJGk6KAu2Lm7Yg80tMNub47VbbOi5Dlucb1mlUED/lZ57bpr02elK/JgU=
X-Gm-Gg: ASbGnctZX50h3HAiZwGZhPwfNXWYFwRofkXxokQqYBOLOlGuoevvW0WIULw0XuM/TA2
 JDoTSzERv3f4zCX2SCZn8lul27jMThJyAV41pFc3raFtSiNCzJuIqICJmZQWq+BsjSw2LmtK3jl
 bOyMlhStv8wfXF6m+7jgv4txbynmWcGPvjpz7Bx8LxD7LC1AKuBM4ABfa68rzIsGLe8cdcdgDVs
 /+ww0uSAksdulpRRDfhb0/jjn7hNgD0N7yD2gFkscrPyG1vSAOGKnDHLxkgBogHFFqJVsqmgKiX
 9/WpHpe4fZbvvwfutA==
X-Google-Smtp-Source: AGHT+IHubMLubx4nwLSVuxzF7Wq0eWGnW/dzSLvKqvDK9sZ9EnBQNN9NebJo2lc6HX9/V41iBsZ7dA==
X-Received: by 2002:a17:906:c146:b0:aa6:1e9a:e45a with SMTP id
 a640c23a62f3a-ab6cfdbc62cmr2220431966b.46.1738593660687; 
 Mon, 03 Feb 2025 06:41:00 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47d0feasm777494766b.52.2025.02.03.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9D4A608B4;
 Mon,  3 Feb 2025 14:40:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 11/18] gdbstub: Try unlinking the unix socket before binding
Date: Mon,  3 Feb 2025 14:40:41 +0000
Message-Id: <20250203144048.2131117-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


