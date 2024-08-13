Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DACC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdry9-0002ro-5V; Tue, 13 Aug 2024 09:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdry6-0002r2-Rc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:53:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdry3-0007pl-Qm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:53:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5bb85e90ad5so4722835a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723557222; x=1724162022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ocxt7oZAAz9BMDOpj25prag5V4EF45wznl+mYkNEXLQ=;
 b=mJTlmzeq+gmq2j97MuOZJh+zBpKWjhLiNzef+qTdG+EdLwQA+9rF6N1F/EdRqp1ouJ
 9fN0yeMu4snJSgAv7rhDXBf7zz7VIfL4aIkqg/va1irGXj15iZXGR9qOSV04LDs2JwyX
 LrHJ2/4U5/9QrSUV1aNE4tsRNDa7R32bQSmiFlbcy3VqUf1DOx7+8PXy6BXZr2TFb1fZ
 Z+nyr9Z2onTX+1lSe/2Iji1Bx+00vihxtHmHnPwWKhIiDHuBryObZHbIGk9ydNGRyvot
 ByhMg01TULjUr5WVzZiNnv0hbSfqH5IoU9B7TotWDzPbBH/OUBy0gnwOdSIkh1oj/Wb8
 mdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723557222; x=1724162022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ocxt7oZAAz9BMDOpj25prag5V4EF45wznl+mYkNEXLQ=;
 b=h0JomGGc3iAiAzKobg/Fs7rxo87AhMoe69PNC5/Dw+vUP6EyEco1FW8CChxoxC2wAy
 8JPtiXPVpVCgDY4a12Sh2EXltc0186CwE/PUMHCYVqAe8fDld2l1Gbs/LTS7QuHii/MA
 Cq/5TPxJ2L5EHpMfyyRTfNNseVIunavbEFmxh4r3wD8hZ/3TbglnAt+bhewNH1gBC8ee
 fx8kzTLxChYsO5jyHqnihw80NIqDy8as0pVRvkanCCeGGXLgW3fQy+Q7yCel4S62B8++
 QGMAgRXUlNoO2GrKd857NSTZJCE47i5qbeHl3qFPvxrN0OLmtHYnEsiQnV/or79BcP2r
 kRQA==
X-Gm-Message-State: AOJu0YzexlYoFWUF4bsqSVU8lX+sL4FcDZkE02Bjv4lAmRd/BsElSWD+
 LQFrw7bKtuNUuf/OUfcazyTDZN3uStGr7TyWmsajsUhKh+PSAsjNAx4QaEixcsWyzonXD3/Lp1d
 fVjI=
X-Google-Smtp-Source: AGHT+IEmGvhgzkWQ8bhvRu4JnXLWhc5la+/XdvrQFgzetqkZHg4LJz9nd027Fg6qqauT8sIUfLTYzA==
X-Received: by 2002:a17:907:3f8b:b0:a7d:a008:abca with SMTP id
 a640c23a62f3a-a80ed2d6162mr264486466b.56.1723557221635; 
 Tue, 13 Aug 2024 06:53:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f49748sm71127266b.4.2024.08.13.06.53.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 06:53:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v3 1/2] target/mips: Pass page table entry size as
 MemOp to get_pte()
Date: Tue, 13 Aug 2024 15:53:12 +0200
Message-ID: <20240813135313.96519-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813135313.96519-1-philmd@linaro.org>
References: <20240813135313.96519-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 59 +++++++++++++----------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 3ba6d369a6..75a26131ca 100644
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
@@ -607,11 +607,11 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
 }
 
 static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
-        int entry_size, int ptei)
+                                     MemOp op, int ptei)
 {
     uint64_t result = entry;
     uint64_t rixi;
-    if (ptei > entry_size) {
+    if (ptei > memop_size(op)) {
         ptei -= 32;
     }
     result >>= (ptei - 2);
@@ -624,14 +624,12 @@ static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
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
@@ -643,14 +641,14 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
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
@@ -658,7 +656,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
             *pw_entrylo0 = entry & ~lsb; /* even page */
             *pw_entrylo1 = entry | lsb; /* odd page */
         } else if (dph) {
-            int oddpagebit = 1 << leaf_shift;
+            int oddpagebit = 1 << leaf_mop;
             uint64_t vaddr2 = *vaddr ^ oddpagebit;
             if (*vaddr & oddpagebit) {
                 *pw_entrylo1 = entry;
@@ -669,10 +667,10 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
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
@@ -711,7 +709,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
 
     /* Native pointer size */
     /*For the 32-bit architectures, this bit is fixed to 0.*/
-    int native_shift = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? 2 : 3;
+    MemOp native_op = (((env->CP0_PWSize >> CP0PS_PS) & 1) == 0) ? MO_32 : MO_64;
 
     /* Indices from PWField */
     int pf_gdw = (env->CP0_PWField >> CP0PF_GDW) & 0x3F;
@@ -728,11 +726,10 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
 
     /* Other HTW configs */
     int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
-    unsigned directory_shift, leaf_shift;
+    MemOp directory_mop, leaf_mop;
 
     /* Offsets into tables */
     unsigned goffset, uoffset, moffset, ptoffset0, ptoffset1;
-    uint32_t leafentry_size;
 
     /* Starting address - Page Table Base */
     uint64_t vaddr = env->CP0_PWBase;
@@ -759,23 +756,21 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
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
@@ -792,7 +787,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         vaddr |= uoffset;
         switch (walk_directory(env, &vaddr, pf_udw, &huge_page, &hgpg_udhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift, ptw_mmu_idx))
+                               directory_mop, leaf_mop, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -809,7 +804,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         vaddr |= moffset;
         switch (walk_directory(env, &vaddr, pf_mdw, &huge_page, &hgpg_mdhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift, ptw_mmu_idx))
+                               directory_mop, leaf_mop, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -827,10 +822,10 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
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
@@ -839,10 +834,10 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
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


