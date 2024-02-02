Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F5EC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWk-0007Ca-BX; Fri, 02 Feb 2024 00:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWi-0007Bg-2L
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:48 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWf-0003Qd-Gm
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:47 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d8aadc624dso13486445ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853344; x=1707458144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbdAL5DvJKQPWcY3wsaw848CgsUHDg3QTYtvSkzuHmY=;
 b=u+zx+IQXgSO1Wu0qMfytQRcrax1KJL98VJ/QE74AbX1QQbyG8dwkYB/J0YA7NxdQr4
 x+391POU4O5AHy/GKTwUpruOpEVE15/UaHLioriqZ1VvD8SgdwUyOaDpA3xgIzZn4fgR
 oBCZeaXSU33yCmgrz0sx0fgMnW9WdGacGRksFgBlJX/gpwAN5i3ZX96RiRh4IJClfi2t
 ms5zF3qPudqb2rKi1Zp3fYzNPMAubPQyoPgxbrhQS1iLOFCekyRYKfGsGAGnk9M2fjhw
 5mZu+F/lISwTSZnEkoVZCliieqDGPKg7usm8vkDw7PGgcRcsapKLlpaYAEswXOCHkUMP
 VmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853344; x=1707458144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbdAL5DvJKQPWcY3wsaw848CgsUHDg3QTYtvSkzuHmY=;
 b=fmSMnTQ6XFjwcEDWGa7QTB2t+Q0hOb6+hGVLtRMxVeRJ/E0VMjiszpFBtjTTpdUbg9
 5VisY+kORdv8TbTDRprYDcXSL95u0SedwcwQZ9iVCR9LjgOJCWOZE4/J00Tq8QfQIwa/
 F5el3ss7G8rdlKV+J0ecrElVB9wcialcO8JAsNbJnGWvUih3ZpuM3eXkO+1kTr67+8z0
 jzjpSGh/u9u2mN8pYo1haUh9fBubQ0TZRxf0NONI29YlA7QXPGefp4wrOxMsLpOtUwDZ
 zCHlFz10IyFsRN+2KVzD1CJiFSj6QkmtJYRYvf2enqLJMq0GrK0HEYvufsYUDfA1+7fg
 /zJQ==
X-Gm-Message-State: AOJu0YxYjEFwbYnX6s8Nex95ntXzwYTitQfDzQhiyJhW5mE13YYXnsW8
 vyM3kUVecwcFY4Me9mIOiEyjkNwr1OwxE61yGzSO8yf+om78xhG4EqyE4U1wuOtBZ/IRGVn0Tzk
 ZZ+g=
X-Google-Smtp-Source: AGHT+IF1wcFumyJ9BNypAtuMrDf1sCL28TCMSeFpDp76X1tFvneKBdzpT02SXs65B6T9J1zyP44AhA==
X-Received: by 2002:a17:902:d509:b0:1d8:ef9e:b436 with SMTP id
 b9-20020a170902d50900b001d8ef9eb436mr1633932plg.22.1706853343889; 
 Thu, 01 Feb 2024 21:55:43 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 55/57] target/sparc: Remove cpu_fsr
Date: Fri,  2 Feb 2024 15:50:34 +1000
Message-Id: <20240202055036.684176-57-richard.henderson@linaro.org>
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

Drop this field as a tcg global, loading it explicitly in the
few places required.  This means that all FPop helpers may
once again be TCG_CALL_NO_WG.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-21-richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 120 +++++++++++++++++++-------------------
 target/sparc/fop_helper.c |   9 ++-
 target/sparc/translate.c  |  98 ++++++++++++++++---------------
 3 files changed, 114 insertions(+), 113 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 7466164468..c8e14fe371 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -36,79 +36,79 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
