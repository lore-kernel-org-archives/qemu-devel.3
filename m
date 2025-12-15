Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B4DD5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGer-0006eW-46; Mon, 15 Dec 2025 17:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGek-0005yO-U0
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:03 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeh-0002zY-7p
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DD5C337B4;
 Mon, 15 Dec 2025 22:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jFdMS1Z2lRqRrJYTng2gKfXuEq0sp8Y5kW7KRGogFQ=;
 b=1rpFtST9YwOZBdWtplud+Q5HjIJOHnSEX2CTkdvopF0KAuPVTItEcJmIWOqofoIuIhrwkC
 I9s4YkD32QApfjaIpXighP/TACn5zYTREJ1KD4zp4BIyeFJrJLqWM8OOpYvSRvStT1yLqx
 Pc+JN5g6wbyj8yKDDqm0M9qbtNNyT+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jFdMS1Z2lRqRrJYTng2gKfXuEq0sp8Y5kW7KRGogFQ=;
 b=1OUxg5uP3cu78Rm3/MiLk+tXgVfuVY5g2aZXMwO+o/bmPPdyJ4qEsj1TZZCaHVHNjz0ukd
 SrArRQJZ9CWpgODg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jFdMS1Z2lRqRrJYTng2gKfXuEq0sp8Y5kW7KRGogFQ=;
 b=1rpFtST9YwOZBdWtplud+Q5HjIJOHnSEX2CTkdvopF0KAuPVTItEcJmIWOqofoIuIhrwkC
 I9s4YkD32QApfjaIpXighP/TACn5zYTREJ1KD4zp4BIyeFJrJLqWM8OOpYvSRvStT1yLqx
 Pc+JN5g6wbyj8yKDDqm0M9qbtNNyT+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jFdMS1Z2lRqRrJYTng2gKfXuEq0sp8Y5kW7KRGogFQ=;
 b=1OUxg5uP3cu78Rm3/MiLk+tXgVfuVY5g2aZXMwO+o/bmPPdyJ4qEsj1TZZCaHVHNjz0ukd
 SrArRQJZ9CWpgODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09ECA3EA63;
 Mon, 15 Dec 2025 22:02:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0LAsL2qFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 36/51] tests/qtest/migration: Move tls hook data out of
 specific hooks
Date: Mon, 15 Dec 2025 19:00:22 -0300
Message-ID: <20251215220041.12657-37-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
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

The nesting of hooks in tls-tests.c is out of hand. It's quite
unreadable and makes it a pain to solve git conflicts in that code.

We're at this point moving away from setting migration parameters and
capabilities with migrate_set_* in favor of the new config struct,
which goes along with the migrate commmand. This means hooks will have
to be reworked to allow some data to be accessed earlier than
->start_hook.

Start cleaning up the tls-tests hooks to allow future patches to
address both issues. This patch only deals with x509 code, while a
later patch will appply the same changes to PSK.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 155 ++++++++++++++++--------------
 1 file changed, 84 insertions(+), 71 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index f63f37132a..d50832573f 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -134,6 +134,76 @@ typedef struct {
     const char *certipaddr;
 } TestMigrateTLSX509;
 
