Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CE9C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkru7-0001hV-Op; Fri, 17 Jul 2026 19:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkru4-0001em-1g
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:36 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkru0-00073D-3F
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:35 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso5470718a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330610; x=1784935410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/+gOtEK+4wt+LDZh97nLyEPdOI5ONUbxlvkS7t1kf94=;
 b=NqFTXrzEExv8TuUe0xkLtuz2c6HfTwiPqFiS1384eNiNynvJ1FrzdBdNCughp1cLAr
 U2PQLYOhyYOBb6+ZRHPLKqI6V670iwD5RuuUEHDtiGy70YQVGpCkkvQ4JFpEX1S/M9oT
 LVc492Ybw6L1WoUSs8TzFKjj21V1Gr03RaZ2Eg1sLmI3RTfKyGrzcbYGPAeyfJZ9kmE6
 42g3MiR6qdFRXWeB+WsFeD0bVaDlc+qxmCpi9yqgu12ZiDO23LBqGtMSA10t7t4IsniV
 gKPkGawq3LZr0DqGFCUKyweMVtOQOo4IkorLfRbcDKvRuzrL6WdI/Tw+dA3L5tAY6w8p
 Gkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330610; x=1784935410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/+gOtEK+4wt+LDZh97nLyEPdOI5ONUbxlvkS7t1kf94=;
 b=LXjAcquE6NbMR24KKAb9rVsfaTqqCE9TSs8y2Up+NRTQSaQK1JpXJl7PMGjcDrSf8+
 2zBDMqnfc/kLwRg7I1P+JfC8DzEUJbeVcs7y8fERFg9vdoFX8rNoCdqSLsl1//30mxVR
 h83SJzQyzdqiEsbJkn+atLQH4nedQAgOZipP636yOzPhmVHTsYeymHesAxp7qnG1r1LU
 KbekauLMGcUeYzX6cH0K6OUPJmcDZBGPvNEiorNpJSVtQGtzVHQHm+SG3+CgcexbWlsn
 noi9bFWVa2xgZZMsciTsoCxaDLdDRlVeUBdYXdnBut+z/G/kzkiPiioyNz6CXBh0mgwx
 mPKQ==
X-Gm-Message-State: AOJu0YwkTmxmn3BgKGp7iXFBhLHLFYKa2jWXQZxaaHLW7cd2A9Yt0BT6
 wvtZBVixeVKcz1iFZ8a5iohmsdfDJ5X2vdFAelbvY1Et7XV4OC8IW6UPvghnCLsl/FX8HrnOqMU
 cYQiV
X-Gm-Gg: AfdE7ck1bBvOIfChG/lchbU1K1ik6KwVbMV/N8vIytw8l65V58Ty31LiBz1t1ftzQ/D
 cRlc5S7bqD3ZFq8w2ocUCGaO9E3LNRg+zyHhGf+QOzm9zr6OHao+qdzbBCWS4EW6d3hS8Fl5f40
 4pAAjkmymS8WNsTZwgvZvnXYsqILuSdlVZOmUikjlSDY2BkuvkCmZsKcyAZtHrfWs3RVAdMW8LJ
 qpDetOC4ywWUoRGs/jfe64sUvb9kfX5vAP6bU1cZQaY3NgXrbH8KteVsnFZstY+sj8jSuT/fkBA
 lOddI9w3fhMRi9/dg0Mv2gEDqN5mqouUkqNysEoDjKN2ul3B8RGAttkRJqVamptCgdVRsL74MpD
 nqMGO5Ds+3T2XbyMAexEJ1deITSBysfP9RjPTJYnwN8jCuw2WDejWwXqfmxQtBeVSoRnBwIEr1g
 cjhwyD5AY=
X-Received: by 2002:a17:90b:574c:b0:387:e0cb:7ee with SMTP id
 98e67ed59e1d1-38e4b585dd2mr4650729a91.34.1784330610477; 
 Fri, 17 Jul 2026 16:23:30 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/17] target/arm: Rewrite DC_GVA, DC_GZVA, STZGM
