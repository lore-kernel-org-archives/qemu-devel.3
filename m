Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18433ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfL9-0000os-V5; Mon, 09 Sep 2024 10:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfL8-0000fc-3P
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:02 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfL6-0004TR-0T
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:01 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7b8884631c4so2063179a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891958; x=1726496758;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVk80rEdIzOmBvs0atZRrFtqRDrxfejNxURYXwd1kcM=;
 b=XkCWhf1c1QSG2/F6I7U7UhCOlEhmETHg00CdzlFZxFuTaJYgUVP8e0ewiRtpOYC+PX
 MduPwTe8J8iZPoXsWvJGM+45oW0U/k/Q6dZA1qkG4FssFudxqKIPRtjr2iiMJZ7jCxby
 6bcFI4xZGpFhpeUQ0jzL2/pqorJZTTVyFYWGEDzrNxxL4oUUj8WC5b5zl+LopGVAimag
 /bQV6FDddC/QhnbvFXInogf1udUNmhNYOcdo6dhI7UKtQAw2AP1UcSujGjacUraFrWOO
 OV1PGjUB4NgMk4sBlOmSb4SuKbGFWD9Ix9rFAdE514evAcChfVILn1R9JpsBxf9AdS0X
 9D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891958; x=1726496758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVk80rEdIzOmBvs0atZRrFtqRDrxfejNxURYXwd1kcM=;
 b=AV89oCU3Mtf5hKepcyu+I1ld3nPQ8ShT/aacesHH9Lb+23qW9hOqQMy5i4S+QRwaXT
 1F9YfeR39hw0HswitH0lYQLP+eGz6Yhu0jBWiGcNnUtLlXyGd5FrR9XOaxAMH5ys5gQ/
 YvMqvL9BHaMT3nv8PDxp8KuLRSACagQvng5uKk6hJZiUXL792cxOkx2LkfnjKKbhGkgo
 fppu7IOIQ4Y91phCJ1glEm5boE0S+dsZ4BEAKfo5dt32j5dB9vYFQuWp5sI2AqFD8/5I
 09/D/JNf3JOxP9Uk/uCAqvxlKqWgB6Qnye8M4Oeva2KlAuyBQ8JcFE7QOpa2oVioNjNa
 MeJQ==
X-Gm-Message-State: AOJu0YwR11HnrRalKEjeS7hv5zwTjMqsaXDlC4hmn/c1PeboKmIkoerU
 S5CuCSfaYNXmlIA9g5HtX6Z5xUPUgpjm/zwuqhJIPjI4E3z9Zw/leF+jZxKv9XrdzvAnLWYsOJa
 jAtqsUw==
X-Google-Smtp-Source: AGHT+IH0b9iAa+5uGsRzRkUT07ozgShtleqSF/hJslwjR5dy0x/GT7PDQ5UV25wQpjRaEYmjN1qZMQ==
X-Received: by 2002:a05:6a21:2d84:b0:1cf:337e:9920 with SMTP id
 adf61e73a8af0-1cf337ecfd3mr10061661637.47.1725891957579; 
 Mon, 09 Sep 2024 07:25:57 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:25:57 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 02/10] migration: Refine util functions to support
 periodic CPU throttle
Date: Mon,  9 Sep 2024 22:25:35 +0800
Message-Id: <83f9756eb21e21300ced2bf77fdb3585a918f05e.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Supply the migration_bitmap_sync function along with a periodic
argument. Introduce the sync_mode global variable to track the
sync mode and support periodic throttling while keeping backward
compatibility.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 include/exec/ram_addr.h | 107 +++++++++++++++++++++++++++++++++++++---
 migration/ram.c         |  49 ++++++++++++++----
 2 files changed, 140 insertions(+), 16 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 891c44cf2d..7df926ed96 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -472,17 +472,68 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
     cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_CODE);
 }
 
