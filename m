Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B41C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoT-00025k-Ab; Sun, 25 May 2025 12:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo6-0001mf-J5
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo4-00036Z-JN
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso17636675e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188954; x=1748793754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qePmWWXgxnxC8EgpTPJrdJSihex1YCPIe/WXpW/iZ68=;
 b=H/UwtqjncIN3h5/SVIpwEP/BLuSGikag6aHgg5go4AwuUdST9zTY6Z2J2bU7lhhP5j
 hLDpMWMdYiUfrqA1wveLwrlZsPZeNouspWEg8YryXudT5pSL/cLVS3cwLvP/ylsnjpXe
 7QFNe/a1Yi24749s0HXrMPzzG5O5YP4YWONNuj9vfAIxVZOLTn01tA66wYbWWe/+1KNk
 7s/v49y8pu1KJr2c0JacEoiTuXhwTNBZkuW5dAartVPzZytZqdj/jRI2+r5iiK9Z0FQL
 I+W59dShX/sXLk4VkTYya/+X8xvmlZroLcKhjs/bIX8504Mvo8EmpYLExToDkFuEpCsC
 SD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188954; x=1748793754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qePmWWXgxnxC8EgpTPJrdJSihex1YCPIe/WXpW/iZ68=;
 b=Beem3aJELzoRDGQAYYdGfUoSxsjSuiec1WPlNStQTwKpbrT4CM+K4gKCzXGPBwahnS
 +HFKnXVzr4WxsoQD6tkdO1sLlmMdgsTFJc0PLcAp14RhcW+KpENnfF1nn97URNWinpeN
 HVQry7WxqADfTlI6tpp/apLxze4SYNxGW+65PyfQX56Lo5AvsoSWMNd23qXejpp0xmLR
 I7IqJCvCofFJzDeEY4mVQVXQw/OtkKDipSHgkUOCLv/c/p2OksKWZsmqDyc/TUfte/Gi
 ksKQZN+VkceEaEZF1MExsWA8DlUjOX3eCHo9YgLf7YPi5y/2SEFIibsTa9ASmQqimTvY
 GnyQ==
X-Gm-Message-State: AOJu0YyhMdcxoH8moaNtSITsV9+VRSPYnTcc7MKrzL0mf4u3gEo0jQx5
 jX4XVqWJCtS/li0ghT9aNOFK5yxtdlqujrPQN62uG8s47sJRC5M5/Zo7xVLEuJIj0MxE5sNQlZF
 lfx0i5D8=
X-Gm-Gg: ASbGncsvbMyai+k1MnKcp0+GA+7SVEgJ+ONdoWokrKnEuYTeP50k4KBabe1Rxu2HFmj
 /h2hZDGk9c2s2kD5P9Ol/OjoIQZqCrmVK42KfStjigaxkN+Cig70D0fV15RFS/O4StNq68AgyhY
 AGeHWusoqqSIeYBhK9LzdtBKI4HOh5BJ9xwS6qHPzsw8oddjyr6yksFQtCThmsW81P/ZMELlr3h
 +kD16qDuqG3tozjhPOEes5bxaEjFBrqLvYdSh52p2tD+T7xZRj7ApE8pq6dAilmMOgSlXT9gJ8f
 cDaLfgAH6yoxYebziACfDMBZBxYr8CzUwpzK4YdQVhcb/JY/MIg5NROO
X-Google-Smtp-Source: AGHT+IF/wUJM2459oYMWgpblO3zNFpGXYEL7CD1f9mAWcEKlY+Y7AUOepIfgzS3mE/iPMn/6TVNI/g==
X-Received: by 2002:a05:600c:4fcd:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-44c91ad6abbmr49054965e9.6.1748188954343; 
 Sun, 25 May 2025 09:02:34 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 06/10] target/microblaze: Use TCGv_i64 for
 compute_ldst_addr_ea
Date: Sun, 25 May 2025 17:02:16 +0100
Message-ID: <20250525160220.222154-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
index b1fc9e5624..dc597b36e6 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -660,23 +660,23 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
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
@@ -781,7 +781,7 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_helper_lbuea(reg_for_write(dc, arg->rd), tcg_env, addr);
     return true;
 #endif
@@ -813,7 +813,7 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, false);
     (mo_endian(dc) == MO_BE ? gen_helper_lhuea_be : gen_helper_lhuea_le)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
@@ -847,7 +847,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, false);
     (mo_endian(dc) == MO_BE ? gen_helper_lwea_be : gen_helper_lwea_le)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
@@ -941,7 +941,7 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_helper_sbea(tcg_env, reg_for_read(dc, arg->rd), addr);
     return true;
 #endif
@@ -973,7 +973,7 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, true);
     (mo_endian(dc) == MO_BE ? gen_helper_shea_be : gen_helper_shea_le)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
@@ -1007,7 +1007,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 #ifdef CONFIG_USER_ONLY
     g_assert_not_reached();
 #else
-    TCGv addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
+    TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, true);
     (mo_endian(dc) == MO_BE ? gen_helper_swea_be : gen_helper_swea_le)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
-- 
2.43.0


