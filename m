Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D71C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFg-0003n2-8Z; Sun, 04 Feb 2024 16:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFb-00039W-0E
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:07 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFY-0003bp-QA
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:06 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d93f2c3701so18200935ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082923; x=1707687723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgCYLBH8uYmmefd9XnbslI9mkFGYtv19hEE6tS0wKb8=;
 b=tCZvKOSc6HSbp1LmLrm1SdRzpfhRfqcimvPhd/R3+36n4Bb0ynBh6K37btBW8dozuJ
 0EDC5WVvxPy/HCfN8Ml3qJl5g3hW6yYZ7vhAxF3B0OPHmMGjLoxTH27XJAX5gZSqwie8
 fh8vOcLIekxC+DFRbZvfDkwVoHAREJLSmBcSjFJ04tyovQgG4+wn56eJzITSiXPea01L
 vCJif13rae3nqxrUA1aw9vc7X7jLLcsNlmOF1QQM+Lv1rsAIVIypaLgMsY0lO0nOjK3L
 Y5nCAH9kHisd9zBjO2XqsRQwdwbXCPQq2nv5wWrW/QPNk4LlWRDnSAb2N9gTrLrx3SEw
 ih1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082923; x=1707687723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgCYLBH8uYmmefd9XnbslI9mkFGYtv19hEE6tS0wKb8=;
 b=rlyHqr3QlDv1Wnh/2ReMVQhaYZ9kX2dTSdFj5LtVHO7qwUG9/CDGStpSc/fNKgNPgT
 m/Be/1RgFAl0iXas4253A8YcyA6qVOc+/ihgYnkGdAevD31JNvJcxYSePNObxDeuAhAv
 hr/OYnziirS4ZLq45gmVk45NXk5t/Re2Vik1NT5DafsnfQeXvBBWSsbIvcQ0i0SYlwdr
 yXJA8ZQGx5JriGdIjUSVY1nQak6AidK/6hb2UBKrqzYrIvrndJvo5y2gmDvWMOaOnx/q
 XtA6srbJHIM+h0qrA7VSrJlIs7UMtBe2ZN754c9MdUiqqkfuYMyhM5BHiUsHMJuBLYJF
 nBCA==
X-Gm-Message-State: AOJu0YyLdvfFxmqzrSDbKozen1Bew1sQdRbC34pLex0zIy7rdmn5bjAA
 nMMtSVuZzakdWHamNXoetRJl/sRQwj0LUbR7qSCzcoVVm77QQKM8jN3T/vDyJ8NpMqMWRK+EHsM
 hoQ4=
X-Google-Smtp-Source: AGHT+IHJCoBYoub+AZDspwH0LuCavPB4Q50UGkKyMjk86C8vaHYngmcHfoDX46jL2C6Rm+Z+XUfDgA==
X-Received: by 2002:a17:902:ba98:b0:1d9:620b:89cb with SMTP id
 k24-20020a170902ba9800b001d9620b89cbmr8309754pls.13.1707082923450; 
 Sun, 04 Feb 2024 13:42:03 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/39] tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
