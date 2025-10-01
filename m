Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B959CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v414i-0003w7-3S; Wed, 01 Oct 2025 13:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v414g-0003si-CG
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:10 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413x-0001Fy-6m
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:09 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so438695e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341378; x=1759946178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ar/b+bK1CSPAd2CXY5znM+31a+2uIsWNME5ALfig9VE=;
 b=R9S3wdAEC7AZWYkmpsb6UmQNqKq4ggBaw5vQQIRGEDbmhdJzKTNm4bg8OOyAh9CTdV
 ggwCvHfe71ng7pHl5xLlmtqnMaJfbODdjUzwEa952DgwnjLtXiG5sFp4VgQbxtUIWU+Z
 AhqjSErw9RML461LoMpiFnl9YWkXyAo9OTZiFwL94rWteY+4mnQdMH6GzJQY7qAfRpoY
 U1p1b+QBxo1kHz2tl3cc5vG0tcZsO1jBCbE637Fk3yLG8/OlX+m2/S/6Ipia/5GLLR0W
 TAt8cllpYdtMr27xQ1D3+MKRRyX2Q8mK9IM6jc3mv0975qPiG2a5WHvDl4UKG9wcWrDk
 62Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341378; x=1759946178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar/b+bK1CSPAd2CXY5znM+31a+2uIsWNME5ALfig9VE=;
 b=g2VvQ9gVGo8prcaqj+xbEEPzzdOjuT/0ptX5m203HbeyRMNyY2VOKVtnbeWNy8gAFC
 Z+bWPwj9evpfSFPfSotuz2/IVXVJy0DTxnP9mlFH9bCmmT5jeL+BbQ/PmOeSkGEUJiud
 WHx6xjlbO8DdzTjz640qJBvyOgf46Z83nfEBJDZCv2EAjKiKGSU+Lwy2CskoQVQ5WwC/
 xXb83B/cYSFZLVKk5VgkklHlqiyyvzB7r4aoL2wSHEUwr78OOo6az2Y7ZyACOdbSrd8b
 uXwYosK+tIDzz3HEWSva8cNw1SSxTGbBI+/9bUWmMAdM8CvIR63NdQCdPArDVE2+shft
 TjQA==
X-Gm-Message-State: AOJu0Yyivl7QvO07sygkeRw0QNU9IB5lAUboag17H+Vo2Ad8UhD2X9Xz
 5ErBqss5dT7dC0zKvHt3EH4VY0dV0XW+m99UuqNgNM5wH1oI9UHy0MSxces2LJaaJ00pYKfZ33D
 smMbbOKb0Mw==
X-Gm-Gg: ASbGncuH06oGeX2aKQCf7PhdRLH8lDImDSCsdiwAT9woaC70uXz+/zO9ycXt0KgIegB
 lPVby9TwHqy07MgKupJ1RYq8uZDzTmNNWMzIXmIpjE/SnkYlyvcBR8E5d7ZDVH7ZnE68nRxSn1K
 aWbB+sUoo1SQ5mVWPhfLTWbNJDM/hfJ3k8ZVWIt3fqz86VuDb6GBR5FQqC61x+atz+TWuygdg3K
 gmQE5ifN6tLWhUL0EpDMGIqmWst7J99U4v+CcREWg56ZjqQMU+iTRCf4nBv1G9KVO6C2PoMKVRR
 m/ma/DUU3CgCk6dJzfcOi1UJ4ide7qA6ZkSlPei5pksKJAKf/ZctalUqUe1pwBU+QwF89cRTqla
 BJjna0ya3vGokt3vO+XIi75Nko/P5sHNAGZB9In5bmR000ArCPX7m9FGmUMQN4RxWDGQZoasN/3
 oeJYwikm/7QbvUUNwwlpJ/kWDbfQ==
X-Google-Smtp-Source: AGHT+IERukjStncMk1gDcNpcolRRiTogPxU99MO+79Bne2LwCSx50cvJQBnkGCm97vg0ybGvoBoNUw==
X-Received: by 2002:a05:600c:c3c1:b0:46d:c045:d2bd with SMTP id
 5b1f17b1804b1-46e68bbaf6dmr2559775e9.8.1759341377590; 
 Wed, 01 Oct 2025 10:56:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4b71sm88706f8f.57.2025.10.01.10.56.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:56:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 16/18] system/physmem: Reduce
 cpu_physical_memory_sync_dirty_bitmap() scope
Date: Wed,  1 Oct 2025 19:54:45 +0200
Message-ID: <20251001175448.18933-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

cpu_physical_memory_sync_dirty_bitmap() is now only called within
system/physmem.c, by ramblock_sync_dirty_bitmap(). Reduce its scope
by making it internal to this file. Since it doesn't involve any CPU,
remove the 'cpu_' prefix.
Remove the now unneeded "qemu/rcu.h" and "system/memory.h" headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h | 79 ---------------------------------------
 migration/ram.c           | 77 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 80 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index cafd258580e..d2d088bbea6 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -21,10 +21,7 @@
 
 #include "exec/ramlist.h"
 #include "system/ramblock.h"
