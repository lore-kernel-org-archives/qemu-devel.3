Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B34C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEXI-0001mi-GL; Fri, 11 Jul 2025 10:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETH-0001iN-QS
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:31 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETE-0006hL-86
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D0A621192;
 Fri, 11 Jul 2025 14:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk32ib5y9aoYEvyT4wmPbKEXZ0gXCpoEwNJ9W1pwe1U=;
 b=aNIRPkPUcRMcAxKBpRu3aUBkTRV8DqMykXliniA6Jbv3keyHNeJmWPdo2/R2o14YxI8IHw
 kahHDrYTa/EJjreZd/5rj4xzq5/F8NYAG2SUimRBgcMx5tdGt40JYFwo5ybfrFDlEE6GLQ
 A7PTy8watgmqtL1V8oehWoSreqlMX9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk32ib5y9aoYEvyT4wmPbKEXZ0gXCpoEwNJ9W1pwe1U=;
 b=Bu8MY1yTv1ze2rXjxqgujoSFXWom/zHHiKNHXfWmxhves9h7V5SULVnU3R7AK2y0rdG0mP
 9UGGZH7UrTuWVGAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk32ib5y9aoYEvyT4wmPbKEXZ0gXCpoEwNJ9W1pwe1U=;
 b=aNIRPkPUcRMcAxKBpRu3aUBkTRV8DqMykXliniA6Jbv3keyHNeJmWPdo2/R2o14YxI8IHw
 kahHDrYTa/EJjreZd/5rj4xzq5/F8NYAG2SUimRBgcMx5tdGt40JYFwo5ybfrFDlEE6GLQ
 A7PTy8watgmqtL1V8oehWoSreqlMX9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk32ib5y9aoYEvyT4wmPbKEXZ0gXCpoEwNJ9W1pwe1U=;
 b=Bu8MY1yTv1ze2rXjxqgujoSFXWom/zHHiKNHXfWmxhves9h7V5SULVnU3R7AK2y0rdG0mP
 9UGGZH7UrTuWVGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 494C21388B;
 Fri, 11 Jul 2025 14:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WJu1AXQbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 13/26] migration/postcopy: Push blocktime start/end into page
 req mutex
Date: Fri, 11 Jul 2025 11:10:18 -0300
Message-Id: <20250711141031.423-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
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

The postcopy blocktime feature was tricky that it used quite some atomic
operations over quite a few arrays and vars, without explaining how that
would be thread safe.  The thread safety here is about concurrency between
the fault thread and the fault resolution threads, possible to access the
same chunk of data.  All these atomic ops can be expensive too before
knowing clearly how it works.

OTOH, postcopy has one page_request_mutex used to serialize the received
bitmap updates.  So far it's ok - we don't yet have a lot of threads
contending the lock.  It might change after multifd will be supported, but
that's a separate story.  What is important is, with that mutex, it's
pretty lightweight to move all the blocktime maintenance into the mutex
critical section.  It's because the blocktime layer is lightweighted:
almost "remember which vcpu faulted on which address", and "ok we get some
fault resolved, calculate how long it takes".  It's also an optional
feature for now (but I have thought of changing that, maybe in the future).

Let's push the blocktime layer into the mutex, so that it's always
thread-safe even without any atomic ops.

To achieve that, I'll need to add a tid parameter on fault path so that
it'll start to pass the faulted thread ID into deeper the stack, but not
too deep.  When at it, add a comment for the shared fault handler (for
example, vhost-user devices running with postcopy), to mention a TODO.  One
reason it might not be trivial is that vhost-user's userfaultfds should be
opened by vhost-user process, so it's pretty hard to control making sure
the TID feature will be around.  It wasn't supported before, so keep it
like that for now.

Now we should be as ease when everything is protected by a mutex that we
always take anyway.

One side effect: we can finally remove one ramblock_recv_bitmap_test() in
mark_postcopy_blocktime_begin(), which was pretty weird and which also
includes a weird (but maybe necessary.. but maybe not?) operation to inject
a blocktime entry then quickly erase it..  When we're with the mutex, and
when we make sure it's invoked after checking the receive bitmap, it's not
needed anymore.  Instead, we assert.

As another side effect, this paves way for removing all atomic ops in all
the mem accesses in blocktime layer.

Note that we need a stub for mark_postcopy_blocktime_begin() for Windows
builds.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-3-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c    | 25 +++++++++++-------
 migration/migration.h    |  2 +-
 migration/postcopy-ram.c | 56 +++++++++++++++++++++-------------------
 migration/postcopy-ram.h |  2 ++
 migration/trace-events   |  2 +-
 5 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 923400f801..10c216d25d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -576,22 +576,27 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 }
 
 int migrate_send_rp_req_pages(MigrationIncomingState *mis,
-                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
+                              RAMBlock *rb, ram_addr_t start, uint64_t haddr,
+                              uint32_t tid)
 {
     void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
     bool received = false;
 
     WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
         received = ramblock_recv_bitmap_test_byte_offset(rb, start);
-        if (!received && !g_tree_lookup(mis->page_requested, aligned)) {
-            /*
-             * The page has not been received, and it's not yet in the page
-             * request list.  Queue it.  Set the value of element to 1, so that
-             * things like g_tree_lookup() will return TRUE (1) when found.
-             */
-            g_tree_insert(mis->page_requested, aligned, (gpointer)1);
-            qatomic_inc(&mis->page_requested_count);
-            trace_postcopy_page_req_add(aligned, mis->page_requested_count);
+        if (!received) {
+            if (!g_tree_lookup(mis->page_requested, aligned)) {
+                /*
+                 * The page has not been received, and it's not yet in the
+                 * page request list.  Queue it.  Set the value of element
+                 * to 1, so that things like g_tree_lookup() will return
+                 * TRUE (1) when found.
+                 */
+                g_tree_insert(mis->page_requested, aligned, (gpointer)1);
+                qatomic_inc(&mis->page_requested_count);
+                trace_postcopy_page_req_add(aligned, mis->page_requested_count);
+            }
+            mark_postcopy_blocktime_begin(haddr, tid, rb);
         }
     }
 
diff --git a/migration/migration.h b/migration/migration.h
index 739289de93..01329bf824 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -546,7 +546,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
 void migrate_send_rp_pong(MigrationIncomingState *mis,
                           uint32_t value);
 int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
-                              ram_addr_t start, uint64_t haddr);
+                              ram_addr_t start, uint64_t haddr, uint32_t tid);
 int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
                                       RAMBlock *rb, ram_addr_t start);
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 75fd310fb2..32fa06dabd 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -752,8 +752,12 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                        pagesize);
 }
 
