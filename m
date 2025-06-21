Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17D0C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82t-0003tS-4X; Sat, 21 Jun 2025 19:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82b-000384-Vp
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82W-0005DZ-TA
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:33 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so2273509b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550067; x=1751154867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iK5l92DV0hldwJwu9EwpC3QRZ5y+C0O71jPdT0q2JeA=;
 b=gsvX0Hu43D7IXOajASHFjZJLg6WtPZBmkcJgpNRvzIKCMUZsY69ab+adkz3rsgvElz
 xTPnC0sC329foobKnr0knWLAZECcRT/6mWPY8mXXiiD40cD1xI4DAdSHbToHIoEUrlOP
 5JNnvYnVcjh9Df1TjFX9Jbsq6rj3aWBm/7sOGbsJk6+Ny1fWozQxxRih6lv45XasI3Ar
 GDIwkh3qCwe4XVwaNn0TgRyU9XkfmXDwbbvlDD8KScbHAR7apub84GGhkkJuRfu0E4yw
 hxhXDK3AoCG5PICvUPMljpH04tZb0vYKeWy6LtkdD/7Bn1NvmRMIfNXc+HsznlpMTn0F
 B6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550067; x=1751154867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iK5l92DV0hldwJwu9EwpC3QRZ5y+C0O71jPdT0q2JeA=;
 b=cHhpsThRmWnjYf1MeA2cFvSPA5sCVPHn1U8x1sOgYiDpNrXPTeIAEX0ihsU4iAO2vh
 ivPoDBr76QkM8T9/vp6/WYY5QXQvE/HHvBsS5Eq9ZqapwQNN4ZD7MgZL/xIFggzsWWVq
 KnLgQyAW6dQl7BkRazGC6LsWzEgBNJVTE5TYBP6H0yo97T22DIrKEpQYDqd0uirxdFCT
 ul0b4wBH0JtR5CO1B041LuSBr6loKi0VNu2lxJNuBcKNCYZQFekNJaOfmbj35gEVI92D
 NEc7urP8yxZlU2e3z/1Y8stlhY0hVvLpwkd1RYi5o3X3UEbCPJQ3z5JJu7zZIf9Z67Rp
 bTKA==
X-Gm-Message-State: AOJu0YxY9R6VHjEgMEdzCJxFg2GZV6mKNdMXQpyxt7LtLEy2fz/a4h4F
 roTgVKMUEMqvkAiM/2hsPR5QcnFug0JafUTAGtiQJZfgK1yxvTjhBQQK0XC+zc5tjP+7AFT00KY
 rMK1GWIo=
X-Gm-Gg: ASbGncsKNqK2sgVlqIvPNvtBFIOmRlXn7g6BnjO0tTMKWBImPAq/3bwMNo3Es6t3iAu
 4nWhPqv1hcNd0sslYMtukm7PDDaxwFPqeotEVs9VddwP+R38Vd/hlM1lrz+fwuIU+ljgNmZ/Am8
 2Y1d44WMEjs4JvXB6mQOGCIS/2heD4XGNOl3mHegMca9xnTB+Pdm+sN0xq0ksqWbxEn0CwP79oU
 pz+WvHfJxRJ2gkPPUwwVFYUATUfuSdp7gh4RoBGPuIlPaxGWMKLEuVg1XK4AIgkFgLYzzUOoBC+
 XB8Ig5Dd+G6LXMVNXaR8R64+lzC1d+hCL+FEq2s5ocC/kFTb9p5h49LJyNPCmDF+SitAmAAv7ND
 Cl7NC5pWPa5J1kNBHHUAK+k6gnu9kI4U=
X-Google-Smtp-Source: AGHT+IGqmZZ2wwVHrt+uaBCskHfgqrIGg8uzTi1ppoOBJ8xiuaQoW9NT27vGyVcR+sp/QoYQmTXZAw==
X-Received: by 2002:a05:6a00:8783:b0:746:1c67:f6cb with SMTP id
 d2e1a72fcca58-7490f4bebdbmr8627578b3a.5.1750550067340; 
 Sat, 21 Jun 2025 16:54:27 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 076/101] target/arm: Implement SVE2p1 WHILE (predicate pair)
Date: Sat, 21 Jun 2025 16:50:12 -0700
Message-ID: <20250621235037.74091-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  3 +++
 target/arm/tcg/sve_helper.c    | 44 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 14 +++++++----
 target/arm/tcg/sve.decode      |  8 +++++++
 4 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 0b1b588783..eac23e75b9 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -941,6 +941,9 @@ DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 
