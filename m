Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E968BCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mzu-0007KB-4P; Thu, 16 Oct 2025 08:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Myd-0005IJ-Ug
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyT-0000RP-Ca
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:21:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so365897f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617246; x=1761222046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z4K5CB8QvWbM4c4Oc1OKjLfNbfykzKFVkpAPVS1cjWY=;
 b=PrB6WYewRAW0E22Mmd45hoEk8/S1IUI+9zv+BFLOU1iSdrvXS7aFbaEtxC4oGVQI8W
 l0Dyg8NlkuW3VBTsxSeoydGYil1JdU6xPBTon5OYs//JH4Up7Irvq4fJ4istt6GQKNl0
 U7yOM4YWfO/iyvU40TJbh9NwBDQn641EM6Uy+MIVpQdupy0GSiqJ/Ve/2nnOVy1X5le3
 QqwRyjrp3BYldvDw3+TYrryOV4DIQnHQd7rNihwjCTM691I8PQYVhxpEFKS8eR4bg5Ew
 pz2LkL0/dYbIza2Q5e9ylYh6ifYQtLCp97LFqZXPGpBklBcJm0lYvsNCbhUhDEiFVK21
 0ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617246; x=1761222046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4K5CB8QvWbM4c4Oc1OKjLfNbfykzKFVkpAPVS1cjWY=;
 b=PtSBG6WNja4KfQMMKRA97rZydPR3nPd2DtbyWa/U31ZWOBmEFVJJeOrGno77caJy7X
 f3Hws4INID+O7he1vf+kc+GfzrlJNrWDCHufg4TF+Gux5bgioICgU0KFZPeb9vRM16Y4
 mfGh8gIJsVQVGEPLPEK70f2y6iAcMimMkckj/2vLrXjskt6HKPVhsiXlcz1ybz/HI5Wk
 hFSb3LSRZpzyqPuZpNtBCJeLR0i3K77g9z63Jx5M+r18OOqpRh3g+6qxucnOa4apsrD8
 mR2Gjs5Etbcnc9zCZC4IMz2BALt7mx5lEb0EXgVHiZlwuF9PwDnY3f5J3SGvtwcQ997B
 v06Q==
X-Gm-Message-State: AOJu0YyBYkHIC6BUXeBXaWwn3Z5f/Rc83auBsHmAGH6+SeCIHI7qgXQS
 ZjrMg7Zqb0W2BhcxRRFMn3xOB/usplGNs3YchDvzxmwoSrMNvqtKD+4iC9DMb4plBTyJzFyhvJf
 mcnBtnxA=
X-Gm-Gg: ASbGncv+JaS0/Wi31UP8I4SUNF5FhHNbO2yIeKOpu3MTqpwU+etjTxILM4pJbsfUx72
 RsJ21PkleooevwH2fqAwQQUrh/ZXDpAJHdwhlDjggquSTcjx9KKZHOPty5cOr7aoEcoJGejMENM
 rl02eh2HWLPDjNsoIeB+O6KhzqUf1I8+VBbA9x6X/jf9f7igDXjzJSrV5DDScvqHIVEzt2HcKfg
 orLZj3vmMi+TZrnwgOmjF2sIRuNnHcBzhQqlCJkQhr4I8Egr3QK7PEECl6tAnIqfJ9/3erjKQl5
 wqzOQt+lMxjHMGvFk2KS5O7e5MbSZvtBijI+2BMSaJT74T9cKBkZZRL4Y31626qJdCsq3gYivFv
 5biyxVhcQ76UgP0+tZSWakwXWz97UQblrT+PduIB/VRhA3ZsNvfuvQQ9GdGoXv0QJef93TTvINt
 13E4tBzWc9RY2FiQ9fNtZcNwhQpQUZG0YutD5NK5YeBv3HqjzjaMKxhg==
X-Google-Smtp-Source: AGHT+IEl1srEub6PkPwpaW/N0VgVcKNr6226v7zLf/WDpVt7X3WOQZDUr2rYVCJLDAGZofsw0rXebw==
X-Received: by 2002:a05:6000:430b:b0:3ec:d7c4:25b6 with SMTP id
 ffacd0b85a97d-4266e7c7c4bmr23470977f8f.27.1760617244995; 
 Thu, 16 Oct 2025 05:20:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cc0esm34727581f8f.6.2025.10.16.05.20.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/75] target/tricore: Expand TCG helpers for 32-bit target
Date: Thu, 16 Oct 2025 14:15:23 +0200
Message-ID: <20251016121532.14042-68-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The TriCore target is only built as 32-bit:

  $ git grep TARGET_LONG_BITS configs/targets/tricore-*
  configs/targets/tricore-softmmu.mak:2:TARGET_LONG_BITS=32

Therefore tcg_FOO_tl() always expands to tcg_FOO_i32().

This is a mechanical replacement.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-10-philmd@linaro.org>
---
 target/tricore/translate.c | 2595 ++++++++++++++++++------------------
 1 file changed, 1298 insertions(+), 1297 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2cfd2e5b8df..ef3653b8820 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -139,9 +139,9 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     TCGv arg00 = tcg_temp_new();                             \
     TCGv arg01 = tcg_temp_new();                             \
     TCGv arg11 = tcg_temp_new();                             \
-    tcg_gen_sari_tl(arg00, arg0, 16);                        \
-    tcg_gen_ext16s_tl(arg01, arg0);                          \
-    tcg_gen_ext16s_tl(arg11, arg1);                          \
+    tcg_gen_sari_i32(arg00, arg0, 16);                       \
+    tcg_gen_ext16s_i32(arg01, arg0);                         \
+    tcg_gen_ext16s_i32(arg11, arg1);                         \
     gen_helper_##name(ret, arg00, arg01, arg11, arg11, n);   \
 } while (0)
 
@@ -150,10 +150,10 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     TCGv arg01 = tcg_temp_new();                             \
     TCGv arg10 = tcg_temp_new();                             \
     TCGv arg11 = tcg_temp_new();                             \
-    tcg_gen_sari_tl(arg00, arg0, 16);                        \
-    tcg_gen_ext16s_tl(arg01, arg0);                          \
-    tcg_gen_sari_tl(arg11, arg1, 16);                        \
-    tcg_gen_ext16s_tl(arg10, arg1);                          \
+    tcg_gen_sari_i32(arg00, arg0, 16);                       \
+    tcg_gen_ext16s_i32(arg01, arg0);                         \
+    tcg_gen_sari_i32(arg11, arg1, 16);                       \
+    tcg_gen_ext16s_i32(arg10, arg1);                         \
     gen_helper_##name(ret, arg00, arg01, arg10, arg11, n);   \
 } while (0)
 
@@ -162,10 +162,10 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     TCGv arg01 = tcg_temp_new();                             \
     TCGv arg10 = tcg_temp_new();                             \
     TCGv arg11 = tcg_temp_new();                             \
-    tcg_gen_sari_tl(arg00, arg0, 16);                        \
-    tcg_gen_ext16s_tl(arg01, arg0);                          \
-    tcg_gen_sari_tl(arg10, arg1, 16);                        \
-    tcg_gen_ext16s_tl(arg11, arg1);                          \
+    tcg_gen_sari_i32(arg00, arg0, 16);                       \
+    tcg_gen_ext16s_i32(arg01, arg0);                         \
+    tcg_gen_sari_i32(arg10, arg1, 16);                       \
+    tcg_gen_ext16s_i32(arg11, arg1);                         \
     gen_helper_##name(ret, arg00, arg01, arg10, arg11, n);   \
 } while (0)
 
@@ -173,9 +173,9 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     TCGv arg00 = tcg_temp_new();                             \
     TCGv arg01 = tcg_temp_new();                             \
     TCGv arg11 = tcg_temp_new();                             \
-    tcg_gen_sari_tl(arg01, arg0, 16);                        \
-    tcg_gen_ext16s_tl(arg00, arg0);                          \
-    tcg_gen_sari_tl(arg11, arg1, 16);                        \
+    tcg_gen_sari_i32(arg01, arg0, 16);                       \
+    tcg_gen_ext16s_i32(arg00, arg0);                         \
+    tcg_gen_sari_i32(arg11, arg1, 16);                       \
     gen_helper_##name(ret, arg00, arg01, arg11, arg11, n);   \
 } while (0)
 
@@ -214,16 +214,16 @@ static inline void gen_offset_ld(DisasContext *ctx, TCGv r1, TCGv r2,
                                  int16_t con, MemOp mop)
 {
     TCGv temp = tcg_temp_new();
-    tcg_gen_addi_tl(temp, r2, con);
-    tcg_gen_qemu_ld_tl(r1, temp, ctx->mem_idx, mop);
+    tcg_gen_addi_i32(temp, r2, con);
+    tcg_gen_qemu_ld_i32(r1, temp, ctx->mem_idx, mop);
 }
 
 static inline void gen_offset_st(DisasContext *ctx, TCGv r1, TCGv r2,
                                  int16_t con, MemOp mop)
 {
     TCGv temp = tcg_temp_new();
-    tcg_gen_addi_tl(temp, r2, con);
-    tcg_gen_qemu_st_tl(r1, temp, ctx->mem_idx, mop);
+    tcg_gen_addi_i32(temp, r2, con);
+    tcg_gen_qemu_st_i32(r1, temp, ctx->mem_idx, mop);
 }
 
 static void gen_st_2regs_64(TCGv rh, TCGv rl, TCGv address, DisasContext *ctx)
@@ -238,7 +238,7 @@ static void gen_offset_st_2regs(TCGv rh, TCGv rl, TCGv base, int16_t con,
                                 DisasContext *ctx)
 {
     TCGv temp = tcg_temp_new();
-    tcg_gen_addi_tl(temp, base, con);
+    tcg_gen_addi_i32(temp, base, con);
     gen_st_2regs_64(rh, rl, temp, ctx);
 }
 
@@ -255,7 +255,7 @@ static void gen_offset_ld_2regs(TCGv rh, TCGv rl, TCGv base, int16_t con,
                                 DisasContext *ctx)
 {
     TCGv temp = tcg_temp_new();
-    tcg_gen_addi_tl(temp, base, con);
+    tcg_gen_addi_i32(temp, base, con);
     gen_ld_2regs_64(rh, rl, temp, ctx);
 }
 
@@ -263,18 +263,18 @@ static void gen_st_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t off,
                            MemOp mop)
 {
     TCGv temp = tcg_temp_new();
-    tcg_gen_addi_tl(temp, r2, off);
-    tcg_gen_qemu_st_tl(r1, temp, ctx->mem_idx, mop);
-    tcg_gen_mov_tl(r2, temp);
+    tcg_gen_addi_i32(temp, r2, off);
+    tcg_gen_qemu_st_i32(r1, temp, ctx->mem_idx, mop);
+    tcg_gen_mov_i32(r2, temp);
 }
 
 static void gen_ld_preincr(DisasContext *ctx, TCGv r1, TCGv r2, int16_t off,
                            MemOp mop)
 {
     TCGv temp = tcg_temp_new();
-    tcg_gen_addi_tl(temp, r2, off);
-    tcg_gen_qemu_ld_tl(r1, temp, ctx->mem_idx, mop);
-    tcg_gen_mov_tl(r2, temp);
+    tcg_gen_addi_i32(temp, r2, off);
+    tcg_gen_qemu_ld_i32(r1, temp, ctx->mem_idx, mop);
+    tcg_gen_mov_i32(r2, temp);
 }
 
 /* M(EA, word) = (M(EA, word) & ~E[a][63:32]) | (E[a][31:0] & E[a][63:32]); */
@@ -285,15 +285,15 @@ static void gen_ldmst(DisasContext *ctx, int ereg, TCGv ea)
 
     CHECK_REG_PAIR(ereg);
     /* temp = (M(EA, word) */
-    tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_qemu_ld_i32(temp, ea, ctx->mem_idx, MO_LEUL);
     /* temp = temp & ~E[a][63:32]) */
-    tcg_gen_andc_tl(temp, temp, cpu_gpr_d[ereg+1]);
+    tcg_gen_andc_i32(temp, temp, cpu_gpr_d[ereg + 1]);
     /* temp2 = (E[a][31:0] & E[a][63:32]); */
-    tcg_gen_and_tl(temp2, cpu_gpr_d[ereg], cpu_gpr_d[ereg+1]);
+    tcg_gen_and_i32(temp2, cpu_gpr_d[ereg], cpu_gpr_d[ereg + 1]);
     /* temp = temp | temp2; */
-    tcg_gen_or_tl(temp, temp, temp2);
+    tcg_gen_or_i32(temp, temp, temp2);
     /* M(EA, word) = temp; */
-    tcg_gen_qemu_st_tl(temp, ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_qemu_st_i32(temp, ea, ctx->mem_idx, MO_LEUL);
 }
 
 /* tmp = M(EA, word);
@@ -303,9 +303,9 @@ static void gen_swap(DisasContext *ctx, int reg, TCGv ea)
 {
     TCGv temp = tcg_temp_new();
 
-    tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
-    tcg_gen_qemu_st_tl(cpu_gpr_d[reg], ea, ctx->mem_idx, MO_LEUL);
-    tcg_gen_mov_tl(cpu_gpr_d[reg], temp);
+    tcg_gen_qemu_ld_i32(temp, ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_qemu_st_i32(cpu_gpr_d[reg], ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_mov_i32(cpu_gpr_d[reg], temp);
 }
 
 static void gen_cmpswap(DisasContext *ctx, int reg, TCGv ea)
@@ -313,11 +313,11 @@ static void gen_cmpswap(DisasContext *ctx, int reg, TCGv ea)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     CHECK_REG_PAIR(reg);
-    tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
-    tcg_gen_movcond_tl(TCG_COND_EQ, temp2, cpu_gpr_d[reg+1], temp,
+    tcg_gen_qemu_ld_i32(temp, ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_movcond_i32(TCG_COND_EQ, temp2, cpu_gpr_d[reg + 1], temp,
                        cpu_gpr_d[reg], temp);
-    tcg_gen_qemu_st_tl(temp2, ea, ctx->mem_idx, MO_LEUL);
-    tcg_gen_mov_tl(cpu_gpr_d[reg], temp);
+    tcg_gen_qemu_st_i32(temp2, ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_mov_i32(cpu_gpr_d[reg], temp);
 }
 
 static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
@@ -326,12 +326,12 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
     TCGv temp2 = tcg_temp_new();
     TCGv temp3 = tcg_temp_new();
     CHECK_REG_PAIR(reg);
-    tcg_gen_qemu_ld_tl(temp, ea, ctx->mem_idx, MO_LEUL);
-    tcg_gen_and_tl(temp2, cpu_gpr_d[reg], cpu_gpr_d[reg+1]);
-    tcg_gen_andc_tl(temp3, temp, cpu_gpr_d[reg+1]);
-    tcg_gen_or_tl(temp2, temp2, temp3);
-    tcg_gen_qemu_st_tl(temp2, ea, ctx->mem_idx, MO_LEUL);
-    tcg_gen_mov_tl(cpu_gpr_d[reg], temp);
+    tcg_gen_qemu_ld_i32(temp, ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_and_i32(temp2, cpu_gpr_d[reg], cpu_gpr_d[reg + 1]);
+    tcg_gen_andc_i32(temp3, temp, cpu_gpr_d[reg + 1]);
+    tcg_gen_or_i32(temp2, temp2, temp3);
+    tcg_gen_qemu_st_i32(temp2, ea, ctx->mem_idx, MO_LEUL);
+    tcg_gen_mov_i32(cpu_gpr_d[reg], temp);
 }
 
 /* We generate loads and store to core special function register (csfr) through
@@ -341,7 +341,7 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
 #define R(ADDRESS, REG, FEATURE)                                         \
     case ADDRESS:                                                        \
         if (has_feature(ctx, FEATURE)) {                             \
-            tcg_gen_ld_tl(ret, tcg_env, offsetof(CPUTriCoreState, REG)); \
+            tcg_gen_ld_i32(ret, tcg_env, offsetof(CPUTriCoreState, REG)); \
         }                                                                \
         break;
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)
@@ -366,7 +366,7 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)                \
     case ADDRESS:                                                        \
         if (has_feature(ctx, FEATURE)) {                             \
-            tcg_gen_st_tl(r1, tcg_env, offsetof(CPUTriCoreState, REG));  \
+            tcg_gen_st_i32(r1, tcg_env, offsetof(CPUTriCoreState, REG)); \
         }                                                                \
         break;
 /* Endinit protected registers
@@ -399,20 +399,20 @@ static inline void gen_add_d(TCGv ret, TCGv r1, TCGv r2)
     TCGv t0 = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
     /* Addition and set V/SV bits */
-    tcg_gen_add_tl(result, r1, r2);
+    tcg_gen_add_i32(result, r1, r2);
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, result, r1);
-    tcg_gen_xor_tl(t0, r1, r2);
-    tcg_gen_andc_tl(cpu_PSW_V, cpu_PSW_V, t0);
+    tcg_gen_xor_i32(cpu_PSW_V, result, r1);
+    tcg_gen_xor_i32(t0, r1, r2);
+    tcg_gen_andc_i32(cpu_PSW_V, cpu_PSW_V, t0);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, result, result);
-    tcg_gen_xor_tl(cpu_PSW_AV, result, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, result, result);
+    tcg_gen_xor_i32(cpu_PSW_AV, result, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, result);
+    tcg_gen_mov_i32(ret, result);
 }
 
 static inline void
@@ -430,13 +430,13 @@ gen_add64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
     tcg_gen_andc_i64(t1, t1, t0);
     tcg_gen_extrh_i64_i32(cpu_PSW_V, t1);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* calc AV/SAV bits */
     tcg_gen_extrh_i64_i32(temp, result);
-    tcg_gen_add_tl(cpu_PSW_AV, temp, temp);
-    tcg_gen_xor_tl(cpu_PSW_AV, temp, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, temp, temp);
+    tcg_gen_xor_i32(cpu_PSW_AV, temp, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
     tcg_gen_mov_i64(ret, result);
 }
@@ -453,38 +453,38 @@ gen_addsub64_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
 
     (*op1)(temp, r1_low, r2);
     /* calc V0 bit */
-    tcg_gen_xor_tl(temp2, temp, r1_low);
-    tcg_gen_xor_tl(temp3, r1_low, r2);
+    tcg_gen_xor_i32(temp2, temp, r1_low);
+    tcg_gen_xor_i32(temp3, r1_low, r2);
     if (op1 == tcg_gen_add_tl) {
-        tcg_gen_andc_tl(temp2, temp2, temp3);
+        tcg_gen_andc_i32(temp2, temp2, temp3);
     } else {
-        tcg_gen_and_tl(temp2, temp2, temp3);
+        tcg_gen_and_i32(temp2, temp2, temp3);
     }
 
     (*op2)(temp3, r1_high, r3);
     /* calc V1 bit */
-    tcg_gen_xor_tl(cpu_PSW_V, temp3, r1_high);
-    tcg_gen_xor_tl(temp4, r1_high, r3);
+    tcg_gen_xor_i32(cpu_PSW_V, temp3, r1_high);
+    tcg_gen_xor_i32(temp4, r1_high, r3);
     if (op2 == tcg_gen_add_tl) {
-        tcg_gen_andc_tl(cpu_PSW_V, cpu_PSW_V, temp4);
+        tcg_gen_andc_i32(cpu_PSW_V, cpu_PSW_V, temp4);
     } else {
-        tcg_gen_and_tl(cpu_PSW_V, cpu_PSW_V, temp4);
+        tcg_gen_and_i32(cpu_PSW_V, cpu_PSW_V, temp4);
     }
     /* combine V0/V1 bits */
-    tcg_gen_or_tl(cpu_PSW_V, cpu_PSW_V, temp2);
+    tcg_gen_or_i32(cpu_PSW_V, cpu_PSW_V, temp2);
     /* calc sv bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* write result */
-    tcg_gen_mov_tl(ret_low, temp);
-    tcg_gen_mov_tl(ret_high, temp3);
+    tcg_gen_mov_i32(ret_low, temp);
+    tcg_gen_mov_i32(ret_high, temp3);
     /* calc AV bit */
-    tcg_gen_add_tl(temp, ret_low, ret_low);
-    tcg_gen_xor_tl(temp, temp, ret_low);
-    tcg_gen_add_tl(cpu_PSW_AV, ret_high, ret_high);
-    tcg_gen_xor_tl(cpu_PSW_AV, cpu_PSW_AV, ret_high);
-    tcg_gen_or_tl(cpu_PSW_AV, cpu_PSW_AV, temp);
+    tcg_gen_add_i32(temp, ret_low, ret_low);
+    tcg_gen_xor_i32(temp, temp, ret_low);
+    tcg_gen_add_i32(cpu_PSW_AV, ret_high, ret_high);
+    tcg_gen_xor_i32(cpu_PSW_AV, cpu_PSW_AV, ret_high);
+    tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 /* ret = r2 + (r1 * r3); */
@@ -509,14 +509,14 @@ static inline void gen_madd32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
     tcg_gen_setcondi_i64(TCG_COND_LT, t2, t1, -0x80000000LL);
     tcg_gen_or_i64(t2, t2, t3);
     tcg_gen_extrl_i64_i32(cpu_PSW_V, t2);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, ret, ret);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret, ret);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void gen_maddi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
@@ -534,23 +534,23 @@ gen_madd64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     TCGv t3 = tcg_temp_new();
     TCGv t4 = tcg_temp_new();
 
-    tcg_gen_muls2_tl(t1, t2, r1, r3);
+    tcg_gen_muls2_i32(t1, t2, r1, r3);
     /* only the add can overflow */
-    tcg_gen_add2_tl(t3, t4, r2_low, r2_high, t1, t2);
+    tcg_gen_add2_i32(t3, t4, r2_low, r2_high, t1, t2);
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, t4, r2_high);
-    tcg_gen_xor_tl(t1, r2_high, t2);
-    tcg_gen_andc_tl(cpu_PSW_V, cpu_PSW_V, t1);
+    tcg_gen_xor_i32(cpu_PSW_V, t4, r2_high);
+    tcg_gen_xor_i32(t1, r2_high, t2);
+    tcg_gen_andc_i32(cpu_PSW_V, cpu_PSW_V, t1);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, t4, t4);
-    tcg_gen_xor_tl(cpu_PSW_AV, t4, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, t4, t4);
+    tcg_gen_xor_i32(cpu_PSW_AV, t4, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back the result */
-    tcg_gen_mov_tl(ret_low, t3);
-    tcg_gen_mov_tl(ret_high, t4);
+    tcg_gen_mov_i32(ret_low, t3);
+    tcg_gen_mov_i32(ret_high, t4);
 }
 
 static inline void
