Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D371BC02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLg-0001dK-5W; Fri, 07 Feb 2025 10:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKT-0008FZ-KZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:51 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKG-00044S-68
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:40 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so1751945a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942286; x=1739547086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNmUeNVqLMWnKw5VpxIg7HB3Zjmh6ElltpcE7zlO/sI=;
 b=MiD6eUT3WnfnkpqKlDG+JXkYJyiDcqOC8tAK8NIbN1apzyqH57+v97qqT92TFHYPMb
 pVPpMU+RA9Ski6WYGhyV0QcIoADiX7UJrUe8QjztM5T/sxtzdShgmmp0p21QZuxsyzUN
 NtVOMDzZ6T8Da7VB5rQtnnYX5qKHSqPPoeLUK+wmR1UAf7q2pNu9qEc2iOZr8Ds0bHeA
 +xw3qX5MTLqIEOtf3HRCO8470VC/OUMYLfypP84Zy7Bni0CjULjPIDveS28HrmLYdQHG
 3C0U+Gn5wMxTtUx+fX2RThid42/Un0Lms5xa337XWgDHxmLC5APexvILjEPmNfUUXisI
 OD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942286; x=1739547086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DNmUeNVqLMWnKw5VpxIg7HB3Zjmh6ElltpcE7zlO/sI=;
 b=gGGcpSlz53pcJ1wjp1uPZwzw4QhTm1rKORwYfcr/FyystsfntPooqZToTh0VNZscED
 0m/oX+Qjl+/yirvmWHeG2LarN3G6RYptaDdTHWffx/Fr/sW6x/Qshdu7kjCGiNKl4+AR
 7eFyP0exxkoKbU6NMuH5J7W+Se6fhAks4Df+ZuWoLtSnrzEhUD/bR1Y9cyWmkq2DMad5
 tekNWZsxb8/OAjg8zcbYbME3Ps9X8faXPqkieLVzT5Njno2vPrjFhlOl6ol2EXG9HpNG
 3Xdfj2QUi7bxccOBjDqn71f/9xmcmFPqGgpeTjneAQyLED+kcMdU0lfm7A0cWIHU+Uf2
 jJ1A==
X-Gm-Message-State: AOJu0YzuznS2nvXFXOII5iXYbOoqHwSKvLPGe817cLFMX6EaV6z3n4ji
 kca7+f02n6+swVVvAsBNqDsokqnhtRiGGe8FG2yEKkTYcj07POdRmCSXJ6ofOUM=
X-Gm-Gg: ASbGncvvqSBeWbsH28fpavAgzRpXAldnEawNzF/wltqVDmRoOLiDVyd9rLDU1o0Hl6x
 H11qvyALRKyTjRQWdlbwoJhGMNSeFmpPeKIkoyWt1R+qEBljP+Kyra7E7cd2ksa0GlZyYlshZgx
 10W618ONnD4oHR3nJmtEJQwQtk4o/A2a4JBp32Erf6545wqErPmCMPYna5w0b4CO33JD6NTX2ZT
 YAh/tmJyks2cF1Ml1gbXWoacrsHHccxONNc09U2NJLBaZpXaDqVskjpDWudndhIpj8d6SXeWV/W
 QHLOvtNfXJTerA0xoA==
X-Google-Smtp-Source: AGHT+IFirjpS0mVz0/6YA1kXSmyvyFpcRXUjfPU9FLurAIGWWuhQj7+PsqxZa9tcLtwCZXGyFQ6igw==
X-Received: by 2002:a50:d6d7:0:b0:5dc:113c:46c3 with SMTP id
 4fb4d7f45d1cf-5de4508dcabmr3021579a12.21.1738942285586; 
 Fri, 07 Feb 2025 07:31:25 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2702253a12.52.2025.02.07.07.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:23 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF95060E67;
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
Subject: [PATCH v2 15/17] gdbstub: Allow late attachment
Date: Fri,  7 Feb 2025 15:31:10 +0000
Message-Id: <20250207153112.3939799-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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
---
 bsd-user/main.c   |   1 -
 gdbstub/user.c    | 115 +++++++++++++++++++++++++++++++++++++++++-----
 linux-user/main.c |   1 -
 3 files changed, 103 insertions(+), 14 deletions(-)

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


