Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB872E7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlv-0002w8-7N; Sun, 22 Dec 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlN-0002au-Qi
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:07 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlK-0002zy-V0
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:05 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215770613dbso22805165ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884701; x=1735489501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/XI5+6+/p9fAbunFiFtbRIOPmiLtR1oJMv0H9QNNE0=;
 b=NbSahlZ58ljPaFlRmCcfot2V0RkOo04SxlDVhd10A85+b7HD0y/ndCFwMLWnoce/1m
 ZCHTNB7RUoD+smVsnCCTo0DAiWRkN/R0EmsqOQh6hK4bxjeGSTzqDec4Zi7VliQkA05G
 gIejB+5PpOMbvhS6hu1ZsqkEaaEmdp1QdirKm+EXwADjb6GIe2ENYTW6dpl5Q8PqY4RC
 q68O6bSPra9buAhioCPgkdc8It5sHIXWPxDaWT27RulfV+6FhRRrc65VLc0dGFlujX8w
 GGQGtNu9okc6tyWWHsxy/B5ZC6BoweeXxxWp6icTSEN/2HCpWZQ9YQv8txc1ZxbVw/Ir
 68gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884701; x=1735489501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/XI5+6+/p9fAbunFiFtbRIOPmiLtR1oJMv0H9QNNE0=;
 b=X2wgkxtfxC5Hh3Z8gKYZ9w0lio25qTwbVYGfaNBOb93+jDs7+Z7xfH1CI6q9Zk0Z/S
 8bgFHkC/8OA6/FbaVA4Vyvx3YNExg0dA2R4PmRXdK+liPW6taxNzb+UrFPxLpv+Da45+
 McApXJHNVgFe7N1nuJCX9H0Gz58UKpQAUr/97JTwfFNL3lL2d39BXVEWaJiP0PIbRQIi
 cbnns9W/Q+qKcmFviZM6X12z1ZLOnGYbUSC7cauzdfgTbKzQWJSHQ1oerqB8f2Jehjyv
 GKJa0kLuR6YCRyE4Mr0EIUhQz6koOmBsm7rV2lreVAPXqqdHIexoyifFykrwuDlSmEjo
 jMFA==
X-Gm-Message-State: AOJu0YweelzdVpmosw4mjdeq10iXw52JSK+Xi95jvdDG6F0ZEeRR4tEf
 Jbtv7ZW2fmLAnlimUZLc0DnBG5Qkv6Vy/IJnPiBb5K1437n0Nr7Ihb3QvyHW8IOLut6reclX/ox
 s6vM=
X-Gm-Gg: ASbGncvyQh4Pry8yDqBrr6OGve5vtKCJIytP9/6w9RlcOLtSYb3tOT0Pkouq6Sf075c
 EX4j0Z/M9vIgJyq8arqZBZ+Goe/LVcu+QV5QECrXiMvZSwAt8dzTOTUz5DrNNkHIcpmK2/L9b7U
 QBuTG1xJtafYPjixSoUe3bEzWMamtLvZwogl5YAaxlkaXMt1zGXNnuRKwgnqI3duIGXL2n5+szC
 LuZxdUkgtg0G+eAf9aFPhGGQZdfa+0wLpTuFNC17a60ploOdwHv2RFPAMcTsqk=
X-Google-Smtp-Source: AGHT+IFFu6gkvoS2ssf097/bmNQd0R+9N+rmHS/zomr+xmJTDLze4BCdx+fLRcZNYMoCpt1BYpcu6w==
X-Received: by 2002:a17:903:94e:b0:212:68e2:6c81 with SMTP id
 d9443c01a7336-219e6ea0223mr153789065ad.24.1734884701601; 
 Sun, 22 Dec 2024 08:25:01 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 22/51] tcg/optimize: Use fold_masks_zs in fold_movcond
Date: Sun, 22 Dec 2024 08:24:17 -0800
Message-ID: <20241222162446.2415717-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index bdf95d1924..5493d76ceb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1872,6 +1872,8 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *tt, *ft;
     int i;
 
     /* If true and false values are the same, eliminate the cmp. */
@@ -1893,14 +1895,14 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
     }
 
-    ctx->z_mask = arg_info(op->args[3])->z_mask
-                | arg_info(op->args[4])->z_mask;
-    ctx->s_mask = arg_info(op->args[3])->s_mask
-                & arg_info(op->args[4])->s_mask;
+    tt = arg_info(op->args[3]);
+    ft = arg_info(op->args[4]);
+    z_mask = tt->z_mask | ft->z_mask;
+    s_mask = tt->s_mask & ft->s_mask;
 
-    if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
-        uint64_t tv = arg_info(op->args[3])->val;
-        uint64_t fv = arg_info(op->args[4])->val;
+    if (tt->is_const && ft->is_const) {
+        uint64_t tv = tt->val;
+        uint64_t fv = ft->val;
         TCGOpcode opc, negopc = 0;
         TCGCond cond = op->args[5];
 
@@ -1939,7 +1941,8 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
             }
         }
     }
-    return false;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
-- 
2.43.0


