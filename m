Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1F6FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Ck-00082L-TH; Fri, 24 Apr 2026 00:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Cb-0007NA-N7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:41 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8CZ-0002u5-Sz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:41 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479e4835e26so2682382b6e.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005099; x=1777609899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7V3cChxtG3x49nUgjSHcR9O7ZWwgxyibx9DFKFeEU6A=;
 b=lKFVl2PaGh0e7wcKXOoSRCmeaKGinebRCWxyx89DjKabcF9MRcwA00pUrzLY9j8jbu
 geATjYl/Ecy3Nl8H5cw4f2h94LdkpGRyG1CzZQWCcGHaUgu4+79C9iohDqhIGtww21D4
 6F8cGh1BxAuJ6mRokZl/0pUue5r+37ZCxwE+kkpOz+ACZcs6bghEL/KBqFW5DReR8lB3
 6imXpISNRpEZAMGWaLup0cxmYSiItgoI/wJr0XRyxncBSJs4U/kY5D/97tgHtWOpWF5W
 ltWvXJsOrrTItCDxMw5KBG2OCISbhpWptLn7KhFKrJMdEN3ZasD3t/HTProReNtH7TOi
 ci2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005099; x=1777609899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7V3cChxtG3x49nUgjSHcR9O7ZWwgxyibx9DFKFeEU6A=;
 b=cYWyugFOJxx/mRzzfPFTMD0wM0FkwL7Na/UHwWGscYswMCqPAQk4taFsKnFrnXC2go
 dKh3JnJSt59tqYzphX4pnZDrGJIa7K80A/CO3l98kAACUWNqdCW+pf5NXaE5+mpN/1OW
 cIFqtH1LPBmU6BJJSvPOu1occi2KespoNExhEgSDc1jdMt3fVn6y3xj9NhUUXkg/AflR
 sJEV0XyrK8b9r/gSgmbcDy+i8VsSu4KyGgitaOgb5AsnNyk1Ll8BQvtFgICccFV3Lef5
 QJOUDCH4KmQ4a/kpZw9n09NCacPWMLf31jjMmH94o/t4Efq9qiNtGdtL5BjkDORf4xbM
 rEww==
X-Gm-Message-State: AOJu0YxLebEZ60n4gnLEXxXKlhKSKWyNP5ACAHf/ObLta7xxLB/ca9QG
 gLP7xXQEoBjfWYjl7/kX6uogV7Qca7V9fqTBogHqz/M6t9cqZGhxTw1ENZ4hUZxCSYY7DSoybWW
 8TDbOzfA=
X-Gm-Gg: AeBDieuWkXixSGiyI8NlFch+XjIpCUYOS0N8XcL3w+OcfJLFn8bX7hIsdG3Cb9DyWVM
 sdus7HLBFTpC4u2JLA9jV64HOVjZ36bFYA37Qountj22xFAGDIMTmzF2Vd0GLDYO+66M9ctdU87
 Enz30Mg3Cxb5TmzTPd5zIDKXkHLoYVkJX0kDLwBL8uU36QTEwAfH5kV6ZlsW+W0vZm5O00Qu+Fh
 jZQ2La1o0j9LRgXq/LDCIpvK++RXJTRhF+H8zxiVXrZGBihleffb/fcyyhyR60sAtAilcCu8J2S
 bljD4izlfCVoO2Hu5cIWSrVH89ECNyfNtIvEr6u6PhnUgAS5CBInTiC2uh9blF4GUtJVnwVcRWy
 42YMKXLL0M8b4zAhXCjxULov/Zto3YSyBoUoTRw+oPKBUjDgHIl9245yM7pp3hcEmTzYa6lJ+Ow
 v8Txa08FxpmqMIMo/BIHFo6CRnrsHCI07Mo1LDDct4ggUPzhk0jfkyIy0kI7VKDw==
X-Received: by 2002:a05:6808:3a06:b0:46a:869c:b576 with SMTP id
 5614622812f47-4799c8f895dmr16031933b6e.2.1777005098677; 
 Thu, 23 Apr 2026 21:31:38 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 18/40] target/arm: Implement FSCALE for SME
Date: Fri, 24 Apr 2026 14:29:52 +1000
Message-ID: <20260424043014.46305-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 15 +++++++++++++--
 target/arm/tcg/sme.decode      |  6 ++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 87d16b57dd..8a6e5d555b 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1603,6 +1603,11 @@ static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool isar_feature_aa64_sme2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ca6b130cfe..c6a8eec32c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -706,9 +706,12 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
 {
     int esz = a->esz, n, dn, vsz, mofs;
     bool overlap = false;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     /* These insns use MO_8 to encode BFloat16. */
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
@@ -718,7 +721,6 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     mofs = vec_full_reg_offset(s, a->zm);
@@ -830,6 +832,15 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
 };
 TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
 
+static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
+    NULL,
+    gen_helper_gvec_fscale_h,
+    gen_helper_gvec_fscale_s,
+    gen_helper_gvec_fscale_d,
+};
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_z2z_n1_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_z2z_nn_fpst, a, f_vector_fscale)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 9dec7318a4..ee874be1a6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -250,6 +250,9 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
 
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_2x1
+FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
+
 ### SME2 Multi-vector Multiple Vectors SVE Destructive
 
 %zm_ax2         17:4 !function=times_2
@@ -291,6 +294,9 @@ FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
 FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
 
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_2x2
+FSCALE_nn      1100000 1 .. 1 ..... 1011.0 01100 .... 0    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
-- 
2.43.0


