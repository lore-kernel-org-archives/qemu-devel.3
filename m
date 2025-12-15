Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA72D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfV-0002TW-RI; Mon, 15 Dec 2025 17:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfN-0001Yp-Mr
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:43 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfK-0003Ee-C7
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2068B5BDE8;
 Mon, 15 Dec 2025 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSYehILACAIjOXpISJcVu+gLmJ3cJe6LXzbUoZ3QKhE=;
 b=BolL/ip9nnr5q5xl7jzRng6HFIxonwksmrLwIzkKQl2xv1P6UxAsvdmPqvKXja+KaHAzQo
 X0ulnmKjHAOV7bzQhcp5P7R7Tbg4Ai5VBej6s856TP5FNNCHRUlomobO4jURske9MvTkhE
 vkY69djcXn8MKcW6izV/IputKeeoz98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSYehILACAIjOXpISJcVu+gLmJ3cJe6LXzbUoZ3QKhE=;
 b=nFoY8BFp7fcvIlIGyuvFV+QWwQHGTlihOSe+CKoWmNGqqHwi8sIZsFw6z2XpJtXFfkdZeF
 /cr8Q/uo6bt7HdBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rlniXr0B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pVUB1t0i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSYehILACAIjOXpISJcVu+gLmJ3cJe6LXzbUoZ3QKhE=;
 b=rlniXr0BRm7KJb7RzEch3w2UGjbmLqyaqhA0wWeZEeppdGmqZNhIaoIi5rMq5FdW2cAFgb
 m1BZo8j1NZgvst2hIXfjHgzuVKlpRI1/cC73CrXQypifbSdoCeKnNAG9L4zxEUS7Z0cP8p
 KimqdgcThmQyB5+8V6in+NfKiASmEVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSYehILACAIjOXpISJcVu+gLmJ3cJe6LXzbUoZ3QKhE=;
 b=pVUB1t0iers8/VOOx0aMZUFjsw0UB+LFMcl2HYMjHtoqhp1wFaM4YmaZ5BhpfWirmRnkOX
 t3PbzF+gpcH5nUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06D7B3EA63;
 Mon, 15 Dec 2025 22:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GOl6LoyFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 49/51] tests/qtest/migration: Convert precopy tests to use
 config
Date: Mon, 15 Dec 2025 19:00:35 -0300
Message-ID: <20251215220041.12657-50-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2068B5BDE8
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Make the precopy tests pass a config argument to migration QMP
commands.

Temporarily, set the use-config key to enable the new method.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c |  21 ----
 tests/qtest/migration/cpr-tests.c         |   3 -
 tests/qtest/migration/framework.c         |   5 +-
 tests/qtest/migration/precopy-tests.c     | 111 ++++++++--------------
 tests/qtest/migration/tls-tests.c         |   6 --
 5 files changed, 46 insertions(+), 100 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index ff3386f586..7ecb10d9a8 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -29,9 +29,6 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 
     qdict_put_bool(args->start.config, "multifd", true);
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     test_precopy_common(args);
 }
 
@@ -46,9 +43,6 @@ static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
     qdict_put_int(args->start.config, "multifd-zstd-level", 2);
     qdict_put_str(args->start.config, "multifd-compression", "zstd");
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     test_precopy_common(args);
 }
 #endif /* CONFIG_ZSTD */
@@ -64,9 +58,6 @@ static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
     qdict_put_int(args->start.config, "multifd-qatzip-level", 2);
     qdict_put_str(args->start.config, "multifd-compression", "qatzip");
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     test_precopy_common(args);
 }
 #endif
@@ -81,9 +72,6 @@ static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
     qdict_put_bool(args->start.config, "multifd", true);
     qdict_put_str(args->start.config, "multifd-compression", "qpl");
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     test_precopy_common(args);
 }
 #endif /* CONFIG_QPL */
@@ -98,9 +86,6 @@ static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
     qdict_put_bool(args->start.config, "multifd", true);
     qdict_put_str(args->start.config, "multifd-compression", "uadk");
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     test_precopy_common(args);
 }
 #endif /* CONFIG_UADK */
@@ -121,9 +106,6 @@ static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
     qdict_put_bool(args->start.config, "xbzrle", true);
     qdict_put_int(args->start.config, "xbzrle-cache-size", 33554432);
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     test_precopy_common(args);
 }
 
