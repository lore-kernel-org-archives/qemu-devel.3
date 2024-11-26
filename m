Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423F9D3B98D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvQb-0008FQ-KR; Tue, 26 Nov 2024 08:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQL-00080o-PJ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:15 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQI-0003a3-8y
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:12 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-382296631f1so4476595f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626968; x=1733231768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIU8a98mE/FRheV+tK1HZL4BvggUU/5/laC5qfhy/+w=;
 b=rsMAmeR3B79wLu/aaPluJD06mcjlUt8d26QNpzn5lfAGjEpL86cXQa87dVzCjBVBYX
 DAdwfdBNr7CNUy1x/cb1RgbGOuITDol1moJsyp4cFPhHXCZ6Rm+SwUMo0e1xfwWSWFHy
 53YOsu6wdKloX8F4tuJE5Tnn3nz4Om97eehGTSACUlpBpsgeVb/llLS3zUwZ+r3q23Yn
 c+8GdPY6AmWdAxeByWapk0t2qyZxzFffM1LkLSnS6B8sKI+VAjsqMTtENzUv34B1w1Es
 YyLLnI4JGYYjLfc+GUdWVHLSFs3u2ICLLj/1eK5ohOMbhIilLFMRRvzePpIxHtQMGrDN
 iMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626968; x=1733231768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIU8a98mE/FRheV+tK1HZL4BvggUU/5/laC5qfhy/+w=;
 b=ENXRpUEDbqqPaaSEncBNl379TRdHfznGnn1UnET7QjFyhvDgcEd8gCCXjom09rZegU
 /D035BjCvHzCifiswuo1TBAdcljtLKeqnfkr9Refywnot2EPYvXLPLTEvp07yKooLDP4
 YsfG0cxDeeycTKBdYMUDQQPF/zIl8IWavy0GhF/Kq01wd9iU8bCpSHAiovh1lNdMcdEH
 P9jfOSLR8c6+8Cfr2iciyE1jraTs/dW9JhOoss4UCgi+fR5MYNv3y0ObE3/Hc56xnfjI
 oYkPPLFzzAaHo755bpJH2gg+MjG5TSiJvxjJlxeo92B8CH1Y5bNyDmUXLPw0O2uP5qt8
 28rA==
X-Gm-Message-State: AOJu0Yz5pRJ8++RcOV+Sy2cNNrs4MXqMQlQhwGck4a5WxCMkLpz1aSeH
 8iuJ95Z3F712AcOoNqeXGREJB4zNnJYzkVJc/D6cnAvCVy2am7XrHfR8VzpJE/EYlMeCnddrCh4
 h
X-Gm-Gg: ASbGncuC7s2cbxHjh2dsE0u4zx+jYZTV2P9Xp2WTMEpuYouaf6UxkpABuQN+aLtixL+
 cu0ql9lFK1znTeSOxnIY2BQUq4oyOEyttOO92+oJUrtwXoL7fGVgvdSkGlT7O77NQ4DPgbwtQWO
 9q5EtxbHDMgZWnJYLcpt4y16KpEgb7ym2Gdlw4C/SBSFpPi7MXda/h7muPSViOwqWdm1hGMFXj5
 LvpF6Rv1L/Xi6jfq6E6jxHitHr2Wy+T09Lc+TdHlKRpH2mpZxXG620vezoQui2rciirjK1H
X-Google-Smtp-Source: AGHT+IFTwKPCuTrfX3b/KNVdvjfRL7TafZM2fQKaWcI1i6H/RTEaVmpf5ygdT0PP0qfX4lITn8bE2A==
X-Received: by 2002:a05:6000:188f:b0:382:4493:ff8f with SMTP id
 ffacd0b85a97d-38260bcb030mr11922974f8f.43.1732626968073; 
 Tue, 26 Nov 2024 05:16:08 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349d8b6da4sm89347545e9.24.2024.11.26.05.16.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 03/13] target/mips: Rename gen_move_low32() ->
 gen_move_low32_tl()
Date: Tue, 26 Nov 2024 14:15:35 +0100
Message-ID: <20241126131546.66145-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

MIPS gen_move_low32() takes a target-specific TCGv argument.
Rename it as gen_move_low32_tl() to clarify, like other TCG
core helpers.

Mechanical change doing:

  $ sed -i -e 's/gen_move_low32/gen_move_low32_tl/' \
     $(git grep -l gen_move_low32)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h              |  2 +-
 target/mips/tcg/mxu_translate.c          |  2 +-
 target/mips/tcg/translate.c              | 30 ++++++++++++------------
 target/mips/tcg/nanomips_translate.c.inc |  8 +++----
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 49f174d3617..6437180d891 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -153,7 +153,7 @@ void check_cp1_registers(DisasContext *ctx, int regs);
 void check_cop1x(DisasContext *ctx);
 
 void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
-void gen_move_low32(TCGv ret, TCGv_i64 arg);
+void gen_move_low32_tl(TCGv ret, TCGv_i64 arg);
 void gen_move_high32(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
 void gen_store_gpr_tl(TCGv t, int reg);
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 9525aebc053..94aa137cb25 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -4385,7 +4385,7 @@ static void gen_mxu_s32madd_sub(DisasContext *ctx, bool sub, bool uns)
         } else {
             tcg_gen_add_i64(t3, t3, t2);
         }
