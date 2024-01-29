Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F91C48286
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6E-0005s2-9r; Mon, 29 Jan 2024 18:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb66-0005eI-9d
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:26 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb64-00054x-0z
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:25 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d7858a469aso17977465ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571082; x=1707175882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX9p1w8gwSjbvchi0L5D4HF7R4GEOnc6YSNW0pomVF4=;
 b=rUkNe65LqnioJuFclhbz/U5jKKK+T7A/XFRzHEEkhGKRFueONs0Z8Mo55djOZXjaHV
 vtnuxWq0J69k+St73ICfcixk6JkNQmcRjP3hK6m873vS+55bMFYuaTm7pvNq4ipHOieT
 dRW7nUvma8/HuhP9xkGZ2z3HeI555saulk+wueX70BJlDmfZj8a/nQEr2FEEkSSKLLGI
 NOJ58KOzyZCFkvixAr1xdPGYsJUH1IVWSVoTDQVbxmdiIr6dOr0gdVd4m+A8xRDKRkN1
 +FzzZB6ymejjmPRugpO6qOkZFugAXIFrKJeRVF3nZYjqWNid7EnCJV9j0Ds/Mg5YoOUx
 JFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571082; x=1707175882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX9p1w8gwSjbvchi0L5D4HF7R4GEOnc6YSNW0pomVF4=;
 b=wmsCq+i9T1KsB3FY+OfFt1Uca1ldo4GyfmdC6FlXknP1bufcLMzoFkvdf0RnQ9ngm7
 VvX3ifzLTqHeeXwQEquwTyg2nOjITpc1uiXhaljpRQYcKqqNkiPSpg9t3sza2FfDNK5a
 xgd8wtxrXl3ktGOqTrQCfTuyFgR12T7ACpxYAXqs0zlp/t1vyAdlqgnwUKwq7PifbTnY
 UydvYtce4QErjRA/pE6Nqs+wUZRBVJB1GnoYIrg7LKd//AfSGyPKgIZejXbOSCj0KkCM
 vOWWWcAfhy9CjptYbpc4V19YVt6mvR3zQc7Zvekog8ucEiUKgPaTQmcNHnYIndzopadQ
 hqWQ==
X-Gm-Message-State: AOJu0YwqSQs8FqnIRjC1UYYLQ1So6oS8qQw1ELkIV5SnKjN71bBpAK7u
 PNGFxqZQpZ6w0GsYN+EMo/zIV5acQTb44d+mnWrAgE9ge4m3+27IBlMSrIp9MuIZwQaUUBusNC3
 Ftlo=
X-Google-Smtp-Source: AGHT+IGlXWUbzVf01GsoCXgRD0LtsZf7FvDzrPLjU3x1SLrtPh7pBHiuG3sfy8qARmrS9JsRc4gM6g==
X-Received: by 2002:a17:903:a90:b0:1d7:3192:de38 with SMTP id
 mo16-20020a1709030a9000b001d73192de38mr3697696plb.69.1706571082505; 
 Mon, 29 Jan 2024 15:31:22 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 15/33] target/mips: Pass ptw_mmu_idx down from
 mips_cpu_tlb_fill
Date: Tue, 30 Jan 2024 09:30:25 +1000
Message-Id: <20240129233043.34558-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Rather than adjust env->hflags so that the value computed
by cpu_mmu_index() changes, compute the mmu_idx that we
want directly and pass it down.

Introduce symbolic constants for MMU_{KERNEL,ERL}_IDX.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.h                   |  4 +++-
 target/mips/tcg/sysemu/tlb_helper.c | 32 ++++++++++++-----------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 1163a71f3c..3ba8dccd2d 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1242,12 +1242,14 @@ uint32_t cpu_rddsp(uint32_t mask_num, CPUMIPSState *env);
  * MMU modes definitions. We carefully match the indices with our
  * hflags layout.
  */
+#define MMU_KERNEL_IDX 0
 #define MMU_USER_IDX 2
