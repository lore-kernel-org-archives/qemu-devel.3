Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37676D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGeE-0004rN-L7; Mon, 15 Dec 2025 17:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGe9-0004cH-KD
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:25 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGe6-0002rO-69
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEF9333703;
 Mon, 15 Dec 2025 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdixMlj90AdyJ9tT9OWwan6oz2SIpuQi3hevm35iFow=;
 b=ukHPY+Au+Y/vYQv0QNkiaZpu9hXoRfTANMHfjo1m2sE0gJkia3EIUDEDMZlYU2zxTpb7zZ
 HPqDAaNpFsmmJHU5J7hICkQ4usQaw0zSuWZpONHCvamd+w38Ao8EQiwQkTlBSKL4inkB0Q
 QDiYSnSu6HiHM1FnOv2tMtlqNjZDipw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdixMlj90AdyJ9tT9OWwan6oz2SIpuQi3hevm35iFow=;
 b=wjnclOgU8ql9SWpmPWHcnkpM44OJw3wQxXyHqv2bHH4D3RQlUY3+b4CfOWtFaO44tpLKzs
 9YTU421ZT/Hqo4BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdixMlj90AdyJ9tT9OWwan6oz2SIpuQi3hevm35iFow=;
 b=ukHPY+Au+Y/vYQv0QNkiaZpu9hXoRfTANMHfjo1m2sE0gJkia3EIUDEDMZlYU2zxTpb7zZ
 HPqDAaNpFsmmJHU5J7hICkQ4usQaw0zSuWZpONHCvamd+w38Ao8EQiwQkTlBSKL4inkB0Q
 QDiYSnSu6HiHM1FnOv2tMtlqNjZDipw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdixMlj90AdyJ9tT9OWwan6oz2SIpuQi3hevm35iFow=;
 b=wjnclOgU8ql9SWpmPWHcnkpM44OJw3wQxXyHqv2bHH4D3RQlUY3+b4CfOWtFaO44tpLKzs
 9YTU421ZT/Hqo4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6CF13EA63;
 Mon, 15 Dec 2025 22:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qGD2GVWFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 28/51] tests/qtest/migration: Stop invoking
 migrate_incoming from hooks
Date: Mon, 15 Dec 2025 19:00:14 -0300
Message-ID: <20251215220041.12657-29-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Now that the listen_uri is being properly used, tests can stop calling
migrate_incoming from their hooks. The _common functions and
migrate_start should take care of that.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c |  6 ++++++
 tests/qtest/migration/framework.c         | 14 +++++++++++---
 tests/qtest/migration/precopy-tests.c     |  7 ++++---
 tests/qtest/migration/tls-tests.c         |  8 ++++++++
 4 files changed, 29 insertions(+), 6 deletions(-)

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
index e811945122..199e439263 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -820,6 +820,9 @@ int test_precopy_common(MigrateCommon *args)
     QObject *out_channels = NULL;
 
     g_assert(!args->cpr_channel || args->connect_channels);
+    if (args->start.incoming_defer) {
+        g_assert(args->listen_uri || args->connect_channels);
+    }
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return -1;
@@ -829,6 +832,14 @@ int test_precopy_common(MigrateCommon *args)
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
@@ -1060,9 +1071,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
     migrate_set_parameter_str(from, "multifd-compression", method);
     migrate_set_parameter_str(to, "multifd-compression", method);
 
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
-
     return NULL;
 }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index d9c463dd0f..ab5789717f 100644
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
 
@@ -484,6 +482,7 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
      * everything will work alright even if guest page is changing.
      */
     args->live = true;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -500,6 +499,7 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
      * everything will work alright even if guest page is changing.
      */
     args->live = true;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -516,6 +516,7 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
      * everything will work alright even if guest page is changing.
      */
     args->live = true;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 166f27f478..f63f37132a 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -677,6 +677,7 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -689,6 +690,7 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.hide_stderr = true;
     args->start.incoming_defer = true;
@@ -702,6 +704,7 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -716,6 +719,7 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -728,6 +732,7 @@ static void test_multifd_tcp_tls_x509_override_host(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -754,6 +759,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
     args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.hide_stderr = true;
@@ -767,6 +773,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -780,6 +787,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
     args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
+    args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.hide_stderr = true;
-- 
2.51.0


