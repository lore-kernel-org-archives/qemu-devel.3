Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E89D637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOTU-0004Kq-C5; Wed, 13 Nov 2024 20:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSz-0002UB-4s
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:16 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOSs-00030s-GR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:12 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-382185ed80eso43740f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546963; x=1732151763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrMoqQT7ptZYv4vONwORkBwHk59Gl8c3keboGabWJlw=;
 b=EmHH/RB4cbscKOuIkp4PQ/anSMtsJ7Qp/LPAiEqiop9fAYSMrDaovfrmDk/S1vKqbi
 BlgQ7euPpVHhPbMtHHheGpNf/YqdJknzxfPl3IWddy3r1lIbuRGfYO6AESdBNqPp8GPL
 GtySufHfxNeUgOC6pmckgb+17BALWNVkqikDjrL4NGyqXkduga/US5G6ACpmp8N+qzrl
 9aRgELZQsv/l4Cqy3mbKOCEfVK7+HZnOHiQm/yVUC7aLkuPzBl7UQS3uhMFZPsNOlkI1
 a4UICUY90l45hwr16qHJ/cmxreuQk/Yj/UlWuWJCT1k3tjYcGjkj1hVjVjVVH+3qx06I
 Ilkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546963; x=1732151763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrMoqQT7ptZYv4vONwORkBwHk59Gl8c3keboGabWJlw=;
 b=UtSbA+yYfy8J1Lo04r7CeBNullbsidWlH20PIFsEmTJYaRXo+uLLKQVaDf4sXGbQQ9
 Z3oVK1PR1ukTp2LbZWtRIQycf19Fi8O3vQd/2avokGa0lcanMTkEj0Vvk2c50xpXKoMj
 tzLkSFOEspPe2Wj5Ymjb8/NN/iHtEMoM804WTZ2ZMwxhOgC6BPwuG+Kep+nOXvYVW4ng
 eQzFQma+CDBPbzt0WVFzFXHDEATyFGJY8kZeiuQ8H/QJ6FF/vOdvdg2E3OrwOiH3tX4M
 LuRJHMRxtszTD4oUyPWwAGbb5cPJDPwjk+QQ63dEEwfaHiBBAmD0Z8pGjQ8TAlrqgsb8
 8Kaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvfK1c9Fhc0BZQUU/imlY9vmdIVXBY3j49bzb3s3mOkgnTG0EIcSrJG3pRhBCssm+niNDIBkWWkljW@nongnu.org
X-Gm-Message-State: AOJu0YwgsclMjeuvOa5JvYcOFix1ENVhGxFC128qJ1wMdYtTgD0dfUot
 hbFmE0b4OKDicAXNMwo9ps0GIi4dsEfSU+oBQrAY0r+wuszgAqE+1rzW4Lme8qI=
X-Google-Smtp-Source: AGHT+IG2AXes16xthEsOBLXXWXy9qaPlNaK+RVqMME8LkJ1kCx8/uy3WXzn1xFJWGaGToeAaD0oMjg==
X-Received: by 2002:a5d:64e3:0:b0:37d:4ebe:163e with SMTP id
 ffacd0b85a97d-381f188c956mr18915374f8f.53.1731546963319; 
 Wed, 13 Nov 2024 17:16:03 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970713sm20009720f8f.3.2024.11.13.17.15.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:16:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/24] exec: Extract CPU physical memory API to
 'sysemu/physmem-target.h'
Date: Thu, 14 Nov 2024 02:13:06 +0100
Message-ID: <20241114011310.3615-22-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

