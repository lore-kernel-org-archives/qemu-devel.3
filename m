Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27656C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEXI-0001q5-T6; Fri, 11 Jul 2025 10:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETs-0002kw-85
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETo-0006of-ID
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:03 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31C43211A5;
 Fri, 11 Jul 2025 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yahr4xTDonbuFFFNBGo8xqPBuH7E+nTTPkcHPHdeRHM=;
 b=sxqkyAC+85vhlGGdxVXgmQEND0aRP8xyeozCD1Jtis8kxH1U1jbHoWJZ13/k4jkBqgXMMS
 gEQfuybfvRYb9C7elNYOIaMNM6aTmx60qCrxqfBMITxo4M3oZOCxZpGbW2SKiIwayuAVBO
 BDQCzHdHfvtKKAYpVzCrTVmuHrQIRtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yahr4xTDonbuFFFNBGo8xqPBuH7E+nTTPkcHPHdeRHM=;
 b=3B+RyH5hPI1OSoz+nKyxTwxPDCxJekmAQMNlLHq+sG8OgJVU1EBZ+sEK3oX6+vRIYsUAK+
 o0e0mPuu7FV+QMAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sxqkyAC+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3B+RyH5h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yahr4xTDonbuFFFNBGo8xqPBuH7E+nTTPkcHPHdeRHM=;
 b=sxqkyAC+85vhlGGdxVXgmQEND0aRP8xyeozCD1Jtis8kxH1U1jbHoWJZ13/k4jkBqgXMMS
 gEQfuybfvRYb9C7elNYOIaMNM6aTmx60qCrxqfBMITxo4M3oZOCxZpGbW2SKiIwayuAVBO
 BDQCzHdHfvtKKAYpVzCrTVmuHrQIRtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yahr4xTDonbuFFFNBGo8xqPBuH7E+nTTPkcHPHdeRHM=;
 b=3B+RyH5hPI1OSoz+nKyxTwxPDCxJekmAQMNlLHq+sG8OgJVU1EBZ+sEK3oX6+vRIYsUAK+
 o0e0mPuu7FV+QMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EFCE1388B;
 Fri, 11 Jul 2025 14:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFenM4QbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 23/26] migration/postcopy: Optimize blocktime fault tracking
 with hashtable
Date: Fri, 11 Jul 2025 11:10:28 -0300
Message-Id: <20250711141031.423-24-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 31C43211A5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Currently, the postcopy blocktime feature maintains vCPU fault information
using an array (vcpu_addr[]).  It has two issues.

Issue 1: Performance Concern
============================

The old algorithm was almost OK and fast on inserts, except that the lookup
is slow and won't scale if there are a lot of vCPUs: when a page is copied
during postcopy, mark_postcopy_blocktime_end() will walk the whole array
trying to find which vCPUs are blocked by the address.  So it needs
constant O(N) walk for each page resolution.

Alexey (the author of postcopy blocktime) mentioned the perf issue and how
to optimize it in a piece of comment in the page resolution path.  The
comment was (interestingly..) not complete, but it's relatively clear what
he wanted to say about this perf issue.

Issue 2: Wrong Accounting on re-entrancies
==========================================

People might think that each vCPU should only and always get one fault at a
time, so that when the blocktime layer captured one fault on one vCPU, we
should never see another fault message on this vCPU.

It's almost correct, except in some extreme rare cases.

Case 1: it's possible the fault thread processes the userfaultfd messages
too fast so it can see >1 messages on one vCPU before the previous one was
resolved.

Case 2: it's theoretically also possible one vCPU can get even more than
one message on the same fault address if a fault is retried by the
kernel (e.g., handle_userfault() got interrupted before page resolution).

As this info might be important, instead of using commit message, I put
more details into the code as comment, when introducing an array
maintaining concurrent faults on one vCPU.  Please refer to the comments
for details on both cases, especially case 1 which can be tricky.

Case 1 sounds rare, but it can be easily reproduced locally for me when we
run blocktime together with the migration-test on the vanilla postcopy.

New Design
==========

This patch should do almost what Alexey mentioned, but slightly
differently: instead of having an array to maintain vCPU fault addresses,
for each of the fault message we push a message into a hash, indexed by the
fault address.

With the hash, it can replace the old two structs: both the vcpu_addr[]
array, and also the array to store the start time of the fault.  However
due to above we need one more counter array to account concurrent faults on
the same vCPU - that should even be needed in the old code, it's just that
the old code was buggy and it will blindly overwrite an existing
entry.. now we'll start to really track everything.

