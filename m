Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524DDC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyyz-0001KP-GF; Fri, 28 Aug 2026 11:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyyv-0001JE-Nw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:05 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyys-0008Af-PA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 653301F7B9;
 Fri, 28 Aug 2026 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewaRFj4nvWUr8moe8ioeqzVqPOi9UFniYimbaeaZ+qs=;
 b=CxCooevI2Qi2rQnerAOa97pvSGQEjyc8K6Q5wzcWnMsJXlnwDf4bsqEN/7xyWdWO1IrYU+
 I8rA16FawvXLvTQDb62ICRyAizC9TnTObK0Ljga4uL8S3njbTIGoDFyBvCXbM7eZLBCFmv
 LMvyMGGsHz1zG3J1FeXukw2M/Qmt6F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewaRFj4nvWUr8moe8ioeqzVqPOi9UFniYimbaeaZ+qs=;
 b=zKG9A1kM7FDJS477erF8C4VARC4GWM3KvMJG4U+InjA4/H5jGRqsrWHNEXun9fifg+TxqC
 BjGFqyVizq3S/fAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewaRFj4nvWUr8moe8ioeqzVqPOi9UFniYimbaeaZ+qs=;
 b=ei0ti1DJVI2Bi0TsyHqVC2l9UB40p+AwCgSrp6lLmpTRFCAD+strJozUTEO1KKbL+y5pIG
 99M75XTV85aeRPmfGVdzyKL0ZZib58MRIlUQ3R5jffzgwrFWPh+Sf2UODEQAz2BWdCYDU2
 Esya6yHgnk0UEgoBxEl/EqAlW63Dflc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932732;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ewaRFj4nvWUr8moe8ioeqzVqPOi9UFniYimbaeaZ+qs=;
 b=JVUZe63NfjPvq5M614Kd8EqKIFYQv/forZhzQq3hCzduLXYHkZZS0VWYMybFj08zozPfPN
 BuKsUgsbqmfm5PAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E6913675;
 Fri, 28 Aug 2026 15:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oNzeOjqwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:58:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL v2 02/30] migration: Extract blocktime marking helper
Date: Fri, 28 Aug 2026 12:58:17 -0300
Message-ID: <20260828155845.2874508-3-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Use new function try_mark_postcopy_blocktim_begin() to call
mark_postcopy_blocktime_begin if page was not received and return if it
actually marked it.

This will help in having a cleaner API to call
mark_postcopy_blocktime_begin as it requires the page to not be received
by asserting on it's existance in RAMBlock->receivedmap.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c    | 24 ++----------------------
 migration/postcopy-ram.c | 39 +++++++++++++++++++++++++++++++++++++++
 migration/postcopy-ram.h |  3 +++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 9df6da131ce..a30779f37c8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -577,32 +577,12 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
                               RAMBlock *rb, ram_addr_t start, uint64_t haddr,
                               uint32_t tid)
 {
-    void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
-    bool received = false;
-
-    WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
-        received = ramblock_recv_bitmap_test_byte_offset(rb, start);
-        if (!received) {
-            if (!g_tree_lookup(mis->page_requested, aligned)) {
-                /*
-                 * The page has not been received, and it's not yet in the
-                 * page request list.  Queue it.  Set the value of element
-                 * to 1, so that things like g_tree_lookup() will return
-                 * TRUE (1) when found.
-                 */
-                g_tree_insert(mis->page_requested, aligned, (gpointer)1);
-                qatomic_inc(&mis->page_requested_count);
-                trace_postcopy_page_req_add(aligned, mis->page_requested_count);
-            }
-            mark_postcopy_blocktime_begin(haddr, tid, rb);
-        }
-    }
-
     /*
+     * If not able to mark page for blocktime it must already be present.
      * If the page is there, skip sending the message.  We don't even need the
      * lock because as long as the page arrived, it'll be there forever.
      */
-    if (received) {
+    if (!try_mark_postcopy_blocktime_begin(mis, rb, start, haddr, tid)) {
         return 0;
     }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 120828a2ead..7dead1c68fc 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1054,6 +1054,37 @@ static void blocktime_fault_inject(PostcopyBlocktimeContext *ctx,
     trace_postcopy_blocktime_begin(addr, time, cpu, !!head);
 }
 
+/*
+ * Take @page_request_mutex and try marking postcopy blocktime begin.
+ * Return true if marking is successful and false if page alredy exists.
+ */
+bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
+                                       RAMBlock *rb, ram_addr_t start,
+                                       uint64_t haddr, uint32_t tid)
+{
+    bool received = false;
+    void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
+
+    WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
+        received = ramblock_recv_bitmap_test_byte_offset(rb, start);
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
+            mark_postcopy_blocktime_begin((uint64_t)aligned, tid, rb);
+        }
+    }
+    return !received;
+}
+
 /*
  * This function is being called when pagefault occurs. It tracks down vCPU
  * blocking time.  It's protected by @page_request_mutex.
@@ -1749,6 +1780,14 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb)
 {
 }
+
+bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
+                                       RAMBlock *rb, ram_addr_t start,
+                                       uint64_t haddr, uint32_t tid)
+{
+    g_assert_not_reached();
+    return false;
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 98d918713f5..ea879f0bc6f 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -196,6 +196,9 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
 void postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
 bool postcopy_is_paused(MigrationStatus status);
+bool try_mark_postcopy_blocktime_begin(MigrationIncomingState *mis,
+                                       RAMBlock *rb, ram_addr_t start,
+                                       uint64_t haddr, uint32_t tid);
 void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
                                    RAMBlock *rb);
 
-- 
2.53.0


