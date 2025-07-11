Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F34C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEdt-0004B9-8J; Fri, 11 Jul 2025 10:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETy-0002t1-IQ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:16 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETw-0006qG-4L
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9846E211A1;
 Fri, 11 Jul 2025 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXrUzXE+qpxN513L6w3Tqatg0QrA1uwNuuyVmMVtD84=;
 b=Yrq/k7JBhS5yt7ZVfvWJIvA38BfvBuSItusjcTj6c8ofocAMHp2SfrefC/rmJvnekMT8zk
 QEM7qwnWZpukI2LQrd+S+65rjK+b8QTNSsjCYmZkt3PgmakEKAUsVqti44XRkBt1BlIw1D
 igGBsgSwiWcxbsjbv1cCSMzdIvOtszs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXrUzXE+qpxN513L6w3Tqatg0QrA1uwNuuyVmMVtD84=;
 b=gnlD6qkz3GJ9qa2sV+IGlV+Ncbb5Bv2WMm3deYOJNXRER2xG8c8KGWsGFhsMHSae/eO2JP
 B8/W9zfws5ce0aAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXrUzXE+qpxN513L6w3Tqatg0QrA1uwNuuyVmMVtD84=;
 b=Yrq/k7JBhS5yt7ZVfvWJIvA38BfvBuSItusjcTj6c8ofocAMHp2SfrefC/rmJvnekMT8zk
 QEM7qwnWZpukI2LQrd+S+65rjK+b8QTNSsjCYmZkt3PgmakEKAUsVqti44XRkBt1BlIw1D
 igGBsgSwiWcxbsjbv1cCSMzdIvOtszs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXrUzXE+qpxN513L6w3Tqatg0QrA1uwNuuyVmMVtD84=;
 b=gnlD6qkz3GJ9qa2sV+IGlV+Ncbb5Bv2WMm3deYOJNXRER2xG8c8KGWsGFhsMHSae/eO2JP
 B8/W9zfws5ce0aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B386D1388B;
 Fri, 11 Jul 2025 14:11:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yF6qGoYbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 24/26] migration/postcopy: blocktime allows track / report
 non-vCPU faults
Date: Fri, 11 Jul 2025 11:10:29 -0300
Message-Id: <20250711141031.423-25-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, treblig.org:email,
 suse.de:email, suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

When used to report page fault latencies, the blocktime feature can be
almost useless when KVM async page fault is enabled, because in most cases
such remote fault will kickoff async page faults, then it's not trackable
from blocktime layer.

After all these recent rewrites to blocktime layer, it's finally so easy to
also support tracking non-vCPU faults.  It'll be even faster if we could
always index fault records with TIDs, unfortunately we need to maintain the
blocktime API which report things in vCPU indexes.

Of course this can work not only for kworkers, but also any guest accesses
that may reach a missing page, for example, very likely when in the QEMU
main thread too (and all other threads whenever applicable).

In this case, we don't care about "how long the threads are blocked", but
we only care about "how long the fault will be resolved".

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Link: https://lore.kernel.org/r/20250613141217.474825-14-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c        |  5 +++
 migration/postcopy-ram.c              | 64 +++++++++++++++++++++------
 migration/trace-events                |  2 +-
 qapi/migration.json                   | 12 ++++-
 tests/qtest/migration/migration-qmp.c |  1 +
 5 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8b3846dab5..e1f9530520 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -80,6 +80,11 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
                        info->postcopy_latency);
     }
 
+    if (info->has_postcopy_non_vcpu_latency) {
+        monitor_printf(mon, "Postcopy non-vCPU Latencies (ns): %" PRIu64 "\n",
+                       info->postcopy_non_vcpu_latency);
+    }
+
     if (info->has_postcopy_vcpu_latency) {
         uint64List *item = info->postcopy_vcpu_latency;
         const char *sep = "";
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 91c23b446e..f4cb23b3e0 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -192,6 +192,8 @@ typedef struct PostcopyBlocktimeContext {
     GHashTable *tid_to_vcpu_hash;
     /* Count of non-vCPU faults.  This is only for debugging purpose. */
     uint64_t non_vcpu_faults;
+    /* total blocktime when a non-vCPU thread is stopped */
+    uint64_t non_vcpu_blocktime_total;
 
     /*
      * Handler for exit event, necessary for
@@ -203,7 +205,10 @@ typedef struct PostcopyBlocktimeContext {
 typedef struct {
     /* The time the fault was triggered */
     uint64_t fault_time;
-    /* The vCPU index that was blocked */
+    /*
+     * The vCPU index that was blocked, when cpu==-1, it means it's a
+     * fault from non-vCPU threads.
+     */
     int cpu;
 } BlocktimeVCPUEntry;
 
@@ -344,6 +349,12 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
         QAPI_LIST_PREPEND(list_latency, latency);
     }
 
+    latency_total += bc->non_vcpu_blocktime_total;
+    faults += bc->non_vcpu_faults;
+
+    info->has_postcopy_non_vcpu_latency = true;
+    info->postcopy_non_vcpu_latency = bc->non_vcpu_faults ?
+        (bc->non_vcpu_blocktime_total / bc->non_vcpu_faults) : 0;
     info->has_postcopy_blocktime = true;
     /* Convert ns -> ms */
     info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / SCALE_MS);
@@ -983,7 +994,10 @@ static uint64_t get_current_ns(void)
     return (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 }
 