The hash structure might be more efficient than tree to maintain such
addr->(cpu, fault_time) information, so that the insert() and lookup()
paths should ideally both be ~O(1).  After all, we do not need to sort.

Here we need to do one remove() though after the lookup().  It could be
slow but only if many vCPUs faulted exactly on the same address (so when
the list of cpu entries is long), which should be unlikely. Even with that,
it's still a worst case O(N) (consider 400 vCPUs faulted on the same
address and how likely is it..) rather than a constant O(N) complexity.

When at it, touch up the tracepoints to make them slightly more useful.
One tracepoint is added when walking all the fault entries.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-13-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 265 +++++++++++++++++++++++++++++++--------
 migration/trace-events   |   5 +-
 2 files changed, 219 insertions(+), 51 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fd6c0bdb1e..91c23b446e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -112,14 +112,69 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 
 /* All the time records are in unit of nanoseconds */
 typedef struct PostcopyBlocktimeContext {
-    /* time when page fault initiated per vCPU */
-    uint64_t *vcpu_blocktime_start;
     /* blocktime per vCPU */
     uint64_t *vcpu_blocktime_total;
     /* count of faults per vCPU */
     uint64_t *vcpu_faults_count;
-    /* page address per vCPU */
-    uintptr_t *vcpu_addr;
+    /*
+     * count of currently blocked faults per vCPU.
+     *
+     * NOTE: Normally there should only be one fault in-progress per vCPU
+     * thread, so logically it _seems_ vcpu_faults_count[] for any vCPU
+     * should be either zero or one.  However, there can be reasons we see
+     * >1 faults on the same vCPU thread.
+     *
+     * CASE (1): since the process to resolve faults (ioctl(UFFDIO_COPY),
+     * for example) is done before taking the mutex that protects the
+     * blocktime context, it can happen that we read more than one faulted
+     * addresses per vCPU.
+     *
+     * One example when we can see >1 faulted addresses for one vCPU:
+     *
+     *  vcpu1 thread       fault thread         resolve thread
+     *  ============       ============         ==============
+     *
+     *  faulted on addr1
+     *                     read uffd msg (addr1)
+     *                     MUTEX_LOCK
+     *                     add entry (cpu1, addr1)
+     *                     MUTEX_UNLOCK
+     *                     request remote fault (addr1)
+     *                                          resolve fault (addr1)
+     *  addr1 resolved, continue..
+     *  faulted on addr2
+     *                     read uffd msg (addr2)
+     *                     MUTEX_LOCK
+     *                     add entry (cpu1, addr2) <--------------- [A]
+     *                     MUTEX_UNLOCK
+     *                                          MUTEX_LOCK
+     *                                          remove entry (cpu1, addr1)
+     *                                          MUTEX_UNLOCK
+     *
+     * In above case, we may see (cpu1, addr1) and (cpu1, addr2) entries to
+     * appear together at [A], when it gets the lock before the resolve
+     * thread.  Use this counter to maintain such case, and only when it
+     * reaches zero we know the vCPU is not blocked anymore.
+     *
+     * CASE (2): theoretically (the author admit to not have verified
+     * this..), one vCPU thread can also generate more than one userfaultfd
+     * message on the same address. It can happen e.g. for whatever reason
+     * the fault got retried before a resolution arrives. In that extremely
+     * rare case, we could also see two (cpu1, addr1) entries.
+     *
+     * In all cases, be prepared with such re-entrancies with this array.
+     *
+     * Using uint8_t should be far enough for now.  For example, when
+     * there're only one resolve thread (postcopy ram listening thread),
+     * the max (concurrent fault entries) should be two.
+     */
+    uint8_t *vcpu_faults_current;
+    /*
+     * The hash that contains addr1->[(cpu1,ts1),(cpu2,ts2) ...] mappings.
+     * Each of the entry is a tuple of (CPU index, fault timestamp) showing
+     * that a fault was requested.
+     */
+    GHashTable *vcpu_addr_hash;
     /* total blocktime when all vCPUs are stopped */
     uint64_t total_blocktime;
     /* point in time when last page fault was initiated */
@@ -145,13 +200,38 @@ typedef struct PostcopyBlocktimeContext {
     Notifier exit_notifier;
 } PostcopyBlocktimeContext;
 
+typedef struct {
+    /* The time the fault was triggered */
+    uint64_t fault_time;
+    /* The vCPU index that was blocked */
+    int cpu;
+} BlocktimeVCPUEntry;
+
+/* Alloc an entry to record a vCPU fault */
+static BlocktimeVCPUEntry *
+blocktime_vcpu_entry_alloc(int cpu, uint64_t fault_time)
+{
+    BlocktimeVCPUEntry *entry = g_new(BlocktimeVCPUEntry, 1);
+
+    entry->fault_time = fault_time;
+    entry->cpu = cpu;
+
+    return entry;
+}
+
+/* Free a @GList of @BlocktimeVCPUEntry */
+static void blocktime_vcpu_list_free(gpointer data)
+{
+    g_list_free_full(data, g_free);
+}
+
 static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
     g_hash_table_destroy(ctx->tid_to_vcpu_hash);
-    g_free(ctx->vcpu_blocktime_start);
+    g_hash_table_destroy(ctx->vcpu_addr_hash);
     g_free(ctx->vcpu_blocktime_total);
     g_free(ctx->vcpu_faults_count);
-    g_free(ctx->vcpu_addr);
+    g_free(ctx->vcpu_faults_current);
     g_free(ctx);
 }
 
