Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257FDC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyz7-0001Ml-Pm; Fri, 28 Aug 2026 11:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyz5-0001MW-8d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyyz-0008FU-6z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:14 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CCE82229F;
 Fri, 28 Aug 2026 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SmeCai2W9mGUnaIlF+RloeydYydX2zCixfhNWH4ej8=;
 b=pV6jcU/wBnaxJ5hudeXpFNtAKkTIRjES9tXGwRhpgRARGxp8nseRaq5Jyqi0860332CMZb
 ou9UAVO9PAHrvhrYBhcqMdG5IpUBwGfKTJ4yiOTVRxvvxUvcawf0la/zjY7UyP6W7+SKth
 SJQKq2sfowzcIl2IAuEUMsQZBTNXA7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SmeCai2W9mGUnaIlF+RloeydYydX2zCixfhNWH4ej8=;
 b=4c9xpu4+TEypBrwucPHv/oFZVMoXrod2FaeYiZiPzL9WVN8gTIutZBJ5UnkDbVnHhAW0o4
 +5lWTGC++QguGlBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SmeCai2W9mGUnaIlF+RloeydYydX2zCixfhNWH4ej8=;
 b=PezpehRgKQ+M6QKQLgb/137gnGuXnzJ5OqGcR1X/U5j+NC+C9PTUymorkpNQVPaJzFjiu5
 EOqd8eFab5WscohM6yMLa7Y6mEV4EQyEnzp3sBNYMr9LrUwT3CAQ93iJYbwStGwVh816tn
 ELUfDBOGrl0xDkjNvkKvwSZ4cws+w6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SmeCai2W9mGUnaIlF+RloeydYydX2zCixfhNWH4ej8=;
 b=ZAAwK2MmEkX6bo4rO/nKZ9vxK1hc5B93ShfsvJFlhw14shckxd2yegGr2dhQGqV1um/UEI
 grqjqsw9HPvldPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F8CC1352D;
 Fri, 28 Aug 2026 15:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mEpcDEKwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:58:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PULL v2 07/30] migration: add support for fault thread to load pages
 from disk
Date: Fri, 28 Aug 2026 12:58:22 -0300
Message-ID: <20260828155845.2874508-8-farosas@suse.de>
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
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=ham autolearn_force=no
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

In fast snapshot load, we would like to serve faults as soon as possible
hence loading pages directly instead of requesting a source

Add postcopy_mapped_ram_load_page() function which serves single page
fault. It uses bitmap_test_and_clear_atomic() on pending_bmap to prevent
multiple threads from loading same page. It loads a page or pages
depending on size of guest pages and host pages, loading exactly the
larger of two. If the entire page is zero postcopy_place_page_zero() is
used for efficiency and in case some part is non zero it is part by part
loaded on loop using new function postcopy_mapped_ram_load_guest_page()
which loads a single guest page in a buffer which is then placed using
postcopy_place_page(). This covers all possible cases for various page
sizes of host and guest. Because postcopy_place_page and in general
postcopy does not support larger guest pages this will not work in case
of guest pages sizes larger than host.

Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
instead of requesting source in case of fast snapshot load. to_src_file
check is bypassed in fast snapshot load case as there is no source.

Call try_mark_postcopy_blocktime_begin on every page fault to support
postcopy-blocktime.

Allocate another channel in postcopy_temp_pages_setup(like the preempt
case), for both the fault thread and eager thread to load pages
independently.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/postcopy-ram.c | 183 +++++++++++++++++++++++++++++++++++----
 1 file changed, 166 insertions(+), 17 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 2286d25f8c6..430b5f24e1a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -946,6 +946,130 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                        pagesize);
 }
 
