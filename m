Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BA0CD3442
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIM4-0008Qf-Cn; Tue, 05 May 2026 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILJ-00080F-0L
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:54 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILG-00087c-K9
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FD945CAF0;
 Tue,  5 May 2026 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnN4jGROF2Ag2stM9Gd8AphVtEE7AjlLZXIM5iuEbDQ=;
 b=kjD5XLixtvbjcr7wEOrqnYeFaFkTyTke9aKHH4MrMM/g0agcJ+fjEKB9zx7UL3mPgj/2Mq
 Vhm5uHHZyMz1oAjqFH/uvqaEOC/riaVmeJK8N/R2NxelJjCP5sO8U+SYmciATsZ6Qo4Qzt
 iVQM5CYvEByZFKvY4zS1PoXXdS07ckE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnN4jGROF2Ag2stM9Gd8AphVtEE7AjlLZXIM5iuEbDQ=;
 b=i9d3RemBjvuzSiZ4tWA7mWOGbIWiwv7nsHSmK5k6Yc4iNbA/iVWtf+J04TiasKfyN79s4G
 CSA/U9HxkFD4SRAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kjD5XLix;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i9d3RemB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnN4jGROF2Ag2stM9Gd8AphVtEE7AjlLZXIM5iuEbDQ=;
 b=kjD5XLixtvbjcr7wEOrqnYeFaFkTyTke9aKHH4MrMM/g0agcJ+fjEKB9zx7UL3mPgj/2Mq
 Vhm5uHHZyMz1oAjqFH/uvqaEOC/riaVmeJK8N/R2NxelJjCP5sO8U+SYmciATsZ6Qo4Qzt
 iVQM5CYvEByZFKvY4zS1PoXXdS07ckE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnN4jGROF2Ag2stM9Gd8AphVtEE7AjlLZXIM5iuEbDQ=;
 b=i9d3RemBjvuzSiZ4tWA7mWOGbIWiwv7nsHSmK5k6Yc4iNbA/iVWtf+J04TiasKfyN79s4G
 CSA/U9HxkFD4SRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E024B593A3;
 Tue,  5 May 2026 16:09:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHmNK0EW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 10/15] tests/qtest/migration: Use defer for all tests
Date: Tue,  5 May 2026 13:09:09 -0300
Message-ID: <20260505160915.25558-11-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0FD945CAF0
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Change all invocations of migrate_start to use defer. The uri
parameter will be removed from that function in subsequent patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/misc-tests.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 8d1cd44183..8216b5d79d 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -28,9 +28,11 @@ static void test_baddest(char *name, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
+
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
     migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     migrate_end(from, to, false);
@@ -52,8 +54,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
         return;
     }
 
-    /* dummy url */
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
@@ -69,6 +70,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
     migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
@@ -178,13 +180,15 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     QTestState *from, *to;
     QObject *channels;
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+
     /*
      * 'uri' and 'channels' validation is checked even before the migration
      * starts.
@@ -248,7 +252,6 @@ static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
 
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer",
     args->connect_uri = "tcp:127.0.0.1:0",
     args->connect_channels = ("[ { ""'channel-type': 'main',"
                               "    'addr': { 'transport': 'socket',"
@@ -263,7 +266,6 @@ static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 
 static void test_validate_uri_channels_none_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start.hide_stderr = true;
 
     do_test_validate_uri_channel(args);
-- 
2.51.0


