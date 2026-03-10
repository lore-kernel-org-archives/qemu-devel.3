Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA6DFD2D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxZ4-0004LA-RH; Tue, 10 Mar 2026 09:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxZ2-0004J7-RF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:56:00 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxZ0-0007BY-JF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:56:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F38DA3ED7C;
 Tue, 10 Mar 2026 13:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSgcApwHsBDH834I1NvwI90SOoyp/987/ws/vlJKf4I=;
 b=GQv+W5auTCd/Rf8sbAcyecz5ps4CcPGZZOyt0HV2CCHpVt8PGrHKBTaA+b8Si0H5h0xyk9
 qJ9akcQE1VLBAmaSlPtCcpwGvUgOA0Axoi8lAiJAbGfuklnj1ZwX5dZdS4IIepSLZDt39d
 LpVY2Rmp7Gx43HnLmvlvF0z2cVv4teo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSgcApwHsBDH834I1NvwI90SOoyp/987/ws/vlJKf4I=;
 b=qWEaObPfrrxAlb0GMK3XY0TuKlRahW/S9VEAGU8BGUqfv4RZgphHs1vKcCPKbcgWVWc4eu
 rF26Tj7vlAk68DCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GQv+W5au;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qWEaObPf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSgcApwHsBDH834I1NvwI90SOoyp/987/ws/vlJKf4I=;
 b=GQv+W5auTCd/Rf8sbAcyecz5ps4CcPGZZOyt0HV2CCHpVt8PGrHKBTaA+b8Si0H5h0xyk9
 qJ9akcQE1VLBAmaSlPtCcpwGvUgOA0Axoi8lAiJAbGfuklnj1ZwX5dZdS4IIepSLZDt39d
 LpVY2Rmp7Gx43HnLmvlvF0z2cVv4teo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSgcApwHsBDH834I1NvwI90SOoyp/987/ws/vlJKf4I=;
 b=qWEaObPfrrxAlb0GMK3XY0TuKlRahW/S9VEAGU8BGUqfv4RZgphHs1vKcCPKbcgWVWc4eu
 rF26Tj7vlAk68DCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 231DB3F4B3;
 Tue, 10 Mar 2026 13:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oFKQNuUisGnFcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 13:55:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/8] tests/qtest/migration: Stop invoking migrate_incoming
 from hooks
Date: Tue, 10 Mar 2026 10:55:36 -0300
Message-ID: <20260310135540.8679-4-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310135540.8679-1-farosas@suse.de>
References: <20260310135540.8679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 RCVD_TLS_ALL(0.00)[];
 FREEMAIL_CC(0.00)[linaro.org,redhat.com,web.de];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F38DA3ED7C
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Now that the listen_uri is being properly used, tests can stop calling
migrate_incoming from their hooks. The _common functions and
migrate_start should take care of that.

Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251215220041.12657-29-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/colo-tests.c        |  4 ++++
 tests/qtest/migration/compression-tests.c |  6 ++++++
 tests/qtest/migration/framework.c         | 14 +++++++++++---
 tests/qtest/migration/precopy-tests.c     |  7 ++++---
 tests/qtest/migration/tls-tests.c         |  8 ++++++++
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index 7c438c196b..0d800429c5 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -55,6 +55,10 @@ static int test_colo_common(MigrateCommon *args,
         data_hook = args->start_hook(from, to);
     }
 
+    if (args->start.incoming_defer) {
+        migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+    }
+
     migrate_ensure_converge(from);
     wait_for_serial("src_serial");
 
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index eb0b7d6b4b..bed39dece0 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -33,6 +33,7 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
 
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 {
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
 
     args->start.incoming_defer = true;
@@ -43,6 +44,7 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 
 static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
 {
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
 
     args->start.incoming_defer = true;
@@ -66,6 +68,7 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
 
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
 {
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
 
     args->start.incoming_defer = true;
@@ -85,6 +88,7 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
 
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
 {
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
 
     args->start.incoming_defer = true;
@@ -104,6 +108,7 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
 
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
 {
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
 
     args->start.incoming_defer = true;
@@ -156,6 +161,7 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
 
 static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
 {
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
 
     args->start.incoming_defer = true;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 75605d1791..4cc63bba7b 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -837,6 +837,9 @@ int test_precopy_common(MigrateCommon *args)
     QObject *out_channels = NULL;
 
     g_assert(!args->cpr_channel || args->connect_channels);
+    if (args->start.incoming_defer) {
+        g_assert(args->listen_uri || args->connect_channels);
+    }
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return -1;
@@ -846,6 +849,14 @@ int test_precopy_common(MigrateCommon *args)
         data_hook = args->start_hook(from, to);
     }
 
+    if (args->start.incoming_defer && !args->start.defer_target_connect) {
+        if (args->connect_channels) {
+            in_channels = qobject_from_json(args->connect_channels,
+                                            &error_abort);
+        }
+        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
+    }
+
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
         wait_for_serial("src_serial");
@@ -1077,9 +1088,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
     migrate_set_parameter_str(from, "multifd-compression", method);
     migrate_set_parameter_str(to, "multifd-compression", method);
 
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
-
     return NULL;
 }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 31fd4af1ad..d2302ed692 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -239,9 +239,6 @@ static void *migrate_hook_start_fd(QTestState *from,
                                  "  'arguments': { 'fdname': 'fd-mig' }}");
     close(pair[0]);
 
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
-
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
                                  "{ 'execute': 'getfd',"
@@ -283,6 +280,7 @@ static void migrate_hook_end_fd(QTestState *from,
 static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 {
     args->connect_uri = "fd:fd-mig";
+    args->listen_uri = "fd:fd-mig";
     args->start_hook = migrate_hook_start_fd;
     args->end_hook = migrate_hook_end_fd;
 
@@ -443,6 +441,7 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
      * everything will work alright even if guest page is changing.
      */
     args->live = true;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -459,6 +458,7 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
      * everything will work alright even if guest page is changing.
      */
     args->live = true;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -475,6 +475,7 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
      * everything will work alright even if guest page is changing.
      */
     args->live = true;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 40a78bd2d2..f636802642 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -675,6 +675,7 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -687,6 +688,7 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.hide_stderr = true;
     args->start.incoming_defer = true;
@@ -700,6 +702,7 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -714,6 +717,7 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -726,6 +730,7 @@ static void test_multifd_tcp_tls_x509_override_host(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -752,6 +757,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
     args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.hide_stderr = true;
@@ -765,6 +771,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -778,6 +785,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
     args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.hide_stderr = true;
-- 
2.51.0


