Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD1C44507
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoNB-0001g2-7i; Thu, 09 Jul 2026 09:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoN5-0001dP-JN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:56 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoN0-00005Z-BJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:55 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca913a601fbso209317a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783602048; x=1784206848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20jw1gKRRwIYR9j0Ca71dxRoZUJNv80X1O03w2o3ayc=;
 b=GB6UqlkJlvJ5SRua3N6dXO116O9MSzD+1VbAj6l9zgGw8MFcYTe6EwzEQxaJUGQ9U7
 OJZ4tg+IsIzJ8OLeri61mIU2cpwnntUFKvAp5OO37BRxDXD5zq3YNR0zbIcD/zf0AngU
 fS2H8VZXHQELBVqJEhUfOsCD+q7o9w803HUeJFIgH7nPPw5EIgmDZuUBLpKDPo/qgFEm
 ihqP8cVqxurvGKwEfprRO+cvZNsk/hIB8bEY8ObqAc1R17SqoN3c3HOGDQGlAjaMWsDR
 mRDn7egArsorgaTUM/xmLFNf14oy9yb8/L7fsHKLhPzz9mS1ogmKFrFVJzRf/gublZoH
 GPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602048; x=1784206848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=20jw1gKRRwIYR9j0Ca71dxRoZUJNv80X1O03w2o3ayc=;
 b=fsaEP7W3EErx9pGCzS9r4pgk4u1CPDc96cMeklx8nmuaYB2A6hESkVnkaCbKGQ5r0b
 VAoCqda9eWCpvtOZm6eN31zcclWxfNiDW3s9uawgH+KOZFN5xUG78F4Go2xni5sgceAJ
 ARY49UvU/vkPzi4inbMwGHU8aKyjZTU56icFk8yicZi46Uocdn8UyF9ASQ0Sv/Yp+fG/
 1XU6Bx5uhVMKTk7X7dOiOmF1tt8adtVmViX9xvj8WdM9gtmARgL/9H7kW1J6NyqemBF8
 n3F52Den3Uy4T+MhQaP6Z6Yb0JlNKDUryJJPmyicIRDODgldot1gHPsGgSyi8O9wYKC0
 KiRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqICOYgUisKRQVDfapwRB7kt4rkmb5VScrFNIgiqgKHhX4wtr04LNKLMBJUu64dM8G5LFykHjNxNW4u@nongnu.org
X-Gm-Message-State: AOJu0YzqVg6gh1+grhBpq6/GKWMNJ5SMGCfa1wqSDQepzhv2I5q+K4Mj
 HKlmsrj1R5ERwCGVDhaQoOTIdtz97Oi80vhFZLG3pguZeHZI2/t8KfMi
X-Gm-Gg: AfdE7cnOcKt+Sh8fI/xN70LjABnTE6PebO42uD7KelmEB8yRVyVZSzyeDSwMCncBF/u
 PgZncLr7WvS6x8ciGvgoB16lbBt7UzDGawy0/mGMRHcVC3RJmtl4oqrZyfwJxL+ZIpkuO9VqrOx
 6DF4YhNsN3eeUjeq4uCFCOc9yysnt/Y77QUggsW/9EgBf/wLNAfWJAgdQ46PIa5mGZ2L+IE65U7
 SYV3CbAK1OSpXgzH1FQCDuIv/InJLQClII3Yrcem4nk+VItED383EFb1EKdNFm/irWW0vThgKbP
 3+s3jGm/5aDWEJtVVaz+DVbucCGjYiM0hpdKVNGQJ8SuLXcv5K/R1HnmxUiAph0ofcPIM5JpQHM
 J9Tg8MZqsExi1Q0O98H2SKa742yvSGIKc8rswrl7c+laR0AWQBOG8Q3qEqK8Dl9R3d1ObkBPh/s
 LSOc9/F2G76etvklc37APF7fUtSTeaIJ4oMgP4yO2EIGTFZ4HTKAqG3RsN
X-Received: by 2002:a05:6a21:a95:b0:3bf:6c08:fb9d with SMTP id
 adf61e73a8af0-3c0bcead1b1mr9350607637.49.1783602047307; 
 Thu, 09 Jul 2026 06:00:47 -0700 (PDT)
