Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99101C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg810-0000HL-R6; Thu, 06 Feb 2025 14:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80R-0007K5-Fj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80O-0000bc-Uz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:47 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f16af1f71so21149135ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871862; x=1739476662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onyfaS/qeSodPOrSH4ti4NiA3Ykvxfxv/LxeH0L1qJs=;
 b=QO1R43I58AeBbdbC/EFxrGAErCHxkkBx8jn56+dzz5nft9D9Ig7TF4NPAamnz2LNun
 24YO86HA94Oqe1OOGqFxlG42icfcCYlbNaI7ATQ1cs4Qacmb8QkWncPh0JX1OjtEvya3
 VBXOHGlRR/+GnZNMeQmMqycDqcEGwq5WL2yaxmPd0IZICxPcWpq+pj8FyRVHSJYq1a2Q
 3yclzRf/J1suGPmHuvVQD/dQu9wdUVY+lAD7q7DX7XlLpxryYmT87czVHDimne2S5+lG
 LGY/oAsgjWLqOxzqIQCgN8yMWVHfLZ/h83L/5n1u68K49T736wGpWyZHm4LY+T/1ca6h
 3wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871862; x=1739476662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onyfaS/qeSodPOrSH4ti4NiA3Ykvxfxv/LxeH0L1qJs=;
 b=KiE1sQJOZ58pMyW3/NjS2xYpOIBKZi2yVIJ1oeEGibwiJlaiD4xrwpp61q0i3RQpL9
 MDgE7DGOCiordLzcJvxiA3pQ+hiRrB5+aibIeT6bshp0/QTfaBnXDs29QReRzmlXxdjO
 WPCPGME+s5zftQ5IAl5924CM74ExRo8JBgFps+ejwg/mGu/jMS0RjIlaA4vxISmyfc/K
 UqHcDg6h37AxRXdj5PIq4Xk9yHq+nSFgpkCvCyxUji5FksE5zTdfsz+yuifbGesiOb9/
 /BY+WJXs9hR7zOEj9HdbZkdX9UHQvDheb1r4JxnbU7QrOZ0gizBIk69EHs+TePeqLEFI
 y5pw==
X-Gm-Message-State: AOJu0Yw53skrkNjkLL9Yt89AAGDzH1V77v+e0OYJxnPW/JLOBrYQU7vQ
 wIjcA/lOQ0ydHQdoW2z6f5X9sQ9eOvetSrKISXqDyof8wKcuO9hQHEXBUtxkpQmvsBLQSC7fscE
 c
X-Gm-Gg: ASbGncvU2fIc9J31xPfzk02N1gLSX6gJ3sB8o2Q7mdP2VSKHXu9wbumcI2zlW+/vS7M
 /7waAeydpJeC0U5cjZ9bGnDwIm01JH4+GpaluEz3MkwcV0ulpPucvAn/+qpszKHhI5xh+v0eXwn
 yEhyzSDeHlA2ErdPbS01R6+PzfUqqwJPGDfvR4HHsYYm1jLwb1j8uSh+59zy197udeqcInt1lho
 FJAuUTu5OYQaOb/KFmexvpxuD9YaKT/tRgqyTy8vsfceE5QumLymrKeXbSHghhzZBAVtUyA9AXq
 xeVZC9zqczpSNPTrnuafyMJSz3Xi9uoEC2NpNdoEyiAoCUQ=
X-Google-Smtp-Source: AGHT+IHOJTdhbmcS+wuNhD8kP6DBPKYnwucIhHBOXkNkUGqv9JihFzDNPChK6ToJDShGvOHskD9mRg==
X-Received: by 2002:a05:6a21:3389:b0:1e1:ac71:2b6a with SMTP id
 adf61e73a8af0-1ee03b0c38bmr1238761637.28.1738871862067; 
 Thu, 06 Feb 2025 11:57:42 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 34/61] target/arm: Implement SME2 FVDOT, BFVDOT
Date: Thu,  6 Feb 2025 11:56:48 -0800
Message-ID: <20250206195715.2150758-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  2 ++
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/sme_helper.c    | 30 ++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++
 target/arm/tcg/vec_helper.c    | 39 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  3 +++
 6 files changed, 92 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0907505839..e64ddd68b2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1079,6 +1079,8 @@ DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_bfvdot_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index ec93ff57ff..8f5a1b3c90 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -178,3 +178,5 @@ DEF_HELPER_FLAGS_6(sme2_fdot_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_fvdot_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 18b17e9fb2..6fb7e6b306 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1166,6 +1166,36 @@ void HELPER(sme2_fdot_idx_h)(void *vd, void *vn, void *vm, void *va,
     }
 }
 
