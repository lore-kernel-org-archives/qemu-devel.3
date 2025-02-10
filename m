Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65B1C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSD-0006wV-EL; Mon, 10 Feb 2025 11:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRB-0004NX-Cy
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:09 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR6-0001XJ-PJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:08 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab7b80326cdso238870466b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204103; x=1739808903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YT3MtmnSLkBKcOVyMB0JztX76L81nkooZxZXsqcklIs=;
 b=Ct6YfJaKa2Ka+A34mWwgmMA+wEpIwQ4BUKa6BNZFJeUrC6J1TX9AwuFAgCbs3ZlPzj
 LlTtmRZguks4MXGkHuIWsDX7czsGfjZjEDp6qewwqW0RKLjZ92/iRuMz2ppu30pyW++P
 pMqrdE9cFuQKgxVEnWWKekRBQhL7DReHuvIGv6j92gksid+gW53LYPn6eKnYorXjc39I
 DLqMY4ELq+uaYm+TKdGH+v8puMYrZhUVeNF2RZTgBKMQ1q97lqQ8tA4hpV+PfaunLtHQ
 x8TMbr4pjJGlGPmX1krY8kWJsySiVQmpyzuoxsOqoMZ4uIiKqfv/OsdivE29TPi97G29
 VExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204103; x=1739808903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YT3MtmnSLkBKcOVyMB0JztX76L81nkooZxZXsqcklIs=;
 b=VVSlTx5IHT0S3q8byaxdJw+KSFqOIpMTSpm26RL7QsgAhRSeBJ2yDvW8hxXjF3tmF2
 X3hhqLeNIS2+/apWZOs0Gte2ohP+PB/6h/KaqIP8VlzzUkhtiPNw7tXCy/94cdpB+D5B
 XZPdH39ubT2gfZS0Y+0+BSVUKQgZGj6Hp5F5IXmvAPBDQTCM2ZNj5ZNYkdhLZcM5Jipj
 lHxCWA2C5/1dvlDLDJ6DedHek+qG9CKATu9xbAfjw/RzZ2Cv+kB+a/DwMARELVNDJcZn
 5goazC5/JgfxuKkKVmBqS3G11rn25skdL9+ZUm/L5d7hMCJIf3FS6ubs2ScvktrrBQgN
 /dGQ==
X-Gm-Message-State: AOJu0YwzHQdZzwFmA7zo44znOW/ZLvTaXKiRCV7qOsd/bT2xgTglWS2c
 lB4/4pCKerxch4g5TwAtQfCmdewJB8wpfuews4hcJy4ZsLuGQat5ka47bPCUHr8=
X-Gm-Gg: ASbGncso+SUnY8t0oTxhCeymgXtU238aWMEc/oUwQLZgtIJHDc05k2+l31PZYNyLrd4
 J3k+PYYN5fnDr1erSqXokiIU9wfgqHFI9Wau4bsSKtTPYolbNh8yGiZTUmVFliX5oZF06AX9Z8f
 63obx0pewKFBvNptqCx6aQgyqe6FteDCP4A/DOVLmJ+k+fXsGMOnEqePFB9phHpFEQmpOKqoMM9
 Or4IX6uZQnD/0vw5f2498R4920VULzwy4811SQKaZNw/Zr/TaCTworfPcNDx4rL9591G0zPx501
 sVpD4d1vix3H1DZZyw==
X-Google-Smtp-Source: AGHT+IG7BXxMQc+AY0CbJDer036tQ93MEsDG2oNxFJ6I5mNOrN8SCnNKi9SGXVyjFfhevbbjqNB7Bg==
X-Received: by 2002:a17:907:d92:b0:ab7:b068:c7b9 with SMTP id
 a640c23a62f3a-ab7b068c7d9mr696240266b.13.1739204103126; 
 Mon, 10 Feb 2025 08:15:03 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7bbf40b2bsm291680466b.23.2025.02.10.08.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C773960354;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/17] gdbstub: Try unlinking the unix socket before binding
Date: Mon, 10 Feb 2025 16:14:45 +0000
Message-Id: <20250210161451.3273284-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-Id: <20250207153112.3939799-12-alex.bennee@linaro.org>

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


