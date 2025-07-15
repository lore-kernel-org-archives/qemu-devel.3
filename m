Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18601C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ18-0002Jx-6o; Tue, 15 Jul 2025 02:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0u-00028J-Hr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0s-00071K-FE
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so49800275e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560376; x=1753165176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmqRT40RDvsgTqfFq5PqPhISBaVjONltwNS6X4XWcCM=;
 b=LpYaBdsQLsJac1AJ3IqV/kXjAoyReO1dJjlD1m9x3dAKvZ5Q5eD16e8YoJxs2y1foM
 Hd0q07aSq/ntIgbXkgVPg1wQJotHnjfEKGdzX1C+GjkP+zEjQ2ZyARYON8B7rvT6ksLM
 NNl58ewE0Pay5YRIpvCfjQO9tZAqcMI3/iDyiVrwdgPaOiICiNm5Gp4rT+Pp/GOrWsSg
 eLrcZnaVVJrZi8DQCx1Htn6UmFJ5411UqUY7RI9dI9cfKXuxVCsvhKdwPgVuTL1PoJj5
 SdUu7jcpvUGDJKOSmupVuxd975UnnhyVadUaYQh81V+cfwuuspZ+a4cyTsXHPDoq65Co
 /Mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560376; x=1753165176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmqRT40RDvsgTqfFq5PqPhISBaVjONltwNS6X4XWcCM=;
 b=Du7n+XN9kcRn2UaC2545AxRiTNBLtP4BG4Q1sKJvZhcOCvHZZJzfkFYj7Q3YGGjDER
 VmoFVqgt7+AhaBwnbHkLF0GaVYO7Mot/rO1KOV+sMiQ3HOb5o4bQ0z3in0EBb549t56M
 87J7Hc55wZ9lPOWn2m81D+P1x8TgksNe39wxMbTGxx5zJUjl2/u1m+J4vlAWv+7Dmr8n
 2NEE1sHQd81uugJJjzYYQZYafneMV5i+kOsiOfkxdncOCkhGnVUVPeVWt+PixcHaOwU1
 9cxc9qjtCeWhFVEvJzUBCosicFugKx7RCa5Da+9LCWzfAaFRio69jnaUg2HqdMuDjPn+
 EJXA==
X-Gm-Message-State: AOJu0YwRK8KOGTXjQWatFf2oLwXvUzB75ncxIdlZqP/u83Lc0XlSYqbg
 ugvDD6zNIFvAJY6HKkseBa3BI1fzIzbtefvb3w6DSjIAXyWkEH4dsNe4stnZ1Usq+sbZg6poiuQ
 S/ZA3
X-Gm-Gg: ASbGnctufC6V1u3XkC5Bg/MELfVUhMPDUvhwhtgzdf2uXsFnXez+wA6f37QpH1dTrJC
 mNnuBdHlX3w3E+ichfHFzUnLcD/+zfKJbDZhGKfCxqtaXd+NTOt/ZymV+Q7li/L8pvjFczs06j/
 Qqfm5u9EZN45IexNjpN3YOyJtzf22hliqe8ra5bPnPugLG06pR1s5o5aKYMOA8Fzp6+suy/NVAp
 iWm390gNKEAVENwCpnvBeVauTqK29T2P2y6Sv50MF0RBTdvCtkRZWh6poGCjxweU/o0M92toAnp
 gM4YC1eCboBc4GemI0GARUC8Mr2/3HB5ejwyhhTtJCP7gfh9aMFhalkxMKqQqnIcHb/R4GMRfww
 aycsgM8bCy693n0vZosfHx4aB9+TchljUKMkdJyveIV9Wb9surcIde8knISjOH/v9jBwY4ZKI
X-Google-Smtp-Source: AGHT+IGvl37IZ7EQKmYyNzSoFjvnK5ndb1yvGSdrFJkrneSSIBf4WtKxeOT7fYDACRV2OT796f8JKg==
X-Received: by 2002:a05:600c:1392:b0:455:fc16:9ed8 with SMTP id
 5b1f17b1804b1-455fc16a23emr124875475e9.30.1752560376367; 
 Mon, 14 Jul 2025 23:19:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd181bsm13884227f8f.7.2025.07.14.23.19.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 03/17] target/mips: Extract generic gen_lx() helper
Date: Tue, 15 Jul 2025 08:19:03 +0200
Message-ID: <20250715061918.44971-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
index e65593815e6..89dde1e7124 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -169,6 +169,7 @@ void gen_store_fpr32(DisasContext *ctx, TCGv_i32 t, int reg);
 void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg);
 int get_fp_bit(int cc);
 
+void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop);
 void gen_ldxs(DisasContext *ctx, int base, int index, int rd);
 void gen_align(DisasContext *ctx, int wordsz, int rd, int rs, int rt, int bp);
 void gen_addiupc(DisasContext *ctx, int rx, int imm,
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 8816237e929..b9b2d8bb7e1 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2036,6 +2036,15 @@ static void gen_lxr(DisasContext *ctx, TCGv reg, TCGv addr,
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
@@ -11328,41 +11337,6 @@ enum {
 
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
@@ -13633,15 +13607,24 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
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
2.49.0


