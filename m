Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44882C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKgW-0005gH-Bn; Mon, 30 Jun 2025 16:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKgN-0005P3-O9
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKgL-0007ns-A6
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DC3121169;
 Mon, 30 Jun 2025 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8MF+wD18+4fRDDS0/kCDVD6uI4fVXKX+iEWE73RBPk=;
 b=uQ2+W4x9AzoPRZb6gKlPqShn4nwgFhVfQ8Y0hiPiJh1kKSB80x23W7fS8QRXH39muTcK6X
 n+3BPhtu23R7RIKQxm8kXisdo2JIPLlrxNNRyOAZ4zREWFIbU3KGlWA0sstem+PX7YJERB
 le+CHFv2So6GKCMndduCXi5PBu+rlAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8MF+wD18+4fRDDS0/kCDVD6uI4fVXKX+iEWE73RBPk=;
 b=Qqx8eXwZHi9k4s7xoVM7lIpWh6Cxs56xe4TrBo4UPuGhvMmLzuapj7fnsYRFhlMtP1f879
 5Sm3KhSC5aWBAXDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8MF+wD18+4fRDDS0/kCDVD6uI4fVXKX+iEWE73RBPk=;
 b=uQ2+W4x9AzoPRZb6gKlPqShn4nwgFhVfQ8Y0hiPiJh1kKSB80x23W7fS8QRXH39muTcK6X
 n+3BPhtu23R7RIKQxm8kXisdo2JIPLlrxNNRyOAZ4zREWFIbU3KGlWA0sstem+PX7YJERB
 le+CHFv2So6GKCMndduCXi5PBu+rlAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313609;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8MF+wD18+4fRDDS0/kCDVD6uI4fVXKX+iEWE73RBPk=;
 b=Qqx8eXwZHi9k4s7xoVM7lIpWh6Cxs56xe4TrBo4UPuGhvMmLzuapj7fnsYRFhlMtP1f879
 5Sm3KhSC5aWBAXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 904CB1399F;
 Mon, 30 Jun 2025 20:00:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YFxwFMfsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 20:00:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 23/24] tests/qtest/migration: Adapt convergence routines to
 config
Date: Mon, 30 Jun 2025 16:59:12 -0300
Message-Id: <20250630195913.28033-24-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Adapt the convergence routines migrate_ensure_[non_]converge to
receive a config argument and set the convergence parameters in it
instead of using migrate-set-parameters.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c     | 10 +++++-----
 tests/qtest/migration/migration-qmp.c | 22 ++++++++++++++++------
 tests/qtest/migration/migration-qmp.h |  4 ++--
 tests/qtest/migration/misc-tests.c    |  4 ++--
 tests/qtest/migration/precopy-tests.c | 22 +++++++++++-----------
 5 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 9ff5576328..5025299d6a 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -513,7 +513,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         args->postcopy_data = args->start_hook(from, to);
     }
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args->start.config);
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { "
@@ -791,7 +791,7 @@ void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->live) {
-        migrate_ensure_non_converge(from);
+        migrate_ensure_non_converge(from, args->start.config);
         migrate_prepare_for_dirty_mem(from);
     } else {
         /*
@@ -803,7 +803,7 @@ void test_precopy_common(MigrateCommon *args)
         if (args->result == MIG_TEST_SUCCEED) {
             qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
             wait_for_stop(from, &src_state);
-            migrate_ensure_converge(from);
+            migrate_ensure_converge(from, args->start.config);
         }
     }
 
@@ -862,7 +862,7 @@ void test_precopy_common(MigrateCommon *args)
             }
             migrate_wait_for_dirty_mem(from, to);
 
-            migrate_ensure_converge(from);
+            migrate_ensure_converge(from, args->start.config);
 
             /*
              * We do this first, as it has a timeout to stop us
@@ -965,7 +965,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
         data_hook = args->start_hook(from, to);
     }
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->start.config);
     wait_for_serial("src_serial");
 
     if (stop_src) {
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index d82ac8c750..8918ce87d8 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -471,18 +471,28 @@ void migrate_set_parameter_bool(QTestState *who, const char *parameter,
     migrate_check_parameter_bool(who, parameter, value);
 }
 
-void migrate_ensure_non_converge(QTestState *who)
+void migrate_ensure_non_converge(QTestState *who, QDict *config)
 {
     /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
-    migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
-    migrate_set_parameter_int(who, "downtime-limit", 1);
+    if (config) {
+        qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
+        qdict_put_int(config, "downtime-limit", 1);
+    } else {
+        migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
+        migrate_set_parameter_int(who, "downtime-limit", 1);
+    }
 }
 
-void migrate_ensure_converge(QTestState *who)
+void migrate_ensure_converge(QTestState *who, QDict *config)
 {
     /* Should converge with 30s downtime + 1 gbs bandwidth limit */
-    migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
-    migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
+    if (config) {
+        qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
+        qdict_put_int(config, "downtime-limit", 30 * 1000);
+    } else {
+        migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
+        migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
+    }
 }
 
 void migrate_pause(QTestState *who)
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index faa8181d91..a80546a258 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -36,8 +36,8 @@ void migrate_set_parameter_str(QTestState *who, const char *parameter,
                                const char *value);
 void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                 int value);
-void migrate_ensure_non_converge(QTestState *who);
-void migrate_ensure_converge(QTestState *who);
+void migrate_ensure_non_converge(QTestState *who, QDict *config);
+void migrate_ensure_converge(QTestState *who, QDict *config);
 void migrate_pause(QTestState *who);
 void migrate_continue(QTestState *who, const char *state);
 void migrate_recover(QTestState *who, const char *uri);
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 54995256d8..abbbf966e9 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -70,7 +70,7 @@ static void test_analyze_script(void)
     file = g_strdup_printf("%s/migfile", tmpfs);
     uri = g_strdup_printf("exec:cat > %s", file);
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args.config);
     migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
@@ -105,7 +105,7 @@ static void test_ignore_shared(void)
         return;
     }
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args.config);
     migrate_prepare_for_dirty_mem(from);
 
     /* Wait for the first serial output from the source */
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index bb38292550..35d4274c69 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -387,7 +387,7 @@ static void test_auto_converge(void)
      * Set the initial parameters so that the migration could not converge
      * without throttling.
      */
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args.config);
 
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
@@ -440,7 +440,7 @@ static void test_auto_converge(void)
     g_assert_cmpint(hit, ==, 1);
 
     /* Now, when we tested that throttling works, let it converge */
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args.config);
 
     /*
      * Wait for pre-switchover status to check last throttle percentage
@@ -580,7 +580,7 @@ static void test_multifd_tcp_cancel(bool postcopy_ram)
         return;
     }
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args.config);
     migrate_prepare_for_dirty_mem(from);
 
     if (postcopy_ram) {
@@ -640,13 +640,13 @@ static void test_multifd_tcp_cancel(bool postcopy_ram)
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args.config);
 
     migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args.config);
 
     wait_for_stop(from, get_src());
     qtest_qmp_eventwait(to2, "RESUME");
@@ -675,7 +675,7 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
      */
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, NULL);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -699,7 +699,7 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, NULL);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -723,7 +723,7 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, NULL);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -752,7 +752,7 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
 
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, NULL);
     migrate_qmp(from, to, uri, NULL, "{}");
 
     wait_for_migration_complete(from);
@@ -771,7 +771,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, NULL);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -1080,7 +1080,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
     migrate_set_parameter_int(from, "vcpu-dirty-limit", value);
 
     /* Make sure migrate can't converge */
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, NULL);
 
     /* To check limit rate after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
-- 
2.35.3


