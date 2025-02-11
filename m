Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD2DC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6V-0007d6-J3; Tue, 11 Feb 2025 11:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5e-0006W2-Tt
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:27 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5d-00039x-71
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4395561ab71so8284505e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291184; x=1739895984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7dyLKxLX4AdtS3tHaeGy6yAUU+znVzaV3FfmSWYqaks=;
 b=J7rCHsvSTmZQa3y+5ZFvVyLY3u8DhoIL879UfL31lBX8qfHYRbjVVOrAd+46Xcl4ON
 9joppJQxOqIrkq6ZolNpFq08JG7sI93+h2BZ66b4aqP52Em0fo1RWwVzCq31nTLLVpN0
 b7eau/4/VvjSllQWP8FMkesHNEMZcbMc1bbu7r7XLaI8bUnFowF1BfpbgS3OpHOwthyl
 F/Dt+eb6STebz5iMtWm1kxMcvyuTIKPQzmE0EJqmlk/4uozynKEX4/pl6UIXpHZr917q
 ZQdVEkU/CtOFs7XXliGhLZzZS380bNwRlyQANurVGt6H6c8qJhxkKT7csKFoLhE33veY
 /h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291184; x=1739895984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dyLKxLX4AdtS3tHaeGy6yAUU+znVzaV3FfmSWYqaks=;
 b=cmgpLeve7RuToVdc7aY09wBx7SASMUE+K5R3YDxFS/Lgqownz3iYHF8dC0saZCxZgb
 wAlQunNdYKUtc+aivYmqNs6+VjwWQRGOiaiKuKE0OgxTwM4hiNxvkioAQ3ZFIbgQe/uc
 x1JNgG8nED8hOEU/dhp65A4cQUKvd6aKQhq9jq1dgsRwtaJSgYz9mpXYBK/YZzMYa/q7
 kevsz2rqLKR2sAudthFDDSJQlBSuhPI/FVm8qgCLCtsrLbPAhdNsoUC5zN4wCV3NpteU
 jsoDHZ/pCA+3owTPsZ9mvRjFeKd0m0q7767ZJPdzIGSg5YLO9iDt1mc5zKLsr9AOCgTE
 ky1g==
X-Gm-Message-State: AOJu0YzkL1fGvcf9CJSTJveeqqhEgWpXHwq3gqVnMeF6DqaL4SeVIUax
 xX/PvHGM+n0OTFCBozs1zeVBcTcYM76ISgHYfy0eadT2kxdgv8gyWDtAq4PAhbskctNdgUQYEQE
 M
X-Gm-Gg: ASbGncupYKDR9bJQKjlDKN/THl2gfYXp5UTITErJeKtwlfhbb83l2YyoXL0HqyAuyzJ
 oW0rhso4rzOu3b/xX2cCJYp5GGuSrs1IIh0uCtBLI3QYGv+SJR07KWOoejlK0V28e9a0kwl2bbI
 66OqzzAgS61PJWvmrs6buDwbZ46o7T/KwgmEDzoA2u4ri5/wmKaJWpJfabnLWzuyHcCBSdkHBeb
 jIk7oMuG0Sp0GwQ9/jpZYOFXl1Xr5jPMRJEvhSSkOSQ2ssXNn5BmXCQV963dhxdNfbiIM8EHaaf
 7RI0FB3opAStxcGGSDfu
X-Google-Smtp-Source: AGHT+IFtH8aNwNVMde7zFRlackNk0j8/m1hf8IC3KTAOYHSQDCOWoP67pbN1M/Zi21RhRZ93Lu/YAw==
X-Received: by 2002:a5d:64a6:0:b0:38d:de38:746d with SMTP id
 ffacd0b85a97d-38dde387647mr9062569f8f.47.1739291183739; 
 Tue, 11 Feb 2025 08:26:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/68] target/arm: Implement FPCR.AH semantics for FMINP and
 FMAXP
