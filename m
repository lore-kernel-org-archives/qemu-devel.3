Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5DCCD3439
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIM7-0008SV-Ko; Tue, 05 May 2026 12:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILP-00084I-43
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:59 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILM-0008IX-UZ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:09:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F6716B75E;
 Tue,  5 May 2026 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlACn550C2kY5jRmhCHCPEFoNUu1oljVf9BIVf0CMq8=;
 b=AWPgHRFBYrJxxyXdsVDeCzrXqBtMu78IJFgwhiBGeJDrCNwdhSOuazbR/un+Fa3UPrgmyC
 iauuDoM271/zxOp1bZCnzQI3H0Ix5a/oTMcgLmLD/USyrV9F0uey0VXy2z8xseReenOi4z
 1pSrcxXt7ESgTXWPkXBXzP5dXvNXYto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlACn550C2kY5jRmhCHCPEFoNUu1oljVf9BIVf0CMq8=;
 b=U7Rt7JKjXp3r0QRi/0wJwNDFmuEQBW+AzhkDo42NN4ory2S//hSXObrn8NuUu0bkwLifPB
 JQEw26nI5b9xgDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlACn550C2kY5jRmhCHCPEFoNUu1oljVf9BIVf0CMq8=;
 b=AWPgHRFBYrJxxyXdsVDeCzrXqBtMu78IJFgwhiBGeJDrCNwdhSOuazbR/un+Fa3UPrgmyC
 iauuDoM271/zxOp1bZCnzQI3H0Ix5a/oTMcgLmLD/USyrV9F0uey0VXy2z8xseReenOi4z
 1pSrcxXt7ESgTXWPkXBXzP5dXvNXYto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlACn550C2kY5jRmhCHCPEFoNUu1oljVf9BIVf0CMq8=;
 b=U7Rt7JKjXp3r0QRi/0wJwNDFmuEQBW+AzhkDo42NN4ory2S//hSXObrn8NuUu0bkwLifPB
 JQEw26nI5b9xgDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEF6E593A3;
 Tue,  5 May 2026 16:09:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OMkzLzkW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 05/15] tests/qtest/migration: Use precopy_unix_common for
 ignore-shared test
Date: Tue,  5 May 2026 13:09:04 -0300
Message-ID: <20260505160915.25558-6-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
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

The ignore-shared test has the same code as the precopy_common test
but inverting (probably incorrectly) the order of a few event
waits. Change it to use the common code instead.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/misc-tests.c | 40 ++++++++----------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index e114ac5972..8d1cd44183 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -90,40 +90,22 @@ static void test_analyze_script(char *name, MigrateCommon *args)
 }
 #endif
 
-static void test_ignore_shared(char *name, MigrateCommon *args)
+static void ignore_shared_assert_skipped(QTestState *from, QTestState *to,
+                                         void *data)
 {
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
-
-    args->start.mem_type = MEM_TYPE_SHMEM;
-    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
-
-    if (migrate_start(&from, &to, uri, &args->start)) {
-        return;
-    }
-
-    migrate_ensure_non_converge(from);
-    migrate_prepare_for_dirty_mem(from);
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-
-    migrate_qmp(from, to, uri, NULL, "{}");
-
-    migrate_wait_for_dirty_mem(from, to);
-
-    wait_for_stop(from, get_src());
-
-    qtest_qmp_eventwait(to, "RESUME");
-
-    wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
-
     /* Check whether shared RAM has been really skipped */
     g_assert_cmpint(
         read_ram_property_int(from, "transferred"), <, 4 * 1024 * 1024);
+}
 
-    migrate_end(from, to, true);
+static void test_ignore_shared(char *name, MigrateCommon *args)
+{
+    args->live = true;
+    args->start.mem_type = MEM_TYPE_SHMEM;
+    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
+    args->end_hook = ignore_shared_assert_skipped;
+
+    test_precopy_unix_common(args);
 }
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
-- 
2.51.0


