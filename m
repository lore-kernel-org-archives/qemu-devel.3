Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6F5C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39D-00051i-5o; Sat, 08 Mar 2025 17:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38W-0004al-Se
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:16 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38T-0005MQ-7w
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:16 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224019ad9edso72453615ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474752; x=1742079552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PiHnQ+1q+MwLFjoc0q+vLnYcSz+0aCBgyfQrhPwFSE=;
 b=AgZO+VEb864EKSbUdiBm7hVXj04FbJkPdEe071pZtAIH1MwySX7AqekF8eNRbKE+/7
 p80uLGTnmVYBnMZ3zo7Ovg/KAb26A75zenrMHV59cJWAcsYOWC6RF+bwCecp2p20zC5e
 eFaiShd2t1fm0uaXtcWmwLzp6rCLDYyIqPIOApUsRu6B5PWjHibU8bL6hqdtq1AsVTCX
 jKu6Is3NFo55APWLNdmG2HYvK23JdUvRzjNrN1Co81F35+hzM1Y4aUXNznkxU+4MJH4T
 Oxmz/UkX0+ehyqTWdJCZbGdgIu7AgoZr1vnjej18QITHB3uuQwKns0DzGBCX3aeOSb0c
 fD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474752; x=1742079552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PiHnQ+1q+MwLFjoc0q+vLnYcSz+0aCBgyfQrhPwFSE=;
 b=l4tU1AC2BFDLu1QzrV6AcFmacDrLd3LZ21pPMpGsFfJgaNNRWgXqzyCAZbypa7pAZd
 Yjset6EkuVlK2T/TKYguBEClo3C3KwyFKsn6JJSprVn9qEpLYSuNBEUwY5K8grxxxl0p
 afe3GCISGDKYaT5eDkD4CMcZLGMKAK5RnYaI93biVEQk7vn4OlRnL6au5NwND/vkkRfY
 DdK3nlLmmhjc0bW7s6l05hUIcOdIbobe1kX+tguAfOt6J5RRaujl4iqmzxNgQwc7qkgU
 +EQBzMjP0pkeaFMzxQfmSKyvIevRHlAqGvjFggSoSe25gUJGmePK8NAEH1uqK0ak9LLC
 yQ/Q==
X-Gm-Message-State: AOJu0Yz+S2JpUzXVO1ExhdMHKkWbKKVq1HDuxrJ9HzTG3jymHHKyb8mz
 ymsYwdEKnUfpU6MFMczL7ptiE2Wac2+kJsIO9YacUwfhpA1QYckVRpp5uMrH1BUgJHqEu+59wqB
 j
X-Gm-Gg: ASbGnctjuC99chfHcdwMWEg9paA4iMDiaEmhQosDvLix10yVBTURMXUnL1RtDyeLlSD
 bnilvmARUBfy+oRGMQp/bAH0MeyIQs3vaiofyk/nXIhBXFlKFYszNNdpB3nmEBBEjgWy2b+nYoS
 Ech5kO6t79zMLDqlEsfL/f7+x9uQcaZFCGLxyv36sAOP+niruyDyFJVYqRtxbHiBiugO41CIg0v
 5Qv4ThhHDz7Tyrf0AE5ZzKR5X0bTLNV8D1MlPgLZC9KhI5J2aqoZW8BpU+1JMrEgPqGYyoBqWrB
 29hG2qPSfUb9pg3MRzkRfuvsOop72eCzfLSmfZWsjxgPYkfcwqRRodnhU8uOaSBun0V3K2gUjDp
 n
X-Google-Smtp-Source: AGHT+IHh3lFLishXgOeN+54f1PahmkHxoSteqzZB5/CnU9ILXczEDGnVdiAel5Ws5KblU0fOMx3GBA==
X-Received: by 2002:a17:902:e802:b0:224:584:6f04 with SMTP id
 d9443c01a7336-2242888ab27mr117975605ad.18.1741474751385; 
 Sat, 08 Mar 2025 14:59:11 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/23] exec: Declare tlb_flush*() in 'exec/cputlb.h'