Date: Tue, 11 Feb 2025 16:25:12 +0000
Message-Id: <20250211162554.4135349-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Implement the FPCR.AH semantics for the pairwise floating
point minimum/maximum insns FMINP and FMAXP.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
 target/arm/tcg/vec_helper.c    | 10 ++++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index f1b4606f763..8349752e99b 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -986,6 +986,20 @@ DEF_HELPER_FLAGS_5(gvec_ah_fmin_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_ah_fmin_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fmaxp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fminp_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_4(sve_faddv_h, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sve_faddv_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4ae0426bf76..02701b10c6b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5765,14 +5765,24 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxp[3] = {
     gen_helper_gvec_fmaxp_s,
     gen_helper_gvec_fmaxp_d,
 };
-TRANS(FMAXP_v, do_fp3_vector, a, 0, f_vector_fmaxp)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fmaxp[3] = {
+    gen_helper_gvec_ah_fmaxp_h,
+    gen_helper_gvec_ah_fmaxp_s,
+    gen_helper_gvec_ah_fmaxp_d,
+};
+TRANS(FMAXP_v, do_fp3_vector_2fn, a, 0, f_vector_fmaxp, f_vector_ah_fmaxp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminp[3] = {
     gen_helper_gvec_fminp_h,
     gen_helper_gvec_fminp_s,
     gen_helper_gvec_fminp_d,
 };
-TRANS(FMINP_v, do_fp3_vector, a, 0, f_vector_fminp)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fminp[3] = {
+    gen_helper_gvec_ah_fminp_h,
+    gen_helper_gvec_ah_fminp_s,
+    gen_helper_gvec_ah_fminp_d,
+};
+TRANS(FMINP_v, do_fp3_vector_2fn, a, 0, f_vector_fminp, f_vector_ah_fminp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnmp[3] = {
     gen_helper_gvec_fmaxnump_h,
@@ -6764,9 +6774,16 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
     return true;
 }
 
+static bool do_fp3_scalar_pair_2fn(DisasContext *s, arg_rr_e *a,
+                                   const FPScalar *fnormal,
+                                   const FPScalar *fah)
+{
+    return do_fp3_scalar_pair(s, a, s->fpcr_ah ? fah : fnormal);
+}
+
 TRANS(FADDP_s, do_fp3_scalar_pair, a, &f_scalar_fadd)
-TRANS(FMAXP_s, do_fp3_scalar_pair, a, &f_scalar_fmax)
-TRANS(FMINP_s, do_fp3_scalar_pair, a, &f_scalar_fmin)
+TRANS(FMAXP_s, do_fp3_scalar_pair_2fn, a, &f_scalar_fmax, &f_scalar_fmax_ah)
+TRANS(FMINP_s, do_fp3_scalar_pair_2fn, a, &f_scalar_fmin, &f_scalar_fmin_ah)
 TRANS(FMAXNMP_s, do_fp3_scalar_pair, a, &f_scalar_fmaxnm)
 TRANS(FMINNMP_s, do_fp3_scalar_pair, a, &f_scalar_fminnm)
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 9f77aa6b919..61e6e54570c 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2444,6 +2444,16 @@ DO_3OP_PAIR(gvec_fminnump_h, float16_minnum, float16, H2)
 DO_3OP_PAIR(gvec_fminnump_s, float32_minnum, float32, H4)
 DO_3OP_PAIR(gvec_fminnump_d, float64_minnum, float64, )
 
+#ifdef TARGET_AARCH64
+DO_3OP_PAIR(gvec_ah_fmaxp_h, helper_vfp_ah_maxh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fmaxp_s, helper_vfp_ah_maxs, float32, H4)
+DO_3OP_PAIR(gvec_ah_fmaxp_d, helper_vfp_ah_maxd, float64, )
+
+DO_3OP_PAIR(gvec_ah_fminp_h, helper_vfp_ah_minh, float16, H2)
+DO_3OP_PAIR(gvec_ah_fminp_s, helper_vfp_ah_mins, float32, H4)
+DO_3OP_PAIR(gvec_ah_fminp_d, helper_vfp_ah_mind, float64, )
+#endif
+
 #undef DO_3OP_PAIR
 
 #define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
-- 
2.34.1


