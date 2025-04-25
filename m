Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916EEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCB-0008A3-Jf; Fri, 25 Apr 2025 18:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAq-0003fh-Vh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAo-0001qC-6n
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso2732953b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618728; x=1746223528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peNf3lD5up4ecbGuzcgFP7NrI+tlYrmRWzI3nUSQeX4=;
 b=NMGO3Pt6+PEHyYUlgy3KtHPJ6DnONCb/jCf8J7in+wIBR7ZbEskAa09Ax+pFLv5Tyv
 fvFRoBls/oI9qow87M7Ked8rUQqlvo8IkGFV45hRJfxB7KFoq6d9hOUntIdkd61/srFV
 lGF7Guf1qdRjmq/BdX2CT2GLNlcL5B7gmiLQyy4hKsBtCFvqGHm02SVsHjfwf3NZH5NJ
 nakXkmzkmrGet1wR8FEc8BywVvVyAkxraSnzinwo7YWyVgav8SJAsisO0MoMlEqDkaWd
 G+svBbj2ZRyBMzP763OVIJsQBs9NK3bFYwZl1AbBd/e2AtTMIquTKhfSwdXexMEY96Qz
 gAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618728; x=1746223528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peNf3lD5up4ecbGuzcgFP7NrI+tlYrmRWzI3nUSQeX4=;
 b=sLEq/R+hgq18OJ8uBO0uC7HkzDqzJu9B4wod4E1gKyKmYkWyLBjiFnVxKO4GziEvU4
 7pjxMOcUCqL7gPlCXxe4k4ZA651Boxjl6+WWRP00mAyPEegfY4Vkt7W99yGKxHiVspc0
 NxM/zoPXsIbtGJvNjBIUB3fQlAwQ6zfVBg9ShfRIWxfOc0fNEaV4o1DnDg+Ky+3/pZ3A
 p0tGK/unEOVp13OR1sFwbjJdVEfNuvjmGEjGZxPvmeIbymNzvhG2SN5wFuHz9AMW4a0U
 M5dk93bw3xuy2vjwWnjjB3Sv7fL8aW0IPYZgBo/zf5U+5DOkgrB1jEE2ZvaTgTJkYLKP
 t2Xw==
X-Gm-Message-State: AOJu0YxpEDtfFlB9mVFkXD/RWuC0WkeQyNAznLQ9Kt+vA0JYkQVb3v9F
 5FEgbMd2nbs8g7FrMOr9QdztpP5+as59+bgWRpuWAoiset2DHzXxAN5gy6wOmuYpFYfc7/qmLwB
 B
X-Gm-Gg: ASbGncujP5rMe2rXTnd44Z2LgfJ6NXSO0O/dSlHlmyO+fhQzT26DHfQZrOWn7aho1Nc
 GLbPQSAW4yI2Sqp4OVdfa6DmnT/wXO5j1znQpcQ7F1au5Yaol7b4NL7YMN1j9bqwxg+wUSXYDfj
 ubE/6FoD4joslcYYt3n43ru5avrcctzlk3ZpFbI2eRm/rjZJEy+zCOwjiRPBnBFBaPyPVqBQT6m
 9OikO90C/VQx4b+NLop95xoca02X9tmnGk2sAtEtq0EHe77I89GRJn3YbK7/1hUMGoYfDzGGn9u
 03EAmhBx3zcnbwG4baeuHa4PkTtiKCB1fLbU/BasuJqxGpsljMt5hvJuxNPT5vbX/GvLLdESYcM
 =
X-Google-Smtp-Source: AGHT+IFoLHZb8lYyLHDA2b3ToQ8ZmRjZ6fDQuF3zmF9BmQ9vDrDMf1kyLIw2a6KGRYqhL2wbH33JIQ==
X-Received: by 2002:a05:6a00:9297:b0:73e:10ea:1196 with SMTP id
 d2e1a72fcca58-73ff72835f6mr1662430b3a.8.1745618728630; 
 Fri, 25 Apr 2025 15:05:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 126/159] tcg: Add tcg_gen_addcio_{i32,i64,tl}
Date: Fri, 25 Apr 2025 14:54:20 -0700
Message-ID: <20250425215454.886111-127-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Create a function for performing an add with carry-in
and producing carry out.  The carry-out result is boolean.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  4 ++
 include/tcg/tcg-op.h        |  2 +
 tcg/tcg-op.c                | 95 +++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 009e2778c5..b439bdb385 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -135,6 +135,8 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
+void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
+                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -238,6 +240,8 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
+void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
+                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index cded92a447..59d19755e6 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -253,6 +253,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_movcond_tl tcg_gen_movcond_i64
 #define tcg_gen_add2_tl tcg_gen_add2_i64
 #define tcg_gen_sub2_tl tcg_gen_sub2_i64
