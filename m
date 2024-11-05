Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBC6D3177B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NzE-0004iw-Ry; Tue, 05 Nov 2024 13:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzC-0004iM-Mn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:02 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nz8-0004sS-UP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66DC021DB4;
 Tue,  5 Nov 2024 18:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41lCNd9bkYF2XWxZQLSAXMCzfFR9lQXJ5X4tMjpzVqA=;
 b=SyiAPqEF0OB5NJR4KVBfqdEIYGbQMIP0qS5D6q+4MreEY+nCGG+CymFjsF8S91x+q8gJti
 u5V5bDhokxT0iQ2AFvkeeJxI7jS8SP3BEBMh7FetYTN/UBhFmH8sRG4nhb6TA3IiuOeaoY
 UttBL9HwiQaHeOdjX/kZQJvMT9OLloM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41lCNd9bkYF2XWxZQLSAXMCzfFR9lQXJ5X4tMjpzVqA=;
 b=5WET+uUKH7S0U0jOB2gX96h4jJqL9yD7cdWogofRGBtZEddL8DcSj53Hxmpd3eQbg+ydPr
 amnyhUYuDuwsi2AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SyiAPqEF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5WET+uUK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41lCNd9bkYF2XWxZQLSAXMCzfFR9lQXJ5X4tMjpzVqA=;
 b=SyiAPqEF0OB5NJR4KVBfqdEIYGbQMIP0qS5D6q+4MreEY+nCGG+CymFjsF8S91x+q8gJti
 u5V5bDhokxT0iQ2AFvkeeJxI7jS8SP3BEBMh7FetYTN/UBhFmH8sRG4nhb6TA3IiuOeaoY
 UttBL9HwiQaHeOdjX/kZQJvMT9OLloM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=41lCNd9bkYF2XWxZQLSAXMCzfFR9lQXJ5X4tMjpzVqA=;
 b=5WET+uUKH7S0U0jOB2gX96h4jJqL9yD7cdWogofRGBtZEddL8DcSj53Hxmpd3eQbg+ydPr
 amnyhUYuDuwsi2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA2D1394A;
 Tue,  5 Nov 2024 18:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sLTwEzdfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:08:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 03/22] tests/qtest/migration: Stop calling everything "test"
Date: Tue,  5 Nov 2024 15:08:18 -0300
Message-Id: <20241105180837.5990-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66DC021DB4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Test frameworks usually prefix "test_" to the entry point of the test
code. Having every function prefixed with test_ makes it hard to
understand the code and to grep for the actual tests.

Remove the "test" prefix from everything that is not a test.

