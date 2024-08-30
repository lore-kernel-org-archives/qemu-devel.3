Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7CBCA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nW-0001SW-44; Fri, 30 Aug 2024 12:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nU-0001MU-Cf
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:28 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nP-000704-Gz
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:28 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2d3b36f5366so1567870a91.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036502; x=1725641302;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORHOWNksCDe53nyFni7l/e5K+2PYqtPVpVXbc5/6rto=;
 b=D9ojdgs0Ox+/uoZPtdCBYUk5dFfAXB20XZ8odU+7AUlVpDCeAF0TuvpPSfF8RdA0HK
 YxQGfvnAHxoF1e/vDcbMchhbHTgo1whsbjYJxqZgAD03QmlSXTZfWLcKhba2Bo0BH+kL
 KOsYf0bRjNr4vjV4Wse3J5b4MV1yQ3X8j6KYIttzprnY3O1MWP9xXQ+/0q6zAJhTJUZg
 L3dOGA4oSmeMQQCausGq5mBwGkPKYGKbTwaQ6SkXOoV9kUKDHYb4KqTwRlrS0Ckmfs9l
 gVQ1xXlcSMTKUat797n8ByCe7om7VynpTAmXfhR7eclj9lLUj9dW5p3DNb/eItrFUQ0i
 HBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036502; x=1725641302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ORHOWNksCDe53nyFni7l/e5K+2PYqtPVpVXbc5/6rto=;
 b=mwNdsfQQ3VQ9adz3SR5AWj5GlGZpMRRxcZpWY2GY/4gy+i5zlmTMvNB7/MVNnDh9rd
 56xzsCmRnJnvtc+OULEmiMlusdBfB1Yc6LIQ1CFwLSvK24fLFClJu6MNzvJbln9uZqnN
 7C6heHZpjwdRsAg5aApW6BfxHwb8/OWjUHkH2CJzZF82fWB5GAsHGF/ghk1yiyFnDO26
 jA8NTQzBdMlbNylYRhkFK6l5eDnxBjNpW9QgJVPP/wydj1oFKprCinVShxRm5GNfDlro
 x9ucaLeB3+V2DxxoSQ+aLltSinS+z4qxnG5JSsMkqvqLcn1QBotnjo/ROah0fHJnWlzT
 lO2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYUw4ZsJrfDM6dUDDlt556Zx3vW8p06TMj61EZCbqKihMayoCyTlJlIYc6M5lUI6bBfPS9ryhGjIc8@nongnu.org
X-Gm-Message-State: AOJu0YzwjgfDjFHGwlqvWUpmX860fNCPKvnIIZslmSU2NpAT1R3P5hDR
 4LEZjUxAAIby29TyytyCCatd0MpKCnT1ciRpVY55qgqBpFrD0rkMYQvkUmg17X8=
X-Google-Smtp-Source: AGHT+IFaANJbD17XmpA1+Bp80NZ3HljNCg0Ih5YPa1ZGaRrRTyKKdxgb7Wn/mv1p6MSC9jhsw7/+FQ==
X-Received: by 2002:a17:90a:a416:b0:2d1:c9c8:301c with SMTP id
 98e67ed59e1d1-2d85639472emr6801843a91.29.1725036502065; 
 Fri, 30 Aug 2024 09:48:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:21 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v13 13/20] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Fri, 30 Aug 2024 09:47:49 -0700
Message-ID: <20240830164756.1154517-14-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/riscv/cpu_helper.c | 46 +++++++++++++++++++++++++++++++++------
 target/riscv/internals.h  |  3 +++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9a1fc1b3a6..9d777ce1a2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -895,6 +895,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1103,21 +1105,40 @@ restart:
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
@@ -1161,8 +1182,11 @@ restart:
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
@@ -1349,9 +1373,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
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


