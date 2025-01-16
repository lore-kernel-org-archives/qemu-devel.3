Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F169C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 21:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYX7E-0003UZ-4O; Thu, 16 Jan 2025 16:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYX7B-0003UC-Hf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:09:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYX78-0008Gm-Ci
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:09:21 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so1096165f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 13:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737061756; x=1737666556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ehQfsjuhR9c4bmr1DLpJA7X8dGSFzsdi+BxL6+m3doQ=;
 b=JgvQwZfhvtamwXOI7jOFR3aDo+Q6Rz/pM5bD6Dfdju/DB5eP5+jZlv/pUvZZ6wEmHt
 TztEyC7Ik0m/nNyge7N/MzRDl7CeiJ/VwTFAtTNUWBIpbT9EED/bWxBcfpnGKgjvWJRT
 70u1JIwxbW0H8dsvJ6lKUh4s6i4Zr1aBMPMRwOEkPM/ojmeUiadtX5bYodh3TT/q4A4B
 acDWvi/i0sJ53XUm8hM0n3alAmLBh1S3PekdgzqCVl5/edsz3ALH9wr5V4Z0C+UaMDof
 FtUCUi7e3rdcOoJAEa9Up1bQLja+pcCpLLzm4ehwGLI/zeG4AlCzx1DO6rBm2RdGHwWX
 9HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737061756; x=1737666556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ehQfsjuhR9c4bmr1DLpJA7X8dGSFzsdi+BxL6+m3doQ=;
 b=GNV9dY0YJGm9FwABt9ISS+2uY+NPL+NPb6SOng/QaCmVv7j0M+LfgWHfylkBDsfMkj
 OKitqPiXm44KWI1+UrmJtHe1es/FZust8XtRVu20t+EypxoKwh8csbew+q1hQPT45DgK
 40fXXOqxjzYShfusfUp70knpDaMEk6QEevCNMtGQYFZPRR1qGRlv9wZY1vue6V0Yvesi
 P+aRAtjB06md1D8jGCcxgxWpRJ0p/moqXs46Jly1ZUczvXkQqtiOhKGIUkbjZgyvSe8p
 M8Vz05d5Rg9foZH35NYvwRXK+xd8KFM3BMEtbBl7YwyxPQDpitA2ntiNuUoBwbKF5XnA
 NT8Q==
X-Gm-Message-State: AOJu0YyXsOxr74Ph1BFCLsO97eh5b3VmQi3XiSc2oSyjo1Rkar4E+pjv
 I4Tofukb3446QtS1BsjzqeI5NwXWFMpj108jAEElQtL7PbxTVWHGlO+TbHeCcbiefS4gjW6II/Y
 8+2U=
X-Gm-Gg: ASbGncsFrIhitkG5rwSmbsyqX0mJmo0oHbuQd4uQ3DGwgAP0YFjWXwU6787o/eLMunS
 TXJWN3FMvQA0C4Xtp7aBPeGYJm0G5QLBBJxP44TwrJw40sRHCjzuG7e12ywEY/iMz0BTTWaC24B
 kuPB/Zi5no2Qc/RdEQUNVn4fRzHEZFPORh3ITOl+We8SS3DS2hgwYBzoFNmOtK7XyzKu0OLlRJb
 wL0OxvTSg8S/wjnCPSqoowqQJvNZLQAr0Pp+M9tMWZnZMXskHdU0H5poxHETsep/90Cb/BWZj0k
 rdWiBGHYnUYYKizjILJKklz1LbYnEfU=
X-Google-Smtp-Source: AGHT+IH8LzCEZ9JDYzraPCqJj9vG8VrRfJq6tfS5RlD9FDYe5QFON6RemlPGPIo1hIHlF8ukHuHntg==
X-Received: by 2002:adf:fec5:0:b0:38a:88d0:18d6 with SMTP id
 ffacd0b85a97d-38bf58e8fa8mr75883f8f.42.1737061755593; 
 Thu, 16 Jan 2025 13:09:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf321504asm794697f8f.17.2025.01.16.13.09.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 13:09:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] qemu/compiler: Absorb 'clang-tsa.h'
