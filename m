Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788D2C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwMc-0001QZ-JE; Sun, 27 Jul 2025 04:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLv-0005QJ-Ry
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLt-00048G-P0
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2363616a1a6so27449395ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603404; x=1754208204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSHTZd/mS6B0hzuFKxsgTmFE8MtB74l1Qk2MWt1HjCI=;
 b=TQC1PEs4BgGcHKDnEdL8AdeRSN0SMu66OyIKMQz7M+WjHkOgytOcwzRe1Jik4JDxcs
 1Ua/w4tg8K1cM7tk4AUWvlMhpBFrHWQb3mU1zYrw9v+V06DTTpdBJqanFqH3wG0b+F+u
 GtRAVxAx4haWP+KyWEHUulfqPBjgRcyCB6ihj8f/Ig2TbNPr631dftl/NE0zet+XV1Sq
 31D16QQvqIfwiqkAHq+/ppqqazBTDYblYgL9cBbEJOzDVdU2vTURSssLhZ4Tr4DuUkRj
 p4pMYlogEeffwkiefRpJzvlQINugPI7CKpZ0YoyuKyTM95FPCVRC8BARcTAT3UY/cQro
 uT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603404; x=1754208204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSHTZd/mS6B0hzuFKxsgTmFE8MtB74l1Qk2MWt1HjCI=;
 b=Bn8eRHrizacTCYiKCqsncC8OSrARHzymu7AV+vEhuUUxbGpWvNWqwk79baOnLHHS/H
 2vhZJBN2DzvOYk7f1HJ/MZatXcg8vfEwG8QSosvyStE5kYS3YQBtJuAuriGTNq5fsQKq
 hrPiRuh6NDL5MJulFzgIgeYAlIaGVDkcB+TxrBDweS4CY08GU/HznQLFlCRBKa3uehPT
 frAJ+V85xP7sSLVSc9OXaKwf2DFWInVds2kqvt303eS82rJdKsP6rOA75dmkqcER5XaW
 gsj6RYNhhWvuXwZ+NdZU80HWL4PLcm9KRrZsVfRdoj/w28/BCaBZipmhlFyDLDNEBCY5
 qtvA==
X-Gm-Message-State: AOJu0YxFW0GZAjIvGR0anZ0T3FEFb7tnOusEWeDqIWb+N5ZGQ4m6OUuU
 WJLLQK7m0TtBweW+1iIFo71rJgfyewencvtZ1QCM5LQCw7JpKHetVYdNT8zm5RaJ9YzH8WnnlK9
 1qiiK
X-Gm-Gg: ASbGncvc3pZhPCRRGflnujohv1UKwm0zXBbWl28dd8Tu63uH1VcKeVu89wEFyqf3MH3
 1OXrFJ6DBxlPnt/bpuo/CgGI+XBz0bI4jPs/Lt8fGGw+soy5RHUM4lwIPk5XNRNkf4AYsOCa691
 dcx9kv90ffDT8KDoJU/5JBIu41hRowypCqwbbM2EEubhbjXXcx2kNjLZg2apR5IoEwU8AxKSwyq
 +IXRvHYy3H+ADegRKmP8MYsE+PLT3k+Z8cywbtOlH64fJaQE5/9ipGlYVaDPw39/fsDmH0eeA6V
 Vgz/3Y+6/ZGIB+Q4yvop6YFvCRPypINRGUn8Kv+M4AoeFxJUmhXndzJaVLVeaCixgY1Kp3vmyzV
 izdrUbeC8YZkgiJMGRkwyt77MuGBTBMU1vjPVM3x2DfUEL527JOne5KfXkZBSaonYQGRFPKlLZ6
 pyQbGppuxd3w==
X-Google-Smtp-Source: AGHT+IHN97kUZiEzFaxmUgJNO0ePdUfUyl4d79Ib+Zn3CO8PG86mbgcPVe33WYe5I6K4LNAkKfFC8g==
X-Received: by 2002:a17:902:d4d2:b0:240:11cd:8502 with SMTP id
 d9443c01a7336-24011cd8924mr7639755ad.13.1753603404436; 
 Sun, 27 Jul 2025 01:03:24 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 23/82] include/hw/core/cpu: Introduce MMUIdxMap
