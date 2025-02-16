Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E6EC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxK-0006Jd-Qo; Sun, 16 Feb 2025 18:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwd-0004Gq-LL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:06 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwY-0006Rm-5X
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:01 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso5329253a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748055; x=1740352855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5L20xDmKCGf6Ew00mPPDT92MsuSmB2DryjXDQVccBtU=;
 b=useZ9Wv6k4Pniy+qFjAQX7qUH9vDIiM60iNASSvNUcTb005EjnA86GFGYmpNIzFrRA
 eL+/7wK68QF9aXlFETLmsxJOIQl63pkr9UVwovgxGDfP9y8tc0tAxowwcAeZAuGZoVWj
 mXZCeslxoUnVuX77X9YZ/wjPFTlgzg0wubc3zg8plVJzGajPTqa/JZ+yqKc3Dtd4M7ZU
 8zfZOlG1rkfBkL026E7oUO/rb8NUcB9bGxgwr0UcvAexUPNV8kSBHoKyDN9kD5uu/UjQ
 rjCqQNg2o4lISvZ5cDl/V3c1QK21xCK3B1iy+9lIvx4gF1nNrLWPq8H9Zz2opu5pPi3Y
 vUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748055; x=1740352855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5L20xDmKCGf6Ew00mPPDT92MsuSmB2DryjXDQVccBtU=;
 b=Prr8y16IClSDWaoMxqa1+xCduizZGhhX/aqdDDCEigT5oib1+Cs1ZQZt+doInQLhfm
 iZ/7EKLNlu0tAw7V0UIXzJbTmDjeie7kivxndL8amHGT3AYAcatMeq3BJZCDPP3lojyn
 y/vflLAGFm4zk/8eM1wCyXU2mU4t0AfVbIb5Yhw69YpTcNqnq8W4cyXy585TZi1nvxbh
 Nu/hV15AuoG2pfpf1NsoVGfo1Ho1RlpoLnuE79TImntC+cG5xoc+GOuFV0YvS5Db6YdG
 rpVgFvlox6W3H+0+5fSdkiERp++uKiCEtwh2wS0R9gLnaR2WSZEc5FCpZAOWcnHrp/2o
 7S8Q==
X-Gm-Message-State: AOJu0YzPpuDIidm02f2m/F5ahiyLr3d0aCaSqZZlMnSvdB3bnSD1fo2K
 WPO1hiZ1QYYEogHt/crgOnspgKVXl8abQhc3tL5iZlqPU8ViQtRD4MKPQiaOnSgWdD8ykkeAWaT
 c
X-Gm-Gg: ASbGncsRlDa36eYSz3pHCzlgTamN1Zr6gTDLMWENq8I17klTcCku/bW2G3EstwwjxI2
 To8RhR1smefOBFqt9rwBRvU7EAi7dqPMNs17UCVHx3CpRy336Chw8pvNmppDQm9KXWoRP+W3KDd
 w+TPtGDpD7Q9iCie1fdka3HieBF91BnZfn4rShBj9NyY8TFIJtbZQGoTGhR2Rucf0yKHH6cimC3
 nBGHiPvrPNKzd4Ky2jMQ7OCrVjoITimIgi3wAqlmvHZvYQ1GpP05p2cHkSxeVZU0aKlEnM2ey4J
 c4ghZ8uL/YCOTVE94v45eYo0+XVNdB1cHPkVvlEIOw8McGw=
X-Google-Smtp-Source: AGHT+IHqn8DUWj1+guh10CBt37GAWSEPED7oHPzK8ZtIyqBoFcaURUS4d0ra4r1hZNAnv8mE1Tf/aA==
X-Received: by 2002:a17:90b:4c8e:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-2fc40f104e7mr11948413a91.11.1739748054694; 
 Sun, 16 Feb 2025 15:20:54 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 132/162] tcg/aarch64: Implement add/sub carry opcodes
Date: Sun, 16 Feb 2025 15:09:41 -0800
Message-ID: <20250216231012.2808572-133-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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