-        gen_move_low32(t1, t3);
+        gen_move_low32_tl(t1, t3);
         gen_move_high32(t0, t3);
 
         tcg_gen_mov_tl(cpu_HI[0], t0);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 629846a596d..5e776136f09 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1452,7 +1452,7 @@ static target_long addr_add(DisasContext *ctx, target_long base,
 }
 
 /* Sign-extract the low 32-bits to a target_long.  */
-void gen_move_low32(TCGv ret, TCGv_i64 arg)
+void gen_move_low32_tl(TCGv ret, TCGv_i64 arg)
 {
 #if defined(TARGET_MIPS64)
     tcg_gen_ext32s_i64(ret, arg);
@@ -3341,7 +3341,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
-            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_low32_tl(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
         }
         break;
@@ -3357,7 +3357,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
-            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_low32_tl(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
         }
         break;
@@ -3371,7 +3371,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_sub_i64(t2, t3, t2);
-            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_low32_tl(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
         }
         break;
@@ -3387,7 +3387,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_sub_i64(t2, t3, t2);
-            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_low32_tl(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
         }
         break;
@@ -3482,10 +3482,10 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
-            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_low32_tl(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
             if (rd) {
-                gen_move_low32(cpu_gpr[rd], t2);
+                gen_move_low32_tl(cpu_gpr[rd], t2);
             }
         }
         break;
@@ -3504,10 +3504,10 @@ static void gen_mul_txx9(DisasContext *ctx, uint32_t opc,
             tcg_gen_mul_i64(t2, t2, t3);
             tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
             tcg_gen_add_i64(t2, t2, t3);
-            gen_move_low32(cpu_LO[acc], t2);
+            gen_move_low32_tl(cpu_LO[acc], t2);
             gen_move_high32(cpu_HI[acc], t2);
             if (rd) {
-                gen_move_low32(cpu_gpr[rd], t2);
+                gen_move_low32_tl(cpu_gpr[rd], t2);
             }
         }
         break;
@@ -4787,7 +4787,7 @@ static void gen_align_bits(DisasContext *ctx, int wordsz, int rd, int rs,
                 TCGv_i64 t2 = tcg_temp_new_i64();
                 tcg_gen_concat_tl_i64(t2, t1, t0);
                 tcg_gen_shri_i64(t2, t2, 32 - bits);
-                gen_move_low32(cpu_gpr[rd], t2);
+                gen_move_low32_tl(cpu_gpr[rd], t2);
             }
             break;
 #if defined(TARGET_MIPS64)
@@ -4865,7 +4865,7 @@ static inline void gen_mfhc0_entrylo(TCGv arg, target_ulong off)
 #else
     tcg_gen_shri_i64(t0, t0, 32);
 #endif
-    gen_move_low32(arg, t0);
+    gen_move_low32_tl(arg, t0);
 }
 
 static inline void gen_mfhc0_load64(TCGv arg, target_ulong off, int shift)
@@ -4874,7 +4874,7 @@ static inline void gen_mfhc0_load64(TCGv arg, target_ulong off, int shift)
 
     tcg_gen_ld_i64(t0, tcg_env, off);
     tcg_gen_shri_i64(t0, t0, 32 + shift);
-    gen_move_low32(arg, t0);
+    gen_move_low32_tl(arg, t0);
 }
 
 static inline void gen_mfc0_load32(TCGv arg, target_ulong off)
@@ -5195,7 +5195,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                     tcg_gen_deposit_tl(tmp, tmp, arg, 30, 2);
                 }
 #endif
-                gen_move_low32(arg, tmp);
+                gen_move_low32_tl(arg, tmp);
             }
             register_name = "EntryLo0";
             break;
@@ -5252,7 +5252,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                     tcg_gen_deposit_tl(tmp, tmp, arg, 30, 2);
                 }
 #endif
-                gen_move_low32(arg, tmp);
+                gen_move_low32_tl(arg, tmp);
             }
             register_name = "EntryLo1";
             break;
@@ -5769,7 +5769,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             {
                 TCGv_i64 tmp = tcg_temp_new_i64();
                 tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUMIPSState, CP0_TagLo));
-                gen_move_low32(arg, tmp);
+                gen_move_low32_tl(arg, tmp);
             }
             register_name = "TagLo";
             break;
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 31a31c00979..5a4a64f3609 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1816,7 +1816,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_mul_i64(t2, t2, t3);
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_add_i64(t2, t2, t3);
-                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_low32_tl(cpu_LO[acc], t2);
                 gen_move_high32(cpu_HI[acc], t2);
             }
             break;
@@ -1871,7 +1871,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_mul_i64(t2, t2, t3);
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_add_i64(t2, t2, t3);
-                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_low32_tl(cpu_LO[acc], t2);
                 gen_move_high32(cpu_HI[acc], t2);
             }
             break;
@@ -1932,7 +1932,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_mul_i64(t2, t2, t3);
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_sub_i64(t2, t3, t2);
-                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_low32_tl(cpu_LO[acc], t2);
                 gen_move_high32(cpu_HI[acc], t2);
             }
             break;
@@ -1973,7 +1973,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
                 tcg_gen_mul_i64(t2, t2, t3);
                 tcg_gen_concat_tl_i64(t3, cpu_LO[acc], cpu_HI[acc]);
                 tcg_gen_sub_i64(t2, t3, t2);
-                gen_move_low32(cpu_LO[acc], t2);
+                gen_move_low32_tl(cpu_LO[acc], t2);
                 gen_move_high32(cpu_HI[acc], t2);
             }
             break;
-- 
2.45.2