@@ -573,14 +573,14 @@ gen_maddu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
        calc V bit */
     tcg_gen_setcond_i64(TCG_COND_LTU, t2, t2, t1);
     tcg_gen_extrl_i64_i32(cpu_PSW_V, t2);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, ret_high, ret_high);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret_high, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret_high, ret_high);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret_high, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void
@@ -714,13 +714,13 @@ gen_madds_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     }
     tcg_gen_extr_i64_i32(temp, temp2, temp64);
     gen_adds(ret_low, r1_low, temp);
-    tcg_gen_mov_tl(temp, cpu_PSW_V);
-    tcg_gen_mov_tl(temp3, cpu_PSW_AV);
+    tcg_gen_mov_i32(temp, cpu_PSW_V);
+    tcg_gen_mov_i32(temp3, cpu_PSW_AV);
     gen_adds(ret_high, r1_high, temp2);
     /* combine v bits */
-    tcg_gen_or_tl(cpu_PSW_V, cpu_PSW_V, temp);
+    tcg_gen_or_i32(cpu_PSW_V, cpu_PSW_V, temp);
     /* combine av bits */
-    tcg_gen_or_tl(cpu_PSW_AV, cpu_PSW_AV, temp3);
+    tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
 static inline void gen_subs(TCGv ret, TCGv r1, TCGv r2);
@@ -751,13 +751,13 @@ gen_maddsus_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     }
     tcg_gen_extr_i64_i32(temp, temp2, temp64);
     gen_subs(ret_low, r1_low, temp);
-    tcg_gen_mov_tl(temp, cpu_PSW_V);
-    tcg_gen_mov_tl(temp3, cpu_PSW_AV);
+    tcg_gen_mov_i32(temp, cpu_PSW_V);
+    tcg_gen_mov_i32(temp3, cpu_PSW_AV);
     gen_adds(ret_high, r1_high, temp2);
     /* combine v bits */
-    tcg_gen_or_tl(cpu_PSW_V, cpu_PSW_V, temp);
+    tcg_gen_or_i32(cpu_PSW_V, cpu_PSW_V, temp);
     /* combine av bits */
-    tcg_gen_or_tl(cpu_PSW_AV, cpu_PSW_AV, temp3);
+    tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
 static inline void
@@ -876,8 +876,8 @@ gen_maddr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_maddr64_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
@@ -902,8 +902,8 @@ gen_maddsur32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
         GEN_HELPER_UU(mul_h, temp64, r2, r3, t_n);
         break;
     }
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_helper_addsur_h(ret, tcg_env, temp64, temp, temp2);
 }
 
@@ -937,8 +937,8 @@ gen_maddr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_maddr64s_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
@@ -963,8 +963,8 @@ gen_maddsur32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
         GEN_HELPER_UU(mul_h, temp64, r2, r3, t_n);
         break;
     }
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_helper_addsur_h_ssov(ret, tcg_env, temp64, temp, temp2);
 }
 
@@ -1009,27 +1009,27 @@ gen_madd32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     tcg_gen_setcondi_i64(TCG_COND_LT, t2, t3, -0x80000000LL);
     tcg_gen_or_i64(t1, t1, t2);
     tcg_gen_extrl_i64_i32(cpu_PSW_V, t1);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
     /* We produce an overflow on the host if the mul before was
        (0x80000000 * 0x80000000) << 1). If this is the
        case, we negate the ovf. */
     if (n == 1) {
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp, arg2, 0x80000000);
-        tcg_gen_setcond_tl(TCG_COND_EQ, temp2, arg2, arg3);
-        tcg_gen_and_tl(temp, temp, temp2);
-        tcg_gen_shli_tl(temp, temp, 31);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp, arg2, 0x80000000);
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp2, arg2, arg3);
+        tcg_gen_and_i32(temp, temp, temp2);
+        tcg_gen_shli_i32(temp, temp, 31);
         /* negate v bit, if special condition */
-        tcg_gen_xor_tl(cpu_PSW_V, cpu_PSW_V, temp);
+        tcg_gen_xor_i32(cpu_PSW_V, cpu_PSW_V, temp);
     }
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, temp3, temp3);
-    tcg_gen_xor_tl(cpu_PSW_AV, temp3, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, temp3, temp3);
+    tcg_gen_xor_i32(cpu_PSW_AV, temp3, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, temp3);
+    tcg_gen_mov_i32(ret, temp3);
 }
 
 static inline void
@@ -1038,13 +1038,13 @@ gen_m16add32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     gen_add_d(ret, arg1, temp);
 }
@@ -1055,13 +1055,13 @@ gen_m16adds32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     gen_adds(ret, arg1, temp);
 }
@@ -1077,13 +1077,13 @@ gen_m16add64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     TCGv_i64 t3 = tcg_temp_new_i64();
 
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     tcg_gen_ext_i32_i64(t2, temp);
     tcg_gen_shli_i64(t2, t2, 16);
@@ -1103,13 +1103,13 @@ gen_m16adds64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     TCGv_i64 t2 = tcg_temp_new_i64();
 
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     tcg_gen_ext_i32_i64(t2, temp);
     tcg_gen_shli_i64(t2, t2, 16);
@@ -1149,22 +1149,22 @@ gen_madd64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     if (n == 1) {
         temp = tcg_temp_new();
         temp2 = tcg_temp_new();
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp, arg2, 0x80000000);
-        tcg_gen_setcond_tl(TCG_COND_EQ, temp2, arg2, arg3);
-        tcg_gen_and_tl(temp, temp, temp2);
-        tcg_gen_shli_tl(temp, temp, 31);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp, arg2, 0x80000000);
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp2, arg2, arg3);
+        tcg_gen_and_i32(temp, temp, temp2);
+        tcg_gen_shli_i32(temp, temp, 31);
         /* negate v bit, if special condition */
-        tcg_gen_xor_tl(cpu_PSW_V, cpu_PSW_V, temp);
+        tcg_gen_xor_i32(cpu_PSW_V, cpu_PSW_V, temp);
     }
     /* write back result */
     tcg_gen_extr_i64_i32(rl, rh, t4);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, rh, rh);
-    tcg_gen_xor_tl(cpu_PSW_AV, rh, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, rh, rh);
+    tcg_gen_xor_i32(cpu_PSW_AV, rh, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void
@@ -1219,15 +1219,15 @@ static inline void gen_msub32_d(TCGv ret, TCGv r1, TCGv r2, TCGv r3)
     tcg_gen_setcondi_i64(TCG_COND_LT, t2, t1, -0x80000000LL);
     tcg_gen_or_i64(t2, t2, t3);
     tcg_gen_extrl_i64_i32(cpu_PSW_V, t2);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
 
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, ret, ret);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret, ret);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void gen_msubi32_d(TCGv ret, TCGv r1, TCGv r2, int32_t con)
@@ -1245,23 +1245,23 @@ gen_msub64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     TCGv t3 = tcg_temp_new();
     TCGv t4 = tcg_temp_new();
 
-    tcg_gen_muls2_tl(t1, t2, r1, r3);
+    tcg_gen_muls2_i32(t1, t2, r1, r3);
     /* only the sub can overflow */
-    tcg_gen_sub2_tl(t3, t4, r2_low, r2_high, t1, t2);
+    tcg_gen_sub2_i32(t3, t4, r2_low, r2_high, t1, t2);
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, t4, r2_high);
-    tcg_gen_xor_tl(t1, r2_high, t2);
-    tcg_gen_and_tl(cpu_PSW_V, cpu_PSW_V, t1);
+    tcg_gen_xor_i32(cpu_PSW_V, t4, r2_high);
+    tcg_gen_xor_i32(t1, r2_high, t2);
+    tcg_gen_and_i32(cpu_PSW_V, cpu_PSW_V, t1);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, t4, t4);
-    tcg_gen_xor_tl(cpu_PSW_AV, t4, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, t4, t4);
+    tcg_gen_xor_i32(cpu_PSW_AV, t4, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back the result */
-    tcg_gen_mov_tl(ret_low, t3);
-    tcg_gen_mov_tl(ret_high, t4);
+    tcg_gen_mov_i32(ret_low, t3);
+    tcg_gen_mov_i32(ret_high, t4);
 }
 
 static inline void
@@ -1290,14 +1290,14 @@ gen_msubu64_d(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
     /* calc V bit, only the sub can overflow, if t1 > t2 */
     tcg_gen_setcond_i64(TCG_COND_GTU, t1, t1, t2);
     tcg_gen_extrl_i64_i32(cpu_PSW_V, t1);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, ret_high, ret_high);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret_high, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret_high, ret_high);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret_high, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void
@@ -1320,22 +1320,22 @@ static inline void gen_add_CC(TCGv ret, TCGv r1, TCGv r2)
     TCGv t0    = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
 
-    tcg_gen_movi_tl(t0, 0);
+    tcg_gen_movi_i32(t0, 0);
     /* Addition and set C/V/SV bits */
     tcg_gen_add2_i32(result, cpu_PSW_C, r1, t0, r2, t0);
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, result, r1);
-    tcg_gen_xor_tl(t0, r1, r2);
-    tcg_gen_andc_tl(cpu_PSW_V, cpu_PSW_V, t0);
+    tcg_gen_xor_i32(cpu_PSW_V, result, r1);
+    tcg_gen_xor_i32(t0, r1, r2);
+    tcg_gen_andc_i32(cpu_PSW_V, cpu_PSW_V, t0);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, result, result);
-    tcg_gen_xor_tl(cpu_PSW_AV, result, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, result, result);
+    tcg_gen_xor_i32(cpu_PSW_AV, result, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, result);
+    tcg_gen_mov_i32(ret, result);
 }
 
 static inline void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
@@ -1352,18 +1352,18 @@ static inline void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
     /* Addition, carry and set C/V/SV bits */
     tcg_gen_addcio_i32(result, cpu_PSW_C, r1, r2, cpu_PSW_C);
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, result, r1);
-    tcg_gen_xor_tl(t0, r1, r2);
-    tcg_gen_andc_tl(cpu_PSW_V, cpu_PSW_V, t0);
+    tcg_gen_xor_i32(cpu_PSW_V, result, r1);
+    tcg_gen_xor_i32(t0, r1, r2);
+    tcg_gen_andc_i32(cpu_PSW_V, cpu_PSW_V, t0);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, result, result);
-    tcg_gen_xor_tl(cpu_PSW_AV, result, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, result, result);
+    tcg_gen_xor_i32(cpu_PSW_AV, result, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, result);
+    tcg_gen_mov_i32(ret, result);
 }
 
 static inline void gen_addci_CC(TCGv ret, TCGv r1, int32_t con)
@@ -1382,27 +1382,27 @@ static inline void gen_cond_add(TCGCond cond, TCGv r1, TCGv r2, TCGv r3,
     TCGv t0 = tcg_constant_i32(0);
 
     /* create mask for sticky bits */
-    tcg_gen_setcond_tl(cond, mask, r4, t0);
-    tcg_gen_shli_tl(mask, mask, 31);
+    tcg_gen_setcond_i32(cond, mask, r4, t0);
+    tcg_gen_shli_i32(mask, mask, 31);
 
-    tcg_gen_add_tl(result, r1, r2);
+    tcg_gen_add_i32(result, r1, r2);
     /* Calc PSW_V */
-    tcg_gen_xor_tl(temp, result, r1);
-    tcg_gen_xor_tl(temp2, r1, r2);
-    tcg_gen_andc_tl(temp, temp, temp2);
-    tcg_gen_movcond_tl(cond, cpu_PSW_V, r4, t0, temp, cpu_PSW_V);
+    tcg_gen_xor_i32(temp, result, r1);
+    tcg_gen_xor_i32(temp2, r1, r2);
+    tcg_gen_andc_i32(temp, temp, temp2);
+    tcg_gen_movcond_i32(cond, cpu_PSW_V, r4, t0, temp, cpu_PSW_V);
     /* Set PSW_SV */
-    tcg_gen_and_tl(temp, temp, mask);
-    tcg_gen_or_tl(cpu_PSW_SV, temp, cpu_PSW_SV);
+    tcg_gen_and_i32(temp, temp, mask);
+    tcg_gen_or_i32(cpu_PSW_SV, temp, cpu_PSW_SV);
     /* calc AV bit */
-    tcg_gen_add_tl(temp, result, result);
-    tcg_gen_xor_tl(temp, temp, result);
-    tcg_gen_movcond_tl(cond, cpu_PSW_AV, r4, t0, temp, cpu_PSW_AV);
+    tcg_gen_add_i32(temp, result, result);
+    tcg_gen_xor_i32(temp, temp, result);
+    tcg_gen_movcond_i32(cond, cpu_PSW_AV, r4, t0, temp, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_and_tl(temp, temp, mask);
-    tcg_gen_or_tl(cpu_PSW_SAV, temp, cpu_PSW_SAV);
+    tcg_gen_and_i32(temp, temp, mask);
+    tcg_gen_or_i32(cpu_PSW_SAV, temp, cpu_PSW_SAV);
     /* write back result */
-    tcg_gen_movcond_tl(cond, r3, r4, t0, result, r1);
+    tcg_gen_movcond_i32(cond, r3, r4, t0, result, r1);
 }
 
 static inline void gen_condi_add(TCGCond cond, TCGv r1, int32_t r2,
@@ -1417,20 +1417,20 @@ static inline void gen_sub_d(TCGv ret, TCGv r1, TCGv r2)
     TCGv temp = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
 
-    tcg_gen_sub_tl(result, r1, r2);
+    tcg_gen_sub_i32(result, r1, r2);
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, result, r1);
-    tcg_gen_xor_tl(temp, r1, r2);
-    tcg_gen_and_tl(cpu_PSW_V, cpu_PSW_V, temp);
+    tcg_gen_xor_i32(cpu_PSW_V, result, r1);
+    tcg_gen_xor_i32(temp, r1, r2);
+    tcg_gen_and_i32(cpu_PSW_V, cpu_PSW_V, temp);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV bit */
-    tcg_gen_add_tl(cpu_PSW_AV, result, result);
-    tcg_gen_xor_tl(cpu_PSW_AV, result, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, result, result);
+    tcg_gen_xor_i32(cpu_PSW_AV, result, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, result);
+    tcg_gen_mov_i32(ret, result);
 }
 
 static inline void
@@ -1448,13 +1448,13 @@ gen_sub64_d(TCGv_i64 ret, TCGv_i64 r1, TCGv_i64 r2)
     tcg_gen_and_i64(t1, t1, t0);
     tcg_gen_extrh_i64_i32(cpu_PSW_V, t1);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* calc AV/SAV bits */
     tcg_gen_extrh_i64_i32(temp, result);
-    tcg_gen_add_tl(cpu_PSW_AV, temp, temp);
-    tcg_gen_xor_tl(cpu_PSW_AV, temp, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, temp, temp);
+    tcg_gen_xor_i32(cpu_PSW_AV, temp, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
     tcg_gen_mov_i64(ret, result);
 }
@@ -1464,28 +1464,28 @@ static inline void gen_sub_CC(TCGv ret, TCGv r1, TCGv r2)
     TCGv result = tcg_temp_new();
     TCGv temp = tcg_temp_new();
 
-    tcg_gen_sub_tl(result, r1, r2);
+    tcg_gen_sub_i32(result, r1, r2);
     /* calc C bit */
-    tcg_gen_setcond_tl(TCG_COND_GEU, cpu_PSW_C, r1, r2);
+    tcg_gen_setcond_i32(TCG_COND_GEU, cpu_PSW_C, r1, r2);
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, result, r1);
-    tcg_gen_xor_tl(temp, r1, r2);
-    tcg_gen_and_tl(cpu_PSW_V, cpu_PSW_V, temp);
+    tcg_gen_xor_i32(cpu_PSW_V, result, r1);
+    tcg_gen_xor_i32(temp, r1, r2);
+    tcg_gen_and_i32(cpu_PSW_V, cpu_PSW_V, temp);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV bit */
-    tcg_gen_add_tl(cpu_PSW_AV, result, result);
-    tcg_gen_xor_tl(cpu_PSW_AV, result, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, result, result);
+    tcg_gen_xor_i32(cpu_PSW_AV, result, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, result);
+    tcg_gen_mov_i32(ret, result);
 }
 
 static inline void gen_subc_CC(TCGv ret, TCGv r1, TCGv r2)
 {
     TCGv temp = tcg_temp_new();
-    tcg_gen_not_tl(temp, r2);
+    tcg_gen_not_i32(temp, r2);
     gen_addc_CC(ret, r1, temp);
 }
 
@@ -1499,27 +1499,27 @@ static inline void gen_cond_sub(TCGCond cond, TCGv r1, TCGv r2, TCGv r3,
     TCGv t0 = tcg_constant_i32(0);
 
     /* create mask for sticky bits */
-    tcg_gen_setcond_tl(cond, mask, r4, t0);
-    tcg_gen_shli_tl(mask, mask, 31);
+    tcg_gen_setcond_i32(cond, mask, r4, t0);
+    tcg_gen_shli_i32(mask, mask, 31);
 
-    tcg_gen_sub_tl(result, r1, r2);
+    tcg_gen_sub_i32(result, r1, r2);
     /* Calc PSW_V */
-    tcg_gen_xor_tl(temp, result, r1);
-    tcg_gen_xor_tl(temp2, r1, r2);
-    tcg_gen_and_tl(temp, temp, temp2);
-    tcg_gen_movcond_tl(cond, cpu_PSW_V, r4, t0, temp, cpu_PSW_V);
+    tcg_gen_xor_i32(temp, result, r1);
+    tcg_gen_xor_i32(temp2, r1, r2);
+    tcg_gen_and_i32(temp, temp, temp2);
+    tcg_gen_movcond_i32(cond, cpu_PSW_V, r4, t0, temp, cpu_PSW_V);
     /* Set PSW_SV */
-    tcg_gen_and_tl(temp, temp, mask);
-    tcg_gen_or_tl(cpu_PSW_SV, temp, cpu_PSW_SV);
+    tcg_gen_and_i32(temp, temp, mask);
+    tcg_gen_or_i32(cpu_PSW_SV, temp, cpu_PSW_SV);
     /* calc AV bit */
-    tcg_gen_add_tl(temp, result, result);
-    tcg_gen_xor_tl(temp, temp, result);
-    tcg_gen_movcond_tl(cond, cpu_PSW_AV, r4, t0, temp, cpu_PSW_AV);
+    tcg_gen_add_i32(temp, result, result);
+    tcg_gen_xor_i32(temp, temp, result);
+    tcg_gen_movcond_i32(cond, cpu_PSW_AV, r4, t0, temp, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_and_tl(temp, temp, mask);
-    tcg_gen_or_tl(cpu_PSW_SAV, temp, cpu_PSW_SAV);
+    tcg_gen_and_i32(temp, temp, mask);
+    tcg_gen_or_i32(cpu_PSW_SAV, temp, cpu_PSW_SAV);
     /* write back result */
-    tcg_gen_movcond_tl(cond, r3, r4, t0, result, r1);
+    tcg_gen_movcond_i32(cond, r3, r4, t0, result, r1);
 }
 
 static inline void
@@ -1575,13 +1575,13 @@ gen_msubs_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     }
     tcg_gen_extr_i64_i32(temp, temp2, temp64);
     gen_subs(ret_low, r1_low, temp);
-    tcg_gen_mov_tl(temp, cpu_PSW_V);
-    tcg_gen_mov_tl(temp3, cpu_PSW_AV);
+    tcg_gen_mov_i32(temp, cpu_PSW_V);
+    tcg_gen_mov_i32(temp3, cpu_PSW_AV);
     gen_subs(ret_high, r1_high, temp2);
     /* combine v bits */
-    tcg_gen_or_tl(cpu_PSW_V, cpu_PSW_V, temp);
+    tcg_gen_or_i32(cpu_PSW_V, cpu_PSW_V, temp);
     /* combine av bits */
-    tcg_gen_or_tl(cpu_PSW_AV, cpu_PSW_AV, temp3);
+    tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
 static inline void
@@ -1667,8 +1667,8 @@ gen_msubr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_msubr64_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
@@ -1701,8 +1701,8 @@ gen_msubr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_msubr64s_h(ret, temp, temp2, r2, r3, n, mode);
 }
 
@@ -1749,16 +1749,16 @@ gen_msub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n,
     tcg_gen_setcondi_i64(TCG_COND_LT, t2, t3, -0x80000000LL);
     tcg_gen_or_i64(t1, t1, t2);
     tcg_gen_extrl_i64_i32(cpu_PSW_V, t1);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, temp3, temp3);
-    tcg_gen_xor_tl(cpu_PSW_AV, temp3, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, temp3, temp3);
+    tcg_gen_xor_i32(cpu_PSW_AV, temp3, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, temp3);
+    tcg_gen_mov_i32(ret, temp3);
 }
 
 static inline void
@@ -1767,13 +1767,13 @@ gen_m16sub32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     gen_sub_d(ret, arg1, temp);
 }
@@ -1784,13 +1784,13 @@ gen_m16subs32_q(TCGv ret, TCGv arg1, TCGv arg2, TCGv arg3, uint32_t n)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     gen_subs(ret, arg1, temp);
 }
@@ -1806,13 +1806,13 @@ gen_m16sub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     TCGv_i64 t3 = tcg_temp_new_i64();
 
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     tcg_gen_ext_i32_i64(t2, temp);
     tcg_gen_shli_i64(t2, t2, 16);
@@ -1832,13 +1832,13 @@ gen_m16subs64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     TCGv_i64 t2 = tcg_temp_new_i64();
 
     if (n == 0) {
-        tcg_gen_mul_tl(temp, arg2, arg3);
+        tcg_gen_mul_i32(temp, arg2, arg3);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(temp, arg2, arg3);
-        tcg_gen_shli_tl(temp, temp, 1);
+        tcg_gen_mul_i32(temp, arg2, arg3);
+        tcg_gen_shli_i32(temp, temp, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, temp, 0x80000000);
-        tcg_gen_sub_tl(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, temp, 0x80000000);
+        tcg_gen_sub_i32(temp, temp, temp2);
     }
     tcg_gen_ext_i32_i64(t2, temp);
     tcg_gen_shli_i64(t2, t2, 16);
@@ -1878,22 +1878,22 @@ gen_msub64_q(TCGv rl, TCGv rh, TCGv arg1_low, TCGv arg1_high, TCGv arg2,
     if (n == 1) {
         temp = tcg_temp_new();
         temp2 = tcg_temp_new();
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp, arg2, 0x80000000);
-        tcg_gen_setcond_tl(TCG_COND_EQ, temp2, arg2, arg3);
-        tcg_gen_and_tl(temp, temp, temp2);
-        tcg_gen_shli_tl(temp, temp, 31);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp, arg2, 0x80000000);
+        tcg_gen_setcond_i32(TCG_COND_EQ, temp2, arg2, arg3);
+        tcg_gen_and_i32(temp, temp, temp2);
+        tcg_gen_shli_i32(temp, temp, 31);
         /* negate v bit, if special condition */
