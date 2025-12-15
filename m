Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D886D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfa-00037q-CZ; Mon, 15 Dec 2025 17:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfW-0002an-F2
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:50 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfR-0003Mh-Ob
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:50 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B55965BDEF;
 Mon, 15 Dec 2025 22:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXWTsFpn/V6CcaxTrVtLPSrXypzOKq52f9e40li1sUU=;
 b=xvg2X2GWxeC/wbC0V+hDzI3GQ5H5jBNe3zCpbqJiBZV0oTiTeTDSZUenYjMocG6rtg8UlG
 9E6F+5PieKLYm/BPWfw4mGp1BNFKEM1kjOZLUiln2I04u0GT1TYSdrRfkoIXPAapDx9qWK
 62Z0l94Sakn7TwpT1Qgv/lMkfKmgr08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXWTsFpn/V6CcaxTrVtLPSrXypzOKq52f9e40li1sUU=;
 b=F2cyTkLe8WmsTsfOBZ75XdKN7OnTZzCj7/JjLBAogTHiUZlqFjG3A08LLGmXQIRSa1DVg7
 ZuSuEchVdEp+wWBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXWTsFpn/V6CcaxTrVtLPSrXypzOKq52f9e40li1sUU=;
 b=xvg2X2GWxeC/wbC0V+hDzI3GQ5H5jBNe3zCpbqJiBZV0oTiTeTDSZUenYjMocG6rtg8UlG
 9E6F+5PieKLYm/BPWfw4mGp1BNFKEM1kjOZLUiln2I04u0GT1TYSdrRfkoIXPAapDx9qWK
 62Z0l94Sakn7TwpT1Qgv/lMkfKmgr08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836177;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXWTsFpn/V6CcaxTrVtLPSrXypzOKq52f9e40li1sUU=;
 b=F2cyTkLe8WmsTsfOBZ75XdKN7OnTZzCj7/JjLBAogTHiUZlqFjG3A08LLGmXQIRSa1DVg7
 ZuSuEchVdEp+wWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D6F3EA65;
 Mon, 15 Dec 2025 22:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iL50HI+FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 50/51] tests/qtest/migration: Remove
 migrate_set_capabilities and code around it
Date: Mon, 15 Dec 2025 19:00:36 -0300
Message-ID: <20251215220041.12657-51-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Remove all of the code that sets capabilities via
migrate_set_capabilities. All the users have already been converted to
use the new API.

Also remove all usage of the use-config key. This is not needed
anymore, tests should always pass the config object, even if empty.

The ensure_non_converge and ensure_converge functions don't need the
QTestState parameter anymore because there will be no fallback, the
config will always be used.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c      |  3 -
 tests/qtest/migration/framework.c      | 86 +++-----------------------
 tests/qtest/migration/migration-qmp.c  | 82 +++++-------------------
 tests/qtest/migration/migration-qmp.h  |  4 +-
 tests/qtest/migration/migration-util.c |  1 -
 tests/qtest/migration/migration-util.h | 34 ----------
 tests/qtest/migration/misc-tests.c     | 16 +----
 tests/qtest/migration/precopy-tests.c  | 24 +++----
 8 files changed, 37 insertions(+), 213 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 57199ed3b8..f8c20b9038 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -186,9 +186,6 @@ static void test_cpr_exec(MigrateCommon *args)
                                                 FILE_TEST_FILENAME);
     g_autofree char *channels = NULL;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
         return;
     }
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index f596f1c171..363604031e 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -209,70 +209,21 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
 }
 
 static void migrate_start_set_default_options(MigrateStart *args)
-{
-    if (args->config && qdict_get_bool(args->config, "use-config")) {
-        /*
-         * Always enable migration events. Libvirt always uses it,
-         * let's mimic that.
-         */
-        qdict_put_bool(args->config, "events", true);
-
-        /*
-         * Default number of channels should be fine for most
-         * tests. Individual tests can override by calling
-         * migrate_set_parameter() directly.
-         */
-        if (qdict_get_try_bool(args->config, "multifd", false)) {
-            qdict_put_int(args->config, "multifd-channels",
-                          MULTIFD_TEST_CHANNELS);
-        }
-
-        return;
-    }
-}
-
-static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
-                                           MigrateStart *args)
 {
     /*
-     * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
-     * are from qapi-types-migration.h.
+     * Always enable migration events. Libvirt always uses it,
+     * let's mimic that.
      */
-    for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (!args->caps[i]) {
-            continue;
-        }
-        if (from) {
-            migrate_set_capability(from,
-                            MigrationCapability_lookup.array[i], true);
-        }
-        if (to) {
-            migrate_set_capability(to,
-                            MigrationCapability_lookup.array[i], true);
-        }
-    }
-
-    /*
-     * Always enable migration events.  Libvirt always uses it, let's try
-     * to mimic as closer as that.
-     */
-    migrate_set_capability(from, "events", true);
-    if (!args->defer_target_connect && to) {
-        migrate_set_capability(to, "events", true);
-    }
+    qdict_put_bool(args->config, "events", true);
 
     /*
      * Default number of channels should be fine for most
      * tests. Individual tests can override by calling
      * migrate_set_parameter() directly.
      */
