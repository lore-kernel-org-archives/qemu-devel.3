Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FEAC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 12:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjHL6-00066i-Ks; Sat, 15 Feb 2025 07:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tjHKt-000641-81
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 07:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tjHKq-0002oC-LU
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 07:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739622711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ia6z9VYSCSmEQiJTZCU45yQKDwD7VqaFb4dVmeZo3VM=;
 b=FS0YzPFNwcHrk8IOTvyG2D7iEB14HIYfHdI1uKe/jfBWtU+dBkRkfLlpDW1sdWXuovNBoL
 f9SC0kK0M3nFf1TMXD/O37XNzwrMYsFmS25LaMhzZkJ2R+Rcx2q+yIS7LUM7ToMTQkvi3l
 DbK4X/k3HtrE2SaS0ULsWHB411a2acE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-fZ1gXu8LO5agBHeaNxJM_Q-1; Sat,
 15 Feb 2025 07:31:47 -0500
X-MC-Unique: fZ1gXu8LO5agBHeaNxJM_Q-1
X-Mimecast-MFC-AGG-ID: fZ1gXu8LO5agBHeaNxJM_Q_1739622706
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA0791975AFC; Sat, 15 Feb 2025 12:31:45 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.149])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF1DA1800365; Sat, 15 Feb 2025 12:31:40 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v6 3/4] tests/qtest/migration: consolidate set capabilities
Date: Sat, 15 Feb 2025 18:01:18 +0530
Message-ID: <20250215123119.814345-4-ppandit@redhat.com>
In-Reply-To: <20250215123119.814345-1-ppandit@redhat.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.195,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Migration capabilities are set in multiple '.start_hook'
functions for various tests. Instead, consolidate setting
capabilities in 'set_migration_capabilities()' function
which is called from various 'test_*_common()' functions.
While simplifying the capabilities setting, it helps
to declutter the qtest sources.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 tests/qtest/migration/compression-tests.c | 10 ++--
 tests/qtest/migration/cpr-tests.c         |  4 +-
 tests/qtest/migration/file-tests.c        | 44 +++++-------------
 tests/qtest/migration/framework.c         | 56 +++++++++++++++++------
 tests/qtest/migration/framework.h         |  4 +-
 tests/qtest/migration/postcopy-tests.c    |  4 +-
 tests/qtest/migration/precopy-tests.c     | 19 +++-----
 tests/qtest/migration/tls-tests.c         | 11 ++++-
 8 files changed, 80 insertions(+), 72 deletions(-)

v6:
- Reorder, make this the first qtest patch in this series.

v5:
- https://lore.kernel.org/qemu-devel/20250205122712.229151-1-ppandit@redhat.com/T/#t

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 8b58401b84..4558a7b9ff 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -35,6 +35,7 @@ static void test_multifd_tcp_zstd(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
     };
     test_precopy_common(&args);
@@ -56,6 +57,7 @@ static void test_multifd_tcp_qatzip(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
     };
     test_precopy_common(&args);
@@ -74,6 +76,7 @@ static void test_multifd_tcp_qpl(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
     };
     test_precopy_common(&args);
@@ -92,6 +95,7 @@ static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
     };
     test_precopy_common(&args);
@@ -103,10 +107,6 @@ migrate_hook_start_xbzrle(QTestState *from,
                           QTestState *to)
 {
     migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
-
-    migrate_set_capability(from, "xbzrle", true);
-    migrate_set_capability(to, "xbzrle", true);
-
     return NULL;
 }
 
@@ -118,6 +118,7 @@ static void test_precopy_unix_xbzrle(void)
         .listen_uri = uri,
         .start_hook = migrate_hook_start_xbzrle,
         .iterations = 2,
