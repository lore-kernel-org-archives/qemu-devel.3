Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56191D78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6a3-0005o3-FD; Mon, 02 Dec 2024 08:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6M4-00086G-FD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lw-0005qA-MQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26XFUj013671;
 Mon, 2 Dec 2024 13:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=dZPhlS1YCwPtdJZdfwGT937kznXrOYhmpvBlJatq8KE=; b=
 Y21MOLlapQfGTqYB8Ua5K3l25FJN5c9vgAFwwU9OKliSX86xfsH3EqdV44k/ju/9
 IsI3T5gvYR5H+/oi9rzHITD24ke7zgXpY1ItEkQ6/FWt9Y4anh61JGfNz9zth2kS
 s5aW4uZrxTYPQ/xhc8SPaK63SNxQMgc8tmvc9ugyVv9xFGlrA0O4AWFMOfVDsMvU
 Xl8HnxZ06NNsdtnkQjgqAdVgWg3Z92M8fxZd/WDUIOzu9k1QxRv7JIzvdEjI9fZt
 fGZVrtqo/4GgXw67PYeGG7aZdFsLuFX62zuKM3SRKe+saoi9t96OWpJlyDJWAlub
 P/r4lTJxujmMLix7ha5zJQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c334h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2CLJX9032060; Mon, 2 Dec 2024 13:20:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:25 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCF5032806;
 Mon, 2 Dec 2024 13:20:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-17; Mon, 02 Dec 2024 13:20:24 +0000
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
Subject: [PATCH V4 16/19] tests/qtest: defer connection
Date: Mon,  2 Dec 2024 05:20:08 -0800
Message-Id: <1733145611-62315-17-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-ORIG-GUID: -19NQH7eSHqUd1Rz7qJ7uX4l6-6qlLk1
X-Proofpoint-GUID: -19NQH7eSHqUd1Rz7qJ7uX4l6-6qlLk1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
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

A test cannot specify port=0 for a deferred connection, because qmp_migrate
cannot query for the assigned port, because the monitor is not connected
yet.  However, even if the test does not specify port=0, qmp_migrate ->
migrate_set_ports unconditionally queries connection parameters.
Modify migrate_set_ports to only query when port=0.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.c          | 80 +++++++++++++++++++++++++----------------
 tests/qtest/libqtest.h          | 19 +++++++++-
 tests/qtest/migration-helpers.c | 19 +++++-----
 tests/qtest/migration-test.c    |  4 +--
 4 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 817fd7a..31c4032 100644
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
@@ -442,18 +444,19 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
     return s;
 }
 
+static char *qtest_socket_path(const char *suffix)
+{
+    return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix);
+}
+
 static QTestState *qtest_init_internal(const char *qemu_bin,
-                                       const char *extra_args)
+                                       const char *extra_args,
+                                       bool defer_connect)
 {
     QTestState *s;
     int sock, qmpsock, i;
-    gchar *socket_path;
-    gchar *qmp_socket_path;
-
-    socket_path = g_strdup_printf("%s/qtest-%d.sock",
-                                  g_get_tmp_dir(), getpid());
-    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
-                                      g_get_tmp_dir(), getpid());
+    g_autofree gchar *socket_path = qtest_socket_path("sock");
+    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
 
     /*
      * It's possible that if an earlier test run crashed it might
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
@@ -515,34 +513,54 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     }
 #endif
 
+   return s;
+}
+
+void qtest_connect_deferred(QTestState *s)
+{
+    g_autofree gchar *socket_path = qtest_socket_path("sock");
+    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
+
+    g_assert(s->sock >= 0 && s->qmpsock >= 0);
+    s->fd = socket_accept(s->sock);
+    if (s->fd >= 0) {
+        s->qmp_fd = socket_accept(s->qmpsock);
+    }
+    unlink(socket_path);
+    unlink(qmp_socket_path);
+    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
+    s->sock = s->qmpsock = -1;
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
@@ -1523,7 +1541,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(qemu_var, "-machine none");
+    qts = qtest_init_with_env(qemu_var, "-machine none", false);
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
@@ -1578,7 +1596,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
 
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
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3f8ba7f..9f39401 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -127,25 +127,28 @@ migrate_get_connect_qdict(QTestState *who)
 
 static void migrate_set_ports(QTestState *to, QList *channel_list)
 {
-    QDict *addr;
+    g_autoptr(QDict) addr = NULL;
     QListEntry *entry;
     const char *addr_port = NULL;
 
-    addr = migrate_get_connect_qdict(to);
-
     QLIST_FOREACH_ENTRY(channel_list, entry) {
         QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
         QDict *addrdict = qdict_get_qdict(channel, "addr");
 
-        if (qdict_haskey(addrdict, "port") &&
-            qdict_haskey(addr, "port") &&
-            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
+        if (!qdict_haskey(addrdict, "port") ||
+            strcmp(qdict_get_str(addrdict, "port"), "0")) {
+            continue;
+        }
+
+        if (!addr) {
+            addr = migrate_get_connect_qdict(to);
+        }
+
+        if (qdict_haskey(addr, "port")) {
             addr_port = qdict_get_str(addr, "port");
             qdict_put_str(addrdict, "port", addr_port);
         }
     }
-
-    qobject_unref(addr);
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 64e1c50..b7001b0 100644
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