-        tcg_gen_xor_tl(cpu_PSW_V, cpu_PSW_V, temp);
+        tcg_gen_xor_i32(cpu_PSW_V, cpu_PSW_V, temp);
     }
     /* write back result */
     tcg_gen_extr_i64_i32(rl, rh, t4);
     /* Calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV/SAV bits */
-    tcg_gen_add_tl(cpu_PSW_AV, rh, rh);
-    tcg_gen_xor_tl(cpu_PSW_AV, rh, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, rh, rh);
+    tcg_gen_xor_i32(cpu_PSW_AV, rh, cpu_PSW_AV);
     /* calc SAV */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void
@@ -2012,8 +2012,8 @@ gen_msubadr32_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
         GEN_HELPER_UU(mul_h, temp64, r2, r3, t_n);
         break;
     }
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_helper_subadr_h(ret, tcg_env, temp64, temp, temp2);
 }
 
@@ -2043,13 +2043,13 @@ gen_msubads_h(TCGv ret_low, TCGv ret_high, TCGv r1_low, TCGv r1_high, TCGv r2,
     }
     tcg_gen_extr_i64_i32(temp, temp2, temp64);
     gen_adds(ret_low, r1_low, temp);
-    tcg_gen_mov_tl(temp, cpu_PSW_V);
-    tcg_gen_mov_tl(temp3, cpu_PSW_AV);
+    tcg_gen_mov_i32(temp, cpu_PSW_V);
+    tcg_gen_mov_i32(temp3, cpu_PSW_AV);
     gen_subs(ret_high, r1_high, temp2);
     /* combine v bits */
-    tcg_gen_or_tl(cpu_PSW_V, cpu_PSW_V, temp);
+    tcg_gen_or_i32(cpu_PSW_V, cpu_PSW_V, temp);
     /* combine av bits */
-    tcg_gen_or_tl(cpu_PSW_AV, cpu_PSW_AV, temp3);
+    tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp3);
 }
 
 static inline void
@@ -2105,24 +2105,24 @@ gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
         GEN_HELPER_UU(mul_h, temp64, r2, r3, t_n);
         break;
     }
-    tcg_gen_andi_tl(temp2, r1, 0xffff0000);
-    tcg_gen_shli_tl(temp, r1, 16);
+    tcg_gen_andi_i32(temp2, r1, 0xffff0000);
+    tcg_gen_shli_i32(temp, r1, 16);
     gen_helper_subadr_h_ssov(ret, tcg_env, temp64, temp, temp2);
 }
 
 static inline void gen_abs(TCGv ret, TCGv r1)
 {
-    tcg_gen_abs_tl(ret, r1);
+    tcg_gen_abs_i32(ret, r1);
     /* overflow can only happen, if r1 = 0x80000000 */
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, r1, 0x80000000);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_PSW_V, r1, 0x80000000);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV bit */
-    tcg_gen_add_tl(cpu_PSW_AV, ret, ret);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret, ret);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
@@ -2130,25 +2130,25 @@ static inline void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
     TCGv temp = tcg_temp_new_i32();
     TCGv result = tcg_temp_new_i32();
 
-    tcg_gen_sub_tl(result, r1, r2);
-    tcg_gen_sub_tl(temp, r2, r1);
-    tcg_gen_movcond_tl(TCG_COND_GT, result, r1, r2, result, temp);
+    tcg_gen_sub_i32(result, r1, r2);
+    tcg_gen_sub_i32(temp, r2, r1);
+    tcg_gen_movcond_i32(TCG_COND_GT, result, r1, r2, result, temp);
 
     /* calc V bit */
-    tcg_gen_xor_tl(cpu_PSW_V, result, r1);
-    tcg_gen_xor_tl(temp, result, r2);
-    tcg_gen_movcond_tl(TCG_COND_GT, cpu_PSW_V, r1, r2, cpu_PSW_V, temp);
-    tcg_gen_xor_tl(temp, r1, r2);
-    tcg_gen_and_tl(cpu_PSW_V, cpu_PSW_V, temp);
+    tcg_gen_xor_i32(cpu_PSW_V, result, r1);
+    tcg_gen_xor_i32(temp, result, r2);
+    tcg_gen_movcond_i32(TCG_COND_GT, cpu_PSW_V, r1, r2, cpu_PSW_V, temp);
+    tcg_gen_xor_i32(temp, r1, r2);
+    tcg_gen_and_i32(cpu_PSW_V, cpu_PSW_V, temp);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV bit */
-    tcg_gen_add_tl(cpu_PSW_AV, result, result);
-    tcg_gen_xor_tl(cpu_PSW_AV, result, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, result, result);
+    tcg_gen_xor_i32(cpu_PSW_AV, result, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* write back result */
-    tcg_gen_mov_tl(ret, result);
+    tcg_gen_mov_i32(ret, result);
 }
 
 static inline void gen_absdifi(TCGv ret, TCGv r1, int32_t con)
@@ -2168,19 +2168,19 @@ static inline void gen_mul_i32s(TCGv ret, TCGv r1, TCGv r2)
     TCGv high = tcg_temp_new();
     TCGv low = tcg_temp_new();
 
-    tcg_gen_muls2_tl(low, high, r1, r2);
-    tcg_gen_mov_tl(ret, low);
+    tcg_gen_muls2_i32(low, high, r1, r2);
+    tcg_gen_mov_i32(ret, low);
     /* calc V bit */
-    tcg_gen_sari_tl(low, low, 31);
-    tcg_gen_setcond_tl(TCG_COND_NE, cpu_PSW_V, high, low);
-    tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+    tcg_gen_sari_i32(low, low, 31);
+    tcg_gen_setcond_i32(TCG_COND_NE, cpu_PSW_V, high, low);
+    tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV bit */
-    tcg_gen_add_tl(cpu_PSW_AV, ret, ret);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret, ret);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void gen_muli_i32s(TCGv ret, TCGv r1, int32_t con)
@@ -2191,16 +2191,16 @@ static inline void gen_muli_i32s(TCGv ret, TCGv r1, int32_t con)
 
 static inline void gen_mul_i64s(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
 {
-    tcg_gen_muls2_tl(ret_low, ret_high, r1, r2);
+    tcg_gen_muls2_i32(ret_low, ret_high, r1, r2);
     /* clear V bit */
-    tcg_gen_movi_tl(cpu_PSW_V, 0);
+    tcg_gen_movi_i32(cpu_PSW_V, 0);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV bit */
-    tcg_gen_add_tl(cpu_PSW_AV, ret_high, ret_high);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret_high, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret_high, ret_high);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret_high, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void gen_muli_i64s(TCGv ret_low, TCGv ret_high, TCGv r1,
@@ -2212,16 +2212,16 @@ static inline void gen_muli_i64s(TCGv ret_low, TCGv ret_high, TCGv r1,
 
 static inline void gen_mul_i64u(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2)
 {
-    tcg_gen_mulu2_tl(ret_low, ret_high, r1, r2);
+    tcg_gen_mulu2_i32(ret_low, ret_high, r1, r2);
     /* clear V bit */
-    tcg_gen_movi_tl(cpu_PSW_V, 0);
+    tcg_gen_movi_i32(cpu_PSW_V, 0);
     /* calc SV bit */
-    tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+    tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     /* Calc AV bit */
-    tcg_gen_add_tl(cpu_PSW_AV, ret_high, ret_high);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret_high, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret_high, ret_high);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret_high, cpu_PSW_AV);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static inline void gen_muli_i64u(TCGv ret_low, TCGv ret_high, TCGv r1,
@@ -2264,7 +2264,7 @@ gen_mul_q(TCGv rl, TCGv rh, TCGv arg1, TCGv arg2, uint32_t n, uint32_t up_shift)
 
     if (n == 0) {
         if (up_shift == 32) {
-            tcg_gen_muls2_tl(rh, rl, arg1, arg2);
+            tcg_gen_muls2_i32(rh, rl, arg1, arg2);
         } else if (up_shift == 16) {
             tcg_gen_ext_i32_i64(temp_64, arg1);
             tcg_gen_ext_i32_i64(temp2_64, arg2);
@@ -2273,10 +2273,10 @@ gen_mul_q(TCGv rl, TCGv rh, TCGv arg1, TCGv arg2, uint32_t n, uint32_t up_shift)
             tcg_gen_shri_i64(temp_64, temp_64, up_shift);
             tcg_gen_extr_i64_i32(rl, rh, temp_64);
         } else {
-            tcg_gen_muls2_tl(rl, rh, arg1, arg2);
+            tcg_gen_muls2_i32(rl, rh, arg1, arg2);
         }
         /* reset v bit */
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
     } else { /* n is expected to be 1 */
         tcg_gen_ext_i32_i64(temp_64, arg1);
         tcg_gen_ext_i32_i64(temp2_64, arg2);
@@ -2291,26 +2291,26 @@ gen_mul_q(TCGv rl, TCGv rh, TCGv arg1, TCGv arg2, uint32_t n, uint32_t up_shift)
         tcg_gen_extr_i64_i32(rl, rh, temp_64);
         /* overflow only occurs if r1 = r2 = 0x8000 */
         if (up_shift == 0) {/* result is 64 bit */
-            tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, rh,
+            tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_PSW_V, rh,
                                 0x80000000);
         } else { /* result is 32 bit */
-            tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, rl,
+            tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_PSW_V, rl,
                                 0x80000000);
         }
-        tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+        tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
         /* calc sv overflow bit */
-        tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+        tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
     }
     /* calc av overflow bit */
     if (up_shift == 0) {
-        tcg_gen_add_tl(cpu_PSW_AV, rh, rh);
-        tcg_gen_xor_tl(cpu_PSW_AV, rh, cpu_PSW_AV);
+        tcg_gen_add_i32(cpu_PSW_AV, rh, rh);
+        tcg_gen_xor_i32(cpu_PSW_AV, rh, cpu_PSW_AV);
     } else {
-        tcg_gen_add_tl(cpu_PSW_AV, rl, rl);
-        tcg_gen_xor_tl(cpu_PSW_AV, rl, cpu_PSW_AV);
+        tcg_gen_add_i32(cpu_PSW_AV, rl, rl);
+        tcg_gen_xor_i32(cpu_PSW_AV, rl, cpu_PSW_AV);
     }
     /* calc sav overflow bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static void
@@ -2318,47 +2318,47 @@ gen_mul_q_16(TCGv ret, TCGv arg1, TCGv arg2, uint32_t n)
 {
     TCGv temp = tcg_temp_new();
     if (n == 0) {
-        tcg_gen_mul_tl(ret, arg1, arg2);
+        tcg_gen_mul_i32(ret, arg1, arg2);
     } else { /* n is expected to be 1 */
-        tcg_gen_mul_tl(ret, arg1, arg2);
-        tcg_gen_shli_tl(ret, ret, 1);
+        tcg_gen_mul_i32(ret, arg1, arg2);
+        tcg_gen_shli_i32(ret, ret, 1);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp, ret, 0x80000000);
-        tcg_gen_sub_tl(ret, ret, temp);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp, ret, 0x80000000);
+        tcg_gen_sub_i32(ret, ret, temp);
     }
     /* reset v bit */
-    tcg_gen_movi_tl(cpu_PSW_V, 0);
+    tcg_gen_movi_i32(cpu_PSW_V, 0);
     /* calc av overflow bit */
-    tcg_gen_add_tl(cpu_PSW_AV, ret, ret);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret, ret);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc sav overflow bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static void gen_mulr_q(TCGv ret, TCGv arg1, TCGv arg2, uint32_t n)
 {
     TCGv temp = tcg_temp_new();
     if (n == 0) {
-        tcg_gen_mul_tl(ret, arg1, arg2);
-        tcg_gen_addi_tl(ret, ret, 0x8000);
+        tcg_gen_mul_i32(ret, arg1, arg2);
+        tcg_gen_addi_i32(ret, ret, 0x8000);
     } else {
-        tcg_gen_mul_tl(ret, arg1, arg2);
-        tcg_gen_shli_tl(ret, ret, 1);
-        tcg_gen_addi_tl(ret, ret, 0x8000);
+        tcg_gen_mul_i32(ret, arg1, arg2);
+        tcg_gen_shli_i32(ret, ret, 1);
+        tcg_gen_addi_i32(ret, ret, 0x8000);
         /* catch special case r1 = r2 = 0x8000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp, ret, 0x80008000);
-        tcg_gen_muli_tl(temp, temp, 0x8001);
-        tcg_gen_sub_tl(ret, ret, temp);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp, ret, 0x80008000);
+        tcg_gen_muli_i32(temp, temp, 0x8001);
+        tcg_gen_sub_i32(ret, ret, temp);
     }
     /* reset v bit */
-    tcg_gen_movi_tl(cpu_PSW_V, 0);
+    tcg_gen_movi_i32(cpu_PSW_V, 0);
     /* calc av overflow bit */
-    tcg_gen_add_tl(cpu_PSW_AV, ret, ret);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret, ret);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc sav overflow bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* cut halfword off */
-    tcg_gen_andi_tl(ret, ret, 0xffff0000);
+    tcg_gen_andi_i32(ret, ret, 0xffff0000);
 }
 
 static inline void
@@ -2447,23 +2447,23 @@ gen_msubsui_64(TCGv ret_low, TCGv ret_high, TCGv r1, TCGv r2_low, TCGv r2_high,
 
 static void gen_saturate(TCGv ret, TCGv arg, int32_t up, int32_t low)
 {
-    tcg_gen_smax_tl(ret, arg, tcg_constant_i32(low));
-    tcg_gen_smin_tl(ret, ret, tcg_constant_i32(up));
+    tcg_gen_smax_i32(ret, arg, tcg_constant_i32(low));
+    tcg_gen_smin_i32(ret, ret, tcg_constant_i32(up));
 }
 
 static void gen_saturate_u(TCGv ret, TCGv arg, int32_t up)
 {
-    tcg_gen_umin_tl(ret, arg, tcg_constant_i32(up));
+    tcg_gen_umin_i32(ret, arg, tcg_constant_i32(up));
 }
 
 static void gen_shi(TCGv ret, TCGv r1, int32_t shift_count)
 {
     if (shift_count == -32) {
-        tcg_gen_movi_tl(ret, 0);
+        tcg_gen_movi_i32(ret, 0);
     } else if (shift_count >= 0) {
-        tcg_gen_shli_tl(ret, r1, shift_count);
+        tcg_gen_shli_i32(ret, r1, shift_count);
     } else {
-        tcg_gen_shri_tl(ret, r1, -shift_count);
+        tcg_gen_shri_i32(ret, r1, -shift_count);
     }
 }
 
@@ -2472,16 +2472,16 @@ static void gen_sh_hi(TCGv ret, TCGv r1, int32_t shiftcount)
     TCGv temp_low, temp_high;
 
     if (shiftcount == -16) {
-        tcg_gen_movi_tl(ret, 0);
+        tcg_gen_movi_i32(ret, 0);
     } else {
         temp_high = tcg_temp_new();
         temp_low = tcg_temp_new();
 
-        tcg_gen_andi_tl(temp_low, r1, 0xffff);
-        tcg_gen_andi_tl(temp_high, r1, 0xffff0000);
+        tcg_gen_andi_i32(temp_low, r1, 0xffff);
+        tcg_gen_andi_i32(temp_high, r1, 0xffff0000);
         gen_shi(temp_low, temp_low, shiftcount);
         gen_shi(ret, temp_high, shiftcount);
-        tcg_gen_deposit_tl(ret, ret, temp_low, 0, 16);
+        tcg_gen_deposit_i32(ret, ret, temp_low, 0, 16);
     }
 }
 
@@ -2493,16 +2493,16 @@ static void gen_shaci(TCGv ret, TCGv r1, int32_t shift_count)
 
     if (shift_count == 0) {
         /* Clear PSW.C and PSW.V */
-        tcg_gen_movi_tl(cpu_PSW_C, 0);
-        tcg_gen_mov_tl(cpu_PSW_V, cpu_PSW_C);
-        tcg_gen_mov_tl(ret, r1);
+        tcg_gen_movi_i32(cpu_PSW_C, 0);
+        tcg_gen_mov_i32(cpu_PSW_V, cpu_PSW_C);
+        tcg_gen_mov_i32(ret, r1);
     } else if (shift_count == -32) {
         /* set PSW.C */
-        tcg_gen_mov_tl(cpu_PSW_C, r1);
+        tcg_gen_mov_i32(cpu_PSW_C, r1);
         /* fill ret completely with sign bit */
-        tcg_gen_sari_tl(ret, r1, 31);
+        tcg_gen_sari_i32(ret, r1, 31);
         /* clear PSW.V */
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
     } else if (shift_count > 0) {
         TCGv t_max = tcg_constant_i32(0x7FFFFFFF >> shift_count);
         TCGv t_min = tcg_constant_i32(((int32_t) -0x80000000) >> shift_count);
@@ -2510,30 +2510,30 @@ static void gen_shaci(TCGv ret, TCGv r1, int32_t shift_count)
         /* calc carry */
         msk_start = 32 - shift_count;
         msk = ((1 << shift_count) - 1) << msk_start;
-        tcg_gen_andi_tl(cpu_PSW_C, r1, msk);
+        tcg_gen_andi_i32(cpu_PSW_C, r1, msk);
         /* calc v/sv bits */
-        tcg_gen_setcond_tl(TCG_COND_GT, temp, r1, t_max);
-        tcg_gen_setcond_tl(TCG_COND_LT, temp2, r1, t_min);
-        tcg_gen_or_tl(cpu_PSW_V, temp, temp2);
-        tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+        tcg_gen_setcond_i32(TCG_COND_GT, temp, r1, t_max);
+        tcg_gen_setcond_i32(TCG_COND_LT, temp2, r1, t_min);
+        tcg_gen_or_i32(cpu_PSW_V, temp, temp2);
+        tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
         /* calc sv */
-        tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_V, cpu_PSW_SV);
+        tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_V, cpu_PSW_SV);
         /* do shift */
-        tcg_gen_shli_tl(ret, r1, shift_count);
+        tcg_gen_shli_i32(ret, r1, shift_count);
     } else {
         /* clear PSW.V */
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
         /* calc carry */
         msk = (1 << -shift_count) - 1;
-        tcg_gen_andi_tl(cpu_PSW_C, r1, msk);
+        tcg_gen_andi_i32(cpu_PSW_C, r1, msk);
         /* do shift */
-        tcg_gen_sari_tl(ret, r1, -shift_count);
+        tcg_gen_sari_i32(ret, r1, -shift_count);
     }
     /* calc av overflow bit */
-    tcg_gen_add_tl(cpu_PSW_AV, ret, ret);
-    tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
+    tcg_gen_add_i32(cpu_PSW_AV, ret, ret);
+    tcg_gen_xor_i32(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc sav overflow bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
 }
 
 static void gen_shas(TCGv ret, TCGv r1, TCGv r2)
@@ -2552,23 +2552,23 @@ static void gen_sha_hi(TCGv ret, TCGv r1, int32_t shift_count)
     TCGv low, high;
 
     if (shift_count == 0) {
-        tcg_gen_mov_tl(ret, r1);
+        tcg_gen_mov_i32(ret, r1);
     } else if (shift_count > 0) {
         low = tcg_temp_new();
         high = tcg_temp_new();
 
-        tcg_gen_andi_tl(high, r1, 0xffff0000);
-        tcg_gen_shli_tl(low, r1, shift_count);
-        tcg_gen_shli_tl(ret, high, shift_count);
-        tcg_gen_deposit_tl(ret, ret, low, 0, 16);
+        tcg_gen_andi_i32(high, r1, 0xffff0000);
+        tcg_gen_shli_i32(low, r1, shift_count);
+        tcg_gen_shli_i32(ret, high, shift_count);
+        tcg_gen_deposit_i32(ret, ret, low, 0, 16);
     } else {
         low = tcg_temp_new();
         high = tcg_temp_new();
 
-        tcg_gen_ext16s_tl(low, r1);
-        tcg_gen_sari_tl(low, low, -shift_count);
-        tcg_gen_sari_tl(ret, r1, -shift_count);
-        tcg_gen_deposit_tl(ret, ret, low, 0, 16);
+        tcg_gen_ext16s_i32(low, r1);
+        tcg_gen_sari_i32(low, low, -shift_count);
+        tcg_gen_sari_i32(ret, r1, -shift_count);
+        tcg_gen_deposit_i32(ret, ret, low, 0, 16);
     }
 }
 
@@ -2578,9 +2578,9 @@ static void gen_sh_cond(int cond, TCGv ret, TCGv r1, TCGv r2)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_shli_tl(temp, ret, 1);
-    tcg_gen_setcond_tl(cond, temp2, r1, r2);
-    tcg_gen_or_tl(ret, temp, temp2);
+    tcg_gen_shli_i32(temp, ret, 1);
+    tcg_gen_setcond_i32(cond, temp2, r1, r2);
+    tcg_gen_or_i32(ret, temp, temp2);
 }
 
 static void gen_sh_condi(int cond, TCGv ret, TCGv r1, int32_t con)
@@ -2626,13 +2626,13 @@ static inline void gen_bit_2op(TCGv ret, TCGv r1, TCGv r2,
     temp1 = tcg_temp_new();
     temp2 = tcg_temp_new();
 
-    tcg_gen_shri_tl(temp2, r2, pos2);
-    tcg_gen_shri_tl(temp1, r1, pos1);
+    tcg_gen_shri_i32(temp2, r2, pos2);
+    tcg_gen_shri_i32(temp1, r1, pos1);
 
     (*op1)(temp1, temp1, temp2);
     (*op2)(temp1 , ret, temp1);
 
-    tcg_gen_deposit_tl(ret, ret, temp1, 0, 1);
+    tcg_gen_deposit_i32(ret, ret, temp1, 0, 1);
 }
 
 /* ret = r1[pos1] op1 r2[pos2]; */
