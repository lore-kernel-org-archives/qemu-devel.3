Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1BCCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrf-0001Ap-C7; Fri, 19 Sep 2025 10:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqy-0000RA-Lu
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqs-0007Si-9U
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpdt008956;
 Fri, 19 Sep 2025 14:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=GL/Biwmikn91u/cWgQBHpPF2r4hLVJPqA2yPO9IpWZI=; b=
 YM5puSwVQOPtUXXD73Uoitock+INtN+NeXFMdNiI/9HJ4Glu6KXjwk2xh623oui0
 Fk0yrpqI9eRJ7iylwwd5iVichSEv1aDN+uueirQObL7kiED+bc6GodMsz/KzCTr/
 IhWMssXQ/MeoBJFyu08LKkl1VwcalUxvTrU54CxZ0YBiRkl2hZoGqh6dcTvZyLZw
 3HicqMcP1lZXk0Lylli6749J+P1dgednAZyxq2s+xivU7CWcw67cJGTx/Dr8VVUe
 MRM7iBCwR/6q1jUHpkEakHn3ozJmi3T5hiTOWDiOnYEpTC2LVkrT+eYeT4MYR1e9
 MLAY3+6qadK3frTV8hvCEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb5mm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JCP30p035162; Fri, 19 Sep 2025 14:12:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu944-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:37 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYX5003357;
 Fri, 19 Sep 2025 14:12:37 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-3; Fri, 19 Sep 2025 14:12:36 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 02/11] tests/qtest: qtest_qemu_args
Date: Fri, 19 Sep 2025 07:12:24 -0700
Message-Id: <1758291153-349744-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3lbi6cPUaZNm
 iVL9o2TKVCtr4MvF5nJ4IOoctHDCUiyxRF5EEzPZtA96bvnNjBiHM4IE9MWxtDs6+2/c0zC2Ea3
 WFH7t8J+IsjnXiu92EpW32CXVDvcWe9DIt8oauz2sMM9Y3w2qvBUtlNSwpvwHeSvvArt63ynFA4
 /Lkkfgkb8sDHntZaknGQEBUj+GGNdArQqHx0Zv/xVSYbE9YMd4GhPiLvRX3DnIewB6yZRUKs82C
 l0FwMi7eVCJ1UezBcNIn7LmytQgcaw9LihDfI/MuwRWWA/WG67+FIJWEj7130bd+4QTlE3Ka4Dn
 RD0hLKDnyRpq2m/+aeH+4MjETvNe3j6OjhE2yx8WHCOo6+Mrtpo9paac2nQ2wEQIhoWyu5oCN6d
 vEe1xw+bxWk/+ptNU1KTeHXpSImhUg==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cd64d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=8wfYa_FxhlLIVDfICZMA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: GllWtyyXu0yGDsdAjFXoPwv-vH2qgCAv
X-Proofpoint-ORIG-GUID: GllWtyyXu0yGDsdAjFXoPwv-vH2qgCAv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define an accessor that returns all the arguments used to exec QEMU.
Collect the arguments that were passed to qtest_spawn_qemu, plus the trace
arguments that were composed inside qtest_spawn_qemu, and move them to a
new function qtest_qemu_args.

This will be needed to test the cpr-exec migration mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/libqtest.h |  8 ++++++++
 tests/qtest/libqtest.c | 54 +++++++++++++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 6d3199f..a164f58 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -57,6 +57,14 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
 const char *qtest_qemu_binary(const char *var);
 
 /**
+ * qtest_qemu_args:
+ * @extra_args: Other arguments to pass to QEMU.
+ *
+ * Return the command line used to start QEMU, sans binary.
+ */
+gchar *qtest_qemu_args(const char *extra_args);
+
+/**
  * qtest_init:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
  * arguments are subject to word splitting and shell evaluation.
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 6f76be1..551bc8c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -409,20 +409,12 @@ static pid_t qtest_create_process(char *cmd)
 }
 #endif /* _WIN32 */
 
-static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
-                                                        const char *fmt, ...)
+static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args)
 {
-    va_list ap;
     QTestState *s = g_new0(QTestState, 1);
-    const char *trace = g_getenv("QTEST_TRACE");
-    g_autofree char *tracearg = trace ?
-        g_strdup_printf("-trace %s ", trace) : g_strdup("");
     g_autoptr(GString) command = g_string_new("");
 
-    va_start(ap, fmt);
-    g_string_append_printf(command, CMD_EXEC "%s %s", qemu_bin, tracearg);
-    g_string_append_vprintf(command, fmt, ap);
-    va_end(ap);
+    g_string_printf(command, CMD_EXEC "%s %s", qemu_bin, args);
 
     qtest_add_abrt_handler(kill_qemu_hook_func, s);
 
@@ -466,6 +458,33 @@ static char *qtest_socket_path(const char *suffix)
     return g_strdup_printf("%s/qtest-%d.%s", g_get_tmp_dir(), getpid(), suffix);
 }
 
+gchar *qtest_qemu_args(const char *extra_args)
+{
+    g_autofree gchar *socket_path = qtest_socket_path("sock");
+    g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
+    const char *trace = g_getenv("QTEST_TRACE");
+    g_autofree char *tracearg = trace ? g_strdup_printf("-trace %s ", trace) :
+                                        g_strdup("");
+    gchar *args = g_strdup_printf(
+                      "%s"
+                      "-qtest unix:%s "
+                      "-qtest-log %s "
+                      "-chardev socket,path=%s,id=char0 "
+                      "-mon chardev=char0,mode=control "
+                      "-display none "
+                      "-audio none "
+                      "%s"
+                      " -accel qtest",
+
+                      tracearg,
+                      socket_path,
+                      getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
+                      qmp_socket_path,
+                      extra_args ?: "");
+
+    return args;
+}
+
 static QTestState *qtest_init_internal(const char *qemu_bin,
                                        const char *extra_args,
                                        bool do_connect)
@@ -474,6 +493,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     int sock, qmpsock, i;
     g_autofree gchar *socket_path = qtest_socket_path("sock");
     g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
+    g_autofree gchar *args = qtest_qemu_args(extra_args);
 
     /*
      * It's possible that if an earlier test run crashed it might
@@ -488,19 +508,7 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-    s = qtest_spawn_qemu(qemu_bin,
-                         "-qtest unix:%s "
-                         "-qtest-log %s "
-                         "-chardev socket,path=%s,id=char0 "
-                         "-mon chardev=char0,mode=control "
-                         "-display none "
-                         "-audio none "
-                         "%s"
-                         " -accel qtest",
-                         socket_path,
-                         getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
-                         qmp_socket_path,
-                         extra_args ?: "");
+    s = qtest_spawn_qemu(qemu_bin, args);
 
     qtest_client_set_rx_handler(s, qtest_client_socket_recv_line);
     qtest_client_set_tx_handler(s, qtest_client_socket_send);
-- 
1.8.3.1


