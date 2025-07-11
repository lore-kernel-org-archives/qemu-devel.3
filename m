Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2015EC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEYI-0002bj-VJ; Fri, 11 Jul 2025 10:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEUA-00037c-F9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:23 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEU8-0006ru-2p
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:22 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 048E21F453;
 Fri, 11 Jul 2025 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mzwXqQN6NKzga9iDDezb4zzzkxloBxPp8r53t2TXtM=;
 b=ISVNiFwvvXJNMBnx8upjhmqRwjqaKA2hTah3BpZ67aoH916WyB1Lqi3NGvFY1eG94y71v5
 kirK1bi+2ljaQz5t0flE4O8dtB3GNqLZzX/jVVtkGcppm5A19bXZmtblRXk7br/nhIKFEA
 pVOekjKL7H7HdifXflhWCk4olWcw9+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mzwXqQN6NKzga9iDDezb4zzzkxloBxPp8r53t2TXtM=;
 b=aRPYjIcSlYzjesWsNchpnJ2kxnFmMF/oZLEZ4wSX0u2AldTYy/sHTew2fgyTZX6jNeYN3T
 N89YFOs6Fce/HsDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mzwXqQN6NKzga9iDDezb4zzzkxloBxPp8r53t2TXtM=;
 b=ISVNiFwvvXJNMBnx8upjhmqRwjqaKA2hTah3BpZ67aoH916WyB1Lqi3NGvFY1eG94y71v5
 kirK1bi+2ljaQz5t0flE4O8dtB3GNqLZzX/jVVtkGcppm5A19bXZmtblRXk7br/nhIKFEA
 pVOekjKL7H7HdifXflhWCk4olWcw9+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4mzwXqQN6NKzga9iDDezb4zzzkxloBxPp8r53t2TXtM=;
 b=aRPYjIcSlYzjesWsNchpnJ2kxnFmMF/oZLEZ4wSX0u2AldTYy/sHTew2fgyTZX6jNeYN3T
 N89YFOs6Fce/HsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E554A1388B;
 Fri, 11 Jul 2025 14:11:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qCHxJoEbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 21/26] migration/postcopy: Cache the tid->vcpu mapping for
 blocktime
Date: Fri, 11 Jul 2025 11:10:26 -0300
Message-Id: <20250711141031.423-22-farosas@suse.de>
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

Looking up the vCPU index for each fault can be expensive when there're
hundreds of vCPUs.  Provide a cache for tid->vcpu instead with a hash
table, then lookup from there.

When at it, add another counter to record how many non-vCPU faults it gets.
For example, the main thread can also access a guest page that was missing.
These kind of faults are not accounted by blocktime so far.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-11-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 68 ++++++++++++++++++++++++++++++++++------
 migration/trace-events   |  3 +-
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index dd3615663f..bf65d6035c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -127,6 +127,17 @@ typedef struct PostcopyBlocktimeContext {
     /* number of vCPU are suspended */
     int smp_cpus_down;
 
+    /*
+     * Fast path for looking up vcpu_index from tid.  NOTE: this result
+     * only reflects the vcpu setup when postcopy is running.  It may not
+     * always match with the current vcpu setup because vcpus can be hot
+     * attached/detached after migration completes.  However this should be
+     * stable when blocktime is using the structure.
+     */
+    GHashTable *tid_to_vcpu_hash;
+    /* Count of non-vCPU faults.  This is only for debugging purpose. */
+    uint64_t non_vcpu_faults;
+
     /*
      * Handler for exit event, necessary for
      * releasing whole blocktime_ctx
@@ -136,6 +147,7 @@ typedef struct PostcopyBlocktimeContext {
 
 static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
+    g_hash_table_destroy(ctx->tid_to_vcpu_hash);
     g_free(ctx->vcpu_blocktime_start);
     g_free(ctx->vcpu_blocktime_total);
     g_free(ctx->vcpu_faults_count);
@@ -150,6 +162,36 @@ static void migration_exit_cb(Notifier *n, void *data)
     destroy_blocktime_context(ctx);
 }
 
+static GHashTable *blocktime_init_tid_to_vcpu_hash(void)
+{
+    /*
+     * TID as an unsigned int can be directly used as the key.  However,
+     * CPU index can NOT be directly used as value, because CPU index can
+     * be 0, which means NULL.  Then when lookup we can never know whether
+     * it's 0 or "not found".  Hence use an indirection for CPU index.
+     */
+    GHashTable *table = g_hash_table_new_full(g_direct_hash, g_direct_equal,
+                                              NULL, g_free);
+    CPUState *cpu;
+
+    /*
+     * Initialize the tid->cpu_id mapping for lookups.  The caller needs to
+     * make sure when reaching here the CPU topology is frozen and will be
+     * stable for the whole blocktime trapping period.
+     */
+    CPU_FOREACH(cpu) {
+        int *value = g_new(int, 1);
+
+        *value = cpu->cpu_index;
+        g_hash_table_insert(table,
+                            GUINT_TO_POINTER((uint32_t)cpu->thread_id),
+                            value);
+        trace_postcopy_blocktime_tid_cpu_map(cpu->cpu_index, cpu->thread_id);
+    }
+
+    return table;
+}
+
 static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -160,6 +202,8 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
+    ctx->tid_to_vcpu_hash = blocktime_init_tid_to_vcpu_hash();
+
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
 
@@ -827,18 +871,21 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
     return 0;
 }
 
-static int get_mem_fault_cpu_index(uint32_t pid)
+static int blocktime_get_vcpu(PostcopyBlocktimeContext *ctx, uint32_t tid)
 {
-    CPUState *cpu_iter;
+    int *found;
 
-    CPU_FOREACH(cpu_iter) {
-        if (cpu_iter->thread_id == pid) {
-            trace_get_mem_fault_cpu_index(cpu_iter->cpu_index, pid);
-            return cpu_iter->cpu_index;
-        }
+    found = g_hash_table_lookup(ctx->tid_to_vcpu_hash, GUINT_TO_POINTER(tid));
+    if (!found) {
+        /*
+         * NOTE: this is possible, because QEMU's non-vCPU threads can
+         * also access a missing page.  Or, when KVM async pf is enabled, a
+         * fault can even happen from a kworker..
+         */
+        return -1;
     }
-    trace_get_mem_fault_cpu_index(-1, pid);
-    return -1;
+
+    return *found;
 }
 
 static uint64_t get_current_ns(void)
@@ -865,8 +912,9 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     if (!dc || ptid == 0) {
         return;
     }
-    cpu = get_mem_fault_cpu_index(ptid);
+    cpu = blocktime_get_vcpu(dc, ptid);
     if (cpu < 0) {
+        dc->non_vcpu_faults++;
         return;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index 02cdb6e7cc..9c1f3b7044 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -310,8 +310,7 @@ postcopy_preempt_tls_handshake(void) ""
 postcopy_preempt_new_channel(void) ""
 postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
-
-get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
+postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
 
 # exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.35.3