Date: Sat,  8 Mar 2025 14:58:50 -0800
Message-ID: <20250308225902.1208237-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move CPU TLB related methods to "exec/cputlb.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20241114011310.3615-19-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cputlb.h                | 200 +++++++++++++++++++++++++--
 include/exec/exec-all.h              | 184 ------------------------
 accel/tcg/tcg-accel-ops.c            |   2 +-
 cpu-target.c                         |   1 +
 hw/intc/armv7m_nvic.c                |   2 +-
 hw/ppc/spapr_nested.c                |   1 +
 hw/sh4/sh7750.c                      |   1 +
 system/watchpoint.c                  |   3 +-
 target/alpha/sys_helper.c            |   2 +-
 target/arm/helper.c                  |   1 +
 target/arm/tcg/tlb-insns.c           |   2 +-
 target/hppa/mem_helper.c             |   1 +
 target/i386/helper.c                 |   2 +-
 target/i386/machine.c                |   2 +-
 target/i386/tcg/fpu_helper.c         |   2 +-
 target/i386/tcg/misc_helper.c        |   2 +-
 target/i386/tcg/system/misc_helper.c |   2 +-
 target/i386/tcg/system/svm_helper.c  |   2 +-
 target/loongarch/tcg/csr_helper.c    |   2 +-
 target/microblaze/mmu.c              |   2 +-
 target/mips/system/cp0.c             |   2 +-
 target/mips/tcg/system/cp0_helper.c  |   2 +-
 target/openrisc/sys_helper.c         |   1 +
 target/ppc/helper_regs.c             |   2 +-
 target/ppc/misc_helper.c             |   1 +
 target/riscv/csr.c                   |   1 +
 target/riscv/op_helper.c             |   1 +
 target/riscv/pmp.c                   |   2 +-
 target/s390x/gdbstub.c               |   2 +-
 target/s390x/sigp.c                  |   1 +
 target/s390x/tcg/mem_helper.c        |   1 +
 target/s390x/tcg/misc_helper.c       |   1 +
 target/sparc/ldst_helper.c           |   1 +
 target/xtensa/mmu_helper.c           |   1 +
 34 files changed, 224 insertions(+), 211 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index cdfaf17403..8125f6809c 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -25,21 +25,14 @@
 #include "exec/memattrs.h"
 #include "exec/vaddr.h"
 
-#ifdef CONFIG_TCG
-
-#if !defined(CONFIG_USER_ONLY)
-/* cputlb.c */
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 void tlb_protect_code(ram_addr_t ram_addr);
 void tlb_unprotect_code(ram_addr_t ram_addr);
 #endif
 
-#endif /* CONFIG_TCG */
-
 #ifndef CONFIG_USER_ONLY
