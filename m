Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF407F3C24C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaLx-0007wf-TJ; Mon, 09 Mar 2026 09:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLt-0007Y4-3g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:53 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzaLp-0008Lu-FP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F8C45BD8F;
 Mon,  9 Mar 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoT4sJsTJCVUrSe47rt/c9mPM/gGJe7LdEyAE9/m3NE=;
 b=Oe2IdYwJwys1dZIuCtpKLrTk31fR/XHAndRrspRwlji7OhlzSZnjNRxUbnG3qP2l2TqtNV
 cUN9ra0HyPzFj5HrqsPvM7cjUsi+fG57m/sEgnTOBziMQO/TLKWWmZyvDxEQ4oIvmRX2OR
 2mSWNUeHt1VIDqQHPKeLDbIelRbJWxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoT4sJsTJCVUrSe47rt/c9mPM/gGJe7LdEyAE9/m3NE=;
 b=PpdAZQK6R/5aNouWhCLoq0lgfH4BK8OKRO0ymmRyrfq5sdj+77cn02vCbjzeI+AS0vggoV
 87gClQxF/uCFCGBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773061692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoT4sJsTJCVUrSe47rt/c9mPM/gGJe7LdEyAE9/m3NE=;
 b=Oe2IdYwJwys1dZIuCtpKLrTk31fR/XHAndRrspRwlji7OhlzSZnjNRxUbnG3qP2l2TqtNV
 cUN9ra0HyPzFj5HrqsPvM7cjUsi+fG57m/sEgnTOBziMQO/TLKWWmZyvDxEQ4oIvmRX2OR
 2mSWNUeHt1VIDqQHPKeLDbIelRbJWxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773061692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoT4sJsTJCVUrSe47rt/c9mPM/gGJe7LdEyAE9/m3NE=;
 b=PpdAZQK6R/5aNouWhCLoq0lgfH4BK8OKRO0ymmRyrfq5sdj+77cn02vCbjzeI+AS0vggoV
 87gClQxF/uCFCGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6C1D3EEF2;
 Mon,  9 Mar 2026 13:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iPaCJjrGrmlJcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 09 Mar 2026 13:08:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 22/22] colo: Reuse the return path from migration on primary
 and secondary side
Date: Mon,  9 Mar 2026 10:07:27 -0300
Message-ID: <20260309130730.20526-23-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
References: <20260309130730.20526-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

From: Lukas Straub <lukasstraub2@web.de>

Use the return-path capability with colo and reuse the opened return path
file on both primary and secondary side.

This fixes a crash in colo where migration_cancel() races with colo closing
s->rp_state.from_dst_file.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260302-colo_unit_test_multifd-v11-21-d653fb3b1d80@web.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/system/qemu-colo.rst          |  4 ++--
 migration/colo.c                   | 26 +++++++++-----------------
 migration/options.c                | 10 +++++++++-
 tests/qtest/migration/colo-tests.c |  1 +
 tests/qtest/migration/framework.c  | 13 +++++++++++++
 5 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index a8f608b95e..d45586acd8 100644
--- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -227,7 +227,7 @@ any IP's here, except for the ``$primary_ip`` variable::
 **3.** On Secondary VM's QEMU monitor, issue command::
 
     {"execute":"qmp_capabilities"}
-    {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "return-path", "state": true }, {"capability": "x-colo", "state": true } ] } }
     {"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "data": {"host": "0.0.0.0", "port": "9999"} } } }
     {"execute": "nbd-server-add", "arguments": {"device": "parent0", "writable": true } }
 
@@ -244,7 +244,7 @@ Note:
     {"execute":"qmp_capabilities"}
     {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}, "export": "parent0", "detect-zeroes": "on"} }
     {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "node": "nbd0" } }
-    {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {"capability": "return-path", "state": true }, {"capability": "x-colo", "state": true } ] } }
     {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
 
 Note:
diff --git a/migration/colo.c b/migration/colo.c
index dc47d03874..2d36f933cf 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -539,6 +539,8 @@ static void colo_process_checkpoint(MigrationState *s)
     Error *local_err = NULL;
     int ret;
 
+    assert(s->rp_state.from_dst_file);
+    assert(!s->rp_state.rp_thread_created);
     if (get_colo_mode() != COLO_MODE_PRIMARY) {
         error_report("COLO mode must be COLO_MODE_PRIMARY");
         return;
@@ -546,12 +548,6 @@ static void colo_process_checkpoint(MigrationState *s)
 
     failover_init_state();
 
-    s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
-    if (!s->rp_state.from_dst_file) {
-        error_report("Open QEMUFile from_dst_file failed");
-        goto out;
-    }
-
     packets_compare_notifier.notify = colo_compare_notify_checkpoint;
     colo_compare_register_notifier(&packets_compare_notifier);
 
@@ -636,16 +632,6 @@ out:
     colo_compare_unregister_notifier(&packets_compare_notifier);
     timer_free(s->colo_delay_timer);
     qemu_event_destroy(&s->colo_checkpoint_event);
-
-    /*
-     * Must be called after failover BH is completed,
-     * Or the failover BH may shutdown the wrong fd that
-     * re-used by other threads after we release here.
-     */
-    if (s->rp_state.from_dst_file) {
-        qemu_fclose(s->rp_state.from_dst_file);
-        s->rp_state.from_dst_file = NULL;
-    }
 }
 
 void migrate_start_colo_process(MigrationState *s)
@@ -838,6 +824,7 @@ static void *colo_process_incoming_thread(void *opaque)
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
 
+    assert(mis->to_src_file);
     if (get_colo_mode() != COLO_MODE_SECONDARY) {
         error_report("COLO mode must be COLO_MODE_SECONDARY");
         return NULL;
@@ -854,7 +841,6 @@ static void *colo_process_incoming_thread(void *opaque)
 
     failover_init_state();
 
-    mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration incoming
@@ -866,6 +852,12 @@ static void *colo_process_incoming_thread(void *opaque)
         goto out;
     }
 
+    /*
+     * rp thread still running on primary side, shut it down to go into
+     * colo state.
+     */
+    migrate_send_rp_shut(mis, 0);
+
     colo_incoming_start_dirty_log();
 
     bioc = qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
diff --git a/migration/options.c b/migration/options.c
index 1ffe85a2d8..f33b297929 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -575,7 +575,15 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-#ifndef CONFIG_REPLICATION
+#ifdef CONFIG_REPLICATION
+    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
+        if (!new_caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+            error_setg(errp, "Capability 'x-colo' requires capability "
+                             "'return-path'");
+            return false;
+        }
+    }
+#else
     if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
         error_setg(errp, "QEMU compiled without replication module"
                    " can't enable COLO");
diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index bc20c92d16..ef880f5114 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -42,6 +42,7 @@ static int test_colo_common(MigrateCommon *args,
      * used in production.
      */
     args->start.oob = true;
+    args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 2a3efeb807..0bfc241914 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -216,6 +216,19 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
      * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
      * are from qapi-types-migration.h.
      */
+
+    /*
+     * Enable return path first, since other features depend on it.
+     */
+    if (args->caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
+        if (from) {
+            migrate_set_capability(from, "return-path", true);
+        }
+        if (to) {
+            migrate_set_capability(to, "return-path", true);
+        }
+    }
+
     for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
         if (!args->caps[i]) {
             continue;
-- 
2.51.0


