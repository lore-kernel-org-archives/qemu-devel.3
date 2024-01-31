Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D10C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVHXn-0004AX-5G; Wed, 31 Jan 2024 15:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHXl-00049k-9w
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:50:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHXh-0004OU-KJ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:50:49 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VJXwlk024565; Wed, 31 Jan 2024 20:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EzW3N1nVLx+hcp/TFWZzJMuC/ohM21T1XlyI8cY0xsc=;
 b=HzxgUBY2eCOxmOt/Miv8VVkmlyV4e7NeYUox5OyappNAZAlj/6cIP5Sf+atE/SWReBzg
 Wsn3G1XoOdJhhaW/VLxfoEyXSUI03vray/xomTlNLznLyKIxlhqZE4GGmcf3MXsDw7ni
 Deo7N2wx9ZRTF80WOjWuEmc55XBX/pnyT2ByUUykCznnz5lPKb1F+5A9yZSycH+qAFm3
 wCHjgdx7fNL6zZVAhGY2ktXZhchhpnlF61lhG/vq7HN76fzlcD2qRKxvVAnlWDF69xzN
 oWRTWVMNhdPhgtCEGWZb0PEblcllaFmqi7/wFYYnNswxq4sA6JW5TBKjIKjhsXUHU2I1 Qw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyvfej4hc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:50:43 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VJo2GY017712; Wed, 31 Jan 2024 20:50:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchyyxw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:50:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VKofs741156976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 20:50:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A1E720043;
 Wed, 31 Jan 2024 20:50:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE65420040;
 Wed, 31 Jan 2024 20:50:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 20:50:40 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] gdbstub: Implement follow-fork-mode child
Date: Wed, 31 Jan 2024 21:43:40 +0100
Message-ID: <20240131205031.144607-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131205031.144607-1-iii@linux.ibm.com>
References: <20240131205031.144607-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jg2_f2w9_u2eLufKufjyhupoOv5S6OHb
X-Proofpoint-ORIG-GUID: jg2_f2w9_u2eLufKufjyhupoOv5S6OHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310161
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
follow-fork-mode involves only a few messages.

Add the hooks for the user-specific handling of $qSupported, $Hg, and
$D. Advertise the fork-events support, and remember whether GDB has it
as well. Implement the state machine that is initialized on fork(),
decides the current owner of the gdbserver socket, and is terminated
when one of the two processes is detached. The logic for the parent and
the child is the same, only the initial state is different.

Handle the `stepi` of a syscall corner case by disabling the
single-stepping in detached processes.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   |  29 ++++--
 gdbstub/internals.h |   3 +
 gdbstub/user.c      | 210 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 234 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7e73e916bdc..46f5dd47e9e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -991,6 +991,12 @@ static void handle_detach(GArray *params, void *user_ctx)
         pid = get_param(params, 0)->val_ul;
     }
 
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_detach_user(pid)) {
+        return;
+    }
+#endif
+
     process = gdb_get_process(pid);
     gdb_process_breakpoint_remove_all(process);
     process->attached = false;
@@ -1066,6 +1072,7 @@ static void handle_cont_with_sig(GArray *params, void *user_ctx)
 
 static void handle_set_thread(GArray *params, void *user_ctx)
 {
+    uint32_t pid, tid;
     CPUState *cpu;
 
     if (params->len != 2) {
@@ -1083,8 +1090,14 @@ static void handle_set_thread(GArray *params, void *user_ctx)
         return;
     }
 
-    cpu = gdb_get_cpu(get_param(params, 1)->thread_id.pid,
-                      get_param(params, 1)->thread_id.tid);
+    pid = get_param(params, 1)->thread_id.pid;
+    tid = get_param(params, 1)->thread_id.tid;
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_set_thread_user(pid, tid)) {
+        return;
+    }
+#endif
+    cpu = gdb_get_cpu(pid, tid);
     if (!cpu) {
         gdb_put_packet("E22");
         return;
@@ -1599,6 +1612,7 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
 
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
+    const char *gdb_supported;
     CPUClass *cc;
 
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
@@ -1622,9 +1636,14 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
 
-    if (params->len &&
-        strstr(get_param(params, 0)->data, "multiprocess+")) {
-        gdbserver_state.multiprocess = true;
+    if (params->len) {
+        gdb_supported = get_param(params, 0)->data;
+        if (strstr(gdb_supported, "multiprocess+")) {
+            gdbserver_state.multiprocess = true;
+        }
+#if defined(CONFIG_USER_ONLY)
+        gdb_handle_query_supported_user(gdb_supported);
+#endif
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 56b7c13b750..b4724598384 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -196,6 +196,9 @@ void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
+void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
+bool gdb_handle_detach_user(uint32_t pid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 120eb7fc117..962f4cb74e7 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/syscall.h>
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
@@ -25,6 +26,41 @@
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
@@ -36,6 +72,10 @@ typedef struct {
      */
     bool catch_all_syscalls;
     GDBSyscallsMask catch_syscalls_mask;
+    bool fork_events;
+    enum GDBForkState fork_state;
+    int fork_sockets[2];
+    pid_t fork_peer_pid, fork_peer_tid;
 } GDBUserState;
 
 static GDBUserState gdbserver_user_state;
@@ -358,6 +398,18 @@ int gdbserver_start(const char *port_or_path)
 
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
@@ -369,16 +421,168 @@ static void disable_gdbstub(void)
     CPU_FOREACH(cpu) {
         cpu_breakpoint_remove_all(cpu, BP_GDB);
         /* no cpu_watchpoint_remove_all for user-mode */
+        cpu_single_step(cpu, 0);
+        tb_flush(cpu);
     }
 }
 
-/* Disable gdb stub for child processes.  */
 void gdbserver_fork_end(pid_t pid)
 {
-    if (pid != 0 || !gdbserver_state.init || gdbserver_user_state.fd < 0) {
+    char b;
+    int fd;
+
+    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
+        return;
+    }
+
+    if (pid == -1) {
+        if (gdbserver_user_state.fork_state != GDB_FORK_DISABLED) {
+            g_assert(gdbserver_user_state.fork_state == GDB_FORK_INACTIVE);
+            close(gdbserver_user_state.fork_sockets[0]);
+            close(gdbserver_user_state.fork_sockets[1]);
+        }
         return;
     }
-    disable_gdbstub();
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
+}
+
+void gdb_handle_query_supported_user(const char *gdb_supported)
+{
+    if (strstr(gdb_supported, "fork-events+")) {
+        gdbserver_user_state.fork_events = true;
+    }
+    g_string_append(gdbserver_state.str_buf, ";fork-events+");
+}
+
+bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
+{
+    if (gdbserver_user_state.fork_state == GDB_FORK_ACTIVE &&
+            pid == gdbserver_user_state.fork_peer_pid &&
+            tid == gdbserver_user_state.fork_peer_tid) {
+        gdbserver_user_state.fork_state = GDB_FORK_DEACTIVATING;
+        gdb_put_packet("OK");
+        return true;
+    }
+    return false;
+}
+
+bool gdb_handle_detach_user(uint32_t pid)
+{
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
+    return false;
 }
 
 /*
-- 
2.43.0


