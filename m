Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530C8C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS6-0007Vn-Kj; Wed, 06 Mar 2024 09:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS3-0007PA-Mh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:59 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001Tv-9Y
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:59 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5132010e5d1so2668545e87.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736048; x=1710340848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fFpozrhEXHVv7vPKY8mGoomu2zMrEYM+4yvjvxzqu7c=;
 b=MQnAHmOBvC/w6wjSaqzG/lHDjb/RIrDWWIp5gA5f3DxIs6u/ptz1sveU1bztAiiYXF
 iAJ089A3D417yNQgMLvSxXslWmiAfI3VeuKOAQHIUF23KDLtrg5A5sbExYp33mBe+/xw
 hQ7fcbGS/O0n1f1+Z5tLiR0n4+p4W4a2N501EAkSjAmld708h1xbQH7dSABHXycfdI5U
 2PMKiFpKru48GX3f/NeJoG4sDJBtAP4BMc+1lpcs1KcsTzwHq3ma8NPoYSm3bHMwBoFP
 P89Q8YdUMje9AIGiS9vr+JlCB3s7avrkTvfEcOvyDxn9P6KRxPOzs+LDb5wJliMyKJ2J
 Bp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736048; x=1710340848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFpozrhEXHVv7vPKY8mGoomu2zMrEYM+4yvjvxzqu7c=;
 b=dMVhZqCiXOhhRQrjaotMWbtcd+1zgha+voq8RXW0raaqecwXzIHXWpjrnwZ7dLZgWj
 Bbl2UfhxAJmPwLPR0L/R68M8vLdqR+NQnPu8JI7Rk4DN9mUUND/T3tgagpHsszmvvKIr
 YYuR1DvZ8RnmwYdW3Qtfm+Q5EuvV/w2jjCKq3zqU8NsqzU1ovwkS8LRMelgrc4jUa+V+
 QFA1GS0vTxwV7Jjq9DyP3tpm5ZtLWv+mYvfSc9zc58mdWwr7RfXVCx3F2Fef62jcG44L
 WvHOKYzwi8sWTW6QZz26fgEh8MVM8l96ygQAuqh2YFgT2Us4+9V4XG7RcoYTbz9J+iuu
 haHA==
X-Gm-Message-State: AOJu0YwbcWvX0psukLuVtvdXMwl+1sEHLnW3o0ESJSzkidYBOTPweHkE
 jZBceWN3G+f1BtaflKrRukXb2i3R+0USIm0XfIPBcOh5snvbbTN4nNX8dJyWC+cdKlLxwcpFLoo
 r
X-Google-Smtp-Source: AGHT+IG5hBFOLuGp54pjqONU06LMsC2+6BiSMV91syOAbPaoTGw68yQZG4Cclcb8KpudemkhtvuVag==
X-Received: by 2002:ac2:4c38:0:b0:513:f34:f4c1 with SMTP id
 u24-20020ac24c38000000b005130f34f4c1mr3271210lfq.20.1709736048027; 
 Wed, 06 Mar 2024 06:40:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p26-20020a05600c1d9a00b00412f83e0c11sm1605253wms.22.2024.03.06.06.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B5B715F9D3;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/29] gdbstub: Implement follow-fork-mode child
Date: Wed,  6 Mar 2024 14:40:24 +0000
Message-Id: <20240306144041.3787188-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently it's not possible to use gdbstub for debugging linux-user
code that runs in a forked child, which is normally done using the `set
follow-fork-mode child` GDB command. Purely on the protocol level, the
missing piece is the fork-events feature.

However, a deeper problem is supporting $Hg switching between different
processes - right now it can do only threads. Implementing this for the
general case would be quite complicated, but, fortunately, for the
follow-fork-mode case there are a few factors that greatly simplify
things: fork() happens in the exclusive section, there are only two
processes involved, and before one of them is resumed, the second one
is detached.

This makes it possible to implement a simplified scheme: the parent and
the child share the gdbserver socket, it's used only by one of them at
any given time, which is coordinated through a separate socketpair. The
processes can read from the gdbserver socket only one byte at a time,
which is not great for performance, but, fortunately, the
follow-fork-mode handling involves only a few messages.

Advertise the fork-events support, and remember whether GDB has it
as well. Implement the state machine that is initialized on fork(),
decides the current owner of the gdbserver socket, and is terminated
when one of the two processes is detached. The logic for the parent and
the child is the same, only the initial state is different.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-12-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-13-alex.bennee@linaro.org>

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 1a7b582a40d..7f9f19a1249 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -25,6 +25,61 @@
 #define GDB_NR_SYSCALLS 1024
 typedef unsigned long GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
 
