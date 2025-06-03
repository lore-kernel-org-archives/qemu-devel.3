Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E459BC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMju-0003UZ-Fw; Tue, 03 Jun 2025 04:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMji-0002aM-Mx
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:07 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjg-0005nw-PB
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:11:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a3798794d3so4503071f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938262; x=1749543062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xymrH7QM4U86RLentxPog9De8K7YteKDldYGgug6hEc=;
 b=OkGZO+HWoYg9Dwjnk3N+YR3EEACgvwgiPWjjyNCb8wC9sWTnmMRIcN9yzE88ipv/4t
 WogITvsRD4TNQhMKGjo/n9SauzAbwcPdjAa2U2nOIIPIupT7JT/3zomHzQsxqmtn2TE/
 +MckmKVathxMaVeOB6n9uWVlsVKDJjMhjCQTrwO3S+vKJom4BcL+iOB1ghwJVrZrdJWl
 N7xGAX9TFO7ntdrd4wOpGlmyo5bA96mL5Y05jQN95lm81m4KlvxAqeiTq7C71IZQEeIn
 d5hId0huY6z1LUr0zYdb522jwCZcN8lD1moX1f/dSjjNhHg0ZkKTx4XYzuyvqAay5tAY
 +oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938262; x=1749543062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xymrH7QM4U86RLentxPog9De8K7YteKDldYGgug6hEc=;
 b=LbiGvEu5w4WzlA9KA1L6b9yJbc6RoJ51ecGAiYGKDHpsA+9upLpcbcCL+MnaAgHnd6
 LjjmSbkJKE09AY0f9w+bwNW7ubLTrpvx8ZKgAoU1oHP/Jiq8k7D3qW9lurLC0ZPY3/v9
 uJHnENpqELGyqowREr/krz9feg9iZuws2tkWnBZacKOEpzTyepajgW6H0JBSYqS2uzdl
 NToLO/P1f3g9LHOEeNmOyovqk4ubllk6uKoOAN+fy4sFZpmKp6phO1walfgM05osn+QN
 BEFNazWhBC2cTjmgwrWZyNcbCCRsw5OAK+v9K8dwfD7H+k9eBt44OqXpgrSUrngisZit
 mluw==
X-Gm-Message-State: AOJu0YyrcfV/H9Gp9iRxJTIcVTnyWSbIL/qQAHLJwSLI0ruppgIDQc0t
 zbp5ys46WZPSgxANaGsh4nMFBO5U845C1tn5lkF8Rs/XW9TAUhqhgDHeuDv1MswlvEWWpv+R8O1
 bmBpLWSI=
X-Gm-Gg: ASbGncvAIpGyxfxcUOTyMmhtmtzw6Vba20djIGvau41UYbAv+LjkKARw3V3EaJgMtl3
 mfpiB/rAwKrVLC50yJK1XYEDS4pIdbmyUYdgDu+m2XxSykzyft/0skYZqoMNH8gQ7KAMI5ZA2pp
 5QDC6PfqOAj5cbVBHaQoEL2GEU1g5PqC29G6VIf6VC+6LK1A3yAsxntO3NJDHQdFKDLoXpPhW3g
 gX5QUPRbehTaZ48T8zncpKU9fxKjxTpe3eB9bP1vGl/iOdMtFe1TFRO8o9FkUp5nSSqaD1MPuay
 c9flqQ0Kg/ysMh8f5PFMnm0GandEBYTMM89cE7bhQlYZ4tY9cNO8+OOyvL2/0D5e38f2hZqQ4RC
 x6ewxDggE7t4IoOkTThx2Ve8=
X-Google-Smtp-Source: AGHT+IE+jIJdd2oX/kVhJI6iY8VGkOjXd7C60lSLBaUmOjFPls/znmwfPqsAnE7YeQYxfG0SwXp69g==
X-Received: by 2002:a5d:64cc:0:b0:3a4:f379:65bc with SMTP id
 ffacd0b85a97d-3a4fe39884amr8620072f8f.40.1748938262026; 
 Tue, 03 Jun 2025 01:11:02 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:11:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 17/27] tcg/optimize: Build and use o_bits in fold_exts
Date: Tue,  3 Jun 2025 09:08:58 +0100
Message-ID: <20250603080908.559594-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 86d958267a..103c94b12f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2013,7 +2013,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
@@ -2022,17 +2022,19 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
     s_mask = t1->s_mask;
 
     switch (op->opc) {
     case INDEX_op_ext_i32_i64:
         s_mask |= INT32_MIN;
         z_mask = (int32_t)z_mask;
+        o_mask = (int32_t)o_mask;
         break;
     default:
         g_assert_not_reached();
     }
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
-- 
2.43.0


