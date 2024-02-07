Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7297CC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXJ-0004jV-I0; Wed, 07 Feb 2024 13:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXG-0004hk-MD
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:38 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXE-00085Q-3I
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:38 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 72ADDCE1ACF;
 Wed,  7 Feb 2024 18:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D070BC43390;
 Wed,  7 Feb 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330030;
 bh=29/fLpf59A6CPqN/LYYXpn2/AuRJvOzTiNJ4whGi5vI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AUWcHwt7/HnC9M/DblhHLFjycmhf6WXSTeFzEKDgCTRVPDx84gAKWm3bms1UFKv4C
 nVlIXbXH4c4Zoh1lSiTtPVjwnwnqRZb3NAOSHmAOJDY52HZ9McMm2cqACer0VSgq41
 wOkKrGqI3gf0NswXLtSNeDrUEWHKZoiLjIPG8BJ+fhKYbQF6HeeiRCde2IrF6Ys8yb
 5CzZnejwEXbQPKlzkZBodb9nBHNJsx/pawjMigmf6k/51hQCqqaTCrHgA2C/au5z8a
 wxipSJ/jvXCiQkTQK/PaBWGZSdP8oZBJNNyPklnzxRcCyO/MOyuO5PGXvqXQDJs3T2
 uanEL/FYJkwgg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 03/13] target/hppa: Fix PSW_W and PSW_E bits in rsm,
 ssm and mtsm
Date: Wed,  7 Feb 2024 19:20:13 +0100
Message-ID: <20240207182023.36316-4-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

The ssm and rsm instructions number the PSW_W and PSW_E bits differently
than how they are actually in the PSW. Both bits are relevant on 64-bit
CPUs only.

Fix the existing ssm and rsm instructions to handle the bits correctly.
For that drop the swap_system_mask() helper function in favour of new
helper functions get_system_mask, set_system_mask and mtsm_system_mask.

get_system_mask() returns the PSW bits how they should be returned in
the target register of the ssm and rsm instructions.
set_system_mask() sets the PSW bits without any further modification.

Note that the a->i constant value of ssm and rsm have already been
converted to match the physical PSW bits by expand_sm_imm() in the
instruction decoder.

The mtsm instruction is different, as it takes the new PSW from a
register at runtime, and as such the PSW.E and PSW.W bits are moved at
runtime to the right bit positions before setting the PSW.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h        |  2 ++
 target/hppa/helper.h     |  4 +++-
 target/hppa/sys_helper.c | 46 +++++++++++++++++++++++++++++++++++++---
 target/hppa/translate.c  | 38 +++++++++++++++++++++------------
 4 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7a181e8f33..06b65f2258 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -122,7 +122,9 @@
 #define PSW_T            0x01000000
 #define PSW_S            0x02000000
 #define PSW_E            0x04000000
+#define PSW_E_BIT                37 /* PA2.0 only */
 #define PSW_W            0x08000000 /* PA2.0 only */
