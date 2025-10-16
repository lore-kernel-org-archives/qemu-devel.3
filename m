Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C49CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9N0H-0007iF-FB; Thu, 16 Oct 2025 08:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Myv-0005Ye-FY
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Myf-0000TN-RW
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so6822935e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617261; x=1761222061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lHwUN7LlSzjhdsSHrb8Oa61Shj7wu9lqzsiNuySZf0Q=;
 b=myDD3Tz0n536nu49tzNSII8Zy6S/4o0eDuuzvDn2UYDfLqoZ6PYAECy9n1SECfKHMe
 Bn4uMv7o4cdVXci9tKxcqb3lEYGHpNjLVVKQ+wiNI5W5ok4425NI24s3vBS944xbF2hS
 asU2Ck8o44+BEhFooFFFlg7RXgKB7gJUAG2fTZ9BzFaVsrA9jpnydLdGG51823FnTdvz
 VA4rLUfnzKlSTVZRqXxzZLskmssAxpzYh0IXqBl+rLtqYgRtdOzIxRHMob9yiiiq9XkB
 VjpFsMCnJNjG2DXsC0SX9ptjiTIeaP0qIwfYOZRElXqcJTw+VhnygJCG9h5gxZU74DVz
 gtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617261; x=1761222061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHwUN7LlSzjhdsSHrb8Oa61Shj7wu9lqzsiNuySZf0Q=;
 b=DEx1GP04eO4chOSMsz+Acdy3ejcMejjEn8r2532v7Mzo4zBS9AfQ3fHIKL7tg6XO+s
 7yAjoWV13NPCM7D0MQmFSZXnHkh/fHQo98qkJpbwG7ALlKW1xMDpfn8LP9b1GUIg55yT
 krqAZuqD7hgNhQZNkmCgmO0s5PqP7fVZyw5BrXFv0ADJhuwf409XkzHEYhc+bYbf14gz
 pSMop0fGK37NybGsTXWrhCDcfRm472cEYX9wvkIHyvmXIcdMvANakF2i1eOGO3TJKUun
 kg7DWfGJwjKxQunA7r4LOfusfDAi5RLXd4vLG/tTEw7MfbjWb5+mOzThcA2wovQFoN4r
 eXFw==
X-Gm-Message-State: AOJu0YwOqjKuiMMbkzfsjNs7MlFspRhbLelonmTYZFHiOm3Uo3DAUV+h
 lBePNMJAm4fuvyzUnv/8IobcYfowM+FbYhAhEkIVvGw3rqOeoMFvu5fXk3yozozbWMVjzYcm0dH
 eGrTgK0w=
X-Gm-Gg: ASbGncsf9CvmNA5d8Eicm0tnH7WFEbMvAPHlclR5QCTIj9IYdUSKAcoo2ctfkBPtYjj
 f7M6aaSdqh2RlGdcPkqiRINKpacxUCu1r+CzquCI6C2X8yC31FlFqEbWGJN86LfjskoIUIHyvCE
 UfHAqLwXP9aN9isUdM+tjeRmk9mwbNEWK131+whnADGDlKgr46oQct4pnZ9Ny/WCob62AT8VdkG
 A+pKTpPDEuh4PYL6ySA8Hsf4t/nF7udW1XteHweoKe30+m6uWWIKCfEpjkDiUZ4eULd7GwPgFeu
 1/m0iauXgzGf0+i+WW1J13uSr2MejCSFMN4BJJmpJt/iqWjip2fzzsrbu+chShZmIT4qSc4WqSU
 vlSvCwCk9GzJd8hnfdMZ5qwtQeYI4lq48h3XCwOKpA8wqONsKzLAWrC8yXsbK0MHy+3IMPU55tG
 aF+NYaVrR7C2eYBv/hkZ7tgF9VpSG3iNuIs9sU4zPFWkNStlDSLfdNDZiLS9kLI/dn
X-Google-Smtp-Source: AGHT+IGWG7/gOozrDCEC7EZ3ra9vJxgBhSUAVhcuKwuDvd1aQlfeAjjKaWD0TFhq3MZdvw2eT9xnBg==
X-Received: by 2002:a05:600c:3507:b0:471:12ed:f698 with SMTP id
 5b1f17b1804b1-47112edf982mr14512325e9.8.1760617259158; 
 Thu, 16 Oct 2025 05:20:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d404sm34791918f8f.3.2025.10.16.05.20.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 70/75] target/tricore: Expand TCGv type for 32-bit target
Date: Thu, 16 Oct 2025 14:15:26 +0200
Message-ID: <20251016121532.14042-71-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The TriCore target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/tricore-*
  configs/targets/tricore-softmmu.mak:2:TARGET_LONG_BITS=32

Replace:

  TCGv -> TCGv_i32
  tcg_temp_new -> tcg_temp_new_i32

This is a mechanical replacement, adapting style to pass
the checkpatch.pl script.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-13-philmd@linaro.org>
---
 target/tricore/translate.c | 1248 +++++++++++++++++++-----------------
 1 file changed, 642 insertions(+), 606 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 787c77292fd..fbe05a93a8a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -136,9 +136,9 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     } while (0)
 
 #define GEN_HELPER_LL(name, ret, arg0, arg1, n) do {         \
-    TCGv arg00 = tcg_temp_new();                             \
-    TCGv arg01 = tcg_temp_new();                             \
-    TCGv arg11 = tcg_temp_new();                             \
+    TCGv_i32 arg00 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg01 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg11 = tcg_temp_new_i32();                     \
     tcg_gen_sari_i32(arg00, arg0, 16);                       \
     tcg_gen_ext16s_i32(arg01, arg0);                         \
     tcg_gen_ext16s_i32(arg11, arg1);                         \
@@ -146,10 +146,10 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 } while (0)
 
 #define GEN_HELPER_LU(name, ret, arg0, arg1, n) do {         \
-    TCGv arg00 = tcg_temp_new();                             \
-    TCGv arg01 = tcg_temp_new();                             \
-    TCGv arg10 = tcg_temp_new();                             \
-    TCGv arg11 = tcg_temp_new();                             \
+    TCGv_i32 arg00 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg01 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg10 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg11 = tcg_temp_new_i32();                     \
     tcg_gen_sari_i32(arg00, arg0, 16);                       \
     tcg_gen_ext16s_i32(arg01, arg0);                         \
     tcg_gen_sari_i32(arg11, arg1, 16);                       \
@@ -158,10 +158,10 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 } while (0)
 
 #define GEN_HELPER_UL(name, ret, arg0, arg1, n) do {         \
-    TCGv arg00 = tcg_temp_new();                             \
-    TCGv arg01 = tcg_temp_new();                             \
-    TCGv arg10 = tcg_temp_new();                             \
-    TCGv arg11 = tcg_temp_new();                             \
+    TCGv_i32 arg00 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg01 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg10 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg11 = tcg_temp_new_i32();                     \
     tcg_gen_sari_i32(arg00, arg0, 16);                       \
     tcg_gen_ext16s_i32(arg01, arg0);                         \
     tcg_gen_sari_i32(arg10, arg1, 16);                       \
@@ -170,9 +170,9 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 } while (0)
 
 #define GEN_HELPER_UU(name, ret, arg0, arg1, n) do {         \
-    TCGv arg00 = tcg_temp_new();                             \
-    TCGv arg01 = tcg_temp_new();                             \
-    TCGv arg11 = tcg_temp_new();                             \
+    TCGv_i32 arg00 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg01 = tcg_temp_new_i32();                     \
+    TCGv_i32 arg11 = tcg_temp_new_i32();                     \
     tcg_gen_sari_i32(arg01, arg0, 16);                       \
     tcg_gen_ext16s_i32(arg00, arg0);                         \
     tcg_gen_sari_i32(arg11, arg1, 16);                       \
@@ -210,23 +210,24 @@ static void generate_trap(DisasContext *ctx, int class, int tin);
 
 /* Functions for load/save to/from memory */
 
-static void gen_offset_ld(DisasContext *ctx, TCGv r1, TCGv r2,
+static void gen_offset_ld(DisasContext *ctx, TCGv_i32 r1, TCGv_i32 r2,
                           int16_t con, MemOp mop)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     tcg_gen_addi_i32(temp, r2, con);
     tcg_gen_qemu_ld_i32(r1, temp, ctx->mem_idx, mop);
 }
 
-static void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,
+static void gen_offset_st(DisasContext *ctx, TCGv_i32 r1, TCGv_i32 r2,
                           int16_t con, MemOp mop)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     tcg_gen_addi_i32(temp, r2, con);
     tcg_gen_qemu_st_i32(r1, temp, ctx->mem_idx, mop);
 }
 
-static void gen_st_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
+static void gen_st_2regs_64(DisasContext *ctx, TCGv_i32 rh, TCGv_i32 rl,
+                            TCGv_i32 address)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -235,14 +236,16 @@ static void gen_st_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
 }
 
 static void gen_offset_st_2regs(DisasContext *ctx,
-                                TCGv rh, TCGv rl, TCGv base, int16_t con)
+                                TCGv_i32 rh, TCGv_i32 rl,
+                                TCGv_i32 base, int16_t con)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     tcg_gen_addi_i32(temp, base, con);
     gen_st_2regs_64(ctx, rh, rl, temp);
 }
 
-static void gen_ld_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
+static void gen_ld_2regs_64(DisasContext *ctx, TCGv_i32 rh, TCGv_i32 rl,
+                            TCGv_i32 address)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -252,36 +255,37 @@ static void gen_ld_2regs_64(DisasContext *ctx, TCGv rh, TCGv rl, TCGv address)
 }
 
 static void gen_offset_ld_2regs(DisasContext *ctx,
-                                TCGv rh, TCGv rl, TCGv base, int16_t con)
+                                TCGv_i32 rh, TCGv_i32 rl,
+                                TCGv_i32 base, int16_t con)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     tcg_gen_addi_i32(temp, base, con);
     gen_ld_2regs_64(ctx, rh, rl, temp);
 }
 
-static void gen_st_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t off,
-                           MemOp mop)
+static void gen_st_preincr(DisasContext *ctx, TCGv_i32 r1, TCGv_i32 r2,
+                           int16_t off, MemOp mop)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     tcg_gen_addi_i32(temp, r2, off);
     tcg_gen_qemu_st_i32(r1, temp, ctx->mem_idx, mop);
     tcg_gen_mov_i32(r2, temp);
 }
 
-static void gen_ld_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t off,
-                           MemOp mop)
+static void gen_ld_preincr(DisasContext *ctx, TCGv_i32 r1, TCGv_i32 r2,
+                           int16_t off, MemOp mop)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     tcg_gen_addi_i32(temp, r2, off);
     tcg_gen_qemu_ld_i32(r1, temp, ctx->mem_idx, mop);
     tcg_gen_mov_i32(r2, temp);
 }
 
 /* M(EA, word) = (M(EA, word) & ~E[a][63:32]) | (E[a][31:0] & E[a][63:32]); */
-static void gen_ldmst(DisasContext *ctx, int ereg, TCGv ea)
+static void gen_ldmst(DisasContext *ctx, int ereg, TCGv_i32 ea)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     CHECK_REG_PAIR(ereg);
     /* temp = (M(EA, word) */
@@ -299,19 +303,19 @@ static void gen_ldmst(DisasContext *ctx, int ereg, TCGv ea)
 /* tmp = M(EA, word);
    M(EA, word) = D[a];
    D[a] = tmp[31:0];*/
