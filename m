Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461F2D24456
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz14l-0002ZK-6e; Thu, 10 Oct 2024 17:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14h-0002WU-Ai
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:52:00 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14f-0004nU-BM
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:58 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso908223a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597115; x=1729201915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNw1KOyLM8nEo9e+Tqv/eWhaE6W1odfPo2L05Z76SwY=;
 b=qgCGpdeerertPAUQsg7FzKCltYHmONbll1s2owFKWOTkGqRwx7kubdEivgIMmDBMCh
 ZunxE+klUOQqmfuzx0vMpP1xJH4cM+zDW4FobD2MjpPe90gDfKdKeULWUhWwlp9N0+HF
 XemhO9P7xjLemX4BkZS0CtfPcfJK9Fb9d4nDeb7W6t09VNiBN31gk/TpsQKNoXKS1ioX
 0HQ9ZwCCW531JGFQ/2lw4YcKVoKuJ8y7hOKgr5MuJcT3TYGHoVZKFtmGkKqKS2G3Psee
 B5Oqxzmn3IMbfm1J1cwzEchmdHkSQkAdFOFwg6WcSFutun5pSdAntiUinfSg1yVHQPGF
 ZIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597115; x=1729201915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNw1KOyLM8nEo9e+Tqv/eWhaE6W1odfPo2L05Z76SwY=;
 b=cD916Di8tu3s+HjHzX0/lJCcaOqLuq5MujOBgUbq83YyryzPja9YDSubrkw9jB5KwQ
 zNqdw/2DNesMfnh3qDltlmIafOzYlJeMUO665XvYH68OewafTkwWovL2kWZ8xlkcvqOb
 /vHXYYgzqOEdImGVBHvckzZbAtyLsTkidSxPS2PdkRrFYcehm2TVMitIaFe/OjdvM+tH
 hXlUX0i+YbkYxUlP4EHJDyHNTH/DNGUIPBiBfh2eW6GsBo/77b+/mqqWC8YPdIDcZWPh
 8+b+a8ZxENA+CE9Z/qmsaixuwM3HJdSGfiXgRDVSdCogyWlXxBrZOhTrLWnRFTgTl9Cv
 z/DA==
X-Gm-Message-State: AOJu0YxHgZQipkvmWx26NgE6D1npOSErb6JSS7DS2r2JL/P+UKbjmxPG
 NC6IKuZHprCj/pkR9eWS0lS9jFUp1JFCBk3fg8ALmuTDUxGKHEQlJtkjXyOG1KqLqLrAfaazepu
 S
X-Google-Smtp-Source: AGHT+IGxLnnk4DLT6oboNNmiMGCjaSryxcqFN7bLMpcpyjx2U4nNvxY1d2iqaHf7oypszNlI/iMoqA==
X-Received: by 2002:a05:6a21:1706:b0:1d8:b15c:f600 with SMTP id
 adf61e73a8af0-1d8bcfb4a2bmr548719637.37.1728597115635; 
 Thu, 10 Oct 2024 14:51:55 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e375d92c8sm208273b3a.82.2024.10.10.14.51.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:51:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 12/16] target/mips: Use gen_op_addr_addi() when possible
Date: Thu, 10 Oct 2024 18:50:10 -0300
Message-ID: <20241010215015.44326-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace tcg_gen_movi_tl() + gen_op_addr_add() by a single
gen_op_addr_addi() call.

gen_op_addr_addi() calls tcg_gen_addi_tl() which might
optimize if the immediate is zero.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h               |  1 +
 target/mips/tcg/translate.c               |  6 ++----
 target/mips/tcg/micromips_translate.c.inc | 12 ++++--------
 target/mips/tcg/mips16e_translate.c.inc   | 15 ++++-----------
 target/mips/tcg/nanomips_translate.c.inc  |  4 +---
 5 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 49ff6b8cd80..5d196e69ac4 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -176,6 +176,7 @@ void gen_addiupc(DisasContext *ctx, int rx, int imm,
  * Address Computation and Large Constant Instructions
  */
 void gen_op_addr_add(DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1);
+void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base, target_long ofs);
 bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 41f25c938de..8ff1d59eb64 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1456,8 +1456,7 @@ void gen_op_addr_add(DisasContext *ctx, TCGv ret, TCGv arg0, TCGv arg1)
 #endif
 }
 
