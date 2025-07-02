Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFABC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwq5-00067N-2D; Wed, 02 Jul 2025 08:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwmo-0008Rh-8g
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:05 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwmm-00036Z-3S
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:02 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so3763224fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460116; x=1752064916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v67OPa0Z97ZWGkIirl/npryGo3W245MZNqgveo3XfiA=;
 b=jw89h3rX79uoeeQ1TJlFQxvCqfGQ42JcIRk47tkQbEw7kv8iKSQ/vIKQUga72ZmVT/
 lVMsjY75oWcxheK8Dyb/ZqfXVQnMdhNhS0s9bSagbijF+YhWkguOtNYOog6oaS9nvKZD
 zBAone++MRnv6Rl1vJZzm9k9swIk+tG7fSmnB1rHpVNkWOL8EUyEyQlZPUev+3frku7b
 2i4UZkNmIGYR3rMrvai7DJknOV5CB+I9/E2yPx6gcVeoHkC5ZtEhY35zCcFrKJBwOVDR
 dg7GBtj9GA2VYXnzVtiFUkkVbrZmaMXuWbPk8YSp7h7I7IclfQtNLYiatPkSpEHVfNxa
 MLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460116; x=1752064916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v67OPa0Z97ZWGkIirl/npryGo3W245MZNqgveo3XfiA=;
 b=n3kZ05592KCah2pkwmZrKnpygUnW95BMbIPMWg8lkcToi8sAMnElucNlhGAnUj18KP
 nvspbeTvfuIrJe5oWyydsHPbAlgjexYecO0//00IapupJxMEvb3p6Ni8UN5PQas2sTZr
 O8Aez7E6kSgTEyySVbJvl9Uhm0TJ6ITj9xAVjz1idSyBHWViuujdvrcqzAsceNkf5m0B
 O8z+Rpea+3s1LVE3YTGf6nW/0LRbdEQYoo32YLQrBCQCQKEC+Etlcf2TPwd5q209tVwo
 EwDztpb3ZQEtiFnqLEsBlmilYy2+a+oL7rwcCZIljOJHMOCNM7sPuvGPVHm1WXK2TTVB
 Cefg==
X-Gm-Message-State: AOJu0YxwJqQp/frtlQiJCoNe7IedgUyONEezKwQzL6x61SVlSEszCi/B
 NcPAxx8zp8PC/8ZlaIP+oOTxZ9RX1+Eqe31GWeG33SNgBQm1S+2BKfx68toMgA4+FnxsHtG0dzq
 WBUOLXXI=
X-Gm-Gg: ASbGncuRKyiAQeu+uP4zagnz2s8KUhL5c3T6sXyFDNBKPyiVXx0HqLqEKe4ecyvAEoG
 e9gZlOE/AWKvPzlEKQQi13o//RfTMO0xRzyFlewg4a21LD6Nx8enGEQGvhk3xWSTc74WZVuH1yS
 4Q7OV3+Zo8BCtRtp77SBvAqW7o8c0sq26UDRplV/SIfYq1oQ29DB9sQ0IIWybSwEI4huq0Pj254
 7MPd5F474ObZ7673jTQgxRG67yCyMKoCsJTtOIQfGqu4eg8FN257M7Hv+zWsxUaoOL+5Kmdo64r
 kTb6GVEjz6wxCXZai9dojGvkT+MvJCSxHbW7bxqGsYeDYgCpvrdYVQJ/DIJkfrdt2vgyPA==
X-Google-Smtp-Source: AGHT+IFqk9x9shizKMDf30XgcjEmOTcTRo/TcFdIqVcukCF4ikQ9P3jKnEwyoFS2EYUKBf+dqAszgA==
X-Received: by 2002:a05:6870:af44:b0:2d8:957a:5165 with SMTP id
 586e51a60fabf-2f5a8991a5bmr1777509fac.17.1751460116187; 
 Wed, 02 Jul 2025 05:41:56 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:41:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 80/97] target/arm: Implement ZIPQ, UZPQ for SME2p1/SVE2p1
Date: Wed,  2 Jul 2025 06:33:53 -0600
Message-ID: <20250702123410.761208-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
index 7af5c59fa5..0fc602fb12 100644
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
index 7f35d1d23c..4ed0fe0480 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2601,11 +2601,19 @@ TRANS_FEAT_NONSTREAMING(ZIP2_q, aa64_sve_f64mm, do_interleave_q,
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
@@ -2616,6 +2624,15 @@ TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
 TRANS_FEAT_NONSTREAMING(UZP2_q, aa64_sve_f64mm, do_interleave_q,
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
index 3271c9cf78..e98275eec1 100644
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


