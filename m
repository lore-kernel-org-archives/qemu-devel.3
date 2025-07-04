Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B925C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFQ-0004Pm-9y; Fri, 04 Jul 2025 12:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF8-0002dt-Jp
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF6-0006r7-L5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453647147c6so9827465e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646387; x=1752251187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J4AjWlLcQzRJMk4zTnwVIKd1mI/AdtOF3eG8HhuX0Cc=;
 b=Ro+e38QykMzERNdY5/9EF5+MHFJn0wX1m6q8aYUVCnWvkb4qsjsn4ZVhyBV6MQV3UP
 ulp62I5FZpe5yZNphPgiW0qsAIsBc52d7vGk9dW9/cNXdheyy0NLgaNMZBpMHU4uPwCD
 OnK6CnJB+UASs7gSStL+v0Di9m7EXVGjrA+zO85tYg3O3uQkVjVm/pUle1r2r/bKsf+F
 rvFUso3OjA2xI0inNziJ7ztjW+bb1/f4Vz0AVFqnGTd6EYQWyZhHz14fFALrTfp6XVya
 jXBobxNg1Lh6iCwzXTUP2vPrWbBHm6Q+Ej+RodO0g5aJRpc4oO5gHZQb2JmwdB4uY8JW
 x/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646387; x=1752251187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4AjWlLcQzRJMk4zTnwVIKd1mI/AdtOF3eG8HhuX0Cc=;
 b=ZLjJ9NQHnjXNYSTVWZLwponvOPrk8igOjQwH5a07pF+JUsQ0kb5JZYTjkSZfP2cbE8
 Nzswt/VApCxdSWq2fx9Zh4i/fJbwj8j+hRjRCZfaf0IlLeEGfJWG79e8IbAKvXpwjydF
 UVsfpADlJv7rnYOpfSIF+uMIjlNCROBM7rUzOsGjgvfAzanIrn+tTBo77jiKy+bBXvuZ
 hr4M3TndO+wc+f695RdGT2/T5igOsEzYlfbyhId6SYyzV8g6/baq2+j9XhR20eLfnCan
 Mu1OjS7fgVpUihpteGVMDrUJDWpF54zWdx7hhkVbwIKPTVy5BoFcPXZmwd4hbte12LyH
 HuEg==
X-Gm-Message-State: AOJu0Yz7AZ+y+2E0RcbXMfti1YCCv6DtPxq3F7XcvdALU2F3NaQcSZ/1
 +pkbceRS6YTfrDjpNiBr442BWgPuZTGx+UGllVkCkdCrQ5enDR2KFyibY/y10bkzvcYjSIir2HB
 K5fN0
X-Gm-Gg: ASbGncvrKF2JTNv5YJpETziwzwts1yUiLceZgZJK59bsO7xHaa+4hHEyKS+uc7ctK8H
 /b4q4dhgcIkP9rORMXSEk3ysaSDLB+I8nMmAZ4/bMp/LdwhQ7lKkkW9AEqekokbSxCOQNZ28Ozg
 1k8UeTa5qKg28DQynvh4e1LcCyxVwEZVIicNDgQ72gYuAASYuc700yhxlmTaD8MTvfBvftOStMn
 OTC34jwlGGOpE9MSfSRRPzWnJ93vxh3qJtg9WGz7pZ+81odGeKMgEuDxzuCbxBSbLEbi/dqiYNc
 f41AgAVi+PYckEuVwDIw5BqAMaurow5PLy+LfelJKDJXn4n6KN8wXSesBDj+u+DOWV3Q
X-Google-Smtp-Source: AGHT+IFgAlYwRlN8wRoG4SQvEe+AU4Uo36serLNkhO0c6tzzoXazCutSgHt11e3RhJ2MV3+lKrs6CA==
X-Received: by 2002:a5d:5f8e:0:b0:3a6:ec1b:5742 with SMTP id
 ffacd0b85a97d-3b4964f9403mr2847514f8f.22.1751646386829; 
 Fri, 04 Jul 2025 09:26:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 088/119] target/arm: Split trans_WHILE to lt and gt
Date: Fri,  4 Jul 2025 17:24:28 +0100
Message-ID: <20250704162501.249138-89-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use TRANS_FEAT to select the correct predicate.
Pass the helper and a boolean to do_WHILE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-77-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      |  4 +++-
 target/arm/tcg/translate-sve.c | 23 +++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index dcfc40ef44b..c90d975ebf7 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -789,7 +789,9 @@ SINCDECP_z      00100101 .. 1010 d:1 u:1 10000 00 .... .....    @incdec2_pred
 CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 
 # SVE integer compare scalar count and limit
-WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 lt:1 rn:5 eq:1 rd:4
+&while          esz rd rn rm sf u eq
+WHILE_lt        00100101 esz:2 1 rm:5 000 sf:1 u:1 1 rn:5 eq:1 rd:4  &while
+WHILE_gt        00100101 esz:2 1 rm:5 000 sf:1 u:1 0 rn:5 eq:1 rd:4  &while
 
 # SVE2 pointer conflict compare
 WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f74f2bb1b38..62d3e2efd69 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3108,7 +3108,8 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
     return true;
 }
 
-static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
+typedef void gen_while_fn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
+static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2;
@@ -3118,14 +3119,8 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     TCGCond cond;
     uint64_t maxval;
     /* Note that GE/HS has a->eq == 0 and GT/HI has a->eq == 1. */
-    bool eq = a->eq == a->lt;
+    bool eq = a->eq == lt;
 
-    /* The greater-than conditions are all SVE2. */
-    if (a->lt
-        ? !dc_isar_feature(aa64_sve, s)
-        : !dc_isar_feature(aa64_sve2, s)) {
-        return false;
-    }
     if (!sve_access_check(s)) {
         return true;
     }
@@ -3149,7 +3144,7 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
 
-    if (a->lt) {
+    if (lt) {
         tcg_gen_sub_i64(t0, op1, op0);
         if (a->u) {
             maxval = a->sf ? UINT64_MAX : UINT32_MAX;
@@ -3204,15 +3199,15 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     ptr = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(ptr, tcg_env, pred_full_reg_offset(s, a->rd));
 
-    if (a->lt) {
-        gen_helper_sve_whilel(t2, ptr, t2, tcg_constant_i32(desc));
-    } else {
-        gen_helper_sve_whileg(t2, ptr, t2, tcg_constant_i32(desc));
-    }
+    fn(t2, ptr, t2, tcg_constant_i32(desc));
+
     do_pred_flags(t2);
     return true;
 }
 
+TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE, a, true, gen_helper_sve_whilel)
+TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE, a, false, gen_helper_sve_whileg)
+
 static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
 {
     TCGv_i64 op0, op1, diff, t1, tmax;
-- 
2.43.0


