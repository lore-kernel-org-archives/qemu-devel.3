Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0379BFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKILT-00086G-4M; Tue, 05 May 2026 12:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIKx-0007oF-FD
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:36 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIKu-0007IC-OS
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75CFF5CAF0;
 Tue,  5 May 2026 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X3ByejEazZO/IkJ6RU0S63fNUcklMp24fSVi0bmCsk=;
 b=vcBZUgYPOU0S4z02ZV02P7FKukVQUv9tjEHwGdabqyA2x4/1xuFlQn19VGaA7BLmnuffUD
 oXyjtgqfLNDnu+eA6W9C8Ou+AAYpkmWfBpm9uB/+prCYqjxyM6pMjNpIpRtzWx0qOneFGw
 tcjXtw+XeG24SsUjiZHslDcuT1X3Vvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X3ByejEazZO/IkJ6RU0S63fNUcklMp24fSVi0bmCsk=;
 b=ojyGKt2eT1Wi8AASiB0METQsDmIC/jXxI8fPP3C8sb492yfQjdeJ1wOKouUWICC4suZigC
 6EEZ9g3C3pHpuCAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X3ByejEazZO/IkJ6RU0S63fNUcklMp24fSVi0bmCsk=;
 b=vcBZUgYPOU0S4z02ZV02P7FKukVQUv9tjEHwGdabqyA2x4/1xuFlQn19VGaA7BLmnuffUD
 oXyjtgqfLNDnu+eA6W9C8Ou+AAYpkmWfBpm9uB/+prCYqjxyM6pMjNpIpRtzWx0qOneFGw
 tcjXtw+XeG24SsUjiZHslDcuT1X3Vvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X3ByejEazZO/IkJ6RU0S63fNUcklMp24fSVi0bmCsk=;
 b=ojyGKt2eT1Wi8AASiB0METQsDmIC/jXxI8fPP3C8sb492yfQjdeJ1wOKouUWICC4suZigC
 6EEZ9g3C3pHpuCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB464593A3;
 Tue,  5 May 2026 16:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OHVHLjQW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 02/15] tests/qtest/migration: Make file-tests defer by
 default
Date: Tue,  5 May 2026 13:09:01 -0300
Message-ID: <20260505160915.25558-3-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

All file: tests use listen_uri="defer". Make this the default in the
common function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c  |  1 -
 tests/qtest/migration/file-tests.c | 14 --------------
 tests/qtest/migration/framework.c  |  2 +-
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 48c98f0089..18217f0460 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -36,7 +36,6 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_mode_reboot;
 
     args->start.mem_type = MEM_TYPE_SHMEM;
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index fef172068f..75135447f8 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -70,8 +70,6 @@ static void test_precopy_file(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
-
     test_file_common(args, true);
 }
 
@@ -114,7 +112,6 @@ static void test_precopy_file_offset_fdset(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_file_offset_fdset;
 
     test_file_common(args, false);
@@ -128,8 +125,6 @@ static void test_precopy_file_offset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
-
     test_file_common(args, false);
 }
 
@@ -140,7 +135,6 @@ static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
                                            tmpfs, FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->result = MIG_TEST_QMP_ERROR;
 
     test_file_common(args, false);
@@ -152,7 +146,6 @@ static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -165,7 +158,6 @@ static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -177,7 +169,6 @@ static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -191,7 +182,6 @@ static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -213,7 +203,6 @@ static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -285,7 +274,6 @@ static void test_multifd_file_mapped_ram_fdset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
@@ -301,7 +289,6 @@ static void test_multifd_file_mapped_ram_fdset_dio(char *name,
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
@@ -332,7 +319,6 @@ test_precopy_file_mapped_ram_ignore_shared(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4ef5e1de83..edd3d0b165 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -972,7 +972,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     void *data_hook = NULL;
     bool check_offset = false;
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
-- 
2.51.0


