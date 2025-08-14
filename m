Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B6FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXZ7-00031X-6n; Thu, 14 Aug 2025 09:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYR-00026Z-10
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:40 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYJ-0004N5-FE
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:38 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b4717390ad7so539303a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176366; x=1755781166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Ree5Gpr8l0LtLySxeEcXv5FgIq91JPtdUEJ2fumBaw=;
 b=IxbULsdLoPUL4ytjL9ChWBmt0YFHXbCWRF81LTedGdUoZxxq4MfGpquJHFDh9Q0wBw
 vb3UxLCP9gNVIQQzD+uvX2NyrkRAMKQJbxkDDg3udsveC60cJncNt5anLEKL8p41amh5
 37QhgWOQHwcXCRl5+z+7SKD8/whK1d7zmIvM1GyWVtGQMO/MNv2+L4kfoqmEIjjH/Z4c
 b4r2ONGLU5ZERv17gB2tL6bMC5i+HzfVwbNIviS/14m2pWhYmIVNJr7xw8wZdsB+E8XY
 9/ge4CYtu1KHUHVT4vZkVDqfO1r+2lp9LHaR6hGP/3CLYPJ0BrJ57UlB5a6KBsna4CZ2
 uxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176366; x=1755781166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Ree5Gpr8l0LtLySxeEcXv5FgIq91JPtdUEJ2fumBaw=;
 b=nqOHIHoRNckwvhV4L0A8yTcTjXdMPHd1lhN/TYEuyKOnD2k1YsKtf0cHyGvfA8wEo6
 1hWsG5/5TOS4K5QW7H0MmpP7sVy/1DwabTucfhFZOll1GMqe7T/AtGEp1MxdQFeVkkG8
 7lMHTvxXNYdcRnWEFN70pjscbp63Z4DavYyH5IHCMyG+NfFgmQu/eOEL+ELseF4Gyfva
 eBCFNE89uPCITu1FzUABssASat/SxpfU9JE4uE2BXlOZ1MFqhkmHZy3GlrMD2eRxw4ZY
 YeTIONkcIqK7iW1RW8U6/ep249od2YKImxDl6YnXZO4jrePtAnMb/4Tz3n6TuZ2thOdE
 4jYw==
X-Gm-Message-State: AOJu0YwjQIBfM5/FUMCVDkN55r4ox4XNH8a+8eXbfgodNc+lylM44f3u
 /oAQj3uktNUflReL42W2eH9lXoNNek+W2r7y8fQ1gcsEHeD2KAle0LtONfJ3yfX2XDuAsl6MDw/
 LSaPxumI=
X-Gm-Gg: ASbGncsesaIAXzDykQUOaaGjUgfLHSvW6RnkhahFzdB4920ZnQa8qepU+Pnk+idiqLj
 3CrpC/IeMvi5tGOxj8zEZFNjq5TeQQfv5hxV+zBRJzTv2alK6ZaAxDDn3tm8s6UeRin5qXlmLKX
 JZO4CIS7kYYoUWm5FKUA8JSEA4qWEXY4muoRrQiXdUQoFHqoJEYQWQuRP3ZtaqeAUVeRJnCDwd9
 MfuNkAia3+NzFdWCjtMqnvYmLLUWmBbKHfn3WoDoYlaB2vrlLro4G/RGjYXVCzYBWXE3JRdARtU
 r0SbgCGalAoM9khgkWhdWmzMGOHWrAmVKJXgQsK25YYlF7Fs4e+LDBoSBVWDCFQ2bzrYwvLML8a
 BL9dMHkpy6QKUsV7el0bUQdDdtlMJ8WYf7Bgk0l40M3+DnR0=
X-Google-Smtp-Source: AGHT+IFbWZ3puoFHM6gtSEMrTveevwnOvjH+Ha30d9pT0d2nkhq3/6B4lSQydzrkgQWjYd3tlYU2aA==
X-Received: by 2002:a17:902:e78f:b0:240:3c62:6194 with SMTP id
 d9443c01a7336-244584f5206mr41555695ad.20.1755176365473; 
 Thu, 14 Aug 2025 05:59:25 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 26/85] include/hw/core/cpu: Introduce MMUIdxMap
Date: Thu, 14 Aug 2025 22:56:53 +1000
Message-ID: <20250814125752.164107-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


