Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E532FC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 19:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shZYB-0004Xs-6r; Fri, 23 Aug 2024 15:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXv-0003fL-RQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:08 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1shZXs-0004MZ-Ro
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 15:02:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-201fbd0d7c2so21792475ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 12:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724439719; x=1725044519;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8xyASdH5ej1bt43PLgAl+R1czKhRhrxaKGHztQjpDI=;
 b=IDMajaiaBw4i8T5mlsRk42VlS5RbIXxxO7I2nB9G3j9gwCRGbRRxDWYveDS8/VBCL7
 t7xK4sP3p3Va/efHFafJH0C6Bd1kfyQLEfMKdlwWyfBXxEbISxdUHFL0bRFkprHAubZP
 i1vPrNdUZ8eTfOUmdxNjMldEQfHqiOFsJUKGWddlW/KS7kn6uGb7FO+T0VSjWPEB6SzV
 iCWg7xUsFWpdE70ImZ970hEckTLPoX6y4T/rcmiSbW0Nwc81C8aIv6Q4vrFz308aWav2
 POh+GiK/VHbmMyfOfAqH2APCODGf3hR3AZ1HzEQRLLcqXl5HBZrTRKXw+qzm+QX+vjN6
 9nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724439719; x=1725044519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8xyASdH5ej1bt43PLgAl+R1czKhRhrxaKGHztQjpDI=;
 b=LsPA0o8BQGa8uJifL8pDBalIELc/TdQNl1gnk7zSU4jYKe3RVQK1y+BE1a8E3LtY6H
 Ol74rmiZvS+6hPIGasXG/Jmf5xKL06trx6ovT2D6zD6d9E2inz8D1+/b6vCVeF8VUZdC
 bEBre5/PkO7G2rTdhaa6wHF+15OVTf1AStid7CPECneu02gLeuRhXPhvC3BKePQnBq+k
 twjccFX86SJEfUWWO4fHFTFmPpdzLU/jJw5pky/ECBEKv7H8R/Yzev17TB6gUSXmvTkw
 mQMEIUF1nwCGBk5pymV8zoJU4WMRi2AxMrk9YfrzF73ebIaCTJZEAmNQoy4rapMhr6IF
 EMPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFChTuvIWw22ksXUvkHbvuZ8s5KZhRPxyQuAbsaOP6sB5FCtgVDMQXI3bypxNdHWGXSM/2ApHQ43rf@nongnu.org
X-Gm-Message-State: AOJu0Yzk5Mx08tmRqs/R1071/6id3hWA9fW9JGi5NBKBSOP/LLOGfVwz
 z3rd9ldxcvA5Lp3l4HTRgYOs3h+N6AqPTK+DdRLt0FsCQfS/ZsJvlIsEPM+DxDE=
X-Google-Smtp-Source: AGHT+IHFj/IfETDFDSB4Z8lgLCcemQlsyAViK8eqhNPGVarj4kVPeSD3HdXlgCP0CQgYYGX+zbAOoQ==
X-Received: by 2002:a17:902:e846:b0:202:1bc9:5a96 with SMTP id
 d9443c01a7336-2039e4bd50amr33036685ad.9.1724439719348; 
 Fri, 23 Aug 2024 12:01:59 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0c37768sm1749885ad.230.2024.08.23.12.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 12:01:59 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 richard.henderson@linaro.org, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v8 11/17] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Fri, 23 Aug 2024 12:01:33 -0700
Message-ID: <20240823190140.4156920-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240823190140.4156920-1-debug@rivosinc.com>
References: <20240823190140.4156920-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

zicfiss protects shadow stack using new page table encodings PTE.W=0,
PTE.R=0 and PTE.X=0. This encoding is reserved if zicfiss is not
implemented or if shadow stack are not enabled.
Loads on shadow stack memory are allowed while stores to shadow stack
memory leads to access faults. Shadow stack accesses to RO memory
leads to store page fault.

To implement special nature of shadow stack memory where only selected
stores (shadow stack stores from sspush) have to be allowed while rest
of regular stores disallowed, new MMU TLB index is created for shadow
stack.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c | 37 +++++++++++++++++++++++++++++++------
 target/riscv/internals.h  |  3 +++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ca336f46db..95ef7b0bd1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -892,6 +892,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1100,21 +1102,36 @@ restart:
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
+            /* if ss index, read and write allowed. else only read allowed */
+            rwx = is_sstack_idx ? PTE_R | PTE_W : PTE_R;
+            break;
+        }
+        return TRANSLATE_FAIL;
+    case PTE_R:
+        /* shadow stack writes to readonly memory are page faults */
+        if (is_sstack_idx && access_type == MMU_DATA_STORE) {
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
@@ -1159,7 +1176,7 @@ restart:
 
     if (!((prot >> access_type) & 1)) {
         /* Access check failed */
-        return TRANSLATE_FAIL;
+        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
     }
 
     target_ulong updated_pte = pte;
@@ -1346,9 +1363,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
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
2.44.0


