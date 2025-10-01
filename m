Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99933CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrN-0005Or-Nf; Wed, 01 Oct 2025 11:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yrE-0005Hc-7Y
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqq-0006T7-4k
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMuKx011249;
 Wed, 1 Oct 2025 15:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=3Q4NSIJUCFvQHQ/0cr+eJF+jyuaVyooMM2rtT6q0NMw=; b=
 YubW76ogGM6AbHz4wyiKiYwCMwTHBSbOr3kIUM/IPoQdYuGx3nhMfK2zXhBTv1Cx
 4IjcxsX5jTFYJnanSOTnFqnWLlyG9/VXmZ+O0bPvMX8s6WPQTUICk9Y97PkQJolZ
 3Jmlmh86W5mIbnyRgD5ZdWnR9UbKU0gpZH6VZwX1ENsb37AJ0hC6xFCMj4JdRHL8
 QV/PVjMtkonVJZsst2PLWUV0MHof7LCCvquW7AQ961XeV0RR0JhVPfqAf8KkFCv4
 mY8npXxDdam0CZIE6OZINNmM7MWXnJtHTDQ1WZ+4mnUljhmsT2N6QsWlRh47RRuS
 k75f6u/eKQR39YQoddr3tA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacspx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591ElsjE023226; Wed, 1 Oct 2025 15:34:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caawad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCrC014790;
 Wed, 1 Oct 2025 15:34:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-18; Wed, 01 Oct 2025 15:34:24 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 17/19] migration-test: migrate_args
Date: Wed,  1 Oct 2025 08:34:09 -0700
Message-Id: <1759332851-370353-18-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dd4a02 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=MJRpHg2tEqB61jsq87oA:9
X-Proofpoint-ORIG-GUID: 6_PbnLpqBRvpkFMGABHHIjNVrFAoiXRK
X-Proofpoint-GUID: 6_PbnLpqBRvpkFMGABHHIjNVrFAoiXRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX8bsaMCqJnTaj
 aKLuxrxO8EOwQYFch4Aa7GGTsgZhUiSA+7+bFyWPfoB208BJyui1coLjY6ICGiQWdspbaP5WCjF
 odSoTWXwYdKon4MgOCTR3KNj8D9fHwRdSsMxKWx+j1tE51RBFXKA5KKgGHGM893u4BJJB/uO/Tl
 v0cRHTd90kP92IfcZm7sIRV2s/HNa6VnFy/rHFwCDECtE6B6+kCWH5TDh+hCOdK+fLrCrxmUE7n
 doYTM5lv6lRu1qPewjVksYbigSzCpp7ENAQifcTcvhS4EyLILJ2OQLhC+gPc2zgSi9hgerP0pFR
 OWUHgsf0WCW7HxmJbRAibmoSmmnVlO1kALEyfE5Bn0DD3wDEMgB1pLmkE/a1qcVAMqeoFnsxulW
 TpVg5ToIOeG7LUJLVRUilGCroBjEpQ==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Define the subroutine migrate_args to return the arguments that are
used to exec the source or target qemu process.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.h |  2 ++
 tests/qtest/migration/framework.c | 65 ++++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index ba7145a..02f9681 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -223,6 +223,8 @@ typedef struct {
 void wait_for_serial(const char *side);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
+
+int migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args);
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index ca13477..c0b299f 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -260,13 +260,12 @@ static char *test_shmem_path(void)
     return g_strdup_printf("/dev/shm/qemu-%d", getpid());
 }
 
-int migrate_start(QTestState **from, QTestState **to, const char *uri,
-                  MigrateStart *args)
+int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
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
@@ -275,23 +274,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
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
 
@@ -388,12 +374,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
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
@@ -417,6 +397,42 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
+
+    *from = cmd_source;
+    *to = cmd_target;
+    return 0;
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
+    if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
+        return -1;
+    }
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
@@ -430,6 +446,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
      * It's valid because QEMU has already opened this file
      */
     if (args->use_shmem) {
+        g_autofree char *shmem_path = test_shmem_path();
         unlink(shmem_path);
     }
 
-- 
1.8.3.1


