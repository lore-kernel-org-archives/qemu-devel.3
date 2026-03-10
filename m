Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9474AFD2D9A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxYy-00046H-3k; Tue, 10 Mar 2026 09:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxYw-000466-Ro
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:55:54 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzxYv-0006vR-5E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:55:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2AB44D211;
 Tue, 10 Mar 2026 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDytoEY7rdITC/LPBNW2KmyIs4i7pB7P8iyv8gIrLsM=;
 b=JyySx91g8VrrizdXW4o540q1UvTUZKdpnsz9MTGhrQOGQJQTlSH2Q4JwmNuKTsnnkrbzRH
 Or4Ab92PUA32+KRw3eJ/aUauqAP7ryHKVKP58604P3txdjNBggVIl45MKBV+TTBnSklpS7
 7ulqJVQztfFWod2V0t4vsscGVuZIAAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDytoEY7rdITC/LPBNW2KmyIs4i7pB7P8iyv8gIrLsM=;
 b=Q6P1bsEVNQVSrSdy6t5TimfceiOlTAIeK5lk+4biF+NW7qFFpsrM6WtP6k2nACCxWFOyUi
 BtBZRM/HUQSkHMDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773150946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDytoEY7rdITC/LPBNW2KmyIs4i7pB7P8iyv8gIrLsM=;
 b=JyySx91g8VrrizdXW4o540q1UvTUZKdpnsz9MTGhrQOGQJQTlSH2Q4JwmNuKTsnnkrbzRH
 Or4Ab92PUA32+KRw3eJ/aUauqAP7ryHKVKP58604P3txdjNBggVIl45MKBV+TTBnSklpS7
 7ulqJVQztfFWod2V0t4vsscGVuZIAAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773150946;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDytoEY7rdITC/LPBNW2KmyIs4i7pB7P8iyv8gIrLsM=;
 b=Q6P1bsEVNQVSrSdy6t5TimfceiOlTAIeK5lk+4biF+NW7qFFpsrM6WtP6k2nACCxWFOyUi
 BtBZRM/HUQSkHMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BCFA3F4B3;
 Tue, 10 Mar 2026 13:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OA3DOOAisGnFcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 13:55:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/8] tests/qtest/migration: Change validate_uuid test to not
 trigger exit(1)
Date: Tue, 10 Mar 2026 10:55:34 -0300
Message-ID: <20260310135540.8679-2-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310135540.8679-1-farosas@suse.de>
References: <20260310135540.8679-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.985];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
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

The UUID validation happens early enough during the migration process
that the incoming coroutine hasn't yet yielded once so the
EXIT_FAILURE from the coroutine can trigger ASAN leak detection due to
the temporary socket from qio_net_listener_channel_func() still having
an elevated refcount.

Direct leak of 400 byte(s) in 1 object(s) allocated from:
    #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
    #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
    #2 0x55e66a8ef05f in object_new_with_type ../qom/object.c:767:15
    #3 0x55e66a8ef178 in object_new ../qom/object.c:789:12
    #4 0x55e66a93bcc6 in qio_channel_socket_new ../io/channel-socket.c:70:31
    #5 0x55e66a93f34f in qio_channel_socket_accept ../io/channel-socket.c:401:12
    #6 0x55e66a96752a in qio_net_listener_channel_func ../io/net-listener.c:64:12
    #7 0x55e66a94bdac in qio_channel_fd_source_dispatch ../io/channel-watch.c:84:12
    #8 0x7f3c7e2adf4b in g_main_dispatch ../glib/gmain.c:3476
    #9 0x7f3c7e2adf4b in g_main_context_dispatch_unlocked ../glib/gmain.c:4284
    #10 0x7f3c7e2b00c8 in g_main_context_dispatch ../glib/gmain.c:4272

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
    #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
    #2 0x7f3c7e2ad40c in g_source_set_callback ../glib/gmain.c:1879
    #3 0x55e66a95c4d2 in qio_channel_add_watch_full ../io/channel.c:416:5
    #4 0x55e66a95c5a9 in qio_channel_add_watch_source ../io/channel.c:444:10
    #5 0x55e66a96380c in qio_net_listener_watch ../io/net-listener.c:166:46
    #6 0x55e66a96496a in qio_net_listener_set_client_func_internal ../io/net-listener.c:275:5
    #7 0x55e66a963e79 in qio_net_listener_set_client_func_full ../io/net-listener.c:284:5
    #8 0x55e669e1b3bb in socket_connect_incoming ../migration/socket.c:165:5
    #9 0x55e669d26b9f in migration_connect_incoming ../migration/channel.c:83:13
    #10 0x55e669d5f6d2 in qemu_setup_incoming_migration ../migration/migration.c:672:5
    #11 0x55e669d5f344 in qmp_migrate_incoming ../migration/migration.c:1771:5

This is inconsequential in production, but let's give ourselves an
easier time and avoid this situation when testing. The uuid_error test
doesn't really need to check the exit code, just the migration state
would be sufficient. Set exit-on-error=false for this test.

While looking at this, add a comment to the source explaining that the
incoming coroutine may block the main loop for a (longer than
expected) while.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c              | 5 +++++
 tests/qtest/migration/misc-tests.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f949708629..c77832f851 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -898,6 +898,11 @@ void migration_start_incoming(void)
 
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     qemu_coroutine_enter(co);
+    /*
+     * This doesn't return right away. The coroutine will run
+     * unimpeded until its first yield, which may happen as late as
+     * the force yield at ram_load_precopy().
+     */
 }
 
 int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 810e9e6549..06da2657d5 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -131,7 +131,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (migrate_start(&from, &to, uri, args)) {
+    if (migrate_start(&from, &to, "defer", args)) {
         return;
     }
 
@@ -146,10 +146,10 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
+    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
     migrate_qmp(from, to, uri, NULL, "{}");
 
     if (should_fail) {
-        qtest_set_expected_status(to, EXIT_FAILURE);
         wait_for_migration_fail(from, true);
     } else {
         wait_for_migration_complete(from);
-- 
2.51.0