-    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        migrate_set_parameter_int(from, "multifd-channels",
-                                  MULTIFD_TEST_CHANNELS);
-        if (to) {
-            migrate_set_parameter_int(to, "multifd-channels",
-                                      MULTIFD_TEST_CHANNELS);
-        }
+    if (qdict_get_try_bool(args->config, "multifd", false)) {
+        qdict_put_int(args->config, "multifd-channels",
+                      MULTIFD_TEST_CHANNELS);
     }
 
     return;
@@ -429,7 +380,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
      */
     events = args->defer_target_connect ? "-global migration.x-events=on" : "";
 
-    if (!args->incoming_defer && args->config) {
+    if (!args->incoming_defer) {
         QDict *conf = fixup_tls_creds(args->config);
         GString *json = qobject_to_json(QOBJECT(conf));
 
@@ -512,11 +463,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
-    args->config = config_load(args->config);
     if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
         return -1;
     }
-    config_put(args->config);
 
     if (!args->only_target) {
         *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
@@ -534,9 +483,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     }
 
     migrate_mem_type_cleanup(args->mem_type);
-    migrate_start_set_capabilities(*from,
-                                   args->only_source ? NULL : *to,
-                                   args);
 
     return 0;
 }
@@ -598,7 +544,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                                                     args->start_hook_data);
     }
 
-    migrate_ensure_non_converge(from, args->start.config);
+    migrate_ensure_non_converge(args->start.config);
     migrate_prepare_for_dirty_mem(from);
 
     channels = qobject_from_json("[ { 'channel-type': 'main',"
@@ -654,9 +600,6 @@ void test_postcopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     if (migrate_postcopy_prepare(&from, &to, args)) {
         return;
     }
@@ -790,9 +733,6 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     QTestState *from, *to;
     g_autofree char *uri = NULL;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     /*
      * Always enable OOB QMP capability for recovery tests, migrate-recover is
      * executed out-of-band
@@ -868,9 +808,6 @@ int test_precopy_common(MigrateCommon *args)
     QObject *in_channels = NULL;
     QObject *out_channels = NULL;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     g_assert(!args->cpr_channel || args->connect_channels);
     if (args->start.incoming_defer) {
         g_assert(args->listen_uri || args->connect_channels);
@@ -906,7 +843,7 @@ int test_precopy_common(MigrateCommon *args)
     }
 
     if (args->live) {
-        migrate_ensure_non_converge(from, args->start.config);
+        migrate_ensure_non_converge(args->start.config);
         migrate_prepare_for_dirty_mem(from);
     } else {
         /*
@@ -1059,9 +996,6 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     void *data_hook = NULL;
     bool check_offset = false;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
@@ -1089,7 +1023,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
         data_hook = args->start_hook_full(from, to, args->start_hook_data);
     }
 
-    migrate_ensure_converge(from, args->start.config);
+    migrate_ensure_converge(args->start.config);
     wait_for_serial("src_serial");
 
     if (stop_src) {
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index a4dde029ee..a9edc793cd 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -96,11 +96,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
         qdict_put_obj(args, "channels", channels);
     }
 
-    config = config_load(config);
-    if (config) {
-        qdict_put_obj(args, "config", QOBJECT(config));
-        qobject_ref(config);
-    }
+    qdict_put_obj(args, "config", QOBJECT(config));
+    qobject_ref(config);
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
@@ -108,7 +105,6 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
     g_assert(qdict_haskey(err, "desc"));
 
     qobject_unref(err);
-    config_put(config);
 }
 
 /*
@@ -142,26 +138,11 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
         qdict_put_obj(args, "channels", channels);
     }
 
-    config = config_load(config);
-    if (config) {
-        qdict_put_obj(args, "config", QOBJECT(config));
-        qobject_ref(config);
-    }
+    qdict_put_obj(args, "config", QOBJECT(config));
+    qobject_ref(config);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
-    config_put(config);
-}
-
-void migrate_set_capability(QTestState *who, const char *capability,
-                            bool value)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate-set-capabilities',"
-                             "'arguments': { "
-                             "'capabilities': [ { "
-                             "'capability': %s, 'state': %i } ] } }",
-                             capability, value);
 }
 
 void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
@@ -185,13 +166,10 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
     }
 
     /* This function relies on the event to work, make sure it's enabled */
-    migrate_set_capability(to, "events", true);
+    qdict_put_bool(config, "events", true);
 
-    config = config_load(config);
-    if (config) {
-        qdict_put_obj(args, "config", QOBJECT(config));
-        qobject_ref(config);
-    }
+    qdict_put_obj(args, "config", QOBJECT(config));
+    qobject_ref(config);
 
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
                     args);
