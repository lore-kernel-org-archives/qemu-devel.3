Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FADC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zJ-0005F6-9h; Sat, 21 Jun 2025 19:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zF-0005DI-Vc
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zE-0004XI-2v
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747ef5996edso2314088b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549863; x=1751154663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6JZD8HW3F2NQB09EKn4GLBSSv0TcWSwQdr67/0/17eo=;
 b=Sy2xvfiVfHyzZwnstQGB4+mlzG803EOsxQaeu2dBw0xK5pdV+cSK9UTGNBWsCCY2+9
 AmB+7xRfMmuwyH6N1mvOKs8Iaohb+EhJ/Bkx9hkWSfkTcBK9fEAaC3nvvBLBpfbZUfUW
 HyswcngAFAeUzLAsDiH2/+c803NRt2RW0gYFkHhVrAYMk0z02jonA1EzYE3OWgiOePUO
 uhQbqCb3UESQJTBsoz/3RBGs8i9eAzjuUWkBQdXP/2hrANTSc9VfQ8xVXguJJ4CT6SRY
 +xkI5TFME8rvALV5OgTdUOj98LVelZ3DzYEiY8RY3Hll+bQSaHBvflkY7AQmo19YUMS0
 z3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549863; x=1751154663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JZD8HW3F2NQB09EKn4GLBSSv0TcWSwQdr67/0/17eo=;
 b=C16UqRxSx/BFwN0lixAqDa3+vK7HrE9Fv1+DdXEOSzCul2Z9OW2BkPd3QtoD26TTKJ
 optX6v0OD1ht/cscJl/95YeuoZyBtQVWesY/39V6zZJ5vQE3j2XwzJcObRFOb7sIShI5
 Ta4Ks1y7CsDjtR6C7utsGcnKgnprq+/qe7N8F+IXLyx0Q6DTM/qM9WOrfn3wLdvtZ6zh
 K1rCc6Q4QdjDTWgz0RAeJLN6fQFoUU0pjphRzcXU1J5QD0cvzvzMQF7UYIxxHmU1DZRR
 7sSsuBTMyabwcS9foJbTQ6FKN/R7QfaGY4HSZp5JpF7ZgfdJHobNb9BtqwAIMPx+TgCW
 iUkQ==
X-Gm-Message-State: AOJu0Yw1ARUlqLRl1JEtrMpOFE+OJjgYpI9dXsffdW7YghWkl9plvsGA
 8cmoy+7/KKU76C0gsQvMHtPsTexGH5OY80iqDslKC0G/U6xvdAmZtg6zjh99c2CBPqxfrAn0Ssp
 i0Bie
X-Gm-Gg: ASbGncsAKG4Bi9lcTybyozxMe10ieD1O7wR1A/u4gWg8nkV6T3AGANAQNAhqReh+QQU
 1RCKudgZgg2cW71rjhQeo6nCJj2qlTFktX9Ub3YGeuvuqn9SV/rf1Biam0rwqbIMYDJ7y+o6bGX
 NHDMzQoh9Tz2A6lGUHwPv48/RQqrOvig8zY7m80z8z4wWC/N6s4vTGVA6K7rp35W9hFlCDrvHGI
 EqjEvpJzpiL1QD3QsUVL3rKVXHTydV6K+FLW8QkMzg1W9wkwz25/6ei7oLdG6qbrLGc254nnb++
 4TMMQIo8UJSJeOoz6iGUMCBL1QzYUWkYoY0BZa8htbD8mtE9u4mj/BvBeBqhNnaBJgYkDfusrbw
 MeyDpCyuZ7QpvKQaI44Hb
X-Google-Smtp-Source: AGHT+IHTT/x+fgG8tFZ9vSCxmMRzt9B+ep0gqkslYRWsiSIDke3NgRBcyMVUtkt8pW/YQsvA8YGVow==
X-Received: by 2002:a05:6a00:17a6:b0:748:68dd:ecc8 with SMTP id
 d2e1a72fcca58-7490d9e7228mr9941584b3a.22.1750549862762; 
 Sat, 21 Jun 2025 16:51:02 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.51.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:51:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 037/101] target/arm: Implement SME2 FVDOT, BFVDOT
Date: Sat, 21 Jun 2025 16:49:33 -0700
Message-ID: <20250621235037.74091-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/helper.h        |  2 ++
 target/arm/tcg/sme_helper.c    | 30 ++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++
 target/arm/tcg/vec_helper.c    | 39 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  3 +++
 6 files changed, 92 insertions(+)

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
diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 80db7c2c37..2a013a6068 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1081,6 +1081,8 @@ DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_bfvdot_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index bd9b81d5aa..ca632b034e 100644
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
index f4467d13c6..5d6fd4cd03 100644
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


