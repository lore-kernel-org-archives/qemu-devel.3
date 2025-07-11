Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10961C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEWz-0000nq-8Q; Fri, 11 Jul 2025 10:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETk-0002Al-Is
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETe-0006mz-R7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C91F92119D;
 Fri, 11 Jul 2025 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnDpAQQCKqVOlmyJkam85CqaMlx30YtetQyR2F9+3Q8=;
 b=m74LQLAi6P0acLw2n9JFnWkO7QYBwCr/NQ2KwGZ5awe86xMT2pGyUeup6WoMRETzS3xdk6
 k+jW0QzgabbXMlkqDMg/4jb1/5SInwmf9LNNHl1hcz8djJ22ODOPPn79dmcnrsObmzC2zd
 9UpRe/1CPvHgVaz6s100njGAto3o/vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnDpAQQCKqVOlmyJkam85CqaMlx30YtetQyR2F9+3Q8=;
 b=Dr3W1dFTo12HvVeiTNQbzM7pmswm2NxpXbWxA+fd5oCiraQ+KX5heUGWwh6bYNE34kJtRI
 OU2RaO28N8RzL5DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GKnyWkZR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=y1Ug5Qxf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnDpAQQCKqVOlmyJkam85CqaMlx30YtetQyR2F9+3Q8=;
 b=GKnyWkZR3cgQhOnp9QI9UmjEXJ/zrVMS3nc6y+kk0orp+wT9SxE0zV9feGA/4dxs/7G7HX
 9UUVaxKP5AqnbQSnrIrtt0WP6DmKSVB2J7rXs0fg09mND4G0QJePvAoy2fydmtdzdRPafN
 oKro+25sgWxUluaSJT82RGZfdWDESjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnDpAQQCKqVOlmyJkam85CqaMlx30YtetQyR2F9+3Q8=;
 b=y1Ug5QxfECAIETntFKDTxVxhAyN0lE35kjA6ieBLaEtLi3WCILipGU+sN8NgEkjASgUDOP
 ALU02TDdAXvcmlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E93D01388B;
 Fri, 11 Jul 2025 14:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GF7KKH0bcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Mario Casquero <mcasquer@redhat.com>
Subject: [PULL 19/26] migration/postcopy: Report fault latencies in blocktime
Date: Fri, 11 Jul 2025 11:10:24 -0300
Message-Id: <20250711141031.423-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250711141031.423-1-farosas@suse.de>
References: <20250711141031.423-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C91F92119D
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,treblig.org:email,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Blocktime so far only cares about the time one vcpu (or the whole system)
got blocked.  It would be also be helpful if it can also report the latency
of page requests, which could be very sensitive during postcopy.

Blocktime itself is sometimes not very important, especially when one
thinks about KVM async PF support, which means vCPUs are literally almost
not blocked at all because the guest OS is smart enough to switch to
another task when a remote fault is needed.

However, latency is still sensitive and important because even if the guest
vCPU is running on threads that do not need a remote fault, the workload
that accesses some missing page is still affected.

Add two entries to the report, showing how long it takes to resolve a
remote fault.  Mention in the QAPI doc that this is not the real average
fault latency, but only the ones that was requested for a remote fault.

Unwrap get_vcpu_blocktime_list() so we don't need to walk the list twice,
meanwhile add the entry checks in qtests for all postcopy tests.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Link: https://lore.kernel.org/r/20250613141217.474825-9-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c        | 67 ++++++++++++++++++---------
 migration/postcopy-ram.c              | 49 +++++++++++++-------
 qapi/migration.json                   | 20 ++++++++
 tests/qtest/migration/migration-qmp.c |  3 ++
 4 files changed, 102 insertions(+), 37 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 867e017b32..8b3846dab5 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -52,6 +52,51 @@ static void migration_global_dump(Monitor *mon)
                    ms->clear_bitmap_shift);
 }
 
+static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
+{
+    if (info->has_postcopy_blocktime) {
+        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
+                       info->postcopy_blocktime);
+    }
+
+    if (info->has_postcopy_vcpu_blocktime) {
+        uint32List *item = info->postcopy_vcpu_blocktime;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
+    }
+
+    if (info->has_postcopy_latency) {
+        monitor_printf(mon, "Postcopy Latency (ns): %" PRIu64 "\n",
+                       info->postcopy_latency);
+    }
+
+    if (info->has_postcopy_vcpu_latency) {
+        uint64List *item = info->postcopy_vcpu_latency;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Latencies (ns):\n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu64, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
+    }
+}
+
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
     bool show_all = qdict_get_try_bool(qdict, "all", false);
