Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96E1C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWH-0005j4-6g; Fri, 02 Feb 2024 00:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWG-0005iO-1H
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:20 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWE-0002zL-Co
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:19 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d958e0d73dso3567895ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853317; x=1707458117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anUQUR+7vArGgtO6zfUt+4F4NGdL3cNUIA03PRdflq8=;
 b=gMNYe740FGFC0+QeEOQHab/Ywm6nUntq1GjDB5KUIeLt15sHOZZ6gX9IkkKI8AWZ1H
 4tjI7kQxxLApox0+fIbCiov9VhMji5ZU3HIlji0f7kaObhwFWM41YgOY6hb+S/VjJ9bK
 JEL/0v07XNBrCMr/Sb0iYgqU7zBhzZCMAzVmXJGMdFMerKZZ626ZPH7BwuSoVU5Bu8C7
 jfVfNcO9nten/yP8gmOQ2+Xop1i0Eu7cSySaCdjqVBtgp7/cW9YuMbVeg/ndNJ1BiwmI
 +IwQZYcgewsIM+gWL4don+6+0TIVn10/sWELDNHPzP2LwkSt/Rkj2pMvJNfYML013YNG
 7xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853317; x=1707458117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anUQUR+7vArGgtO6zfUt+4F4NGdL3cNUIA03PRdflq8=;
 b=jbif1xHIRX0dVERPn+5piITFW5jmSIDhg/ObUesfl6kfXmzv/AXpj+Zn//PDZRdIAV
 W1VxaBU7lR4flmSAlsKn2X9lEGTOrTlIkAAHHLCDkSzb8ftnixoOF+SfYH/30fORXhxk
 aWDFUuHAd0jm/fu6k5m8agn06Op/38nOhAx7rr97htEJ7emtUXoU0riI+cgy67WGyy9w
 nJyjNUZvYzIv+zyfPlWhX7+4ewhgytCaeEhLviKXjx9ONUg+tHtKlTrkQe7IztqL4NIL
 T1qgNVwG5UJAl/0ClSD2vZnt7CW+Pbhv0IqxE3vT+MF6rx4HHTMQO+qnJKDaoEN9F6jo
 Jn9g==
X-Gm-Message-State: AOJu0Yxci8ROg7lLkeQ5PBIWroi5peQ0TAN/U89Cq/NMSeToseINo1sK
 Z+Mj8Eri+h4I53KbDDaZksE0hB5b1ZUaDLCEeAatga4QZxl11ndPqfla1PEsPtqAM6q9U9ol6ue
 QOUw=
X-Google-Smtp-Source: AGHT+IGTWXIqLuaw/GrdKm7nkTV8MMhiQiAb61UQBVN5COuIEVL+qrSMbCrWMj7NfQyXoCnn+K6OGw==
X-Received: by 2002:a17:903:2b0b:b0:1d9:4834:e1c9 with SMTP id
 mc11-20020a1709032b0b00b001d94834e1c9mr2053626plb.29.1706853317080; 
 Thu, 01 Feb 2024 21:55:17 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 43/57] target/sparc: Use i128 for FqTOs, FqTOi
Date: Fri,  2 Feb 2024 15:50:22 +1000
Message-Id: <20240202055036.684176-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
Message-Id: <20231103173841.33651-9-richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 4 ++--
 target/sparc/fop_helper.c | 8 ++++----
 target/sparc/translate.c  | 7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 0a030fc908..e770107eb0 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -98,13 +98,13 @@ DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
 #endif
 DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
-DEF_HELPER_FLAGS_1(fqtos, TCG_CALL_NO_RWG, f32, env)
+DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
 DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, void, env, f32)
 DEF_HELPER_FLAGS_1(fqtod, TCG_CALL_NO_RWG, f64, env)
 DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
 DEF_HELPER_FLAGS_2(fdtoi, TCG_CALL_NO_RWG, s32, env, f64)
-DEF_HELPER_FLAGS_1(fqtoi, TCG_CALL_NO_RWG, s32, env)
+DEF_HELPER_FLAGS_2(fqtoi, TCG_CALL_NO_RWG, s32, env, i128)
 #ifdef TARGET_SPARC64
 DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_RWG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_RWG, s64, env, f64)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index ceb64d802f..657a14575d 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -180,9 +180,9 @@ float64 helper_fstod(CPUSPARCState *env, float32 src)
     return float32_to_float64(src, &env->fp_status);
 }
 
-float32 helper_fqtos(CPUSPARCState *env)
+float32 helper_fqtos(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_float32(QT1, &env->fp_status);
+    return float128_to_float32(f128_in(src), &env->fp_status);
 }
 
 void helper_fstoq(CPUSPARCState *env, float32 src)
@@ -211,9 +211,9 @@ int32_t helper_fdtoi(CPUSPARCState *env, float64 src)
     return float64_to_int32_round_to_zero(src, &env->fp_status);
 }
 
-int32_t helper_fqtoi(CPUSPARCState *env)
+int32_t helper_fqtoi(CPUSPARCState *env, Int128 src)
 {
-    return float128_to_int32_round_to_zero(QT1, &env->fp_status);
+    return float128_to_int32_round_to_zero(f128_in(src), &env->fp_status);
 }
 
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 96aa7ed235..f70efb29a1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4692,8 +4692,9 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
 
 static bool do_env_fq(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_i32, TCGv_env))
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i128))
 {
+    TCGv_i128 src;
     TCGv_i32 dst;
 
     if (gen_trap_ifnofpu(dc)) {
@@ -4704,9 +4705,9 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
     }
 
     gen_op_clear_ieee_excp_and_FTT();
-    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    src = gen_load_fpr_Q(dc, a->rs);
     dst = tcg_temp_new_i32();
-    func(dst, tcg_env);
+    func(dst, tcg_env, src);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
     gen_store_fpr_F(dc, a->rd, dst);
     return advance_pc(dc);
-- 
2.34.1


