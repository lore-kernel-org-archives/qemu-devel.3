Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23398C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEVo-0006h5-2u; Fri, 11 Jul 2025 10:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET9-0001N0-0I
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:19 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaESu-0006by-RS
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1FB11F451;
 Fri, 11 Jul 2025 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVi/ud188k7DZ8kqR4sTOhVMrCU6s+gJeBw/KUDtN5o=;
 b=WhHAONjqcqTeQ2luBJQjV9UbYFi7ubfWHfr6HPB73XwTkJ59X5wF69bhJjkjD3QGI8Rb1q
 QGAfBNOjORpiH6CveTC7KYjeXCb6odgnw9sJvyMXc3PNJVsQeEi2v496A9BfskBkOEKd/4
 cRf7OVxBg6ntKz84n/kiJuQS16wtcC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVi/ud188k7DZ8kqR4sTOhVMrCU6s+gJeBw/KUDtN5o=;
 b=HXiWR2L59NiTHLScH2pBTJFldHFdDQleKSqqm6nVTzGjtJzagExkR7jlgjF9M9r54kunLZ
 XhOYcpsx2EP7kNDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WhHAONjq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HXiWR2L5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVi/ud188k7DZ8kqR4sTOhVMrCU6s+gJeBw/KUDtN5o=;
 b=WhHAONjqcqTeQ2luBJQjV9UbYFi7ubfWHfr6HPB73XwTkJ59X5wF69bhJjkjD3QGI8Rb1q
 QGAfBNOjORpiH6CveTC7KYjeXCb6odgnw9sJvyMXc3PNJVsQeEi2v496A9BfskBkOEKd/4
 cRf7OVxBg6ntKz84n/kiJuQS16wtcC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243046;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVi/ud188k7DZ8kqR4sTOhVMrCU6s+gJeBw/KUDtN5o=;
 b=HXiWR2L59NiTHLScH2pBTJFldHFdDQleKSqqm6nVTzGjtJzagExkR7jlgjF9M9r54kunLZ
 XhOYcpsx2EP7kNDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FE6C1388B;
 Fri, 11 Jul 2025 14:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AKicC2UbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 05/26] migration: Drop save_live_complete_postcopy hook
Date: Fri, 11 Jul 2025 11:10:10 -0300
Message-Id: <20250711141031.423-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E1FB11F451
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

From: Peter Xu <peterx@redhat.com>

The hook is only defined in two vmstate users ("ram" and "block dirty
bitmap"), meanwhile both of them define the hook exactly the same as the
precopy version.  Hence, this postcopy version isn't needed.

No functional change intended.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613140801.474264-6-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/register.h   | 24 ++++++++----------------
 migration/block-dirty-bitmap.c |  1 -
 migration/ram.c                |  1 -
 migration/savevm.c             |  9 ++++-----
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index b79dc81b8d..e022195785 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -77,26 +77,18 @@ typedef struct SaveVMHandlers {
      */
     void (*save_cleanup)(void *opaque);
 
-    /**
-     * @save_live_complete_postcopy
-     *
-     * Called at the end of postcopy for all postcopyable devices.
-     *
-     * @f: QEMUFile where to send the data
-     * @opaque: data pointer passed to register_savevm_live()
-     *
-     * Returns zero to indicate success and negative for error
-     */
-    int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
-
     /**
      * @save_live_complete_precopy
      *
      * Transmits the last section for the device containing any
-     * remaining data at the end of a precopy phase. When postcopy is
-     * enabled, devices that support postcopy will skip this step,
-     * where the final data will be flushed at the end of postcopy via
-     * @save_live_complete_postcopy instead.
+     * remaining data at the end phase of migration.
+     *
+     * For precopy, this will be invoked _during_ the switchover phase
+     * after source VM is stopped.
+     *
+     * For postcopy, this will be invoked _after_ the switchover phase
+     * (except some very unusual cases, like PMEM ramblocks), while
+     * destination VM can be running.
      *
      * @f: QEMUFile where to send the data
      * @opaque: data pointer passed to register_savevm_live()
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index f2c352d4a7..6ee3c32a76 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1248,7 +1248,6 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
 
 static SaveVMHandlers savevm_dirty_bitmap_handlers = {
     .save_setup = dirty_bitmap_save_setup,
-    .save_live_complete_postcopy = dirty_bitmap_save_complete,
     .save_live_complete_precopy = dirty_bitmap_save_complete,
     .has_postcopy = dirty_bitmap_has_postcopy,
     .state_pending_exact = dirty_bitmap_state_pending,
diff --git a/migration/ram.c b/migration/ram.c
index 2140785a05..6bb4f13031 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4548,7 +4548,6 @@ void postcopy_preempt_shutdown_file(MigrationState *s)
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
-    .save_live_complete_postcopy = ram_save_complete,
     .save_live_complete_precopy = ram_save_complete,
     .has_postcopy = ram_has_postcopy,
     .state_pending_exact = ram_state_pending_exact,
diff --git a/migration/savevm.c b/migration/savevm.c
index bb04a4520d..3e20f8608a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1485,9 +1485,8 @@ bool should_send_vmdesc(void)
 }
 
 /*
- * Calls the save_live_complete_postcopy methods
- * causing the last few pages to be sent immediately and doing any associated
- * cleanup.
+ * Complete saving any postcopy-able devices.
+ *
  * Note postcopy also calls qemu_savevm_state_complete_precopy to complete
  * all the other devices, but that happens at the point we switch to postcopy.
  */
@@ -1497,7 +1496,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_live_complete_postcopy) {
+        if (!se->ops || !se->ops->save_live_complete_precopy) {
             continue;
         }
         if (se->ops->is_active) {
@@ -1510,7 +1509,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         qemu_put_byte(f, QEMU_VM_SECTION_END);
         qemu_put_be32(f, se->section_id);
 
-        ret = se->ops->save_live_complete_postcopy(f, se->opaque);
+        ret = se->ops->save_live_complete_precopy(f, se->opaque);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
         if (ret < 0) {
-- 
2.35.3