Date: Sat, 26 Jul 2025 22:01:55 -1000
Message-ID: <20250727080254.83840-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Use a typedef instead of uint16_t directly when
describing sets of mmu indexes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cputlb.h | 32 ++++++++++++++++----------------
 include/hw/core/cpu.h |  6 +++---
 accel/tcg/cputlb.c    | 30 +++++++++++++++---------------
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index 03ed7e2165..9bec0e7890 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -150,7 +150,7 @@ void tlb_flush_all_cpus_synced(CPUState *src_cpu);
  * MMU indexes.
  */
 void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
-                              uint16_t idxmap);
+                              MMUIdxMap idxmap);
 
 /**
  * tlb_flush_page_by_mmuidx_all_cpus_synced:
@@ -165,7 +165,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr,
  * translations using the flushed TLBs.
  */
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap);
+                                              MMUIdxMap idxmap);
 
 /**
  * tlb_flush_by_mmuidx:
@@ -176,7 +176,7 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
  * Flush all entries from the TLB of the specified CPU, for the specified
  * MMU indexes.
  */
-void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
+void tlb_flush_by_mmuidx(CPUState *cpu, MMUIdxMap idxmap);
 
 /**
  * tlb_flush_by_mmuidx_all_cpus_synced:
@@ -189,7 +189,7 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap);
  * When this function returns, no CPUs will subsequently perform
  * translations using the flushed TLBs.
  */
-void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
+void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, MMUIdxMap idxmap);
 
 /**
  * tlb_flush_page_bits_by_mmuidx
@@ -201,11 +201,11 @@ void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
  * Similar to tlb_flush_page_mask, but with a bitmap of indexes.
  */
 void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
-                                   uint16_t idxmap, unsigned bits);
+                                   MMUIdxMap idxmap, unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
 void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                                   uint16_t idxmap,
+                                                   MMUIdxMap idxmap,
                                                    unsigned bits);
 
 /**
@@ -220,14 +220,14 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
  * comparing only the low @bits worth of each virtual page.
  */
 void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                               vaddr len, uint16_t idxmap,
+                               vaddr len, MMUIdxMap idxmap,
                                unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                vaddr addr,
                                                vaddr len,
-                                               uint16_t idxmap,
+                                               MMUIdxMap idxmap,
                                                unsigned bits);
 #else
 static inline void tlb_flush_page(CPUState *cpu, vaddr addr)
@@ -243,42 +243,42 @@ static inline void tlb_flush_all_cpus_synced(CPUState *src_cpu)
 {
 }
 static inline void tlb_flush_page_by_mmuidx(CPUState *cpu,
-                                            vaddr addr, uint16_t idxmap)
+                                            vaddr addr, MMUIdxMap idxmap)
 {
 }
 
-static inline void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
+static inline void tlb_flush_by_mmuidx(CPUState *cpu, MMUIdxMap idxmap)
 {
 }
 static inline void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                             vaddr addr,
-                                                            uint16_t idxmap)
+                                                            MMUIdxMap idxmap)
 {
 }
 static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
-                                                       uint16_t idxmap)
+                                                       MMUIdxMap idxmap)
 {
 }
 static inline void tlb_flush_page_bits_by_mmuidx(CPUState *cpu,
                                                  vaddr addr,
-                                                 uint16_t idxmap,
+                                                 MMUIdxMap idxmap,
                                                  unsigned bits)
 {
 }
 static inline void
 tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
-                                              uint16_t idxmap, unsigned bits)
+                                              MMUIdxMap idxmap, unsigned bits)
 {
 }
 static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                                             vaddr len, uint16_t idxmap,
+                                             vaddr len, MMUIdxMap idxmap,
                                              unsigned bits)
 {
 }
 static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                              vaddr addr,
                                                              vaddr len,
