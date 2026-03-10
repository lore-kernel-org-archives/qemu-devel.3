Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0E7FD2D98
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxYx-00046F-MY; Tue, 10 Mar 2026 09:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxYw-00045z-KF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:55:54 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxYt-0006t3-I9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:55:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F32B5BCFA;
 Tue, 10 Mar 2026 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzFc0sJm0VL3gSCQNRA9UoEuGs5962iSYyeolg1j+wc=;
 b=LCTHNF/gI9rhh+G8R0aC+OSCK5S6/pTn89Ad02WXlIct5M/LWxhMzGm8bmtXVrHNbOkRaE
 97B3QEnOUjB1hOtAt6ruXkxR0Uw3x8KeF3SWIDOsB7T57PoiSlxBP3hr0H8mG01/X68J6K
 02t4CFjwkUnq0rMEKOAMNomDk/mG5hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzFc0sJm0VL3gSCQNRA9UoEuGs5962iSYyeolg1j+wc=;
 b=6RLTfIZe7tuXFluzqD+IlczjYwJZCOSFiwRNi01gfBj4fRl66YO34+3TABFwiYROQupUlt
 vDlTs26cbNU6f3Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzFc0sJm0VL3gSCQNRA9UoEuGs5962iSYyeolg1j+wc=;
 b=LCTHNF/gI9rhh+G8R0aC+OSCK5S6/pTn89Ad02WXlIct5M/LWxhMzGm8bmtXVrHNbOkRaE
 97B3QEnOUjB1hOtAt6ruXkxR0Uw3x8KeF3SWIDOsB7T57PoiSlxBP3hr0H8mG01/X68J6K
 02t4CFjwkUnq0rMEKOAMNomDk/mG5hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzFc0sJm0VL3gSCQNRA9UoEuGs5962iSYyeolg1j+wc=;
 b=6RLTfIZe7tuXFluzqD+IlczjYwJZCOSFiwRNi01gfBj4fRl66YO34+3TABFwiYROQupUlt
 vDlTs26cbNU6f3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 512183F4B3;
 Tue, 10 Mar 2026 13:55:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SONGBuMisGnFcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 13:55:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: [PATCH 3/8] tests/qtest/migration: Fix misuse of listen_uri
Date: Tue, 10 Mar 2026 10:55:35 -0300
Message-ID: <20260310135540.8679-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310135540.8679-1-farosas@suse.de>
References: <20260310135540.8679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.984];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linaro.org,redhat.com,web.de,oracle.com,akamai.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The listen_uri parameter is supposed to be used for the incoming
migration while connect_uri for the outgoing migration. This is well
documented in the header file.

However, due to -incoming "defer", some tests set listen-uri =
"defer", which is fine. But then, being without another parameter to
define the uri to be use in migrate_incoming, some tests have been
misusing connect_uri.

Add a separate flag to denote "defer" and spare the tests from passing
the string. Change the usage of listen_uri to it's original purpose.

Link: https://lore.kernel.org/qemu-devel/20251215220041.12657-28-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/colo-tests.c        |  4 ++-
 tests/qtest/migration/compression-tests.c | 12 +++----
 tests/qtest/migration/cpr-tests.c         | 20 +++++++----
 tests/qtest/migration/file-tests.c        | 41 ++++++++++++++++-------
 tests/qtest/migration/framework.c         | 12 +++----
 tests/qtest/migration/framework.h         |  7 ++++
 tests/qtest/migration/misc-tests.c        |  4 +--
 tests/qtest/migration/precopy-tests.c     | 14 +++++---
 tests/qtest/migration/tls-tests.c         | 16 ++++-----
 9 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index ef880f5114..7c438c196b 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -116,9 +116,11 @@ static void test_colo_multifd_common(MigrateCommon *args,
                                      bool failover_during_checkpoint,
                                      bool primary_failover)
 {
-    args->listen_uri = "defer";
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = hook_start_multifd;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.incoming_defer = true;
+
     test_colo_common(args, failover_during_checkpoint, primary_failover);
 }
 
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 845e622cd5..eb0b7d6b4b 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -33,9 +33,9 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
 
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -43,9 +43,9 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 
 static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
@@ -66,9 +66,9 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
 
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -85,9 +85,9 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
 
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -104,9 +104,9 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
 
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -156,9 +156,9 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
 
 static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0d97b5b89f..1b3d42e51c 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -32,10 +32,11 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
 
+    args->listen_uri = uri;
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_mode_reboot;
 
+    args->start.incoming_defer = true;
     args->start.mem_type = MEM_TYPE_SHMEM;
     args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
 
@@ -53,7 +54,7 @@ static void *test_mode_transfer_start(QTestState *from, QTestState *to)
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
@@ -84,7 +85,11 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
                                   "addr.type=fd,addr.str=%d %s",
                                   cpr_sockfd, opts);
 
-    args->listen_uri = incoming_defer ? "defer" : uri;
+    /*
+     * The URI is used only for the deferred target connection when
+     * !incoming_defer.
+     */
+    args->listen_uri = uri;
     args->connect_channels = connect_channels;
     args->cpr_channel = cpr_channel;
     args->start_hook = test_mode_transfer_start;
@@ -102,12 +107,14 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    args->start.incoming_defer = false;
+    test_mode_transfer_common(args);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    args->start.incoming_defer = true;
+    test_mode_transfer_common(args);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -227,11 +234,10 @@ static void test_mode_exec(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    g_autofree char *listen_uri = g_strdup_printf("defer");
 
     args->connect_uri = uri;
-    args->listen_uri = listen_uri;
     args->start_hook = test_mode_exec_start;
+    args->start.incoming_defer = true;
 
     args->start.only_source = true;
     args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 5d1b861cf6..7597ff7552 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -25,7 +25,9 @@ static void test_precopy_file(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
+
+    args->start.incoming_defer = true;
 
     test_file_common(args, true);
 }
@@ -69,9 +71,11 @@ static void test_precopy_file_offset_fdset(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_file_offset_fdset;
 
+    args->start.incoming_defer = true;
+
     test_file_common(args, false);
 }
 #endif
@@ -83,7 +87,9 @@ static void test_precopy_file_offset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
+
+    args->start.incoming_defer = true;
 
     test_file_common(args, false);
 }
