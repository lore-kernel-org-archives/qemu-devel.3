Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E24CF042A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2V-0000Ne-FB; Tue, 08 Oct 2024 18:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2T-0000M9-HA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:45 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2G-0003yu-I4
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20b90984971so63661905ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427831; x=1729032631;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBpTSzscFQZRWfY6VFZyDz+QYOjLnTuunuys6kxFNEw=;
 b=KIeL33W4BktSY8+m2dLVPnD7OjAMsP1RNFmybSzvUNY3NxkMtMHeEnxmEz/hIgdIyQ
 oqk5GRoviAjsYEXmOSx2Za5i+fvtAKQV6HLWMhDdcLxlVsv1TYy/aTwQ4X+8ddroVqVm
 Aydfd/IGYpC0i0/kWzurKOrKxs+kH9shSKpe5UFaulkKU+yak/XFVV5B6cjAFyaZAuRd
 d950Qgs2MEpfeyurXZe8twotZFZJlJ8aCuWTtaxhL+Af2TZGjbx81uDw4K0X4zTHMqlZ
 9yM/l03e1FcVIX905xbmuTVF6kO0qI5RJxtGNLxNHIr+ZxrC9BfkdbqtrGPAOkuIi+dg
 eCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427831; x=1729032631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XBpTSzscFQZRWfY6VFZyDz+QYOjLnTuunuys6kxFNEw=;
 b=ezpmNRpGe63PIn2vl2rltj1/CBooa2RkPoHOkjdcAptFLOf5sLq69wOgwlhiUioGfu
 5qghuK/WUdfOXo4IWg0DObH7yFFpzC+lFQlULxMcAspb3JCXVO7eCrQtUJl3KYIZEjE2
 hviMR2WkLj0+qI9oADS4wweOW3AWO+gpAATuPwGY2TuknO1Ph0vF9zZWxgkBiBpxY9ve
 GunRluds+B9AA6GBE59GUQfhct5CtqXWHLdlpTklDShoHmNihAhdD/zCoqqdHTkL4Jbw
 UYt4HlK2AreG3FKo8UYed2/r0Jtv9bOs85a0lZ9ZoX6NizAybhlQkshdqCXCX9Jzv/Uu
 8hZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+kKcbaVoG17t/nskJW9HUj++sS2YSj2wOkBdnjkOxo5Te/EoU3Oiy9B1X8/VfLH2gQ9jK6Rf3Brva@nongnu.org
X-Gm-Message-State: AOJu0YzfM9pX/ufxdfGmPsDSBxzr6R5dFd/PBW07Xq5Noi7gcL+r9EH3
 K8IRxnohFVuiYoqXc5ICffHsu0Q64id6jZkqoQDlAK9TKACEgDvZhy8Z+wJDOKA=
X-Google-Smtp-Source: AGHT+IGySDVe1n/C1Iy392lVieyGpz3IAa8YKq75B0dLTv/DPbV8/SQkGiXfMk712WOijzBad7GJPA==
X-Received: by 2002:a17:902:db11:b0:20b:c287:202d with SMTP id
 d9443c01a7336-20c637924a8mr7363805ad.55.1728427831011; 
 Tue, 08 Oct 2024 15:50:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:30 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v16 13/20] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Tue,  8 Oct 2024 15:50:03 -0700
Message-ID: <20241008225010.1861630-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

zicfiss protects shadow stack using new page table encodings PTE.W=1,
PTE.R=0 and PTE.X=0. This encoding is reserved if zicfiss is not
implemented or if shadow stack are not enabled.
Loads on shadow stack memory are allowed while stores to shadow stack
memory leads to access faults. Shadow stack accesses to RO memory
leads to store page fault.

To implement special nature of shadow stack memory where only selected
stores (shadow stack stores from sspush) have to be allowed while rest
of regular stores disallowed, new MMU TLB index is created for shadow
stack.

