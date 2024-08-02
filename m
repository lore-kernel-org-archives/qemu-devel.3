Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C655EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 00:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZgC4-000124-3w; Thu, 01 Aug 2024 20:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZgBs-0000xv-PS
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 20:30:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZgBp-0002Tw-Dn
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 20:30:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ff3d5c6e9eso29957085ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 17:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722558635; x=1723163435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LiMEQG69yJo8ctZ7Uv/IEe1k23BKFoSxFIRYOs9ZoWQ=;
 b=rgLovX5fqoz0qwTT0MAGa+USGXWWvfu0oVRb/ivhjyIRffmiEJmolhvnwwsClgtqhL
 Wzwt6nt0sm47toRzQrTsg3W5ifCKlKUlXMxcA1vIVxIOyCsGnB6STpL3om82CmnzkWxC
 hwbXl9jN660YjpV1E+6oBneWopmbYH3q4nWe3niQ1SdY1uU7+2yEVQLwNB80IJCZqINy
 mSZdyQSpn1mlvLFnjSj4CeIRS+gyO5hDe06DQ4RUmrXcImxPdAffB6WMJwdQpjooiq79
 85hTmX73u/p4GVAphfU7jAiUuKT2O7504ilaNEJq8YT1Deur2ZYmCNhDmaXwhALAGCmA
 M8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722558635; x=1723163435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LiMEQG69yJo8ctZ7Uv/IEe1k23BKFoSxFIRYOs9ZoWQ=;
 b=lcOgzCSBa0SRH2uJr616ngClPGzt/ctBqKKWeohRAtkgZ0TtaL8nJkOh9QAZePVgGr
 Iww833r2o6zMpkCnqSfdud9SgXePXWuGMs4rmAQU0HdZrMkVWmyqbwTKK6DDriSdbyRB
 WgBFlnuvBmxLRs5/ZKZ5+Ne7D8P/K073paAOwv2uCOy3RFTYMw3cteg0njZWE145pBFk
 vdnAMlox+gAVb9yq/+4LTuFXQjCbcLYP7iMjULmtptWcCe7chZaiNOm1YYshaF9+21PY
 M2mUHmTbYa9DAWP+/32G+tCEOH15yyr4SXfI7CYMo/uwh0urTofITxtXE9KL1Lx8/xz7
 tYMQ==
X-Gm-Message-State: AOJu0YylG/A7I5kZpkr+GggcgEMHz6k+0X3ERuKRWkDDaSHWKhDNa1Qo
 +qqSPiE1mF84rs8TbrC4hn/k2+yfa5peTrg97npe3TOGH0E0udYFHMV5bAOsBfn9hRFF76xT4ZV
 XIHJwsA==
X-Google-Smtp-Source: AGHT+IF6O2KO+yk5RZ+uVie8EHwhtfX1pKabS9JHMM42fkhnmmI5NgyrT0ucZru6Jo1HL1qvMigrRQ==
X-Received: by 2002:a17:902:f54b:b0:1fd:6c5b:afcc with SMTP id
 d9443c01a7336-1ff5727c375mr26297155ad.8.1722558635018; 
 Thu, 01 Aug 2024 17:30:35 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff59175d73sm4891275ad.193.2024.08.01.17.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 17:30:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/arm: Fix BTI versus CF_PCREL
Date: Fri,  2 Aug 2024 10:30:28 +1000
Message-ID: <20240802003028.795476-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

With pcrel, we cannot check the guarded page bit at translation
time, as different mappings of the same physical page may or may
not have the GP bit set.

Instead, add a couple of helpers to check the page at runtime,
after all other filters that might obviate the need for the check.

The set_btype_for_br call must be moved after the gen_a64_set_pc
call to ensure the current pc can still be computed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

v2: Enable unwind from guarded_page_br.
    Since guarded_page_check is called exclusively with btype != 0,
    it must immediately follow an indirect branch or eret, so cpu
    state is up-to-date, so unwind is not required.

---
 target/arm/tcg/helper-a64.h    |  3 ++
 target/arm/tcg/translate.h     |  2 --
 target/arm/tcg/helper-a64.c    | 39 +++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 64 ++++++++--------------------------
 4 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 371388f61b..481007bf39 100644
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
index a8672c857c..01c217f4a4 100644
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
index c60d2a7ec9..21a9abd90a 100644
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
index 148be2826e..28a1013503 100644
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
2.43.0


