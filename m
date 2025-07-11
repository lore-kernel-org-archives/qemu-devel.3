Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD58C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEWg-0000gB-EU; Fri, 11 Jul 2025 10:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETi-00029M-Mc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETe-0006mw-83
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 896C81F45B;
 Fri, 11 Jul 2025 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54fwsoqL/jMCsGFAHTp3/X/pPU81n3Ezh4sNFqmkJqM=;
 b=mGbIBY70e/vjS8x4PT+J17kiidAWdyxucnzzIRxU/dnt4kLAeeyISh0/HZ0i4W4XdULswL
 tL1U+QActGCYG2YwYWsd0KQnQwkyNIsCOLQwsJt+EbddClAIZvpXdMCTgBepDDcBFUmaE+
 t4FcSxfeo1vVAPl4P7da3YyugSKp1VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54fwsoqL/jMCsGFAHTp3/X/pPU81n3Ezh4sNFqmkJqM=;
 b=xbIeizN4qH6O3CdMOJxjzllQLpCexUZzeqW+zsmE1GapWb+2U4kYYNhcTkNH+UrzuaeGVm
 HFzf+XAbZAdc+uBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54fwsoqL/jMCsGFAHTp3/X/pPU81n3Ezh4sNFqmkJqM=;
 b=mGbIBY70e/vjS8x4PT+J17kiidAWdyxucnzzIRxU/dnt4kLAeeyISh0/HZ0i4W4XdULswL
 tL1U+QActGCYG2YwYWsd0KQnQwkyNIsCOLQwsJt+EbddClAIZvpXdMCTgBepDDcBFUmaE+
 t4FcSxfeo1vVAPl4P7da3YyugSKp1VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54fwsoqL/jMCsGFAHTp3/X/pPU81n3Ezh4sNFqmkJqM=;
 b=xbIeizN4qH6O3CdMOJxjzllQLpCexUZzeqW+zsmE1GapWb+2U4kYYNhcTkNH+UrzuaeGVm
 HFzf+XAbZAdc+uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 757F91388B;
 Fri, 11 Jul 2025 14:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ePKwDHcbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 15/26] migration/postcopy: Make all blocktime vars 64bits
Date: Fri, 11 Jul 2025 11:10:20 -0300
Message-Id: <20250711141031.423-16-farosas@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
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

I am guessing it was used to be 32bits because of the atomic ops.  Now all
the atomic ops are gone and we're protected by a mutex instead, it's ok we
can switch to 64 bits.

Reasons to move over:

  - Allow further patches to change the unit from ms to us: with postcopy
  preempt mode, we're really into hundreds of microseconds level on
  blocktime.  We'd better be able to trap those.

  - This also paves way for some other tricks that the original version
  used to avoid overflows, e.g., start_time was almost only useful before
  to make sure the sampled timestamp won't overflow a 32-bit field.

  - This prepares further reports on top of existing data collected,
  e.g. average page fault latencies.  When average operation is taken into
  account, milliseconds are simply too coarse grained.

When at it:

  - Rename page_fault_vcpu_time to vcpu_blocktime_start.

  - Rename vcpu_blocktime to vcpu_blocktime_total.

  - Touch up the trace-events to not dump blocktime ctx pointer

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-5-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 50 ++++++++++++++++++++--------------------
 migration/trace-events   |  4 ++--
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 81925532de..ec91821b85 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -112,14 +112,15 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 
 typedef struct PostcopyBlocktimeContext {
     /* time when page fault initiated per vCPU */
-    uint32_t *page_fault_vcpu_time;
+    uint64_t *vcpu_blocktime_start;
+    /* blocktime per vCPU */
+    uint64_t *vcpu_blocktime_total;
     /* page address per vCPU */
     uintptr_t *vcpu_addr;
-    uint32_t total_blocktime;
-    /* blocktime per vCPU */
-    uint32_t *vcpu_blocktime;
+    /* total blocktime when all vCPUs are stopped */
+    uint64_t total_blocktime;
     /* point in time when last page fault was initiated */
-    uint32_t last_begin;
+    uint64_t last_begin;
     /* number of vCPU are suspended */
     int smp_cpus_down;
     uint64_t start_time;
@@ -133,9 +134,9 @@ typedef struct PostcopyBlocktimeContext {
 
 static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
-    g_free(ctx->page_fault_vcpu_time);
+    g_free(ctx->vcpu_blocktime_start);
+    g_free(ctx->vcpu_blocktime_total);
     g_free(ctx->vcpu_addr);
-    g_free(ctx->vcpu_blocktime);
     g_free(ctx);
 }
 
@@ -151,13 +152,14 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
     PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
-    ctx->page_fault_vcpu_time = g_new0(uint32_t, smp_cpus);
+
+    ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
-    ctx->vcpu_blocktime = g_new0(uint32_t, smp_cpus);
-
     ctx->exit_notifier.notify = migration_exit_cb;
     ctx->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     qemu_add_exit_notifier(&ctx->exit_notifier);
+
     return ctx;
 }
 