-
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
-
 #endif
 
 /**
@@ -101,4 +94,193 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                   hwaddr paddr, int prot,
                   int mmu_idx, vaddr size);
 
-#endif
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+/**
+ * tlb_flush_page:
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of the specified CPU, for all
+ * MMU indexes.
+ */
+void tlb_flush_page(CPUState *cpu, vaddr addr);
+
+/**
+ * tlb_flush_page_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ * @addr: virtual address of page to be flushed
+ *
+ * Flush one page from the TLB of all CPUs, for all
+ * MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr);
+
+/**
+ * tlb_flush:
+ * @cpu: CPU whose TLB should be flushed
+ *
+ * Flush the entire TLB for the specified CPU. Most CPU architectures
+ * allow the implementation to drop entries from the TLB at any time
+ * so this is generally safe. If more selective flushing is required
+ * use one of the other functions for efficiency.
+ */
+void tlb_flush(CPUState *cpu);
+
+/**
+ * tlb_flush_all_cpus_synced:
+ * @cpu: src CPU of the flush
+ *
+ * Flush the entire TLB for all CPUs, for all MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_all_cpus_synced(CPUState *src_cpu);
+
+/**
+ * tlb_flush_page_by_mmuidx:
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of the specified CPU, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
+                              uint16_t idxmap);
+
+/**
+ * tlb_flush_page_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush one page from the TLB of all CPUs, for the specified
+ * MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                              uint16_t idxmap);
+
+/**
+ * tlb_flush_by_mmuidx:
+ * @cpu: CPU whose TLB should be flushed
+ * @wait: If true ensure synchronisation by exiting the cpu_loop
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from the TLB of the specified CPU, for the specified
+ * MMU indexes.
+ */
+void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
+
+/**
+ * tlb_flush_by_mmuidx_all_cpus_synced:
+ * @cpu: Originating CPU of the flush
+ * @idxmap: bitmap of MMU indexes to flush
+ *
+ * Flush all entries from the TLB of all CPUs, for the specified
+ * MMU indexes.
+ *
+ * When this function returns, no CPUs will subsequently perform
+ * translations using the flushed TLBs.
+ */
+void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
+
+/**
+ * tlb_flush_page_bits_by_mmuidx
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of page to be flushed
+ * @idxmap: bitmap of mmu indexes to flush
+ * @bits: number of significant bits in address
+ *
+ * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
+ */
+void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
+                                   uint16_t idxmap, unsigned bits);
+
+/* Similarly, with broadcast and syncing. */
+void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                                   uint16_t idxmap,
+                                                   unsigned bits);
+
+/**
+ * tlb_flush_range_by_mmuidx
+ * @cpu: CPU whose TLB should be flushed
+ * @addr: virtual address of the start of the range to be flushed
+ * @len: length of range to be flushed
+ * @idxmap: bitmap of mmu indexes to flush
+ * @bits: number of significant bits in address
+ *
+ * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
+ * comparing only the low @bits worth of each virtual page.
+ */
+void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                               vaddr len, uint16_t idxmap,
+                               unsigned bits);
+
+/* Similarly, with broadcast and syncing. */
+void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                               vaddr addr,
+                                               vaddr len,
+                                               uint16_t idxmap,
+                                               unsigned bits);
+#else
+static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
+{
+}
+static inline void tlb_flush_page_all_cpus_synced(CPUState *src, vaddr addr)
+{
+}
+static inline void tlb_flush(CPUState *cpu)
+{
+}
+static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
+{
+}
+static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
+                                            vaddr addr, uint16_t idxmap)
+{
+}
+
+static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                            vaddr addr,
+                                                            uint16_t idxmap)
+{
+}
+static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                       uint16_t idxmap)
+{
+}
+static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
+                                                 vaddr addr,
+                                                 uint16_t idxmap,
+                                                 unsigned bits)
+{
+}
+static inline void
+tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
+                                              uint16_t idxmap, unsigned bits)
+{
+}
+static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
+                                             vaddr len, uint16_t idxmap,
+                                             unsigned bits)
+{
+}
+static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
+                                                             vaddr addr,
+                                                             vaddr len,
+                                                             uint16_t idxmap,
+                                                             unsigned bits)
+{
+}
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
+#endif /* CPUTLB_H */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a3aa8448d0..a758b7a843 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -27,190 +27,6 @@
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
-/* cputlb.c */
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
-#else
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
 #if defined(CONFIG_TCG)
 
 /**
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 132c5d1461..53e580d128 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -33,7 +33,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
diff --git a/cpu-target.c b/cpu-target.c
index 5aa6c4b0c6..b6e66d5ac0 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -31,6 +31,7 @@
 #include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
 #include "exec/log.h"
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5fd0760982..7212c87c68 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -22,7 +22,7 @@
 #include "system/runstate.h"
 #include "target/arm/cpu.h"
 #include "target/arm/cpu-features.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/memop.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 7def8eb73b..23958c6383 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 8892eaddcb..6faf0e3ca8 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -36,6 +36,7 @@
 #include "hw/sh4/sh_intc.h"
 #include "hw/timer/tmu012.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "trace.h"
 
 typedef struct SH7750State {
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 2aa2a9ea63..08dbd8483d 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -19,7 +19,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
+#include "exec/target_page.h"
 #include "hw/core/cpu.h"
 
 /* Add a watchpoint.  */
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 54ee93f34c..51e3254428 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71dead7241..e786c8df5f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -18,6 +18,7 @@
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/qemu-print.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "hw/irq.h"
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index fadc61a76e..630a481f0f 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -7,7 +7,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 304f0b61e2..fb1d93ef1f 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 3bc15fba6e..c07b1b16ea 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/translation-block.h"
 #include "system/runstate.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/machine.c b/target/i386/machine.c
