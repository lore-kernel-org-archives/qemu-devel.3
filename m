Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE27D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGev-0007Cj-BI; Mon, 15 Dec 2025 17:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGer-0006kt-9j
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:09 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeo-00031Z-TC
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3853833703;
 Mon, 15 Dec 2025 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfsR4cuI/tt0teFS9a0rpgqNCcAgFFOVh1mZjh5NV7s=;
 b=ZClp95KJxd3ir4Fzaag/4GmGEQd4SKZVsxon1EoVcukJwcjK1WgcVTfO9S28fHODScN5z2
 U6mZaFGSgZ3/Wy/78wPKG1v1+IFyXMbYsUqNbp19xQgi4UXpA7jBbkSNK0O0eXteQiKjRK
 R0OReAC/18kX5cyVguMqc11OPIjYDX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfsR4cuI/tt0teFS9a0rpgqNCcAgFFOVh1mZjh5NV7s=;
 b=BSb5g7f3IDYbuHODG5sl36FzyWhhJlKRkRYVlWF18uY4dI7P4xOtoJs1FqY6WCG7AstDO1
 QIimCXlNhkt/OXCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZClp95KJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BSb5g7f3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfsR4cuI/tt0teFS9a0rpgqNCcAgFFOVh1mZjh5NV7s=;
 b=ZClp95KJxd3ir4Fzaag/4GmGEQd4SKZVsxon1EoVcukJwcjK1WgcVTfO9S28fHODScN5z2
 U6mZaFGSgZ3/Wy/78wPKG1v1+IFyXMbYsUqNbp19xQgi4UXpA7jBbkSNK0O0eXteQiKjRK
 R0OReAC/18kX5cyVguMqc11OPIjYDX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfsR4cuI/tt0teFS9a0rpgqNCcAgFFOVh1mZjh5NV7s=;
 b=BSb5g7f3IDYbuHODG5sl36FzyWhhJlKRkRYVlWF18uY4dI7P4xOtoJs1FqY6WCG7AstDO1
 QIimCXlNhkt/OXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C2243EA63;
 Mon, 15 Dec 2025 22:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABBUN2+FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 38/51] tests/qtest/migration: TLS x509: Refactor to use
 full hook
Date: Mon, 15 Dec 2025 19:00:24 -0300
Message-ID: <20251215220041.12657-39-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
X-Rspamd-Queue-Id: 3853833703
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

Refactor the TLS x509 hooks to use the _full variant which passes the
hook data into the _common functions via MigrateCommon *args.

This reduces the number of hooks and will allow further simplification
of the TLS tests by setting a common hook at a centralized place in
the next patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 98 +++++++++----------------------
 1 file changed, 29 insertions(+), 69 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index d50832573f..8da95dc92a 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -207,8 +207,9 @@ static TestMigrateTLSX509 tls_x509_no_host = {
 static void *
 migrate_hook_start_tls_x509_common(QTestState *from,
                                    QTestState *to,
-                                   TestMigrateTLSX509 *args)
+                                   void *opaque)
 {
+    TestMigrateTLSX509 *args = opaque;
     TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
 
     data->workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);
@@ -293,60 +294,6 @@ migrate_hook_start_tls_x509_common(QTestState *from,
     return data;
 }
 
-static void *
-migrate_hook_start_tls_x509_default_host(QTestState *from,
-                                         QTestState *to)
-{
-    return migrate_hook_start_tls_x509_common(from, to, &tls_x509_default_host);
-}
-
-static void *
-migrate_hook_start_tls_x509_override_host(QTestState *from,
-                                          QTestState *to)
-{
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_override_host);
-}
-
-static void *
-migrate_hook_start_tls_x509_mismatch_host(QTestState *from,
-                                          QTestState *to)
-{
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_mismatch_host);
-}
-
-static void *
-migrate_hook_start_tls_x509_friendly_client(QTestState *from,
-                                            QTestState *to)
-{
-    return migrate_hook_start_tls_x509_common(from, to, &x509_friendly_client);
-}
-
-static void *
-migrate_hook_start_tls_x509_hostile_client(QTestState *from,
-                                           QTestState *to)
-{
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_hostile_client);
-}
-
-static void *
-migrate_hook_start_tls_x509_allow_anon_client(QTestState *from,
-                                              QTestState *to)
-{
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_allow_anon_client);
-}
-
-static void *
-migrate_hook_start_tls_x509_reject_anon_client(QTestState *from,
-                                               QTestState *to)
-{
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_reject_anon_client);
-}
-
 static void
 migrate_hook_end_tls_x509(QTestState *from,
                           QTestState *to,
@@ -460,7 +407,8 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
 
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook = migrate_hook_start_tls_x509_default_host;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
@@ -476,7 +424,8 @@ static void test_precopy_unix_tls_x509_override_host(char *name,
 
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook = migrate_hook_start_tls_x509_override_host;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
     test_precopy_common(args);
@@ -552,7 +501,8 @@ static void test_precopy_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_default_host;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
     test_precopy_common(args);
@@ -562,7 +512,8 @@ static void test_precopy_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_override_host;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
     test_precopy_common(args);
@@ -572,7 +523,8 @@ static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
                                                     MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
@@ -585,7 +537,8 @@ static void test_precopy_tcp_tls_x509_friendly_client(char *name,
                                                       MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_friendly_client;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &x509_friendly_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
     test_precopy_common(args);
@@ -595,7 +548,8 @@ static void test_precopy_tcp_tls_x509_hostile_client(char *name,
                                                      MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_hostile_client;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_hostile_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
@@ -608,7 +562,8 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_allow_anon_client;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
     test_precopy_common(args);
@@ -618,7 +573,8 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_reject_anon_client;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
@@ -650,7 +606,7 @@ migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
                                                  QTestState *to)
 {
     migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_default_host(from, to);
+    return migrate_hook_start_tls_x509_common(from, to, &tls_x509_default_host);
 }
 
 static void *
@@ -658,7 +614,8 @@ migrate_hook_start_multifd_tls_x509_override_host(QTestState *from,
                                                   QTestState *to)
 {
     migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_override_host(from, to);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_override_host);
 }
 
 static void *
@@ -666,7 +623,8 @@ migrate_hook_start_multifd_tls_x509_mismatch_host(QTestState *from,
                                                   QTestState *to)
 {
     migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_mismatch_host(from, to);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_mismatch_host);
 }
 
 static void *
@@ -674,7 +632,8 @@ migrate_hook_start_multifd_tls_x509_allow_anon_client(QTestState *from,
                                                       QTestState *to)
 {
     migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_allow_anon_client(from, to);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_allow_anon_client);
 }
 
 static void *
@@ -682,7 +641,8 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
                                                        QTestState *to)
 {
     migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_reject_anon_client(from, to);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_reject_anon_client);
 }
 #endif /* CONFIG_TASN1 */
 
-- 
2.51.0


