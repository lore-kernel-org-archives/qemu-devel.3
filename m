Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBAED5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfX-0002kP-MY; Mon, 15 Dec 2025 17:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfV-0002Ww-Rn
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:49 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfT-0003OG-3M
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:49 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 583BC33748;
 Mon, 15 Dec 2025 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wS1Se1O16cm5p8znhF1rexTm8ckxpPn3WO6AAmjcCME=;
 b=pORvknywWNso6vZMFl1PTv7DwWRtC97CgQ4fQUg2IosCdbqzd925sDSyOq2j9tbGO0P/jP
 XNSTlwcojXkXrhOjJc4cfKyxBN4EuV1cQ3ZYiyfYA71yVlQqkkOSHD5n4ZHkL8oVlsY2SH
 J0ntCrF3FRdmfqA2GQpuB8qqZcxk4s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wS1Se1O16cm5p8znhF1rexTm8ckxpPn3WO6AAmjcCME=;
 b=QEjkd0UqOi3D/8HvyGueu7NiDx9Lc4xI0Ou/1dwQ3AJXUrwJnJ1zcwMRF8DFI9EnBG1VcP
 2nIhoFfyze3NsjAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wS1Se1O16cm5p8znhF1rexTm8ckxpPn3WO6AAmjcCME=;
 b=pORvknywWNso6vZMFl1PTv7DwWRtC97CgQ4fQUg2IosCdbqzd925sDSyOq2j9tbGO0P/jP
 XNSTlwcojXkXrhOjJc4cfKyxBN4EuV1cQ3ZYiyfYA71yVlQqkkOSHD5n4ZHkL8oVlsY2SH
 J0ntCrF3FRdmfqA2GQpuB8qqZcxk4s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836180;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wS1Se1O16cm5p8znhF1rexTm8ckxpPn3WO6AAmjcCME=;
 b=QEjkd0UqOi3D/8HvyGueu7NiDx9Lc4xI0Ou/1dwQ3AJXUrwJnJ1zcwMRF8DFI9EnBG1VcP
 2nIhoFfyze3NsjAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 471F83EA63;
 Mon, 15 Dec 2025 22:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KPl3ApKFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 51/51] tests/qtest/migration: Further simplify TLS tests
Date: Mon, 15 Dec 2025 19:00:37 -0300
Message-ID: <20251215220041.12657-52-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.990];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
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

Now that the TLS hooks were simplified, many test functions are using
the same hook, but passing a different data pointer. Since the data
pointer is already an argument for the _common function, stop setting
the hook & data in the test function and do it instead in the init
routine.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 60 +++++--------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index aa5482b823..da8b3e42fe 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -80,6 +80,11 @@ static void migrate_tls_psk_init(MigrateCommon *args,
                                  TestMigrateTLSPSK *test_args,
                                  TestMigrateTLSPSKData *data)
 {
+    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
+
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = test_args;
+
     data->workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
     data->pskfile = g_strdup_printf("%s/%s", data->workdir,
                                     QCRYPTO_TLS_CREDS_PSKFILE);
@@ -118,8 +123,6 @@ static void test_precopy_tls_psk_common(MigrateCommon *args,
 {
     TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
 
-    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
-
     migrate_tls_psk_init(args, test_args, data);
     test_precopy_common(args);
     migrate_tls_psk_cleanup(data);
@@ -130,8 +133,6 @@ static void test_postcopy_tls_psk_common(MigrateCommon *args,
 {
     TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
 
-    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
-
     migrate_tls_psk_init(args, test_args, data);
     test_postcopy_common(args);
     migrate_tls_psk_cleanup(data);
@@ -142,8 +143,6 @@ static void test_postcopy_recovery_tls_psk_common(MigrateCommon *args,
 {
     TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
 
-    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
-
     migrate_tls_psk_init(args, test_args, data);
     test_postcopy_recovery_common(args);
     migrate_tls_psk_cleanup(data);
@@ -283,6 +282,9 @@ static void migrate_tls_x509_init(MigrateCommon *args,
                                   TestMigrateTLSX509 *test_args,
                                   TestMigrateTLSX509Data *data)
 {
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = test_args;
+
     data->workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);
     data->keyfile = g_strdup_printf("%s/key.pem", data->workdir);
 
@@ -390,17 +392,11 @@ static void test_precopy_tls_x509_common(MigrateCommon *args,
 
 static void test_postcopy_tls_psk(char *name, MigrateCommon *args)
 {
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
-
     test_postcopy_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_postcopy_preempt_tls_psk(char *name, MigrateCommon *args)
 {
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
-
     qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_tls_psk_common(args, &tls_psk_match);
@@ -408,18 +404,12 @@ static void test_postcopy_preempt_tls_psk(char *name, MigrateCommon *args)
 
 static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
 {
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
-
     test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
 
 static void test_multifd_postcopy_recovery_tls_psk(char *name,
                                                    MigrateCommon *args)
 {
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
-
     qdict_put_bool(args->start.config, "multifd", true);
 
     test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
@@ -428,9 +418,6 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
 /* This contains preempt+recovery+tls test altogether */
 static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 {
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
-
     qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
@@ -439,9 +426,6 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
                                                            MigrateCommon *args)
 {
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
-
     qdict_put_bool(args->start.config, "multifd", true);
     qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
@@ -454,8 +438,6 @@ static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
 
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
 
     test_precopy_tls_psk_common(args, &tls_psk_match);
 }
@@ -468,8 +450,6 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
 
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_default_host;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
     args->start.hide_stderr = true;
@@ -484,8 +464,6 @@ static void test_precopy_unix_tls_x509_override_host(char *name,
 
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_override_host;
 
     test_precopy_tls_x509_common(args, &tls_x509_override_host);
 }
@@ -494,8 +472,6 @@ static void test_precopy_unix_tls_x509_override_host(char *name,
 static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_match;
 
     test_precopy_tls_psk_common(args, &tls_psk_match);
 }
@@ -503,8 +479,6 @@ static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_psk_common;
-    args->start_hook_data = &tls_psk_mismatch;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
@@ -524,8 +498,6 @@ static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_no_host;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
     args->start.hide_stderr = true;
@@ -538,8 +510,6 @@ static void test_precopy_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_default_host;
 
     test_precopy_tls_x509_common(args, &tls_x509_default_host);
 }
@@ -548,8 +518,6 @@ static void test_precopy_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_override_host;
 
     test_precopy_tls_x509_common(args, &tls_x509_override_host);
 }
@@ -558,8 +526,6 @@ static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
                                                     MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_mismatch_host;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
     args->start.hide_stderr = true;
@@ -571,8 +537,6 @@ static void test_precopy_tcp_tls_x509_friendly_client(char *name,
                                                       MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &x509_friendly_client;
 
     test_precopy_tls_x509_common(args, &x509_friendly_client);
 }
@@ -581,8 +545,6 @@ static void test_precopy_tcp_tls_x509_hostile_client(char *name,
                                                      MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_hostile_client;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
@@ -594,8 +556,6 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_allow_anon_client;
 
     test_precopy_tls_x509_common(args, &tls_x509_allow_anon_client);
 }
@@ -604,8 +564,6 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_reject_anon_client;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
@@ -679,8 +637,6 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->start_hook_full = migrate_hook_start_tls_x509_common;
-    args->start_hook_data = &tls_x509_mismatch_host;
     args->result = MIG_TEST_FAIL;
     args->listen_uri = "tcp:127.0.0.1:0";
 
-- 
2.51.0


