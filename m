Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDB0C02187
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 00:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYa1s-00029I-V8; Thu, 16 Jan 2025 19:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYa1p-00027s-6l
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 19:16:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tYa1m-0008KL-Ua
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 19:16:00 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GNsP2U017931;
 Fri, 17 Jan 2025 00:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=unkRP0OC+XAzxB3p+
 /k73knFxmAaJB81U2h9oSuJOa0=; b=eVU7hRDtVU8g5yR9Qz3ukIgMhBJAp1KRk
 AxIwNjofhTNqf4aytJgwVSdWcBwxIeinLWgdHEPslZkMK15966/LVoYqt9XPgZUR
 RxhslfH7/3gCBKrb91AtstJHD08YlBvjtuwE/sqybsduM4goFWo/i33ffAI9Yz1o
 +VsIGWgs1b3a5wu8S8K2MXr1SUGkzqjQHKqJHyIUM+yFtleLLMwQM7YoOM5w3eFp
 lNH4+eT7nVJCPz03GNss33ukaEv+jkAVIKXER9paAevE/ksjD90ogxm9QXzhpDUI
 mzv4cyhNunS6e8n2H3PtAHqqPGoI8P7Ds/F6oSt7pFt4bnj1Fz1QQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447bxb033b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 00:15:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GK2RDw004576;
 Fri, 17 Jan 2025 00:15:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442yt0jk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Jan 2025 00:15:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50H0Fn6R56361220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 00:15:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEF1E20040;
 Fri, 17 Jan 2025 00:15:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D07720043;
 Fri, 17 Jan 2025 00:15:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.62.46])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2025 00:15:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v6 6/8] gdbstub: Allow late attachment
Date: Fri, 17 Jan 2025 01:11:31 +0100
Message-ID: <20250117001542.8290-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117001542.8290-1-iii@linux.ibm.com>
References: <20250117001542.8290-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4p-oiY5jxs9fPXQ_FYuQlWblNNE73f7n
X-Proofpoint-GUID: 4p-oiY5jxs9fPXQ_FYuQlWblNNE73f7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_10,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=848
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160178
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.797, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 gdbstub/user.c    | 115 +++++++++++++++++++++++++++++++++++++++++-----
 linux-user/main.c |   1 -
 3 files changed, 103 insertions(+), 14 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index b2f6a9be2f2..fdb160bed0f 100644
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
index 8225b702802..3730f32c415 100644
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
index 7198fa0986b..5c74c52cc52 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1024,7 +1024,6 @@ int main(int argc, char **argv, char **envp)
 
     if (gdbstub) {
         gdbserver_start(gdbstub, &error_fatal);
-        gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
 #ifdef CONFIG_SEMIHOSTING
-- 
2.47.1


