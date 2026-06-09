Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3757CD98C8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX27B-00026L-3Y; Tue, 09 Jun 2026 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX220-0003d4-Un
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21p-00044q-Q3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c0bd02d97eso66979465ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032884; x=1781637684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lboo0C2JmHk88RK4dY8S0NhcoYqtPxPXM8Pg2zgFeUM=;
 b=zU19aPolb051OX0IHC7hapncdBqMJlXcilW91Kn24BXU89Hl5BJTOu2/RbEMhGr2GI
 HW+xHIxSkjuDg94n4Se3VCJnkGLNg1o2D6ETD1cAPZ1xhDB1qQAbpWiR4q9FwuDlnidr
 VQhiMHthzuEKxoUkCR5KyobnP27/ofy8aDBc5dAt/ClJnsJULhPYRn7WYzI+MkNjk+o4
 k4zF+D8qqC397xJ9yhP4L7FFl6bX91dc7GgZ0QTxqgQXWKKxx1EHZJnshssEBZj6Y4qj
 g2bQRHZwyzEHmNpmglja9o3iBkg+M2EkC656tZBPb3Ywx+7OT2jsAc/72kMPX7q6LdYz
 MBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032884; x=1781637684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lboo0C2JmHk88RK4dY8S0NhcoYqtPxPXM8Pg2zgFeUM=;
 b=Y+WP0JD5FSOP/dpbR1TdlRZwdXyelP8DPWreHWKq17YoSYydQ4SLk5+xLCsPt7Bh2w
 rUv+/9l7HkPw87fmvcuPjHHGgyxgeEpBoFlvhi4+QWKCxFwY7CxONv20ATzKkityElR2
 0hn6gfxeC/X1mb9poFFhEIEqlxYH0JeUcW9to8z+EGmOZy80oW+H8NQAls1Kln2wBRyG
 qILmlG8BqZ4SjadzkdhSCynut27jb4roJl/Sng/bkXs9/DjRGrWEz954OgCkgqs07QKu
 4YTH0SwAP8v1YzKAgJhOtBWFUYv0B2g0JYQzJAj+vdrxQLCk+5+8APDcW+oxgiGmOriK
 obKg==
X-Gm-Message-State: AOJu0YzQnB0BfZ5wLnBKejvaWL8uUBtWNNG4GRinnNq0FHVL/XBTVyTB
 1uaBxRjWvZLo0qTYdZEJ6SQvY2QJ7UYlA9oPSnL9l0Y+Bi8hJlxjMOTryeLXcq+8tkgV6W4WsTY
 A+QL6dZs=
X-Gm-Gg: Acq92OFGbleHDSxDdvHKbk+C/RIq/N6rzInVomsmcTTu/1SfOdKkq8QpyAcWgQ0STVW
 3xBh8ixIY2NbKMXkkHpMWblceheY7eBimHJDxwmB24+Kv3KJ2KmEsIO67jhVAUUQ0Leq47gGE4B
 IgogTcSWoC+H2l9PJ9Ph+uwA8buNB6gHYUxRpoj1V6v7vETKobVXYmzQhC8oDO4N8IPK+ZMxL1E
 C2OtLTnQGAOWJdIQ3XNtOueuYk1pGDh90XGvi7KMdfHgVrScAhjaEqbyTg2Pk4M4dZ3KeghUXPo
 k44X5GSvcWzTSLSgG2Pg5Ocn/SaJbob+MfXxCP4+12SDkprxfwACTjK3DXfxQjt7tIeFElrEcxv
 w675zFiLONY+U+BZJ4MNnnDKaxL2gSN21W+edSInpG7JG1FlCK2+J0YfI2qeneE+pApHR87RHS6
 iYPha58hevTYukaZpwim2fSeqVbqLYVyq+YeSoeeA=
X-Received: by 2002:a17:902:fc50:b0:2c1:6e2a:40b with SMTP id
 d9443c01a7336-2c1e80d2ae2mr243006105ad.2.1781032884251; 
 Tue, 09 Jun 2026 12:21:24 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 18/45] target/arm: Implement FCVTNB, FCVTNT for SVE
Date: Tue,  9 Jun 2026 12:20:42 -0700
Message-ID: <20260609192110.752384-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


