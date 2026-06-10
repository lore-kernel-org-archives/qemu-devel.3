Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092ECCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYE-0001yI-Cr; Wed, 10 Jun 2026 12:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYB-0001te-W1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYA-0005p3-19
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:07 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45ef779c1c2so4816015f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107984; x=1781712784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=96gfwOgDQ7TQX2Cy0IGMrZVt/LAFVcWaE2Pfi7hy+Yc=;
 b=lQrX3+6vnlJeycEkNBFXNHdiBbl2T1/zeHx+PdMI9BHOtMfpj10tCNIjDcnouaG2OO
 1/NF5Z6z3P8cINe23rz7JjXYOwcDDHUseSYj518jvwhGofdOZqnu+M0dk17hfEFu8mxQ
 rHQMLR1Nucxw1JbsaclaewvkJBFRhdL34iig5kxA77qf0+fnpUBYa6AVd3aBF7eEq6bo
 /R/mTuzHYxFQ1A1A6QW9h0wOCOgqs+l72NvJeI9sYnpuLDylugOuxBsQ7sZvaHq2f0UG
 rdDeUFpx9dXHp7p9NljeS2f1SxKvy2yt/FqF5Cvy0mnJTzpq+5dHyqRJCfRRLPNeTf9S
 kW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107984; x=1781712784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=96gfwOgDQ7TQX2Cy0IGMrZVt/LAFVcWaE2Pfi7hy+Yc=;
 b=mVwghliFQRKwbZF62pa2WFpweGL+sXGuXJ4Zgb9HxjdY961LBpHZkNYeqOBxa85iUp
 /lLaKScQoI2mPBDWyZnEesFyf2NXYyzTiK/rxDxba5D2UDcRPDI14Ryj47zJzS3LMGrm
 pmQI0O599QDu6ZM4OnxYmuVF5+ABBxWxeFFZJsAv5cr5hOqvf5Qgi2OjH5q4w6Fs+hk3
 jLLvqzJjntH/T5lmcbVg0GvxXTFcGLFLVtPe0f7Q0PbOoIuZufkubuVexTahc8oGm1A2
 IPybQQDpw1VSXwMdy1EQkF/1QvyiEv2MWBjxw/IvZzYoFMkfG8ZM7p3nxdff01lrAfkp
 Zo8g==
X-Gm-Message-State: AOJu0YwJC0r9ShM4LEfau2o4NlfmZJUYYRpudZg1Bh7KmuL1ewqRN0yC
 tycyvFbAtM9okqJ22GSYH7MyFR8LsFXmendLWHtGnVQP8KLuuXqcTbh0xs9lebd9CYH5eR4OO1I
 Sajsp
X-Gm-Gg: Acq92OGUMb21f5VTNb6rEn+omagI3vqwBUHufOwWB+dkknPJhKKS2Ay/Vsbr3UUasTy
 UYmX2+R/0xXu9L4fzPzv9N7mRWT/zvLUEGhgrMrH4+r8sbtf+a1d9IypYoxUyg652+Y/mk8Uk25
 MDN+8VF6SN5yPjqnxP4rY0f1Nib3NAfno13kydL7IOKPXV+AC+j7ruYAqPv204L72a8HvBjsjm7
 +KIx0YU6EG5taLglBsr/iNuf0uf9wJhLQg/ynlGIm2qSLlfE5+4WXqDmZmqy94R5ys8JsavzrPT
 V2r3WMd+OYTUiuiN7bdpfPmsA3EP+PTo9ibk27eH5ZLdy29fOCE/EDK+eE0mSDm1IgDx4tuyntO
 mcBvXjbfriFx9Eyj5+uIK3SWc4N/R0MSefjgSAXc+XFayiIySuBs3I/gyb8sBodTi/KLL0xhh7R
 7aObsshiVaPICFD1oFk8JoLwVjsh8zBGT61kMWlHvbEVEll4CCAuV9e6KEzAqly8dgI68zlJfHK
 Idso3HyAG0GBRG1rD0G4LCFYVilWrXAY2IwdQMoPJT2qKqRRz9/Qw==
X-Received: by 2002:a05:6000:c41:b0:455:70bc:216d with SMTP id
 ffacd0b85a97d-460304fc121mr29667660f8f.12.1781107984491; 
 Wed, 10 Jun 2026 09:13:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/71] target/arm: Implement FCVTNB, FCVTNT for SVE
Date: Wed, 10 Jun 2026 17:11:35 +0100
Message-ID: <20260610161202.2235298-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/fp8_helper.c      | 47 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/sve.decode        |  2 ++
 target/arm/tcg/translate-sve.c   |  4 +++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 8295725b83..3bd57ff350 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -462,3 +462,50 @@ void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
     fp8_cvt_finish(env, &ctx);
     clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
 }
+
+void HELPER(sve2_fcvtnb_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint16_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        /* Zero-extend uint8_t to clear the odd lanes. */
+        d[H2(2 * i + 0)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H2(2 * i + 1)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
+void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        d[H1(4 * i + 1)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 3)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index e67fb191c2..5863a6dbb8 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -19,3 +19,5 @@ DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 806953bc35..72755b27af 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1103,6 +1103,8 @@ BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
 FCVTN           01100101 00 001 010 001100 ....0 .....          @rd_rnx2 esz=1
 BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
+FCVTNB          01100101 00 001 010 001101 ....0 .....          @rd_rnx2 esz=2
+FCVTNT          01100101 00 001 010 001111 ....0 .....          @rd_rnx2 esz=2
 
 ### SVE FP Compare with Zero Group
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 446fedb5b9..065f16d899 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4104,6 +4104,10 @@ TRANS_FEAT_STREAMING_IF(FCVTN, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT_STREAMING_IF(BFCVTN, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvtn_bh, false, false)
+TRANS_FEAT_STREAMING_IF(FCVTNB, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvtnb_bs, false, false)
+TRANS_FEAT_STREAMING_IF(FCVTNT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvtnt_bs, false, false)
 
 /*
  *** SVE Floating Point Compare with Zero Group
-- 
2.43.0


