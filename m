Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACDFD5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGet-0006x2-39; Mon, 15 Dec 2025 17:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeb-0005k4-0u
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:58 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeY-0002xy-Ji
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3CF495BDE8;
 Mon, 15 Dec 2025 22:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRWqTnAE7it0GUM5I0KBnogUWKEuhBCSO7OZNyfngIg=;
 b=seTVREg9j5T6uzy3baz9AnuZ4UKDoXG438aYh9rbAPC91ZM8qdjF8ak4xcUXGt8rxGn3qL
 lacuaTwlP2Z46I2lo5Qrsic8eVbEtPuV0/2DHdvqT86xVXkZMU6Ah7m59cOF+HgjAmrDgT
 QDghwYeIWP+PP44/yy0Gj6g3BkPa+dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRWqTnAE7it0GUM5I0KBnogUWKEuhBCSO7OZNyfngIg=;
 b=8rxzPKQIdQrqU3eOWZVrLgUYoh4BVrn8LQ8IcMi6LtzLPlSAxYvRpNeFSRbUhgjnbg9X6y
 JX32loboXxRKsXCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uA+B539S;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RzmNTRH3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRWqTnAE7it0GUM5I0KBnogUWKEuhBCSO7OZNyfngIg=;
 b=uA+B539SluDJ33PyQka5uznaVaXNyyOfKUJB+oSv9oMsnUwjRYgtu+U18e4KlzDaDDv6QL
 5386MinkAOni7saUZONHq9dv8C6ICAAPU6NIZeyIk2R0P8chqnbsd7NHLJd38shASehXR2
 kKECb2oPjR9LbS5TlVmASMdrQ6OjDHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRWqTnAE7it0GUM5I0KBnogUWKEuhBCSO7OZNyfngIg=;
 b=RzmNTRH3caFKObHPehYm5g3eIt52pnOdWJ9PRg3OK98z63PJdPABIUK0I+S7SZrBarL6ut
 NRVdSBRd0L6hgtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15ADF3EA63;
 Mon, 15 Dec 2025 22:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4BZVMV+FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 32/51] tests/qtest/migration: Adapt convergence routines to
 config
Date: Mon, 15 Dec 2025 19:00:18 -0300
Message-ID: <20251215220041.12657-33-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3CF495BDE8
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Adapt the convergence routines migrate_ensure_[non_]converge to set
the convergence parameters in the config dict it instead of using
migrate-set-parameters.

Some tests need to change the convergence parameters during the
migration. The config object method is specific to configuration prior
to starting a migration, so by design it's not suitable to effect
migration-runtime changes. The existing routines will be kept for this
purpose (renamed with 'ongoing' for clarity).

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c     | 10 ++++-----
 tests/qtest/migration/migration-qmp.c | 32 +++++++++++++++++++++++++--
 tests/qtest/migration/migration-qmp.h |  6 +++--
 tests/qtest/migration/misc-tests.c    |  4 ++--
 tests/qtest/migration/precopy-tests.c | 26 +++++++++-------------
 5 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index fd15bd832e..df42a8a2c6 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -583,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         args->postcopy_data = args->start_hook(from, to);
     }
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args->start.config);
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { "
@@ -872,7 +872,7 @@ int test_precopy_common(MigrateCommon *args)
     }
 
     if (args->live) {
-        migrate_ensure_non_converge(from);
+        migrate_ensure_non_converge(from, args->start.config);
         migrate_prepare_for_dirty_mem(from);
     } else {
         /*
@@ -884,7 +884,7 @@ int test_precopy_common(MigrateCommon *args)
         if (args->result == MIG_TEST_SUCCEED) {
             qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
             wait_for_stop(from, &src_state);
-            migrate_ensure_converge(from);
+            migrate_ongoing_ensure_converge(from);
         }
     }
 
@@ -942,7 +942,7 @@ int test_precopy_common(MigrateCommon *args)
             }
             migrate_wait_for_dirty_mem(from, to);
 
-            migrate_ensure_converge(from);
+            migrate_ongoing_ensure_converge(from);
 
             /*
              * We do this first, as it has a timeout to stop us
@@ -1047,7 +1047,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
         data_hook = args->start_hook(from, to);
     }
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->start.config);
     wait_for_serial("src_serial");
 
     if (stop_src) {
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 5c46ceb3e6..7fe47a5793 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -499,20 +499,48 @@ void migrate_set_parameter_bool(QTestState *who, const char *parameter,
     migrate_check_parameter_bool(who, parameter, value);
 }
 
-void migrate_ensure_non_converge(QTestState *who)
+void migrate_ongoing_ensure_non_converge(QTestState *who)
 {
     /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
     migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
     migrate_set_parameter_int(who, "downtime-limit", 1);
 }
 
-void migrate_ensure_converge(QTestState *who)
+void migrate_ongoing_ensure_converge(QTestState *who)
 {
     /* Should converge with 30s downtime + 1 gbs bandwidth limit */
     migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
     migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
 }
 
