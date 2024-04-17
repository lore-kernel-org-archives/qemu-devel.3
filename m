Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A44C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 22:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxDXq-0001Zp-1h; Wed, 17 Apr 2024 18:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rxDXn-0001ZP-F5
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 18:14:19 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rxDXj-0005SI-8r
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 18:14:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 8DFCA60A9B;
 Thu, 18 Apr 2024 01:14:07 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b58f::1:2c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XDN2JB0IW0U0-kbk7cGeA; Thu, 18 Apr 2024 01:14:06 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713392046;
 bh=FQjW2JABBoz6njABOJV/+vzRR1pd5nmxRBXMhpsKZi8=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=VVequCZ3Hz+dTQTtgznSl2KgNEK56JrXSI1FdEDQIVEK7HJzBqAdZxGebDT87+bno
 0tpHomSXS9iDuW6c+RWEheK3bqCqH2ItxdCvwvOG+KbiwcY/B3RILc+CX52cAUIwu6
 rdiXLyMdDUsL/vu6026VDzvO2vpZvlk/7XNBQWgY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: vsementsov@yandex-team.ru, yc-core@yandex-team.ru, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 pkrempa@redhat.com
Subject: [PATCH] migration: do not exit on incoming failure
Date: Thu, 18 Apr 2024 01:13:29 +0300
Message-Id: <20240417221329.248803-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We do set MIGRATION_FAILED state, but don't give a chance to
orchestrator to query migration state and get the error.

Let's report an error through QAPI like we do on outgoing migration.

migration-test is updated correspondingly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Doubt: is exiting on failure a contract? Will this commit break
something in Libvirt? Finally, could we just change the logic, or I need
and additional migration-parameter for new behavior?

 migration/migration.c           | 22 +++++++---------------
 tests/qtest/migration-helpers.c | 13 ++++++++++---
 tests/qtest/migration-helpers.h |  3 ++-
 tests/qtest/migration-test.c    | 14 +++++++-------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 86bf76e925..3c203e767d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -738,11 +738,12 @@ process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     assert(mis->from_src_file);
 
     if (compress_threads_load_setup(mis->from_src_file)) {
-        error_report("Failed to setup decompress threads");
+        error_setg(&local_err, "Failed to setup decompress threads");
         goto fail;
     }
 
@@ -779,32 +780,23 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        MigrationState *s = migrate_get_current();
-
-        if (migrate_has_error(s)) {
-            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-                error_report_err(s->error);
-            }
-        }
-        error_report("load of migration failed: %s", strerror(-ret));
+        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
         goto fail;
     }
 
     if (colo_incoming_co() < 0) {
+        error_setg(&local_err, "colo incoming failed");
         goto fail;
     }
 
     migration_bh_schedule(process_incoming_migration_bh, mis);
     return;
 fail:
+    migrate_set_error(migrate_get_current(), local_err);
+    error_report_err(local_err);
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
-    qemu_fclose(mis->from_src_file);
-
-    multifd_recv_cleanup();
-    compress_threads_load_cleanup();
-
-    exit(EXIT_FAILURE);
+    migration_incoming_state_destroy();
 }
 
 /**
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..91c13bd566 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -211,7 +211,8 @@ void wait_for_migration_complete(QTestState *who)
     wait_for_migration_status(who, "completed", NULL);
 }
 
-void wait_for_migration_fail(QTestState *from, bool allow_active)
+void wait_for_migration_fail(QTestState *from, bool allow_active,
+                             bool is_incoming)
 {
     g_test_timer_start();
     QDict *rsp_return;
@@ -236,8 +237,14 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
     /* Is the machine currently running? */
     rsp_return = qtest_qmp_assert_success_ref(from,
                                               "{ 'execute': 'query-status' }");
-    g_assert(qdict_haskey(rsp_return, "running"));
-    g_assert(qdict_get_bool(rsp_return, "running"));
+    if (is_incoming) {
+        if (qdict_haskey(rsp_return, "running")) {
+            g_assert(!qdict_get_bool(rsp_return, "running"));
+        }
+    } else {
+        g_assert(qdict_haskey(rsp_return, "running"));
+        g_assert(qdict_get_bool(rsp_return, "running"));
+    }
     qobject_unref(rsp_return);
 }
 
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..7bd07059ae 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -46,7 +46,8 @@ void wait_for_migration_status(QTestState *who,
 
 void wait_for_migration_complete(QTestState *who);
 
-void wait_for_migration_fail(QTestState *from, bool allow_active);
+void wait_for_migration_fail(QTestState *from, bool allow_active,
+                             bool is_incoming);
 
 char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 1d2cee87ea..e00b755f05 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1670,7 +1670,7 @@ static void test_baddest(void)
         return;
     }
     migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
-    wait_for_migration_fail(from, false);
+    wait_for_migration_fail(from, false, false);
     test_migrate_end(from, to, false);
 }
 
@@ -1781,10 +1781,10 @@ static void test_precopy_common(MigrateCommon *args)
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
-        wait_for_migration_fail(from, allow_active);
+        wait_for_migration_fail(from, allow_active, false);
 
         if (args->result == MIG_TEST_FAIL_DEST_QUIT_ERR) {
-            qtest_set_expected_status(to, EXIT_FAILURE);
+            wait_for_migration_fail(to, true, true);
         }
     } else {
         if (args->live) {
@@ -2571,8 +2571,8 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     migrate_qmp(from, uri, "{}");
 
     if (should_fail) {
-        qtest_set_expected_status(to, EXIT_FAILURE);
-        wait_for_migration_fail(from, true);
+        wait_for_migration_fail(to, true, true);
+        wait_for_migration_fail(from, true, false);
     } else {
         wait_for_migration_complete(from);
     }
@@ -3047,8 +3047,8 @@ static void test_multifd_tcp_cancel(void)
     migrate_cancel(from);
 
     /* Make sure QEMU process "to" exited */
-    qtest_set_expected_status(to, EXIT_FAILURE);
-    qtest_wait_qemu(to);
+    wait_for_migration_fail(to, true, true);
+    qtest_quit(to);
 
     args = (MigrateStart){
         .only_target = true,
-- 
2.34.1