-DEF_HELPER_FLAGS_2(set_fsr_noftt, 0, void, env, tl)
-DEF_HELPER_FLAGS_2(fsqrts, 0, f32, env, f32)
-DEF_HELPER_FLAGS_2(fsqrtd, 0, f64, env, f64)
-DEF_HELPER_FLAGS_2(fsqrtq, 0, i128, env, i128)
-DEF_HELPER_FLAGS_3(fcmps, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpd, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpes, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmped, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpq, 0, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_2(set_fsr_noftt, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_WG, f32, env, f32)
+DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_WG, f64, env, f64)
+DEF_HELPER_FLAGS_2(fsqrtq, TCG_CALL_NO_WG, i128, env, i128)
+DEF_HELPER_FLAGS_3(fcmps, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpd, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpes, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmped, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpq, TCG_CALL_NO_WG, void, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq, TCG_CALL_NO_WG, void, env, i128, i128)
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_3(fcmps_fcc1, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmps_fcc2, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmps_fcc3, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpd_fcc1, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpd_fcc2, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpd_fcc3, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpes_fcc1, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpes_fcc2, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmpes_fcc3, 0, tl, env, f32, f32)
-DEF_HELPER_FLAGS_3(fcmped_fcc1, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmped_fcc2, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmped_fcc3, 0, tl, env, f64, f64)
-DEF_HELPER_FLAGS_3(fcmpq_fcc1, 0, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpq_fcc2, 0, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpq_fcc3, 0, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc1, 0, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc2, 0, tl, env, i128, i128)
-DEF_HELPER_FLAGS_3(fcmpeq_fcc3, 0, tl, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmps_fcc3, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpd_fcc1, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpd_fcc2, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpd_fcc3, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpes_fcc1, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpes_fcc2, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmpes_fcc3, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmped_fcc1, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmped_fcc2, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmped_fcc3, TCG_CALL_NO_WG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fcmpq_fcc1, TCG_CALL_NO_WG, void, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc2, TCG_CALL_NO_WG, void, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpq_fcc3, TCG_CALL_NO_WG, void, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc1, TCG_CALL_NO_WG, void, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc2, TCG_CALL_NO_WG, void, env, i128, i128)
+DEF_HELPER_FLAGS_3(fcmpeq_fcc3, TCG_CALL_NO_WG, void, env, i128, i128)
 #endif
 DEF_HELPER_2(raise_exception, noreturn, env, int)
 
-DEF_HELPER_FLAGS_3(faddd, 0, f64, env, f64, f64)
-DEF_HELPER_FLAGS_3(fsubd, 0, f64, env, f64, f64)
-DEF_HELPER_FLAGS_3(fmuld, 0, f64, env, f64, f64)
-DEF_HELPER_FLAGS_3(fdivd, 0, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(faddd, TCG_CALL_NO_WG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fsubd, TCG_CALL_NO_WG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fmuld, TCG_CALL_NO_WG, f64, env, f64, f64)
+DEF_HELPER_FLAGS_3(fdivd, TCG_CALL_NO_WG, f64, env, f64, f64)
 
-DEF_HELPER_FLAGS_3(faddq, 0, i128, env, i128, i128)
-DEF_HELPER_FLAGS_3(fsubq, 0, i128, env, i128, i128)
-DEF_HELPER_FLAGS_3(fmulq, 0, i128, env, i128, i128)
-DEF_HELPER_FLAGS_3(fdivq, 0, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(faddq, TCG_CALL_NO_WG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fsubq, TCG_CALL_NO_WG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fmulq, TCG_CALL_NO_WG, i128, env, i128, i128)
+DEF_HELPER_FLAGS_3(fdivq, TCG_CALL_NO_WG, i128, env, i128, i128)
 
-DEF_HELPER_FLAGS_3(fadds, 0, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fsubs, 0, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fmuls, 0, f32, env, f32, f32)
-DEF_HELPER_FLAGS_3(fdivs, 0, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fadds, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fsubs, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_WG, f32, env, f32, f32)
 
-DEF_HELPER_FLAGS_3(fsmuld, 0, f64, env, f32, f32)
-DEF_HELPER_FLAGS_3(fdmulq, 0, i128, env, f64, f64)
+DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_WG, f64, env, f32, f32)
+DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_WG, i128, env, f64, f64)
 