-static inline void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base,
-                                    target_long ofs)
+void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base, target_long ofs)
 {
     tcg_gen_addi_tl(ret, base, ofs);
 
@@ -11265,10 +11264,9 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
         } else {
             /* OPC_JIC, OPC_JIALC */
             TCGv tbase = tcg_temp_new();
-            TCGv toffset = tcg_constant_tl(offset);
 
             gen_load_gpr(tbase, rt);
-            gen_op_addr_add(ctx, btarget, tbase, toffset);
+            gen_op_addr_addi(ctx, btarget, tbase, offset);
         }
         break;
     default:
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 171508f7deb..3cbf53bf2b3 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -980,8 +980,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
-        tcg_gen_movi_tl(t1, 4);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_addi(ctx, t0, t0, 4);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
@@ -990,8 +989,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
-        tcg_gen_movi_tl(t1, 4);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_addi(ctx, t0, t0, 4);
         gen_load_gpr(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
@@ -1005,8 +1003,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
-        tcg_gen_movi_tl(t1, 8);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_addi(ctx, t0, t0, 8);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
@@ -1015,8 +1012,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        tcg_gen_movi_tl(t1, 8);
-        gen_op_addr_add(ctx, t0, t0, t1);
+        gen_op_addr_addi(ctx, t0, t0, 8);
         gen_load_gpr(t1, rd + 1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 3c914a10c0f..09092653fcc 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -130,10 +130,8 @@ static int xlat(int r)
 static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
 {
     TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
 
-    tcg_gen_movi_tl(t2, -4);
-    gen_op_addr_add(ctx, t0, t0, t2);
+    gen_op_addr_addi(ctx, t0, t0, -4);
     gen_load_gpr(t1, regidx);
     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                        ctx->default_tcg_memop_mask);
@@ -146,7 +144,6 @@ static void gen_mips16_save(DisasContext *ctx,
 {
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
     int args, astatic;
 
     switch (aregs) {
@@ -286,8 +283,7 @@ static void gen_mips16_save(DisasContext *ctx,
         }
     }
 
-    tcg_gen_movi_tl(t2, -framesize);
-    gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
+    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], -framesize);
 }
 
 static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
@@ -309,10 +305,8 @@ static void gen_mips16_restore(DisasContext *ctx,
 {
     int astatic;
     TCGv t0 = tcg_temp_new();
-    TCGv t2 = tcg_temp_new();
 
-    tcg_gen_movi_tl(t2, framesize);
-    gen_op_addr_add(ctx, t0, cpu_gpr[29], t2);
+    gen_op_addr_addi(ctx, t0, cpu_gpr[29], -framesize);
 
     if (do_ra) {
         decr_and_load(ctx, 31, t0);
@@ -392,8 +386,7 @@ static void gen_mips16_restore(DisasContext *ctx,
         }
     }
 
-    tcg_gen_movi_tl(t2, framesize);
-    gen_op_addr_add(ctx, cpu_gpr[29], cpu_gpr[29], t2);
+    gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], -framesize);
 }
 
 #if defined(TARGET_MIPS64)
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index a32b4c1d4f8..d6149ea26e4 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -2469,11 +2469,9 @@ static void gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
         } else {
             /* OPC_JIC, OPC_JIALC */
             TCGv tbase = tcg_temp_new();
-            TCGv toffset = tcg_temp_new();
 
             gen_load_gpr(tbase, rt);
-            tcg_gen_movi_tl(toffset, offset);
-            gen_op_addr_add(ctx, btarget, tbase, toffset);
+            gen_op_addr_addi(ctx, btarget, tbase, offset);
         }
         break;
     default:
-- 
2.45.2


