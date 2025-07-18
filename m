Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB98FC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucpDk-0007A9-Vh; Fri, 18 Jul 2025 13:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucov0-000537-EB
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucoux-0000r0-Mn
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso24721345e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859841; x=1753464641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83s1l7e8slhfNxjdmj0HuMqD4EcLsV28TpE5dx21NzY=;
 b=ptzvvufoKTTe0GsziqwQAEtd7TUaitvGZtN7M9IEV0ePxpm4njk/i+ipqadPS5aKnx
 hcqEjtvv0ylrbY1wwG0TXC03arKEOPE1FghgALbHp9E9r/8LMK5kLr4ctvpRXFCUyEAW
 TmwD9nsFKmY2MiRGX0euah52FH3b7wN7CUHzxtqFf++YRRgp/wOL6OR81+weKI7r0OdF
 8IWnC8Z8Tqc+/JksxiAhgUSW1PNnYs4YIP7+VZ4e1J9b58rNzjE1yynR9AJAALqF4/EY
 kCyWVK25U2spOYLmHsM1WyRBIwdo6+zZVZX4eQHriZzjqbcC3jZfKtfYftfhZUPVZjt6
 FIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859841; x=1753464641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83s1l7e8slhfNxjdmj0HuMqD4EcLsV28TpE5dx21NzY=;
 b=Yh73Da7dbJSGi2qNHkUkrYQR2zAkxfLwxu6RrmqsgtWwRByokkU2jEkTxQJm/wxC2u
 3emILHi00sNf70KT+2kg5hFSV8tX+KrufbyK5Tb/yb+PwsGUiWQfl54DEc+2WZvFf5va
 2kQEeitwCR/zZn2u6xQ5hlW3mlmUa6AnoFitri3ghQ/84vacK2a3OdnYmZm0h/TS9gu/
 RnPK176C8YpCAevOXyiWP4iFA7FOasxCkS85Hvdm11/nq9+RmOdjxQcQQgKIEsY8HArS
 ZMPxnvRz3drEE+6wSN3577gnpXtoADDVUkC5N6lMr0VQL4yguNxLYESG1LnoNfasOiWh
 tSoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/QO1JtWu3DzQ93t2hi5oViOpvh/MZr+FS5K+EKEw9+5RV+ClpaoE9PvyetmSsqIfc/f/gYoUpGKta@nongnu.org
X-Gm-Message-State: AOJu0YwNRQmQYSiqjYwyhmoGpugHGQixIjSpfNpAns1mHutj5OpxDovV
 txknv2njnHC/pxu7a6RMIFD754B1aYaynrsIlQyQjpM4dnJG1VddmNb8xpsCmnB+wF8=
X-Gm-Gg: ASbGncvxfUIFVQPW9SRQJHjQ9puGKepj6ufCVuwC4CpC5YarVLvJZIq/fwpZwArHZhY
 Fvyu8hLzLULA+IcTAAGX8FEZoKrv4Lo/HWbrtl8ObIj6V6I9i7a0G0qytNTzxE0afDM1Gm61iNc
 KXgvGqgoQbzHOAhSm5TmcZzp3CQPhPDafb8jXMWrvPmc9BUAUGhQwwW3wMLuZ879e3iYoQGVSkV
 wUenSBnv7XBCmgnoggxjpvQLQWrR/zMy5L8/S5rySycdsVIIbfunqBpVHetOfv5euUszqk2cU7t
 pfHfa7wgjKHrs6N+YhZHmCeQF8LANNXicnzcsEnaozkDYoshygA52for7klhUFZR/V3CgHZSijM
 zVIJp9uU63KVj4CMbsT1Wyl3dB5D8
X-Google-Smtp-Source: AGHT+IF5qlS51ngxkOnePtdx/r9fP5wVYXkNq5FayuK+HvABgeKa+5Hq+untG0XVyYjLx/kbLxjQng==
X-Received: by 2002:a05:600c:c4a6:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-45632a45295mr92026695e9.4.1752859841431; 
 Fri, 18 Jul 2025 10:30:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 05/10] target/arm: Add BFMLA, BFMLS (vectors)
Date: Fri, 18 Jul 2025 18:30:27 +0100
Message-ID: <20250718173032.2498900-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718173032.2498900-1-peter.maydell@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


