Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830A1E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkep-00050U-Dy; Tue, 14 Jan 2025 12:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkem-0004um-9D
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkek-0004dE-EI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:48 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC1Vg3013757;
 Tue, 14 Jan 2025 17:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=w9msB8c+9TrHT+/GJFhThnvi7XY2KBCVYvFzeGxB+10=; b=
 XN9NhmIj+IRbxfppuuBZb8JZ+mB3jQYEVOgOn/AHjZqnpKhp6ZChlEEiCbtcZyiq
 gPRdq8ANakvJXGs7gKX950GhiI7fBuQWVLQyUXnx7YqkWKzrwV0OOwvULr4+y1L2
 IX+5+ev8nokXPdPwwohe45YkcB60lwlaU9ASS7Zaq8nFlXEt2GLEcqKYwMA6SQe/
 yRMb+2C5mmiGLR7YiurjokQmuOQzZXT1j8QWuUZLcCYXD0CYgkSQ0br1ykW0Ltw5
 mtCPGVGn4kCtKLBpgqEOmjDTtzqg5al3wwwXRY3rqhHwMwhw0iIq8eem/LlXUl5d
 xILJJfUaB4/w2qN2IObeQQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2eacv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EG2QTr020265; Tue, 14 Jan 2025 17:24:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq6u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtYG013352;
 Tue, 14 Jan 2025 17:24:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-24; Tue, 14 Jan 2025 17:24:32 +0000
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
Subject: [PATCH V6 23/24] migration-test: cpr-transfer
Date: Tue, 14 Jan 2025 09:23:53 -0800
Message-Id: <1736875434-106563-24-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-ORIG-GUID: jMgB5q14LvoCQ56xDR08qZpxfyz56C1Q
X-Proofpoint-GUID: jMgB5q14LvoCQ56xDR08qZpxfyz56C1Q
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a migration test for cpr-transfer mode.  Defer the connection to the
target monitor, else the test hangs because in cpr-transfer mode QEMU does
not listen for monitor connections until we send the migrate command to
source QEMU.

To test -incoming defer, send a migrate incoming command to the target,
after sending the migrate command to the source, as required by
cpr-transfer mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/cpr-tests.c | 60 +++++++++++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.c | 19 +++++++++++++
 tests/qtest/migration/framework.h |  3 ++
 3 files changed, 82 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 44ce89a..b221980 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -44,6 +44,62 @@ static void test_mode_reboot(void)
     test_file_common(&args, true);
 }
 
+static void *test_mode_transfer_start(QTestState *from, QTestState *to)
+{
+    migrate_set_parameter_str(from, "mode", "cpr-transfer");
+    return NULL;
+}
+
+/*
+ * cpr-transfer mode cannot use the target monitor prior to starting the
+ * migration, and cannot connect synchronously to the monitor, so defer
+ * the target connection.
+ */
+static void test_mode_transfer_common(bool incoming_defer)
+{
+    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
+    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
+    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
+
+    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree const char *cpr_channel = g_strdup_printf(
+        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
+        cpr_path);
+    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
+                                                   cpr_channel, opts);
+
+    g_autofree char *connect_channels = g_strdup_printf(
+        "[ { 'channel-type': 'main',"
+        "    'addr': { 'transport': 'socket',"
+        "              'type': 'unix',"
+        "              'path': '%s' } } ]",
+        mig_path);
+
+    MigrateCommon args = {
+        .start.opts_source = opts,
+        .start.opts_target = opts_target,
+        .start.defer_target_connect = true,
+        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
+                                " -machine memory-backend=pc.ram",
+        .listen_uri = incoming_defer ? "defer" : uri,
+        .connect_channels = connect_channels,
+        .cpr_channel = cpr_channel,
+        .start_hook = test_mode_transfer_start,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_mode_transfer(void)
+{
+    test_mode_transfer_common(NULL);
+}
+
+static void test_mode_transfer_defer(void)
+{
+    test_mode_transfer_common(true);
+}
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -55,4 +111,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
         migration_test_add("/migration/mode/reboot", test_mode_reboot);
     }
+
+    migration_test_add("/migration/mode/transfer", test_mode_transfer);
+    migration_test_add("/migration/mode/transfer/defer",
+                       test_mode_transfer_defer);
 }
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 8d34cb2..699beda 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -407,6 +407,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
     qtest_quit(to);
 
     cleanup("migsocket");
+    cleanup("cpr.sock");
     cleanup("src_serial");
     cleanup("dest_serial");
     cleanup(FILE_TEST_FILENAME);
@@ -688,8 +689,11 @@ void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    QObject *in_channels = NULL;
     QObject *out_channels = NULL;
 
+    g_assert(!args->cpr_channel || args->connect_channels);
+
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
@@ -721,8 +725,20 @@ void test_precopy_common(MigrateCommon *args)
         }
     }
 
+    /*
+     * The cpr channel must be included in outgoing channels, but not in
+     * migrate-incoming channels.
+     */
     if (args->connect_channels) {
+        in_channels = qobject_from_json(args->connect_channels, &error_abort);
         out_channels = qobject_from_json(args->connect_channels, &error_abort);
+
+        if (args->cpr_channel) {
+            QList *channels_list = qobject_to(QList, out_channels);
+            QObject *obj = migrate_str_to_channel(args->cpr_channel);
+
+            qlist_append(channels_list, obj);
+        }
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
@@ -735,6 +751,9 @@ void test_precopy_common(MigrateCommon *args)
     if (args->start.defer_target_connect) {
         qtest_connect(to);
         qtest_qmp_handshake(to);
+        if (!strcmp(args->listen_uri, "defer")) {
+            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
+        }
     }
 
     if (args->result != MIG_TEST_SUCCEED) {
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 1341368..4678e2a 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -152,6 +152,9 @@ typedef struct {
      */
     const char *connect_channels;
 
+    /* Optional: the cpr migration channel, in JSON or dotted keys format */
+    const char *cpr_channel;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
-- 
1.8.3.1


