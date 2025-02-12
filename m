Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2060AC021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo8-0006po-7v; Wed, 12 Feb 2025 17:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKo2-0006nJ-M1
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:06 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKo0-0004TQ-O2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:06 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f9f6a2fa8dso385368a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397723; x=1740002523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtWffR29W1lq+y/owEw/cHjeXtzTBtEfWnTjBGb0sKA=;
 b=yXM1i+HQuFXu8WNXPotrVlc6u4IzdciHjd2O0Eq7jXcq9XyhAARSyuUFBI2BEfUDzA
 NrD2tVILzTIIXu7NEBLFNN4uY0unes76UNTfXN8QHir7Cb2gDuRgxho2Sz4pi/HDOylY
 uHc6ismWbV+CIwBLtJJRHaAoOglP5+lgFm5YlnchE71cgy3AjfxcPKV9ecJXs/qR/xOp
 2d/09JENJFMATw8VevQXeym5KEy/wSol1N8/QlhbT2HanSpes4kYyvBv87/ubfAZ7qM1
 DIIDS5t34Q3ygTwhnK2exQwpS/vbl3q0wr475T0kmsHlSRaJ0AclHNLm04+orlt/5Yy7
 j14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397723; x=1740002523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtWffR29W1lq+y/owEw/cHjeXtzTBtEfWnTjBGb0sKA=;
 b=GE4+dVGhAaxpQajYkoAgncIf/KN3ccgSWyjO8XeeQKtPs97WwFykv/4+WY4bGsNvpB
 lO6muOkke9iM6HS5ZnERKXZeC/1ZK5jJMGUOh3CiBf7a5ALZwYo84O98gpduP97qjNu1
 mXB6k1KSCimRqQUyScc4bwE2cgDV6tThw96CDJzcSD4Q9flGJ12kVnn9zsgpdhk/NSeq
 1XLY12sHFq0frL+HECGIIfH/IPE0Bqo4n9UYcP7pvgsXwCs01wRy0LqZwgXvG3Lvp8fM
 jB7ePGE0nLzSUCSB/he+l4Mgkk43dPJ4rW7W7Yr57yM/DBRPSrZNghYVZKvMcf0a6rwQ
 PPGg==
X-Gm-Message-State: AOJu0YxShRqhSM2JP3hOBYNkxECdbZboABcZr55pc9o1pR+I5vG/rYFL
 49gNh74Zb0JryVOFy7vdICW29LuJiNfNG5orVw50lhATCTrF2+65H0nLUzLvR+04c68qkm3P1EU
 u
X-Gm-Gg: ASbGncuK7KsUxE2pDaR6cp4cJ3DGeGxAsKSE6mwGuZCO4rXTf6cNObYLmCskEIVQ1nM
 /d1K2Z5ARkdGKUqTi8Bp410jK48r/K9zHjBN5j8cBYLJ54dWo+8HWyiwYYberAI2l/f6taVlXGK
 eqEs33R+ExbmpHHttsoLVCwABF4vlWwiifBiwTYiUcpQ+s71YQX5M/9nu+cC3qKACUrZL3X7M3D
 ei/XfBx7kpBWH4s5PWbXcO9WUvRmXV9adf1ek5Tso9w9TW2uFZw++ysaeKJvFzMuh392AV2YLck
 rZbN1xZX58JPl81+mOEmmj1NDmuBZ0VCDTFI9RgEHWdG85s=
X-Google-Smtp-Source: AGHT+IGft4rV9jvl9sq3NbDFnE0+RDbuPHrHsX814KP8PX/t2Ge5z+GmHLySvXkb4aQKcj9bYZiVCw==
X-Received: by 2002:a17:90a:e185:b0:2ee:8430:b831 with SMTP id
 98e67ed59e1d1-2fbf5bc0249mr8048022a91.2.1739397723371; 
 Wed, 12 Feb 2025 14:02:03 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:02:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 9/9] target/microblaze: Simplify compute_ldst_addr_type{a,b}
Date: Wed, 12 Feb 2025 14:01:55 -0800
Message-ID: <20250212220155.1147144-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Require TCGv_i32 and TCGv be identical, so drop
the extensions.  Return constants when possible
instead of a mov into a temporary.  Return register
inputs unchanged when possible.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 5750c45dac..5f3b94e683 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -612,19 +612,18 @@ DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
 static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
-    TCGv ret = tcg_temp_new();
+    TCGv ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
     if (ra && rb) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_add_i32(tmp, cpu_R[ra], cpu_R[rb]);
-        tcg_gen_extu_i32_tl(ret, tmp);
+        ret = tcg_temp_new_i32();
+        tcg_gen_add_i32(ret, cpu_R[ra], cpu_R[rb]);
     } else if (ra) {
-        tcg_gen_extu_i32_tl(ret, cpu_R[ra]);
+        ret = cpu_R[ra];
     } else if (rb) {
-        tcg_gen_extu_i32_tl(ret, cpu_R[rb]);
+        ret = cpu_R[rb];
     } else {
-        tcg_gen_movi_tl(ret, 0);
+        ret = tcg_constant_i32(0);
     }
 
     if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
@@ -635,15 +634,16 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 
 static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
-    TCGv ret = tcg_temp_new();
+    TCGv ret;
 
     /* If any of the regs is r0, set t to the value of the other reg.  */
-    if (ra) {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_addi_i32(tmp, cpu_R[ra], imm);
-        tcg_gen_extu_i32_tl(ret, tmp);
+    if (ra && imm) {
+        ret = tcg_temp_new_i32();
+        tcg_gen_addi_i32(ret, cpu_R[ra], imm);
+    } else if (ra) {
+        ret = cpu_R[ra];
     } else {
-        tcg_gen_movi_tl(ret, (uint32_t)imm);
+        ret = tcg_constant_i32(imm);
     }
 
     if (ra == 1 && dc->cfg->stackprot) {
-- 
2.43.0


