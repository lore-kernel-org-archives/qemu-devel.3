Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C88C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBEx-0001pS-4r; Mon, 19 Aug 2024 18:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBE0-0000Sv-Se
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBDx-0000gP-MF
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37182eee02dso2551176f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107898; x=1724712698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7OiajvUnedKpMidKrs6amtZmafu3g3RvoaYWNpbOxM=;
 b=ytpHSYRW+xglkcWV22WOLrlTASBcRUqjsdkYxqkBJAhYlGRj7moZx4O/mQRHMwv0KD
 M2UKbde9TfKh3XeidvtoTcwbQnAqmTlgftQ+4M/c+QCjXcemn0KzdxJb1/m6xcYcbgiV
 ezki/Nk6uqMz+tirc9qjCL3hMcxk1kSJNrbS4HFGYnyntYK91UDozRW96xilw7WFNcCI
 K16Trk2E7Xb7l6shqK9OFA1OK079bwV2ogprvUXo+DUuuuN9ecW+9lDMXKkDshNsXscy
 Z62aiB8tn0I4ZD+MgJ8b13UArYVzLFn2WB76ROY9ihiNvPRFp5wTZEOSOYXPuLVBUL0l
 GcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107898; x=1724712698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7OiajvUnedKpMidKrs6amtZmafu3g3RvoaYWNpbOxM=;
 b=PwMDpZJCz387qPlvT/+vUTSfLjO2LzF95WeLLD0ZzZUD3+FK9jzUUSF+F+fCZCe6sS
 DFvTWHByC8e20UitkTX2wTqtsMJU9+GdnHcSKg/WHBr3tvuWgoIbPejq84/umm8f9GT/
 uS4ECUjXIb9UqCXmIdquSDczdN7nWIqzGi4eEEgj5Os7vhoGjxu9IM7/Rt1n43YT6jiI
 25hceNoLJm/az6eiPMFsyHsVN+9Ygm9y6iIVdkudBoiP2hN6+5EMRTbhJzFb3623nfd6
 5BC1VcDv80eZefroH2nbv81l0Et+BaTUkHKogH1+aCvnFFaNpghfb1dGEdFCM5Z+haS+
 bJuQ==
X-Gm-Message-State: AOJu0YyyzdJiP4ezT2Gc6BBTz/W8ZyxwRfuhkCfdTZYdPa1/KZbBJ3eu
 oXn4pepEs5ZZqN11hsMNXoGlGSnzF2dyqGkD5o2gxUwBe+GIUXSWVUmz2R9dguvAvlj2F6e6M/V
 BIrI=
X-Google-Smtp-Source: AGHT+IGJ/6BQN7EHB0Vjds3FAJVLjOJS3T5dkTnXgVuQZGUQm5fmFCzRlNOkWS7znc5i4oHJnZT+Gg==
X-Received: by 2002:a5d:5144:0:b0:36b:ea2d:fd5a with SMTP id
 ffacd0b85a97d-371c4ab1d82mr487659f8f.22.1724107897592; 
 Mon, 19 Aug 2024 15:51:37 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189896bf0sm11537030f8f.73.2024.08.19.15.51.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/20] target/mips: Pass page table entry size as MemOp to
 get_pte()
Date: Tue, 20 Aug 2024 00:51:00 +0200
Message-ID: <20240819225116.17928-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to simplify the next commit, pass the PTE size as MemOp.

Rename:

  native_shift -> native_op
  directory_shift -> directory_mop
  leaf_shift -> leaf_mop

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240814090452.2591-2-philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 58 ++++++++++++++---------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 3ba6d369a6..60147ba0af 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -592,13 +592,13 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
  * resulting in a TLB or XTLB Refill exception.
  */
 
