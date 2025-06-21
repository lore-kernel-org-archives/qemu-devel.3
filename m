Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02758C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT867-0000TL-Pi; Sat, 21 Jun 2025 19:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85b-0005Ja-Og
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:40 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85Z-0006bn-Cn
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:39 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so1748131b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550256; x=1751155056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bwiZT10Y30kTfWaUZPaS4Gb1aqiNUahK4/incXSRvWk=;
 b=cWbxHO82rlrvo5xXzEPXOEQOFSvmvC4bYDiYHa12AMku6Rmaxx0bGmU2l5XNHqc4o6
 91nPjkA1MwNLIOKFrmR3AYj4ipS/kGaxMZzig9G1DJAtvEOHtWiuIpTVoOOF/T4kkZsz
 ++5ai99XyIsurvga+wTzgzLgkgzV/juXloaIR/ovoJ0NJoYrOB67UkbgTgd6TB3pNVza
 nuGxNDbIz+6CVjXLxL4VE6a9rzVwQEjSINruUo0gQFow3HrRiQaVnV702f53ZIAHP1hH
 fOkYWq30hukG4ZvPh5WB9deFGAL0hIATP2xB9MPu2hYiSUQcsrVXwJNkRM4x72wDV8+u
 FO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550256; x=1751155056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwiZT10Y30kTfWaUZPaS4Gb1aqiNUahK4/incXSRvWk=;
 b=jWjZ3y5zFqoocM+8vhVUTewk9Lx8lKnTSsFgh2VXWJycoYHUKghvwEI5GzV/HT0dIC
 6r3HxuLgupIt9uSeBmutoU5j8VLeibLAT1/P7YNNPrHrGpTyhlUmGsxsjfiG1B4PqswG
 n1x6srgXIWTRFiIL020dGOCCF8hRIWZDGbyRsaMVFcsWqzAFA5PaHR6UFJonccfXYqmC
 YUR3T5H03vnBidhN1ucwI/XT8XXcr2/9Vwgi0box4BWfOzzNUnsKrZ9oez/7lq9EgZV/
 NFnIzxfUoG1VPQFwQumLQEDgfgqsSNu/W3qvG/gBSUGfmrVSpStHcqyTOviMXMr+P+lV
 RQ5A==
X-Gm-Message-State: AOJu0YwT/Q2L/GrmjYkipngswl4HvQIag8g2M2agoLb3pJohULbAOxM3
 rtP3BeLk+LxPmvoQc/1xGRbe8YITV72RE0bu0PjiPi882dstHYbnYWpRRjwqmwJzxwTXi9E/+Gp
 0efQqWvA=
X-Gm-Gg: ASbGncs+38eV4B7amM1h4RHbK1HdOHBTFWP4nfIMxqhSfIBpy66Z8K8qXF20f3cewX+
 DCKjxucT353EKGd3+FAncn5n8gjCz6pY7kkVm5f0SMt9LLHBDuFolfomnsulAz4Q3v1hvpDvPTU
 bT3eCKU/8VAhbRDInC+fB+boW5dP2ylbHP6CT/NFTxWCTlLs/saxt5NZEgI16YK7gyPXSsJgjyU
 xPbxNQkiRXutbtN2Kc2zfnfObQxMJgMg5dFhuKucxvZonGtPvnZwjfqVpJPBjIPmhyhVOLmBse4
 TuhOm803IwHNWksKVMg8mSWH5GwdWGU0smXR8iYkCxqEF+xah3Hdx4P/LD0bOtFI965qmCkCrvt
 BhLQODr9NVVT3Uh66M0n8
X-Google-Smtp-Source: AGHT+IHh05ft2CMcP63SizPJGlaUqZovFA0V1YgHYLpFqHVKSSl2TX6G4RUIphQ661X/YBaM67S3Yw==
X-Received: by 2002:a05:6300:4ce:10b0:220:2741:cb1f with SMTP id
 adf61e73a8af0-2202741cd68mr7739952637.41.1750550255925; 
 Sat, 21 Jun 2025 16:57:35 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 089/101] target/arm: Implement ZIPQ, UZPQ for SME2p1/SVE2p1