Date: Mon,  5 Feb 2024 07:40:45 +1000
Message-Id: <20240204214052.5639-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Using cr0 means we could choose to use rc=1 to compute the condition.
Adjust the tables and tcg_out_cmp that feeds them.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 68 ++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 830d2fe73a..b9323baa86 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -671,30 +671,30 @@ enum {
 };
 
 static const uint32_t tcg_to_bc[] = {
-    [TCG_COND_EQ]  = BC | BI(7, CR_EQ) | BO_COND_TRUE,
-    [TCG_COND_NE]  = BC | BI(7, CR_EQ) | BO_COND_FALSE,
-    [TCG_COND_LT]  = BC | BI(7, CR_LT) | BO_COND_TRUE,
-    [TCG_COND_GE]  = BC | BI(7, CR_LT) | BO_COND_FALSE,
-    [TCG_COND_LE]  = BC | BI(7, CR_GT) | BO_COND_FALSE,
-    [TCG_COND_GT]  = BC | BI(7, CR_GT) | BO_COND_TRUE,
-    [TCG_COND_LTU] = BC | BI(7, CR_LT) | BO_COND_TRUE,
-    [TCG_COND_GEU] = BC | BI(7, CR_LT) | BO_COND_FALSE,
-    [TCG_COND_LEU] = BC | BI(7, CR_GT) | BO_COND_FALSE,
-    [TCG_COND_GTU] = BC | BI(7, CR_GT) | BO_COND_TRUE,
+    [TCG_COND_EQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
+    [TCG_COND_NE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
+    [TCG_COND_LT]  = BC | BI(0, CR_LT) | BO_COND_TRUE,
+    [TCG_COND_GE]  = BC | BI(0, CR_LT) | BO_COND_FALSE,
+    [TCG_COND_LE]  = BC | BI(0, CR_GT) | BO_COND_FALSE,
+    [TCG_COND_GT]  = BC | BI(0, CR_GT) | BO_COND_TRUE,
+    [TCG_COND_LTU] = BC | BI(0, CR_LT) | BO_COND_TRUE,
+    [TCG_COND_GEU] = BC | BI(0, CR_LT) | BO_COND_FALSE,
+    [TCG_COND_LEU] = BC | BI(0, CR_GT) | BO_COND_FALSE,
+    [TCG_COND_GTU] = BC | BI(0, CR_GT) | BO_COND_TRUE,
 };
 
 /* The low bit here is set if the RA and RB fields must be inverted.  */
 static const uint32_t tcg_to_isel[] = {
-    [TCG_COND_EQ]  = ISEL | BC_(7, CR_EQ),
-    [TCG_COND_NE]  = ISEL | BC_(7, CR_EQ) | 1,
-    [TCG_COND_LT]  = ISEL | BC_(7, CR_LT),
-    [TCG_COND_GE]  = ISEL | BC_(7, CR_LT) | 1,
-    [TCG_COND_LE]  = ISEL | BC_(7, CR_GT) | 1,
-    [TCG_COND_GT]  = ISEL | BC_(7, CR_GT),
-    [TCG_COND_LTU] = ISEL | BC_(7, CR_LT),
-    [TCG_COND_GEU] = ISEL | BC_(7, CR_LT) | 1,
-    [TCG_COND_LEU] = ISEL | BC_(7, CR_GT) | 1,
-    [TCG_COND_GTU] = ISEL | BC_(7, CR_GT),
+    [TCG_COND_EQ]  = ISEL | BC_(0, CR_EQ),
+    [TCG_COND_NE]  = ISEL | BC_(0, CR_EQ) | 1,
+    [TCG_COND_LT]  = ISEL | BC_(0, CR_LT),
+    [TCG_COND_GE]  = ISEL | BC_(0, CR_LT) | 1,
+    [TCG_COND_LE]  = ISEL | BC_(0, CR_GT) | 1,
+    [TCG_COND_GT]  = ISEL | BC_(0, CR_GT),
+    [TCG_COND_LTU] = ISEL | BC_(0, CR_LT),
+    [TCG_COND_GEU] = ISEL | BC_(0, CR_LT) | 1,
+    [TCG_COND_LEU] = ISEL | BC_(0, CR_GT) | 1,
+    [TCG_COND_GTU] = ISEL | BC_(0, CR_GT),
 };
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
@@ -1827,7 +1827,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     if (have_isa_3_10) {
         tcg_insn_unit bi, opc;
 
-        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
 
         /* Re-use tcg_to_bc for BI and BO_COND_{TRUE,FALSE}. */
         bi = tcg_to_bc[cond] & (0x1f << 16);
@@ -1880,7 +1880,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     if (have_isel) {
         int isel, tab;
 
-        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
 
         isel = tcg_to_isel[cond];
 
@@ -1966,7 +1966,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *l, TCGType type)
 {
-    tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+    tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
     tcg_out_bc_lab(s, cond, l);
 }
 
@@ -1980,7 +1980,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
         return;
     }
 
-    tcg_out_cmp(s, cond, c1, c2, const_c2, 7, type);
+    tcg_out_cmp(s, cond, c1, c2, const_c2, 0, type);
 
     if (have_isel) {
         int isel = tcg_to_isel[cond];
@@ -2024,7 +2024,7 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     if (const_a2 && a2 == (type == TCG_TYPE_I32 ? 32 : 64)) {
         tcg_out32(s, opc | RA(a0) | RS(a1));
     } else {
-        tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 7, type);
+        tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 0, type);
         /* Note that the only other valid constant for a2 is 0.  */
         if (have_isel) {
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
@@ -2079,7 +2079,7 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
     do_equality:
         tcg_out_cmp(s, cond, al, bl, blconst, 6, TCG_TYPE_I32);
         tcg_out_cmp(s, cond, ah, bh, bhconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
+        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         break;
 
     case TCG_COND_LT:
@@ -2097,8 +2097,8 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 
         tcg_out_cmp(s, cond, ah, bh, bhconst, 6, TCG_TYPE_I32);
         tcg_out_cmp(s, cond2, al, bl, blconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, bit2));
-        tcg_out32(s, CROR | BT(7, CR_EQ) | BA(6, bit1) | BB(7, CR_EQ));
+        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, bit2));
+        tcg_out32(s, CROR | BT(0, CR_EQ) | BA(6, bit1) | BB(0, CR_EQ));
         break;
 
     default:
@@ -2110,8 +2110,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
     tcg_out_cmp2(s, args + 1, const_args + 1);
-    tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(7));
-    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, 31, 31, 31);
+    tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
+    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
 }
 
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
@@ -2442,12 +2442,12 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_TMP2,
                         0, 6, TCG_TYPE_I32);
 
-            /* Combine comparisons into cr7. */
-            tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
+            /* Combine comparisons into cr0. */
+            tcg_out32(s, CRAND | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         } else {
-            /* Full comparison into cr7. */
+            /* Full comparison into cr0. */
             tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                        0, 7, addr_type);
+                        0, 0, addr_type);
         }
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
-- 
2.34.1


