Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056BAFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIM4-0008QZ-BU; Tue, 05 May 2026 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILC-0007w5-Rp
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIL9-0007RT-Dc
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:46 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 910CC5CB10;
 Tue,  5 May 2026 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYZtWW/BG1VVPc2RlzeHfPalbRqchXjdPpj+gIrK+Rg=;
 b=D8blho+5DO0lqsUOXGG4EnoWqPj7jXMR9f3UJrIjGMmsZRuUU2nj3Us4AcmmqjNG/iQMHq
 tlxTN1GKCIjPUiG48PzxxJs0ewI3e4fP3zufit8NvjT1fwA8Mko+RoWUwkPqCkPdug0/G3
 FG16gJdm5YtcHHcNwK4k0Ek9ktE62a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYZtWW/BG1VVPc2RlzeHfPalbRqchXjdPpj+gIrK+Rg=;
 b=JspJLqEUCHRhcFJkjRviJqsLqf2nu39JpEHs5SAEHFLko0bE9k/UiDsAIYimXw4AjqPZGX
 oXxcku7y/b5UzTAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYZtWW/BG1VVPc2RlzeHfPalbRqchXjdPpj+gIrK+Rg=;
 b=D8blho+5DO0lqsUOXGG4EnoWqPj7jXMR9f3UJrIjGMmsZRuUU2nj3Us4AcmmqjNG/iQMHq
 tlxTN1GKCIjPUiG48PzxxJs0ewI3e4fP3zufit8NvjT1fwA8Mko+RoWUwkPqCkPdug0/G3
 FG16gJdm5YtcHHcNwK4k0Ek9ktE62a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYZtWW/BG1VVPc2RlzeHfPalbRqchXjdPpj+gIrK+Rg=;
 b=JspJLqEUCHRhcFJkjRviJqsLqf2nu39JpEHs5SAEHFLko0bE9k/UiDsAIYimXw4AjqPZGX
 oXxcku7y/b5UzTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C9EB593A3;
 Tue,  5 May 2026 16:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4D1fDzgW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 04/15] tests/qtest/migration: Group unix migration tests
Date: Tue,  5 May 2026 13:09:03 -0300
Message-ID: <20260505160915.25558-5-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
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

Remove some repetition when defining unix: tests by introducing a
_common function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c |  6 +----
 tests/qtest/migration/framework.c         |  9 +++++++
 tests/qtest/migration/framework.h         |  1 +
 tests/qtest/migration/precopy-tests.c     | 30 +++--------------------
 tests/qtest/migration/tls-tests.c         | 12 ++-------
 5 files changed, 17 insertions(+), 41 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 845e622cd5..7f2856b7f8 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -123,10 +123,6 @@ migrate_hook_start_xbzrle(QTestState *from,
 
 static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->connect_uri = uri;
-    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_xbzrle;
     args->iterations = 2;
     /*
@@ -137,7 +133,7 @@ static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
 
     args->start.caps[MIGRATION_CAPABILITY_XBZRLE] = true;
 
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void *
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 42f565af7b..73bb015f64 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -934,6 +934,15 @@ finish:
     return 0;
 }
 
+void test_precopy_unix_common(MigrateCommon *args)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+
+    args->listen_uri = uri;
+    args->connect_uri = uri;
+    test_precopy_common(args);
+}
+
 static void file_dirty_offset_region(void)
 {
     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 13ce84b49e..613839dec8 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -239,6 +239,7 @@ void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args,
                                    PostcopyRecoveryFailStage fail_stage);
 int test_precopy_common(MigrateCommon *args);
+void test_precopy_unix_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a0e3ff0547..54e45e2a02 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -37,62 +37,40 @@ static char *tmpfs;
 
 static void test_precopy_unix_plain(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     /*
      * The simplest use case of precopy, covering smoke tests of
      * get-dirty-log dirty tracking.
      */
     args->live = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void test_precopy_unix_suspend_live(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     /*
      * despite being live, the test is fast because the src
      * suspends immediately.
      */
     args->live = true;
-
     args->start.suspend_me = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void test_precopy_unix_suspend_notlive(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     args->start.suspend_me = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 static void test_precopy_unix_dirty_ring(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->listen_uri = uri;
-    args->connect_uri = uri;
     /*
      * Besides the precopy/unix basic test, cover dirty ring interface
      * rather than get-dirty-log.
      */
     args->live = true;
-
     args->start.use_dirty_ring = true;
-
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 #ifdef CONFIG_RDMA
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 87898af260..0677ca661e 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -424,14 +424,10 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
 
 static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->connect_uri = uri;
-    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 
 #ifdef CONFIG_TASN1
@@ -454,14 +450,10 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
 static void test_precopy_unix_tls_x509_override_host(char *name,
                                                      MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-
-    args->connect_uri = uri;
-    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(args);
+    test_precopy_unix_common(args);
 }
 #endif /* CONFIG_TASN1 */
 
-- 
2.51.0


