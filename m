Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3753BCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbq-0004q7-4t; Mon, 22 Sep 2025 14:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbo-0004oQ-3E
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbf-00047u-PQ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:55 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso3910917b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566985; x=1759171785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxAP5qFgcbJbR3OKukr3gh9u6b8be93wd3OS1SsOQv8=;
 b=PyCTedMg5P1ZVFxHyqhV184OQulNBudZY2SeX+SS+F+oVI6XKwusZgixpaXIEJvYLf
 rzjN0+d6WnTXByL8ScevhkDoJFoolUzdYxdmUhPOwkOM4xreWFSf/7R49BQy5aKULzUd
 n5ITEk9u8aPqpP00dAAUxLgxlRGI7yLVrOUEjGVCndOxIWuXtVtiyU/njxgJA0M4bQio
 Pz9IAhOs0m3PK59gzAyAIq1mqmQx/vRF7pBkxEHadjOHxr1vVOfQ1wc5Ii1QllFeKIO/
 SVkv6qUlqipQi8FPP/0Q5NDFRVnGSxol8NKaOFxt8EQUukGcR5l0GGa8jJPPiFocGDnG
 NVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566985; x=1759171785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxAP5qFgcbJbR3OKukr3gh9u6b8be93wd3OS1SsOQv8=;
 b=PxVwl8IY+pf+QvcbaW4gdrBwFbTK4jfEBa9xEOThst6jKfExO3ITghumlwSjQ1v2ad
 5/PXCkY+slOAbAPZ78sstC5k0Y8GXcDwhrokhAKCw80uK+o6IjnvWnR8Jo54Hb7knQtW
 ktnO/OyTKOJZq+MjUaXeMI4ULq277WKXcXegR8V9+6WTdIltRYihGyz/fky7zSA7BnCQ
 jf5pmeoBXK/ZogszJkBmWsOWweDNi3gpZvFXIGL8qribZ34d2J3XysH6hIb9f2M251yn
 8u/RNesU8Mcf0EThOtaVNeMMAfh4ys39O0kV1l6xpAcgeBMsEib9PVmc9hkfFVk1Rsgb
 XjaQ==
X-Gm-Message-State: AOJu0YyXBwsNUn6SDa0kbmRB57VQAe53f5HNykkYYWx2HBG/RwKPx4yh
 zFGfyRW0D7wCiHzSSiIafd2XcGsCHbVLgxluP1w46jf1szPA0tNcTAA5Zg6bVUNvqzMokTgQTgS
 iuw+N
X-Gm-Gg: ASbGncs/1RRlABBZT1NiHNQfv1pBzmpjJR9fy8k3mmCsRmGV/fXMCtPWiPl3JZ2bJs6
 j9Q66VB7BbuF5esrhuJlw8ljbfB0zsyxW1t0BrwtEKhZqFa7YZn9YlF4ry9otceqqbUjfD71HlA
 p+5XZA/GVoM3mLfQGzH2EvWzXgj2aLQT2PakmpAtX1EW9tovnNN0Xrk5FOVcnBO2IFgr42xRbuA
 DYoaOb3Vs/Ae8uwb9P4sZrV6W31Hyb7c7ovnbp2ZSCGDECcnm/l7sH9gdWJFFM2dqFApbOLpxVI
 7P1Ctn6JMDEyk3m2smOPRMi95rvZwDg3ui2ZUkBpTKIDD4d65SCeFCPbsWPh2NVvuylLurriARX
 CghD9lKHAV06K1xegLDzvpozgohHmJRX+PSOZqhs=
X-Google-Smtp-Source: AGHT+IEeiHCt4dAEYJqkiBHlqD3yDF9rneUTY97nxwQHwCh9FZze5ex0WsL72T+SgScsy2L+Eczdxg==
X-Received: by 2002:a05:6a20:7f95:b0:244:aefe:71fa with SMTP id
 adf61e73a8af0-2cff367ed2cmr91748637.37.1758566985046; 
 Mon, 22 Sep 2025 11:49:45 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 13/76] include/hw/core/cpu: Introduce MMUIdxMap
Date: Mon, 22 Sep 2025 11:48:21 -0700
Message-ID: <20250922184924.2754205-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Use a typedef instead of uint16_t directly when
describing sets of mmu indexes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index b01a0cffd6..a7038b8c07 100644
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
+    MMUIdxMap dirty;
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


