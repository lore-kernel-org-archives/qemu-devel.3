Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8F2CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yre-0005bm-O5; Wed, 01 Oct 2025 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yrT-0005VZ-BD
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqr-0006Qp-5E
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:22 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMuKv011249;
 Wed, 1 Oct 2025 15:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=HQQilMN2sZ062zC6WGNy2qecLFQMOB7ajHw0kJZsDMw=; b=
 mkKjw0vlWfkWSF2JRthuWS+40+lVHP+edRLKkYWMdTgjs0R5MQggtrQtSuiFZpKl
 rWBc5G7LXUbkIuTdTbZVg4pbfCq8VrsSdYQbEQm+t+Ux29vZJe6XLdVu8AuIAQfZ
 rAr4s/rFYM7rTBdohv0ee8L7HWav9d/xozAIWrEt3J9Zy2nc8DNacYj8lYtAfWMy
 wnI+xMBynhd4ObrV0z3vi3hFC0EONyomdbTFuDyuu2wTsFwlaYP1g6t8XtcJxnmv
 7yzXDlsyj/qk1Pn51j5z85lassjN7VhzRjOsKwh8nvCmfBVkH0KYGiDKhZmkilt+
 lBNbvottMSi/hAh4FskZnA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacspwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591EkqMY023130; Wed, 1 Oct 2025 15:34:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCqw014790;
 Wed, 1 Oct 2025 15:34:19 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-11; Wed, 01 Oct 2025 15:34:19 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 10/19] tests/qtest: qtest_qemu_args
Date: Wed,  1 Oct 2025 08:34:02 -0700
Message-Id: <1759332851-370353-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dd49fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=8wfYa_FxhlLIVDfICZMA:9
X-Proofpoint-ORIG-GUID: 5VSShwOW8NSuoe1Cw0_cvmRWyhAOBTyT
X-Proofpoint-GUID: 5VSShwOW8NSuoe1Cw0_cvmRWyhAOBTyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfXxiNi+TGKDSzc
 3gLxGam4rTiH9oGfxvNCpljfWOhIWZ7TqJ/xbwG9SvPCqmfJuWGeHxmTiEd49RpRyVxbcMh4bng
 nWHDnmeeyOUz5ffD3gaVxjcPfMsyy3KkgkbaD03o516aioYsje5k8f3tWGHyLGMYagnFk1O2wDx
 8n+JzI5O61yMV41fPU1AhFiCh8EwCi+5g9fRjp9oUKljQP/8Y7OMqELwSCVfs2tMJo/PHsMT7NH
 7VpLqmFGtKUlIrhBgw5df4HJlfDR7gbPz5w1zYobWCg8DvjP+hZvmVkYBdFpg+rye63m+gGnjq8
 gM+PqePF8KA4IwLapehkN7e/uf0yOkCu3UA8i4GkorVO3K1Gh0bLrNmvnrOXUyZ8ua2HkeERqpv
 a79dmoUz7oozqgzwCiVRlmekMaLOtQ==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.h |  8 ++++++++
 tests/qtest/libqtest.c | 54 +++++++++++++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index dc2cdd0..7f8dd0a 100644
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
index 43fd997..b3b3fc2 100644
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


