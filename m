Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714C4E7718F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOp0-00058O-Az; Sun, 22 Dec 2024 11:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoW-0004sy-Nl
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:21 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoV-0003jP-5f
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:20 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2164b1f05caso31209485ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884898; x=1735489698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XK7HdFgJI1aoovKqrgnwds0J6drlE9NjhtggGFHKYgY=;
 b=m5/9KCZmKC7J5ya7dzFr0BLepydnzgq/7AoWLGXoHm0xoqhlYXO4oBwr6u9tG/PLpJ
 QsLsTt2khA5XuYte3NlgEA3pGi/uJKkY+pjDSJHUw4WDl2ryXt14i+yg4yzXn8OF3y+V
 lHad86WVvumVrTDiCQeyrOdELsSUh/OAdw/9NbHrMcx4lT3B+pDRBkLo1kwSB8NZ6i84
 zFyA9kGwUTXozbj/s264O1Kbd0jDa+xmnLMWeiFvQKtRYpSR1nmSQGIalWlrq/IqycY9
 Zi+/TKvyK11oy2HpvWz56dt736HG+GIDpJ3x+4T7DHSxRvB0BL2ufk3c3l6Q8dSBqj3t
 QSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884898; x=1735489698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XK7HdFgJI1aoovKqrgnwds0J6drlE9NjhtggGFHKYgY=;
 b=Tc3IC4XXhEgLcVCuLuZGxB7Rr1ui4KSAD3GueMPEXtRJkY67VKu5xKISRNqf6uKrVF
 MOGa144VESb4ZsoYJBoQiICBimQP8+rByO1sfh4PLHbHMKvQuJUbba75Q2Wca1o/Jn5Y
 GDHOafsBNq6KfdlaF1wJOH35Kx+heAl/4A0QQ9je04OQ2Cy06Imt2waVuQmb9YhTVDsD
 rdoobxZhkKuzVOM9TVMydUeqryejCiluyrXiqrytPbgo+U6dqeHZ0THd3bmuPDEmQseD
 JO/5g7Z6edgh/awiQM8ooehsXFveuGVBVxb8WkHGqMBPJcCXLDAcitKIL94YPSMzi+Z5
 P/jg==
X-Gm-Message-State: AOJu0Yxs3aGoA6KoBhLQEC5f7Tw/fcwJhugCRTQ1xnMZm10NLXdgibwY
 rmRZ8CYhzgDmQo0jOha5s1PQ9RZryFEEO5c3dj8sibpuZL7d6+Jbw6rpMXotTIO8p7pZa7dE/Sh
 7N7w=
X-Gm-Gg: ASbGncseCwgNEdAFg/qyNDwABndQ6sUN1JIcVGcR1ihEZJPC4Jm6oMHzPSaUEMrmUPr
 yXq9N4gJNbwDQHuBoZSR0jxhWPseB6+8CQKwAZFLTDFm93Uqa2apWZrxEKb5O8yV54OhDixTbIk
 ugLICwN9V3zB1mkF5b5jeghZ5WIFPkNRq/d6IMq0UeaCzI/PaV7Co1Kyubw8B/qs7zlEkFOk0sy
 wHIh8XF+niLx6JGpPVfpBL0ev2gXGccpu1cZdY+LvQ95aPoZFy8hzGi/bCKWgY=
X-Google-Smtp-Source: AGHT+IGiEdWdZUnraBq2kVlozGbMMpVMExMyKeHZCFp4pUBMfJ6BVev8QakyHJm4Do4k5PcKTu3M4A==
X-Received: by 2002:a17:903:1c2:b0:216:2c3b:61ba with SMTP id
 d9443c01a7336-219e6f3320dmr113457375ad.56.1734884897926; 
 Sun, 22 Dec 2024 08:28:17 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 45/51] tcg/optimize: Use fold_masks_zs in fold_xor
Date: Sun, 22 Dec 2024 08:24:40 -0800
Message-ID: <20241222162446.2415717-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.
Remove fold_masks as the function becomes unused.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 48324f122a..0cdbd1e262 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1063,11 +1063,6 @@ static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
     return fold_masks_zs(ctx, op, -1, s_mask);
 }
 
-static bool fold_masks(OptContext *ctx, TCGOp *op)
-{
-    return fold_masks_zs(ctx, op, ctx->z_mask, ctx->s_mask);
-}
-
 /*
  * An "affected" mask bit is 0 if and only if the result is identical
  * to the first input.  Thus if the entire mask is 0, the operation
@@ -2752,6 +2747,9 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xx_to_i(ctx, op, 0) ||
         fold_xi_to_x(ctx, op, 0) ||
@@ -2759,11 +2757,11 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    ctx->z_mask = arg_info(op->args[1])->z_mask
-                | arg_info(op->args[2])->z_mask;
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z_mask = t1->z_mask | t2->z_mask;
+    s_mask = t1->s_mask & t2->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


