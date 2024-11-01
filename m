Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B69CE6B27D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s18-0004jN-8P; Fri, 01 Nov 2024 09:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s15-0004Up-Vk
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s14-0002KI-4B
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dffpl023740;
 Fri, 1 Nov 2024 13:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=IU/Mn09d2+EbLtQ8eeojMxP360v0lOYoa9uwDhEpKzo=; b=
 gxDyccqtlqyxC4PkpRt4Sc7PFTonit3xFpBj7WR2S5pp5DWuUVzaCGzrKgbTsDVu
 p0Ug7PXi5wvFULTr1k6EF4ji+FG46yx7wzJhACohEHVZAublACF3Dn4lbdOmRmbT
 KREPAJ7+MHW2TIaE7Sb9Ri/fcmFWv8ett/EdLkzlAcK2pfbxYQRoyMmCivI4NFo3
 9LGEyhFqTK8tZobjFmD77SHTVJwlSQVGHufGaP048TE7XgKIm/lZIrJ/X+e/Ywy3
 fiJ6fhn3WIT8S7J1jW88/j+YKotNq09pwuBjygIVzKO1IfXXsr9bH0QsH9oyhPYT
 6d6wynIjQOQ3DmD4lFgl+w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc94a3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1CJBnP010117; Fri, 1 Nov 2024 13:48:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91ptmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuOQ006031;
 Fri, 1 Nov 2024 13:48:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-14; Fri, 01 Nov 2024 13:48:35 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 13/16] tests/qtest: defer connection
Date: Fri,  1 Nov 2024 06:47:52 -0700
Message-Id: <1730468875-249970-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010100
X-Proofpoint-GUID: vSx5fPTEJJZgkTCV3NrWmgsFaBO3aNrB
X-Proofpoint-ORIG-GUID: vSx5fPTEJJZgkTCV3NrWmgsFaBO3aNrB
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an option to defer making the connecting to the monitor and qtest
sockets when calling qtest_init_with_env.  The client makes the connection
later by calling qtest_connect_deferred and qtest_qmp_handshake.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.c       | 69 +++++++++++++++++++++++++++++---------------
 tests/qtest/libqtest.h       | 19 +++++++++++-
 tests/qtest/migration-test.c |  4 +--
 3 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9d07de1..95408fb 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -75,6 +75,8 @@ struct QTestState
 {
     int fd;
     int qmp_fd;
+    int sock;
+    int qmpsock;
     pid_t qemu_pid;  /* our child QEMU process */
     int wstatus;
 #ifdef _WIN32
@@ -443,7 +445,8 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
 }
 
 static QTestState *qtest_init_internal(const char *qemu_bin,
-                                       const char *extra_args)
+                                       const char *extra_args,
+                                       bool defer_connect)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -485,22 +488,17 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
 
-    s->fd = socket_accept(sock);
-    if (s->fd >= 0) {
-        s->qmp_fd = socket_accept(qmpsock);
-    }
-    unlink(socket_path);
-    unlink(qmp_socket_path);
-    g_free(socket_path);
-    g_free(qmp_socket_path);
-
-    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
-
     s->rx = g_string_new("");
     for (i = 0; i < MAX_IRQ; i++) {
         s->irq_level[i] = false;
     }
 
+    s->sock = sock;
+    s->qmpsock = qmpsock;
+    if (!defer_connect) {
+        qtest_connect_deferred(s);
+    }
+
     /*
      * Stopping QEMU for debugging is not supported on Windows.
      *
@@ -515,34 +513,57 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     }
 #endif
 
+   return s;
+}
+
+void qtest_connect_deferred(QTestState *s)
+{
+    g_autofree gchar *socket_path = NULL;
+    g_autofree gchar *qmp_socket_path = NULL;
+
+    socket_path = g_strdup_printf("%s/qtest-%d.sock",
+                                  g_get_tmp_dir(), getpid());
+    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
+                                      g_get_tmp_dir(), getpid());
+
+    s->fd = socket_accept(s->sock);
+    if (s->fd >= 0) {
+        s->qmp_fd = socket_accept(s->qmpsock);
+    }
+    unlink(socket_path);
+    unlink(qmp_socket_path);
+    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
     /* ask endianness of the target */
-
     s->big_endian = qtest_query_target_endianness(s);
-
-   return s;
 }
 
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
-    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
+    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, false);
 }
 
-QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+void qtest_qmp_handshake(QTestState *s)
 {
-    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
-    QDict *greeting;
-
     /* Read the QMP greeting and then do the handshake */
-    greeting = qtest_qmp_receive(s);
+    QDict *greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
     qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
+}
 
+QTestState *qtest_init_with_env(const char *var, const char *extra_args,
+                                bool defer_connect)
+{
+    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
+                                        defer_connect);
+    if (!defer_connect) {
+        qtest_qmp_handshake(s);
+    }
     return s;
 }
 
 QTestState *qtest_init(const char *extra_args)
 {
-    return qtest_init_with_env(NULL, extra_args);
+    return qtest_init_with_env(NULL, extra_args, false);
 }
 
 QTestState *qtest_vinitf(const char *fmt, va_list ap)
@@ -1523,7 +1544,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(qemu_var, "-machine none");
+    qts = qtest_init_with_env(qemu_var, "-machine none", false);
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
@@ -1578,7 +1599,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(NULL, "-machine none");
+    qts = qtest_init_with_env(NULL, "-machine none", false);
     response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index beb96b1..db76f2c 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -60,13 +60,15 @@ QTestState *qtest_init(const char *extra_args);
  * @var: Environment variable from where to take the QEMU binary
  * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
+ * @defer_connect: do not connect to qemu monitor and qtest socket.
  *
  * Like qtest_init(), but use a different environment variable for the
  * QEMU binary.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_with_env(const char *var, const char *extra_args);
+QTestState *qtest_init_with_env(const char *var, const char *extra_args,
+                                bool defer_connect);
 
 /**
  * qtest_init_without_qmp_handshake:
@@ -78,6 +80,21 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 
 /**
+ * qtest_connect_deferred:
+ * @s: #QTestState instance to connect
+ * Connect to qemu monitor and qtest socket, after deferring them in
+ * qtest_init_with_env.  Does not handshake with the monitor.
+ */
+void qtest_connect_deferred(QTestState *s);
+
+/**
+ * qtest_qmp_handshake:
+ * @s: #QTestState instance to operate on.
+ * Perform handshake after connecting to qemu monitor.
+ */
+void qtest_qmp_handshake(QTestState *s);
+
+/**
  * qtest_init_with_serial:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a008316..d359b10 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -844,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
+        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source, false);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
@@ -865,7 +865,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
+    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, false);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
-- 
1.8.3.1


