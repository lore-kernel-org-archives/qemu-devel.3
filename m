Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13393C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8do-0007Pe-GK; Wed, 15 Jan 2025 14:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dm-0007P3-6S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dk-0005eh-89
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:21 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHuMgb010293;
 Wed, 15 Jan 2025 19:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=37FN6yXLFNsYDNKXbuuqpP3zFjr2TgW8/Vi3g0xJrJQ=; b=
 T2BtuxmoAyzL7JYe69q4WyfWbKEkNm699TXcEYTp7YoHcVa54SABQCUgJQn+0Ljo
 4xfFr9FL+jZN0yw+jHnKuIoLZLgB49Z/EjIPuUYgS1xF1p8/E4I9mc5rveCq9DlF
 SHIh9tomcjNXDnVQTFYKA/lIrLjj9bfYgSBil6T6bjeKwJRZpMt3rQcsWT57CHuo
 psZgCdGx6rhw1b22vBsDlKbXBiH7sGUsMtk1i0PD1e2xEMfVyKdHuSPvFvl9TVef
 DkRqaOLwALvITsggSvDI5wJWkMdNJzfz4bU2Dr7BAer9XOV67yWAChkUepVldIHS
 wmnhPcsTC0+hmSQ+PAGMBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjarpt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FHKrHQ034834; Wed, 15 Jan 2025 19:01:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39ur9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:05 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0peV016497;
 Wed, 15 Jan 2025 19:01:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-20; Wed, 15 Jan 2025 19:01:05 +0000
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
Subject: [PATCH V7 19/24] tests/qtest: defer connection
Date: Wed, 15 Jan 2025 11:00:45 -0800
Message-Id: <1736967650-129648-20-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-GUID: 7wEP9d8q9ZvrQxJkoI3oC3hCHJYw10g6
X-Proofpoint-ORIG-GUID: 7wEP9d8q9ZvrQxJkoI3oC3hCHJYw10g6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
later by calling qtest_connect and qtest_qmp_handshake.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/libqtest.c            | 82 ++++++++++++++++++++++++---------------
 tests/qtest/libqtest.h            | 19 ++++++++-
 tests/qtest/migration/framework.c |  4 +-
 3 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 8de5f1f..b1e0df9 100644
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
@@ -458,18 +460,19 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
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
+                                       bool do_connect)
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
@@ -501,22 +504,19 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
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
 
+    s->fd = -1;
+    s->qmp_fd = -1;
+    s->sock = sock;
+    s->qmpsock = qmpsock;
+    if (do_connect) {
+        qtest_connect(s);
+    }
+
     /*
      * Stopping QEMU for debugging is not supported on Windows.
      *
@@ -531,34 +531,54 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     }
 #endif
 
+   return s;
+}
+
+void qtest_connect(QTestState *s)
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
+    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true);
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
+                                bool do_connect)
+{
+    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args,
+                                        do_connect);
+    if (do_connect) {
+        qtest_qmp_handshake(s);
+    }
     return s;
 }
 
 QTestState *qtest_init(const char *extra_args)
 {
-    return qtest_init_with_env(NULL, extra_args);
+    return qtest_init_with_env(NULL, extra_args, true);
 }
 
 QTestState *qtest_vinitf(const char *fmt, va_list ap)
@@ -1539,7 +1559,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(qemu_var, "-machine none");
+    qts = qtest_init_with_env(qemu_var, "-machine none", true);
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
@@ -1594,7 +1614,7 @@ static struct CpuModel *qtest_get_cpu_models(void)
 
     silence_spawn_log = !g_test_verbose();
 
-    qts = qtest_init_with_env(NULL, "-machine none");
+    qts = qtest_init_with_env(NULL, "-machine none", true);
     response = qtest_qmp(qts, "{ 'execute': 'query-cpu-definitions' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f23d80e..71c94b3 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -60,13 +60,15 @@ QTestState *qtest_init(const char *extra_args);
  * @var: Environment variable from where to take the QEMU binary
  * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
+ * @do_connect: connect to qemu monitor and qtest socket.
  *
  * Like qtest_init(), but use a different environment variable for the
  * QEMU binary.
  *
  * Returns: #QTestState instance.
  */
-QTestState *qtest_init_with_env(const char *var, const char *extra_args);
+QTestState *qtest_init_with_env(const char *var, const char *extra_args,
+                                bool do_connect);
 
 /**
  * qtest_init_without_qmp_handshake:
@@ -78,6 +80,21 @@ QTestState *qtest_init_with_env(const char *var, const char *extra_args);
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 
 /**
+ * qtest_connect
+ * @s: #QTestState instance to connect
+ * Connect to qemu monitor and qtest socket, after skipping them in
+ * qtest_init_with_env.  Does not handshake with the monitor.
+ */
+void qtest_connect(QTestState *s);
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
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 81a0e49..44ff901 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -321,7 +321,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
+        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source, true);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
@@ -341,7 +341,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
+    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, true);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
-- 
1.8.3.1


