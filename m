Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FA4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s8G-0001vD-SB; Wed, 01 Oct 2025 04:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s8D-0001pk-DK
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7K-0006Ks-Um
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso5197655e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306987; x=1759911787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YB31f3SnOrBT6zoXspLyOSupGu2zupb4dG+i3+hnw94=;
 b=GNBfCP3VkgSnsKfKAh7/nAG/pS0Pw3IJ19F2hzl8QqvJ3wJm6JYIlgmQbLlbThdjPx
 1WdtUKtONnxh+YYH2yyvlYCII0jImelrz6BhAEt75JO+xSkeIsvwPHizYxVwAgwvnfVf
 Z7VMJxEs/FZC/Qn9EsxRIutgqnVvk6iZqypzYpsXLtd7bu1q4vkLjwlvke5W0fWX8OEJ
 a41TtU3quGKD+jl0wrYnC+JcgvYIwfAUcml0uSR6AqXT4uCxRNrw8I58D0eQnIMMQOVS
 HxVVJhqwbOPF2y6TGtC56DtN9eGtVhYWk0l1zzS/VfSn+jaE5z/KupyoDdaU9qbIuuLH
 EZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306987; x=1759911787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YB31f3SnOrBT6zoXspLyOSupGu2zupb4dG+i3+hnw94=;
 b=RwP71ZtGXkDQQ5ssYPFM+8e7/oKywMu7gB+0piF8TtlB3wyTew2pcusfdMU0FPlImy
 nUX6lcwA9JNCSkeyB6Hb5ebSCwz0f+1n9kNgQT9hZ2b6C6WEKnXsh3klbjYbawsiDjLl
 uJWvS9EUwMOj0ddPPtUnyjuuN3+sBwj2IZkOf+3KvbNIQbSg327md7VCAkRBG/C0+qT/
 NQlWbgCqcmGxb1hx/22V9b7pNMDcwbJZRSdivr14hPudHtLa/8dUYV4a1SxkeWhGQYDx
 aWPyEeYJXCEqbjWqjn+YD43YBpdZQlAifwz5t9glGY481Naj3zfW8GR/SSQeSbLCOYIj
 kPQw==
X-Gm-Message-State: AOJu0Yxocplln6mlZrhGHaJ2w/bPeolNH9S84Bi5hVXHuneQ4P4ueZLv
 wnp/vPsS0dbJfUEAiuBGrgK8OX2dDh5VO9LLlwIUd+P4BvittpsYmOsgoWnDO+ePfk+aUjd/HBx
 e0xQo1wn0pA==
X-Gm-Gg: ASbGncs0vPFmitklCkEj5g5tv3wF+X98ga8pgnA6UxLkCN+LsZZ+V7+g01n4YVgT76b
 +7NgYK97dGz9HVmhvoLH8IU//L1CbcziNA7zBgD8k+PaoqRliW1ETk3UT5lg+b922+y9WcgMBQR
 h1AmokGJc1pul7mSpT0Ik+nqLV/oIvy1xQi83sdn2tfhYgIhRbKPILA2haRoAg/NGcmu5ZDSNms
 gCB1zOfwcnEqMsMEqkIwRPK425AcY5iBztGAACHsyEN1ikiJIalBLFEFvKxqg5nn6FoK8Xmdmg6
 Ka+Fkmp4TrhwNYiSSpJRmTreUBvi+EdxLzQ8Ak+wA/aDr9VoTwZ5dFfJY8wSPB5lwdRRR59CrIi
 E4lmnlVB0TgphCn8SLxKLKVR1k/dEB84dvJy2jxY1Fil8pVV0NuJgqoLW1mH56v02lwaNaJn1dT
 C53+X99PbDRSRvbrdMFJJb
