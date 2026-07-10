Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C7EC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIKB-0002Zd-Ki; Fri, 10 Jul 2026 16:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIS-0000yZ-1b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:13 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIE-0001yK-4t
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:07 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1141625a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717072; x=1784321872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KpnTdJpquXSGqeXOM/ODDLLKulghlNdrEhAgoBJAG/g=;
 b=O4odXN0/2FJ2BI+krkEQzvAGSglPW4QlsfSykLmYMmLjnt0CoZ7ScRcI/kgFhQInIQ
 04OY0JmsXsoUY8+Wz5ze5ZTiEgFy7veAmgwkMp3aL5CD+1iVzmBuzZhjoML+e/4zKg4q
 9ajILiGTEFtCnX0yK89dBsKxowbQFLKaDKxDlVYnNHrerAb3OMc+/pk66dFNJrWKwXk0
 bkW/ImIQkHDvNa/17rbtAKddFcZIg/5QAUMRa9abldb5x6RzrjxabduL7l0VwaPIxzTp
 de+UJ6yofvcr/xNZAEeCJLrScp5mMGJveccugz3SEp9GItqgoQ7uvTV1b6Tf05lLLsVF
 Xnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717072; x=1784321872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KpnTdJpquXSGqeXOM/ODDLLKulghlNdrEhAgoBJAG/g=;
 b=lUaD4ypDV89tNq80f2+haSasQe2TKsdMYkccOs2UIt8H3qzA8a80jSjMTC5ICzwCOA
 9IdNNnmNld9uSVYygSdMKsx2qgkWpB+5z+Mbf2Y46X5KIM/237jbo6uEnON9ZKRHSuZ3
 abfkRmr2ymLkYYkzkaM7jROfVrhMe6CN3NlhSJ6ogNCze5O11GiDCFC9IC61dqGWJ55L
 PjeFi6LHgXP1W8j80CTSlILO2hzdAoGrWluc+KFfXT7NHz9j7vD9LqKwL371hcfFU3gn
 2wTk2SyyZ/ezBw1pNxYuYDAPjqJGi4OJOuSe0Cv9BVJ4tEcseGixh53ogiiEXwHIClRN
 n2Rw==
X-Gm-Message-State: AOJu0YxvCS0oM1UqXecHLjN5+HrRKjEbPMr7y4yGbdTjHsBD/mChC5KJ
 YceVgTZQ8AbWv58G9ag4hyLkuGV7ceAaz6BBcwkNVB29yDF+ZiYiEmdOFFc4o0bDJfMJgqxLW6n
 BvBs4
X-Gm-Gg: AfdE7cl9cpSzhSGC/r+yRBlf85JkVaTj+VyTXYiHluH4vVVhqcyimV1M/hInN24gYvq
 5R4acHN2rWt/LfTfavSkWhtdv8HrF9SaxWJcsdCYRMVwjEg5RDO3CfqIXJbJyDf0zKOvoEJmdgM
 9ype7DJ9h9ymTHGicEG9f3LFAVkXl6fASnC2puyexZUJ+31bhnAicxNOrSPtfgwtU0ScdJHyl3q
 cSjCebGpTLo5hhR7qUxswmPQ5sPNOibwqH/2sEupRmqn0zGsXxACTPJcDKIHG3ADQZw0bhDL5Sm
 X7Mg2gj6MpJXmqYF7mI9fgORZ7GIOd2FjQWR+4sPaPJpIixC22UQl8dhs2kBy/2LgYd8SCsFLBW
 7gPjD2KvIpQvepa2DWRWnT8Ngpsw5WgSVxluuSOHVCnluf6xvVu/LaqSDinA1mhR6vPahh7lR8g
 TeKc1L3PKMzhFqyOvXi/QxlufPn0h+
X-Received: by 2002:a17:90b:164b:b0:37f:ceed:e1d8 with SMTP id
 98e67ed59e1d1-38dc7730cbdmr483202a91.12.1783717072370; 
 Fri, 10 Jul 2026 13:57:52 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 49/51] accel/tcg: Change tlb_flush_range_* to use addr/last
