Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E8CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYi-0004Hn-HF; Mon, 21 Jul 2025 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYL-0000KK-Pi
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYH-0005Jv-TB
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b49ffbb31bso2721267f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104451; x=1753709251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+k3hZvnicSQlwCFWXFQT5ayGDKEjpiuAoZcY2ne8PPw=;
 b=TSPxhyRlCKxhW4ltfwY5YvNqoP+lLNpfnFX8f4y6ILCIZsxIViuo50wOkR6dL6kUzA
 QNpqKlwGgtwMrryYNOlixJoFmYpylJfElFUoiJCysnhqVHMCwqqbdPZW7wfGQvzPThtg
 Ey0fRWtmV7mWN17uu0nAwMtYPlShBEZQlqf14i9Fs7rj9vq295hv58c0dWrQL/x7FrJV
 ZCFbcCA0hYyE3k+JTxKom/A4bvVWc5towsn9iEcHcZh7s0ARIBQlWB2A8GP1/0cLG6UO
 ZYmFUZXt9vGbfYkDdtIaVuFtVYSe6/LDV8TEttaNGBbBmQA/RE6tbcnur6v60S5E0VnQ
 QD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104451; x=1753709251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+k3hZvnicSQlwCFWXFQT5ayGDKEjpiuAoZcY2ne8PPw=;
 b=hsHWpdCabpRkYrdBhdzDo5W2yJIoKSW6P0qVhE70CQrGyBXHya1T+F2x/iv6kQR3SG
 yuvu4BqT46+fv75/zOlyBTg/lGxz4mVmetbToEA2MP4boH4wGHr2sixQ7F/6erM30pfG
 Tl7It74BiuVif3lPHsYEkHQCTwSLK6btRbGpfXtjv3vc6mG6Qw429zKQBzEx1KHZ2O33
 OLLtmDsciYqBW5xZG4ZOhpKUzbfMcn2/vj5IkLARndDylvVMj7T2MCmmbsCYAaVmFH+8
 OykJ8bnj+XqH13XoAgE2zrEZBv2RVZJhrgJC/72Ct2UjcERPycGU11LxMYWRbp7hMrs+
 q/1Q==
X-Gm-Message-State: AOJu0Yx4zKW65ntkP+y77+uvnW6cE1BBRK63J+WSOvLs/4qX6Ps+3gfz
 ZtavJRdC6X2KH/6TiwLPY8jjJlRzjtj/iidik1kIDMGrUCD9P2sl/Wz43YPQYZ7Z9KJycNeY4Ep
 l5uKQ
X-Gm-Gg: ASbGncsQH3EDjXOKLb5hIvveplVvNVL2fZTD5dEozF/cxaAfT2U71zPpPKWCX6gTo9C
 rsJYW/0I7UT7zFloYfxtKdMfv2khOQ9iADJiJdLmAqClJ405sBVgcxOWFrWcntBHOECF27W5UZq
 Gug52z5TjiWysQ4A3C73sprQc/Z43i5XGTxv85U76QkUQk+Yxlo9SMVmQ6IAq+GRkcxAwu7eVTh
 PbpR6I1IqiMPZKUvtKYUqw65/OZlKbCf9Y6c8gQ4oKQ8pP2n4AP+ExUF3S8ceSRZ3MjfXE+rGY9
 nYazxB+Bs7uzHtXIcXPwVvTnWryC+OJR9080Ybc+cqv5mb7UwNZELU5AyheFB9eQ86ktvZRU9fP
 5f/dK46pZ7A/5hnD6flRca/1oPALq
X-Google-Smtp-Source: AGHT+IFxTVsWRrqo7iOUjURceuDFogbyyYPcxqD4tVUvgSYTxjSKAPD/sQ6ML5qwDkBZO8thKscqag==
X-Received: by 2002:a5d:5d12:0:b0:3a4:ee40:715c with SMTP id
 ffacd0b85a97d-3b613e66f3amr13533220f8f.14.1753104451391; 
 Mon, 21 Jul 2025 06:27:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/20] target/arm: Add BFMLA, BFMLS (vectors)
Date: Mon, 21 Jul 2025 14:27:09 +0100
Message-ID: <20250721132718.2835729-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