-DEF_HELPER_FLAGS_2(fitod, 0, f64, env, s32)
-DEF_HELPER_FLAGS_2(fitoq, 0, i128, env, s32)
+DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_WG, f64, env, s32)
+DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_WG, i128, env, s32)
 
-DEF_HELPER_FLAGS_2(fitos, 0, f32, env, s32)
+DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_WG, f32, env, s32)
 
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_2(fxtos, 0, f32, env, s64)
-DEF_HELPER_FLAGS_2(fxtod, 0, f64, env, s64)
-DEF_HELPER_FLAGS_2(fxtoq, 0, i128, env, s64)
+DEF_HELPER_FLAGS_2(fxtos, TCG_CALL_NO_WG, f32, env, s64)
+DEF_HELPER_FLAGS_2(fxtod, TCG_CALL_NO_WG, f64, env, s64)
+DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_WG, i128, env, s64)
 #endif
-DEF_HELPER_FLAGS_2(fdtos, 0, f32, env, f64)
-DEF_HELPER_FLAGS_2(fstod, 0, f64, env, f32)
-DEF_HELPER_FLAGS_2(fqtos, 0, f32, env, i128)
-DEF_HELPER_FLAGS_2(fstoq, 0, i128, env, f32)
-DEF_HELPER_FLAGS_2(fqtod, 0, f64, env, i128)
-DEF_HELPER_FLAGS_2(fdtoq, 0, i128, env, f64)
-DEF_HELPER_FLAGS_2(fstoi, 0, s32, env, f32)
-DEF_HELPER_FLAGS_2(fdtoi, 0, s32, env, f64)
-DEF_HELPER_FLAGS_2(fqtoi, 0, s32, env, i128)
+DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_WG, f32, env, f64)
+DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_WG, f64, env, f32)
+DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_WG, f32, env, i128)
+DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_WG, i128, env, f32)
+DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_WG, f64, env, i128)
+DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_WG, i128, env, f64)
+DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_WG, s32, env, f32)
+DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_WG, s32, env, f64)
+DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_WG, s32, env, i128)
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_2(fstox, 0, s64, env, f32)
-DEF_HELPER_FLAGS_2(fdtox, 0, s64, env, f64)
-DEF_HELPER_FLAGS_2(fqtox, 0, s64, env, i128)
+DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_WG, s64, env, f32)
+DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
+DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index ac30f88810..796f448bfd 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -344,8 +344,7 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
 }
 
 #define GEN_FCMP(name, size, FS, E)                                     \
-    target_ulong glue(helper_, name) (CPUSPARCState *env,               \
-                                      Int128 src1, Int128 src2)         \
+    void glue(helper_, name)(CPUSPARCState *env, Int128 src1, Int128 src2) \
     {                                                                   \
         float128 reg1 = f128_in(src1);                                  \
         float128 reg2 = f128_in(src2);                                  \
@@ -376,10 +375,10 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
             fsr &= ~((FSR_FCC1 | FSR_FCC0) << FS);                      \
             break;                                                      \
         }                                                               \
-        return fsr;                                                     \
+        env->fsr = fsr;                                                 \
     }
 #define GEN_FCMP_T(name, size, FS, E)                                   \
-    target_ulong glue(helper_, name)(CPUSPARCState *env, size src1, size src2)\
+    void glue(helper_, name)(CPUSPARCState *env, size src1, size src2)  \
     {                                                                   \
         FloatRelation ret;                                              \
         target_ulong fsr;                                               \
@@ -407,7 +406,7 @@ Int128 helper_fsqrtq(CPUSPARCState *env, Int128 src)
             fsr &= ~((FSR_FCC1 | FSR_FCC0) << FS);                      \
             break;                                                      \
         }                                                               \
