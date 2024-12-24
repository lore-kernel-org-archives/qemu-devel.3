Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB356E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAS-0003HY-Jq; Tue, 24 Dec 2024 15:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9x-0002nM-Eo
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:43 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9v-0002ZL-OU
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:41 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21631789fcdso46982225ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070738; x=1735675538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djzRryUm4IchJk8S/iBXoENiUIgFlXm/HpsFU74cNpE=;
 b=rj/TRc9VVY6QbvLbxL1E2cw4rsQcxOV3IvQtzJnArArOsmoMkDDPV5kUq8Kt1UhvYB
 VHQWzgUXbXvHXpM8XNJ1gEs8gfsG+Wk8QeqRLLCcr6LSvmsWvZVw5dQO3xItLwnjg4VB
 ezK7mOCZQY/7SWNjrX04cEgLbXpKo9ALacXVPDO+Or3PgPj5Cq85NGEAuldRdb5UMnOL
 D7IcTstzDDGqV5V3+1mzoYCmu5JnyMu03PMy0eyANcSYRfqV6SD2njtvX7JfaKgTfFH3
 xVDgV2exRo32/GodQDY+N2H6z2GASeBp66vTsrk6q+/pstFs89TKn2CUsTAm/nMb6Rg5
 6d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070738; x=1735675538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djzRryUm4IchJk8S/iBXoENiUIgFlXm/HpsFU74cNpE=;
 b=XZndXuo6S6WLn9x5yOJBX6PODtDGULue6WuC0LSaZftczNKnkgUy+YTOwZktVsCHkg
 pHX34kdZ82BTA02wSpuPABloV8ZjYU0qKV3q8rgE7Gj7Uxaq15b6pqILHZ0GmZ1MsqTj
 62GOGp/JHUZJO10wI6S0OLy6Z9fWWKGSYcjbakfuMrZ6se+ePKxsIQ6FdJCu265wy6BK
 NFJskJcJnghupCvadAvXhPUg/tAqiM+WMCVc0VzVpYZmfa3ERkr6ZY7CKiI4TjrQHfE3
 DEEZjmYqkNsqOc0PAXgrTh5E3XV1c7F3NXQ33CTibOd315R5gNIv1oo6lpdDOKzWoGSs
 YDwQ==
X-Gm-Message-State: AOJu0YyuY842gKf/H9KoI0nB68PVptCk+zo5bDhxK+7zkjgHbvIN6ZmD
 mqI3MfABkc1TbtWPmQyaiLdhU0RvUKxcW0sVyud8DhnrQ0y2eaoE4AsBLk1RXMNubniKmGejMBZ
 lZPU=
X-Gm-Gg: ASbGnctolJUco0hXXJjCBGqd2M/tncRfV/F9t6V/7MM+XNK19gqIOVHPpHtel3Trls1
 7GnsBzBH8sAnC8Li50w5FQo7bQmtxcRxbxqis9NXwvEZMuZZjYbvCoyWwShU/IN80ACKtC2VzFj
 sznBcen59y/84NFqoYjk7ephMhXti3UnDlEOBQ2vXoBhzhDiIQBBMzWmch1ATm06vDppjdVI8z7
 84taNYFeDWwE+munmU3yJ9bozYNOrASmb/ylSIEJYJuTjNagYD9NuSx7UbaZkBt8sb/AmT/Ukxl
 28acGFCwh42Yqss10EwAnuXtZw==
X-Google-Smtp-Source: AGHT+IG5DCUeXwv9rxnBWMvHtKsNkOA42XQZhguRnI2A2jZ40u2cUsaSRCmVJIJRWD+RV6ANQ5vzVw==
X-Received: by 2002:a05:6a21:339e:b0:1e5:f8c6:203 with SMTP id
 adf61e73a8af0-1e5f8c6076fmr14459488637.14.1735070738359; 
 Tue, 24 Dec 2024 12:05:38 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 17/72] tcg/optimize: Compute sign mask in fold_deposit
Date: Tue, 24 Dec 2024 12:04:26 -0800
Message-ID: <20241224200521.310066-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

The input which overlaps the sign bit of the output can
have its input s_mask propagated to the output s_mask.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c0f0390431..b774c96f49 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1629,8 +1629,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     TempOptInfo *t2 = arg_info(op->args[2]);
     int ofs = op->args[3];
     int len = op->args[4];
+    int width;
     TCGOpcode and_opc;
-    uint64_t z_mask;
+    uint64_t z_mask, s_mask;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0],
@@ -1641,9 +1642,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         and_opc = INDEX_op_and_i32;
+        width = 32;
         break;
     case TCG_TYPE_I64:
         and_opc = INDEX_op_and_i64;
+        width = 64;
         break;
     default:
         g_assert_not_reached();
@@ -1668,8 +1671,15 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return fold_and(ctx, op);
     }
 
+    /* The s_mask from the top portion of the deposit is still valid. */
+    if (ofs + len == width) {
+        s_mask = t2->s_mask << ofs;
+    } else {
+        s_mask = t1->s_mask & ~MAKE_64BIT_MASK(0, ofs + len);
+    }
+
     z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
-    return fold_masks_z(ctx, op, z_mask);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


