Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1233DFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAX-0007uU-9N; Wed, 29 Apr 2026 20:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAP-0007YO-HG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:09 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAN-0006aV-NJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f33d28c1dso206047b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508526; x=1778113326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GiTDWBFvFfWsIlgU7QlGePW8lBNeuuWLOhvxSB1tt1M=;
 b=EiT+25mh/ooc8gEfJgK/7j6+bF4JNcoKJqiU8flAayYuJRNAyZTgoh6vHOKl3tkcU2
 vlJs3CcJHjaO4WNkml+8nt2ZXDDt3tMJ3QbIIIFjVLse0n9iVxNE1D0bZ7GdjUr7aibk
 ZdW99uy4Hyjhz4JK1KBbZUD+Axtcy2ylkRDZZlbNTsR0sFOprdGL8dteOjknZQBywzQF
 SFaZUb22ZK/S+lY8N66mwT2ydASJKZ41BcPM5HVYhLegBM61zs5g9xdlMJjzVneq7xf1
 +/XEspJjcfTbGetFVV99ZAClRPz7bADyJnNJIyDHkNgF5L9+DlGhj0EsG1G3/0h//w/q
 HKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508526; x=1778113326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GiTDWBFvFfWsIlgU7QlGePW8lBNeuuWLOhvxSB1tt1M=;
 b=OWn5zPXh69RQla/06QKH6SABW3NZw19PWxynBDSDb1UVoTYRcdcW3H50JcsFN1yhsl
 AA1ithTYioJnHYMguZ8TShBSeSrMtqZH1H10gVfO8f9avBtKV40N/8N+Eh16lLjFdVcF
 ykad4qdTdDOgd9yx4K+dDkSiIHe3LCQk+46WFmrInrqz5s9PocrJpLX/iOSeWF1f40VJ
 u2JdevQp7RIQSvV/n5lui7cK2O+pFnqftnZAsY8+AtPsYhrxIoSiPTvWkrLy/TVc/dbd
 K/9Pw+fnFFeABzuXOUOK4nRhPXGRblGixsZH+rzW4DunhYWpcwZX4y2IpEe9OtUMe4X6
 TxXw==
X-Gm-Message-State: AOJu0YyUZBsUBpUwmu+QUix3YHb45WCBM569sNRp9m9kwrDPhtL3i1bG
 Ln2QmCHRDm1DKqdmE/Sug0fQt0yfZB53yGuDoDAS0Ic43hOCuI0EfHZV1gIrF6PehzJuG7GPX9H
 sN6pbj2s=
X-Gm-Gg: AeBDieuYZnP834BJXYYa4GLwtHdSygK1ruG2b5OtQGcSGxjaIZyNNHWusujO0/13zqH
 /O114DKOuu3bLg5cGrImjsS8dwY4uZPEvDsfmR0GAmr2zHPhS+IQScQm7ZdpZLDPnmzKTrREgPk
 eTPpV8hINiHbSxvHMgD3o0vzKknS5q5nEFze33QGarGQlit3yNosjdwgeFkqAxfIUlR2no/IdDa
 V1nFgAOEBPx6+yfnxSRZE4DgofOEilsnstUiTwENSotDDgb+NTqZaSLWjignX96k1iNz/lehBzG
 6gIYDi+vd90koQflhWOhMrbumcUD5U84Nc+R3IwKY220f2KazLlo9Ofxq2cKRn6Xa3wELWZ4zQg
 lh8OYD4nlLEz6ZEqM7MkFDyvjU0lc3cHbg6eGRDonaHThMv4KkM49Zg7lHdOvpb/iSloslDwOq6
 zEzxDHl8EvTbiNENQxuu8TDSBFHZYswq8/pGwkl4CJ
X-Received: by 2002:a05:6a00:1827:b0:82f:6b6f:13ec with SMTP id
 d2e1a72fcca58-834fdd080f1mr787651b3a.34.1777508526216; 
 Wed, 29 Apr 2026 17:22:06 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:22:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 34/47] target/arm: Implement FCVT,
 FCVTN (FP32 to FP8) for SME
Date: Thu, 30 Apr 2026 10:20:33 +1000
Message-ID: <20260430002046.59739-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index f92ffe68e3..f0f03298d1 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -753,3 +753,98 @@ void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
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
+                    fcvt_f32_to_fp8e5m2(e, ctx.scale, osc, &ctx.stat);
+            }
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; i++) {
+            for (size_t j = 0; j < 4; j++) {
+                float32 e = n[H4(i) + stride * j];
+                d[H1(i + nelem * j)] =
+                    fcvt_f32_to_fp8e4m3(e, ctx.scale, osc, &ctx.stat);
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
+                fcvt_f32_to_fp8e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] =
+                fcvt_f32_to_fp8e5m2(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 2)] =
+                fcvt_f32_to_fp8e5m2(e2, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                fcvt_f32_to_fp8e5m2(e3, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float32 e0 = n0[H2(i)];
+            float32 e1 = n1[H2(i)];
+            float32 e2 = n2[H2(i)];
+            float32 e3 = n3[H2(i)];
+            d[H1(4 * i + 0)] =
+                fcvt_f32_to_fp8e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 1)] =
+                fcvt_f32_to_fp8e4m3(e1, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 2)] =
+                fcvt_f32_to_fp8e4m3(e2, ctx.scale, osc, &ctx.stat);
+            d[H1(4 * i + 3)] =
+                fcvt_f32_to_fp8e4m3(e3, ctx.scale, osc, &ctx.stat);
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
index 050c3cfefe..2f79c458e1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1572,6 +1572,9 @@ static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
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


