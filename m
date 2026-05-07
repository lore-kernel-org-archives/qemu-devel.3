Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6165ECD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SG-0008Jg-QB; Thu, 07 May 2026 19:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8S2-0007Ug-HU
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:19 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ry-0002BR-Aj
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:18 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-435153d9b68so867196fac.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197692; x=1778802492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/106JkrzJFzFnqkxxfcW/t8wbw54ekNHS0lrjPbUE/s=;
 b=PjLQ47E+EwUwLcoz3AQdPSisNNPq/Y80z0l93jKQF5MgNjuE0M9BiqF+LFuUC5mSEn
 lK2QjXm8sVOPNuGKDCO0wBu2J5a/ZGkoPH+sZlmrAU/UPsjEEElyn5KOxSsZNAlJyoEa
 orXOJehNknyZ/66ZhBRGUqTeZV+2RnqtFGq9gLDnqjUS7DHosOWTPJU1XnE4MmqEAh6Y
 p8BzA29hzrSGSEmRkJ09h2jkN3yBTcxdUAR69SOjuR9B7ir5E6AgLCo3M1iTrj7ep+J5
 /iEjT59akTX6iiHLVrz7VdYDywYenw/WZODXJ1obM6qVbzv63jbjvM2EnWm7xiOI/wrd
 yeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197692; x=1778802492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/106JkrzJFzFnqkxxfcW/t8wbw54ekNHS0lrjPbUE/s=;
 b=D1/ddCF55Z61d4YHpuo7h8GuFjsFIwvB2QMAjFUm4Q0u2BYMtnM0i3RM+r2JDXUWgV
 kn6dFOZpniS1FcGEB/IrwsOSTEW9L6rxklfMpL+zrcN0nytv2ET6cOF/o1GFn3Iq3Dff
 TCF40UrKNb+3aidBh7I43V+MMHssA5UeB11cHi0LI0daHMDonj99r1aDC+saZnuiEYAP
 aYVF9Zksu1xoN/pp9Grh+pWpCQP3i1JsweNuiMsPMNcyToQY3L7ucIZq5eKFrqP79UNr
 8aUeXuBS3+vRzJnyPtUPWtvebVWJyl/IoU6ZlCLRObuMEFNXKwa0cIo/Yzqi+63bq0ji
 qigQ==
X-Gm-Message-State: AOJu0Yy/Hns/wUA+WurplSvvT7t3ZtBrt34oCdUdZpGtnkGCUoMBUcse
 ws7z0axOTgh6XsZnwIMf6FQDwg4GFhoStp2dnFp4ypSLS+gYYfAinw2zJiofzBZVvEO0eCZYJgF
 t+LOS
X-Gm-Gg: Acq92OET/HZ2RNCJ7U0CxrL/n5uIJg7pAfEbn8xq1eQY1QR8AzFgR7DjrqneqL26uDk
 M6bmvnQJ7qZKEB9R8kJtkQJ6+n4O2sVXsfBfbZCBtOWr5Y9Z08HDlk0x+GCfPHUPei0gwTNIfco
 DXMemYCHxxEQB8p4ul08SPa2gMFNjZdmgxLnin5+D2aJ96xY+ge67aHE8FLkvgyp3oIP6zgyWlJ
 bmI5kD1Uy7vEfra2/+UYlHZWnHKwgx3a2ylatfY2NmOnbOuzG01oniO+H0FJPvIdhjd6VaVhmGC
 MzyBSA+qXVHttKQt0SE0FQuPERh6/pbvvQu55sxs9Tz+4ZdJjx9vHaElwTO2zvL6dEbY7/blrxQ
 hrvYCXNUG2kiGw/qhh4s1AWB0eBtkbHrEjPwjvjdayGT3Tjc9bNuKWY+/cI3cMIJGy670mnZkCl
 GemNkygSeiId8Qon5PUL+tcamaqPc3cobtFL8nfGOtxMWm2g==
X-Received: by 2002:a05:6870:9c8d:b0:42c:1b45:e8c3 with SMTP id
 586e51a60fabf-434f65b2ffdmr6226731fac.33.1778197692412; 
 Thu, 07 May 2026 16:48:12 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 58/60] target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
Date: Thu,  7 May 2026 18:44:11 -0500
Message-ID: <20260507234413.643512-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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
 target/arm/tcg/fp8_helper.c      | 26 ++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  1 +
 target/arm/tcg/a64.decode        |  1 +
 5 files changed, 34 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 0aaf08eba9..41066ec5f7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1619,6 +1619,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
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
index c90b276913..c40e026aea 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -839,3 +839,29 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
     fp8_mul_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
+                           CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nseg = oprsz / 16;
+    uint32_t *n = vn;
+    uint32_t *m = vm;
+    float16 *d = vd;
+
+    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
+        float16 d0 = f8dotadd_h(n[0], m[0], 4, d[H4(0)], &ctx);
+        float16 d1 = f8dotadd_h(n[0], m[1], 4, d[H4(1)], &ctx);
+        float16 d2 = f8dotadd_h(n[1], m[0], 4, d[H4(2)], &ctx);
+        float16 d3 = f8dotadd_h(n[1], m[1], 4, d[H4(3)], &ctx);
+
+        d[H4(0)] = d0;
+        d[H4(1)] = d1;
+        d[H4(2)] = d2;
+        d[H4(3)] = d3;
+    }
+
+    fp8_mul_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 02d5e007f9..aff0f332ac 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7419,6 +7419,7 @@ static bool do_f8dot(DisasContext *s, arg_qrrr_e *a,
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


