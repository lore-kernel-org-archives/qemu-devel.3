Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436EDC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEWa-0000FE-LO; Fri, 11 Jul 2025 10:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETR-0001sg-Hy
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:44 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETL-0006iO-R1
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 565DD1F454;
 Fri, 11 Jul 2025 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bnz20s69+Inf6MGIXR/Cgjh2pMWofI8C1iUr1UrS8nM=;
 b=P93/VpFeWZSJ9qojnmvWKA0tf3OSr7EDls9PHtK3P50tLF/4RQgCsb8yKduBjfHEShk21U
 9vYqy4bp9Ofnx/y2wzSIwwtQY35et4kCHhB7vgMDqnAMhGwwQOhGfuVOACXbXwEs4UnN0W
 miExWSsBdcnHePaaTDWpcjHJ5sHcaDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bnz20s69+Inf6MGIXR/Cgjh2pMWofI8C1iUr1UrS8nM=;
 b=Muq2n5DUnYc286j4WvUDVgi9nJYV7ACmNvYU5iKNZ3pq7P9fYAOt7ZS64EMmxdh3e2FF36
 kmJVFCCyuvb3DEDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m83txFfz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=073tuCCW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bnz20s69+Inf6MGIXR/Cgjh2pMWofI8C1iUr1UrS8nM=;
 b=m83txFfzEosbzKm3tbKJJCym+hyjf1gqZeIcH2FTBu353mYfU0qQ+CrEM6hbIExUg0trwj
 NlwVf5WW2kIWM2mdrPoP/GOaFCDBCuvsXoemX2jqmhX8UJDBh7XGuFIE8qA6hmDuQQcZkr
 HWx2dfZEF99glNmi1MSTNNn/mBtw9rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243056;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bnz20s69+Inf6MGIXR/Cgjh2pMWofI8C1iUr1UrS8nM=;
 b=073tuCCW5N4TnHnnhvyvTL0vzGkHkv4V11Tl/ruom1ysUdg2CGkvJxAtBZMfLhC1keHLy6
 pfY0KEATADC4BaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0220D1388B;
 Fri, 11 Jul 2025 14:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +HWhLG4bcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 10/26] migration: Rewrite the migration complete detect logic
Date: Fri, 11 Jul 2025 11:10:15 -0300
Message-Id: <20250711141031.423-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 565DD1F454
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

There're a few things off here in that logic, rewrite it.  When at it, add
rich comment to explain each of the decisions.

Since this is very sensitive path for migration, below are the list of
things changed with their reasonings.

  (1) Exact pending size is only needed for precopy not postcopy

      Fundamentally it's because "exact" version only does one more deep
      sync to fetch the pending results, while in postcopy's case it's
      never going to sync anything more than estimate as the VM on source
      is stopped.

  (2) Do _not_ rely on threshold_size anymore to decide whether postcopy
      should complete

      threshold_size was calculated from the expected downtime and
      bandwidth only during precopy as an efficient way to decide when to
      switchover.  It's not sensible to rely on threshold_size in postcopy.

      For precopy, if switchover is decided, the migration will complete
      soon.  It's not true for postcopy.  Logically speaking, postcopy
      should only complete the migration if all pending data is flushed.

      Here it used to work because save_complete() used to implicitly
      contain save_live_iterate() when there's pending size.

      Even if that looks benign, having RAMs to be migrated in postcopy's
      save_complete() has other bad side effects:

      (a) Since save_complete() needs to be run once at a time, it means
      when moving RAM there's no way moving other things (rather than
      round-robin iterating the vmstate handlers like what we do with
      ITERABLE phase).  Not an immediate concern, but it may stop working
      in the future when there're more than one iterables (e.g. vfio
      postcopy).

      (b) postcopy recovery, unfortunately, only works during ITERABLE
      phase. IOW, if src QEMU moves RAM during postcopy's save_complete()
      and network failed, then it'll crash both QEMUs... OTOH if it failed
      during iteration it'll still be recoverable.  IOW, this change should
      further reduce the window QEMU split brain and crash in extreme cases.

      If we enable the ram_save_complete() tracepoints, we'll see this
      before this patch:

      1267959@1748381938.294066:ram_save_complete dirty=9627, done=0
      1267959@1748381938.308884:ram_save_complete dirty=0, done=1

      It means in this migration there're 9627 pages migrated at complete()
      of postcopy phase.

      After this change, all the postcopy RAM should be migrated in iterable
      phase, rather than save_complete():

      1267959@1748381938.294066:ram_save_complete dirty=0, done=0
      1267959@1748381938.308884:ram_save_complete dirty=0, done=1

  (3) Adjust when to decide to switch to postcopy

      This shouldn't be super important, the movement makes sure there's
      only one in_postcopy check, then we are clear on what we do with the
      two completely differnt use cases (precopy v.s. postcopy).

  (4) Trivial touch up on threshold_size comparision

      Which changes:

      "(!pending_size || pending_size < s->threshold_size)"

      into:

      "(pending_size <= s->threshold_size)"

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613140801.474264-11-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 57 +++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index e33e39ac74..923400f801 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3436,33 +3436,60 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
     bool can_switchover = migration_can_switchover(s);
+    bool complete_ready;
 
+    /* Fast path - get the estimated amount of pending data */
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
     pending_size = must_precopy + can_postcopy;
     trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
 
-    if (pending_size < s->threshold_size) {
-        qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
-        pending_size = must_precopy + can_postcopy;
-        trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
+    if (in_postcopy) {
+        /*
+         * Iterate in postcopy until all pending data flushed.  Note that
+         * postcopy completion doesn't rely on can_switchover, because when
+         * POSTCOPY_ACTIVE it means switchover already happened.
+         */
+        complete_ready = !pending_size;
+    } else {
+        /*
+         * Exact pending reporting is only needed for precopy.  Taking RAM
+         * as example, there'll be no extra dirty information after
+         * postcopy started, so ESTIMATE should always match with EXACT
+         * during postcopy phase.
+         */
+        if (pending_size < s->threshold_size) {
+            qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
+            pending_size = must_precopy + can_postcopy;
+            trace_migrate_pending_exact(pending_size, must_precopy,
+                                        can_postcopy);
+        }
+
+        /* Should we switch to postcopy now? */
+        if (must_precopy <= s->threshold_size &&
+            can_switchover && qatomic_read(&s->start_postcopy)) {
+            if (postcopy_start(s, &local_err)) {
+                migrate_set_error(s, local_err);
+                error_report_err(local_err);
+            }
+            return MIG_ITERATE_SKIP;
+        }
+
+        /*
+         * For precopy, migration can complete only if:
+         *
+         * (1) Switchover is acknowledged by destination
+         * (2) Pending size is no more than the threshold specified
+         *     (which was calculated from expected downtime)
+         */
+        complete_ready = can_switchover && (pending_size <= s->threshold_size);
     }
 
-    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
+    if (complete_ready) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
 
-    /* Still a significant amount to transfer */
-    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
-        qatomic_read(&s->start_postcopy)) {
-        if (postcopy_start(s, &local_err)) {
-            migrate_set_error(s, local_err);
-            error_report_err(local_err);
-        }
-        return MIG_ITERATE_SKIP;
-    }
-
     /* Just another iteration step */
     qemu_savevm_state_iterate(s->to_dst_file, in_postcopy);
     return MIG_ITERATE_RESUME;
-- 
2.35.3


