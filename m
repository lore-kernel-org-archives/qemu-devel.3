Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6C5C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSK-0007aL-Jt; Mon, 10 Feb 2025 11:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRB-0004Na-DO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:09 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR8-0001Xi-Eb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:08 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1104726866b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204105; x=1739808905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cv/0HiWib5mVBaxSrAfp5Uz9fY8LMI2bjBnu/BWf/Z8=;
 b=YixDZ3bIvRxfnxLxzhKcXQK6rfbvkF63/ysNvMdc9VK5yvxoY4MT+jVDuSuZOgl+VV
 hvWGnex+SERc8l2Fcf9nQn3GOmLO1DYIWlKmf/nouDix5/yMLDU6/M7T+3mA1HCAS6Q4
 M6zAnAaU5p5fDvBIeOT8ciI57sjva9eyFgKLTTRkYLOEwnbxqtNSu0AXOl7t/OJv1lmc
 XX1NL8u0t7rnIyEpiWL7djiSDR6cc2sQp+SlJTpACgHbBg8jm54rseIjU+RmIVZw0Ns6
 FAvT2V98bmKRiuaAhqG2Bqay4ThXQM7aZFRm4mwIhmPHOsDx+ZWMeefcD/ZtNCJh7CD1
 WzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204105; x=1739808905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cv/0HiWib5mVBaxSrAfp5Uz9fY8LMI2bjBnu/BWf/Z8=;
 b=Bpm5sQblTiYdUUg9mlBBGdFD6JwBYMhIxnnWiBvAmuIHWAF7I7VpLjfXQ3cspX2ejA
 ooFbHZrNhIe1D4u8ieIkF2t6AvIwVe2gM0jtbmeWp3W1fkPqN+JDqElecRZJP+qNT5rk
 RvDlAkVW/3qKtHiCKF8ZsJlKmjyPnfpMRLNie//VDqZI8zO4O5h/P1r/fhGyQEKlcuPK
 5pbp+3Ngg9RE5Q9FcWRmgYcIF7nb0L+DvvomXpCC9X1Ah9A+pzS0M5U+9hMjckRRhDO4
 dZlBLxLN4kSPuzVmsg0EHoe+MWW+8fSYIXSGEhg0Oeybi8LkIrvEiDqU2SHmI4oyB/jl
 Fg1g==
X-Gm-Message-State: AOJu0YzGCu8uXgCmffyxx5eDwSgo7TizbISzmqG9iEQOwSVD7HptqJVH
 4soBN7Dzv1wCB7LjcLIo+z8T3qT+UILXqHi7tHJNf6s+QRgJktUlrIrMwyl7gfM=
X-Gm-Gg: ASbGncs3vfpGQoqxtzp3kIjSwP1mKUFpczokcY8ggN9mTLwS2VwxjmF3T1WF9zB/Gdq
 3E39VmbKcIRy9UHH5Pdt4HZ9HYDar6wQyG/x4ehYAxjBlJdl3JfJhtDGYQFbsmmMzbzfeSCeWUF
 65MFB7Ok/X6zrPPSfuDCO3+8fD/UrNgSe1ImznuWXVmcv9ov/hp4jLiKLpqtWooe5emTPkmNJB0
 G3cvqnvVwoaFTPTCQAhhHkvRVuQpDYEa9A6o2QmAfwVXIeEKxgPHE4BROvKzWtiqRvfIHhJoN8g
 cM+F2ViEVOm3OnQpnA==
X-Google-Smtp-Source: AGHT+IG2heHBIAuPYtOq6oHYP7Gc7zQLEOhC9SQlFm5Sgjs2KpUsmbBmclKn7yuY7kED9tkRfp2fnQ==
X-Received: by 2002:a17:906:ef0b:b0:ab7:6c4b:796a with SMTP id
 a640c23a62f3a-ab789c629f3mr1715751766b.39.1739204104476; 
 Mon, 10 Feb 2025 08:15:04 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d4d291bdsm55689266b.17.2025.02.10.08.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A4466038D;
 Mon, 10 Feb 2025 16:14:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 15/17] gdbstub: Allow late attachment
Date: Mon, 10 Feb 2025 16:14:49 +0000
Message-Id: <20250210161451.3273284-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Allow debugging individual processes in multi-process applications by
starting them with export QEMU_GDB=/tmp/qemu-%d.sock,suspend=n.
Currently one would have to attach to every process to ensure the app
makes progress.

In case suspend=n is not specified, the flow remains unchanged. If it
is specified, then accepting the client connection is delegated to a
thread. In the future this machinery may be reused for handling
reconnections and interruptions.

On accepting a connection, the thread schedules gdb_handlesig() on the
first CPU and wakes it up with host_interrupt_signal. Note that the
result of this gdb_handlesig() invocation is handled, as opposed to
many other existing call sites. These other call sites probably need to
be fixed separately.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-7-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-16-alex.bennee@linaro.org>