@@ -198,12 +278,22 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     unsigned int smp_cpus = ms->smp.cpus;
     PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
 
-    ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
-    ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
+    ctx->vcpu_faults_current = g_new0(uint8_t, smp_cpus);
     ctx->tid_to_vcpu_hash = blocktime_init_tid_to_vcpu_hash();
 
+    /*
+     * The key (host virtual addresses) will always be gpointer-sized on
+     * either 32bits or 64bits systems, so it'll fit as a direct key.
+     *
+     * The value will be a list of BlocktimeVCPUEntry entries.
+     */
+    ctx->vcpu_addr_hash = g_hash_table_new_full(g_direct_hash,
+                                                g_direct_equal,
+                                                NULL,
+                                                blocktime_vcpu_list_free);
+
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
 
@@ -893,6 +983,39 @@ static uint64_t get_current_ns(void)
     return (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 }
 
+/* Inject an (cpu, fault_time) entry into the database, using addr as key */
+static void blocktime_fault_inject(PostcopyBlocktimeContext *ctx,
+                                   uintptr_t addr, int cpu, uint64_t time)
+{
+    BlocktimeVCPUEntry *entry = blocktime_vcpu_entry_alloc(cpu, time);
+    GHashTable *table = ctx->vcpu_addr_hash;
+    gpointer key = (gpointer)addr;
+    GList *head, *list;
+    gboolean result;
+
+    head = g_hash_table_lookup(table, key);
+    if (head) {
+        /*
+         * If existed, steal the @head for list operation rather than
+         * freeing it, making sure steal succeeded.
+         */
+        result = g_hash_table_steal(table, key);
+        assert(result == TRUE);
+    }
+
+    /*
+     * Now the key is guaranteed to be absent.  Two cases:
+     *
+     * (1) There's no existing entry, list contains the only one. Insert.
+     * (2) There're existing entries, after stealing we own it, prepend the
+     *     result and re-insert.
+     */
+    list = g_list_prepend(head, entry);
+    g_hash_table_insert(table, key, list);
+
+    trace_postcopy_blocktime_begin(addr, time, cpu, !!head);
+}
+
 /*
  * This function is being called when pagefault occurs. It tracks down vCPU
  * blocking time.  It's protected by @page_request_mutex.
@@ -912,21 +1035,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     if (!dc || ptid == 0) {
         return;
     }
-    cpu = blocktime_get_vcpu(dc, ptid);
-    if (cpu < 0) {
-        dc->non_vcpu_faults++;
-        return;
-    }
-
-    current = get_current_ns();
-    if (dc->vcpu_addr[cpu] == 0) {
-        dc->smp_cpus_down++;
-    }
-
-    dc->last_begin = current;
-    dc->vcpu_blocktime_start[cpu] = current;
-    dc->vcpu_addr[cpu] = addr;
-    dc->vcpu_faults_count[cpu]++;
 
     /*
      * The caller should only inject a blocktime entry when the page is
@@ -934,8 +1042,67 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
      */
     assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
 
