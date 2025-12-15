Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B880D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGez-0007pW-LK; Mon, 15 Dec 2025 17:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGex-0007Xs-NY
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:15 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGev-00033A-O2
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:15 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DD555BDDC;
 Mon, 15 Dec 2025 22:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3EAAXF/t2Le8CLhlGe+/S/F1KCweg+ZNh6980ehknw=;
 b=pu1fH6XzT/bwjoYyHRsqCqkjJS0fj0uMeBbLrwqlqzeHpkzrLBVwk7+pL+m/+YqM2gudHn
 qND3kyMt+IzdamRaCkXYAxMUADwxHQsOkezsyQ47UC113K+q4L6ZzIWjqn+DQyUt+/muw/
 eum/I3O8qdeM4y9drlzB+DU/UUdv3KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3EAAXF/t2Le8CLhlGe+/S/F1KCweg+ZNh6980ehknw=;
 b=z+M0yXay1/id/ssi0USQXhI4QvTA1ASJY0kEn4EzTayjGvlFQAHV9Cu5Fez3YATmR/mg8e
 Bfxq8I2Gu0+6kICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3EAAXF/t2Le8CLhlGe+/S/F1KCweg+ZNh6980ehknw=;
 b=pu1fH6XzT/bwjoYyHRsqCqkjJS0fj0uMeBbLrwqlqzeHpkzrLBVwk7+pL+m/+YqM2gudHn
 qND3kyMt+IzdamRaCkXYAxMUADwxHQsOkezsyQ47UC113K+q4L6ZzIWjqn+DQyUt+/muw/
 eum/I3O8qdeM4y9drlzB+DU/UUdv3KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3EAAXF/t2Le8CLhlGe+/S/F1KCweg+ZNh6980ehknw=;
 b=z+M0yXay1/id/ssi0USQXhI4QvTA1ASJY0kEn4EzTayjGvlFQAHV9Cu5Fez3YATmR/mg8e
 Bfxq8I2Gu0+6kICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 187B23EA63;
 Mon, 15 Dec 2025 22:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ECfIMnyFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 43/51] tests/qtest/migration: Convert postcopy tests to use
 config
Date: Mon, 15 Dec 2025 19:00:29 -0300
Message-ID: <20251215220041.12657-44-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.987];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Make the postcopy tests (including TLS) pass a config argument to
migration QMP commands.

Temporarily, set the use-config key to enable the new method.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c      | 10 ++++++++--
 tests/qtest/migration/postcopy-tests.c | 10 +++++-----
 tests/qtest/migration/tls-tests.c      | 14 +++++++++-----
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index ecfeee570e..8f179ea2fa 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -582,8 +582,8 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     QObject *channels;
 
     /* set postcopy capabilities */
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+    qdict_put_bool(args->start.config, "postcopy-blocktime", true);
+    qdict_put_bool(args->start.config, "postcopy-ram", true);
 
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
@@ -652,6 +652,9 @@ void test_postcopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     if (migrate_postcopy_prepare(&from, &to, args)) {
         return;
     }
@@ -785,6 +788,9 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     QTestState *from, *to;
     g_autofree char *uri = NULL;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     /*
      * Always enable OOB QMP capability for recovery tests, migrate-recover is
      * executed out-of-band
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 7ae4d765d7..5136a26abd 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -34,7 +34,7 @@ static void test_postcopy_suspend(char *name, MigrateCommon *args)
 
 static void test_postcopy_preempt(char *name, MigrateCommon *args)
 {
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+    qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_common(args);
 }
@@ -62,7 +62,7 @@ static void test_postcopy_recovery_fail_reconnect(char *name,
 
 static void test_postcopy_preempt_recovery(char *name, MigrateCommon *args)
 {
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+    qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_recovery_common(args);
 }
@@ -80,15 +80,15 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
 
 static void test_multifd_postcopy(char *name, MigrateCommon *args)
 {
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    qdict_put_bool(args->start.config, "multifd", true);
 
     test_postcopy_common(args);
 }
 
 static void test_multifd_postcopy_preempt(char *name, MigrateCommon *args)
 {
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_common(args);
 }
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 5f561bc602..abd6bf9281 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -131,6 +131,8 @@ static void test_postcopy_tls_psk_common(MigrateCommon *args,
 {
     TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
 
+    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
+
     migrate_tls_psk_init(args, test_args, data);
     test_postcopy_common(args);
     migrate_tls_psk_cleanup(data);
@@ -141,6 +143,8 @@ static void test_postcopy_recovery_tls_psk_common(MigrateCommon *args,
 {
     TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
 
+    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
+
     migrate_tls_psk_init(args, test_args, data);
     test_postcopy_recovery_common(args);
     migrate_tls_psk_cleanup(data);
@@ -382,7 +386,7 @@ static void test_postcopy_preempt_tls_psk(char *name, MigrateCommon *args)
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
 
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+    qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_tls_psk_common(args, &tls_psk_match);
 }
@@ -401,7 +405,7 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
 
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    qdict_put_bool(args->start.config, "multifd", true);
 
     test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
@@ -412,7 +416,7 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
 
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+    qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
@@ -423,8 +427,8 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
     args->start_hook_full = migrate_hook_start_tls_psk_common;
     args->start_hook_data = &tls_psk_match;
 
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "postcopy-preempt", true);
 
     test_postcopy_recovery_tls_psk_common(args, &tls_psk_match);
 }
-- 
2.51.0


