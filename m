Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8741C36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u15nY-0006Bv-Os; Sat, 05 Apr 2025 11:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nS-0006Aq-GA
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u15nP-0002gT-VC
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 11:51:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso2742146b3a.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743868259; x=1744473059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGkY893pksSyJpWIAoZrw90Rpm6xbrrdV4WYhKep6Wk=;
 b=sWEPaFbd8oSNnJHYbbUHLEJIxsxoKJb9r4Y8pOCm097pFFBIz10aIHi95k5cMA1/90
 4bZkZPgvMqPd+x5hlNMZZnrBP3VtZZK2XowYyDFk1lXeZpV9r0MTray6m9H6SWU8MqhC
 jEEVVW3KF3z7XfUv2jrDNguFMGHr9SKG1zhBEjYTFMrGyoica8M/7uq8Wf9Zfd576Sp9
 8zW5c0fWpOWcVOWu36LVcxgBvj7DESqPnRVlW57dM0vs27zrvBDyonQ7hz3ubijErEDI
 T+M5o4kF8MEluKnnkfnR/uSO/B2Ns6r24heS4w87FbPBZ+9By1zrNZV0UFKb4oiqy20d
 zhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743868259; x=1744473059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGkY893pksSyJpWIAoZrw90Rpm6xbrrdV4WYhKep6Wk=;
 b=GUIuePspGhLZSRy6JubNDVGZb698Otz3hZ3oxwBWTkqtqlOACo1MogUQBE/BafqYPj
 nlEH5uqBe1IvG831zUwvh7IVm0OgwU8yN5R76Ad05mKXJK652EbMtmQvn4FywTxVWLzj
 UbemwzpQhF0LPOFEpt2E5sSaAJl8QwFg2K8JTSVFEQkJaAgjngij56Xmzi9iib0jmt3t
 Sh0vpidKfYsXr86YOKd24YvXY+cpWE4rLuuXQ1lnzig2azGnvuhiSaCe9AC4+13m4pWu
 gadLIxi0hqssul6PKVzenhn/PqUExjrVmwgQ0biYbZeJ+P8QUqxR/JLdxw/kxsg89jhn
 TAcg==
X-Gm-Message-State: AOJu0YxazH/unqp42nSCTj1HIT01a9OKnymB68/LUzhsYCmkOmr27Usl
 1kTAtuSP3sqGzfb0Dd9tJjvtJVgIr/Nb6mah8cWh0Tq/aRoGaOJB3Sd2jiS1lInYANL+iJdzQfm
 u
X-Gm-Gg: ASbGncvWfC+ggaBS0kcsgTCMr/Ju/hWKm/zC3VFkiRFEwHUKoSxJSb1eBcMcOaFLMbr
 pQi5oMzJdUNspo+vJwgt6b+9WC1RaCcV1guEG8eTbJH69MAtVivGTUFyE8h8nH7tjRNiwZMf1za
 t+A42qajqHGo56e9CSw20BvDFQwX+16EahscaPpEYJB0eoJtQYPMgeAMmLNpwdpV6lQRkjlOU7U
 7e60v7hSBIwHYloKVQXlHHBYFOtsoDyLilSf1RmkbnMCMcS1JoqRQeh1HOVpXqYS1cPp/Qwksio
 4pOttIZ4Ur6UKuH8V36DNxC3OwI7MEd2zry/YDrjbnTRK2mZakt8
X-Google-Smtp-Source: AGHT+IFKR5n+Jso1uYfiiBWLppqfdzQ7xsagIX6dyfqaUSoGqLX1gI4tkpTu9g4G89d6KgfTqNyNeA==
X-Received: by 2002:a05:6a00:1489:b0:736:7960:981f with SMTP id
 d2e1a72fcca58-739e4816ed1mr10498263b3a.8.1743868258660; 
 Sat, 05 Apr 2025 08:50:58 -0700 (PDT)
