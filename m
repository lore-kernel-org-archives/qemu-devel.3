Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A52DC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg89b-00070L-RM; Thu, 06 Feb 2025 15:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83q-0007z7-C6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:20 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83i-0001BI-IS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:18 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f3328f72aso15379055ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872060; x=1739476860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9IwbEb/3vgBeI9XzJV8Nkyndofr5YjbeuVPZLmQGyk=;
 b=sxJYy6ZSXZc8MHADfWH6VTGugQeLvG5jkAIDchZohvu0cgIXk8n9b43xDGihIotA60
 9p5jvRD16o0mbzzTgbYEP/IV3ELmtWUuvHtpbEkqFEThBJH2N+ZvzzYp/oYTteMaZpRh
 n80QPlW03/OCx192ITS750avPx3sJk6KWBTgMCi/ukGeMc4kqL3i7uKinbC7IXJ1R01S
 PIjp9atYuhxayXDfkwnHYKK0L8QuqvhJ0Se95zyFDUtCtTbMn8UmLlp5B5/Dithf+ix6
 ZHFy9bpSCwS5W3lwrygJoZGHKp1LV9v2ojyfYUmEdSimXbD+/3VQ4au3U0yVzabEbqIb
 wJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872060; x=1739476860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9IwbEb/3vgBeI9XzJV8Nkyndofr5YjbeuVPZLmQGyk=;
 b=tGRMide0E9vGMEQJrDhBbL981PKQuPE/TSSXfucxLoe8Wr1XAl7kg8SWai0HPJu3ir
 PZ3irIqEwFGx/7t4Z5tPOGkuvSNLZ62pV38/CN5s94U1PALGkJeQdhdGgWlH0v3ou9Zq
 O7i4TCEKU6rDhiEB1/3etp0L6GfXLPp9ZkXO0pJKzVO3T/QUlLiKBxUIinQnc5bLbDvM
 apcW3CVXFfyBsV5lCUlYxZAP7P9H+NijkodNAtlcptIzI/glTJekxA78GGD7xi6/MqVT
 Cvurb0UJPQrYklRUmOwxqhlonkr3yFPdarQMGJB7gxLLsIB82CWdjGOVUB8nD84wOfu7
 Amhg==
X-Gm-Message-State: AOJu0Yy8gsFHpkjjNrJgmgiATBXedHjycBBRmuWxoUIUhGTWJQ6uzYJz
 unqTkza5Op6KHfamba/TZLyiKXSHFIxb6znYaiR5Hju5ildlljApAVlIXsuPH4YbzZPOz26M/CI
 L
X-Gm-Gg: ASbGnctB+cYDzUMa5jc5p+BRq2UqAgarFzFnsMRG4UgRVFa3rZ2vz7vHN8OM7UTEKrS
 jgx7DKzVXmJFxspI8yvQygnNamFgNyCKdmwMd/XMEoHwa4B+6Ism3KMNaSMKNTFSO6nfs2muuMo
 astccdVBWN7ugYEDNen+EGD80idOnBTamCMIwzpdEaIkfrBAsHRt5FMbT8FNFQSW9yjoFoo/oR8
 7v87DA6OQ9w8XJ27k5sUkP5reBs7/yPSUiZL7heatOOAJG3mXd4rGS5YRaMqG1fjCAJ8/c274/B
 K7v7WjP7lDc+VoMtt87d7jK3jirLiDPJJtrb/2YBcNTNkVk=
X-Google-Smtp-Source: AGHT+IH8Xn0NHdVTqSZYr7FkqDWpj+OwHk7E1/2fBpFOmTi8WJO+hD8zAecvmfWo6o0i160vC1liXA==
X-Received: by 2002:a17:903:2309:b0:215:a04a:89d5 with SMTP id
 d9443c01a7336-21f4e1cf038mr7008305ad.2.1738872059691; 
 Thu, 06 Feb 2025 12:00:59 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 58/61] target/arm: Implement SME2 ZIP, UZP (two registers)
Date: Thu,  6 Feb 2025 11:57:12 -0800
Message-ID: <20250206195715.2150758-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 target/arm/tcg/helper-sme.h    | 12 +++++++
 target/arm/tcg/sme_helper.c    | 58 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 37 ++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 12 +++++++
 4 files changed, 119 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index b9e1de63e6..a4216c8f3b 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -252,6 +252,18 @@ DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sme2_zip2_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_zip2_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_uzp2_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uzp2_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sme2_zip4_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_zip4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_zip4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 9a92302b8b..a88b602314 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1824,6 +1824,37 @@ void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define ZIP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch[2] __attribute__((uninitialized));     \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *n = vn, *m = vm;                                      \
