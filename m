Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011D8E77180
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ59-000783-JP; Sun, 08 Dec 2024 17:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ57-00077Q-CR
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:53 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ55-0006CY-HY
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:48:53 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71de02b24cfso556506a34.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698130; x=1734302930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VygN+W9RKPAJjasMCWSLuOlElJZ/pQQzo9TD4o2RJQI=;
 b=GDneB3h1sgCo78LbGrQkFrdUOgWugjuWkaWlwN0nMZPrbBsMeF8HvtRsjwAU7Gv+T+
 GauAyfE/Rdq5qd/W8x6M6KKkz4dywNGoSBZ3Ca5dm82x6ox325GCDXu+5Ph13MGtiNpR
 Rm6DsCTWl6fEBKlE9TBPIBYtCpT8rVQC0CbpMQ5l7gya0Qlp8KhS4PefCVZ3Sfg+Xn4d
 Xp/GbfACSpOXOBRdC25/RUeESpA8PGCnvvi4lNwFKT0fgemn/9/zIDvmmdtenHbW4Smw
 3XJDzi7PPOWiDJIqDYhQ0YnbbGsXCNvvOXwsFg5BRWvzPuF4CfTLy1WzHjtCiwSYqKAJ
 UBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698130; x=1734302930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VygN+W9RKPAJjasMCWSLuOlElJZ/pQQzo9TD4o2RJQI=;
 b=dEWbeibAjMTqbV3/knAGywIvL0X2xEpds/nlKD7inkh2Qsj/9tnP4gNjA5jge+FiR0
 kSoI4SIJASpMJpZNu2lFT5xBFMYQ55hlKhQ0hV/Cj2t0ynEDWv6/snE8jd/bmyRgDD1u
 vrKaEI4jJtBhIn1mV5fJbKN3yf8u8k6hWQTLoAfEZe/mS+/FMr2QN0dQBi/0L4qmxE4A
 02UAjNYNgsPw3qy4+aoqsFv4qJg1h7lDXw7+FkwshFAztInGjJ6LhdZpUZk70T3NbIZZ
 O+XDv+ciuy098zjJ305+GE9jtDQVcYlEXg9wkskrk8LuvtcFDFyPn79VYFXdxtO745Z0
 Hcbw==
X-Gm-Message-State: AOJu0YxHG4ktQCN4hWQbfilG1feu7eCW9x1M2ix3OEuYpuA6cD02sQcx
 T4KWmxKHcVFXEdIvyNhyP/kUyg8gPCouRL/NbhCOnKBJPLCUr56wgdFIKkrCQjROvSEmIyJrqDj
 dn/esUQ==
X-Gm-Gg: ASbGncuyYqQ/g5ftsOleKEKpOu2FDaLFuGpXPVJTwn8wkHS9x4N+AO6qFqp2Xq4oMDu
 wNrfW3h1KJxFR4NbzPB1FwkrlUCpvpbxpI8MR1wtXc+DwgFiU/rryPngJoGZiVeab+5UX/b3lT6
 BISNpNh2oxJFdSbhwICzVCnLkEDHjvMPCHY2f3x8VY++nUyu9sQxcvX1kdJTjDektLhpVX5Hnp6
 ++wiWTQHs7hebs0auPtQJ5IHlr+AOoykvAA+l4kX4tCtHHjfJOJt1D2OoQL6cR19LlVSfETcprp
 kwhyA7XLhDTkdhCX0y8c4nIzkmMywUJ9pIPQ
X-Google-Smtp-Source: AGHT+IGUjjs+2xNhOHGylRySyrWOoJ5F1jxH09TD1rjC0ggyg8whgrPQIINCNMLVAXw9ymMIUs17kw==
X-Received: by 2002:a05:6830:700e:b0:71d:4385:665e with SMTP id
 46e09a7af769-71dcf4cc128mr6426441a34.9.1733698130362; 
 Sun, 08 Dec 2024 14:48:50 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:48:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/17] target/sparc: Use float*_muladd_scalbn
Date: Sun,  8 Dec 2024 16:48:30 -0600
Message-ID: <20241208224844.570491-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Use the scalbn interface instead of float_muladd_halve_result.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  4 +-
 target/sparc/fop_helper.c |  8 ++--
 target/sparc/translate.c  | 80 +++++++++++++++++++++++----------------
 3 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 134e519a37..49ace89858 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -59,7 +59,7 @@ DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_WG, f64, env, f64, f64)