@@ -141,9 +123,6 @@ static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
     qdict_put_int(args->start.config, "multifd-zlib-level", 2);
     qdict_put_str(args->start.config, "multifd-compression", "zlib");
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     test_precopy_common(args);
 }
 
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index a1b5a39f9f..57199ed3b8 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -88,9 +88,6 @@ static void test_mode_transfer_common(MigrateCommon *args)
 
     qdict_put_str(args->start.config, "mode", "cpr-transfer");
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     if (test_precopy_common(args) < 0) {
         close(cpr_sockfd);
         unlink(cpr_path);
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 6cf2bbf9cc..f596f1c171 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -868,6 +868,9 @@ int test_precopy_common(MigrateCommon *args)
     QObject *in_channels = NULL;
     QObject *out_channels = NULL;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     g_assert(!args->cpr_channel || args->connect_channels);
     if (args->start.incoming_defer) {
         g_assert(args->listen_uri || args->connect_channels);
@@ -951,7 +954,7 @@ int test_precopy_common(MigrateCommon *args)
         qtest_connect(to);
         qtest_qmp_handshake(to, NULL);
         if (args->start.incoming_defer) {
-            migrate_incoming_qmp(to, args->connect_uri, in_channels,
+            migrate_incoming_qmp(to, NULL, in_channels,
                                  args->start.config, "{}");
         }
     }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 01151301ce..f8f46322bc 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -216,8 +216,8 @@ static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
      */
     args->live = true;
 
-    args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] = true;
-    args->start.caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true;
+    qdict_put_bool(args->start.config, "return-path", true);
+    qdict_put_bool(args->start.config, "switchover-ack", true);
 
     test_precopy_common(args);
 }
@@ -365,10 +365,10 @@ static void test_auto_converge(char *name, MigrateCommon *args)
         return;
     }
 
-    migrate_set_capability(from, "auto-converge", true);
-    migrate_set_parameter_int(from, "cpu-throttle-initial", init_pct);
-    migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
-    migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
+    qdict_put_bool(args->start.config, "auto-converge", true);
+    qdict_put_int(args->start.config, "cpu-throttle-initial", init_pct);
+    qdict_put_int(args->start.config, "cpu-throttle-increment", inc_pct);
+    qdict_put_int(args->start.config, "max-cpu-throttle", max_pct);
 
     /*
      * Set the initial parameters so that the migration could not converge
@@ -377,7 +377,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     migrate_ensure_non_converge(from, args->start.config);
 
     /* To check remaining size after precopy */
-    migrate_set_capability(from, "pause-before-switchover", true);
+    qdict_put_bool(args->start.config, "pause-before-switchover", true);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -448,37 +448,8 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     migrate_end(from, to, true);
 }
 