FEAT_SVE_B16B16 adds bfloat16 versions of the FMLA and FMLS insns in
the "SVE floating-point multiply-accumulate writing addend" group,
encoded as sz=0b00.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-6-peter.maydell@linaro.org
---
 target/arm/tcg/helper-sve.h    | 14 +++++++
 target/arm/tcg/sve_helper.c    | 69 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 21 ++++++++---
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index cb6c2355e58..5e4b7fd8cf4 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1541,6 +1541,8 @@ DEF_HELPER_FLAGS_6(sve_fcadd_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fcadd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG,
@@ -1548,6 +1550,8 @@ DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG,
@@ -1555,6 +1559,8 @@ DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
@@ -1562,6 +1568,8 @@ DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
@@ -1569,6 +1577,8 @@ DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_s, TCG_CALL_NO_RWG,
@@ -1576,6 +1586,8 @@ DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_ah_fmls_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
@@ -1583,6 +1595,8 @@ DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_7(sve_ah_fnmla_zpzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sve_ah_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 1a56fa86d9c..105cc5dd122 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -5099,6 +5099,75 @@ DO_ZPZ_FP(flogb_d, float64, H1_8, do_float64_logb_as_int)
 
 #undef DO_ZPZ_FP
 
+static void do_fmla_zpzzz_b16(void *vd, void *vn, void *vm, void *va, void *vg,
+                              float_status *status, uint32_t desc,
+                              uint16_t neg1, uint16_t neg3, int flags)
+{
+    intptr_t i = simd_oprsz(desc);
+    uint64_t *g = vg;
+
+    do {
+        uint64_t pg = g[(i - 1) >> 6];
+        do {
+            i -= 2;
+            if (likely((pg >> (i & 63)) & 1)) {
+                float16 e1, e2, e3, r;
+
+                e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
+                e2 = *(uint16_t *)(vm + H1_2(i));
+                e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
+                r = bfloat16_muladd(e1, e2, e3, flags, status);
+                *(uint16_t *)(vd + H1_2(i)) = r;
+            }
+        } while (i & 63);
+    } while (i != 0);
+}
+
+void HELPER(sve_fmla_zpzzz_b16)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_b16(vd, vn, vm, va, vg, status, desc, 0, 0, 0);
+}
+
+void HELPER(sve_fmls_zpzzz_b16)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_b16(vd, vn, vm, va, vg, status, desc, 0x8000, 0, 0);
+}
+
+void HELPER(sve_fnmla_zpzzz_b16)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_b16(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000, 0);
+}
+
+void HELPER(sve_fnmls_zpzzz_b16)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_b16(vd, vn, vm, va, vg, status, desc, 0, 0x8000, 0);
+}
+
+void HELPER(sve_ah_fmls_zpzzz_b16)(void *vd, void *vn, void *vm, void *va,
+                              void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_b16(vd, vn, vm, va, vg, status, desc, 0, 0,
+                      float_muladd_negate_product);
+}
+
+void HELPER(sve_ah_fnmla_zpzzz_b16)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_b16(vd, vn, vm, va, vg, status, desc, 0, 0,
+                      float_muladd_negate_product | float_muladd_negate_c);
+}
+
+void HELPER(sve_ah_fnmls_zpzzz_b16)(void *vd, void *vn, void *vm, void *va,
+                               void *vg, float_status *status, uint32_t desc)
+{
+    do_fmla_zpzzz_b16(vd, vn, vm, va, vg, status, desc, 0, 0,
+                      float_muladd_negate_c);
+}
+
 static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
                             float_status *status, uint32_t desc,
                             uint16_t neg1, uint16_t neg3, int flags)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 918cf6e1bd4..37ecbc2b7c0 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4368,19 +4368,28 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
+static bool do_fmla_zpzzz(DisasContext *s, arg_rprrr_esz *a,
+                          gen_helper_gvec_5_ptr *fn)
+{
+    /* These insns use MO_8 to encode BFloat16 */
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
+        return false;
+    }
+    return gen_gvec_fpst_zzzzp(s, fn, a->rd, a->rn, a->rm, a->ra, a->pg, 0,
+                               a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+}
+
 #define DO_FMLA(NAME, name, ah_name)                                    \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
-        NULL, gen_helper_sve_##name##_h,                                \
+        gen_helper_sve_##name##_b16, gen_helper_sve_##name##_h,         \
         gen_helper_sve_##name##_s, gen_helper_sve_##name##_d            \
     };                                                                  \
     static gen_helper_gvec_5_ptr * const name##_ah_fns[4] = {           \
-        NULL, gen_helper_sve_##ah_name##_h,                             \
+        gen_helper_sve_##ah_name##_b16, gen_helper_sve_##ah_name##_h,   \
         gen_helper_sve_##ah_name##_s, gen_helper_sve_##ah_name##_d      \
     };                                                                  \
-    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp,                     \
-               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], \
-               a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
-               a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+    TRANS_FEAT(NAME, aa64_sve, do_fmla_zpzzz, a,                        \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
 
 /* We don't need an ah_fmla_zpzzz because fmla doesn't negate anything */
 DO_FMLA(FMLA_zpzzz, fmla_zpzzz, fmla_zpzzz)
-- 
2.43.0


