Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25017D58D57
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaML-0007Vd-Q2; Mon, 25 Nov 2024 09:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaM8-0007TR-Rr; Mon, 25 Nov 2024 09:46:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaM7-00049o-5Z; Mon, 25 Nov 2024 09:46:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ADB811F396;
 Mon, 25 Nov 2024 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU+6oq9nj4hE4oNtHzLpkuHX+DcqZqNFJ+6b1YyXsWc=;
 b=yb5RGaA1l+48Ff2VHmF1vIUuuggWqptpkprDIhFNERqSQTLCRnFZgnbnbBZGnIiscqUF6/
 NPiblp7TLEDPDW17lBs6dFzuLQILo94wTMsxrfzgarWjYge2uJa2vawRg3QFs1wsZ+eISL
 5Mrix9GfwO547FPy6bVEQhTyYEJ93Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU+6oq9nj4hE4oNtHzLpkuHX+DcqZqNFJ+6b1YyXsWc=;
 b=HebLWO45t7YmSLiREVeMgMBPD5IkQa5OjeNUn2o7EESeUVFhCKqr9mXVIcZGXZy/l++WaU
 NA+A8iTN4skyZVDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU+6oq9nj4hE4oNtHzLpkuHX+DcqZqNFJ+6b1YyXsWc=;
 b=yb5RGaA1l+48Ff2VHmF1vIUuuggWqptpkprDIhFNERqSQTLCRnFZgnbnbBZGnIiscqUF6/
 NPiblp7TLEDPDW17lBs6dFzuLQILo94wTMsxrfzgarWjYge2uJa2vawRg3QFs1wsZ+eISL
 5Mrix9GfwO547FPy6bVEQhTyYEJ93Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU+6oq9nj4hE4oNtHzLpkuHX+DcqZqNFJ+6b1YyXsWc=;
 b=HebLWO45t7YmSLiREVeMgMBPD5IkQa5OjeNUn2o7EESeUVFhCKqr9mXVIcZGXZy/l++WaU
 NA+A8iTN4skyZVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99B24137D4;
 Mon, 25 Nov 2024 14:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MArqF7qNRGdRTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 14:46:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/5] tests/qtest/migration: Move more code under only_target
Date: Mon, 25 Nov 2024 11:46:08 -0300
Message-Id: <20241125144612.16194-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241125144612.16194-1-farosas@suse.de>
References: <20241125144612.16194-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The only_target option's purpose is to make sure only the destination
QTestState machine is initialized. This allows the test code to retain
an already initialized source machine (e.g. for doing ping pong
migration).

We have drifted from that a bit when adding new code, so move some
lines under only_target to restore the functionality.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 44 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e6a2803e71..d56894dd97 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -717,7 +717,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree gchar *arch_target = NULL;
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
-    g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
     g_autofree char *shmem_opts = NULL;
@@ -735,10 +734,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         }
     }
 
-    dst_state = (QTestMigrationState) { };
-    src_state = (QTestMigrationState) { };
     bootfile_create(tmpfs, args->suspend_me);
-    src_state.suspend_me = args->suspend_me;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
@@ -817,27 +813,35 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     g_test_message("Using machine type: %s", machine);
 
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
-                                 "-name source,debug-threads=on "
-                                 "-m %s "
-                                 "-serial file:%s/src_serial "
-                                 "%s %s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
-                                 memory_size, tmpfs,
-                                 arch_opts ? arch_opts : "",
-                                 arch_source ? arch_source : "",
-                                 shmem_opts ? shmem_opts : "",
-                                 args->opts_source ? args->opts_source : "",
-                                 ignore_stderr);
     if (!args->only_target) {
+        g_autofree gchar *cmd_source = NULL;
+
+        src_state = (QTestMigrationState) { };
+        src_state.suspend_me = args->suspend_me;
+
+        cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
+                                     "-machine %s,%s "
+                                     "-name source,debug-threads=on "
+                                     "-m %s "
+                                     "-serial file:%s/src_serial "
+                                     "%s %s %s %s %s",
+                                     kvm_opts ? kvm_opts : "",
+                                     machine, machine_opts,
+                                     memory_size, tmpfs,
+                                     arch_opts ? arch_opts : "",
+                                     arch_source ? arch_source : "",
+                                     shmem_opts ? shmem_opts : "",
+                                     args->opts_source ? args->opts_source : "",
+                                     ignore_stderr);
+
         *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
     }
 
+    dst_state = (QTestMigrationState) { };
+
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
@@ -870,7 +874,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * Always enable migration events.  Libvirt always uses it, let's try
      * to mimic as closer as that.
      */
-    migrate_set_capability(*from, "events", true);
+    if (!args->only_target) {
+        migrate_set_capability(*from, "events", true);
+    }
     migrate_set_capability(*to, "events", true);
 
     return 0;
-- 
2.35.3


