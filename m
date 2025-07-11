Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C9DC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEbk-00089p-62; Fri, 11 Jul 2025 10:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEU5-0002uK-I5
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:20 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaEU3-0006rD-6Y
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:12:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B72D4211A0;
 Fri, 11 Jul 2025 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c+sKf5zS5Fj2EAwNBg2Y1lHJiq62nREYOaV1obbBy8=;
 b=Pnt/N4qfqh3sCpGl57i6gNuDc7hgJLBpBJoQmihCsgvZkR/Y4/5589o0c3q0xD5ceutvzE
 +fvq5z8NeFJp/enVuY3UDmqLEAXS9qfe+HJlKtro0Xyo5xbGTori+AG8FLut1IcvTGGYMZ
 vH/POsXDWgIXJyuEmBl/+WZqr2XRkaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c+sKf5zS5Fj2EAwNBg2Y1lHJiq62nREYOaV1obbBy8=;
 b=eQW/mb7wNRM+wQKup+ANbaadQJQ/M/cUW63AvFihehMzahI1wpX3F/Dd78u6y7f12HHmkK
 ssCak1XZOLxWkoCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Pnt/N4qf";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="eQW/mb7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c+sKf5zS5Fj2EAwNBg2Y1lHJiq62nREYOaV1obbBy8=;
 b=Pnt/N4qfqh3sCpGl57i6gNuDc7hgJLBpBJoQmihCsgvZkR/Y4/5589o0c3q0xD5ceutvzE
 +fvq5z8NeFJp/enVuY3UDmqLEAXS9qfe+HJlKtro0Xyo5xbGTori+AG8FLut1IcvTGGYMZ
 vH/POsXDWgIXJyuEmBl/+WZqr2XRkaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4c+sKf5zS5Fj2EAwNBg2Y1lHJiq62nREYOaV1obbBy8=;
 b=eQW/mb7wNRM+wQKup+ANbaadQJQ/M/cUW63AvFihehMzahI1wpX3F/Dd78u6y7f12HHmkK
 ssCak1XZOLxWkoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21FF31388B;
 Fri, 11 Jul 2025 14:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CNYpNIgbcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 25/26] migration/postcopy: Add latency distribution report for
 blocktime
Date: Fri, 11 Jul 2025 11:10:30 -0300
Message-Id: <20250711141031.423-26-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[treblig.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B72D4211A0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Add the latency distribution too for blocktime, using order-of-two buckets.
It accounts for all the faults, from either vCPU or non-vCPU threads.  With
prior rework, it's very easy to achieve by adding an array to account for
faults in each buckets.

Sample output for HMP (while for QMP it's simply an array):

Postcopy Latency Distribution:
  [     1 us -     2 us ]:          0
  [     2 us -     4 us ]:          0
  [     4 us -     8 us ]:          1
  [     8 us -    16 us ]:          2
  [    16 us -    32 us ]:          2
  [    32 us -    64 us ]:          3
  [    64 us -   128 us ]:      10169
  [   128 us -   256 us ]:      50151
  [   256 us -   512 us ]:      12876
  [   512 us -     1 ms ]:         97
  [     1 ms -     2 ms ]:         42
  [     2 ms -     4 ms ]:         44
  [     4 ms -     8 ms ]:         93
  [     8 ms -    16 ms ]:        138
  [    16 ms -    32 ms ]:          0
  [    32 ms -    65 ms ]:          0
  [    65 ms -   131 ms ]:          0
  [   131 ms -   262 ms ]:          0
  [   262 ms -   524 ms ]:          0
  [   524 ms -    1 sec ]:          0
  [    1 sec -    2 sec ]:          0
  [    2 sec -    4 sec ]:          0
  [    4 sec -    8 sec ]:          0
  [    8 sec -   16 sec ]:          0

Cc: Markus Armbruster <armbru@redhat.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-15-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c        | 32 +++++++++++++++++++
 migration/postcopy-ram.c              | 46 +++++++++++++++++++++++++++
 qapi/migration.json                   | 12 ++++++-
 tests/qtest/migration/migration-qmp.c |  1 +
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e1f9530520..cef5608210 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -52,6 +52,21 @@ static void migration_global_dump(Monitor *mon)
                    ms->clear_bitmap_shift);
 }
 
+static const gchar *format_time_str(uint64_t us)
+{
+    const char *units[] = {"us", "ms", "sec"};
+    int index = 0;
+
+    while (us > 1000) {
+        us /= 1000;
+        if (++index >= (sizeof(units) - 1)) {
+            break;
+        }
+    }
+
+    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
+}
+
 static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
 {
     if (info->has_postcopy_blocktime) {
@@ -100,6 +115,23 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
         }
         monitor_printf(mon, "]\n");
     }
