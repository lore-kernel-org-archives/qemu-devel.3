Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF67C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6l-0005vs-JC; Thu, 18 Jul 2024 21:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc62-0003Tp-PT
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:44 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc5y-0000oF-N7
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc658b6b2eso9408185ad.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351256; x=1721956056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMEEORHFY/5AJeKs7AXO2kip576OxvLWKFUcuNYKW6c=;
 b=uFWfHCsOzEFDKVpv3bEq9FU9tl93BofivGm38wbi4M/bCQzU+nCQ1CqreYZzhZjcl8
 2oq8oXy7KRtRW6ES1YYxn3EHzZoSQE9JFKtBzdsEnhmNQbvLewMUviDIEGccBzBlRwr5
 TwIxOi0JaXb3/+A+kpclmwQclW7iTmwcuFqwYf6FLcWujWbMPotVDAc6voly6KrVReJ0
 PcXj3zfYVD8UJ6zaEAUAOKaU5mTEd8rJB10fn/DNGuzjptBawxQHmpjQ5vQJZPbfGl5j
 aVa8ZGTsUF/iekekupPhtOcg2X5IAZCIV/v3QnEr0jRE4HqRKSMd6lN/mtK+Es1yMZ3B
 NPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351256; x=1721956056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMEEORHFY/5AJeKs7AXO2kip576OxvLWKFUcuNYKW6c=;
 b=v3KrlxWzFVBYdtJQYLgJnbB2GzeJ6kXDG8ehxX0QvzoHeL6sdqBJFFpqhQnXJSpOOf
 Ozav9FM5UN6rMDRKy7e8X6JbZBTW6mgTjnQK8hJDe84/4y6MeFPsa4Jl/4PpBYVsGar2
 XXOd8vC+djboJRzhwIRfBh8IiT/YYc0uKD45jlTBcczTMgCJQTlwkJaSCJbquFpv7K7v
 BlNZfxHk257XujB3fCp+YdpbByPuoyMgHvFAUBH85xqEzuPb/BECwlzSqruxM3Bu74IV
 7mhrOcr7WDm25PDkjX4CfgLmnJ0Gxd1wj7Bp154BnnloxNcei+QEzXtrzejSg5W/4gnR
 Z6jA==
X-Gm-Message-State: AOJu0Yx2zurFuJGpJNRSOwAgXZShN04HloqeUoba1f81uGDuJIISN7QX
 1GWqKMJznW1bk/fba8hz8jzDWVCpJHaoZ6qcNbKJHb1dankCJdCbADvduMZpK+nb7byI7aRo+lK
 eUP84ZQ==
X-Google-Smtp-Source: AGHT+IFJIQDUuu0/EOFFle+gZ7LYLHCduHhq26cr0sEkJHzKeE9ySJm9w09NCOosESs3piIBKdpjVQ==
X-Received: by 2002:a17:902:ec89:b0:1fb:8466:7df3 with SMTP id
 d9443c01a7336-1fc4e567292mr61058435ad.28.1721351256302; 
 Thu, 18 Jul 2024 18:07:36 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 06/12] target/ppc: Split out helper_dbczl for 970
Date: Fri, 19 Jul 2024 11:07:01 +1000
Message-ID: <20240719010707.1319675-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

We can determine at translation time whether the insn is or
is not dbczl.  We must retain a runtime check against the
HID5 register, but we can move that to a separate function
that never affects other ppc models.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  7 +++++--
 target/ppc/mem_helper.c | 34 +++++++++++++++++++++-------------
 target/ppc/translate.c  | 24 ++++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 76b8f25c77..afc56855ff 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -46,8 +46,11 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(lsw, void, env, tl, i32, i32)
 DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
-DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
-DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
+DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
+#ifdef TARGET_PPC64
+DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
+#endif
 DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 5067919ff8..d4957efd6e 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -296,26 +296,34 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
+void helper_dcbz(CPUPPCState *env, target_ulong addr)
 {
-    int dcbz_size = env->dcache_line_size;
-
-#if defined(TARGET_PPC64)
-    /* Check for dcbz vs dcbzl on 970 */
-    if (env->excp_model == POWERPC_EXCP_970 &&
-        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
-        dcbz_size = 32;
-    }
-#endif
-
-    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+    dcbz_common(env, addr, env->dcache_line_size,
+                ppc_env_mmu_index(env, false), GETPC());
 }
 
-void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
+void helper_dcbzep(CPUPPCState *env, target_ulong addr)
 {
     dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
 }
 
+#ifdef TARGET_PPC64
+void helper_dcbzl(CPUPPCState *env, target_ulong addr)
+{
+    int dcbz_size = env->dcache_line_size;
+
+    /*
+     * The translator checked for POWERPC_EXCP_970.
+     * All that's left is to check HID5.
+     */
+    if (((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
+        dcbz_size = 32;
+    }
+
+    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+}
+#endif
+
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
     addr &= ~(env->dcache_line_size - 1);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0bc16d7251..9e472ab7ef 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -178,6 +178,7 @@ struct DisasContext {
     /* Translation flags */
     MemOp default_tcg_memop_mask;
 #if defined(TARGET_PPC64)
+    powerpc_excp_t excp_model;
     bool sf_mode;
     bool has_cfar;
     bool has_bhrb;
@@ -4445,27 +4446,29 @@ static void gen_dcblc(DisasContext *ctx)
 /* dcbz */
 static void gen_dcbz(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbz(tcg_env, tcgv_addr, tcgv_op);
+
+#ifdef TARGET_PPC64
+    if (ctx->excp_model == POWERPC_EXCP_970 && !(ctx->opcode & 0x00200000)) {
+        gen_helper_dcbzl(tcg_env, tcgv_addr);
+        return;
+    }
+#endif
+
+    gen_helper_dcbz(tcg_env, tcgv_addr);
 }
 
 /* dcbzep */
 static void gen_dcbzep(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbzep(tcg_env, tcgv_addr, tcgv_op);
+    gen_helper_dcbzep(tcg_env, tcgv_addr);
 }
 
 /* dst / dstt */
@@ -6486,6 +6489,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->default_tcg_memop_mask = ctx->le_mode ? MO_LE : MO_BE;
     ctx->flags = env->flags;
 #if defined(TARGET_PPC64)
+    ctx->excp_model = env->excp_model;
     ctx->sf_mode = (hflags >> HFLAGS_64) & 1;
     ctx->has_cfar = !!(env->flags & POWERPC_FLAG_CFAR);
     ctx->has_bhrb = !!(env->flags & POWERPC_FLAG_BHRB);
-- 
2.43.0


