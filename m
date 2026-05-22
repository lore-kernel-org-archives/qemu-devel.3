Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7652DCD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY0Y-0004RG-IG; Fri, 22 May 2026 18:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXyA-0007qA-0I
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:55 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXy5-0008Q8-Jt
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:48 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3698e34a567so6988331a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487423; x=1780092223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INPKxCo/13lsupH8RTnZ2qnDLqr9desj6G1cjc0ZHGs=;
 b=mDldSN1t0xCXqzvoElC3lFi3axCbwEJVfKtx6a7bf+f2F5uAhx+dBAO+uXLm+zraA4
 Wzro+2txoCEpYr2Q4P66m/lRHl8f4tLG5pI8iHjZObMw78VsrG+qjcDJmpzPdSP+eUaD
 xlo3JFq3k5jxVk2v2Mk1/T2zfKJQnI80MkiBCXAwKfCGtTocxEYQk2KEsZbmMgJHhu8Z
 AVO0TDn19IxNJH+5v+Bl3+llMvsZBvqH1/VI7h8rUCUDVWgwloA5JyGFIM3OaQ53METj
 1qx0RXMuxl0Mg+EATY1wJ5awuNRLwyG+p8hWytvfJgBhpkYkPdZqafoCLNzdZzKNDts/
 P1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487423; x=1780092223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=INPKxCo/13lsupH8RTnZ2qnDLqr9desj6G1cjc0ZHGs=;
 b=XhhUcJskKywGYDE/e4Be+F+sbAnOOqscdTqcrLOp0dO7/YI3ZBmqdLqfBN74vQgcEs
 OMUS2wOSw1+cZRbYt2LFxavGxEYVziTZsGbaUWA8cDc0eJPmlHCOgqukjQ670XBZqnyb
 cFas4x0JUqo72N7F127IjvuFAUkHdPiWBUAPiTVNZowXPeSfSx10qqUzf83OymW3LF2n
 +AxBwHjTPoZOGJzUOjQzHE9PLLTdl8gH0xodpx4FKtTRc60QIeUabBhsrt/u/ZO8EKnb
 UU1Lpt5s4t2ZaFmShL9Wi5nwXW3QIydoeEKYwLkXkL5CQ1TnrHioNaCRr+j2UaQ8Eudo
 VrMg==
X-Gm-Message-State: AOJu0YxsXcXvYEGsdiPaRbQPSc8AA9LvJXQBildPlx2eIUuJ5181vXkO
 S9JzEFTv5DaWjlUtoKwftUqDOxdvJVC/0HLJ6AOQUSx5jSDXN0lsbtYq3JCzUKygLgsLEm2rNBM
 jBPpn
X-Gm-Gg: Acq92OGQbTyAygN7z4gJK8baAPuzupyft3TWnl/H8n+YpE0eayUcd4BgCKSWVg9NmHc
 K2Xa0WYZmTGZBbKdZzAVSmIdEPxaXxmqa6YYL4pOPTTp1RA4VBVFb1UwQh7jbJG07PGa4ScNurd
 msbwq8kZyy+gwKGKIcRfRe/kmOP3/XQhUz2G6b04N+6J/Md5r34yyRXzSW/mSke7aVdXILWPvsv
 s1VYAQ1M4HhdIJQb4VXGKLTp0jqf6ASsWda0Cv+/cLZSDwVDAEYoSXb569vJ/UvV+JTj04P3ZAc
 zC+vOcmIcUwN3YleYxNrPU3rfmCiEyfwEz5FAPgMb591y7GKIlkYcZrOs9PHeS+ZJRX8GfvNclV
 Fl7nyaSGW1GFC0aldU6QmDMy8R9CB6FjcrtWFqhzSCVrb/y9Rah/UsF/z4Fz+kDGmvVr98lzy9J
 3EoA8P7l7PiOBU+Lyx3JtELkQ7jrKEqHIMOJA38HoNuzQNThCgnA==
X-Received: by 2002:a17:90b:2586:b0:368:f0d0:1ce8 with SMTP id
 98e67ed59e1d1-36a6770aa6bmr5096780a91.9.1779487423326; 
 Fri, 22 May 2026 15:03:43 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 37/64] target/arm: Implement FCVTNB, FCVTNT for SVE
Date: Fri, 22 May 2026 15:02:39 -0700
Message-ID: <20260522220306.235200-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
index da46976cc6..a339ffe454 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4103,6 +4103,10 @@ TRANS_FEAT(FCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
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


