Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117AAC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mD7-0003Qf-1N; Tue, 15 Apr 2025 15:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6C-0000yj-Pj
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:40 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5W-0004VM-EO
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:35 -0400
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso5196744b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745768; x=1745350568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5L20xDmKCGf6Ew00mPPDT92MsuSmB2DryjXDQVccBtU=;
 b=aw/vhsA3qDA2hdTDk/MB813Av0cMpVOXsBpEfh+pjeshEwyOBgMzMFRTgl9w/I+GlH
 sEpYZVFrCSX3o3dS54XHX1nb5SHKwTUmpt13hG1T3XGUYNXXmh2SmdKvQq1WPzSyFef0
 keo69ncNuJZ5Q19XKEwPVA+4JE5SVQyW1NvXECm1ZycvuOf4OkSwrLBC1A16l943KHpF
 4I/2vkphY3tb0V2SLZnQDTC4dAw58qB16PKIakXtbrfJ7qX+VeN7CrkxKxkagijQmR2O
 vZog0vKDgNqs79Y0lrihQFljwAzXO9q160q3F7Ur1h47K+4nagPANYNAJMM/GIB/hBns
 Wt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745768; x=1745350568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5L20xDmKCGf6Ew00mPPDT92MsuSmB2DryjXDQVccBtU=;
 b=cRfRCZrXlQsvuBzwQouBPuUhSRKMgvFKL7da7WToPrhivQRkGV6WSReQnjKG0aE1Rz
 ktq017ili7mVmbn2UCEFcI9g5JTLkwnXgea+MIugg/ZWwc30CnzJ4j3IbvWwYr7/+DAf
 RtEY4s7uosGVh1bK7IYQ+mO1oy5CLg3sTxYPnhLSaQlNLR/R4zjAUbFESgEw75Fb7wmJ
 o5SkuRwzuDTbN4dRqQ3vR/xb4x8AFvlLWnaLbR1uI6uC2tJHPjAillBSYOKEphKHr7By
 WDvhpOmSyXiOXIlPWQ4dOQT3I1Y2607s9aToyJXGoxzeHs2Nv9HXcWE355Wt66a6hk1x
 0kxg==
X-Gm-Message-State: AOJu0Yw/TQaeMpyrFGKXUvnS/rqkhBKh9KqdhhiQ5w7Xupb63yUIexR3
 MAt7iJ4Efjb6tjcqrupe5wh5d23GZVFTBtifYcO5kjSYi1/d06XrcRuzExwXYmZPloWDbVfmomW
 l
X-Gm-Gg: ASbGncuBhXs74JvtLPBVcq9MjlSnoVFC/wOY4TG1VammfG4wQqY0l3+BR/B2BUFchoz
 LarAcKPtpGHQ9N2nYSL/qjvsaPbcXFXKjHYe9TbqYrD2FLwE437i87QArj6KlqdZx+pzjUm9pdU
 0f+9TJV01JV/r5vdO6vy2YQtBma5ZdxVBUFxB68wVaH4joN0O6jrD1JSUvuNxFVSOUaapwF4XcN
 v58jTkn11drqJNDB9qsewV/YaEZCGWJ0/UmSc96aStHaLerXBoKKYAE2HYM4kpAxTeaWqCUXhMH
 rLxiCYyFy8OzWqY+6wxKgbcmWm3YE9YD0n89/CDwj4c8G6+VV5MTM/uF8XvhK3SFQ0bkZ/gTzzA
 =
X-Google-Smtp-Source: AGHT+IHNm2MHP+P1Bn5YUla1eJtEer765T8j1LuEoVffqzciwvAg+GiPoCj7Ge611a9KZLdNhZyiCA==
X-Received: by 2002:a05:6a00:17a6:b0:736:2ff4:f255 with SMTP id
 d2e1a72fcca58-73c1faed874mr901456b3a.15.1744745767783; 
 Tue, 15 Apr 2025 12:36:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 133/163] tcg/aarch64: Implement add/sub carry opcodes
