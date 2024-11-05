Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF647D31778
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NzB-0004hu-Um; Tue, 05 Nov 2024 13:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzA-0004hP-7P
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:00 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nz6-0004ry-Jl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:08:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 124471F818;
 Tue,  5 Nov 2024 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMDxjhXQ9+qwOoL2nNWBr/557sjfNZDCejD1D0C0Re0=;
 b=exBZeCXV48eowovOyruTs2ilQJBvrhRUyhYTtcCVEfRz6smbB6bvAfy8KvWRFccoRfiID+
 8MaTo4+PA1jWqXTMD9MvVksOPisoAWAEVIeqZazuQJ7gw8+eyg/iLxxLXl283ccy3LbibS
 wYsPk4slombw5rVO4GO6d71S1GcarQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMDxjhXQ9+qwOoL2nNWBr/557sjfNZDCejD1D0C0Re0=;
 b=nR8DNSn849O4qUKvpbdkPLgm14k6TNJxNH0QKzfywJCVeFio8m0k6Cg9KuyfpnGBoxNfkv
 XfS1KLkuzeh0VIBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=exBZeCXV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nR8DNSn8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMDxjhXQ9+qwOoL2nNWBr/557sjfNZDCejD1D0C0Re0=;
 b=exBZeCXV48eowovOyruTs2ilQJBvrhRUyhYTtcCVEfRz6smbB6bvAfy8KvWRFccoRfiID+
 8MaTo4+PA1jWqXTMD9MvVksOPisoAWAEVIeqZazuQJ7gw8+eyg/iLxxLXl283ccy3LbibS
 wYsPk4slombw5rVO4GO6d71S1GcarQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMDxjhXQ9+qwOoL2nNWBr/557sjfNZDCejD1D0C0Re0=;
 b=nR8DNSn849O4qUKvpbdkPLgm14k6TNJxNH0QKzfywJCVeFio8m0k6Cg9KuyfpnGBoxNfkv
 XfS1KLkuzeh0VIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DEC51394A;
 Tue,  5 Nov 2024 18:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wDxzDTVfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:08:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/22] tests/qtest/migration: Standardize hook names
Date: Tue,  5 Nov 2024 15:08:17 -0300
Message-Id: <20241105180837.5990-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 124471F818
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Standardize the hook names:

- change the names to .start|end_hook to match
  test_migrate_start|end()