+    if (vd >= vn && vn < vd + 2 * sizeof(ARMVectorReg)) {       \
+        n = memcpy(&scratch[0], vn, oprsz);                     \
+    }                                                           \
+    if (vd >= vm && vm < vd + 2 * sizeof(ARMVectorReg)) {       \
+        m = memcpy(&scratch[1], vm, oprsz);                     \
+    }                                                           \
+    for (size_t r = 0; r < 2; ++r) {                            \
+        TYPE *d = vd + r * sizeof(ARMVectorReg);                \
+        size_t base = r * pairs;                                \
+        for (size_t p = 0; p < pairs; ++p) {                    \
+            d[H(2 * p + 0)] = n[base + H(p)];                   \
+            d[H(2 * p + 1)] = m[base + H(p)];                   \
+        }                                                       \
+    }                                                           \
+}
+
+ZIP2(sme2_zip2_b, uint8_t, H1)
+ZIP2(sme2_zip2_h, uint16_t, H2)
+ZIP2(sme2_zip2_s, uint32_t, H4)
+ZIP2(sme2_zip2_d, uint64_t, )
+ZIP2(sme2_zip2_q, Int128, )
+
+#undef ZIP2
+
 #define ZIP4(NAME, TYPE, H)                                     \
 void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
 {                                                               \
@@ -1858,6 +1889,33 @@ ZIP4(sme2_zip4_q, Int128, )
 
 #undef ZIP4
 
+#define UZP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch __attribute__((uninitialized));        \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *d0 = vd, *d1 = vd + sizeof(ARMVectorReg);             \
+    if (vd >= vm && vm < vd + 2 * sizeof(ARMVectorReg)) {       \
+        vm = memcpy(&scratch, vm, oprsz);                       \
+    }                                                           \
+    for (size_t r = 0; r < 2; ++r) {                            \
+        TYPE *s = r ? vm : vn;                                  \
+        for (size_t p = 0; p < pairs; ++p) {                    \
+            d0[H(p)] = s[H(2 * p + 0)];                         \
+            d1[H(p)] = s[H(2 * p + 1)];                         \
+        }                                                       \
+    }                                                           \
+}
+
+UZP2(sme2_uzp2_b, uint8_t, H1)
+UZP2(sme2_uzp2_h, uint16_t, H2)
+UZP2(sme2_uzp2_s, uint32_t, H4)
+UZP2(sme2_uzp2_d, uint64_t, )
+UZP2(sme2_uzp2_q, Int128, )
+
+#undef UZP2
+
 #define UZP4(NAME, TYPE, H)                                     \
 void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
 {                                                               \
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 55c3310e9b..c449760add 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1427,3 +1427,40 @@ TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
 TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
 TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
 TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
+
+static bool do_zipuzp_2(DisasContext *s, arg_zzz_e *a,
+                        gen_helper_gvec_3 * const fn[5])
+{
+    int svl = streaming_vec_reg_size(s);
+
+    /* MO_128 can fail the size test. */
+    if (svl < (2 << a->esz)) {
+        return false;
+    }
+    if (sme_sm_enabled_check(s)) {
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vec_full_reg_offset(s, a->zm),
+                           svl, svl, 0, fn[a->esz]);
+    }
+    return true;
+}
+
+static gen_helper_gvec_3 * const zip2_fns[] = {
+    gen_helper_sme2_zip2_b,
+    gen_helper_sme2_zip2_h,
+    gen_helper_sme2_zip2_s,
+    gen_helper_sme2_zip2_d,
+    gen_helper_sme2_zip2_q,
+};
+TRANS_FEAT(ZIP_2, aa64_sme2, do_zipuzp_2, a, zip2_fns)
+
+static gen_helper_gvec_3 * const uzp2_fns[] = {
+    gen_helper_sme2_uzp2_b,
+    gen_helper_sme2_uzp2_h,
+    gen_helper_sme2_uzp2_s,
+    gen_helper_sme2_uzp2_d,
+    gen_helper_sme2_uzp2_q,
+};
+TRANS_FEAT(UZP_2, aa64_sme2, do_zipuzp_2, a, uzp2_fns)
+
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index b28113a883..bd485a26f0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -843,3 +843,15 @@ UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
 UQRSHRN_dh      11000001 1.1 ..... 110111 ...01 .....       @rshr_dh
 SQRSHRUN_sb     11000001 011 ..... 110111 ...10 .....       @rshr_sb
 SQRSHRUN_dh     11000001 1.1 ..... 110111 ...10 .....       @rshr_dh
+
+&zzz_e          zd zn zm esz
+
+ZIP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 0    \
+                &zzz_e zd=%zd_ax2
+ZIP_2           11000001 00    1 zm:5 110101 zn:5 .... 0    \
+                &zzz_e zd=%zd_ax2 esz=4
+
+UZP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 1    \
+                &zzz_e zd=%zd_ax2
+UZP_2           11000001 00    1 zm:5 110101 zn:5 .... 1    \
+                &zzz_e zd=%zd_ax2 esz=4
-- 
2.43.0