X-Google-Smtp-Source: AGHT+IGA97ouW7V3aI0vwlChFMcdiXoAwJP/OMRCztYRqvbyZTrDJjFM6Ab9EV4QJLzzmgUJhI7sUA==
X-Received: by 2002:a05:600c:a407:b0:46e:28cc:e56f with SMTP id
 5b1f17b1804b1-46e58abdf61mr62230685e9.6.1759306986862; 
 Wed, 01 Oct 2025 01:23:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b5f3015sm32174185e9.1.2025.10.01.01.23.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:23:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 18/25] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_lebitmap()
Date: Wed,  1 Oct 2025 10:21:18 +0200
Message-ID: <20251001082127.65741-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Remove the now unneeded "system/xen.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 103 +------------------------------------
 system/physmem.c          | 105 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 102 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 6377dd19a2f..4c227fee412 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -19,7 +19,6 @@
 #ifndef SYSTEM_RAM_ADDR_H
 #define SYSTEM_RAM_ADDR_H
 
-#include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
@@ -156,115 +155,15 @@ void cpu_physical_memory_set_dirty_range(ram_addr_t addr, ram_addr_t length,
                                          uint8_t mask);
 
 #if !defined(_WIN32)
-
 /*
  * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
  * the number of dirty pages in @bitmap passed as argument. On the other hand,
  * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
  * weren't set in the global migration bitmap.
  */
-static inline
 uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t start,
-                                                ram_addr_t pages)
-{
-    unsigned long i, j;
-    unsigned long page_number, c, nbits;
-    hwaddr addr;
-    ram_addr_t ram_addr;
-    uint64_t num_dirty = 0;
-    unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
-    unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
-    unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
-
-    /* start address is aligned at the start of a word? */
-    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) &&
-        (hpratio == 1)) {
-        unsigned long **blocks[DIRTY_MEMORY_NUM];
-        unsigned long idx;
-        unsigned long offset;
-        long k;
-        long nr = BITS_TO_LONGS(pages);
-
-        idx = (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
-        offset = BIT_WORD((start >> TARGET_PAGE_BITS) %
-                          DIRTY_MEMORY_BLOCK_SIZE);
-
-        WITH_RCU_READ_LOCK_GUARD() {
-            for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
-                blocks[i] =
-                    qatomic_rcu_read(&ram_list.dirty_memory[i])->blocks;
-            }
-
-            for (k = 0; k < nr; k++) {
-                if (bitmap[k]) {
-                    unsigned long temp = leul_to_cpu(bitmap[k]);
-
-                    nbits = ctpopl(temp);
-                    qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
-
-                    if (global_dirty_tracking) {
-                        qatomic_or(
-                                &blocks[DIRTY_MEMORY_MIGRATION][idx][offset],
-                                temp);
-                        if (unlikely(
-                            global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                            total_dirty_pages += nbits;
-                        }
-                    }
-
-                    num_dirty += nbits;
-
-                    if (tcg_enabled()) {
-                        qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
-                                   temp);
-                    }
-                }
-
-                if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
-                    offset = 0;
-                    idx++;
-                }
-            }
-        }
-
-        if (xen_enabled()) {
-            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
-        }
-    } else {
-        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
-
-        if (!global_dirty_tracking) {
-            clients &= ~(1 << DIRTY_MEMORY_MIGRATION);
-        }
-
-        /*
-         * bitmap-traveling is faster than memory-traveling (for addr...)
-         * especially when most of the memory is not dirty.
-         */
-        for (i = 0; i < len; i++) {
-            if (bitmap[i] != 0) {
-                c = leul_to_cpu(bitmap[i]);
-                nbits = ctpopl(c);
-                if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
-                    total_dirty_pages += nbits;
-                }
-                num_dirty += nbits;
-                do {
-                    j = ctzl(c);
-                    c &= ~(1ul << j);
-                    page_number = (i * HOST_LONG_BITS + j) * hpratio;
-                    addr = page_number * TARGET_PAGE_SIZE;
-                    ram_addr = start + addr;
-                    cpu_physical_memory_set_dirty_range(ram_addr,
-                                       TARGET_PAGE_SIZE * hpratio, clients);
-                } while (c != 0);
-            }
-        }
-    }
-
-    return num_dirty;
-}
+                                                ram_addr_t pages);
 #endif /* not _WIN32 */
 
 static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
