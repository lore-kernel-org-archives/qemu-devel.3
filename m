Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE7CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX25z-000738-Qw; Tue, 09 Jun 2026 15:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21v-0003aK-2b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21p-00044c-8W
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c0c2d792c8so40178005ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032884; x=1781637684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoKh6IursYqEAyOMk/XX4xNNJvsNskRUZIgXPcmISBc=;
 b=LD6/0xptYxZ5dkOMrjwdO1D7RAgRaoQ5qrp8D9WWzc18i8Sb6Bp8uv8bBng4kmg10o
 0E49N9P5tn9hRmYajSdPjC4HHQc8EKvg0UURfs4CjfkD9o7U+QYBeAe9Ed/5y5qYO/Wz
 hMIQy6Wanj/cyccV8nb9j3+RsernzgKoH1wVDXJuQXUqA1tCj6DSfptRS8SFBlKp4FDq
 MDs0i796bZXPfukB1M1bnT7aI5AqafksB9e8d+HvzRIqyRpUpDc5AgHyRERH+1VpT5F5
 2XqtlZTH5CoVjwiKgBZdoxy5GWxVTQBdd4aiZPsK8Ujg/w0oRMoffx/5vsFjmdhXfZkS
 aMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032884; x=1781637684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xoKh6IursYqEAyOMk/XX4xNNJvsNskRUZIgXPcmISBc=;
 b=dcmKVIpZU7qRH1jQC+6It/xQh78PLz5bGbF5kfYwDn6v5nuRwEdlS0xdioKnzEoNKH
 5jJhMKUFHxNITxq6mDn9QbNYjPq/qdrZqYQsoAb20V4w1hssRTiFHmTf3Xi/CfPNXOFO
 Gm2NnipBZcXbENW6onNyXMr+D+e0V/UUrfFoG1PWpYRUDHMLqHedeKHqnTdMe6Lumyh+
 g6qnFs4D97RyDoTZCCzGPHzRg1ABZv6WrdirhWCXFqUbO1d+EEqI92hTfWHerEKv7WaR
 OObBVhHVo52lA86CFxUNaaIqKymqB38J8NNitm6qD5tJFVIskK7tHmBI7ML9s4QneKZr
 MMGA==
X-Gm-Message-State: AOJu0YwUnibMVZO1oICbg7M3K/TBxXFkKepjdC3xlN7GrvsAk6m4u/z8
 TKgY+NTGdNLAyI17xGMlmm83v03R3MvtscbsIcQhNNDKhXTTRnnewLGCRuBII6HnSdex7dhYrrp
 AZ3FuRPo=
X-Gm-Gg: Acq92OG9vjN13ugoAmfGPLt4y9a4wwZd0ChTHK2izztpIr4lxs8RhqmpQu9MpXdY6P2
 GBlTbdYu5zPvaWbeUjOAQFvFD/lr89JZ485yQ8o+OigJt0sm1FUC3VEB+PdIH7fIs0nAerUvx8u
 vD5BCNblV8L8/VJZuEsVhYQuW4tkaXyWPj0xTvMmgCgH4iJus9dV8gHUlDoY8P3R6tjoQbDC23A
 XtHNJ2zeFzctd5qYhPiXgPQlSHhyLePGq6SY893gtkm5doIqaB3Ylj50AJeihX2dS90HYQ2Z3eu
 D78/tpbJ3rw/O6FozWw4OyB3pjn7v3IHlddSBVQwgxfhzoEHtTdQeTWJ6+zpmGDBDHx343KtPEF
 zsHfDH8Mo5VLDplRxduha7BZEhLFJ27k3ZzhLFI9sdkTHEDPcWtPQgALv9Vw8kELKlmKz3wjDh5
 4oxwcN7RBQRXAy1qJkVHM+VPGZZMi2kHsM9zfbuaE=
X-Received: by 2002:a17:902:d58f:b0:2bf:195d:21d2 with SMTP id
 d9443c01a7336-2c1e7e44e91mr256257695ad.16.1781032883535; 
 Tue, 09 Jun 2026 12:21:23 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 17/45] target/arm: Implement FCVTN (16- to 8-bit fp) for
 SVE
Date: Tue,  9 Jun 2026 12:20:41 -0700
Message-ID: <20260609192110.752384-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 23 +++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  2 ++
 target/arm/tcg/sve.decode        |  1 +
 4 files changed, 27 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 023a49e12f..e67fb191c2 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,5 +16,6 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0b86ed9eb9..8295725b83 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -414,6 +414,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
 
+void HELPER(sve2_fcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, true);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float16 e0 = n0[H2(i)];
+        float16 e1 = n1[H2(i)];
+        d[H1(2 * i + 0)] = fcvt_f16_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(2 * i + 1)] = fcvt_f16_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
 void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
                              CPUARMState *env, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6b2875a451..446fedb5b9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4100,6 +4100,8 @@ TRANS_FEAT_STREAMING_IF(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
 TRANS_FEAT_STREAMING_IF(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvt, true, true)
 
+TRANS_FEAT_STREAMING_IF(FCVTN, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
+                        do_f8cvt, a, gen_helper_sve2_fcvtn_bh, false, false)
 TRANS_FEAT_STREAMING_IF(BFCVTN, aa64_sme2_or_sve2_f8cvt, aa64_sme2,
                         do_f8cvt, a, gen_helper_sve2_bfcvtn_bh, false, false)
 
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index b6ef8ed8de..806953bc35 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1101,6 +1101,7 @@ BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
 BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
+FCVTN           01100101 00 001 010 001100 ....0 .....          @rd_rnx2 esz=1
 BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
 
 ### SVE FP Compare with Zero Group
-- 
2.43.0


