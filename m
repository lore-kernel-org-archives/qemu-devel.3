Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE06C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrto-0001Tk-Tv; Fri, 17 Jul 2026 19:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtl-0001ST-FS
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:17 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtj-0006y7-Gf
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c95d0a54ea5so6147862a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330594; x=1784935394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/PwnvtkmnND82rvGSpVtWGJUQzkpj2nFU1NpSAxz+X8=;
 b=kqvYNqKAKpv3g2TWyWCCG4/odR94j97paC72MzC6wSBx6AXSd1kwmhrjzd2nWOaGwL
 6J9t1zQWjRgmshJk62h0Ph506TxgPuMV3hTJC1bwSSAayyhVa2PNM+JwK4nQ1Huu9XJQ
 NXqyQ8wBR8PsLvrgqFxLXtQzF/fV1MOWTCV8CguSdnBclXb6jlFPHKYWsc+7v0gCah5c
 fBREW3k3XqQ0PxpRV8kCN8lUnmYZy57NESgqMqYj2KPmmhgMxLcVsfEe4B8C8dTK3pRz
 nbiHUauCT9Ok9++bz1mCgLbBN3TQsTBKQyyNL0Lq2xl/E7NvIryCPese/1eKFvb7MNjA
 R3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330594; x=1784935394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/PwnvtkmnND82rvGSpVtWGJUQzkpj2nFU1NpSAxz+X8=;
 b=EXtbKycQk2SZuZDZsClRaR8+XiGb5mvRzqmEDUFjR3vBHDtXT8Vbucczd3sekC5kf3
 FPwSRQ6VdCW3ZaSRI+MBpUrL32CxZiwIZcsw7jHR6QsvxUXr4oS2n0APUgzdu9GdjWeD
 Gu4Tpy+6YWnlBjuepLIy09aRHUptS7TBgak2qQFB8ouRRnJwTBLqrTE9AgVftGmEoFqX
 D9dLpNU6uyzHd36CV3YuAcVOkcw+epdAGxZ+BcLMMzM84FkIka1h2SaW7Fw9NuskQIuF
 F5CyHmmp1gONzOMm4Ps3RgWL9A3IW0jrbhKvNXjTsUnwH6rWBWVF4CPYQs4idpQdKepB
 nwnQ==
X-Gm-Message-State: AOJu0YxwSihrUorX8jfhfHzqVRI9olYcjGss1erknaWi2sM5aVPFsuwL
 xd8I4GxN5SP+5x6rmNEfFSwwie9F30at9nvOBljnEhSkUmzMVhK7aM5uYF92OdeE/HTIqMD0CMI
 mu0Qh
X-Gm-Gg: AfdE7ckbjL04FbYTweEXRDjxk7IrwrrmDZzQgQu+a80mqnOug+qoZtYJ3neuGM8eAZt
 yISbqMx/d0M1PXS+3BDbhHAsvUaQg0s+Dt7qMmJn6yxCTURao/7T9CQyhCK7v5B8fo+wA+OL8xj
 lTAnq+ag6XagOGGjOx2Tx9oMyRiVRjpHDBhwmpxdnDlUQt4zhSPZ5m7Z7CN9HHxDOe09dcH6/gN
 3taT6XWjXyLTSK2WbMvwEkb8RcKY1zFnaDnHpzHltJvBh/BrKRGQA32HNA1UyBLYe7eKwB3ysJj
 ow5Zdx9SN/iqpDLxIEGqZPffsVxKOf08Epb8cly1MxxgdoOKGtwBGsTQNjNtC1pMNgGz2fHeU00
 OBwhWo/c3yezGWFhEXsDBE9Z5xR4HLHoFsrvgTsAJxRh5bZAafcYG2qzvDt+KQWcsQY2XV3AyJ6
 ptrPOS3+YD76exiGr2zg==
X-Received: by 2002:a17:90a:d40f:b0:38e:542:6485 with SMTP id
 98e67ed59e1d1-38e4b4461e1mr4744360a91.12.1784330594032; 
 Fri, 17 Jul 2026 16:23:14 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/17] target/arm: Raise alignment fault for DC_ZVA on Device
 memory
Date: Fri, 17 Jul 2026 16:22:52 -0700
Message-ID: <20260717232306.378988-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Raise alignment fault when DC_ZVA targets Device memory, as required
by the architecture.  With MTE, an alignment exception is not always
correctly ordered vs a tag check fail exception -- to be fixed in
followup patches.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3005
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.c | 104 ++++++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 39 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 993aba5df4..dc87dc283f 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -1018,56 +1018,82 @@ bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr)
     return ret != 0;
 }
 
