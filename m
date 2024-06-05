Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DDFC27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLq-0005rx-E7; Wed, 05 Jun 2024 13:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLp-0005rR-2P
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:05 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLn-0003ob-82
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:04 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6819b3c92bbso24385a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608182; x=1718212982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fljjc+vgV8n9jaU2H17cE0qlx4ZtzSc/592LQHPcA70=;
 b=PyXCOy+hacUZgIeEgUTH17qq6diiiG4Jhw5zvD74VSAWRHQE/ubPBwoHwQGa2vBKSk
 GVywIfCa/ysjUvJ1wXKXQLZI2m7L/jg+jbWL4a6elsvAC3R1lyHPrlXAgcagGIwYF3uT
 TXa869Uw1wpGmk1RGs8rLfNZ5HBe2dM42/Av5meJvmRpjSJVsw35sIlegpsp/JPdZAMj
 jS0/04H1StC8MSsoQDpqCnQs3/q2dsIfCx7maCyBapRLplAgazx2m+6oQta4vqwvltgw
 nw0kIc0LCV8OyQSf0SW1n2GvZgNtwSNAGJej85J7cK0+nmbmJoybbcXoJsogmySvebUW
 Aigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608182; x=1718212982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fljjc+vgV8n9jaU2H17cE0qlx4ZtzSc/592LQHPcA70=;
 b=lGWbslF+A5ecXHSF67E0e+KcauBbP/eIiYe8GnfBVtkz2DdZUo82DOIVdtu03PmFLw
 Sdzat/2jR1ogrmC1J33mlSfWA2d2O6151sA6d/phZ68m5V9lERTSx6m5QLkdbp5MCnYB
 35DcYdsKCmCfhvzDUskbVTJRo3Gf+9xnU4BEx2Y1UCUoWxV/xJn8DT3V3qG8qjFADmNA
 GUmGnfd+tkJ88/+9A8IqK8idsMiPM/WwgLDBUpBuXlFNvWhXVNoV6XYZB/HYre89+Kuy
 NgoReRkseZ0OG5ArTYNPkcRlAsdppUJrLH5dzQxzTRNUMCKNHCeAUHeciySITt4F+mzd
 9SKA==
X-Gm-Message-State: AOJu0YziQOYaWTqW/+77rCh64ps4GfHJ7sJsNH2JGt5LwQmLtxiElrwJ
 IrDVEyaO1I6YTo+4bd3JuJt30tf6KpD3xdywky0h7fkTPxtMzRYHl+LOHbJWzP2PTol0C4dDIDy
 q
X-Google-Smtp-Source: AGHT+IEyy6ULhG52MpQdX2g3crtUebWcaH+0wZKxuHkQedpdcKOON+lYR+/3zegN/lPe7BlPi5yTKg==
X-Received: by 2002:a17:90a:ba18:b0:2c2:4129:aeed with SMTP id
 98e67ed59e1d1-2c27db49769mr3478487a91.33.1717608181983; 
 Wed, 05 Jun 2024 10:23:01 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/38] target/sparc: Remove gen_dest_fpr_D
Date: Wed,  5 Jun 2024 10:22:22 -0700
Message-Id: <20240605172253.356302-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Replace with tcg_temp_new_i64.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f3c52c7c48..750a3e6554 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -241,11 +241,6 @@ static void gen_store_fpr_D(DisasContext *dc, unsigned int dst, TCGv_i64 v)
     gen_update_fprs_dirty(dc, dst);
 }
 
-static TCGv_i64 gen_dest_fpr_D(DisasContext *dc, unsigned int dst)
-{
-    return cpu_fpr[dst / 2];
-}
-
 static TCGv_i128 gen_load_fpr_Q(DisasContext *dc, unsigned int src)
 {
     TCGv_i128 ret = tcg_temp_new_i128();
@@ -2020,7 +2015,7 @@ static void gen_fmovs(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 static void gen_fmovd(DisasContext *dc, DisasCompare *cmp, int rd, int rs)
 {
 #ifdef TARGET_SPARC64
-    TCGv_i64 dst = gen_dest_fpr_D(dc, rd);
+    TCGv_i64 dst = tcg_temp_new_i64();
     tcg_gen_movcond_i64(cmp->cond, dst, cmp->c1, tcg_constant_tl(cmp->c2),
                         gen_load_fpr_D(dc, rs),
                         gen_load_fpr_D(dc, rd));
@@ -4345,7 +4340,7 @@ static bool do_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4367,7 +4362,7 @@ static bool do_env_dd(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_D(dc, a->rs);
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4407,7 +4402,7 @@ static bool do_env_df(DisasContext *dc, arg_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src = gen_load_fpr_F(dc, a->rs);
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
@@ -4498,7 +4493,7 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
     }
 
     src = gen_load_fpr_Q(dc, a->rs);
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     func(dst, tcg_env, src);
     gen_store_fpr_D(dc, a->rd, dst);
     return advance_pc(dc);
@@ -4613,7 +4608,7 @@ static bool do_dff(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     func(dst, src1, src2);
@@ -4637,7 +4632,7 @@ static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, src1, src2);
@@ -4656,7 +4651,7 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, src1, src2);
@@ -4721,7 +4716,7 @@ static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
     func(dst, tcg_env, src1, src2);
@@ -4746,7 +4741,7 @@ static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
         return raise_unimpfpop(dc);
     }
 
-    dst = gen_dest_fpr_D(dc, a->rd);
+    dst = tcg_temp_new_i64();
     src1 = gen_load_fpr_F(dc, a->rs1);
     src2 = gen_load_fpr_F(dc, a->rs2);
     gen_helper_fsmuld(dst, tcg_env, src1, src2);
@@ -4763,7 +4758,7 @@ static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
         return true;
     }
 
-    dst  = gen_dest_fpr_D(dc, a->rd);
+    dst  = tcg_temp_new_i64();
     src0 = gen_load_fpr_D(dc, a->rd);
     src1 = gen_load_fpr_D(dc, a->rs1);
     src2 = gen_load_fpr_D(dc, a->rs2);
-- 
2.34.1