+DEF_HELPER_FLAGS_3(sve_while2l, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+DEF_HELPER_FLAGS_3(sve_while2g, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
+
 DEF_HELPER_FLAGS_4(sve_subri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_subri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(sve_subri_s, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index dbb88e9a39..2beb012292 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4157,6 +4157,28 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, false);
 }
 
+uint32_t HELPER(sve_while2l)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+
+    do_zero(&d[0], oprsz);
+    do_zero(&d[1], oprsz);
+
+    count <<= esz;
+    if (count <= oprbits) {
+        do_whilel(d[0].p, esz_mask, count, oprbits);
+    } else {
+        do_whilel(d[0].p, esz_mask, oprbits, oprbits);
+        do_whilel(d[1].p, esz_mask, count - oprbits, oprbits);
+    }
+
+    return pred_count_test(2 * oprbits, count, false);
+}
+
 static void do_whileg(uint64_t *d, uint64_t esz_mask,
                       uint32_t count, uint32_t oprbits)
 {
@@ -4190,6 +4212,28 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, true);
 }
 
+uint32_t HELPER(sve_while2g)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+
+    do_zero(&d[0], oprsz);
+    do_zero(&d[1], oprsz);
+
+    count <<= esz;
+    if (count <= oprbits) {
+        do_whileg(d[0].p, esz_mask, count, oprbits);
+    } else {
+        do_whileg(d[0].p, esz_mask, oprbits, oprbits);
+        do_whileg(d[1].p, esz_mask, count - oprbits, oprbits);
+    }
+
+    return pred_count_test(2 * oprbits, count, true);
+}
+
 /* Recursive reduction on a function;
  * C.f. the ARM ARM function ReducePredicated.
  *
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9a6fa8ee8a..c2a5b2f76f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3092,7 +3092,8 @@ static bool trans_CTERM(DisasContext *s, arg_CTERM *a)
 }
 
 typedef void gen_while_fn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
-static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
+static bool do_WHILE(DisasContext *s, arg_while *a,
+                     bool lt, int scale, gen_while_fn *fn)
 {
     TCGv_i64 op0, op1, t0, t1, tmax;
     TCGv_i32 t2;
@@ -3147,7 +3148,7 @@ static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
         }
     }
 
-    tmax = tcg_constant_i64(vsz >> a->esz);
+    tmax = tcg_constant_i64((vsz << scale) >> a->esz);
     if (eq) {
         /* Equality means one more iteration.  */
         tcg_gen_addi_i64(t0, t0, 1);
@@ -3188,8 +3189,13 @@ static bool do_WHILE(DisasContext *s, arg_while *a, bool lt, gen_while_fn *fn)
     return true;
 }
 
-TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE, a, true, gen_helper_sve_whilel)
-TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE, a, false, gen_helper_sve_whileg)
+TRANS_FEAT(WHILE_lt, aa64_sve, do_WHILE, a, true, 0, gen_helper_sve_whilel)
+TRANS_FEAT(WHILE_gt, aa64_sve2, do_WHILE, a, false, 0, gen_helper_sve_whileg)
+
+TRANS_FEAT(WHILE_lt_pair, aa64_sme2_or_sve2p1, do_WHILE,
+           a, true, 1, gen_helper_sve_while2l)
+TRANS_FEAT(WHILE_gt_pair, aa64_sme2_or_sve2p1, do_WHILE,
+           a, false, 1, gen_helper_sve_while2g)
 
 static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
 {
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 525c11f5d4..a919fe117b 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -796,6 +796,14 @@ WHILE_gt        00100101 esz:2 1 rm:5 000 sf:1 u:1 0 rn:5 eq:1 rd:4  &while
 # SVE2 pointer conflict compare
 WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
 
+# SVE2.1 predicate pair
+%pd_pair        1:3 !function=times_2
+@while_pair     ........ esz:2 . rm:5 .... u:1 . rn:5 . ... eq:1 \
+                &while rd=%pd_pair sf=1
+
+WHILE_lt_pair   00100101 .. 1 ..... 0101 . 1 ..... 1 ... .  @while_pair
+WHILE_gt_pair   00100101 .. 1 ..... 0101 . 0 ..... 1 ... .  @while_pair
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
-- 
2.43.0


