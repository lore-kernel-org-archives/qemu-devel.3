Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655F0C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYH-0008QE-J4; Wed, 24 Apr 2024 20:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXp-0008GN-HS
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXl-0006H2-4x
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e5c7d087e1so3726065ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003251; x=1714608051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4k0GmsyyHp6l3HUJNBVWsFzARFivg/eO6L4ms+jh8b8=;
 b=j4XeJnoD6M1UWKM7m0qL3RCEe3oci08ZtWbD4LjBc4nE8ygTkFyJv14+Ze5ZWwVdXs
 cYS+sfL4dOJlLpELCUYAbdkL1YcckahcJe0NPRQIGB6mQFQ4Q9fK2+6fl91XwiLg/X5a
 mOZUJslemo4s5zSdv18WV2prDICGvDZjtSsmumgSmxOirvcbKYem/NzYdXQNZvo4XfTB
 nKK4t/Ve0sI6lFdQxvm5DYhomwpp5ZcnkZRSjipyZhbcVRv5tCL1v3pQYsQqqnLg2iRm
 zZl+TuWigG2ovqcCtfvkROasAW3kktX3cH0MZ5IBRbFLr7Nya00snmUVOjvWWZYJx/ti
 32ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003251; x=1714608051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4k0GmsyyHp6l3HUJNBVWsFzARFivg/eO6L4ms+jh8b8=;
 b=o6DkeLB5SIfUNwps3CFfAa8Geq03yKL6imbLQdc/j16GYZufbzSZv0KzkvpyYuvAaw
 QuAO0aTQkHDAOhAqPp0WdmYYLBt05b2dPXO50m9r27mg2JF4LW072n3IAKSgqgD75R3i
 xORmfXCS5zTbc51dVTEuujXveoOuBdX5AYiy35488f/t2r2vOaLy4DZGO+VfxHQ76Y6a
 Im7/qV/5sayERRnX43SmonuWfjXL8ZVBRmT0w4fnyZlC/NN6gAIaKw9GdxdnLbZGVKlI
 OFQaBtj77BFbOWniPFhhjY7THIvwjLgehTU/ilELzW0CQtMU2J5qctA5VN6w4gMmWKKl
 Lk3g==
X-Gm-Message-State: AOJu0YzvwkVGOT2OJYFjdOhzvGRuxAi6f0MgqcRHqFfvyu2sEpPfIB9p
 SBG3iXNtHF3k8i7Wdv5P+YxsvEkwL/zRQ9SDmttwrCoZByVFLgRHY/DD4uHL6dmia75h5u+bFRH
 m
X-Google-Smtp-Source: AGHT+IGaHspIF23qCZG9hocVreAWRRozgkpSbFKiwjBo4KoRDU9OqsuL/Cij2GFCyJJySm/P0WLrsQ==
X-Received: by 2002:a17:903:2b03:b0:1e0:e85b:b9ca with SMTP id
 mc3-20020a1709032b0300b001e0e85bb9camr5949473plb.21.1714003250919; 
 Wed, 24 Apr 2024 17:00:50 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/45] target/hppa: Use TCG_COND_TST* in trans_ftest
Date: Wed, 24 Apr 2024 17:00:04 -0700
Message-Id: <20240425000023.1002026-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4b9092b1cf..b1311e7688 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4309,6 +4309,8 @@ static bool trans_fcmp_d(DisasContext *ctx, arg_fclass2 *a)
 
 static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
 {
+    TCGCond tc = TCG_COND_TSTNE;
+    uint32_t mask;
     TCGv_i64 t;
 
     nullify_over(ctx);
@@ -4317,21 +4319,18 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
     tcg_gen_ld32u_i64(t, tcg_env, offsetof(CPUHPPAState, fr0_shadow));
 
     if (a->y == 1) {
-        int mask;
-        bool inv = false;
-
         switch (a->c) {
         case 0: /* simple */
             mask = R_FPSR_C_MASK;
             break;
         case 2: /* rej */
-            inv = true;
+            tc = TCG_COND_TSTEQ;
             /* fallthru */
         case 1: /* acc */
             mask = R_FPSR_C_MASK | R_FPSR_CQ_MASK;
             break;
         case 6: /* rej8 */
-            inv = true;
+            tc = TCG_COND_TSTEQ;
             /* fallthru */
         case 5: /* acc8 */
             mask = R_FPSR_C_MASK | R_FPSR_CQ0_6_MASK;
@@ -4349,21 +4348,12 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
             gen_illegal(ctx);
             return true;
         }
-        if (inv) {
-            TCGv_i64 c = tcg_constant_i64(mask);
-            tcg_gen_or_i64(t, t, c);
-            ctx->null_cond = cond_make_tt(TCG_COND_EQ, t, c);
-        } else {
-            tcg_gen_andi_i64(t, t, mask);
-            ctx->null_cond = cond_make_ti(TCG_COND_EQ, t, 0);
-        }
     } else {
         unsigned cbit = (a->y ^ 1) - 1;
-
-        tcg_gen_extract_i64(t, t, R_FPSR_CA0_SHIFT - cbit, 1);
-        ctx->null_cond = cond_make_ti(TCG_COND_NE, t, 0);
+        mask = R_FPSR_CA0_MASK >> cbit;
     }
 
+    ctx->null_cond = cond_make_ti(tc, t, mask);
     return nullify_end(ctx);
 }
 
-- 
2.34.1


