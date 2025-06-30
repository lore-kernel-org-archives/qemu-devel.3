Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F97C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKgZ-0005x6-RP; Mon, 30 Jun 2025 16:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKgU-0005Ys-Be
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:58 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uWKgR-0007p3-RJ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:00:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FEBB21163;
 Mon, 30 Jun 2025 20:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NoYIazTUb7UYgrEprPOq7hGNgqCYvNkOKEt64gj1Gz4=;
 b=myYFL2WslFFtinQgHJMWM8YJ/ZR0caW2tKtP5LEkYHo0/nqiL677Ro2BXiuCBhKMel6Ga+
 EziW3GXoXawP0Bn4aqw+fdMYgdidN4Ud2Anzr6Rgn6lUF/5FlmZN19q0Pqm/7uMAJ5IpH+
 Tr3LocHuBFNF8jJUVZtHgnTKRGg/WPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NoYIazTUb7UYgrEprPOq7hGNgqCYvNkOKEt64gj1Gz4=;
 b=udjGE/YZyYu1g9vOTvMRz/BZGBokgzK5SfrFcXUKMuNiHyY297SvVujw+xLyIqzpoZe4h8
 AHazBAdcxiWB4yBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751313612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NoYIazTUb7UYgrEprPOq7hGNgqCYvNkOKEt64gj1Gz4=;
 b=myYFL2WslFFtinQgHJMWM8YJ/ZR0caW2tKtP5LEkYHo0/nqiL677Ro2BXiuCBhKMel6Ga+
 EziW3GXoXawP0Bn4aqw+fdMYgdidN4Ud2Anzr6Rgn6lUF/5FlmZN19q0Pqm/7uMAJ5IpH+
 Tr3LocHuBFNF8jJUVZtHgnTKRGg/WPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751313612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NoYIazTUb7UYgrEprPOq7hGNgqCYvNkOKEt64gj1Gz4=;
 b=udjGE/YZyYu1g9vOTvMRz/BZGBokgzK5SfrFcXUKMuNiHyY297SvVujw+xLyIqzpoZe4h8
 AHazBAdcxiWB4yBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29BDA1399F;
 Mon, 30 Jun 2025 20:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6F/0NsnsYmhQUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 30 Jun 2025 20:00:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 24/24] tests/qtest/migration: Pass the migration config to
 file tests
Date: Mon, 30 Jun 2025 16:59:13 -0300
Message-Id: <20250630195913.28033-25-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250630195913.28033-1-farosas@suse.de>
References: <20250630195913.28033-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

Use the existing file tests to test the new way of passing parameters
to the migration via the config argument to qmp_migrate*.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/file-tests.c    | 68 +++++++++++----------------
 tests/qtest/migration/framework.c     |  9 ++--
 tests/qtest/migration/precopy-tests.c |  1 +
 3 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 4d78ce0855..656d6527e8 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -27,6 +27,7 @@ static void test_precopy_file(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
+        .start.config = qdict_new(),
     };
 
     test_file_common(&args, true);
@@ -74,6 +75,7 @@ static void test_precopy_file_offset_fdset(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_file_offset_fdset,
+        .start.config = qdict_new(),
     };
 
     test_file_common(&args, false);
@@ -88,6 +90,7 @@ static void test_precopy_file_offset(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
+        .start.config = qdict_new(),
     };
 
     test_file_common(&args, false);
@@ -102,6 +105,7 @@ static void test_precopy_file_offset_bad(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .result = MIG_TEST_QMP_ERROR,
+        .start.config = qdict_new(),
     };
 
     test_file_common(&args, false);
@@ -114,11 +118,10 @@ static void test_precopy_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
+        .start.config = qdict_new(),
     };
 
+    qdict_put_bool(args.start.config, "mapped-ram", true);
     test_file_common(&args, false);
 }
 
@@ -129,11 +132,9 @@ static void test_precopy_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
+        .start.config = qdict_new(),
     };
-
+    qdict_put_bool(args.start.config, "mapped-ram", true);
     test_file_common(&args, true);
 }
 
@@ -144,12 +145,11 @@ static void test_multifd_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
+        .start.config = qdict_new(),
     };
 
+    qdict_put_bool(args.start.config, "mapped-ram", true);
+    qdict_put_bool(args.start.config, "multifd", true);
     test_file_common(&args, false);
 }
 
@@ -160,24 +160,13 @@ static void test_multifd_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
+        .start.config = qdict_new(),
     };
-
+    qdict_put_bool(args.start.config, "mapped-ram", true);
+    qdict_put_bool(args.start.config, "multifd", true);
     test_file_common(&args, true);
 }
 
-static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
-                                                       QTestState *to)
-{
-    migrate_set_parameter_bool(from, "direct-io", true);
-    migrate_set_parameter_bool(to, "direct-io", true);
-
-    return NULL;
-}
-
 static void test_multifd_file_mapped_ram_dio(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -185,13 +174,13 @@ static void test_multifd_file_mapped_ram_dio(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
+        .start.config = qdict_new(),
     };
 
+    qdict_put_bool(args.start.config, "direct-io", true);
+    qdict_put_bool(args.start.config, "mapped-ram", true);
+    qdict_put_bool(args.start.config, "multifd", true);
+
     if (!probe_o_direct_support(tmpfs)) {
         g_test_skip("Filesystem does not support O_DIRECT");
         return;
@@ -235,9 +224,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, true);
     fdset_add_fds(to, file, O_RDONLY, 2, true);
 
-    migrate_set_parameter_bool(from, "direct-io", true);
-    migrate_set_parameter_bool(to, "direct-io", true);
-
     return NULL;
 }
 
@@ -261,12 +247,11 @@ static void test_multifd_file_mapped_ram_fdset(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
+        .start.config = qdict_new(),
     };
 
+    qdict_put_bool(args.start.config, "mapped-ram", true);
+    qdict_put_bool(args.start.config, "multifd", true);
     test_file_common(&args, true);
 }
 
@@ -279,12 +264,13 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
         .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
+        .start.config = qdict_new(),
     };
 
+    qdict_put_bool(args.start.config, "direct-io", true);
+    qdict_put_bool(args.start.config, "mapped-ram", true);
+    qdict_put_bool(args.start.config, "multifd", true);
+
     if (!probe_o_direct_support(tmpfs)) {
         g_test_skip("Filesystem does not support O_DIRECT");
         return;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 5025299d6a..37c5c884af 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -974,18 +974,21 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{ 'config': %p }",
+                         args->start.config);
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{ 'config': %p }",
+                args->start.config);
     wait_for_migration_complete(from);
 
     /*
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->connect_uri, NULL, "{ 'config': %p }",
+                         args->start.config);
     wait_for_migration_complete(to);
 
     if (stop_src) {
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 35d4274c69..9606dc1d02 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -338,6 +338,7 @@ static void test_precopy_fd_file(void)
         .connect_uri = "fd:fd-mig",
         .start_hook = migrate_hook_start_precopy_fd_file,
         .end_hook = migrate_hook_end_fd,
+        .start.config = qdict_new(),
     };
     test_file_common(&args, true);
 }
-- 
2.35.3


