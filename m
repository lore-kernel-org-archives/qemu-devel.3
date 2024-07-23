Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18941C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6J6-0002eW-BG; Mon, 22 Jul 2024 23:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J2-0002RL-TV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:16 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6J0-0001xq-Mc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:16 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d1d818c42so1122102b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705713; x=1722310513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMEEORHFY/5AJeKs7AXO2kip576OxvLWKFUcuNYKW6c=;
 b=aQn+7Z0fIEZjXKw0cu+5kpbaqSsSJaEV3l8j4h6auVlEIb985VZjQ4oHYIDdUhmQnF
 Jm3U7Cui7gKUdQlKt9vspacptjiznJZlJNoxSD+pkda45e0DHLXqp56lEHt+R6Ncet8g
 91t3ckWuBxKK4q/Hu1mPsY4Fd2wfImpWcrewb9O1HwcuTaW52nj2MpK6ORH2YHrV35L3
 R6R0GgTBug0h6C0uKKrViND34yKslC5yViM0agaUBnTI2W3m3yacy5wn4NMezxpX7lz1
 LB1ennyb0egTkSGFpa3dr+iNuKPvFAIbuXlchX7pBZ+EX3gSh6W0xg+mUCGgC5Jj83xD
 Wobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705713; x=1722310513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMEEORHFY/5AJeKs7AXO2kip576OxvLWKFUcuNYKW6c=;
 b=YmU8un3UYjujYya0dds6GOhIzurILPWUT4/6Ffbv+D/iLWKN8S/NCbvk9ymXARMa/y
 KHqmnd3hkyieb7Z41wFhqNUnZ3s128aI18NBtyy/wum7aE8cFIJq49B3gdbsoHB7n+Np
 3gKxPIlp7eIej5/4dX3Vkuz3fOv1ZZqzYFciDXiYtqVWnQ6IXLRXIsekv9vq6BlPVur6
 ZL0r2G6MhJ92RERiLzb6AWmDeWrO+vMwiMJTKJI9p1YKOXgxtxFJD9WHLo76ECAfIAQm
 EtGQONDAVwyesUWuEQtHiL+Ug96LlaoTumKz9q1JNgYMMcNihjxW252+hOmpwxyL5lsc
 hm3Q==
X-Gm-Message-State: AOJu0Yy8Z/QykNrQtnrWWyuMDEs+sJSwxmHo6ufKiEvJ3K1qSnca8feL
 g81bL5he6nKl9yyrP9nSWwiMSY3huSrr6XjqDvvjEmCOe1HYh3hdTTM5hvOVXf4Lu5y+5np0CLO
 D7WUbAw==
X-Google-Smtp-Source: AGHT+IHCY5N9BikBxn26COk7IchKhQs1QcxMpm5TJwv/kJwd1gzCDrnDpV2TihUTgoSzXUVFmwoC4w==
X-Received: by 2002:a05:6a00:2e03:b0:706:5dab:83c4 with SMTP id
 d2e1a72fcca58-70d3a8b177amr2736644b3a.14.1721705713035; 
 Mon, 22 Jul 2024 20:35:13 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:35:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 06/12] target/ppc: Split out helper_dbczl for 970
Date: Tue, 23 Jul 2024 13:34:45 +1000
Message-ID: <20240723033451.546151-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723033451.546151-1-richard.henderson@linaro.org>
References: <20240723033451.546151-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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


