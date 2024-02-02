Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129DEC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWV-0006dx-0a; Fri, 02 Feb 2024 00:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWS-0006LU-6t
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:32 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWK-00030v-Dj
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d91397bd22so14198135ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853323; x=1707458123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qq++rIr45iSkpBC0Q6O8O5vjzYxl8Bl9TQVIq1ySmoA=;
 b=CYN4p7rX+4PZaLtVcys8sEdVrWfCVIGP/+X1dISu3th52EUxiY95po8sLltaTRlBKq
 7a6YE6L/eYbU7f6V0fkTgZdYg8oZgIP1+/HRhi8OXON4Gd4gi7Srex0/ItEt873fUJw4
 svRJocT7bXnUUTiyhrH6C42estTfjBr79vl4OEKofwCkMGyaswgOOvr41QT+Qbu/Vsfb
 Wju5YrZWygscsDV0Gua+Qs/ySMeFQmANwegUQqPOLMh7KogaQz/QhWtsH+bLyQtggnEQ
 x2Ll+3u85vRUKpFy81XiG3DO8qAaWrUXPS7aM5oF0yNKRmM7RSwNt9eTBEJUYfY16HlE
 /rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853323; x=1707458123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qq++rIr45iSkpBC0Q6O8O5vjzYxl8Bl9TQVIq1ySmoA=;
 b=FXFeHl/ZpRTvYvI8yMMjdfsTfUyRi72h5MKJlvt+5szVKxzQFTn0BgT1SLtjrfiGGB
 5exbCd7sZ27pFNtiTpszQlmUrhouy0zzgcK4oRT3tycmve8XfyMVCwVxG3A57DoNRigh
 uz5df/+Kryi2UTB0l68BPzR9tHftLyjPN9Ywj0Vl5oa6cWO0KFGGlbP6d6Anu3LyaIIn
 e/PrroPdKDDaBqaNcFXvDu3T4SAzCCSioEAHnlRynAIi7fHIwYPl8/tqe2FE8nYGIHDu
 uZBvESll3hTZqbD+g96JvD90lWRhbkMD8OTh2oNT+tf8IC2PERGDhCz6HvQKrgxsRCiI
 pcjw==
X-Gm-Message-State: AOJu0Yy2wySlrnhhqBNDyDtyPRSw44VuyaHOErssSkqFVJvXdDNcxOd6
 4n6x9Ld1KzNzyUH7tyykeiq7HBvg+VlbH5ckjU2H/79qlsx/jt56wskDJVv2E63PJpdjgKFpM2O
 iclk=
X-Google-Smtp-Source: AGHT+IG+QBfW+BaMQ11yxVhE4XvK1idLSMhvw88lejsvqhbHyOmp/+ZJUuuGyVqPQC3RDJpzde7QoA==
X-Received: by 2002:a17:903:2303:b0:1d9:6cb5:a818 with SMTP id
 d3-20020a170903230300b001d96cb5a818mr1648261plh.30.1706853323203; 
 Thu, 01 Feb 2024 21:55:23 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 46/57] target/sparc: Use i128 for FsTOq, FiTOq
Date: Fri,  2 Feb 2024 15:50:25 +1000
Message-Id: <20240202055036.684176-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Message-Id: <20231103173841.33651-12-richard.henderson@linaro.org>
---
 target/sparc/helper.h     | 4 ++--
 target/sparc/fop_helper.c | 8 ++++----
 target/sparc/translate.c  | 9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 7caae9a441..5e93342583 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -87,7 +87,7 @@ DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_RWG, f64, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, void, env, f64, f64)
 
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_RWG_SE, f64, env, s32)
-DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, void, env, s32)
+DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, i128, env, s32)
 
 DEF_HELPER_FLAGS_2(fitos, TCG_CALL_NO_RWG, f32, env, s32)
 
@@ -99,7 +99,7 @@ DEF_HELPER_FLAGS_2(fxtoq, TCG_CALL_NO_RWG, void, env, s64)
 DEF_HELPER_FLAGS_2(fdtos, TCG_CALL_NO_RWG, f32, env, f64)
 DEF_HELPER_FLAGS_2(fstod, TCG_CALL_NO_RWG, f64, env, f32)
 DEF_HELPER_FLAGS_2(fqtos, TCG_CALL_NO_RWG, f32, env, i128)
-DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, void, env, f32)
+DEF_HELPER_FLAGS_2(fstoq, TCG_CALL_NO_RWG, i128, env, f32)
 DEF_HELPER_FLAGS_2(fqtod, TCG_CALL_NO_RWG, f64, env, i128)
 DEF_HELPER_FLAGS_2(fdtoq, TCG_CALL_NO_RWG, void, env, f64)
 DEF_HELPER_FLAGS_2(fstoi, TCG_CALL_NO_RWG, s32, env, f32)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index faf75e651f..c7dc835d28 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -147,9 +147,9 @@ float64 helper_fitod(CPUSPARCState *env, int32_t src)
     return int32_to_float64(src, &env->fp_status);
 }
 
-void helper_fitoq(CPUSPARCState *env, int32_t src)
+Int128 helper_fitoq(CPUSPARCState *env, int32_t src)
 {
-    QT0 = int32_to_float128(src, &env->fp_status);
+    return f128_ret(int32_to_float128(src, &env->fp_status));
 }
 
 #ifdef TARGET_SPARC64
@@ -185,9 +185,9 @@ float32 helper_fqtos(CPUSPARCState *env, Int128 src)
     return float128_to_float32(f128_in(src), &env->fp_status);
 }
 
-void helper_fstoq(CPUSPARCState *env, float32 src)
+Int128 helper_fstoq(CPUSPARCState *env, float32 src)
 {
-    QT0 = float32_to_float128(src, &env->fp_status);
+    return f128_ret(float32_to_float128(src, &env->fp_status));
 }
 
 float64 helper_fqtod(CPUSPARCState *env, Int128 src)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6c003eed7c..6522a9b0c8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4726,9 +4726,10 @@ TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
 TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
 
 static bool do_env_qf(DisasContext *dc, arg_r_r *a,
-                      void (*func)(TCGv_env, TCGv_i32))
+                      void (*func)(TCGv_i128, TCGv_env, TCGv_i32))
 {
     TCGv_i32 src;
+    TCGv_i128 dst;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -4739,9 +4740,9 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
 
     gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_F(dc, a->rs);
-    func(tcg_env, src);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    dst = tcg_temp_new_i128();
+    func(dst, tcg_env, src);
+    gen_store_fpr_Q(dc, a->rd, dst);
     return advance_pc(dc);
 }
 
-- 
2.34.1


