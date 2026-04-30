Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B8CD13D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAH-00074M-4C; Wed, 29 Apr 2026 20:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFA0-0006pB-44
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:49 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9y-0006Mn-CC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:43 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso197124b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508501; x=1778113301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WO6c7Ev0QOAz+gpCM4MJrP6PDuccGS4481ICnmoGQSI=;
 b=CRDscYEuPCs5vyevU3yrv6imb5VGsZxhKDXlwdKNJ8u2oN/9UjibgnDGd2QQm0SLA4
 OS5OFEuupoJD9TR5bq/iyV9mG0Go2MIEz7EeSNx6/oinZsbkl9+X8bNY2kgunPpnXqXq
 0+kpA7QacmE8OwhhslF8/aS/hbTcWhiX/3t7ns5POrjk2wY95EjnCtDLW82OSoxa4VZ6
 Cr2iqmntknew/1jcFv5bA3gEvu7yqUymnm+UzEvaD3R6zLHb+egPJyG7/Oq7NPSJqBfl
 vEo5JzuxvKqdnwXYOqpbIHsEYN3qglPukJUnQouRMivATGu0iLmBk2ljvnKp3a29T/rI
 f5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508501; x=1778113301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WO6c7Ev0QOAz+gpCM4MJrP6PDuccGS4481ICnmoGQSI=;
 b=KA3ODTiYUha8N/T7ucyfxPUa3vMazifIjQUvDihpkmtjat3gQnW4cHZge6Dv9EDFgo
 /0meeJpO8vafXu6cfEPyNMlm6+j6ng/aZQ0GwKfhtoMRd16HpEa07j2VDgSltE+2RIwz
 kT0MCQqdSeUErEZ3gLtQkYqncSFLcW4Y7JzOR2otG6BIp2UlTUp8saVcOAT8bZILyB88
 4iAtK5/xNEdShBEjtmdqwqx6xCvpIotVCSOp2Ox9BfnG0Wj1BbHwsJcVHuZrkbWAhiuR
 qBthyRLUrwXQ7ULRRpW2MUfk0r7xcawnzbH8hPk12ZZfsdRqqLo3ZEFJ2s/WlWlDRdH0
 SACA==
X-Gm-Message-State: AOJu0YxZqgQbOTdqglMQzswrvbwF7qLWeywfMKJ8H+7dNSfkgqJHSzVF
 cMquAQmgbZIHlKNZwB7qa7ZzqJwuJnM2I5JBOaOSpj/xtXyPOi53IjsH2zU7Y/NY0dqvdObbQKU
 TDfHwmrU=
X-Gm-Gg: AeBDieuTAb1Xo88Lo2lQqNhct6DwQalNsjdW+1utqqyTYIcf/fzxqtW8SC13wObifxb
 nCvy5tumy498F/H9QBgx6ceiW0pYeUIEvzl6hFSpv4iVUMnqeb8qbTwVm8d+8lHbZqtuQiz4jHE
 lXGvgrsNfN9mxZhaoR2l5ZO/17+UQltxvem3x1KAxd+3e7bA5FW4YT+PWyFvQWfF7h0AcLfyA5E
 GSHcELKZUHLrigXqqKrVMnIhSWWjm+LKs0evnhvL1NhzV++hCjiVsqI2Z1APrUF7MGv3uM4orEK
 6RDCnn4JNU45W5AIMIF705KNZu89HxUsX1W4iJfdbStoHaKuEYUW5KIg+EAVHzEeR9osJB02cIF
 3WExQTbwcgb7NJ/xkSy1wAVybo3/jtLpB8D46QXoKOU5UQUU0I1AbW/mlJmbpkzeBpjk59qopQB
 C++y9qitb7HP3fP8omPaiY9esPX9qCF9fUN8jbXyW/
X-Received: by 2002:a05:6a00:1f19:b0:82f:6e7:152d with SMTP id
 d2e1a72fcca58-834fdb6d5f3mr771581b3a.21.1777508500689; 
 Wed, 29 Apr 2026 17:21:40 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 22/47] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT,
 BF2CVTLT for SVE
Date: Thu, 30 Apr 2026 10:20:21 +1000
Message-ID: <20260430002046.59739-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  6 ++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  6 ++++++
 5 files changed, 64 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 104e36b3ae..334ff480bc 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1629,6 +1629,12 @@ isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool
+isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 0caaf63749..18ff483bb0 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -4,3 +4,4 @@
  */
 
 DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 5566550205..a4c7c44e6f 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -136,3 +136,31 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
     clear_tail(vd, 16, simd_maxsz(desc));
 }
+
+void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = fcvt_fp8e5m2_to_b16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = fcvt_fp8e4m3_to_b16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        bfloat16_invalid_input(d, nelem, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index db32230595..9bab5feb93 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
@@ -4067,6 +4068,28 @@ TRANS_FEAT(FRSQRTE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
            s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
            frsqrte_rpres_fns[a->esz] : frsqrte_fns[a->esz], a, 0)
 
+static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2, bool isodd)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           tcg_env, vsz, vsz,
+                           issrc2 | (isodd << 1) | (FPST_A64 << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, false, false)
+TRANS_FEAT(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, true, false)
+TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, false, true)
+TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, true, true)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 078a085a79..e7984fa8e0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -108,6 +108,7 @@
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
+@rd_rn_e0       ........ .. ...... ...... rn:5 rd:5             &rr_esz esz=0
 @rd_rnx2        ........ ... ..... ...... ..... rd:5            &rr_esz rn=%rn_ax2
 
 # Two operand with governing predicate, flags setting
@@ -1090,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
+BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
+BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
+BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
+
 ### SVE FP Compare with Zero Group
 
 FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
-- 
2.43.0


