Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F354C021A5
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo4-0006oX-7P; Wed, 12 Feb 2025 17:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKo0-0006ly-47
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:04 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKny-0004SU-8O
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:03 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220c8f38febso2692845ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397721; x=1740002521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z46Rzxp1rqHOdnC9w48Zi9qlaZaCm/K3R1IX0q0/ej4=;
 b=Yt/4/G3LfUbTazORFgpOb1v7nFlbaNPSoQVgbTjKZLx5hSO3WQAbLuIba2y+LYTqcT
 Bdw5ja5918mws2U83t+q6TenC4STUfT8Ok4JLvk1UFJZv8qq7cSkV4PrB8Z2L9wSUtcM
 uEqUoJLf5W0AmhS4Z7G4d2YhlaHl75UMRxGQ/fqoV0iKMTFiNt1bVxRLUjw2bK0AuKnn
 g9M39ClqpMKz/CNI1hoixbKDiIs1Qo8OF2XmpsP+c6uO8LWVGI4fqbHQQo0G9phWilY/
 3LJ51Rlq13gIeofXJQvgQxyIArfR+TD5pAxgPb1/YOtzMIJih8NApDZB/3+PzXiL4wbQ
 +y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397721; x=1740002521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z46Rzxp1rqHOdnC9w48Zi9qlaZaCm/K3R1IX0q0/ej4=;
 b=FYMJiUyjaukZvgzYk0l+fHmyN8+32hI9Z4YRI1Jch3VGP4Q24hogleQJNFCWrZ/pID
 /PfJqXV6eI213DjhAl4UjPviq8K181CS4tbAwvXPoZWR8OCzexC+Tj99VBh4go97Jb31
 9wyEh9KvT4xIw/ZgGkyk6fBjcsVG9yheRR0+On/DK0HKKbbgoNPzRzOdEiPtxzSBP/D3
 oiXVuuo5J4L8lc1koZlf/DPgLHPUOIEErBTwf0QfrYEgSjqsFLiAA8eZgP9UCGcByrpe
 uwnisPxCNtj/pgPc9DqeBvzMA8O6sHZeX5Kjfw7Pjbo+wcTQ+o+bFqWjfK2DMxNcMeYt
 3bpQ==
X-Gm-Message-State: AOJu0YyD+YSYCXzen7xnpKCt5FUg1D5Yothk9CcJmeOHBqsVddJXdj4P
 iE04M1fmSa+X2k95YOM8WIzh2r9xYIYMwx16jNPcAzeTLr/MgWAxha1X9FVMHqkoCs0ppViI+5U
 w
X-Gm-Gg: ASbGnctIPWxBMJR/hjlZYy4Mse/ae30ycYJvNDS/YXhWlFLCVPKVKJPL+i5PFmgfIMQ
 /DEymAhSE4rNmboLwFyeA9EWXEUWt1VrxtRu1t5s0Y8lIGwJPsnYUT6dLAtTLL8pzxBKVr+21dP
 RTk28Vsz3hZAB1uuKYrQ0XTPMCijybgm85pRvULU8FrTwZOum0NedCoH8k51zE+48R0LRSGTggm
 atUkkLstYxpBtIpYIWdfWrIETYuh9Zd0ZrdCSimjnWPqZfmfP0SXWIK/8B0Wqco8ewDvbbZFKn3
 EelN+joZpYWKqy+ofFd3bl5eUA4aUcR3uIWJwREBD0+fBxY=
X-Google-Smtp-Source: AGHT+IFgzfTNH39SvTnCVA61TkR3SyPee6oITqld97Ks2FaLLLHcH+sgmHEKKQyJ61AvGBpn0LoCZg==
X-Received: by 2002:a17:902:fc8e:b0:215:a05d:fb05 with SMTP id
 d9443c01a7336-220bdfee6a5mr84096335ad.32.1739397720790; 
 Wed, 12 Feb 2025 14:02:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:02:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 5/9] target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
Date: Wed, 12 Feb 2025 14:01:51 -0800
Message-ID: <20250212220155.1147144-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Use an explicit 64-bit type for extended addresses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 549013d25e..a1d81b0166 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -666,23 +666,23 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 }
 
 #ifndef CONFIG_USER_ONLY
-static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
+static TCGv_i64 compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 {
     int addr_size = dc->cfg->addr_size;
-    TCGv ret = tcg_temp_new();
+    TCGv_i64 ret = tcg_temp_new_i64();
 
     if (addr_size == 32 || ra == 0) {
         if (rb) {
-            tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
+            tcg_gen_extu_i32_i64(ret, cpu_R[rb]);
         } else {
-            tcg_gen_movi_tl(ret, 0);
+            return tcg_constant_i64(0);
         }
     } else {
         if (rb) {
             tcg_gen_concat_i32_i64(ret, cpu_R[rb], cpu_R[ra]);
         } else {
-            tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
-            tcg_gen_shli_tl(ret, ret, 32);
+            tcg_gen_extu_i32_i64(ret, cpu_R[ra]);
+            tcg_gen_shli_i64(ret, ret, 32);
         }
         if (addr_size < 64) {
             /* Mask off out of range bits.  */
@@ -766,7 +766,7 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_helper_lbuea(reg_for_write(dc, arg->rd), tcg_env, addr);
     return true;
 #endif
@@ -798,7 +798,7 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, arg->rd, MO_16, false);
     }
@@ -833,7 +833,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, arg->rd, MO_32, false);
     }
@@ -925,7 +925,7 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_helper_sbea(tcg_env, reg_for_read(dc, arg->rd), addr);
     return true;
 #endif
@@ -957,7 +957,7 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, arg->rd, MO_16, true);
     }
@@ -992,7 +992,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     if ((dc->tb_flags & MSR_EE) && dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, arg->rd, MO_32, true);
     }
-- 
2.43.0