In order to still keep some namespacing, stick to the "migrate_"
prefix, which is the most used currently.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
note: I would prefer the prefix "mig_" to avoid using "migrate_" which
is a verb, but several functions such as migrate_qmp() would have to
be given an entirely new name to keep expressiveness and I want to
keep this a mechanical change.
---
 tests/qtest/migration-test.c | 410 +++++++++++++++++------------------
 1 file changed, 205 insertions(+), 205 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 04890e0479..a40451df1e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -710,8 +710,8 @@ typedef struct {
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
-static int test_migrate_start(QTestState **from, QTestState **to,
-                              const char *uri, MigrateStart *args)
+static int migrate_start(QTestState **from, QTestState **to,
+                         const char *uri, MigrateStart *args)
 {
     g_autofree gchar *arch_source = NULL;
     g_autofree gchar *arch_target = NULL;
@@ -876,7 +876,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     return 0;
 }
 
-static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
+static void migrate_end(QTestState *from, QTestState *to, bool test_dest)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
@@ -919,9 +919,9 @@ struct TestMigrateTLSPSKData {
 };
 
 static void *
-test_migrate_tls_psk_start_common(QTestState *from,
-                                  QTestState *to,
-                                  bool mismatch)
+migrate_tls_psk_start_common(QTestState *from,
+                             QTestState *to,
+                             bool mismatch)
 {
     struct TestMigrateTLSPSKData *data =
         g_new0(struct TestMigrateTLSPSKData, 1);
@@ -964,23 +964,23 @@ test_migrate_tls_psk_start_common(QTestState *from,
 }
 
 static void *
-test_migrate_tls_psk_match_start(QTestState *from,
-                                 QTestState *to)
+migrate_tls_psk_match_start(QTestState *from,
+                            QTestState *to)
 {
-    return test_migrate_tls_psk_start_common(from, to, false);
+    return migrate_tls_psk_start_common(from, to, false);
 }
 
 static void *
-test_migrate_tls_psk_mismatch_start(QTestState *from,
-                                    QTestState *to)
+migrate_tls_psk_mismatch_start(QTestState *from,
+                               QTestState *to)
 {
-    return test_migrate_tls_psk_start_common(from, to, true);
+    return migrate_tls_psk_start_common(from, to, true);
 }
 
 static void
-test_migrate_tls_psk_end(QTestState *from,
-                         QTestState *to,
-                         void *opaque)
+migrate_tls_psk_end(QTestState *from,
+                    QTestState *to,
+                    void *opaque)
 {
     struct TestMigrateTLSPSKData *data = opaque;
 
@@ -1021,9 +1021,9 @@ typedef struct {
 } TestMigrateTLSX509;
 
 static void *
-test_migrate_tls_x509_start_common(QTestState *from,
-                                   QTestState *to,
-                                   TestMigrateTLSX509 *args)
+migrate_tls_x509_start_common(QTestState *from,
+                              QTestState *to,
+                              TestMigrateTLSX509 *args)
 {
     TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
 
@@ -1114,15 +1114,15 @@ test_migrate_tls_x509_start_common(QTestState *from,
  * whatever host we were telling QEMU to connect to (if any)
  */
 static void *
-test_migrate_tls_x509_default_host_start(QTestState *from,
-                                         QTestState *to)
+migrate_tls_x509_default_host_start(QTestState *from,
+                                    QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
         .clientcert = true,
         .certipaddr = "127.0.0.1"
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_tls_x509_start_common(from, to, &args);
 }
 
 /*
@@ -1131,15 +1131,15 @@ test_migrate_tls_x509_default_host_start(QTestState *from,
  * so we must give QEMU an explicit hostname to validate
  */
 static void *
-test_migrate_tls_x509_override_host_start(QTestState *from,
-                                          QTestState *to)
+migrate_tls_x509_override_host_start(QTestState *from,
+                                     QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
         .clientcert = true,
         .certhostname = "qemu.org",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_tls_x509_start_common(from, to, &args);
 }
 
 /*
@@ -1148,20 +1148,20 @@ test_migrate_tls_x509_override_host_start(QTestState *from,
  * expect the client to reject the server
  */
 static void *
-test_migrate_tls_x509_mismatch_host_start(QTestState *from,
-                                          QTestState *to)
+migrate_tls_x509_mismatch_host_start(QTestState *from,
+                                     QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
         .clientcert = true,
         .certipaddr = "10.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_tls_x509_start_common(from, to, &args);
 }
 
 static void *
-test_migrate_tls_x509_friendly_client_start(QTestState *from,
-                                            QTestState *to)
+migrate_tls_x509_friendly_client_start(QTestState *from,
+                                       QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1169,12 +1169,12 @@ test_migrate_tls_x509_friendly_client_start(QTestState *from,
         .authzclient = true,
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_tls_x509_start_common(from, to, &args);
 }
 
 static void *
-test_migrate_tls_x509_hostile_client_start(QTestState *from,
-                                           QTestState *to)
+migrate_tls_x509_hostile_client_start(QTestState *from,
+                                      QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
@@ -1183,7 +1183,7 @@ test_migrate_tls_x509_hostile_client_start(QTestState *from,
         .authzclient = true,
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_tls_x509_start_common(from, to, &args);
 }
 
 /*
@@ -1191,13 +1191,13 @@ test_migrate_tls_x509_hostile_client_start(QTestState *from,
  * and no server verification
  */
 static void *
-test_migrate_tls_x509_allow_anon_client_start(QTestState *from,
-                                              QTestState *to)
+migrate_tls_x509_allow_anon_client_start(QTestState *from,
+                                         QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_tls_x509_start_common(from, to, &args);
 }
 
 /*
@@ -1205,20 +1205,20 @@ test_migrate_tls_x509_allow_anon_client_start(QTestState *from,
  * and server verification rejecting
  */
 static void *
-test_migrate_tls_x509_reject_anon_client_start(QTestState *from,
-                                               QTestState *to)
+migrate_tls_x509_reject_anon_client_start(QTestState *from,
+                                          QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_tls_x509_start_common(from, to, &args);
 }
 
 static void
-test_migrate_tls_x509_end(QTestState *from,
-                          QTestState *to,
-                          void *opaque)
+migrate_tls_x509_end(QTestState *from,
+                     QTestState *to,
+                     void *opaque)
 {
     TestMigrateTLSX509Data *data = opaque;
 
@@ -1255,7 +1255,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 {
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -1319,7 +1319,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
         args->postcopy_data = NULL;
     }
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 
 static void test_postcopy_common(MigrateCommon *args)
@@ -1362,8 +1362,8 @@ static void test_postcopy_preempt(void)
 static void test_postcopy_tls_psk(void)
 {
     MigrateCommon args = {
-        .start_hook = test_migrate_tls_psk_match_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_tls_psk_match_start,
+        .end_hook = migrate_tls_psk_end,
     };
 
     test_postcopy_common(&args);
@@ -1373,8 +1373,8 @@ static void test_postcopy_preempt_tls_psk(void)
 {
     MigrateCommon args = {
         .postcopy_preempt = true,
-        .start_hook = test_migrate_tls_psk_match_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_tls_psk_match_start,
+        .end_hook = migrate_tls_psk_end,
     };
 
     test_postcopy_common(&args);
@@ -1596,8 +1596,8 @@ static void test_postcopy_recovery_fail_reconnect(void)
 static void test_postcopy_recovery_tls_psk(void)
 {
     MigrateCommon args = {
-        .start_hook = test_migrate_tls_psk_match_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_tls_psk_match_start,
+        .end_hook = migrate_tls_psk_end,
     };
 
     test_postcopy_recovery_common(&args);
@@ -1619,8 +1619,8 @@ static void test_postcopy_preempt_all(void)
 {
     MigrateCommon args = {
         .postcopy_preempt = true,
-        .start_hook = test_migrate_tls_psk_match_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_tls_psk_match_start,
+        .end_hook = migrate_tls_psk_end,
     };
 
     test_postcopy_recovery_common(&args);
@@ -1635,12 +1635,12 @@ static void test_baddest(void)
     };
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
     migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
 }
 
 #ifndef _WIN32
@@ -1661,7 +1661,7 @@ static void test_analyze_script(void)
     }
 
     /* dummy url */
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
 
@@ -1693,7 +1693,7 @@ static void test_analyze_script(void)
         g_test_message("Failed to analyze the migration stream");
         g_test_fail();
     }
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
     cleanup("migfile");
 }
 #endif
@@ -1703,7 +1703,7 @@ static void test_precopy_common(MigrateCommon *args)
     QTestState *from, *to;
     void *data_hook = NULL;
 
-    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
@@ -1798,7 +1798,7 @@ finish:
         args->end_hook(from, to, data_hook);
     }
 
-    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
 static void file_dirty_offset_region(void)
@@ -1839,7 +1839,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     void *data_hook = NULL;
     bool check_offset = false;
 
-    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
@@ -1903,7 +1903,7 @@ finish:
         args->end_hook(from, to, data_hook);
     }
 
-    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
 static void test_precopy_unix_plain(void)
@@ -1977,8 +1977,8 @@ static void test_precopy_unix_tls_psk(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_psk_match_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_tls_psk_match_start,
+        .end_hook = migrate_tls_psk_end,
     };
 
     test_precopy_common(&args);
@@ -1994,8 +1994,8 @@ static void test_precopy_unix_tls_x509_default_host(void)
         },
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_x509_default_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_default_host_start,
+        .end_hook = migrate_tls_x509_end,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
@@ -2008,8 +2008,8 @@ static void test_precopy_unix_tls_x509_override_host(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_x509_override_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_override_host_start,
+        .end_hook = migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2024,7 +2024,7 @@ static void test_ignore_shared(void)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
+    if (migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
         return;
     }
 
@@ -2051,13 +2051,13 @@ static void test_ignore_shared(void)
     /* Check whether shared RAM has been really skipped */
     g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 #endif
 
 static void *
-test_migrate_xbzrle_start(QTestState *from,
-                          QTestState *to)
+migrate_xbzrle_start(QTestState *from,
+                     QTestState *to)
 {
     migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
 
@@ -2073,7 +2073,7 @@ static void test_precopy_unix_xbzrle(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_xbzrle_start,
+        .start_hook = migrate_xbzrle_start,
         .iterations = 2,
         /*
          * XBZRLE needs pages to be modified when doing the 2nd+ round
@@ -2392,7 +2392,7 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
-static void *test_migrate_switchover_ack_start(QTestState *from, QTestState *to)
+static void *migrate_switchover_ack_start(QTestState *from, QTestState *to)
 {
 
     migrate_set_capability(from, "return-path", true);
@@ -2408,7 +2408,7 @@ static void test_precopy_tcp_switchover_ack(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_switchover_ack_start,
+        .start_hook = migrate_switchover_ack_start,
         /*
          * Source VM must be running in order to consider the switchover ACK
          * when deciding to do switchover or not.
@@ -2424,8 +2424,8 @@ static void test_precopy_tcp_tls_psk_match(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_psk_match_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_tls_psk_match_start,
+        .end_hook = migrate_tls_psk_end,
     };
 
     test_precopy_common(&args);
@@ -2438,8 +2438,8 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_psk_mismatch_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_tls_psk_mismatch_start,
+        .end_hook = migrate_tls_psk_end,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2451,8 +2451,8 @@ static void test_precopy_tcp_tls_x509_default_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_default_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_default_host_start,
+        .end_hook = migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2462,8 +2462,8 @@ static void test_precopy_tcp_tls_x509_override_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_override_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_override_host_start,
+        .end_hook = migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2476,8 +2476,8 @@ static void test_precopy_tcp_tls_x509_mismatch_host(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_mismatch_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_mismatch_host_start,
+        .end_hook = migrate_tls_x509_end,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
@@ -2488,8 +2488,8 @@ static void test_precopy_tcp_tls_x509_friendly_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_friendly_client_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_friendly_client_start,
+        .end_hook = migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2502,8 +2502,8 @@ static void test_precopy_tcp_tls_x509_hostile_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_hostile_client_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_hostile_client_start,
+        .end_hook = migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2514,8 +2514,8 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_allow_anon_client_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_allow_anon_client_start,
+        .end_hook = migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2528,8 +2528,8 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_reject_anon_client_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_tls_x509_reject_anon_client_start,
+        .end_hook = migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2539,8 +2539,8 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
 #endif /* CONFIG_GNUTLS */
 
 #ifndef _WIN32
-static void *test_migrate_fd_start(QTestState *from,
-                                   QTestState *to)
+static void *migrate_fd_start(QTestState *from,
+                              QTestState *to)
 {
     int ret;
     int pair[2];
@@ -2567,9 +2567,9 @@ static void *test_migrate_fd_start(QTestState *from,
     return NULL;
 }
 
-static void test_migrate_fd_end(QTestState *from,
-                                QTestState *to,
-                                void *opaque)
+static void migrate_fd_end(QTestState *from,
+                           QTestState *to,
+                           void *opaque)
 {
     QDict *rsp;
     const char *error_desc;
@@ -2594,13 +2594,13 @@ static void test_migrate_fd_end(QTestState *from,
     qobject_unref(rsp);
 }
 
-static void test_migrate_precopy_fd_socket(void)
+static void test_precopy_fd_socket(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
         .connect_uri = "fd:fd-mig",
-        .start_hook = test_migrate_fd_start,
-        .end_hook = test_migrate_fd_end,
+        .start_hook = migrate_fd_start,
+        .end_hook = migrate_fd_end,
     };
     test_precopy_common(&args);
 }
@@ -2633,13 +2633,13 @@ static void *migrate_precopy_fd_file_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_migrate_precopy_fd_file(void)
+static void test_precopy_fd_file(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
         .connect_uri = "fd:fd-mig",
         .start_hook = migrate_precopy_fd_file_start,
-        .end_hook = test_migrate_fd_end,
+        .end_hook = migrate_fd_end,
     };
     test_file_common(&args, true);
 }
@@ -2650,7 +2650,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, args)) {
+    if (migrate_start(&from, &to, uri, args)) {
         return;
     }
 
@@ -2674,7 +2674,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
         wait_for_migration_complete(from);
     }
 
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
 }
 
 static void test_validate_uuid(void)
@@ -2722,7 +2722,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
 {
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
@@ -2734,7 +2734,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
      * starts.
      */
     migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
 }
 
 static void test_validate_uri_channels_both_set(void)
@@ -2782,7 +2782,7 @@ static void test_validate_uri_channels_none_set(void)
  * To make things even worse, we need to run the initial stage at
  * 3MB/s so we enter autoconverge even when host is (over)loaded.
  */
-static void test_migrate_auto_converge(void)
+static void test_auto_converge(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     MigrateStart args = {};
@@ -2798,7 +2798,7 @@ static void test_migrate_auto_converge(void)
     uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
     int max_try_count, hit = 0;
 
-    if (test_migrate_start(&from, &to, uri, &args)) {
+    if (migrate_start(&from, &to, uri, &args)) {
         return;
     }
 
@@ -2882,13 +2882,13 @@ static void test_migrate_auto_converge(void)
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
-                                              QTestState *to,
-                                              const char *method)
+migrate_precopy_tcp_multifd_start_common(QTestState *from,
+                                         QTestState *to,
+                                         const char *method)
 {
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
@@ -2906,17 +2906,17 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start(QTestState *from,
-                                       QTestState *to)
+migrate_precopy_tcp_multifd_start(QTestState *from,
+                                  QTestState *to)
 {
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_zero_page_legacy_start(QTestState *from,
-                                                        QTestState *to)
+migrate_precopy_tcp_multifd_zero_page_legacy_start(QTestState *from,
+                                                   QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "legacy");
     return NULL;
 }
@@ -2925,14 +2925,14 @@ static void *
 test_migration_precopy_tcp_multifd_no_zero_page_start(QTestState *from,
                                                       QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "none");
     return NULL;
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
-                                            QTestState *to)
+migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
+                                       QTestState *to)
 {
     /*
      * Overloading this test to also check that set_parameter does not error.
@@ -2941,47 +2941,47 @@ test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
     migrate_set_parameter_int(from, "multifd-zlib-level", 2);
     migrate_set_parameter_int(to, "multifd-zlib-level", 2);
 
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
+    return migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
 }
 
 #ifdef CONFIG_ZSTD
 static void *
-test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
-                                            QTestState *to)
+migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
+                                       QTestState *to)
 {
     migrate_set_parameter_int(from, "multifd-zstd-level", 2);
     migrate_set_parameter_int(to, "multifd-zstd-level", 2);
 
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
+    return migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
 }
 #endif /* CONFIG_ZSTD */
 
 #ifdef CONFIG_QATZIP
 static void *
-test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
-                                              QTestState *to)
+migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+                                         QTestState *to)
 {
     migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
     migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
 
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+    return migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
 }
 #endif
 
 #ifdef CONFIG_QPL
 static void *
-test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
-                                           QTestState *to)
+migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
+                                      QTestState *to)
 {
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
+    return migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
 }
 #endif /* CONFIG_QPL */
 #ifdef CONFIG_UADK
 static void *
-test_migrate_precopy_tcp_multifd_uadk_start(QTestState *from,
-                                            QTestState *to)
+migrate_precopy_tcp_multifd_uadk_start(QTestState *from,
+                                       QTestState *to)
 {
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "uadk");
+    return migrate_precopy_tcp_multifd_start_common(from, to, "uadk");
 }
 #endif /* CONFIG_UADK */
 