@@ -202,27 +247,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->dirty_limit_ring_full_time);
     }
 
-    if (info->has_postcopy_blocktime) {
-        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
-                       info->postcopy_blocktime);
-    }
-
-    if (info->has_postcopy_vcpu_blocktime) {
-        uint32List *item = info->postcopy_vcpu_blocktime;
-        const char *sep = "";
-        int count = 0;
-
-        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
-
-        while (item) {
-            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
-            item = item->next;
-            /* Each line 10 vcpu results, newline if there's more */
-            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
-        }
-        monitor_printf(mon, "]\n");
-    }
-
+    migration_dump_blocktime(mon, info);
 out:
     qapi_free_MigrationInfo(info);
 }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 15ea106910..fe940f89b9 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -166,21 +166,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     return ctx;
 }
 
-static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
-{
-    MachineState *ms = MACHINE(qdev_get_machine());
-    uint32List *list = NULL;
-    int i;
-
-    for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        /* Convert ns -> ms */
-        QAPI_LIST_PREPEND(
-            list, (uint32_t)(ctx->vcpu_blocktime_total[i] / SCALE_MS));
-    }
-
-    return list;
-}
-
 /*
  * This function just populates MigrationInfo from postcopy's
  * blocktime context. It will not populate MigrationInfo,
@@ -192,16 +177,48 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    uint64_t latency_total = 0, faults = 0;
+    uint32List *list_blocktime = NULL;
+    uint64List *list_latency = NULL;
+    int i;
 
     if (!bc) {
         return;
     }
 
+    for (i = ms->smp.cpus - 1; i >= 0; i--) {
+        uint64_t latency, total, count;
+
+        /* Convert ns -> ms */
+        QAPI_LIST_PREPEND(list_blocktime,
+                          (uint32_t)(bc->vcpu_blocktime_total[i] / SCALE_MS));
+
+        /* The rest in nanoseconds */
+        total = bc->vcpu_blocktime_total[i];
+        latency_total += total;
+        count = bc->vcpu_faults_count[i];
+        faults += count;
+
+        if (count) {
+            latency = total / count;
+        } else {
+            /* No fault detected */
+            latency = 0;
+        }
+
+        QAPI_LIST_PREPEND(list_latency, latency);
+    }
+
     info->has_postcopy_blocktime = true;
     /* Convert ns -> ms */
     info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / SCALE_MS);
     info->has_postcopy_vcpu_blocktime = true;
-    info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
+    info->postcopy_vcpu_blocktime = list_blocktime;
+    info->has_postcopy_latency = true;
+    info->postcopy_latency = faults ? (latency_total / faults) : 0;
+    info->has_postcopy_vcpu_latency = true;
+    info->postcopy_vcpu_latency = list_latency;
 }
 
 static uint64_t get_postcopy_total_blocktime(void)
diff --git a/qapi/migration.json b/qapi/migration.json
index e8a7d3b2a9..bb41dc0795 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -236,6 +236,17 @@
 #     This is only present when the postcopy-blocktime migration
 #     capability is enabled.  (Since 3.0)
 #
+# @postcopy-latency: average remote page fault latency (in ns).  Note that
+#     this doesn't include all faults, but only the ones that require a
+#     remote page request.  So it should be always bigger than the real
+#     average page fault latency. This is only present when the
+#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
+#
+# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
+#     ns).  It has the same definition of @postcopy-latency, but instead
+#     this is the per-vCPU statistics.  This is only present when the
+#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
+#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -260,6 +271,11 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
+# Features:
+#
+# @unstable: Members @postcopy-latency, @postcopy-vcpu-latency are
+#     experimental.
+#
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
@@ -275,6 +291,10 @@
            '*blocked-reasons': ['str'],
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
+           '*postcopy-latency': {
+               'type': 'uint64', 'features': [ 'unstable' ] },
+           '*postcopy-vcpu-latency': {
+               'type': ['uint64'], 'features': [ 'unstable' ] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index fb59741b2c..1a5ab2d229 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -358,6 +358,9 @@ void read_blocktime(QTestState *who)
 
     rsp_return = migrate_query_not_failed(who);
     g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
     qobject_unref(rsp_return);
 }
 
-- 
2.35.3


