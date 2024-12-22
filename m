Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3DDE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlq-0002ta-57; Sun, 22 Dec 2024 11:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlD-0002YS-M7
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:57 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlB-0002x9-RR
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:54 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2165cb60719so32160405ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884692; x=1735489492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntKzLXVCf+dfdJqwHevl/7NkCe78JheCkwV4PXcpwhs=;
 b=bHhGP9vmreempbHsWTza/aPrecf6RZDTlIJNaU8j3C7Htu1a93Tc5lXST5yYVKBZn0
 DUXKCKFV24QPaN6f3mOjrlilNL9IiL1jz1le1ZXVA8ChdK0s5P6YItUhoODI8S0DSk0k
 yfP9BpNGJXIb4yRCUFB38QHIcYTe10jW4A9yRSLYitZZGe3iHntvmXEQZX4a0ZeivqCZ
 bPBMRNPlyCsUUBu4n9BdUUqfO9zM55wMoiHFHP27Y/yUJfG9fJQuOq/C2+6nAidtR9j3
 ptIouQllOklo3mS0B4Ib1XIh+z46qZsYqNxvh608SUyXLOS0gZ5TJQfzWUeGYIQv9vf1
 INcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884692; x=1735489492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntKzLXVCf+dfdJqwHevl/7NkCe78JheCkwV4PXcpwhs=;
 b=NOQ/gu5b5CfL1U1NLkaTPH2dXHO/XvEY/GMUxNMfkwDj9B5wNNEWs5USLNqLRdmmNi
 DOuXmRIlhmYKi3WV/aUyHcNfDNmFq12zyW9Hkd46XUExqE3w+yzvg432NNVbNRT6Aamy
 6zmUot3Eecl2XJyqrUfozdclF/I+r/8QvTFiSWewkdQoEPsslD7hNlHS3bYuwQKMNJei
 7GRbFb9OBSSR+cdwTJMD9TxWjs+j1In6+X39rfjb6gPBDY99U8SOeRR6tybcabdDwUBk
 svojayH58g7bFdI9f6OLSQnuCyZYzwsGk8EqsSF4T0qfNRPeyNjRF3eTo4ii1aZK4w+y
 DN+g==
X-Gm-Message-State: AOJu0Yzska5c4RCFK2eeNeLDoG//cXZ3tGektm92BSW7U4gkCtFAfeAp
 ECbNjxoL89TZAGD0bAdzj4/AFzbf750pZGovZESkmqDMwIqzcUrSiPe4iSrWty44Np0w67V6Jl3
 VBuA=
X-Gm-Gg: ASbGncvynezSyjQ7p3RjXlXyqUvYjxivQwoQUqETIH/vM68mlT9/PggWpg64DocLYaJ
 ZOYEwvp1laUeZlPHROnlzfVC1AyTKGEvrcrT6okDqJcfFZm+6mG1qx62irpWl5y7T35JJ8/nNe0
 lfKOUZ2xJkY2HfdKYKnAQ5K3p+CxiFByrb1MMqhRpyv0Ny4FbkKaBEplZuTGv0LvL4OGFR2HCR6
 ebtjSgqrCAXX32H/XfmdHfnSEp7A3ZgmGAmE8IOvC/XamUOvMWBwXuEYRY6bdg=
X-Google-Smtp-Source: AGHT+IGg9k4kODKC+SHkjrke7dH6Yky+/n/O9a3qBwCp6TN/SXc6sXkWIRquGKZn4nxYZzhGsO8Hyg==
X-Received: by 2002:a17:903:2cc:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-219e6f25d2emr125800395ad.50.1734884692385; 
 Sun, 22 Dec 2024 08:24:52 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 07/51] tcg/optimize: Use finish_folding in fold_add,
 fold_add_vec, fold_addsub2
Date: Sun, 22 Dec 2024 08:24:02 -0800
Message-ID: <20241222162446.2415717-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index fbc0dc5588..26d1c5d4a1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -938,7 +938,7 @@ static void finish_ebb(OptContext *ctx)
     remove_mem_copy_all(ctx);
 }
 
-static void finish_folding(OptContext *ctx, TCGOp *op)
+static bool finish_folding(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     int i, nb_oargs;
@@ -955,6 +955,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
             ts_info(ts)->z_mask = ctx->z_mask;
         }
     }
+    return true;
 }
 
 /*
@@ -1188,7 +1189,7 @@ static bool fold_add(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 /* We cannot as yet do_constant_folding with vectors. */
@@ -1198,7 +1199,7 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
@@ -1265,7 +1266,7 @@ static bool fold_addsub2(OptContext *ctx, TCGOp *op, bool add)
         op->args[4] = arg_new_constant(ctx, bl);
         op->args[5] = arg_new_constant(ctx, bh);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_add2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


