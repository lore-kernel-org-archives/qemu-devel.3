Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3696DC44500
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOFx-0006hD-C0; Thu, 02 Jul 2026 16:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFs-0006da-IC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:29 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFk-0000Rs-2g
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:23 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9aaa90a791so1391111a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783024997; x=1783629797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FvpXgQVjcf4JSmoEhv8+Ao1XAq3+8hcAdEOLcwA+d5s=;
 b=TMw4uC4/pgPVm684miJcQtBsord4rghmgoqWGvrS77VvmcqSPVs9KxkALdDVm0M5Td
 s2TUU29Y6sABUS3Q38oX32YiNA/BUtoLDhtVaiTZ++d2a0IKB9aPG3dKy/6jN89C/ra1
 FpCL7iY57fitCS0Oq97ZY+jfnV04IKiZr1sLpfgENXogqZUggV6OsVJkFpZOJVsThGas
 89UqQ1spdRjENjxflMJTHRbnCUxEwGBx135+MDoszwTYShTS2rOgbgac+n06U5iokdvW
 5QWi+ofs/yrUH2x5lrxYSLEQPbi+pY4mO38CwQHj5nBIyiPDKhAJcNnQQKIGPb9mTWDF
 GRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783024997; x=1783629797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FvpXgQVjcf4JSmoEhv8+Ao1XAq3+8hcAdEOLcwA+d5s=;
 b=Hlo8+QqaS/ZV1q6/14YOFv5WeiOuBdM5RtC0bi+HUyRqPMwBq6TxfzqI+4EeNI+85r
 /K5VCzpGOqDER8JZQLppX18//8QUK40c9ZLNJLIyD52vfxT+LZtCyCjfJ70P3njk2w1R
 odg+f9ZS7lQZ8RPvJvHUnkpDX2Dz1/WS4g7Q35qqJxO5b0uNbZfeLbJSA/QxZxIY3cvA
 k8ZK6RGrmGjCmsP8XO55HKXENLZLPwFQV6Ktw4OxR1wDSZTQUH28vtECT8QoV0PgT4S8
 sbtBu79VDz7+Hp2c2a01wDam+HJhE2377+6PzaxljEsZypk9Zn/FPlYjGVLRvFAp1T2d
 8Mmg==
X-Gm-Message-State: AOJu0Yyv1huVQYPlXA47IIT+xGSN29S79uEVtOjJtfHdCPHVsHvweaK8
 trXCaN52QhMVvpC/+yZ6Szwq184pztDEcce9T+3mdJ/KhAqfLg2/ESVb8u9LLLWjMQkWO0HNLD3
 daY5R
X-Gm-Gg: AfdE7cn1s+YMEsrsWq0pOAXU4pWYPIS2IUPnmTyEUD5Eg0Ou7LOT/26xfs/AI0/d456
 zq4RmdT7u8xVdFSTvvCma3h2ymaxcaFZ44Mw4sNRUIZJOWVH76rnig0zeu7U7MaH79hgUtNl2WA
 qZ4To4vU3YvMrJW6lGcNwOdCYqQjnGAXMMZ1IEEkrOyqO8dB0J9qVZmdRi8MR3yapG6ZV8uq6f2
 AwSn5N6hXgPnkQ3PwwymXnQAtYMgm7ZhA0xOTpbf3ka+8QzpIkyOeBCPUzwjVJ9q0NP7Sv0920A
 EULyay4beKvMSequfCcjz4RzmOpmZFpUcpMd5rX16G1J8W44n2eO0Hwwanm0YE3QuQQNiWg6uHm
 lEucLrWQYRgeYFYusncUCk/mu4KW6wbUS0uYR47o2aCEXc1+xqqTAeab0XifqePdGWbTChYhyiC
 n/HnGLQa+duUSsREPETr511ck73sURxnj9PMJMeW+lL1C0P+iyFw==
X-Received: by 2002:a05:6a20:244c:b0:3bf:83f3:b810 with SMTP id
 adf61e73a8af0-3bfed47776cmr8599995637.29.1783024996882; 
 Thu, 02 Jul 2026 13:43:16 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 01/15] target/arm: Implement FMOP4 (non-widening) for
 float32
Date: Thu,  2 Jul 2026 13:43:00 -0700
Message-ID: <20260702204314.79224-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/cpu-features.h        |  5 +++
 target/arm/tcg/helper-sme-defs.h |  4 ++
 target/arm/tcg/translate.h       |  5 +++
 target/arm/tcg/vec_internal.h    |  8 ++++
 target/arm/tcg/sme_helper.c      | 76 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 29 ++++++++++++
 target/arm/tcg/sme.decode        | 12 +++++
 7 files changed, 139 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 98102d75bf..5a45358318 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_sme_mop4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMOP4);
+}
+
 static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 01aad4c231..9e1f09ce5b 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -355,3 +355,7 @@ DEF_HELPER_FLAGS_5(sme2_sel_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 462d4c1c74..4a2cc95034 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -268,6 +268,11 @@ static inline int times_2_plus_1(DisasContext *s, int x)
     return x * 2 + 1;
 }
 
