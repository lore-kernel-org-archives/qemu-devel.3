Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AC2C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Up-0004A4-P6; Thu, 17 Sep 2026 05:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Uh-00047c-UX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:27 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ug-00019C-9e
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:27 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8633a38df87so369824b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637604; x=1790242404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwoa6vrkODRo23xjez8ZIL5++kbe/ft06/FXzPSyFIo=;
 b=iFRyu616JhwxP27BGEL6TMs2dIkhQIXhB/W9otpnx/ug4ClswiPtoq2wdqmn+4n1I7
 EYtd+dPMM0EuxG3QCmXRsP07n7DMk8GjmGP0QnV7+nFCqes7fduv+SanrH1gthfIFzSJ
 zpEXwOjnB6wBD0aUNL4yNbOQlTRQYwbkQMmoe2NdB8qafgfRsQ0zZEkxlw70qVJEp5eN
 BDWNRbQpZvQtTI7YFmb5Mz+Kj2oyZlrZPJGcaNnjlpZDoBRTpsv/Ei1F+zofohUPAG2x
 7GGGRq7EBi/8yOm1Jb1VpdLJehRBVqzNw6hC3Yj59ga9C/DPoLZvppMwKJmI74zaoiwb
 u/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637604; x=1790242404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwoa6vrkODRo23xjez8ZIL5++kbe/ft06/FXzPSyFIo=;
 b=jkG3GbN2E+RwkW/+VgKb7WVx71a/O6DeY8c86LAKHb0bAQ8ZiZ9AT4WSNtICvD1G8U
 9KrFbuD60fd7F2Kc4sbNhL1YsbNG3pbVn8gJkV/ptZPTKDPAkGeWovGbZ5PtleIPUfeV
 rtkMYJF9ekE7khUm1p6drr/17ZYE1H36vArwUXwNjBj+zpdcA2gG4QdOeUtfCqJZPQTD
 d32zLYCqCqMP43a8DAMyveZTY0xxhfgMfAD39TBSJD0c5+H76fpLsEY39XaVJXVHbP7o
 Gd8uvV+phoRFDUIiTrpVA9CahOtj9I6hCNzNTm231YeOwYySBMU6x5RSmU/XKs0Ke7PG
 khIg==
X-Gm-Message-State: AFuF++mHoTF2rEU4/AdH7i4/VwqxR2T4nIrhBwvH9vgk/msA9YiUZLSS
 CzVesUDLY33sFGet2lsBKq5wTrLhlFz1gTalcYqR2REMJ3uM1YxFBOR53Gvm6DulrYX2Vb5h1kK
 dzO+hRt4=
X-Gm-Gg: AYBFou31EEhgry4mPQralhmhiJuc+qUJPJku3yTNTrzDtzuWtrRnr8p+6L5Nc8h0aLo
 +HMnET/coNuZnfpqqZsNyR/+7KLKbijSOnVomyiTsBnGUsfMzm41iD992KyEOycDo9IWIq/fPSB
 VmCGSoTZESMNRzEJsk+ZojT/qo84Fyo3E8aDirvVURs45CFdskJAlsOJGylDiboGXO5sMCGH/1k
 WftXV+I6l+RQBGP0DuvAzkRgaLgKDt34n/vwdNTp5w/8cMXSp4+ldorXBxgR0hp49zv19zEGEYz
 4XNpTndW4YC3ZExYX5QPZaZ5etuAOStTT2YHDY93FyUg0VQWgP6eu/2Nacmdv7snDz1IDuakzZb
 y1Qp9IDFDIJOSB5+epW2WLx6VaC/WutvqhAC5ZztdQdYQqR8MF36DBdjNfMjLeNZnPzp+sZf/F/
 7IODf/z5vd38uUrr0GcT3tPxv9ty4JBIW7AwhxAJQh65ka7ktwyCL3AGpcRQBMqWXLaDz05Gq9k
 J0p/AcZ
X-Received: by 2002:a05:6a20:20c3:b0:3bf:6d96:ac40 with SMTP id
 adf61e73a8af0-3dd5f475f34mr15417967637.12.1789637604425; 
 Thu, 17 Sep 2026 02:33:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 13/13] tcg/s390x: Implement INDEX_op_goto_jc
Date: Wed, 16 Sep 2026 23:33:07 -1000
Message-ID: <20260917093307.1092084-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use LGM to load multiple values at once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  1 +
 tcg/s390x/tcg-target-con-str.h |  1 +
 tcg/s390x/tcg-target.c.inc     | 40 +++++++++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index f67fd7898ed..a566a1ca7b4 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -18,6 +18,7 @@ C_O0_I2(r, ri)
 C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(o, m, r)
+C_O0_I4(r, hJU, hJU, hJU)
 C_O1_I1(r, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 636a38a168a..e44b2a92d52 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -9,6 +9,7 @@
  * REGS(letter, register_mask)
  */
 REGS('r', ALL_GENERAL_REGS)
+REGS('h', 0xfff8) /* general regs other than r0-r2 */
 REGS('v', ALL_VECTOR_REGS)
 REGS('o', 0xaaaa) /* odd numbered general regs */
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 3b63383315d..b04c54e26d3 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3202,8 +3202,46 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static void tgen_goto_jc(TCGContext *s, TCGReg ptr, TCGReg pc,
+                         TCGArg cs, bool const_cs,
+                         TCGArg fl, bool const_fl, TCGLabel *label)
+{
+    /*
+     * Note that pc, cs, fl are constrained to r3 or higher, r0 and r1
+     * are always reserved as scratch, this is the end of the translation
+     * block so r2 may now be clobbered, and the input ptr * is dead
+     * after the initial LMG.
+     */
+
+    /* ptr is CPUJumpCache */
+
+    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) !=
+                      offsetof(CPUJumpCache, array[0].tb) + 8);
+    /* lmg r1,r2,tb(ptr) */
+    tcg_out_insn(s, RXY, LMG, TCG_REG_R1, ptr, TCG_REG_R2,
+                 offsetof(CPUJumpCache, array[0].tb));
+
+    tgen_brcond(s, TCG_TYPE_I64, TCG_COND_NE, TCG_REG_R2, pc, false, label);
+    tgen_brcond(s, TCG_TYPE_PTR, TCG_COND_EQ, TCG_REG_R1, 0, true, label);
+
+    /* R1 is now TranslationBlock */
+
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) !=
+                      offsetof(TranslationBlock, cs_base) + 8);
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, tc.ptr) !=
+                      offsetof(TranslationBlock, cs_base) + 16);
+    /* lmg r0,r2,cs(r1) */
+    tcg_out_insn(s, RXY, LMG, TCG_REG_R0, TCG_REG_R1, TCG_REG_R2,
+                 offsetof(TranslationBlock, cs_base));
+
+    tgen_brcond(s, TCG_TYPE_I64, TCG_COND_NE, TCG_REG_R0, cs, const_cs, label);
+    tgen_brcond(s, TCG_TYPE_I64, TCG_COND_NE, TCG_REG_R1, fl, const_fl, label);
+    tcg_out_goto_ptr(s, TCG_REG_R2);
+}
+
 static const TCGOutOpGotoJC outop_goto_jc = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O0_I4(r, hJU, hJU, hJU),
+    .out = tgen_goto_jc,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0


