Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEDEC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWM-0005nr-AJ; Fri, 02 Feb 2024 00:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWK-0005kK-Ao
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:24 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWI-00030S-F9
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:24 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso13086145ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853321; x=1707458121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWVW9zIWIN6DyYuL+xfFV1ntiMTdFfptfEfa84xvE2U=;
 b=CqBSHaR/N0YEsscOsDLFBEskBDhGF4N/eFrsCaXizwQs/QRdPV101Mqii2dVSI+YSX
 1ijYxazi8K8/qt+AFQM+2ty+CBN41cNB1QWP2l+okCuWh/yWKojIYsSUUReq+ju1rg9k
 DAL6cfsXANNIqMRLGHuoDfnpSq3Ave2eRPFkYRe5UKty/4Wm3abAd5qh1vhjNyQowaI/
 41bPAf2feE6BG0KMyLXUtVJ6W5EV0mbef+RJ0AJlql8GrYbhOZz3GbTqQDfA8ct21nLM
 1ln4x9l3+rN9mBPyS1HlpduEq2bsUK80ycV/+90laDw46B/D/xAKZ85SAwHPh84pIePg
 DYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853321; x=1707458121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWVW9zIWIN6DyYuL+xfFV1ntiMTdFfptfEfa84xvE2U=;
 b=HvSgxMyvKZq9/JEy1vKCzPgnyioV6DUe6CO8MudzIGVjfOI+aSWR7p1zJxu0Bxlmwr
 qpAWxk5t6YkBum4GstQpSL+NU/kc7pUC6yVodv/1Q9dhKoygYn4Hyds9pOGsFwQC9/5i
 nVAcUC/WkwelDvKzFM8cMJwUIre3Xjsqb5S8d70mstc5v1ifs5/NqdyTDLI+r/YtCZt2
 /S0nft6gtzKW9It1IxarUAlibybQ98HZwhSdHW+b2MJgjOu6SRgSYIZDRKQW3C/yZX+C
 5Zsk8oNCZM8Jdqs/OxtkUaQ8zanrr2Rs+LQ6Dryu5DsI95fFHg0RIPkSXzeUspRwpp1Q
 SzTg==
X-Gm-Message-State: AOJu0Yx6lvJtAASg2dim7USy0qSRCZgSi5JWrq0577jRo9QjWKuIuDZL
 B00ZDjctPbmicq6z9OV90VzTOwUaFbeTD/adN7inbcUXqAPM3EjnkfzgBFJtL+W3mbE8FzHtgwv
 4jnw=
X-Google-Smtp-Source: AGHT+IHTR1BjoRnxlJpVjsIJMct3uAiyXiya8jss1huQMFbYKwuXC0unFd/+1msdFhhlqWPZjW1jPg==
X-Received: by 2002:a17:903:246:b0:1d6:fe11:2642 with SMTP id
 j6-20020a170903024600b001d6fe112642mr1494945plh.27.1706853321120; 
 Thu, 01 Feb 2024 21:55:21 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 45/57] target/sparc: Use i128 for FCMPq, FCMPEq
Date: Fri,  2 Feb 2024 15:50:24 +1000
Message-Id: <20240202055036.684176-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
Message-Id: <20231103173841.33651-11-richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 16 ++++++------
 target/sparc/fop_helper.c | 23 +++++++++--------
 target/sparc/translate.c  | 54 +++++++++++++++------------------------
 3 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 4cb3451878..7caae9a441 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -44,8 +44,8 @@ DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_2(fsqrtq, TCG_CALL_NO_RWG, i128, env, i128)
-DEF_HELPER_FLAGS_1(fcmpq, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq, TCG_CALL_NO_WG, tl, env)
+DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, tl, env, i128, i128)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, tl, env, f32, f32)
@@ -59,12 +59,12 @@ DEF_HELPER_FLAGS_3(fcmpes_fcc3, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmped_fcc1, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc2, TCG_CALL_NO_WG, tl, env, f64, f64)
 DEF_HELPER_FLAGS_3(fcmped_fcc3, TCG_CALL_NO_WG, tl, env, f64, f64)
-DEF_HELPER_FLAGS_1(fcmpq_fcc1, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpq_fcc2, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpq_fcc3, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq_fcc1, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq_fcc2, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_1(fcmpeq_fcc3, TCG_CALL_NO_WG, tl, env)
+DEF_HELPER_FLAGS_3(fcmpq_fcc1, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc2, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc3, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc1, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc2, TCG_CALL_NO_WG, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc3, TCG_CALL_NO_WG, tl, env, i128, i128)
 #endif
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 9f39b933e8..faf75e651f 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -248,9 +248,12 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
     return f128_ret(float128_sqrt(f128_in(src), &env->fp_status));
 }
 
