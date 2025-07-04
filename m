Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30586C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhOU-0001Rs-1C; Fri, 04 Jul 2025 10:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM3-0004UZ-Li
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:33 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLx-00084g-0e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:31 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73ac5680bb0so276357a34.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639123; x=1752243923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGPz8c4Quh73bz1xi4TXiyf83H6O8RYqsWdecbapKxU=;
 b=KZkDa3sd3klfKR9HEj2LCGDA7saLndVBWzY9Wp7xhmNPESKEbj1QSsFMNpILL1LyAn
 +iy4fZ0jVM8U7F+itz7B6gOdDGZ0/5f/mtrkJUn8g7kZYKZWS1J8kFW2vzcVfcdYOc4i
 9LHY/2gMOmasiSMIKS0mxFx0wZlpzeMBZDPS8iUwj4DyOfosbjo45HWJDP7mAnVm7rmZ
 mfZ/IS7MaFcdOVqysRS+CMUmnYYgzrD9IcPxQhqq/lzO8CC7AqH2K+h2n6fZpUzFVKNd
 PLVHzT0UDCaTqI4mhpOKTxz6v8rKxWupInVBJt/ANHUW33OBV0H572Bulr0NZlzkqG41
 6SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639123; x=1752243923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGPz8c4Quh73bz1xi4TXiyf83H6O8RYqsWdecbapKxU=;
 b=CKyQFMtF2r1DuRdLU0w8KBNSgSs15tpiD8oeeBskFAYc90LKH1kOXMbxlO7qu5phSP
 IN4urrbnkCrh6DHQJBx48LBZtHVAxl30uhH+3OsHxL2e9AXNg5csmW0SzKQ+gZJ9zYHT
 z+r2MfVC19gvGUV+4baqncM6enf8tC8MN78SoWS3tXI5D1s6s0Lm3JNLEPolcY7PiHqc
 d2feFFUCI7GZb974sRmfkM/mjKZU7jzNg7DXr0DaInrEAjrNMI7GIaNhoX28hj5g8q5t
 bkntW4UlNFI8V85uy1XJ/yvtAJSm5FrKrhIBoNQd+fxMjAiZ80kRMJh8YqobWAAVvwrx
 NmoQ==
X-Gm-Message-State: AOJu0YyXvjBHOpCStVajxJoBxRcvcA2KfQdPD47iax/oB/33AaYUAgQm
 6huc8BGDx87ei1ACqXSxXxiNAYcAfywvMrcua4w4pALoaAjJr8oTNGfayq1SmT9ldtLJno5LkV3
 IDHXqFZw=
X-Gm-Gg: ASbGncutS4O0+TYu9BweyH7rnlkx0XFWSx1ude4TPWlMYnJDwCwpDzM8wtVceVxBrRK
 hld8dIv+zRlOd30wjAlG0UWXy0d978ejRHUnF7WkAd9TMNO47FDPQ5ik3iTNVokseiGTdFCZt93
 5VYrSaZX2S1gckJGZ+aw+rCr/LPAZY6mZgbw8vPtSGkBpjXOSjIpU8s0552uvi/C4c6/Gl8M+fm
 bo9/iA1M0BeGxgz/ZknxoRnxSXTJnBq/cVYNAu5gF3ofARKtFt9zvNIZMTTFHPqR/ZzvPNAWP19
 7PEgIySf8mNE+/n01+hYcrRSWDBI+yj5XzCpY03ItKXTXhNEou/UjsJoJluAbqfW4nEqkEDZbE2
 i026sxLWJqAtPnW5p1+ZmJ94FiNRTgOLNPjrpICHJ86qJbz/u
X-Google-Smtp-Source: AGHT+IEICFcKQYBvVozmDUsGszCPwLOeKyGFTuxjArUmJahbCcFtsWC+e6bB9q/lmdb2ttYQx/sNyw==
X-Received: by 2002:a05:6808:23cb:b0:40b:441e:3603 with SMTP id
 5614622812f47-40d04aed0cfmr1778657b6e.14.1751639123534; 
 Fri, 04 Jul 2025 07:25:23 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 065/108] target/arm: Implement SME2 ZIP, UZP (two registers)
Date: Fri,  4 Jul 2025 08:20:28 -0600
Message-ID: <20250704142112.1018902-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 12 +++++++
 target/arm/tcg/sme_helper.c    | 62 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 40 ++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 12 +++++++
 4 files changed, 126 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 97428bcd6b..06b95da3c3 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -255,6 +255,18 @@ DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
index 2e95fe38cd..cf0e655bdd 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1933,6 +1933,37 @@ void HELPER(sme2_ucvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define ZIP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch[2];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *n = vn, *m = vm;                                      \
+    if (vectors_overlap(vd, 2, vn, 1)) {                        \
+        n = memcpy(&scratch[0], vn, oprsz);                     \
+    }                                                           \
+    if (vectors_overlap(vd, 2, vm, 1)) {                        \
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
@@ -1967,6 +1998,37 @@ ZIP4(sme2_zip4_q, Int128, )
 
 #undef ZIP4
 
+#define UZP2(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch[2];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t pairs = oprsz / (sizeof(TYPE) * 2);                  \
+    TYPE *d0 = vd, *d1 = vd + sizeof(ARMVectorReg);             \
+    if (vectors_overlap(vd, 2, vn, 1)) {                        \
+        vn = memcpy(&scratch[0], vn, oprsz);                    \
+    }                                                           \
+    if (vectors_overlap(vd, 2, vm, 1)) {                        \
+        vm = memcpy(&scratch[1], vm, oprsz);                    \
+    }                                                           \
+    for (size_t r = 0; r < 2; ++r) {                            \
+        TYPE *s = r ? vm : vn;                                  \
+        size_t base = r * pairs;                                \
+        for (size_t p = 0; p < pairs; ++p) {                    \
+            d0[base + H(p)] = s[H(2 * p + 0)];                  \
+            d1[base + H(p)] = s[H(2 * p + 1)];                  \
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
index d413efd20e..d52ccf2ac5 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1507,3 +1507,43 @@ TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
 TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
 TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
 TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
+
+static bool do_zipuzp_2(DisasContext *s, arg_zzz_e *a,
+                        gen_helper_gvec_3 * const fn[5])
+{
+    int bytes_per_op = 2 << a->esz;
+
+    /* MO_128 can fail the size test. */
+    if (s->max_svl < bytes_per_op) {
+        unallocated_encoding(s);
+    } else if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        if (svl < bytes_per_op) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->zd),
+                               vec_full_reg_offset(s, a->zn),
+                               vec_full_reg_offset(s, a->zm),
+                               svl, svl, 0, fn[a->esz]);
+        }
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 05d513efba..c1f73d9f63 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -848,3 +848,15 @@ UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
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