-static void gen_swap(DisasContext *ctx, int reg, TCGv ea)
+static void gen_swap(DisasContext *ctx, int reg, TCGv_i32 ea)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
 
     tcg_gen_qemu_ld_i32(temp, ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_qemu_st_i32(cpu_gpr_d[reg], ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_mov_i32(cpu_gpr_d[reg], temp);
 }
 
-static void gen_cmpswap(DisasContext *ctx, int reg, TCGv ea)
+static void gen_cmpswap(DisasContext *ctx, int reg, TCGv_i32 ea)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     CHECK_REG_PAIR(reg);
     tcg_gen_qemu_ld_i32(temp, ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_movcond_i32(TCG_COND_EQ, temp2, cpu_gpr_d[reg + 1], temp,
@@ -320,11 +324,11 @@ static void gen_cmpswap(DisasContext *ctx, int reg, TCGv ea)
     tcg_gen_mov_i32(cpu_gpr_d[reg], temp);
 }
 
-static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
+static void gen_swapmsk(DisasContext *ctx, int reg, TCGv_i32 ea)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv temp3 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
     CHECK_REG_PAIR(reg);
     tcg_gen_qemu_ld_i32(temp, ea, ctx->mem_idx, MO_LEUL);
     tcg_gen_and_i32(temp2, cpu_gpr_d[reg], cpu_gpr_d[reg + 1]);
@@ -346,7 +350,7 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
         break;
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)
 #define E(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)
-static void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
+static void gen_mfcr(DisasContext *ctx, TCGv_i32 ret, int32_t offset)
 {
     /* since we're caching PSW make this a special case */
     if (offset == 0xfe04) {
@@ -374,7 +378,7 @@ static void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
          watchdog device, we handle endinit protected registers like
          all-access registers for now. */
 #define E(ADDRESS, REG, FEATURE) A(ADDRESS, REG, FEATURE)
-static void gen_mtcr(DisasContext *ctx, TCGv r1, int32_t offset)
+static void gen_mtcr(DisasContext *ctx, TCGv_i32 r1, int32_t offset)
 {
     if (ctx->priv == TRICORE_PRIV_SM) {
         /* since we're caching PSW make this a special case */
@@ -393,10 +397,10 @@ static void gen_mtcr(DisasContext *ctx, TCGv r1, int32_t offset)
 
 /* Functions for arithmetic instructions  */
 
-static void gen_add_d(TCGv ret, TCGv r1, TCGv r2)
+static void gen_add_d(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv t0 = tcg_temp_new_i32();
-    TCGv result = tcg_temp_new_i32();
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 result = tcg_temp_new_i32();
     /* Addition and set V/SV bits */
     tcg_gen_add_i32(result, r1, r2);
     /* calc V bit */
@@ -414,10 +418,9 @@ static void gen_add_d(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static void
-gen_add64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
+static void gen_add64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 result = tcg_temp_new_i64();
@@ -440,15 +443,16 @@ gen_add64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
     tcg_gen_mov_i64(ret, result);
 }
 
-static void
-gen_addsub64_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-               TCGv r3, void(*op1)(TCGv, TCGv, TCGv),
-               void(*op2)(TCGv, TCGv, TCGv))
+static void gen_addsub64_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                           TCGv_i32 r1_low, TCGv_i32 r1_high,
+                           TCGv_i32 r2, TCGv_i32 r3,
+                           void(*op1)(TCGv_i32, TCGv_i32, TCGv_i32),
+                           void(*op2)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv temp3 = tcg_temp_new();
-    TCGv temp4 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
+    TCGv_i32 temp4 = tcg_temp_new_i32();
 
     (*op1)(temp, r1_low, r2);
     /* calc V0 bit */
@@ -487,7 +491,7 @@ gen_addsub64_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
 }
 
 /* ret = r2 + (r1 * r3); */
-static void gen_madd32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
+static void gen_madd32_d(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -518,20 +522,19 @@ static void gen_madd32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_maddi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_maddi32_d(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_madd32_d(ret, r1, r2, temp);
 }
 
-static void
-gen_madd64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-             TCGv r3)
+static void gen_madd64_d(TCGv_i32 ret_low, TCGv_i32 ret_high, TCGv_i32 r1,
+                         TCGv_i32 r2_low, TCGv_i32 r2_high, TCGv_i32 r3)
 {
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
-    TCGv t4 = tcg_temp_new();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    TCGv_i32 t4 = tcg_temp_new_i32();
 
     tcg_gen_muls2_i32(t1, t2, r1, r3);
     /* only the add can overflow */
@@ -552,9 +555,8 @@ gen_madd64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_mov_i32(ret_high, t4);
 }
 
-static void
-gen_maddu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-              TCGv r3)
+static void gen_maddu64_d(TCGv_i32 ret_low, TCGv_i32 ret_high, TCGv_i32 r1,
+                          TCGv_i32 r2_low, TCGv_i32 r2_high, TCGv_i32 r3)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -582,29 +584,28 @@ gen_maddu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void
-gen_maddi64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-              int32_t con)
+static void gen_maddi64_d(TCGv_i32 ret_low, TCGv_i32 ret_high, TCGv_i32 r1,
+                          TCGv_i32 r2_low, TCGv_i32 r2_high, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_madd64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void
-gen_maddui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-               int32_t con)
+static void gen_maddui64_d(TCGv_i32 ret_low, TCGv_i32 ret_high, TCGv_i32 r1,
+                           TCGv_i32 r2_low, TCGv_i32 r2_high, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_maddu64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void
-gen_madd_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-           TCGv r3, uint32_t n, uint32_t mode)
+static void gen_madd_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                       TCGv_i32 r1_low, TCGv_i32 r1_high,
+                       TCGv_i32 r2, TCGv_i32 r3,
+                       uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -625,13 +626,14 @@ gen_madd_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_add_tl, tcg_gen_add_tl);
 }
 
-static void
-gen_maddsu_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-             TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddsu_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1_low, TCGv_i32 r1_high,
+                         TCGv_i32 r2, TCGv_i32 r3,
+                         uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -652,11 +654,12 @@ gen_maddsu_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_sub_tl, tcg_gen_add_tl);
 }
 
-static void
-gen_maddsum_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-              TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddsum_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1_low, TCGv_i32 r1_high,
+                          TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
     TCGv_i64 temp64_3 = tcg_temp_new_i64();
@@ -685,16 +688,17 @@ gen_maddsum_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_2);
 }
 
-static void gen_adds(TCGv ret, TCGv r1, TCGv r2);
+static void gen_adds(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2);
 
-static void
-gen_madds_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-           TCGv r3, uint32_t n, uint32_t mode)
+static void gen_madds_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                        TCGv_i32 r1_low, TCGv_i32 r1_high,
+                        TCGv_i32 r2, TCGv_i32 r3,
+                        uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv temp3 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
 
     switch (mode) {
@@ -722,16 +726,17 @@ gen_madds_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static void gen_subs(TCGv ret, TCGv r1, TCGv r2);
+static void gen_subs(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2);
 
-static void
-gen_maddsus_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-              TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddsus_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1_low, TCGv_i32 r1_high,
+                          TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv temp3 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
 
     switch (mode) {
@@ -759,11 +764,12 @@ gen_maddsus_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static void
-gen_maddsums_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-               TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddsums_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                           TCGv_i32 r1_low, TCGv_i32 r1_high,
+                           TCGv_i32 r2, TCGv_i32 r3,
+                           uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
 
@@ -792,11 +798,12 @@ gen_maddsums_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
 }
 
 
-static void
-gen_maddm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-           TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddm_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                        TCGv_i32 r1_low, TCGv_i32 r1_high,
+                        TCGv_i32 r2, TCGv_i32 r3,
+                        uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
     TCGv_i64 temp64_3 = tcg_temp_new_i64();
@@ -820,11 +827,12 @@ gen_maddm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_3);
 }
 
-static void
-gen_maddms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-           TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddms_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1_low, TCGv_i32 r1_high,
+                         TCGv_i32 r2, TCGv_i32 r3,
+                         uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
     switch (mode) {
@@ -846,11 +854,11 @@ gen_maddms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static void
-gen_maddr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
-              uint32_t mode)
+static void gen_maddr64_h(TCGv_i32 ret, TCGv_i32 r1_low, TCGv_i32 r1_high,
+                          TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -869,23 +877,25 @@ gen_maddr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
     gen_helper_addr_h(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static void
-gen_maddr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddr32_h(TCGv_i32 ret,
+                          TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     tcg_gen_andi_i32(temp2, r1, 0xffff0000);
     tcg_gen_shli_i32(temp, r1, 16);
     gen_maddr64_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static void
-gen_maddsur32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddsur32_h(TCGv_i32 ret,
+                            TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                            uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -907,11 +917,11 @@ gen_maddsur32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 }
 
 
-static void
-gen_maddr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
-               uint32_t n, uint32_t mode)
+static void gen_maddr64s_h(TCGv_i32 ret, TCGv_i32 r1_low, TCGv_i32 r1_high,
+                           TCGv_i32 r2, TCGv_i32 r3,
+                           uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -930,23 +940,25 @@ gen_maddr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
     gen_helper_addr_h_ssov(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static void
-gen_maddr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddr32s_h(TCGv_i32 ret,
+                           TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                           uint32_t n, uint32_t mode)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     tcg_gen_andi_i32(temp2, r1, 0xffff0000);
     tcg_gen_shli_i32(temp, r1, 16);
     gen_maddr64s_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static void
-gen_maddsur32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_maddsur32s_h(TCGv_i32 ret,
+                             TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                             uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -967,27 +979,27 @@ gen_maddsur32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_helper_addsur_h_ssov(ret, tcg_env, temp64, temp, temp2);
 }
 
-static void
-gen_maddr_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
+static void gen_maddr_q(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                        uint32_t n)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     gen_helper_maddr_q(ret, tcg_env, r1, r2, r3, t_n);
 }
 
-static void
-gen_maddrs_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
+static void gen_maddrs_q(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                         uint32_t n)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     gen_helper_maddr_q_ssov(ret, tcg_env, r1, r2, r3, t_n);
 }
 
-static void
-gen_madd32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
-             uint32_t up_shift)
+static void gen_madd32_q(TCGv_i32 ret,
+                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                         uint32_t n, uint32_t up_shift)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv temp3 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
     TCGv_i64 t3 = tcg_temp_new_i64();
@@ -1031,11 +1043,12 @@ gen_madd32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     tcg_gen_mov_i32(ret, temp3);
 }
 
-static void
-gen_m16add32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
+static void gen_m16add32_q(TCGv_i32 ret,
+                           TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                           uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     if (n == 0) {
         tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
@@ -1048,11 +1061,12 @@ gen_m16add32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_add_d(ret, arg1, temp);
 }
 
-static void
-gen_m16adds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
+static void gen_m16adds32_q(TCGv_i32 ret,
+                            TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                            uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     if (n == 0) {
         tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
@@ -1065,12 +1079,12 @@ gen_m16adds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_adds(ret, arg1, temp);
 }
 
-static void
-gen_m16add64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-               TCGv arg3, uint32_t n)
+static void gen_m16add64_q(TCGv_i32 rl, TCGv_i32 rh,
+                           TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                           TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
     TCGv_i64 t3 = tcg_temp_new_i64();
@@ -1092,12 +1106,12 @@ gen_m16add64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t3);
 }
 
-static void
-gen_m16adds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-               TCGv arg3, uint32_t n)
+static void gen_m16adds64_q(TCGv_i32 rl, TCGv_i32 rh,
+                            TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                            TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
@@ -1118,15 +1132,15 @@ gen_m16adds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t1);
 }
 
