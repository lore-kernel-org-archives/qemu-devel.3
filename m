Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EFCC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTx-00042S-SY; Fri, 21 Jun 2024 13:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTw-0003xM-GN
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:28 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTu-0003fc-AF
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBABC1F7F2;
 Fri, 21 Jun 2024 17:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us4frndFyCNSheambPS6o9NAb9jTM2+BpJbWyRSqIMg=;
 b=BQ7bELo1mCPd5Tft168IFyFhmVnoXwg/+5/wtJpuvmkjd8/NdCpO9kQR9mf1QyrQ19Zjux
 X2tnOOk9OXUnNsktiJ0ZP+7EvtagIfMpxGiXcI1mcjuuEqzzlUNFlvE2NE78wDeu2VTZ3g
 +o9gp/VJBE2PJRm4J+Gae7ovIXBLBnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us4frndFyCNSheambPS6o9NAb9jTM2+BpJbWyRSqIMg=;
 b=9Oe0Be0z+qcwCnCLtLbhnO+UqrQG0TFBwMWr91lqHNpE1sFsKi53e3JYuwHugu5iwhsiFY
 VLL8m7kuWxJEbgAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BQ7bELo1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9Oe0Be0z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us4frndFyCNSheambPS6o9NAb9jTM2+BpJbWyRSqIMg=;
 b=BQ7bELo1mCPd5Tft168IFyFhmVnoXwg/+5/wtJpuvmkjd8/NdCpO9kQR9mf1QyrQ19Zjux
 X2tnOOk9OXUnNsktiJ0ZP+7EvtagIfMpxGiXcI1mcjuuEqzzlUNFlvE2NE78wDeu2VTZ3g
 +o9gp/VJBE2PJRm4J+Gae7ovIXBLBnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us4frndFyCNSheambPS6o9NAb9jTM2+BpJbWyRSqIMg=;
 b=9Oe0Be0z+qcwCnCLtLbhnO+UqrQG0TFBwMWr91lqHNpE1sFsKi53e3JYuwHugu5iwhsiFY
 VLL8m7kuWxJEbgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEA4113AAA;
 Fri, 21 Jun 2024 17:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qItLHIu+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/28] tests/migration-tests: Cover postcopy failure on
 reconnect
Date: Fri, 21 Jun 2024 14:54:33 -0300
Message-Id: <20240621175434.31180-28-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBABC1F7F2
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Peter Xu <peterx@redhat.com>

Make sure there will be an event for postcopy recovery, irrelevant of
whether the reconnect will success, or when the failure happens.

The added new case is to fail early in postcopy recovery, in which case it
didn't even reach RECOVER stage on src (and in real life it'll be the same
to dest, but the test case is just slightly more involved due to the dual
socketpair setup).

To do that, rename the postcopy_recovery_test_fail to reflect either stage
to fail, instead of a boolean.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 95 +++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e61096adfe..571fc1334c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -73,6 +73,17 @@ static QTestMigrationState dst_state;
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 
+typedef enum PostcopyRecoveryFailStage {
+    /*
+     * "no failure" must be 0 as it's the default.  OTOH, real failure
+     * cases must be >0 to make sure they trigger by a "if" test.
+     */
+    POSTCOPY_FAIL_NONE = 0,
+    POSTCOPY_FAIL_CHANNEL_ESTABLISH,
+    POSTCOPY_FAIL_RECOVERY,
+    POSTCOPY_FAIL_MAX
+} PostcopyRecoveryFailStage;
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -693,7 +704,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
-    bool postcopy_recovery_test_fail;
+    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1371,12 +1382,16 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
                                                   "completed", NULL });
 }
 
