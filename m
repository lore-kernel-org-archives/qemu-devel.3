Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34125C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0c-0006jM-HF; Fri, 21 Aug 2026 07:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0a-0006XP-73
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0Y-0007Jb-2k
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso9475025e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310117; x=1787914917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9MdcaNnkGkPnZZLX3uIyD05cWJ8D3IXbmezaTQn5KFU=;
 b=dXNPLEKjduY31y5gYKOJBV9qjXaOtnIUnQNtOYYioo0SWVvpGxFrDvoXU6EACReJ9w
 fgHGVs2D/JKUMLpvIc36qNE5b9QLmOJVnYalE5A76INh3cSRFLcrD4gFdfAauW09RmPS
 KzN2GXuIMEY2mrN1VxBB0aXTwDnOC8LEmlLBX2h5FwPscyM51uvZJuvP0PJEsiAwy8B9
 /QxNWZoih775xpocALA+MW3ibABzsBbadGIzZzhOVFd5P5kmy8P4COn3EmE+9pxFR92l
 +zMSa7iXHa/pKWAungX4JUNqd0r74Tp9htSFcvYzvh+674wOmRsCwz0Vj4U5xgQ1s5Dv
 WCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310117; x=1787914917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9MdcaNnkGkPnZZLX3uIyD05cWJ8D3IXbmezaTQn5KFU=;
 b=PmlQ5YZPXHu+I0WSVlE1CcUbUpOFt6hQs5W0nOD9z6vCNxQZUQ2am9b8A3uJAz/cRt
 UgTE60UAbpY4caVLO2YNSpbdk8E0+/RIOkv0TsM8uPpDkGBMEVcTqAVKrcXIxtwMGYmP
 vOquo++RZiC2rSbtf4ChyEB5861o2b7bA8iG/H6NpvrElIl/9wTe3m2G0/gK2nm0p2ld
 ACxCZ8XeE+KVRgu4A5cGxLeyLc2EgrK+E0I0m2RwGf0yo50yQhwec5dBTkdx3NrTuvPU
 dN4OGqHbhKCCxSglwF4zitE3a1Y55hWfq9Pond5+BX2dvtJ7X6uN6GDYU+tPLhc3kPP/
 jayg==
X-Gm-Message-State: AOJu0Yx/2sO420851Odxq5wsUIc4jxiBYZ7sLQj8kOwTp9KD/RRfrlcC
 isnvf2l6yUjGc8aDtFoz2U7+53gzs/HhcEBWy2TCvoO8JXjyTGOeWZCh1qNtlWD+PDMhKP54t6T
 EI2ci
X-Gm-Gg: AR+sD12MMHlI+FiilqzFSNvfAP9vC+DeDMPwfbKUVIcJxmO/cyK8QZRwdd4tVbsWC2j
 CHzOEwXf/0KO0AsXPNsR/oxcR5PxYPHbb64o7DG4ZbigAoKECbPtdebC4VQeux+dwLIDvgIGv73
 1IaGiWsbw8EHFG1kP3AVgys7IeJLc7bDI7Eoa6XcSRgMPIGBo17tJjdTdbMN7jVn0WvErGPPyhr
 Sxh0QYF/kWmnUMo2JeOpopo4wHOgHeqJ2SVItGSOWLnNA1fNf0rrvKUSAMhzvTT1J948JXCmKeU
 0h808vZ0GNaGnyIIx2VQAuYSEqynIi61m/rywftGDVatD6pHxzyQXXdnWxlojbT5NRb2m9z2EaU
 YO1ylNTJ6yo4cCIf9yuqBOR3Tqqy8S+g7z8ZjUenTFLEF9/u4al3wf+UB3O6DL4EZMkh8iueYde
 myeMoMWL5qWPR+CSqvDZOIrYvRYqh8lFlIyDMfKaX78HIH/6Y43KZMuTWDmtwqmIWlfzMu+huWb
 dj5JQjNSTqoca6BJnBrFt95Qw6S7oBFvDlWXpCCmyvUO/eALNcJW6ZjYxsQd0a5+NlO/w==
X-Received: by 2002:a05:600c:a088:b0:499:7a19:408b with SMTP id
 5b1f17b1804b1-499b83572bbmr84063985e9.11.1787310116492; 
 Fri, 21 Aug 2026 04:01:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/43] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary
 case
Date: Fri, 21 Aug 2026 12:00:31 +0100
Message-ID: <20260821110101.3971391-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The trans_WHILE_ptr function incorrectly handles the case where the
address difference divided by ESIZE results in zero. This happens when
the address difference is less than ESIZE but greater than zero.

Fix by dropping direct comparisons of op0 vs op1, and instead
testing the scaled diff vs 0.  Merge with the bounding to the
maximum vector length via wrapping arithmetic.

Cc: qemu-stable@nongnu.org
Fixes: 14f6dad168e ("target/arm: Implement SVE2 WHILERW, WHILEWR")
Reported-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260811191540.79882-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 38 +++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fc4cc8c479f..0becef16a94 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3697,7 +3697,7 @@ TRANS_FEAT(WHILE_gt_cnt4, aa64_sme2_or_sve2p1, do_WHILE,
 
 static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
 {
-    TCGv_i64 op0, op1, diff, t1, tmax;
+    TCGv_i64 op0, op1, diff, t1;
     TCGv_i32 t2;
     TCGv_ptr ptr;
     unsigned vsz = vec_full_reg_size(s);
@@ -3713,7 +3713,6 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     op0 = read_cpu_reg(s, a->rn, 1);
     op1 = read_cpu_reg(s, a->rm, 1);
 
-    tmax = tcg_constant_i64(vsz >> a->esz);
     diff = tcg_temp_new_i64();
 
     if (a->rw) {
@@ -3723,25 +3722,36 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
         tcg_gen_sub_i64(diff, op0, op1);
         tcg_gen_sub_i64(t1, op1, op0);
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, diff, t1);
-        /* Divide, rounding down, by ESIZE.  */
-        tcg_gen_shri_i64(diff, diff, a->esz);
-        /* If op1 == op0, diff == 0, and the condition is always true. */
-        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
     } else {
         /* WHILEWR */
-        tcg_gen_sub_i64(diff, op1, op0);
-        /* Divide, rounding down, by ESIZE.  */
-        tcg_gen_shri_i64(diff, diff, a->esz);
-        /* If op0 >= op1, diff <= 0, the condition is always true. */
-        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
+        /* Saturating subtraction maps diff <= 0 to diff == 0. */
+        tcg_gen_ussub_i64(diff, op1, op0);
     }
 
-    /* Bound to the maximum.  */
-    tcg_gen_umin_i64(diff, diff, tmax);
+    /* Divide, rounding down, by ESIZE.  */
+    tcg_gen_shri_i64(diff, diff, a->esz);
 
-    /* Since we're bounded, pass as a 32-bit type.  */
+    /*
+     * If diff == 0, the condition is always true.  Also, bound to max.
+     * Simplify
+     *    diff = diff ? diff : max;
+     *    diff = umin(diff, max);
+     * via
+     *    diff -= 1;
+     *    diff = umin(diff, max - 1);
+     *    diff += 1;
+     * via 0 - 1 == UINT64_MAX.
+     */
+    tcg_gen_addi_i64(diff, diff, -1);
+    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
+
+    /*
+     * Since we're bounded, pass as a 32-bit type.
+     * Sink the diff += 1 from above into the 32-bit type.
+     */
     t2 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, diff);
+    tcg_gen_addi_i32(t2, t2, 1);
 
     desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
     desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
-- 
2.43.0