Date: Thu, 16 Jan 2025 22:09:13 +0100
Message-ID: <20250116210913.53782-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

We already have "qemu/compiler.h" for compiler-specific arrangements,
automatically included by "qemu/osdep.h" for each source file. No
need to explicitly include a header for a Clang particularity,
let the common "qemu/compiler.h" deal with that by having it
include "qemu/clang-tsa.h" (renamed as qemu/clang-tsa.h.inc).
Add a check to not include "qemu/clang-tsa.h.inc" directly,
remove previous "qemu/clang-tsa.h" inclusions.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/qemu.h                               |   1 -
 include/block/block_int-common.h              |   1 -
 include/block/graph-lock.h                    |   2 -
 include/exec/exec-all.h                       | 516 ------------------
 include/exec/page-protection.h                |   2 -
 include/qemu/compiler.h                       |   2 +
 include/qemu/thread.h                         |   1 -
 include/qemu/{clang-tsa.h => clang-tsa.h.inc} |   8 +-
 block/create.c                                |   1 -
 tests/unit/test-bdrv-drain.c                  |   1 -
 tests/unit/test-block-iothread.c              |   1 -
 util/qemu-thread-posix.c                      |   1 -
 12 files changed, 8 insertions(+), 529 deletions(-)
 delete mode 100644 include/exec/exec-all.h
 rename include/qemu/{clang-tsa.h => clang-tsa.h.inc} (97%)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 3eaa14f3f56..4e97c796318 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -40,7 +40,6 @@ extern char **environ;
 #include "target.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
-#include "qemu/clang-tsa.h"
 #include "accel/tcg/vcpu-state.h"
 
 #include "qemu-os.h"
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index bb91a0f62fa..ebb4e56a503 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -28,7 +28,6 @@
 #include "block/block-common.h"
 #include "block/block-global-state.h"
 #include "block/snapshot.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "qemu/stats64.h"
diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index dc8d9491843..2c26c721081 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -20,8 +20,6 @@
 #ifndef GRAPH_LOCK_H
 #define GRAPH_LOCK_H
 
