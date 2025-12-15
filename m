Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC683D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGf5-0000OK-J3; Mon, 15 Dec 2025 17:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGf3-0008TU-Et
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:21 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGf1-000359-8b
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4FA45BD2A;
 Mon, 15 Dec 2025 22:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Asv0nckwgRbIXiiEg8gYC5OI3TeaKDkPOJPdSQRaX6o=;
 b=TvVaBPYBkZIuR70fiDUeSMGEVJ81atnZ62IS81kPJbbrsNrqWToshtfaR3XMC6RXa9ijM1
 ClzvrIsWgb13klFNaIQecYxiPl/zkbGp4xq5uTWt6piyyLkOLJHwxYPNZshOyo2nbTTk+h
 13JRRNa14bmnJjvFgYJ5FLFMWnjt3i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Asv0nckwgRbIXiiEg8gYC5OI3TeaKDkPOJPdSQRaX6o=;
 b=j18vZwMASWffzbvzG2rKKvs+IMJnO/kUIlgl+b0WOP8ZuHJNyugG7IF4wwwqF3WOo6KBkE
 c2kAb8folbWnjcBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TvVaBPYB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j18vZwMA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Asv0nckwgRbIXiiEg8gYC5OI3TeaKDkPOJPdSQRaX6o=;
 b=TvVaBPYBkZIuR70fiDUeSMGEVJ81atnZ62IS81kPJbbrsNrqWToshtfaR3XMC6RXa9ijM1
 ClzvrIsWgb13klFNaIQecYxiPl/zkbGp4xq5uTWt6piyyLkOLJHwxYPNZshOyo2nbTTk+h
 13JRRNa14bmnJjvFgYJ5FLFMWnjt3i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Asv0nckwgRbIXiiEg8gYC5OI3TeaKDkPOJPdSQRaX6o=;
 b=j18vZwMASWffzbvzG2rKKvs+IMJnO/kUIlgl+b0WOP8ZuHJNyugG7IF4wwwqF3WOo6KBkE
 c2kAb8folbWnjcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FBB23EA63;
 Mon, 15 Dec 2025 22:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SDg1GH+FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 44/51] tests/qtest/migration: Convert TLS PSK tests to use
 config
Date: Mon, 15 Dec 2025 19:00:30 -0300
Message-ID: <20251215220041.12657-45-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A4FA45BD2A
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

Replace calls to migrate_set_parameters and the usage of args.caps
with the new config object API.

The multifd tests are now the same as the "precopy" tests, only
setting some multifd options, so reuse the precopy code.

Temporarily, set the use-config key to enable the new method.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 72 +++++++++----------------------
 1 file changed, 20 insertions(+), 52 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index abd6bf9281..68304a7af3 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -73,9 +73,6 @@ static void *migrate_hook_start_tls_psk_common(QTestState *from,
                              "                 'dir': %s } }",
                              args->mismatch ? workdiralt : workdir);
 
-    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
-    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
-
     return NULL;
 }
 
@@ -121,6 +118,11 @@ static void test_precopy_tls_psk_common(MigrateCommon *args,
 {
     TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
+    qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
+
     migrate_tls_psk_init(args, test_args, data);
     test_precopy_common(args);
     migrate_tls_psk_cleanup(data);
@@ -497,18 +499,11 @@ static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
     test_precopy_tls_psk_common(args, &tls_psk_mismatch);
 }
 
-static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
-{
-    migrate_set_parameter_null(from, "tls-creds");
-    migrate_set_parameter_null(to, "tls-creds");
-
-    return NULL;
-}
-
 static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_no_tls;
+
+    qdict_put_null(args->start.config, "tls-creds");
 
     test_precopy_common(args);
 }
@@ -614,29 +609,7 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
 
     test_precopy_tls_x509_common(args, &tls_x509_reject_anon_client);
 }
-#endif /* CONFIG_TASN1 */
 
-static void *
-migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
-                                             QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_match);
-}
-
-static void *
-migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
-                                                QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return migrate_hook_start_tls_psk_common(from, to, &tls_psk_mismatch);
-}
-
-#ifdef CONFIG_TASN1
 static void *
 migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
                                                  QTestState *to)
@@ -694,39 +667,34 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
 
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_tls_psk_common(args, &tls_psk_match);
+    qdict_put_str(args->start.config, "multifd-compression", "none");
+    qdict_put_bool(args->start.config, "multifd", true);
+
+    test_precopy_tcp_tls_psk_match(name, args);
 }
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
-    args->result = MIG_TEST_FAIL;
-    args->listen_uri = "tcp:127.0.0.1:0";
-
-    args->start.hide_stderr = true;
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_tls_psk_common(args, &tls_psk_mismatch);
+    qdict_put_str(args->start.config, "multifd-compression", "none");
+    qdict_put_bool(args->start.config, "multifd", true);
+
+    test_precopy_tcp_tls_psk_mismatch(name, args);
 }
 
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
-    test_precopy_tls_psk_common(args, &tls_psk_match);
+    qdict_put_str(args->start.config, "multifd-compression", "none");
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "postcopy-ram", true);
+
+    test_precopy_tcp_tls_psk_match(name, args);
 }
 
 #ifdef CONFIG_TASN1
-- 
2.51.0


