Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE52C531DB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2d-0000xx-6Y; Fri, 09 Aug 2024 14:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2c-0000ww-0w
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2Z-0007C1-Q0
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso1208533f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226918; x=1723831718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jhQP03+tlFIXCNvACIpxrmWqMTiMtqMMEpE7GGG91S4=;
 b=BAOg1q2xhDlp3QLZNTMmk66nLK1SPBTUQAD5lWrPsnsBA0A8sBpqXQf5X4j3pi+Ujt
 tBaqGDST2n/0y668bv5uy6mu7ZkEvMLqRqTbQYorZFzyWLGK4xMkwpd9GSf83Uiy6ku7
 yD5QtpL1GWYuk+/xMhnpM7IO3z7MLE4G66xBLKKsJkZ5jdcR9jHhIE0XKrZPn0gHFc5g
 ojbDxUDL8+fsd58TuvklQMLzNwIUcYBOlHb3XCxw/rUsEs6JWv7RgpfUozbr2MFhriob
 dDkCQcPB2X9DLBzblCRspdyajF39ASS6HxSOXuLg5ohv7y8EMdD83A+bgMkYTUyi6zaJ
 GXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226918; x=1723831718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jhQP03+tlFIXCNvACIpxrmWqMTiMtqMMEpE7GGG91S4=;
 b=UbYCr7f/LoENJJWfnpa9SkIVEff3zm273hSJnrLW0IMKX0C98W9jtp7UBF8I0a+vCv
 ZeVnpOThWcTJFov4xQpXp6SVwhznEfZrF/4cBHwHKRl9dS69+h9o1cn9Vl5IK9EcnH0d
 E6D/Y3oJWhkFs6LCtcFzGKtPGntUoQrC3DgEUUEUqM9Sf41tkjv8/rc2XX3bEvnzwrhJ
 cHTkpH9muzKDWWr5/ySVyLF+RzJXvUCoQmVM7sCWQLXR7SqctT0Zkec/bBvLP3N4/XXX
 dDwr1RR7HnsEQUvj7u6Dw2z/esukr/CrQFrJWiNsNd0+Ft3mFoawLQIR0MyUD4u2ztmR
 oa5w==
X-Gm-Message-State: AOJu0YwEx7FR5QbEGp/QeNAAP+T1NfXwXs8BHWoGC3cWFLHhwmc3Rhfl
 S3CjuEjVOFnGO91VhAQT5/6lYqGARmCODBZzCeD9ZX+VjjmXdJaJA0+ntvrG3bhhBOWLrW3Uf+y
 B
X-Google-Smtp-Source: AGHT+IGx4kc0F+g6sGvC5+OVlRvFJ8cteY/oNBFuxVigFm1/udHUhbHZtKHuuzZcVaRP0PvpnErESA==
X-Received: by 2002:a5d:6552:0:b0:368:3198:5ac4 with SMTP id
 ffacd0b85a97d-36d60346adbmr1685448f8f.39.1723226918077; 
 Fri, 09 Aug 2024 11:08:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] target/arm: Fix BTI versus CF_PCREL
Date: Fri,  9 Aug 2024 19:08:25 +0100
Message-Id: <20240809180835.1243269-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809180835.1243269-1-peter.maydell@linaro.org>
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

With pcrel, we cannot check the guarded page bit at translation
time, as different mappings of the same physical page may or may
not have the GP bit set.

Instead, add a couple of helpers to check the page at runtime,
after all other filters that might obviate the need for the check.

