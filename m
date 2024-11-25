Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C467FD58D55
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaMW-0007Xd-Qk; Mon, 25 Nov 2024 09:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaMH-0007VH-51; Mon, 25 Nov 2024 09:46:37 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaME-0004Ap-Cg; Mon, 25 Nov 2024 09:46:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E261E21190;
 Mon, 25 Nov 2024 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7enqESChfvR0CAJwTxUUoUtZMHOz3j3mX4EYPrGvXc=;
 b=aXoyxbLFsgUSTMZafvrhsaelUGCgH3nGktWEwLeW9bGp5DpKuHdqftMkiOeev5QEKslAUi
 JI8KJv5cGQItwZ3GGTmyMg6Dz3mACnTeLul2cWiwNT+wZjLYME2lvs80Xv/81SolVn2eAn
 hwhEiilxYfDBS/TFz/V1LlPNWfiFpyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7enqESChfvR0CAJwTxUUoUtZMHOz3j3mX4EYPrGvXc=;
 b=Bc6aSr0MTK7IPZpYU1G3EL/+7PQUt4lB6OTn3u/j2rmn3f3vPkLYPnwJIS4N8NvpQv0Hre
 8ip9ki1+IuKGOsAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SZaOpKxG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JSLh5a2g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7enqESChfvR0CAJwTxUUoUtZMHOz3j3mX4EYPrGvXc=;
 b=SZaOpKxG5nlgnXVZULkcUcgZJDj1KjPOjPkPkP0mY2pLwG9avznjxi9fddbSQnidoPA6k8
 fcmXwAtDai1rYheUydtAyx//XemHxjRHcAEcLVIRJcFhhwTVcQV/c2PUOLCZghqyzuIpM3
 u07b0QKhOE6BA5GLdl2+MX+rSsFnAII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7enqESChfvR0CAJwTxUUoUtZMHOz3j3mX4EYPrGvXc=;
 b=JSLh5a2gb99EcZt/XbRfONkJfJwBPsGp5ZUd4qbeVl5X/+PGPZOfW+FTgsZjL1LEFUXPEA
 8G2mkHSAcCPY6bBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFE64137D4;
 Mon, 25 Nov 2024 14:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gKFKJcSNRGdRTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 14:46:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 5/5] tests/qtest/migration: Test successive migrations
Date: Mon, 25 Nov 2024 11:46:12 -0300
Message-Id: <20241125144612.16194-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241125144612.16194-1-farosas@suse.de>
References: <20241125144612.16194-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E261E21190
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Add a framework for running migrations back and forth between two
guests (aka ping-pong migration). We have seen a couple of bugs that
only reproduce when a guest is migrated and the destination machine is
used as the source of a new migration.

Add a simple test that does 2 migrations and another test that uses
the late-block-activate capability, which is one area where a bug has
been found.

Note that this does not reuse any of the existing tests
(e.g. test_precopy_common), because there is too much ambiguity
regarding how to handle the hooks, args->result, stop/continue, etc.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 121 +++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f27dd93835..ee1422c8e8 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1817,6 +1817,104 @@ finish:
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
+static void migrate_dst_becomes_src(QTestState **from, QTestState **to,
+                                    QTestMigrationState *src_state,
+                                    QTestMigrationState *dst_state)
+{
+    *from = *to;
+
+    *src_state = (QTestMigrationState) { };
+    src_state->serial = dst_state->serial;
+    qtest_qmp_set_event_callback(*from, migrate_watch_for_events, src_state);
+
+    src_state->stop_seen = dst_state->stop_seen;
+}
+
+static void test_precopy_ping_pong_common(MigrateCommon *args, int n,
+                                          bool late_block_activate)
+{
+    QTestState *from, *to;
+    bool keep_paused = false;
+
+    g_assert(!args->live);
+
+    g_test_message("Migrating back and forth %d times", n);
+
+    for (int i = 0; i < n; i++) {
+        g_test_message("%s (%d/%d)", i % 2 ? "pong" : "ping", i + 1, n);
+
+        if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+            return;
+        }
+
+        if (late_block_activate) {
+            migrate_set_capability(from, "late-block-activate", true);
+            migrate_set_capability(to, "late-block-activate", true);
+
+            /*
+             * The late-block-activate capability expects that the
+             * management layer will issue a qmp_continue command on
+             * the destination once the migration finishes. In order
+             * to test the capability properly, make sure the test is
+             * not issuing spurious continue commands.
+             */
+            keep_paused = true;
+        }
+
+        if (!src_state.stop_seen) {
+            wait_for_serial(src_state.serial);
+        }
+
+        /* because of !args->live */
+        qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+        wait_for_stop(from, &src_state);
+
+        migrate_ensure_converge(from);
+        migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
+
+        wait_for_migration_complete(from);
+        wait_for_migration_complete(to);
+
+        /* note check_guests_ram() requires a stopped guest */
+        check_guests_ram(to);
+
+        if (keep_paused) {
+            /*
+             * Nothing issued continue on the destination, reflect
+             * that the guest is paused in the dst_state.
+             */
+            dst_state.stop_seen = true;
+        } else {
+            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+            wait_for_serial(dst_state.serial);
+            dst_state.stop_seen = false;
+        }
+
+        /*
+         * Last iteration, let the guest run to make sure there's no
+         * memory corruption. The test_migrate_end() below will check
+         * the memory one last time.
+         */
+        if (i == n - 1) {
+            qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+            wait_for_serial(dst_state.serial);
+            dst_state.stop_seen = false;
+            break;
+        }
+
+        /*
+         * Prepare for migrating back: clear the original source and
+         * switch source & destination.
+         */
+        migrate_cleanup(from, NULL);
+        migrate_dst_becomes_src(&from, &to, &src_state, &dst_state);
+
+        args->start.only_target = true;
+    }
+
+    test_migrate_end(from, to, true);
+}
+
 static void file_dirty_offset_region(void)
 {
     g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
@@ -3765,6 +3863,24 @@ static void test_migrate_dirty_limit(void)
     test_migrate_end(from, to, true);
 }
 
+static void test_precopy_ping_pong(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+    };
+
+    test_precopy_ping_pong_common(&args, 2, false);
+}
+
+static void test_precopy_ping_pong_late_block(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+    };
+
+    test_precopy_ping_pong_common(&args, 2, true);
+}
+
 static bool kvm_dirty_ring_supported(void)
 {
 #if defined(__linux__) && defined(HOST_X86_64)
@@ -4048,6 +4164,11 @@ int main(int argc, char **argv)
         }
     }
 
+    migration_test_add("/migration/precopy/ping-pong/plain",
+                       test_precopy_ping_pong);
+    migration_test_add("/migration/precopy/ping-pong/late-block-activate",
+                       test_precopy_ping_pong_late_block);
+
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
2.35.3