Received: from C02G720XMD6P.sg.corp.seagroup.com ([111.223.92.222])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-31174ac14f2sm32908611eec.27.2026.07.09.06.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:00:46 -0700 (PDT)
From: phind.uet@gmail.com
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/migration: Retrieve serial path from QTestState
Date: Thu,  9 Jul 2026 21:00:26 +0800
Message-ID: <20260709130032.58667-3-phind.uet@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709130032.58667-1-phind.uet@gmail.com>
References: <20260709130032.58667-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=phind.uet@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Replace hard-coded side names ("src_serial", "dest_serial") passed to
wait_for_serial() with qtest_get_serial_path().  The path is stored on
the QTestState at launch time by migrate_launch_source/dest().

Hard-coded names break when a process changes role, for example when a
completed destination is re-used as a new source in a chain migration.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 tests/qtest/libqtest.c                | 16 ++++++++++++
 tests/qtest/libqtest.h                |  8 ++++++
 tests/qtest/migration/colo-tests.c    | 14 +++++-----
 tests/qtest/migration/cpr-tests.c     |  8 +++---
 tests/qtest/migration/framework.c     | 37 ++++++++++++++++-----------
 tests/qtest/migration/framework.h     |  2 +-
 tests/qtest/migration/misc-tests.c    |  4 +--
 tests/qtest/migration/precopy-tests.c | 28 +++++++++++---------
 8 files changed, 76 insertions(+), 41 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c33c799c92..3fccd089dd 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -93,6 +93,7 @@ struct QTestState
     GList *pending_events;
     QTestQMPEventCallback eventCB;
     void *eventData;
+    char *serial_path;
 };
 
 static GHookList abrt_hooks;
@@ -688,10 +689,25 @@ void qtest_quit(QTestState *s)
     }
 
     g_list_free(s->pending_events);
+    if (s->serial_path) {
+        unlink(s->serial_path);
+        g_free(s->serial_path);
+    }
 
     g_free(s);
 }
 