index d9d4f25d1a..70f632a36f 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
 #include "kvm/hyperv.h"
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4858ae9a5f..c1184ca219 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -21,7 +21,7 @@
 #include <math.h>
 #include "cpu.h"
 #include "tcg-cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index ed4cda8001..2b5f092a23 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "helper-tcg.h"
 
 /*
diff --git a/target/i386/tcg/system/misc_helper.c b/target/i386/tcg/system/misc_helper.c
index c9c4d42f84..ce18c75b9f 100644
--- a/target/i386/tcg/system/misc_helper.c
+++ b/target/i386/tcg/system/misc_helper.c
@@ -23,7 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "tcg/helper-tcg.h"
 #include "hw/i386/apic.h"
 
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index 5f95b5227b..f9982b72d1 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -21,7 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "tcg/helper-tcg.h"
 
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 6c95be9910..84f7ff25f6 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -12,7 +12,7 @@
 #include "internals.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "hw/irq.h"
 #include "cpu-csr.h"
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 2423ac6172..f8587d5ac4 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 
 static unsigned int tlb_decode_size(unsigned int f)
diff --git a/target/mips/system/cp0.c b/target/mips/system/cp0.c
index bae37f515b..ff7d3db00c 100644
--- a/target/mips/system/cp0.c
+++ b/target/mips/system/cp0.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 
 /* Called for updates to CP0_Status.  */
 void sync_c0_status(CPUMIPSState *env, CPUMIPSState *cpu, int tc)
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 79a5c833ce..01a07a169f 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -27,7 +27,7 @@
 #include "internal.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 
 
 /* SMP helpers.  */
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 77567afba4..21bc137ccc 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 3ad4273c16..f211bc9830 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/main-loop.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "helper_regs.h"
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index f0ca80153b..e379da6010 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0ebcca4597..49566d3c08 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -25,6 +25,7 @@
 #include "pmu.h"
 #include "time_helper.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "system/cpu-timers.h"
 #include "qemu/guest-random.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f156bfab12..0d4220ba93 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "trace.h"
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 85ab270dad..b0841d44f4 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "trace.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t addr_index,
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 6879430adc..6bca376f2b 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "s390x-internal.h"
-#include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "qemu/bitops.h"
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index cf53b23291..6a4d9c5081 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -15,6 +15,7 @@
 #include "system/hw_accel.h"
 #include "system/runstate.h"
 #include "exec/address-spaces.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "system/tcg.h"
 #include "trace.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index ea9fa64d6b..8187b917ba 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -26,6 +26,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 0245451472..31266aeda4 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/cpu_ldst.h"
 #include "qapi/error.h"
 #include "tcg_s390x.h"
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 4c54e45655..b559afc9a9 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -24,6 +24,7 @@
 #include "tcg/tcg.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/cpu_ldst.h"
 #ifdef CONFIG_USER_ONLY
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 29b84d5dbf..63be741a42 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -32,6 +32,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
+#include "exec/cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 
-- 
2.43.0


