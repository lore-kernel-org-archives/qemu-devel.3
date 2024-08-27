Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6596FC54744
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TY-0004Vh-7a; Tue, 27 Aug 2024 19:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TI-0003Ta-Lt
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TF-0000uJ-RW
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:32 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-204d391f53bso23328115ad.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800768; x=1725405568;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfT0nIMWBIbJcaqmjwnW5/0Iuog81wXS/GOvLXNs2Eg=;
 b=E7AUk+LAtyNyud2sVlP+kEhLSjkCTD+IiQylzM2l5wZZO6/KEn/diLOnrNb2eGL0S6
 vUpl+Ygfs4KeZr6hvTzSNjz338hYIu+5Pp2kVUmJKrQ2XeQxIOoWp6xGtIDaE170dVRA
 IDjoAPiHMF4iwlKhX+kvLXr6kDXERCf/sZns7u1nXLyXgOQIxyorBi1nABuvIDknvZIi
 p4uhRYzd6QEFpleC47yUeWWviHVeXw1cGXCahO/ASLgtr8bfQDGEJEUP1s/FgiGDEasm
 pqPEE8nJ1RiLknsq746+T2vZMJQ4ZUH26gzga6AWfCA4A8yyOtNcf6PE+1g1uyg4Cc3/
 InBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800768; x=1725405568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfT0nIMWBIbJcaqmjwnW5/0Iuog81wXS/GOvLXNs2Eg=;
 b=JeeSoCGt7KfdH45gwSrTPk4ofqUktlpBK3FoQDMxBozgTdoa3SXKLPpzoYnzYQUjFj
 SjRqs9syrNO/9Ko7lxszSdUqwLgW3SOhLGGW2te3/W5EtEhQ9kT0FPycIxG8xV3ldHDB
 9ZmyNQz/KaNp8BqbBbl6AIWxXoLA9ZdOXltk6d0G/dw5KUysA5INeBor3VxFSU9Xq89C
 F950rs3R63CY/OOXZJNL7eqXN4V7FbRt+er1M0+st0NRgM5qMhTYpOkLALka5IjStwMG
 nTS5u9nsEq0/DTVKAHHatWKb0lMtRo2iq2e+bHcoCMuMkZCM0CvgEDlUAlghl7ilPRNN
 X9rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx6DfipZ7DjcBTN9Ioc7vuqH/aVTQwC2XDzn6dPZ0+oOVug3AiD85XkFmR0lYiAnKVQLk7duyasPDN@nongnu.org
X-Gm-Message-State: AOJu0YzJQGcQ0ONvsOlQo3BvNzgrCzzLM+HeND1xYI0Akb9X3LhuES7B
 1zMMCFGRxr4TKCV0zDT2EuLRpiGkBVZCkh0dGrCNPWP3DyxnlcILR9v/F3MkB3A=
X-Google-Smtp-Source: AGHT+IFfDeExli8LfndZkcAGzdCONswFKV1tE3j3B3hynZl3Pq4wwsQZ122lInma92kEZIu+CbIegw==
X-Received: by 2002:a17:902:cec5:b0:203:a046:cb7e with SMTP id
 d9443c01a7336-204f9c6c567mr3935715ad.58.1724800768264; 
 Tue, 27 Aug 2024 16:19:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v10 14/21] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Tue, 27 Aug 2024 16:18:58 -0700
Message-ID: <20240827231906.553327-15-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x635.google.com
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

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c | 37 +++++++++++++++++++++++++++++++------
 target/riscv/internals.h  |  3 +++
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index be4ac3d54e..39544cade6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -893,6 +893,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1101,21 +1103,36 @@ restart:
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
@@ -1160,7 +1177,7 @@ restart:
 
     if (!((prot >> access_type) & 1)) {
         /* Access check failed */
-        return TRANSLATE_FAIL;
+        return sstack_page ? TRANSLATE_PMP_FAIL : TRANSLATE_FAIL;
     }
 
     target_ulong updated_pte = pte;
@@ -1347,9 +1364,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
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


