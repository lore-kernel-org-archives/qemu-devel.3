Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA21CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mGG-0000P9-2f; Tue, 15 Apr 2025 15:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m6s-0001I2-7r
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:38:36 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5g-0004Y1-82
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:52 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso2723661b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745774; x=1745350574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bmk6ZfjcUictTTcvWQnXhrk1XKxfh8uaZLHmYOMw2HQ=;
 b=G/Ehn/w2KMIfw5KX6rvgCG7KhmMCuRnrZWTayDmS4pYSJ9EoSdVZg5foPTCqxb7kJ+
 S7ZYe6Vg6/hNnnox7jIiczhlpATZPVS7UyLetgLiZsPcFA3+T95RHKVfS5OYMajyv05U
 iHQPSgv1I9WCrUz21J5wFoLKKD1meP8YIeaqs7/CDtYAQ2zImm3UiXimaSsAloz5ZCgM
 r8Jw+BY74uWL2T+tvAhbbLIsLh7RHc5viaRZe9T09pU0Y7yI5Gh/Fb3CyoSHtiXAcRjo
 v0cUCDDuxwoTFGMzmzZyKA31doouWnqDLR3nNmOoqTcaO2dJCi5GmHAlzcgsAojVBuxk
 sU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745774; x=1745350574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmk6ZfjcUictTTcvWQnXhrk1XKxfh8uaZLHmYOMw2HQ=;
 b=tFA0icUdiIMxcnRNBLjYBvenfBWaqB+4OfI78+wKwU+g1WVSUWJeduLdIKdlfxh3Ay
 MFT7phffyQEO7WQfoSJQm/azC5ECDsHEX4nV5hkndBp8ZNKHCfT3FBvDISjUlcBmjDLe
 R5j2cLVRXkppDaaxURtsGgff37WaOGMTVhK+WU9uYamiZN9BC3AqB8aTTL5kVMBQ88C2
 NjySdL6G4+yj9+7BKoWx59KcZkl2OTk/J5nfL0HetbNIHdGZrPG9LyKTLchTj5038TPu
 1CmiSJsq5EEpK2iZa7OF9ooIYM4ReG568866kpH6FqKIrtXAsA6B9Vlm16ZcvdoV10is
 o++g==
X-Gm-Message-State: AOJu0YzasKANDDPZxRVnEtbTle5ztvvCkHZEZj0Jxe8tdCzp/YgCL0Rj
 OphYkedZ+ER/7OUn7mnF8VCyxghTDTvGUPGSEbAlaQvZh9+6FjAglT1WNssEcYNLb3PAlEJ85bG
 d
X-Gm-Gg: ASbGncsb133qWc2fw+swSC/d1ob9qyMrO027SJrgkyb9PaJoXX6/QfWaw3zsUq815NM
 IabJTPfglPCnadrVVBxZ/scz66UXtYrAr8x4nHNeHkXqyLBTomCKNBAPpMdfIXqWNuumwzRLfry
 RZcYh2XGCxtHAvQ2gXTEvLxKCpkxLTohuXJn6TNqQpHzyu1WanFAgdLxJsObhghK2CVX79PQRZz
 k9KSiiH7R59snCT1nYi+MWhSmXG1U4lf/61XI4/zp9u36FUmIqjvRullD3jKajTq+OuLSaPlG6A
 der45Ig6riMnQKuLQh5obZbajdeKDyI/otMnwQn9HZiSWB0WEsMHLpXeMY6c5CohgM51/m2eK3U
 =
X-Google-Smtp-Source: AGHT+IHyqBGmxs4FGl79sKjmsPyAQ9lhTC8MC8FooEf5yPsIH16BNbLNu7uZDtkuyea16z7+OXfcLw==
X-Received: by 2002:a05:6a00:802:b0:736:7960:981f with SMTP id
 d2e1a72fcca58-73c1f8ffa89mr1086403b3a.8.1744745773651; 
 Tue, 15 Apr 2025 12:36:13 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 141/163] tcg/s390x: Implement add/sub carry opcodes
Date: Tue, 15 Apr 2025 12:24:52 -0700
Message-ID: <20250415192515.232910-142-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 tcg/s390x/tcg-target-con-set.h |   2 +
 tcg/s390x/tcg-target.c.inc     | 103 ++++++++++++++++++++++++++++-----
 2 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index f5d3878070..0a991f6d5d 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -22,6 +22,7 @@ C_O1_I1(r, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I1(v, vr)
+C_O1_I2(r, 0, r)
 C_O1_I2(r, 0, ri)
 C_O1_I2(r, 0, rI)
 C_O1_I2(r, 0, rJ)
@@ -32,6 +33,7 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
 C_O1_I2(r, r, rNKR)
+C_O1_I2(r, r, rUV)
 C_O1_I2(r, rZ, r)
 C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 9b28083945..2b31ea1c3e 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -173,6 +173,8 @@ typedef enum S390Opcode {
     RRE_SLBGR   = 0xb989,
     RRE_XGR     = 0xb982,
 
+    RRFa_ALRK   = 0xb9fa,
+    RRFa_ALGRK  = 0xb9ea,
     RRFa_MGRK   = 0xb9ec,
     RRFa_MSRKC  = 0xb9fd,
     RRFa_MSGRKC = 0xb9ed,
@@ -2259,21 +2261,60 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, ALGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, ALR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, ALRK, a0, a1, a2);
+    }
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RIL, ALFI, a0, a2);
+    } else if (a2 >= 0) {
+        tcg_out_insn(s, RIL, ALGFI, a0, a2);
+    } else {
+        tcg_out_insn(s, RIL, SLGFI, a0, -a2);
+    }
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rUV),
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
+};
+
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, ALCR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, ALCGR, a0, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_addcio,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_addcio,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, RR, SLR, TCG_REG_R0, TCG_REG_R0); /* cc = 2 */
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -2794,21 +2835,57 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rrr = tgen_sub,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, SLGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, SLR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, SLRK, a0, a1, a2);
+    }
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RIL, SLFI, a0, a2);
+    } else if (a2 >= 0) {
+        tcg_out_insn(s, RIL, SLGFI, a0, a2);
+    } else {
+        tcg_out_insn(s, RIL, ALGFI, a0, -a2);
+    }
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, rUV),
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RRE, SLBR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRE, SLBGR, a0, a2);
+    }
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_subbio,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out_insn(s, RR, CLR, TCG_REG_R0, TCG_REG_R0); /* cc = 0 */
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


