Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B0FCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbre-00017Y-2p; Fri, 19 Sep 2025 10:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbrA-0000V5-TV
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqy-0007Wg-Di
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDu2P4009215;
 Fri, 19 Sep 2025 14:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=fI1kqNJSC5ZyO0q0rbr0dSa7aYQgbwPOGlDXHSRJMSQ=; b=
 Rqd1Qs119YDdha9191AE4gyFFDYoN416Jyff42XAGzncUq/tT/kMddy6Xc5zrlhc
 /LTgK2caLvUhAx4hyAgYA+caPW4jnemuIokSLBOc+NC6VKsGSoymPuC/mq41dvT7
 mgBczHeWeAGcNlpwRB+h/zWI9mHyw6Tt2HHrhRIw5ypvOozHlVmvdSJCrPJ6ZN4Q
 jH6+QoYcbyPj3ld+akMVDcfIu+KPLcIJA9wiSF9QHrGaXC4evVkVFCXJ3W3BA1Bp
 xb2gPtoh1A+RkzhyZ0X/tbuQ6yltdZW0L3NehS+RCOzfeNKCa3Y3GCNsBLwUDbu5
 w3UeKMQxL5U4zoEik36CdQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb5mmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JDlolt035170; Fri, 19 Sep 2025 14:12:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu970-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYXJ003357;
 Fri, 19 Sep 2025 14:12:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-10; Fri, 19 Sep 2025 14:12:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 09/11] migration-test: migrate_args
Date: Fri, 19 Sep 2025 07:12:31 -0700
Message-Id: <1758291153-349744-10-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5c3zgX19JOfv
 /rc+KDMsH23PB1ZeXHtXJ7YsoSuXsLuTxmF7uKOP+yWAX7hAhiTDPipgRuD0iFzMYdveI9xYS5o
 bQa7asTPV+Eef+0HnTGYi8/XtGAFOfoOxlbnOf1+v1hByjEnmtcjOg5x9lrfQ305PlPg0I0ScAy
 zhfdaxmF588IeZP7Hb994iMWyJ5Bt04uVdv3WUKHZsSx0fH74SxPUQIbpzbL4XBAUqf7GC2Ajvr
 S/zx0QhjV/6mxvyoGx3f8Zi4TYJnNdiJIWJQxUrZDLJNFbetiI9pUlhIM8JvWutR8aVZSY6Szkp
 F3R9e26Xu7b6s8BFbjG8mhYTL7es3fL9H2FtcxuUFccf7Au5xmViBl/U+QGM0tjGQt1+TSSMvfm
 71GQfH7WVgiVY0tRMok9jbFuXTs5gg==
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cd64dd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=YmwRFIh_-Xcf99jFgVMA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: Dcw53D9L-l_kKAqqCOcg8IEUCFtQX_Be
X-Proofpoint-ORIG-GUID: Dcw53D9L-l_kKAqqCOcg8IEUCFtQX_Be
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Define the subroutine migrate_args to return the arguments that are
used to exec the source or target qemu process.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/framework.h |  2 ++
 tests/qtest/migration/framework.c | 64 ++++++++++++++++++++++++---------------
 2 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 7ff3187..51a8a7e 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -226,6 +226,8 @@ typedef struct {
 void wait_for_serial(const char *side);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
+
+void migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args);
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 8f9e359..2dfb1ee 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -258,13 +258,12 @@ static char *test_shmem_path(void)
     return g_strdup_printf("/dev/shm/qemu-%d", getpid());
 }
 
-int migrate_start(QTestState **from, QTestState **to, const char *uri,
-                  MigrateStart *args)
+void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
 {
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
-    g_autofree gchar *cmd_source = NULL;
-    g_autofree gchar *cmd_target = NULL;
+    gchar *cmd_source = NULL;
+    gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
@@ -273,23 +272,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *memory_size;
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
-    const char *bootpath;
-    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
+    const char *bootpath = bootfile_get();
     g_autofree char *memory_backend = NULL;
     const char *events;
 
-    if (args->use_shmem) {
-        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
-            g_test_skip("/dev/shm is not supported");
-            return -1;
-        }
-    }
-
-    dst_state = (QTestMigrationState) { };
-    src_state = (QTestMigrationState) { };
-    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
-    src_state.suspend_me = args->suspend_me;
-
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
 
@@ -365,7 +351,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     if (!qtest_has_machine(machine_alias)) {
         g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
         g_test_skip(msg);
-        return -1;
+        return;
     }
 
     machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
@@ -386,12 +372,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
-    if (!args->only_target) {
-        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
-        qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_events,
-                                     &src_state);
-    }
 
     /*
      * If the monitor connection is deferred, enable events on the command line
@@ -415,6 +395,39 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
+
+    *from = cmd_source;
+    *to = cmd_target;
+}
+
+int migrate_start(QTestState **from, QTestState **to, const char *uri,
+                  MigrateStart *args)
+{
+    g_autofree gchar *cmd_source = NULL;
+    g_autofree gchar *cmd_target = NULL;
+    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
+
+    if (args->use_shmem) {
+        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
+            g_test_skip("/dev/shm is not supported");
+            return -1;
+        }
+    }
+
+    dst_state = (QTestMigrationState) { };
+    src_state = (QTestMigrationState) { };
+    bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
+    src_state.suspend_me = args->suspend_me;
+
+    migrate_args(&cmd_source, &cmd_target, uri, args);
+
+    if (!args->only_target) {
+        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
+        qtest_qmp_set_event_callback(*from,
+                                     migrate_watch_for_events,
+                                     &src_state);
+    }
+
     if (!args->only_source) {
         *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
                              !args->defer_target_connect);
@@ -428,6 +441,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
      * It's valid because QEMU has already opened this file
      */
     if (args->use_shmem) {
+        g_autofree char *shmem_path = test_shmem_path();
         unlink(shmem_path);
     }
 
-- 
1.8.3.1