-        return fsr;                                                     \
+        env->fsr = fsr;                                                 \
     }
 
 GEN_FCMP_T(fcmps, float32, 0, 0);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5b9bbeb8ff..cf8cfe5cc4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -99,7 +99,7 @@
 
 /* global register indexes */
 static TCGv_ptr cpu_regwptr;
-static TCGv cpu_fsr, cpu_pc, cpu_npc;
+static TCGv cpu_pc, cpu_npc;
 static TCGv cpu_regs[32];
 static TCGv cpu_y;
 static TCGv cpu_tbr;
@@ -1097,7 +1097,7 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
 static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
 {
     unsigned int offset;
-    TCGv r_dst;
+    TCGv r_dst, fsr;
 
     /* For now we still generate a straight boolean result.  */
     cmp->cond = TCG_COND_NE;
@@ -1120,54 +1120,56 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
         break;
     }
 
+    fsr = tcg_temp_new();
+    tcg_gen_ld_tl(fsr, tcg_env, offsetof(CPUSPARCState, fsr));
     switch (cond) {
     case 0x0:
         gen_op_eval_bn(r_dst);
         break;
     case 0x1:
-        gen_op_eval_fbne(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbne(r_dst, fsr, offset);
         break;
     case 0x2:
-        gen_op_eval_fblg(r_dst, cpu_fsr, offset);
+        gen_op_eval_fblg(r_dst, fsr, offset);
         break;
     case 0x3:
-        gen_op_eval_fbul(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbul(r_dst, fsr, offset);
         break;
     case 0x4:
-        gen_op_eval_fbl(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbl(r_dst, fsr, offset);
         break;
     case 0x5:
-        gen_op_eval_fbug(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbug(r_dst, fsr, offset);
         break;
     case 0x6:
-        gen_op_eval_fbg(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbg(r_dst, fsr, offset);
         break;
     case 0x7:
-        gen_op_eval_fbu(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbu(r_dst, fsr, offset);
         break;
     case 0x8:
         gen_op_eval_ba(r_dst);
         break;
     case 0x9:
-        gen_op_eval_fbe(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbe(r_dst, fsr, offset);
         break;
     case 0xa:
-        gen_op_eval_fbue(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbue(r_dst, fsr, offset);
         break;
     case 0xb:
-        gen_op_eval_fbge(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbge(r_dst, fsr, offset);
         break;
     case 0xc:
-        gen_op_eval_fbuge(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbuge(r_dst, fsr, offset);
         break;
     case 0xd:
-        gen_op_eval_fble(r_dst, cpu_fsr, offset);
+        gen_op_eval_fble(r_dst, fsr, offset);
         break;
     case 0xe:
-        gen_op_eval_fbule(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbule(r_dst, fsr, offset);
         break;
     case 0xf:
-        gen_op_eval_fbo(r_dst, cpu_fsr, offset);
+        gen_op_eval_fbo(r_dst, fsr, offset);
         break;
     }
 }
@@ -1264,16 +1266,16 @@ static void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmps(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmps(tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmps_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmps_fcc1(tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmps_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmps_fcc2(tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmps_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmps_fcc3(tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1282,16 +1284,16 @@ static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpd(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpd(tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpd_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpd_fcc1(tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpd_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpd_fcc2(tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpd_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpd_fcc3(tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1300,16 +1302,16 @@ static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpq(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpq(tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpq_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpq_fcc1(tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpq_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpq_fcc2(tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpq_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpq_fcc3(tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1318,16 +1320,16 @@ static void gen_op_fcmpes(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpes(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpes(tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpes_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpes_fcc1(tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpes_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpes_fcc2(tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpes_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpes_fcc3(tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1336,16 +1338,16 @@ static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmped(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmped(tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmped_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmped_fcc1(tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmped_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmped_fcc2(tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmped_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmped_fcc3(tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1354,16 +1356,16 @@ static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
     switch (fccno) {
     case 0:
-        gen_helper_fcmpeq(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpeq(tcg_env, r_rs1, r_rs2);
         break;
     case 1:
-        gen_helper_fcmpeq_fcc1(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpeq_fcc1(tcg_env, r_rs1, r_rs2);
         break;
     case 2:
-        gen_helper_fcmpeq_fcc2(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpeq_fcc2(tcg_env, r_rs1, r_rs2);
         break;
     case 3:
-        gen_helper_fcmpeq_fcc3(cpu_fsr, tcg_env, r_rs1, r_rs2);
+        gen_helper_fcmpeq_fcc3(tcg_env, r_rs1, r_rs2);
         break;
     }
 }
@@ -1372,32 +1374,32 @@ static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 
 static void gen_op_fcmps(int fccno, TCGv r_rs1, TCGv r_rs2)
 {
-    gen_helper_fcmps(cpu_fsr, tcg_env, r_rs1, r_rs2);
+    gen_helper_fcmps(tcg_env, r_rs1, r_rs2);
 }
 
 static void gen_op_fcmpd(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
-    gen_helper_fcmpd(cpu_fsr, tcg_env, r_rs1, r_rs2);
+    gen_helper_fcmpd(tcg_env, r_rs1, r_rs2);
 }
 
 static void gen_op_fcmpq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
-    gen_helper_fcmpq(cpu_fsr, tcg_env, r_rs1, r_rs2);
+    gen_helper_fcmpq(tcg_env, r_rs1, r_rs2);
 }
 
 static void gen_op_fcmpes(int fccno, TCGv r_rs1, TCGv r_rs2)
 {
-    gen_helper_fcmpes(cpu_fsr, tcg_env, r_rs1, r_rs2);
+    gen_helper_fcmpes(tcg_env, r_rs1, r_rs2);
 }
 
 static void gen_op_fcmped(int fccno, TCGv_i64 r_rs1, TCGv_i64 r_rs2)
 {
-    gen_helper_fcmped(cpu_fsr, tcg_env, r_rs1, r_rs2);
+    gen_helper_fcmped(tcg_env, r_rs1, r_rs2);
 }
 
 static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 {
-    gen_helper_fcmpeq(cpu_fsr, tcg_env, r_rs1, r_rs2);
+    gen_helper_fcmpeq(tcg_env, r_rs1, r_rs2);
 }
 #endif
 
@@ -4413,8 +4415,9 @@ static bool do_ldfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop,
     tnew = tcg_temp_new();
     told = tcg_temp_new();
     tcg_gen_qemu_ld_tl(tnew, addr, dc->mem_idx, mop | MO_ALIGN);
+    tcg_gen_ld_tl(told, tcg_env, offsetof(CPUSPARCState, fsr));
     tcg_gen_andi_tl(tnew, tnew, new_mask);
-    tcg_gen_andi_tl(told, cpu_fsr, old_mask);
+    tcg_gen_andi_tl(told, told, old_mask);
     tcg_gen_or_tl(tnew, tnew, told);
     gen_helper_set_fsr_noftt(tcg_env, tnew);
     return advance_pc(dc);
@@ -5342,7 +5345,6 @@ void sparc_tcg_init(void)
         { &cpu_icc_Z, offsetof(CPUSPARCState, icc_Z), "icc_Z" },
         { &cpu_icc_C, offsetof(CPUSPARCState, icc_C), "icc_C" },
         { &cpu_cond, offsetof(CPUSPARCState, cond), "cond" },
-        { &cpu_fsr, offsetof(CPUSPARCState, fsr), "fsr" },
         { &cpu_pc, offsetof(CPUSPARCState, pc), "pc" },
         { &cpu_npc, offsetof(CPUSPARCState, npc), "npc" },
         { &cpu_y, offsetof(CPUSPARCState, y), "y" },
-- 
2.34.1


