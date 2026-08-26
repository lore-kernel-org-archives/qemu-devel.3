Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55573C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeL-0000QE-8W; Wed, 26 Aug 2026 13:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdx-00006D-5a
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:33 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdu-0004oP-QV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:32 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so782552a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766149; x=1788370949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oHlvtyL2rQlyiAdhAGXJKakXVeYyRaf33f+zCffDFKc=;
 b=XCbUk0BdIM5hpHNBKi+nVzKciMCt4iARLqzQ5To2cQsvBsY8Gp3AV3uTvEYfI0D1k1
 a2xgQRB34SZnVZfvpMOWcLqfkMJ7kJoDo8klkDhDEBa0N0Glxf/qxXY6Nta0rsyNmdNC
 JX+yDSchTPyvCfHSDUfQtcd2df0n6vhERjBE/Q+J8a//uASMOaTtuK+rtJjEGQBg+D/9
 6inQt07RmpEglDL5Mqe/RJdd/EksYeHrXwQDuxmNPQ77acEv3N1CVw6bJYKpMQ/eGFnl
 3LDzA8Y0Kvgw25mBXrBfpNsemUAHahR6tufgd9ASu5ytWOvdAJiMn2DqThkE6S9Llabs
 lumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766149; x=1788370949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oHlvtyL2rQlyiAdhAGXJKakXVeYyRaf33f+zCffDFKc=;
 b=CyqImQRXvgZmiIU1NlInP12bS5C7GyC52s5Enfi9HDUFe/j0crmIkyU/8v/00QaQOV
 pMdpZ/sdS4cZgOZDBqeQKB93rTRozjTJ0W7kqK3GDck2RDT1RS329fqkWpNTLhO+ZR7G
 LMwmYmG7Tt5kr+dcEyoq+5+BRjkWb9mgVCUUD3Xiw/t0fsyVQDGcz6WAJ1P+Ap4FppxA
 qncmhOTukUECCHMF++1QJWR57mmTkcyNEjmIz63BC/EZVQAiBYor1bwHT9YNQSVbS0Xm
 FB2SDD6C1Cc6vVmnsF+L7hsHPg0oPqdi/tzcyCl3RjMaW4sVDxYSsHxYyUKs4W42oWki
 6+tA==
X-Gm-Message-State: AFuF++kdhv03nuFbknVMCthVDrblOFrnVtrZtwofIMNsJXxpCGwsp83I
 eg6Z4N19nb4d3CVhWMERi+AWwDcorpU5DmTGe49FxhJWgL1U41ADM9rive8gPvfoV5rFxzdyZQz
 8qQEnDZA=
X-Gm-Gg: AR+sD109CJZQ7S0I8tXBv9ZxRNrdFGPHzcjoefy57SvHQG0EqI2Pot9BDXhQzaPHQDc
 sDsbYjTL0YFSf44L/QVsCOScsR+xxrDakQZ8dQBwnxdMd+X4Fitte1/eu7JSdrAbf+nWqn9uNo+
 pRwdVmx914MfoStJ/+EBPr7j3g7BXjabTjE0r6A0OolxUdwUC8GIrpykCIxfOp1mfF+WODwxFxl
 mGBmeLFSciJ6pYCTh6qE1HSZtlCvxs6QRdp/SGQAO91Chb+gPTNeHp7vLcPfw9DGhPmpOwaPKta
 yyg6ezAIPEZyLubh7C0dO1EOYrciglaNL7wm5y792S66tm1+KLC1vEJpGs0LfW82qQsMnK0bhk9
 qOnI4II9mL1M6alYP3EkpT64RE8hnDgnCYHRgpaUhYbJW/9UxH/g6e+0x929zfKM6toP28iXNd1
 VRfpbept0yxAcUemDjHsbG6Zuswl1Ddoswe2qCIh7pIOzpN0Ve1vEZ0HELRIIUQTwkx4pmeJjPY
 ex3JvdVuF364uper3Rpxvxmtp1M
X-Received: by 2002:a05:6a21:7985:b0:3d0:ba81:79b7 with SMTP id
 adf61e73a8af0-3d0ba817c06mr5050655637.12.1787766149040; 
 Wed, 26 Aug 2026 10:42:29 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/25] target/arm: Implement SME BFSCALE
Date: Wed, 26 Aug 2026 10:41:59 -0700
Message-ID: <20260826174213.614571-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-a64-defs.h |  1 +
 target/arm/tcg/translate-sme.c   |  4 ++++
 target/arm/tcg/vec_helper64.c    |  1 +
 target/arm/tcg/sme.decode        | 20 ++++++++++++++++----
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 76859c1f745..b29cd490200 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1872,6 +1872,11 @@ static inline bool isar_feature_aa64_sme_tmop_f8f32(const ARMISARegisters *id)
     return isar_feature_aa64_sme_tmop(id) && isar_feature_aa64_sme_f8f32(id);
 }
 
+static inline bool isar_feature_aa64_sme2_sve_bfscale(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sve_bfscale(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 12f58c6a442..c1e5d86b272 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -151,6 +151,7 @@ DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fscale_b16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fscale_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 463754b057f..d28574a8cf0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -890,6 +890,10 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
 };
 TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
 TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
+TRANS_FEAT(BFSCALE_n1, aa64_sme2_sve_bfscale, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fscale_b16)
+TRANS_FEAT(BFSCALE_nn, aa64_sme2_sve_bfscale, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fscale_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmul[4] = {
     NULL,
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index d8b25b868ea..88799693507 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -179,6 +179,7 @@ DO_3OP(gvec_famin_s, float32_famin, float32)
 DO_3OP(gvec_famax_d, float64_famax, float64)
 DO_3OP(gvec_famin_d, float64_famin, float64)
 
+DO_3OP(gvec_fscale_b16, bfloat16_scalbn, int16_t)
 DO_3OP(gvec_fscale_h, float16_scalbn, int16_t)
 DO_3OP(gvec_fscale_s, float32_scalbn, int32_t)
 DO_3OP(gvec_fscale_d, scalbn_d, int64_t)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 60c7cacc10e..4e19c42b196 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -287,8 +287,14 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
-FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
-FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+{
+  BFSCALE_n1   1100000 1 00 10 .... 1010.0 01100 .... 0    @z2z_2x1_e0
+  FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+}
+{
+  BFSCALE_n1   1100000 1 00 10 .... 1010.0 01100 .... 0    @z2z_4x1_e0
+  FSCALE_n1    1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+}
 
 FMUL_n1        1100000 1 esz:2 1 zm:4 0 111010 ....0 ....0 \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2
@@ -365,8 +371,14 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
-FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
-FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+{
+  BFSCALE_nn   1100000 1 00 1 ..... 1011.0 01100 .... 0    @z2z_2x2_e0
+  FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+}
+{
+  BFSCALE_nn   1100000 1 00 1 ..... 1011.0 01100 .... 0    @z2z_4x4_e0
+  FSCALE_nn    1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+}
 
 FMUL_nn        1100000 1 esz:2 1 ....0 111001 ....0 ....0  \
                &zzz_en n=2 zd=%zd_ax2 zn=%zn_ax2 zm=%zm_ax2
-- 
2.53.0


