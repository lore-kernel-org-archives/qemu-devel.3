Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714A3C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzJw-0004Kb-HK; Fri, 28 Feb 2025 07:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzJu-0004H3-Sb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzJr-0001Gc-OX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740745098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uia+fes4pNtdusLHioa6C5P5V8u5kbWAm64xht2Ey9w=;
 b=cwkF5JAA6hA9CbpQUOOB/lWvG2DAA/tSlzU9MJ1p4A5igAnbr1ggtH/Cx9Qy+0uqg87THT
 GEStPtgEEFd/e1pHZNX5gWJ18+9BlJxoJONzyt+CO98PNSlvwzN4cUBZ1N0cDl6MS/R7Et
 Os8RQe4bxkufvToJHT/Q2xFM6803a1I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-yn-wRK8FNgWV6n0_7UoEiQ-1; Fri,
 28 Feb 2025 07:18:17 -0500
X-MC-Unique: yn-wRK8FNgWV6n0_7UoEiQ-1
X-Mimecast-MFC-AGG-ID: yn-wRK8FNgWV6n0_7UoEiQ_1740745096
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 516051944D01; Fri, 28 Feb 2025 12:18:16 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.175])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912E1180087F; Fri, 28 Feb 2025 12:18:10 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v7 3/5] tests/qtest/migration: consolidate set capabilities
Date: Fri, 28 Feb 2025 17:47:47 +0530
Message-ID: <20250228121749.553184-4-ppandit@redhat.com>
In-Reply-To: <20250228121749.553184-1-ppandit@redhat.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

Migration capabilities are set in multiple '.start_hook'
functions for various tests. Instead, consolidate setting
capabilities in 'migrate_start_set_capabilities()' function
which is called from the 'migrate_start()' function.
While simplifying the capabilities setting, it helps
to declutter the qtest sources.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 tests/qtest/migration/compression-tests.c | 22 +++++--
 tests/qtest/migration/cpr-tests.c         |  6 +-
 tests/qtest/migration/file-tests.c        | 58 ++++++++---------
 tests/qtest/migration/framework.c         | 76 ++++++++++++++++-------
 tests/qtest/migration/framework.h         |  9 ++-
 tests/qtest/migration/misc-tests.c        |  4 +-
 tests/qtest/migration/postcopy-tests.c    |  8 ++-
 tests/qtest/migration/precopy-tests.c     | 29 +++++----
 tests/qtest/migration/tls-tests.c         | 23 ++++++-
 9 files changed, 151 insertions(+), 84 deletions(-)

v6: Move .caps initialization to the .start object.
    Set default multifd threads to 4.
- https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 8b58401b84..41e79f031b 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -35,6 +35,9 @@ static void test_multifd_tcp_zstd(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
     };
     test_precopy_common(&args);
@@ -56,6 +59,9 @@ static void test_multifd_tcp_qatzip(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
     };
     test_precopy_common(&args);
@@ -74,6 +80,9 @@ static void test_multifd_tcp_qpl(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
     };
     test_precopy_common(&args);
@@ -92,6 +101,9 @@ static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
     };
     test_precopy_common(&args);
@@ -103,10 +115,6 @@ migrate_hook_start_xbzrle(QTestState *from,
                           QTestState *to)
 {
     migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
-
-    migrate_set_capability(from, "xbzrle", true);
-    migrate_set_capability(to, "xbzrle", true);
-
     return NULL;
 }
 
@@ -118,6 +126,9 @@ static void test_precopy_unix_xbzrle(void)
         .listen_uri = uri,
         .start_hook = migrate_hook_start_xbzrle,
         .iterations = 2,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
+        },
         /*
          * XBZRLE needs pages to be modified when doing the 2nd+ round
          * iteration to have real data pushed to the stream.
@@ -146,6 +157,9 @@ static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
     };
     test_precopy_common(&args);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 4758841824..5536e14610 100644
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
 
@@ -39,6 +36,9 @@ static void test_mode_reboot(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_mode_reboot,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
+        },
     };
 
     test_file_common(&args, true);
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index f260e2871d..4d78ce0855 100644
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
@@ -123,7 +114,9 @@ static void test_precopy_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, false);
@@ -136,26 +129,14 @@ static void test_precopy_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
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
@@ -163,7 +144,10 @@ static void test_multifd_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, false);
@@ -176,7 +160,10 @@ static void test_multifd_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+        },
     };
 
     test_file_common(&args, true);
@@ -185,8 +172,6 @@ static void test_multifd_file_mapped_ram(void)
 static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
                                                        QTestState *to)
 {
-    migrate_hook_start_multifd_mapped_ram(from, to);
-
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
 
@@ -201,6 +186,10 @@ static void test_multifd_file_mapped_ram_dio(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     if (!probe_o_direct_support(tmpfs)) {
@@ -246,7 +235,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, true);
     fdset_add_fds(to, file, O_RDONLY, 2, true);
 
-    migrate_hook_start_multifd_mapped_ram(from, to);
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
 
@@ -261,8 +249,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, false);
     fdset_add_fds(to, file, O_RDONLY, 2, false);
 
-    migrate_hook_start_multifd_mapped_ram(from, to);
-
     return NULL;
 }
 
@@ -275,6 +261,10 @@ static void test_multifd_file_mapped_ram_fdset(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     test_file_common(&args, true);
@@ -289,6 +279,10 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
 
     if (!probe_o_direct_support(tmpfs)) {
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 10e1d04b58..be6c245843 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -30,6 +30,7 @@
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+#define MULTIFD_TEST_CHANNELS 4
 
 unsigned start_address;
 unsigned end_address;
@@ -207,6 +208,52 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
     return capabilities;
 }
 
+static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
+                                           MigrateStart *args)
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
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(from, "events", true);
+    if (!args->defer_target_connect) {
+        migrate_set_capability(to, "events", true);
+    }
+
+    /*
+     * Default number of channels should be fine for most
+     * tests. Individual tests can override by calling
+     * migrate_set_parameter() directly.
+     */
+    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        migrate_set_parameter_int(from, "multifd-channels",
+                                  MULTIFD_TEST_CHANNELS);
+        migrate_set_parameter_int(to, "multifd-channels",
+                                  MULTIFD_TEST_CHANNELS);
+    }
+
+    return;
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -379,14 +426,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         unlink(shmem_path);
     }
 
