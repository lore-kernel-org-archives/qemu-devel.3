Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F79C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aAy-00023w-VN; Sat, 12 Sep 2026 22:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAw-0001mb-It
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:38 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAu-0001sr-O1
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:38 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2dso786917a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267355; x=1789872155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=na2WKq4hNVSjSEKdnQMcVOQzt3kswfiu7Fj2vGTHCjk=;
 b=F+gtOjM/KXNU7A3hOk1bIqodEFgLAVXB2Y4cbXohxM75RvBB+57XghssVuqyixmbEd
 m6K4dUvU/4Oiz80bX/PrUdGT5EGJjsrLSOQtdhkS0Oa5sxyNIgVkAJxqsk2O4NRmoL18
 em0Hwn1CeWr0FxFxKKxlfG4EM18Tj9uhSuQROolJNT8yTmrjbFdcqRi8Cm4pVytQp0kl
 2yBbVeODYNXzijbAd24SIq0G1eWk871G2kY4amVA4YHs/HYtI6JiusxVUA9FUQp24OQU
 DGXn7OEvNkGcMzLk6921VtdG0tzEDSALmml0MeKS1rYT0NXJ56VU2nsMjqwbx03xb4Wo
 irnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267355; x=1789872155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=na2WKq4hNVSjSEKdnQMcVOQzt3kswfiu7Fj2vGTHCjk=;
 b=kyQVHCmyxGcM8rTUuP5rVWtkI6clmJcvHbrBzf+UXqcAdZMJkVFMG1dLnuXNghDZ6i
 j5XK/5oPyYbJkQojcqarnmxYd8vzMXX0hQvto959KrG5R61GXM0cQKuvnJKjBl6+6YH2
 vzz5pM1F1Z5AzxerIpV/JKdArV6ziROV9F93qLQH8WwESV0cRoHunUjddFQTYdxFGpVA
 QPb/+pkWSvxlJlWyj0hWimpuMeEqKMkzrHcFvGXdlluH4hmFpwaXkD5Gl0MWqzfOh2VO
 P6dq4zzaoVyjiQfceAFUFTP1ohirDAoE3TfE6wqsZKjy8cGkGxcuZkhnfwNsSDOAIRkx
 w0gw==
X-Gm-Message-State: AFuF++kzOE0EsUxs1of+FoDQDckFcIrlWcI44ZnSd72hQ8i7Mnh1Sg6Z
 kCDP8Awc7xLp+qWRwPUAUGEEfWz+TsjzfMQibH80LXsjgGwy1qVNhQd6NFjTzKuabpWjs0X1dWq
 JPVn9Ozk=
X-Gm-Gg: AYBFou0SJ9MQrVvwbDvSxMbTxQbYinZNil/T9qwe+ZMdbrkGKtVoeV/mylYZyTEZpgi
 FVT7hAINQYk/dF/XLCI5MYeM7SluOXiWk5XkHR6rR6OVuANGhluYY1IWC5YDhMZZK9YiHiUmIYP
 99yA1iAZRzG/U9vaUxvc6D0TotmnFFcHYNPJJ0PBbXT6LZ06A8VtyjsDbV9uw3T0yYDt/IwRXE6
 RIkMjfeShexTm1H2ez2TDXuC8Ve4hvY7bl+mB3rkaS7GSUhv8wgnxua4Xf/oZoFfeTU8dDVzldQ
 PhIJ/tNDc+gDD6hevDng7zElkmluaeJRYWvetgTpexDF+nAT8WRZedWCAkuFVEYvoodNLOI7mmK
 PU5MQd0PrVk4YF39GLKDngam3CvB5AnMOF2xwYug+aTs6lVm4ifwou9tQeTx0E2ftQyDqqMoAMD
 KGrTsxH7l8u6KfL5ePu1uDt5XcCNkuXZH0vZx8OuaA/MVChQV5wUXMIDFPJ3uAORk6pIRDy12+o
 GBFHg0=
X-Received: by 2002:a05:6a20:3ca7:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3daed16281bmr22869107637.7.1789267355244; 
 Sat, 12 Sep 2026 19:42:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 49/86] tcg: Use signed integer for tcg_gen_{clz, ctz}i_{i32,
 i64}
Date: Sat, 12 Sep 2026 16:38:00 -1000
Message-ID: <20260913023837.741866-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We use signed integers for all other functions, and the
sign of the second source is not meaningful here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h                | 8 ++++----
 tcg/tcg-op.c                               | 8 ++++----
 target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 755e89d7715..44fa7886c60 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,8 +130,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -190,8 +190,8 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fabec509aa9..276bc11ebcc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -853,7 +853,7 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
@@ -898,7 +898,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
@@ -1774,7 +1774,7 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
@@ -1808,7 +1808,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index c3d8bbf2670..4e521e44bb5 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1551,7 +1551,7 @@ static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
 }
 
 static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i32, TCGv_i32, uint32_t))
+                     void (*helper)(TCGv_i32, TCGv_i32, int32_t))
 {
     TCGv_i32 t = tcg_temp_new_i32();
 
@@ -1567,7 +1567,7 @@ static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
 
 #if defined(TARGET_PPC64)
 static bool do_cntzd(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i64, TCGv_i64, uint64_t))
+                    void (*helper)(TCGv_i64, TCGv_i64, int64_t))
 {
     helper(cpu_gpr[a->ra], cpu_gpr[a->rs], 64);
     if (unlikely(a->rc)) {
-- 
2.53.0