+/*
+ * Forked child talks to its parent in order to let GDB enforce the
+ * follow-fork-mode. This happens inside a start_exclusive() section, so that
+ * the other threads, which may be forking too, do not interfere. The
+ * implementation relies on GDB not sending $vCont until it has detached
+ * either from the parent (follow-fork-mode child) or from the child
+ * (follow-fork-mode parent).
+ *
+ * The parent and the child share the GDB socket; at any given time only one
+ * of them is allowed to use it, as is reflected in the respective fork_state.
+ * This is negotiated via the fork_sockets pair as a reaction to $Hg.
+ *
+ * Below is a short summary of the possible state transitions:
+ *
+ *     ENABLED                     : Terminal state.
+ *     DISABLED                    : Terminal state.
+ *     ACTIVE                      : Parent initial state.
+ *     INACTIVE                    : Child initial state.
+ *     ACTIVE       -> DEACTIVATING: On $Hg.
+ *     ACTIVE       -> ENABLING    : On $D.
+ *     ACTIVE       -> DISABLING   : On $D.
+ *     ACTIVE       -> DISABLED    : On communication error.
+ *     DEACTIVATING -> INACTIVE    : On gdb_read_byte() return.
+ *     DEACTIVATING -> DISABLED    : On communication error.
+ *     INACTIVE     -> ACTIVE      : On $Hg in the peer.
+ *     INACTIVE     -> ENABLE      : On $D in the peer.
+ *     INACTIVE     -> DISABLE     : On $D in the peer.
+ *     INACTIVE     -> DISABLED    : On communication error.
+ *     ENABLING     -> ENABLED     : On gdb_read_byte() return.
+ *     ENABLING     -> DISABLED    : On communication error.
+ *     DISABLING    -> DISABLED    : On gdb_read_byte() return.
+ */
+enum GDBForkState {
+    /* Fully owning the GDB socket. */
+    GDB_FORK_ENABLED,
+    /* Working with the GDB socket; the peer is inactive. */
+    GDB_FORK_ACTIVE,
+    /* Handing off the GDB socket to the peer. */
+    GDB_FORK_DEACTIVATING,
+    /* The peer is working with the GDB socket. */
+    GDB_FORK_INACTIVE,
+    /* Asking the peer to close its GDB socket fd. */
+    GDB_FORK_ENABLING,
+    /* Asking the peer to take over, closing our GDB socket fd. */
+    GDB_FORK_DISABLING,
+    /* The peer has taken over, our GDB socket fd is closed. */
+    GDB_FORK_DISABLED,
+};
+
+enum GDBForkMessage {
+    GDB_FORK_ACTIVATE = 'a',
+    GDB_FORK_ENABLE = 'e',
+    GDB_FORK_DISABLE = 'd',
+};
+
 /* User-mode specific state */
 typedef struct {
     int fd;
@@ -36,6 +91,10 @@ typedef struct {
      */
     bool catch_all_syscalls;
     GDBSyscallsMask catch_syscalls_mask;
+    bool fork_events;
+    enum GDBForkState fork_state;
+    int fork_sockets[2];
+    pid_t fork_peer_pid, fork_peer_tid;
 } GDBUserState;
 
 static GDBUserState gdbserver_user_state;
@@ -358,6 +417,18 @@ int gdbserver_start(const char *port_or_path)
 
 void gdbserver_fork_start(void)
 {
+    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
+        return;
+    }
+    if (!gdbserver_user_state.fork_events ||
+            qemu_socketpair(AF_UNIX, SOCK_STREAM, 0,
+                            gdbserver_user_state.fork_sockets) < 0) {
+        gdbserver_user_state.fork_state = GDB_FORK_DISABLED;
+        return;
+    }
+    gdbserver_user_state.fork_state = GDB_FORK_INACTIVE;
+    gdbserver_user_state.fork_peer_pid = getpid();
+    gdbserver_user_state.fork_peer_tid = qemu_get_thread_id();
 }
 
 static void disable_gdbstub(CPUState *thread_cpu)