The set_btype_for_br call must be moved after the gen_a64_set_pc
call to ensure the current pc can still be computed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240802003028.795476-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    |  3 ++
 target/arm/tcg/translate.h     |  2 --
 target/arm/tcg/helper-a64.c    | 39 +++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 64 ++++++++--------------------------
 4 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 371388f61b5..481007bf397 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -133,6 +133,9 @@ DEF_HELPER_4(cpyfp, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfm, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
 
+DEF_HELPER_FLAGS_1(guarded_page_check, TCG_CALL_NO_WG, void, env)
+DEF_HELPER_FLAGS_2(guarded_page_br, TCG_CALL_NO_RWG, void, env, tl)
+
 DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index a8672c857c1..01c217f4a45 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -163,8 +163,6 @@ typedef struct DisasContext {
     uint8_t dcz_blocksize;
     /* A copy of cpu->gm_blocksize. */
     uint8_t gm_blocksize;
-    /* True if this page is guarded.  */
-    bool guarded_page;
     /* True if the current insn_start has been updated. */
     bool insn_start_updated;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index c60d2a7ec96..21a9abd90a6 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1877,3 +1877,42 @@ void HELPER(cpyfe)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
 {
     do_cpye(env, syndrome, wdesc, rdesc, false, GETPC());
 }
+
+static bool is_guarded_page(CPUARMState *env, target_ulong addr, uintptr_t ra)
+{
+#ifdef CONFIG_USER_ONLY
+    return page_get_flags(addr) & PAGE_BTI;
+#else
+    CPUTLBEntryFull *full;
+    void *host;
+    int mmu_idx = cpu_mmu_index(env_cpu(env), true);
+    int flags = probe_access_full(env, addr, 0, MMU_INST_FETCH, mmu_idx,
+                                  false, &host, &full, ra);
+
+    assert(!(flags & TLB_INVALID_MASK));
+    return full->extra.arm.guarded;
+#endif
+}
+
+void HELPER(guarded_page_check)(CPUARMState *env)
+{
+    /*
+     * We have already verified that bti is enabled, and that the
+     * instruction at PC is not ok for BTYPE.  This is always at
+     * the beginning of a block, so PC is always up-to-date and
+     * no unwind is required.
+     */
+    if (is_guarded_page(env, env->pc, 0)) {
+        raise_exception(env, EXCP_UDEF, syn_btitrap(env->btype),
+                        exception_target_el(env));
+    }
+}
+
+void HELPER(guarded_page_br)(CPUARMState *env, target_ulong pc)
+{
+    /*
+     * We have already checked for branch via x16 and x17.
+     * What remains for choosing BTYPE is checking for a guarded page.
+     */
+    env->btype = is_guarded_page(env, pc, GETPC()) ? 3 : 1;
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 148be2826ec..28a10135032 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1507,7 +1507,14 @@ static void set_btype_for_br(DisasContext *s, int rn)
 {
     if (dc_isar_feature(aa64_bti, s)) {
         /* BR to {x16,x17} or !guard -> 1, else 3.  */
-        set_btype(s, rn == 16 || rn == 17 || !s->guarded_page ? 1 : 3);
+        if (rn == 16 || rn == 17) {
+            set_btype(s, 1);
+        } else {
+            TCGv_i64 pc = tcg_temp_new_i64();
+            gen_pc_plus_diff(s, pc, 0);
+            gen_helper_guarded_page_br(tcg_env, pc);
+            s->btype = -1;
+        }
     }
 }
 
@@ -1521,8 +1528,8 @@ static void set_btype_for_blr(DisasContext *s)
 
 static bool trans_BR(DisasContext *s, arg_r *a)
 {
-    gen_a64_set_pc(s, cpu_reg(s, a->rn));
     set_btype_for_br(s, a->rn);
+    gen_a64_set_pc(s, cpu_reg(s, a->rn));
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -1581,8 +1588,8 @@ static bool trans_BRAZ(DisasContext *s, arg_braz *a)
     }
 
     dst = auth_branch_target(s, cpu_reg(s, a->rn), tcg_constant_i64(0), !a->m);
-    gen_a64_set_pc(s, dst);
     set_btype_for_br(s, a->rn);
+    gen_a64_set_pc(s, dst);
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -11878,37 +11885,6 @@ static bool trans_FAIL(DisasContext *s, arg_OK *a)
     return true;
 }
 
-/**
- * is_guarded_page:
- * @env: The cpu environment
- * @s: The DisasContext
- *
- * Return true if the page is guarded.
- */
-static bool is_guarded_page(CPUARMState *env, DisasContext *s)
-{
-    uint64_t addr = s->base.pc_first;
-#ifdef CONFIG_USER_ONLY
-    return page_get_flags(addr) & PAGE_BTI;
-#else
-    CPUTLBEntryFull *full;
-    void *host;
-    int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
-    int flags;
-
-    /*
-     * We test this immediately after reading an insn, which means
-     * that the TLB entry must be present and valid, and thus this
-     * access will never raise an exception.
-     */
-    flags = probe_access_full(env, addr, 0, MMU_INST_FETCH, mmu_idx,
-                              false, &host, &full, 0);
-    assert(!(flags & TLB_INVALID_MASK));
-
-    return full->extra.arm.guarded;
-#endif
-}
-
 /**
  * btype_destination_ok:
  * @insn: The instruction at the branch destination
@@ -12151,19 +12127,6 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     if (dc_isar_feature(aa64_bti, s)) {
         if (s->base.num_insns == 1) {
-            /*
-             * At the first insn of the TB, compute s->guarded_page.
-             * We delayed computing this until successfully reading
-             * the first insn of the TB, above.  This (mostly) ensures
-             * that the softmmu tlb entry has been populated, and the
-             * page table GP bit is available.
-             *
-             * Note that we need to compute this even if btype == 0,
-             * because this value is used for BR instructions later
-             * where ENV is not available.
-             */
-            s->guarded_page = is_guarded_page(env, s);
-
             /* First insn can have btype set to non-zero.  */
             tcg_debug_assert(s->btype >= 0);
 
@@ -12172,12 +12135,13 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
              * priority -- below debugging exceptions but above most
              * everything else.  This allows us to handle this now
              * instead of waiting until the insn is otherwise decoded.
+             *
+             * We can check all but the guarded page check here;
+             * defer the latter to a helper.
              */
             if (s->btype != 0
-                && s->guarded_page
                 && !btype_destination_ok(insn, s->bt, s->btype)) {
-                gen_exception_insn(s, 0, EXCP_UDEF, syn_btitrap(s->btype));
-                return;
+                gen_helper_guarded_page_check(tcg_env);
             }
         } else {
             /* Not the first insn: btype must be 0.  */
-- 
2.34.1


