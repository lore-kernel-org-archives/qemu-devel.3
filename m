Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F9CC9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAko8-0004xB-08; Sun, 27 Sep 2026 05:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknr-0004VT-B1
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:12 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknp-0007dK-A9
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:10 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so990175a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499848; x=1791104648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fxHuGCuJQ2I8t/qnL1+80CoNNO6OTdWogGUcszyL0B8=;
 b=V5FzAFXBJT9UkSXIAOeH/k6MsS0kyuzUDEsrTNI7bMG/gz9dYhyS7OPnio4QpuQb+S
 RzJeMAloLhDBAmQkcPPIVHYrPi5+sW3nWxjcRWfMwsYdCwoL1sAzXLdgp3PeWGQPjmBa
 wTZHUJEtMtw54HChU8Dzfj8UcOjkgfzKTW8QHelMoY5biyH4WMF0IYuu2Pmru3KlZVEu
 L+HlkGGGfPjsKxCGGD/+O9P3/C4Fnl1+dxIZYo2Hs9b5WCnHGLjdP0GU7Przde3SXjG0
 8Iy5A2vkC2sXV2V+7f8i7Iji3A3y5Rn80Y7T8xrrPhFN0jRJSfMKtQpQWoaJsp2y+TD8
 Q6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499848; x=1791104648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fxHuGCuJQ2I8t/qnL1+80CoNNO6OTdWogGUcszyL0B8=;
 b=sDeIaRCnlSNOEMGvic/hEIaJCjbAwOQVwdDW+F5X/j/zU2h8RVJkIHD7Q4eOhKQqze
 MsVyALCxy2SJEYagAGxz7SC+Gy+3Fq4m3wTCKBWX5mB/uYJgGYjsaiRqR0017a3pQAfM
 di77Uq83enc0jNrbRS80aMqDZXjw+qjVWfSEWXhSvfewb03CCbUHHLuhYOkQQNrQbHaI
 F50fdZEbj2PRl/gc9iOdxAziTnfRWziSFJmokhCC0tJnyimHJbYo4Wm79Ho/MtL/65RZ
 64JBomL+UfwXJlhcD9r8t/pCrujry72p4rOEroh9ScOHWgdzlDaf3diSyvI2CbC8qhsF
 i/Tg==
X-Gm-Message-State: AFq9FYJpz0uKWyWUYErFkO1JMSs4/w24Cg24OV7xDfglWJTEkZwdTACi
 Sd7/aOslDfN/PZXGu+fOHTArd/SbKgQMelJwG4uxGEnex9ICxLM1QulWkwCKbtYon5Qbq6Sr9SM
 F17q1
X-Gm-Gg: AYBFou3nn4MeYj6g/UUSzzq1V9itBULBBDlmYbIIDE8SPKDnJ9NCULoEVv5CKmJsGgF
 apuuh98LmGNgKUjHO3mBmyF/yo7q4C7pfdYFQaAIA4wKj3zr8W23BNJ04hwxpbwv040fdBzePxn
 nqrHWKdwebYX/Y5ycPDNeagNrsO5pqEWB1nYfeTrBD6DaAMVo/dIvYVdxj65YUI+Y5mC8aUAb0q
 1DVR7cBh23Ci5SU9oj9Yai7kVlTAwUj+0nlN7h1SyeP6W4ONN/5YrNmNWduJkdw2EyY24oy9Svw
 8FY08BiHV5L80lbeY8Y5uoIUaLAWayhx8zfc6v3enHDBsB7c3Npbh6IoYEHC/T0RkiwlZ2Q9sdF
 FVD+lvej8NMk5tufhjqM1rocO7SHYpv46NqoU7yuzynqWPhAa9dV9OBH/KIW7JQUdQFutsFsM09
 m0eFTDCnQKLxuU+XiaPFGBaBs3au7p37wf02rEoWdkn/42Y8WowP5xhAuK3p8HtzO9w8wmaYWq9
 YXuSfVZiI1lp0JKbjmzTYEJQSdi8g==
X-Received: by 2002:a17:90b:3c8e:b0:3a0:dec0:c0d2 with SMTP id
 98e67ed59e1d1-3a0dec0d44cmr3391121a91.63.1790499847941; 
 Sun, 27 Sep 2026 02:04:07 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 052/101] tcg: Use signed integer for tcg_gen_{clz,
 ctz}i_{i32, i64}
Date: Sun, 27 Sep 2026 01:59:22 -0700
Message-ID: <20260927090011.10724-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
index f40c286a831..40a7f94040c 100644
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
index 74e1e1aae2d..1231cb4ca0e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -753,7 +753,7 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
@@ -798,7 +798,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
@@ -1674,7 +1674,7 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
@@ -1708,7 +1708,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index c3d8bbf2670..5195db4e9a3 100644
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
+                     void (*helper)(TCGv_i64, TCGv_i64, int64_t))
 {
     helper(cpu_gpr[a->ra], cpu_gpr[a->rs], 64);
     if (unlikely(a->rc)) {
-- 
2.53.0