- use the _start and _end suffixes

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 210 +++++++++++++++++------------------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index c3b461b5fa..04890e0479 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -631,9 +631,9 @@ typedef void * (*TestMigrateStartHook)(QTestState *from,
  * @opaque is a pointer to state previously returned
  * by the TestMigrateStartHook if any, or NULL.
  */
-typedef void (*TestMigrateFinishHook)(QTestState *from,
-                                      QTestState *to,
-                                      void *opaque);
+typedef void (*TestMigrateEndHook)(QTestState *from,
+                                   QTestState *to,
+                                   void *opaque);
 
 typedef struct {
     /* Optional: fine tune start parameters */
@@ -660,7 +660,7 @@ typedef struct {
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
-    TestMigrateFinishHook finish_hook;
+    TestMigrateEndHook end_hook;
 
     /*
      * Optional: normally we expect the migration process to complete.
@@ -964,23 +964,23 @@ test_migrate_tls_psk_start_common(QTestState *from,
 }
 
 static void *
-test_migrate_tls_psk_start_match(QTestState *from,
+test_migrate_tls_psk_match_start(QTestState *from,
                                  QTestState *to)
 {
     return test_migrate_tls_psk_start_common(from, to, false);
 }
 
 static void *
-test_migrate_tls_psk_start_mismatch(QTestState *from,
+test_migrate_tls_psk_mismatch_start(QTestState *from,
                                     QTestState *to)
 {
     return test_migrate_tls_psk_start_common(from, to, true);
 }
 
 static void
-test_migrate_tls_psk_finish(QTestState *from,
-                            QTestState *to,
-                            void *opaque)
+test_migrate_tls_psk_end(QTestState *from,
+                         QTestState *to,
+                         void *opaque)
 {
     struct TestMigrateTLSPSKData *data = opaque;
 
@@ -1114,7 +1114,7 @@ test_migrate_tls_x509_start_common(QTestState *from,
  * whatever host we were telling QEMU to connect to (if any)
  */
 static void *
-test_migrate_tls_x509_start_default_host(QTestState *from,
+test_migrate_tls_x509_default_host_start(QTestState *from,
                                          QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1131,7 +1131,7 @@ test_migrate_tls_x509_start_default_host(QTestState *from,
  * so we must give QEMU an explicit hostname to validate
  */
 static void *
-test_migrate_tls_x509_start_override_host(QTestState *from,
+test_migrate_tls_x509_override_host_start(QTestState *from,
                                           QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1148,7 +1148,7 @@ test_migrate_tls_x509_start_override_host(QTestState *from,
  * expect the client to reject the server
  */
 static void *
-test_migrate_tls_x509_start_mismatch_host(QTestState *from,
+test_migrate_tls_x509_mismatch_host_start(QTestState *from,
                                           QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1160,7 +1160,7 @@ test_migrate_tls_x509_start_mismatch_host(QTestState *from,
 }
 
 static void *
-test_migrate_tls_x509_start_friendly_client(QTestState *from,
+test_migrate_tls_x509_friendly_client_start(QTestState *from,
                                             QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1173,7 +1173,7 @@ test_migrate_tls_x509_start_friendly_client(QTestState *from,
 }
 
 static void *
-test_migrate_tls_x509_start_hostile_client(QTestState *from,
+test_migrate_tls_x509_hostile_client_start(QTestState *from,
                                            QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1191,7 +1191,7 @@ test_migrate_tls_x509_start_hostile_client(QTestState *from,
  * and no server verification
  */
 static void *
-test_migrate_tls_x509_start_allow_anon_client(QTestState *from,
+test_migrate_tls_x509_allow_anon_client_start(QTestState *from,
                                               QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1205,7 +1205,7 @@ test_migrate_tls_x509_start_allow_anon_client(QTestState *from,
  * and server verification rejecting
  */
 static void *
-test_migrate_tls_x509_start_reject_anon_client(QTestState *from,
+test_migrate_tls_x509_reject_anon_client_start(QTestState *from,
                                                QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1216,9 +1216,9 @@ test_migrate_tls_x509_start_reject_anon_client(QTestState *from,
 }
 
 static void
-test_migrate_tls_x509_finish(QTestState *from,
-                             QTestState *to,
-                             void *opaque)
+test_migrate_tls_x509_end(QTestState *from,
+                          QTestState *to,
+                          void *opaque)
 {
     TestMigrateTLSX509Data *data = opaque;
 
@@ -1314,8 +1314,8 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
         read_blocktime(to);
     }
 
-    if (args->finish_hook) {
-        args->finish_hook(from, to, args->postcopy_data);
+    if (args->end_hook) {
+        args->end_hook(from, to, args->postcopy_data);
         args->postcopy_data = NULL;
     }
 
@@ -1362,8 +1362,8 @@ static void test_postcopy_preempt(void)
 static void test_postcopy_tls_psk(void)
 {
     MigrateCommon args = {
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_tls_psk_match_start,
+        .end_hook = test_migrate_tls_psk_end,
     };
 
     test_postcopy_common(&args);
@@ -1373,8 +1373,8 @@ static void test_postcopy_preempt_tls_psk(void)
 {
     MigrateCommon args = {
         .postcopy_preempt = true,
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_tls_psk_match_start,
+        .end_hook = test_migrate_tls_psk_end,
     };
 
     test_postcopy_common(&args);
@@ -1596,8 +1596,8 @@ static void test_postcopy_recovery_fail_reconnect(void)
 static void test_postcopy_recovery_tls_psk(void)
 {
     MigrateCommon args = {
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_tls_psk_match_start,
+        .end_hook = test_migrate_tls_psk_end,
     };
 
     test_postcopy_recovery_common(&args);
@@ -1619,8 +1619,8 @@ static void test_postcopy_preempt_all(void)
 {
     MigrateCommon args = {
         .postcopy_preempt = true,
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_tls_psk_match_start,
+        .end_hook = test_migrate_tls_psk_end,
     };
 
     test_postcopy_recovery_common(&args);
@@ -1794,8 +1794,8 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
 finish:
-    if (args->finish_hook) {
-        args->finish_hook(from, to, data_hook);
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
     }
 
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
@@ -1899,8 +1899,8 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
 finish:
-    if (args->finish_hook) {
-        args->finish_hook(from, to, data_hook);
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
     }
 
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
@@ -1977,8 +1977,8 @@ static void test_precopy_unix_tls_psk(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_tls_psk_match_start,
+        .end_hook = test_migrate_tls_psk_end,
     };
 
     test_precopy_common(&args);
@@ -1994,8 +1994,8 @@ static void test_precopy_unix_tls_x509_default_host(void)
         },
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_x509_start_default_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_default_host_start,
+        .end_hook = test_migrate_tls_x509_end,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
@@ -2008,8 +2008,8 @@ static void test_precopy_unix_tls_x509_override_host(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_x509_start_override_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_override_host_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2120,7 +2120,7 @@ static void fdset_add_fds(QTestState *qts, const char *file, int flags,
     }
 }
 
-static void *file_offset_fdset_start_hook(QTestState *from, QTestState *to)
+static void *file_offset_fdset_start(QTestState *from, QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
@@ -2137,7 +2137,7 @@ static void test_precopy_file_offset_fdset(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = file_offset_fdset_start_hook,
+        .start_hook = file_offset_fdset_start,
     };
 
     test_file_common(&args, false);
@@ -2323,7 +2323,7 @@ static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
     qobject_unref(resp);
 }
 
-static void *multifd_mapped_ram_fdset_dio(QTestState *from, QTestState *to)
+static void *multifd_mapped_ram_fdset_dio_start(QTestState *from, QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
@@ -2337,7 +2337,7 @@ static void *multifd_mapped_ram_fdset_dio(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void *multifd_mapped_ram_fdset(QTestState *from, QTestState *to)
+static void *multifd_mapped_ram_fdset_start(QTestState *from, QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
@@ -2356,8 +2356,8 @@ static void test_multifd_file_mapped_ram_fdset(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_fdset,
-        .finish_hook = multifd_mapped_ram_fdset_end,
+        .start_hook = multifd_mapped_ram_fdset_start,
+        .end_hook = multifd_mapped_ram_fdset_end,
     };
 
     test_file_common(&args, true);
@@ -2370,8 +2370,8 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_fdset_dio,
-        .finish_hook = multifd_mapped_ram_fdset_end,
+        .start_hook = multifd_mapped_ram_fdset_dio_start,
+        .end_hook = multifd_mapped_ram_fdset_end,
     };
 
     if (!probe_o_direct_support(tmpfs)) {
@@ -2424,8 +2424,8 @@ static void test_precopy_tcp_tls_psk_match(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_tls_psk_match_start,
+        .end_hook = test_migrate_tls_psk_end,
     };
 
     test_precopy_common(&args);
@@ -2438,8 +2438,8 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_psk_start_mismatch,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_tls_psk_mismatch_start,
+        .end_hook = test_migrate_tls_psk_end,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2451,8 +2451,8 @@ static void test_precopy_tcp_tls_x509_default_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_default_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_default_host_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2462,8 +2462,8 @@ static void test_precopy_tcp_tls_x509_override_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_override_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_override_host_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2476,8 +2476,8 @@ static void test_precopy_tcp_tls_x509_mismatch_host(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_mismatch_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_mismatch_host_start,
+        .end_hook = test_migrate_tls_x509_end,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
@@ -2488,8 +2488,8 @@ static void test_precopy_tcp_tls_x509_friendly_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_friendly_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_friendly_client_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2502,8 +2502,8 @@ static void test_precopy_tcp_tls_x509_hostile_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_hostile_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_hostile_client_start,
+        .end_hook = test_migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2514,8 +2514,8 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_allow_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_allow_anon_client_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
 
     test_precopy_common(&args);
@@ -2528,8 +2528,8 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_reject_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_tls_x509_reject_anon_client_start,
+        .end_hook = test_migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2539,8 +2539,8 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
 #endif /* CONFIG_GNUTLS */
 
 #ifndef _WIN32
-static void *test_migrate_fd_start_hook(QTestState *from,
-                                        QTestState *to)
+static void *test_migrate_fd_start(QTestState *from,
+                                   QTestState *to)
 {
     int ret;
     int pair[2];
@@ -2567,9 +2567,9 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     return NULL;
 }
 
-static void test_migrate_fd_finish_hook(QTestState *from,
-                                        QTestState *to,
-                                        void *opaque)
+static void test_migrate_fd_end(QTestState *from,
+                                QTestState *to,
+                                void *opaque)
 {
     QDict *rsp;
     const char *error_desc;
@@ -2599,8 +2599,8 @@ static void test_migrate_precopy_fd_socket(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .connect_uri = "fd:fd-mig",
-        .start_hook = test_migrate_fd_start_hook,
-        .finish_hook = test_migrate_fd_finish_hook
+        .start_hook = test_migrate_fd_start,
+        .end_hook = test_migrate_fd_end,
     };
     test_precopy_common(&args);
 }
@@ -2639,7 +2639,7 @@ static void test_migrate_precopy_fd_file(void)
         .listen_uri = "defer",
         .connect_uri = "fd:fd-mig",
         .start_hook = migrate_precopy_fd_file_start,
-        .finish_hook = test_migrate_fd_finish_hook
+        .end_hook = test_migrate_fd_end,
     };
     test_file_common(&args, true);
 }
@@ -2913,7 +2913,7 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
+test_migrate_precopy_tcp_multifd_zero_page_legacy_start(QTestState *from,
                                                         QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
@@ -2922,7 +2922,7 @@ test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
 }
 
 static void *
-test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
+test_migration_precopy_tcp_multifd_no_zero_page_start(QTestState *from,
                                                       QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
@@ -3004,7 +3004,7 @@ static void test_multifd_tcp_zero_page_legacy(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_start_zero_page_legacy,
+        .start_hook = test_migrate_precopy_tcp_multifd_zero_page_legacy_start,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -3019,7 +3019,7 @@ static void test_multifd_tcp_no_zero_page(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migration_precopy_tcp_multifd_start_no_zero_page,
+        .start_hook = test_migration_precopy_tcp_multifd_no_zero_page_start,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -3100,60 +3100,60 @@ static void test_multifd_tcp_uadk(void)
 
 #ifdef CONFIG_GNUTLS
 static void *
-test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
+test_migrate_multifd_tcp_tls_psk_match_start(QTestState *from,
                                              QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_psk_start_match(from, to);
+    return test_migrate_tls_psk_match_start(from, to);
 }
 
 static void *
-test_migrate_multifd_tcp_tls_psk_start_mismatch(QTestState *from,
+test_migrate_multifd_tcp_tls_psk_mismatch_start(QTestState *from,
                                                 QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_psk_start_mismatch(from, to);
+    return test_migrate_tls_psk_mismatch_start(from, to);
 }
 
 #ifdef CONFIG_TASN1
 static void *
-test_migrate_multifd_tls_x509_start_default_host(QTestState *from,
+test_migrate_multifd_tls_x509_default_host_start(QTestState *from,
                                                  QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_default_host(from, to);
+    return test_migrate_tls_x509_default_host_start(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_override_host(QTestState *from,
+test_migrate_multifd_tls_x509_override_host_start(QTestState *from,
                                                   QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_override_host(from, to);
+    return test_migrate_tls_x509_override_host_start(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_mismatch_host(QTestState *from,
+test_migrate_multifd_tls_x509_mismatch_host_start(QTestState *from,
                                                   QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_mismatch_host(from, to);
+    return test_migrate_tls_x509_mismatch_host_start(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_allow_anon_client(QTestState *from,
+test_migrate_multifd_tls_x509_allow_anon_client_start(QTestState *from,
                                                       QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_allow_anon_client(from, to);
+    return test_migrate_tls_x509_allow_anon_client_start(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_reject_anon_client(QTestState *from,
+test_migrate_multifd_tls_x509_reject_anon_client_start(QTestState *from,
                                                        QTestState *to)
 {
     test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_reject_anon_client(from, to);
+    return test_migrate_tls_x509_reject_anon_client_start(from, to);
 }
 #endif /* CONFIG_TASN1 */
 
@@ -3161,8 +3161,8 @@ static void test_multifd_tcp_tls_psk_match(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tcp_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_multifd_tcp_tls_psk_match_start,
+        .end_hook = test_migrate_tls_psk_end,
     };
     test_precopy_common(&args);
 }
@@ -3174,8 +3174,8 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tcp_tls_psk_start_mismatch,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = test_migrate_multifd_tcp_tls_psk_mismatch_start,
+        .end_hook = test_migrate_tls_psk_end,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
@@ -3186,8 +3186,8 @@ static void test_multifd_tcp_tls_x509_default_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_default_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_multifd_tls_x509_default_host_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
     test_precopy_common(&args);
 }
@@ -3196,8 +3196,8 @@ static void test_multifd_tcp_tls_x509_override_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_override_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_multifd_tls_x509_override_host_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
     test_precopy_common(&args);
 }
@@ -3222,8 +3222,8 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_mismatch_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_multifd_tls_x509_mismatch_host_start,
+        .end_hook = test_migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
@@ -3233,8 +3233,8 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_allow_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_multifd_tls_x509_allow_anon_client_start,
+        .end_hook = test_migrate_tls_x509_end,
     };
     test_precopy_common(&args);
 }
@@ -3246,8 +3246,8 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_reject_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = test_migrate_multifd_tls_x509_reject_anon_client_start,
+        .end_hook = test_migrate_tls_x509_end,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
-- 
2.35.3


