Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E156CC83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwnY-00015z-HX; Wed, 02 Jul 2025 08:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjV-0004Le-Mh
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:41 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjG-00025s-1q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:35 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2efb0b03e40so1235226fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459898; x=1752064698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dEgFe/aMCLBRuy/ILH5OuLrM9Ftc/PXr/fYOnWwFMI=;
 b=RC0q/FXjmmFlV5HYOXFqhb48rcYIGtkwDUGo0SNLxttDjq7wyF5QQNNoeU4jg5FXjj
 7oy/CmiLQEtEaXhXxckwSO+urZuzNrNVtTFAXzWADoObk9c/uV+7QBgHKdOAe6M0Gy6S
 fW6Z9Q7TJBB+PQOj1ona37vvULhxO5W5YMdBrKiRspX+5uX7hS6m3+Wo9FJkKRg9PiIQ
 VqtIQzJDcXSdBHHXUpMijIGKkrLrSdLi3aILiwETJglw6BdtsVbRCDLhk1GiEuvc9eB4
 9GEkvro92PIDAwvkb2ql3Y7aJuHIMuckBTRuSA7IhQgIjqN5QG0yK/mUX6p/1svMhabc
 9pMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459898; x=1752064698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dEgFe/aMCLBRuy/ILH5OuLrM9Ftc/PXr/fYOnWwFMI=;
 b=BN1IjDQUoRLPJbXvqUU0/7QexnLiy1/68gcWIa2md9hGoKFvfONmtGHThc4rtbncA9
 pc+rBQKNLlOriXKHBfkTU0vRs4gnncSF21zYOQA6UUgQPR0rYT8pIq08nyFTHlo7tWDM
 c1HCKrAeBntXsQho8vMnk/C9LvP9oM9HVZfcuZ0U54FVtRxPOYSfgnyWe5IBBPmNcA/4
 mg+8B2atIwvDy5wNI2jn4/KC5HpwgNhdhXdXgR6OiXvx3EUzraKF+YXt9QsBDQh+Xv7D
 66H6JDEzBCwLMNOcBodSjBZ+5RQtzBA9FElfywI0GmWLPGFBOZPgQBIou6upYTtzYIyj
 TpbQ==
X-Gm-Message-State: AOJu0YyPgpbbx4kW9/SFf9Fml2FPwQHCI/+Fi5prPr8Mv5xl/PYNtPSj
 5Baueb7NFfUm/c+BwxVGoW/3aP2Z0hal5QGeYeA3yygFAPX2QEpHZHDiEM4fOy9KhIgK3OnwVIU
 6rvYVA2Q=
X-Gm-Gg: ASbGnctadjYDkt5pC74GQh3ErdP6vDnus9LeAcNZ+Mu1SzW7BAIb6DxasKGEhYI+ttT
 UxvlblDsL/0AZEjL4bgGLGMF+DUnIz1TL/krcoPW6Na3+vnC6xC2IsieEYkheG20GHK4B9eezjH
 86ddxE2F6z/EoLTRyhxYkvwLk0bLbElherKOdhu0waQ0TeiIDbQpBcFvmp78uRVmLpR6tsCF952
 8eICzm6J2kjyDIJSS/xLlQX7eTnVO4bMoLIWYMHz38mV4AvoGJlpLz3TUpQwrJcLLGnmOLLOM68
 McnSEM5YxNvFBE7WxjTE57ogqoP8Fj7UkeWoyLXMpd6z6Q5bBNKbsQV/GqNDyqWoUcg17MOFUTB
 +l79h
X-Google-Smtp-Source: AGHT+IHmqzOlKCC1xxDEZ2JNthg4YRnmLoCR4FYf6On87DPUNaeILXHWX84JXrz9wNXzTsXscsFOrQ==
X-Received: by 2002:a05:6870:92c8:b0:2d5:ba2d:80da with SMTP id
 586e51a60fabf-2f5abe40dbfmr1873778fac.36.1751459898243; 
 Wed, 02 Jul 2025 05:38:18 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 52/97] target/arm: Implement SME2 ZIP, UZP (four registers)
Date: Wed,  2 Jul 2025 06:33:25 -0600
Message-ID: <20250702123410.761208-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 12 ++++++
 target/arm/tcg/sme_helper.c    | 68 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 39 +++++++++++++++++++
 target/arm/tcg/sme.decode      | 11 ++++++
 4 files changed, 130 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 893b23aa3b..7e21f1095a 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -254,3 +254,15 @@ DEF_HELPER_FLAGS_3(sme2_uunpk2_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_zip4_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_uzp4_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index a7d282695d..83646a3665 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1805,3 +1805,71 @@ void HELPER(sme2_ucvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d[i] = uint32_to_float32(s[i], fpst);
     }
 }