-/* Inject an (cpu, fault_time) entry into the database, using addr as key */
+/*
+ * Inject an (cpu, fault_time) entry into the database, using addr as key.
+ * When cpu==-1, it means it's a non-vCPU fault.
+ */
 static void blocktime_fault_inject(PostcopyBlocktimeContext *ctx,
                                    uintptr_t addr, int cpu, uint64_t time)
 {
@@ -1066,9 +1080,17 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         /* Making sure it won't overflow - it really should never! */
         assert(dc->vcpu_faults_current[cpu] <= 255);
     } else {
-        /* We do not support non-vCPU thread tracking yet */
+        /*
+         * For non-vCPU thread faults, we don't care about tid or cpu index
+         * or time the thread is blocked (e.g., a kworker trying to help
+         * KVM when async_pf=on is OK to be blocked and not affect guest
+         * responsiveness), but we care about latency.  Track it with
+         * cpu=-1.
+         *
+         * Note that this will NOT affect blocktime reports on vCPU being
+         * blocked, but only about system-wide latency reports.
+         */
         dc->non_vcpu_faults++;
-        return;
     }
 
     blocktime_fault_inject(dc, addr, cpu, current);
@@ -1078,6 +1100,7 @@ typedef struct {
     PostcopyBlocktimeContext *ctx;
     uint64_t current;
     int affected_cpus;
+    int affected_non_cpus;
 } BlockTimeVCPUIter;
 
 static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
@@ -1085,6 +1108,7 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
     BlockTimeVCPUIter *iter = user_data;
     PostcopyBlocktimeContext *ctx = iter->ctx;
     BlocktimeVCPUEntry *entry = data;
+    uint64_t time_passed;
     int cpu = entry->cpu;
 
     /*
@@ -1092,17 +1116,27 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
      * later than when it was faulted.
      */
     assert(iter->current >= entry->fault_time);
+    time_passed = iter->current - entry->fault_time;
 
-    /*
-     * If we resolved all pending faults on one vCPU due to this page
-     * resolution, take a note.
-     */
-    if (--ctx->vcpu_faults_current[cpu] == 0) {
-        ctx->vcpu_blocktime_total[cpu] += iter->current - entry->fault_time;
-        iter->affected_cpus += 1;
+    if (cpu >= 0) {
+        /*
+         * If we resolved all pending faults on one vCPU due to this page
+         * resolution, take a note.
+         */
+        if (--ctx->vcpu_faults_current[cpu] == 0) {
+            ctx->vcpu_blocktime_total[cpu] += time_passed;
+            iter->affected_cpus += 1;
+        }
+        trace_postcopy_blocktime_end_one(cpu, ctx->vcpu_faults_current[cpu]);
+    } else {
+        iter->affected_non_cpus++;
+        ctx->non_vcpu_blocktime_total += time_passed;
+        /*
+         * We do not maintain how many pending non-vCPU faults because we
+         * do not care about blocktime, only latency.
+         */
+        trace_postcopy_blocktime_end_one(-1, 0);
     }
-
-    trace_postcopy_blocktime_end_one(cpu, ctx->vcpu_faults_current[cpu]);
 }
 
 /*
@@ -1141,6 +1175,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     BlockTimeVCPUIter iter = {
         .current = get_current_ns(),
         .affected_cpus = 0,
+        .affected_non_cpus = 0,
         .ctx = dc,
     };
     gpointer key = (gpointer)addr;
@@ -1174,7 +1209,8 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     }
     dc->smp_cpus_down -= iter.affected_cpus;
 
-    trace_postcopy_blocktime_end(addr, iter.current, iter.affected_cpus);
+    trace_postcopy_blocktime_end(addr, iter.current, iter.affected_cpus,
+                                 iter.affected_non_cpus);
 }
 
 static void postcopy_pause_fault_thread(MigrationIncomingState *mis)
diff --git a/migration/trace-events b/migration/trace-events
index a36a78f01a..706db97def 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -310,7 +310,7 @@ postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
 postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
 postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
-postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
+postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu, int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d, affected_non_cpus: %d"
 postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
 
 # exec.c
diff --git a/qapi/migration.json b/qapi/migration.json
index bb41dc0795..66fb8ac74d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -247,6 +247,12 @@
 #     this is the per-vCPU statistics.  This is only present when the
 #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-non-vcpu-latency: average remote page fault latency for all
+#     faults happend in non-vCPU threads (in ns).  It has the same
+#     definition of @postcopy-latency but this only provides statistics to
+#     non-vCPU faults.  This is only present when the postcopy-blocktime
+#     migration capability is enabled.  (Since 10.1)
+#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -273,8 +279,8 @@
 #
 # Features:
 #
-# @unstable: Members @postcopy-latency, @postcopy-vcpu-latency are
-#     experimental.
+# @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
+#     @postcopy-non-vcpu-latency are experimental.
 #
 # Since: 0.14
 ##
@@ -295,6 +301,8 @@
                'type': 'uint64', 'features': [ 'unstable' ] },
            '*postcopy-vcpu-latency': {
                'type': ['uint64'], 'features': [ 'unstable' ] },
+           '*postcopy-non-vcpu-latency': {
+               'type': 'uint64', 'features': [ 'unstable' ] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 1a5ab2d229..67a67d4bd6 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -361,6 +361,7 @@ void read_blocktime(QTestState *who)
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
     g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-non-vcpu-latency"));
     qobject_unref(rsp_return);
 }
 
-- 
2.35.3