@@ -376,23 +447,160 @@ static void disable_gdbstub(CPUState *thread_cpu)
 
 void gdbserver_fork_end(CPUState *cpu, pid_t pid)
 {
-    if (pid != 0 || !gdbserver_state.init || gdbserver_user_state.fd < 0) {
+    char b;
+    int fd;
+
+    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
-    disable_gdbstub(cpu);
+
+    if (pid == -1) {
+        if (gdbserver_user_state.fork_state != GDB_FORK_DISABLED) {
+            g_assert(gdbserver_user_state.fork_state == GDB_FORK_INACTIVE);
+            close(gdbserver_user_state.fork_sockets[0]);
+            close(gdbserver_user_state.fork_sockets[1]);
+        }
+        return;
+    }
+
+    if (gdbserver_user_state.fork_state == GDB_FORK_DISABLED) {
+        if (pid == 0) {
+            disable_gdbstub(cpu);
+        }
+        return;
+    }
+
+    if (pid == 0) {
+        close(gdbserver_user_state.fork_sockets[0]);
+        fd = gdbserver_user_state.fork_sockets[1];
+        g_assert(gdbserver_state.process_num == 1);
+        g_assert(gdbserver_state.processes[0].pid ==
+                     gdbserver_user_state.fork_peer_pid);
+        g_assert(gdbserver_state.processes[0].attached);
+        gdbserver_state.processes[0].pid = getpid();
+    } else {
+        close(gdbserver_user_state.fork_sockets[1]);
+        fd = gdbserver_user_state.fork_sockets[0];
+        gdbserver_user_state.fork_state = GDB_FORK_ACTIVE;
+        gdbserver_user_state.fork_peer_pid = pid;
+        gdbserver_user_state.fork_peer_tid = pid;
+
+        if (!gdbserver_state.allow_stop_reply) {
+            goto fail;
+        }
+        g_string_printf(gdbserver_state.str_buf,
+                        "T%02xfork:p%02x.%02x;thread:p%02x.%02x;",
+                        gdb_target_signal_to_gdb(gdb_target_sigtrap()),
+                        pid, pid, (int)getpid(), qemu_get_thread_id());
+        gdb_put_strbuf();
+    }
+
+    gdbserver_state.state = RS_IDLE;
+    gdbserver_state.allow_stop_reply = false;
+    gdbserver_user_state.running_state = 0;
+    for (;;) {
+        switch (gdbserver_user_state.fork_state) {
+        case GDB_FORK_ENABLED:
+            if (gdbserver_user_state.running_state) {
+                return;
+            }
+            QEMU_FALLTHROUGH;
+        case GDB_FORK_ACTIVE:
+            if (read(gdbserver_user_state.fd, &b, 1) != 1) {
+                goto fail;
+            }
+            gdb_read_byte(b);
+            break;
+        case GDB_FORK_DEACTIVATING:
+            b = GDB_FORK_ACTIVATE;
+            if (write(fd, &b, 1) != 1) {
+                goto fail;
+            }
+            gdbserver_user_state.fork_state = GDB_FORK_INACTIVE;
+            break;
+        case GDB_FORK_INACTIVE:
+            if (read(fd, &b, 1) != 1) {
+                goto fail;
+            }
+            switch (b) {
+            case GDB_FORK_ACTIVATE:
+                gdbserver_user_state.fork_state = GDB_FORK_ACTIVE;
+                break;
+            case GDB_FORK_ENABLE:
+                close(fd);
+                gdbserver_user_state.fork_state = GDB_FORK_ENABLED;
+                break;
+            case GDB_FORK_DISABLE:
+                gdbserver_user_state.fork_state = GDB_FORK_DISABLED;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
+        case GDB_FORK_ENABLING:
+            b = GDB_FORK_DISABLE;
+            if (write(fd, &b, 1) != 1) {
+                goto fail;
+            }
+            close(fd);
+            gdbserver_user_state.fork_state = GDB_FORK_ENABLED;
+            break;
+        case GDB_FORK_DISABLING:
+            b = GDB_FORK_ENABLE;
+            if (write(fd, &b, 1) != 1) {
+                goto fail;
+            }
+            gdbserver_user_state.fork_state = GDB_FORK_DISABLED;
+            break;
+        case GDB_FORK_DISABLED:
+            close(fd);
+            disable_gdbstub(cpu);
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+fail:
+    close(fd);
+    if (pid == 0) {
+        disable_gdbstub(cpu);
+    }
 }
 
 void gdb_handle_query_supported_user(const char *gdb_supported)
 {
+    if (strstr(gdb_supported, "fork-events+")) {
+        gdbserver_user_state.fork_events = true;
+    }
+    g_string_append(gdbserver_state.str_buf, ";fork-events+");
 }
 
 bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
 {
+    if (gdbserver_user_state.fork_state == GDB_FORK_ACTIVE &&
+            pid == gdbserver_user_state.fork_peer_pid &&
+            tid == gdbserver_user_state.fork_peer_tid) {
+        gdbserver_user_state.fork_state = GDB_FORK_DEACTIVATING;
+        gdb_put_packet("OK");
+        return true;
+    }
     return false;
 }
 
 bool gdb_handle_detach_user(uint32_t pid)
 {
+    bool enable;
+
+    if (gdbserver_user_state.fork_state == GDB_FORK_ACTIVE) {
+        enable = pid == gdbserver_user_state.fork_peer_pid;
+        if (enable || pid == getpid()) {
+            gdbserver_user_state.fork_state = enable ? GDB_FORK_ENABLING :
+                                                       GDB_FORK_DISABLING;
+            gdb_put_packet("OK");
+            return true;
+        }
+    }
     return false;
 }
 
-- 
2.39.2


