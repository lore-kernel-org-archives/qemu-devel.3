Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17088D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGf8-0000jR-UP; Mon, 15 Dec 2025 17:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGf4-0000HT-Nr
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:22 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGf2-000376-Fi
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:22 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59ED5337EB;
 Mon, 15 Dec 2025 22:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Kn2aTgGJ/0MobWDmu5uyVQfyYGUwkYy/He+BUbCRl0=;
 b=yewJ7lJSd4CbD88zznGvSYzJnOl1kUcd7hudYNvHUvAuR3Z//Qkl9fGSSOyEwhusMq91/U
 DR8536I5bBKQlLF0iQ5ysAOadDtbbs6jFo24ttdjhsnBJsDis5N0aTxi7C8CFSwulkkL+i
 pkG9udAYYYmY2ec87tH9blv5nTYxRZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Kn2aTgGJ/0MobWDmu5uyVQfyYGUwkYy/He+BUbCRl0=;
 b=jpyuqTklv01LlKSn0+utl2A+qbqlpJXTANzobq8kuEVZjcIhBwHdXMIA+fIxkc0WR87u+c
 u/muico3gltZcJBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Kn2aTgGJ/0MobWDmu5uyVQfyYGUwkYy/He+BUbCRl0=;
 b=yewJ7lJSd4CbD88zznGvSYzJnOl1kUcd7hudYNvHUvAuR3Z//Qkl9fGSSOyEwhusMq91/U
 DR8536I5bBKQlLF0iQ5ysAOadDtbbs6jFo24ttdjhsnBJsDis5N0aTxi7C8CFSwulkkL+i
 pkG9udAYYYmY2ec87tH9blv5nTYxRZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836151;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Kn2aTgGJ/0MobWDmu5uyVQfyYGUwkYy/He+BUbCRl0=;
 b=jpyuqTklv01LlKSn0+utl2A+qbqlpJXTANzobq8kuEVZjcIhBwHdXMIA+fIxkc0WR87u+c
 u/muico3gltZcJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 518483EA63;
 Mon, 15 Dec 2025 22:02:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QERKBHWFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 40/51] tests/qtest/migration: TLS PSK: Refactor to use full
 hook
Date: Mon, 15 Dec 2025 19:00:26 -0300
Message-ID: <20251215220041.12657-41-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Similar to what's been done with the TLS x509 tests, pass an object in
to the TLS PSK common hook so a couple of extra hooks can be removed,
making the code easier to follow.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 64 +++++++++++++++++--------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 6a858b766f..2eeed1fc5b 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -30,13 +30,26 @@ struct TestMigrateTLSPSKData {
     char *pskfilealt;
 };
 
+typedef struct {
+    bool mismatch;
+} TestMigrateTLSPSK;
+
+static TestMigrateTLSPSK tls_psk_match = {
+    .mismatch = false,
+};
+
+static TestMigrateTLSPSK tls_psk_mismatch = {
+    .mismatch = true,
+};
+
 static char *tmpfs;
 
 static void *
 migrate_hook_start_tls_psk_common(QTestState *from,
                                   QTestState *to,
-                                  bool mismatch)
+                                  void *opaque)
 {
+    TestMigrateTLSPSK *args = opaque;
     struct TestMigrateTLSPSKData *data =
         g_new0(struct TestMigrateTLSPSKData, 1);
 
@@ -46,7 +59,7 @@ migrate_hook_start_tls_psk_common(QTestState *from,
     g_mkdir_with_parents(data->workdir, 0700);
     test_tls_psk_init(data->pskfile);
 
-    if (mismatch) {
+    if (args->mismatch) {
         data->workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
         data->pskfilealt = g_strdup_printf("%s/%s", data->workdiralt,
                                            QCRYPTO_TLS_CREDS_PSKFILE);
@@ -69,7 +82,7 @@ migrate_hook_start_tls_psk_common(QTestState *from,
                              "                 'id': 'tlscredspsk0',"
                              "                 'endpoint': 'server',"
                              "                 'dir': %s } }",
-                             mismatch ? data->workdiralt : data->workdir);
+                             args->mismatch ? data->workdiralt : data->workdir);
 
     migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
     migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
@@ -77,20 +90,6 @@ migrate_hook_start_tls_psk_common(QTestState *from,
     return data;
 }
 
-static void *
-migrate_hook_start_tls_psk_match(QTestState *from,
-                                 QTestState *to)
-{
-    return migrate_hook_start_tls_psk_common(from, to, false);
-}
-
-static void *
-migrate_hook_start_tls_psk_mismatch(QTestState *from,
-                                    QTestState *to)
-{
-    return migrate_hook_start_tls_psk_common(from, to, true);
-}
-
 static void
 migrate_hook_end_tls_psk(QTestState *from,
                          QTestState *to,
@@ -339,7 +338,8 @@ static void test_precopy_tls_x509_common(MigrateCommon *args,
 
 static void test_postcopy_tls_psk(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     test_postcopy_common(args);
@@ -347,7 +347,8 @@ static void test_postcopy_tls_psk(char *name, MigrateCommon *args)
 
 static void test_postcopy_preempt_tls_psk(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
@@ -357,7 +358,8 @@ static void test_postcopy_preempt_tls_psk(char *name, MigrateCommon *args)
 
 static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     test_postcopy_recovery_common(args);
@@ -366,7 +368,8 @@ static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_recovery_tls_psk(char *name,
                                                    MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -377,7 +380,8 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
 /* This contains preempt+recovery+tls test altogether */
 static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
@@ -388,7 +392,8 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
                                                            MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -403,7 +408,8 @@ static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
 
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     test_precopy_common(args);
@@ -443,7 +449,8 @@ static void test_precopy_unix_tls_x509_override_host(char *name,
 static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     test_precopy_common(args);
@@ -452,7 +459,8 @@ static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_psk_mismatch;
+    args->start_hook_full = migrate_hook_start_tls_psk_common;
+    args->start_hook_data = &tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
 
@@ -589,7 +597,7 @@ migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
                                              QTestState *to)
 {
     migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_psk_match(from, to);
+    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_match);
 }
 
 static void *
@@ -597,7 +605,7 @@ migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
                                                 QTestState *to)
 {
     migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_psk_mismatch(from, to);
+    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_mismatch);
 }
 
 #ifdef CONFIG_TASN1
-- 
2.51.0