@@ -2989,7 +2989,7 @@ static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .start_hook = migrate_precopy_tcp_multifd_start,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -3004,7 +3004,7 @@ static void test_multifd_tcp_zero_page_legacy(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_zero_page_legacy_start,
+        .start_hook = migrate_precopy_tcp_multifd_zero_page_legacy_start,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -3034,7 +3034,7 @@ static void test_multifd_tcp_channels_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .start_hook = migrate_precopy_tcp_multifd_start,
         .live = true,
         .connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
@@ -3049,7 +3049,7 @@ static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_zlib_start,
+        .start_hook = migrate_precopy_tcp_multifd_zlib_start,
     };
     test_precopy_common(&args);
 }
@@ -3059,7 +3059,7 @@ static void test_multifd_tcp_zstd(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_zstd_start,
+        .start_hook = migrate_precopy_tcp_multifd_zstd_start,
     };
     test_precopy_common(&args);
 }
@@ -3070,7 +3070,7 @@ static void test_multifd_tcp_qatzip(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
+        .start_hook = migrate_precopy_tcp_multifd_qatzip_start,
     };
     test_precopy_common(&args);
 }
@@ -3081,7 +3081,7 @@ static void test_multifd_tcp_qpl(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_qpl_start,
+        .start_hook = migrate_precopy_tcp_multifd_qpl_start,
     };
     test_precopy_common(&args);
 }