@@ -2645,12 +2645,12 @@ static inline void gen_bit_1op(TCGv ret, TCGv r1, TCGv r2,
     temp1 = tcg_temp_new();
     temp2 = tcg_temp_new();
 
-    tcg_gen_shri_tl(temp2, r2, pos2);
-    tcg_gen_shri_tl(temp1, r1, pos1);
+    tcg_gen_shri_i32(temp2, r2, pos2);
+    tcg_gen_shri_i32(temp1, r1, pos1);
 
     (*op1)(ret, temp1, temp2);
 
-    tcg_gen_andi_tl(ret, ret, 0x1);
+    tcg_gen_andi_i32(ret, ret, 0x1);
 }
 
 static inline void gen_accumulating_cond(int cond, TCGv ret, TCGv r1, TCGv r2,
@@ -2659,13 +2659,13 @@ static inline void gen_accumulating_cond(int cond, TCGv ret, TCGv r1, TCGv r2,
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
     /* temp = (arg1 cond arg2 )*/
-    tcg_gen_setcond_tl(cond, temp, r1, r2);
+    tcg_gen_setcond_i32(cond, temp, r1, r2);
     /* temp2 = ret[0]*/
-    tcg_gen_andi_tl(temp2, ret, 0x1);
+    tcg_gen_andi_i32(temp2, ret, 0x1);
     /* temp = temp insn temp2 */
     (*op)(temp, temp, temp2);
     /* ret = {ret[31:1], temp} */
-    tcg_gen_deposit_tl(ret, ret, temp, 0, 1);
+    tcg_gen_deposit_i32(ret, ret, temp, 0, 1);
 }
 
 static inline void
@@ -2684,25 +2684,25 @@ static inline void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
     TCGv b3 = tcg_temp_new();
 
     /* byte 0 */
-    tcg_gen_andi_tl(b0, r1, 0xff);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, b0, b0, con & 0xff);
+    tcg_gen_andi_i32(b0, r1, 0xff);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, b0, b0, con & 0xff);
 
     /* byte 1 */
-    tcg_gen_andi_tl(b1, r1, 0xff00);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, b1, b1, con & 0xff00);
+    tcg_gen_andi_i32(b1, r1, 0xff00);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, b1, b1, con & 0xff00);
 
     /* byte 2 */
-    tcg_gen_andi_tl(b2, r1, 0xff0000);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, b2, b2, con & 0xff0000);
+    tcg_gen_andi_i32(b2, r1, 0xff0000);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, b2, b2, con & 0xff0000);
 
     /* byte 3 */
-    tcg_gen_andi_tl(b3, r1, 0xff000000);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, b3, b3, con & 0xff000000);
+    tcg_gen_andi_i32(b3, r1, 0xff000000);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, b3, b3, con & 0xff000000);
 
     /* combine them */
-    tcg_gen_or_tl(ret, b0, b1);
-    tcg_gen_or_tl(ret, ret, b2);
-    tcg_gen_or_tl(ret, ret, b3);
+    tcg_gen_or_i32(ret, b0, b1);
+    tcg_gen_or_i32(ret, ret, b2);
+    tcg_gen_or_i32(ret, ret, b3);
 }
 
 static inline void gen_eqany_hi(TCGv ret, TCGv r1, int32_t con)
@@ -2711,15 +2711,15 @@ static inline void gen_eqany_hi(TCGv ret, TCGv r1, int32_t con)
     TCGv h1 = tcg_temp_new();
 
     /* halfword 0 */
-    tcg_gen_andi_tl(h0, r1, 0xffff);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, h0, h0, con & 0xffff);
+    tcg_gen_andi_i32(h0, r1, 0xffff);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, h0, h0, con & 0xffff);
 
     /* halfword 1 */
-    tcg_gen_andi_tl(h1, r1, 0xffff0000);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, h1, h1, con & 0xffff0000);
+    tcg_gen_andi_i32(h1, r1, 0xffff0000);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, h1, h1, con & 0xffff0000);
 
     /* combine them */
-    tcg_gen_or_tl(ret, h0, h1);
+    tcg_gen_or_i32(ret, h0, h1);
 }
 
 /* mask = ((1 << width) -1) << pos;
@@ -2730,14 +2730,14 @@ static inline void gen_insert(TCGv ret, TCGv r1, TCGv r2, TCGv width, TCGv pos)
     TCGv temp = tcg_temp_new();
     TCGv temp2 = tcg_temp_new();
 
-    tcg_gen_shl_tl(mask, tcg_constant_tl(1), width);
-    tcg_gen_subi_tl(mask, mask, 1);
-    tcg_gen_shl_tl(mask, mask, pos);
+    tcg_gen_shl_i32(mask, tcg_constant_i32(1), width);
+    tcg_gen_subi_i32(mask, mask, 1);
+    tcg_gen_shl_i32(mask, mask, pos);
 
-    tcg_gen_shl_tl(temp, r2, pos);
-    tcg_gen_and_tl(temp, temp, mask);
-    tcg_gen_andc_tl(temp2, r1, mask);
-    tcg_gen_or_tl(ret, temp, temp2);
+    tcg_gen_shl_i32(temp, r2, pos);
+    tcg_gen_and_i32(temp, temp, mask);
+    tcg_gen_andc_i32(temp2, r1, mask);
+    tcg_gen_or_i32(ret, temp, temp2);
 }
 
 static inline void gen_bsplit(TCGv rl, TCGv rh, TCGv r1)
@@ -2786,35 +2786,35 @@ static void gen_calc_usb_mul_h(TCGv arg_low, TCGv arg_high)
 {
     TCGv temp = tcg_temp_new();
     /* calc AV bit */
-    tcg_gen_add_tl(temp, arg_low, arg_low);
-    tcg_gen_xor_tl(temp, temp, arg_low);
-    tcg_gen_add_tl(cpu_PSW_AV, arg_high, arg_high);
-    tcg_gen_xor_tl(cpu_PSW_AV, cpu_PSW_AV, arg_high);
-    tcg_gen_or_tl(cpu_PSW_AV, cpu_PSW_AV, temp);
+    tcg_gen_add_i32(temp, arg_low, arg_low);
+    tcg_gen_xor_i32(temp, temp, arg_low);
+    tcg_gen_add_i32(cpu_PSW_AV, arg_high, arg_high);
+    tcg_gen_xor_i32(cpu_PSW_AV, cpu_PSW_AV, arg_high);
+    tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
-    tcg_gen_movi_tl(cpu_PSW_V, 0);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_movi_i32(cpu_PSW_V, 0);
 }
 
 static void gen_calc_usb_mulr_h(TCGv arg)
 {
     TCGv temp = tcg_temp_new();
     /* calc AV bit */
-    tcg_gen_add_tl(temp, arg, arg);
-    tcg_gen_xor_tl(temp, temp, arg);
-    tcg_gen_shli_tl(cpu_PSW_AV, temp, 16);
-    tcg_gen_or_tl(cpu_PSW_AV, cpu_PSW_AV, temp);
+    tcg_gen_add_i32(temp, arg, arg);
+    tcg_gen_xor_i32(temp, temp, arg);
+    tcg_gen_shli_i32(cpu_PSW_AV, temp, 16);
+    tcg_gen_or_i32(cpu_PSW_AV, cpu_PSW_AV, temp);
     /* calc SAV bit */
-    tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+    tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
     /* clear V bit */
-    tcg_gen_movi_tl(cpu_PSW_V, 0);
+    tcg_gen_movi_i32(cpu_PSW_V, 0);
 }
 
 /* helpers for generating program flow micro-ops */
 
 static inline void gen_save_pc(vaddr pc)
 {
-    tcg_gen_movi_tl(cpu_PC, pc);
+    tcg_gen_movi_i32(cpu_PC, pc);
 }
 
 static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index, vaddr dest)
@@ -2844,7 +2844,7 @@ static inline void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
                                    TCGv r2, int16_t address)
 {
     TCGLabel *jumpLabel = gen_new_label();
-    tcg_gen_brcond_tl(cond, r1, r2, jumpLabel);
+    tcg_gen_brcond_i32(cond, r1, r2, jumpLabel);
 
     gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
 
@@ -2863,8 +2863,8 @@ static void gen_loop(DisasContext *ctx, int r1, int32_t offset)
 {
     TCGLabel *l1 = gen_new_label();
 
-    tcg_gen_subi_tl(cpu_gpr_a[r1], cpu_gpr_a[r1], 1);
-    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_gpr_a[r1], -1, l1);
+    tcg_gen_subi_i32(cpu_gpr_a[r1], cpu_gpr_a[r1], 1);
+    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_gpr_a[r1], -1, l1);
     gen_goto_tb(ctx, 1, ctx->base.pc_next + offset);
     gen_set_label(l1);
     gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
@@ -2874,20 +2874,20 @@ static void gen_fcall_save_ctx(DisasContext *ctx)
 {
     TCGv temp = tcg_temp_new();
 
-    tcg_gen_addi_tl(temp, cpu_gpr_a[10], -4);
-    tcg_gen_qemu_st_tl(cpu_gpr_a[11], temp, ctx->mem_idx, MO_LESL);
-    tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
-    tcg_gen_mov_tl(cpu_gpr_a[10], temp);
+    tcg_gen_addi_i32(temp, cpu_gpr_a[10], -4);
+    tcg_gen_qemu_st_i32(cpu_gpr_a[11], temp, ctx->mem_idx, MO_LESL);
+    tcg_gen_movi_i32(cpu_gpr_a[11], ctx->pc_succ_insn);
+    tcg_gen_mov_i32(cpu_gpr_a[10], temp);
 }
 
 static void gen_fret(DisasContext *ctx)
 {
     TCGv temp = tcg_temp_new();
 
-    tcg_gen_andi_tl(temp, cpu_gpr_a[11], ~0x1);
-    tcg_gen_qemu_ld_tl(cpu_gpr_a[11], cpu_gpr_a[10], ctx->mem_idx, MO_LESL);
-    tcg_gen_addi_tl(cpu_gpr_a[10], cpu_gpr_a[10], 4);
-    tcg_gen_mov_tl(cpu_PC, temp);
+    tcg_gen_andi_i32(temp, cpu_gpr_a[11], ~0x1);
+    tcg_gen_qemu_ld_i32(cpu_gpr_a[11], cpu_gpr_a[10], ctx->mem_idx, MO_LESL);
+    tcg_gen_addi_i32(cpu_gpr_a[10], cpu_gpr_a[10], 4);
+    tcg_gen_mov_i32(cpu_PC, temp);
     ctx->base.is_jmp = DISAS_EXIT;
 }
 
@@ -2932,12 +2932,12 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
 /* SBRN-format jumps */
     case OPC1_16_SBRN_JZ_T:
         temp = tcg_temp_new();
-        tcg_gen_andi_tl(temp, cpu_gpr_d[15], 0x1u << constant);
+        tcg_gen_andi_i32(temp, cpu_gpr_d[15], 0x1u << constant);
         gen_branch_condi(ctx, TCG_COND_EQ, temp, 0, offset);
         break;
     case OPC1_16_SBRN_JNZ_T:
         temp = tcg_temp_new();
-        tcg_gen_andi_tl(temp, cpu_gpr_d[15], 0x1u << constant);
+        tcg_gen_andi_i32(temp, cpu_gpr_d[15], 0x1u << constant);
         gen_branch_condi(ctx, TCG_COND_NE, temp, 0, offset);
         break;
 /* SBR-format jumps */
@@ -2986,7 +2986,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         break;
 /* SR-format jumps */
     case OPC1_16_SR_JI:
-        tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], 0xfffffffe);
+        tcg_gen_andi_i32(cpu_PC, cpu_gpr_a[r1], 0xfffffffe);
         ctx->base.is_jmp = DISAS_EXIT;
         break;
     case OPC2_32_SYS_RET:
@@ -3008,13 +3008,13 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_JLA:
-        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
+        tcg_gen_movi_i32(cpu_gpr_a[11], ctx->pc_succ_insn);
         /* fall through */
     case OPC1_32_B_JA:
         gen_goto_tb(ctx, 0, EA_B_ABSOLUT(offset));
         break;
     case OPC1_32_B_JL:
-        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
+        tcg_gen_movi_i32(cpu_gpr_a[11], ctx->pc_succ_insn);
         gen_goto_tb(ctx, 0, ctx->base.pc_next + offset * 2);
         break;
 /* BOL format */
@@ -3046,14 +3046,14 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
     case OPCM_32_BRC_JNE:
         temp = tcg_temp_new();
         if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRC_JNED) {
-            tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
+            tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
             /* subi is unconditional */
-            tcg_gen_subi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
+            tcg_gen_subi_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_condi(ctx, TCG_COND_NE, temp, constant, offset);
         } else {
-            tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
+            tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
             /* addi is unconditional */
-            tcg_gen_addi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
+            tcg_gen_addi_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_condi(ctx, TCG_COND_NE, temp, constant, offset);
         }
         break;
@@ -3062,7 +3062,7 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         n = MASK_OP_BRN_N(ctx->opcode);
 
         temp = tcg_temp_new();
-        tcg_gen_andi_tl(temp, cpu_gpr_d[r1], (1 << n));
+        tcg_gen_andi_i32(temp, cpu_gpr_d[r1], (1 << n));
 
         if (MASK_OP_BRN_OP2(ctx->opcode) == OPC2_32_BRN_JNZ_T) {
             gen_branch_condi(ctx, TCG_COND_NE, temp, 0, offset);
@@ -3119,18 +3119,18 @@ static void gen_compute_branch(DisasContext *ctx, uint32_t opc, int r1,
         temp = tcg_temp_new();
         temp2 = tcg_temp_new();
         if (MASK_OP_BRC_OP2(ctx->opcode) == OPC2_32_BRR_JNED) {
-            tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
+            tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
             /* also save r2, in case of r1 == r2, so r2 is not decremented */
-            tcg_gen_mov_tl(temp2, cpu_gpr_d[r2]);
+            tcg_gen_mov_i32(temp2, cpu_gpr_d[r2]);
             /* subi is unconditional */
-            tcg_gen_subi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
+            tcg_gen_subi_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_cond(ctx, TCG_COND_NE, temp, temp2, offset);
         } else {
-            tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
+            tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
             /* also save r2, in case of r1 == r2, so r2 is not decremented */
-            tcg_gen_mov_tl(temp2, cpu_gpr_d[r2]);
+            tcg_gen_mov_i32(temp2, cpu_gpr_d[r2]);
             /* addi is unconditional */
-            tcg_gen_addi_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
+            tcg_gen_addi_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 1);
             gen_branch_cond(ctx, TCG_COND_NE, temp, temp2, offset);
         }
         break;
@@ -3171,7 +3171,7 @@ static void decode_src_opc(DisasContext *ctx, int op1)
         gen_addi_d(cpu_gpr_d[15], cpu_gpr_d[r1], const4);
         break;
     case OPC1_16_SRC_ADD_A:
-        tcg_gen_addi_tl(cpu_gpr_a[r1], cpu_gpr_a[r1], const4);
+        tcg_gen_addi_i32(cpu_gpr_a[r1], cpu_gpr_a[r1], const4);
         break;
     case OPC1_16_SRC_CADD:
         gen_condi_add(TCG_COND_NE, cpu_gpr_d[r1], const4, cpu_gpr_d[r1],
@@ -3182,37 +3182,37 @@ static void decode_src_opc(DisasContext *ctx, int op1)
                       cpu_gpr_d[15]);
         break;
     case OPC1_16_SRC_CMOV:
-        temp = tcg_constant_tl(0);
-        temp2 = tcg_constant_tl(const4);
-        tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
+        temp = tcg_constant_i32(0);
+        temp2 = tcg_constant_i32(const4);
+        tcg_gen_movcond_i32(TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
                            temp2, cpu_gpr_d[r1]);
         break;
     case OPC1_16_SRC_CMOVN:
-        temp = tcg_constant_tl(0);
-        temp2 = tcg_constant_tl(const4);
-        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
+        temp = tcg_constant_i32(0);
+        temp2 = tcg_constant_i32(const4);
+        tcg_gen_movcond_i32(TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
                            temp2, cpu_gpr_d[r1]);
         break;
     case OPC1_16_SRC_EQ:
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_gpr_d[15], cpu_gpr_d[r1],
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_gpr_d[15], cpu_gpr_d[r1],
                             const4);
         break;
     case OPC1_16_SRC_LT:
-        tcg_gen_setcondi_tl(TCG_COND_LT, cpu_gpr_d[15], cpu_gpr_d[r1],
+        tcg_gen_setcondi_i32(TCG_COND_LT, cpu_gpr_d[15], cpu_gpr_d[r1],
                             const4);
         break;
     case OPC1_16_SRC_MOV:
-        tcg_gen_movi_tl(cpu_gpr_d[r1], const4);
+        tcg_gen_movi_i32(cpu_gpr_d[r1], const4);
         break;
     case OPC1_16_SRC_MOV_A:
         const4 = MASK_OP_SRC_CONST4(ctx->opcode);
-        tcg_gen_movi_tl(cpu_gpr_a[r1], const4);
+        tcg_gen_movi_i32(cpu_gpr_a[r1], const4);
         break;
     case OPC1_16_SRC_MOV_E:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             CHECK_REG_PAIR(r1);
-            tcg_gen_movi_tl(cpu_gpr_d[r1], const4);
-            tcg_gen_sari_tl(cpu_gpr_d[r1+1], cpu_gpr_d[r1], 31);
+            tcg_gen_movi_i32(cpu_gpr_d[r1], const4);
+            tcg_gen_sari_i32(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], 31);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
@@ -3247,49 +3247,49 @@ static void decode_srr_opc(DisasContext *ctx, int op1)
         gen_add_d(cpu_gpr_d[15], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_ADD_A:
-        tcg_gen_add_tl(cpu_gpr_a[r1], cpu_gpr_a[r1], cpu_gpr_a[r2]);
+        tcg_gen_add_i32(cpu_gpr_a[r1], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         break;
     case OPC1_16_SRR_ADDS:
         gen_adds(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_AND:
-        tcg_gen_and_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_and_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_CMOV:
-        temp = tcg_constant_tl(0);
-        tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
+        temp = tcg_constant_i32(0);
+        tcg_gen_movcond_i32(TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
                            cpu_gpr_d[r2], cpu_gpr_d[r1]);
         break;
     case OPC1_16_SRR_CMOVN:
-        temp = tcg_constant_tl(0);
-        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
+        temp = tcg_constant_i32(0);
+        tcg_gen_movcond_i32(TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15], temp,
                            cpu_gpr_d[r2], cpu_gpr_d[r1]);
         break;
     case OPC1_16_SRR_EQ:
-        tcg_gen_setcond_tl(TCG_COND_EQ, cpu_gpr_d[15], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_EQ, cpu_gpr_d[15], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_LT:
-        tcg_gen_setcond_tl(TCG_COND_LT, cpu_gpr_d[15], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_LT, cpu_gpr_d[15], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_MOV:
-        tcg_gen_mov_tl(cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_mov_i32(cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_MOV_A:
-        tcg_gen_mov_tl(cpu_gpr_a[r1], cpu_gpr_d[r2]);
+        tcg_gen_mov_i32(cpu_gpr_a[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_MOV_AA:
-        tcg_gen_mov_tl(cpu_gpr_a[r1], cpu_gpr_a[r2]);
+        tcg_gen_mov_i32(cpu_gpr_a[r1], cpu_gpr_a[r2]);
         break;
     case OPC1_16_SRR_MOV_D:
-        tcg_gen_mov_tl(cpu_gpr_d[r1], cpu_gpr_a[r2]);
+        tcg_gen_mov_i32(cpu_gpr_d[r1], cpu_gpr_a[r2]);
         break;
     case OPC1_16_SRR_MUL:
         gen_mul_i32s(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_OR:
-        tcg_gen_or_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_or_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_SUB:
         gen_sub_d(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
@@ -3304,7 +3304,7 @@ static void decode_srr_opc(DisasContext *ctx, int op1)
         gen_subs(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC1_16_SRR_XOR:
-        tcg_gen_xor_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_xor_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3320,32 +3320,32 @@ static void decode_ssr_opc(DisasContext *ctx, int op1)
 
     switch (op1) {
     case OPC1_16_SSR_ST_A:
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
         break;
     case OPC1_16_SSR_ST_A_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
         break;
     case OPC1_16_SSR_ST_B:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
         break;
     case OPC1_16_SSR_ST_B_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 1);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 1);
         break;
     case OPC1_16_SSR_ST_H:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUW);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUW);
         break;
     case OPC1_16_SSR_ST_H_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUW);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 2);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUW);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 2);
         break;
     case OPC1_16_SSR_ST_W:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
         break;
     case OPC1_16_SSR_ST_W_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LEUL);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3360,7 +3360,7 @@ static void decode_sc_opc(DisasContext *ctx, int op1)
 
     switch (op1) {
     case OPC1_16_SC_AND:
-        tcg_gen_andi_tl(cpu_gpr_d[15], cpu_gpr_d[15], const16);
+        tcg_gen_andi_i32(cpu_gpr_d[15], cpu_gpr_d[15], const16);
         break;
     case OPC1_16_SC_BISR:
         if (ctx->priv == TRICORE_PRIV_SM) {
@@ -3376,10 +3376,10 @@ static void decode_sc_opc(DisasContext *ctx, int op1)
         gen_offset_ld(ctx, cpu_gpr_d[15], cpu_gpr_a[10], const16 * 4, MO_LESL);
         break;
     case OPC1_16_SC_MOV:
-        tcg_gen_movi_tl(cpu_gpr_d[15], const16);
+        tcg_gen_movi_i32(cpu_gpr_d[15], const16);
         break;
     case OPC1_16_SC_OR:
-        tcg_gen_ori_tl(cpu_gpr_d[15], cpu_gpr_d[15], const16);
+        tcg_gen_ori_i32(cpu_gpr_d[15], cpu_gpr_d[15], const16);
         break;
     case OPC1_16_SC_ST_A:
         gen_offset_st(ctx, cpu_gpr_a[15], cpu_gpr_a[10], const16 * 4, MO_LESL);
@@ -3388,7 +3388,7 @@ static void decode_sc_opc(DisasContext *ctx, int op1)
         gen_offset_st(ctx, cpu_gpr_d[15], cpu_gpr_a[10], const16 * 4, MO_LESL);
         break;
     case OPC1_16_SC_SUB_A:
-        tcg_gen_subi_tl(cpu_gpr_a[10], cpu_gpr_a[10], const16);
+        tcg_gen_subi_i32(cpu_gpr_a[10], cpu_gpr_a[10], const16);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3405,32 +3405,32 @@ static void decode_slr_opc(DisasContext *ctx, int op1)
     switch (op1) {
 /* SLR-format */
     case OPC1_16_SLR_LD_A:
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
         break;
     case OPC1_16_SLR_LD_A_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
         break;
     case OPC1_16_SLR_LD_BU:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
         break;
     case OPC1_16_SLR_LD_BU_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 1);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_UB);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 1);
         break;
     case OPC1_16_SLR_LD_H:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESW);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESW);
         break;
     case OPC1_16_SLR_LD_H_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESW);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 2);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESW);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 2);
         break;
     case OPC1_16_SLR_LD_W:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
         break;
     case OPC1_16_SLR_LD_W_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx, MO_LESL);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], 4);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3513,17 +3513,18 @@ static void decode_sr_accu(DisasContext *ctx)
     switch (op2) {
     case OPC2_16_SR_RSUB:
         /* calc V bit -- overflow only if r1 = -0x80000000 */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r1], -0x80000000);
