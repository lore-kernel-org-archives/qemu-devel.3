Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC58E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAU-0003O2-1X; Tue, 24 Dec 2024 15:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9r-0002kw-J7
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:36 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9q-0002YC-4j
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:35 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2165448243fso66700385ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070732; x=1735675532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpqpgVCVgx0sIQuZRDJGY03SPPXo8ssS0CTWPjNfIQM=;
 b=Tx0ERFhmSuQSAnPUkhaOkpsKzaU2ICcLwa7+EWwS6qbL5L2nebL8EbOXPqBG74czwM
 1DlSQFHk2dQda+X/etHqVJSqLcXrnwdOxk+dT3ja585O4ZlGA3MhU5nYwF5P0+F0uO4l
 n86GmhAPX+3mvzBbGeIqTIns6JFqZyxs6AKfhMIasQWeI5mWZKsT3GuWLGZbVMh4UVdv
 QmC3/Z+E/6bKapKryT8Q780jjuWg9RmvxaMOmgK0x6Y5V0vOkrAQEsZ4DgmCO/e1Kf5Y
 6EYyf+hx/pB5RAA8bKo04y+L78tEMVgUbfJT18FEygD00ISnMve+6piE4W4KAe3ui6Me
 V9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070732; x=1735675532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpqpgVCVgx0sIQuZRDJGY03SPPXo8ssS0CTWPjNfIQM=;
 b=ducOX/NDk9suXOYdhsuDA9NDKcuY2bpK+0dVCg85pfSHPI+8ECMVtkCkGiBAn3US3t
 MMro4ZF2Sf2GttaAafgnyDHmLtVFkCPm24qNYzFIMgk5fiJkxNfYDng0heHQ+s7VVimb
 FlsfK5IB24tzAU5SGIaqLa0OaeOU2KTl94xv6NhCcZDixE/wBUt2oMA+TABkQu7uAD9I
 sK7rnt1WBNVDv8exESMvjJ+l89Me0q5rVJiv+SKExmnnAQ4kvG4V5loqnjHbX15dYkuD
 bEiIoHfM455vNkgGCrnjrJedURvywT2EFsqVImSJiWR40rjnnxODbjVba4GmUmw0FXmL
 GgsA==
X-Gm-Message-State: AOJu0YyLxlhZJ+ircqRk++Lk/qilngZ8+k4IXKturwnploc6aDYjlf6x
 Hlw6f6qwiClaLaSeIy0KI4U7m05wmoYYeGFPj5mMDueBqvGaSfMjuYtG7STQfGko8H+YoiDI7Ga
 v01A=
X-Gm-Gg: ASbGncsIvmsmojE085m8AykEwae+ZeoCWK/7lX/75j1hvcilz94aWNJ82s99YLAFmwD
 nAqVDFanhgkzJRRrRx4pBuO61gPoPqcSUZX2pP4zZaq/bVsARbQXivTev+Tn5829ujMW+Ntwx6r
 xxoOXkAeUs7N4ei/aKm4B1Gwi2du6bKEdtphySUOr/WkzBq+iePrFVQxxmArQEeVHrqZ8NTTiPm
 oyr0U0K/Cm+5LIWOBinu1H6If7o0CLnblskOckalNYBppMgfXzIf39o5iTL6wQB+1ZeO2WtI3EQ
 CP99Z4HYDna56XpeaLL87ThBQg==
X-Google-Smtp-Source: AGHT+IHIv/5qI5sgC3qnRqI/s9YrpHiU69uSTCw74PQ79sbECIVOW1NC6Ew3wnS0DWwHQH1HOInm5w==
X-Received: by 2002:a05:6a00:8085:b0:725:e309:7110 with SMTP id
 d2e1a72fcca58-72abdd3bf64mr26835076b3a.5.1735070732617; 
 Tue, 24 Dec 2024 12:05:32 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/72] tcg/optimize: Use fold_masks_zs in fold_and
Date: Tue, 24 Dec 2024 12:04:20 -0800
Message-ID: <20241224200521.310066-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
Sink mask computation below fold_affected_mask early exit.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5090f6e759..4a5b52916a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1294,7 +1294,8 @@ static bool fold_add2(OptContext *ctx, TCGOp *op)
 
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1, z2;
+    uint64_t z1, z2, z_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_i(ctx, op, 0) ||
@@ -1303,27 +1304,28 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    z1 = arg_info(op->args[1])->z_mask;
-    z2 = arg_info(op->args[2])->z_mask;
-    ctx->z_mask = z1 & z2;
-
-    /*
-     * Sign repetitions are perforce all identical, whether they are 1 or 0.
-     * Bitwise operations preserve the relative quantity of the repetitions.
-     */
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z1 = t1->z_mask;
+    z2 = t2->z_mask;
 
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer affected bits from it.
      */
-    if (arg_is_const(op->args[2]) &&
-        fold_affected_mask(ctx, op, z1 & ~z2)) {
+    if (ti_is_const(t2) && fold_affected_mask(ctx, op, z1 & ~z2)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    z_mask = z1 & z2;
+
+    /*
+     * Sign repetitions are perforce all identical, whether they are 1 or 0.
+     * Bitwise operations preserve the relative quantity of the repetitions.
+     */
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