+void qtest_set_serial_path(QTestState *s, const char *path)
+{
+    g_free(s->serial_path);
+    s->serial_path = g_strdup(path);
+}
+
+const char *qtest_get_serial_path(QTestState *s)
+{
+    return s->serial_path;
+}
+
 static void socket_send(int fd, const char *buf, size_t size)
 {
     ssize_t res = qemu_send_full(fd, buf, size);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 45217fb8dc..0958cf1662 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -98,6 +98,14 @@ QTestState *qtest_init(const char *extra_args);
 QTestState *qtest_init_ext(const char *var, const char *extra_args,
                            QList *capabilities, bool do_connect);
 
+/**
+ * qtest_set_serial_path:
+ * @s: #QTestState instance
+ * @path: full path to the serial output file to unlink on qtest_quit()
+ */
+void qtest_set_serial_path(QTestState *s, const char *path);
+const char *qtest_get_serial_path(QTestState *s);
+
 /**
  * qtest_init_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index f7f9ba491b..c6b6faa578 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -58,21 +58,21 @@ static int test_colo_common(MigrateCommon *args,
     migrate_incoming_qmp(to, args->uri, NULL, "{}");
 
     migrate_ensure_converge(from);
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 
     migrate_qmp(from, to, NULL, NULL, "{}");
 
     wait_for_migration_status(from, "colo", NULL);
     wait_for_resume(to, get_dst());
 
-    wait_for_serial("src_serial");
-    wait_for_serial("dest_serial");
+    wait_for_serial(qtest_get_serial_path(from));
+    wait_for_serial(qtest_get_serial_path(to));
 
     /* wait for 3 checkpoints */
     for (int i = 0; i < 3; i++) {
         qtest_qmp_eventwait(to, "RESUME");
-        wait_for_serial("src_serial");
-        wait_for_serial("dest_serial");
+        wait_for_serial(qtest_get_serial_path(from));
+        wait_for_serial(qtest_get_serial_path(to));
     }
 
     if (failover_during_checkpoint) {
@@ -83,13 +83,13 @@ static int test_colo_common(MigrateCommon *args,
                                             "'arguments': {'instances':"
                                                 "[{'type': 'migration'}]}}");
         qtest_qmp_assert_success(from, "{'execute': 'x-colo-lost-heartbeat'}");
-        wait_for_serial("src_serial");
+        wait_for_serial(qtest_get_serial_path(from));
     } else {
         qtest_qmp_assert_success(to, "{'exec-oob': 'yank', 'id': 'yank-cmd', "
                                         "'arguments': {'instances':"
                                             "[{'type': 'migration'}]}}");
         qtest_qmp_assert_success(to, "{'execute': 'x-colo-lost-heartbeat'}");
-        wait_for_serial("dest_serial");
+        wait_for_serial(qtest_get_serial_path(to));
     }
 
     if (args->end_hook) {
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0bec753b4a..f56bbe48fe 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -66,7 +66,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
 
     migrate_set_parameter_str(from, "mode", "cpr-transfer");
 
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 
     qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
     wait_for_stop(from, get_src());
@@ -89,7 +89,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
     qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
 
     wait_for_resume(to, get_dst());
-    wait_for_serial("dest_serial");
+    wait_for_serial(qtest_get_serial_path(to));
 
     migrate_end(from, to, true);
 
@@ -241,7 +241,7 @@ static void test_cpr_exec(MigrateCommon *args)
         data_hook = args->start_hook(from, NULL);
     }
 
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
     set_cpr_exec_args(from, args);
     migrate_set_capability(from, "events", true);
     migrate_qmp(from, NULL, connect_uri, NULL, "{}");
@@ -260,7 +260,7 @@ static void test_cpr_exec(MigrateCommon *args)
 
     wait_for_resume(to, get_dst());
     /* Device on target is still named src_serial because args do not change */
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 
     if (args->end_hook) {
         args->end_hook(from, to, data_hook);
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 305b8968ff..a7dffeb82c 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -58,10 +58,9 @@ static char *tmpfs;
  * we get an 'A' followed by an endless string of 'B's
  * but on the destination we won't have the A (unless we enabled suspend/resume)
  */
-void wait_for_serial(const char *side)
+void wait_for_serial(const char *path)
 {
-    g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
-    FILE *serialfile = fopen(serialpath, "r");
+    FILE *serialfile = fopen(path, "r");
 
     do {
         int readvalue = fgetc(serialfile);
@@ -82,7 +81,7 @@ void wait_for_serial(const char *side)
             break;
 
         default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, path);
             g_assert_not_reached();
         }
     } while (true);
@@ -450,7 +449,12 @@ QTestState *migrate_launch_source(const char *serial_name, MigrateStart *args)
                           false, args, &cmd)) {
         return NULL;
     }
-    return qtest_init_ext(QEMU_ENV_SRC, cmd, capabilities, true);
+    QTestState *s = qtest_init_ext(QEMU_ENV_SRC, cmd, capabilities, true);
+    if (s) {
+        g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, serial_name);
+        qtest_set_serial_path(s, path);
+    }
+    return s;
 }
 
 /*
@@ -466,8 +470,13 @@ QTestState *migrate_launch_dest(const char *serial_name, MigrateStart *args)
                           args->defer_target_connect, args, &cmd)) {
         return NULL;
     }
-    return qtest_init_ext(QEMU_ENV_DST, cmd, capabilities,
-                          !args->defer_target_connect);
+    QTestState *s = qtest_init_ext(QEMU_ENV_DST, cmd, capabilities,
+                                   !args->defer_target_connect);
+    if (s) {
+        g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, serial_name);
+        qtest_set_serial_path(s, path);
+    }
+    return s;
 }
 
 int migrate_args(char **from, char **to, MigrateStart *args)
@@ -595,8 +604,6 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
 
     cleanup("migsocket");
     cleanup("cpr.sock");
-    cleanup("src_serial");
-    cleanup("dest_serial");
     cleanup(FILE_TEST_FILENAME);
 }
 
@@ -631,7 +638,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                              "                'port': '0' } } ] } }");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
     wait_for_suspend(from, &src_state);
 
     migrate_qmp(from, to, NULL, NULL, "{}");
@@ -657,7 +664,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     }
 
     /* Make sure we get at least one "B" on destination */