In order to keep "exec/ram_addr.h" focused on (target
agnostic) methods related to the ram_addr_t type, move
all (target specific) CPU physical memory API to a new
"sysemu/physmem-target.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                       |   1 +
 include/exec/ram_addr.h           | 483 +---------------------------
 include/sysemu/physmem-target.h   | 506 ++++++++++++++++++++++++++++++
 accel/kvm/kvm-all.c               |   1 +
 accel/tcg/cputlb.c                |   1 +
 accel/tcg/translate-all.c         |   1 +
 hw/ppc/spapr.c                    |   1 +
 hw/ppc/spapr_caps.c               |   1 +
 hw/ppc/spapr_pci.c                |   1 +
 hw/remote/memory.c                |   1 +
 hw/remote/proxy-memory-listener.c |   1 +
 hw/s390x/s390-stattrib-kvm.c      |   1 +
 hw/s390x/s390-stattrib.c          |   1 +
 hw/s390x/s390-virtio-ccw.c        |   1 +
 hw/vfio/common.c                  |   1 +
 hw/vfio/container.c               |   1 +
 hw/vfio/iommufd.c                 |   1 +
 hw/vfio/migration.c               |   1 +
 hw/vfio/spapr.c                   |   1 +
 hw/virtio/virtio-mem.c            |   1 +
 migration/ram.c                   |   1 +
 plugins/api.c                     |   1 +
 system/memory.c                   |   1 +
 system/physmem.c                  |   1 +
 target/arm/tcg/mte_helper.c       |   1 +
 target/ppc/kvm.c                  |   1 +
 target/s390x/kvm/kvm.c            |   1 +
 27 files changed, 532 insertions(+), 482 deletions(-)
 create mode 100644 include/sysemu/physmem-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..0027e56fa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3027,6 +3027,7 @@ F: include/exec/memory.h
 F: include/exec/ram_addr.h
 F: include/exec/ramblock.h
 F: include/sysemu/memory_mapping.h
+F: include/sysemu/physmem-target.h
 F: system/dma-helpers.c
 F: system/ioport.c
 F: system/memory.c
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b6d5551549..80f6dc7564 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -20,82 +20,6 @@
 #define RAM_ADDR_H
 
 #ifndef CONFIG_USER_ONLY
-#include "cpu.h"
-#include "sysemu/xen.h"
-#include "sysemu/tcg.h"
-#include "exec/cputlb.h"
-#include "exec/ramlist.h"
-#include "exec/ramblock.h"
-#include "exec/exec-all.h"
-#include "qemu/rcu.h"
-
-extern uint64_t total_dirty_pages;
-
-/**
- * clear_bmap_size: calculate clear bitmap size
- *
- * @pages: number of guest pages
- * @shift: guest page number shift
- *
- * Returns: number of bits for the clear bitmap
- */
-static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
-{
-    return DIV_ROUND_UP(pages, 1UL << shift);
-}
-
-/**
- * clear_bmap_set: set clear bitmap for the page range.  Must be with
- * bitmap_mutex held.
- *
- * @rb: the ramblock to operate on
- * @start: the start page number
- * @size: number of pages to set in the bitmap
- *
- * Returns: None
- */
-static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
-                                  uint64_t npages)
-{
-    uint8_t shift = rb->clear_bmap_shift;
-
-    bitmap_set(rb->clear_bmap, start >> shift, clear_bmap_size(npages, shift));
-}
-
-/**
- * clear_bmap_test_and_clear: test clear bitmap for the page, clear if set.
- * Must be with bitmap_mutex held.
- *
- * @rb: the ramblock to operate on
- * @page: the page number to check
- *
- * Returns: true if the bit was set, false otherwise
- */
-static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
-{
-    uint8_t shift = rb->clear_bmap_shift;
-
-    return bitmap_test_and_clear(rb->clear_bmap, page >> shift, 1);
-}
-
-static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
-{
-    return (b && b->host && offset < b->used_length) ? true : false;
-}
-
-static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
-{
-    assert(offset_in_ramblock(block, offset));
-    return (char *)block->host + offset;
-}
-
-static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
-                                                            RAMBlock *rb)
-{
-    uint64_t host_addr_offset =
-            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
-    return host_addr_offset >> TARGET_PAGE_BITS;
-}
 
 bool ramblock_is_pmem(RAMBlock *rb);
 
@@ -143,411 +67,6 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
 void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
 
