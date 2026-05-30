Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9FACD6E4C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrN-0000Bs-Q9; Sat, 30 May 2026 19:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrJ-00008a-PW
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrH-0007W9-Qp
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:49 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-36b7b7b7a80so1479482a91.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182766; x=1780787566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gFw1Ev95FpbZU9VWkw0gz30Ij2Ve1FFHR5p004lk4A=;
 b=OHSqnjc3wXCnAXcQ6NlMT3awYT967qQlhviudLAGaeULLvkTPVoGMqdjy2nNwvlnAa
 RbtJ5bRH8o1Fpctu7wkbi04Zvyeiy/0NiCzZvUiMxIA2dkscHOAvm7WO8UoSEP8uvxj+
 C+6jUWe9g6NxCQ3XO/jkMi+oM8WpYJ/MWeTbRNeH4RkwQmNUVarCyhVRjhPZB6Zjoq+t
 zQJwPE/HhdNeUdJYz8KXD3XBoN0GC7BoBY9UEmvLR/0i0mm8P3U+Zl+vfMYcf6V/RPj0
 bsQaXvTXToXTJo4GVEN1jx3DVUuiTh7nbObZMhOcINoctC48vlqKpCZYWXWSvDf4xLAP
 k6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182766; x=1780787566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5gFw1Ev95FpbZU9VWkw0gz30Ij2Ve1FFHR5p004lk4A=;
 b=LLzjL3g4h5IdvlAKGVT3FY/34ZaY1SlVeUrqwnoIzRsUqpc/IWPGQ4gQVLVvgkZDaJ
 520OtJpyps7UV/nwWGa1QiDqTyY3DaMkR+3ZsGBpGRqcfgqM13NL4h/Yl3FvU/ejEw3i
 V5B+aOWNzQSQ06YHiWAkTheRtDWR/s34dgAnOYOYKlI1T0P8ZQtYCaH4p7hkQqr/HnEK
 EJe1KWUbk1mLl0ihUDZCWTqyJybif6b/f51r/atxPCeXRHFrUG27Dz+ZC2B46tD83zwu
 9gZ8yJMPpe0OcI/mdtcBxOZ1kitEja2JbxcoxrmovVsHf+/vh/dQERCP8IFi9GRmlGPO
 5/EQ==
X-Gm-Message-State: AOJu0Yxj9Q8971dBZ1T1OfwMWGgug3D+KORF7tKzOwEpto8gc9vgsSsx
 aFIejS7HoFgtf6lf8lT9zrYXWCNpqzmLAB6rVN3XBbUF0b1rttWjrFCGjqBFXp9722RalEqFF+l
 RxgBRZ+g=
X-Gm-Gg: Acq92OFR0R3TEs/xZfmmAJg/1BWRLJtMDnK5OMBjE08j71BgJoCVaDSXDqJGptu9fxa
 wsMbuvRaDVd/T4VwgP4cYPgu7twpDegjgEiEB0wKxQ5KM4Qb9F8brkmy4YmsyWBHx81QTDbf6J8
 BgTccfyjvIizjs3D5LLOtxYwAbA6yLoZT6lEyQ5/3qSd/31NPWHjXcUBWQMdqvH9kNc9DULBKex
 U+GwpqPo8FdnN9RgsD6xrOq957i93t7hsssVrKlDBwobFXR2eFZKNnFGXNRBjBV1hWJkeYrLvWY
 QPj6gQh+smiX7VoF1vkYBJ1b2n6ZAHTuqscm4vboSM7lY82PTEtls9UT893hjwqomf3wi40drTy
 wdpUfH5TjbpWvmumzAHiye9oHTWzHazkD7yR3YtnVHxQ88RVqAIS6qc/uCTn0izBTtOyUdaBQZ3
 PCFHchGs0UaAM/wB45n+cy2X+MFd8aknxnppK6BwU=
X-Received: by 2002:a17:903:2452:b0:2b2:ec33:cf15 with SMTP id
 d9443c01a7336-2bf2048bfc7mr86587825ad.7.1780182766394; 
 Sat, 30 May 2026 16:12:46 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 14/41] target/arm: Implement FCVTNB, FCVTNT for SVE
Date: Sat, 30 May 2026 16:12:02 -0700
Message-ID: <20260530231229.400441-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/arm/tcg/fp8_helper.c      | 47 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  4 +++
 target/arm/tcg/sve.decode        |  2 ++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index e67fb191c2..5863a6dbb8 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -19,3 +19,5 @@ DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
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
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 4ae1d2a75a..31e120af68 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4104,6 +4104,10 @@ TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
            a, gen_helper_sve2_bfcvtn_bh, false, false)
+TRANS_FEAT(FCVTNB, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnb_bs, false, false)
+TRANS_FEAT(FCVTNT, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_fcvtnt_bs, false, false)
 
 /*
  *** SVE Floating Point Compare with Zero Group
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
 
-- 
2.43.0