@@ -205,7 +183,6 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
     qobject_unref(rsp);
 
     migration_event_wait(to, "setup");
-    config_put(config);
 }
 
 static bool check_migration_status(QTestState *who, const char *goal,
@@ -463,22 +440,6 @@ void migrate_set_parameter_str(QTestState *who, const char *parameter,
     migrate_check_parameter_str(who, parameter, value);
 }
 
-void migrate_set_parameter_strv(QTestState *who, const char *parameter,
-                                char **strv)
-{
-    g_autofree char *args = g_strjoinv("\",\"", strv);
-    g_autoptr(GString) value = g_string_new("");
-    g_autofree char *command = NULL;
-
-    g_string_printf(value, "\"%s\"", args);
-
-    command = g_strdup_printf("{ 'execute': 'migrate-set-parameters',"
-                              "'arguments': { %%s: [ %s ]}}",
-                              value->str);
-
-    qtest_qmp_assert_success(who, command, parameter);
-}
-
 void migrate_set_parameter_null(QTestState *who, const char *parameter)
 {
     qtest_qmp_assert_success(who,
@@ -534,32 +495,17 @@ void migrate_ongoing_ensure_converge(QTestState *who)
     migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
 }
 
-void migrate_ensure_non_converge(QTestState *who, QDict *config)
+void migrate_ensure_non_converge(QDict *config)
 {
-    config = config_load(config);
-    if (config) {
-        /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
-        qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
-        qdict_put_int(config, "downtime-limit", 1);
-    } else {
-        assert(who);
-        migrate_ongoing_ensure_non_converge(who);
-    }
-    config_put(config);
+    /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
+    qdict_put_int(config, "max-bandwidth", 3 * 1000 * 1000);
+    qdict_put_int(config, "downtime-limit", 1);
 }
 
-void migrate_ensure_converge(QTestState *who, QDict *config)
+void migrate_ensure_converge(QDict *config)
 {
-    config = config_load(config);
-    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
-    if (config) {
-        qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
-        qdict_put_int(config, "downtime-limit", 30 * 1000);
-    } else {
-        assert(who);
-        migrate_ongoing_ensure_converge(who);
-    }
-    config_put(config);
+    qdict_put_int(config, "max-bandwidth", 1 * 1000 * 1000 * 1000);
+    qdict_put_int(config, "downtime-limit", 30 * 1000);
 }
 
 void migrate_pause(QTestState *who)
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index 7daeb913fa..da0d99af59 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -42,8 +42,8 @@ void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                 int value);
 void migrate_ongoing_ensure_non_converge(QTestState *who);
 void migrate_ongoing_ensure_converge(QTestState *who);
-void migrate_ensure_non_converge(QTestState *who, QDict *config);
-void migrate_ensure_converge(QTestState *who, QDict *config);
+void migrate_ensure_non_converge(QDict *config);
+void migrate_ensure_converge(QDict *config);
 void migrate_pause(QTestState *who);
 void migrate_continue(QTestState *who, const char *state);
 void migrate_recover(QTestState *who, const char *uri);
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index efe1ae25de..c6f5ae3cb1 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -255,7 +255,6 @@ static void migration_test_wrapper(const void *data)
 
     test->data = g_new0(MigrateCommon, 1);
     test->data->start.config = qdict_new();
-    qdict_put_bool(test->data->start.config, "use-config", false);
 
     g_test_message("Running /%s%s", qtest_get_arch(), test->name);
     test->func(test->name, test->data);
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index ec58868197..da523fb2f7 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -61,38 +61,4 @@ char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
 QDict *fixup_tls_creds(QDict *config);
 
-/*
- * Scaffolding to allow the framework _common functions and _qmp
- * functions to use the config object while some tests are still using
- * migrate_set_*. Tests that have been converted will set use-config =
- * true on the config dict.
- */
-static bool has_key;
-static bool use_config;
-static inline QDict *config_load(QDict *config)
-{
-    if (!config) {
-        return NULL;
-    }
-
-    has_key = qdict_haskey(config, "use-config");
-    if (has_key) {
-        use_config = qdict_get_try_bool(config, "use-config", false);
-        qdict_del(config, "use-config");
-    }
-
-    if (use_config) {
-        return config;
-    }
-
-    return NULL;
-}
-
-static inline void config_put(QDict *config)
-{
-    if (config && has_key) {
-        qdict_put_bool(config, "use-config", use_config);
-    }
-}
-
 #endif /* MIGRATION_UTIL_H */
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 7e38d26ab2..4bac7fff41 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -28,9 +28,6 @@ static void test_baddest(char *name, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
         return;
     }
@@ -55,9 +52,6 @@ static void test_analyze_script(char *name, MigrateCommon *args)
         return;
     }
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     /* dummy url */
     if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
         return;