@@ -168,7 +170,7 @@ static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
     int i;
 
     for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        QAPI_LIST_PREPEND(list, ctx->vcpu_blocktime[i]);
+        QAPI_LIST_PREPEND(list, (uint32_t)ctx->vcpu_blocktime_total[i]);
     }
 
     return list;
@@ -191,12 +193,12 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     }
 
     info->has_postcopy_blocktime = true;
-    info->postcopy_blocktime = bc->total_blocktime;
+    info->postcopy_blocktime = (uint32_t)bc->total_blocktime;
     info->has_postcopy_vcpu_blocktime = true;
     info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
 }
 
-static uint32_t get_postcopy_total_blocktime(void)
+static uint64_t get_postcopy_total_blocktime(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
@@ -816,11 +818,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
     return -1;
 }
 
-static uint32_t get_low_time_offset(PostcopyBlocktimeContext *dc)
+static uint64_t get_low_time_offset(PostcopyBlocktimeContext *dc)
 {
-    int64_t start_time_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
-                                    dc->start_time;
-    return start_time_offset < 1 ? 1 : start_time_offset & UINT32_MAX;
+    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - dc->start_time;
 }
 
 /*
@@ -837,7 +837,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     int cpu;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
-    uint32_t low_time_offset;
+    uint64_t low_time_offset;
 
     if (!dc || ptid == 0) {
         return;
@@ -853,7 +853,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     }
 
     dc->last_begin = low_time_offset;
-    dc->page_fault_vcpu_time[cpu] = low_time_offset;
+    dc->vcpu_blocktime_start[cpu] = low_time_offset;
     dc->vcpu_addr[cpu] = addr;
 
     /*
@@ -862,7 +862,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
      */
     assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
 
-    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
+    trace_mark_postcopy_blocktime_begin(addr, dc->vcpu_blocktime_start[cpu],
                                         cpu);
 }
 
@@ -901,7 +901,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
     bool vcpu_total_blocktime = false;
-    uint32_t read_vcpu_time, low_time_offset;
+    uint64_t read_vcpu_time, low_time_offset;
 
     if (!dc) {
         return;
@@ -913,9 +913,9 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
      * optimal, more optimal algorithm is keeping tree or hash
      * where key is address value is a list of  */
     for (i = 0; i < smp_cpus; i++) {
-        uint32_t vcpu_blocktime = 0;
+        uint64_t vcpu_blocktime = 0;
 
-        read_vcpu_time = dc->page_fault_vcpu_time[i];
+        read_vcpu_time = dc->vcpu_blocktime_start[i];
         if (dc->vcpu_addr[i] != addr || read_vcpu_time == 0) {
             continue;
         }
@@ -929,14 +929,14 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
             vcpu_total_blocktime = true;
         }
         /* continue cycle, due to one page could affect several vCPUs */
-        dc->vcpu_blocktime[i] += vcpu_blocktime;
+        dc->vcpu_blocktime_total[i] += vcpu_blocktime;
     }
 
     dc->smp_cpus_down -= affected_cpu;
     if (vcpu_total_blocktime) {
         dc->total_blocktime += low_time_offset - dc->last_begin;
     }
-    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
+    trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 917f521e88..02cdb6e7cc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -285,8 +285,8 @@ postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
-mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d"
-mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d"
+mark_postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d"
+mark_postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
 postcopy_pause_fault_thread(void) ""
 postcopy_pause_fault_thread_continued(void) ""
 postcopy_pause_fast_load(void) ""
-- 
2.35.3


