Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E24C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 14:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEWe-0000V6-6O; Fri, 11 Jul 2025 10:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETa-00020g-OH
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:50 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uaETW-0006kD-Ca
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:11:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4D182119B;
 Fri, 11 Jul 2025 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xERf0QzeUJ/kYk97vVnlP2qxGIkQ4LHhvQ4xm0T8gKs=;
 b=1MI2bPsFha7OU3TCXmyL7fL5rat6G2Y363XYAEowWzd1W9geRVivnVXHPf8Jqjd2HY+WN3
 PsR3xT/2enKIubD0+dOPWPBacep2mP/9Pw3PQOJcJCwTIrfynlnbCn1vJc8M4RZD6eY/tb
 vtn0UKyJ6ILJ9eTyV19sKishkqcfPb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xERf0QzeUJ/kYk97vVnlP2qxGIkQ4LHhvQ4xm0T8gKs=;
 b=xMdouM+jwsh1pt+XdILmpvDW2q0lPac696bPaDmOJ1v/qbKxhfEuEZORfubzOr7mBk8rVA
 lmhyxf5hu9rVNRAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1MI2bPsF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xMdouM+j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752243067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xERf0QzeUJ/kYk97vVnlP2qxGIkQ4LHhvQ4xm0T8gKs=;
 b=1MI2bPsFha7OU3TCXmyL7fL5rat6G2Y363XYAEowWzd1W9geRVivnVXHPf8Jqjd2HY+WN3
 PsR3xT/2enKIubD0+dOPWPBacep2mP/9Pw3PQOJcJCwTIrfynlnbCn1vJc8M4RZD6eY/tb
 vtn0UKyJ6ILJ9eTyV19sKishkqcfPb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752243067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xERf0QzeUJ/kYk97vVnlP2qxGIkQ4LHhvQ4xm0T8gKs=;
 b=xMdouM+jwsh1pt+XdILmpvDW2q0lPac696bPaDmOJ1v/qbKxhfEuEZORfubzOr7mBk8rVA
 lmhyxf5hu9rVNRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D051388B;
 Fri, 11 Jul 2025 14:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KGvPGnobcWg7TgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Jul 2025 14:11:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 17/26] migration/postcopy: Bring blocktime layer to ns level
Date: Fri, 11 Jul 2025 11:10:22 -0300
Message-Id: <20250711141031.423-18-farosas@suse.de>
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
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: C4D182119B
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

With 64-bit fields, it is trivial.  The caution is when exposing any values
in QMP, it was still declared with milliseconds (ms).  Hence it's needed to
do the convertion when exporting the values to existing QMP queries.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250613141217.474825-7-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e9acb4ef6e..9dfa92a62d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -110,6 +110,7 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
+/* All the time records are in unit of nanoseconds */
 typedef struct PostcopyBlocktimeContext {
     /* time when page fault initiated per vCPU */
     uint64_t *vcpu_blocktime_start;
@@ -168,7 +169,9 @@ static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
     int i;
 
     for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        QAPI_LIST_PREPEND(list, (uint32_t)ctx->vcpu_blocktime_total[i]);
+        /* Convert ns -> ms */
+        QAPI_LIST_PREPEND(
+            list, (uint32_t)(ctx->vcpu_blocktime_total[i] / SCALE_MS));
     }
 
     return list;
@@ -191,7 +194,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     }
 
     info->has_postcopy_blocktime = true;
-    info->postcopy_blocktime = (uint32_t)bc->total_blocktime;
+    /* Convert ns -> ms */
+    info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / SCALE_MS);
     info->has_postcopy_vcpu_blocktime = true;
     info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
 }
@@ -816,9 +820,9 @@ static int get_mem_fault_cpu_index(uint32_t pid)
     return -1;
 }
 
-static uint64_t get_low_time_offset(void)
+static uint64_t get_current_ns(void)
 {
-    return (uint64_t)qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    return (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 }
 
 /*
@@ -835,7 +839,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     int cpu;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
-    uint64_t low_time_offset;
+    uint64_t current;
 
     if (!dc || ptid == 0) {
         return;
@@ -845,13 +849,13 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         return;
     }
 
-    low_time_offset = get_low_time_offset();
+    current = get_current_ns();
     if (dc->vcpu_addr[cpu] == 0) {
         dc->smp_cpus_down++;
     }
 
-    dc->last_begin = low_time_offset;
-    dc->vcpu_blocktime_start[cpu] = low_time_offset;
+    dc->last_begin = current;
+    dc->vcpu_blocktime_start[cpu] = current;
     dc->vcpu_addr[cpu] = addr;
 
     /*
@@ -899,13 +903,13 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     unsigned int smp_cpus = ms->smp.cpus;
     int i, affected_cpu = 0;
     bool vcpu_total_blocktime = false;
-    uint64_t read_vcpu_time, low_time_offset;
+    uint64_t read_vcpu_time, current;
 
     if (!dc) {
         return;
     }
 
-    low_time_offset = get_low_time_offset();
+    current = get_current_ns();
     /* lookup cpu, to clear it,
      * that algorithm looks straightforward, but it's not
      * optimal, more optimal algorithm is keeping tree or hash
@@ -918,7 +922,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
             continue;
         }
         dc->vcpu_addr[i] = 0;
-        vcpu_blocktime = low_time_offset - read_vcpu_time;
+        vcpu_blocktime = current - read_vcpu_time;
         affected_cpu += 1;
         /* we need to know is that mark_postcopy_end was due to
          * faulted page, another possible case it's prefetched
@@ -932,7 +936,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
 
     dc->smp_cpus_down -= affected_cpu;
     if (vcpu_total_blocktime) {
-        dc->total_blocktime += low_time_offset - dc->last_begin;
+        dc->total_blocktime += current - dc->last_begin;
     }
     trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
                                       affected_cpu);
-- 
2.35.3


