Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614FDC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWK-0005k2-1C; Fri, 02 Feb 2024 00:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWH-0005jD-Rv
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:21 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWG-0002zs-B2
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:21 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so1543955a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853319; x=1707458119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NSayOrlpf4hRSJQ67NyQWTUVVrKjEVHeBTZ50SQ0J0=;
 b=j3Jy1yHBM1Kjcp+loyW7pa0oT8WSwr9kaJ1rOeTP3SQ/Af/D4gc9guYMSvvqSiB9MB
 XeL+Lz60TBvVkgzK4MXCWGyYnnJwYttSvvTVOHDW+dosip1Nl5tN3vBD1JY9NnPA4jJJ
 /NZgFopWVVYTvohk80192ZJjGHRYjMfuq7WsAZ4WjDTy/Z5lJ5zMAp7ERT3BdCDCvAuw
 JoSnugQAj0r9u0/eBS9CL4D164ozPsobq3Bkq1P+kfUv6sqR7o+Py4EPiz3qWfJ1r3Wr
 LtGGwm1Sp8wSsfHk8KARRIYGZTIp7/Acp2U+FkhTnm9PiWzNqUv0dbYFR0NJSgzVa8NG
 gQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853319; x=1707458119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NSayOrlpf4hRSJQ67NyQWTUVVrKjEVHeBTZ50SQ0J0=;
 b=HvN24lD8qmybnuL9C4MPFYcGQW2j3M89bdSY2fc5ItDhL5eaUc6PlZulHx6m6YLf07
 4kJZoSNIwYOgeVJj8SgQr4tzbtzDMw4RH0ShU++snoFDE9l/CFt1Jy92SPKJMjWljcZC
 +cr/byHNOA1G8gL0LI2h5ZdWS3Yh+KuBnaslW6R80XhhCOqn9mAsie+MFP1Q97r8AqCH
 3nknldsAJtNRUanEi74GRgvXGZ1hvbn3TmoTh/ysuqXauMlaDlRYboeb0r3nmChbszbO
 2xkduAx7ATMetrq8IAhUACLk964tPgydDGpLLcfK4iBV+u9k16q/SIrMA2u8nA1Yws45
 PCPg==
X-Gm-Message-State: AOJu0YzzCwVK4pn6qYauGyNx5aQY5Pt6P3s5NJWDY8hquLUTmZ8H6gqL
 FpCqK+lTfFY+IlJPvZznNPxH2po08YQtJwV5Yg157xOFc9d3kz8nE6wt072+XbmqBcgdmtAjKLJ
 YHwk=
X-Google-Smtp-Source: AGHT+IEqcYNbkgAkiUBsgVdueKsDGIM23Yp+owAqFM620OXumnDbnlzYJ7LWPvSDBy0G/4ZdeeMbeg==
X-Received: by 2002:a05:6a20:d044:b0:19e:3356:a6cc with SMTP id
 hv4-20020a056a20d04400b0019e3356a6ccmr937038pzb.51.1706853319113; 
 Thu, 01 Feb 2024 21:55:19 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 44/57] target/sparc: Use i128 for FqTOd, FqTOx
Date: Fri,  2 Feb 2024 15:50:23 +1000
Message-Id: <20240202055036.684176-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Message-Id: <20231103173841.33651-10-richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 4 ++--
 target/sparc/fop_helper.c | 8 ++++----
 target/sparc/translate.c  | 7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index e770107eb0..4cb3451878 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -100,7 +100,7 @@ DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
 DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, void, env, f32)
-DEF_HELPER_FLAGS_1(fqtod, TCG_CALL_NO_RWG, f64, env)
+DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_RWG, f64, env, i128)
 DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
 DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_RWG, s32, env, f64)
@@ -108,7 +108,7 @@ DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_RWG, s32, env, i128)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_RWG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_RWG, s64, env, f64)
-DEF_HELPER_FLAGS_1(fqtox, TCG_CALL_NO_RWG, s64, env)
+DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_RWG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 657a14575d..9f39b933e8 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -190,9 +190,9 @@ void helper_fstoq(CPUSPARCState *env, float32 src)
     QT0 = float32_to_float128(src, &env->fp_status);
 }
 
-float64 helper_fqtod(CPUSPARCState *env)
+float64 helper_fqtod(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_float64(QT1, &env->fp_status);
+    return float128_to_float64(f128_in(src), &env->fp_status);
 }
 
 void helper_fdtoq(CPUSPARCState *env, float64 src)
@@ -227,9 +227,9 @@ int64_t helper_fdtox(CPUSPARCState *env, float64 src)
     return float64_to_int64_round_to_zero(src, &env->fp_status);
 }
 
-int64_t helper_fqtox(CPUSPARCState *env)
+int64_t helper_fqtox(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_int64_round_to_zero(QT1, &env->fp_status);
+    return float128_to_int64_round_to_zero(f128_in(src), &env->fp_status);
 }
 #endif
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f70efb29a1..6f75f4d5d6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4717,8 +4717,9 @@ TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
 TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
 
 static bool do_env_dq(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_i64, TCGv_env))
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i128))
 {
+    TCGv_i128 src;
     TCGv_i64 dst;
 
     if (gen_trap_ifnofpu(dc)) {
@@ -4729,9 +4730,9 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    src = gen_load_fpr_Q(dc, a->rs);
     dst = gen_dest_fpr_D(dc, a->rd);
-    func(dst, tcg_env);
+    func(dst, tcg_env, src);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
-- 
2.34.1