@@ -74,7 +68,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
     file = g_strdup_printf("%s/migfile", tmpfs);
     uri = g_strdup_printf("exec:cat > %s", file);
 
-    migrate_ensure_converge(from, args->start.config);
+    migrate_ensure_converge(args->start.config);
     migrate_qmp(from, to, uri, NULL, args->start.config, "{}");
     wait_for_migration_complete(from);
 
@@ -103,16 +97,13 @@ static void test_ignore_shared(char *name, MigrateCommon *args)
 
     args->start.mem_type = MEM_TYPE_SHMEM;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     qdict_put_bool(args->start.config, "x-ignore-shared", true);
 
     if (migrate_start(&from, &to, uri, &args->start)) {
         return;
     }
 
-    migrate_ensure_non_converge(from, args->start.config);
+    migrate_ensure_non_converge(args->start.config);
     migrate_prepare_for_dirty_mem(from);
 
     /* Wait for the first serial output from the source */
@@ -141,9 +132,6 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    /* temporary */
-    qdict_put_bool(args->config, "use-config", true);
-
     if (migrate_start(&from, &to, uri, args)) {
         return;
     }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index f8f46322bc..bb96cbb56f 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -374,7 +374,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
      * Set the initial parameters so that the migration could not converge
      * without throttling.
      */
-    migrate_ensure_non_converge(from, args->start.config);
+    migrate_ensure_non_converge(args->start.config);
 
     /* To check remaining size after precopy */
     qdict_put_bool(args->start.config, "pause-before-switchover", true);
@@ -536,9 +536,6 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
 {
     QTestState *from, *to, *to2;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     args->start.hide_stderr = true;
     args->start.incoming_defer = true;
 
@@ -546,7 +543,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
         return;
     }
 
-    migrate_ensure_non_converge(from, args->start.config);
+    migrate_ensure_non_converge(args->start.config);
     migrate_prepare_for_dirty_mem(from);
 
     if (postcopy_ram) {
@@ -598,7 +595,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, args->start.config,
                          "{}");
 
-    migrate_ensure_non_converge(from, args->start.config);
+    migrate_ensure_non_converge(args->start.config);
 
     migrate_qmp(from, to2, NULL, NULL, args->start.config, "{}");
 
@@ -632,7 +629,7 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
      */
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from, args->config);
+    migrate_ensure_converge(args->config);
 
     migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
@@ -658,7 +655,7 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
                          "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from, args->config);
+    migrate_ensure_converge(args->config);
 
     migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
@@ -684,7 +681,7 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
                          "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from, args->config);
+    migrate_ensure_converge(args->config);
 
     migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
@@ -715,7 +712,7 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
     migrate_incoming_qmp(to, uri, NULL, args->config,
                          "{ 'exit-on-error': false }");
 
-    migrate_ensure_converge(from, args->config);
+    migrate_ensure_converge(args->config);
     migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
     wait_for_migration_complete(from);
@@ -730,7 +727,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
                          "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
-    migrate_ensure_converge(from, args->config);
+    migrate_ensure_converge(args->config);
 
     migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
@@ -751,9 +748,6 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     args->start.hide_stderr = true;
     args->start.incoming_defer = true;
 
@@ -1103,7 +1097,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     }
 
     /* Prepare for dirty limit migration and wait src vm show up */
-    migrate_ensure_non_converge(from, args->start.config);
+    migrate_ensure_non_converge(args->start.config);
     migrate_dirty_limit_wait_showup(args->start.config, dirtylimit_period,
                                     dirtylimit_value);
 
-- 
2.51.0


