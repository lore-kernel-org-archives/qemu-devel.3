Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941C3CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2W-0001an-A7; Fri, 22 May 2026 18:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1W-0006sL-21
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:19 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1L-0002tc-Qx
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:14 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so80343505ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487625; x=1780092425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BN3YrxBeYnKrLp4dE6hJz3KYuErqD7i23aJarhXNf4=;
 b=iKOr4c8gYPnf+hCqiQaWYwtEv53F520hdyhNySzgFhfrVypyj8eVwd9cEulz4yUWiV
 EvFm78TT9tWxr6dRd1HcjzECQj4+W0NbEREFec/hYVZCtS6PPbWPyhoXPyAsexZAdumb
 NamKdv7NmGmRmIYuvAATRdc/lw3fo1ySeKhzaQgOtJoGbVcg10xF8CY7ujskDovzgnZZ
 zBXIAgSq6otu2XlK1E6sPtFj5CG7M6PoUQmyUuhUNmvh9BxDPc8qW8DLXNS1BMYF5rn0
 prgKfKXycVBwvI49CaHJBepK4G4TlmvtXclnf9BJ0EoSWgjeoyFPDLM3iRnJqkuRy+Yj
 1kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487625; x=1780092425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1BN3YrxBeYnKrLp4dE6hJz3KYuErqD7i23aJarhXNf4=;
 b=Qet0n4IpEr8aovp9TRzzwngbuJsbRdOJ6LKDJIZ4WWdxfS7evpy7Jf6j+Vek41jIT6
 1cPpe+c3bJIIuUGynjHdme8ze956wbKsWqcHJXblKtjK+TBPI1BkGPu1p+cKglF7l54S
 HcXXe9PfdlkpNk7rrqhoPrW3/Gwm6p1TYVjDPKhgvXPeKMNHbqtIzzCM5jGl1ghjFpJW
 foau+12GTST13VbEzoc9yBnO+BQiYcLNu8cXkwasE1ged6e6+PHX61UMpWavyF3UJsEF
 2N4Wc0HkBkYryrQLL8hfE2aWGAtLvQ9f9baJ+KyPvKCjbETKLlUF/BhU12mUi0otbAF6
 eF7g==
X-Gm-Message-State: AOJu0Yz9I981OFKeetqkSvkosqcOMu7D9Mv1paRdXp5Nnkduho3tVrS3
 jD0yFKnllEAMS6aNUXMxMhTw/sEl1ttcpflINoRldkwA6ZMFWonIVSa0q2f/NNpxvT0h7UW0qWw
 Y2FLt
X-Gm-Gg: Acq92OEge85epCu8Qw+s/qCK7RohOha0tanngSDrJGyKFPgmHpBR6/hpPEF4oA1C1XY
 uk/z6Qt6fLeVcyv9x/avlwrONK6SUPMYPK9aD3sD70/UsCMsQ0/8Dgbn2mywAzb26zlN18IIkRe
 t17+lX3od+qmazkYL5uE4oqlRduNw2LMKzSD92UFnAPgK7vgPakyzqYYVjgBOaSGM8o6OmUy+Vu
 vyX0zlGjDPzgjm5FcJdU8EdJj3M6FDKSq/45iXK14VjELw074jEk7jIBJRb05PZ8Q9rnIKhX0oD
 g8R5IvZj6XwdHvmfJIiR9mI2JEpA9vxqgMNBrsL/VKNgrDrNoY8AS54TJ8gqz2/mRWWm+DxRN0e
 F81XsKX7zrOJ1W5rKIzbrvS2mRJe0toF4j0aFoJUlsTZfzEA/WqRCrmZ32JMCmo20swURclxh/e
 QGWxtWoQebm5dwhAgTLOkl/UMerw64
X-Received: by 2002:a17:903:1ac3:b0:2bc:7d1d:b677 with SMTP id
 d9443c01a7336-2beb065f97fmr60171355ad.36.1779487625385; 
 Fri, 22 May 2026 15:07:05 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:07:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 62/64] target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
Date: Fri, 22 May 2026 15:03:04 -0700
Message-ID: <20260522220306.235200-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  1 +
 5 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8f6cc2974f..fce38dfbb0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1625,6 +1625,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
 }
 
+static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 3c74f02022..e942308af4 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 9db4ff4c2f..8365da9893 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -831,3 +831,28 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, 0xf);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 8;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[H4(0)], m[H4(0)], 4, d[H2(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[H4(0)], m[H4(1)], 4, d[H2(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[H4(1)], m[H4(0)], 4, d[H2(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[H4(1)], m[H4(1)], 4, d[H2(3)], &ctx);
+
+        d[H2(0)] = d0;
+        d[H2(1)] = d1;
+        d[H2(2)] = d2;
+        d[H2(3)] = d3;
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c62fd6f4c3..5523ac03b2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7416,6 +7416,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
 TRANS_FEAT(FDOT_sb_v, aa64_f8dp4, do_f8dot, a, gen_helper_gvec_fdot_sb)
 TRANS_FEAT(FDOT_hb_v, aa64_f8dp2, do_f8dot, a, gen_helper_gvec_fdot_hb)
 TRANS_FEAT(FMMLA_sb, aa64_f8mm8, do_f8dot, a, gen_helper_gvec_fmmla_sb)
+TRANS_FEAT(FMMLA_hb, aa64_f8mm4, do_f8dot, a, gen_helper_gvec_fmmla_hb)
 
 static bool do_f8dot_idx(DisasContext *s, arg_qrrx_e *a,
                          gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6404c26540..e7f2f30abb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1217,6 +1217,7 @@ FDOT_sb_v       0.00 1110 000 ..... 11111 1 ..... ..... @qrrr_s
 FDOT_hb_v       0.00 1110 010 ..... 11111 1 ..... ..... @qrrr_h
 
 FMMLA_sb        0110 1110 100 ..... 11101 1 ..... ..... @rrr_q1e0
+FMMLA_hb        0110 1110 000 ..... 11101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