-    trace_mark_postcopy_blocktime_begin(addr, dc->vcpu_blocktime_start[cpu],
-                                        cpu);
+    current = get_current_ns();
+    cpu = blocktime_get_vcpu(dc, ptid);
+
+    if (cpu >= 0) {
+        /* How many faults on this vCPU in total? */
+        dc->vcpu_faults_count[cpu]++;
+
+        /*
+         * Account how many concurrent faults on this vCPU we trapped.  See
+         * comments above vcpu_faults_current[] on why it can be more than one.
+         */
+        if (dc->vcpu_faults_current[cpu]++ == 0) {
+            dc->smp_cpus_down++;
+            /*
+             * We use last_begin to cover (1) the 1st fault on this specific
+             * vCPU, but meanwhile (2) the last vCPU that got blocked.  It's
+             * only used to calculate system-wide blocktime.
+             */
+            dc->last_begin = current;
+        }
+
+        /* Making sure it won't overflow - it really should never! */
+        assert(dc->vcpu_faults_current[cpu] <= 255);
+    } else {
+        /* We do not support non-vCPU thread tracking yet */
+        dc->non_vcpu_faults++;
+        return;
+    }
+
+    blocktime_fault_inject(dc, addr, cpu, current);
+}
+
+typedef struct {
+    PostcopyBlocktimeContext *ctx;
+    uint64_t current;
+    int affected_cpus;
+} BlockTimeVCPUIter;
+
+static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
+{
+    BlockTimeVCPUIter *iter = user_data;
+    PostcopyBlocktimeContext *ctx = iter->ctx;
+    BlocktimeVCPUEntry *entry = data;
+    int cpu = entry->cpu;
+
+    /*
+     * Time should never go back.. so when the fault is resolved it must be
+     * later than when it was faulted.
+     */
+    assert(iter->current >= entry->fault_time);
+
+    /*
+     * If we resolved all pending faults on one vCPU due to this page
+     * resolution, take a note.
+     */
+    if (--ctx->vcpu_faults_current[cpu] == 0) {
+        ctx->vcpu_blocktime_total[cpu] += iter->current - entry->fault_time;
+        iter->affected_cpus += 1;
+    }
+
+    trace_postcopy_blocktime_end_one(cpu, ctx->vcpu_faults_current[cpu]);
 }
 
 /*
@@ -971,43 +1138,43 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
-    int i, affected_cpu = 0;
-    uint64_t read_vcpu_time, current;
+    BlockTimeVCPUIter iter = {
+        .current = get_current_ns(),
+        .affected_cpus = 0,
+        .ctx = dc,
+    };
+    gpointer key = (gpointer)addr;
+    GHashTable *table;
+    GList *list;
 
     if (!dc) {
         return;
     }
 
-    current = get_current_ns();
-    /* lookup cpu, to clear it,
-     * that algorithm looks straightforward, but it's not
-     * optimal, more optimal algorithm is keeping tree or hash
-     * where key is address value is a list of  */
-    for (i = 0; i < smp_cpus; i++) {
-        uint64_t vcpu_blocktime = 0;
-
-        read_vcpu_time = dc->vcpu_blocktime_start[i];
-        if (dc->vcpu_addr[i] != addr || read_vcpu_time == 0) {
-            continue;
-        }
-        dc->vcpu_addr[i] = 0;
-        vcpu_blocktime = current - read_vcpu_time;
-        affected_cpu += 1;
-        /* continue cycle, due to one page could affect several vCPUs */
-        dc->vcpu_blocktime_total[i] += vcpu_blocktime;
+    table = dc->vcpu_addr_hash;
+    /* the address wasn't tracked at all? */
+    list = g_hash_table_lookup(table, key);
+    if (!list) {
+        return;
     }
 
+    /*
+     * Loop over the set of vCPUs that got blocked on this addr, do the
+     * blocktime accounting.  After that, remove the whole list.
+     */
+    g_list_foreach(list, blocktime_cpu_list_iter_fn, &iter);
+    g_hash_table_remove(table, key);
+
     /*
      * If all vCPUs used to be down, and copying this page would free some
      * vCPUs, then the system-level blocktime ends here.
      */
-    if (dc->smp_cpus_down == smp_cpus && affected_cpu) {
-        dc->total_blocktime += current - dc->last_begin;
+    if (dc->smp_cpus_down == smp_cpus && iter.affected_cpus) {
+        dc->total_blocktime += iter.current - dc->last_begin;
     }
-    dc->smp_cpus_down -= affected_cpu;
+    dc->smp_cpus_down -= iter.affected_cpus;
 
-    trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
-                                      affected_cpu);
+    trace_postcopy_blocktime_end(addr, iter.current, iter.affected_cpus);
 }
 
 static void postcopy_pause_fault_thread(MigrationIncomingState *mis)
diff --git a/migration/trace-events b/migration/trace-events
index 9c1f3b7044..a36a78f01a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -285,8 +285,6 @@ postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
-mark_postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d"
-mark_postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
 postcopy_pause_fault_thread(void) ""
 postcopy_pause_fault_thread_continued(void) ""
 postcopy_pause_fast_load(void) ""
@@ -311,6 +309,9 @@ postcopy_preempt_new_channel(void) ""
 postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
 postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
+postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
+postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
+postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
 
 # exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.35.3


