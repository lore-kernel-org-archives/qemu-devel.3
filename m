Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C89BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdw-00005d-Ax; Wed, 26 Aug 2026 13:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdr-0008UE-SY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:27 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdq-0004lt-4A
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:27 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c96c92c0980so848989a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766144; x=1788370944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hZEskbli4g2F3N+3TCJnxiYglitQsZnFYl0LsdySdls=;
 b=h04VC0o8NNuUsnmWhadByLffC04Xri82CjFMohtA7VXfm96IDb3O+mcKTYenLO+s08
 1OUb/8drlqo6ZUZv5T1yyKczmoRxi0BWWFs/FfPiDDRuNvYqyI/yHT2t3xgPq9x0skik
 RYuF0WMh/abc1UmzAeZvrB+cT7k/oIu5JMzNhYK8Nj4tuDTvvT2VboUNaJx2D39QSjie
 effXiNGaJaYpLO1F+KPm/Usuji2+cE/ILAqo9AiGXdjCn06e40JpK/elhx68c7riLL6B
 K54d6tYWzu+hnoXAEHcQvrMTvxHvwr+4b8JE1tKkExE2JI5NKXUyqEpb7QvQp8B5YkE6
 6gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766144; x=1788370944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hZEskbli4g2F3N+3TCJnxiYglitQsZnFYl0LsdySdls=;
 b=Pw6a0zTuqnJGKl+dICoMH2HA8mv+ieK6dlzWCIE90kA+eOEjJnI422mTJ0FtAb3ig7
 BoUfWo8w9Cq73hK/rgy/hQAdiW1DDm7zXuJZHYVVML/dm6r1smqQBzrdduFFhnppVQuB
 25OKMqlSZ10JKgpD9/9noUNg67vXlkGd2fiHtBAYFXfdjz+B5i74vhO5PhQoC55OaRmY
 f41LvBPIhesmISxpa1BhGnnH6bq4bxBOZjjnhRKgH3tkd0SGH/omt9kc5lWnbi/A0dF9
 Q56m5dCdJARMkqCsqDrDMsbquNHR9aM48UQqOG7OMXR3kbB3AjsUMIO2Ipnoy5xGBSaB
 Q0bQ==
X-Gm-Message-State: AFuF++kSZ42ExZXfZaGRgzZqlEicV9tD9nVTFZwsHmCZJ4nD9DboyZSl
 Q97gJRnPbVHbzlLaLETKzYtCXwqJmdH97hwSx3pyFbluGTqqwY6X5/FTDw5zQkFu0VbbzVp45+X
 712XKOk0=
X-Gm-Gg: AR+sD13Sbr/T8JejnfEnVQuJbNbrB4WZffE8yxODC8TNjd8eQkRyuSZNRmalOIddvxS
 SYFwjRhlajssQhz/qPqwGA9bLyEqTLeH9D/gSfR0jhBj+Bqh8ddUbxMyrmasBYUE6C0RlhbxeM3
 0bku0HT3y3MGpAzNCr1Blut0N7qg2seUD1rAT7+cBG45TZ3LvrltHNREEQm8h1ZyjXerMh1P1zu
 I3/ZQqTMW1RFoDRXeiJV8Ey4qA9FiP2QZPQ5S1ixLa08LadUuv+LoiosFGG3toC0GKeGcYX/j2q
 4Oc8v99R0uBwWi9HkfgCqYxZ9/ODtpudWP6NWJuQdb0QikoOzukChwbQEYDjzkWt+mMRhfs7UmE
 9CVm0LRb8WWtLBF2LMpYvJSbDkwePFx2xtW1GRPhkNDGpxJ45+lQ5gtcowt8ODq+FGJa1rjccyX
 64wlohr4YwQ6NI3OKAsJhXXou4bNufxDi8roMo72Hmwbxg/48HYWDVn44z+VZfOiisRM8OBEZNp
 CqZdZGOhgQ8DNd+MA==
X-Received: by 2002:a05:6a21:58b:b0:3c3:66c5:68d6 with SMTP id
 adf61e73a8af0-3cf83c17840mr17609947637.9.1787766144307; 
 Wed, 26 Aug 2026 10:42:24 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 07/25] target/arm: Remove DO_ZPZZ_FP_B16 from
 translate-sme.c
Date: Wed, 26 Aug 2026 10:41:54 -0700
Message-ID: <20260826174213.614571-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Expand the macro at each use site.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 59 ++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7e0b47412ba..347eeb4602e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4438,14 +4438,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-/* Similar, but for insns where sz == 0 encodes bfloat16 */
-#define DO_ZPZZ_FP_B16(NAME, FEAT, name) \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
-        gen_helper_##name##_b16, gen_helper_##name##_h,         \
-        gen_helper_##name##_s, gen_helper_##name##_d            \
-    };                                                          \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
-
 #define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
         gen_helper_##name##_b16, gen_helper_##name##_h,                 \
@@ -4459,13 +4451,54 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_FP_B16(FADD_zpzz, aa64_sme_or_sve, sve_fadd)
-DO_ZPZZ_FP_B16(FSUB_zpzz, aa64_sme_or_sve, sve_fsub)
-DO_ZPZZ_FP_B16(FMUL_zpzz, aa64_sme_or_sve, sve_fmul)
+static gen_helper_gvec_4_ptr * const sve_fadd_zpzz_fns[4] = {
+    gen_helper_sve_fadd_b16,
+    gen_helper_sve_fadd_h,
+    gen_helper_sve_fadd_s,
+    gen_helper_sve_fadd_d
+};
+TRANS_FEAT(FADD_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fadd_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fsub_zpzz_fns[4] = {
+    gen_helper_sve_fsub_b16,
+    gen_helper_sve_fsub_h,
+    gen_helper_sve_fsub_s,
+    gen_helper_sve_fsub_d
+};
+TRANS_FEAT(FSUB_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fsub_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fmul_zpzz_fns[4] = {
+    gen_helper_sve_fmul_b16,
+    gen_helper_sve_fmul_h,
+    gen_helper_sve_fmul_s,
+    gen_helper_sve_fmul_d
+};
+TRANS_FEAT(FMUL_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmul_zpzz_fns[a->esz], a)
+
 DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sme_or_sve, sve_fmin, sve_ah_fmin)
 DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sme_or_sve, sve_fmax, sve_ah_fmax)
-DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sme_or_sve, sve_fminnum)
-DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sme_or_sve, sve_fmaxnum)
+
+static gen_helper_gvec_4_ptr * const sve_fmaxnum_fns[4] = {
+    gen_helper_sve_fmaxnum_b16,
+    gen_helper_sve_fmaxnum_h,
+    gen_helper_sve_fmaxnum_s,
+    gen_helper_sve_fmaxnum_d
+};
+TRANS_FEAT(FMAXNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmaxnum_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fminnum_fns[4] = {
+    gen_helper_sve_fminnum_b16,
+    gen_helper_sve_fminnum_h,
+    gen_helper_sve_fminnum_s,
+    gen_helper_sve_fminnum_d
+};
+TRANS_FEAT(FMINNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fminnum_fns[a->esz], a)
+
 DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
 
 static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
-- 
2.53.0


