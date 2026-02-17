Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D03E909D5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNkK-0003br-UO; Tue, 17 Feb 2026 11:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkI-0003QP-Dl
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:18 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNkG-0003FR-J6
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:16:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 946F43E718;
 Tue, 17 Feb 2026 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZ9v1zRre8MJoTcvIKPSMOTVWa31kcAX+dlQiw/brnk=;
 b=xbOII4FIonnBJFJH/aCRLAKee3dF6WvtKaPxdfP07QRO7ViCy5/hm5BAqnFPLGyWGUlPSU
 PuWM7JZfVE67mjayVQRQmBxcdyMxS+d5qfgfbC0FyoobHNGvo3LoiN4JwGjeqVnZb6iIAl
 bwNNbTe8Httqdz0hGn+5cxJsSYQ+9hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZ9v1zRre8MJoTcvIKPSMOTVWa31kcAX+dlQiw/brnk=;
 b=kksFB/vwhJhLG7DaCbqAEEFeii/K01egg+HgH6vwyohWEsTKUILkdyUYrIuIi/94VxZ3mr
 pQflTMaLqsm3m+CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZ9v1zRre8MJoTcvIKPSMOTVWa31kcAX+dlQiw/brnk=;
 b=xbOII4FIonnBJFJH/aCRLAKee3dF6WvtKaPxdfP07QRO7ViCy5/hm5BAqnFPLGyWGUlPSU
 PuWM7JZfVE67mjayVQRQmBxcdyMxS+d5qfgfbC0FyoobHNGvo3LoiN4JwGjeqVnZb6iIAl
 bwNNbTe8Httqdz0hGn+5cxJsSYQ+9hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZ9v1zRre8MJoTcvIKPSMOTVWa31kcAX+dlQiw/brnk=;
 b=kksFB/vwhJhLG7DaCbqAEEFeii/K01egg+HgH6vwyohWEsTKUILkdyUYrIuIi/94VxZ3mr
 pQflTMaLqsm3m+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BD833EA66;
 Tue, 17 Feb 2026 16:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OKd8CCSUlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:15:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 27/32] migration/bg-snapshot: Cleanup error paths
Date: Tue, 17 Feb 2026 13:14:38 -0300
Message-ID: <20260217161443.12738-28-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Peter Xu <peterx@redhat.com>

Cleanup bg_migration_thread() function on error handling.  First of all,
early_fail is almost only used to say if BQL is taken.  Since we already
have separate jumping labels, we don't really need it, hence removed.

Also, since local_err is around, making sure every failure path will set a
proper error string for the failure, then propagate to MigrationState.error.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/qemu-devel/20260127185254.3954634-22-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f81ac21d4e..f9eec4b25a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3628,7 +3628,6 @@ static void *bg_migration_thread(void *opaque)
     int64_t setup_start;
     MigThrError thr_error;
     QEMUFile *fb;
-    bool early_fail = true;
     Error *local_err = NULL;
     int ret;
 
@@ -3674,10 +3673,7 @@ static void *bg_migration_thread(void *opaque)
      * devices to unplug. This to preserve migration state transitions.
      */
     if (ret) {
-        migrate_error_propagate(s, local_err);
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
-        goto fail_setup;
+        goto fail;
     }
 
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
@@ -3687,11 +3683,13 @@ static void *bg_migration_thread(void *opaque)
     bql_lock();
 
     if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
-        goto fail;
+        error_setg(&local_err, "Failed to stop the VM");
+        goto fail_with_bql;
     }
 
     if (qemu_savevm_state_non_iterable(fb)) {
-        goto fail;
+        error_setg(&local_err, "Failed to save non-iterable devices");
+        goto fail_with_bql;
     }
 
     qemu_savevm_state_end_precopy(s, fb);
@@ -3704,9 +3702,9 @@ static void *bg_migration_thread(void *opaque)
 
     /* Now initialize UFFD context and start tracking RAM writes */
     if (ram_write_tracking_start()) {
-        goto fail;
+        error_setg(&local_err, "Failed to start write tracking");
+        goto fail_with_bql;
     }
-    early_fail = false;
 
     /*
      * Start VM from BH handler to avoid write-fault lock here.
@@ -3738,21 +3736,22 @@ static void *bg_migration_thread(void *opaque)
     }
 
     trace_migration_thread_after_loop();
+    goto done;
+
+fail_with_bql:
+    bql_unlock();
 
 fail:
-    if (early_fail) {
-        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
-                MIGRATION_STATUS_FAILED);
-        bql_unlock();
-    }
+    /* local_err is guaranteed to be set when reaching here */
+    migrate_error_propagate(s, local_err);
+    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
+                      MIGRATION_STATUS_FAILED);
 
-fail_setup:
+done:
     bg_migration_iteration_finish(s);
-
     qemu_fclose(fb);
     object_unref(OBJECT(s));
     rcu_unregister_thread();
-
     return NULL;
 }
 
-- 
2.51.0