+/*
+ * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
+ * also optional: when zero is provided, the fault accounting will be ignored.
+ */
 static int postcopy_request_page(MigrationIncomingState *mis, RAMBlock *rb,
-                                 ram_addr_t start, uint64_t haddr)
+                                 ram_addr_t start, uint64_t haddr, uint32_t tid)
 {
     void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
 
@@ -772,7 +776,7 @@ static int postcopy_request_page(MigrationIncomingState *mis, RAMBlock *rb,
         return received ? 0 : postcopy_place_page_zero(mis, aligned, rb);
     }
 
-    return migrate_send_rp_req_pages(mis, rb, start, haddr);
+    return migrate_send_rp_req_pages(mis, rb, start, haddr, tid);
 }
 
 /*
@@ -793,7 +797,8 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                         qemu_ram_get_idstr(rb), rb_offset);
         return postcopy_wake_shared(pcfd, client_addr, rb);
     }
-    postcopy_request_page(mis, rb, aligned_rbo, client_addr);
+    /* TODO: support blocktime tracking */
+    postcopy_request_page(mis, rb, aligned_rbo, client_addr, 0);
     return 0;
 }
 
@@ -819,17 +824,17 @@ static uint32_t get_low_time_offset(PostcopyBlocktimeContext *dc)
 }
 
 /*
- * This function is being called when pagefault occurs. It
- * tracks down vCPU blocking time.
+ * This function is being called when pagefault occurs. It tracks down vCPU
+ * blocking time.  It's protected by @page_request_mutex.
  *
  * @addr: faulted host virtual address
  * @ptid: faulted process thread id
  * @rb: ramblock appropriate to addr
  */
-static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
-                                          RAMBlock *rb)
+void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
+                                   RAMBlock *rb)
 {
-    int cpu, already_received;
+    int cpu;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
     uint32_t low_time_offset;
@@ -852,24 +857,19 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     qatomic_xchg(&dc->vcpu_addr[cpu], addr);
 
     /*
-     * check it here, not at the beginning of the function,
-     * due to, check could occur early than bitmap_set in
-     * qemu_ufd_copy_ioctl
+     * The caller should only inject a blocktime entry when the page is
+     * yet missing.
      */
-    already_received = ramblock_recv_bitmap_test(rb, (void *)addr);
-    if (already_received) {
-        qatomic_xchg(&dc->vcpu_addr[cpu], 0);
-        qatomic_xchg(&dc->page_fault_vcpu_time[cpu], 0);
-        qatomic_dec(&dc->smp_cpus_down);
-    }
+    assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
+
     trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
-                                        cpu, already_received);
+                                        cpu);
 }
 
 /*
- *  This function just provide calculated blocktime per cpu and trace it.
- *  Total blocktime is calculated in mark_postcopy_blocktime_end.
- *
+ * This function just provide calculated blocktime per cpu and trace it.
+ * Total blocktime is calculated in mark_postcopy_blocktime_end.  It's
+ * protected by @page_request_mutex.
  *
  * Assume we have 3 CPU
  *
@@ -1068,17 +1068,14 @@ static void *postcopy_ram_fault_thread(void *opaque)
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset,
                                                 msg.arg.pagefault.feat.ptid);
-            mark_postcopy_blocktime_begin(
-                    (uintptr_t)(msg.arg.pagefault.address),
-                                msg.arg.pagefault.feat.ptid, rb);
-
 retry:
             /*
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >= TPS)
              */
             ret = postcopy_request_page(mis, rb, rb_offset,
-                                        msg.arg.pagefault.address);
+                                        msg.arg.pagefault.address,
+                                        msg.arg.pagefault.feat.ptid);
             if (ret) {
                 /* May be network failure, try to wait for recovery */
                 postcopy_pause_fault_thread(mis);
@@ -1299,8 +1296,8 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
                 qemu_cond_signal(&mis->page_request_cond);
             }
         }
-        qemu_mutex_unlock(&mis->page_request_mutex);
         mark_postcopy_blocktime_end((uintptr_t)host_addr);
+        qemu_mutex_unlock(&mis->page_request_mutex);
     }
     return ret;
 }
@@ -1430,6 +1427,11 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
 {
     g_assert_not_reached();
 }
+
+void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
+                                   RAMBlock *rb)
+{
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index a6df1b2811..3852141d7e 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -196,5 +196,7 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
 void postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
 bool postcopy_is_paused(MigrationStatus status);
+void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
+                                   RAMBlock *rb);
 
 #endif
diff --git a/migration/trace-events b/migration/trace-events
index dcd8fe9a0c..917f521e88 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -285,7 +285,7 @@ postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
-mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d, already_received: %d"
+mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d"
 mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d"
 postcopy_pause_fault_thread(void) ""
 postcopy_pause_fault_thread_continued(void) ""
-- 
2.35.3