-#include "qemu/clang-tsa.h"
-
 /**
  * Graph Lock API
  * This API provides a rwlock used to protect block layer
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
deleted file mode 100644
index d9045c9ac4c..00000000000
--- a/include/exec/exec-all.h
+++ /dev/null
@@ -1,516 +0,0 @@
-/*
- * internal execution defines for qemu
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef EXEC_ALL_H
-#define EXEC_ALL_H
-
-#include "cpu.h"
-#if defined(CONFIG_USER_ONLY)
-#include "exec/cpu_ldst.h"
-#endif
-#include "exec/mmu-access-type.h"
-#include "exec/translation-block.h"
-
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-/* cputlb.c */
-/**
- * tlb_init - initialize a CPU's TLB
- * @cpu: CPU whose TLB should be initialized
- */
-void tlb_init(CPUState *cpu);
-/**
- * tlb_destroy - destroy a CPU's TLB
- * @cpu: CPU whose TLB should be destroyed
- */
-void tlb_destroy(CPUState *cpu);
-/**
- * tlb_flush_page:
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- *
- * Flush one page from the TLB of the specified CPU, for all
- * MMU indexes.
- */
-void tlb_flush_page(CPUState *cpu, vaddr addr);
-/**
- * tlb_flush_page_all_cpus_synced:
- * @cpu: src CPU of the flush
- * @addr: virtual address of page to be flushed
- *
- * Flush one page from the TLB of all CPUs, for all
- * MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
-/**
- * tlb_flush:
- * @cpu: CPU whose TLB should be flushed
- *
- * Flush the entire TLB for the specified CPU. Most CPU architectures
- * allow the implementation to drop entries from the TLB at any time
- * so this is generally safe. If more selective flushing is required
- * use one of the other functions for efficiency.
- */
-void tlb_flush(CPUState *cpu);
-/**
- * tlb_flush_all_cpus_synced:
- * @cpu: src CPU of the flush
- *
- * Flush the entire TLB for all CPUs, for all MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_all_cpus_synced(CPUState *src_cpu);
-/**
- * tlb_flush_page_by_mmuidx:
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush one page from the TLB of the specified CPU, for the specified
- * MMU indexes.
- */
-void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
-                              uint16_t idxmap);
-/**
- * tlb_flush_page_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush one page from the TLB of all CPUs, for the specified
- * MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx:
- * @cpu: CPU whose TLB should be flushed
- * @wait: If true ensure synchronisation by exiting the cpu_loop
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush all entries from the TLB of the specified CPU, for the specified
- * MMU indexes.
- */
-void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
-/**
- * tlb_flush_by_mmuidx_all_cpus_synced:
- * @cpu: Originating CPU of the flush
- * @idxmap: bitmap of MMU indexes to flush
- *
- * Flush all entries from the TLB of all CPUs, for the specified
- * MMU indexes.
- *
- * When this function returns, no CPUs will subsequently perform
- * translations using the flushed TLBs.
- */
-void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
-
-/**
- * tlb_flush_page_bits_by_mmuidx
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of page to be flushed
- * @idxmap: bitmap of mmu indexes to flush
- * @bits: number of significant bits in address
- *
- * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
- */
-void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
-                                   uint16_t idxmap, unsigned bits);
-
-/* Similarly, with broadcast and syncing. */
-void tlb_flush_page_bits_by_mmuidx_all_cpus_synced
-    (CPUState *cpu, vaddr addr, uint16_t idxmap, unsigned bits);
-
-/**
- * tlb_flush_range_by_mmuidx
- * @cpu: CPU whose TLB should be flushed
- * @addr: virtual address of the start of the range to be flushed
- * @len: length of range to be flushed
- * @idxmap: bitmap of mmu indexes to flush
- * @bits: number of significant bits in address
- *
- * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
- * comparing only the low @bits worth of each virtual page.
- */
-void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                               vaddr len, uint16_t idxmap,
-                               unsigned bits);
-
-/* Similarly, with broadcast and syncing. */
-void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                               vaddr addr,
-                                               vaddr len,
-                                               uint16_t idxmap,
-                                               unsigned bits);
-
-/**
- * tlb_set_page_full:
- * @cpu: CPU context
- * @mmu_idx: mmu index of the tlb to modify
- * @addr: virtual address of the entry to add
- * @full: the details of the tlb entry
- *
- * Add an entry to @cpu tlb index @mmu_idx.  All of the fields of
- * @full must be filled, except for xlat_section, and constitute
- * the complete description of the translated page.
- *
- * This is generally called by the target tlb_fill function after
- * having performed a successful page table walk to find the physical
- * address and attributes for the translation.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; @full->lg_page_size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_full(CPUState *cpu, int mmu_idx, vaddr addr,
-                       CPUTLBEntryFull *full);
-
-/**
- * tlb_set_page_with_attrs:
- * @cpu: CPU to add this TLB entry for
- * @addr: virtual address of page to add entry for
- * @paddr: physical address of the page
- * @attrs: memory transaction attributes
- * @prot: access permissions (PAGE_READ/PAGE_WRITE/PAGE_EXEC bits)
- * @mmu_idx: MMU index to insert TLB entry for
- * @size: size of the page in bytes
- *
- * Add an entry to this CPU's TLB (a mapping from virtual address
- * @addr to physical address @paddr) with the specified memory
- * transaction attributes. This is generally called by the target CPU
- * specific code after it has been called through the tlb_fill()
- * entry point and performed a successful page table walk to find
- * the physical address and attributes for the virtual address
- * which provoked the TLB miss.
- *
- * At most one entry for a given virtual address is permitted. Only a
- * single TARGET_PAGE_SIZE region is mapped; the supplied @size is only
- * used by tlb_flush_page.
- */
-void tlb_set_page_with_attrs(CPUState *cpu, vaddr addr,
-                             hwaddr paddr, MemTxAttrs attrs,
-                             int prot, int mmu_idx, vaddr size);
-/* tlb_set_page:
- *
- * This function is equivalent to calling tlb_set_page_with_attrs()
- * with an @attrs argument of MEMTXATTRS_UNSPECIFIED. It's provided
- * as a convenience for CPUs which don't use memory transaction attributes.
- */
-void tlb_set_page(CPUState *cpu, vaddr addr,
-                  hwaddr paddr, int prot,
-                  int mmu_idx, vaddr size);
-#else
-static inline void tlb_init(CPUState *cpu)
-{
-}
-static inline void tlb_destroy(CPUState *cpu)
-{
-}
-static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
-{
-}
-static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
-{
-}
-static inline void tlb_flush(CPUState *cpu)
-{
-}
-static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
-{
-}
-static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
-                                            vaddr addr, uint16_t idxmap)
-{
-}
-
-static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
-{
-}
-static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                            vaddr addr,
-                                                            uint16_t idxmap)
-{
-}
-static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                       uint16_t idxmap)
-{
-}
-static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
-                                                 vaddr addr,
-                                                 uint16_t idxmap,
-                                                 unsigned bits)
-{
-}
-static inline void
-tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap, unsigned bits)
-{
-}
-static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                                             vaddr len, uint16_t idxmap,
-                                             unsigned bits)
-{
-}
-static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                             vaddr addr,
-                                                             vaddr len,
-                                                             uint16_t idxmap,
-                                                             unsigned bits)
-{
-}
-#endif
-
-#if defined(CONFIG_TCG)
-
-/**
- * probe_access:
- * @env: CPUArchState
- * @addr: guest virtual address to look up
- * @size: size of the access
- * @access_type: read, write or execute permission
- * @mmu_idx: MMU index to use for lookup
- * @retaddr: return address for unwinding
- *
- * Look up the guest virtual address @addr.  Raise an exception if the
- * page does not satisfy @access_type.  Raise an exception if the
- * access (@addr, @size) hits a watchpoint.  For writes, mark a clean
- * page as dirty.
- *
- * Finally, return the host address for a page that is backed by RAM,
- * or NULL if the page requires I/O.
- */
-void *probe_access(CPUArchState *env, vaddr addr, int size,
-                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr);
-
-static inline void *probe_write(CPUArchState *env, vaddr addr, int size,
-                                int mmu_idx, uintptr_t retaddr)
-{
-    return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
-}
-
-static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
-                               int mmu_idx, uintptr_t retaddr)
-{
-    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
-}
-
-/**
- * probe_access_flags:
- * @env: CPUArchState
- * @addr: guest virtual address to look up
- * @size: size of the access
- * @access_type: read, write or execute permission
- * @mmu_idx: MMU index to use for lookup
- * @nonfault: suppress the fault
- * @phost: return value for host address
- * @retaddr: return address for unwinding
- *
- * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
- * the page, and storing the host address for RAM in @phost.
- *
- * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
- * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
- * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
- * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
- */
-int probe_access_flags(CPUArchState *env, vaddr addr, int size,
-                       MMUAccessType access_type, int mmu_idx,
-                       bool nonfault, void **phost, uintptr_t retaddr);
-
-#ifndef CONFIG_USER_ONLY
-
-/**
- * probe_access_full:
- * Like probe_access_flags, except also return into @pfull.
- *
- * The CPUTLBEntryFull structure returned via @pfull is transient
- * and must be consumed or copied immediately, before any further
- * access or changes to TLB @mmu_idx.
- *
- * This function will not fault if @nonfault is set, but will
- * return TLB_INVALID_MASK if the page is not mapped, or is not
- * accessible with @access_type.
- *
- * This function will return TLB_MMIO in order to force the access
- * to be handled out-of-line if plugins wish to instrument the access.
- */
-int probe_access_full(CPUArchState *env, vaddr addr, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool nonfault, void **phost,
-                      CPUTLBEntryFull **pfull, uintptr_t retaddr);
-
-/**
- * probe_access_full_mmu:
- * Like probe_access_full, except:
- *
- * This function is intended to be used for page table accesses by
- * the target mmu itself.  Since such page walking happens while
- * handling another potential mmu fault, this function never raises
- * exceptions (akin to @nonfault true for probe_access_full).
- * Likewise this function does not trigger plugin instrumentation.
- */
-int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
-                          MMUAccessType access_type, int mmu_idx,
-                          void **phost, CPUTLBEntryFull **pfull);
-
-#endif /* !CONFIG_USER_ONLY */
-#endif /* CONFIG_TCG */
-
-static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
-{
-#ifdef CONFIG_USER_ONLY
-    return tb->itree.start;
-#else
-    return tb->page_addr[0];
-#endif
-}
-
-static inline tb_page_addr_t tb_page_addr1(const TranslationBlock *tb)
-{
-#ifdef CONFIG_USER_ONLY
-    tb_page_addr_t next = tb->itree.last & TARGET_PAGE_MASK;
-    return next == (tb->itree.start & TARGET_PAGE_MASK) ? -1 : next;
-#else
-    return tb->page_addr[1];
-#endif
-}
-
-static inline void tb_set_page_addr0(TranslationBlock *tb,
-                                     tb_page_addr_t addr)
-{
-#ifdef CONFIG_USER_ONLY
-    tb->itree.start = addr;
-    /*
-     * To begin, we record an interval of one byte.  When the translation
-     * loop encounters a second page, the interval will be extended to
-     * include the first byte of the second page, which is sufficient to
-     * allow tb_page_addr1() above to work properly.  The final corrected
-     * interval will be set by tb_page_add() from tb->size before the
-     * node is added to the interval tree.
-     */
-    tb->itree.last = addr;
-#else
-    tb->page_addr[0] = addr;
-#endif
-}
-
-static inline void tb_set_page_addr1(TranslationBlock *tb,
-                                     tb_page_addr_t addr)
-{
-#ifdef CONFIG_USER_ONLY
-    /* Extend the interval to the first byte of the second page.  See above. */
-    tb->itree.last = addr;
-#else
-    tb->page_addr[1] = addr;
-#endif
-}
-
-/* TranslationBlock invalidate API */
-void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
-void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
-
-/* GETPC is the true target of the return instruction that we'll execute.  */
-#if defined(CONFIG_TCG_INTERPRETER)
-extern __thread uintptr_t tci_tb_ptr;
-# define GETPC() tci_tb_ptr
-#else
-# define GETPC() \
-    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
-#endif
-
-/* The true return address will often point to a host insn that is part of
-   the next translated guest insn.  Adjust the address backward to point to
-   the middle of the call insn.  Subtracting one would do the job except for
-   several compressed mode architectures (arm, mips) which set the low bit
-   to indicate the compressed mode; subtracting two works around that.  It
-   is also the case that there are no host isas that contain a call insn
-   smaller than 4 bytes, so we don't worry about special-casing this.  */
-#define GETPC_ADJ   2
-
-#if !defined(CONFIG_USER_ONLY)
-
-/**
- * iotlb_to_section:
- * @cpu: CPU performing the access
- * @index: TCG CPU IOTLB entry
- *
- * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
- * it refers to. @index will have been initially created and returned
- * by memory_region_section_get_iotlb().
- */
-struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                             hwaddr index, MemTxAttrs attrs);
-#endif
-
-/**
- * get_page_addr_code_hostp()
- * @env: CPUArchState
- * @addr: guest virtual address of guest code
- *
- * See get_page_addr_code() (full-system version) for documentation on the
- * return value.
- *
- * Sets *@hostp (when @hostp is non-NULL) as follows.
- * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
- * to the host address where @addr's content is kept.
- *
- * Note: this function can trigger an exception.
- */
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
-                                        void **hostp);
-
-/**
- * get_page_addr_code()
- * @env: CPUArchState
- * @addr: guest virtual address of guest code
- *
- * If we cannot translate and execute from the entire RAM page, or if
- * the region is not backed by RAM, returns -1. Otherwise, returns the
- * ram_addr_t corresponding to the guest code at @addr.
- *
- * Note: this function can trigger an exception.
- */
-static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
-                                                vaddr addr)
-{
-    return get_page_addr_code_hostp(env, addr, NULL);
-}
-
-#if !defined(CONFIG_USER_ONLY)
-
-void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
-void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
-
-MemoryRegionSection *
-address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
-                                  hwaddr *xlat, hwaddr *plen,
-                                  MemTxAttrs attrs, int *prot);
-hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section);
-#endif
-
-#endif
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index bae3355f62c..3e0a8a03331 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -40,8 +40,6 @@
 
 #ifdef CONFIG_USER_ONLY
 
