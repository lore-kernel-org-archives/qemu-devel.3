Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716D8CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMns8-0003Vg-FJ; Tue, 12 May 2026 10:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMnru-0003VA-J5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:13:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMnro-0005XE-4K
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:13:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31737758B1;
 Tue, 12 May 2026 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778595226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mJoAs3KxRfdHs9dGWiTHQaMVMpxy4wyLPN3qTuBpOdY=;
 b=HQAqW82el6dUxvxgVo3oqGgs0OITZRru6tn+PfFAMyW6ginS/QztWprIRRpyHNgC+PHugz
 61QLWwh2BF6rm6GeGRZeyBBZHBF9oBydKcZ468zGpYnUh7L2froEmQU21I11LyOBQIMqZv
 StXMVEtECvVHTewawWPz7w6XnUX9vpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778595226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mJoAs3KxRfdHs9dGWiTHQaMVMpxy4wyLPN3qTuBpOdY=;
 b=0554hbPSNlj1cYbZg5kgEEQWIOXFPrEC+253HqAmMdyJjEbrPHSv/vblOAI4XorDTGdeAs
 7o6+4Btdg3m0DCCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778595226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mJoAs3KxRfdHs9dGWiTHQaMVMpxy4wyLPN3qTuBpOdY=;
 b=HQAqW82el6dUxvxgVo3oqGgs0OITZRru6tn+PfFAMyW6ginS/QztWprIRRpyHNgC+PHugz
 61QLWwh2BF6rm6GeGRZeyBBZHBF9oBydKcZ468zGpYnUh7L2froEmQU21I11LyOBQIMqZv
 StXMVEtECvVHTewawWPz7w6XnUX9vpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778595226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mJoAs3KxRfdHs9dGWiTHQaMVMpxy4wyLPN3qTuBpOdY=;
 b=0554hbPSNlj1cYbZg5kgEEQWIOXFPrEC+253HqAmMdyJjEbrPHSv/vblOAI4XorDTGdeAs
 7o6+4Btdg3m0DCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13385593A9;
 Tue, 12 May 2026 14:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V/9pNZg1A2o+BAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 May 2026 14:13:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1] tests/qtest/migration: Fix auto-converge test
Date: Tue, 12 May 2026 11:13:38 -0300
Message-ID: <20260512141338.10089-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

We fixed the cpu throttling sync thread affecting the
dirty-sync-count, but the test still relies on it to gauge for
progress. Remove that block from the test with no replacement.

While here remove several incorrect or redundant comments.

Fixes: 9519d3667a ("migration: Move iteration counter out of RAM")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/precopy-tests.c | 62 ++-------------------------
 1 file changed, 3 insertions(+), 59 deletions(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a0e3ff0547..c4ead906c1 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -291,35 +291,12 @@ static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 }
 #endif /* _WIN32 */
 
-/*
- * The way auto_converge works, we need to do too many passes to
- * run this test.  Auto_converge logic is only run once every
- * three iterations, so:
- *
- * - 3 iterations without auto_converge enabled
- * - 3 iterations with pct = 5
- * - 3 iterations with pct = 30
- * - 3 iterations with pct = 55
- * - 3 iterations with pct = 80
- * - 3 iterations with pct = 95 (max(95, 80 + 25))
- *
- * To make things even worse, we need to run the initial stage at
- * 3MB/s so we enter autoconverge even when host is (over)loaded.
- */
 static void test_auto_converge(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
     int64_t percentage;
-
-    /*
-     * We want the test to be stable and as fast as possible.
-     * E.g., with 1Gb/s bandwidth migration may pass without throttling,
-     * so we need to decrease a bandwidth.
-     */
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
-    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
-    int max_try_count, hit = 0;
 
     if (migrate_start(&from, &to, uri, &args->start)) {
         return;
@@ -330,21 +307,16 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     migrate_set_parameter_int(from, "cpu-throttle-increment", inc_pct);
     migrate_set_parameter_int(from, "max-cpu-throttle", max_pct);
 
-    /*
-     * Set the initial parameters so that the migration could not converge
-     * without throttling.
-     */
     migrate_ensure_non_converge(from);
 
     /* To check remaining size after precopy */
     migrate_set_capability(from, "pause-before-switchover", true);
 
-    /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
-    /* Wait for throttling begins */
+    /* Wait until throttling begins */
     percentage = 0;
     do {
         percentage = read_migrate_property_int(from, "cpu-throttle-percentage");
@@ -357,36 +329,8 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
 
-    /*
-     * End the loop when the dirty sync count greater than 1.
-     */
-    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
-        usleep(1000 * 1000);
-    }
-
-    prev_dirty_sync_cnt = dirty_sync_cnt;
-
-    /*
-     * The RAMBlock dirty sync count must changes in 5 seconds, here we set
-     * the timeout to 10 seconds to ensure it changes.
-     *
-     * Note that migrate_ensure_non_converge set the max-bandwidth to 3MB/s,
-     * while the qtest mem is >= 100MB, one iteration takes at least 33s (100/3)
-     * to complete; this ensures that the RAMBlock dirty sync occurs.
-     */
-    max_try_count = 10;
-    while (--max_try_count) {
-        dirty_sync_cnt = get_migration_pass(from);
-        if (dirty_sync_cnt != prev_dirty_sync_cnt) {
-            hit = 1;
-            break;
-        }
-        prev_dirty_sync_cnt = dirty_sync_cnt;
-        sleep(1);
-    }
-    g_assert_cmpint(hit, ==, 1);
-
-    /* Now, when we tested that throttling works, let it converge */
+    /* throttling always ignores the first pass */
+    assert(get_migration_pass(from) == 2);
     migrate_ensure_converge(from);
 
     /*
-- 
2.51.0