+#define MMU_ERL_IDX 3
 
 static inline int hflags_mmu_index(uint32_t hflags)
 {
     if (hflags & MIPS_HFLAG_ERL) {
-        return 3; /* ERL */
+        return MMU_ERL_IDX;
     } else {
         return hflags & MIPS_HFLAG_KSU;
     }
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 4ede904800..b715449114 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -623,7 +623,7 @@ static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
 static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         int directory_index, bool *huge_page, bool *hgpg_directory_hit,
         uint64_t *pw_entrylo0, uint64_t *pw_entrylo1,
-        unsigned directory_shift, unsigned leaf_shift)
+        unsigned directory_shift, unsigned leaf_shift, int ptw_mmu_idx)
 {
     int dph = (env->CP0_PWCtl >> CP0PC_DPH) & 0x1;
     int psn = (env->CP0_PWCtl >> CP0PC_PSN) & 0x3F;
@@ -638,8 +638,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
     uint64_t w = 0;
 
     if (get_physical_address(env, &paddr, &prot, *vaddr, MMU_DATA_LOAD,
-                             cpu_mmu_index(env, false)) !=
-                             TLBRET_MATCH) {
+                             ptw_mmu_idx) != TLBRET_MATCH) {
         /* wrong base address */
         return 0;
     }
@@ -666,8 +665,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
                 *pw_entrylo0 = entry;
             }
             if (get_physical_address(env, &paddr, &prot, vaddr2, MMU_DATA_LOAD,
-                                     cpu_mmu_index(env, false)) !=
-                                     TLBRET_MATCH) {
+                                     ptw_mmu_idx) != TLBRET_MATCH) {
                 return 0;
             }
             if (!get_pte(env, vaddr2, leafentry_size, &entry)) {
@@ -690,7 +688,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
 }
 
 static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
-                                   int mmu_idx)
+                                   int ptw_mmu_idx)
 {
     int gdw = (env->CP0_PWSize >> CP0PS_GDW) & 0x3F;
     int udw = (env->CP0_PWSize >> CP0PS_UDW) & 0x3F;
@@ -776,7 +774,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         vaddr |= goffset;
         switch (walk_directory(env, &vaddr, pf_gdw, &huge_page, &hgpg_gdhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift))
+                               directory_shift, leaf_shift, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -793,7 +791,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         vaddr |= uoffset;
         switch (walk_directory(env, &vaddr, pf_udw, &huge_page, &hgpg_udhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift))
+                               directory_shift, leaf_shift, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -810,7 +808,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         vaddr |= moffset;
         switch (walk_directory(env, &vaddr, pf_mdw, &huge_page, &hgpg_mdhit,
                                &pw_entrylo0, &pw_entrylo1,
-                               directory_shift, leaf_shift))
+                               directory_shift, leaf_shift, ptw_mmu_idx))
         {
         case 0:
             return false;
@@ -825,8 +823,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
     /* Leaf Level Page Table - First half of PTE pair */
     vaddr |= ptoffset0;
     if (get_physical_address(env, &paddr, &prot, vaddr, MMU_DATA_LOAD,
-                             cpu_mmu_index(env, false)) !=
-                             TLBRET_MATCH) {
+                             ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
     if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
@@ -838,8 +835,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
     /* Leaf Level Page Table - Second half of PTE pair */
     vaddr |= ptoffset1;
     if (get_physical_address(env, &paddr, &prot, vaddr, MMU_DATA_LOAD,
-                             cpu_mmu_index(env, false)) !=
-                             TLBRET_MATCH) {
+                             ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
     if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
@@ -944,12 +940,10 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
          * Memory reads during hardware page table walking are performed
          * as if they were kernel-mode load instructions.
          */
-        int mode = (env->hflags & MIPS_HFLAG_KSU);
-        bool ret_walker;
-        env->hflags &= ~MIPS_HFLAG_KSU;
-        ret_walker = page_table_walk_refill(env, address, mmu_idx);
-        env->hflags |= mode;
-        if (ret_walker) {
+        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
+                           MMU_ERL_IDX : MMU_KERNEL_IDX);
+
+        if (page_table_walk_refill(env, address, ptw_mmu_idx)) {
             ret = get_physical_address(env, &physical, &prot, address,
                                        access_type, mmu_idx);
             if (ret == TLBRET_MATCH) {
-- 
2.34.1