-static void *
-migrate_hook_start_precopy_tcp_multifd(QTestState *from,
-                                       QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return NULL;
-}
-
-static void *
-migrate_hook_start_precopy_tcp_multifd_zero_page_legacy(QTestState *from,
-                                                        QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd(from, to);
-    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
-    return NULL;
-}
-
-static void *
-migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
-                                                    QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd(from, to);
-    migrate_set_parameter_str(from, "zero-page-detection", "none");
-    return NULL;
-}
-
 static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     /*
      * Multifd is more complicated than most of the features, it
      * directly takes guest page buffers when sending, make sure
@@ -488,14 +459,15 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_str(args->start.config, "multifd-compression", "none");
 
     test_precopy_common(args);
 }
 
 static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy;
     /*
      * Multifd is more complicated than most of the features, it
      * directly takes guest page buffers when sending, make sure
@@ -505,14 +477,16 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_str(args->start.config, "multifd-compression", "none");
+    qdict_put_str(args->start.config, "zero-page-detection", "legacy");
 
     test_precopy_common(args);
 }
 
 static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page;
     /*
      * Multifd is more complicated than most of the features, it
      * directly takes guest page buffers when sending, make sure
@@ -522,14 +496,16 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_str(args->start.config, "multifd-compression", "none");
+    qdict_put_str(args->start.config, "zero-page-detection", "none");
 
     test_precopy_common(args);
 }
 
 static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     args->live = true;
     args->connect_channels = ("[ { 'channel-type': 'main',"
                               "    'addr': { 'transport': 'socket',"
@@ -538,7 +514,9 @@ static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
                               "              'port': '0' } } ]");
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_str(args->start.config, "multifd-compression", "none");
 
     test_precopy_common(args);
 }
@@ -558,6 +536,9 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
 {
     QTestState *from, *to, *to2;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     args->start.hide_stderr = true;
     args->start.incoming_defer = true;
 
@@ -569,15 +550,11 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     migrate_prepare_for_dirty_mem(from);
 
     if (postcopy_ram) {
-        migrate_set_capability(from, "postcopy-ram", true);
-        migrate_set_capability(to, "postcopy-ram", true);
+        qdict_put_bool(args->start.config, "postcopy-ram", true);
     }
 
-    migrate_set_parameter_int(from, "multifd-channels", 16);
-    migrate_set_parameter_int(to, "multifd-channels", 16);
-
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
+    qdict_put_int(args->start.config, "multifd-channels", 16);
+    qdict_put_bool(args->start.config, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, args->start.config, "{}");
@@ -615,13 +592,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
         return;
     }
 
-    if (postcopy_ram) {
-        migrate_set_capability(to2, "postcopy-ram", true);
-    }
-
-    migrate_set_parameter_int(to2, "multifd-channels", 16);
-
-    migrate_set_capability(to2, "multifd", true);
+    /* reusing the same config for to2 */
 
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, args->start.config,
@@ -755,12 +726,6 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
                                            const char *uri, const char *phase,
                                            MigrateStart *args)
 {
-    migrate_set_capability(from, "pause-before-switchover", true);
-    migrate_set_capability(to, "pause-before-switchover", true);
-
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
     migrate_incoming_qmp(to, uri, NULL, args->config,
                          "{ 'exit-on-error': false }");
 
@@ -786,6 +751,9 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     args->start.hide_stderr = true;
     args->start.incoming_defer = true;
 
@@ -808,6 +776,10 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
 
     } else {
         /* any state that comes before pre-switchover */
+
+        qdict_put_bool(args->start.config, "pause-before-switchover", true);
+        qdict_put_bool(args->start.config, "multifd", true);
+
         test_cancel_src_pre_switchover(from, to, uri, phase, &args->start);
     }
 
@@ -1061,19 +1033,19 @@ static void test_vcpu_dirty_limit(char *name, MigrateCommon *args)
     dirtylimit_stop_vm(vm);
 }
 
-static void migrate_dirty_limit_wait_showup(QTestState *from,
+static void migrate_dirty_limit_wait_showup(QDict *config,
                                             const int64_t period,
                                             const int64_t value)
 {
     /* Enable dirty limit capability */
-    migrate_set_capability(from, "dirty-limit", true);
+    qdict_put_bool(config, "dirty-limit", true);
 
     /* Set dirty limit parameters */
-    migrate_set_parameter_int(from, "x-vcpu-dirty-limit-period", period);
-    migrate_set_parameter_int(from, "vcpu-dirty-limit", value);
+    qdict_put_int(config, "x-vcpu-dirty-limit-period", period);
+    qdict_put_int(config, "vcpu-dirty-limit", value);
 
     /* To check limit rate after precopy */
-    migrate_set_capability(from, "pause-before-switchover", true);
+    qdict_put_bool(config, "pause-before-switchover", true);
 
     /* Wait for the serial output from the source */
     wait_for_serial("src_serial");
@@ -1132,7 +1104,8 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
 
     /* Prepare for dirty limit migration and wait src vm show up */
     migrate_ensure_non_converge(from, args->start.config);
-    migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
+    migrate_dirty_limit_wait_showup(args->start.config, dirtylimit_period,
+                                    dirtylimit_value);
 
     /* Start migrate */
     migrate_qmp(from, to, args->connect_uri, NULL, args->start.config, "{}");
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index b6d436389a..aa5482b823 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -118,9 +118,6 @@ static void test_precopy_tls_psk_common(MigrateCommon *args,
 {
     TestMigrateTLSPSKData *data = g_new0(TestMigrateTLSPSKData, 1);
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     qdict_put_str(args->start.config, "tls-creds", "tlscredspsk0");
 
     migrate_tls_psk_init(args, test_args, data);
@@ -385,9 +382,6 @@ static void test_precopy_tls_x509_common(MigrateCommon *args,
 {
     TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
 
-    /* temporary */
-    qdict_put_bool(args->start.config, "use-config", true);
-
     migrate_tls_x509_init(args, test_args, data);
     test_precopy_common(args);
     migrate_tls_x509_cleanup(data);
-- 
2.51.0


