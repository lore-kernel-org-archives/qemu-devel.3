Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D4FD5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfR-0001p8-AX; Mon, 15 Dec 2025 17:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfA-0001Dl-LR
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:28 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGf8-00039g-FX
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5D68337EC;
 Mon, 15 Dec 2025 22:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaqejw6QbIIEISnVqLiykhW4s8zVxq/A8MJRBb+rqF4=;
 b=hRhtyCONM0HgWmLN2y2u5KHLnm3RL0Nui/rPeajv/Z3e0o6p/aqNs71xmv6l3njThl9HwY
 TOJqk1646IqEjDHBqTFaWBGWNABr8PrKuDAo+mJjWlLHTAILQM6qEPUVz8kxNCzXawg30o
 mkxbc5u8D/jCNMHlAUm3J+kRjoiSuZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaqejw6QbIIEISnVqLiykhW4s8zVxq/A8MJRBb+rqF4=;
 b=62ly6vQiEfB4xe5c0+UCJR8FIih5qzsIWh+pXxM9GdcWohdShLclsbx9X6n6j13r1dJJmL
 AWVJtJWleG7CTzAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaqejw6QbIIEISnVqLiykhW4s8zVxq/A8MJRBb+rqF4=;
 b=hRhtyCONM0HgWmLN2y2u5KHLnm3RL0Nui/rPeajv/Z3e0o6p/aqNs71xmv6l3njThl9HwY
 TOJqk1646IqEjDHBqTFaWBGWNABr8PrKuDAo+mJjWlLHTAILQM6qEPUVz8kxNCzXawg30o
 mkxbc5u8D/jCNMHlAUm3J+kRjoiSuZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaqejw6QbIIEISnVqLiykhW4s8zVxq/A8MJRBb+rqF4=;
 b=62ly6vQiEfB4xe5c0+UCJR8FIih5qzsIWh+pXxM9GdcWohdShLclsbx9X6n6j13r1dJJmL
 AWVJtJWleG7CTzAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF9183EA63;
 Mon, 15 Dec 2025 22:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLJFJ3eFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 41/51] tests/qtest/migration: TLS PSK: Add init/cleanup
 routines
Date: Mon, 15 Dec 2025 19:00:27 -0300
Message-ID: <20251215220041.12657-42-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Move TLS PSK setup and cleanup into a common function instead of using
hooks. Hooks are for when the test needs to access the QTestState.

This primarily moves setup of TLS PSK tests from ->start_hook time
earlier into test function call time, which brings the migrate_set_*
calls within earlier, where they can be replaced in subsequent patches
with the new config setup.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 149 +++++++++++++++++-------------
 1 file changed, 83 insertions(+), 66 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 2eeed1fc5b..aade57f7de 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -23,12 +23,12 @@
 #endif /* CONFIG_TASN1 */
 
 