-        tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_PSW_V,
+                             cpu_gpr_d[r1], -0x80000000);
+        tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
         /* calc SV bit */
-        tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+        tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
         /* sub */
-        tcg_gen_neg_tl(cpu_gpr_d[r1], cpu_gpr_d[r1]);
+        tcg_gen_neg_i32(cpu_gpr_d[r1], cpu_gpr_d[r1]);
         /* calc av */
-        tcg_gen_add_tl(cpu_PSW_AV, cpu_gpr_d[r1], cpu_gpr_d[r1]);
-        tcg_gen_xor_tl(cpu_PSW_AV, cpu_gpr_d[r1], cpu_PSW_AV);
+        tcg_gen_add_i32(cpu_PSW_AV, cpu_gpr_d[r1], cpu_gpr_d[r1]);
+        tcg_gen_xor_i32(cpu_PSW_AV, cpu_gpr_d[r1], cpu_PSW_AV);
         /* calc sav */
-        tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
+        tcg_gen_or_i32(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
         break;
     case OPC2_16_SR_SAT_B:
         gen_saturate(cpu_gpr_d[r1], cpu_gpr_d[r1], 0x7f, -0x80);
@@ -3616,8 +3617,8 @@ static void decode_16Bit_opc(DisasContext *ctx)
         r1 = MASK_OP_SRRS_S1D(ctx->opcode);
         const16 = MASK_OP_SRRS_N(ctx->opcode);
         temp = tcg_temp_new();
-        tcg_gen_shli_tl(temp, cpu_gpr_d[15], const16);
-        tcg_gen_add_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], temp);
+        tcg_gen_shli_i32(temp, cpu_gpr_d[15], const16);
+        tcg_gen_add_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], temp);
         break;
 /* SLRO-format */
     case OPC1_16_SLRO_LD_A:
@@ -3766,7 +3767,7 @@ static void decode_16Bit_opc(DisasContext *ctx)
         break;
     case OPC1_16_SR_NOT:
         r1 = MASK_OP_SR_S1D(ctx->opcode);
-        tcg_gen_not_tl(cpu_gpr_d[r1], cpu_gpr_d[r1]);
+        tcg_gen_not_i32(cpu_gpr_d[r1], cpu_gpr_d[r1]);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3793,18 +3794,18 @@ static void decode_abs_ldw(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_ABS_LD_A:
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], temp, ctx->mem_idx, MO_LESL);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], temp, ctx->mem_idx, MO_LESL);
         break;
     case OPC2_32_ABS_LD_D:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], temp, ctx);
+        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
         break;
     case OPC2_32_ABS_LD_DA:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], temp, ctx);
+        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
         break;
     case OPC2_32_ABS_LD_W:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3826,16 +3827,16 @@ static void decode_abs_ldb(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_ABS_LD_B:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_SB);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_SB);
         break;
     case OPC2_32_ABS_LD_BU:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_UB);
         break;
     case OPC2_32_ABS_LD_H:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESW);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESW);
         break;
     case OPC2_32_ABS_LD_HU:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUW);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUW);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3908,18 +3909,18 @@ static void decode_abs_store(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_ABS_ST_A:
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1], temp, ctx->mem_idx, MO_LESL);
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1], temp, ctx->mem_idx, MO_LESL);
         break;
     case OPC2_32_ABS_ST_D:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], temp, ctx);
+        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
         break;
     case OPC2_32_ABS_ST_DA:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], temp, ctx);
+        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
         break;
     case OPC2_32_ABS_ST_W:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LESL);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -3941,10 +3942,10 @@ static void decode_abs_storeb_h(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_ABS_ST_B:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_UB);
         break;
     case OPC2_32_ABS_ST_H:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUW);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUW);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -4043,11 +4044,11 @@ static void decode_bit_insert(DisasContext *ctx)
 
     temp = tcg_temp_new();
 
-    tcg_gen_shri_tl(temp, cpu_gpr_d[r2], pos2);
+    tcg_gen_shri_i32(temp, cpu_gpr_d[r2], pos2);
     if (op2 == OPC2_32_BIT_INSN_T) {
-        tcg_gen_not_tl(temp, temp);
+        tcg_gen_not_i32(temp, temp);
     }
-    tcg_gen_deposit_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], temp, pos1, 1);
+    tcg_gen_deposit_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], temp, pos1, 1);
 }
 
 static void decode_bit_logical_t2(DisasContext *ctx)
@@ -4163,8 +4164,8 @@ static void decode_bit_sh_logic1(DisasContext *ctx)
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-    tcg_gen_shli_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], 1);
-    tcg_gen_add_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], temp);
+    tcg_gen_shli_i32(cpu_gpr_d[r3], cpu_gpr_d[r3], 1);
+    tcg_gen_add_i32(cpu_gpr_d[r3], cpu_gpr_d[r3], temp);
 }
 
 static void decode_bit_sh_logic2(DisasContext *ctx)
@@ -4203,8 +4204,8 @@ static void decode_bit_sh_logic2(DisasContext *ctx)
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
     }
-    tcg_gen_shli_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], 1);
-    tcg_gen_add_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], temp);
+    tcg_gen_shli_i32(cpu_gpr_d[r3], cpu_gpr_d[r3], 1);
+    tcg_gen_add_i32(cpu_gpr_d[r3], cpu_gpr_d[r3], temp);
 }
 
 /* BO-format */
@@ -4233,14 +4234,14 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
     case OPC2_32_BO_CACHEA_I_POSTINC:
         /* instruction to access the cache, but we still need to handle
            the addressing mode */
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_CACHEA_WI_PREINC:
     case OPC2_32_BO_CACHEA_W_PREINC:
     case OPC2_32_BO_CACHEA_I_PREINC:
         /* instruction to access the cache, but we still need to handle
            the addressing mode */
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_CACHEI_WI_SHORTOFF:
     case OPC2_32_BO_CACHEI_W_SHORTOFF:
@@ -4251,7 +4252,7 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
     case OPC2_32_BO_CACHEI_W_POSTINC:
     case OPC2_32_BO_CACHEI_WI_POSTINC:
         if (has_feature(ctx, TRICORE_FEATURE_131)) {
-            tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+            tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
@@ -4259,7 +4260,7 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
     case OPC2_32_BO_CACHEI_W_PREINC:
     case OPC2_32_BO_CACHEI_WI_PREINC:
         if (has_feature(ctx, TRICORE_FEATURE_131)) {
-            tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+            tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
@@ -4268,9 +4269,9 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         gen_offset_st(ctx, cpu_gpr_a[r1], cpu_gpr_a[r2], off10, MO_LESL);
         break;
     case OPC2_32_BO_ST_A_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LESL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_A_PREINC:
         gen_st_preincr(ctx, cpu_gpr_a[r1], cpu_gpr_a[r2], off10, MO_LESL);
@@ -4279,82 +4280,82 @@ static void decode_bo_addrmode_post_pre_base(DisasContext *ctx)
         gen_offset_st(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_UB);
         break;
     case OPC2_32_BO_ST_B_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_UB);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_B_PREINC:
         gen_st_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_UB);
         break;
     case OPC2_32_BO_ST_D_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_st_2regs(cpu_gpr_d[r1+1], cpu_gpr_d[r1], cpu_gpr_a[r2],
+        gen_offset_st_2regs(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
                             off10, ctx);
         break;
     case OPC2_32_BO_ST_D_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_D_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
-        gen_st_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], temp, ctx);
-        tcg_gen_mov_tl(cpu_gpr_a[r2], temp);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
+        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_ST_DA_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_st_2regs(cpu_gpr_a[r1+1], cpu_gpr_a[r1], cpu_gpr_a[r2],
+        gen_offset_st_2regs(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
                             off10, ctx);
         break;
     case OPC2_32_BO_ST_DA_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_DA_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
-        gen_st_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], temp, ctx);
-        tcg_gen_mov_tl(cpu_gpr_a[r2], temp);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
+        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_ST_H_SHORTOFF:
         gen_offset_st(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_ST_H_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUW);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_H_PREINC:
         gen_st_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_ST_Q_SHORTOFF:
         temp = tcg_temp_new();
-        tcg_gen_shri_tl(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
         gen_offset_st(ctx, temp, cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_ST_Q_POSTINC:
         temp = tcg_temp_new();
-        tcg_gen_shri_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_qemu_st_tl(temp, cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_qemu_st_i32(temp, cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUW);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_Q_PREINC:
         temp = tcg_temp_new();
-        tcg_gen_shri_tl(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
         gen_st_preincr(ctx, temp, cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_ST_W_SHORTOFF:
         gen_offset_st(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUL);
         break;
     case OPC2_32_BO_ST_W_POSTINC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_ST_W_PREINC:
         gen_st_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUL);
@@ -4380,91 +4381,91 @@ static void decode_bo_addrmode_bitreverse_circular(DisasContext *ctx)
     temp2 = tcg_temp_new();
     t_off10 = tcg_constant_i32(off10);
     CHECK_REG_PAIR(r2);
-    tcg_gen_ext16u_tl(temp, cpu_gpr_a[r2+1]);
-    tcg_gen_add_tl(temp2, cpu_gpr_a[r2], temp);
+    tcg_gen_ext16u_i32(temp, cpu_gpr_a[r2 + 1]);
+    tcg_gen_add_i32(temp2, cpu_gpr_a[r2], temp);
 
     switch (op2) {
     case OPC2_32_BO_CACHEA_WI_BR:
     case OPC2_32_BO_CACHEA_W_BR:
     case OPC2_32_BO_CACHEA_I_BR:
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_CACHEA_WI_CIRC:
     case OPC2_32_BO_CACHEA_W_CIRC:
     case OPC2_32_BO_CACHEA_I_CIRC:
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_ST_A_BR:
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_A_CIRC:
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_ST_B_BR:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_B_CIRC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_ST_D_BR:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], temp2, ctx);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_st_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2, ctx);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_D_CIRC:
         CHECK_REG_PAIR(r1);
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
-        tcg_gen_shri_tl(temp2, cpu_gpr_a[r2+1], 16);
-        tcg_gen_addi_tl(temp, temp, 4);
-        tcg_gen_rem_tl(temp, temp, temp2);
-        tcg_gen_add_tl(temp2, cpu_gpr_a[r2], temp);
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1+1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
+        tcg_gen_shri_i32(temp2, cpu_gpr_a[r2 + 1], 16);
+        tcg_gen_addi_i32(temp, temp, 4);
+        tcg_gen_rem_i32(temp, temp, temp2);
+        tcg_gen_add_i32(temp2, cpu_gpr_a[r2], temp);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1 + 1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_ST_DA_BR:
         CHECK_REG_PAIR(r1);
-        gen_st_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], temp2, ctx);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_st_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2, ctx);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_DA_CIRC:
         CHECK_REG_PAIR(r1);
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
-        tcg_gen_shri_tl(temp2, cpu_gpr_a[r2+1], 16);
-        tcg_gen_addi_tl(temp, temp, 4);
-        tcg_gen_rem_tl(temp, temp, temp2);
-        tcg_gen_add_tl(temp2, cpu_gpr_a[r2], temp);
-        tcg_gen_qemu_st_tl(cpu_gpr_a[r1+1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
+        tcg_gen_shri_i32(temp2, cpu_gpr_a[r2 + 1], 16);
+        tcg_gen_addi_i32(temp, temp, 4);
+        tcg_gen_rem_i32(temp, temp, temp2);
+        tcg_gen_add_i32(temp2, cpu_gpr_a[r2], temp);
+        tcg_gen_qemu_st_i32(cpu_gpr_a[r1 + 1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_ST_H_BR:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_H_CIRC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_ST_Q_BR:
-        tcg_gen_shri_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_qemu_st_tl(temp, temp2, ctx->mem_idx, MO_LEUW);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_qemu_st_i32(temp, temp2, ctx->mem_idx, MO_LEUW);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_Q_CIRC:
-        tcg_gen_shri_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_qemu_st_tl(temp, temp2, ctx->mem_idx, MO_LEUW);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_shri_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_qemu_st_i32(temp, temp2, ctx->mem_idx, MO_LEUW);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_ST_W_BR:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_ST_W_CIRC:
-        tcg_gen_qemu_st_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_st_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -4488,9 +4489,9 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         gen_offset_ld(ctx, cpu_gpr_a[r1], cpu_gpr_a[r2], off10, MO_LEUL);
         break;
     case OPC2_32_BO_LD_A_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_A_PREINC:
         gen_ld_preincr(ctx, cpu_gpr_a[r1], cpu_gpr_a[r2], off10, MO_LEUL);
@@ -4499,9 +4500,9 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_SB);
         break;
     case OPC2_32_BO_LD_B_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_SB);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_B_PREINC:
         gen_ld_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_SB);
@@ -4510,54 +4511,54 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_UB);
         break;
     case OPC2_32_BO_LD_BU_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_UB);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_BU_PREINC:
         gen_ld_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_UB);
         break;
     case OPC2_32_BO_LD_D_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_ld_2regs(cpu_gpr_d[r1+1], cpu_gpr_d[r1], cpu_gpr_a[r2],
+        gen_offset_ld_2regs(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2],
                             off10, ctx);
         break;
     case OPC2_32_BO_LD_D_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], cpu_gpr_a[r2], ctx);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_D_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
-        gen_ld_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], temp, ctx);
-        tcg_gen_mov_tl(cpu_gpr_a[r2], temp);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
+        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp, ctx);
+        tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_LD_DA_SHORTOFF:
         CHECK_REG_PAIR(r1);
-        gen_offset_ld_2regs(cpu_gpr_a[r1+1], cpu_gpr_a[r1], cpu_gpr_a[r2],
+        gen_offset_ld_2regs(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2],
                             off10, ctx);
         break;
     case OPC2_32_BO_LD_DA_POSTINC:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], cpu_gpr_a[r2], ctx);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_DA_PREINC:
         CHECK_REG_PAIR(r1);
         temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
-        gen_ld_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], temp, ctx);
-        tcg_gen_mov_tl(cpu_gpr_a[r2], temp);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
+        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp, ctx);
+        tcg_gen_mov_i32(cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_BO_LD_H_SHORTOFF:
         gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LESW);
         break;
     case OPC2_32_BO_LD_H_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LESW);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_H_PREINC:
         gen_ld_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LESW);
@@ -4566,34 +4567,34 @@ static void decode_bo_addrmode_ld_post_pre_base(DisasContext *ctx)
         gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_LD_HU_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUW);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_HU_PREINC:
         gen_ld_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUW);
         break;
     case OPC2_32_BO_LD_Q_SHORTOFF:
         gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUW);
-        tcg_gen_shli_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
+        tcg_gen_shli_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
         break;
     case OPC2_32_BO_LD_Q_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUW);
-        tcg_gen_shli_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_shli_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_Q_PREINC:
         gen_ld_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUW);
-        tcg_gen_shli_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
+        tcg_gen_shli_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
         break;
     case OPC2_32_BO_LD_W_SHORTOFF:
         gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUL);
         break;
     case OPC2_32_BO_LD_W_POSTINC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], cpu_gpr_a[r2], ctx->mem_idx,
                            MO_LEUL);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LD_W_PREINC:
         gen_ld_preincr(ctx, cpu_gpr_d[r1], cpu_gpr_a[r2], off10, MO_LEUL);
@@ -4619,98 +4620,98 @@ static void decode_bo_addrmode_ld_bitreverse_circular(DisasContext *ctx)
     temp2 = tcg_temp_new();
     t_off10 = tcg_constant_i32(off10);
     CHECK_REG_PAIR(r2);
-    tcg_gen_ext16u_tl(temp, cpu_gpr_a[r2+1]);
-    tcg_gen_add_tl(temp2, cpu_gpr_a[r2], temp);
+    tcg_gen_ext16u_i32(temp, cpu_gpr_a[r2 + 1]);
+    tcg_gen_add_i32(temp2, cpu_gpr_a[r2], temp);
 
 
     switch (op2) {
     case OPC2_32_BO_LD_A_BR:
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_A_CIRC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_B_BR:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_SB);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_SB);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_B_CIRC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_SB);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_SB);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_BU_BR:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_BU_CIRC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_UB);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_D_BR:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_d[r1+1], cpu_gpr_d[r1], temp2, ctx);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_ld_2regs_64(cpu_gpr_d[r1 + 1], cpu_gpr_d[r1], temp2, ctx);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_D_CIRC:
         CHECK_REG_PAIR(r1);
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
-        tcg_gen_shri_tl(temp2, cpu_gpr_a[r2+1], 16);
-        tcg_gen_addi_tl(temp, temp, 4);
-        tcg_gen_rem_tl(temp, temp, temp2);
-        tcg_gen_add_tl(temp2, cpu_gpr_a[r2], temp);
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1+1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
+        tcg_gen_shri_i32(temp2, cpu_gpr_a[r2 + 1], 16);
+        tcg_gen_addi_i32(temp, temp, 4);
+        tcg_gen_rem_i32(temp, temp, temp2);
+        tcg_gen_add_i32(temp2, cpu_gpr_a[r2], temp);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1 + 1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_DA_BR:
         CHECK_REG_PAIR(r1);
-        gen_ld_2regs_64(cpu_gpr_a[r1+1], cpu_gpr_a[r1], temp2, ctx);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_ld_2regs_64(cpu_gpr_a[r1 + 1], cpu_gpr_a[r1], temp2, ctx);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_DA_CIRC:
         CHECK_REG_PAIR(r1);
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
-        tcg_gen_shri_tl(temp2, cpu_gpr_a[r2+1], 16);
-        tcg_gen_addi_tl(temp, temp, 4);
-        tcg_gen_rem_tl(temp, temp, temp2);
-        tcg_gen_add_tl(temp2, cpu_gpr_a[r2], temp);
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1+1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], temp2, ctx->mem_idx, MO_LEUL);
+        tcg_gen_shri_i32(temp2, cpu_gpr_a[r2 + 1], 16);
+        tcg_gen_addi_i32(temp, temp, 4);
+        tcg_gen_rem_i32(temp, temp, temp2);
+        tcg_gen_add_i32(temp2, cpu_gpr_a[r2], temp);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1 + 1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_H_BR:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LESW);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LESW);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_H_CIRC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LESW);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LESW);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_HU_BR:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_HU_CIRC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_Q_BR:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
-        tcg_gen_shli_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
+        tcg_gen_shli_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_Q_CIRC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
-        tcg_gen_shli_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUW);
+        tcg_gen_shli_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_LD_W_BR:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LD_W_CIRC:
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp2, ctx->mem_idx, MO_LEUL);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -4735,70 +4736,70 @@ static void decode_bo_addrmode_stctx_post_pre_base(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_BO_LDLCX_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_helper_ldlcx(tcg_env, temp);
         break;
     case OPC2_32_BO_LDMST_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_ldmst(ctx, r1, temp);
         break;
     case OPC2_32_BO_LDMST_POSTINC:
         gen_ldmst(ctx, r1, cpu_gpr_a[r2]);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_LDMST_PREINC:
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         gen_ldmst(ctx, r1, cpu_gpr_a[r2]);
         break;
     case OPC2_32_BO_LDUCX_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_helper_lducx(tcg_env, temp);
         break;
     case OPC2_32_BO_LEA_SHORTOFF:
-        tcg_gen_addi_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_STLCX_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_helper_stlcx(tcg_env, temp);
         break;
     case OPC2_32_BO_STUCX_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_helper_stucx(tcg_env, temp);
         break;
     case OPC2_32_BO_SWAP_W_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_swap(ctx, r1, temp);
         break;
     case OPC2_32_BO_SWAP_W_POSTINC:
         gen_swap(ctx, r1, cpu_gpr_a[r2]);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_SWAP_W_PREINC:
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         gen_swap(ctx, r1, cpu_gpr_a[r2]);
         break;
     case OPC2_32_BO_CMPSWAP_W_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_cmpswap(ctx, r1, temp);
         break;
     case OPC2_32_BO_CMPSWAP_W_POSTINC:
         gen_cmpswap(ctx, r1, cpu_gpr_a[r2]);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_CMPSWAP_W_PREINC:
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         gen_cmpswap(ctx, r1, cpu_gpr_a[r2]);
         break;
     case OPC2_32_BO_SWAPMSK_W_SHORTOFF:
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], off10);
         gen_swapmsk(ctx, r1, temp);
         break;
     case OPC2_32_BO_SWAPMSK_W_POSTINC:
         gen_swapmsk(ctx, r1, cpu_gpr_a[r2]);
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         break;
     case OPC2_32_BO_SWAPMSK_W_PREINC:
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r2], off10);
         gen_swapmsk(ctx, r1, cpu_gpr_a[r2]);
         break;
     default:
@@ -4822,41 +4823,41 @@ static void decode_bo_addrmode_ldmst_bitreverse_circular(DisasContext *ctx)
     temp2 = tcg_temp_new();
     t_off10 = tcg_constant_i32(off10);
     CHECK_REG_PAIR(r2);
-    tcg_gen_ext16u_tl(temp, cpu_gpr_a[r2+1]);
-    tcg_gen_add_tl(temp2, cpu_gpr_a[r2], temp);
+    tcg_gen_ext16u_i32(temp, cpu_gpr_a[r2 + 1]);
+    tcg_gen_add_i32(temp2, cpu_gpr_a[r2], temp);
 
     switch (op2) {
     case OPC2_32_BO_LDMST_BR:
         gen_ldmst(ctx, r1, temp2);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_LDMST_CIRC:
         gen_ldmst(ctx, r1, temp2);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_SWAP_W_BR:
         gen_swap(ctx, r1, temp2);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_SWAP_W_CIRC:
         gen_swap(ctx, r1, temp2);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_CMPSWAP_W_BR:
         gen_cmpswap(ctx, r1, temp2);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_CMPSWAP_W_CIRC:
         gen_cmpswap(ctx, r1, temp2);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     case OPC2_32_BO_SWAPMSK_W_BR:
         gen_swapmsk(ctx, r1, temp2);
-        gen_helper_br_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1]);
+        gen_helper_br_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1]);
         break;
     case OPC2_32_BO_SWAPMSK_W_CIRC:
         gen_swapmsk(ctx, r1, temp2);
