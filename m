Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46507D778B1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNEb-0001xt-BC; Fri, 23 Jan 2026 14:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEZ-0001xf-SZ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:19 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNEY-0003Tw-5t
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:54:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53A5E5BCCD;
 Fri, 23 Jan 2026 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaiI/AssrYeE/BeFlqJs+cjWEBQJzpqKM0VTCNdISJk=;
 b=SckBUTSg4gJQBMAKz0+ObPuWzk5s6PmudP9FiGHKvLAVjp5ofCwSgcckhL1LvbPFI0WzeK
 KF1+wY+XSJDPJlk3DMPZE0EgHP0cuE42EtErsM3IL4V/5YDkm+bCs8SI5tkb3pDE7NkTF5
 1OH2rijBDvJ5bfnWBY3AR2FZ5IDLqtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaiI/AssrYeE/BeFlqJs+cjWEBQJzpqKM0VTCNdISJk=;
 b=teOA7dfce81qyMyztSjjxB082DIBhfx9n35EIV7+La/ZawtpXHvkMNJepcZnE9KhEwZDQ2
 91evcympvdaaA/Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SckBUTSg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=teOA7dfc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaiI/AssrYeE/BeFlqJs+cjWEBQJzpqKM0VTCNdISJk=;
 b=SckBUTSg4gJQBMAKz0+ObPuWzk5s6PmudP9FiGHKvLAVjp5ofCwSgcckhL1LvbPFI0WzeK
 KF1+wY+XSJDPJlk3DMPZE0EgHP0cuE42EtErsM3IL4V/5YDkm+bCs8SI5tkb3pDE7NkTF5
 1OH2rijBDvJ5bfnWBY3AR2FZ5IDLqtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaiI/AssrYeE/BeFlqJs+cjWEBQJzpqKM0VTCNdISJk=;
 b=teOA7dfce81qyMyztSjjxB082DIBhfx9n35EIV7+La/ZawtpXHvkMNJepcZnE9KhEwZDQ2
 91evcympvdaaA/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F28EB1395E;
 Fri, 23 Jan 2026 19:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uNQPLOLRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 09/36] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
Date: Fri, 23 Jan 2026 16:53:24 -0300
Message-ID: <20260123195352.12850-10-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 53A5E5BCCD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

From: Peter Xu <peterx@redhat.com>

The parameter can be instead passed into the function to avoid polluting
the global address space of MigrateCommon.

Reviewed-by: Prasad Pandit <ppandit@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260114153751.2427172-3-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c      |  7 ++++---
 tests/qtest/migration/framework.h      |  6 ++----
 tests/qtest/migration/postcopy-tests.c | 12 ++++--------
 tests/qtest/migration/tls-tests.c      |  8 ++++----
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 78bd3ec31a..d5240104b1 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -739,7 +739,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to,
 #endif
 }
 
-void test_postcopy_recovery_common(MigrateCommon *args)
+void test_postcopy_recovery_common(MigrateCommon *args,
+                                   PostcopyRecoveryFailStage fail_stage)
 {
     QTestState *from, *to;
     g_autofree char *uri = NULL;
@@ -784,12 +785,12 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
-    if (args->postcopy_recovery_fail_stage) {
+    if (fail_stage) {
         /*
          * Test when a wrong socket specified for recover, and then the
          * ability to kick it out, and continue with a correct socket.
          */
-        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
+        postcopy_recover_fail(from, to, fail_stage);
         /* continue with a good recovery */
     }
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index c180cc3e46..40984d0493 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -229,9 +229,6 @@ typedef struct {
      * refer to existing ones with live=true), or use live=off by default.
      */
     bool live;
-
-    /* Postcopy specific fields */
-    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
 void wait_for_serial(const char *side);
@@ -244,7 +241,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
 
 void test_postcopy_common(MigrateCommon *args);
-void test_postcopy_recovery_common(MigrateCommon *args);
+void test_postcopy_recovery_common(MigrateCommon *args,
+                                   PostcopyRecoveryFailStage fail_stage);
 int test_precopy_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 7ae4d765d7..13a5759655 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -41,30 +41,26 @@ static void test_postcopy_preempt(char *name, MigrateCommon *args)
 
 static void test_postcopy_recovery(char *name, MigrateCommon *args)
 {
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_postcopy_recovery_fail_handshake(char *name,
                                                   MigrateCommon *args)
 {
-    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY;
-
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_RECOVERY);
 }
 
 static void test_postcopy_recovery_fail_reconnect(char *name,
                                                   MigrateCommon *args)
 {
-    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH;
-
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_CHANNEL_ESTABLISH);
 }
 
 static void test_postcopy_preempt_recovery(char *name, MigrateCommon *args)
 {
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 6a20c65104..bf0bb06a29 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -385,7 +385,7 @@ static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
     args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_multifd_postcopy_recovery_tls_psk(char *name,
@@ -396,7 +396,7 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 /* This contains preempt+recovery+tls test altogether */
@@ -407,7 +407,7 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
@@ -419,7 +419,7 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
-- 
2.51.0


