Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF89E69E95
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 22:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEUP-00076x-7K; Mon, 02 Dec 2024 17:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUN-00076n-Ou
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUL-0003dS-IQ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:55 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 572CF1F387;
 Mon,  2 Dec 2024 22:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siRO2ER29XgC/MLznmevspyWks+406KbmDeRkQWUaPI=;
 b=WucXY2W81bBktZ56JDcp3wnI1un0vmucUWe/2XhqkpGw77k3qV5+oVxdJ8mxPe+MO9ml9X
 rtUVW1i1yVpnCH02JZceonFXtlVDzSyMND++vfR+iih7BQR+TqvZuP371fwonLtl50b/uN
 X/CBRLZrTIolUgjnZZgrkOtHU4FGu0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siRO2ER29XgC/MLznmevspyWks+406KbmDeRkQWUaPI=;
 b=bjt0X6j8yjmu7KpR3ZfX5MpcMdzkG7T3VOiQIMVZSEu4uX4hCFEnvLcyagnIAQrdniYRCb
 J1VXg36V8Xw+hOCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siRO2ER29XgC/MLznmevspyWks+406KbmDeRkQWUaPI=;
 b=WucXY2W81bBktZ56JDcp3wnI1un0vmucUWe/2XhqkpGw77k3qV5+oVxdJ8mxPe+MO9ml9X
 rtUVW1i1yVpnCH02JZceonFXtlVDzSyMND++vfR+iih7BQR+TqvZuP371fwonLtl50b/uN
 X/CBRLZrTIolUgjnZZgrkOtHU4FGu0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176912;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siRO2ER29XgC/MLznmevspyWks+406KbmDeRkQWUaPI=;
 b=bjt0X6j8yjmu7KpR3ZfX5MpcMdzkG7T3VOiQIMVZSEu4uX4hCFEnvLcyagnIAQrdniYRCb
 J1VXg36V8Xw+hOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2173D13A31;
 Mon,  2 Dec 2024 22:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8LsiNk4uTmdlIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Dec 2024 22:01:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/6] tests/qtest/migration: Add a cancel test
Date: Mon,  2 Dec 2024 19:01:37 -0300
Message-Id: <20241202220137.32584-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202220137.32584-1-farosas@suse.de>
References: <20241202220137.32584-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

The qmp_migrate_cancel() command is poorly tested and code inspection
reveals that there might be concurrency issues with its usage. Add a
test that runs a migration and calls qmp_migrate_cancel() at specific
moments.

In order to make the test more deterministic, instead of calling
qmp_migrate_cancel() at random moments during migration, do it after
the migration status change events are seen.

The expected result is that qmp_migrate_cancel() on the source ends
migration on the source with the "cancelled" state and ends migration
on the destination with the "failed" state.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 243 +++++++++++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 74d3000198..48942289bf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -23,6 +23,8 @@
 #include "qapi/qmp/qlist.h"
 #include "ppc-util.h"
 
+#include "qapi-types-migration.h"
+
 #include "migration-helpers.h"
 #include "tests/migration/migration-test.h"
 #ifdef CONFIG_GNUTLS
@@ -3774,6 +3776,234 @@ static bool kvm_dirty_ring_supported(void)
 #endif
 }
 