-DEF_HELPER_FLAGS_5(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, i32)
+DEF_HELPER_FLAGS_6(fmaddd, TCG_CALL_NO_WG, f64, env, f64, f64, f64, s32, i32)
 DEF_HELPER_FLAGS_3(fnaddd, TCG_CALL_NO_WG, f64, env, f64, f64)
 DEF_HELPER_FLAGS_3(fnmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
 
@@ -72,7 +72,7 @@ DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_WG, f32, env, f32, f32)
-DEF_HELPER_FLAGS_5(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, i32)
+DEF_HELPER_FLAGS_6(fmadds, TCG_CALL_NO_WG, f32, env, f32, f32, f32, s32, i32)
 DEF_HELPER_FLAGS_3(fnadds, TCG_CALL_NO_WG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fnmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
 
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 6f9ccc008a..f4af04f061 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -344,17 +344,17 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
 }
 
 float32 helper_fmadds(CPUSPARCState *env, float32 s1,
-                      float32 s2, float32 s3, uint32_t op)
+                      float32 s2, float32 s3, int32_t sc, uint32_t op)
 {
-    float32 ret = float32_muladd(s1, s2, s3, op, &env->fp_status);
+    float32 ret = float32_muladd_scalbn(s1, s2, s3, sc, op, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
 
 float64 helper_fmaddd(CPUSPARCState *env, float64 s1,
-                      float64 s2, float64 s3, uint32_t op)
+                      float64 s2, float64 s3, int32_t sc, uint32_t op)
 {
-    float64 ret = float64_muladd(s1, s2, s3, op, &env->fp_status);
+    float64 ret = float64_muladd_scalbn(s1, s2, s3, sc, op, &env->fp_status);
     check_ieee_exceptions(env, GETPC());
     return ret;
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cdd0a95c03..005efb13f1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1364,93 +1364,109 @@ static void gen_op_fabsq(TCGv_i128 dst, TCGv_i128 src)
 
 static void gen_op_fmadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(0));
+    TCGv_i32 z = tcg_constant_i32(0);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, z);
 }
 
 static void gen_op_fmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(0));
+    TCGv_i32 z = tcg_constant_i32(0);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, z);
 }
 
 static void gen_op_fmsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    int op = float_muladd_negate_c;
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fmsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    int op = float_muladd_negate_c;
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    int op = float_muladd_negate_c | float_muladd_negate_result;
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c |
+                                   float_muladd_negate_result);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    int op = float_muladd_negate_c | float_muladd_negate_result;
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c |
+                                   float_muladd_negate_result);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2, TCGv_i32 s3)
 {
-    int op = float_muladd_negate_result;
-    gen_helper_fmadds(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmadds(d, tcg_env, s1, s2, s3, z, op);
 }
 
 static void gen_op_fnmaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2, TCGv_i64 s3)
 {
-    int op = float_muladd_negate_result;
-    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, tcg_constant_i32(op));
+    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmaddd(d, tcg_env, s1, s2, s3, z, op);
 }
 
 /* Use muladd to compute (1 * src1) + src2 / 2 with one rounding. */
 static void gen_op_fhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
 {
-    TCGv_i32 one = tcg_constant_i32(float32_one);
-    int op = float_muladd_halve_result;
-    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i32 fone = tcg_constant_i32(float32_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(0);
+    gen_helper_fmadds(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
 {
-    TCGv_i64 one = tcg_constant_i64(float64_one);
-    int op = float_muladd_halve_result;
-    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i64 fone = tcg_constant_i64(float64_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(0);
+    gen_helper_fmaddd(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 /* Use muladd to compute (1 * src1) - src2 / 2 with one rounding. */
 static void gen_op_fhsubs(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
 {
-    TCGv_i32 one = tcg_constant_i32(float32_one);
-    int op = float_muladd_negate_c | float_muladd_halve_result;
-    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i32 fone = tcg_constant_i32(float32_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmadds(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fhsubd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
 {
-    TCGv_i64 one = tcg_constant_i64(float64_one);
-    int op = float_muladd_negate_c | float_muladd_halve_result;
-    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i64 fone = tcg_constant_i64(float64_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_c);
+    gen_helper_fmaddd(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 /* Use muladd to compute -((1 * src1) + src2 / 2) with one rounding. */
 static void gen_op_fnhadds(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
 {
-    TCGv_i32 one = tcg_constant_i32(float32_one);
-    int op = float_muladd_negate_result | float_muladd_halve_result;
-    gen_helper_fmadds(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i32 fone = tcg_constant_i32(float32_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmadds(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fnhaddd(TCGv_i64 d, TCGv_i64 s1, TCGv_i64 s2)
 {
-    TCGv_i64 one = tcg_constant_i64(float64_one);
-    int op = float_muladd_negate_result | float_muladd_halve_result;
-    gen_helper_fmaddd(d, tcg_env, one, s1, s2, tcg_constant_i32(op));
+    TCGv_i64 fone = tcg_constant_i64(float64_one);
+    TCGv_i32 mone = tcg_constant_i32(-1);
+    TCGv_i32 op = tcg_constant_i32(float_muladd_negate_result);
+    gen_helper_fmaddd(d, tcg_env, fone, s1, s2, mone, op);
 }
 
 static void gen_op_fpexception_im(DisasContext *dc, int ftt)
-- 
2.43.0


