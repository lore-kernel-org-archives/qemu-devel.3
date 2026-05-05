Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49FECD3441
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIM3-0008Pt-V3; Tue, 05 May 2026 12:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILI-00080E-R2
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:53 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILG-00086L-I9
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 059276B763;
 Tue,  5 May 2026 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ih7EP1hGcdM62oFC55Hb51YORj/ldUEDXIPDlWObwhA=;
 b=DjSRJyc11thmgaRCfBShXIXbYY52q9XxP56zUX8ocUfOWD+mA4Mcv/CEokCuCouyeOrz0P
 yiHwOpD4psDztGDjarCO0kK5MjOIjAVZ/uwDIFh8bk4dLBiuyYRUbMrPVpZX8BY9VF/Jxn
 2ev84Bqu/rhPnAZDKIbr+XDzvCn/Er8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ih7EP1hGcdM62oFC55Hb51YORj/ldUEDXIPDlWObwhA=;
 b=J2tyBysP5BP5xsqKOjN1SXlvYbwVbcK5bxIeyeG+hrgbIpdMu9mJC5QqWT6ElL8tjETuaV
 +7em3ixod9ram5DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ih7EP1hGcdM62oFC55Hb51YORj/ldUEDXIPDlWObwhA=;
 b=DjSRJyc11thmgaRCfBShXIXbYY52q9XxP56zUX8ocUfOWD+mA4Mcv/CEokCuCouyeOrz0P
 yiHwOpD4psDztGDjarCO0kK5MjOIjAVZ/uwDIFh8bk4dLBiuyYRUbMrPVpZX8BY9VF/Jxn
 2ev84Bqu/rhPnAZDKIbr+XDzvCn/Er8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997368;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ih7EP1hGcdM62oFC55Hb51YORj/ldUEDXIPDlWObwhA=;
 b=J2tyBysP5BP5xsqKOjN1SXlvYbwVbcK5bxIeyeG+hrgbIpdMu9mJC5QqWT6ElL8tjETuaV
 +7em3ixod9ram5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6F49593A3;
 Tue,  5 May 2026 16:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iGJfKTYW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 03/15] tests/qtest/migration: Set file URI by default
Date: Tue,  5 May 2026 13:09:02 -0300
Message-ID: <20260505160915.25558-4-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
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

Most file: tests use the same URI. Make it a default in the common
function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/file-tests.c | 29 -----------------------------
 tests/qtest/migration/framework.c  |  6 ++++++
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 75135447f8..4b6a2eeb7b 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -67,9 +67,6 @@ static void test_file_connect_outgoing_fd_leak(char *name, MigrateCommon *args)
 
 static void test_precopy_file(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
     test_file_common(args, true);
 }
 
@@ -142,11 +139,6 @@ static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
 
 static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, false);
@@ -154,11 +146,6 @@ static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
 
 static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, true);
@@ -166,10 +153,6 @@ static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
 
 static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -178,11 +161,6 @@ static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
 
 static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -200,9 +178,6 @@ static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
 
 static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -316,10 +291,6 @@ static void migration_test_add_file_smoke(MigrationTestEnv *env)
 static void
 test_precopy_file_mapped_ram_ignore_shared(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index edd3d0b165..42f565af7b 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -971,11 +971,17 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     QTestState *from, *to;
     void *data_hook = NULL;
     bool check_offset = false;
+    g_autofree char *uri = NULL;
 
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
+    if (!args->connect_uri) {
+        uri = g_strdup_printf("file:%s/%s", tmpfs, FILE_TEST_FILENAME);
+        args->connect_uri = uri;
+    }
+
     /*
      * File migration is never live. We can keep the source VM running
      * during migration, but the destination will not be running
-- 
2.51.0


