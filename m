Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16105C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mDo-0005Lc-8n; Tue, 15 Apr 2025 15:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001HD-4G
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5c-0004I6-EL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:41 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so5527198b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745758; x=1745350558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uwMREjkkbvzn6dxTKOGvoXRjW8rBE/YoyyujR/9nCKI=;
 b=i4XWmSSSOrqFxaqvIp0QC2weuU8uni/b4E94Vsg/xebEO0tk9pRnqam/IaYRLw9mXj
 O78OSZGjz33x52L5A5zEL2qnE1bUl8gBP7VIroF2zqZzPQiuMd7UP+Mdxyn1ypnDrlB7
 xynNDLoKll73KfVjnsIAQjYBwsMac4sz1brUAhsDgJ5Aa+JCwDGilsdr5YRfq2NJXa0e
 KKJ4kq1SMOE5mHQNgfEl7WgZQsphv/fyUBGa17pf/mzpUhmWDZPOrqGHtcp8kMaQCCkj
 Ky2jSJll75loWlyaGN/r6F31jHCtX4Qk4RlixfrMxyjfzUEGp8u0J3blOi3vuOVbaqpm
 +9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745758; x=1745350558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwMREjkkbvzn6dxTKOGvoXRjW8rBE/YoyyujR/9nCKI=;
 b=ejpWeEXcTdp+QSOTHWNJYMdAjabg67q4480WyY0ZE0zKpQ0nR3Z9D14J5kAow3FEkw
 8WEuoUjzDoXThMbiPGPMcpvFefeS3TffcR4EGBP3LY3H6SVHv2hYUE92X7dQourp/+fK
 +Q+wmNwSvYIUgCeHZOKCURf+9hgSzPrZNgr4bBYiBqnPFLdLVUtWRBrReRldcNLehRmE
 XNjprNpfnHxIAsAw9QYjXMmWVfuEXFBzkTKHbTuwiBnchTFC1qqO8NVC07jgMmNNQOLI
 gMVhv3NNhroUJxgV7/Q43DuxA953oL7xWk/B/cnh2hW72Qhp6HqllW6wwtPQASVTX8r1
 wMyw==
X-Gm-Message-State: AOJu0YyZJo1aeYtTmsW6xi0HePuLkSwXLSYHYtOckP5WVyIDhoIWYMCs
 dH3PJn6fWad5pxLfe52AsjdIktczkWm3S2LoG1EknEftM54KZsp0jqpJY+L5Ib8CKMTi3E/Tvgz
 M
X-Gm-Gg: ASbGncv3UuwckK6goDr41drCCsqOQnx91tfWMPV6sl1m95KeTpeu7r8vD1sVKQ/Wx6f
 CxNJTVnMzCX58s5i2gsdWfKtp1lCAnvKfTg0Lqw0zB9LyH5zxM0Mc+TIk82OTV8e1X7Ng8KSLlN
 wx2iFH+GAJEvWXjHrzRWFdY2bUyvPIsEcEiUbsxnIw9QwPVU7buX9hgCVR7F4NCNGXRjTY0/4d+
 nJb3rGVS+3hWVUBm7L1S5xxXwzYMVwoS2CIFamEzVMPg/oryfie03EEMM/iYYIvrvaFT7kLEa7w
 xyAOPrLTcj4begIKlHFeqy7qySg7AjyohUXsQAs02GKxbQxzQEwXb96dQyq6Eg27GZwknODDJri
 6XcFdeyvogg==
X-Google-Smtp-Source: AGHT+IHCV7zueqfOZrxh4mxdjwsY4gyaNHFD2vSYdu0jDRgPdupRWImVib4eWIKO+uKH02FJHgLhRQ==
X-Received: by 2002:a05:6a00:2d1d:b0:736:5753:12f7 with SMTP id
 d2e1a72fcca58-73c1f8f0d88mr1247072b3a.3.1744745758224; 
 Tue, 15 Apr 2025 12:35:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.35.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:35:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 120/163] tcg/i386: Implement add/sub carry opcodes
Date: Tue, 15 Apr 2025 12:24:31 -0700
Message-ID: <20250415192515.232910-121-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 86 ++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 14 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8e0ccbc722..52d3402f29 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -424,6 +424,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_SHRD_Ib     (0xac | P_EXT)
+#define OPC_STC         (0xf9)
 #define OPC_TESTB	(0x84)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
@@ -2629,21 +2630,55 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_ADD + rexw, a0, a2);
+}
+
+static void tgen_addco_imm(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_ADD + rexw, a0, a2, true);
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_addco,
+    .out_rri = tgen_addco_imm,
+};
+
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_ADC + rexw, a0, a2);
+}
+
+static void tgen_addcio_imm(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_ADC + rexw, a0, a2, true);
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_addcio,
+    .out_rri = tgen_addcio_imm,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_addcio,
+    .out_rri = tgen_addcio_imm,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out8(s, OPC_STC);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -3060,7 +3095,7 @@ static const TCGOutOpBinary outop_shr = {
 };
 
 static void tgen_sub(TCGContext *s, TCGType type,
-                      TCGReg a0, TCGReg a1, TCGReg a2)
+                     TCGReg a0, TCGReg a1, TCGReg a2)
 {
     int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
     tgen_arithr(s, ARITH_SUB + rexw, a0, a2);
@@ -3071,21 +3106,44 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_SUB + rexw, a0, a2, 1);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_sub,
+    .out_rri = tgen_subbo_rri,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_SBB + rexw, a0, a2);
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithi(s, ARITH_SBB + rexw, a0, a2, 1);
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, re),
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out8(s, OPC_STC);
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