-        gen_helper_circ_update(cpu_gpr_a[r2+1], cpu_gpr_a[r2+1], t_off10);
+        gen_helper_circ_update(cpu_gpr_a[r2 + 1], cpu_gpr_a[r2 + 1], t_off10);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -4876,16 +4877,16 @@ static void decode_bol_opc(DisasContext *ctx, int32_t op1)
     switch (op1) {
     case OPC1_32_BOL_LD_A_LONGOFF:
         temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], address);
-        tcg_gen_qemu_ld_tl(cpu_gpr_a[r1], temp, ctx->mem_idx, MO_LEUL);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], address);
+        tcg_gen_qemu_ld_i32(cpu_gpr_a[r1], temp, ctx->mem_idx, MO_LEUL);
         break;
     case OPC1_32_BOL_LD_W_LONGOFF:
         temp = tcg_temp_new();
-        tcg_gen_addi_tl(temp, cpu_gpr_a[r2], address);
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUL);
+        tcg_gen_addi_i32(temp, cpu_gpr_a[r2], address);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUL);
         break;
     case OPC1_32_BOL_LEA_LONGOFF:
-        tcg_gen_addi_tl(cpu_gpr_a[r1], cpu_gpr_a[r2], address);
+        tcg_gen_addi_i32(cpu_gpr_a[r1], cpu_gpr_a[r2], address);
         break;
     case OPC1_32_BOL_ST_A_LONGOFF:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
@@ -4959,26 +4960,26 @@ static void decode_rc_logical_shift(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RC_AND:
-        tcg_gen_andi_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_andi_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_ANDN:
-        tcg_gen_andi_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], ~const9);
+        tcg_gen_andi_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], ~const9);
         break;
     case OPC2_32_RC_NAND:
         temp = tcg_temp_new();
-        tcg_gen_movi_tl(temp, const9);
-        tcg_gen_nand_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
+        tcg_gen_movi_i32(temp, const9);
+        tcg_gen_nand_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_NOR:
         temp = tcg_temp_new();
-        tcg_gen_movi_tl(temp, const9);
-        tcg_gen_nor_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
+        tcg_gen_movi_i32(temp, const9);
+        tcg_gen_nor_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_OR:
-        tcg_gen_ori_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_ori_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_ORN:
-        tcg_gen_ori_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], ~const9);
+        tcg_gen_ori_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], ~const9);
         break;
     case OPC2_32_RC_SH:
         const9 = sextract32(const9, 0, 6);