+
+#define ZIP4(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch[4];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t quads = oprsz / (sizeof(TYPE) * 4);                  \
+    TYPE *s0, *s1, *s2, *s3;                                    \
+    if (vs == vd) {                                             \
+        vs = memcpy(scratch, vs, sizeof(scratch));              \
+    }                                                           \
+    s0 = vs;                                                    \
+    s1 = vs + sizeof(ARMVectorReg);                             \
+    s2 = vs + 2 * sizeof(ARMVectorReg);                         \
+    s3 = vs + 3 * sizeof(ARMVectorReg);                         \
+    for (size_t r = 0; r < 4; ++r) {                            \
+        TYPE *d = vd + r * sizeof(ARMVectorReg);                \
+        size_t base = r * quads;                                \
+        for (size_t q = 0; q < quads; ++q) {                    \
+            d[H(4 * q + 0)] = s0[base + H(q)];                  \
+            d[H(4 * q + 1)] = s1[base + H(q)];                  \
+            d[H(4 * q + 2)] = s2[base + H(q)];                  \
+            d[H(4 * q + 3)] = s3[base + H(q)];                  \
+        }                                                       \
+    }                                                           \
+}
+
+ZIP4(sme2_zip4_b, uint8_t, H1)
+ZIP4(sme2_zip4_h, uint16_t, H2)
+ZIP4(sme2_zip4_s, uint32_t, H4)
+ZIP4(sme2_zip4_d, uint64_t, )
+ZIP4(sme2_zip4_q, Int128, )
+
+#undef ZIP4
+
+#define UZP4(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch[4];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t quads = oprsz / (sizeof(TYPE) * 4);                  \
+    TYPE *d0, *d1, *d2, *d3;                                    \
+    if (vs == vd) {                                             \
+        vs = memcpy(scratch, vs, sizeof(scratch));              \
+    }                                                           \
+    d0 = vd;                                                    \
+    d1 = vd + sizeof(ARMVectorReg);                             \
+    d2 = vd + 2 * sizeof(ARMVectorReg);                         \
+    d3 = vd + 3 * sizeof(ARMVectorReg);                         \
+    for (size_t r = 0; r < 4; ++r) {                            \
+        TYPE *s = vs + r * sizeof(ARMVectorReg);                \
+        size_t base = r * quads;                                \
+        for (size_t q = 0; q < quads; ++q) {                    \
+            d0[base + H(q)] = s[H(4 * q + 0)];                  \
+            d1[base + H(q)] = s[H(4 * q + 1)];                  \
+            d2[base + H(q)] = s[H(4 * q + 2)];                  \
+            d3[base + H(q)] = s[H(4 * q + 3)];                  \
+        }                                                       \
+    }                                                           \
+}
+
+UZP4(sme2_uzp4_b, uint8_t, H1)
+UZP4(sme2_uzp4_h, uint16_t, H2)
+UZP4(sme2_uzp4_s, uint32_t, H4)
+UZP4(sme2_uzp4_d, uint64_t, )
+UZP4(sme2_uzp4_q, Int128, )
+
+#undef UZP4
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b45e68750d..de9545ee6d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1435,3 +1435,42 @@ TRANS_FEAT(UUNPK_2sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_sd)
 TRANS_FEAT(UUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_bh)
 TRANS_FEAT(UUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_hs)
 TRANS_FEAT(UUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_sd)
+
+static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
+                        gen_helper_gvec_2 * const fn[5])
+{
+    int bytes_per_op = 4 << a->esz;
+
+    /* Both MO_64 and MO_128 can fail the size test. */
+    if (s->max_svl < bytes_per_op) {
+        unallocated_encoding(s);
+    } else if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        if (svl < bytes_per_op) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd),
+                               vec_full_reg_offset(s, a->zn),
+                               svl, svl, 0, fn[a->esz]);
+        }
+    }
+    return true;
+}
+
+static gen_helper_gvec_2 * const zip4_fns[] = {
+    gen_helper_sme2_zip4_b,
+    gen_helper_sme2_zip4_h,
+    gen_helper_sme2_zip4_s,
+    gen_helper_sme2_zip4_d,
+    gen_helper_sme2_zip4_q,
+};
+TRANS_FEAT(ZIP_4, aa64_sme2, do_zipuzp_4, a, zip4_fns)
+
+static gen_helper_gvec_2 * const uzp4_fns[] = {
+    gen_helper_sme2_uzp4_b,
+    gen_helper_sme2_uzp4_h,
+    gen_helper_sme2_uzp4_s,
+    gen_helper_sme2_uzp4_d,
+    gen_helper_sme2_uzp4_q,
+};
+TRANS_FEAT(UZP_4, aa64_sme2, do_zipuzp_4, a, uzp4_fns)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 38c210cd4f..81783b4705 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -723,6 +723,7 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 
 ### SME2 Multi-vector SVE Constructive Unary
 
+&zz_e           zd zn esz
 &zz_n           zd zn n
 @zz_1x2         ........ ... ..... ...... ..... zd:5        \
                 &zz_n n=1 zn=%zn_ax2
@@ -800,3 +801,13 @@ SUNPK_4sd       11000001 111 10101 111000 ....0 ...00       @zz_4x2_n1
 UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
+
+ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
+                &zz_e zd=%zd_ax4 zn=%zn_ax4
+ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
+                &zz_e esz=4 zd=%zd_ax4 zn=%zn_ax4
+
+UZP_4           11000001 esz:2 1 10110 111000 ...00 ... 10   \
+                &zz_e zd=%zd_ax4 zn=%zn_ax4
+UZP_4           11000001 001     10111 111000 ...00 ... 10   \
+                &zz_e esz=4 zd=%zd_ax4 zn=%zn_ax4
-- 
2.43.0