diff --git a/system/physmem.c b/system/physmem.c
index 383aecb391f..e78ca410ebf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1208,6 +1208,111 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
     return false;
 }
 
+#if !defined(_WIN32)
+uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+                                                ram_addr_t start,
+                                                ram_addr_t pages)
+{
+    unsigned long i, j;
+    unsigned long page_number, c, nbits;
+    hwaddr addr;
+    ram_addr_t ram_addr;
+    uint64_t num_dirty = 0;
+    unsigned long len = (pages + HOST_LONG_BITS - 1) / HOST_LONG_BITS;
+    unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
+    unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
+
+    /* start address is aligned at the start of a word? */
+    if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) &&
+        (hpratio == 1)) {
+        unsigned long **blocks[DIRTY_MEMORY_NUM];
+        unsigned long idx;
+        unsigned long offset;
+        long k;
+        long nr = BITS_TO_LONGS(pages);
+
+        idx = (start >> TARGET_PAGE_BITS) / DIRTY_MEMORY_BLOCK_SIZE;
+        offset = BIT_WORD((start >> TARGET_PAGE_BITS) %
+                          DIRTY_MEMORY_BLOCK_SIZE);
+
+        WITH_RCU_READ_LOCK_GUARD() {
+            for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
+                blocks[i] =
+                    qatomic_rcu_read(&ram_list.dirty_memory[i])->blocks;
+            }
+
+            for (k = 0; k < nr; k++) {
+                if (bitmap[k]) {
+                    unsigned long temp = leul_to_cpu(bitmap[k]);
+
+                    nbits = ctpopl(temp);
+                    qatomic_or(&blocks[DIRTY_MEMORY_VGA][idx][offset], temp);
+
+                    if (global_dirty_tracking) {
+                        qatomic_or(
+                                &blocks[DIRTY_MEMORY_MIGRATION][idx][offset],
+                                temp);
+                        if (unlikely(
+                            global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
+                            total_dirty_pages += nbits;
+                        }
+                    }
+
+                    num_dirty += nbits;
+
+                    if (tcg_enabled()) {
+                        qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
+                                   temp);
+                    }
+                }
+
+                if (++offset >= BITS_TO_LONGS(DIRTY_MEMORY_BLOCK_SIZE)) {
+                    offset = 0;
+                    idx++;
+                }
+            }
+        }
+
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
+    } else {
+        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL
+                                        : DIRTY_CLIENTS_NOCODE;
+
+        if (!global_dirty_tracking) {
+            clients &= ~(1 << DIRTY_MEMORY_MIGRATION);
+        }
+
+        /*
+         * bitmap-traveling is faster than memory-traveling (for addr...)
+         * especially when most of the memory is not dirty.
+         */
+        for (i = 0; i < len; i++) {
+            if (bitmap[i] != 0) {
+                c = leul_to_cpu(bitmap[i]);
+                nbits = ctpopl(c);
+                if (unlikely(global_dirty_tracking & GLOBAL_DIRTY_DIRTY_RATE)) {
+                    total_dirty_pages += nbits;
+                }
+                num_dirty += nbits;
+                do {
+                    j = ctzl(c);
+                    c &= ~(1ul << j);
+                    page_number = (i * HOST_LONG_BITS + j) * hpratio;
+                    addr = page_number * TARGET_PAGE_SIZE;
+                    ram_addr = start + addr;
+                    cpu_physical_memory_set_dirty_range(ram_addr,
+                                       TARGET_PAGE_SIZE * hpratio, clients);
+                } while (c != 0);
+            }
+        }
+    }
+
+    return num_dirty;
+}
+#endif /* not _WIN32 */
+
 static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
                             uint16_t section);
 static subpage_t *subpage_init(FlatView *fv, hwaddr base);
-- 
2.51.0