-void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
+/* Traps for DC_ZVA, DC_GVA, and friends, after successful page lookup. */
+static int do_dcxva_traps(CPUARMState *env, vaddr addr, size_t len, int mmu_idx,
+                          int flags, MemTxAttrs attrs, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
-
-    /*
-     * Implement DC ZVA, which zeroes a fixed-length block of memory.
-     * Note that we do not implement the (architecturally mandated)
-     * alignment fault for attempts to use this on Device memory
-     * (which matches the usual QEMU behaviour of not implementing either
-     * alignment faults or any memory attribute handling).
-     */
-    int blocklen = 4 << get_dczid_bs(env_archcpu(env));
-    uint64_t vaddr = vaddr_in & ~(blocklen - 1);
-    int mmu_idx = arm_env_mmu_index(env);
-    void *mem;
-
-    /*
-     * Trapless lookup.  In addition to actual invalid page, may
-     * return NULL for I/O, watchpoints, clean pages, etc.
-     */
-    mem = tlb_vaddr_to_host(env, vaddr, MMU_DATA_STORE, mmu_idx);
-
 #ifndef CONFIG_USER_ONLY
-    if (unlikely(!mem)) {
-        /*
-         * Trap if accessing an invalid page.  DC_ZVA requires that we supply
-         * the original pointer for an invalid page.  But watchpoints require
-         * that we probe the actual space.  So do both.
-         */
-        (void) probe_write(env, vaddr_in, 1, mmu_idx, ra);
-        mem = probe_write(env, vaddr, blocklen, mmu_idx, ra);
+    /*
+     * DC_ZVA traps on pages without caching enabled.  This can be either
+     * pages mapped as Device, or when the mmu is disabled entirely.
+     * We have already detected such pages and have set TLB_CHECK_ALIGNED
+     * so that unaligned accesses are trapped under the same conditions.
+     */
+    if (unlikely(flags & TLB_CHECK_ALIGNED)) {
+        arm_cpu_do_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
+                                    mmu_idx, ra);
+    }
 
-        if (unlikely(!mem)) {
-            /*
-             * The only remaining reason for mem == NULL is I/O.
-             * Just do a series of byte writes as the architecture demands.
-             */
-            for (int i = 0; i < blocklen; i++) {
-                cpu_stb_mmuidx_ra(env, vaddr + i, 0, mmu_idx, ra);
-            }
-            return;
+    /* Watchpoints have lower priority than alignment faults. */
+    if (unlikely(flags & TLB_WATCHPOINT)) {
+        cpu_check_watchpoint(env_cpu(env), addr & -len, len,
+                             attrs, BP_MEM_WRITE, ra);
+        flags &= ~TLB_WATCHPOINT;
+    }
+#endif
+    return flags;
+}
+
+static void do_dczva_0(CPUARMState *env, vaddr addr, size_t len, void *mem,
+                       int mmu_idx, int flags, uintptr_t ra)
+{
+#ifndef CONFIG_USER_ONLY
+    /*
+     * There are a couple of cases where QEMU wants the slow path;
+     * just do a series of byte writes as the architecture demands.
+     */
+    if (unlikely(flags)) {
+        for (size_t i = 0; i < len; i++) {
+            cpu_stb_mmuidx_ra(env, addr + i, 0, mmu_idx, ra);
         }
+        return;
     }
 #endif
 
     set_helper_retaddr(ra);
-    memset(mem, 0, blocklen);
+    memset(mem, 0, len);
     clear_helper_retaddr();
 }
 
+void HELPER(dc_zva)(CPUARMState *env, uint64_t addr)
+{
+    uintptr_t ra = GETPC();
+    size_t len = (size_t)4 << get_dczid_bs(env_archcpu(env));
+    int mmu_idx = arm_env_mmu_index(env);
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    int flags;
+    void *mem;
+
+    /* DC_ZVA requires that we supply the original pointer for traps. */
+#ifdef CONFIG_USER_ONLY
+    flags = probe_access_flags(env, addr, 0, MMU_DATA_STORE, mmu_idx,
+                               false, &mem, ra);
+#else
+    CPUTLBEntryFull *full;
+    flags = probe_access_full(env, addr, 0, MMU_DATA_STORE, mmu_idx,
+                              false, &mem, &full, ra);
+    attrs = full->attrs;
+#endif
+
+    flags = do_dcxva_traps(env, addr, len, mmu_idx, flags, attrs, ra);
+
+    /* After traps, treat as aligned blocks. */
+    addr = addr & -len;
+    mem = (void *)((uintptr_t)mem & -len);
+
+    do_dczva_0(env, addr, len, mem, mmu_idx, flags, ra);
+}
+
 /*
  * Perform an MTE checked access for DC_ZVA.
  */
-- 
2.43.0