-static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
+static bool get_pte(CPUMIPSState *env, uint64_t vaddr, MemOp op,
         uint64_t *pte)
 {
-    if ((vaddr & ((entry_size >> 3) - 1)) != 0) {
+    if ((vaddr & (memop_size(op) - 1)) != 0) {
         return false;
     }
-    if (entry_size == 64) {
+    if (op == MO_64) {
         *pte = cpu_ldq_code(env, vaddr);
     } else {
         *pte = cpu_ldl_code(env, vaddr);
@@ -607,8 +607,9 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
 }
 
 static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
-        int entry_size, int ptei)
+                                     MemOp op, int ptei)
 {
+    unsigned entry_size = memop_size(op) << 3;
     uint64_t result = entry;
     uint64_t rixi;
     if (ptei > entry_size) {
@@ -624,14 +625,12 @@ static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
 static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         int directory_index, bool *huge_page, bool *hgpg_directory_hit,
         uint64_t *pw_entrylo0, uint64_t *pw_entrylo1,
-        unsigned directory_shift, unsigned leaf_shift, int ptw_mmu_idx)
+        MemOp directory_mop, MemOp leaf_mop, int ptw_mmu_idx)
 {
     int dph = (env->CP0_PWCtl >> CP0PC_DPH) & 0x1;
     int psn = (env->CP0_PWCtl >> CP0PC_PSN) & 0x3F;
     int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
     int pf_ptew = (env->CP0_PWField >> CP0PF_PTEW) & 0x3F;
-    uint32_t direntry_size = 1 << (directory_shift + 3);
-    uint32_t leafentry_size = 1 << (leaf_shift + 3);
     uint64_t entry;
     uint64_t paddr;
     int prot;
@@ -643,14 +642,14 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         /* wrong base address */
         return 0;
     }
-    if (!get_pte(env, *vaddr, direntry_size, &entry)) {
+    if (!get_pte(env, *vaddr, directory_mop, &entry)) {
         return 0;
     }
 
     if ((entry & (1 << psn)) && hugepg) {
         *huge_page = true;
         *hgpg_directory_hit = true;
-        entry = get_tlb_entry_layout(env, entry, leafentry_size, pf_ptew);
+        entry = get_tlb_entry_layout(env, entry, leaf_mop, pf_ptew);
         w = directory_index - 1;
         if (directory_index & 0x1) {
             /* Generate adjacent page from same PTE for odd TLB page */
@@ -658,7 +657,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
             *pw_entrylo0 = entry & ~lsb; /* even page */
             *pw_entrylo1 = entry | lsb; /* odd page */
         } else if (dph) {
-            int oddpagebit = 1 << leaf_shift;
+            int oddpagebit = 1 << leaf_mop;
             uint64_t vaddr2 = *vaddr ^ oddpagebit;
             if (*vaddr & oddpagebit) {
                 *pw_entrylo1 = entry;
@@ -669,10 +668,10 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
                                      ptw_mmu_idx) != TLBRET_MATCH) {
                 return 0;
             }
-            if (!get_pte(env, vaddr2, leafentry_size, &entry)) {
+            if (!get_pte(env, vaddr2, leaf_mop, &entry)) {
                 return 0;
             }
-            entry = get_tlb_entry_layout(env, entry, leafentry_size, pf_ptew);
+            entry = get_tlb_entry_layout(env, entry, leaf_mop, pf_ptew);
             if (*vaddr & oddpagebit) {
                 *pw_entrylo0 = entry;
             } else {
@@ -711,7 +710,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
 
     /* Native pointer size */
     /*For the 32-bit architectures, this bit is fixed to 0.*/
-    int native_shift = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? 2 : 3;
+    MemOp native_op = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? MO_32 : MO_64;
 
     /* Indices from PWField */
     int pf_gdw = (env->CP0_PWField >> CP0PF_GDW) & 0x3F;
@@ -728,11 +727,10 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
 
     /* Other HTW configs */
     int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
-    unsigned directory_shift, leaf_shift;
+    MemOp directory_mop, leaf_mop;
 
     /* Offsets into tables */
     unsigned goffset, uoffset, moffset, ptoffset0, ptoffset1;
-    uint32_t leafentry_size;
 
     /* Starting address - Page Table Base */
     uint64_t vaddr = env->CP0_PWBase;
@@ -759,23 +757,21 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
     }
 
     /* HTW Shift values (depend on entry size) */
-    directory_shift = (hugepg && (ptew == 1)) ? native_shift + 1 : native_shift;
-    leaf_shift = (ptew == 1) ? native_shift + 1 : native_shift;
+    directory_mop = (hugepg && (ptew == 1)) ? native_op + 1 : native_op;
+    leaf_mop = (ptew == 1) ? native_op + 1 : native_op;
 
-    goffset = gindex << directory_shift;
-    uoffset = uindex << directory_shift;
-    moffset = mindex << directory_shift;
-    ptoffset0 = (ptindex >> 1) << (leaf_shift + 1);
-    ptoffset1 = ptoffset0 | (1 << (leaf_shift));
-
-    leafentry_size = 1 << (leaf_shift + 3);
+    goffset = gindex << directory_mop;
+    uoffset = uindex << directory_mop;
+    moffset = mindex << directory_mop;
+    ptoffset0 = (ptindex >> 1) << (leaf_mop + 1);
+    ptoffset1 = ptoffset0 | (1 << (leaf_mop));
 
     /* Global Directory */
     if (gdw > 0) {
         vaddr |= goffset;
         switch (walk_directory(env, &vaddr, pf_gdw, &huge_page, &hgpg_gdhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift, ptw_mmu_idx))
+                               directory_mop, leaf_mop, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -792,7 +788,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         vaddr |= uoffset;
         switch (walk_directory(env, &vaddr, pf_udw, &huge_page, &hgpg_udhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift, ptw_mmu_idx))
+                               directory_mop, leaf_mop, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -809,7 +805,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         vaddr |= moffset;
         switch (walk_directory(env, &vaddr, pf_mdw, &huge_page, &hgpg_mdhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift, ptw_mmu_idx))
+                               directory_mop, leaf_mop, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -827,10 +823,10 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
                              ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
-    if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
+    if (!get_pte(env, vaddr, leaf_mop, &dir_entry)) {
         return false;
     }
-    dir_entry = get_tlb_entry_layout(env, dir_entry, leafentry_size, pf_ptew);
+    dir_entry = get_tlb_entry_layout(env, dir_entry, leaf_mop, pf_ptew);
     pw_entrylo0 = dir_entry;
 
     /* Leaf Level Page Table - Second half of PTE pair */
@@ -839,10 +835,10 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
                              ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
-    if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
+    if (!get_pte(env, vaddr, leaf_mop, &dir_entry)) {
         return false;
     }
-    dir_entry = get_tlb_entry_layout(env, dir_entry, leafentry_size, pf_ptew);
+    dir_entry = get_tlb_entry_layout(env, dir_entry, leaf_mop, pf_ptew);
     pw_entrylo1 = dir_entry;
 
 refill:
-- 
2.45.2