Date: Tue, 15 Apr 2025 12:24:44 -0700
Message-ID: <20250415192515.232910-134-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.170;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-f170.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 tcg/aarch64/tcg-target-con-set.h |   2 +
 tcg/aarch64/tcg-target.c.inc     | 152 +++++++++++++++++++++++++++++--
 2 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 2eda499cd3..02a0be66fd 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -24,6 +24,8 @@ C_O1_I2(r, r, rAL)
 C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
+C_O1_I2(r, rZ, rA)
+C_O1_I2(r, rz, rMZ)
 C_O1_I2(r, rz, rz)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 87f8c98ed7..9dc6bf3e3d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -508,7 +508,9 @@ typedef enum {
 
     /* Add/subtract with carry instructions.  */
     I3503_ADC       = 0x1a000000,
+    I3503_ADCS      = 0x3a000000,
     I3503_SBC       = 0x5a000000,
+    I3503_SBCS      = 0x7a000000,
 
     /* Conditional select instructions.  */
     I3506_CSEL      = 0x1a800000,
@@ -2078,21 +2080,81 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, ADDS, type, a0, a1, a2);
+}
+
+static void tgen_addco_imm(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 >= 0) {
+        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, -a2);
+    }
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rA),
+    .out_rrr = tgen_addco,
+    .out_rri = tgen_addco_imm,
 };
 
+static void tgen_addci_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, ADC, type, a0, a1, a2);
+}
+
+static void tgen_addci_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /*
+     * Note that the only two constants we support are 0 and -1, and
+     * that SBC = rn + ~rm + c, so adc -1 is sbc 0, and vice-versa.
+     */
+    if (a2) {
+        tcg_out_insn(s, 3503, SBC, type, a0, a1, TCG_REG_XZR);
+    } else {
+        tcg_out_insn(s, 3503, ADC, type, a0, a1, TCG_REG_XZR);
+    }
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_addci_rrr,
+    .out_rri = tgen_addci_rri,
 };
 
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, ADCS, type, a0, a1, a2);
+}
+
+static void tgen_addcio_imm(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /* Use SBCS w/0 for ADCS w/-1 -- see above. */
+    if (a2) {
+        tcg_out_insn(s, 3503, SBCS, type, a0, a1, TCG_REG_XZR);
+    } else {
+        tcg_out_insn(s, 3503, ADCS, type, a0, a1, TCG_REG_XZR);
+    }
+}
+
 static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_addcio,
+    .out_rri = tgen_addcio_imm,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, 3502, SUBS, TCG_TYPE_I32,
+                 TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -2438,21 +2500,95 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, SUBS, type, a0, a1, a2);
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 >= 0) {
+        tcg_out_insn(s, 3401, SUBSI, type, a0, a1, a2);
+    } else {
+        tcg_out_insn(s, 3401, ADDSI, type, a0, a1, -a2);
+    }
+}
+
+static void tgen_subbo_rir(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tgen_subbo_rrr(s, type, a0, TCG_REG_XZR, a2);
+}
+
+static void tgen_subbo_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    if (a2 == 0) {
+        tgen_subbo_rrr(s, type, a0, TCG_REG_XZR, TCG_REG_XZR);
+        return;
+    }
+
+    /*
+     * We want to allow a1 to be zero for the benefit of negation via
+     * subtraction.  However, that leaves open the possibility of
+     * adding 0 +/- const, and the immediate add/sub instructions
+     * encode XSP not XZR.  Since we have 0 - non-zero, borrow is
+     * always set.
+     */
+    tcg_out_movi(s, type, a0, -a2);
+    tcg_out_set_borrow(s);
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rZ, rA),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
+    .out_rir = tgen_subbo_rir,
+    .out_rii = tgen_subbo_rii,
 };
 
+static void tgen_subbi_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, SBC, type, a0, a1, a2);
+}
+
+static void tgen_subbi_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_addci_rri(s, type, a0, a1, ~a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_subbi_rrr,
+    .out_rri = tgen_subbi_rri,
 };
 
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3503, SBCS, type, a0, a1, a2);
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_addcio_imm(s, type, a0, a1, ~a2);
+}
+
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, rz, rMZ),
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, 3502, ADDS, TCG_TYPE_I32,
+                 TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


