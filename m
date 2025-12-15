Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B7AD5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfS-000216-Eo; Mon, 15 Dec 2025 17:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfG-0001Nm-QI
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfD-0003Bd-Lv
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:33 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 744045BDE2;
 Mon, 15 Dec 2025 22:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLzP0FP/GuIRsL62Nak4M/JkrfBmomudVQwI79vGZYw=;
 b=fA8uPO85qrkM8gM2zfDHEuLTHWLLwo3+YYejBoN8TREvjgtrripd8VOm9X6pCgeKtDL39G
 yy+srsd4Nw99dH80dsZk8UBB3SfQVznzrz+DCnlkzC4eMblVu5jzFsHbLJarSRWKyJ44t2
 ThSR2ZdPMfsDXNIst5+uSip2Qkn7eko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLzP0FP/GuIRsL62Nak4M/JkrfBmomudVQwI79vGZYw=;
 b=9n9WGj9SYPhGNfHGM2k42lVt76eOpWTJ5zpyI02itnZuBzwVLoLS5bRqBBtVpFxoLSFo6V
 /GTYCOiJvNtSD+AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLzP0FP/GuIRsL62Nak4M/JkrfBmomudVQwI79vGZYw=;
 b=fA8uPO85qrkM8gM2zfDHEuLTHWLLwo3+YYejBoN8TREvjgtrripd8VOm9X6pCgeKtDL39G
 yy+srsd4Nw99dH80dsZk8UBB3SfQVznzrz+DCnlkzC4eMblVu5jzFsHbLJarSRWKyJ44t2
 ThSR2ZdPMfsDXNIst5+uSip2Qkn7eko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLzP0FP/GuIRsL62Nak4M/JkrfBmomudVQwI79vGZYw=;
 b=9n9WGj9SYPhGNfHGM2k42lVt76eOpWTJ5zpyI02itnZuBzwVLoLS5bRqBBtVpFxoLSFo6V
 /GTYCOiJvNtSD+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61EC93EA63;
 Mon, 15 Dec 2025 22:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QCwwCYqFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 48/51] tests/qtest/migration: Convert misc-tests to use
 config
Date: Mon, 15 Dec 2025 19:00:34 -0300
Message-ID: <20251215220041.12657-49-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Make the misc tests pass a config argument to migration QMP commands.

Temporarily, set the use-config key to enable the new method.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/misc-tests.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index c62fd1e3f9..7e38d26ab2 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -28,6 +28,9 @@ static void test_baddest(char *name, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
         return;
     }
@@ -52,6 +55,9 @@ static void test_analyze_script(char *name, MigrateCommon *args)
         return;
     }
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     /* dummy url */
     if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
         return;
@@ -62,8 +68,8 @@ static void test_analyze_script(char *name, MigrateCommon *args)
      * vmstate to include subsections for them. The script needs to
      * parse those subsections properly.
      */
-    migrate_set_capability(from, "validate-uuid", true);
-    migrate_set_capability(from, "x-ignore-shared", true);
+    qdict_put_bool(args->start.config, "validate-uuid", true);
+    qdict_put_bool(args->start.config, "x-ignore-shared", true);
 
     file = g_strdup_printf("%s/migfile", tmpfs);
     uri = g_strdup_printf("exec:cat > %s", file);
@@ -96,7 +102,11 @@ static void test_ignore_shared(char *name, MigrateCommon *args)
     QTestState *from, *to;
 
     args->start.mem_type = MEM_TYPE_SHMEM;
-    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
+    qdict_put_bool(args->start.config, "x-ignore-shared", true);
 
     if (migrate_start(&from, &to, uri, &args->start)) {
         return;
@@ -131,6 +141,9 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
+    /* temporary */
+    qdict_put_bool(args->config, "use-config", true);
+
     if (migrate_start(&from, &to, uri, args)) {
         return;
     }
@@ -140,8 +153,8 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
      * migration is not interesting for us here. Thus, set huge downtime for
      * very fast migration.
      */
-    migrate_set_parameter_int(from, "downtime-limit", 1000000);
-    migrate_set_capability(from, "validate-uuid", true);
+    qdict_put_int(args->config, "downtime-limit", 1000000);
+    qdict_put_bool(args->config, "validate-uuid", true);
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.51.0


