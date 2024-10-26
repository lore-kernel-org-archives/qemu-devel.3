Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D38AD0C604
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 17:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4kzX-0008RH-LE; Sat, 26 Oct 2024 13:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzV-0008Qq-AA
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4kzT-0003mX-Qn
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 13:54:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20e576dbc42so30832285ad.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729965258; x=1730570058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9rUKSeMJCa0vu/2TgEevCLC7enoeVuoehiK9K/0kes=;
 b=Q1rqdKb7HxRHrVbTZe+aHWhyuFGe6QWSMWs6/HU1Yod8ugnze4rwbbsz+Ockt3/JYF
 3RkvV9WkDDBIsE+IJil2leeiG+9QY1HFL98LDHveuwRwvB2KxtjDfDv26sixC8Atjyic
 T3FlFLbxsST4ak6Pf3MssvTUYaTkSADULW8AftEIfLjP6X8RDXmZLC7RI9UfW5VnmbR0
 l30eHDBIX9U1dTf4AsQBLbqBKLcihEwRIp8I/c5Roz7vQiFMjlpFeQ9WJf/1goxrmMYL
 RfdWvzk+PJjlzmS7O1Y+PclFuoatsqP8e9sAvD5zxC3WywWA93x5Vv3jncEP1Bl7tbi+
 a2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729965258; x=1730570058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9rUKSeMJCa0vu/2TgEevCLC7enoeVuoehiK9K/0kes=;
 b=dwa0KkqYE77jLsf9r3qsQhxXcQPPcDogv+LHNYP3/vFip4yesj1qU4MxWduoiMmzV5
 Gfi0dfPkoYUorr4eAi9MEhLF6eDZZBZe6k/7j0OT0sEi1SYbm2PuTYXRt0v0KVlKdI0A
 7mOn5+VB8G41GErhntB85GiGFDkHL4lGRoEekBIjZDtZYx5wRXkE4ao5VFTI6hR2SuoL
 IfqXIqo3Qr6BelnxIZnX7qYJr2nceB3wgQZ7Ql7ubtBvBibedJRp15d2UYUV3WNbjyig
 tP4G/dAKhizkjF6/jAo+mAqGIyz9jtJRTA+rgpnSefC6FeyoIl130EXMwtTGyge2xuDn
 6yXA==
X-Gm-Message-State: AOJu0YwfcIDztGZE1vQOIuE9ah2L4Bq8KO1teo4ZAWl51pd3hj5R7Rcj
 XzZ5lqupd2/Yf7HHb3DUDRKOI60Yr3CFE7grIklrE8gVMDne2/2xbBZtcgDa2LzG9SvU+K5p/2a
 U
X-Google-Smtp-Source: AGHT+IFiiNUg0sn0h88t8HN3WJ2Y7OhbiR3oA3LMWXIC6NZNMolFiR2PpfKZNJLKekRnErfNfzpmQg==
X-Received: by 2002:a17:902:c951:b0:20b:5231:cd61 with SMTP id
 d9443c01a7336-210c6c3469dmr43265665ad.24.1729965258177; 
 Sat, 26 Oct 2024 10:54:18 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf6d5c2sm26502365ad.94.2024.10.26.10.54.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 26 Oct 2024 10:54:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 3/9] target/mips: Re-introduce OPC_ADDUH_QB_DSP and
 OPC_MUL_PH_DSP
Date: Sat, 26 Oct 2024 14:53:43 -0300
Message-ID: <20241026175349.84523-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026175349.84523-1-philmd@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is no issue having multiple enum declarations with
the same value. As we are going to remove the OPC_MULT_G_2E
definition in few commits, restore the OPC_ADDUH_QB_DSP and
OPC_MUL_PH_DSP definitions and use them where they belong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6d7e913263e..509488fdc7a 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -389,16 +389,14 @@ enum {
     OPC_ADDU_OB_DSP    = 0x14 | OPC_SPECIAL3,
     OPC_ABSQ_S_PH_DSP  = 0x12 | OPC_SPECIAL3,
     OPC_ABSQ_S_QH_DSP  = 0x16 | OPC_SPECIAL3,
-    /* OPC_ADDUH_QB_DSP is same as OPC_MULT_G_2E.  */
-    /* OPC_ADDUH_QB_DSP   = 0x18 | OPC_SPECIAL3,  */
+    OPC_ADDUH_QB_DSP   = 0x18 | OPC_SPECIAL3,
     OPC_CMPU_EQ_QB_DSP = 0x11 | OPC_SPECIAL3,
     OPC_CMPU_EQ_OB_DSP = 0x15 | OPC_SPECIAL3,
     /* MIPS DSP GPR-Based Shift Sub-class */
     OPC_SHLL_QB_DSP    = 0x13 | OPC_SPECIAL3,
     OPC_SHLL_OB_DSP    = 0x17 | OPC_SPECIAL3,
     /* MIPS DSP Multiply Sub-class insns */
-    /* OPC_MUL_PH_DSP is same as OPC_ADDUH_QB_DSP.  */
-    /* OPC_MUL_PH_DSP     = 0x18 | OPC_SPECIAL3,  */
+    OPC_MUL_PH_DSP     = 0x18 | OPC_SPECIAL3,
     OPC_DPA_W_PH_DSP   = 0x30 | OPC_SPECIAL3,
     OPC_DPAQ_W_QH_DSP  = 0x34 | OPC_SPECIAL3,
     /* DSP Bit/Manipulation Sub-class */
@@ -556,7 +554,6 @@ enum {
     OPC_MULQ_S_PH      = (0x1E << 6) | OPC_ADDU_QB_DSP,
 };
 
-#define OPC_ADDUH_QB_DSP OPC_MULT_G_2E
 #define MASK_ADDUH_QB(op)           (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 enum {
     /* MIPS DSP Arithmetic Sub-class */
@@ -11587,8 +11584,7 @@ static void gen_mipsdsp_arith(DisasContext *ctx, uint32_t op1, uint32_t op2,
     gen_load_gpr(v2_t, v2);
 
     switch (op1) {
-    /* OPC_MULT_G_2E is equal OPC_ADDUH_QB_DSP */
-    case OPC_MULT_G_2E:
+    case OPC_ADDUH_QB_DSP:
         check_dsp_r2(ctx);
         switch (op2) {
         case OPC_ADDUH_QB:
@@ -12271,11 +12267,7 @@ static void gen_mipsdsp_multiply(DisasContext *ctx, uint32_t op1, uint32_t op2,
     gen_load_gpr(v2_t, v2);
 
     switch (op1) {
-    /*
-     * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
-     * the same mask and op1.
-     */
-    case OPC_MULT_G_2E:
+    case OPC_MUL_PH_DSP:
         check_dsp_r2(ctx);
         switch (op2) {
         case  OPC_MUL_PH:
@@ -13811,7 +13803,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
          * OPC_MULT_G_2E, OPC_ADDUH_QB_DSP, OPC_MUL_PH_DSP have
          * the same mask and op1.
          */
-        if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MULT_G_2E)) {
+        if ((ctx->insn_flags & ASE_DSP_R2) && (op1 == OPC_MUL_PH_DSP)) {
             op2 = MASK_ADDUH_QB(ctx->opcode);
             switch (op2) {
             case OPC_ADDUH_QB:
-- 
2.45.2