+        .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
         /*
          * XBZRLE needs pages to be modified when doing the 2nd+ round
          * iteration to have real data pushed to the stream.
@@ -146,6 +147,7 @@ static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
     };
     test_precopy_common(&args);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 4758841824..a175646b57 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -24,9 +24,6 @@ static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
     migrate_set_parameter_str(from, "mode", "cpr-reboot");
     migrate_set_parameter_str(to, "mode", "cpr-reboot");
 
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
     return NULL;
 }
 
@@ -39,6 +36,7 @@ static void test_mode_reboot(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_mode_reboot,
+        .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
     };
 
     test_file_common(&args, true);
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index f260e2871d..6253ece687 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -107,15 +107,6 @@ static void test_precopy_file_offset_bad(void)
     test_file_common(&args, false);
 }
 
-static void *migrate_hook_start_mapped_ram(QTestState *from,
-                                           QTestState *to)
-{
-    migrate_set_capability(from, "mapped-ram", true);
-    migrate_set_capability(to, "mapped-ram", true);
-
-    return NULL;
-}
-
 static void test_precopy_file_mapped_ram_live(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -123,7 +114,7 @@ static void test_precopy_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mapped_ram,
+        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
     };
 
     test_file_common(&args, false);
@@ -136,26 +127,12 @@ static void test_precopy_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mapped_ram,
+        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
     };
 
     test_file_common(&args, true);
 }
 
-static void *migrate_hook_start_multifd_mapped_ram(QTestState *from,
-                                                   QTestState *to)
-{
-    migrate_hook_start_mapped_ram(from, to);
-
-    migrate_set_parameter_int(from, "multifd-channels", 4);
-    migrate_set_parameter_int(to, "multifd-channels", 4);
-
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
-    return NULL;
-}
-
 static void test_multifd_file_mapped_ram_live(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -163,7 +140,8 @@ static void test_multifd_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
     };
 
     test_file_common(&args, false);
@@ -176,7 +154,8 @@ static void test_multifd_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
     };
 
     test_file_common(&args, true);
@@ -185,8 +164,6 @@ static void test_multifd_file_mapped_ram(void)
 static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
                                                        QTestState *to)
 {
-    migrate_hook_start_multifd_mapped_ram(from, to);
-
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
 
@@ -201,6 +178,8 @@ static void test_multifd_file_mapped_ram_dio(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
+        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
 
     if (!probe_o_direct_support(tmpfs)) {
@@ -246,7 +225,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, true);
     fdset_add_fds(to, file, O_RDONLY, 2, true);
 
-    migrate_hook_start_multifd_mapped_ram(from, to);
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
 
@@ -261,8 +239,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, false);
     fdset_add_fds(to, file, O_RDONLY, 2, false);
 
-    migrate_hook_start_multifd_mapped_ram(from, to);
-
     return NULL;
 }
 
@@ -275,6 +251,8 @@ static void test_multifd_file_mapped_ram_fdset(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
+        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
 
     test_file_common(&args, true);
@@ -289,6 +267,8 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
+        .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
 
     if (!probe_o_direct_support(tmpfs)) {
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 10e1d04b58..82aaa13e85 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -207,6 +207,31 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
     return capabilities;
 }
 
+static void set_migration_capabilities(QTestState *from,
+                                        QTestState *to, MigrateCommon *args)
+{
+    /*
+     * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
+     * are from qapi-types-migration.h.
+     */
+    for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++)
+    {
+        if (!args->caps[i]) {
+            continue;
+        }
+        if (from) {
+            migrate_set_capability(from,
+                            MigrationCapability_lookup.array[i], true);
+        }
+        if (to) {
+            migrate_set_capability(to,
+                            MigrationCapability_lookup.array[i], true);
+        }
+    }
+
+    return;
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -440,17 +465,12 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         args->postcopy_data = args->start_hook(from, to);
     }
 
-    migrate_set_capability(from, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-ram", true);
-    migrate_set_capability(to, "postcopy-blocktime", true);
-
-    if (args->postcopy_preempt) {
-        migrate_set_capability(from, "postcopy-preempt", true);
-        migrate_set_capability(to, "postcopy-preempt", true);
-    }
+    /* set postcopy capabilities */
+    args->caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
+    args->caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+    set_migration_capabilities(from, to, args);
 
     migrate_ensure_non_converge(from);
-
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { "
@@ -717,6 +737,12 @@ void test_precopy_common(MigrateCommon *args)
         return;
     }
 
+    set_migration_capabilities(from, to, args);
+    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        migrate_set_parameter_int(from, "multifd-channels", 16);
+        migrate_set_parameter_int(to, "multifd-channels", 16);
+    }
+
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
     }