+void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
+                              CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, j, oprsz = simd_maxsz(desc);
+    intptr_t elements = oprsz / sizeof(float32);
+    intptr_t eltspersegment = MIN(4, elements);
+    int idx = extract32(desc, SIMD_DATA_SHIFT, 2);
+    int sel = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status fpst_odd, *fpst_std, *fpst_f16;
+    float32 *d = vd, *a = va;
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *m = (uint32_t *)vm + H4(idx);
+
+    fpst_std = &env->vfp.fp_status[FPST_ZA];
+    fpst_f16 = &env->vfp.fp_status[FPST_ZA_F16];
+    fpst_odd = *fpst_std;
+    set_float_rounding_mode(float_round_to_odd, &fpst_odd);
+
+    for (i = 0; i < elements; i += eltspersegment) {
+        uint32_t mm = m[i];
+        for (j = 0; j < eltspersegment; ++j) {
+            uint32_t nn = n0[i + H2(2 * j + sel)]
+                        | (n1[i + H2(2 * j + sel)] << 16);
+            d[i + H4(j)] = f16_dotadd(a[i + H4(j)], nn, mm,
+                                      fpst_f16, fpst_std, &fpst_odd);
+        }
+    }
+}
+
 void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
                         void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index c03daa535d..f4a684f6a4 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -863,6 +863,14 @@ static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 
 TRANS_FEAT(FDOT_nx, aa64_sme2, do_fdot_nx, a)
 
+static bool trans_FVDOT(DisasContext *s, arg_azx_n *a)
+{
+    return dc_isar_feature(aa64_sme2, s) &&
+           do_azz_acc_fp(s, 1, 2, a->rv, a->off, a->zn, a->zm,
+                         a->idx, 2, false, FPST_ENV,
+                         gen_helper_sme2_fvdot_idx_h);
+}
+
 static bool do_bfdot(DisasContext *s, arg_azz_n *a, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 0, 0,
@@ -879,3 +887,11 @@ static bool do_bfdot_nx(DisasContext *s, arg_azx_n *a)
 }
 
 TRANS_FEAT(BFDOT_nx, aa64_sme2, do_bfdot_nx, a)
+
+static bool trans_BFVDOT(DisasContext *s, arg_azx_n *a)
+{
+    return dc_isar_feature(aa64_sme2, s) &&
+           do_azz_acc_fp(s, 1, 2, a->rv, a->off, a->zn, a->zm,
+                         a->idx, 2, false, FPST_ENV,
+                         gen_helper_sme2_bfvdot_idx);
+}
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 16ddd35239..cfd219ed13 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3079,6 +3079,45 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(sme2_bfvdot_idx)(void *vd, void *vn, void *vm,
+                             void *va, CPUARMState *env, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT, 2);
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    intptr_t elements = opr_sz / 4;
+    intptr_t eltspersegment = MIN(16 / 4, elements);
+    float32 *d = vd, *a = va;
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *m = vm;
+    float_status fpst, fpst_odd;
+
+    if (is_ebf(env, &fpst, &fpst_odd)) {
+        for (i = 0; i < elements; i += eltspersegment) {
+            uint32_t m_idx = m[i + H4(idx)];
+
+            for (j = 0; j < eltspersegment; j++) {
+                uint32_t nn = n0[i + H2(2 * j + sel)]
+                            | (n1[i + H2(2 * j + sel)] << 16);
+                d[i + H4(j)] = bfdotadd_ebf(a[i + H4(j)], nn, m_idx,
+                                            &fpst, &fpst_odd);
+            }
+        }
+    } else {
+        for (i = 0; i < elements; i += eltspersegment) {
+            uint32_t m_idx = m[i + H4(idx)];
+
+            for (j = 0; j < eltspersegment; j++) {
+                uint32_t nn = n0[i + H2(2 * j + sel)]
+                            | (n1[i + H2(2 * j + sel)] << 16);
+                d[i + H4(j)] = bfdotadd(a[i + H4(j)], nn, m_idx, &fpst);
+            }
+        }
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va,
                          CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 18e625605f..7c057bcad2 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -374,3 +374,6 @@ FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
 
 BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
 BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
+
+FVDOT           11000001 0101 .... 0 .. 0 .. ....0 01 ...   @azx_2x1_i2_o3
+BFVDOT          11000001 0101 .... 0 .. 0 .. ....0 11 ...   @azx_2x1_i2_o3
-- 
2.43.0


