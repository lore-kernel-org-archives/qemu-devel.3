Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810D3C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEWb-0000IJ-Ih; Fri, 11 Jul 2025 10:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET9-0001N3-0e
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:19 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaET1-0006e6-Kg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:13 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E13061F453;
 Fri, 11 Jul 2025 14:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xjV3uDk/KQiqyg6+/FlJeG/5UFVlpXxOHhas+J0JmQ=;
 b=zMYnS1rqtz1mi5I35zQK1Gdfg0ZN/F01bIle7VOR7rUI9qlu2Y6ouTQ4n4XV8yl4+H4I5T
 2ocRT4KvfZlZgKeur5LzcLM/pna74jCIFVuHfkuiZwVlCbPnZFvkhSm/Il1DsTuVKlNJxA
 PRC8flLeouhIRCN9BG1+rDaHwuOPRE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xjV3uDk/KQiqyg6+/FlJeG/5UFVlpXxOHhas+J0JmQ=;
 b=lmtDCOkcZ7vlFmZbXQKOJDkXONTm+5aKglOOYMEgNPOk0aXHSDTSi0eG3LjLNAu5cWw1tO
 ZSEtMcojEHfQFGDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xjV3uDk/KQiqyg6+/FlJeG/5UFVlpXxOHhas+J0JmQ=;
 b=zMYnS1rqtz1mi5I35zQK1Gdfg0ZN/F01bIle7VOR7rUI9qlu2Y6ouTQ4n4XV8yl4+H4I5T
 2ocRT4KvfZlZgKeur5LzcLM/pna74jCIFVuHfkuiZwVlCbPnZFvkhSm/Il1DsTuVKlNJxA
 PRC8flLeouhIRCN9BG1+rDaHwuOPRE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xjV3uDk/KQiqyg6+/FlJeG/5UFVlpXxOHhas+J0JmQ=;
 b=lmtDCOkcZ7vlFmZbXQKOJDkXONTm+5aKglOOYMEgNPOk0aXHSDTSi0eG3LjLNAu5cWw1tO
 ZSEtMcojEHfQFGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 829A41388B;
 Fri, 11 Jul 2025 14:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDYlD2cbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:10:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 06/26] migration: Rename save_live_complete_precopy to
 save_complete
Date: Fri, 11 Jul 2025 11:10:11 -0300
Message-Id: <20250711141031.423-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
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

Now after merging the precopy and postcopy version of complete() hook,
rename the precopy version from save_live_complete_precopy() to
save_complete().

Dropping the "live" when at it, because it's in most cases not live when
happening (in precopy).

No functional change intended.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613140801.474264-7-peterx@redhat.com
[peterx: squash the fixup that covers a few more doc spots, per Juraj]
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/main.rst  |  4 ++--
 docs/devel/migration/vfio.rst  | 12 ++++++------
 hw/ppc/spapr.c                 |  2 +-
 hw/s390x/s390-stattrib.c       |  2 +-
 hw/vfio/migration.c            |  2 +-
 include/migration/register.h   |  6 +++---
 migration/block-dirty-bitmap.c |  2 +-
 migration/ram.c                |  2 +-
 migration/savevm.c             |  8 ++++----
 9 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index cdd4f4a6d7..6493c1d2bc 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -508,8 +508,8 @@ An iterative device must provide:
     the point that stream bandwidth limits tell it to stop.  Each call
     generates one section.
 
-  - A ``save_live_complete_precopy`` function that must transmit the
-    last section for the device containing any remaining data.
+  - A ``save_complete`` function that must transmit the last section for
+    the device containing any remaining data.
 
   - A ``load_state`` function used to load sections generated by
     any of the save functions that generate sections.
diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 673e354754..8ff5ab0c74 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -75,10 +75,10 @@ VFIO implements the device hooks for the iterative approach as follows:
   in the non-multifd mode.
   In the multifd mode it just emits either a dummy EOS marker.
 
-* A ``save_live_complete_precopy`` function that sets the VFIO device in
-  _STOP_COPY state and iteratively copies the data for the VFIO device until
-  the vendor driver indicates that no data remains.
-  In the multifd mode it just emits a dummy EOS marker.
+* A ``save_complete`` function that sets the VFIO device in _STOP_COPY
+  state and iteratively copies the data for the VFIO device until the
+  vendor driver indicates that no data remains.  In the multifd mode it
+  just emits a dummy EOS marker.
 
 * A ``save_live_complete_precopy_thread`` function that in the multifd mode
   provides thread handler performing multifd device state transfer.