+/*
+ * Load a single guest page from source file into the buffer.
+ * NOTE: This is not an atomic operation and should not be used to directly load
+ * pages on page faults in postcopy. It is meant to fill in buffer that can then
+ * be copied into the faulting location using UFFDIO_COPY.
+ */
+static bool postcopy_mapped_ram_load_guest_page(MigrationIncomingState *mis,
+                                                RAMBlock *rb,
+                                                ram_addr_t rb_offset, void *buf,
+                                                Error **errp)
+{
+    ERRP_GUARD();
+    size_t page = rb_offset / qemu_target_page_size();
+    size_t read;
+
+    if (test_bit(page, rb->file_bmap)) {
+        /*
+         * This can happen concurrently, but it's thread-safe because
+         * qemu_get_buffer_at() is thread-safe, and the caller will be using
+         * different temporary buffers.
+         */
+        read =
+            qemu_get_buffer_at(mis->from_src_file, buf, qemu_target_page_size(),
+                               rb->pages_offset + rb_offset, errp);
+
+        if (read != qemu_target_page_size()) {
+            error_prepend(errp,
+                          "Could not read page %zu from RAM Block %s: ", page,
+                          rb->idstr);
+            return false;
+        }
+    } else {
+        memset(buf, '\0', qemu_target_page_size());
+    }
+    return true;
+}
+
+/**
+ * postcopy_mapped_ram_load_page() - Load pages required to access host address.
+ * @mis: Migration Incoming State.
+ * @rb: RAMBlock from where page is loaded.
+ * @rb_offset: Offset of target page in RAMBlock.
+ * @haddr: Base of target page where to load in page.
+ * @channel: Used to identify between threads and use corresponding temp.
+ * @errp: Set error in case of failure
+ *
+ * Load page(s) from RAMBlock covering the faulting address. We might need to
+ * load multiple pages in the case when host page size is greater than guest
+ * page size. As userfaultfd works on granularity of host pages, we might need
+ * to load guest pages in single operation.
+ *
+ * Return: True on success.
+ */
+static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
+                                          RAMBlock *rb, ram_addr_t rb_offset,
+                                          uint64_t haddr, int channel,
+                                          Error **errp)
+{
+    void *place_source = mis->postcopy_tmp_pages[channel].tmp_huge_page;
+    char *buffer_ptr = (char *)place_source;
+    size_t guest_pages_to_load =
+        MAX(1, qemu_ram_pagesize(rb) / qemu_target_page_size());
+    size_t guest_page;
+    size_t host_page;
+
+    /*
+     * If guest page size is greater than host page size uffd needs to load one
+     * guest page and multiple host pages, hence the offsets need to aligned
+     * with guest pages (which is automatically aligned with host pages). In the
+     * same case we need to check range of bits on pending_bmap(bit per host
+     * page) to decide whether all the page have been loaded.
+     *
+     * NOTE: This is future proofing as currently target page size greater than
+     * host page size is not supported. However if postcopy does support this in
+     * future, with updated place page functions this function should work
+     * readily.
+     */
+    rb_offset = ROUND_DOWN(rb_offset, qemu_target_page_size());
+    haddr = ROUND_DOWN(haddr, qemu_target_page_size());
+    guest_page = rb_offset >> qemu_target_page_bits();
+    host_page = rb_offset / qemu_ram_pagesize(rb);
+
+    /*
+     * pending_bmap needs the index of host or guest page based on which is
+     * larger. As page index is inversely proportional to page size we use the
+     * minimum of both.
+     */
+    if (bitmap_test_and_clear_atomic(rb->pending_bmap,
+                                     MIN(host_page, guest_page), 1)) {
+        if (find_next_bit(rb->file_bmap, guest_page + guest_pages_to_load,
+                          guest_page) == guest_page + guest_pages_to_load) {
+            /* It is efficient to use UFFDIO_ZERO if all pages are zero */
+            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
+                error_setg(errp,
+                           "Failed to place zero page %zu from RAM Block %s at "
+                           "address %" PRIu64,
+                           guest_page, rb->idstr, haddr);
+                return false;
+            }
+        } else {
+            size_t load_size = guest_pages_to_load * qemu_target_page_size();
+            size_t offset;
+
+            for (offset = 0; offset < load_size;
+                 offset += qemu_target_page_size()) {
+                if (!postcopy_mapped_ram_load_guest_page(
+                        mis, rb, rb_offset + offset, buffer_ptr + offset,
+                        errp)) {
+                    return false;
+                }
+            }
+
+            if (postcopy_place_page(mis, (void *)haddr, place_source, rb)) {
+                error_setg(errp,
+                           "Failed to place page %zu from RAM Block %s at "
+                           "address %" PRIu64,
+                           guest_page, rb->idstr, haddr);
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
 /*
  * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
  * also optional: when zero is provided, the fault accounting will be ignored.
@@ -1308,6 +1432,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     int ret;
     size_t index;
     RAMBlock *rb = NULL;
+    Error *local_err = NULL;
 
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
@@ -1349,11 +1474,13 @@ static void *postcopy_ram_fault_thread(void *opaque)
             break;
         }
 
-        if (!mis->to_src_file) {
+        if (!migrate_mapped_ram() && !mis->to_src_file) {
             /*
-             * Possibly someone tells us that the return path is
-             * broken already using the event. We should hold until
-             * the channel is rebuilt.
+             * Possibly someone tells us that the return path is broken already
+             * using the event. We should hold until the channel is rebuilt.
+             * Fast snapshot load doesn't support pause and recover, because
+             * it's not necessary: we can fail right away when QEMU just booted
+             * with nothing to lose.
              */
             postcopy_pause_fault_thread(mis);
         }
@@ -1416,18 +1543,37 @@ static void *postcopy_ram_fault_thread(void *opaque)
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset,
                                                 msg.arg.pagefault.feat.ptid);
+
+            if (migrate_mapped_ram()) {
+                /* Load page directly in case of fast snapshot load */
+
+                uintptr_t aligned = (uintptr_t)ROUND_DOWN(
+                    msg.arg.pagefault.address, qemu_ram_pagesize(rb));
+
+                if (try_mark_postcopy_blocktime_begin(
+                        mis, rb, rb_offset, (uintptr_t)aligned,
+                        msg.arg.pagefault.feat.ptid)) {
+                    if (!postcopy_mapped_ram_load_page(
+                            mis, rb, rb_offset, aligned, RAM_CHANNEL_POSTCOPY,
+                            &local_err)) {
+                        error_report_err(local_err);
+                        break;
+                    }
+                }
+            } else {
 retry:
-            /*
-             * Send the request to the source - we want to request one
-             * of our host page sizes (which is >= TPS)
-             */
-            ret = postcopy_request_page(mis, rb, rb_offset,
-                                        msg.arg.pagefault.address,
-                                        msg.arg.pagefault.feat.ptid);
-            if (ret) {
-                /* May be network failure, try to wait for recovery */
-                postcopy_pause_fault_thread(mis);
-                goto retry;
+                /*
+                 * Send the request to the source - we want to request one
+                 * of our host page sizes (which is >= TPS)
+                 */
+                ret = postcopy_request_page(mis, rb, rb_offset,
+                                            msg.arg.pagefault.address,
+                                            msg.arg.pagefault.feat.ptid);
+                if (ret) {
+                    /* May be network failure, try to wait for recovery */
+                    postcopy_pause_fault_thread(mis);
+                    goto retry;
+                }
             }
         }
 
@@ -1499,8 +1645,11 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis, Error **errp)
     unsigned i, channels;
     void *temp_page;
 
-    if (migrate_postcopy_preempt()) {
-        /* If preemption enabled, need extra channel for urgent requests */
+    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
+        /*
+         * If preemption enabled or it is fast snapshot load, need extra channel
+         * for urgent requests/faults
+         */
         mis->postcopy_channels = RAM_CHANNEL_MAX;
     } else {
         /* Both precopy/postcopy on the same channel */
-- 
2.53.0