@@ -5000,11 +5001,11 @@ static void decode_rc_logical_shift(DisasContext *ctx)
         gen_shasi(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_XNOR:
-        tcg_gen_xori_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
-        tcg_gen_not_tl(cpu_gpr_d[r2], cpu_gpr_d[r2]);
+        tcg_gen_xori_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_not_i32(cpu_gpr_d[r2], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RC_XOR:
-        tcg_gen_xori_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_xori_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_SHUFFLE:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
@@ -5084,7 +5085,7 @@ static void decode_rc_accumulator(DisasContext *ctx)
                                const9, &tcg_gen_and_tl);
         break;
     case OPC2_32_RC_EQ:
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_EQANY_B:
         gen_eqany_bi(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
@@ -5093,41 +5094,41 @@ static void decode_rc_accumulator(DisasContext *ctx)
         gen_eqany_hi(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_GE:
-        tcg_gen_setcondi_tl(TCG_COND_GE, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_setcondi_i32(TCG_COND_GE, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_GE_U:
         const9 = MASK_OP_RC_CONST9(ctx->opcode);
-        tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_setcondi_i32(TCG_COND_GEU, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_LT:
-        tcg_gen_setcondi_tl(TCG_COND_LT, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_setcondi_i32(TCG_COND_LT, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_LT_U:
         const9 = MASK_OP_RC_CONST9(ctx->opcode);
-        tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_setcondi_i32(TCG_COND_LTU, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_MAX:
-        tcg_gen_movi_tl(temp, const9);
-        tcg_gen_movcond_tl(TCG_COND_GT, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
+        tcg_gen_movi_i32(temp, const9);
+        tcg_gen_movcond_i32(TCG_COND_GT, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
                            cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_MAX_U:
-        tcg_gen_movi_tl(temp, MASK_OP_RC_CONST9(ctx->opcode));
-        tcg_gen_movcond_tl(TCG_COND_GTU, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
+        tcg_gen_movi_i32(temp, MASK_OP_RC_CONST9(ctx->opcode));
+        tcg_gen_movcond_i32(TCG_COND_GTU, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
                            cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_MIN:
-        tcg_gen_movi_tl(temp, const9);
-        tcg_gen_movcond_tl(TCG_COND_LT, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
+        tcg_gen_movi_i32(temp, const9);
+        tcg_gen_movcond_i32(TCG_COND_LT, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
                            cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_MIN_U:
-        tcg_gen_movi_tl(temp, MASK_OP_RC_CONST9(ctx->opcode));
-        tcg_gen_movcond_tl(TCG_COND_LTU, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
+        tcg_gen_movi_i32(temp, MASK_OP_RC_CONST9(ctx->opcode));
+        tcg_gen_movcond_i32(TCG_COND_LTU, cpu_gpr_d[r2], cpu_gpr_d[r1], temp,
                            cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_NE:
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
+        tcg_gen_setcondi_i32(TCG_COND_NE, cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_OR_EQ:
         gen_accumulating_condi(TCG_COND_EQ, cpu_gpr_d[r2], cpu_gpr_d[r1],
@@ -5156,15 +5157,15 @@ static void decode_rc_accumulator(DisasContext *ctx)
                                const9, &tcg_gen_or_tl);
         break;
     case OPC2_32_RC_RSUB:
-        tcg_gen_movi_tl(temp, const9);
+        tcg_gen_movi_i32(temp, const9);
         gen_sub_d(cpu_gpr_d[r2], temp, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RC_RSUBS:
-        tcg_gen_movi_tl(temp, const9);
+        tcg_gen_movi_i32(temp, const9);
         gen_subs(cpu_gpr_d[r2], temp, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RC_RSUBS_U:
-        tcg_gen_movi_tl(temp, const9);
+        tcg_gen_movi_i32(temp, const9);
         gen_subsu(cpu_gpr_d[r2], temp, cpu_gpr_d[r1]);
         break;
     case OPC2_32_RC_SH_EQ:
@@ -5260,7 +5261,7 @@ static void decode_rc_mul(DisasContext *ctx)
         break;
     case OPC2_32_RC_MUL_64:
         CHECK_REG_PAIR(r2);
-        gen_muli_i64s(cpu_gpr_d[r2], cpu_gpr_d[r2+1], cpu_gpr_d[r1], const9);
+        gen_muli_i64s(cpu_gpr_d[r2], cpu_gpr_d[r2 + 1], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_MULS_32:
         gen_mulsi_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
@@ -5268,7 +5269,7 @@ static void decode_rc_mul(DisasContext *ctx)
     case OPC2_32_RC_MUL_U_64:
         const9 = MASK_OP_RC_CONST9(ctx->opcode);
         CHECK_REG_PAIR(r2);
-        gen_muli_i64u(cpu_gpr_d[r2], cpu_gpr_d[r2+1], cpu_gpr_d[r1], const9);
+        gen_muli_i64u(cpu_gpr_d[r2], cpu_gpr_d[r2 + 1], cpu_gpr_d[r1], const9);
         break;
     case OPC2_32_RC_MULS_U_32:
         const9 = MASK_OP_RC_CONST9(ctx->opcode);
@@ -5300,18 +5301,18 @@ static void decode_rcpw_insert(DisasContext *ctx)
         CHECK_REG_PAIR(r2);
         /* if pos + width > 32 undefined result */
         if (pos + width <= 32) {
-            tcg_gen_movi_tl(cpu_gpr_d[r2+1], ((1u << width) - 1) << pos);
-            tcg_gen_movi_tl(cpu_gpr_d[r2], (const4 << pos));
+            tcg_gen_movi_i32(cpu_gpr_d[r2 + 1], ((1u << width) - 1) << pos);
+            tcg_gen_movi_i32(cpu_gpr_d[r2], (const4 << pos));
         }
         break;
     case OPC2_32_RCPW_INSERT:
-        /* tcg_gen_deposit_tl() does not handle the case of width = 0 */
+        /* tcg_gen_deposit_i32() does not handle the case of width = 0 */
         if (width == 0) {
-            tcg_gen_mov_tl(cpu_gpr_d[r2], cpu_gpr_d[r1]);
+            tcg_gen_mov_i32(cpu_gpr_d[r2], cpu_gpr_d[r1]);
         /* if pos + width > 32 undefined result */
         } else if (pos + width <= 32) {
             temp = tcg_constant_i32(const4);
-            tcg_gen_deposit_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp, pos, width);
+            tcg_gen_deposit_i32(cpu_gpr_d[r2], cpu_gpr_d[r1], temp, pos, width);
         }
         break;
     default:
@@ -5342,18 +5343,18 @@ static void decode_rcrw_insert(DisasContext *ctx)
     switch (op2) {
     case OPC2_32_RCRW_IMASK:
         CHECK_REG_PAIR(r4);
-        tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
-        tcg_gen_movi_tl(temp2, (1 << width) - 1);
-        tcg_gen_shl_tl(cpu_gpr_d[r4 + 1], temp2, temp);
-        tcg_gen_movi_tl(temp2, const4);
-        tcg_gen_shl_tl(cpu_gpr_d[r4], temp2, temp);
+        tcg_gen_andi_i32(temp, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_movi_i32(temp2, (1 << width) - 1);
+        tcg_gen_shl_i32(cpu_gpr_d[r4 + 1], temp2, temp);
+        tcg_gen_movi_i32(temp2, const4);
+        tcg_gen_shl_i32(cpu_gpr_d[r4], temp2, temp);
         break;
     case OPC2_32_RCRW_INSERT:
         temp3 = tcg_temp_new();
 
-        tcg_gen_movi_tl(temp, width);
-        tcg_gen_movi_tl(temp2, const4);
-        tcg_gen_andi_tl(temp3, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_movi_i32(temp, width);
+        tcg_gen_movi_i32(temp2, const4);
+        tcg_gen_andi_i32(temp3, cpu_gpr_d[r3], 0x1f);
         gen_insert(cpu_gpr_d[r4], cpu_gpr_d[r1], temp2, temp, temp3);
         break;
     default:
@@ -5389,13 +5390,13 @@ static void decode_rcr_cond_select(DisasContext *ctx)
     case OPC2_32_RCR_SEL:
         temp = tcg_constant_i32(0);
         temp2 = tcg_constant_i32(const9);
-        tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
+        tcg_gen_movcond_i32(TCG_COND_NE, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
                            cpu_gpr_d[r1], temp2);
         break;
     case OPC2_32_RCR_SELN:
         temp = tcg_constant_i32(0);
         temp2 = tcg_constant_i32(const9);
-        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
+        tcg_gen_movcond_i32(TCG_COND_EQ, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
                            cpu_gpr_d[r1], temp2);
         break;
     default:
@@ -5423,8 +5424,8 @@ static void decode_rcr_madd(DisasContext *ctx)
     case OPC2_32_RCR_MADD_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddi64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_maddi64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     case OPC2_32_RCR_MADDS_32:
         gen_maddsi_32(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r3], const9);
@@ -5432,15 +5433,15 @@ static void decode_rcr_madd(DisasContext *ctx)
     case OPC2_32_RCR_MADDS_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsi_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_maddsi_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     case OPC2_32_RCR_MADD_U_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
         const9 = MASK_OP_RCR_CONST9(ctx->opcode);
-        gen_maddui64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                       cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_maddui64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                       cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     case OPC2_32_RCR_MADDS_U_32:
         const9 = MASK_OP_RCR_CONST9(ctx->opcode);
@@ -5450,8 +5451,8 @@ static void decode_rcr_madd(DisasContext *ctx)
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
         const9 = MASK_OP_RCR_CONST9(ctx->opcode);
-        gen_maddsui_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                       cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_maddsui_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                       cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -5478,8 +5479,8 @@ static void decode_rcr_msub(DisasContext *ctx)
     case OPC2_32_RCR_MSUB_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubi64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_msubi64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     case OPC2_32_RCR_MSUBS_32:
         gen_msubsi_32(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r3], const9);
@@ -5487,15 +5488,15 @@ static void decode_rcr_msub(DisasContext *ctx)
     case OPC2_32_RCR_MSUBS_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubsi_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_msubsi_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     case OPC2_32_RCR_MSUB_U_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
         const9 = MASK_OP_RCR_CONST9(ctx->opcode);
-        gen_msubui64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                       cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_msubui64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                       cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     case OPC2_32_RCR_MSUBS_U_32:
         const9 = MASK_OP_RCR_CONST9(ctx->opcode);
@@ -5505,8 +5506,8 @@ static void decode_rcr_msub(DisasContext *ctx)
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
         const9 = MASK_OP_RCR_CONST9(ctx->opcode);
-        gen_msubsui_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                       cpu_gpr_d[r3], cpu_gpr_d[r3+1], const9);
+        gen_msubsui_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                       cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], const9);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -5533,33 +5534,33 @@ static void decode_rlc_opc(DisasContext *ctx,
         gen_addi_d(cpu_gpr_d[r2], cpu_gpr_d[r1], const16 << 16);
         break;
     case OPC1_32_RLC_ADDIH_A:
-        tcg_gen_addi_tl(cpu_gpr_a[r2], cpu_gpr_a[r1], const16 << 16);
+        tcg_gen_addi_i32(cpu_gpr_a[r2], cpu_gpr_a[r1], const16 << 16);
         break;
     case OPC1_32_RLC_MFCR:
         const16 = MASK_OP_RLC_CONST16(ctx->opcode);
         gen_mfcr(ctx, cpu_gpr_d[r2], const16);
         break;
     case OPC1_32_RLC_MOV:
-        tcg_gen_movi_tl(cpu_gpr_d[r2], const16);
+        tcg_gen_movi_i32(cpu_gpr_d[r2], const16);
         break;
     case OPC1_32_RLC_MOV_64:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             CHECK_REG_PAIR(r2);
-            tcg_gen_movi_tl(cpu_gpr_d[r2], const16);
-            tcg_gen_movi_tl(cpu_gpr_d[r2+1], const16 >> 15);
+            tcg_gen_movi_i32(cpu_gpr_d[r2], const16);
+            tcg_gen_movi_i32(cpu_gpr_d[r2 + 1], const16 >> 15);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC1_32_RLC_MOV_U:
         const16 = MASK_OP_RLC_CONST16(ctx->opcode);
-        tcg_gen_movi_tl(cpu_gpr_d[r2], const16);
+        tcg_gen_movi_i32(cpu_gpr_d[r2], const16);
         break;
     case OPC1_32_RLC_MOV_H:
-        tcg_gen_movi_tl(cpu_gpr_d[r2], const16 << 16);
+        tcg_gen_movi_i32(cpu_gpr_d[r2], const16 << 16);
         break;
     case OPC1_32_RLC_MOVH_A:
-        tcg_gen_movi_tl(cpu_gpr_a[r2], const16 << 16);
+        tcg_gen_movi_i32(cpu_gpr_a[r2], const16 << 16);
         break;
     case OPC1_32_RLC_MTCR:
         const16 = MASK_OP_RLC_CONST16(ctx->opcode);
@@ -5673,7 +5674,7 @@ static void decode_rr_accumulator(DisasContext *ctx)
                               cpu_gpr_d[r2], &tcg_gen_and_tl);
         break;
     case OPC2_32_RR_EQ:
-        tcg_gen_setcond_tl(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_EQ_B:
@@ -5683,7 +5684,7 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_eq_h(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_EQ_W:
-        tcg_gen_negsetcond_tl(TCG_COND_EQ, cpu_gpr_d[r3],
+        tcg_gen_negsetcond_i32(TCG_COND_EQ, cpu_gpr_d[r3],
                               cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_EQANY_B:
@@ -5693,19 +5694,19 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_eqany_h(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_GE:
-        tcg_gen_setcond_tl(TCG_COND_GE, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_GE, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_GE_U:
-        tcg_gen_setcond_tl(TCG_COND_GEU, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_GEU, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT:
-        tcg_gen_setcond_tl(TCG_COND_LT, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_LT, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_U:
-        tcg_gen_setcond_tl(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_B:
@@ -5721,19 +5722,19 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_lt_hu(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_W:
-        tcg_gen_negsetcond_tl(TCG_COND_LT, cpu_gpr_d[r3],
+        tcg_gen_negsetcond_i32(TCG_COND_LT, cpu_gpr_d[r3],
                               cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_WU:
-        tcg_gen_negsetcond_tl(TCG_COND_LTU, cpu_gpr_d[r3],
+        tcg_gen_negsetcond_i32(TCG_COND_LTU, cpu_gpr_d[r3],
                               cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MAX:
-        tcg_gen_movcond_tl(TCG_COND_GT, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_movcond_i32(TCG_COND_GT, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MAX_U:
-        tcg_gen_movcond_tl(TCG_COND_GTU, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_movcond_i32(TCG_COND_GTU, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MAX_B:
@@ -5749,11 +5750,11 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_max_hu(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MIN:
-        tcg_gen_movcond_tl(TCG_COND_LT, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_movcond_i32(TCG_COND_LT, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MIN_U:
-        tcg_gen_movcond_tl(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_movcond_i32(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MIN_B:
@@ -5769,16 +5770,16 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_min_hu(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MOV:
-        tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
+        tcg_gen_mov_i32(cpu_gpr_d[r3], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MOV_64:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             temp = tcg_temp_new();
 
             CHECK_REG_PAIR(r3);
-            tcg_gen_mov_tl(temp, cpu_gpr_d[r1]);
-            tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
-            tcg_gen_mov_tl(cpu_gpr_d[r3 + 1], temp);
+            tcg_gen_mov_i32(temp, cpu_gpr_d[r1]);
+            tcg_gen_mov_i32(cpu_gpr_d[r3], cpu_gpr_d[r2]);
+            tcg_gen_mov_i32(cpu_gpr_d[r3 + 1], temp);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
@@ -5786,14 +5787,14 @@ static void decode_rr_accumulator(DisasContext *ctx)
     case OPC2_32_RR_MOVS_64:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             CHECK_REG_PAIR(r3);
-            tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r2]);
-            tcg_gen_sari_tl(cpu_gpr_d[r3 + 1], cpu_gpr_d[r2], 31);
+            tcg_gen_mov_i32(cpu_gpr_d[r3], cpu_gpr_d[r2]);
+            tcg_gen_sari_i32(cpu_gpr_d[r3 + 1], cpu_gpr_d[r2], 31);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
         break;
     case OPC2_32_RR_NE:
-        tcg_gen_setcond_tl(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_d[r1],
+        tcg_gen_setcond_i32(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_d[r1],
                            cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_OR_EQ:
@@ -5926,41 +5927,41 @@ static void decode_rr_logical_shift(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RR_AND:
-        tcg_gen_and_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_and_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_ANDN:
-        tcg_gen_andc_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_andc_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_CLO:
-        tcg_gen_not_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
-        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r3], TARGET_LONG_BITS);
+        tcg_gen_not_i32(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        tcg_gen_clzi_i32(cpu_gpr_d[r3], cpu_gpr_d[r3], TARGET_LONG_BITS);
         break;
     case OPC2_32_RR_CLO_H:
         gen_helper_clo_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CLS:
-        tcg_gen_clrsb_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        tcg_gen_clrsb_i32(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CLS_H:
         gen_helper_cls_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CLZ:
-        tcg_gen_clzi_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], TARGET_LONG_BITS);
+        tcg_gen_clzi_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], TARGET_LONG_BITS);
         break;
     case OPC2_32_RR_CLZ_H:
         gen_helper_clz_h(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_NAND:
-        tcg_gen_nand_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_nand_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_NOR:
-        tcg_gen_nor_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_nor_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_OR:
-        tcg_gen_or_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_or_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_ORN:
-        tcg_gen_orc_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_orc_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_SH:
         gen_helper_sh(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
@@ -5978,10 +5979,10 @@ static void decode_rr_logical_shift(DisasContext *ctx)
         gen_shas(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_XNOR:
-        tcg_gen_eqv_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_eqv_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_XOR:
-        tcg_gen_xor_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_xor_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6002,52 +6003,52 @@ static void decode_rr_address(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RR_ADD_A:
-        tcg_gen_add_tl(cpu_gpr_a[r3], cpu_gpr_a[r1], cpu_gpr_a[r2]);
+        tcg_gen_add_i32(cpu_gpr_a[r3], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_ADDSC_A:
         temp = tcg_temp_new();
-        tcg_gen_shli_tl(temp, cpu_gpr_d[r1], n);
-        tcg_gen_add_tl(cpu_gpr_a[r3], cpu_gpr_a[r2], temp);
+        tcg_gen_shli_i32(temp, cpu_gpr_d[r1], n);
+        tcg_gen_add_i32(cpu_gpr_a[r3], cpu_gpr_a[r2], temp);
         break;
     case OPC2_32_RR_ADDSC_AT:
         temp = tcg_temp_new();
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 3);
-        tcg_gen_add_tl(temp, cpu_gpr_a[r2], temp);
-        tcg_gen_andi_tl(cpu_gpr_a[r3], temp, 0xFFFFFFFC);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 3);
+        tcg_gen_add_i32(temp, cpu_gpr_a[r2], temp);
+        tcg_gen_andi_i32(cpu_gpr_a[r3], temp, 0xFFFFFFFC);
         break;
     case OPC2_32_RR_EQ_A:
-        tcg_gen_setcond_tl(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_a[r1],
+        tcg_gen_setcond_i32(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_a[r1],
                            cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_EQZ:
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_a[r1], 0);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_a[r1], 0);
         break;
     case OPC2_32_RR_GE_A:
-        tcg_gen_setcond_tl(TCG_COND_GEU, cpu_gpr_d[r3], cpu_gpr_a[r1],
+        tcg_gen_setcond_i32(TCG_COND_GEU, cpu_gpr_d[r3], cpu_gpr_a[r1],
                            cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_LT_A:
-        tcg_gen_setcond_tl(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_a[r1],
+        tcg_gen_setcond_i32(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_a[r1],
                            cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_MOV_A:
-        tcg_gen_mov_tl(cpu_gpr_a[r3], cpu_gpr_d[r2]);
+        tcg_gen_mov_i32(cpu_gpr_a[r3], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MOV_AA:
-        tcg_gen_mov_tl(cpu_gpr_a[r3], cpu_gpr_a[r2]);
+        tcg_gen_mov_i32(cpu_gpr_a[r3], cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_MOV_D:
-        tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_a[r2]);
+        tcg_gen_mov_i32(cpu_gpr_d[r3], cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_NE_A:
-        tcg_gen_setcond_tl(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_a[r1],
+        tcg_gen_setcond_i32(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_a[r1],
                            cpu_gpr_a[r2]);
         break;
     case OPC2_32_RR_NEZ_A:
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_a[r1], 0);
+        tcg_gen_setcondi_i32(TCG_COND_NE, cpu_gpr_d[r3], cpu_gpr_a[r1], 0);
         break;
     case OPC2_32_RR_SUB_A:
-        tcg_gen_sub_tl(cpu_gpr_a[r3], cpu_gpr_a[r1], cpu_gpr_a[r2]);
+        tcg_gen_sub_i32(cpu_gpr_a[r3], cpu_gpr_a[r1], cpu_gpr_a[r2]);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6064,19 +6065,19 @@ static void decode_rr_idirect(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RR_JI:
-        tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
+        tcg_gen_andi_i32(cpu_PC, cpu_gpr_a[r1], ~0x1);
         break;
     case OPC2_32_RR_JLI:
-        tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
-        tcg_gen_movi_tl(cpu_gpr_a[11], ctx->pc_succ_insn);
+        tcg_gen_andi_i32(cpu_PC, cpu_gpr_a[r1], ~0x1);
+        tcg_gen_movi_i32(cpu_gpr_a[11], ctx->pc_succ_insn);
         break;
     case OPC2_32_RR_CALLI:
         gen_helper_1arg(call, ctx->pc_succ_insn);
-        tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
+        tcg_gen_andi_i32(cpu_PC, cpu_gpr_a[r1], ~0x1);
         break;
     case OPC2_32_RR_FCALLI:
         gen_fcall_save_ctx(ctx);
-        tcg_gen_andi_tl(cpu_PC, cpu_gpr_a[r1], ~0x1);
+        tcg_gen_andi_i32(cpu_PC, cpu_gpr_a[r1], ~0x1);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6103,11 +6104,11 @@ static void decode_rr_divide(DisasContext *ctx)
         break;
     case OPC2_32_RR_BSPLIT:
         CHECK_REG_PAIR(r3);
-        gen_bsplit(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1]);
+        gen_bsplit(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_DVINIT_B:
         CHECK_REG_PAIR(r3);
-        gen_dvinit_b(ctx, cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
+        gen_dvinit_b(ctx, cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1],
                      cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DVINIT_BU:
@@ -6115,28 +6116,28 @@ static void decode_rr_divide(DisasContext *ctx)
         temp2 = tcg_temp_new();
         temp3 = tcg_temp_new();
         CHECK_REG_PAIR(r3);
-        tcg_gen_shri_tl(temp3, cpu_gpr_d[r1], 8);
+        tcg_gen_shri_i32(temp3, cpu_gpr_d[r1], 8);
         /* reset av */
-        tcg_gen_movi_tl(cpu_PSW_AV, 0);
+        tcg_gen_movi_i32(cpu_PSW_AV, 0);
         if (!has_feature(ctx, TRICORE_FEATURE_131)) {
-            /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_abs_tl(temp, temp3);
-            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
+            /* overflow = (abs(D[r3 + 1]) >= abs(D[r2])) */
+            tcg_gen_abs_i32(temp, temp3);
+            tcg_gen_abs_i32(temp2, cpu_gpr_d[r2]);
+            tcg_gen_setcond_i32(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
-            tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
+            tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
         }
-        tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+        tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
         /* sv */
-        tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+        tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
         /* write result */
-        tcg_gen_shli_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], 24);
-        tcg_gen_mov_tl(cpu_gpr_d[r3+1], temp3);
+        tcg_gen_shli_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], 24);
+        tcg_gen_mov_i32(cpu_gpr_d[r3 + 1], temp3);
         break;
     case OPC2_32_RR_DVINIT_H:
         CHECK_REG_PAIR(r3);
-        gen_dvinit_h(ctx, cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
+        gen_dvinit_h(ctx, cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1],
                      cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_DVINIT_HU:
@@ -6144,24 +6145,24 @@ static void decode_rr_divide(DisasContext *ctx)
         temp2 = tcg_temp_new();
         temp3 = tcg_temp_new();
         CHECK_REG_PAIR(r3);
-        tcg_gen_shri_tl(temp3, cpu_gpr_d[r1], 16);
+        tcg_gen_shri_i32(temp3, cpu_gpr_d[r1], 16);
         /* reset av */
-        tcg_gen_movi_tl(cpu_PSW_AV, 0);
+        tcg_gen_movi_i32(cpu_PSW_AV, 0);
         if (!has_feature(ctx, TRICORE_FEATURE_131)) {
-            /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_abs_tl(temp, temp3);
-            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
+            /* overflow = (abs(D[r3 + 1]) >= abs(D[r2])) */
+            tcg_gen_abs_i32(temp, temp3);
+            tcg_gen_abs_i32(temp2, cpu_gpr_d[r2]);
+            tcg_gen_setcond_i32(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
-            tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
+            tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
         }
-        tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+        tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
         /* sv */
-        tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+        tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
         /* write result */
-        tcg_gen_shli_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], 16);
-        tcg_gen_mov_tl(cpu_gpr_d[r3+1], temp3);
+        tcg_gen_shli_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], 16);
+        tcg_gen_mov_i32(cpu_gpr_d[r3 + 1], temp3);
         break;
     case OPC2_32_RR_DVINIT:
         temp = tcg_temp_new();
@@ -6169,41 +6170,41 @@ static void decode_rr_divide(DisasContext *ctx)
         CHECK_REG_PAIR(r3);
         /* overflow = ((D[b] == 0) ||
                       ((D[b] == 0xFFFFFFFF) && (D[a] == 0x80000000))) */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp, cpu_gpr_d[r2], 0xffffffff);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, cpu_gpr_d[r1], 0x80000000);
-        tcg_gen_and_tl(temp, temp, temp2);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, temp2, cpu_gpr_d[r2], 0);
-        tcg_gen_or_tl(cpu_PSW_V, temp, temp2);
-        tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp, cpu_gpr_d[r2], 0xffffffff);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, cpu_gpr_d[r1], 0x80000000);
+        tcg_gen_and_i32(temp, temp, temp2);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, temp2, cpu_gpr_d[r2], 0);
+        tcg_gen_or_i32(cpu_PSW_V, temp, temp2);
+        tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
         /* sv */
-        tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+        tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
         /* reset av */
-       tcg_gen_movi_tl(cpu_PSW_AV, 0);
+       tcg_gen_movi_i32(cpu_PSW_AV, 0);
         /* write result */
-        tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        tcg_gen_mov_i32(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         /* sign extend to high reg */
-        tcg_gen_sari_tl(cpu_gpr_d[r3+1], cpu_gpr_d[r1], 31);
+        tcg_gen_sari_i32(cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], 31);
         break;
     case OPC2_32_RR_DVINIT_U:
         CHECK_REG_PAIR(r3);
         /* overflow = (D[b] == 0) */
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
-        tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_PSW_V, cpu_gpr_d[r2], 0);
+        tcg_gen_shli_i32(cpu_PSW_V, cpu_PSW_V, 31);
         /* sv */
-        tcg_gen_or_tl(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
+        tcg_gen_or_i32(cpu_PSW_SV, cpu_PSW_SV, cpu_PSW_V);
         /* reset av */
-        tcg_gen_movi_tl(cpu_PSW_AV, 0);
+        tcg_gen_movi_i32(cpu_PSW_AV, 0);
         /* write result */
-        tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        tcg_gen_mov_i32(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         /* zero extend to high reg*/
-        tcg_gen_movi_tl(cpu_gpr_d[r3+1], 0);
+        tcg_gen_movi_i32(cpu_gpr_d[r3 + 1], 0);
         break;
     case OPC2_32_RR_PARITY:
         gen_helper_parity(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_UNPACK:
         CHECK_REG_PAIR(r3);
-        gen_unpack(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1]);
+        gen_unpack(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RR_CRC32_B:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
@@ -6229,7 +6230,7 @@ static void decode_rr_divide(DisasContext *ctx)
 
     case OPC2_32_RR_POPCNT_W:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
-            tcg_gen_ctpop_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+            tcg_gen_ctpop_i32(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
         }
@@ -6237,7 +6238,7 @@ static void decode_rr_divide(DisasContext *ctx)
     case OPC2_32_RR_DIV:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             CHECK_REG_PAIR(r3);
-            GEN_HELPER_RR(divide, cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
+            GEN_HELPER_RR(divide, cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1],
                           cpu_gpr_d[r2]);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6246,7 +6247,7 @@ static void decode_rr_divide(DisasContext *ctx)
     case OPC2_32_RR_DIV_U:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             CHECK_REG_PAIR(r3);
-            GEN_HELPER_RR(divide_u, cpu_gpr_d[r3], cpu_gpr_d[r3+1],
+            GEN_HELPER_RR(divide_u, cpu_gpr_d[r3], cpu_gpr_d[r3 + 1],
                           cpu_gpr_d[r1], cpu_gpr_d[r2]);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6328,69 +6329,69 @@ static void decode_rr1_mul(DisasContext *ctx)
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_LL(mul_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
-        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3+1]);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
+        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1]);
         break;
     case OPC2_32_RR1_MUL_H_32_LU:
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_LU(mul_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
-        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3+1]);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
+        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1]);
         break;
     case OPC2_32_RR1_MUL_H_32_UL:
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_UL(mul_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
-        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3+1]);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
+        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1]);
         break;
     case OPC2_32_RR1_MUL_H_32_UU:
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_UU(mul_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
-        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3+1]);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
+        gen_calc_usb_mul_h(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1]);
         break;
     case OPC2_32_RR1_MULM_H_64_LL:
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_LL(mulm_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
         /* reset V bit */
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
         /* reset AV bit */
-        tcg_gen_mov_tl(cpu_PSW_AV, cpu_PSW_V);
+        tcg_gen_mov_i32(cpu_PSW_AV, cpu_PSW_V);
         break;
     case OPC2_32_RR1_MULM_H_64_LU:
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_LU(mulm_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
         /* reset V bit */
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
         /* reset AV bit */
-        tcg_gen_mov_tl(cpu_PSW_AV, cpu_PSW_V);
+        tcg_gen_mov_i32(cpu_PSW_AV, cpu_PSW_V);
         break;
     case OPC2_32_RR1_MULM_H_64_UL:
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_UL(mulm_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
         /* reset V bit */
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
         /* reset AV bit */
-        tcg_gen_mov_tl(cpu_PSW_AV, cpu_PSW_V);
+        tcg_gen_mov_i32(cpu_PSW_AV, cpu_PSW_V);
         break;
     case OPC2_32_RR1_MULM_H_64_UU:
         temp64 = tcg_temp_new_i64();
         CHECK_REG_PAIR(r3);
         GEN_HELPER_UU(mulm_h, temp64, cpu_gpr_d[r1], cpu_gpr_d[r2], n);
-        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3+1], temp64);
+        tcg_gen_extr_i64_i32(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], temp64);
         /* reset V bit */
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
         /* reset AV bit */
-        tcg_gen_mov_tl(cpu_PSW_AV, cpu_PSW_V);
+        tcg_gen_mov_i32(cpu_PSW_AV, cpu_PSW_V);
         break;
     case OPC2_32_RR1_MULR_H_16_LL:
         GEN_HELPER_LL(mulr_h, cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2], n);
@@ -6436,45 +6437,45 @@ static void decode_rr1_mulq(DisasContext *ctx)
         break;
     case OPC2_32_RR1_MUL_Q_64:
         CHECK_REG_PAIR(r3);
-        gen_mul_q(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_mul_q(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                   n, 0);
         break;
     case OPC2_32_RR1_MUL_Q_32_L:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
         gen_mul_q(cpu_gpr_d[r3], temp, cpu_gpr_d[r1], temp, n, 16);
         break;
     case OPC2_32_RR1_MUL_Q_64_L:
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
-        gen_mul_q(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp, n, 0);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
+        gen_mul_q(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp, n, 0);
         break;
     case OPC2_32_RR1_MUL_Q_32_U:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
         gen_mul_q(cpu_gpr_d[r3], temp, cpu_gpr_d[r1], temp, n, 16);
         break;
     case OPC2_32_RR1_MUL_Q_64_U:
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
-        gen_mul_q(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp, n, 0);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
+        gen_mul_q(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp, n, 0);
         break;
     case OPC2_32_RR1_MUL_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_mul_q_16(cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RR1_MUL_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_mul_q_16(cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RR1_MULR_Q_32_L:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_mulr_q(cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RR1_MULR_Q_32_U:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_mulr_q(cpu_gpr_d[r3], temp, temp2, n);
         break;
     default:
@@ -6498,7 +6499,7 @@ static void decode_rr2_mul(DisasContext *ctx)
         break;
     case OPC2_32_RR2_MUL_64:
         CHECK_REG_PAIR(r3);
-        gen_mul_i64s(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
+        gen_mul_i64s(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1],
                      cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR2_MULS_32:
@@ -6507,7 +6508,7 @@ static void decode_rr2_mul(DisasContext *ctx)
         break;
     case OPC2_32_RR2_MUL_U_64:
         CHECK_REG_PAIR(r3);
-        gen_mul_i64u(cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r1],
+        gen_mul_i64u(cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r1],
                      cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR2_MULS_U_32:
@@ -6537,16 +6538,16 @@ static void decode_rrpw_extract_insert(DisasContext *ctx)
     switch (op2) {
     case OPC2_32_RRPW_EXTR:
         if (width == 0) {
-            tcg_gen_movi_tl(cpu_gpr_d[r3], 0);
+            tcg_gen_movi_i32(cpu_gpr_d[r3], 0);
         } else if (pos + width <= 32) {
-            tcg_gen_sextract_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], pos, width);
+            tcg_gen_sextract_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], pos, width);
         }
         break;
     case OPC2_32_RRPW_EXTR_U:
         if (width == 0) {
-            tcg_gen_movi_tl(cpu_gpr_d[r3], 0);
+            tcg_gen_movi_i32(cpu_gpr_d[r3], 0);
         } else {
-            tcg_gen_extract_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], pos, width);
+            tcg_gen_extract_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], pos, width);
         }
         break;
     case OPC2_32_RRPW_IMASK:
@@ -6554,18 +6555,18 @@ static void decode_rrpw_extract_insert(DisasContext *ctx)
 
         if (pos + width <= 32) {
             temp = tcg_temp_new();
-            tcg_gen_movi_tl(temp, ((1u << width) - 1) << pos);
-            tcg_gen_shli_tl(cpu_gpr_d[r3], cpu_gpr_d[r2], pos);
-            tcg_gen_mov_tl(cpu_gpr_d[r3 + 1], temp);
+            tcg_gen_movi_i32(temp, ((1u << width) - 1) << pos);
+            tcg_gen_shli_i32(cpu_gpr_d[r3], cpu_gpr_d[r2], pos);
+            tcg_gen_mov_i32(cpu_gpr_d[r3 + 1], temp);
         }
 
         break;
     case OPC2_32_RRPW_INSERT:
-        /* tcg_gen_deposit_tl() does not handle the case of width = 0 */
+        /* tcg_gen_deposit_i32() does not handle the case of width = 0 */
         if (width == 0) {
-            tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+            tcg_gen_mov_i32(cpu_gpr_d[r3], cpu_gpr_d[r1]);
         } else if (pos + width <= 32) {
-            tcg_gen_deposit_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
+            tcg_gen_deposit_i32(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                                pos, width);
         }
         break;
@@ -6606,12 +6607,12 @@ static void decode_rrr_cond_select(DisasContext *ctx)
         break;
     case OPC2_32_RRR_SEL:
         temp = tcg_constant_i32(0);
-        tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
+        tcg_gen_movcond_i32(TCG_COND_NE, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
                            cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_SELN:
         temp = tcg_constant_i32(0);
-        tcg_gen_movcond_tl(TCG_COND_EQ, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
+        tcg_gen_movcond_i32(TCG_COND_EQ, cpu_gpr_d[r4], cpu_gpr_d[r3], temp,
                            cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     default:
@@ -6635,49 +6636,49 @@ static void decode_rrr_divide(DisasContext *ctx)
     case OPC2_32_RRR_DVADJ:
         CHECK_REG_PAIR(r3);
         CHECK_REG_PAIR(r4);
-        GEN_HELPER_RRR(dvadj, cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        GEN_HELPER_RRR(dvadj, cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_DVSTEP:
         CHECK_REG_PAIR(r3);
         CHECK_REG_PAIR(r4);
-        GEN_HELPER_RRR(dvstep, cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        GEN_HELPER_RRR(dvstep, cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_DVSTEP_U:
         CHECK_REG_PAIR(r3);
         CHECK_REG_PAIR(r4);
-        GEN_HELPER_RRR(dvstep_u, cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        GEN_HELPER_RRR(dvstep_u, cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_IXMAX:
         CHECK_REG_PAIR(r3);
         CHECK_REG_PAIR(r4);
-        GEN_HELPER_RRR(ixmax, cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        GEN_HELPER_RRR(ixmax, cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_IXMAX_U:
         CHECK_REG_PAIR(r3);
         CHECK_REG_PAIR(r4);
-        GEN_HELPER_RRR(ixmax_u, cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        GEN_HELPER_RRR(ixmax_u, cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_IXMIN:
         CHECK_REG_PAIR(r3);
         CHECK_REG_PAIR(r4);
-        GEN_HELPER_RRR(ixmin, cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        GEN_HELPER_RRR(ixmin, cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_IXMIN_U:
         CHECK_REG_PAIR(r3);
         CHECK_REG_PAIR(r4);
-        GEN_HELPER_RRR(ixmin_u, cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        GEN_HELPER_RRR(ixmin_u, cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR_PACK:
         CHECK_REG_PAIR(r3);
         gen_helper_pack(cpu_gpr_d[r4], cpu_PSW_C, cpu_gpr_d[r3],
-                        cpu_gpr_d[r3+1], cpu_gpr_d[r1]);
+                        cpu_gpr_d[r3 + 1], cpu_gpr_d[r1]);
         break;
     case OPC2_32_RRR_CRCN:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
@@ -6725,8 +6726,8 @@ static void decode_rrr2_madd(DisasContext *ctx)
     case OPC2_32_RRR2_MADD_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madd64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                     cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_madd64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                     cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MADDS_32:
         gen_helper_madd32_ssov(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
@@ -6735,14 +6736,14 @@ static void decode_rrr2_madd(DisasContext *ctx)
     case OPC2_32_RRR2_MADDS_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madds_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                     cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_madds_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                     cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MADD_U_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddu64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_maddu64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MADDS_U_32:
         gen_helper_madd32_suov(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
@@ -6751,8 +6752,8 @@ static void decode_rrr2_madd(DisasContext *ctx)
     case OPC2_32_RRR2_MADDS_U_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsu_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_maddsu_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6778,8 +6779,8 @@ static void decode_rrr2_msub(DisasContext *ctx)
     case OPC2_32_RRR2_MSUB_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msub64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                     cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_msub64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                     cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MSUBS_32:
         gen_helper_msub32_ssov(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
@@ -6788,14 +6789,14 @@ static void decode_rrr2_msub(DisasContext *ctx)
     case OPC2_32_RRR2_MSUBS_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubs_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                     cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_msubs_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                     cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MSUB_U_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubu64_d(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_msubu64_d(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RRR2_MSUBS_U_32:
         gen_helper_msub32_suov(cpu_gpr_d[r4], tcg_env, cpu_gpr_d[r1],
@@ -6804,8 +6805,8 @@ static void decode_rrr2_msub(DisasContext *ctx)
     case OPC2_32_RRR2_MSUBS_U_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubsu_64(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r1],
-                      cpu_gpr_d[r3], cpu_gpr_d[r3+1], cpu_gpr_d[r2]);
+        gen_msubsu_64(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r1],
+                      cpu_gpr_d[r3], cpu_gpr_d[r3 + 1], cpu_gpr_d[r2]);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
@@ -6829,98 +6830,98 @@ static void decode_rrr1_madd(DisasContext *ctx)
     case OPC2_32_RRR1_MADD_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADD_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADD_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADD_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_madd_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDS_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADDS_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADDS_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADDS_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_madds_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDM_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADDM_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADDM_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADDM_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_maddm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDMS_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADDMS_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADDMS_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADDMS_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_maddms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDR_H_LL:
         gen_maddr32_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
@@ -6983,61 +6984,61 @@ static void decode_rrr1_maddq_h(DisasContext *ctx)
     case OPC2_32_RRR1_MADD_Q_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madd64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_madd64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                      n);
         break;
     case OPC2_32_RRR1_MADD_Q_32_L:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
         gen_madd32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                      temp, n, 16);
         break;
     case OPC2_32_RRR1_MADD_Q_64_L:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
-        gen_madd64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
+        gen_madd64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                      n);
         break;
     case OPC2_32_RRR1_MADD_Q_32_U:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
         gen_madd32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                      temp, n, 16);
         break;
     case OPC2_32_RRR1_MADD_Q_64_U:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
-        gen_madd64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
+        gen_madd64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                      n);
         break;
     case OPC2_32_RRR1_MADD_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_m16add32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADD_Q_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
-        gen_m16add64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
+        gen_m16add64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADD_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_m16add32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADD_Q_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
-        gen_m16add64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
+        gen_m16add64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDS_Q_32:
         gen_madds32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
@@ -7046,90 +7047,90 @@ static void decode_rrr1_maddq_h(DisasContext *ctx)
     case OPC2_32_RRR1_MADDS_Q_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_madds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_madds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n);
         break;
     case OPC2_32_RRR1_MADDS_Q_32_L:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
         gen_madds32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                       temp, n, 16);
         break;
     case OPC2_32_RRR1_MADDS_Q_64_L:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
-        gen_madds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
+        gen_madds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                       n);
         break;
     case OPC2_32_RRR1_MADDS_Q_32_U:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
         gen_madds32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                       temp, n, 16);
         break;
     case OPC2_32_RRR1_MADDS_Q_64_U:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
-        gen_madds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
+        gen_madds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                       n);
         break;
     case OPC2_32_RRR1_MADDS_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_m16adds32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDS_Q_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
-        gen_m16adds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                        cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
+        gen_m16adds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                        cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDS_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_m16adds32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDS_Q_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
-        gen_m16adds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                        cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
+        gen_m16adds64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                        cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDR_H_64_UL:
         CHECK_REG_PAIR(r3);
-        gen_maddr64_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3+1],
+        gen_maddr64_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3 + 1],
                       cpu_gpr_d[r1], cpu_gpr_d[r2], n, 2);
         break;
     case OPC2_32_RRR1_MADDRS_H_64_UL:
         CHECK_REG_PAIR(r3);
-        gen_maddr64s_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3+1],
+        gen_maddr64s_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3 + 1],
                        cpu_gpr_d[r1], cpu_gpr_d[r2], n, 2);
         break;
     case OPC2_32_RRR1_MADDR_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_maddr_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDR_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_maddr_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDRS_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_maddrs_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MADDRS_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_maddrs_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     default:
@@ -7153,109 +7154,109 @@ static void decode_rrr1_maddsu_h(DisasContext *ctx)
     case OPC2_32_RRR1_MADDSU_H_32_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADDSU_H_32_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADDSU_H_32_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADDSU_H_32_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_maddsu_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDSUS_H_32_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADDSUS_H_32_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADDSUS_H_32_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADDSUS_H_32_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsus_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDSUM_H_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADDSUM_H_64_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADDSUM_H_64_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADDSUM_H_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsum_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDSUMS_H_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_LL);
         break;
     case OPC2_32_RRR1_MADDSUMS_H_64_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_LU);
         break;
     case OPC2_32_RRR1_MADDSUMS_H_64_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_UL);
         break;
     case OPC2_32_RRR1_MADDSUMS_H_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_maddsums_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_UU);
         break;
     case OPC2_32_RRR1_MADDSUR_H_16_LL:
@@ -7311,98 +7312,98 @@ static void decode_rrr1_msub(DisasContext *ctx)
     case OPC2_32_RRR1_MSUB_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUB_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUB_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUB_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                   cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_msub_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                   cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBS_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUBS_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUBS_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUBS_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_msubs_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBM_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUBM_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUBM_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUBM_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                    cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_msubm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                    cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBMS_H_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUBMS_H_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUBMS_H_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUBMS_H_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_msubms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBR_H_LL:
         gen_msubr32_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
@@ -7465,61 +7466,61 @@ static void decode_rrr1_msubq_h(DisasContext *ctx)
     case OPC2_32_RRR1_MSUB_Q_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                      n);
         break;
     case OPC2_32_RRR1_MSUB_Q_32_L:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
         gen_msub32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                      temp, n, 16);
         break;
     case OPC2_32_RRR1_MSUB_Q_64_L:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
-        gen_msub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
+        gen_msub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                      n);
         break;
     case OPC2_32_RRR1_MSUB_Q_32_U:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
         gen_msub32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                      temp, n, 16);
         break;
     case OPC2_32_RRR1_MSUB_Q_64_U:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
-        gen_msub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
+        gen_msub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                      n);
         break;
     case OPC2_32_RRR1_MSUB_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_m16sub32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUB_Q_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
-        gen_m16sub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
+        gen_m16sub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUB_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_m16sub32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUB_Q_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
-        gen_m16sub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
+        gen_m16sub64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBS_Q_32:
         gen_msubs32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
@@ -7528,90 +7529,90 @@ static void decode_rrr1_msubq_h(DisasContext *ctx)
     case OPC2_32_RRR1_MSUBS_Q_64:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n);
         break;
     case OPC2_32_RRR1_MSUBS_Q_32_L:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
         gen_msubs32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                       temp, n, 16);
         break;
     case OPC2_32_RRR1_MSUBS_Q_64_L:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r2]);
-        gen_msubs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r2]);
+        gen_msubs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                       n);
         break;
     case OPC2_32_RRR1_MSUBS_Q_32_U:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
         gen_msubs32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r1],
                       temp, n, 16);
         break;
     case OPC2_32_RRR1_MSUBS_Q_64_U:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r2], 16);
-        gen_msubs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], temp,
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r2], 16);
+        gen_msubs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], temp,
                       n);
         break;
     case OPC2_32_RRR1_MSUBS_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_m16subs32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBS_Q_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
-        gen_m16subs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                        cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
+        gen_m16subs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                        cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBS_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_m16subs32_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBS_Q_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
-        gen_m16subs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                        cpu_gpr_d[r3+1], temp, temp2, n);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
+        gen_m16subs64_q(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                        cpu_gpr_d[r3 + 1], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBR_H_64_UL:
         CHECK_REG_PAIR(r3);
-        gen_msubr64_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3+1],
+        gen_msubr64_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3 + 1],
                       cpu_gpr_d[r1], cpu_gpr_d[r2], n, 2);
         break;
     case OPC2_32_RRR1_MSUBRS_H_64_UL:
         CHECK_REG_PAIR(r3);
-        gen_msubr64s_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3+1],
+        gen_msubr64s_h(cpu_gpr_d[r4], cpu_gpr_d[r3], cpu_gpr_d[r3 + 1],
                        cpu_gpr_d[r1], cpu_gpr_d[r2], n, 2);
         break;
     case OPC2_32_RRR1_MSUBR_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_msubr_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBR_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_msubr_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBRS_Q_32_LL:
-        tcg_gen_ext16s_tl(temp, cpu_gpr_d[r1]);
-        tcg_gen_ext16s_tl(temp2, cpu_gpr_d[r2]);
+        tcg_gen_ext16s_i32(temp, cpu_gpr_d[r1]);
+        tcg_gen_ext16s_i32(temp2, cpu_gpr_d[r2]);
         gen_msubrs_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     case OPC2_32_RRR1_MSUBRS_Q_32_UU:
-        tcg_gen_sari_tl(temp, cpu_gpr_d[r1], 16);
-        tcg_gen_sari_tl(temp2, cpu_gpr_d[r2], 16);
+        tcg_gen_sari_i32(temp, cpu_gpr_d[r1], 16);
+        tcg_gen_sari_i32(temp2, cpu_gpr_d[r2], 16);
         gen_msubrs_q(cpu_gpr_d[r4], cpu_gpr_d[r3], temp, temp2, n);
         break;
     default:
@@ -7635,109 +7636,109 @@ static void decode_rrr1_msubad_h(DisasContext *ctx)
     case OPC2_32_RRR1_MSUBAD_H_32_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
+        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUBAD_H_32_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
+        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUBAD_H_32_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
+        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUBAD_H_32_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                     cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
+        gen_msubad_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                     cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2], n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBADS_H_32_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUBADS_H_32_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUBADS_H_32_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUBADS_H_32_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubads_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBADM_H_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUBADM_H_64_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUBADM_H_64_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUBADM_H_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                      cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadm_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                      cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                       n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBADMS_H_64_LL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_LL);
         break;
     case OPC2_32_RRR1_MSUBADMS_H_64_LU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_LU);
         break;
     case OPC2_32_RRR1_MSUBADMS_H_64_UL:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_UL);
         break;
     case OPC2_32_RRR1_MSUBADMS_H_64_UU:
         CHECK_REG_PAIR(r4);
         CHECK_REG_PAIR(r3);
