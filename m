Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B3F103E2E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RCT-0005NP-B1; Wed, 11 Mar 2026 17:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCR-0005NB-Bf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCM-00035f-37
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:34:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D2735BD81;
 Wed, 11 Mar 2026 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLDUypVLJFruQUZaT2FvstlLe7oVVwkR5O8QRLHa66s=;
 b=dAe0v6j6DBJl6BBX8D7eKk30jnMS1Eyk12duq/syvzjiCzHlGpF34f5Vh1NJcXtTR75f/q
 p9MrtNgGUOePeP16FMDUJ5UsB0brTJB06mr7Nrs803DGYU0oqwfKneS1GJSzYmjehGwuOl
 ISJIILHgKoa8ek7c0dTVzd/e+HIFRhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLDUypVLJFruQUZaT2FvstlLe7oVVwkR5O8QRLHa66s=;
 b=5Z/wLMaT/DbIkS3IRNeFhaqGADPYNpZ9LxNn/7l7ERocVnKXRAh3JOUL975caaUs2avGaU
 Nz3wwgmQ4VZY81BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLDUypVLJFruQUZaT2FvstlLe7oVVwkR5O8QRLHa66s=;
 b=jS6Bw+Fi7zrvyYzO9mkJpqCXR3V9RbzMhnF+U0SAWPQ0OQOoB+SdhICHNbkgQ3YaG31KBx
 393s+gtO2fnuQorfG++CGUbemIdeSHTpRjhyv7yQCfGk8NhGp7kbWWZ15qgPXFUxGmHIjg
 Nja9EXWCSM67v+WAyU0P85OlrrN1EkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLDUypVLJFruQUZaT2FvstlLe7oVVwkR5O8QRLHa66s=;
 b=4mMaCnGyRZYh8qS77BL+AmasGJqexlG6kGUAIGl7kegxA7S87PseBo2+YQfpiSzTR2OBNj
 TioRIh7y4/5wfLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 315363FC1B;
 Wed, 11 Mar 2026 21:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QBQOOd7fsWngUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 21:34:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/5] tests/qtest/migration: Fix leak of migration tests data
Date: Wed, 11 Mar 2026 18:34:14 -0300
Message-ID: <20260311213418.16951-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311213418.16951-1-farosas@suse.de>
References: <20260311213418.16951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:email,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

When the migration-test is invoked with the '-p' flag (to run a single
test), the glib code won't call the destroy function for the
not-executed tests, causing the MigrationTest wrapper data to leak.

This doesn't affect make check, but affects debugging use-cases where
having a leak pop up in ASAN output is extra annoying.

Fix by adding the tests data to a list and freeing them all at the end
of migration-test execution. Any tests actually dispatched by glib
will have the destroy function called as usual.

Note that migration_test_add_suffix() is altered to call
migration_test_add() so that there's only one place adding the data to
the list.

Performance is not an issue at the moment, we have < 100 tests.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c      |  2 ++
 tests/qtest/migration/migration-util.c | 19 ++++++++++++++-----
 tests/qtest/migration/migration-util.h |  2 +-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 0bfc241914..b9371372de 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1162,5 +1162,7 @@ int migration_env_clean(MigrationTestEnv *env)
     }
     g_free(tmpfs);
 
+    migration_tests_free();
+
     return ret;
 }
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index c2462306a1..2648ad7f61 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -38,6 +38,7 @@
 #include "linux/kvm.h"
 #endif
 
+GQueue *tests;
 
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
@@ -243,6 +244,8 @@ static void migration_test_destroy(gpointer data)
 {
     MigrationTest *test = (MigrationTest *)data;
 
+    g_queue_remove(tests, test);
+
     g_free(test->data);
     g_free(test->name);
     g_free(test);
@@ -268,21 +271,27 @@ void migration_test_add(const char *path,
 
     qtest_add_data_func_full(path, test, migration_test_wrapper,
                              migration_test_destroy);
+    if (!tests) {
+        tests = g_queue_new();
+    }
+    g_queue_push_tail(tests, test);
 }
 
 void migration_test_add_suffix(const char *path, const char *suffix,
                                void (*fn)(char *name, MigrateCommon *args))
 {
-    MigrationTest *test = g_new0(MigrationTest, 1);
+    g_autofree char *name = NULL;
 
     g_assert(g_str_has_suffix(path, "/"));
     g_assert(!g_str_has_prefix(suffix, "/"));
 
-    test->func = fn;
-    test->name = g_strconcat(path, suffix, NULL);
+    name = g_strconcat(path, suffix, NULL);
+    migration_test_add(name, fn);
+}
 
-    qtest_add_data_func_full(test->name, test, migration_test_wrapper,
-                             migration_test_destroy);
+void migration_tests_free(void)
+{
+    g_queue_free_full(tests, migration_test_destroy);
 }
 
 #ifdef O_DIRECT
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index e73d69bab0..694773e594 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -59,5 +59,5 @@ void migration_test_add_suffix(const char *path, const char *suffix,
                                void (*fn)(char *name, MigrateCommon *args));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
-
+void migration_tests_free(void);
 #endif /* MIGRATION_UTIL_H */
-- 
2.51.0


