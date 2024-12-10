Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878EFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26E-0004IF-9X; Tue, 10 Dec 2024 10:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL267-0004Gq-Sw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:29 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL263-0008KN-Ix
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:27 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eb4da24f3bso1156722b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844262; x=1734449062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jxlQMNQObfmK2RVW7iMpz96pfHl/dvmXgPnDGNhRgT4=;
 b=aCA2sAHsbZ5q0E6FYr7IAJVS/5BCaGawdrBUN5Lj8Fc2+4fUrCXgHEIL8RWelF2lxE
 lGY8rdsu4aEeOMnSCpyoUG6MgIh+ydy8WQ9PNXUBUiH9mTOwL/CmwmjWotgAfOhk+/b3
 rnkbt6rEhHbYpHVTpg2dBYfYJ5ngc/UdpGMPbef6tD03H5mBGVRpEjhVBhgF38hTLAg3
 2edJ2FiTs6VbqdqnFw5YKEcgQfvZzXAsrz056jWg8uW3mKBhyYrq+4yBEYU2IiznQtFV
 PS/uLMBQVSYDtRxZRAJJwcBcQPh1ViiV/N2oijnFt4JInDPDgmt4ataMpfH8eqngOMeK
 bIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844262; x=1734449062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxlQMNQObfmK2RVW7iMpz96pfHl/dvmXgPnDGNhRgT4=;
 b=Y53uBYeNUAYPQwJbjPkqc02AQaQeZpEcGiA0vGkGRCIAsI9Bp67gps4e2LAYLFU8SF
 2EvnK539UXMG5xS6rcUj8/cFhfFe5bKWeK1KIBIvlgFgA7Gnxq9dc1DTENlZXAKOJXbE
 F/LgTGo0lrMOwjQalVTttgeRhvMly83ZI02VgAJllsGMTnrls7D23QME02hQy9EdykRU
 suiPZgOYrJ/ITOApqwmhm1vWdivxqLL7qO6VhVV7C+J5XcfiN+pYlNQ4EiDycZfVXmO8
 pWFY1yQrOkf0IMy8sSufv9MV6ngfUvXJgdhYdqJnDDTjuWJtSyE/Nrh+k85q9/L7HwaY
 HQbQ==
X-Gm-Message-State: AOJu0YxpnzKrz5tFUII0tIVBCJQ68B+VPlQEuPOfrDwV79jB0yGMIo/b
 KL4Ad/eZFjWnDk0GC5LP9uQXsrQwyfDBaZeFhrQZF3/fdPqHsKflxHnvqWlhUgw/g8RLgEMdY1F
 AJ5IqWFUK
X-Gm-Gg: ASbGncv5AA5k/zc0HBdj0KoR5nqFk30JB3g/O/xtL4sfh1kPTEf4JgKvboXQqtPtDur
 Ee6OcVBCsB/Jpddmr/ekX/ooOpuK1p6D8Sa3UZ+FcBzwyEf8acCboCx/Ipr3d60aKSUeonycKTZ
 0OhB0TWw4/f27HUcZYFcXCpuJVC9mTWGqStyZpkPLYzLEXxeBbXJUdEsQiZ96Ni2weJ0OS+1FOp
 DHErp/i6DRSI7ZeUCe6swUL0TrRDEmsWtmKAygXAU69+LAjmQB6kuaL40MhvQ==
X-Google-Smtp-Source: AGHT+IHE+YfaI7b4xi44MEdd8xOB0QI+L/jQgS16dwyjbiBo8mAlLd3OJF0/XmgO/gFGqdulLKD4bQ==
X-Received: by 2002:a05:6808:10cd:b0:3ea:5d19:63c8 with SMTP id
 5614622812f47-3eb19c16723mr13291299b6e.6.1733844262474; 
 Tue, 10 Dec 2024 07:24:22 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/46] tcg/optimize: Use fold_and and fold_masks_z in
 fold_deposit
Date: Tue, 10 Dec 2024 09:23:26 -0600
Message-ID: <20241210152401.1823648-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When we fold to and, use fold_and, which sets s_mask
and a_mask more intelligently than we do for the
rest of deposit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 424ed7674d..4d5fa04199 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1620,6 +1620,7 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
     TCGOpcode and_opc;
+    uint64_t z_mask;
 
     if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
         uint64_t t1 = arg_info(op->args[1])->val;
@@ -1647,8 +1648,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         op->opc = and_opc;
         op->args[1] = op->args[2];
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
     /* Inserting zero into a value. */
@@ -1657,14 +1657,12 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
 
         op->opc = and_opc;
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
-    ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
-                            op->args[3], op->args[4],
-                            arg_info(op->args[2])->z_mask);
-    return false;
+    z_mask = deposit64(arg_info(op->args[1])->z_mask, op->args[3], op->args[4],
+                       arg_info(op->args[2])->z_mask);
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