-        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4+1], cpu_gpr_d[r3],
-                       cpu_gpr_d[r3+1], cpu_gpr_d[r1], cpu_gpr_d[r2],
+        gen_msubadms_h(cpu_gpr_d[r4], cpu_gpr_d[r4 + 1], cpu_gpr_d[r3],
+                       cpu_gpr_d[r3 + 1], cpu_gpr_d[r1], cpu_gpr_d[r2],
                        n, MODE_UU);
         break;
     case OPC2_32_RRR1_MSUBADR_H_16_LL:
@@ -7795,43 +7796,43 @@ static void decode_rrrr_extract_insert(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RRRR_DEXTR:
-        tcg_gen_andi_tl(tmp_pos, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_andi_i32(tmp_pos, cpu_gpr_d[r3], 0x1f);
         if (r1 == r2) {
-            tcg_gen_rotl_tl(cpu_gpr_d[r4], cpu_gpr_d[r1], tmp_pos);
+            tcg_gen_rotl_i32(cpu_gpr_d[r4], cpu_gpr_d[r1], tmp_pos);
         } else {
             TCGv msw = tcg_temp_new();
-            TCGv zero = tcg_constant_tl(0);
-            tcg_gen_shl_tl(tmp_width, cpu_gpr_d[r1], tmp_pos);
-            tcg_gen_subfi_tl(msw, 32, tmp_pos);
-            tcg_gen_shr_tl(msw, cpu_gpr_d[r2], msw);
+            TCGv zero = tcg_constant_i32(0);
+            tcg_gen_shl_i32(tmp_width, cpu_gpr_d[r1], tmp_pos);
+            tcg_gen_subfi_i32(msw, 32, tmp_pos);
+            tcg_gen_shr_i32(msw, cpu_gpr_d[r2], msw);
             /*
              * if pos == 0, then we do cpu_gpr_d[r2] << 32, which is undefined
              * behaviour. So check that case here and set the low bits to zero
              * which effectivly returns cpu_gpr_d[r1]
              */
-            tcg_gen_movcond_tl(TCG_COND_EQ, msw, tmp_pos, zero, zero, msw);
-            tcg_gen_or_tl(cpu_gpr_d[r4], tmp_width, msw);
+            tcg_gen_movcond_i32(TCG_COND_EQ, msw, tmp_pos, zero, zero, msw);
+            tcg_gen_or_i32(cpu_gpr_d[r4], tmp_width, msw);
         }
         break;
     case OPC2_32_RRRR_EXTR:
     case OPC2_32_RRRR_EXTR_U:
         CHECK_REG_PAIR(r3);
-        tcg_gen_andi_tl(tmp_width, cpu_gpr_d[r3+1], 0x1f);
-        tcg_gen_andi_tl(tmp_pos, cpu_gpr_d[r3], 0x1f);
-        tcg_gen_add_tl(tmp_pos, tmp_pos, tmp_width);
-        tcg_gen_subfi_tl(tmp_pos, 32, tmp_pos);
-        tcg_gen_shl_tl(cpu_gpr_d[r4], cpu_gpr_d[r1], tmp_pos);
-        tcg_gen_subfi_tl(tmp_width, 32, tmp_width);
+        tcg_gen_andi_i32(tmp_width, cpu_gpr_d[r3 + 1], 0x1f);
+        tcg_gen_andi_i32(tmp_pos, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_add_i32(tmp_pos, tmp_pos, tmp_width);
+        tcg_gen_subfi_i32(tmp_pos, 32, tmp_pos);
+        tcg_gen_shl_i32(cpu_gpr_d[r4], cpu_gpr_d[r1], tmp_pos);
+        tcg_gen_subfi_i32(tmp_width, 32, tmp_width);
         if (op2 == OPC2_32_RRRR_EXTR) {
-            tcg_gen_sar_tl(cpu_gpr_d[r4], cpu_gpr_d[r4], tmp_width);
+            tcg_gen_sar_i32(cpu_gpr_d[r4], cpu_gpr_d[r4], tmp_width);
         } else {
-            tcg_gen_shr_tl(cpu_gpr_d[r4], cpu_gpr_d[r4], tmp_width);
+            tcg_gen_shr_i32(cpu_gpr_d[r4], cpu_gpr_d[r4], tmp_width);
         }
         break;
     case OPC2_32_RRRR_INSERT:
         CHECK_REG_PAIR(r3);
-        tcg_gen_andi_tl(tmp_width, cpu_gpr_d[r3+1], 0x1f);
-        tcg_gen_andi_tl(tmp_pos, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_andi_i32(tmp_width, cpu_gpr_d[r3 + 1], 0x1f);
+        tcg_gen_andi_i32(tmp_pos, cpu_gpr_d[r3], 0x1f);
         gen_insert(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r2], tmp_width,
                    tmp_pos);
         break;
@@ -7860,35 +7861,35 @@ static void decode_rrrw_extract_insert(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_RRRW_EXTR:
-        tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
-        tcg_gen_addi_tl(temp, temp, width);
-        tcg_gen_subfi_tl(temp, 32, temp);
-        tcg_gen_shl_tl(cpu_gpr_d[r4], cpu_gpr_d[r1], temp);
-        tcg_gen_sari_tl(cpu_gpr_d[r4], cpu_gpr_d[r4], 32 - width);
+        tcg_gen_andi_i32(temp, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_addi_i32(temp, temp, width);
+        tcg_gen_subfi_i32(temp, 32, temp);
+        tcg_gen_shl_i32(cpu_gpr_d[r4], cpu_gpr_d[r1], temp);
+        tcg_gen_sari_i32(cpu_gpr_d[r4], cpu_gpr_d[r4], 32 - width);
         break;
     case OPC2_32_RRRW_EXTR_U:
         if (width == 0) {
-            tcg_gen_movi_tl(cpu_gpr_d[r4], 0);
+            tcg_gen_movi_i32(cpu_gpr_d[r4], 0);
         } else {
-            tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
-            tcg_gen_shr_tl(cpu_gpr_d[r4], cpu_gpr_d[r1], temp);
-            tcg_gen_andi_tl(cpu_gpr_d[r4], cpu_gpr_d[r4], ~0u >> (32-width));
+            tcg_gen_andi_i32(temp, cpu_gpr_d[r3], 0x1f);
+            tcg_gen_shr_i32(cpu_gpr_d[r4], cpu_gpr_d[r1], temp);
+            tcg_gen_andi_i32(cpu_gpr_d[r4], cpu_gpr_d[r4], ~0u >> (32 - width));
         }
         break;
     case OPC2_32_RRRW_IMASK:
         temp2 = tcg_temp_new();
         CHECK_REG_PAIR(r4);
-        tcg_gen_andi_tl(temp, cpu_gpr_d[r3], 0x1f);
-        tcg_gen_movi_tl(temp2, (1 << width) - 1);
-        tcg_gen_shl_tl(temp2, temp2, temp);
-        tcg_gen_shl_tl(cpu_gpr_d[r4], cpu_gpr_d[r2], temp);
-        tcg_gen_mov_tl(cpu_gpr_d[r4+1], temp2);
+        tcg_gen_andi_i32(temp, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_movi_i32(temp2, (1 << width) - 1);
+        tcg_gen_shl_i32(temp2, temp2, temp);
+        tcg_gen_shl_i32(cpu_gpr_d[r4], cpu_gpr_d[r2], temp);
+        tcg_gen_mov_i32(cpu_gpr_d[r4 + 1], temp2);
         break;
     case OPC2_32_RRRW_INSERT:
         temp2 = tcg_temp_new();
 
-        tcg_gen_movi_tl(temp, width);
-        tcg_gen_andi_tl(temp2, cpu_gpr_d[r3], 0x1f);
+        tcg_gen_movi_i32(temp, width);
+        tcg_gen_andi_i32(temp2, cpu_gpr_d[r3], 0x1f);
         gen_insert(cpu_gpr_d[r4], cpu_gpr_d[r1], cpu_gpr_d[r2], temp, temp2);
         break;
     default:
@@ -7913,7 +7914,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_DISABLE:
         if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
-            tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+            tcg_gen_andi_i32(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
         } else {
             generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
         }
@@ -7921,9 +7922,9 @@ static void decode_sys_interrupts(DisasContext *ctx)
     case OPC2_32_SYS_DISABLE_D:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
-                tcg_gen_extract_tl(cpu_gpr_d[r1], cpu_ICR,
+                tcg_gen_extract_i32(cpu_gpr_d[r1], cpu_ICR,
                         ctx->icr_ie_offset, 1);
-                tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
+                tcg_gen_andi_i32(cpu_ICR, cpu_ICR, ~ctx->icr_ie_mask);
             } else {
                 generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
             }
@@ -7934,7 +7935,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_ENABLE:
         if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
-            tcg_gen_ori_tl(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
+            tcg_gen_ori_i32(cpu_ICR, cpu_ICR, ctx->icr_ie_mask);
             ctx->base.is_jmp = DISAS_EXIT_UPDATE;
         } else {
             generate_trap(ctx, TRAPC_PROT, TIN1_PRIV);
@@ -7960,8 +7961,8 @@ static void decode_sys_interrupts(DisasContext *ctx)
             l1 = gen_new_label();
 
             tcg_gen_ld_i32(tmp, tcg_env, offsetof(CPUTriCoreState, DBGSR));
-            tcg_gen_andi_tl(tmp, tmp, MASK_DBGSR_DE);
-            tcg_gen_brcondi_tl(TCG_COND_NE, tmp, 1, l1);
+            tcg_gen_andi_i32(tmp, tmp, MASK_DBGSR_DE);
+            tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 1, l1);
             gen_helper_rfm(tcg_env);
             gen_set_label(l1);
             ctx->base.is_jmp = DISAS_EXIT;
@@ -7978,7 +7979,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
     case OPC2_32_SYS_RESTORE:
         if (has_feature(ctx, TRICORE_FEATURE_16)) {
             if (ctx->priv == TRICORE_PRIV_SM || ctx->priv == TRICORE_PRIV_UM1) {
-                tcg_gen_deposit_tl(cpu_ICR, cpu_ICR, cpu_gpr_d[r1],
+                tcg_gen_deposit_i32(cpu_ICR, cpu_ICR, cpu_gpr_d[r1],
                         ctx->icr_ie_offset, 1);
                 ctx->base.is_jmp = DISAS_EXIT_UPDATE;
             } else {
@@ -7990,13 +7991,13 @@ static void decode_sys_interrupts(DisasContext *ctx)
         break;
     case OPC2_32_SYS_TRAPSV:
         l1 = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_GE, cpu_PSW_SV, 0, l1);
+        tcg_gen_brcondi_i32(TCG_COND_GE, cpu_PSW_SV, 0, l1);
         generate_trap(ctx, TRAPC_ASSERT, TIN5_SOVF);
         gen_set_label(l1);
         break;
     case OPC2_32_SYS_TRAPV:
         l1 = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_GE, cpu_PSW_V, 0, l1);
+        tcg_gen_brcondi_i32(TCG_COND_GE, cpu_PSW_V, 0, l1);
         generate_trap(ctx, TRAPC_ASSERT, TIN5_OVF);
         gen_set_label(l1);
         break;
@@ -8047,16 +8048,16 @@ static void decode_32Bit_opc(DisasContext *ctx)
         temp = tcg_constant_i32(EA_ABS_FORMAT(address));
         temp2 = tcg_temp_new();
 
-        tcg_gen_shri_tl(temp2, cpu_gpr_d[r1], 16);
-        tcg_gen_qemu_st_tl(temp2, temp, ctx->mem_idx, MO_LEUW);
+        tcg_gen_shri_i32(temp2, cpu_gpr_d[r1], 16);
+        tcg_gen_qemu_st_i32(temp2, temp, ctx->mem_idx, MO_LEUW);
         break;
     case OPC1_32_ABS_LD_Q:
         address = MASK_OP_ABS_OFF18(ctx->opcode);
         r1 = MASK_OP_ABS_S1D(ctx->opcode);
         temp = tcg_constant_i32(EA_ABS_FORMAT(address));
 
-        tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUW);
-        tcg_gen_shli_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
+        tcg_gen_qemu_ld_i32(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUW);
+        tcg_gen_shli_i32(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
         break;
     case OPCM_32_ABS_LEA_LHA:
         address = MASK_OP_ABS_OFF18(ctx->opcode);
@@ -8065,13 +8066,13 @@ static void decode_32Bit_opc(DisasContext *ctx)
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
             op2 = MASK_OP_ABS_OP2(ctx->opcode);
             if (op2 == OPC2_32_ABS_LHA) {
-                tcg_gen_movi_tl(cpu_gpr_a[r1], address << 14);
+                tcg_gen_movi_i32(cpu_gpr_a[r1], address << 14);
                 break;
             }
             /* otherwise translate regular LEA */
         }
 
-        tcg_gen_movi_tl(cpu_gpr_a[r1], EA_ABS_FORMAT(address));
+        tcg_gen_movi_i32(cpu_gpr_a[r1], EA_ABS_FORMAT(address));
         break;
 /* ABSB-format */
     case OPC1_32_ABSB_ST_T:
@@ -8082,10 +8083,10 @@ static void decode_32Bit_opc(DisasContext *ctx)
         temp = tcg_constant_i32(EA_ABS_FORMAT(address));
         temp2 = tcg_temp_new();
 
-        tcg_gen_qemu_ld_tl(temp2, temp, ctx->mem_idx, MO_UB);
-        tcg_gen_andi_tl(temp2, temp2, ~(0x1u << bpos));
-        tcg_gen_ori_tl(temp2, temp2, (b << bpos));
-        tcg_gen_qemu_st_tl(temp2, temp, ctx->mem_idx, MO_UB);
+        tcg_gen_qemu_ld_i32(temp2, temp, ctx->mem_idx, MO_UB);
+        tcg_gen_andi_i32(temp2, temp2, ~(0x1u << bpos));
+        tcg_gen_ori_i32(temp2, temp2, (b << bpos));
+        tcg_gen_qemu_st_i32(temp2, temp, ctx->mem_idx, MO_UB);
         break;
 /* B-format */
     case OPC1_32_B_CALL:
@@ -8212,8 +8213,8 @@ static void decode_32Bit_opc(DisasContext *ctx)
 
         CHECK_REG_PAIR(r2);
 
-        tcg_gen_andi_tl(temp2, cpu_gpr_d[r2 + 1], 0x1f);
-        tcg_gen_andi_tl(temp3, cpu_gpr_d[r2], 0x1f);
+        tcg_gen_andi_i32(temp2, cpu_gpr_d[r2 + 1], 0x1f);
+        tcg_gen_andi_i32(temp3, cpu_gpr_d[r2], 0x1f);
 
         gen_insert(cpu_gpr_d[r3], cpu_gpr_d[r1], temp, temp2, temp3);
         break;
@@ -8281,7 +8282,7 @@ static void decode_32Bit_opc(DisasContext *ctx)
         r3 = MASK_OP_RRPW_D(ctx->opcode);
         const16 = MASK_OP_RRPW_POS(ctx->opcode);
 
-        tcg_gen_extract2_tl(cpu_gpr_d[r3], cpu_gpr_d[r2], cpu_gpr_d[r1],
+        tcg_gen_extract2_i32(cpu_gpr_d[r3], cpu_gpr_d[r2], cpu_gpr_d[r1],
                             32 - const16);
         break;
 /* RRR Format */
@@ -8330,10 +8331,10 @@ static void decode_32Bit_opc(DisasContext *ctx)
         decode_sys_interrupts(ctx);
         break;
     case OPC1_32_SYS_RSTV:
-        tcg_gen_movi_tl(cpu_PSW_V, 0);
-        tcg_gen_mov_tl(cpu_PSW_SV, cpu_PSW_V);
-        tcg_gen_mov_tl(cpu_PSW_AV, cpu_PSW_V);
-        tcg_gen_mov_tl(cpu_PSW_SAV, cpu_PSW_V);
+        tcg_gen_movi_i32(cpu_PSW_V, 0);
+        tcg_gen_mov_i32(cpu_PSW_SV, cpu_PSW_V);
+        tcg_gen_mov_i32(cpu_PSW_AV, cpu_PSW_V);
+        tcg_gen_mov_i32(cpu_PSW_SAV, cpu_PSW_V);
         break;
     default:
         generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
-- 
2.51.0