Date: Fri, 10 Jul 2026 13:53:59 -0700
Message-ID: <20260710205401.836304-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Plugs a hole in the API by which one cannot flush the
entire address space with one range.  There are only a
few users, so it's easy to update them all at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cputlb.h             | 12 ++++++------
 accel/tcg/cputlb.c                | 27 ++++++++++++++++-----------
 target/arm/tcg/tlb-insns.c        | 21 +++++++++++----------
 target/hppa/mem_helper.c          |  3 +--
 target/loongarch/tcg/tlb_helper.c |  5 +++--
 target/ppc/mmu_helper.c           |  4 ++--
 6 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
index f7f7020382..30e1d1f93e 100644
--- a/include/exec/cputlb.h
+++ b/include/exec/cputlb.h
@@ -209,21 +209,21 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
  * tlb_flush_range_by_mmuidx
  * @cpu: CPU whose TLB should be flushed
  * @addr: virtual address of the start of the range to be flushed
- * @len: length of range to be flushed
+ * @last: virtual address of the end of the range to be flushed, inclusive
  * @idxmap: bitmap of mmu indexes to flush
  * @bits: number of significant bits in address
  *
- * For each mmuidx in @idxmap, flush all pages within [@addr,@addr+@len),
+ * For each mmuidx in @idxmap, flush all pages within [@addr,@last]
  * comparing only the low @bits worth of each virtual page.
  */
 void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                               vaddr len, MMUIdxMap idxmap,
+                               vaddr last, MMUIdxMap idxmap,
                                unsigned bits);
 
 /* Similarly, with broadcast and syncing. */
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                vaddr addr,
-                                               vaddr len,
+                                               vaddr last,
                                                MMUIdxMap idxmap,
                                                unsigned bits);
 #else
@@ -268,13 +268,13 @@ tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *cpu, vaddr addr,
 {
 }
 static inline void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                                             vaddr len, MMUIdxMap idxmap,
+                                             vaddr last, MMUIdxMap idxmap,
                                              unsigned bits)
 {
 }
 static inline void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                              vaddr addr,
-                                                             vaddr len,
+                                                             vaddr last,
                                                              MMUIdxMap idxmap,
                                                              unsigned bits)
 {
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2c0f7bed52..0a49b87bcb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -761,13 +761,12 @@ static void tlb_flush_range_by_mmuidx_async_1(CPUState *cpu,
     g_free(d);
 }
 
-void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
-                               vaddr len, MMUIdxMap idxmap,
-                               unsigned bits)
+void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr, vaddr last,
+                               MMUIdxMap idxmap, unsigned bits)
 {
     TLBFlushRangeData d = {
         .addr = addr & TARGET_PAGE_MASK,
-        .last = (addr + len - 1) & TARGET_PAGE_MASK,
+        .last = last & TARGET_PAGE_MASK,
         .idxmap = idxmap,
         .bits = bits,
     };
@@ -795,18 +794,20 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 void tlb_flush_page_bits_by_mmuidx(CPUState *cpu, vaddr addr,
                                    MMUIdxMap idxmap, unsigned bits)
 {
-    tlb_flush_range_by_mmuidx(cpu, addr, TARGET_PAGE_SIZE, idxmap, bits);
+    /*
+     * The implementation above only cares about the page of @last,
+     * so we don't need to find the end of the page for @addr.
+     */
+    tlb_flush_range_by_mmuidx(cpu, addr, addr, idxmap, bits);
 }
 
 void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
-                                               vaddr addr,
-                                               vaddr len,
-                                               MMUIdxMap idxmap,
-                                               unsigned bits)
+                                               vaddr addr, vaddr last,
+                                               MMUIdxMap idxmap, unsigned bits)
 {
     TLBFlushRangeData d = {
         .addr = addr & TARGET_PAGE_MASK,
-        .last = (addr + len - 1) & TARGET_PAGE_MASK,
+        .last = last & TARGET_PAGE_MASK,
         .idxmap = idxmap,
         .bits = bits,
     };
@@ -847,7 +848,11 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
                                                    MMUIdxMap idxmap,
                                                    unsigned bits)
 {
-    tlb_flush_range_by_mmuidx_all_cpus_synced(src_cpu, addr, TARGET_PAGE_SIZE,
+    /*
+     * The implementation above only cares about the page of @last,
+     * so we don't need to find the end of the page for @addr.
+     */
+    tlb_flush_range_by_mmuidx_all_cpus_synced(src_cpu, addr, addr,
                                               idxmap, bits);
 }
 
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index b24eb57788..cf1698941c 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -819,7 +819,7 @@ static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
 
 typedef struct {
     uint64_t base;
-    uint64_t length;
+    uint64_t last;
 } TLBIRange;
 
 static ARMGranuleSize tlbi_range_tg_to_gran_size(int tg)
@@ -847,8 +847,8 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     /* Extract one bit to represent the va selector in use. */
     uint64_t select = sextract64(value, 36, 1);
     ARMVAParameters param = aa64_va_parameters(env, select, mmuidx, true, false);
-    TLBIRange ret = { };
     ARMGranuleSize gran;
+    uint64_t base, length;
 
     page_size_granule = extract64(value, 46, 2);
     gran = tlbi_range_tg_to_gran_size(page_size_granule);
@@ -857,7 +857,8 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     if (gran != param.gran || gran == GranInvalid) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
                       page_size_granule);