@@ -95,9 +101,11 @@ static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
                                            tmpfs, FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->result = MIG_TEST_QMP_ERROR;
 
+    args->start.incoming_defer = true;
+
     test_file_common(args, false);
 }
 
@@ -107,8 +115,9 @@ static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, false);
@@ -120,8 +129,9 @@ static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, true);
@@ -132,8 +142,9 @@ static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -146,8 +157,9 @@ static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -168,9 +180,10 @@ static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
@@ -240,10 +253,11 @@ static void test_multifd_file_mapped_ram_fdset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
@@ -255,11 +269,13 @@ static void test_multifd_file_mapped_ram_fdset_dio(char *name,
 {
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
+
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
@@ -286,8 +302,9 @@ test_precopy_file_mapped_ram_ignore_shared(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
+    args->listen_uri = uri;
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->start.incoming_defer = true;
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b9371372de..75605d1791 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -428,7 +428,8 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_backend, tmpfs, uri,
+                                 memory_backend, tmpfs,
+                                 args->incoming_defer ? "defer" : uri,
                                  events,
                                  arch_opts ? arch_opts : "",
                                  args->opts_target ? args->opts_target : "",
@@ -873,8 +874,7 @@ int test_precopy_common(MigrateCommon *args)
      * migrate-incoming channels.
      */
     if (args->connect_channels) {
-        if (args->start.defer_target_connect &&
-            !strcmp(args->listen_uri, "defer")) {
+        if (args->start.defer_target_connect && args->start.incoming_defer) {
             in_channels = qobject_from_json(args->connect_channels,
                                             &error_abort);
         }
@@ -898,8 +898,8 @@ int test_precopy_common(MigrateCommon *args)
     if (args->start.defer_target_connect) {
         qtest_connect(to);
         qtest_qmp_handshake(to, NULL);
-        if (!strcmp(args->listen_uri, "defer")) {
-            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
+        if (args->start.incoming_defer) {
+            migrate_incoming_qmp(to, NULL, in_channels, "{}");
         }
     }
 
@@ -1048,7 +1048,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 80eef75893..f920735d05 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -145,6 +145,13 @@ typedef struct {
      * migration_set_capabilities().
      */
     bool caps[MIGRATION_CAPABILITY__MAX];
+
+    /*
+     * Whether to use "defer" as the uri for the -incoming command
+     * line option. If set to true, MigrateCommon.listen_uri will be
+     * used for the deferred migrate_incoming call.
+     */
+    bool incoming_defer;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 06da2657d5..a1704755d9 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -217,7 +217,6 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
 
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer",
     args->connect_uri = "tcp:127.0.0.1:0",
     args->connect_channels = ("[ { ""'channel-type': 'main',"
                               "    'addr': { 'transport': 'socket',"
@@ -225,6 +224,7 @@ static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
                               "              'host': '127.0.0.1',"
                               "              'port': '0' } } ]"),
 
+    args->start.incoming_defer = true;
     args->start.hide_stderr = true;
 
     do_test_validate_uri_channel(args);
@@ -232,8 +232,8 @@ static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 
 static void test_validate_uri_channels_none_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
 
     do_test_validate_uri_channel(args);
 }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index f17dc5176d..31fd4af1ad 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -282,11 +282,12 @@ static void migrate_hook_end_fd(QTestState *from,
 
 static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->connect_uri = "fd:fd-mig";
     args->start_hook = migrate_hook_start_fd;
     args->end_hook = migrate_hook_end_fd;
 
+    args->start.incoming_defer = true;
+
     test_precopy_common(args);
 }
 #endif /* _WIN32 */
@@ -435,7 +436,6 @@ migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
 
 static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     /*
      * Multifd is more complicated than most of the features, it
@@ -444,6 +444,7 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
      */
     args->live = true;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -451,7 +452,6 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy;
     /*
      * Multifd is more complicated than most of the features, it
@@ -460,6 +460,7 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
      */
     args->live = true;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -467,7 +468,6 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page;
     /*
      * Multifd is more complicated than most of the features, it
@@ -476,6 +476,7 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
      */
     args->live = true;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -483,7 +484,6 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     args->live = true;
     args->connect_channels = ("[ { 'channel-type': 'main',"
@@ -492,6 +492,7 @@ static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
                              "              'host': '127.0.0.1',"
                               "              'port': '0' } } ]");
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -513,6 +514,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     QTestState *from, *to, *to2;
 
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
 
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
@@ -560,6 +562,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     wait_for_migration_status(from, "cancelled", NULL);
 
     args->start.only_target = true;
+    args->start.incoming_defer = true;
 
     if (migrate_start(&from, &to2, "defer", &args->start)) {
         return;
@@ -734,6 +737,7 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
     QTestState *from, *to;
 
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
 
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 4ce7f6c676..40a78bd2d2 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -673,10 +673,10 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
 
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -684,12 +684,12 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -698,10 +698,10 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
@@ -712,10 +712,10 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -724,10 +724,10 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -749,11 +749,11 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
+    args->start.incoming_defer = true;
     args->start.hide_stderr = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
@@ -763,10 +763,10 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -775,11 +775,11 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
+    args->start.incoming_defer = true;
     args->start.hide_stderr = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-- 
2.51.0


