Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36D9EA71A4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Sb-0000Vi-Fa; Tue, 21 Apr 2026 01:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rq-0008C5-Fz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rn-0006eP-AD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ab232cc803so18287225ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748494; x=1777353294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtGKPI9ZpKsuZkMA/HWHFsmsOIe2bn1o6/gZpN9uRvQ=;
 b=CICDkrqRki26lpjT3tMvuYrG2iKGNYOEPpup4NSWJNzGqw3yWoFNLt/N08JSeMSsuw
 4+Z1Z+3qfxZADseFilYGFRqnVT46z+Iy9yOEFyq1hJzKqm7s9bgzyuvI/tKr2vS7/8DM
 /Y1F2xrPqgcTA0/wa0dKJ6uNeb19LqgDGFPLpMLeYWA0+GSz8s0Fa72cG8T5snw4Umsc
 ZkggYAzByfF4GZ8mvz5hIP5h72KN9A3wz4m+b39lT3N+rbO0eUYcfIqrrNJ2cEdRGU3u
 fZD3yq8RyZssrEKg1cXddO/cT2bsuiFV82GIPILz3/fDAUqG6Lm+ok1ma6RT3j7YMQmE
 be7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748494; x=1777353294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtGKPI9ZpKsuZkMA/HWHFsmsOIe2bn1o6/gZpN9uRvQ=;
 b=Fz1+azaIVUwP1x9qNZQQze71fUKeWxjlSGHY+7fLf/CwmwTXKprxHuxwVDsSxyDWZH
 LOR6OJsWs/e35mFEJXo4Uwj7UOFSZelWJzWAGdMVRBgAuxVzhqYdb8vnBD/5mD4jTOuQ
 3kzMVCc6TBsI4MVisBNHUTZQW1T/wWHXBk/zEts0kRAn3YDV44FYskUFV3vIp3rnR4/j
 YEW3UPfqJMwDwKXHhbw9ghYjqq8DWMkxwB2bsEHapBlQet8RbKipbP4MPAp/uVuJU1uO
 kjHDwlZvNFd0jtT9gfJBFweqUqU0ImfpRDFl/aB1pUo6aPIWWlSbDSfxI+J0V85XzdaL
 JyRQ==
X-Gm-Message-State: AOJu0YxRWY9SQmgm0JEgpw22V7jrno9larsDwLzLITISC5mjEtS215iL
 v+ldRJRRjaPVFpFqIGqYHQSrrD80xtui8Or7cJf6iOLRe5ixpAk/cZwFrCdWbe9qYAd/AbP+cMr
 KSWN2u5Q=
X-Gm-Gg: AeBDietx3cIveJSM+bVZ6Mgzz593q++fl6DPIxxWaJflWw6y1GrqtBZTC6D23RP9FsN
 2XncujdaKiTgQi/5I9a6DnUPCt+t3uK2oT2zu8wgQz/qNXjLl2OVEtv16/Vs/Rl0wMXBb/xtbRQ
 XRIL4O0HCqJrhQ04eB6kaMjdBKB9K2oT6hGa5H7p7QYC8zFZNYkW+H/ECdvLFON/EUWTEuMdSs0
 pELjMEnhLGHLWE6xlXEgLc5DdkAl+/j5mfyKy4bmEdfts9Z69adswBYOHKbc0nbQNt9MnSaWxcA
 CFgLzBIQBHQeBBptsnP0rZWki81dbJTwuzEHOsvh0dkeLKclyjeDO6Md5AZ6t3s0zJ6tTXbeT23
 wtbjFSYcVBZabA7XbP1vhshY5s3nKrWjGvmAIlV4HxquSRsNMAAT6DqJtek4bezxfPAGJEhIbx8
 BRpE4jHTEua84KeB69bMU+ahRVOt2oFJBd7YvRX2IW
X-Received: by 2002:a17:902:ce09:b0:2b4:5d87:a1fd with SMTP id
 d9443c01a7336-2b5f9fd21c5mr175941855ad.27.1776748493850; 
 Mon, 20 Apr 2026 22:14:53 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 26/37] target/arm: Implement BF1CVT, BF1CVTL, BF2CVT,
 BF2CVTL for SME
Date: Tue, 21 Apr 2026 15:13:35 +1000
Message-ID: <20260421051346.41106-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 +
 target/arm/tcg/fp8_helper.c      | 79 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 19 ++++++++
 target/arm/tcg/sme.decode        |  5 ++
 4 files changed, 105 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 18ff483bb0..966f83d796 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -5,3 +5,5 @@
 
 DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index b03345c670..daf9c35720 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -149,3 +149,82 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vectors_overlap(vd, 2, vn, 1)) {
+        n = memcpy(&scratch, vn, oprsz);
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i)];
+            d0[H2(i)] = float8_e5m2_to_bfloat16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i) + nelem];
+            d1[H2(i)] = float8_e5m2_to_bfloat16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i)];
+            d0[H2(i)] = float8_e4m3_to_bfloat16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i) + nelem];
+            d1[H2(i)] = float8_e4m3_to_bfloat16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        bfloat16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sme2_bfcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e0 = n[H1(2 * i + 0)];
+            float8_e5m2 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = float8_e5m2_to_bfloat16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = float8_e5m2_to_bfloat16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e0 = n[H1(2 * i + 0)];
+            float8_e4m3 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = float8_e4m3_to_bfloat16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = float8_e4m3_to_bfloat16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        bfloat16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 1267d3e65f..3e1da83535 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -22,6 +22,7 @@
 #include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 
@@ -1531,6 +1532,24 @@ TRANS_FEAT(UUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_bh)
 TRANS_FEAT(UUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_hs)
 TRANS_FEAT(UUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_sd)
 
+static bool do_f8cvt(DisasContext *s, arg_zz_n *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2)
+{
+    if (fpmr_access_check(s) && sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           tcg_env, svl, svl,
+                           issrc2 | (FPST_ZA << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(BF1CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 0)
+TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
+TRANS_FEAT(BF1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 0)
+TRANS_FEAT(BF2CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 1)
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 7a8e1abb59..df9586c1a5 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -853,6 +853,11 @@ UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
 
+BF1CVT          11000001 011 00110 111000 ..... ....0       @zz_2x1
+BF2CVT          11000001 111 00110 111000 ..... ....0       @zz_2x1
+BF1CVTL         11000001 011 00110 111000 ..... ....1       @zz_2x1
+BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


