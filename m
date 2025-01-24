Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3F1C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMdy-00018P-7R; Fri, 24 Jan 2025 11:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZR-0005xv-RQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:19 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZH-0005oZ-99
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso15352995e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736199; x=1738340999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQP+mP8aoERhG/l82UzKUhVhRS0CYJg3hdc1vQH02Ms=;
 b=l5aMiUJMJIoXlAMi1Tvd/ob3DsmkIzNecnMF6NE34pBLtRwFWNz7yCQF7CMwHWg2Oi
 f39FWXNf5wYZUCODnDMj3ZGrl7Gzf8vqhN9mvZpTaQ6SxWGyq0fcNfVU73GqoxEIWPt8
 LH98hGygZZ5uUR6y9XURTSoz6r7/x6XG1RrQj7dL5nkgMNpxGd+pN86wTNlDRX731jBu
 U/17RrgmYgFCWdK4l3j14l3/d73Y8ezgO8XfouteTatmk5ngsRSF/tEI2iRXCLeDe0vN
 UOePXeuk6LEH5T43J8WaLdYRbH33J7l/dfSSF2jPIdmeOt37SAqlK4tLMu28s17hykEH
 Nuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736199; x=1738340999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQP+mP8aoERhG/l82UzKUhVhRS0CYJg3hdc1vQH02Ms=;
 b=HZfMORUhM93KosGY+29ZSeKs0h5zy58XF4w7gc2Bhu1zTqPHtlYLhK1Qh73L1JCkKn
 oS3MptmgymBEzZKcawRsWrgjC99pTVY6DRPU7Rw71dG6avraX0PzbRqw0jQn3eLN+UNj
 +DjAB7YLD4rPsOyaja3Q9q20B54vWwdta7OtoRhgunCS1k7kn9jl7AnyJajy+ihcZRdY
 HfSx0AIK22L/Dxlv9tmLV1DlM4rQ+oRQeqpO8/6ydpd0mAUcoqqEec0L5zMZgYqPu0ol
 s7/+Sa9mVPeJ9sArhl/4HkaNB66H8lliP6XbRHuPDGUc6GzAV8cqujVmzWB0b1uC3VlD
 K3Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxXUWZTzrHrgEWM6rG6q3f51ee1tVlx6lEbC3/p3zdsMj6J5hIeJZolnxDJKTQ0jlnHeqLeduIXWzc@nongnu.org
X-Gm-Message-State: AOJu0YxSTDRyuUSiQ/MG2t8c5RLjSl0ZHuplMC+zdBiN1Z+mQtaXFasY
 eUJW+a7SV/hFNKIo8d8M3xBi3F5EtRvD2htqJbBI6bB26BehNpkclcjKBIJmmfg9GLb+yLLDfkQ
 c
X-Gm-Gg: ASbGncvkd/R+z63ula0ec1v9UkxqUo1+w3hpFRDkdLtKumUEwB6Rcfte9nKQ2P1rR0+
 58eKG2HZix9T36hiyTrYLMxkirdIMPk1evjUaYHrumszNp9NJSCNjCptUFcsRecs3pPyZBSH7/Z
 I+HNGbGLkr92psPfpNSExRbtG4gn5Ws6/EILZcfAyIeQgqSxSsIXz1RvSfaZEZY4RWtipXYDjwb
 yZAumsTZmtbCNFvkT8X90ZIqUN3OIr2DlwyAcVz6BZJYddn5Xi7S95RBw2luDjJ4sjDl2qHa2LG
 hDfyHLOqokw=
X-Google-Smtp-Source: AGHT+IE7Iz0bDBL9YOgkD2DQkuVb0zJrVf0mu4Jm/g/K/IXHtbsrhQqTDvQKe0LG2TUoZEEXvHF7Nw==
X-Received: by 2002:a05:600c:21d8:b0:434:ea1a:e30c with SMTP id
 5b1f17b1804b1-438bd0bca9amr41267815e9.13.1737736199253; 
 Fri, 24 Jan 2025 08:29:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 64/76] target/arm: Handle FPCR.AH in negation in FMLS (vector)
Date: Fri, 24 Jan 2025 16:28:24 +0000
Message-Id: <20250124162836.2332150-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Handle the FPCR.AH "don't negate the sign of a NaN" semantics
in FMLS (vector), by implementing a new set of helpers for
the AH=1 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  4 ++++
 target/arm/tcg/translate-a64.c |  7 ++++++-
 target/arm/tcg/vec_helper.c    | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 43505d5fedc..0a8b4c946e1 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -782,6 +782,10 @@ DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c688275106f..0b57e35f999 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5871,7 +5871,12 @@ static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
     gen_helper_gvec_vfms_s,
     gen_helper_gvec_vfms_d,
 };
-TRANS(FMLS_v, do_fp3_vector, a, 0, f_vector_fmls)
+static gen_helper_gvec_3_ptr * const f_vector_fmls_ah[3] = {
+    gen_helper_gvec_ah_vfms_h,
+    gen_helper_gvec_ah_vfms_s,
+    gen_helper_gvec_ah_vfms_d,
+};
+TRANS(FMLS_v, do_fp3_vector_2fn, a, 0, f_vector_fmls, f_vector_fmls_ah)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmeq[3] = {
     gen_helper_gvec_fceq_h,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5e9663382a9..c720b435d58 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1579,6 +1579,27 @@ static float64 float64_mulsub_f(float64 dest, float64 op1, float64 op2,
     return float64_muladd(float64_chs(op1), op2, dest, 0, stat);
 }
 
+static float16 float16_ah_mulsub_f(float16 dest, float16 op1, float16 op2,
+                                 float_status *stat)
+{
+    op1 = float16_is_any_nan(op1) ? op1 : float16_chs(op1);
+    return float16_muladd(op1, op2, dest, 0, stat);
+}
+
+static float32 float32_ah_mulsub_f(float32 dest, float32 op1, float32 op2,
+                                 float_status *stat)
+{
+    op1 = float32_is_any_nan(op1) ? op1 : float32_chs(op1);
+    return float32_muladd(op1, op2, dest, 0, stat);
+}
+
+static float64 float64_ah_mulsub_f(float64 dest, float64 op1, float64 op2,
+                                 float_status *stat)
+{
+    op1 = float64_is_any_nan(op1) ? op1 : float64_chs(op1);
+    return float64_muladd(op1, op2, dest, 0, stat);
+}
+
 #define DO_MULADD(NAME, FUNC, TYPE)                                        \
 void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
                   float_status *stat, uint32_t desc)                       \
@@ -1605,6 +1626,10 @@ DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
 DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
 DO_MULADD(gvec_vfms_d, float64_mulsub_f, float64)
 
+DO_MULADD(gvec_ah_vfms_h, float16_ah_mulsub_f, float16)
+DO_MULADD(gvec_ah_vfms_s, float32_ah_mulsub_f, float32)
+DO_MULADD(gvec_ah_vfms_d, float64_ah_mulsub_f, float64)
+
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
  */
-- 
2.34.1