Date: Fri, 17 Jul 2026 16:23:05 -0700
Message-ID: <20260717232306.378988-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Perform alignment trap on device memory.  Recognize watchpoints.
Perform both in the correct order wrt MTX faults.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h |   5 +-
 target/arm/tcg/mte_helper.c      | 127 ++++++++++++++++++++++---------
 target/arm/tcg/translate-a64.c   |  49 +++++-------
 3 files changed, 115 insertions(+), 66 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 518e74c8aa..0d0830c837 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -82,6 +82,9 @@ DEF_HELPER_3(vfp_ah_maxd, f64, f64, f64, fpst)
 
 DEF_HELPER_FLAGS_3(dc_zva, TCG_CALL_NO_WG, void, env, i64, i32)
 DEF_HELPER_FLAGS_3(dc_zva_mte, TCG_CALL_NO_WG, void, env, i64, i32)
+DEF_HELPER_FLAGS_3(dc_gva, TCG_CALL_NO_WG, void, env, i64, i32)
+DEF_HELPER_FLAGS_3(dc_gva_stub, TCG_CALL_NO_WG, void, env, i64, i32)
+DEF_HELPER_FLAGS_3(dc_gzva, TCG_CALL_NO_WG, void, env, i64, i32)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
@@ -111,7 +114,7 @@ DEF_HELPER_FLAGS_4(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_3(ldgm, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_4(stgm, TCG_CALL_NO_WG, void, env, i64, i64, i32)
-DEF_HELPER_FLAGS_4(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64, i32)
+DEF_HELPER_FLAGS_4(stzgm, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 
 DEF_HELPER_FLAGS_4(arm_unaligned_access, TCG_CALL_NO_WG,
                    noreturn, env, i64, i32, i32)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 4161f4eb32..25adc8c714 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -671,36 +671,6 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val, uint32_t mtx)
     }
 }
 
-void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val,
-                        uint32_t mtx)
-{
-    uintptr_t ra = GETPC();
-    int mmu_idx = arm_env_mmu_index(env);
-    int log2_dcz_bytes, log2_tag_bytes;
-    intptr_t dcz_bytes, tag_bytes;
-    uint8_t *mem;
-
-    /*
-     * In arm_cpu_realizefn, we assert that dcz > LOG2_TAG_GRANULE+1,
-     * i.e. 32 bytes, which is an unreasonably small dcz anyway,
-     * to make sure that we can access one complete tag byte here.
-     */
-    log2_dcz_bytes = get_dczid_bs(env_archcpu(env)) + 2;
-    log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
-    dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
-    tag_bytes = (intptr_t)1 << log2_tag_bytes;
-    ptr &= -dcz_bytes;
-
-    mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE, dcz_bytes,
-                             MMU_DATA_STORE, ra);
-    if (mem) {
-        int tag_pair = (val & 0xf) * 0x11;
-        memset(mem, tag_pair, tag_bytes);
-    } else if (raw_mtx_check(mtx, extract64(ptr, 55, 1))) {
-        canonical_tag_write_fail(env, ptr, ra);
-    }
-}
-
 static void mte_sync_check_fail(CPUARMState *env, uint32_t desc,
                                 uint64_t dirty_ptr, uintptr_t ra)
 {
@@ -1092,8 +1062,9 @@ bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr)
 }
 
 /* Traps for DC_ZVA, DC_GVA, and friends, after successful page lookup. */
