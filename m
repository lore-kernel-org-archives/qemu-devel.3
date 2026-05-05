Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA4DCD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIMH-00006K-Eq; Tue, 05 May 2026 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIM7-0008UG-Po
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:45 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIM4-0000p5-JG
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86ED76B785;
 Tue,  5 May 2026 16:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gLu8fyUzyQP1940vUaN/flGN80brylBhmoAkEaPaCE=;
 b=s8Pa5jjuHqS1aFVTYrcs2NnXiH8u4l+Wdm9FpDE1EGszi0Aasf3zn/w0V9uyqvIC37MsWx
 KM6aULGLY5dRVUhYm31J5ZyJ5epsLN/G82GA5IFrzc4PsU82h5UtQxzbu426YErDbFHkaE
 yWJPCRT9CDkNj+aUNcS8XUS7t/DuCQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gLu8fyUzyQP1940vUaN/flGN80brylBhmoAkEaPaCE=;
 b=grnONh+cy7lzuYX9cfoFxwzcuLsYuk4h1DWkKz0k4qZSy/lCyuYk/b5QjZ52IXhS6fhtW4
 WPt88c3eRdFuDQDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gLu8fyUzyQP1940vUaN/flGN80brylBhmoAkEaPaCE=;
 b=s8Pa5jjuHqS1aFVTYrcs2NnXiH8u4l+Wdm9FpDE1EGszi0Aasf3zn/w0V9uyqvIC37MsWx
 KM6aULGLY5dRVUhYm31J5ZyJ5epsLN/G82GA5IFrzc4PsU82h5UtQxzbu426YErDbFHkaE
 yWJPCRT9CDkNj+aUNcS8XUS7t/DuCQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gLu8fyUzyQP1940vUaN/flGN80brylBhmoAkEaPaCE=;
 b=grnONh+cy7lzuYX9cfoFxwzcuLsYuk4h1DWkKz0k4qZSy/lCyuYk/b5QjZ52IXhS6fhtW4
 WPt88c3eRdFuDQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DC59593A3;
 Tue,  5 May 2026 16:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iIS6C0AW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 09/15] tests/qtest/migration: Remove multifd compression
 hook
Date: Tue,  5 May 2026 13:09:08 -0300
Message-ID: <20260505160915.25558-10-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Take advantage of the default compression method for multifd being
"none" and remove the common compression hook.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c     |  9 ----
 tests/qtest/migration/framework.h     |  3 --
 tests/qtest/migration/precopy-tests.c | 11 ----
 tests/qtest/migration/tls-tests.c     | 74 +++------------------------
 4 files changed, 8 insertions(+), 89 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index f9f16faee4..9df33f8809 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1063,15 +1063,6 @@ finish:
     migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
-void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
-                                                    QTestState *to,
-                                                    const char *method)
-{
-    migrate_set_parameter_str(from, "multifd-compression", method);
-    migrate_set_parameter_str(to, "multifd-compression", method);
-    return NULL;
-}
-
 QTestMigrationState *get_src(void)
 {
     return &src_state;
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 613839dec8..7635e9fac1 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -241,9 +241,6 @@ void test_postcopy_recovery_common(MigrateCommon *args,
 int test_precopy_common(MigrateCommon *args);
 void test_precopy_unix_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
-void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
-                                                    QTestState *to,
-                                                    const char *method);
 
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 05e5bee48d..45a8f6d76c 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -378,18 +378,10 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     migrate_end(from, to, true);
 }
 
-static void *
-migrate_hook_start_precopy_tcp_multifd(QTestState *from,
-                                       QTestState *to)
-{
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-}
-
 static void *
 migrate_hook_start_precopy_tcp_multifd_zero_page_legacy(QTestState *from,
                                                         QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "legacy");
     return NULL;
 }
@@ -398,14 +390,12 @@ static void *
 migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
                                                     QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "none");
     return NULL;
 }
 
 static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     /*
      * Multifd is more complicated than most of the features, it
      * directly takes guest page buffers when sending, make sure
@@ -450,7 +440,6 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     args->live = true;
     args->connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 275d0b84d4..f45f4c4b0c 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -593,67 +593,9 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
 }
 #endif /* CONFIG_TASN1 */
 
-static void *
-migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
-                                             QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_psk_match(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
-                                                QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_psk_mismatch(from, to);
-}
-
-#ifdef CONFIG_TASN1
-static void *
-migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
-                                                 QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_default_host(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_override_host(QTestState *from,
-                                                  QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_override_host(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_mismatch_host(QTestState *from,
-                                                  QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_mismatch_host(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_allow_anon_client(QTestState *from,
-                                                      QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_allow_anon_client(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
-                                                       QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_reject_anon_client(from, to);
-}
-#endif /* CONFIG_TASN1 */
-
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
+    args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -663,7 +605,7 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
+    args->start_hook = migrate_hook_start_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
 
@@ -676,7 +618,7 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
+    args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -689,7 +631,7 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
+    args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -700,7 +642,7 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
+    args->start_hook = migrate_hook_start_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -724,7 +666,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
+    args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
@@ -737,7 +679,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
+    args->start_hook = migrate_hook_start_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -748,7 +690,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
+    args->start_hook = migrate_hook_start_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
-- 
2.51.0