-        return ret;
+        /* The behaviour of the insn is undefined. */
+        return (TLBIRange) { 0, 0 };
     }
 
     page_shift = arm_granule_bits(gran);
@@ -865,12 +866,12 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     scale = extract64(value, 44, 2);
     exponent = (5 * scale) + 1;
 
-    ret.length = (num + 1) << (exponent + page_shift);
+    length = (num + 1) << (exponent + page_shift);
 
     if (param.select) {
-        ret.base = sextract64(value, 0, 37);
+        base = sextract64(value, 0, 37);
     } else {
-        ret.base = extract64(value, 0, 37);
+        base = extract64(value, 0, 37);
     }
     if (param.ds) {
         /*
@@ -880,9 +881,9 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
          */
         page_shift = 16;
     }
-    ret.base <<= page_shift;
+    base <<= page_shift;
 
-    return ret;
+    return (TLBIRange){ .base = base, .last = base + length - 1 };
 }
 
 static void do_rvae_write(CPUARMState *env, uint64_t value,
@@ -898,12 +899,12 @@ static void do_rvae_write(CPUARMState *env, uint64_t value,
     if (synced) {
         tlb_flush_range_by_mmuidx_all_cpus_synced(env_cpu(env),
                                                   range.base,
-                                                  range.length,
+                                                  range.last,
                                                   idxmap,
                                                   bits);
     } else {
         tlb_flush_range_by_mmuidx(env_cpu(env), range.base,
-                                  range.length, idxmap, bits);
+                                  range.last, idxmap, bits);
     }
 }
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 01e6149c81..394e975533 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -106,8 +106,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
     trace_hppa_tlb_flush_ent(env, ent, ent->itree.start,
                              ent->itree.last, ent->pa);
 
-    tlb_flush_range_by_mmuidx(cs, ent->itree.start,
-                              ent->itree.last - ent->itree.start + 1,
+    tlb_flush_range_by_mmuidx(cs, ent->itree.start, ent->itree.last,
                               HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
 
     /* Never clear BTLBs, unless forced to do so. */
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index a4b90beca6..3a708ebf3a 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -130,13 +130,14 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
 
     tlb_v = pte_present(env, tlb->tlb_entry0);
     if (tlb_v) {
-        tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
+        tlb_flush_range_by_mmuidx(env_cpu(env), addr, addr + pagesize - 1,
                                   idxmap, TARGET_LONG_BITS);
     }
 
     tlb_v = pte_present(env, tlb->tlb_entry1);
     if (tlb_v) {
-        tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
+        tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize,
+                                  addr + 2 * pagesize - 1,
                                   idxmap, TARGET_LONG_BITS);
     }
 }
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index ac60705402..c881191749 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -734,8 +734,8 @@ static void ppcemb_tlb_flush(CPUState *cs, ppcemb_tlb_t *tlb)
         mmu_idx <<= 2;
     }
 
-    tlb_flush_range_by_mmuidx(cs, tlb->EPN, tlb->size, mmu_idx,
-                              TARGET_LONG_BITS);
+    tlb_flush_range_by_mmuidx(cs, tlb->EPN, tlb->EPN + tlb->size - 1,
+                              mmu_idx, TARGET_LONG_BITS);
 }
 
 void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
-- 
2.43.0