-static int do_dcxva_traps(CPUARMState *env, vaddr addr, size_t len, int mmu_idx,
-                          int flags, MemTxAttrs attrs, uintptr_t ra)
+static int do_dcxva_traps(CPUARMState *env, vaddr addr, size_t len,
+                          int mmu_idx, int flags, MemTxAttrs attrs,
+                          uint32_t mtx_write, uintptr_t ra)
 {
 #ifndef CONFIG_USER_ONLY
     /*
@@ -1106,7 +1077,17 @@ static int do_dcxva_traps(CPUARMState *env, vaddr addr, size_t len, int mmu_idx,
         arm_cpu_do_unaligned_access(env_cpu(env), addr, MMU_DATA_STORE,
                                     mmu_idx, ra);
     }
+#endif
 
+    /*
+     * MTX write fault is via AArch64_S1CheckPermissions, which happens
+     * after AArch64_S1HasAlignmentFaultDueToMemType.
+     */
+    if (mtx_check(mtx_write, extract64(addr, 55, 1))) {
+        canonical_tag_write_fail(env, addr, ra);
+    }
+
+#ifndef CONFIG_USER_ONLY
     /* Watchpoints have lower priority than alignment faults. */
     if (unlikely(flags & TLB_WATCHPOINT)) {
         cpu_check_watchpoint(env_cpu(env), addr & -len, len,
@@ -1158,7 +1139,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t addr, uint32_t desc)
     attrs = full->attrs;
 #endif
 
-    flags = do_dcxva_traps(env, addr, len, mmu_idx, flags, attrs, ra);
+    flags = do_dcxva_traps(env, addr, len, mmu_idx, flags, attrs, 0, ra);
 
     /* After traps, treat as aligned blocks. */
     addr = addr & -len;
@@ -1180,7 +1161,7 @@ void HELPER(dc_zva_mte)(CPUARMState *env, uintptr_t ptr_orig, uint32_t desc)
                                     dcz_bytes, MMU_DATA_LOAD, ra, ATM_ZVA);
 
     r.flags = do_dcxva_traps(env, ptr, dcz_bytes, mmu_idx,
-                             r.flags, r.attrs, ra);
+                             r.flags, r.attrs, 0, ra);
 
     bit55 = extract64(ptr, 55, 1);
     ptr_tag = allocation_tag_from_addr(ptr);
@@ -1266,6 +1247,84 @@ void HELPER(dc_zva_mte)(CPUARMState *env, uintptr_t ptr_orig, uint32_t desc)
     do_dczva_0(env, ptr, dcz_bytes, r.ptr_mem, mmu_idx, r.flags, ra);
 }
 
+static void do_stzgm_tags(void *mem, int dcz_bytes, int tag)
+{
+    /*
+     * In arm_cpu_realizefn, we asserted that dcz > LOG2_TAG_GRANULE+1,
+     * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make
+     * sure that we can access one complete tag byte here.
+     */
+    int tag_bytes = dcz_bytes / (TAG_GRANULE * 2);
+    int tag_pair = (tag & 0xf) * 0x11;
+    memset(mem, tag_pair, tag_bytes);
+}
+
+void HELPER(dc_gva)(CPUARMState *env, uint64_t ptr, uint32_t desc)
+{
+    int dcz_bytes = FIELD_EX32(desc, MTEDESC, SIZEM1) + 1;
+    int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+    uintptr_t ra = GETPC();
+
+    AllocationTagMem r =
+        allocation_tag_mem_internal(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                    dcz_bytes, MMU_DATA_STORE, ra, ATM_ZVA);
+
+    do_dcxva_traps(env, ptr, dcz_bytes, mmu_idx, r.flags, r.attrs,
+                   r.tag_mem ? 0 : desc, ra);
+
+    if (r.tag_mem) {
+        do_stzgm_tags(r.tag_mem, dcz_bytes, allocation_tag_from_addr(ptr));
+    }
+}
+
+/* DC GVA when tag access is disabled -- we still want all of the traps. */
+void HELPER(dc_gva_stub)(CPUARMState *env, uint64_t ptr, uint32_t desc)
+{
+    uintptr_t ra = GETPC();
+    int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+
+#ifdef CONFIG_USER_ONLY
+    probe_write(env, ptr, 0, mmu_idx, ra);
+#else
+    int len = FIELD_EX32(desc, MTEDESC, SIZEM1) + 1;
+    void *mem;
+    CPUTLBEntryFull *full;
+    int flags = probe_access_full(env, ptr, 0, MMU_DATA_STORE, mmu_idx,
+                                  false, &mem, &full, ra);
+    do_dcxva_traps(env, ptr, len, mmu_idx, flags, full->attrs, 0, ra);
+#endif
+}
+
+static void do_gzva_stzgm(CPUARMState *env, uint64_t ptr, uint64_t tag,
+                          uint32_t desc, uintptr_t ra)
+{
+    int dcz_bytes = FIELD_EX32(desc, MTEDESC, SIZEM1) + 1;
+    int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
+
+    AllocationTagMem r =
+        allocation_tag_mem_internal(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                    dcz_bytes, MMU_DATA_STORE, ra, ATM_ZVA);
+
+    r.flags = do_dcxva_traps(env, ptr, dcz_bytes, mmu_idx, r.flags, r.attrs,
+                             r.tag_mem ? 0 : desc, ra);
+
+    if (r.tag_mem) {
+        do_stzgm_tags(r.tag_mem, dcz_bytes, tag);
+    }
+    do_dczva_0(env, ptr, dcz_bytes, r.ptr_mem, mmu_idx, r.flags, ra);
+}
+
+void HELPER(dc_gzva)(CPUARMState *env, uint64_t ptr, uint32_t desc)
+{
+    do_gzva_stzgm(env, ptr, allocation_tag_from_addr(ptr), desc, GETPC());
+}
+
+void HELPER(stzgm)(CPUARMState *env, uint64_t ptr, uint64_t tag, uint32_t desc)
+{
+    int dcz_bytes = FIELD_EX32(desc, MTEDESC, SIZEM1) + 1;
+    do_gzva_stzgm(env, ptr & -dcz_bytes, tag, desc, GETPC());
+}
+
 uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
                         uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cae8d6826f..6ce123eafc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3150,41 +3150,25 @@ static void handle_sys(DisasContext *s, bool isread,
         return;
     case ARM_CP_DC_GVA:
         {
-            TCGv_i64 clean_addr, tag;
+            TCGv_i32 desc = gen_mtedesc_zva(s);
 
-            /*
-             * DC_GVA, like DC_ZVA, requires that we supply the original
-             * pointer for an invalid page.  Probe that address first.
-             */
             tcg_rt = cpu_reg(s, rt);
-            clean_addr = clean_data_tbi(s, tcg_rt);
-            gen_probe_access(s, clean_addr, MMU_DATA_STORE, MO_8);
-
             if (s->ata[0]) {
-                /* Extract the tag from the register to match STZGM.  */
-                tag = tcg_temp_new_i64();
-                tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
-                                      tcg_constant_i32(s->mtx));
+                gen_helper_dc_gva(tcg_env, tcg_rt, desc);
+            } else {
+                gen_helper_dc_gva_stub(tcg_env, tcg_rt, desc);
             }
         }
         return;
     case ARM_CP_DC_GZVA:
         {
-            TCGv_i64 clean_addr, tag;
             TCGv_i32 desc = gen_mtedesc_zva(s);
 
-            /* For DC_GZVA, we can rely on DC_ZVA for the proper fault. */
             tcg_rt = cpu_reg(s, rt);
-            clean_addr = clean_data_tbi(s, tcg_rt);
-            gen_helper_dc_zva(tcg_env, clean_addr, desc);
-
             if (s->ata[0]) {
-                /* Extract the tag from the register to match STZGM.  */
-                tag = tcg_temp_new_i64();
-                tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
-                                      tcg_constant_i32(s->mtx));
+                gen_helper_dc_gzva(tcg_env, tcg_rt, desc);
+            } else {
+                gen_helper_dc_zva(tcg_env, tcg_rt, desc);
             }
         }
         return;
