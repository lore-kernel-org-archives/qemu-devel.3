Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3905BD5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGen-000653-Fx; Mon, 15 Dec 2025 17:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeO-0005Fe-Hm
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:40 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeM-0002vV-PR
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4EE25BD2A;
 Mon, 15 Dec 2025 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/nBXOIo2ZcXdwbvi4S1iTXg0TqbIwOv4w9aq2LbXy8=;
 b=O2fh1C9kaAbYwuxW07erkF3+f7YSu9tjhUHP6vX+OD+0+QD/uJ7KlMYk3tmm+UfPQohF2a
 8/4cvTsWeVMMlxr/Mk6sbVF1G7zQNtuugjO/6nR5VhB5TD5BwuYmIDO4kzaFxHiiAAP8BY
 R/uPMf9Pw8Co2aMo+mJ40rMed7mcYB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/nBXOIo2ZcXdwbvi4S1iTXg0TqbIwOv4w9aq2LbXy8=;
 b=J2TNU8sFFw4HW+mR++FznoKXBdNo3wdnU7dt2hQTm0c24APcHpeiMfguLmOiyfi8c/uMg6
 4BbBptXSjg7+zoBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MsOKkzsy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=D0gMhVvE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/nBXOIo2ZcXdwbvi4S1iTXg0TqbIwOv4w9aq2LbXy8=;
 b=MsOKkzsyE3h1I9/6zlZ7IBBE1PyMPYu/Y8KfGYFvmzZa0/K1hgkMltF0ue5chTnD+hYewT
 P5QmWyWVp1QlPzGvtep604CXgdAxpSzt+6BHa1Msl0jprBgCTMPQN7L8P+paqc4ffz48OI
 NJ05/MCAtduZj+vjaTK3u16F34pZwkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836124;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/nBXOIo2ZcXdwbvi4S1iTXg0TqbIwOv4w9aq2LbXy8=;
 b=D0gMhVvEh38RWJD07wkCwi6HEEkQ6twSSef6SHMpGe/km6jaX4n+zl6wSObr9xEGFcU8pQ
 elXZrvtWkFX3CkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA3243EA63;
 Mon, 15 Dec 2025 22:02:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2A5hJlqFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 30/51] tests/qtest/migration: Add temporary code to toggle
 usage of config
Date: Mon, 15 Dec 2025 19:00:16 -0300
Message-ID: <20251215220041.12657-31-farosas@suse.de>
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
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E4EE25BD2A
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

The tests are being refactored to pass migration options to QEMU using
the new API of passing a JSON object as argument the migration
commands instead of using several calls to the
migrate_set_capabilities|parameters commands.

Since multiple tests share common infrastructure (framework.c,
migration-utils.c, migration-qmp.c), it's cumbersome to convert tests
in small chunks, which would require changes to every common function
to accept both the new and old ways.

After some tinkering, an easier way to do this transition is to allow
the tests to set a key in the config dict itself telling whether the
config is supported. With this, the common functions can be fully
altered to support the config object, as long as they check this
temporary key and do the right thing.

QEMU doesn't know about this hack, so some code is needed to hide it
when issuing QMP commands with the config object.

This will all be removed once tests are fully converted.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-qmp.h  |  1 -
 tests/qtest/migration/migration-util.c |  1 +
 tests/qtest/migration/migration-util.h | 34 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index 940ffd5950..9a36a677ba 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -47,5 +47,4 @@ void migrate_recover(QTestState *who, const char *uri);
 void migrate_cancel(QTestState *who);
 void migrate_postcopy_start(QTestState *from, QTestState *to,
                             QTestMigrationState *src_state);
-
 #endif /* MIGRATION_QMP_H */
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 416dd10ef8..e702f00896 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -255,6 +255,7 @@ static void migration_test_wrapper(const void *data)
 
     test->data = g_new0(MigrateCommon, 1);
     test->data->start.config = qdict_new();
+    qdict_put_bool(test->data->start.config, "use-config", false);
 
     g_test_message("Running /%s%s", qtest_get_arch(), test->name);
     test->func(test->name, test->data);
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index e73d69bab0..3c3b5a8777 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -60,4 +60,38 @@ void migration_test_add_suffix(const char *path, const char *suffix,
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
 
+/*
+ * Scaffolding to allow the framework _common functions and _qmp
+ * functions to use the config object while some tests are still using
+ * migrate_set_*. Tests that have been converted will set use-config =
+ * true on the config dict.
+ */
+static bool has_key;
+static bool use_config;
+static inline QDict *config_load(QDict *config)
+{
+    if (!config) {
+        return NULL;
+    }
+
+    has_key = qdict_haskey(config, "use-config");
+    if (has_key) {
+        use_config = qdict_get_try_bool(config, "use-config", false);
+        qdict_del(config, "use-config");
+    }
+
+    if (use_config) {
+        return config;
+    }
+
+    return NULL;
+}
+
+static inline void config_put(QDict *config)
+{
+    if (config && has_key) {
+        qdict_put_bool(config, "use-config", use_config);
+    }
+}
+
 #endif /* MIGRATION_UTIL_H */
-- 
2.51.0