-    /*
-     * Always enable migration events.  Libvirt always uses it, let's try
-     * to mimic as closer as that.
-     */
-    migrate_set_capability(*from, "events", true);
-    if (!args->defer_target_connect) {
-        migrate_set_capability(*to, "events", true);
-    }
+    migrate_start_set_capabilities(*from, *to, args);
 
     return 0;
 }
@@ -432,6 +472,10 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 {
     QTestState *from, *to;
 
+    /* set postcopy capabilities */
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
@@ -440,17 +484,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
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
-
     migrate_ensure_non_converge(from);
-
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { "
@@ -948,15 +982,9 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
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
index e4a11870f6..01e425e64e 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -12,6 +12,7 @@
 #define TEST_FRAMEWORK_H
 
 #include "libqtest.h"
+#include <qapi/qapi-types-migration.h>
 
 #define FILE_TEST_FILENAME "migfile"
 #define FILE_TEST_OFFSET 0x1000
@@ -120,6 +121,13 @@ typedef struct {
 
     /* Do not connect to target monitor and qtest sockets in qtest_init */
     bool defer_target_connect;
+
+    /*
+     * Migration capabilities to be set in both source and
+     * destination. For unilateral capabilities, use
+     * migration_set_capabilities().
+     */
+    bool caps[MIGRATION_CAPABILITY__MAX];
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
@@ -207,7 +215,6 @@ typedef struct {
 
     /* Postcopy specific fields */
     void *postcopy_data;
-    bool postcopy_preempt;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 2e612d9e38..54995256d8 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -98,6 +98,7 @@ static void test_ignore_shared(void)
     QTestState *from, *to;
     MigrateStart args = {
         .use_shmem = true,
+        .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
     };
 
     if (migrate_start(&from, &to, uri, &args)) {
@@ -107,9 +108,6 @@ static void test_ignore_shared(void)
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
 
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 982457bed1..483e3ff99f 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -39,7 +39,9 @@ static void test_postcopy_suspend(void)
 static void test_postcopy_preempt(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_common(&args);
@@ -73,7 +75,9 @@ static void test_postcopy_recovery_fail_reconnect(void)
 static void test_postcopy_preempt_recovery(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_recovery_common(&args);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ba273d10b9..f8404793b8 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -108,23 +108,14 @@ static void test_precopy_tcp_plain(void)
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
+        .start = {
+            .caps[MIGRATION_CAPABILITY_RETURN_PATH] = true,
+            .caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true,
+        },
         /*
          * Source VM must be running in order to consider the switchover ACK
          * when deciding to do switchover or not.
@@ -393,6 +384,9 @@ static void test_multifd_tcp_uri_none(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -408,6 +402,9 @@ static void test_multifd_tcp_zero_page_legacy(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -423,6 +420,9 @@ static void test_multifd_tcp_no_zero_page(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -439,6 +439,9 @@ static void test_multifd_tcp_channels_none(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_precopy_tcp_multifd,
         .live = true,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
         .connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
                              "              'type': 'inet',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 2cb4a44bcd..72f44defbb 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -375,9 +375,11 @@ static void test_postcopy_tls_psk(void)
 static void test_postcopy_preempt_tls_psk(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_common(&args);
@@ -397,9 +399,11 @@ static void test_postcopy_recovery_tls_psk(void)
 static void test_postcopy_preempt_all(void)
 {
     MigrateCommon args = {
-        .postcopy_preempt = true,
         .start_hook = migrate_hook_start_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
     };
 
     test_postcopy_recovery_common(&args);
@@ -631,6 +635,9 @@ static void test_multifd_tcp_tls_psk_match(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
         .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -640,6 +647,7 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
@@ -656,6 +664,9 @@ static void test_multifd_tcp_tls_x509_default_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
         .end_hook = migrate_hook_end_tls_x509,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -666,6 +677,9 @@ static void test_multifd_tcp_tls_x509_override_host(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
         .end_hook = migrate_hook_end_tls_x509,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -688,6 +702,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
@@ -703,6 +718,9 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
         .end_hook = migrate_hook_end_tls_x509,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
     };
     test_precopy_common(&args);
 }
@@ -712,6 +730,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
         },
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
-- 
2.48.1