-                                                             uint16_t idxmap,
+                                                             MMUIdxMap idxmap,
                                                              unsigned bits)
 {
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5eaf41a566..1153cadb70 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -198,10 +198,10 @@ struct CPUClass {
 };
 
 /*
- * Fix the number of mmu modes to 16, which is also the maximum
- * supported by the softmmu tlb api.
+ * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
+typedef uint16_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
@@ -306,7 +306,7 @@ typedef struct CPUTLBCommon {
      * mmu_idx N since the last time that mmu_idx was flushed.
      * Protected by tlb_c.lock.
      */
-    uint16_t dirty;
+     MMUIdxMap dirty;
     /*
      * Statistics.  These are not lock protected, but are read and
      * written atomically.  This allows the monitor to print a snapshot
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 87e14bde4f..d324f33339 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -370,8 +370,8 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
 
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
-    uint16_t asked = data.host_int;
-    uint16_t all_dirty, work, to_clean;
+    MMUIdxMap asked = data.host_int;
+    MMUIdxMap all_dirty, work, to_clean;
     int64_t now = get_clock_realtime();
 
     assert_cpu_is_self(cpu);
@@ -408,7 +408,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     }
 }
 
-void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
+void tlb_flush_by_mmuidx(CPUState *cpu, MMUIdxMap idxmap)
 {
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
@@ -422,7 +422,7 @@ void tlb_flush(CPUState *cpu)
     tlb_flush_by_mmuidx(cpu, ALL_MMUIDX_BITS);
 }
 
-void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, uint16_t idxmap)
+void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *src_cpu, MMUIdxMap idxmap)
 {
     const run_on_cpu_func fn = tlb_flush_by_mmuidx_async_work;
 
@@ -531,7 +531,7 @@ static void tlb_flush_page_locked(CPUState *cpu, int midx, vaddr page)
  */
 static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
                                              vaddr addr,
-                                             uint16_t idxmap)
+                                             MMUIdxMap idxmap)
 {
     int mmu_idx;
 
@@ -570,14 +570,14 @@ static void tlb_flush_page_by_mmuidx_async_1(CPUState *cpu,
 {
     vaddr addr_and_idxmap = data.target_ptr;
     vaddr addr = addr_and_idxmap & TARGET_PAGE_MASK;
-    uint16_t idxmap = addr_and_idxmap & ~TARGET_PAGE_MASK;
+    MMUIdxMap idxmap = addr_and_idxmap & ~TARGET_PAGE_MASK;
 
     tlb_flush_page_by_mmuidx_async_0(cpu, addr, idxmap);
 }
 
 typedef struct {
     vaddr addr;
-    uint16_t idxmap;
+    MMUIdxMap idxmap;
 } TLBFlushPageByMMUIdxData;
 
 /**
@@ -599,7 +599,7 @@ static void tlb_flush_page_by_mmuidx_async_2(CPUState *cpu,
     g_free(d);
 }
 
-void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, uint16_t idxmap)
+void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, MMUIdxMap idxmap)
 {
     tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%" PRIx16 "\n", addr, idxmap);
 
@@ -618,7 +618,7 @@ void tlb_flush_page(CPUState *cpu, vaddr addr)
 
 void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                               vaddr addr,
-                                              uint16_t idxmap)
+                                              MMUIdxMap idxmap)
 {
     tlb_debug("addr: %016" VADDR_PRIx " mmu_idx:%"PRIx16"\n", addr, idxmap);
 
@@ -715,8 +715,8 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
 typedef struct {
     vaddr addr;
     vaddr len;
-    uint16_t idxmap;
-    uint16_t bits;
+    MMUIdxMap idxmap;
+    unsigned bits;
 } TLBFlushRangeData;
 
 static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
@@ -766,7 +766,7 @@ static void tlb_flush_range_by_mmuidx_async_1(CPUState *cpu,
 }
 
 void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                               vaddr len, uint16_t idxmap,
+                               vaddr len, MMUIdxMap idxmap,
                                unsigned bits)
 {
     TLBFlushRangeData d;
@@ -797,7 +797,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 }
 
 void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
-                                   uint16_t idxmap, unsigned bits)
+                                   MMUIdxMap idxmap, unsigned bits)
 {
     tlb_flush_range_by_mmuidx(cpu, addr, TARGET_PAGE_SIZE, idxmap, bits);
 }
@@ -805,7 +805,7 @@ void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                                vaddr addr,
                                                vaddr len,
-                                               uint16_t idxmap,
+                                               MMUIdxMap idxmap,
                                                unsigned bits)
 {
     TLBFlushRangeData d, *p;
@@ -847,7 +847,7 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 
 void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                                    vaddr addr,
-                                                   uint16_t idxmap,
+                                                   MMUIdxMap idxmap,
                                                    unsigned bits)
 {
     tlb_flush_range_by_mmuidx_all_cpus_synced(src_cpu, addr, TARGET_PAGE_SIZE,
-- 
2.43.0