@@ -3092,7 +3092,7 @@ static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_uadk_start,
+        .start_hook = migrate_precopy_tcp_multifd_uadk_start,
     };
     test_precopy_common(&args);
 }
@@ -3100,60 +3100,60 @@ static void test_multifd_tcp_uadk(void)
 
 #ifdef CONFIG_GNUTLS
 static void *
-test_migrate_multifd_tcp_tls_psk_match_start(QTestState *from,
-                                             QTestState *to)
+migrate_multifd_tcp_tls_psk_match_start(QTestState *from,
+                                        QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_psk_match_start(from, to);
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_tls_psk_match_start(from, to);
 }
 
 static void *
-test_migrate_multifd_tcp_tls_psk_mismatch_start(QTestState *from,
-                                                QTestState *to)
+migrate_multifd_tcp_tls_psk_mismatch_start(QTestState *from,
+                                           QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_psk_mismatch_start(from, to);
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_tls_psk_mismatch_start(from, to);
 }
 
 #ifdef CONFIG_TASN1
 static void *
-test_migrate_multifd_tls_x509_default_host_start(QTestState *from,
+migrate_multifd_tls_x509_default_host_start(QTestState *from,
+                                            QTestState *to)
+{
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_tls_x509_default_host_start(from, to);
+}
+
+static void *
+migrate_multifd_tls_x509_override_host_start(QTestState *from,
+                                             QTestState *to)
+{
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_tls_x509_override_host_start(from, to);
+}
+
+static void *
+migrate_multifd_tls_x509_mismatch_host_start(QTestState *from,
+                                             QTestState *to)
+{
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_tls_x509_mismatch_host_start(from, to);
+}
+
+static void *
+migrate_multifd_tls_x509_allow_anon_client_start(QTestState *from,
                                                  QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_default_host_start(from, to);
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_tls_x509_allow_anon_client_start(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_override_host_start(QTestState *from,
+migrate_multifd_tls_x509_reject_anon_client_start(QTestState *from,
                                                   QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_override_host_start(from, to);
-}
-
-static void *
-test_migrate_multifd_tls_x509_mismatch_host_start(QTestState *from,
-                                                  QTestState *to)
-{
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_mismatch_host_start(from, to);
-}
-
-static void *
-test_migrate_multifd_tls_x509_allow_anon_client_start(QTestState *from,
-                                                      QTestState *to)
-{
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_allow_anon_client_start(from, to);
-}
-
-static void *
-test_migrate_multifd_tls_x509_reject_anon_client_start(QTestState *from,
-                                                       QTestState *to)
-{
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_reject_anon_client_start(from, to);
+    migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_tls_x509_reject_anon_client_start(from, to);
 }
 #endif /* CONFIG_TASN1 */
 
@@ -3161,8 +3161,8 @@ static void test_multifd_tcp_tls_psk_match(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tcp_tls_psk_match_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_multifd_tcp_tls_psk_match_start,
+        .end_hook = migrate_tls_psk_end,
     };
     test_precopy_common(&args);
 }
@@ -3174,8 +3174,8 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tcp_tls_psk_mismatch_start,
-        .end_hook = test_migrate_tls_psk_end,
+        .start_hook = migrate_multifd_tcp_tls_psk_mismatch_start,
+        .end_hook = migrate_tls_psk_end,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
@@ -3186,8 +3186,8 @@ static void test_multifd_tcp_tls_x509_default_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_default_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_multifd_tls_x509_default_host_start,
+        .end_hook = migrate_tls_x509_end,
     };
     test_precopy_common(&args);
 }
@@ -3196,8 +3196,8 @@ static void test_multifd_tcp_tls_x509_override_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_override_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_multifd_tls_x509_override_host_start,
+        .end_hook = migrate_tls_x509_end,
     };
     test_precopy_common(&args);
 }
