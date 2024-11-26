Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40444D3B990
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw7E-0002ge-Ss; Tue, 26 Nov 2024 09:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw73-0002fj-7L
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:23 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw70-00056f-VA
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:00:20 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3823e45339bso4137159f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629617; x=1733234417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ujfkvO8LZuywqD2+o/XmPcEkRI4UkLalyohmosFyZI=;
 b=Mn1R0YQBC1GkE3GCaNs/CtSy2YkdtfUjUncTopAJ/Z3jzWC3aO76zUUE3I3/rU6C4A
 8wwtOR0bgldcml2xl6Td7YLXcxuSxamuiePWuJnz6e4Fx/sWPXAMv9l4sHvMN5jpVps4
 VcaUYvrxy07JCsopx2EKwmv3oGqSda7yevbYUehxH8+d5P3HIkd6cyB5l6S4nwxJoahI
 NRVZhuW8Ov+OabhqOePRaNioKciYX2LJHNskm4mhycuFlfb03SctfMX+Ywa2M+R3Qb7X
 DQFar1mH9TGZeLXdG1Hwf09yJUi5+Hh9B3pEJw2mJnn4zmmBVXYk8546BfOksotK1yyw
 p4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629617; x=1733234417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ujfkvO8LZuywqD2+o/XmPcEkRI4UkLalyohmosFyZI=;
 b=GPsyrHO2KZ7goeJ4O7FA45xvacBoFRLPg1gDUd21T6b7UIbKcx2DNryJQmOt3HVmbC
 suvWIQnzUApNKHc6mdMQN9lCpk6tRn0Sb7uxm6URVXX+E6Ph32i7qRP6dBHLTzP4sHDR
 ogryPfZ9TILUcg1KIS8bhulhUgt4h7b4KGJnKke2TLyjKsDPY6+8dqLc2Rpy2n8f09VB
 XpTzcCTUvPTblmtjIV4CEKw+CwYamA0flIph6p/FXzbWe3WyEo5wQqe67ZVNy+jD1OSx
 Js/hKgQUX2VTWbM/GdfyHZFHeNjvRRUeKktRw8T4geGR0TIFoGMOMJijKOQ6HaGcw6ss
 016g==
X-Gm-Message-State: AOJu0Yy5NNDe+VJ4a/Wh9/bMaYITFxpO9BNgUU5QuTrFVH3C5z94eR9p
 SuIuWG5xyJ4e/PE7lU+KIH9zQvK/SypYdfuQ+xS1YojUmI1VEIG/tYXGFW5lDGpyBM2llwTEQu5
 I
X-Gm-Gg: ASbGncuWnyoaNX1k3nAogJon+//vb5uY7YRTxzlK/7X2bq5lTAZDSw4oX1xWnjdq8Zt
 JgmFla2TSUZvze/4ICiX21fzaRL2lgYd+7+zqML0/BQnR0kFRld47scXhEXqZueG7YzYveNdYYF
 /krc/bUULakpZKXzqQ+LBZu6mXEzWcOxJJ2vn74VEkzBagsRvr68e+mYqZmAdxwI+ZxPYitwJpB
 R0ZXFZJzLVKKV9LejK3k5UicXV7uwVvl3ag1zpvA3CkgkZ2A7nBQj+iOmecPvKySrP8W79IbWM8
 tQ==
X-Google-Smtp-Source: AGHT+IG/Po5xF2SRvZV9/HyACVwnn/9kaWLClUntF4IDQqJ4L1LNWUnMOuBVoL+Y5YK88PrLkpT+6g==
X-Received: by 2002:a05:6000:178b:b0:382:488d:dfd1 with SMTP id
 ffacd0b85a97d-38260bcb8e6mr15573760f8f.44.1732629616998; 
 Tue, 26 Nov 2024 06:00:16 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad641fsm13368600f8f.20.2024.11.26.06.00.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:00:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 02/16] target/mips: Extract generic gen_lx() helper
Date: Tue, 26 Nov 2024 14:59:48 +0100
Message-ID: <20241126140003.74871-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Extract gen_lx() from gen_mips_lx(); inline the Octeon
check in decode_opc_special3_legacy().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241111222936.59869-3-philmd@linaro.org>
---
 target/mips/tcg/translate.h |  1 +
 target/mips/tcg/translate.c | 55 +++++++++++++------------------------
 2 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index ed69ba15e58..a65ab4a747c 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -168,6 +168,7 @@ void gen_store_fpr32(DisasContext *ctx, TCGv_i32 t, int reg);
 void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg);
 int get_fp_bit(int cc);
 
+void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop);
 void gen_ldxs(DisasContext *ctx, int base, int index, int rd);
 void gen_align(DisasContext *ctx, int wordsz, int rd, int rs, int rt, int bp);
 void gen_addiupc(DisasContext *ctx, int rx, int imm,
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 7152f5418e1..acadd3d8919 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2035,6 +2035,15 @@ static void gen_lxr(DisasContext *ctx, TCGv reg, TCGv addr,
     tcg_gen_or_tl(reg, t0, t1);
 }
 
+void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop)
+{
+    TCGv t0 = tcg_temp_new();
+
+    gen_base_index_addr(ctx, t0, base, index);
+    tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | mop);
+    gen_store_gpr(t0, rd);
+}
+
 /* Load */
 static void gen_ld(DisasContext *ctx, uint32_t opc,
                    int rt, int base, int offset)
@@ -11327,41 +11336,6 @@ enum {
 
 /* MIPSDSP functions. */
 
-/* Indexed load is not for DSP only */
-static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
-                        int rd, int base, int offset)
-{
-    TCGv t0;
-
-    if (!(ctx->insn_flags & INSN_OCTEON)) {
-        check_dsp(ctx);
-    }
-    t0 = tcg_temp_new();
-
-    gen_base_index_addr(ctx, t0, base, offset);
-
-    switch (opc) {
-    case OPC_LBUX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_UB);
-        gen_store_gpr(t0, rd);
-        break;
-    case OPC_LHX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SW);
-        gen_store_gpr(t0, rd);
-        break;
-    case OPC_LWX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
-        gen_store_gpr(t0, rd);
-        break;
-#if defined(TARGET_MIPS64)
-    case OPC_LDX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
-        gen_store_gpr(t0, rd);
-        break;
-#endif
-    }
-}
-
 static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
                               int ret, int v1, int v2)
 {
@@ -13609,15 +13583,24 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_LX_DSP:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            check_dsp(ctx);
+        }
         op2 = MASK_LX(ctx->opcode);
         switch (op2) {
 #if defined(TARGET_MIPS64)
         case OPC_LDX:
+            gen_lx(ctx, rd, rs, rt, MO_UQ);
+            break;
 #endif
         case OPC_LBUX:
+            gen_lx(ctx, rd, rs, rt, MO_UB);
+            break;
         case OPC_LHX:
+            gen_lx(ctx, rd, rs, rt, MO_SW);
+            break;
         case OPC_LWX:
-            gen_mips_lx(ctx, op2, rd, rs, rt);
+            gen_lx(ctx, rd, rs, rt, MO_SL);
             break;
         default:            /* Invalid */
             MIPS_INVAL("MASK LX");
-- 
2.45.2


