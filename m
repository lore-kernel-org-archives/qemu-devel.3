Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4008FCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIMH-00006J-Eh; Tue, 05 May 2026 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILl-0008BV-BL
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:30 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILZ-0000XL-Ao
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 683706B766;
 Tue,  5 May 2026 16:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cb7zHppTTTPuuYGVnbjALadsZfX5j2jgmG1ucp8x/24=;
 b=yEV2EGyi757Y6m1cIMElntcAuRYH4vQhd0h2RTD29X8+gYdTIkNuzjp05EYs8ikI39G9iK
 TYBtRxFsZmZ6SVEOml5aR6svxv2BHX3nNMmjgvU0PK6cQIAnN03Sf0v51jZHonb2uCwe1B
 6KrwShWkh6WBUnidwe5SbES2+/VN7zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cb7zHppTTTPuuYGVnbjALadsZfX5j2jgmG1ucp8x/24=;
 b=yNJFuCsmXzaa3/gbMe1P39fLddQl98UEkAsxuhwRh+NW08wDSalnXpVfe4U2U6RU3YeVz6
 RAWw9ZqMb/Fg5cCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cb7zHppTTTPuuYGVnbjALadsZfX5j2jgmG1ucp8x/24=;
 b=yEV2EGyi757Y6m1cIMElntcAuRYH4vQhd0h2RTD29X8+gYdTIkNuzjp05EYs8ikI39G9iK
 TYBtRxFsZmZ6SVEOml5aR6svxv2BHX3nNMmjgvU0PK6cQIAnN03Sf0v51jZHonb2uCwe1B
 6KrwShWkh6WBUnidwe5SbES2+/VN7zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cb7zHppTTTPuuYGVnbjALadsZfX5j2jgmG1ucp8x/24=;
 b=yNJFuCsmXzaa3/gbMe1P39fLddQl98UEkAsxuhwRh+NW08wDSalnXpVfe4U2U6RU3YeVz6
 RAWw9ZqMb/Fg5cCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16DC6593A6;
 Tue,  5 May 2026 16:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yDoINjwW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 07/15] tests/qtest/migration: Defer by default in
 precopy_common
Date: Tue,  5 May 2026 13:09:06 -0300
Message-ID: <20260505160915.25558-8-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[web.de]
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

As a design direction, we're restricting the usage of the command line
option -incoming <URI>. The alternative -incoming defer should be used
instead.

Make all precopy_common tests defer by default.

Using the defer option means that QEMU will not start the incoming
migration automatically. Add the incoming QMP command. With the added
command, the invocation at the multifd_common hook becomes redundant,
so remove it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/colo-tests.c        | 12 ++++--------
 tests/qtest/migration/compression-tests.c |  6 ------
 tests/qtest/migration/framework.c         | 15 ++++++++-------
 tests/qtest/migration/precopy-tests.c     | 11 +----------
 tests/qtest/migration/tls-tests.c         | 15 +--------------
 5 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index ef880f5114..4add4a014b 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -45,7 +45,7 @@ static int test_colo_common(MigrateCommon *args,
     args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -55,6 +55,8 @@ static int test_colo_common(MigrateCommon *args,
         data_hook = args->start_hook(from, to);
     }
 
+    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+
     migrate_ensure_converge(from);
     wait_for_serial("src_serial");
 
@@ -107,17 +109,11 @@ static void test_colo_plain_common(MigrateCommon *args,
     test_colo_common(args, failover_during_checkpoint, primary_failover);
 }
 
-static void *hook_start_multifd(QTestState *from, QTestState *to)
-{
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-}
-
 static void test_colo_multifd_common(MigrateCommon *args,
                                      bool failover_during_checkpoint,
                                      bool primary_failover)
 {
-    args->listen_uri = "defer";
-    args->start_hook = hook_start_multifd;
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     test_colo_common(args, failover_during_checkpoint, primary_failover);
 }
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 7f2856b7f8..134bf44db6 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -33,7 +33,6 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
 
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -43,7 +42,6 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 
 static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -66,7 +64,6 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
 
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -85,7 +82,6 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
 
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -104,7 +100,6 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
 
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -152,7 +147,6 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
 
 static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b77889de7f..f9f16faee4 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -834,11 +834,15 @@ int test_precopy_common(MigrateCommon *args)
     void *data_hook = NULL;
     QObject *channels = NULL;
 
-    if (!args->listen_uri) {
+    assert(!args->connect_uri);
+
+    if (args->listen_uri) {
+        args->connect_uri = args->listen_uri;
+    } else {
         args->listen_uri = "tcp:127.0.0.1:0";
     }
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -846,6 +850,8 @@ int test_precopy_common(MigrateCommon *args)
         data_hook = args->start_hook(from, to);
     }
 
+    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
         wait_for_serial("src_serial");
@@ -943,7 +949,6 @@ void test_precopy_unix_common(MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
     args->listen_uri = uri;
-    args->connect_uri = uri;
     test_precopy_common(args);
 }
 
@@ -1064,10 +1069,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
 {
     migrate_set_parameter_str(from, "multifd-compression", method);
     migrate_set_parameter_str(to, "multifd-compression", method);
-
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
-
     return NULL;
 }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 0d538bcd1a..05e5bee48d 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -162,7 +162,6 @@ static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
     g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
 
     args->listen_uri = uri;
-    args->connect_uri = uri;
 
     test_precopy_common(args);
 }
@@ -214,9 +213,6 @@ static void *migrate_hook_start_fd(QTestState *from,
                                  "  'arguments': { 'fdname': 'fd-mig' }}");
     close(pair[0]);
 
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
-
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
                                  "{ 'execute': 'getfd',"
@@ -257,8 +253,7 @@ static void migrate_hook_end_fd(QTestState *from,
 
 static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
-    args->connect_uri = "fd:fd-mig";
+    args->listen_uri = "fd:fd-mig";
     args->start_hook = migrate_hook_start_fd;
     args->end_hook = migrate_hook_end_fd;
 
@@ -410,7 +405,6 @@ migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
 
 static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     /*
      * Multifd is more complicated than most of the features, it
@@ -426,7 +420,6 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy;
     /*
      * Multifd is more complicated than most of the features, it
@@ -442,7 +435,6 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page;
     /*
      * Multifd is more complicated than most of the features, it
@@ -458,7 +450,6 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     args->live = true;
     args->connect_channels = ("[ { 'channel-type': 'main',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 4a3c404349..275d0b84d4 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -436,8 +436,7 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
-    args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -511,8 +510,6 @@ migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
 
 static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
-    args->connect_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_no_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -544,8 +541,6 @@ static void test_precopy_tcp_tls_x509_override_host(char *name,
 static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
-    args->connect_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -658,7 +653,6 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
 
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
@@ -669,7 +663,6 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
@@ -683,7 +676,6 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
@@ -697,7 +689,6 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -709,7 +700,6 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -734,7 +724,6 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -748,7 +737,6 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -760,7 +748,6 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
-- 
2.51.0


