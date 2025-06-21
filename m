Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F0AC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82Y-0002rN-Vv; Sat, 21 Jun 2025 19:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82K-00025W-BF
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00050c-Dn
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:16 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2372683b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550052; x=1751154852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g5/GSaU4hDVvgcYYKrYfTIyfV8YDtynBAEDk0h2ij34=;
 b=awZcCX8cIGIzdnY27B4xJjBaVBmQW8SSjMWoV63xF2+rTlfuMcxC7/8194VOucWEKA
 rm+o1ArbNC2wYaJIuO2sClD635XKRVNSS6nYuJRJXR96je5mpq+X4NUMx5c6ILyzN0ta
 dZk1YaNIfQ7//0AE5NJ+nlQABCBMtLvPhcvAA+MbOknzfSuiq8YJerJGlgCGSQFRHec9
 fRiu/zWf9mBvp58n8h8vAcR4kUzcWBmfSI5gAn1TIj7f+980wXhtQZ8vi4kVg0ofEF0B
 lvw1tnLmpghsZ8Tb6zpRYNwCHe8ZwGYtTNiB1Zn4sNnPVaEpdsfUwrCW/z89AJLBqgPo
 wmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550052; x=1751154852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5/GSaU4hDVvgcYYKrYfTIyfV8YDtynBAEDk0h2ij34=;
 b=SOWp3iuUn81KyNnX1XSsGtxIWVhnd6HCAqOK7Ck7ju/MbmTNBNhHFrDQ6kUhxUQkkm
 /83QVrUVKsP4u+uI2wWK/q1v2Diuv82HmBQ36npAjAD/RTypPGbl3gw1umRRAmdUSFIr
 6QyAEW7+qTzX+VV16yM9NEtbMDlF++FSKvbYqDRR7Yybm4bqCRCaqNU9w+p9tuDEI+HV
 tFbLnsdXxjWNoA0svqooI8wYt2G/DKq6zgeneS7QCSxlHlv7eNQkWkpB9Jg9wtrb5GU1
 EFMwGWnda6GojliTrGDtlWyP3gr6f0d6PJi0pIBqPv3XAn3ARExdQz2SsX0LPV+gJMMW
 dIEA==
X-Gm-Message-State: AOJu0YxeALlOiG00VMVbVlKQtcRYLq0FhZXWPusCYL3eHfmhAzNOntaj
 UdrMBF0+0DAiosnWbrxdz5TMYKA5vwzeL4thnQC35HfE+7QvIAP1TdbhYBngLOkCeThzO9/z/jz
 rx8qZhXg=
X-Gm-Gg: ASbGncs2FV/WrROiD+mGigwluMfwn/ofwW1lDxXH0Mj583/aP6b+gGtE/T4kexAF+fw
 geGGEgBymjTd6w38M1uqAjkFI/iITe23NdBEQ+a6EmuJzo5zR1twM6JCvln1yicaJZ77cVJfdvc
 bFZAfHZBy8H7QzLhvYLRg+FQHXpXs00lnc2K8ZfiUuOO2xQuyJZgu8dqsb/yFV2JPf4+n34/fNN
 rQQV5KZxtLngSNmrc6O7qu/6MHlTpNWayQgoK4tksB9o8uEFK4g+JQN8yvPQSNJTX0RF15UcDqz
 R19JYbyR8j3VJnzPtE6X3SbMnkhvO9QX7O7yjV6pcdKBCwpLrbXuZ7yzz7ML7W565iCQ3m6h/zJ
 uGxdsc+fLy49RNgxyvN/E
X-Google-Smtp-Source: AGHT+IE7KlQvp+z05EXnCzSWlJ/Q8hyJzd5BxDzyoVgv97vNFWm2ATbBfmnlXFZ5H2SQifQlW2EjZA==
X-Received: by 2002:a05:6a20:6a23:b0:1f5:7007:9eb8 with SMTP id
 adf61e73a8af0-22026e94585mr11714979637.16.1750550051783; 
 Sat, 21 Jun 2025 16:54:11 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 051/101] target/arm: Implement SME2 BFCVT, BFCVTN, FCVT,
 FCVTN
Date: Sat, 21 Jun 2025 16:49:47 -0700
Message-ID: <20250621235037.74091-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/arm/tcg/helper-sme.h    |  5 +++
 target/arm/tcg/sme_helper.c    | 74 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 25 ++++++++++++
 target/arm/tcg/sme.decode      | 12 ++++++
 4 files changed, 116 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 673aa347bc..cb81f89fb3 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -213,3 +213,8 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5be1a38077..cd66f321d2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1488,3 +1488,77 @@ DO_MLALL_IDX(sme2_usmlall_idx_s, uint32_t, uint8_t, int8_t, H4, H1, +)
 DO_MLALL_IDX(sme2_usmlall_idx_d, uint64_t, uint16_t, int16_t, H8, H2, +)
 
 #undef DO_MLALL_IDX
+
+/* Convert and compress */
+void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = float32_to_bfloat16(s0[H4(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = float32_to_bfloat16(s1[H4(i)], fpst);
+    }
+}
+
+void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    float16 *d = vd;
+
+    if (vd == s1) {
+        s1 = memcpy(&scratch, s1, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d[H2(i)] = float32_to_float16(s0[H4(i)], true, fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d[H2(i) + n] = float32_to_float16(s1[H4(i)], true, fpst);
+    }
+}
+
+/* Convert and interleave */
+void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = float32_to_bfloat16(s0[H4(i)], fpst);
+        bfloat16 d1 = float32_to_bfloat16(s1[H4(i)], fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
+
+void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float32 *s0 = vs;
+    float32 *s1 = vs + sizeof(ARMVectorReg);
+    bfloat16 *d = vd;
+
+    for (i = 0; i < n; ++i) {
+        bfloat16 d0 = float32_to_float16(s0[H4(i)], true, fpst);
+        bfloat16 d1 = float32_to_float16(s1[H4(i)], true, fpst);
+        d[H2(i * 2 + 0)] = d0;
+        d[H2(i * 2 + 1)] = d1;
+    }
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index f89850cfa8..39a9831d3b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1263,3 +1263,28 @@ TRANS_FEAT(UMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_umlall
 TRANS_FEAT(UMLSLL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_smlsll_idx_d)
 TRANS_FEAT(USMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_usmlall_idx_d)
 TRANS_FEAT(SUMLALL_nx_d, aa64_sme_i16i64, do_smlall_nx, a, gen_helper_sme2_sumlall_idx_d)
+
+static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
+                       ARMFPStatusFlavour type, gen_helper_gvec_2_ptr *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        TCGv_ptr fpst = fpstatus_ptr(type);
+
+        for (int i = 0, n = a->n; i < n; ++i) {
+            tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               fpst, svl, svl, data, fn);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvtn)
+TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvt_n)
+TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_fcvtn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 91df2068cf..8cca7d0d46 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -719,3 +719,15 @@ BFMLS_nx        11000001 0001 .... 1 .. 1.. ...01 1 ....    @azx_4x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
+
+### SME2 Multi-vector SVE Constructive Unary
+
+&zz_n           zd zn n
+@zz_1x2         ........ ... ..... ...... ..... zd:5        \
+                &zz_n n=1 zn=%zn_ax2
+
+BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
+
+FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
+FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
-- 
2.43.0