-static void
-gen_madd64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-             TCGv arg3, uint32_t n)
+static void gen_madd64_q(TCGv_i32 rl, TCGv_i32 rh,
+                         TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                         TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
     TCGv_i64 t3 = tcg_temp_new_i64();
     TCGv_i64 t4 = tcg_temp_new_i64();
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     tcg_gen_concat_i32_i64(t1, arg1_low, arg1_high);
     tcg_gen_ext_i32_i64(t2, arg2);
@@ -1146,8 +1160,8 @@ gen_madd64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
        (0x80000000 * 0x80000000) << 1). If this is the
        case, we negate the ovf. */
     if (n == 1) {
-        temp = tcg_temp_new();
-        temp2 = tcg_temp_new();
+        temp = tcg_temp_new_i32();
+        temp2 = tcg_temp_new_i32();
         tcg_gen_setcondi_i32(TCG_COND_EQ, temp, arg2, 0x80000000);
         tcg_gen_setcond_i32(TCG_COND_EQ, temp2, arg2, arg3);
         tcg_gen_and_i32(temp, temp, temp2);
@@ -1166,9 +1180,9 @@ gen_madd64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void
-gen_madds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
-              uint32_t up_shift)
+static void gen_madds32_q(TCGv_i32 ret,
+                          TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                          uint32_t n, uint32_t up_shift)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -1184,12 +1198,12 @@ gen_madds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     gen_helper_madd32_q_add_ssov(ret, tcg_env, t1, t2);
 }
 
-static void
-gen_madds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-             TCGv arg3, uint32_t n)
+static void gen_madds64_q(TCGv_i32 rl, TCGv_i32 rh,
+                          TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                          TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
     TCGv_i64 r1 = tcg_temp_new_i64();
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
 
     tcg_gen_concat_i32_i64(r1, arg1_low, arg1_high);
     gen_helper_madd64_q_ssov(r1, tcg_env, r1, arg2, arg3, t_n);
@@ -1197,7 +1211,7 @@ gen_madds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
 }
 
 /* ret = r2 - (r1 * r3); */
-static void gen_msub32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
+static void gen_msub32_d(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -1229,20 +1243,20 @@ static void gen_msub32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_msubi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_msubi32_d(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_msub32_d(ret, r1, r2, temp);
 }
 
-static void
-gen_msub64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-             TCGv r3)
+static void gen_msub64_d(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                         TCGv_i32 r3)
 {
-    TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
-    TCGv t3 = tcg_temp_new();
-    TCGv t4 = tcg_temp_new();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    TCGv_i32 t3 = tcg_temp_new_i32();
+    TCGv_i32 t4 = tcg_temp_new_i32();
 
     tcg_gen_muls2_i32(t1, t2, r1, r3);
     /* only the sub can overflow */
@@ -1263,17 +1277,16 @@ gen_msub64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_mov_i32(ret_high, t4);
 }
 
-static void
-gen_msubi64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-              int32_t con)
+static void gen_msubi64_d(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                          int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_msub64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void
-gen_msubu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-              TCGv r3)
+static void gen_msubu64_d(TCGv_i32 ret_low, TCGv_i32 ret_high, TCGv_i32 r1,
+                          TCGv_i32 r2_low, TCGv_i32 r2_high, TCGv_i32 r3)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -1299,25 +1312,25 @@ gen_msubu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void
-gen_msubui64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-               int32_t con)
+static void gen_msubui64_d(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                           TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                           int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_msubu64_d(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void gen_addi_d(TCGv ret, TCGv r1, int32_t r2)
+static void gen_addi_d(TCGv_i32 ret, TCGv_i32 r1, int32_t r2)
 {
-    TCGv temp = tcg_constant_i32(r2);
+    TCGv_i32 temp = tcg_constant_i32(r2);
     gen_add_d(ret, r1, temp);
 }
 
 /* calculate the carry bit too */
-static void gen_add_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_add_CC(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv t0    = tcg_temp_new_i32();
-    TCGv result = tcg_temp_new_i32();
+    TCGv_i32 t0    = tcg_temp_new_i32();
+    TCGv_i32 result = tcg_temp_new_i32();
 
     tcg_gen_movi_i32(t0, 0);
     /* Addition and set C/V/SV bits */
@@ -1337,16 +1350,16 @@ static void gen_add_CC(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
+static void gen_addi_CC(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_add_CC(ret, r1, temp);
 }
 
-static void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_addc_CC(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv t0     = tcg_temp_new_i32();
-    TCGv result = tcg_temp_new_i32();
+    TCGv_i32 t0     = tcg_temp_new_i32();
+    TCGv_i32 result = tcg_temp_new_i32();
 
     /* Addition, carry and set C/V/SV bits */
     tcg_gen_addcio_i32(result, cpu_PSW_C, r1, r2, cpu_PSW_C);
@@ -1365,19 +1378,20 @@ static void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static void gen_addci_CC(TCGv ret, TCGv r1, int32_t con)
+static void gen_addci_CC(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_addc_CC(ret, r1, temp);
 }
 
-static void gen_cond_add(TCGCond cond, TCGv r1, TCGv r2, TCGv r3, TCGv r4)
+static void gen_cond_add(TCGCond cond,
+                         TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3, TCGv_i32 r4)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv result = tcg_temp_new();
-    TCGv mask = tcg_temp_new();
-    TCGv t0 = tcg_constant_i32(0);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 result = tcg_temp_new_i32();
+    TCGv_i32 mask = tcg_temp_new_i32();
+    TCGv_i32 t0 = tcg_constant_i32(0);
 
     /* create mask for sticky bits */
     tcg_gen_setcond_i32(cond, mask, r4, t0);
@@ -1403,16 +1417,17 @@ static void gen_cond_add(TCGCond cond, TCGv r1, TCGv r2, TCGv r3, TCGv r4)
     tcg_gen_movcond_i32(cond, r3, r4, t0, result, r1);
 }
 
-static void gen_condi_add(TCGCond cond, TCGv r1, int32_t r2, TCGv r3, TCGv r4)
+static void gen_condi_add(TCGCond cond,
+                          TCGv_i32 r1, int32_t r2, TCGv_i32 r3, TCGv_i32 r4)
 {
-    TCGv temp = tcg_constant_i32(r2);
+    TCGv_i32 temp = tcg_constant_i32(r2);
     gen_cond_add(cond, r1, temp, r3, r4);
 }
 
-static void gen_sub_d(TCGv ret, TCGv r1, TCGv r2)
+static void gen_sub_d(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv temp = tcg_temp_new_i32();
-    TCGv result = tcg_temp_new_i32();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 result = tcg_temp_new_i32();
 
     tcg_gen_sub_i32(result, r1, r2);
     /* calc V bit */
@@ -1430,10 +1445,9 @@ static void gen_sub_d(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static void
-gen_sub64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
+static void gen_sub64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 result = tcg_temp_new_i64();
@@ -1456,10 +1470,10 @@ gen_sub64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
     tcg_gen_mov_i64(ret, result);
 }
 
-static void gen_sub_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_sub_CC(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv result = tcg_temp_new();
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 result = tcg_temp_new_i32();
+    TCGv_i32 temp = tcg_temp_new_i32();
 
     tcg_gen_sub_i32(result, r1, r2);
     /* calc C bit */
@@ -1479,20 +1493,21 @@ static void gen_sub_CC(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static void gen_subc_CC(TCGv ret, TCGv r1, TCGv r2)
+static void gen_subc_CC(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     tcg_gen_not_i32(temp, r2);
     gen_addc_CC(ret, r1, temp);
 }
 
-static void gen_cond_sub(TCGCond cond, TCGv r1, TCGv r2, TCGv r3, TCGv r4)
+static void gen_cond_sub(TCGCond cond,
+                         TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3, TCGv_i32 r4)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv result = tcg_temp_new();
-    TCGv mask = tcg_temp_new();
-    TCGv t0 = tcg_constant_i32(0);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 result = tcg_temp_new_i32();
+    TCGv_i32 mask = tcg_temp_new_i32();
+    TCGv_i32 t0 = tcg_constant_i32(0);
 
     /* create mask for sticky bits */
     tcg_gen_setcond_i32(cond, mask, r4, t0);
@@ -1518,13 +1533,14 @@ static void gen_cond_sub(TCGCond cond, TCGv r1, TCGv r2, TCGv r3, TCGv r4)
     tcg_gen_movcond_i32(cond, r3, r4, t0, result, r1);
 }
 
-static void
-gen_msub_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-           TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msub_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                       TCGv_i32 r1_low, TCGv_i32 r1_high,
+                       TCGv_i32 r2, TCGv_i32 r3,
+                       uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -1545,14 +1561,15 @@ gen_msub_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_sub_tl, tcg_gen_sub_tl);
 }
 
-static void
-gen_msubs_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-            TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubs_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                        TCGv_i32 r1_low, TCGv_i32 r1_high,
+                        TCGv_i32 r2, TCGv_i32 r3,
+                        uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv temp3 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
 
     switch (mode) {
@@ -1580,11 +1597,12 @@ gen_msubs_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static void
-gen_msubm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-            TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubm_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                        TCGv_i32 r1_low, TCGv_i32 r1_high,
+                        TCGv_i32 r2, TCGv_i32 r3,
+                        uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
     TCGv_i64 temp64_3 = tcg_temp_new_i64();
@@ -1608,11 +1626,12 @@ gen_msubm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_3);
 }
 
-static void
-gen_msubms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-             TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubms_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1_low, TCGv_i32 r1_high,
+                         TCGv_i32 r2, TCGv_i32 r3,
+                         uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
     switch (mode) {
@@ -1634,11 +1653,12 @@ gen_msubms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static void
-gen_msubr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
-              uint32_t mode)
+static void gen_msubr64_h(TCGv_i32 ret,
+                          TCGv_i32 r1_low, TCGv_i32 r1_high,
+                          TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -1657,22 +1677,24 @@ gen_msubr64_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3, uint32_t n,
     gen_helper_subr_h(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static void
-gen_msubr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubr32_h(TCGv_i32 ret,
+                          TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     tcg_gen_andi_i32(temp2, r1, 0xffff0000);
     tcg_gen_shli_i32(temp, r1, 16);
     gen_msubr64_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static void
-gen_msubr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
-               uint32_t n, uint32_t mode)
+static void gen_msubr64s_h(TCGv_i32 ret,
+                           TCGv_i32 r1_low, TCGv_i32 r1_high,
+                           TCGv_i32 r2, TCGv_i32 r3,
+                           uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -1691,36 +1713,37 @@ gen_msubr64s_h(TCGv ret, TCGv r1_low, TCGv r1_high, TCGv r2, TCGv r3,
     gen_helper_subr_h_ssov(ret, tcg_env, temp64, r1_low, r1_high);
 }
 
-static void
-gen_msubr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubr32s_h(TCGv_i32 ret,
+                           TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                           uint32_t n, uint32_t mode)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     tcg_gen_andi_i32(temp2, r1, 0xffff0000);
     tcg_gen_shli_i32(temp, r1, 16);
     gen_msubr64s_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
-static void
-gen_msubr_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
+static void gen_msubr_q(TCGv_i32 ret,
+                        TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3, uint32_t n)
 {
-    TCGv temp = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_constant_i32(n);
     gen_helper_msubr_q(ret, tcg_env, r1, r2, r3, temp);
 }
 
-static void
-gen_msubrs_q(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n)
+static void gen_msubrs_q(TCGv_i32 ret,
+                         TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3, uint32_t n)
 {
-    TCGv temp = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_constant_i32(n);
     gen_helper_msubr_q_ssov(ret, tcg_env, r1, r2, r3, temp);
 }
 
-static void
-gen_msub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
-             uint32_t up_shift)
+static void gen_msub32_q(TCGv_i32 ret,
+                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                         uint32_t n, uint32_t up_shift)
 {
-    TCGv temp3 = tcg_temp_new();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
     TCGv_i64 t3 = tcg_temp_new_i64();
@@ -1757,11 +1780,12 @@ gen_msub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     tcg_gen_mov_i32(ret, temp3);
 }
 
-static void
-gen_m16sub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
+static void gen_m16sub32_q(TCGv_i32 ret,
+                           TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                           uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     if (n == 0) {
         tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
@@ -1774,11 +1798,12 @@ gen_m16sub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_sub_d(ret, arg1, temp);
 }
 
-static void
-gen_m16subs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
+static void gen_m16subs32_q(TCGv_i32 ret,
+                            TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                            uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     if (n == 0) {
         tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
@@ -1791,12 +1816,12 @@ gen_m16subs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     gen_subs(ret, arg1, temp);
 }
 
-static void
-gen_m16sub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-               TCGv arg3, uint32_t n)
+static void gen_m16sub64_q(TCGv_i32 rl, TCGv_i32 rh,
+                           TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                           TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
     TCGv_i64 t3 = tcg_temp_new_i64();
@@ -1818,12 +1843,12 @@ gen_m16sub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t3);
 }
 
-static void
-gen_m16subs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-               TCGv arg3, uint32_t n)
+static void gen_m16subs64_q(TCGv_i32 rl, TCGv_i32 rh,
+                            TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                            TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
@@ -1844,15 +1869,15 @@ gen_m16subs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_extr_i64_i32(rl, rh, t1);
 }
 
-static void
-gen_msub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-             TCGv arg3, uint32_t n)
+static void gen_msub64_q(TCGv_i32 rl, TCGv_i32 rh,
+                         TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                         TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
     TCGv_i64 t3 = tcg_temp_new_i64();
     TCGv_i64 t4 = tcg_temp_new_i64();
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     tcg_gen_concat_i32_i64(t1, arg1_low, arg1_high);
     tcg_gen_ext_i32_i64(t2, arg2);
@@ -1872,8 +1897,8 @@ gen_msub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
        (0x80000000 * 0x80000000) << 1). If this is the
        case, we negate the ovf. */
     if (n == 1) {
-        temp = tcg_temp_new();
-        temp2 = tcg_temp_new();
+        temp = tcg_temp_new_i32();
+        temp2 = tcg_temp_new_i32();
         tcg_gen_setcondi_i32(TCG_COND_EQ, temp, arg2, 0x80000000);
         tcg_gen_setcond_i32(TCG_COND_EQ, temp2, arg2, arg3);
         tcg_gen_and_i32(temp, temp, temp2);
@@ -1892,9 +1917,9 @@ gen_msub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void
-gen_msubs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
-              uint32_t up_shift)
+static void gen_msubs32_q(TCGv_i32 ret,
+                          TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3,
+                          uint32_t n, uint32_t up_shift)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
     TCGv_i64 t2 = tcg_temp_new_i64();
@@ -1915,25 +1940,26 @@ gen_msubs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     gen_helper_msub32_q_sub_ssov(ret, tcg_env, t1, t3);
 }
 
-static void
-gen_msubs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
-             TCGv arg3, uint32_t n)
+static void gen_msubs64_q(TCGv_i32 rl, TCGv_i32 rh,
+                          TCGv_i32 arg1_low, TCGv_i32 arg1_high,
+                          TCGv_i32 arg2, TCGv_i32 arg3, uint32_t n)
 {
     TCGv_i64 r1 = tcg_temp_new_i64();
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
 
     tcg_gen_concat_i32_i64(r1, arg1_low, arg1_high);
     gen_helper_msub64_q_ssov(r1, tcg_env, r1, arg2, arg3, t_n);
     tcg_gen_extr_i64_i32(rl, rh, r1);
 }
 
-static void
-gen_msubad_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-             TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubad_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1_low, TCGv_i32 r1_high,
+                         TCGv_i32 r2, TCGv_i32 r3,
+                         uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -1954,11 +1980,12 @@ gen_msubad_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
                    tcg_gen_add_tl, tcg_gen_sub_tl);
 }
 
