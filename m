Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16A0E68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mi9-0008OC-E3; Thu, 31 Oct 2024 00:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mi7-0008KJ-LX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:03 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mi5-0006sa-TI
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:23:03 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb50e84ec7so3131851fa.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348579; x=1730953379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szXkpmPSUeROwD+6VYjwTLHIGyNjyw7b2MJe2LmUrMg=;
 b=b2dFHgtB6RJju2nkBz4nPYMPLsrXddN4WQZlvN59N+Cy/OF26Kr597EIVHut1nI0pl
 UJ+/R0HNQ77Jr3qPjrhU5895tUIcEXV3r/CmXM8M5+2X7abhgWLWh86eviVGK2K2WlKs
 W2q+RVxilbAVOr0chSiP2kQxSWO7KxELd3SgXlpHKHAcgyyE/j5eWn1FaMn/RcFdTFxY
 6/HdaLets86hI+CBQGzN19ZBcg7yJtCNDatoLyngu7XhqaG3FZowxkQqchfi1j6ZeODI
 /LC9XchAqC/KhV3e4DuUNrIqT1fEWyWz5XOX+g0sSzNJ+aIHKrvCIacJdK1OcSlJKJBd
 muOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348579; x=1730953379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szXkpmPSUeROwD+6VYjwTLHIGyNjyw7b2MJe2LmUrMg=;
 b=Z7o0Rnux0oswQd16iy9fj8GC5DAO0bis5b7ZlnTty8c7vzBs3zt0fOq21Yp5Li5G0p
 kZNS/KlGiZNAOBcU19A1WZTYdWtlSuxddkBLwznBTUyRm/sA1eHoyz8YtAz8vNWdcmrY
 gy+XpQNDDlbzcxJHZcymfuGvRiZTtUjeB6z/JeJcnS7Pn/h1wFKEV4LUkezMhiggMzKB
 kOU0NrFM+Vhlk8eyW8Y1D39dHQL0EEhpMst41jeCEvHhWk0kzDzOUlTlkTbR2qqbqlN4
 JajUvh3Nc1NnJubUFZY8ADLIOb8lgcTE94pFKHSriaB2mg/kQ7yNTJpMCWejrow9Bdth
 yNHg==
X-Gm-Message-State: AOJu0YzegyI/twVDlq/SBdgCjNBWCC51YFcuiaVdzcfGFhUQq/Ecegvg
 2ta6Fv1nF45lmazrtQRT/TYLTxun7KiChpOmGgg3IeDVeA6hOu1O9KzmKFMSgoJXEZc/AjLVq3e
 u
X-Google-Smtp-Source: AGHT+IHI8qtOjZt0yKqV6lmEqZAw3k8wCbOOzCT9MD7gKBiLCg1KRWQ31kZgOHyWozLxdDhRsGldRA==
X-Received: by 2002:a2e:a543:0:b0:2fa:cc50:41b with SMTP id
 38308e7fff4ca-2fcbdf5fa9amr85198681fa.5.1730348579299; 
 Wed, 30 Oct 2024 21:22:59 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef8c393asm937971fa.107.2024.10.30.21.22.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:22:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/14] target/mips: Re-introduce OPC_ADDUH_QB_DSP and
 OPC_MUL_PH_DSP
Date: Thu, 31 Oct 2024 01:21:21 -0300
Message-ID: <20241031042130.98450-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is no issue having multiple enum declarations with
the same value. As we are going to remove the OPC_MULT_G_2E
definition in few commits, restore the OPC_ADDUH_QB_DSP and
OPC_MUL_PH_DSP definitions and use them where they belong.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241026175349.84523-4-philmd@linaro.org>
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


