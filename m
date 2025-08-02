Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6F2C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjj-0005Cg-34; Sat, 02 Aug 2025 19:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhx-0000MB-Uo
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:10 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLhv-00058n-1T
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:09 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-306ab3a49d6so1700801fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177526; x=1754782326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzErdxa6ZkVBa6lEBDxGiyKzAGuLJ7HYtDGlIeknl/c=;
 b=JO2ugnLM/HnSN4qFIufPutaGyuha/OtYDjhhxg/pJRGSbMz4HjkoC6/WYhr9h9TaTj
 Kt51NgUXgO2k6A5m+rv5uiRb0zcO8SB9bUac/ibbdJwBWzQHHx8aA1gX1pPoNhg6eLzH
 noSqkLmFqMRxb6isQOn1BepOjbDP1xCTp0unVaOrPneuOpPqcGMhIIxnhIvO7G3GqFTZ
 ENaSPf4BYZdrm8dIiDBIUhJMMWohfsiIAdCOwPq2F8fcwJWjZnjn4vhyMehNj2WA0rGF
 2d0UhUH+Fn+hR3BhncE2ckLUZPGCLFTEtstEtD9gncxut4NCafLOuwzFRXLBOXupb3dj
 Tikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177526; x=1754782326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzErdxa6ZkVBa6lEBDxGiyKzAGuLJ7HYtDGlIeknl/c=;
 b=ijHaRLv2SIDnaWiueZ/7keDvW3T73jIQrY8F5MvfDp+PCIfPlmBR16h9tT/E+EkNuG
 5RJLSY1WaQjOYYWp8aFo+qsY+G+LVvHrRrKag+WLLiaKj3XAIFpJ1kH7sduYwOw5L8OE
 S6k9VNu5YLPkxYbC0C0pHWXH+jk79nf7uLeUmwtSl+lgRMpItJVBs0B8aD6ASHkkO+y5
 MSKKld5rSP2sSYHM62gDvar8qeftJ5vEUxtmfcL6TvgXkwCer7xS1quygwPjxrURpolf
 7ebsHfnBn16XTqIp1DUJojYSINrsUdWcd8PFG4r9IkktZlkY5u87eupOlWAX0wfUEbKX
 nJfg==
X-Gm-Message-State: AOJu0Yz46xLlZzY8BG+O7VBELiX6CwrArW6oFfL6lfAGql6P5Q6vrenE
 oB72dohFx0PhZDVwH8tLa1Cu6OMAN0k40QUj7fjxFjfsRAcIAL6mq5fmyiwTt4Haok0i4ji5xeV
 tAbX66M8=
X-Gm-Gg: ASbGnct8p/NAuhHZVrdbcFWHNAULJ33lbm6nR2aZ5eF6+lGS6BTKBcZcaK9t+AvEIz0
 Uv4lMEm1804KU1UbOdT7AZIsyAYJjXI2Q9vErSSiBmEhwqCf0yFlNacmAeT3lxaet70CNI4bW1D
 9mlu0T+08ZhuPUAVEzDdSoQDNpzEc19jsyHN3cZmLpIopYaNn99C/z97rHfeDs0bizrv+XawdFz
 HGCzhpGTl4zN0ai+sWSyttTkhEYc6Y1o43hURbNXd1QCKjeyVjzpVsdO+TvdeXjxQlXiwVC45ov
 ibSAPoWRRoffgBWzVT6tYVCJf0ZjrDdhOPbT5vRr5fa4rLR3e6rkeTY4JCtU8z/wJV2DNCAp4ML
 9lfScFO/lXQlDhYxpNxuSQudtjbxBxpOsW/iQ0vbHO/L/Q/mVBVUc
X-Google-Smtp-Source: AGHT+IFabHbZna1wCkhqDYho3vGAjEVs5ROn8GoK32k8ZlhkFez80kjZ4QttaZQQx0DVWc62KnXdcg==
X-Received: by 2002:a05:6870:79e:b0:308:fc2b:b77 with SMTP id
 586e51a60fabf-30b679e60f9mr2253678fac.40.1754177525588; 
 Sat, 02 Aug 2025 16:32:05 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 26/85] include/hw/core/cpu: Introduce MMUIdxMap
Date: Sun,  3 Aug 2025 09:28:54 +1000
Message-ID: <20250802232953.413294-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