-#define GEN_FCMP(name, size, reg1, reg2, FS, E)                         \
-    target_ulong glue(helper_, name) (CPUSPARCState *env)               \
+#define GEN_FCMP(name, size, FS, E)                                     \
+    target_ulong glue(helper_, name) (CPUSPARCState *env,               \
+                                      Int128 src1, Int128 src2)         \
     {                                                                   \
+        float128 reg1 = f128_in(src1);                                  \
+        float128 reg2 = f128_in(src2);                                  \
         FloatRelation ret;                                              \
         target_ulong fsr;                                               \
         if (E) {                                                        \
@@ -316,33 +319,33 @@ GEN_FCMP_T(fcmpd, float64, 0, 0);
 GEN_FCMP_T(fcmpes, float32, 0, 1);
 GEN_FCMP_T(fcmped, float64, 0, 1);
 
-GEN_FCMP(fcmpq, float128, QT0, QT1, 0, 0);
-GEN_FCMP(fcmpeq, float128, QT0, QT1, 0, 1);
+GEN_FCMP(fcmpq, float128, 0, 0);
+GEN_FCMP(fcmpeq, float128, 0, 1);
 
 #ifdef TARGET_SPARC64
 GEN_FCMP_T(fcmps_fcc1, float32, 22, 0);
 GEN_FCMP_T(fcmpd_fcc1, float64, 22, 0);
-GEN_FCMP(fcmpq_fcc1, float128, QT0, QT1, 22, 0);
+GEN_FCMP(fcmpq_fcc1, float128, 22, 0);
 
 GEN_FCMP_T(fcmps_fcc2, float32, 24, 0);
 GEN_FCMP_T(fcmpd_fcc2, float64, 24, 0);
-GEN_FCMP(fcmpq_fcc2, float128, QT0, QT1, 24, 0);
+GEN_FCMP(fcmpq_fcc2, float128, 24, 0);
 
 GEN_FCMP_T(fcmps_fcc3, float32, 26, 0);
 GEN_FCMP_T(fcmpd_fcc3, float64, 26, 0);
-GEN_FCMP(fcmpq_fcc3, float128, QT0, QT1, 26, 0);
+GEN_FCMP(fcmpq_fcc3, float128, 26, 0);
 
 GEN_FCMP_T(fcmpes_fcc1, float32, 22, 1);
 GEN_FCMP_T(fcmped_fcc1, float64, 22, 1);
-GEN_FCMP(fcmpeq_fcc1, float128, QT0, QT1, 22, 1);
+GEN_FCMP(fcmpeq_fcc1, float128, 22, 1);
 
 GEN_FCMP_T(fcmpes_fcc2, float32, 24, 1);
 GEN_FCMP_T(fcmped_fcc2, float64, 24, 1);
-GEN_FCMP(fcmpeq_fcc2, float128, QT0, QT1, 24, 1);
+GEN_FCMP(fcmpeq_fcc2, float128, 24, 1);
 
 GEN_FCMP_T(fcmpes_fcc3, float32, 26, 1);
 GEN_FCMP_T(fcmped_fcc3, float64, 26, 1);
-GEN_FCMP(fcmpeq_fcc3, float128, QT0, QT1, 26, 1);
+GEN_FCMP(fcmpeq_fcc3, float128, 26, 1);
 #endif
 #undef GEN_FCMP_T
 #undef GEN_FCMP
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6f75f4d5d6..6c003eed7c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -276,22 +276,6 @@ static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static void gen_op_load_fpr_QT0(unsigned int src)
-{
-    tcg_gen_st_i64(cpu_fpr[src / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.upper));
-    tcg_gen_st_i64(cpu_fpr[src/2 + 1], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.lower));
-}
-
-static void gen_op_load_fpr_QT1(unsigned int src)
-{
-    tcg_gen_st_i64(cpu_fpr[src / 2], tcg_env, offsetof(CPUSPARCState, qt1) +
-                   offsetof(CPU_QuadU, ll.upper));
-    tcg_gen_st_i64(cpu_fpr[src/2 + 1], tcg_env, offsetof(CPUSPARCState, qt1) +
-                   offsetof(CPU_QuadU, ll.lower));
-}
-
 static void gen_op_store_QT0_fpr(unsigned int dst)
 {
     tcg_gen_ld_i64(cpu_fpr[dst / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
@@ -1319,20 +1303,20 @@ static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     }
 }
 
-static void gen_op_fcmpq(int fccno)
+static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpq(cpu_fsr, tcg_env);
+        gen_helper_fcmpq(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpq_fcc1(cpu_fsr, tcg_env);
+        gen_helper_fcmpq_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpq_fcc2(cpu_fsr, tcg_env);
+        gen_helper_fcmpq_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpq_fcc3(cpu_fsr, tcg_env);
+        gen_helper_fcmpq_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1373,20 +1357,20 @@ static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     }
 }
 
-static void gen_op_fcmpeq(int fccno)
+static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpeq(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpeq_fcc1(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpeq_fcc2(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpeq_fcc3(cpu_fsr, tcg_env);
+        gen_helper_fcmpeq_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1403,9 +1387,9 @@ static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     gen_helper_fcmpd(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 
-static void gen_op_fcmpq(int fccno)
+static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
-    gen_helper_fcmpq(cpu_fsr, tcg_env);
+    gen_helper_fcmpq(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 
 static void gen_op_fcmpes(int fccno, TCGv r_rs1, TCGv r_rs2)
@@ -1418,9 +1402,9 @@ static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
     gen_helper_fcmped(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 
-static void gen_op_fcmpeq(int fccno)
+static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
-    gen_helper_fcmpeq(cpu_fsr, tcg_env);
+    gen_helper_fcmpeq(cpu_fsr, tcg_env, r_rs1, r_rs2);
 }
 #endif
 
@@ -5144,6 +5128,8 @@ TRANS(FCMPEd, ALL, do_fcmpd, a, true)
 
 static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
 {
+    TCGv_i128 src1, src2;
+
     if (avail_32(dc) && a->cc != 0) {
         return false;
     }
@@ -5155,12 +5141,12 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT0(QFPREG(a->rs1));
-    gen_op_load_fpr_QT1(QFPREG(a->rs2));
+    src1 = gen_load_fpr_Q(dc, a->rs1);
+    src2 = gen_load_fpr_Q(dc, a->rs2);
     if (e) {
-        gen_op_fcmpeq(a->cc);
+        gen_op_fcmpeq(a->cc, src1, src2);
     } else {
-        gen_op_fcmpq(a->cc);
+        gen_op_fcmpq(a->cc, src1, src2);
     }
     return advance_pc(dc);
 }
-- 
2.34.1


