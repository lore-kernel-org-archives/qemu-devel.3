Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D7FC48299
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEx-00026y-KJ; Sun, 04 Feb 2024 16:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEu-00025Z-Kr
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:24 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEs-0003WX-Rf
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:24 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so32846735ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082881; x=1707687681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vyZhh9F6fWmSs4Bpq5S+VCME8YHT+VYlvyj+usF/4Q=;
 b=PC1VR/SYbxSyifvT2XaiBH7/cbKT5k2dU4ynhrdyvJQPHxoiEEJUEdrtsWnVIKhMA0
 aiU+du57V9hwcCEgEsPDje2KY7xaDoav9vva2E98sGDkUsBY9sgSAk8BcBuXU+8VuFGs
 TIuvpi0d7RCSNI8iNp//VEfq8WZ6c06rrzW1Z0P+8EIVxsVcmkV/UQ4SQGNVax1k1kc3
 cJBHXiLat/Si8sBzayM0B4AESmDdk7GyJ7Tn3NPlwo2j+HkDsHohqF/r0bddiecDHM7R
 TdPXU2qVbVFluUsPArfedO2tPuOk7P3Ogo3uZEwAM3tjVHWftLb2hfX2Nr5hN3pisC5g
 RRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082881; x=1707687681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vyZhh9F6fWmSs4Bpq5S+VCME8YHT+VYlvyj+usF/4Q=;
 b=TwFF1o1sL9cC6BduFA0mNGhTOtHikn2aQBnnaKQylcDDZkvyntExU74Eti+lPlqV7T
 9f+xzbxgv0SG24e51XZiZ3aMqYaO/QPIeDUt0acb5eYiaMOQvCcCZPwhiExNTYm4UPU/
 dlxusi4AAVbEmilaLjOZMA8+InXlLx67kfR/SUfvDjhg30Yk0aT9xT6FAMMQrlEdEtu2
 l45voAuvPlKq7m9IRxDSXuJwzsZ2GvVaGqnbm4OrpmX/MeUUEkXx9UKvybNDgd3vSaur
 894GQfR34ShUdgBkNL+602gkInUm9IuF0aapr2Qb9L8zM/H3GBo8sBytZEAUage3NWnN
 NLBw==
X-Gm-Message-State: AOJu0YwXEW2lN5hTBgd8wOZTFWtO9oNyTC12BljS/ms3Qpk38IqhoKIR
 qL9c05+4t3O3ydcSLINhywqZbvjzkl2GYOTH6dUoBkNZFPEAKudvJAmx5qdm0qMemtTYVUdsHP1
 jjY4=
X-Google-Smtp-Source: AGHT+IE5MWNqrUcAAUG975y6NpRQLATY02cvLjn3P4PNhCHLtOTQswSOdpxNHnGpwZBeevPJj2andQ==
X-Received: by 2002:a17:902:e750:b0:1d9:bf28:8bda with SMTP id
 p16-20020a170902e75000b001d9bf288bdamr265739plf.68.1707082881600; 
 Sun, 04 Feb 2024 13:41:21 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/39] target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
Date: Mon,  5 Feb 2024 07:40:25 +1000
Message-Id: <20240204214052.5639-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 74 ++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 41 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f886190f88..d7d5ff4300 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5129,46 +5129,44 @@ undef:
 static void gen_fcc_cond(DisasCompare *c, DisasContext *s, int cond)
 {
     TCGv fpsr;
+    int imm = 0;
 
-    c->v2 = tcg_constant_i32(0);
     /* TODO: Raise BSUN exception.  */
     fpsr = tcg_temp_new();
     gen_load_fcr(s, fpsr, M68K_FPSR);
+    c->v1 = fpsr;
+
     switch (cond) {
     case 0:  /* False */
     case 16: /* Signaling False */
-        c->v1 = c->v2;
         c->tcond = TCG_COND_NEVER;
         break;
     case 1:  /* EQual Z */
     case 17: /* Signaling EQual Z */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 2:  /* Ordered Greater Than !(A || Z || N) */
     case 18: /* Greater Than !(A || Z || N) */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr,
-                         FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 3:  /* Ordered Greater than or Equal Z || !(A || N) */
     case 19: /* Greater than or Equal Z || !(A || N) */
         c->v1 = tcg_temp_new();
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
-        tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_Z | FPSR_CC_N);
         tcg_gen_or_i32(c->v1, c->v1, fpsr);
         tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 4:  /* Ordered Less Than !(!N || A || Z); */
     case 20: /* Less Than !(!N || A || Z); */
         c->v1 = tcg_temp_new();
         tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_N);