+#define PSW_W_BIT                36 /* PA2.0 only */
 #define PSW_Z            0x40000000 /* PA1.x only */
 #define PSW_Y            0x80000000 /* PA1.x only */
 
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 1bdbcd8f98..abffd3f531 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -92,7 +92,9 @@ DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tl, env, tl)
+DEF_HELPER_FLAGS_1(get_system_mask, TCG_CALL_NO_RWG, tl, env)
+DEF_HELPER_FLAGS_2(set_system_mask, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(mtsm_system_mask, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(idtlbt_pa20, TCG_CALL_NO_RWG, void, env, tl, tl)
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index a59245eed3..88ba99f0d4 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -58,7 +58,27 @@ void HELPER(reset)(CPUHPPAState *env)
     helper_excp(env, EXCP_HLT);
 }
 
-target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
+target_ulong HELPER(get_system_mask)(CPUHPPAState *env)
+{
+    target_ulong psw = env->psw;
+
+    /* mask out invalid bits */
+    target_ulong psw_new = psw & PSW_SM;
+
+    /* ssm/rsm instructions number PSW_W and PSW_E differently */
+    psw_new &= ~PSW_W;
+    if (psw & PSW_W) {
+        psw_new |= 1ull << (63 - PSW_W_BIT);
+    }
+    psw_new &= ~PSW_E;
+    if (psw & PSW_E) {
+        psw_new |= 1ull << (63 - PSW_E_BIT);
+    }
+
+    return psw_new;
+}
+
+void HELPER(set_system_mask)(CPUHPPAState *env, target_ulong nsm)
 {
     target_ulong psw = env->psw;
     /*
@@ -70,8 +90,28 @@ target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
      * machines set the Q bit from 0 to 1 without an exception,
      * so let this go without comment.
      */
-    env->psw = (psw & ~PSW_SM) | (nsm & PSW_SM);
-    return psw & PSW_SM;
+
+    cpu_hppa_put_psw(env, (psw & ~PSW_SM) | (nsm & PSW_SM));
+}
+
+void HELPER(mtsm_system_mask)(CPUHPPAState *env, target_ulong nsm)
+{
+    target_ulong psw_new;
+
+    /* mask out invalid bits */
+    psw_new = nsm & PSW_SM;
+
+    /* set PSW_E and PSW_W */
+    psw_new &= ~PSW_W;
+    if (nsm & (1ull << (63 - PSW_W_BIT))) {
+        psw_new |= PSW_W;
+    }
+    psw_new &= ~PSW_E;
+    if (nsm & (1ull << (63 - PSW_E_BIT))) {
+        psw_new |= PSW_E;
+    }
+
+    helper_set_system_mask(env, psw_new);
 }
 
 void HELPER(rfi)(CPUHPPAState *env)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 53ec57ee86..10fdc0813d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2163,13 +2163,20 @@ static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
-    tcg_gen_andi_i64(tmp, tmp, ~a->i);
-    gen_helper_swap_system_mask(tmp, tcg_env, tmp);
-    save_gpr(ctx, a->t, tmp);
+    if (a->t != 0) {
+        gen_helper_get_system_mask(tmp, tcg_env);
+        save_gpr(ctx, a->t, tmp);
+    }
+
+    if (a->i) {
+        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+        tcg_gen_andi_i64(tmp, tmp, ~a->i);
+        gen_helper_set_system_mask(tcg_env, tmp);
+
+        /* Exit, check e.g. for new interrupts */
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+    }
 
-    /* Exit the TB to recognize new interrupts, e.g. PSW_M.  */
-    ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     return nullify_end(ctx);
 #endif
 }
@@ -2183,11 +2190,17 @@ static bool trans_ssm(DisasContext *ctx, arg_ssm *a)
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
-    tcg_gen_ori_i64(tmp, tmp, a->i);
-    gen_helper_swap_system_mask(tmp, tcg_env, tmp);
-    save_gpr(ctx, a->t, tmp);
+    if (a->t != 0) {
+        gen_helper_get_system_mask(tmp, tcg_env);
+        save_gpr(ctx, a->t, tmp);
+    }
+
+    if (a->i) {
+        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUHPPAState, psw));
+        tcg_gen_ori_i64(tmp, tmp, a->i);
+        gen_helper_set_system_mask(tcg_env, tmp);
 
+    }
     /* Exit the TB to recognize new interrupts, e.g. PSW_I.  */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
     return nullify_end(ctx);
@@ -2198,12 +2211,11 @@ static bool trans_mtsm(DisasContext *ctx, arg_mtsm *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
 #ifndef CONFIG_USER_ONLY
-    TCGv_i64 tmp, reg;
+    TCGv_i64 reg;
     nullify_over(ctx);
 
     reg = load_gpr(ctx, a->r);
-    tmp = tcg_temp_new_i64();
-    gen_helper_swap_system_mask(tmp, tcg_env, reg);
+    gen_helper_mtsm_system_mask(tcg_env, reg);
 
     /* Exit the TB to recognize new interrupts.  */
     ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
-- 
2.43.0