+
+    if (info->has_postcopy_latency_dist) {
+        uint64List *item = info->postcopy_latency_dist;
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy Latency Distribution:\n");
+
+        while (item) {
+            g_autofree const gchar *from = format_time_str(1UL << count);
+            g_autofree const gchar *to = format_time_str(1UL << (count + 1));
+
+            monitor_printf(mon, "  [ %8s - %8s ]: %10"PRIu64"\n",
+                           from, to, item->value);
+            item = item->next;
+            count++;
+        }
+    }
 }
 
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f4cb23b3e0..45af9a361e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -110,6 +110,15 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
+/*
+ * Here we use 24 buckets, which means the last bucket will cover [2^24 us,
+ * 2^25 us) ~= [16, 32) seconds.  It should be far enough to record even
+ * extreme (perf-wise broken) 1G pages moving over, which can sometimes
+ * take a few seconds due to various reasons.  Anything more than that
+ * might be unsensible to account anymore.
+ */
+#define  BLOCKTIME_LATENCY_BUCKET_N  (24)
+
 /* All the time records are in unit of nanoseconds */
 typedef struct PostcopyBlocktimeContext {
     /* blocktime per vCPU */
@@ -175,6 +184,11 @@ typedef struct PostcopyBlocktimeContext {
      * that a fault was requested.
      */
     GHashTable *vcpu_addr_hash;
+    /*
+     * Each bucket stores the count of faults that were resolved within the
+     * bucket window [2^N us, 2^(N+1) us).
+     */
+    uint64_t latency_buckets[BLOCKTIME_LATENCY_BUCKET_N];
     /* total blocktime when all vCPUs are stopped */
     uint64_t total_blocktime;
     /* point in time when last page fault was initiated */
@@ -283,6 +297,9 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     unsigned int smp_cpus = ms->smp.cpus;
     PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
 
+    /* Initialize all counters to be zeros */
+    memset(ctx->latency_buckets, 0, sizeof(ctx->latency_buckets));
+
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_current = g_new0(uint8_t, smp_cpus);
@@ -320,6 +337,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     uint64_t latency_total = 0, faults = 0;
     uint32List *list_blocktime = NULL;
     uint64List *list_latency = NULL;
+    uint64List *latency_buckets = NULL;
     int i;
 
     if (!bc) {
@@ -349,6 +367,10 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
         QAPI_LIST_PREPEND(list_latency, latency);
     }
 
+    for (i = BLOCKTIME_LATENCY_BUCKET_N - 1; i >= 0; i--) {
+        QAPI_LIST_PREPEND(latency_buckets, bc->latency_buckets[i]);
+    }
+
     latency_total += bc->non_vcpu_blocktime_total;
     faults += bc->non_vcpu_faults;
 
@@ -364,6 +386,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     info->postcopy_latency = faults ? (latency_total / faults) : 0;
     info->has_postcopy_vcpu_latency = true;
     info->postcopy_vcpu_latency = list_latency;
+    info->has_postcopy_latency_dist = true;
+    info->postcopy_latency_dist = latency_buckets;
 }
 
 static uint64_t get_postcopy_total_blocktime(void)
@@ -1096,6 +1120,25 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     blocktime_fault_inject(dc, addr, cpu, current);
 }
 
+static void blocktime_latency_account(PostcopyBlocktimeContext *ctx,
+                                      uint64_t time_us)
+{
+    /*
+     * Convert time (in us) to bucket index it belongs.  Take extra caution
+     * of time_us==0 even if normally rare - when happens put into bucket 0.
+     */
+    int index = time_us ? (63 - clz64(time_us)) : 0;
+
+    assert(index >= 0);
+
+    /* If it's too large, put into top bucket */
+    if (index >= BLOCKTIME_LATENCY_BUCKET_N) {
+        index = BLOCKTIME_LATENCY_BUCKET_N - 1;
+    }
+
+    ctx->latency_buckets[index]++;
+}
+
 typedef struct {
     PostcopyBlocktimeContext *ctx;
     uint64_t current;
@@ -1118,6 +1161,9 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
     assert(iter->current >= entry->fault_time);
     time_passed = iter->current - entry->fault_time;
 
+    /* Latency buckets are in microseconds */
+    blocktime_latency_account(ctx, time_passed / SCALE_US);
+
     if (cpu >= 0) {
         /*
          * If we resolved all pending faults on one vCPU due to this page
diff --git a/qapi/migration.json b/qapi/migration.json
index 66fb8ac74d..2d39a8f748 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -242,6 +242,14 @@
 #     average page fault latency. This is only present when the
 #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-latency-dist: remote page fault latency distributions.  Each
+#     element of the array is the number of faults that fall into the
+#     bucket period.  For the N-th bucket (N>=0), the latency window is
+#     [2^Nus, 2^(N+1)us).  For example, the 8th element stores how many
+#     remote faults got resolved within [256us, 512us) window. This is only
+#     present when the postcopy-blocktime migration capability is enabled.
+#     (Since 10.1)
+#
 # @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
 #     ns).  It has the same definition of @postcopy-latency, but instead
 #     this is the per-vCPU statistics.  This is only present when the
@@ -280,7 +288,7 @@
 # Features:
 #
 # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
-#     @postcopy-non-vcpu-latency are experimental.
+#     @postcopy-latency-dist, @postcopy-non-vcpu-latency are experimental.
 #
 # Since: 0.14
 ##
@@ -299,6 +307,8 @@
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*postcopy-latency': {
                'type': 'uint64', 'features': [ 'unstable' ] },
+           '*postcopy-latency-dist': {
+               'type': ['uint64'], 'features': [ 'unstable' ] },
            '*postcopy-vcpu-latency': {
                'type': ['uint64'], 'features': [ 'unstable' ] },
            '*postcopy-non-vcpu-latency': {
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 67a67d4bd6..66dd369ba7 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -360,6 +360,7 @@ void read_blocktime(QTestState *who)
     g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
     g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-latency-dist"));
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
     g_assert(qdict_haskey(rsp_return, "postcopy-non-vcpu-latency"));
     qobject_unref(rsp_return);
-- 
2.35.3