Date: Sat, 21 Jun 2025 16:50:25 -0700
Message-ID: <20250621235037.74091-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/arm/tcg/helper-sve.h    | 10 ++++++++++
 target/arm/tcg/sve_helper.c    | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 19 ++++++++++++++++++-
 target/arm/tcg/sve.decode      |  6 ++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 04b9545c11..0f510ea610 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -701,12 +701,22 @@ DEF_HELPER_FLAGS_4(sve_zip_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_zip_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_zip_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2p1_zipq_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_zipq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_zipq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_zipq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_uzp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_uzp_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_trn_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 10fd1f456b..ed5147031f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3817,6 +3817,35 @@ DO_UZP(sve_uzp_s, uint32_t, H1_4)
 DO_UZP(sve_uzp_d, uint64_t, H1_8)
 DO_UZP(sve2_uzp_q, Int128, )
 
+typedef void perseg_zzz_fn(void *vd, void *vn, void *vm, uint32_t desc);
+
+static void do_perseg_zzz(void *vd, void *vn, void *vm,
+                          uint32_t desc, perseg_zzz_fn *fn)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+
+    desc = simd_desc(16, 16, simd_data(desc));
+    for (intptr_t i = 0; i < oprsz; i += 16) {
+        fn(vd + i, vn + i, vm + i, desc);
+    }
+}
+
+#define DO_PERSEG_ZZZ(NAME, FUNC) \
+    void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+    { do_perseg_zzz(vd, vn, vm, desc, FUNC); }
+
+DO_PERSEG_ZZZ(sve2p1_uzpq_b, helper_sve_uzp_b)
+DO_PERSEG_ZZZ(sve2p1_uzpq_h, helper_sve_uzp_h)
+DO_PERSEG_ZZZ(sve2p1_uzpq_s, helper_sve_uzp_s)
+DO_PERSEG_ZZZ(sve2p1_uzpq_d, helper_sve_uzp_d)
+
+DO_PERSEG_ZZZ(sve2p1_zipq_b, helper_sve_zip_b)
+DO_PERSEG_ZZZ(sve2p1_zipq_h, helper_sve_zip_h)
+DO_PERSEG_ZZZ(sve2p1_zipq_s, helper_sve_zip_s)
+DO_PERSEG_ZZZ(sve2p1_zipq_d, helper_sve_zip_d)
+
+#undef DO_PERSEG_ZZZ
+
 #define DO_TRN(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)         \
 {                                                                      \
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8ca14c2494..bbb424b738 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2584,11 +2584,19 @@ TRANS_FEAT(ZIP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
            gen_helper_sve2_zip_q, a,
            QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
 
+static gen_helper_gvec_3 * const zipq_fns[4] = {
+    gen_helper_sve2p1_zipq_b, gen_helper_sve2p1_zipq_h,
+    gen_helper_sve2p1_zipq_s, gen_helper_sve2p1_zipq_d,
+};
+TRANS_FEAT(ZIPQ1, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           zipq_fns[a->esz], a, 0)
+TRANS_FEAT(ZIPQ2, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           zipq_fns[a->esz], a, 16 / 2)
+
 static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
     gen_helper_sve_uzp_s, gen_helper_sve_uzp_d,
 };
-
 TRANS_FEAT(UZP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 0)
 TRANS_FEAT(UZP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
@@ -2599,6 +2607,15 @@ TRANS_FEAT(UZP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(UZP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
            gen_helper_sve2_uzp_q, a, 16)
 
+static gen_helper_gvec_3 * const uzpq_fns[4] = {
+    gen_helper_sve2p1_uzpq_b, gen_helper_sve2p1_uzpq_h,
+    gen_helper_sve2p1_uzpq_s, gen_helper_sve2p1_uzpq_d,
+};
+TRANS_FEAT(UZPQ1, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           uzpq_fns[a->esz], a, 0)
+TRANS_FEAT(UZPQ2, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           uzpq_fns[a->esz], a, 1 << a->esz)
+
 static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_b, gen_helper_sve_trn_h,
     gen_helper_sve_trn_s, gen_helper_sve_trn_d,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 1048387f96..623c6f2520 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -657,6 +657,12 @@ UZP2_q          00000101 10 1 ..... 000 011 ..... .....         @rd_rn_rm_e0
 TRN1_q          00000101 10 1 ..... 000 110 ..... .....         @rd_rn_rm_e0
 TRN2_q          00000101 10 1 ..... 000 111 ..... .....         @rd_rn_rm_e0
 
+# SVE2.1 permute vector elements (quadwords)
+ZIPQ1           01000100 .. 0 ..... 111 000 ..... .....         @rd_rn_rm
+ZIPQ2           01000100 .. 0 ..... 111 001 ..... .....         @rd_rn_rm
+UZPQ1           01000100 .. 0 ..... 111 010 ..... .....         @rd_rn_rm
+UZPQ2           01000100 .. 0 ..... 111 011 ..... .....         @rd_rn_rm
+
 ### SVE Permute - Predicated Group
 
 # SVE compress active elements
-- 
2.43.0


