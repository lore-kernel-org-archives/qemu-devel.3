Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38960C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLx-0003z4-U9; Fri, 04 Jul 2025 10:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIc-00067A-6m
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:59 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIa-0006Di-63
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:57 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso926173fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638915; x=1752243715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoZQEHUiuPqxJOVR0eH/FrbbJ9IkIyue0ROJ8VBIYCo=;
 b=kYXOmJmnqKLspB81plGyEiQ0M2gN8O+tgayTft8Uv+gTYvGrVVoI0TSfRv9DkzbHTw
 V3B3vvSr4+uM2LmtxWadbDudDEjFuz0qpRaEqV3EWaaXa5hPgTICwnQJr/497DSTYkXm
 PeCPa7vVZ2ILQe55PqGkMIc7aeiIztBLhByJaDOaCvR6VxeYtXSbWdwmfUgycifmRlrI
 X0cxojHPtL1pgcNPzg1+E9cKgToXXffbm7b/ktEixcOn5xhHLM1Q9scO6Z5C8K4dCi2o
 YCByvmEVXWW+W+XN3J69/SJgTaz62Xv/6oM23iLJYpEBLilmUC1Lb1Rio1Z41AWVpYO/
 iQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638915; x=1752243715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoZQEHUiuPqxJOVR0eH/FrbbJ9IkIyue0ROJ8VBIYCo=;
 b=pR17WzcpxUVjxTzY4SbX8aB7HdPDytPwH56vvml/ZAvZXCxld7KehRHFtCnRFnNMuJ
 ZekiNKn4bDXWgcHapxB/VAsVb5up7RqY7N/jbGvIbBzwijPLt/aIzWNewBrk48fU0gyT
 1TbHFYrnBKOVHVOOxzir2J5JglJWK2ChKwF58+0DCLZ81lcioj7CO7Zno2mIezs1PTnY
 eYMPykwjAGQrUsbKXtpx3aReVbJFXbGlFhHN1wajmik8ERTfZw31NoY4/84naQ1iUO7V
 g96B0PxEYb4DWj+6wtLneyjln65T1ozW0DBzUZ3Vxl1lYe28tNsgUYEZ/B//65lYUDx3
 tOBA==
X-Gm-Message-State: AOJu0YynPdFYQGDpSpIC4ElrqSX4aQ6eT24A+nkbkEeG/oVrjNkSFMU1
 kJRP+nFiYAoDPOpMleZszS08CYyZ1N0rNskThdhO4U0wKel6zCWzCLWx6D+7K5K8cthWYWyUWDx
 yWgQe+eQ=
X-Gm-Gg: ASbGncueY5980Y0LoGZXkc1RgMVSA2PFImhaTMPQBbfn4pvULrhvOY16Du95JYTgZuY
 faImcXaGB+c4JOe7bBoPF2PyaMUIu9mvWC+sgjmJEi2Q4OiVlb4PG5cDzgJJQiqPDnr/abqY8EP
 MAWIChNqP7hoK9c8fHJ6IwD7y1OCuZBAVsioB9vJAhEIGj4mqBJca6SPJ/vsM+RxOJbO0azQZCc
 MNyu8d967xB4J8np+OjjlNjKY3RqQbHpYngYhqKfZGayIT2EEVVZcR6bzDAT6cnI9y0cT7Wtrhk
 cCt2LgnB7/3EIBJI1nyn25P8b2iInocEqWsu8NF8wjTvYuolh6bNReuapW+5wKagi1Uq2sahUGn
 D2+YK1y0KnWR1yUDbCxvd9csa3BGYGPQg1KlNtyNUsIRT4qAz
X-Google-Smtp-Source: AGHT+IHcb60VIGxLre4Ol1i+LCmzUxRu/3rTccQolq0XemRBj5Z+BJ8TyBFSwf+nzduop0gpMWokrA==
X-Received: by 2002:a05:6871:741f:b0:2e4:4617:f6e1 with SMTP id
 586e51a60fabf-2f796b79ab4mr1898775fac.2.1751638914768; 
 Fri, 04 Jul 2025 07:21:54 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 039/108] target/arm: Implement SME2 FVDOT, BFVDOT
Date: Fri,  4 Jul 2025 08:20:02 -0600
Message-ID: <20250704142112.1018902-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/helper.h        |  2 ++
 target/arm/tcg/sme_helper.c    | 30 ++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 24 +++++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 39 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  3 +++
 6 files changed, 100 insertions(+)

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
index a05b63380c..d8d389af2b 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -1089,6 +1089,8 @@ DEF_HELPER_FLAGS_6(gvec_bfdot, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(gvec_bfdot_idx, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(sme2_bfvdot_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_6(gvec_bfmmla, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 60322be3d0..8b45865461 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1196,6 +1196,36 @@ void HELPER(sme2_fdot_idx_h)(void *vd, void *vn, void *vm, void *va,
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
+            uint32_t nn = (n0[H2(2 * (i + j) + sel)])
+                        | (n1[H2(2 * (i + j) + sel)] << 16);
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
index 965a49465e..410a8d037c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -938,3 +938,27 @@ static bool do_bfdot_nx(DisasContext *s, arg_azx_n *a)
 }
 
 TRANS_FEAT(BFDOT_nx, aa64_sme2, do_bfdot_nx, a)
+
+static bool do_vdot(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4_ptr *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / 2;
+        TCGv_ptr t_za = get_zarray(s, a->rv, a->off, 2, 1);
+        TCGv_ptr t_zn = vec_full_reg_ptr(s, a->zn);
+        TCGv_ptr t_zm = vec_full_reg_ptr(s, a->zm);
+        TCGv_ptr t = tcg_temp_new_ptr();
+
+        for (int i = 0; i < 2; ++i) {
+            int o_za = i * vstride * sizeof(ARMVectorReg);
+            int desc = simd_desc(svl, svl, a->idx | (i << 2));
+
+            tcg_gen_addi_ptr(t, t_za, o_za);
+            fn(t, t_zn, t_zm, t, tcg_env, tcg_constant_i32(desc));
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(FVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
+TRANS_FEAT(BFVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_bfvdot_idx)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5dcd6f9282..616f4050e4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3110,6 +3110,45 @@ void HELPER(gvec_bfdot_idx)(void *vd, void *vn, void *vm,
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
+                uint32_t nn = (n0[H2(2 * (i + j) + sel)])
+                            | (n1[H2(2 * (i + j) + sel)] << 16);
+                d[i + H4(j)] = bfdotadd_ebf(a[i + H4(j)], nn, m_idx,
+                                            &fpst, &fpst_odd);
+            }
+        }
+    } else {
+        for (i = 0; i < elements; i += eltspersegment) {
+            uint32_t m_idx = m[i + H4(idx)];
+
+            for (j = 0; j < eltspersegment; j++) {
+                uint32_t nn = (n0[H2(2 * (i + j) + sel)])
+                            | (n1[H2(2 * (i + j) + sel)] << 16);
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


