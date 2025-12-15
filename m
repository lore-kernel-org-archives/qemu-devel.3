Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6F2D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfU-0002LK-CR; Mon, 15 Dec 2025 17:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfP-0001Zb-Pi
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:44 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfO-0003Kr-2M
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 435103381A;
 Mon, 15 Dec 2025 22:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvL4BBSmoKDumAmp6JVFT+bkUw/pD2BkaKKn388vg9Q=;
 b=tj8nHKXlfxcGAnWXapFZnV2L8inDLmzDSYNWK0C+Roq/o+8wMcCOEowiWmyDAPdreIkHjw
 IDxjGVUWbI5wGOnxwWIO/kxDruVAjEVeO35R1mWXb7R6k6aRwXsu57/hbNkOhwdLWiFK+a
 vtz8LOm64LVZh17+l9PIodZQFwPvo4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvL4BBSmoKDumAmp6JVFT+bkUw/pD2BkaKKn388vg9Q=;
 b=pqP8twu5qcYSHAHGF8iLZHTctvewzSjhmkYASSvJf/IadRQAX3c1+GBQQERLIwCcQwCSWX
 Vcz770XeVRruUOAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nDewrYoq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gGDqDyyX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvL4BBSmoKDumAmp6JVFT+bkUw/pD2BkaKKn388vg9Q=;
 b=nDewrYoqHKQXjeNTKnLYPa//Bm6KEr0ofKKPYqCKK6CZ0vi5xgFQRUoqtqNI0Adkzvi1x5
 pOkGwgipyPyziMq4uevmGqHhSc2PmtLDg247Ap1xYZhJwpQd+3OGOukNCLnNBBHYNeLGQI
 uxdNA5rO77MqIg9DunPfCot9kZvfbL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mvL4BBSmoKDumAmp6JVFT+bkUw/pD2BkaKKn388vg9Q=;
 b=gGDqDyyXQYB+cTHFrOkxR5J8f8VdxBlU2RYQTHkjf24ZOUUHa0jhPlVGxfwzaSU0iXN9MG
 XTJAF1bHIxLtnrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAAFB3EA63;
 Mon, 15 Dec 2025 22:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4LyNKoSFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 46/51] tests/qtest/migration: Convert compression tests to
 use config
Date: Mon, 15 Dec 2025 19:00:32 -0300
Message-ID: <20251215220041.12657-47-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 435103381A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Make the compression tests pass a config argument to migration QMP
commands.

Temporarily, set the use-config key to enable the new method.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c | 132 ++++++++--------------
 1 file changed, 47 insertions(+), 85 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index be60981f66..ff3386f586 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -21,26 +21,16 @@
 static char *tmpfs;
 
 #ifdef CONFIG_ZSTD
-static void *
-migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
-                                            QTestState *to)
-{
-    migrate_set_parameter_int(from, "multifd-zstd-level", 2);
-    migrate_set_parameter_int(to, "multifd-zstd-level", 2);
-
-    migrate_set_parameter_str(from, "multifd-compression", "zstd");
-    migrate_set_parameter_str(to, "multifd-compression", "zstd");
-
-    return NULL;
-}
-
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
 
     test_precopy_common(args);
 }
@@ -48,103 +38,79 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "postcopy-ram", true);
+    qdict_put_int(args->start.config, "multifd-zstd-level", 2);
+    qdict_put_str(args->start.config, "multifd-compression", "zstd");
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
 
     test_precopy_common(args);
 }
 #endif /* CONFIG_ZSTD */
 
 #ifdef CONFIG_QATZIP
-static void *
-migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
-                                              QTestState *to)
-{
-    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
-    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
-
-    migrate_set_parameter_str(from, "multifd-compression", "qatzip");
-    migrate_set_parameter_str(to, "multifd-compression", "qatzip");
-
-    return NULL;
-}
-
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_int(args->start.config, "multifd-qatzip-level", 2);
+    qdict_put_str(args->start.config, "multifd-compression", "qatzip");
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
 
     test_precopy_common(args);
 }
 #endif
 
 #ifdef CONFIG_QPL
-static void *
-migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
-                                           QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "qpl");
-    migrate_set_parameter_str(to, "multifd-compression", "qpl");
-
-    return NULL;
-}
-
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_str(args->start.config, "multifd-compression", "qpl");
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
 
     test_precopy_common(args);
 }
 #endif /* CONFIG_QPL */
 
 #ifdef CONFIG_UADK
-static void *
-migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
-                                            QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "uadk");
-    migrate_set_parameter_str(to, "multifd-compression", "uadk");
-
-    return NULL;
-}
-
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_str(args->start.config, "multifd-compression", "uadk");
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
 
     test_precopy_common(args);
 }
 #endif /* CONFIG_UADK */
 
-static void *
-migrate_hook_start_xbzrle(QTestState *from,
-                          QTestState *to)
-{
-    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
-    return NULL;
-}
-
 static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook = migrate_hook_start_xbzrle;
     args->iterations = 2;
     /*
      * XBZRLE needs pages to be modified when doing the 2nd+ round
@@ -152,35 +118,31 @@ static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
      */
     args->live = true;
 
-    args->start.caps[MIGRATION_CAPABILITY_XBZRLE] = true;
+    qdict_put_bool(args->start.config, "xbzrle", true);
+    qdict_put_int(args->start.config, "xbzrle-cache-size", 33554432);
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
 
     test_precopy_common(args);
 }
 
-static void *
-migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
-                                            QTestState *to)
+static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
 {
+    args->listen_uri = "tcp:127.0.0.1:0";
+
+    args->start.incoming_defer = true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
     /*
      * Overloading this test to also check that set_parameter does not error.
      * This is also done in the tests for the other compression methods.
      */
-    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
-    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+    qdict_put_int(args->start.config, "multifd-zlib-level", 2);
+    qdict_put_str(args->start.config, "multifd-compression", "zlib");
 
-    migrate_set_parameter_str(from, "multifd-compression", "zlib");
-    migrate_set_parameter_str(to, "multifd-compression", "zlib");
-
-    return NULL;
-}
-
-static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
-{
-    args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
-
-    args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
 
     test_precopy_common(args);
 }
-- 
2.51.0


