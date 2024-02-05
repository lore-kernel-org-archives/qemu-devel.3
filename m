Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA5C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWx4D-0001nu-IO; Mon, 05 Feb 2024 06:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx4B-0001nM-Fq
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx49-0006lx-Hb
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:11 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415AllO7030704; Mon, 5 Feb 2024 11:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ORDQFh0ZbmXoNZXex+KfWOpErb5yHnwgB1CbNfCg3wE=;
 b=rR2L3kVGWBFheFSsz4aMcfSsHWdmFbqlfXjnBMKdebP6Weiy0q7ynrAWMfAMwBris5T1
 1IBW+iAQsqA61E0TlbpetR86uCdvuuVywxX/Xuh0h+WySR2FgFcVTImwX9FJG7IG1/BX
 ygrS2l3a/+Tk01K1ma2IywOINH2BrWGr6aXFn3X/Iriwh39jThNZgvm6Frx7ii5Sq5Ra
 cfH9L1ioAB5cJj1ECBdlJdJFuDgZnCPn8H3UIfA8iIk/rPU6G9wd3Ll8DSjuVAqhiVE3
 Wwo6y1T7aWlnNvsPz3U9x9jSLn1hb+/UhFLqehb77Us6YxrR/O7wFCCV7Y2vrPNpHC+Z WA== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2x82gsfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:06 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4158HIle005430; Mon, 5 Feb 2024 11:23:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21ak7xtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415BN42H41222730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 11:23:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECA1120049;
 Mon,  5 Feb 2024 11:23:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 819C920040;
 Mon,  5 Feb 2024 11:23:03 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.32.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 11:23:03 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 10/11] gdbstub: Implement follow-fork-mode child
Date: Mon,  5 Feb 2024 12:22:24 +0100
Message-ID: <20240205112251.121569-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205112251.121569-1-iii@linux.ibm.com>
References: <20240205112251.121569-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eObWEMDbjQ8WQzR0xuzRaur_205OcexP
X-Proofpoint-ORIG-GUID: eObWEMDbjQ8WQzR0xuzRaur_205OcexP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 gdbstub/user.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 210 insertions(+), 2 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 6f108e60839..bb1e384ddb1 100644
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
 
 static void disable_gdbstub(void)
@@ -376,23 +447,160 @@ static void disable_gdbstub(void)
 
 void gdbserver_fork_end(pid_t pid)
 {
-    if (pid != 0 || !gdbserver_state.init || gdbserver_user_state.fd < 0) {
+    char b;
+    int fd;
+
+    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
-    disable_gdbstub();
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
+            disable_gdbstub();
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
+            disable_gdbstub();
+            return;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+fail:
+    close(fd);
+    if (pid == 0) {
+        disable_gdbstub();
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
2.43.0