-/* Clear whole block of mem */
-static inline void qemu_ram_block_writeback(RAMBlock *block)
-{
-    qemu_ram_msync(block, 0, block->used_length);
-}
+#endif /* CONFIG_USER_ONLY */
 
-#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
-#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
-
-static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
-                                                 ram_addr_t length,
-                                                 unsigned client)
-{
-    DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    bool dirty = false;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
-
-    WITH_RCU_READ_LOCK_GUARD() {
-        blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-
-        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-        base = page - offset;
-        while (page < end) {
-            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-            unsigned long num = next - base;
-            unsigned long found = find_next_bit(blocks->blocks[idx],
-                                                num, offset);
-            if (found < num) {
-                dirty = true;
-                break;
-            }
-
-            page = next;
-            idx++;
-            offset = 0;
-            base += DIRTY_MEMORY_BLOCK_SIZE;
-        }
-    }
-
-    return dirty;
-}
-
-static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
-                                                 ram_addr_t length,
-                                                 unsigned client)
-{
-    DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    bool dirty = true;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
-
-    RCU_READ_LOCK_GUARD();
-
-    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-
-    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-    base = page - offset;
-    while (page < end) {
-        unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-        unsigned long num = next - base;
-        unsigned long found = find_next_zero_bit(blocks->blocks[idx], num, offset);
-        if (found < num) {
-            dirty = false;
-            break;
-        }
-
-        page = next;
-        idx++;
-        offset = 0;
-        base += DIRTY_MEMORY_BLOCK_SIZE;
-    }
-
-    return dirty;
-}
-
-static inline bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr,
-                                                      unsigned client)
-{
-    return cpu_physical_memory_get_dirty(addr, 1, client);
-}
-
-static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
-{
-    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
-    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
-    bool migration =
-        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
-    return !(vga && code && migration);
-}
-
-static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
-                                                               ram_addr_t length,
-                                                               uint8_t mask)
-{
-    uint8_t ret = 0;
-
-    if (mask & (1 << DIRTY_MEMORY_VGA) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
-        ret |= (1 << DIRTY_MEMORY_VGA);
-    }
-    if (mask & (1 << DIRTY_MEMORY_CODE) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
-        ret |= (1 << DIRTY_MEMORY_CODE);
-    }
-    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
-        ret |= (1 << DIRTY_MEMORY_MIGRATION);
-    }
-    return ret;
-}
-
-static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
-                                                      unsigned client)
-{
-    unsigned long page, idx, offset;
-    DirtyMemoryBlocks *blocks;
-
-    assert(client < DIRTY_MEMORY_NUM);
-
-    page = addr >> TARGET_PAGE_BITS;
-    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-
-    RCU_READ_LOCK_GUARD();
-
-    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
-
-    set_bit_atomic(offset, blocks->blocks[idx]);
-}
-
-static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
-                                                       ram_addr_t length,
-                                                       uint8_t mask)
-{
-    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
-    unsigned long end, page;
-    unsigned long idx, offset, base;
-    int i;
-
-    if (!mask && !xen_enabled()) {
-        return;
-    }
-
-    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page = start >> TARGET_PAGE_BITS;
-
-    WITH_RCU_READ_LOCK_GUARD() {
-        for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
-            blocks[i] = qatomic_rcu_read(&ram_list.dirty_memory[i]);
-        }
-
-        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
-        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-        base = page - offset;
-        while (page < end) {
-            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
-
-            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[idx],
-                                  offset, next - page);
-            }
-            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
-                                  offset, next - page);
-            }
-            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
-                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
-                                  offset, next - page);
-            }
-
-            page = next;
-            idx++;
-            offset = 0;
-            base += DIRTY_MEMORY_BLOCK_SIZE;
-        }
-    }
-
-    xen_hvm_modified_memory(start, length);
-}
-
-#if !defined(_WIN32)
-
-/*
- * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
- * the number of dirty pages in @bitmap passed as argument. On the other hand,
- * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
- * weren't set in the global migration bitmap.
- */
-static inline
-uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
-                                                ram_addr_t start,
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
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
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
-#endif /* not _WIN32 */
-
-static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
-                                                          ram_addr_t length)
-{
-    if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
-    }
-
-}
-bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
-                                              ram_addr_t length,
-                                              unsigned client);
-
-DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
-    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
-
-bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
-                                            ram_addr_t start,
-                                            ram_addr_t length);
-
-static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
-                                                         ram_addr_t length)
-{
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_MIGRATION);
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_VGA);
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_CODE);
-}
-
-
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
-#endif
 #endif