@@ -3222,8 +3222,8 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_mismatch_host_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_multifd_tls_x509_mismatch_host_start,
+        .end_hook = migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
@@ -3233,8 +3233,8 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_allow_anon_client_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_multifd_tls_x509_allow_anon_client_start,
+        .end_hook = migrate_tls_x509_end,
     };
     test_precopy_common(&args);
 }
@@ -3246,8 +3246,8 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_reject_anon_client_start,
-        .end_hook = test_migrate_tls_x509_end,
+        .start_hook = migrate_multifd_tls_x509_reject_anon_client_start,
+        .end_hook = migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
@@ -3273,7 +3273,7 @@ static void test_multifd_tcp_cancel(void)
     };
     QTestState *from, *to, *to2;
 
-    if (test_migrate_start(&from, &to, "defer", &args)) {
+    if (migrate_start(&from, &to, "defer", &args)) {
         return;
     }
 
@@ -3305,7 +3305,7 @@ static void test_multifd_tcp_cancel(void)
 
     /*
      * Ensure the source QEMU finishes its cancellation process before we
-     * proceed with the setup of the next migration. The test_migrate_start()
+     * proceed with the setup of the next migration. The migrate_start()
      * function and others might want to interact with the source in a way that
      * is not possible while the migration is not canceled properly. For
      * example, setting migration capabilities when the migration is still
@@ -3317,7 +3317,7 @@ static void test_multifd_tcp_cancel(void)
         .only_target = true,
     };
 
-    if (test_migrate_start(&from, &to2, "defer", &args)) {
+    if (migrate_start(&from, &to2, "defer", &args)) {
         return;
     }
 
@@ -3341,7 +3341,7 @@ static void test_multifd_tcp_cancel(void)
 
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
-    test_migrate_end(from, to2, true);
+    migrate_end(from, to2, true);
 }
 
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
@@ -3627,7 +3627,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
  * And see if dirty limit migration works correctly.
  * This test case involves many passes, so it runs in slow mode only.
  */
-static void test_migrate_dirty_limit(void)
+static void test_dirty_limit(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -3658,7 +3658,7 @@ static void test_migrate_dirty_limit(void)
     };
 
     /* Start src, dst vm */
-    if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
+    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
         return;
     }
 
