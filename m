Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F271CFDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcI-0002lf-Tx; Thu, 23 Apr 2026 15:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbs-0002Ao-GD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:15 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzbm-0001tc-FI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BBA075BD7F;
 Thu, 23 Apr 2026 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKT9Q2zKT+GEZGSWOgGSeMo9cBOjOzFrkFs3s/aOn2w=;
 b=mczSZtBJFb4qz6lr61OcO958JQFAhJmxwaDYJNnSDjAIzZ4kSyJFjBazXzMkoYW6MbH9u1
 xdwHtyxK/rebeiWI1JQAi3EafELvsTcaqOrsFYib9q1BKhwPXUtXwNFB6NDmVJHlWmD7bQ
 3ofFjoEBXwkxHVNrPp9jBu1zWtVBfDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKT9Q2zKT+GEZGSWOgGSeMo9cBOjOzFrkFs3s/aOn2w=;
 b=EeXZv1Q88HlTobtfUCZ0M5ze4VisB/Y5fnBvW5hMyDe3RMeB2eICEAQj3/ffshCQmlyVd3
 WAwIc9k+Y1HzykDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mczSZtBJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EeXZv1Q8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKT9Q2zKT+GEZGSWOgGSeMo9cBOjOzFrkFs3s/aOn2w=;
 b=mczSZtBJFb4qz6lr61OcO958JQFAhJmxwaDYJNnSDjAIzZ4kSyJFjBazXzMkoYW6MbH9u1
 xdwHtyxK/rebeiWI1JQAi3EafELvsTcaqOrsFYib9q1BKhwPXUtXwNFB6NDmVJHlWmD7bQ
 3ofFjoEBXwkxHVNrPp9jBu1zWtVBfDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKT9Q2zKT+GEZGSWOgGSeMo9cBOjOzFrkFs3s/aOn2w=;
 b=EeXZv1Q88HlTobtfUCZ0M5ze4VisB/Y5fnBvW5hMyDe3RMeB2eICEAQj3/ffshCQmlyVd3
 WAwIc9k+Y1HzykDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2AE3593A3;
 Thu, 23 Apr 2026 19:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +PWwHwBx6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PULL 22/43] tests/qtest/migration: Add mapped-ram/postcopy
 validation test
Date: Thu, 23 Apr 2026 16:19:36 -0300
Message-ID: <20260423191958.1440-23-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[redhat.com,gmail.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: BBA075BD7F
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

From: Takeru Hayasaka <hayatake396@gmail.com>

The migration capability checks reject enabling postcopy-ram together
with mapped-ram, but there is no qtest covering this incompatibility.

Add a validation test that verifies QMP rejects the combination in
both capability ordering cases and returns the expected error.

This keeps the existing capability boundary covered without changing
migration behavior.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20260327164705.1990226-1-hayatake396@gmail.com
[unlink src_serial]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/misc-tests.c | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 196f1ca842..e114ac5972 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -215,6 +215,55 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     migrate_end(from, to, false);
 }
 
+static void validate_caps_pair(QTestState *from,
+                               const char *first_capability,
+                               const char *second_capability,
+                               const char *expected_error)
+{
+    QDict *rsp;
+    const char *error_desc;
+
+    migrate_set_capability(from, first_capability, true);
+
+    rsp = qtest_qmp_assert_failure_ref(
+        from,
+        "{ 'execute': 'migrate-set-capabilities',"
+        "  'arguments': { 'capabilities': [ { "
+        "      'capability': %s, 'state': true } ] } }",
+        second_capability);
+
+    error_desc = qdict_get_str(rsp, "desc");
+    g_assert_cmpstr(error_desc, ==, expected_error);
+    qobject_unref(rsp);
+
+    migrate_set_capability(from, first_capability, false);
+}
+
+static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
+{
+    g_autofree char *serial_path = g_strconcat(tmpfs, "/src_serial", NULL);
+    g_autofree char *cap_pair = g_path_get_basename(test_path);
+    QTestState *from, *to;
+
+    args->start.hide_stderr = true;
+    args->start.only_source = true;
+
+    if (migrate_start(&from, &to, "defer", &args->start)) {
+        return;
+    }
+
+    if (g_str_equal(cap_pair, "mapped_ram_postcopy")) {
+        const char *error =
+            "Mapped-ram migration is incompatible with postcopy";
+
+        validate_caps_pair(from, "mapped-ram", "postcopy-ram", error);
+        validate_caps_pair(from, "postcopy-ram", "mapped-ram", error);
+    }
+
+    qtest_quit(from);
+    unlink(serial_path);
+}
+
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
     args->listen_uri = "defer",
@@ -276,4 +325,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
+    migration_test_add_suffix("/migration/validate_caps/",
+                              "mapped_ram_postcopy",
+                              test_validate_caps_pair);
 }
-- 
2.51.0