-static void postcopy_recover_fail(QTestState *from, QTestState *to)
+static void postcopy_recover_fail(QTestState *from, QTestState *to,
+                                  PostcopyRecoveryFailStage stage)
 {
 #ifndef _WIN32
+    bool fail_early = (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH);
     int ret, pair1[2], pair2[2];
     char c;
 
+    g_assert(stage > POSTCOPY_FAIL_NONE && stage < POSTCOPY_FAIL_MAX);
+
     /* Create two unrelated socketpairs */
     ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
     g_assert_cmpint(ret, ==, 0);
@@ -1410,6 +1425,14 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     ret = send(pair2[1], &c, 1, 0);
     g_assert_cmpint(ret, ==, 1);
 
+    if (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
+        /*
+         * This will make src QEMU to fail at an early stage when trying to
+         * resume later, where it shouldn't reach RECOVER stage at all.
+         */
+        close(pair1[1]);
+    }
+
     migrate_recover(to, "fd:fd-mig");
     migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
@@ -1419,28 +1442,53 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
      */
     migration_event_wait(from, "postcopy-recover-setup");
 
+    if (fail_early) {
+        /*
+         * When fails at reconnection, src QEMU will automatically goes
+         * back to PAUSED state.  Making sure there is an event in this
+         * case: Libvirt relies on this to detect early reconnection
+         * errors.
+         */
+        migration_event_wait(from, "postcopy-paused");
+    } else {
+        /*
+         * We want to test "fail later" at RECOVER stage here.  Make sure
+         * both QEMU instances will go into RECOVER stage first, then test
+         * kicking them out using migrate-pause.
+         *
+         * Explicitly check the RECOVER event on src, that's what Libvirt
+         * relies on, rather than polling.
+         */
+        migration_event_wait(from, "postcopy-recover");
+        wait_for_postcopy_status(from, "postcopy-recover");
+
+        /* Need an explicit kick on src QEMU in this case */
+        migrate_pause(from);
+    }
+
     /*
-     * Make sure both QEMU instances will go into RECOVER stage, then test
-     * kicking them out using migrate-pause.
+     * For all failure cases, we'll reach such states on both sides now.
+     * Check them.
      */
-    wait_for_postcopy_status(from, "postcopy-recover");
+    wait_for_postcopy_status(from, "postcopy-paused");
     wait_for_postcopy_status(to, "postcopy-recover");
 
     /*
-     * This would be issued by the admin upon noticing the hang, we should
-     * make sure we're able to kick this out.
+     * Kick dest QEMU out too. This is normally not needed in reality
+     * because when the channel is shutdown it should also happen on src.
+     * However here we used separate socket pairs so we need to do that
+     * explicitly.
      */
-    migrate_pause(from);
-    wait_for_postcopy_status(from, "postcopy-paused");
-
-    /* Do the same test on dest */
     migrate_pause(to);
     wait_for_postcopy_status(to, "postcopy-paused");
 
     close(pair1[0]);
-    close(pair1[1]);
     close(pair2[0]);
     close(pair2[1]);
+
+    if (stage != POSTCOPY_FAIL_CHANNEL_ESTABLISH) {
+        close(pair1[1]);
+    }
 #endif
 }
 
@@ -1482,12 +1530,12 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
-    if (args->postcopy_recovery_test_fail) {
+    if (args->postcopy_recovery_fail_stage) {
         /*
          * Test when a wrong socket specified for recover, and then the
          * ability to kick it out, and continue with a correct socket.
          */
-        postcopy_recover_fail(from, to);
+        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
         /* continue with a good recovery */
     }
 
@@ -1518,10 +1566,19 @@ static void test_postcopy_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-static void test_postcopy_recovery_double_fail(void)
+static void test_postcopy_recovery_fail_handshake(void)
 {
     MigrateCommon args = {
-        .postcopy_recovery_test_fail = true,
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_postcopy_recovery_fail_reconnect(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
     };
 
     test_postcopy_recovery_common(&args);
@@ -3791,8 +3848,10 @@ int main(int argc, char **argv)
                            test_postcopy_preempt);
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
-        migration_test_add("/migration/postcopy/recovery/double-failures",
-                           test_postcopy_recovery_double_fail);
+        migration_test_add("/migration/postcopy/recovery/double-failures/handshake",
+                           test_postcopy_recovery_fail_handshake);
+        migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
+                           test_postcopy_recovery_fail_reconnect);
         if (is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
-- 
2.35.3


