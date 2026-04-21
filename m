Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FB7EA7184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3TG-0001FH-Q7; Tue, 21 Apr 2026 01:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3SF-00005T-5O
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:31 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3SC-0006wK-Ak
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:22 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c76b9efc299so1472737a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748518; x=1777353318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHw9W0r73gnNntSyeFRZzouxm1QL1rIad4n1+k+yIsY=;
 b=c0ADSwEiGQe4Fwc2BBFFK+jkd4l6W/BlJOr3bULl3Q6pYRW7mFZgg45PcpyjFnEkgj
 G4891Fg3Iz/Z2lIz9dvXmoiM6AQoIvLAWIItFlQKVeL1I87bQkDcW0GZRtE7PlEP/mle
 qzVj1D1y6eA8LOwOQfTwL2+A1be8ZuIeT2cMxwGwtZU+0EXEJKZbFyJdZUvtea2PZLOc
 s0tDuLT/7tCQfMbNBZbl06eJuSkJ7M5DDdD0iwikBDcmKxmm6NOYoJlE8GOCbP9xUZzC
 ZzO/bz8GvWwumsFDDnSS6ulAMGXgDR/WRiSsUmoogHYOvzZYsBvqCWPPhHcoCPd7UXYk
 uPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748518; x=1777353318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JHw9W0r73gnNntSyeFRZzouxm1QL1rIad4n1+k+yIsY=;
 b=cEm6cpMxp7X66GqSjgprBUiKtBdTXEUT/I1HCpvNJzpb3E1nPe/tYvncoInHtVpXIn
 pmX2MScaDXwpeKkWJhP9ae2bzcMafzc5OUMuoPIOtjqxGsPa5pjjhWBZFLd0CHcGGqis
 zvnwj4byxZPprGPrHp0aCj/wk8Chnj73DX6Oj9uKVr51qeBBhOH6pQaPG6ixsC4C45Nh
 oXF+lTReWiRHZk0BBMnWeWo26gKSlSOFTyUtMXebucBj06f7eihyHb43xzqzP4UwVX/I
 wSzvosZRgT7YZR9jO5lbxql2t0Ki9zvOuuwBlwv0Qgg9VmKLCwCuyvJg8BlwFw15Q6Nu
 Qn5Q==
X-Gm-Message-State: AOJu0Yx5PthO8zGchG1KYC8hBSP1X2rG8p8B895SS20LQBVlXIAeqiHI
 dKkLUk9hJGmm/hau2MYruuGDVZdrwldW8yRruu93gyN36Y3jkXpgHgfnwjt++v21N/nv13oFbKQ
 TpzUbVss=
X-Gm-Gg: AeBDievCXATYrPQb2L7h+Q6SK6G2puzOR+56FZ2PWDImyW+AwKh/A287DduECastyH0
 5bRSLMewJddD6SrvhpqDNCiUyFqn8HtdlXb890HpEHr77T/sB1qxD8FLZsoLh6vflWWAQWZG0lJ
 F2q2uja4xpZMsuXtPT1TrQnQOkTR81mOb2AnqLVtYY32BNc9FaY0+mOuXbEm1zp1AsDiGJrgUWy
 hYf9dAAfRMzwSyYbh32vsQ4ZeYHbA5TYIjoBnk/HHakS8nnLkycrp3nuGzgyTtwmIiswHetk3ZD
 f26+bQ/UwzO+XBw5N7b5ik6z1LO0clyoKedEB4S5lowk3h/+7Djmji6+K7SMyH2UBVjCMgSp23F
 qnyM6BmNYz1Rg1w6vQZ1ADP+ZJqNcb4r9VO5HJqtT2sekcc9bXWP85iJ9m5wYPg4/tCp5ijLDEv
 mkBSjrGHcJaWD5szLj3nCnl/AX157kalOr8k4n1+c5y6b0AuBJnxk=
X-Received: by 2002:a17:902:930b:b0:2b2:67ca:5fff with SMTP id
 d9443c01a7336-2b5f9fd24b7mr118390615ad.28.1776748517640; 
 Mon, 20 Apr 2026 22:15:17 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:15:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 36/37] target/arm: Implement FCVT, FCVTN (FP32 to FP8) for SME
Date: Tue, 21 Apr 2026 15:13:45 +1000
Message-ID: <20260421051346.41106-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 target/arm/tcg/fp8_helper.c      | 95 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  3 +
 target/arm/tcg/sme.decode        |  3 +
 4 files changed, 103 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5863a6dbb8..36ae977431 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -21,3 +21,5 @@ DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index ebd448b466..099ca44c4a 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -645,3 +645,98 @@ void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    ARMVectorReg scratch[4];
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n = vn;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    size_t stride = sizeof(ARMVectorReg) / 4;
+
+    if (vectors_overlap(vd, 1, vn, 4)) {
+        n = memcpy(scratch, vn, sizeof(scratch));
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; i++) {
+            for (size_t j = 0; j < 4; j++) {
+                float32 e = n[H4(i) + stride * j];
+                d[H1(i + nelem * j)] =
+                    float32_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+            }
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; i++) {
+            for (size_t j = 0; j < 4; j++) {
+                float32 e = n[H4(i) + stride * j];
+                d[H1(i + nelem * j)] =
+                    float32_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+            }
+        }
+        break;
+    default:
+        float8_invalid_output(d, oprsz, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *n2 = vn + sizeof(ARMVectorReg) * 2;
+    uint32_t *n3 = vn + sizeof(ARMVectorReg) * 3;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            float32 e2 = n2[H2(i)];
+            float32 e3 = n3[H2(i)];
+            d[H1(4 * i + 0)] =
+                float32_to_float8_e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] =
+                float32_to_float8_e5m2(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 2)] =
+                float32_to_float8_e5m2(e2, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                float32_to_float8_e5m2(e3, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            float32 e2 = n2[H2(i)];
+            float32 e3 = n3[H2(i)];
+            d[H1(4 * i + 0)] =
+                float32_to_float8_e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] =
+                float32_to_float8_e4m3(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 2)] =
+                float32_to_float8_e4m3(e2, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                float32_to_float8_e4m3(e3, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        float8_invalid_output(d, oprsz, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b112f16cd7..c57c7c122e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1571,6 +1571,9 @@ static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
     return true;
 }
 
+TRANS_FEAT(FCVT_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_bs, 0)
+TRANS_FEAT(FCVTN_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtn_bs, 0)
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a02bcc0e22..2b9e41a75a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -865,6 +865,9 @@ BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
 FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
 
+FCVT_bs         11000001 001 10100 111000 ...00 .....       @zz_1x4
+FCVTN_bs        11000001 001 10100 111000 ...01 .....       @zz_1x4
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