Furthermore, `check_zicbom_access` (`cbo.clean/flush/inval`) may probe
shadow stack memory and must always raise store/AMO access fault because
it has store semantics. For non-shadow stack memory even though
`cbo.clean/flush/inval` have store semantics, it will not fault if read
is allowed (probably to follow `clflush` on x86). Although if read is not
allowed, eventually `probe_write` will do store page (or access) fault (if
permissions don't allow it). cbo operations on shadow stack memory must
always raise store access fault. Thus extending `get_physical_address` to
recieve `probe` parameter as well.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c | 64 ++++++++++++++++++++++++++++++---------
 target/riscv/internals.h  |  3 ++
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 93d199748e..8f7871c92b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -884,7 +884,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 target_ulong *fault_pte_addr,
                                 int access_type, int mmu_idx,
                                 bool first_stage, bool two_stage,
-                                bool is_debug)
+                                bool is_debug, bool is_probe)
 {
     /*
      * NOTE: the env->pc value visible here will not be
@@ -898,6 +898,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1028,7 +1030,7 @@ restart:
             int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
                                                  base, NULL, MMU_DATA_LOAD,
                                                  MMUIdx_U, false, true,
-                                                 is_debug);
+                                                 is_debug, false);
 
             if (vbase_ret != TRANSLATE_SUCCESS) {
                 if (fault_pte_addr) {
@@ -1106,21 +1108,43 @@ restart:
         return TRANSLATE_FAIL;
     }
 
+    target_ulong rwx = pte & (PTE_R | PTE_W | PTE_X);
     /* Check for reserved combinations of RWX flags. */
-    switch (pte & (PTE_R | PTE_W | PTE_X)) {
-    case PTE_W:
+    switch (rwx) {
     case PTE_W | PTE_X:
         return TRANSLATE_FAIL;
+    case PTE_W:
+        /* if bcfi enabled, PTE_W is not reserved and shadow stack page */
+        if (cpu_get_bcfien(env) && first_stage) {
+            sstack_page = true;
+            /*
+             * if ss index, read and write allowed. else if not a probe
+             * then only read allowed
+             */
+            rwx = is_sstack_idx ? (PTE_R | PTE_W) : (is_probe ? 0 :  PTE_R);
+            break;
+        }
+        return TRANSLATE_FAIL;
+    case PTE_R:
+        /*
+         * no matter what's the `access_type`, shadow stack access to readonly
+         * memory are always store page faults. During unwind, loads will be
+         * promoted as store fault.
+         */
+        if (is_sstack_idx) {
+            return TRANSLATE_FAIL;
+        }
+        break;
     }
 
     int prot = 0;
-    if (pte & PTE_R) {
+    if (rwx & PTE_R) {
         prot |= PAGE_READ;
     }
-    if (pte & PTE_W) {
+    if (rwx & PTE_W) {
         prot |= PAGE_WRITE;
     }
-    if (pte & PTE_X) {
+    if (rwx & PTE_X) {
         bool mxr = false;
 
         /*
@@ -1164,8 +1188,11 @@ restart:
     }
 
     if (!((prot >> access_type) & 1)) {
-        /* Access check failed */
-        return TRANSLATE_FAIL;
+        /*
+         * Access check failed, access check failures for shadow stack are
+         * access faults.
+         */
+        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
     }
 
     target_ulong updated_pte = pte;
@@ -1303,13 +1330,13 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
-                             true, env->virt_enabled, true)) {
+                             true, env->virt_enabled, true, false)) {
         return -1;
     }
 
     if (env->virt_enabled) {
         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
-                                 0, MMUIdx_U, false, true, true)) {
+                                 0, MMUIdx_U, false, true, true, false)) {
             return -1;
         }
     }
@@ -1352,9 +1379,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
         break;
     case MMU_DATA_LOAD:
         cs->exception_index = RISCV_EXCP_LOAD_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_WRITE) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        }
         break;
     case MMU_DATA_STORE:
         cs->exception_index = RISCV_EXCP_STORE_AMO_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_WRITE) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        }
         break;
     default:
         g_assert_not_reached();
@@ -1415,7 +1450,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         /* Two stage lookup */
         ret = get_physical_address(env, &pa, &prot, address,
                                    &env->guest_phys_fault_addr, access_type,
-                                   mmu_idx, true, true, false);
+                                   mmu_idx, true, true, false, probe);
 
         /*
          * A G-stage exception may be triggered during two state lookup.
@@ -1438,7 +1473,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
             ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
                                        access_type, MMUIdx_U, false, true,
-                                       false);
+                                       false, probe);
 
             qemu_log_mask(CPU_LOG_MMU,
                           "%s 2nd-stage address=%" VADDR_PRIx
@@ -1475,7 +1510,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else {
         /* Single stage lookup */
         ret = get_physical_address(env, &pa, &prot, address, NULL,
-                                   access_type, mmu_idx, true, false, false);
+                                   access_type, mmu_idx, true, false, false,
+                                   probe);
 
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " ret %d physical "
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 0ac17bc5ad..ddbdee885b 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -30,12 +30,15 @@
  *  - U+2STAGE          0b100
  *  - S+2STAGE          0b101
  *  - S+SUM+2STAGE      0b110
+ *  - Shadow stack+U   0b1000
+ *  - Shadow stack+S   0b1001
  */
 #define MMUIdx_U            0
 #define MMUIdx_S            1
 #define MMUIdx_S_SUM        2
 #define MMUIdx_M            3
 #define MMU_2STAGE_BIT      (1 << 2)
+#define MMU_IDX_SS_WRITE    (1 << 3)
 
 static inline int mmuidx_priv(int mmu_idx)
 {
-- 
2.45.0