-static void
-gen_msubadm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-              TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubadm_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1_low, TCGv_i32 r1_high,
+                          TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
     TCGv_i64 temp64_3 = tcg_temp_new_i64();
@@ -1987,12 +2014,13 @@ gen_msubadm_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64_2);
 }
 
-static void
-gen_msubadr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubadr32_h(TCGv_i32 ret,
+                            TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                            uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -2013,14 +2041,15 @@ gen_msubadr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_helper_subadr_h(ret, tcg_env, temp64, temp, temp2);
 }
 
-static void
-gen_msubads_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-              TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubads_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1_low, TCGv_i32 r1_high,
+                          TCGv_i32 r2, TCGv_i32 r3,
+                          uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
-    TCGv temp3 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
+    TCGv_i32 temp3 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
 
     switch (mode) {
@@ -2048,11 +2077,12 @@ gen_msubads_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
-static void
-gen_msubadms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
-               TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubadms_h(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                           TCGv_i32 r1_low, TCGv_i32 r1_high,
+                           TCGv_i32 r2, TCGv_i32 r3,
+                           uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
+    TCGv_i32 t_n = tcg_constant_i32(n);
     TCGv_i64 temp64 = tcg_temp_new_i64();
     TCGv_i64 temp64_2 = tcg_temp_new_i64();
 
@@ -2080,12 +2110,13 @@ gen_msubadms_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static void
-gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
+static void gen_msubadr32s_h(TCGv_i32 ret,
+                             TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 r3,
+                             uint32_t n, uint32_t mode)
 {
-    TCGv t_n = tcg_constant_i32(n);
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 t_n = tcg_constant_i32(n);
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     TCGv_i64 temp64 = tcg_temp_new_i64();
     switch (mode) {
     case MODE_LL:
@@ -2106,7 +2137,7 @@ gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     gen_helper_subadr_h_ssov(ret, tcg_env, temp64, temp, temp2);
 }
 
-static void gen_abs(TCGv ret, TCGv r1)
+static void gen_abs(TCGv_i32 ret, TCGv_i32 r1)
 {
     tcg_gen_abs_i32(ret, r1);
     /* overflow can only happen, if r1 = 0x80000000 */
@@ -2121,10 +2152,10 @@ static void gen_abs(TCGv ret, TCGv r1)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
+static void gen_absdif(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv temp = tcg_temp_new_i32();
-    TCGv result = tcg_temp_new_i32();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 result = tcg_temp_new_i32();
 
     tcg_gen_sub_i32(result, r1, r2);
     tcg_gen_sub_i32(temp, r2, r1);
@@ -2147,22 +2178,22 @@ static void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_mov_i32(ret, result);
 }
 
-static void gen_absdifi(TCGv ret, TCGv r1, int32_t con)
+static void gen_absdifi(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_absdif(ret, r1, temp);
 }
 
-static void gen_absdifsi(TCGv ret, TCGv r1, int32_t con)
+static void gen_absdifsi(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_absdif_ssov(ret, tcg_env, r1, temp);
 }
 
-static void gen_mul_i32s(TCGv ret, TCGv r1, TCGv r2)
+static void gen_mul_i32s(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv high = tcg_temp_new();
-    TCGv low = tcg_temp_new();
+    TCGv_i32 high = tcg_temp_new_i32();
+    TCGv_i32 low = tcg_temp_new_i32();
 
     tcg_gen_muls2_i32(low, high, r1, r2);
     tcg_gen_mov_i32(ret, low);
@@ -2179,13 +2210,14 @@ static void gen_mul_i32s(TCGv ret, TCGv r1, TCGv r2)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_muli_i32s(TCGv ret, TCGv r1, int32_t con)
+static void gen_muli_i32s(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_mul_i32s(ret, r1, temp);
 }
 
-static void gen_mul_i64s(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
+static void gen_mul_i64s(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1, TCGv_i32 r2)
 {
     tcg_gen_muls2_i32(ret_low, ret_high, r1, r2);
     /* clear V bit */
@@ -2199,14 +2231,15 @@ static void gen_mul_i64s(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_muli_i64s(TCGv ret_low, TCGv ret_high, TCGv r1,
-                                int32_t con)
+static void gen_muli_i64s(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_mul_i64s(ret_low, ret_high, r1, temp);
 }
 
-static void gen_mul_i64u(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
+static void gen_mul_i64u(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1, TCGv_i32 r2)
 {
     tcg_gen_mulu2_i32(ret_low, ret_high, r1, r2);
     /* clear V bit */
@@ -2220,40 +2253,40 @@ static void gen_mul_i64u(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_muli_i64u(TCGv ret_low, TCGv ret_high, TCGv r1,
-                                int32_t con)
+static void gen_muli_i64u(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_mul_i64u(ret_low, ret_high, r1, temp);
 }
 
-static void gen_mulsi_i32(TCGv ret, TCGv r1, int32_t con)
+static void gen_mulsi_i32(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_mul_ssov(ret, tcg_env, r1, temp);
 }
 
-static void gen_mulsui_i32(TCGv ret, TCGv r1, int32_t con)
+static void gen_mulsui_i32(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_mul_suov(ret, tcg_env, r1, temp);
 }
 
 /* gen_maddsi_32(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r3], const9); */
-static void gen_maddsi_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_maddsi_32(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_madd32_ssov(ret, tcg_env, r1, r2, temp);
 }
 
-static void gen_maddsui_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_maddsui_32(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_madd32_suov(ret, tcg_env, r1, r2, temp);
 }
 
-static void
-gen_mul_q(TCGv rl, TCGv rh, TCGv arg1, TCGv arg2, uint32_t n, uint32_t up_shift)
+static void gen_mul_q(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2,
+                      uint32_t n, uint32_t up_shift)
 {
     TCGv_i64 temp_64 = tcg_temp_new_i64();
     TCGv_i64 temp2_64 = tcg_temp_new_i64();
@@ -2309,10 +2342,9 @@ gen_mul_q(TCGv rl, TCGv rh, TCGv arg1, TCGv arg2, uint32_t n, uint32_t up_shift)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void
-gen_mul_q_16(TCGv ret, TCGv arg1, TCGv arg2, uint32_t n)
+static void gen_mul_q_16(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2, uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     if (n == 0) {
         tcg_gen_mul_i32(ret, arg1, arg2);
     } else { /* n is expected to be 1 */
@@ -2331,9 +2363,9 @@ gen_mul_q_16(TCGv ret, TCGv arg1, TCGv arg2, uint32_t n)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_mulr_q(TCGv ret, TCGv arg1, TCGv arg2, uint32_t n)
+static void gen_mulr_q(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2, uint32_t n)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     if (n == 0) {
         tcg_gen_mul_i32(ret, arg1, arg2);
         tcg_gen_addi_i32(ret, ret, 0x8000);
@@ -2357,9 +2389,9 @@ static void gen_mulr_q(TCGv ret, TCGv arg1, TCGv arg2, uint32_t n)
     tcg_gen_andi_i32(ret, ret, 0xffff0000);
 }
 
-static void
-gen_madds_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-             TCGv r3)
+static void gen_madds_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                         TCGv_i32 r3)
 {
     TCGv_i64 temp64 = tcg_temp_new_i64();
     tcg_gen_concat_i32_i64(temp64, r2_low, r2_high);
@@ -2367,17 +2399,17 @@ gen_madds_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static void
-gen_maddsi_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-              int32_t con)
+static void gen_maddsi_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                          int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_madds_64(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void
-gen_maddsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-             TCGv r3)
+static void gen_maddsu_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                          TCGv_i32 r3)
 {
     TCGv_i64 temp64 = tcg_temp_new_i64();
     tcg_gen_concat_i32_i64(temp64, r2_low, r2_high);
@@ -2385,29 +2417,29 @@ gen_maddsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static void
-gen_maddsui_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-               int32_t con)
+static void gen_maddsui_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, TCGv_i32 r2_low,
+                          TCGv_i32 r2_high, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_maddsu_64(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void gen_msubsi_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_msubsi_32(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_msub32_ssov(ret, tcg_env, r1, r2, temp);
 }
 
-static void gen_msubsui_32(TCGv ret, TCGv r1, TCGv r2, int32_t con)
+static void gen_msubsui_32(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_msub32_suov(ret, tcg_env, r1, r2, temp);
 }
 
-static void
-gen_msubs_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-             TCGv r3)
+static void gen_msubs_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                         TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                         TCGv_i32 r3)
 {
     TCGv_i64 temp64 = tcg_temp_new_i64();
     tcg_gen_concat_i32_i64(temp64, r2_low, r2_high);
@@ -2415,17 +2447,17 @@ gen_msubs_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static void
-gen_msubsi_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-              int32_t con)
+static void gen_msubsi_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                          int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_msubs_64(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void
-gen_msubsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-             TCGv r3)
+static void gen_msubsu_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                          TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                          TCGv_i32 r3)
 {
     TCGv_i64 temp64 = tcg_temp_new_i64();
     tcg_gen_concat_i32_i64(temp64, r2_low, r2_high);
@@ -2433,26 +2465,26 @@ gen_msubsu_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     tcg_gen_extr_i64_i32(ret_low, ret_high, temp64);
 }
 
-static void
-gen_msubsui_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
-               int32_t con)
+static void gen_msubsui_64(TCGv_i32 ret_low, TCGv_i32 ret_high,
+                           TCGv_i32 r1, TCGv_i32 r2_low, TCGv_i32 r2_high,
+                           int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_msubsu_64(ret_low, ret_high, r1, r2_low, r2_high, temp);
 }
 
-static void gen_saturate(TCGv ret, TCGv arg, int32_t up, int32_t low)
+static void gen_saturate(TCGv_i32 ret, TCGv_i32 arg, int32_t up, int32_t low)
 {
     tcg_gen_smax_i32(ret, arg, tcg_constant_i32(low));
     tcg_gen_smin_i32(ret, ret, tcg_constant_i32(up));
 }
 
-static void gen_saturate_u(TCGv ret, TCGv arg, int32_t up)
+static void gen_saturate_u(TCGv_i32 ret, TCGv_i32 arg, int32_t up)
 {
     tcg_gen_umin_i32(ret, arg, tcg_constant_i32(up));
 }
 
-static void gen_shi(TCGv ret, TCGv r1, int32_t shift_count)
+static void gen_shi(TCGv_i32 ret, TCGv_i32 r1, int32_t shift_count)
 {
     if (shift_count == -32) {
         tcg_gen_movi_i32(ret, 0);
@@ -2463,15 +2495,15 @@ static void gen_shi(TCGv ret, TCGv r1, int32_t shift_count)
     }
 }
 
-static void gen_sh_hi(TCGv ret, TCGv r1, int32_t shiftcount)
+static void gen_sh_hi(TCGv_i32 ret, TCGv_i32 r1, int32_t shiftcount)
 {
-    TCGv temp_low, temp_high;
+    TCGv_i32 temp_low, temp_high;
 
     if (shiftcount == -16) {
         tcg_gen_movi_i32(ret, 0);
     } else {
-        temp_high = tcg_temp_new();
-        temp_low = tcg_temp_new();
+        temp_high = tcg_temp_new_i32();
+        temp_low = tcg_temp_new_i32();
 
         tcg_gen_andi_i32(temp_low, r1, 0xffff);
         tcg_gen_andi_i32(temp_high, r1, 0xffff0000);
@@ -2481,11 +2513,11 @@ static void gen_sh_hi(TCGv ret, TCGv r1, int32_t shiftcount)
     }
 }
 
-static void gen_shaci(TCGv ret, TCGv r1, int32_t shift_count)
+static void gen_shaci(TCGv_i32 ret, TCGv_i32 r1, int32_t shift_count)
 {
     uint32_t msk, msk_start;
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     if (shift_count == 0) {
         /* Clear PSW.C and PSW.V */
@@ -2500,8 +2532,8 @@ static void gen_shaci(TCGv ret, TCGv r1, int32_t shift_count)
         /* clear PSW.V */
         tcg_gen_movi_i32(cpu_PSW_V, 0);
     } else if (shift_count > 0) {
-        TCGv t_max = tcg_constant_i32(0x7FFFFFFF >> shift_count);
-        TCGv t_min = tcg_constant_i32(((int32_t) -0x80000000) >> shift_count);
+        TCGv_i32 t_max = tcg_constant_i32(0x7FFFFFFF >> shift_count);
+        TCGv_i32 t_min = tcg_constant_i32(((int32_t) -0x80000000) >> shift_count);
 
         /* calc carry */
         msk_start = 32 - shift_count;
@@ -2532,34 +2564,34 @@ static void gen_shaci(TCGv ret, TCGv r1, int32_t shift_count)
     tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
-static void gen_shas(TCGv ret, TCGv r1, TCGv r2)
+static void gen_shas(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
     gen_helper_sha_ssov(ret, tcg_env, r1, r2);
 }
 
-static void gen_shasi(TCGv ret, TCGv r1, int32_t con)
+static void gen_shasi(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_shas(ret, r1, temp);
 }
 
-static void gen_sha_hi(TCGv ret, TCGv r1, int32_t shift_count)
+static void gen_sha_hi(TCGv_i32 ret, TCGv_i32 r1, int32_t shift_count)
 {
-    TCGv low, high;
+    TCGv_i32 low, high;
 
     if (shift_count == 0) {
         tcg_gen_mov_i32(ret, r1);
     } else if (shift_count > 0) {
-        low = tcg_temp_new();
-        high = tcg_temp_new();
+        low = tcg_temp_new_i32();
+        high = tcg_temp_new_i32();
 
         tcg_gen_andi_i32(high, r1, 0xffff0000);
         tcg_gen_shli_i32(low, r1, shift_count);
         tcg_gen_shli_i32(ret, high, shift_count);
         tcg_gen_deposit_i32(ret, ret, low, 0, 16);
     } else {
-        low = tcg_temp_new();
-        high = tcg_temp_new();
+        low = tcg_temp_new_i32();
+        high = tcg_temp_new_i32();
 
         tcg_gen_ext16s_i32(low, r1);
         tcg_gen_sari_i32(low, low, -shift_count);
@@ -2569,58 +2601,58 @@ static void gen_sha_hi(TCGv ret, TCGv r1, int32_t shift_count)
 }
 
 /* ret = {ret[30:0], (r1 cond r2)}; */
-static void gen_sh_cond(int cond, TCGv ret, TCGv r1, TCGv r2)
+static void gen_sh_cond(int cond, TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     tcg_gen_shli_i32(temp, ret, 1);
     tcg_gen_setcond_i32(cond, temp2, r1, r2);
     tcg_gen_or_i32(ret, temp, temp2);
 }
 
-static void gen_sh_condi(int cond, TCGv ret, TCGv r1, int32_t con)
+static void gen_sh_condi(int cond, TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_sh_cond(cond, ret, r1, temp);
 }
 
-static void gen_adds(TCGv ret, TCGv r1, TCGv r2)
+static void gen_adds(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
     gen_helper_add_ssov(ret, tcg_env, r1, r2);
 }
 
-static void gen_addsi(TCGv ret, TCGv r1, int32_t con)
+static void gen_addsi(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_add_ssov(ret, tcg_env, r1, temp);
 }
 
-static void gen_addsui(TCGv ret, TCGv r1, int32_t con)
+static void gen_addsui(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_helper_add_suov(ret, tcg_env, r1, temp);
 }
 
-static void gen_subs(TCGv ret, TCGv r1, TCGv r2)
+static void gen_subs(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
     gen_helper_sub_ssov(ret, tcg_env, r1, r2);
 }
 
-static void gen_subsu(TCGv ret, TCGv r1, TCGv r2)
+static void gen_subsu(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2)
 {
     gen_helper_sub_suov(ret, tcg_env, r1, r2);
 }
 
-static void gen_bit_2op(TCGv ret, TCGv r1, TCGv r2,
+static void gen_bit_2op(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2,
                         int pos1, int pos2,
-                        void(*op1)(TCGv, TCGv, TCGv),
-                        void(*op2)(TCGv, TCGv, TCGv))
+                        void(*op1)(TCGv_i32, TCGv_i32, TCGv_i32),
+                        void(*op2)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
-    TCGv temp1, temp2;
+    TCGv_i32 temp1, temp2;
 
-    temp1 = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp1 = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
 
     tcg_gen_shri_i32(temp2, r2, pos2);
     tcg_gen_shri_i32(temp1, r1, pos1);
@@ -2632,14 +2664,14 @@ static void gen_bit_2op(TCGv ret, TCGv r1, TCGv r2,
 }
 
 /* ret = r1[pos1] op1 r2[pos2]; */
-static void gen_bit_1op(TCGv ret, TCGv r1, TCGv r2,
+static void gen_bit_1op(TCGv_i32 ret, TCGv_i32 r1, TCGv_i32 r2,
                         int pos1, int pos2,
-                        void(*op1)(TCGv, TCGv, TCGv))
+                        void(*op1)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
-    TCGv temp1, temp2;
+    TCGv_i32 temp1, temp2;
 
-    temp1 = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp1 = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
 
     tcg_gen_shri_i32(temp2, r2, pos2);
     tcg_gen_shri_i32(temp1, r1, pos1);
@@ -2649,11 +2681,12 @@ static void gen_bit_1op(TCGv ret, TCGv r1, TCGv r2,
     tcg_gen_andi_i32(ret, ret, 0x1);
 }
 
-static void gen_accumulating_cond(int cond, TCGv ret, TCGv r1, TCGv r2,
-                                  void(*op)(TCGv, TCGv, TCGv))
+static void gen_accumulating_cond(int cond, TCGv_i32 ret,
+                                  TCGv_i32 r1, TCGv_i32 r2,
+                                  void(*op)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
     /* temp = (arg1 cond arg2 )*/
     tcg_gen_setcond_i32(cond, temp, r1, r2);
     /* temp2 = ret[0]*/
@@ -2664,20 +2697,20 @@ static void gen_accumulating_cond(int cond, TCGv ret, TCGv r1, TCGv r2,
     tcg_gen_deposit_i32(ret, ret, temp, 0, 1);
 }
 
-static void
-gen_accumulating_condi(int cond, TCGv ret, TCGv r1, int32_t con,
-                       void(*op)(TCGv, TCGv, TCGv))
+static void gen_accumulating_condi(int cond, TCGv_i32 ret, TCGv_i32 r1,
+                                   int32_t con,
+                                   void(*op)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
-    TCGv temp = tcg_constant_i32(con);
+    TCGv_i32 temp = tcg_constant_i32(con);
     gen_accumulating_cond(cond, ret, r1, temp, op);
 }
 
-static void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
+static void gen_eqany_bi(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv b0 = tcg_temp_new();
-    TCGv b1 = tcg_temp_new();
-    TCGv b2 = tcg_temp_new();
-    TCGv b3 = tcg_temp_new();
+    TCGv_i32 b0 = tcg_temp_new_i32();
+    TCGv_i32 b1 = tcg_temp_new_i32();
+    TCGv_i32 b2 = tcg_temp_new_i32();
+    TCGv_i32 b3 = tcg_temp_new_i32();
 
     /* byte 0 */
     tcg_gen_andi_i32(b0, r1, 0xff);
@@ -2701,10 +2734,10 @@ static void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
     tcg_gen_or_i32(ret, ret, b3);
 }
 
-static void gen_eqany_hi(TCGv ret, TCGv r1, int32_t con)
+static void gen_eqany_hi(TCGv_i32 ret, TCGv_i32 r1, int32_t con)
 {
-    TCGv h0 = tcg_temp_new();
-    TCGv h1 = tcg_temp_new();
+    TCGv_i32 h0 = tcg_temp_new_i32();
+    TCGv_i32 h1 = tcg_temp_new_i32();
 
     /* halfword 0 */
     tcg_gen_andi_i32(h0, r1, 0xffff);
@@ -2720,11 +2753,12 @@ static void gen_eqany_hi(TCGv ret, TCGv r1, int32_t con)
 
 /* mask = ((1 << width) -1) << pos;
    ret = (r1 & ~mask) | (r2 << pos) & mask); */
-static void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
+static void gen_insert(TCGv_i32 ret,
+                       TCGv_i32 r1, TCGv_i32 r2, TCGv_i32 width, TCGv_i32 pos)
 {
-    TCGv mask = tcg_temp_new();
-    TCGv temp = tcg_temp_new();
-    TCGv temp2 = tcg_temp_new();
+    TCGv_i32 mask = tcg_temp_new_i32();
+    TCGv_i32 temp = tcg_temp_new_i32();
+    TCGv_i32 temp2 = tcg_temp_new_i32();
 
     tcg_gen_shl_i32(mask, tcg_constant_i32(1), width);
     tcg_gen_subi_i32(mask, mask, 1);
@@ -2736,7 +2770,7 @@ static void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
     tcg_gen_or_i32(ret, temp, temp2);
 }
 
-static void gen_bsplit(TCGv rl, TCGv rh, TCGv r1)
+static void gen_bsplit(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 r1)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -2744,7 +2778,7 @@ static void gen_bsplit(TCGv rl, TCGv rh, TCGv r1)
     tcg_gen_extr_i64_i32(rl, rh, temp);
 }
 
-static void gen_unpack(TCGv rl, TCGv rh, TCGv r1)
+static void gen_unpack(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 r1)
 {
     TCGv_i64 temp = tcg_temp_new_i64();
 
@@ -2752,8 +2786,9 @@ static void gen_unpack(TCGv rl, TCGv rh, TCGv r1)
     tcg_gen_extr_i64_i32(rl, rh, temp);
 }
 
-static void
-gen_dvinit_b(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
+static void gen_dvinit_b(DisasContext *ctx,
+                         TCGv_i32 rl, TCGv_i32 rh,
+                         TCGv_i32 r1, TCGv_i32 r2)
 {
     TCGv_i64 ret = tcg_temp_new_i64();
 
@@ -2765,8 +2800,9 @@ gen_dvinit_b(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
     tcg_gen_extr_i64_i32(rl, rh, ret);
 }
 
-static void
-gen_dvinit_h(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
+static void gen_dvinit_h(DisasContext *ctx,
+                         TCGv_i32 rl, TCGv_i32 rh,
+                         TCGv_i32 r1, TCGv_i32 r2)
 {
     TCGv_i64 ret = tcg_temp_new_i64();
 
@@ -2778,9 +2814,9 @@ gen_dvinit_h(DisasContext *ctx, TCGv rl, TCGv rh, TCGv r1, TCGv r2)
     tcg_gen_extr_i64_i32(rl, rh, ret);
 }
 
-static void gen_calc_usb_mul_h(TCGv arg_low, TCGv arg_high)
+static void gen_calc_usb_mul_h(TCGv_i32 arg_low, TCGv_i32 arg_high)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     /* calc AV bit */
     tcg_gen_add_i32(temp, arg_low, arg_low);
     tcg_gen_xor_i32(temp, temp, arg_low);
@@ -2792,9 +2828,9 @@ static void gen_calc_usb_mul_h(TCGv arg_low, TCGv arg_high)
     tcg_gen_movi_i32(cpu_PSW_V, 0);
 }
 
-static void gen_calc_usb_mulr_h(TCGv arg)
+static void gen_calc_usb_mulr_h(TCGv_i32 arg)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
     /* calc AV bit */
     tcg_gen_add_i32(temp, arg, arg);
     tcg_gen_xor_i32(temp, temp, arg);
@@ -2836,8 +2872,8 @@ static void generate_trap(DisasContext *ctx, int class, int tin)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
-                            TCGv r2, int16_t address)
+static void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv_i32 r1,
+                            TCGv_i32 r2, int16_t address)
 {
     TCGLabel *jumpLabel = gen_new_label();
     tcg_gen_brcond_i32(cond, r1, r2, jumpLabel);
@@ -2848,10 +2884,10 @@ static void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
     gen_goto_tb(ctx, 0, ctx->base.pc_next + address * 2);
 }
 
-static void gen_branch_condi(DisasContext *ctx, TCGCond cond, TCGv r1,
+static void gen_branch_condi(DisasContext *ctx, TCGCond cond, TCGv_i32 r1,
                              int r2, int16_t address)
 {
-    TCGv temp = tcg_constant_i32(r2);
+    TCGv_i32 temp = tcg_constant_i32(r2);
     gen_branch_cond(ctx, cond, r1, temp, address);
 }
 
@@ -2868,7 +2904,7 @@ static void gen_loop(DisasContext *ctx, int r1, int32_t offset)
 
 static void gen_fcall_save_ctx(DisasContext *ctx)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
 
     tcg_gen_addi_i32(temp, cpu_gpr_a[10], -4);
     tcg_gen_qemu_st_i32(cpu_gpr_a[11], temp, ctx->mem_idx, MO_LESL);
@@ -2878,7 +2914,7 @@ static void gen_fcall_save_ctx(DisasContext *ctx)
 
 static void gen_fret(DisasContext *ctx)
 {
-    TCGv temp = tcg_temp_new();
+    TCGv_i32 temp = tcg_temp_new_i32();
 
     tcg_gen_andi_i32(temp, cpu_gpr_a[11], ~0x1);
     tcg_gen_qemu_ld_i32(cpu_gpr_a[11], cpu_gpr_a[10], ctx->mem_idx, MO_LESL);
@@ -2890,7 +2926,7 @@ static void gen_fret(DisasContext *ctx)
 static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
                                int r2 , int32_t constant , int32_t offset)
 {
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
     int n;
 
     switch (opc) {
@@ -2927,12 +2963,12 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         break;
 /* SBRN-format jumps */
     case OPC1_16_SBRN_JZ_T:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_andi_i32(temp, cpu_gpr_d[15], 0x1u << constant);
         gen_branch_condi(ctx, TCG_COND_EQ, temp, 0, offset);
         break;
     case OPC1_16_SBRN_JNZ_T:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_andi_i32(temp, cpu_gpr_d[15], 0x1u << constant);
         gen_branch_condi(ctx, TCG_COND_NE, temp, 0, offset);
         break;
@@ -3040,7 +3076,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
          }
          break;
     case OPCM_32_BRC_JNE:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRC_JNED) {
             tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
             /* subi is unconditional */
@@ -3057,7 +3093,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
     case OPCM_32_BRN_JTT:
         n = MASK_OP_BRN_N(ctx->opcode);
 
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_andi_i32(temp, cpu_gpr_d[r1], (1 << n));
 
         if (MASK_OP_BRN_OP2(ctx->opcode) == OPC2_32_BRN_JNZ_T) {
@@ -3112,8 +3148,8 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         }
         break;
     case OPCM_32_BRR_JNE:
-        temp = tcg_temp_new();
-        temp2 = tcg_temp_new();
+        temp = tcg_temp_new_i32();
+        temp2 = tcg_temp_new_i32();
         if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRR_JNED) {
             tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
             /* also save r2, in case of r1 == r2, so r2 is not decremented */
@@ -3151,7 +3187,7 @@ static void decode_src_opc(DisasContext *ctx, int op1)
 {
     int r1;
     int32_t const4;
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     r1 = MASK_OP_SRC_S1D(ctx->opcode);
     const4 = MASK_OP_SRC_CONST4_SEXT(ctx->opcode);
@@ -3227,7 +3263,7 @@ static void decode_src_opc(DisasContext *ctx, int op1)
 static void decode_srr_opc(DisasContext *ctx, int op1)
 {
     int r1, r2;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_SRR_S1D(ctx->opcode);
     r2 = MASK_OP_SRR_S2(ctx->opcode);
@@ -3545,7 +3581,7 @@ static void decode_16Bit_opc(DisasContext *ctx)
     int r1, r2;
     int32_t const16;
     int32_t address;
-    TCGv temp;
+    TCGv_i32 temp;
 
     op1 = MASK_OP_MAJOR(ctx->opcode);
 
@@ -3612,7 +3648,7 @@ static void decode_16Bit_opc(DisasContext *ctx)
         r2 = MASK_OP_SRRS_S2(ctx->opcode);
         r1 = MASK_OP_SRRS_S1D(ctx->opcode);
         const16 = MASK_OP_SRRS_N(ctx->opcode);
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_shli_i32(temp, cpu_gpr_d[15], const16);
         tcg_gen_add_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], temp);
         break;
@@ -3780,7 +3816,7 @@ static void decode_abs_ldw(DisasContext *ctx)
     int32_t op2;
     int32_t r1;
     uint32_t address;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_ABS_S1D(ctx->opcode);
     address = MASK_OP_ABS_OFF18(ctx->opcode);
@@ -3813,7 +3849,7 @@ static void decode_abs_ldb(DisasContext *ctx)
     int32_t op2;
     int32_t r1;
     uint32_t address;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_ABS_S1D(ctx->opcode);
     address = MASK_OP_ABS_OFF18(ctx->opcode);
@@ -3844,7 +3880,7 @@ static void decode_abs_ldst_swap(DisasContext *ctx)
     int32_t op2;
     int32_t r1;
     uint32_t address;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_ABS_S1D(ctx->opcode);
     address = MASK_OP_ABS_OFF18(ctx->opcode);
@@ -3895,7 +3931,7 @@ static void decode_abs_store(DisasContext *ctx)
     int32_t op2;
     int32_t r1;
     uint32_t address;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_ABS_S1D(ctx->opcode);
     address = MASK_OP_ABS_OFF18(ctx->opcode);
@@ -3928,7 +3964,7 @@ static void decode_abs_storeb_h(DisasContext *ctx)
     int32_t op2;
     int32_t r1;
     uint32_t address;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_ABS_S1D(ctx->opcode);
     address = MASK_OP_ABS_OFF18(ctx->opcode);
@@ -4030,7 +4066,7 @@ static void decode_bit_insert(DisasContext *ctx)
     uint32_t op2;
     int r1, r2, r3;
     int pos1, pos2;
-    TCGv temp;
+    TCGv_i32 temp;
     op2 = MASK_OP_BIT_OP2(ctx->opcode);
     r1 = MASK_OP_BIT_S1(ctx->opcode);
     r2 = MASK_OP_BIT_S2(ctx->opcode);
@@ -4038,7 +4074,7 @@ static void decode_bit_insert(DisasContext *ctx)
     pos1 = MASK_OP_BIT_POS1(ctx->opcode);
     pos2 = MASK_OP_BIT_POS2(ctx->opcode);
 
-    temp = tcg_temp_new();
+    temp = tcg_temp_new_i32();
 
     tcg_gen_shri_i32(temp, cpu_gpr_d[r2], pos2);
     if (op2 == OPC2_32_BIT_INSN_T) {
@@ -4129,7 +4165,7 @@ static void decode_bit_sh_logic1(DisasContext *ctx)
     uint32_t op2;
     int r1, r2, r3;
     int pos1, pos2;
-    TCGv temp;
+    TCGv_i32 temp;
 
     op2 = MASK_OP_BIT_OP2(ctx->opcode);
     r1 = MASK_OP_BIT_S1(ctx->opcode);
@@ -4138,7 +4174,7 @@ static void decode_bit_sh_logic1(DisasContext *ctx)
     pos1 = MASK_OP_BIT_POS1(ctx->opcode);
     pos2 = MASK_OP_BIT_POS2(ctx->opcode);
 
-    temp = tcg_temp_new();
+    temp = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_BIT_SH_AND_T:
@@ -4169,7 +4205,7 @@ static void decode_bit_sh_logic2(DisasContext *ctx)
     uint32_t op2;
     int r1, r2, r3;
     int pos1, pos2;
-    TCGv temp;
+    TCGv_i32 temp;
 
     op2 = MASK_OP_BIT_OP2(ctx->opcode);
     r1 = MASK_OP_BIT_S1(ctx->opcode);
@@ -4178,7 +4214,7 @@ static void decode_bit_sh_logic2(DisasContext *ctx)
     pos1 = MASK_OP_BIT_POS1(ctx->opcode);
     pos2 = MASK_OP_BIT_POS2(ctx->opcode);
 
-    temp = tcg_temp_new();
+    temp = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_BIT_SH_NAND_T:
@@ -4212,7 +4248,7 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
     uint32_t op2;
     uint32_t off10;
     int32_t r1, r2;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_BO_S1D(ctx->opcode);
     r2  = MASK_OP_BO_S2(ctx->opcode);
@@ -4296,7 +4332,7 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_D_PREINC:
         CHECK_REG_PAIR(r1);
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_st_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
@@ -4314,7 +4350,7 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_ST_DA_PREINC:
         CHECK_REG_PAIR(r1);
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_st_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
@@ -4331,19 +4367,19 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         gen_st_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_ST_Q_SHORTOFF:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
         gen_offset_st(ctx, temp, cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_ST_Q_POSTINC:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
         tcg_gen_qemu_st_i32(temp, cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUW);
         tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_Q_PREINC:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
         gen_st_preincr(ctx, temp, cpu_gpr_a[r2], off10, MO_LEUW);
         break;
@@ -4368,15 +4404,15 @@ static void decode_bo_addrmode_bitreverse_circular(DisasContext *ctx)
     uint32_t op2;
     uint32_t off10;
     int32_t r1, r2;
-    TCGv temp, temp2, t_off10;
+    TCGv_i32 temp, temp2, t_off10;
 
     r1 = MASK_OP_BO_S1D(ctx->opcode);
     r2  = MASK_OP_BO_S2(ctx->opcode);
     off10 = MASK_OP_BO_OFF10_SEXT(ctx->opcode);
     op2 = MASK_OP_BO_OP2(ctx->opcode);
 
-    temp = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
     t_off10 = tcg_constant_i32(off10);
     CHECK_REG_PAIR(r2);
     tcg_gen_ext16u_i32(temp, cpu_gpr_a[r2 + 1]);
@@ -4475,7 +4511,7 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
     uint32_t op2;
     uint32_t off10;
     int32_t r1, r2;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_BO_S1D(ctx->opcode);
     r2  = MASK_OP_BO_S2(ctx->opcode);
@@ -4529,7 +4565,7 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_D_PREINC:
         CHECK_REG_PAIR(r1);
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_ld_2regs_64(ctx, cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
@@ -4547,7 +4583,7 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         break;
     case OPC2_32_BO_LD_DA_PREINC:
         CHECK_REG_PAIR(r1);
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_ld_2regs_64(ctx, cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp);
         tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
@@ -4609,15 +4645,15 @@ static void decode_bo_addrmode_ld_bitreverse_circular(DisasContext *ctx)
     uint32_t op2;
     uint32_t off10;
     int r1, r2;
-    TCGv temp, temp2, t_off10;
+    TCGv_i32 temp, temp2, t_off10;
 
     r1 = MASK_OP_BO_S1D(ctx->opcode);
     r2 = MASK_OP_BO_S2(ctx->opcode);
     off10 = MASK_OP_BO_OFF10_SEXT(ctx->opcode);
     op2 = MASK_OP_BO_OP2(ctx->opcode);
 
-    temp = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
     t_off10 = tcg_constant_i32(off10);
     CHECK_REG_PAIR(r2);
     tcg_gen_ext16u_i32(temp, cpu_gpr_a[r2 + 1]);
@@ -4724,7 +4760,7 @@ static void decode_bo_addrmode_stctx_post_pre_base(DisasContext *ctx)
     uint32_t off10;
     int r1, r2;
 
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_BO_S1D(ctx->opcode);
     r2 = MASK_OP_BO_S2(ctx->opcode);
@@ -4732,7 +4768,7 @@ static void decode_bo_addrmode_stctx_post_pre_base(DisasContext *ctx)
     op2 = MASK_OP_BO_OP2(ctx->opcode);
 
 
-    temp = tcg_temp_new();
+    temp = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_BO_LDLCX_SHORTOFF:
@@ -4812,15 +4848,15 @@ static void decode_bo_addrmode_ldmst_bitreverse_circular(DisasContext *ctx)
     uint32_t op2;
     uint32_t off10;
     int r1, r2;
-    TCGv temp, temp2, t_off10;
+    TCGv_i32 temp, temp2, t_off10;
 
     r1 = MASK_OP_BO_S1D(ctx->opcode);
     r2 = MASK_OP_BO_S2(ctx->opcode);
     off10 = MASK_OP_BO_OFF10_SEXT(ctx->opcode);
     op2 = MASK_OP_BO_OP2(ctx->opcode);
 
-    temp = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
     t_off10 = tcg_constant_i32(off10);
     CHECK_REG_PAIR(r2);
     tcg_gen_ext16u_i32(temp, cpu_gpr_a[r2 + 1]);
@@ -4868,7 +4904,7 @@ static void decode_bol_opc(DisasContext *ctx, int32_t op1)
 {
     int r1, r2;
     int32_t address;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r1 = MASK_OP_BOL_S1D(ctx->opcode);
     r2 = MASK_OP_BOL_S2(ctx->opcode);
@@ -4876,12 +4912,12 @@ static void decode_bol_opc(DisasContext *ctx, int32_t op1)
 
     switch (op1) {
     case OPC1_32_BOL_LD_A_LONGOFF:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], address);
         tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], temp, ctx->mem_idx, MO_LEUL);
         break;
     case OPC1_32_BOL_LD_W_LONGOFF:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_addi_i32(temp, cpu_gpr_a[r2], address);
         tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUL);
         break;
@@ -4951,7 +4987,7 @@ static void decode_rc_logical_shift(DisasContext *ctx)
     uint32_t op2;
     int r1, r2;
     int32_t const9;
-    TCGv temp;
+    TCGv_i32 temp;
 
     r2 = MASK_OP_RC_D(ctx->opcode);
     r1 = MASK_OP_RC_S1(ctx->opcode);
@@ -4966,12 +5002,12 @@ static void decode_rc_logical_shift(DisasContext *ctx)
         tcg_gen_andi_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], ~const9);
         break;
     case OPC2_32_RC_NAND:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_movi_i32(temp, const9);
         tcg_gen_nand_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_NOR:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_movi_i32(temp, const9);
         tcg_gen_nor_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
@@ -5026,7 +5062,7 @@ static void decode_rc_accumulator(DisasContext *ctx)
     int r1, r2;
     int16_t const9;
 
-    TCGv temp;
+    TCGv_i32 temp;
 
     r2 = MASK_OP_RC_D(ctx->opcode);
     r1 = MASK_OP_RC_S1(ctx->opcode);
@@ -5034,7 +5070,7 @@ static void decode_rc_accumulator(DisasContext *ctx)
 
     op2 = MASK_OP_RC_OP2(ctx->opcode);
 
-    temp = tcg_temp_new();
+    temp = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_RC_ABSDIF:
@@ -5287,7 +5323,7 @@ static void decode_rcpw_insert(DisasContext *ctx)
     int r1, r2;
     int32_t pos, width, const4;
 
-    TCGv temp;
+    TCGv_i32 temp;
 
     op2    = MASK_OP_RCPW_OP2(ctx->opcode);
     r1     = MASK_OP_RCPW_S1(ctx->opcode);
@@ -5328,7 +5364,7 @@ static void decode_rcrw_insert(DisasContext *ctx)
     int r1, r3, r4;
     int32_t width, const4;
 
-    TCGv temp, temp2, temp3;
+    TCGv_i32 temp, temp2, temp3;
 
     op2    = MASK_OP_RCRW_OP2(ctx->opcode);
     r1     = MASK_OP_RCRW_S1(ctx->opcode);
@@ -5337,8 +5373,8 @@ static void decode_rcrw_insert(DisasContext *ctx)
     width  = MASK_OP_RCRW_WIDTH(ctx->opcode);
     const4 = MASK_OP_RCRW_CONST4(ctx->opcode);
 
-    temp = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_RCRW_IMASK:
@@ -5350,7 +5386,7 @@ static void decode_rcrw_insert(DisasContext *ctx)
         tcg_gen_shl_i32(cpu_gpr_d[r4], temp2, temp);
         break;
     case OPC2_32_RCRW_INSERT:
-        temp3 = tcg_temp_new();
+        temp3 = tcg_temp_new_i32();
 
         tcg_gen_movi_i32(temp, width);
         tcg_gen_movi_i32(temp2, const4);
@@ -5370,7 +5406,7 @@ static void decode_rcr_cond_select(DisasContext *ctx)
     int r1, r3, r4;
     int32_t const9;
 
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     op2 = MASK_OP_RCR_OP2(ctx->opcode);
     r1 = MASK_OP_RCR_S1(ctx->opcode);
@@ -5577,7 +5613,7 @@ static void decode_rr_accumulator(DisasContext *ctx)
     uint32_t op2;
     int r3, r2, r1;
 
-    TCGv temp;
+    TCGv_i32 temp;
 
     r3 = MASK_OP_RR_D(ctx->opcode);
     r2 = MASK_OP_RR_S2(ctx->opcode);
@@ -5774,7 +5810,7 @@ static void decode_rr_accumulator(DisasContext *ctx)
         break;
     case OPC2_32_RR_MOV_64:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
-            temp = tcg_temp_new();
+            temp = tcg_temp_new_i32();
 
             CHECK_REG_PAIR(r3);
             tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
@@ -5993,7 +6029,7 @@ static void decode_rr_address(DisasContext *ctx)
 {
     uint32_t op2, n;
     int r1, r2, r3;
-    TCGv temp;
+    TCGv_i32 temp;
 
     op2 = MASK_OP_RR_OP2(ctx->opcode);
     r3 = MASK_OP_RR_D(ctx->opcode);
@@ -6006,12 +6042,12 @@ static void decode_rr_address(DisasContext *ctx)
         tcg_gen_add_i32(cpu_gpr_a[r3], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_ADDSC_A:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_shli_i32(temp, cpu_gpr_d[r1], n);
         tcg_gen_add_i32(cpu_gpr_a[r3], cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_RR_ADDSC_AT:
-        temp = tcg_temp_new();
+        temp = tcg_temp_new_i32();
         tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 3);
         tcg_gen_add_i32(temp, cpu_gpr_a[r2], temp);
         tcg_gen_andi_i32(cpu_gpr_a[r3], temp, 0xFFFFFFFC);
@@ -6091,7 +6127,7 @@ static void decode_rr_divide(DisasContext *ctx)
     uint32_t op2;
     int r1, r2, r3;
 
-    TCGv temp, temp2, temp3;
+    TCGv_i32 temp, temp2, temp3;
 
     op2 = MASK_OP_RR_OP2(ctx->opcode);
     r3 = MASK_OP_RR_D(ctx->opcode);
@@ -6112,9 +6148,9 @@ static void decode_rr_divide(DisasContext *ctx)
                      cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DVINIT_BU:
-        temp = tcg_temp_new();
-        temp2 = tcg_temp_new();
-        temp3 = tcg_temp_new();
+        temp = tcg_temp_new_i32();
+        temp2 = tcg_temp_new_i32();
+        temp3 = tcg_temp_new_i32();
         CHECK_REG_PAIR(r3);
         tcg_gen_shri_i32(temp3, cpu_gpr_d[r1], 8);
         /* reset av */
@@ -6141,9 +6177,9 @@ static void decode_rr_divide(DisasContext *ctx)
                      cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DVINIT_HU:
-        temp = tcg_temp_new();
-        temp2 = tcg_temp_new();
-        temp3 = tcg_temp_new();
+        temp = tcg_temp_new_i32();
+        temp2 = tcg_temp_new_i32();
+        temp3 = tcg_temp_new_i32();
         CHECK_REG_PAIR(r3);
         tcg_gen_shri_i32(temp3, cpu_gpr_d[r1], 16);
         /* reset av */
@@ -6165,8 +6201,8 @@ static void decode_rr_divide(DisasContext *ctx)
         tcg_gen_mov_i32(cpu_gpr_d[r3 + 1], temp3);
         break;
     case OPC2_32_RR_DVINIT:
-        temp = tcg_temp_new();
-        temp2 = tcg_temp_new();
+        temp = tcg_temp_new_i32();
+        temp2 = tcg_temp_new_i32();
         CHECK_REG_PAIR(r3);
         /* overflow = ((D[b] == 0) ||
                       ((D[b] == 0xFFFFFFFF) && (D[a] == 0x80000000))) */
@@ -6315,7 +6351,7 @@ static void decode_rr1_mul(DisasContext *ctx)
     uint32_t op2;
 
     int r1, r2, r3;
-    TCGv n;
+    TCGv_i32 n;
     TCGv_i64 temp64;
 
     r1 = MASK_OP_RR1_S1(ctx->opcode);
@@ -6420,7 +6456,7 @@ static void decode_rr1_mulq(DisasContext *ctx)
     int r1, r2, r3;
     uint32_t n;
 
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     r1 = MASK_OP_RR1_S1(ctx->opcode);
     r2 = MASK_OP_RR1_S2(ctx->opcode);
@@ -6428,8 +6464,8 @@ static void decode_rr1_mulq(DisasContext *ctx)
     n  = MASK_OP_RR1_N(ctx->opcode);
     op2 = MASK_OP_RR1_OP2(ctx->opcode);
 
-    temp = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_RR1_MUL_Q_32:
@@ -6526,7 +6562,7 @@ static void decode_rrpw_extract_insert(DisasContext *ctx)
     uint32_t op2;
     int r1, r2, r3;
     int32_t pos, width;
-    TCGv temp;
+    TCGv_i32 temp;
 
     op2 = MASK_OP_RRPW_OP2(ctx->opcode);
     r1 = MASK_OP_RRPW_S1(ctx->opcode);
@@ -6554,7 +6590,7 @@ static void decode_rrpw_extract_insert(DisasContext *ctx)
         CHECK_REG_PAIR(r3);
 
         if (pos + width <= 32) {
-            temp = tcg_temp_new();
+            temp = tcg_temp_new_i32();
             tcg_gen_movi_i32(temp, ((1u << width) - 1) << pos);
             tcg_gen_shli_i32(cpu_gpr_d[r3], cpu_gpr_d[r2], pos);
             tcg_gen_mov_i32(cpu_gpr_d[r3 + 1], temp);
@@ -6580,7 +6616,7 @@ static void decode_rrr_cond_select(DisasContext *ctx)
 {
     uint32_t op2;
     int r1, r2, r3, r4;
-    TCGv temp;
+    TCGv_i32 temp;
 
     op2 = MASK_OP_RRR_OP2(ctx->opcode);
     r1  = MASK_OP_RRR_S1(ctx->opcode);
@@ -6964,7 +7000,7 @@ static void decode_rrr1_maddq_h(DisasContext *ctx)
 {
     uint32_t op2;
     uint32_t r1, r2, r3, r4, n;
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     op2 = MASK_OP_RRR1_OP2(ctx->opcode);
     r1 = MASK_OP_RRR1_S1(ctx->opcode);
@@ -6973,8 +7009,8 @@ static void decode_rrr1_maddq_h(DisasContext *ctx)
     r4 = MASK_OP_RRR1_D(ctx->opcode);
     n = MASK_OP_RRR1_N(ctx->opcode);
 
-    temp = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_RRR1_MADD_Q_32:
@@ -7446,7 +7482,7 @@ static void decode_rrr1_msubq_h(DisasContext *ctx)
 {
     uint32_t op2;
     uint32_t r1, r2, r3, r4, n;
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     op2 = MASK_OP_RRR1_OP2(ctx->opcode);
     r1 = MASK_OP_RRR1_S1(ctx->opcode);
@@ -7455,8 +7491,8 @@ static void decode_rrr1_msubq_h(DisasContext *ctx)
     r4 = MASK_OP_RRR1_D(ctx->opcode);
     n = MASK_OP_RRR1_N(ctx->opcode);
 
-    temp = tcg_temp_new();
-    temp2 = tcg_temp_new();
+    temp = tcg_temp_new_i32();
+    temp2 = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_RRR1_MSUB_Q_32:
@@ -7783,7 +7819,7 @@ static void decode_rrrr_extract_insert(DisasContext *ctx)
 {
     uint32_t op2;
     int r1, r2, r3, r4;
-    TCGv tmp_width, tmp_pos;
+    TCGv_i32 tmp_width, tmp_pos;
 
     r1 = MASK_OP_RRRR_S1(ctx->opcode);
     r2 = MASK_OP_RRRR_S2(ctx->opcode);
@@ -7791,8 +7827,8 @@ static void decode_rrrr_extract_insert(DisasContext *ctx)
     r4 = MASK_OP_RRRR_D(ctx->opcode);
     op2 = MASK_OP_RRRR_OP2(ctx->opcode);
 
-    tmp_pos = tcg_temp_new();
-    tmp_width = tcg_temp_new();
+    tmp_pos = tcg_temp_new_i32();
+    tmp_width = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_RRRR_DEXTR:
@@ -7800,8 +7836,8 @@ static void decode_rrrr_extract_insert(DisasContext *ctx)
         if (r1 == r2) {
             tcg_gen_rotl_i32(cpu_gpr_d[r4], cpu_gpr_d[r1], tmp_pos);
         } else {
-            TCGv msw = tcg_temp_new();
-            TCGv zero = tcg_constant_i32(0);
+            TCGv_i32 msw = tcg_temp_new_i32();
+            TCGv_i32 zero = tcg_constant_i32(0);
             tcg_gen_shl_i32(tmp_width, cpu_gpr_d[r1], tmp_pos);
             tcg_gen_subfi_i32(msw, 32, tmp_pos);
             tcg_gen_shr_i32(msw, cpu_gpr_d[r2], msw);
@@ -7848,7 +7884,7 @@ static void decode_rrrw_extract_insert(DisasContext *ctx)
     int r1, r2, r3, r4;
     int32_t width;
 
-    TCGv temp, temp2;
+    TCGv_i32 temp, temp2;
 
     op2 = MASK_OP_RRRW_OP2(ctx->opcode);
     r1  = MASK_OP_RRRW_S1(ctx->opcode);
@@ -7857,7 +7893,7 @@ static void decode_rrrw_extract_insert(DisasContext *ctx)
     r4  = MASK_OP_RRRW_D(ctx->opcode);
     width = MASK_OP_RRRW_WIDTH(ctx->opcode);
 
-    temp = tcg_temp_new();
+    temp = tcg_temp_new_i32();
 
     switch (op2) {
     case OPC2_32_RRRW_EXTR:
@@ -7877,7 +7913,7 @@ static void decode_rrrw_extract_insert(DisasContext *ctx)
         }
         break;
     case OPC2_32_RRRW_IMASK:
-        temp2 = tcg_temp_new();
+        temp2 = tcg_temp_new_i32();
         CHECK_REG_PAIR(r4);
         tcg_gen_andi_i32(temp, cpu_gpr_d[r3], 0x1f);
         tcg_gen_movi_i32(temp2, (1 << width) - 1);
@@ -7886,7 +7922,7 @@ static void decode_rrrw_extract_insert(DisasContext *ctx)
         tcg_gen_mov_i32(cpu_gpr_d[r4 + 1], temp2);
         break;
     case OPC2_32_RRRW_INSERT:
-        temp2 = tcg_temp_new();
+        temp2 = tcg_temp_new_i32();
 
         tcg_gen_movi_i32(temp, width);
         tcg_gen_andi_i32(temp2, cpu_gpr_d[r3], 0x1f);
@@ -7903,7 +7939,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
     uint32_t op2;
     uint32_t r1;
     TCGLabel *l1;
-    TCGv tmp;
+    TCGv_i32 tmp;
 
     op2 = MASK_OP_SYS_OP2(ctx->opcode);
     r1  = MASK_OP_SYS_S1D(ctx->opcode);
@@ -7957,7 +7993,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_RFM:
         if (ctx->priv  == TRICORE_PRIV_SM) {
-            tmp = tcg_temp_new();
+            tmp = tcg_temp_new_i32();
             l1 = gen_new_label();
 
             tcg_gen_ld_i32(tmp, tcg_env, offsetof(CPUTriCoreState, DBGSR));
@@ -8013,7 +8049,7 @@ static void decode_32Bit_opc(DisasContext *ctx)
     int32_t address, const16;
     int8_t b, const4;
     int32_t bpos;
-    TCGv temp, temp2, temp3;
+    TCGv_i32 temp, temp2, temp3;
 
     op1 = MASK_OP_MAJOR(ctx->opcode);
 
@@ -8046,7 +8082,7 @@ static void decode_32Bit_opc(DisasContext *ctx)
         address = MASK_OP_ABS_OFF18(ctx->opcode);
         r1 = MASK_OP_ABS_S1D(ctx->opcode);
         temp = tcg_constant_i32(EA_ABS_FORMAT(address));
-        temp2 = tcg_temp_new();
+        temp2 = tcg_temp_new_i32();
 
         tcg_gen_shri_i32(temp2, cpu_gpr_d[r1], 16);
         tcg_gen_qemu_st_i32(temp2, temp, ctx->mem_idx, MO_LEUW);
@@ -8081,7 +8117,7 @@ static void decode_32Bit_opc(DisasContext *ctx)
         bpos = MASK_OP_ABSB_BPOS(ctx->opcode);
 
         temp = tcg_constant_i32(EA_ABS_FORMAT(address));
-        temp2 = tcg_temp_new();
+        temp2 = tcg_temp_new_i32();
 
         tcg_gen_qemu_ld_i32(temp2, temp, ctx->mem_idx, MO_UB);
         tcg_gen_andi_i32(temp2, temp2, ~(0x1u << bpos));
@@ -8208,8 +8244,8 @@ static void decode_32Bit_opc(DisasContext *ctx)
         r3 = MASK_OP_RCRR_D(ctx->opcode);
         const16 = MASK_OP_RCRR_CONST4(ctx->opcode);
         temp = tcg_constant_i32(const16);
-        temp2 = tcg_temp_new(); /* width*/
-        temp3 = tcg_temp_new(); /* pos */
+        temp2 = tcg_temp_new_i32(); /* width*/
+        temp3 = tcg_temp_new_i32(); /* pos */
 
         CHECK_REG_PAIR(r2);
 
-- 
2.51.0