+static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
+                                         const char *uri, const char *phase)
+{
+    /*
+     * No migrate_incoming_qmp() at the start to force source into
+     * failed state during migrate_qmp().
+     */
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migration_event_wait(from, phase);
+    migrate_cancel(from);
+
+    /* cancelling will not move the migration out of 'failed' */
+
+    wait_for_migration_status(from, "failed",
+                              (const char * []) { "completed", NULL });
+
+    /*
+     * Not waiting for the destination because it never started
+     * migration.
+     */
+}
+
+static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
+                                            const char *uri, const char *phase)
+{
+    migrate_incoming_qmp(to, uri, "{ 'exit-on-error': false }");
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    /* To move to cancelled/cancelling */
+    migrate_cancel(from);
+    migration_event_wait(from, phase);
+
+    /* The migrate_cancel under test */
+    migrate_cancel(from);
+
+    wait_for_migration_status(from, "cancelled",
+                              (const char * []) { "completed", NULL });
+
+    wait_for_migration_status(to, "failed",
+                              (const char * []) { "completed", NULL });
+}
+
+static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
+                                           const char *uri, const char *phase)
+{
+    migrate_incoming_qmp(to, uri, "{ 'exit-on-error': false }");
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migration_event_wait(from, phase);
+    migrate_cancel(from);
+
+    /*
+     * qmp_migrate_cancel() exits early if migration is not running
+     * anymore, the status will not change to cancelled.
+     */
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+}
+
+static void test_cancel_src_after_none(QTestState *from, QTestState *to,
+                                       const char *uri, const char *phase)
+{
+    /*
+     * Test that cancelling without a migration happening does not
+     * affect subsequent migrations
+     */
+    migrate_cancel(to);
+
+    wait_for_serial("src_serial");
+    migrate_cancel(from);
+
+    migrate_incoming_qmp(to, uri, "{ 'exit-on-error': false }");
+
+    migrate_ensure_converge(from);
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+}
+
+static void test_cancel_src_after_postcopy(QTestState *from, QTestState *to,
+                                           const char *uri, const char *phase)
+{
+    bool postcopy_active = g_str_equal(phase, "postcopy-active");
+    bool postcopy_paused = g_str_equal(phase, "postcopy-paused");
+    bool postcopy_recover = g_str_equal(phase, "postcopy-recover-setup") ||
+        g_str_equal(phase, "postcopy-recover");
+
+    migrate_set_capability(from, "postcopy-ram", true);
+    migrate_set_capability(to, "postcopy-ram", true);
+
+    migrate_incoming_qmp(to, uri, "{ 'exit-on-error': false }");
+
+    wait_for_serial("src_serial");
+    migrate_ensure_non_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migration_event_wait(from, "active");
+
+    /* Turn postcopy speed down, 4K/s is slow enough on any machines */
+    migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
+    qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
+
+    if (!postcopy_active) {
+        migration_event_wait(from, "postcopy-active");
+        migration_event_wait(to, "postcopy-active");
+
+        wait_for_stop(from, &src_state);
+        qtest_qmp_eventwait(to, "RESUME");
+
+        migrate_pause(from);
+    }
+
+    if (postcopy_recover) {
+        migration_event_wait(to, "postcopy-paused");
+        migration_event_wait(from, "postcopy-paused");
+
+        migrate_recover(to, uri);
+        migrate_qmp(from, to, uri, NULL, "{'resume': true}");
+    }
+
+    migration_event_wait(from, phase);
+    migrate_cancel(from);
+    migration_event_wait(from, "cancelling");
+
+    wait_for_migration_status(from, "cancelled",
+                              (const char * []) { "completed", NULL });
+
+    if (postcopy_paused || postcopy_recover) {
+        /*
+         * Cancelling on source is not detectable by the destination,
+         * so it remains paused.
+         */
+        migration_event_wait(to, "postcopy-paused");
+    } else {
+        wait_for_migration_status(to, "failed",
+                                  (const char * []) { "completed", NULL });
+    }
+}
+
+static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
+                                           const char *uri, const char *phase)
+{
+    migrate_set_capability(from, "pause-before-switchover", true);
+    migrate_set_capability(to, "pause-before-switchover", true);
+
+    migrate_set_parameter_int(from, "multifd-channels", 2);
+    migrate_set_parameter_int(to, "multifd-channels", 2);
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    migrate_incoming_qmp(to, uri, "{ 'exit-on-error': false }");
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migration_event_wait(from, phase);
+    migrate_cancel(from);
+    migration_event_wait(from, "cancelling");
+
+    wait_for_migration_status(from, "cancelled",
+                              (const char * []) { "completed", NULL });
+
+    wait_for_migration_status(to, "failed",
+                              (const char * []) { "completed", NULL });
+}
+
+static void test_cancel_src_after_status(void *opaque)
+{
+    const char *test_path = opaque;
+    g_autofree char *phase = g_path_get_basename(test_path);
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    MigrateStart args = {
+        .hide_stderr = true,
+    };
+
+    if (test_migrate_start(&from, &to, "defer", &args)) {
+        return;
+    }
+
+    if (g_str_has_prefix(phase, "postcopy")) {
+        if (!ufd_version_check()) {
+            g_test_skip("No postcopy support. "
+                        "Cannot test migrate_cancel in postcopy states");
+            goto out;
+        }
+
+        test_cancel_src_after_postcopy(from, to, uri, phase);
+
+    } else if (g_str_equal(phase, "cancelling") ||
+               g_str_equal(phase, "cancelled")) {
+        test_cancel_src_after_cancelled(from, to, uri, phase);
+
+    } else if (g_str_equal(phase, "completed")) {
+        test_cancel_src_after_complete(from, to, uri, phase);
+
+    } else if (g_str_equal(phase, "failed")) {
+        test_cancel_src_after_failed(from, to, uri, phase);
+
+    } else if (g_str_equal(phase, "none")) {
+        test_cancel_src_after_none(from, to, uri, phase);
+
+    } else {
+        /* any state that comes before pre-switchover */
+        test_cancel_src_pre_switchover(from, to, uri, phase);
+    }
+
+out:
+    test_migrate_end(from, to, false);
+}
+
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
@@ -4034,6 +4264,19 @@ int main(int argc, char **argv)
         }
     }
 
+    for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
+        switch (i) {
+        case MIGRATION_STATUS_DEVICE: /* happens too fast */
+        case MIGRATION_STATUS_WAIT_UNPLUG: /* no support in tests */
+        case MIGRATION_STATUS_COLO: /* no support in tests */
+            continue;
+        default:
+            migration_test_add_suffix("/migration/cancel/src/after/",
+                                      MigrationStatus_str(i),
+                                      test_cancel_src_after_status);
+        }
+    }
+
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
2.35.3