+#define tcg_gen_addcio_tl tcg_gen_addcio_i64
 #define tcg_gen_mulu2_tl tcg_gen_mulu2_i64
 #define tcg_gen_muls2_tl tcg_gen_muls2_i64
 #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i64
@@ -371,6 +372,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_movcond_tl tcg_gen_movcond_i32
 #define tcg_gen_add2_tl tcg_gen_add2_i32
 #define tcg_gen_sub2_tl tcg_gen_sub2_i32
+#define tcg_gen_addcio_tl tcg_gen_addcio_i32
 #define tcg_gen_mulu2_tl tcg_gen_mulu2_i32
 #define tcg_gen_muls2_tl tcg_gen_muls2_i32
 #define tcg_gen_mulsu2_tl tcg_gen_mulsu2_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 447b0ebacd..b0a29278ab 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1123,6 +1123,33 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     }
 }
 
+void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
+                        TCGv_i32 a, TCGv_i32 b, TCGv_i32 ci)
+{
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 zero = tcg_constant_i32(0);
+        TCGv_i32 mone = tcg_constant_i32(-1);
+
+        tcg_gen_op3_i32(INDEX_op_addco, t0, ci, mone);
+        tcg_gen_op3_i32(INDEX_op_addcio, r, a, b);
+        tcg_gen_op3_i32(INDEX_op_addci, co, zero, zero);
+        tcg_temp_free_i32(t0);
+    } else {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+
+        tcg_gen_add_i32(t0, a, b);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);
+        tcg_gen_add_i32(r, t0, ci);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
+        tcg_gen_or_i32(co, t0, t1);
+
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
+    }
+}
+
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -2868,6 +2895,74 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
     }
 }
 
+void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
+                        TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci)
+{
+    if (TCG_TARGET_REG_BITS == 64) {
+        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
+            TCGv_i64 discard = tcg_temp_ebb_new_i64();
+            TCGv_i64 zero = tcg_constant_i64(0);
+            TCGv_i64 mone = tcg_constant_i64(-1);
+
+            tcg_gen_op3_i64(INDEX_op_addco, discard, ci, mone);
+            tcg_gen_op3_i64(INDEX_op_addcio, r, a, b);
+            tcg_gen_op3_i64(INDEX_op_addci, co, zero, zero);
+            tcg_temp_free_i64(discard);
+        } else {
+            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+            TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+
+            tcg_gen_add_i64(t0, a, b);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
+            tcg_gen_add_i64(r, t0, ci);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
+            tcg_gen_or_i64(co, t0, t1);
+
+            tcg_temp_free_i64(t0);
+            tcg_temp_free_i64(t1);
+        }
+    } else {
+        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
+            TCGv_i32 discard = tcg_temp_ebb_new_i32();
+            TCGv_i32 zero = tcg_constant_i32(0);
+            TCGv_i32 mone = tcg_constant_i32(-1);
+
+            tcg_gen_op3_i32(INDEX_op_addco, discard, TCGV_LOW(ci), mone);
+            tcg_gen_op3_i32(INDEX_op_addcio, discard, TCGV_HIGH(ci), mone);
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(r),
+                            TCGV_LOW(a), TCGV_LOW(b));
+            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(r),
+                            TCGV_HIGH(a), TCGV_HIGH(b));
+            tcg_gen_op3_i32(INDEX_op_addci, TCGV_LOW(co), zero, zero);
+            tcg_temp_free_i32(discard);
+        } else {
+            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+            TCGv_i32 c0 = tcg_temp_ebb_new_i32();
+            TCGv_i32 c1 = tcg_temp_ebb_new_i32();
+
+            tcg_gen_or_i32(c1, TCGV_LOW(ci), TCGV_HIGH(ci));
+            tcg_gen_setcondi_i32(TCG_COND_NE, c1, c1, 0);
+
+            tcg_gen_add_i32(t0, TCGV_LOW(a), TCGV_LOW(b));
+            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_LOW(a));
+            tcg_gen_add_i32(TCGV_LOW(r), t0, c1);
+            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_LOW(r), c1);
+            tcg_gen_or_i32(c1, c1, c0);
+
+            tcg_gen_add_i32(t0, TCGV_HIGH(a), TCGV_HIGH(b));
+            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_HIGH(a));
+            tcg_gen_add_i32(TCGV_HIGH(r), t0, c1);
+            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_HIGH(r), c1);
+            tcg_gen_or_i32(TCGV_LOW(co), c0, c1);
+
+            tcg_temp_free_i32(t0);
+            tcg_temp_free_i32(c0);
+            tcg_temp_free_i32(c1);
+        }
+        tcg_gen_movi_i32(TCGV_HIGH(co), 0);
+    }
+}
+
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.43.0