diff --git a/include/sysemu/physmem-target.h b/include/sysemu/physmem-target.h
new file mode 100644
index 0000000000..b30c42da60
--- /dev/null
+++ b/include/sysemu/physmem-target.h
@@ -0,0 +1,506 @@
+/*
+ * Declarations for cpu physical memory functions
+ *
+ * Copyright 2011 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *  Avi Kivity <avi@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ *
+ */
+
+/*
+ * This header is for use by exec.c and memory.c ONLY.  Do not include it.
+ * The functions declared here will be removed soon.
+ */
+
+#ifndef RAM_ADDR_TARGET_H
+#define RAM_ADDR_TARGET_H
+
+#include "cpu.h"
+#include "sysemu/xen.h"
+#include "sysemu/tcg.h"
+#include "exec/cputlb.h"
+#include "exec/ram_addr.h"
+#include "exec/ramlist.h"
+#include "exec/ramblock.h"
+#include "qemu/rcu.h"
+
+extern uint64_t total_dirty_pages;
+
+/**
+ * clear_bmap_size: calculate clear bitmap size
+ *
+ * @pages: number of guest pages
+ * @shift: guest page number shift
+ *
+ * Returns: number of bits for the clear bitmap
+ */
+static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
+{
+    return DIV_ROUND_UP(pages, 1UL << shift);
+}
+
+/**
+ * clear_bmap_set: set clear bitmap for the page range.  Must be with
+ * bitmap_mutex held.
+ *
+ * @rb: the ramblock to operate on
+ * @start: the start page number
+ * @size: number of pages to set in the bitmap
+ *
+ * Returns: None
+ */
+static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
+                                  uint64_t npages)
+{
+    uint8_t shift = rb->clear_bmap_shift;
+
+    bitmap_set(rb->clear_bmap, start >> shift, clear_bmap_size(npages, shift));
+}
+
+/**
+ * clear_bmap_test_and_clear: test clear bitmap for the page, clear if set.
+ * Must be with bitmap_mutex held.
+ *
+ * @rb: the ramblock to operate on
+ * @page: the page number to check
+ *
+ * Returns: true if the bit was set, false otherwise
+ */
+static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
+{
+    uint8_t shift = rb->clear_bmap_shift;
+
+    return bitmap_test_and_clear(rb->clear_bmap, page >> shift, 1);
+}
+
+static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
+{
+    return (b && b->host && offset < b->used_length) ? true : false;
+}
+
+static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
+{
+    assert(offset_in_ramblock(block, offset));
+    return (char *)block->host + offset;
+}
+
+static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
+                                                            RAMBlock *rb)
+{
+    uint64_t host_addr_offset =
+            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
+    return host_addr_offset >> TARGET_PAGE_BITS;
+}
+
+/* Clear whole block of mem */
+static inline void qemu_ram_block_writeback(RAMBlock *block)
+{
+    qemu_ram_msync(block, 0, block->used_length);
+}
+
+#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
+#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
+
+static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
+                                                 ram_addr_t length,
+                                                 unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    bool dirty = false;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page = start >> TARGET_PAGE_BITS;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
+
+        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+        base = page - offset;
+        while (page < end) {
+            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+            unsigned long num = next - base;
+            unsigned long found = find_next_bit(blocks->blocks[idx],
+                                                num, offset);
+            if (found < num) {
+                dirty = true;
+                break;
+            }
+
+            page = next;
+            idx++;
+            offset = 0;
+            base += DIRTY_MEMORY_BLOCK_SIZE;
+        }
+    }
+
+    return dirty;
+}
+
+static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
+                                                 ram_addr_t length,
+                                                 unsigned client)
+{
+    DirtyMemoryBlocks *blocks;
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    bool dirty = true;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page = start >> TARGET_PAGE_BITS;
+
+    RCU_READ_LOCK_GUARD();
+
+    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+    base = page - offset;
+    while (page < end) {
+        unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+        unsigned long num = next - base;
+        unsigned long found = find_next_zero_bit(blocks->blocks[idx], num, offset);
+        if (found < num) {
+            dirty = false;
+            break;
+        }
+
+        page = next;
+        idx++;
+        offset = 0;
+        base += DIRTY_MEMORY_BLOCK_SIZE;
+    }
+
+    return dirty;
+}
+
+static inline bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr,
+                                                      unsigned client)
+{
+    return cpu_physical_memory_get_dirty(addr, 1, client);
+}
+
+static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
+{
+    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
+    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
+    bool migration =
+        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
+    return !(vga && code && migration);
+}
+
+static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
+                                                               ram_addr_t length,
+                                                               uint8_t mask)
+{
+    uint8_t ret = 0;
+
+    if (mask & (1 << DIRTY_MEMORY_VGA) &&
+        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
+        ret |= (1 << DIRTY_MEMORY_VGA);
+    }
+    if (mask & (1 << DIRTY_MEMORY_CODE) &&
+        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
+        ret |= (1 << DIRTY_MEMORY_CODE);
+    }
+    if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
+        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
+        ret |= (1 << DIRTY_MEMORY_MIGRATION);
+    }
+    return ret;
+}
+
+static inline void cpu_physical_memory_set_dirty_flag(ram_addr_t addr,
+                                                      unsigned client)
+{
+    unsigned long page, idx, offset;
+    DirtyMemoryBlocks *blocks;
+
+    assert(client < DIRTY_MEMORY_NUM);
+
+    page = addr >> TARGET_PAGE_BITS;
+    idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+    offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+
+    RCU_READ_LOCK_GUARD();
+
+    blocks = qatomic_rcu_read(&ram_list.dirty_memory[client]);
+
+    set_bit_atomic(offset, blocks->blocks[idx]);
+}
+
+static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
+                                                       ram_addr_t length,
+                                                       uint8_t mask)
+{
+    DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
+    unsigned long end, page;
+    unsigned long idx, offset, base;
+    int i;
+
+    if (!mask && !xen_enabled()) {
+        return;
+    }
+
+    end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
+    page = start >> TARGET_PAGE_BITS;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        for (i = 0; i < DIRTY_MEMORY_NUM; i++) {
+            blocks[i] = qatomic_rcu_read(&ram_list.dirty_memory[i]);
+        }
+
+        idx = page / DIRTY_MEMORY_BLOCK_SIZE;
+        offset = page % DIRTY_MEMORY_BLOCK_SIZE;
+        base = page - offset;
+        while (page < end) {
+            unsigned long next = MIN(end, base + DIRTY_MEMORY_BLOCK_SIZE);
+
+            if (likely(mask & (1 << DIRTY_MEMORY_MIGRATION))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_MIGRATION]->blocks[idx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_VGA))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_VGA]->blocks[idx],
+                                  offset, next - page);
+            }
+            if (unlikely(mask & (1 << DIRTY_MEMORY_CODE))) {
+                bitmap_set_atomic(blocks[DIRTY_MEMORY_CODE]->blocks[idx],
+                                  offset, next - page);
+            }
+
+            page = next;
+            idx++;
+            offset = 0;
+            base += DIRTY_MEMORY_BLOCK_SIZE;
+        }
+    }
+
+    xen_hvm_modified_memory(start, length);
+}
+
+#if !defined(_WIN32)
+
+/*
+ * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
+ * the number of dirty pages in @bitmap passed as argument. On the other hand,
+ * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
+ * weren't set in the global migration bitmap.
+ */
+static inline
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
+        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+    } else {
+        uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
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
+static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
+                                                          ram_addr_t length)
+{
+    if (tcg_enabled()) {
+        tlb_reset_dirty_range_all(start, length);
+    }
+
+}
+bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
+                                              ram_addr_t length,
+                                              unsigned client);
+
+DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
+    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
+
+bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
+                                            ram_addr_t start,
+                                            ram_addr_t length);
+
+static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
+                                                         ram_addr_t length)
+{
+    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_MIGRATION);
+    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_VGA);
+    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_CODE);
+}
+
+
+/* Called with RCU critical section */
+static inline
+uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
+                                               ram_addr_t start,
+                                               ram_addr_t length)
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
+#endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5..a80547006b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -35,6 +35,7 @@
 #include "qemu/bswap.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dba4831cd1..d4b381641c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -28,6 +28,7 @@
 #include "exec/tb-flush.h"
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
 #include "exec/vaddr.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fdf6d8ac19..48015be829 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -41,6 +41,7 @@
 #endif
 #else
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #endif
 
 #include "exec/cputlb.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c56..a9833530c7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -75,6 +75,7 @@
 #include "hw/virtio/vhost-scsi-common.h"
 
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 2f74923560..5eef7475c1 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -28,6 +28,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7e24084673..a91fea1304 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -35,6 +35,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include <libfdt.h>
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/hw/remote/memory.c b/hw/remote/memory.c
index 6d60da91e0..0af2a2f3fe 100644
--- a/hw/remote/memory.c
+++ b/hw/remote/memory.c
@@ -12,6 +12,7 @@
 
 #include "hw/remote/memory.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "qapi/error.h"
 
 static void remote_sysmem_reset(void)
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index a926f61ebe..3948751ed7 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -13,6 +13,7 @@
 #include "exec/memory.h"
 #include "exec/cpu-common.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/remote/mpqemu-link.h"
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index eeaa811098..b495d81296 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c4259b5327..fe7945e856 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -17,6 +17,7 @@
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "cpu.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fe03f716f3..5b6fe1a18a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/s390x/s390-virtio-hcall.h"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index dcef44fe55..2e7a02cd4b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -30,6 +30,7 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ccdb639ac..f0bc9e8c2b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -26,6 +26,7 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/reset.h"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e7bece4ea1..120c82f3de 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,6 +26,7 @@
 #include "qemu/chardev_open.h"
 #include "pci.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 01aa11013e..f5698eeae0 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -27,6 +27,7 @@
 #include "qapi/qapi-events-vfio.h"
 #include "exec/ramlist.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "pci.h"
 #include "trace.h"
 #include "hw/hw.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 018bd20481..980147338a 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -20,6 +20,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 80ada89551..dae94dbbde 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..82c44e8213 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -49,6 +49,7 @@
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
diff --git a/plugins/api.c b/plugins/api.c
index 24ea64e2de..77b55cff74 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -50,6 +50,7 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
diff --git a/system/memory.c b/system/memory.c
index 85f6834cb3..7eae1bbda7 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -27,6 +27,7 @@
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "sysemu/tcg.h"
diff --git a/system/physmem.c b/system/physmem.c
index 3f937a5e58..26cfb84454 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -67,6 +67,7 @@
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 
 #include "qemu/pmem.h"
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index b017b26d07..0950a1c6f1 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -25,6 +25,7 @@
 #include "exec/page-protection.h"
 #ifndef CONFIG_USER_ONLY
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #endif
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3efc28f18b..f764931426 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -42,6 +42,7 @@
 #include "gdbstub/enums.h"
 #include "exec/memattrs.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "sysemu/hostmem.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 8ffe0159d8..c8045d873c 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -42,6 +42,7 @@
 #include "sysemu/device_tree.h"
 #include "gdbstub/enums.h"
 #include "exec/ram_addr.h"
+#include "sysemu/physmem-target.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
-- 
2.45.2


