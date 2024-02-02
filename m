Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFEBC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWS-0006OR-S0; Fri, 02 Feb 2024 00:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWQ-0006Cm-DO
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWO-00032B-Ld
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:30 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso13086465ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853327; x=1707458127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eKYzACMAdv41jwhWgL5ua1c7uVrjKcVx/en63NM27s=;
 b=Un+2cmmKr7DLm119jEA9RAd0FY1OU15gB3k0E05KG2j/Sqadpv7IkNcSgsS0ZTnPg4
 SIZ63wulz09xFNC6BQ02Ppuw8v6bJr2AOU95FNJ+ly10ongHb//NpHlB0dHRV+tkRCQp
 Sadc3uT2tPtt2G2T0zywcO0Edb5jsiDv43LD2xO3MvjrNHbAOJEVIL0mCi+o3E68BJhq
 EnvrESgmdv5t7nhhojA+VLQ5q6D1snBRmt/ePmTWICbo7rDTwUWnxy5ERUzVIqG4aBsX
 PGc0uS1QADwKDamxHr7ZV2lgNYZ5PpcATi08djbvzSq5SeQYtN78ZG8uKl9NQNgp3fZU
 IEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853327; x=1707458127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eKYzACMAdv41jwhWgL5ua1c7uVrjKcVx/en63NM27s=;
 b=UjRga4C14WczxeyAusZ9hpDsDR0EKUym9rKwnMlv6KDGUOsTK6prPbW9UW9t9Dr1ip
 tCdDiNq6L1bPhU5DWKOl5ajUQTZPhITZxra8xFvsNjao0BOsV3h3lg5X5NoxIFVIcWZS
 CbuOL1Ddhy/pJ4v9gb+PYEuovNnov0AttdLEslgN9mrKpCu7miFo6OrNz7HMb9YwKDGA
 xG+5WEXtCMKNAM3cTHy2CAK2+picd5YAyjejlH+H2X3ltebMNDUGLdLbcQRYbMEE0z4g
 qGObSR0ugXz4r98FfoGlmQz1rsHoAUm255p0YFcfXxQCZMiRN9uA+aA/pceC/DGA0ZdO
 Ny0w==
X-Gm-Message-State: AOJu0YxWzJYnTYpsDW5lcwGFk4W1DfezD599iGwFnPeaoaYoYmyW4MFd
 BA2u42wk8ktjIXBUvLi2lvZultMyeLojulbTIq05rNZ7EHmuvRpOnGpJg9OassXkU9eDcQ+TRRc
 C78w=
X-Google-Smtp-Source: AGHT+IGzNatTW+QEMboGjPdHjMPcN8h17fQi260tb1Yo3HaVNnO6m4pOXP9cbhcfWm8YjbHZuJhMVw==
X-Received: by 2002:a17:902:ef92:b0:1d9:2cda:afe5 with SMTP id
 iz18-20020a170902ef9200b001d92cdaafe5mr1164021plb.31.1706853327222; 
 Thu, 01 Feb 2024 21:55:27 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 48/57] target/sparc: Use i128 for Fdmulq
Date: Fri,  2 Feb 2024 15:50:27 +1000
Message-Id: <20240202055036.684176-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
Message-Id: <20231103173841.33651-14-richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/fop_helper.c |  8 ++++----
 target/sparc/translate.c  | 15 ++++-----------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 20f67f89b0..f7aeb31169 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -84,7 +84,7 @@ DEF_HELPER_FLAGS_3(fmuls, TCG_CALL_NO_RWG, f32, env, f32, f32)
 DEF_HELPER_FLAGS_3(fdivs, TCG_CALL_NO_RWG, f32, env, f32, f32)
 
 DEF_HELPER_FLAGS_3(fsmuld, TCG_CALL_NO_RWG, f64, env, f32, f32)
-DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, void, env, f64, f64)
+DEF_HELPER_FLAGS_3(fdmulq, TCG_CALL_NO_RWG, i128, env, f64, f64)
 
 DEF_HELPER_FLAGS_2(fitod, TCG_CALL_NO_RWG_SE, f64, env, s32)
 DEF_HELPER_FLAGS_2(fitoq, TCG_CALL_NO_RWG, i128, env, s32)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 9a0110e201..cd9b212597 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -129,11 +129,11 @@ float64 helper_fsmuld(CPUSPARCState *env, float32 src1, float32 src2)
                        &env->fp_status);
 }
 
-void helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
+Int128 helper_fdmulq(CPUSPARCState *env, float64 src1, float64 src2)
 {
-    QT0 = float128_mul(float64_to_float128(src1, &env->fp_status),
-                       float64_to_float128(src2, &env->fp_status),
-                       &env->fp_status);
+    return f128_ret(float128_mul(float64_to_float128(src1, &env->fp_status),
+                                 float64_to_float128(src2, &env->fp_status),
+                                 &env->fp_status));
 }
 
 /* Integer to float conversion.  */
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d478a2fcd0..d12de5ae5c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -276,14 +276,6 @@ static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst, TCGv_i128 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static void gen_op_store_QT0_fpr(unsigned int dst)
-{
-    tcg_gen_ld_i64(cpu_fpr[dst / 2], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.upper));
-    tcg_gen_ld_i64(cpu_fpr[dst/2 + 1], tcg_env, offsetof(CPUSPARCState, qt0) +
-                   offsetof(CPU_QuadU, ll.lower));
-}
-
 /* moves */
 #ifdef CONFIG_USER_ONLY
 #define supervisor(dc) 0
@@ -4992,6 +4984,7 @@ TRANS(FDIVq, ALL, do_env_qqq, a, gen_helper_fdivq)
 static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
 {
     TCGv_i64 src1, src2;
+    TCGv_i128 dst;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -5003,10 +4996,10 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
     gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-    gen_helper_fdmulq(tcg_env, src1, src2);
+    dst = tcg_temp_new_i128();
+    gen_helper_fdmulq(dst, tcg_env, src1, src2);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-    gen_op_store_QT0_fpr(QFPREG(a->rd));
-    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    gen_store_fpr_Q(dc, a->rd, dst);
     return advance_pc(dc);
 }
 
-- 
2.34.1