-    wait_for_serial("dest_serial");
+    wait_for_serial(qtest_get_serial_path(to));
 
     if (env->uffd_feature_thread_id) {
         read_blocktime(to);
@@ -895,7 +902,7 @@ int test_precopy_common(MigrateCommon *args)
 
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
-        wait_for_serial("src_serial");
+        wait_for_serial(qtest_get_serial_path(from));
         wait_for_suspend(from, &src_state);
     }
 
@@ -972,7 +979,7 @@ int test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
         }
 
-        wait_for_serial("dest_serial");
+        wait_for_serial(qtest_get_serial_path(to));
     }
 
 finish:
@@ -1063,7 +1070,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     migrate_ensure_converge(from);
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 
     if (stop_src) {
         qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
@@ -1090,7 +1097,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     }
     wait_for_resume(to, &dst_state);
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(qtest_get_serial_path(to));
 
     if (check_offset) {
         file_check_offset_region();
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index f054ef8f4d..f6936eb8c6 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -227,7 +227,7 @@ typedef struct {
 
 typedef struct QTestMigrationState QTestMigrationState;
 
-void wait_for_serial(const char *side);
+void wait_for_serial(const char *path);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index ec6d438cdc..73750335f1 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -128,7 +128,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     migrate_set_capability(from, "validate-uuid", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 
     migrate_incoming_qmp(to, uri, NULL, "{}");
     migrate_qmp(from, to, uri, NULL, "{}");
@@ -185,7 +185,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     }
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a23d51126b..194462c841 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -282,7 +282,8 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
 
-    wait_for_serial("src_serial");
+    /* Wait for the first serial output from the source */
+    wait_for_serial(qtest_get_serial_path(from));
 
     migrate_incoming_qmp(to, uri, NULL, "{}");
     migrate_qmp(from, to, uri, NULL, "{}");
@@ -317,7 +318,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(qtest_get_serial_path(to));
     wait_for_migration_complete(from);
 
     migrate_end(from, to, true);
@@ -436,7 +437,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 
     migrate_qmp(from, to, NULL, NULL, "{}");
 
@@ -486,7 +487,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     wait_for_stop(from, get_src());
     qtest_qmp_eventwait(to2, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(qtest_get_serial_path(to2));
     wait_for_migration_complete(from);
     migrate_end(from, to2, true);
 }
@@ -510,7 +511,7 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
      * failed state during migrate_qmp().
      */
 
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
     migrate_ensure_converge(from);
 
     migrate_qmp(from, to, uri, NULL, "{}");
@@ -535,7 +536,7 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
 {
     migrate_incoming_qmp(to, uri, NULL, "{}");
 
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
     migrate_ensure_converge(from);
 
     migrate_qmp(from, to, uri, NULL, "{}");
@@ -560,7 +561,7 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
 {
     migrate_incoming_qmp(to, uri, NULL, "{}");
 
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
     migrate_ensure_converge(from);
 
     migrate_qmp(from, to, uri, NULL, "{}");
@@ -586,7 +587,7 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
      */
     migrate_cancel(to);
 
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
     migrate_cancel(from);
 
     migrate_incoming_qmp(to, uri, NULL, "{}");
@@ -610,7 +611,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
 
     migrate_incoming_qmp(to, uri, NULL, "{}");
 
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
     migrate_ensure_converge(from);
 
     migrate_qmp(from, to, uri, NULL, "{}");
@@ -831,7 +832,10 @@ static void test_vcpu_dirty_limit(char *name, MigrateCommon *args)
     vm = dirtylimit_start_vm();
 
     /* Wait for the first serial output from the vm*/
-    wait_for_serial("vm_serial");
+    {
+        g_autofree char *vm_serial = g_strdup_printf("%s/vm_serial", tmpfs);
+        wait_for_serial(vm_serial);
+    }
 
     /* Do dirtyrate measurement with calc time equals 1s */
     calc_dirty_rate(vm, 1);
@@ -924,7 +928,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
     migrate_set_capability(from, "pause-before-switchover", true);
 
     /* Wait for the serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(qtest_get_serial_path(from));
 }
 
 /*
@@ -1062,7 +1066,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(qtest_get_serial_path(to));
     wait_for_migration_complete(from);
 
     migrate_end(from, to, true);
-- 
2.50.1 (Apple Git-155)


