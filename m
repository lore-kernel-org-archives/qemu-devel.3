Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE762CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZy-0000FL-JW; Wed, 20 May 2026 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZC-0007Vb-Rm
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:50 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ7-0000fZ-3L
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:50 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-367cbac9cb1so5003623a91.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301360; x=1779906160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG5j+tXBfe0M/pH9YqrPktPeM17VCWtju0SLzqGEZMk=;
 b=MyLt6Gf60xvgGOhK6ZRAaCia1I9ntnQ4K2DHSyYAsm8XvwIVvBtSWCsnsUX2PpOMQW
 ce70V2U4bvTnlGN5C52KfG6hIOC5sAhPTMIycvQegF4GQ/jEsF0U4nxbOwuG8NKJRNOh
 cMHPn4hHgN/d5NIwklVC27zYaVxbTtJU536ZdDyEb1wZqQdNyuLfC+a+9fw4JJsHKgmh
 svJEtsS/isYbkMgroJ+Swq06JohnFxNyVPB3B7eQm7Vag2gauTm6qcT3p7bYw/ExzjAX
 YrH5DVeTY/sVzXzFWGFpW61oXyk21cH3LR5n/xQbI+Ac8VIfTb5mcwstCrIUbVdJxIyM
 DHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301360; x=1779906160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tG5j+tXBfe0M/pH9YqrPktPeM17VCWtju0SLzqGEZMk=;
 b=Exw8CQXr3/sP1NNGofWIHFNl9Z/Qw0z/BdUlXZfOFYVamUKCxhJxdHf+I2hJAetldj
 R0nIWQbQBKUSBx8ZmztpnEY1YirYqPR5INi+3m3T0EJjdC3mQIxEbpK9N9Y/ncqtz0pv
 Jb6IHw0TQitBBCVfKeJEQZGX4yK7AltEgT//ogcGJUo2s+TEj1Ek1Xm6QBjPAOmJmrMV
 JX9N4PlK1hw0CRDzHWAWQRGZOjMalAb8cIn+d9weVguhO65/gu5RTbBLgraLtYVpS7Ft
 nq09kP4q3tXzN1NIbzhMJaupzvmSL5ryCCT90Z1QE0V0RD+YNHtHBtji8j2NFHfHEZvF
 sqHw==
X-Gm-Message-State: AOJu0YzGK6c1HHwvJSFt1lTPNbRczX1jJ47tCPpbFUPUTTj+mMoPG4wX
 sfDiagTjUzt0uIt3Vr2AYLHJT1ZZxlSyPUETHsNLLeoYVMDqEHASjvMxwxPDmmqoMAWVhLUiHvz
 0t8UwFtg=
X-Gm-Gg: Acq92OHO5bMQ0Vho30/57bCajigsmMfYjqKrQL0ZXteZcrMylB8kl5G2cjArMe/v6jj
 ujr7nmWSo/DxwIZELGJaF5slFqhP3Fer4QpC/K5gcpeCEjAjShXE56A51rQF74v1vDSar5mk/yY
 urj+zmTLKrAZd2wyJdMPNWcaQ1SK3wrfWTmbWPrKY7g43tGnxohcswoiRZ+3reaoUbr8gXGbIc4
 f0BenzphqDTYIDQErCCvS1oSxYX/wpGQHpfoX2+nYlHEAztPti5ao4bzYEgDPryHkns3Sgsz8/+
 s9Vcgdxp92YPkH7z4yZe6G16laA9bV+A2AKVJVEWFr+08i4fZU4IZ9Ra8SaDQzfAbn31xuWhRT1
 AWPXJWus4bVyDrCChlBfFDNqT9uhC2vL399MCO09JOrSXoVxArbFwj2ATS6JeYivbqMWu78Tw/z
 uldlUqgA/o1BkIlnXktlUNlBamXREROlJNJbhjwJs=
X-Received: by 2002:a17:90b:5904:b0:369:1dcf:4a56 with SMTP id
 98e67ed59e1d1-36951ca8d1amr24903065a91.21.1779301360290; 
 Wed, 20 May 2026 11:22:40 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 37/64] target/arm: Implement FCVT,
 FCVTN (FP32 to FP8) for SME
Date: Wed, 20 May 2026 11:21:46 -0700
Message-ID: <20260520182213.872945-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 59 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  3 ++
 target/arm/tcg/sme.decode        |  3 ++
 4 files changed, 67 insertions(+)

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
index faa8df692e..8c999655ba 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -510,3 +510,62 @@ void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    ARMVectorReg scratch[4];
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
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
+    for (size_t i = 0; i < nelem; i++) {
+        for (size_t j = 0; j < 4; j++) {
+            d[H1(i + nelem * j)] = fcvt_f32_to_fp8(n[H4(i) + stride * j],
+                                                   output_fmt, ctx.scale,
+                                                   osc, &ctx.stat);
+        }
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
+void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *n2 = vn + sizeof(ARMVectorReg) * 2;
+    uint32_t *n3 = vn + sizeof(ARMVectorReg) * 3;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        float32 e2 = n2[H4(i)];
+        float32 e3 = n3[H4(i)];
+
+        d[H1(4 * i + 0)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 1)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 2)] = fcvt_f32_to_fp8(e2, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 3)] = fcvt_f32_to_fp8(e3, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
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