+/*
+ * The normal case: match server's cert hostname against
+ * whatever host we were telling QEMU to connect to (if any)
+ */
+static TestMigrateTLSX509 tls_x509_default_host = {
+    .verifyclient = true,
+    .clientcert = true,
+    .certipaddr = "127.0.0.1"
+};
+
+/*
+ * The unusual case: the server's cert is different from
+ * the address we're telling QEMU to connect to (if any),
+ * so we must give QEMU an explicit hostname to validate
+ */
+static TestMigrateTLSX509 tls_x509_override_host = {
+    .verifyclient = true,
+    .clientcert = true,
+    .certhostname = "qemu.org",
+};
+
+/*
+ * The unusual case: the server's cert is different from
+ * the address we're telling QEMU to connect to, and so we
+ * expect the client to reject the server
+ */
+static TestMigrateTLSX509 tls_x509_mismatch_host = {
+    .verifyclient = true,
+    .clientcert = true,
+    .certipaddr = "10.0.0.1",
+};
+
+static TestMigrateTLSX509 x509_friendly_client = {
+    .verifyclient = true,
+    .clientcert = true,
+    .authzclient = true,
+    .certipaddr = "127.0.0.1",
+};
+
+static TestMigrateTLSX509 tls_x509_hostile_client = {
+    .verifyclient = true,
+    .clientcert = true,
+    .hostileclient = true,
+    .authzclient = true,
+    .certipaddr = "127.0.0.1",
+};
+
+/*
+ * The case with no client certificate presented,
+ * and no server verification
+ */
+static TestMigrateTLSX509 tls_x509_allow_anon_client = {
+    .certipaddr = "127.0.0.1",
+};
+
+/*
+ * The case with no client certificate presented,
+ * and server verification rejecting
+ */
+static TestMigrateTLSX509 tls_x509_reject_anon_client = {
+    .verifyclient = true,
+    .certipaddr = "127.0.0.1",
+};
+
+static TestMigrateTLSX509 tls_x509_no_host = {
+    .verifyclient = true,
+    .clientcert = true,
+    .authzclient = true,
+};
+
 static void *
 migrate_hook_start_tls_x509_common(QTestState *from,
                                    QTestState *to,
@@ -223,110 +293,58 @@ migrate_hook_start_tls_x509_common(QTestState *from,
     return data;
 }
 
-/*
- * The normal case: match server's cert hostname against
- * whatever host we were telling QEMU to connect to (if any)
- */
 static void *
 migrate_hook_start_tls_x509_default_host(QTestState *from,
                                          QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .certipaddr = "127.0.0.1"
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &tls_x509_default_host);
 }
 
-/*
- * The unusual case: the server's cert is different from
- * the address we're telling QEMU to connect to (if any),
- * so we must give QEMU an explicit hostname to validate
- */
 static void *
 migrate_hook_start_tls_x509_override_host(QTestState *from,
                                           QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .certhostname = "qemu.org",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_override_host);
 }
 
-/*
- * The unusual case: the server's cert is different from
- * the address we're telling QEMU to connect to, and so we
- * expect the client to reject the server
- */
 static void *
 migrate_hook_start_tls_x509_mismatch_host(QTestState *from,
                                           QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .certipaddr = "10.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_mismatch_host);
 }
 
 static void *
 migrate_hook_start_tls_x509_friendly_client(QTestState *from,
                                             QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .authzclient = true,
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &x509_friendly_client);
 }
 
 static void *
 migrate_hook_start_tls_x509_hostile_client(QTestState *from,
                                            QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .hostileclient = true,
-        .authzclient = true,
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_hostile_client);
 }
 
-/*
- * The case with no client certificate presented,
- * and no server verification
- */
 static void *
 migrate_hook_start_tls_x509_allow_anon_client(QTestState *from,
                                               QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_allow_anon_client);
 }
 
-/*
- * The case with no client certificate presented,
- * and server verification rejecting
- */
 static void *
 migrate_hook_start_tls_x509_reject_anon_client(QTestState *from,
                                                QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to,
+                                              &tls_x509_reject_anon_client);
 }
 
 static void
@@ -509,13 +527,8 @@ static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 static void *
 migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
 {
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .authzclient = true,
-    };
-    TestMigrateTLSX509Data *data = migrate_hook_start_tls_x509_common(from, to,
-                                                                      &args);
+    TestMigrateTLSX509Data *data = migrate_hook_start_tls_x509_common(
+        from, to, &tls_x509_no_host);
     migrate_set_parameter_null(from, "tls-hostname");
     migrate_set_parameter_null(to, "tls-hostname");
 
-- 
2.51.0