+static inline int times_2_plus_16(DisasContext *s, int x)
+{
+    return x * 2 + 16;
+}
+
 static inline int rsub_64(DisasContext *s, int x)
 {
     return 64 - x;
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 77e5b01550..038a2a3439 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -547,4 +547,12 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
+/*
+ * Perform SME quarter-tile outer product.
+ * Iterate over ZAtile[] for esize, calling fn for each element.
+ */
+void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,
+              uint32_t desc, size_t esize,
+              void (*fn)(void *, void *, void *, void *));
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 685b6b46be..b08d91e6de 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2601,3 +2601,79 @@ void HELPER(sme2_sel_d)(void *vd, void *vn, void *vm,
         }
     }
 }
+
+void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,
+              uint32_t desc, size_t esize,
+              void (*fn)(void *, void *, void *, void *))
+{
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t dim = oprsz / 2;  /* in bytes */
+    bool nreg_m1 = extract32(desc, SIMD_DATA_SHIFT + 0, 1);
+    bool mreg_m1 = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
+    intptr_t host_adj = HOST_BIG_ENDIAN ? 8 - esize : 0;
+
+    for (int outprod = 0; outprod < 4; outprod++) {
+        bool row_hv = outprod & 2;
+        bool col_hv = outprod & 1;
+        intptr_t row_base = row_hv ? dim : 0;
+        intptr_t col_base = col_hv ? dim : 0;
+        void *op1 = vzn + (col_hv && nreg_m1 ? sizeof(ARMVectorReg) : 0);
+        void *op2 = vzm + (row_hv && mreg_m1 ? sizeof(ARMVectorReg) : 0);
+
+        for (intptr_t row = 0; row < dim; row += esize) {
+            intptr_t row_idx = row_base + row;
+            void *vza_row = vza + tile_vslice_offset(row_idx);
+            void *e1 = op1 + (row_idx ^ host_adj);
+
+            for (intptr_t col = 0; col < dim; col += esize) {
+                intptr_t col_idx = col_base + col;
+                void *e2 = op2 + (col_idx ^ host_adj);
+                void *e3 = vza_row + (col_idx ^ host_adj);
+
+                fn(e3, e1, e2, fn_opaque);
+            }
+        }
+    }
+}
+
+static void inner_fmop4a_ss(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float32_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4a_ss)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float32), inner_fmop4a_ss);
+}
+
+static void inner_fmop4s_ss(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float32_muladd(float32_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4s_ss)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float32), inner_fmop4s_ss);
+}
+
+static void inner_ah_fmop4s_ss(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float32_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_fmop4s_ss)(void *vza, void *vzn, void *vzm,
+                              float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float32), inner_ah_fmop4s_ss);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ff5554eefb..aab5eab9df 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2002,3 +2002,32 @@ TRANS_FEAT(LUTI4_s_4h, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti4_4h)
 
 TRANS_FEAT(LUTI4_s_4b, aa64_sme2p1_lutv2, do_lut_s4, a,
            gen_helper_sme2_luti4_4b)
+
+static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
+                       ARMFPStatusFlavour e_fpst,
+                       gen_helper_gvec_3_ptr * const fns[3])
+{
+    int svl = streaming_vec_reg_size(s);
+    uint32_t desc = simd_desc(svl, svl, (a->m << 1) | a->n);
+    int fns_idx = (a->s ? 1 + s->fpcr_ah : 0);
+    TCGv_ptr za, zn, zm, fpst;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    za = get_tile(s, esz, a->zad);
+    zn = vec_full_reg_ptr(s, a->zn);
+    zm = vec_full_reg_ptr(s, a->zm);
+    fpst = fpstatus_ptr(e_fpst);
+
+    fns[fns_idx](za, zn, zm, fpst, tcg_constant_i32(desc));
+    return true;
+}
+
+static gen_helper_gvec_3_ptr * const fmop4_ss[3] = {
+    gen_helper_sme_fmop4a_ss,
+    gen_helper_sme_fmop4s_ss,
+    gen_helper_sme_ah_fmop4s_ss
+};
+TRANS_FEAT(FMOP4_ss, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ZA, fmop4_ss)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 3a65e1ad4b..5a3d47cdfe 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1086,3 +1086,15 @@ LUTI4_s_4h      1100 0000 1001 101 idx:1 10 01 00 zn:5 zd:5     &lut
 
 LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
                 &lut zn=%zn_ax2 idx=0
+
+# SME MOP4 Quarter-tile outer products
+
+&mop4           zad zn zm s:bool n:bool m:bool
+
+%mop4_zm        17:3 !function=times_2_plus_16
+%mop4_zn        6:3  !function=times_2
+
+@mop4_o2        .... .... ... m:1 .... .... .. n:1 ... . s:1 .. zad:2 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn
+
+FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
-- 
2.43.0