@@ -3702,7 +3702,7 @@ static void test_migrate_dirty_limit(void)
     };
 
     /* Restart dst vm, src vm already show up so we needn't wait anymore */
-    if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
+    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
         return;
     }
 
@@ -3745,7 +3745,7 @@ static void test_migrate_dirty_limit(void)
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 
 static bool kvm_dirty_ring_supported(void)
@@ -3948,9 +3948,9 @@ int main(int argc, char **argv)
     /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
-                       test_migrate_precopy_fd_socket);
+                       test_precopy_fd_socket);
     migration_test_add("/migration/precopy/fd/file",
-                       test_migrate_precopy_fd_file);
+                       test_precopy_fd_file);
 #endif
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
@@ -3968,11 +3968,11 @@ int main(int argc, char **argv)
      */
     if (g_test_slow()) {
         migration_test_add("/migration/auto_converge",
-                           test_migrate_auto_converge);
+                           test_auto_converge);
         if (g_str_equal(arch, "x86_64") &&
             has_kvm && kvm_dirty_ring_supported()) {
             migration_test_add("/migration/dirty_limit",
-                               test_migrate_dirty_limit);
+                               test_dirty_limit);
         }
     }
     migration_test_add("/migration/multifd/tcp/uri/plain/none",
-- 
2.35.3