diff --git a/bsd-user/main.c b/bsd-user/main.c
index b2f6a9be2f..fdb160bed0 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -629,7 +629,6 @@ int main(int argc, char **argv)
 
     if (gdbstub) {
         gdbserver_start(gdbstub, &error_fatal);
-        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
     cpu_loop(env);
     /* never exits */
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 8225b70280..3730f32c41 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -22,6 +22,7 @@
 #include "gdbstub/user.h"
 #include "gdbstub/enums.h"
 #include "hw/core/cpu.h"
+#include "user/signal.h"
 #include "trace.h"
 #include "internals.h"
 
@@ -393,32 +394,122 @@ static int gdbserver_open_port(int port, Error **errp)
     return fd;
 }
 
-bool gdbserver_start(const char *port_or_path, Error **errp)
+static bool gdbserver_accept(int port, int gdb_fd, const char *path)
 {
-    int port = g_ascii_strtoull(port_or_path, NULL, 10);
+    bool ret;
+
+    if (port > 0) {
+        ret = gdb_accept_tcp(gdb_fd);
+    } else {
+        ret = gdb_accept_socket(gdb_fd);
+        if (ret) {
+            gdbserver_user_state.socket_path = g_strdup(path);
+        }
+    }
+
+    if (!ret) {
+        close(gdb_fd);
+    }
+
+    return ret;
+}
+
+struct {
+    int port;
     int gdb_fd;
+    char *path;
+} gdbserver_args;
+
+static void do_gdb_handlesig(CPUState *cs, run_on_cpu_data arg)
+{
+    int sig;
+
+    sig = target_to_host_signal(gdb_handlesig(cs, 0, NULL, NULL, 0));
+    if (sig >= 1 && sig < NSIG) {
+        qemu_kill_thread(gdb_get_cpu_index(cs), sig);
+    }
+}
+
+static void *gdbserver_accept_thread(void *arg)
+{
+    if (gdbserver_accept(gdbserver_args.port, gdbserver_args.gdb_fd,
+                         gdbserver_args.path)) {
+        CPUState *cs = first_cpu;
+
+        async_safe_run_on_cpu(cs, do_gdb_handlesig, RUN_ON_CPU_NULL);
+        qemu_kill_thread(gdb_get_cpu_index(cs), host_interrupt_signal);
+    }
+
+    g_free(gdbserver_args.path);
+    gdbserver_args.path = NULL;
+
+    return NULL;
+}
 
+#define USAGE "\nUsage: -g {port|path}[,suspend={y|n}]"
+
+bool gdbserver_start(const char *args, Error **errp)
+{
+    g_auto(GStrv) argv = g_strsplit(args, ",", 0);
+    const char *port_or_path = NULL;
+    bool suspend = true;
+    int gdb_fd, port;
+    GStrv arg;
+
+    for (arg = argv; *arg; arg++) {
+        g_auto(GStrv) tokens = g_strsplit(*arg, "=", 2);
+
+        if (g_strcmp0(tokens[0], "suspend") == 0) {
+            if (tokens[1] == NULL) {
+                error_setg(errp,
+                           "gdbstub: missing \"suspend\" option value" USAGE);
+                return false;
+            } else if (!qapi_bool_parse(tokens[0], tokens[1],
+                                        &suspend, errp)) {
+                return false;
+            }
+        } else {
+            if (port_or_path) {
+                error_setg(errp, "gdbstub: unknown option \"%s\"" USAGE, *arg);
+                return false;
+            }
+            port_or_path = *arg;
+        }
+    }
+    if (!port_or_path) {
+        error_setg(errp, "gdbstub: port or path not specified" USAGE);
+        return false;
+    }
+
+    port = g_ascii_strtoull(port_or_path, NULL, 10);
     if (port > 0) {
         gdb_fd = gdbserver_open_port(port, errp);
     } else {
         gdb_fd = gdbserver_open_socket(port_or_path, errp);
     }
-
     if (gdb_fd < 0) {
         return false;
     }
 
-    if (port > 0 && gdb_accept_tcp(gdb_fd)) {
-        return true;
-    } else if (gdb_accept_socket(gdb_fd)) {
-        gdbserver_user_state.socket_path = g_strdup(port_or_path);
+    if (suspend) {
+        if (gdbserver_accept(port, gdb_fd, port_or_path)) {
+            gdb_handlesig(first_cpu, 0, NULL, NULL, 0);
+            return true;
+        } else {
+            error_setg(errp, "gdbstub: failed to accept connection");
+            return false;
+        }
+    } else {
+        QemuThread thread;
+
+        gdbserver_args.port = port;
+        gdbserver_args.gdb_fd = gdb_fd;
+        gdbserver_args.path = g_strdup(port_or_path);
+        qemu_thread_create(&thread, "gdb-accept",
+                           &gdbserver_accept_thread, NULL,
+                           QEMU_THREAD_DETACHED);
         return true;
     }
-
-    /* gone wrong */
-    close(gdb_fd);
-    error_setg(errp, "gdbstub: failed to accept connection");
-    return false;
 }
 
 void gdbserver_fork_start(void)
diff --git a/linux-user/main.c b/linux-user/main.c
index 7198fa0986..5c74c52cc5 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1024,7 +1024,6 @@ int main(int argc, char **argv, char **envp)
 
     if (gdbstub) {
         gdbserver_start(gdbstub, &error_fatal);
-        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
 #ifdef CONFIG_SEMIHOSTING
-- 
2.39.5