+void migrate_ensure_non_converge(QTestState *who, QDict *config)
+{
+    config = config_load(config);
+    if (config) {
+        /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
+        qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
+        qdict_put_int(config, "downtime-limit", 1);
+    } else {
+        assert(who);
+        migrate_ongoing_ensure_non_converge(who);
+    }
+    config_put(config);
+}
+
+void migrate_ensure_converge(QTestState *who, QDict *config)
+{
+    config = config_load(config);
+    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
+    if (config) {
+        qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
+        qdict_put_int(config, "downtime-limit", 30 * 1000);
+    } else {
+        assert(who);
+        migrate_ongoing_ensure_converge(who);
+    }
+    config_put(config);
+}
+
 void migrate_pause(QTestState *who)
 {
     qtest_qmp_assert_success(who, "{ 'execute': 'migrate-pause' }");
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index 9a36a677ba..e465c69094 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -39,8 +39,10 @@ void migrate_set_parameter_strv(QTestState *who, const char *parameter,
 void migrate_set_parameter_null(QTestState *who, const char *parameter);
 void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                 int value);
-void migrate_ensure_non_converge(QTestState *who);
-void migrate_ensure_converge(QTestState *who);
+void migrate_ongoing_ensure_non_converge(QTestState *who);
+void migrate_ongoing_ensure_converge(QTestState *who);
+void migrate_ensure_non_converge(QTestState *who, QDict *config);
+void migrate_ensure_converge(QTestState *who, QDict *config);
 void migrate_pause(QTestState *who);
 void migrate_continue(QTestState *who, const char *state);
 void migrate_recover(QTestState *who, const char *uri);
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 61bdfda857..0a737cb54f 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -68,7 +68,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
     file = g_strdup_printf("%s/migfile", tmpfs);
     uri = g_strdup_printf("exec:cat > %s", file);
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->start.config);
     migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
@@ -102,7 +102,7 @@ static void test_ignore_shared(char *name, MigrateCommon *args)
         return;
     }
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args->start.config);
     migrate_prepare_for_dirty_mem(from);
 
     /* Wait for the first serial output from the source */
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ab5789717f..eabbbf39c3 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -374,7 +374,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
      * Set the initial parameters so that the migration could not converge
      * without throttling.
      */
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args->start.config);
 
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
@@ -427,7 +427,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     g_assert_cmpint(hit, ==, 1);
 
     /* Now, when we tested that throttling works, let it converge */
-    migrate_ensure_converge(from);
+    migrate_ongoing_ensure_converge(from);
 
     /*
      * Wait for pre-switchover status to check last throttle percentage
@@ -562,7 +562,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
         return;
     }
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args->start.config);
     migrate_prepare_for_dirty_mem(from);
 
     if (postcopy_ram) {
@@ -623,14 +623,12 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
 
-    migrate_ensure_non_converge(from);
+    migrate_ensure_non_converge(from, args->start.config);
 
     migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
-
-    migrate_ensure_converge(from);
-
+    migrate_ongoing_ensure_converge(from);
     wait_for_stop(from, get_src());
     qtest_qmp_eventwait(to2, "RESUME");
 
@@ -659,7 +657,7 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
      */
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->config);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -684,7 +682,7 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->config);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -709,7 +707,7 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->config);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -739,7 +737,7 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
 
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->config);
     migrate_qmp(from, to, uri, NULL, "{}");
 
     wait_for_migration_complete(from);
@@ -759,7 +757,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
     migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from);
+    migrate_ensure_converge(from, args->config);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -1066,9 +1064,6 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
     migrate_set_parameter_int(from, "x-vcpu-dirty-limit-period", period);
     migrate_set_parameter_int(from, "vcpu-dirty-limit", value);
 
-    /* Make sure migrate can't converge */
-    migrate_ensure_non_converge(from);
-
     /* To check limit rate after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
 
@@ -1128,6 +1123,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     }
 
     /* Prepare for dirty limit migration and wait src vm show up */
+    migrate_ensure_non_converge(from, args->start.config);
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-- 
2.51.0