@@ -4767,6 +4751,7 @@ static bool trans_LD_single_repl(DisasContext *s, arg_LD_single_repl *a)
 static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
 {
     TCGv_i64 addr, tcg_rt;
+    TCGv_i32 desc;
 
     if (!dc_isar_feature(aa64_mte, s)) {
         return false;
@@ -4781,17 +4766,19 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
 
     addr = read_cpu_reg_sp(s, a->rn, true);
     tcg_gen_addi_i64(addr, addr, a->imm);
-    tcg_rt = cpu_reg(s, a->rt);
 
+    desc = gen_mtedesc_zva(s);
     if (s->ata[0]) {
-        gen_helper_stzgm_tags(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
+        tcg_rt = cpu_reg(s, a->rt);
+        gen_helper_stzgm(tcg_env, addr, tcg_rt, desc);
+    } else {
+        /*
+         * The non-tags portion of STZGM is mostly like DC_ZVA,
+         * except the alignment happens before the access.
+         */
+        tcg_gen_andi_i64(addr, addr, -s->dcz_blocksize);
+        gen_helper_dc_zva(tcg_env, addr, desc);
     }
-    /*
-     * The non-tags portion of STZGM is mostly like DC_ZVA,
-     * except the alignment happens before the access.
-     */
-    tcg_gen_andi_i64(addr, addr, -s->dcz_blocksize);
-    gen_helper_dc_zva(tcg_env, addr, gen_mtedesc_zva(s));
     return true;
 }
 
-- 
2.43.0


