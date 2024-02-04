Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8210DC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEs-000245-EO; Sun, 04 Feb 2024 16:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEm-00022x-BV
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:16 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEk-0003Vr-Qr
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:16 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7393de183so27249295ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082873; x=1707687673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdjLaL1s4T12GYUYF4WyCqbK9Vrp5G+xso0HVv7zwQk=;
 b=hbTtkZbJlo2GsjUFzTHMv99axI2dUFEC5QQPagb4+c8SQtYtZTRASAPmcDJA8gLvjW
 /+Ygst5/5etzA5/IxHGbApVc4b2BQoVtiX8xy0h/90YdpeCJCizg0MCvDRo1TJ/mmGJw
 HB4F+yGZTj9MTPrTGEm2tX93gJUfrH2CPc+Gx2H36YUQQRHbSDOF1ncbHg1na4PieHso
 EuACX5qsmDMPpaxGcqyVMoAO+YN6uSRpt2UG5DhLSzNTYRCImKNRRYAoPIkAzkOEEqSG
 OouCFwglgZEjwuKD7ZS3jVtuBaUA5te2nubWzjxhuWLWiPKTpC9cZkWdCJT0azhAthUt
 fM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082873; x=1707687673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdjLaL1s4T12GYUYF4WyCqbK9Vrp5G+xso0HVv7zwQk=;
 b=JeHZtZah5WIRoCYT+Pm0J2FKmA0Vman/L8L/p+d+3Z3s2wg1JPPVdl8XddaFQuMg9k
 CJq3JKddgr0rse2TUwhxEkw6O7IXIRnNXgDwYkg4nLe3cE/zsWwbolOX6qPQGhEWWUno
 g1CjC9rtt0IhzG8fxSW4GmUTwOjJp2RVK5AhWDh9ond1CqLjm3rQPjy+xpU2yW2+fCfv
 RwR65OaFmPnvVLYdVyS3BQZnQPR+to+sf5n14thK47oFhtChlKtgOM92PI5DNmn5P7W1
 8c83jfl7dThF3gLyNDIDayAz0Cjc8fK/u7a/GT3GpZ5X86LJ6M8J4Vi1CdnyqENv3J6u
 ixvQ==
X-Gm-Message-State: AOJu0Ywa2sq/ISdfkL1/J5BEnQvUNWSENV6QO23LQSYns0PL2KQ2CtWM
 KFHyHwPBjXNweAjC1ELHNLrRKfPvtXWfxrsgWOhGTACPTMGDFuLbgdimzW5AMH3p8Nq60NEnKWd
 si7Q=
X-Google-Smtp-Source: AGHT+IGPo6AN+k3eYictY6MtHruKN606Gy2t9S4OEfVAeDnJ5Ocg7PN0T0WlMJzXIMtMDBJzipjaXQ==
X-Received: by 2002:a17:902:6503:b0:1d9:50ca:c4e4 with SMTP id
 b3-20020a170902650300b001d950cac4e4mr10052932plk.27.1707082873451; 
 Sun, 04 Feb 2024 13:41:13 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/39] target/alpha: Pass immediate value to
 gen_bcond_internal()
Date: Mon,  5 Feb 2024 07:40:21 +1000
Message-Id: <20240204214052.5639-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Simplify gen_bcond() by passing an immediate value.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231108205247.83234-1-philmd@linaro.org>
---
 target/alpha/translate.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4b464f8651..e9cb623277 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -453,13 +453,13 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
-                                        TCGv cmp, int32_t disp)
+                                        TCGv cmp, uint64_t imm, int32_t disp)
 {
     uint64_t dest = ctx->base.pc_next + (disp << 2);
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, 0, lab_true);
+        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
 
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
@@ -472,11 +472,11 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         return DISAS_NORETURN;
     } else {
-        TCGv_i64 z = load_zero(ctx);
+        TCGv_i64 i = tcg_constant_i64(imm);
         TCGv_i64 d = tcg_constant_i64(dest);
         TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
 
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, z, d, p);
+        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
         return DISAS_PC_UPDATED;
     }
 }
@@ -484,15 +484,8 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
                                int32_t disp, int mask)
 {
-    if (mask) {
-        TCGv tmp = tcg_temp_new();
-        DisasJumpType ret;
-
-        tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
-        ret = gen_bcond_internal(ctx, cond, tmp, disp);
-        return ret;
-    }
-    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra), disp);
+    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
+                              mask, disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -533,7 +526,7 @@ static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
     DisasJumpType ret;
 
     gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
     return ret;
 }
 
-- 
2.34.1