Received: from stoup.. ([173.164.107.234]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b4851sm5554790b3a.146.2025.04.05.08.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 08:50:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 3/3] accel/tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
Date: Sat,  5 Apr 2025 08:50:53 -0700
Message-ID: <20250405155054.967307-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250405155054.967307-1-richard.henderson@linaro.org>
References: <20250405155054.967307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
have each target set the 'precise_smc' field in the TCGCPUOps
structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  6 ++++++
 include/exec/poison.h       |  1 -
 target/i386/cpu.h           |  4 ----
 target/s390x/cpu.h          |  2 --
 accel/tcg/tb-maint.c        | 26 ++++++++++----------------
 target/i386/tcg/tcg-cpu.c   |  1 +
 target/s390x/cpu.c          |  1 +
 7 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index a4932fc5d7..303753c43e 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -19,6 +19,12 @@
 #include "tcg/tcg-mo.h"
 
 struct TCGCPUOps {
+    /**
+     * @precise_smc: Stores which modify code within the current TB force
+     *               the TB to exit; the next executed instruction will see
+     *               the result of the store.
+     */
+    bool precise_smc;
 
     /**
      * @guest_default_memory_order: default barrier that is required
diff --git a/include/exec/poison.h b/include/exec/poison.h
index a09e0c1263..1593a56489 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -38,7 +38,6 @@
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
-#pragma GCC poison TARGET_HAS_PRECISE_SMC
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 16d76df34b..5a2e4a8103 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -35,10 +35,6 @@
 
 #define XEN_NR_VIRQS 24
 
-/* support for self modifying code even if the modified instruction is
-   close to the modifying instruction */
-#define TARGET_HAS_PRECISE_SMC
-
 #ifdef TARGET_X86_64
 #define I386_ELF_MACHINE  EM_X86_64
 #define ELF_MACHINE_UNAME "x86_64"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 90f64ee20c..ee59039879 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -35,8 +35,6 @@
 
 #define ELF_MACHINE_UNAME "S390X"
 
-#define TARGET_HAS_PRECISE_SMC
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 714dcaedc9..2af6c6d451 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -28,6 +28,7 @@
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
@@ -1041,9 +1042,7 @@ static void tb_invalidate_phys_page(tb_page_addr_t addr)
 /*
  * Called with mmap_lock held. If pc is not 0 then it indicates the
  * host PC of the faulting store instruction that caused this invalidate.
- * Returns true if the caller needs to abort execution of the current
- * TB (because it was modified by this store and the guest CPU has
- * precise-SMC semantics).
+ * Returns true if the caller needs to abort execution of the current TB.
  */
 bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
                                     uintptr_t pc)
@@ -1058,10 +1057,7 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
      * Without precise smc semantics, or when outside of a TB,
      * we can skip to invalidate.
      */
-#ifndef TARGET_HAS_PRECISE_SMC
-    pc = 0;
-#endif
-    if (!pc) {
+    if (!pc || !cpu->cc->tcg_ops->precise_smc) {
         tb_invalidate_phys_page(addr);
         return false;
     }
@@ -1109,14 +1105,16 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
 {
     TranslationBlock *tb;
     PageForEachNext n;
-#ifdef TARGET_HAS_PRECISE_SMC
     bool current_tb_modified = false;
-    TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
-#endif /* TARGET_HAS_PRECISE_SMC */
+    TranslationBlock *current_tb = NULL;
 
     /* Range may not cross a page. */
     tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
 
+    if (retaddr && current_cpu->cc->tcg_ops->precise_smc) {
+        current_tb = tcg_tb_lookup(retaddr);
+    }
+
     /*
      * We remove all the TBs in the range [start, last].
      * XXX: see if in some cases it could be faster to invalidate all the code
@@ -1134,8 +1132,7 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
             tb_last = tb_start + (tb_last & ~TARGET_PAGE_MASK);
         }
         if (!(tb_last < start || tb_start > last)) {
-#ifdef TARGET_HAS_PRECISE_SMC
-            if (current_tb == tb &&
+            if (unlikely(current_tb == tb) &&
                 (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
                 /*
                  * If we are modifying the current TB, we must stop
@@ -1147,7 +1144,6 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
                 current_tb_modified = true;
                 cpu_restore_state_from_tb(current_cpu, current_tb, retaddr);
             }
-#endif /* TARGET_HAS_PRECISE_SMC */
             tb_phys_invalidate__locked(tb);
         }
     }
@@ -1157,15 +1153,13 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
         tlb_unprotect_code(start);
     }
 
-#ifdef TARGET_HAS_PRECISE_SMC
-    if (current_tb_modified) {
+    if (unlikely(current_tb_modified)) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
         current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
-#endif
 }
 
 /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index d941df0956..8e8ebe8aa2 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -125,6 +125,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "accel/tcg/cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
+    .precise_smc = true,
     /*
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1e101b5afe..f8f859cd30 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -345,6 +345,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
+    .precise_smc = true,
     /*
      * The z/Architecture has a strong memory model with some
      * store-after-load re-ordering.
-- 
2.43.0