@@ -195,9 +195,9 @@ Live migration save path
                                       |
                 Then the VFIO device is put in _STOP_COPY state
                      (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
-         .save_live_complete_precopy() is called for each active device
+               .save_complete() is called for each active device
               For the VFIO device: in the non-multifd mode iterate in
-                        .save_live_complete_precopy() until
+                             .save_complete() until
                                pending data is 0
 	          In the multifd mode this iteration is done in
 	          .save_live_complete_precopy_thread() instead.
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 08615f6c90..40f53ad7b3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2518,7 +2518,7 @@ static void htab_save_cleanup(void *opaque)
 static SaveVMHandlers savevm_htab_handlers = {
     .save_setup = htab_save_setup,
     .save_live_iterate = htab_save_iterate,
-    .save_live_complete_precopy = htab_save_complete,
+    .save_complete = htab_save_complete,
     .save_cleanup = htab_save_cleanup,
     .load_state = htab_load,
 };
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index f74cf32636..13a678a803 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -338,7 +338,7 @@ static const TypeInfo qemu_s390_stattrib_info = {
 static SaveVMHandlers savevm_s390_stattrib_handlers = {
     .save_setup = cmma_save_setup,
     .save_live_iterate = cmma_save_iterate,
-    .save_live_complete_precopy = cmma_save_complete,
+    .save_complete = cmma_save_complete,
     .state_pending_exact = cmma_state_pending,
     .state_pending_estimate = cmma_state_pending,
     .save_cleanup = cmma_save_cleanup,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b76697bd1a..33a71f8999 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -824,7 +824,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .state_pending_exact = vfio_state_pending_exact,
     .is_active_iterate = vfio_is_active_iterate,
     .save_live_iterate = vfio_save_iterate,
-    .save_live_complete_precopy = vfio_save_complete_precopy,
+    .save_complete = vfio_save_complete_precopy,
     .save_state = vfio_save_state,
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
diff --git a/include/migration/register.h b/include/migration/register.h
index e022195785..2a26e76a68 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -78,7 +78,7 @@ typedef struct SaveVMHandlers {
     void (*save_cleanup)(void *opaque);
 
     /**
-     * @save_live_complete_precopy
+     * @save_complete
      *
      * Transmits the last section for the device containing any
      * remaining data at the end phase of migration.
@@ -95,7 +95,7 @@ typedef struct SaveVMHandlers {
      *
      * Returns zero to indicate success and negative for error
      */
-    int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
+    int (*save_complete)(QEMUFile *f, void *opaque);
 
     /**
      * @save_live_complete_precopy_thread (invoked in a separate thread)
@@ -103,7 +103,7 @@ typedef struct SaveVMHandlers {
      * Called at the end of a precopy phase from a separate worker thread
      * in configurations where multifd device state transfer is supported
      * in order to perform asynchronous transmission of the remaining data in
-     * parallel with @save_live_complete_precopy handlers.
+     * parallel with @save_complete handlers.
      * When postcopy is enabled, devices that support postcopy will skip this
      * step.
      *
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 6ee3c32a76..a061aad817 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1248,7 +1248,7 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
 
 static SaveVMHandlers savevm_dirty_bitmap_handlers = {
     .save_setup = dirty_bitmap_save_setup,
-    .save_live_complete_precopy = dirty_bitmap_save_complete,
+    .save_complete = dirty_bitmap_save_complete,
     .has_postcopy = dirty_bitmap_has_postcopy,
     .state_pending_exact = dirty_bitmap_state_pending,
     .state_pending_estimate = dirty_bitmap_state_pending,
diff --git a/migration/ram.c b/migration/ram.c
index 6bb4f13031..ffd839f57c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4548,7 +4548,7 @@ void postcopy_preempt_shutdown_file(MigrationState *s)
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
-    .save_live_complete_precopy = ram_save_complete,
+    .save_complete = ram_save_complete,
     .has_postcopy = ram_has_postcopy,
     .state_pending_exact = ram_state_pending_exact,
     .state_pending_estimate = ram_state_pending_estimate,
diff --git a/migration/savevm.c b/migration/savevm.c
index 3e20f8608a..454e914b56 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1496,7 +1496,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops || !se->ops->save_live_complete_precopy) {
+        if (!se->ops || !se->ops->save_complete) {
             continue;
         }
         if (se->ops->is_active) {
@@ -1509,7 +1509,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
         qemu_put_byte(f, QEMU_VM_SECTION_END);
         qemu_put_be32(f, se->section_id);
 
-        ret = se->ops->save_live_complete_precopy(f, se->opaque);
+        ret = se->ops->save_complete(f, se->opaque);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
         if (ret < 0) {
@@ -1583,7 +1583,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
-            !se->ops->save_live_complete_precopy) {
+            !se->ops->save_complete) {
             continue;
         }
 
@@ -1598,7 +1598,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 
         save_section_header(f, se, QEMU_VM_SECTION_END);
 
-        ret = se->ops->save_live_complete_precopy(f, se->opaque);
+        ret = se->ops->save_complete(f, se->opaque);
         trace_savevm_section_end(se->idstr, se->section_id, ret);
         save_section_footer(f, se);
         if (ret < 0) {
-- 
2.35.3