+static void ramblock_clear_iter_bmap(RAMBlock *rb,
+                                     ram_addr_t start,
+                                     ram_addr_t length)
+{
+    ram_addr_t addr;
+    unsigned long *bmap = rb->bmap;
+    unsigned long *shadow_bmap = rb->shadow_bmap;
+    unsigned long *iter_bmap = rb->iter_bmap;
+
+    for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
+        long k = (start + addr) >> TARGET_PAGE_BITS;
+        if (test_bit(k, shadow_bmap) && !test_bit(k, bmap)) {
+            /* Page has been sent, clear the iter bmap */
+            clear_bit(k, iter_bmap);
+        }
+    }
+}
+
+static void ramblock_update_iter_bmap(RAMBlock *rb,
+                                      ram_addr_t start,
+                                      ram_addr_t length)
+{
+    ram_addr_t addr;
+    unsigned long *bmap = rb->bmap;
+    unsigned long *iter_bmap = rb->iter_bmap;
+
+    for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
+        long k = (start + addr) >> TARGET_PAGE_BITS;
+        if (test_bit(k, iter_bmap)) {
+            if (!test_bit(k, bmap)) {
+                set_bit(k, bmap);
+                rb->iter_dirty_pages++;
+            }
+        }
+    }
+}
 
 /* Called with RCU critical section */
 static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                ram_addr_t start,
-                                               ram_addr_t length)
+                                               ram_addr_t length,
+                                               unsigned int flag)
 {
     ram_addr_t addr;
     unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
+    unsigned long *shadow_bmap = rb->shadow_bmap;
+    unsigned long *iter_bmap = rb->iter_bmap;
+
+    assert(flag && !(flag & (~RAMBLOCK_SYN_MASK)));
+
+    /*
+     * We must remove the sent dirty page from the iter_bmap in order to
+     * minimize redundant page transfers if periodic sync has appeared
+     * during this iteration.
+     */
+    if (rb->periodic_sync_shown_up &&
+        (flag & (RAMBLOCK_SYN_MODERN_ITER | RAMBLOCK_SYN_MODERN_PERIOD))) {
+        ramblock_clear_iter_bmap(rb, start, length);
+    }
 
     /* start address and length is aligned at the start of a word? */
     if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
@@ -503,8 +554,20 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
             if (src[idx][offset]) {
                 unsigned long bits = qatomic_xchg(&src[idx][offset], 0);
                 unsigned long new_dirty;
+                if (flag & (RAMBLOCK_SYN_MODERN_ITER |
+                            RAMBLOCK_SYN_MODERN_PERIOD)) {
+                    /* Back-up bmap for the next iteration */
+                    iter_bmap[k] |= bits;
+                    if (flag == RAMBLOCK_SYN_MODERN_PERIOD) {
+                        /* Back-up bmap to detect pages has been sent */
+                        shadow_bmap[k] = dest[k];
+                    }
+                }
                 new_dirty = ~dest[k];
-                dest[k] |= bits;
+                if (flag == RAMBLOCK_SYN_LEGACY_ITER) {
+                    dest[k] |= bits;
+                }
+
                 new_dirty &= bits;
                 num_dirty += ctpopl(new_dirty);
             }
@@ -534,18 +597,50 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         ram_addr_t offset = rb->offset;
 
         for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
-            if (cpu_physical_memory_test_and_clear_dirty(
+            bool dirty = false;
+            long k = (start + addr) >> TARGET_PAGE_BITS;
+            if (flag == RAMBLOCK_SYN_MODERN_PERIOD) {
+                if (test_bit(k, dest)) {
+                    /* Back-up bmap to detect pages has been sent */
+                    set_bit(k, shadow_bmap);
+                }
+            }
+
+            dirty = cpu_physical_memory_test_and_clear_dirty(
                         start + addr + offset,
                         TARGET_PAGE_SIZE,
-                        DIRTY_MEMORY_MIGRATION)) {
-                long k = (start + addr) >> TARGET_PAGE_BITS;
-                if (!test_and_set_bit(k, dest)) {
+                        DIRTY_MEMORY_MIGRATION);
+
+            if (flag == RAMBLOCK_SYN_LEGACY_ITER) {
+                if (dirty && !test_and_set_bit(k, dest)) {
                     num_dirty++;
                 }
+            } else {
+                if (dirty) {
+                    if (!test_bit(k, dest)) {
+                        num_dirty++;
+                    }
+                    /* Back-up bmap for the next iteration */
+                    set_bit(k, iter_bmap);
+                }
             }
         }
     }
 
+    /*
+     * We have to re-fetch dirty pages from the iter_bmap one by one.
+     * It's possible that not all of the dirty pages that meant to
+     * send in the current iteration are included in the bitmap
+     * that the current sync retrieved from the KVM.
+     */
+    if (flag == RAMBLOCK_SYN_MODERN_ITER) {
+        ramblock_update_iter_bmap(rb, start, length);
+    }
+
+    if (flag == RAMBLOCK_SYN_MODERN_PERIOD) {
+        rb->periodic_sync_shown_up = true;
+    }
+
     return num_dirty;
 }
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index f29faa82d6..a56634eb46 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -112,6 +112,8 @@
 
 XBZRLECacheStats xbzrle_counters;
 