-#include "system/memory.h"
 #include "exec/target_page.h"
-#include "qemu/rcu.h"
-
 #include "exec/hwaddr.h"
 
 extern uint64_t total_dirty_pages;
@@ -175,80 +172,4 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
                                             ram_addr_t length);
 
-/* Called with RCU critical section */
-static inline
-uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
-                                               ram_addr_t start,
-                                               ram_addr_t length)
-{
-    ram_addr_t addr;
-    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
-    uint64_t num_dirty = 0;
-    unsigned long *dest = rb->bmap;
-
-    /* start address and length is aligned at the start of a word? */
-    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
-         (start + rb->offset) &&
-        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
-        int k;
-        int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
-        unsigned long * const *src;
-        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
-        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
-                                        DIRTY_MEMORY_BLOCK_SIZE);
-        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
-
-        src = qatomic_rcu_read(
-                &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
-
-        for (k = page; k < page + nr; k++) {
-            if (src[idx][offset]) {
-                unsigned long bits = qatomic_xchg(&src[idx][offset], 0);
-                unsigned long new_dirty;
-                new_dirty = ~dest[k];
-                dest[k] |= bits;
-                new_dirty &= bits;
-                num_dirty += ctpopl(new_dirty);
-            }
-
-            if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
-                offset = 0;
-                idx++;
-            }
-        }
-        if (num_dirty) {
-            cpu_physical_memory_dirty_bits_cleared(start, length);
-        }
-
-        if (rb->clear_bmap) {
-            /*
-             * Postpone the dirty bitmap clear to the point before we
-             * really send the pages, also we will split the clear
-             * dirty procedure into smaller chunks.
-             */
-            clear_bmap_set(rb, start >> TARGET_PAGE_BITS,
-                           length >> TARGET_PAGE_BITS);
-        } else {
-            /* Slow path - still do that in a huge chunk */
-            memory_region_clear_dirty_bitmap(rb->mr, start, length);
-        }
-    } else {
-        ram_addr_t offset = rb->offset;
-
-        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
-            if (cpu_physical_memory_test_and_clear_dirty(
-                        start + addr + offset,
-                        TARGET_PAGE_SIZE,
-                        DIRTY_MEMORY_MIGRATION)) {
-                long k = (start + addr) >> TARGET_PAGE_BITS;
-                if (!test_and_set_bit(k, dest)) {
-                    num_dirty++;
-                }
-            }
-        }
-    }
-
-    return num_dirty;
-}
-
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 91e65be83d8..52bdfec91d9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -935,11 +935,86 @@ bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start)
     return false;
 }
 
+/* Called with RCU critical section */
+static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
+                                                  ram_addr_t start,
+                                                  ram_addr_t length)
+{
+    ram_addr_t addr;
+    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
+    uint64_t num_dirty = 0;
+    unsigned long *dest = rb->bmap;
+
+    /* start address and length is aligned at the start of a word? */
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
+         (start + rb->offset) &&
+        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
+        int k;
+        int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
+        unsigned long * const *src;
+        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
+        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
+                                        DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
+
+        src = qatomic_rcu_read(
+                &ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION])->blocks;
+
+        for (k = page; k < page + nr; k++) {
+            if (src[idx][offset]) {
+                unsigned long bits = qatomic_xchg(&src[idx][offset], 0);
+                unsigned long new_dirty;
+                new_dirty = ~dest[k];
+                dest[k] |= bits;
+                new_dirty &= bits;
+                num_dirty += ctpopl(new_dirty);
+            }
+
+            if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
+                offset = 0;
+                idx++;
+            }
+        }
+        if (num_dirty) {
+            cpu_physical_memory_dirty_bits_cleared(start, length);
+        }
+
+        if (rb->clear_bmap) {
+            /*
+             * Postpone the dirty bitmap clear to the point before we
+             * really send the pages, also we will split the clear
+             * dirty procedure into smaller chunks.
+             */
+            clear_bmap_set(rb, start >> TARGET_PAGE_BITS,
+                           length >> TARGET_PAGE_BITS);
+        } else {
+            /* Slow path - still do that in a huge chunk */
+            memory_region_clear_dirty_bitmap(rb->mr, start, length);
+        }
+    } else {
+        ram_addr_t offset = rb->offset;
+
+        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
+            if (cpu_physical_memory_test_and_clear_dirty(
+                        start + addr + offset,
+                        TARGET_PAGE_SIZE,
+                        DIRTY_MEMORY_MIGRATION)) {
+                long k = (start + addr) >> TARGET_PAGE_BITS;
+                if (!test_and_set_bit(k, dest)) {
+                    num_dirty++;
+                }
+            }
+        }
+    }
+
+    return num_dirty;
+}
+
 /* Called with RCU critical section */
 static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb)
 {
     uint64_t new_dirty_pages =
-        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length);
+        physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length);
 
     rs->migration_dirty_pages += new_dirty_pages;
     rs->num_dirty_pages_period += new_dirty_pages;
-- 
2.51.0


