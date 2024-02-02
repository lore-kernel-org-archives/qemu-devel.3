Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F69C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWG-0005fr-1c; Fri, 02 Feb 2024 00:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWE-0005cv-5m
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:18 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWC-0002xP-DN
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:17 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d71cb97937so16369995ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853315; x=1707458115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mej4K0cyDawsqfKycBOiGoJa8Xqu6U9NANCf2rpmhqc=;
 b=M9fu5hR1xfHH+zEKcbcaqHZV39ptcqfhqEepRQhAfYuXn54NWdu3qgeDcakcKAjamz
 VW+lAej63w7rGsTF5gxzREpkZ/UR6/yLdbL9fgIYuPfVLP10MtAbNLaHMkKqZm+v4sUo
 OnCXgBz6ZcuvXkuDM19fPdSvWF2xv4hn3uCX8nSUVZCMG55Kj5IvkS3Ye7IQUtcMyqzo
 jot6O/esIN/ygRuSlI/ISd3vLl4I5GbOK03PbHjSXp/ivi3uHxmSqOMBfFdZ1Ke4Rh5r
 GIg3XBUFmuSE/T0/eZ+9803+e+6XTRuBW5mu469zXDN9eqGfzTmFuZv+9Avo2lqtYljW
 063g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853315; x=1707458115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mej4K0cyDawsqfKycBOiGoJa8Xqu6U9NANCf2rpmhqc=;
 b=aHevoAVNR9cVzlA0MWvOElHJeX6ZqsMXBGAhpPpI2rWM++Y1X6KkuFDYd7wElKtZUj
 LdJTH9ikZ4AKsjAuwcNI89M1mXKDkGCvAKbiJrod4xr5gRiYHZ3mLg9IkfG3OOa0oZez
 cgac/d/GsC06l8WBtJOaUyUaB4AXDM8blwqjLrT3X45kujvLhaDIuzg/BuDwfVsJx8fk
 2sigp83EzHYIKzRc/8wGLBGqkaWJN5JhAPQ/t2nxwmrx3pfpHuAf6MDcuknC0CvwMJH8
 Y7/QQLeXwJWRRhzPI5HYkIJ637J9OZi00hLaDkEq91UPesReBE0cYe1bmlGE11P+sgAc
 zbog==
X-Gm-Message-State: AOJu0YzOOfqrfSC5C+BdJe1EK6+6A3M7nogifRS7c/XZS2+nrJIi2qff
 iD5cuTkuKAi9Su/s4JpdSxiq+k+FmefVrWso0P+Fo4zPymiPWvr5bRgajtrVf4GXGMNJUhuR/9I
 oQfc=
X-Google-Smtp-Source: AGHT+IHf3rQclRM2gjCun3JMZmesMbsLfXuzJ3Zu4GgQlmivX/8O0CJ2dGEfFjcDShSToiTZoNloPg==
X-Received: by 2002:a17:902:e84d:b0:1d9:592:c301 with SMTP id
 t13-20020a170902e84d00b001d90592c301mr8250215plg.3.1706853315062; 
 Thu, 01 Feb 2024 21:55:15 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 42/57] target/sparc: Use i128 for FADDq, FSUBq, FMULq, FDIVq
Date: Fri,  2 Feb 2024 15:50:21 +1000
Message-Id: <20240202055036.684176-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-8-richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 12 +++++-------
 target/sparc/fop_helper.c | 29 ++++++++++++++---------------
 target/sparc/translate.c  | 13 +++++++------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index eea2fa570c..0a030fc908 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -67,17 +67,16 @@ DEF_HELPER_FLAGS_1(fcmpeq_fcc2, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpeq_fcc3, TCG_CALL_NO_WG, tl, env)
 #endif
 DEF_HELPER_2(raise_exception, noreturn, env, int)
-#define F_HELPER_0_1(name) \
-  DEF_HELPER_FLAGS_1(f ## name, TCG_CALL_NO_RWG, void, env)
 
 DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_RWG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_RWG, f64, env, f64, f64)
-F_HELPER_0_1(addq)
-F_HELPER_0_1(subq)
-F_HELPER_0_1(mulq)
-F_HELPER_0_1(divq)
+
+DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_RWG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_RWG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fmulq, TCG_CALL_NO_RWG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fdivq, TCG_CALL_NO_RWG, i128, env, i128, i128)
 
 DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_RWG, f32, env, f32, f32)
@@ -135,6 +134,5 @@ VIS_CMPHELPER(cmpeq)
 VIS_CMPHELPER(cmple)
 VIS_CMPHELPER(cmpne)
 #endif
-#undef F_HELPER_0_1
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index d639e50965..ceb64d802f 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -98,22 +98,22 @@ target_ulong helper_check_ieee_exceptions(CPUSPARCState *env)
     return do_check_ieee_exceptions(env, GETPC());
 }
 
-#define F_HELPER(name, p) void helper_f##name##p(CPUSPARCState *env)
-
-#define F_BINOP(name)                                           \
+#define F_BINOP(name)                                                \
     float32 helper_f ## name ## s (CPUSPARCState *env, float32 src1, \
-                                   float32 src2)                \
-    {                                                           \
-        return float32_ ## name (src1, src2, &env->fp_status);  \
-    }                                                           \
+                                   float32 src2)                     \
+    {                                                                \
+        return float32_ ## name (src1, src2, &env->fp_status);       \
+    }                                                                \
     float64 helper_f ## name ## d (CPUSPARCState * env, float64 src1,\
-                                   float64 src2)                \
-    {                                                           \
-        return float64_ ## name (src1, src2, &env->fp_status);  \
-    }                                                           \
-    F_HELPER(name, q)                                           \
-    {                                                           \
-        QT0 = float128_ ## name (QT0, QT1, &env->fp_status);    \
+                                   float64 src2)                     \
+    {                                                                \
+        return float64_ ## name (src1, src2, &env->fp_status);       \
+    }                                                                \
+    Int128 helper_f ## name ## q(CPUSPARCState * env, Int128 src1,   \
+                                 Int128 src2)                        \
+    {                                                                \
+        return f128_ret(float128_ ## name (f128_in(src1), f128_in(src2), \
+                                           &env->fp_status));        \
     }
 
 F_BINOP(add);
@@ -168,7 +168,6 @@ void helper_fxtoq(CPUSPARCState *env, int64_t src)
     QT0 = int64_to_float128(src, &env->fp_status);
 }
 #endif
-#undef F_HELPER
 
 /* floating point conversion */
 float32 helper_fdtos(CPUSPARCState *env, float64 src)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ca98565c16..96aa7ed235 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4976,8 +4976,10 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
 TRANS(PDIST, VIS1, do_dddd, a, gen_helper_pdist)
 
 static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
-                       void (*func)(TCGv_env))
+                       void (*func)(TCGv_i128, TCGv_env, TCGv_i128, TCGv_i128))
 {
+    TCGv_i128 src1, src2;
+
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
@@ -4986,12 +4988,11 @@ static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT0(QFPREG(a->rs1));
-    gen_op_load_fpr_QT1(QFPREG(a->rs2));
-    func(tcg_env);
+    src1 = gen_load_fpr_Q(dc, a->rs1);
+    src2 = gen_load_fpr_Q(dc, a->rs2);
+    func(src1, tcg_env, src1, src2);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    gen_store_fpr_Q(dc, a->rd, src1);
     return advance_pc(dc);
 }
 
-- 
2.34.1