+static RAMBlockSynMode sync_mode = RAMBLOCK_SYN_LEGACY;
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* The migration channel used for a specific host page */
@@ -912,13 +914,38 @@ bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start)
     return false;
 }
 
+static void ramblock_reset_iter_stats(RAMBlock *rb)
+{
+    bitmap_clear(rb->shadow_bmap, 0, rb->used_length >> TARGET_PAGE_BITS);
+    bitmap_clear(rb->iter_bmap, 0, rb->used_length >> TARGET_PAGE_BITS);
+    rb->iter_dirty_pages = 0;
+    rb->periodic_sync_shown_up = false;
+}
+
 /* Called with RCU critical section */
-static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb)
+static void ramblock_sync_dirty_bitmap(RAMState *rs,
+                                       RAMBlock *rb,
+                                       bool periodic)
 {
-    uint64_t new_dirty_pages =
-        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length);
+    uint64_t new_dirty_pages;
+    unsigned int flag = RAMBLOCK_SYN_LEGACY_ITER;
+
+    if (sync_mode == RAMBLOCK_SYN_MODERN) {
+        flag = periodic ? RAMBLOCK_SYN_MODERN_PERIOD : RAMBLOCK_SYN_MODERN_ITER;
+    }
+
+    new_dirty_pages =
+        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length, flag);
+
+    if (flag & (RAMBLOCK_SYN_LEGACY_ITER | RAMBLOCK_SYN_MODERN_ITER)) {
+        if (flag == RAMBLOCK_SYN_LEGACY_ITER) {
+            rs->migration_dirty_pages += new_dirty_pages;
+        } else {
+            rs->migration_dirty_pages += rb->iter_dirty_pages;
+            ramblock_reset_iter_stats(rb);
+        }
+    }
 
-    rs->migration_dirty_pages += new_dirty_pages;
     rs->num_dirty_pages_period += new_dirty_pages;
 }
 
@@ -1041,7 +1068,9 @@ static void migration_trigger_throttle(RAMState *rs)
     }
 }
 
-static void migration_bitmap_sync(RAMState *rs, bool last_stage)
+static void migration_bitmap_sync(RAMState *rs,
+                                  bool last_stage,
+                                  bool periodic)
 {
     RAMBlock *block;
     int64_t end_time;
@@ -1058,7 +1087,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
     WITH_QEMU_LOCK_GUARD(&rs->bitmap_mutex) {
         WITH_RCU_READ_LOCK_GUARD() {
             RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-                ramblock_sync_dirty_bitmap(rs, block);
+                ramblock_sync_dirty_bitmap(rs, block, periodic);
             }
             stat64_set(&mig_stats.dirty_bytes_last_sync, ram_bytes_remaining());
         }
@@ -1101,7 +1130,7 @@ static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
         local_err = NULL;
     }
 
-    migration_bitmap_sync(rs, last_stage);
+    migration_bitmap_sync(rs, last_stage, false);
 
     if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
         error_report_err(local_err);
@@ -2594,7 +2623,7 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
     RCU_READ_LOCK_GUARD();
 
     /* This should be our last sync, the src is now paused */
-    migration_bitmap_sync(rs, false);
+    migration_bitmap_sync(rs, false, false);
 
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
@@ -3581,7 +3610,7 @@ void colo_incoming_start_dirty_log(void)
     memory_global_dirty_log_sync(false);
     WITH_RCU_READ_LOCK_GUARD() {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-            ramblock_sync_dirty_bitmap(ram_state, block);
+            ramblock_sync_dirty_bitmap(ram_state, block, false);
             /* Discard this dirty bitmap record */
             bitmap_zero(block->bmap, block->max_length >> TARGET_PAGE_BITS);
         }
@@ -3862,7 +3891,7 @@ void colo_flush_ram_cache(void)
     qemu_mutex_lock(&ram_state->bitmap_mutex);
     WITH_RCU_READ_LOCK_GUARD() {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-            ramblock_sync_dirty_bitmap(ram_state, block);
+            ramblock_sync_dirty_bitmap(ram_state, block, false);
         }
     }
 
-- 
2.39.1