-struct TestMigrateTLSPSKData {
+typedef struct {
     char *workdir;
     char *workdiralt;
     char *pskfile;
     char *pskfilealt;
-};
+} TestMigrateTLSPSKData;
 
 typedef struct {
     bool mismatch;
@@ -44,59 +44,62 @@ static TestMigrateTLSPSK tls_psk_mismatch = {
 
 static char *tmpfs;
 
-static void *
-migrate_hook_start_tls_psk_common(QTestState *from,
-                                  QTestState *to,
-                                  void *opaque)
+static void *migrate_hook_start_tls_psk_common(QTestState *from,
+                                               QTestState *to,
+                                               void *opaque)
 {
     TestMigrateTLSPSK *args = opaque;
-    struct TestMigrateTLSPSKData *data =
-        g_new0(struct TestMigrateTLSPSKData, 1);
+    g_autofree char *workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
+    g_autofree char *workdiralt = NULL;
 
+    if (args->mismatch) {
+        workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
+    }
+
+    qtest_qmp_assert_success(from,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
+                             "                 'id': 'tlscredspsk0',"
+                             "                 'endpoint': 'client',"
+                             "                 'dir': %s,"
+                             "                 'username': 'qemu'} }",
+                             workdir);
+
+    qtest_qmp_assert_success(to,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
+                             "                 'id': 'tlscredspsk0',"
+                             "                 'endpoint': 'server',"
+                             "                 'dir': %s } }",
+                             args->mismatch ? workdiralt : workdir);
+
+    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
+    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
+
+    return NULL;
+}
+
+static void migrate_tls_psk_init(MigrateCommon *args,
+                                 TestMigrateTLSPSK *test_args,
+                                 TestMigrateTLSPSKData *data)
+{
     data->workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
     data->pskfile = g_strdup_printf("%s/%s", data->workdir,
                                     QCRYPTO_TLS_CREDS_PSKFILE);
     g_mkdir_with_parents(data->workdir, 0700);
     test_tls_psk_init(data->pskfile);
 
-    if (args->mismatch) {
+    if (test_args->mismatch) {
         data->workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
         data->pskfilealt = g_strdup_printf("%s/%s", data->workdiralt,
                                            QCRYPTO_TLS_CREDS_PSKFILE);
         g_mkdir_with_parents(data->workdiralt, 0700);
         test_tls_psk_init_alt(data->pskfilealt);
     }
-
-    qtest_qmp_assert_success(from,
-                             "{ 'execute': 'object-add',"
-                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
-                             "                 'id': 'tlscredspsk0',"
-                             "                 'endpoint': 'client',"
-                             "                 'dir': %s,"
-                             "                 'username': 'qemu'} }",
-                             data->workdir);
-
-    qtest_qmp_assert_success(to,
-                             "{ 'execute': 'object-add',"
-                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
-                             "                 'id': 'tlscredspsk0',"
-                             "                 'endpoint': 'server',"
-                             "                 'dir': %s } }",
-                             args->mismatch ? data->workdiralt : data->workdir);
-
-    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
-    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
-
-    return data;
 }
 
-static void
-migrate_hook_end_tls_psk(QTestState *from,
-                         QTestState *to,
-                         void *opaque)
+static void migrate_tls_psk_cleanup(TestMigrateTLSPSKData *data)
 {
-    struct TestMigrateTLSPSKData *data = opaque;
-
     test_tls_psk_cleanup(data->pskfile);
     if (data->pskfilealt) {
         test_tls_psk_cleanup(data->pskfilealt);
@@ -113,6 +116,36 @@ migrate_hook_end_tls_psk(QTestState *from,
     g_free(data);
 }
 
+static void test_precopy_tls_psk_common(MigrateCommon *args,
+                                        TestMigrateTLSPSK *test_args)
+{
+    TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
+
+    migrate_tls_psk_init(args, test_args, data);
+    test_precopy_common(args);
+    migrate_tls_psk_cleanup(data);
+}
+
+static void test_postcopy_tls_psk_common(MigrateCommon *args,
+                                        TestMigrateTLSPSK *test_args)
+{
+    TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
+
+    migrate_tls_psk_init(args, test_args, data);
+    test_postcopy_common(args);
+    migrate_tls_psk_cleanup(data);
+}
+
+static void test_postcopy_recovery_tls_psk_common(MigrateCommon *args,
+                                                  TestMigrateTLSPSK *test_args)
+{
+    TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
+
+    migrate_tls_psk_init(args, test_args, data);
+    test_postcopy_recovery_common(args);
+    migrate_tls_psk_cleanup(data);
+}
+
 #ifdef CONFIG_TASN1
 typedef struct {
     char *workdir;
@@ -340,29 +373,26 @@ static void test_postcopy_tls_psk(char *name, MigrateCommon *args)
 {
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_postcopy_common(args);
+    test_postcopy_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_postcopy_preempt_tls_psk(char *name, MigrateCommon *args)
 {
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_common(args);
+    test_postcopy_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
 {
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_multifd_postcopy_recovery_tls_psk(char *name,
@@ -370,11 +400,10 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
 {
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
 
 /* This contains preempt+recovery+tls test altogether */
@@ -382,11 +411,10 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 {
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
@@ -394,12 +422,11 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
 {
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
@@ -410,9 +437,8 @@ static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
     args->listen_uri = uri;
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_precopy_common(args);
+    test_precopy_tls_psk_common(args, &tls_psk_match);
 }
 
 #ifdef CONFIG_TASN1
@@ -451,9 +477,8 @@ static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_precopy_common(args);
+    test_precopy_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
@@ -461,30 +486,25 @@ static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_mismatch;
-    args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_psk_common(args, &tls_psk_mismatch);
 }
 
 static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
 {
-    struct TestMigrateTLSPSKData *data =
-        g_new0(struct TestMigrateTLSPSKData, 1);
-
     migrate_set_parameter_null(from, "tls-creds");
     migrate_set_parameter_null(to, "tls-creds");
 
-    return data;
+    return NULL;
 }
 
 static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_no_tls;
-    args->end_hook = migrate_hook_end_tls_psk;
 
     test_precopy_common(args);
 }
@@ -657,19 +677,17 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
-    args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
     args->listen_uri = "tcp:127.0.0.1:0";
 
@@ -677,21 +695,20 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_psk_common(args, &tls_psk_mismatch);
 }
 
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
-    args->end_hook = migrate_hook_end_tls_psk;
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_psk_common(args, &tls_psk_match);
 }
 
 #ifdef CONFIG_TASN1
-- 
2.51.0


