Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F2C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWb-00073U-HR; Fri, 02 Feb 2024 00:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWa-00071Z-Hn
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:40 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWY-00039V-UX
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d9607f2b3aso3073395ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853337; x=1707458137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xswm8Y4EVntAPydwJ8PJUaf0qkJ0h3e6mOU1vrp0dGE=;
 b=w5AMC/ZOg5b62eUEol6KHNgHQNHD1NyRUNVwhecLG+AtKsqkmBGjgrZcbmhiOZ534G
 +TdhdERVbNoM4Su/rOdw8CqJGraU8BEymHZmEOQRS+5z5UjZNhXDdC98CTbDBeQr9TVm
 Oh+nbRV3FMqxiEVrfQB1cTptquldnlsYKTnJ0VMlWbjOXykY9dhJsllClC8fe3Ro5laT
 R+7OaMZqngcflm6hsYEi8U4Cw5AzS5I+VB21HqB0wc7Al7OZfme8DcERQuJcp1SviqN+
 1AaldRQ9d7/6Mk2jf6vlhgOvQGurPr9nwv7WnjqXTx+0mu8GJCg17XxOWQ6bBnTSzs7k
 PmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853337; x=1707458137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xswm8Y4EVntAPydwJ8PJUaf0qkJ0h3e6mOU1vrp0dGE=;
 b=CBPR3oDUHjYGsUgwTV8tRqKTy+X9R3I+ADgviWsGKyn4YJ/hZhosPSCHMbZlCynQ2G
 l7/TMnhgGWrbW7F0q7g0pJjQYHefkMgITamn04wiUpGBcXLQTDqEKokKaiNwHpENrH0d
 2ECvlj7NqkKtDiyXgoNQaqHGkfJYRAzny1dnefE5y5Ljl2hxQgWh+LWWJ6LuBp4yWD8Y
 7cK+Ir6aiI5dIJK0AhF39MAnpNVr756DpMrdmQK3j824+hoB7RZBPMqbvJzZyMf7uvYb
 hc+UthjlQMkknzTkQpC08qQp7rHsz38OuBVj5zeLgNUxocmazThCv8r2mS/EQricnUSk
 uh+w==
X-Gm-Message-State: AOJu0Yw5Alh6pv1WzMgGZRmWLdtVQl+Y1N1athYaaL65KlFx8OqJ9UCZ
 GjknJVXJFeJqsrv0owGgnEBS2FfbCCFgzt4wfPSl/DgghV3T+RWmb3+lm0BUdBt1737Qd2IxROp
 eCSI=
X-Google-Smtp-Source: AGHT+IFWaA1tkgiiwjpkrvC5aXlOkD8ksLnbC5TFsGreY06/8Gg9EyEeO36++IEhFOG84C/TqFKBzA==
X-Received: by 2002:a17:903:32c5:b0:1d7:19ec:2eaf with SMTP id
 i5-20020a17090332c500b001d719ec2eafmr1943574plr.6.1706853337693; 
 Thu, 01 Feb 2024 21:55:37 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 52/57] target/sparc: Clear cexc and ftt in
 do_check_ieee_exceptions
Date: Fri,  2 Feb 2024 15:50:31 +1000
Message-Id: <20240202055036.684176-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Don't do the clearing explicitly before each FPop,
rather do it as part of the rest of exception handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-18-richard.henderson@linaro.org>
---
 target/sparc/fop_helper.c |  2 ++
 target/sparc/translate.c  | 16 ----------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 22b412adb5..64f20e78f1 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -50,6 +50,8 @@ static target_ulong do_check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
     target_ulong status = get_float_exception_flags(&env->fp_status);
     target_ulong fsr = env->fsr;
 
+    fsr &= FSR_FTT_CEXC_NMASK;
+
     if (unlikely(status)) {
         /* Keep exception flags clear for next time.  */
         set_float_exception_flags(0, &env->fp_status);
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index da4f167fa6..67bac6f65f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4524,7 +4524,6 @@ static bool do_env_ff(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     tmp = gen_load_fpr_F(dc, a->rs);
     func(tmp, tcg_env, tmp);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
@@ -4546,7 +4545,6 @@ static bool do_env_fd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = tcg_temp_new_i32();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
@@ -4590,7 +4588,6 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
@@ -4613,7 +4610,6 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src = gen_load_fpr_F(dc, a->rs);
     func(dst, tcg_env, src);
@@ -4661,8 +4657,6 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
-
     t = gen_load_fpr_Q(dc, a->rs);
     func(t, tcg_env, t);
     gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
@@ -4685,7 +4679,6 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_Q(dc, a->rs);
     dst = tcg_temp_new_i32();
     func(dst, tcg_env, src);
@@ -4710,7 +4703,6 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src = gen_load_fpr_Q(dc, a->rs);
     dst = gen_dest_fpr_D(dc, a->rd);
     func(dst, tcg_env, src);
@@ -4808,7 +4800,6 @@ static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     func(src1, tcg_env, src1, src2);
@@ -4903,7 +4894,6 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
@@ -4930,7 +4920,6 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
         return raise_unimpfpop(dc);
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     dst = gen_dest_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
@@ -4972,7 +4961,6 @@ static bool do_env_qqq(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_Q(dc, a->rs1);
     src2 = gen_load_fpr_Q(dc, a->rs2);
     func(src1, tcg_env, src1, src2);
@@ -4998,7 +4986,6 @@ static bool trans_FdMULq(DisasContext *dc, arg_r_r_r *a)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     dst = tcg_temp_new_i128();
@@ -5087,7 +5074,6 @@ static bool do_fcmps(DisasContext *dc, arg_FCMPs *a, bool e)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     if (e) {
@@ -5112,7 +5098,6 @@ static bool do_fcmpd(DisasContext *dc, arg_FCMPd *a, bool e)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     if (e) {
@@ -5140,7 +5125,6 @@ static bool do_fcmpq(DisasContext *dc, arg_FCMPq *a, bool e)
         return true;
     }
 
-    gen_op_clear_ieee_excp_and_FTT();
     src1 = gen_load_fpr_Q(dc, a->rs1);
     src2 = gen_load_fpr_Q(dc, a->rs2);
     if (e) {
-- 
2.34.1


