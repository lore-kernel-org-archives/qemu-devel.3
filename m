Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEC9C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFY-0005SM-Fk; Fri, 04 Jul 2025 12:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFM-00045N-BJ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFJ-0006ur-Rh
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso11823705e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646400; x=1752251200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FA/V/E0/PYzfQXJFZXoR8kL+LV28zQZtl3tMaeHyII8=;
 b=cQRLLowP5gn430/DhcN4XqLlrUTYAzfZmaPkNR7WwhepTw1ZhaMn051F1I40ZPPJkj
 ANb4NKfb4UnMFrtuU0DfDfuvanr7QB9g02sQfq+xVdVKQeDGdwYaNjKqZrCqWYzrxFzc
 +31XHkOb/nSGJ4+9ThdMoqDePk2LUVIpeUel748lm4Dfz/6hxIew7v10AB+GNqZ46Nhg
 201VBDZ1ZATytVV9jA/O0Vm5a0E19dWTmoDqdVtG2ePP95eNWJozHWKb9TPx2m7SuN5J
 YdELhXPoUV8cA1GJsShWLGjWg9Qh/3dhV8SvpcMCvU00k7bhrZKoS5AACbxOgypl7+0T
 jJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646400; x=1752251200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA/V/E0/PYzfQXJFZXoR8kL+LV28zQZtl3tMaeHyII8=;
 b=sU5F2SqjfALahe4LUDEYeRaK/sWdy7+jzw2Z9Uso/qTzAH/yqo7THCq3L9gw3Xx+uv
 S6WBpK0uDBMlQuIaPMrDnwLYWesd5U4GCxO9gzPsKdDLcj4vSx+BuNwMU6RhGejRa6jB
 AnJU4iLyT2YC/7ufBu2ft5U96lX8mvV9+aml170AJ1JRu9vrgFJyAyEL/1b/dEXvBcuO
 NMqjVH9wyfUl6qPN6QWmtGxQN2m3WAAc9uGZUoTGYIbocwsNe9u1i8BctOKfNWQ3cJMc
 xbZ33smeEhqdg0C3LWLFPYLQif4Lsy73+4FADe85q+LDIHca3wW+jXJOG94qY6s2QQD7
 kjXw==
X-Gm-Message-State: AOJu0YwRpFm0tIGg7kENwHmMZxCEGGx/fLIHQzB6HxLPrtOX4guTv0qJ
 9+G0zgq1gjV8TWI2fNvcX46i8SY7+OzKdrNTxJyRlUbEUMYRnL+i64dZXnbVDP+g11IGBVlfz4H
 dEcVD
X-Gm-Gg: ASbGncs/dUO/xLfITRvKwRztZB+OwT8R8Qi7sy5/wIWqP3DlGI2vEEv3m4t07W0v750
 80TyBJBYt8lLJ9t9t1pWJai24Thgqy+aZJMMlCwSUKjd10HlRAO0ilX/4wrU+3nf2wv2BlgDi/T
 GWcWCEEaN9rO/apXZAXcT7jwLeQuLHOoSl3y8PC0QG+aIdNdoUTWHjhIu9sHUE4QWzyhOdWHLTV
 EzaEyYDLnV7QsK5FULT5u2AgOS2xn1tCXth9hPJMQB01+dcqNRRN7AAUkYRCf+SCEjLunZTAx7S
 vgM6bVdz05fEDbweFsPWCOeOJnQUl7eeTJ4sEE+YiFTaQ13jY32W4AT3g8IrjkbIUKef
X-Google-Smtp-Source: AGHT+IFxUOdufPYzJotn4MYRZ89WfmA7DGWP0BQFdmrqbVcRfHl+zj/I7qqVIfGvAeK4VbSG/tVH8w==
X-Received: by 2002:a05:600c:1c21:b0:43c:fcbc:9680 with SMTP id
 5b1f17b1804b1-454b4eb8326mr27897785e9.25.1751646400329; 
 Fri, 04 Jul 2025 09:26:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 103/119] target/arm: Implement ZIPQ, UZPQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 17:24:43 +0100
Message-ID: <20250704162501.249138-104-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-92-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 10 ++++++++++
 target/arm/tcg/sve.decode      |  6 ++++++
 target/arm/tcg/sve_helper.c    | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 19 ++++++++++++++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 04b9545c11e..0f510ea6103 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 3271c9cf78c..e98275eec15 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a9dc3c44b22..dbbfbc12b97 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3550,6 +3550,35 @@ DO_UZP(sve_uzp_s, uint32_t, H1_4)
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
index 01c4eaa5856..28cfcb9cb4c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2606,11 +2606,19 @@ TRANS_FEAT_NONSTREAMING(ZIP2_q, aa64_sve_f64mm, do_interleave_q,
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
@@ -2621,6 +2629,15 @@ TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
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
-- 
2.43.0