-#include "qemu/clang-tsa.h"
-
 void TSA_NO_TSA mmap_lock(void);
 void TSA_NO_TSA mmap_unlock(void);
 bool have_mmap_lock(void);
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb41..6dfd8da14d9 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -7,6 +7,8 @@
 #ifndef COMPILER_H
 #define COMPILER_H
 
+#include "qemu/clang-tsa.h.inc"
+
 #define HOST_BIG_ENDIAN (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
 
 /* HOST_LONG_BITS is the size of a native pointer in bits. */
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 7eba27a7049..6f800aad31a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -3,7 +3,6 @@
 
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
-#include "qemu/clang-tsa.h"
 
 typedef struct QemuCond QemuCond;
 typedef struct QemuSemaphore QemuSemaphore;
diff --git a/include/qemu/clang-tsa.h b/include/qemu/clang-tsa.h.inc
similarity index 97%
rename from include/qemu/clang-tsa.h
rename to include/qemu/clang-tsa.h.inc
index ba06fb8c924..1273c39f9c5 100644
--- a/include/qemu/clang-tsa.h
+++ b/include/qemu/clang-tsa.h.inc
@@ -1,5 +1,5 @@
-#ifndef CLANG_TSA_H
-#define CLANG_TSA_H
+#ifndef CLANG_TSA_H_INC
+#define CLANG_TSA_H_INC
 
 /*
  * Copyright 2018 Jarkko Hietaniemi <jhi@iki.fi>
@@ -24,6 +24,10 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#ifndef COMPILER_H
+#error Cannot include this header directly
+#endif
+
 /* http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
  * TSA is available since clang 3.6-ish.
diff --git a/block/create.c b/block/create.c
index 72abafb4c12..6b23a216753 100644
--- a/block/create.c
+++ b/block/create.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "qapi/qapi-commands-block-core.h"
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 98ad89b390c..7410e6f3528 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -28,7 +28,6 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
-#include "qemu/clang-tsa.h"
 #include "iothread.h"
 
 static QemuEvent done_event;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 1de04a8a13d..26a6c051758 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -29,7 +29,6 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/main-loop.h"
 #include "iothread.h"
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 6fff4162ac6..b2e26e21205 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -17,7 +17,6 @@
 #include "qemu-thread-common.h"
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
-#include "qemu/clang-tsa.h"
 
 #ifdef CONFIG_PTHREAD_SET_NAME_NP
 #include <pthread_np.h>
-- 
2.47.1


