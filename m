Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC175D0E3F3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 20:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4412-0003Od-WC; Thu, 24 Oct 2024 16:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t440r-0003Je-Df
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:00:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t440o-0002Dx-UR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 16:00:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OGuTVM004817;
 Thu, 24 Oct 2024 20:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jIgHKXFAcn5x3/TcS
 OwNybUdYxtB3I3Rg2nKNc6YdSM=; b=nGaRFJizBZige+9cT18/23YwVJypA0lVt
 cStQamS/lzcsdgAyvrEC3gUi304sHxK6e5+HksluIX+oMW0MFbMGcFEm7OlCmwix
 iAATO5AWoYYlAyqNthiPWE8pXNYswZ5lxbODA9xWGASPD0FqWFKLdibKxzSe30Vt
 3XtpSw0ZMWPo8Rix9oncqSxhl3SZLJfA2kn7S3sV04nRdarRPqeKqCkouXlNhnJW
 Rcx9+aLjOKDv8wx/jvm1K4WStKz/Xax7RZTJwv0sZeykp48dj6xvUT5tvlblaB1j
 9dOx4wuu9YHo8RAdBqkB/XVKyV9UMB9h3XUyBmsOHUoBR8G80t4RA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fgyuux6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 20:00:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHubgk008796;
 Thu, 24 Oct 2024 20:00:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkat879-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Oct 2024 20:00:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49OK0bv636372958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2024 20:00:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED5DC20040;
 Thu, 24 Oct 2024 20:00:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B2AC20043;
 Thu, 24 Oct 2024 20:00:36 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.25.135])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2024 20:00:36 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 6/8] gdbstub: Allow late attachment
Date: Thu, 24 Oct 2024 21:59:13 +0200
Message-ID: <20241024200031.80327-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024200031.80327-1-iii@linux.ibm.com>
References: <20241024200031.80327-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wcx3YXcHizn-R8c8cfACB8Ba3G1cNo4-
X-Proofpoint-GUID: wcx3YXcHizn-R8c8cfACB8Ba3G1cNo4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxlogscore=798 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 bsd-user/main.c   |   1 -
 gdbstub/user.c    | 120 ++++++++++++++++++++++++++++++++++++++++++----
 linux-user/main.c |   1 -
 3 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index cc980e6f401..7c2f8e4e96e 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -618,7 +618,6 @@ int main(int argc, char **argv)
 
     if (gdbstub) {
         gdbserver_start(gdbstub);
-        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
     cpu_loop(env);
     /* never exits */
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 26b25b1b7e9..455ecd6f831 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/syscall.h>
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
@@ -21,6 +22,7 @@
 #include "gdbstub/user.h"
 #include "gdbstub/enums.h"
 #include "hw/core/cpu.h"
+#include "user/signal.h"
 #include "trace.h"
 #include "internals.h"
 
@@ -416,11 +418,101 @@ static int gdbserver_open_port(int port)
     return fd;
 }
 
-int gdbserver_start(const char *port_or_path)
+static bool gdbserver_accept(int port, int gdb_fd, const char *port_or_path)
 {
-    int port = g_ascii_strtoull(port_or_path, NULL, 10);
+    bool ret;
+
+    if (port > 0) {
+        ret = gdb_accept_tcp(gdb_fd);
+    } else {
+        ret = gdb_accept_socket(gdb_fd);
+        if (ret) {
+            gdbserver_user_state.socket_path = g_strdup(port_or_path);
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
+    char *port_or_path;
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
+                         gdbserver_args.port_or_path)) {
+        CPUState *cs = first_cpu;
+
+        async_safe_run_on_cpu(cs, do_gdb_handlesig, RUN_ON_CPU_NULL);
+        qemu_kill_thread(gdb_get_cpu_index(cs), host_interrupt_signal);
+    }
+
+    g_free(gdbserver_args.port_or_path);
+
+    return NULL;
+}
+
+__attribute__((__format__(__printf__, 1, 2)))
+static void print_usage(const char *format, ...)
+{
+    va_list ap;
+
+    va_start(ap, format);
+    vfprintf(stderr, format, ap);
+    va_end(ap);
+    fprintf(stderr, "Usage: -g {port|path}[,suspend={y|n}]\n");
+}
+
+#define SUSPEND "suspend="
+
+int gdbserver_start(const char *args)
+{
+    g_auto(GStrv) argv = g_strsplit(args, ",", 0);
+    const char *port_or_path = NULL;
+    bool suspend = true;
+    int gdb_fd, port;
+    GStrv arg;
 
+    for (arg = argv; *arg; arg++) {
+        if (g_str_has_prefix(*arg, SUSPEND)) {
+            const char *val = *arg + strlen(SUSPEND);
+
+            suspend = (strcmp(val, "y") == 0);
+            if (!suspend && (strcmp(val, "n") != 0)) {
+                print_usage("Bad option value: %s", *arg);
+                return -1;
+            }
+        } else {
+            if (port_or_path) {
+                print_usage("Unknown option: %s", *arg);
+                return -1;
+            }
+            port_or_path = *arg;
+        }
+    }
+    if (!port_or_path) {
+        print_usage("Port or path not specified");
+        return -1;
+    }
+
+    port = g_ascii_strtoull(port_or_path, NULL, 10);
     if (port > 0) {
         gdb_fd = gdbserver_open_port(port);
     } else {
@@ -431,16 +523,24 @@ int gdbserver_start(const char *port_or_path)
         return -1;
     }
 
-    if (port > 0 && gdb_accept_tcp(gdb_fd)) {
-        return 0;
-    } else if (gdb_accept_socket(gdb_fd)) {
-        gdbserver_user_state.socket_path = g_strdup(port_or_path);
+    if (suspend) {
+        if (gdbserver_accept(port, gdb_fd, port_or_path)) {
+            gdb_handlesig(first_cpu, 0, NULL, NULL, 0);
+            return 0;
+        } else {
+            return -1;
+        }
+    } else {
+        QemuThread thread;
+
+        gdbserver_args.port = port;
+        gdbserver_args.gdb_fd = gdb_fd;
+        gdbserver_args.port_or_path = g_strdup(port_or_path);
+        qemu_thread_create(&thread, "gdb-accept",
+                           &gdbserver_accept_thread, NULL,
+                           QEMU_THREAD_DETACHED);
         return 0;
     }
-
-    /* gone wrong */
-    close(gdb_fd);
-    return -1;
 }
 
 void gdbserver_fork_start(void)
diff --git a/linux-user/main.c b/linux-user/main.c
index 8143a0d4b02..db54925a6c9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1017,7 +1017,6 @@ int main(int argc, char **argv, char **envp)
                     gdbstub);
             exit(EXIT_FAILURE);
         }
-        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
 #ifdef CONFIG_SEMIHOSTING
-- 
2.47.0