@@ -888,6 +914,12 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      */
     g_assert_false(args->live);
 
+    set_migration_capabilities(from, to, args);
+    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        migrate_set_parameter_int(from, "multifd-channels", 4);
+        migrate_set_parameter_int(to, "multifd-channels", 4);
+    }
+
     if (g_strrstr(args->connect_uri, "offset=")) {
         check_offset = true;
         /*
@@ -948,15 +980,9 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
                                                     const char *method)
 {
-    migrate_set_parameter_int(from, "multifd-channels", 16);
-    migrate_set_parameter_int(to, "multifd-channels", 16);
-
     migrate_set_parameter_str(from, "multifd-compression", method);
     migrate_set_parameter_str(to, "multifd-compression", method);
 
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index e4a11870f6..74d53eee69 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -12,6 +12,7 @@
 #define TEST_FRAMEWORK_H
 
 #include "libqtest.h"
+#include <qapi/qapi-types-migration.h>
 
 #define FILE_TEST_FILENAME "migfile"
 #define FILE_TEST_OFFSET 0x1000
@@ -207,8 +208,9 @@ typedef struct {
 
     /* Postcopy specific fields */
     void *postcopy_data;
-    bool postcopy_preempt;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
+
+    bool caps[MIGRATION_CAPABILITY__MAX];
 } MigrateCommon;
 
 void wait_for_serial(const char *side);
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 982457bed1..b0e70a6367 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -39,7 +39,7 @@ static void test_postcopy_suspend(void)
 static void test_postcopy_preempt(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
+        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
     };
 
     test_postcopy_common(&args);
@@ -73,7 +73,7 @@ static void test_postcopy_recovery_fail_reconnect(void)
 static void test_postcopy_preempt_recovery(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
+        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
     };
 
     test_postcopy_recovery_common(&args);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 162fa69531..e5d8c49dbe 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -107,23 +107,12 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
-static void *migrate_hook_start_switchover_ack(QTestState *from, QTestState *to)
-{
-
-    migrate_set_capability(from, "return-path", true);
-    migrate_set_capability(to, "return-path", true);
-
-    migrate_set_capability(from, "switchover-ack", true);
-    migrate_set_capability(to, "switchover-ack", true);
-
-    return NULL;
-}
-
 static void test_precopy_tcp_switchover_ack(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_switchover_ack,
+        .caps[MIGRATION_CAPABILITY_RETURN_PATH] = true,
+        .caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true,
         /*
          * Source VM must be running in order to consider the switchover ACK
          * when deciding to do switchover or not.
@@ -392,6 +381,7 @@ static void test_multifd_tcp_uri_none(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -407,6 +397,7 @@ static void test_multifd_tcp_zero_page_legacy(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -422,6 +413,7 @@ static void test_multifd_tcp_no_zero_page(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -438,6 +430,7 @@ static void test_multifd_tcp_channels_none(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
         .live = true,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         .connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
                              "              'type': 'inet',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 2cb4a44bcd..30ab79e058 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -375,9 +375,9 @@ static void test_postcopy_tls_psk(void)
 static void test_postcopy_preempt_tls_psk(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
     };
 
     test_postcopy_common(&args);
@@ -397,9 +397,9 @@ static void test_postcopy_recovery_tls_psk(void)
 static void test_postcopy_preempt_all(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
     };
 
     test_postcopy_recovery_common(&args);
@@ -631,6 +631,7 @@ static void test_multifd_tcp_tls_psk_match(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -645,6 +646,7 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
         .end_hook = migrate_hook_end_tls_psk,
         .result = MIG_TEST_FAIL,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -656,6 +658,7 @@ static void test_multifd_tcp_tls_x509_default_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
         .end_hook = migrate_hook_end_tls_x509,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -666,6 +669,7 @@ static void test_multifd_tcp_tls_x509_override_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
         .end_hook = migrate_hook_end_tls_x509,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -693,6 +697,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
         .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
         .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -703,6 +708,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
         .end_hook = migrate_hook_end_tls_x509,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
@@ -717,6 +723,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
         .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
         .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
     };
     test_precopy_common(&args);
 }
--
2.48.1