-        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_N | FPSR_CC_A | FPSR_CC_Z);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_N | FPSR_CC_A | FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 5:  /* Ordered Less than or Equal Z || (N && !A) */
     case 21: /* Less than or Equal Z || (N && !A) */
@@ -5176,49 +5174,45 @@ static void gen_fcc_cond(DisasCompare *c, DisasContext *s, int cond)
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_A));
         tcg_gen_andc_i32(c->v1, fpsr, c->v1);
-        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_Z | FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 6:  /* Ordered Greater or Less than !(A || Z) */
     case 22: /* Greater or Less than !(A || Z) */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_A | FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 7:  /* Ordered !A */
     case 23: /* Greater, Less or Equal !A */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_A;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 8:  /* Unordered A */
     case 24: /* Not Greater, Less or Equal A */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 9:  /* Unordered or Equal A || Z */
     case 25: /* Not Greater or Less then A || Z */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 10: /* Unordered or Greater Than A || !(N || Z)) */
     case 26: /* Not Less or Equal A || !(N || Z)) */
         c->v1 = tcg_temp_new();
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
-        tcg_gen_andi_i32(fpsr, fpsr, FPSR_CC_A | FPSR_CC_N);
         tcg_gen_or_i32(c->v1, c->v1, fpsr);
         tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 11: /* Unordered or Greater or Equal A || Z || !N */
     case 27: /* Not Less Than A || Z || !N */
         c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        tcg_gen_xori_i32(c->v1, c->v1, FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        tcg_gen_xori_i32(c->v1, fpsr, FPSR_CC_N);
+        imm = FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 12: /* Unordered or Less Than A || (N && !Z) */
     case 28: /* Not Greater than or Equal A || (N && !Z) */
@@ -5226,27 +5220,25 @@ static void gen_fcc_cond(DisasCompare *c, DisasContext *s, int cond)
         tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
         tcg_gen_shli_i32(c->v1, c->v1, ctz32(FPSR_CC_N) - ctz32(FPSR_CC_Z));
         tcg_gen_andc_i32(c->v1, fpsr, c->v1);
-        tcg_gen_andi_i32(c->v1, c->v1, FPSR_CC_A | FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 13: /* Unordered or Less or Equal A || Z || N */
     case 29: /* Not Greater Than A || Z || N */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N);
-        c->tcond = TCG_COND_NE;
+        imm = FPSR_CC_A | FPSR_CC_Z | FPSR_CC_N;
+        c->tcond = TCG_COND_TSTNE;
         break;
     case 14: /* Not Equal !Z */
     case 30: /* Signaling Not Equal !Z */
-        c->v1 = tcg_temp_new();
-        tcg_gen_andi_i32(c->v1, fpsr, FPSR_CC_Z);
-        c->tcond = TCG_COND_EQ;
+        imm = FPSR_CC_Z;
+        c->tcond = TCG_COND_TSTEQ;
         break;
     case 15: /* True */
     case 31: /* Signaling True */
-        c->v1 = c->v2;
         c->tcond = TCG_COND_ALWAYS;
         break;
     }
+    c->v2 = tcg_constant_i32(imm);
 }
 
 static void gen_fjmpcc(DisasContext *s, int cond, TCGLabel *l1)
-- 
2.34.1


