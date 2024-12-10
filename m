Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE14E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL25x-0004DB-4R; Tue, 10 Dec 2024 10:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25v-0004Cb-BM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:15 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25t-0008Ip-Nd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:15 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea36b05654so2929558b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844252; x=1734449052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7cFEO+uMgJmacMAFlsXy/XFjA9D7UAzv+GZ8zUt5SUg=;
 b=huZHnsRq2es70IJecbzvp0bfwOxIumqixI6pBvBMcnfKBXvQtfo/TyPAb0Cz4TkQlg
 /zCnMLnzrzSy0FlVGzLyQuXa3BrKgyt/n45HrwboG0DI4u8GgP49Q3AfAYjoKRPc43jy
 6YT9Zq47kTjKKVAG5UMY2Zmc269r3923HKdVYcJB0lTeMsZbS8k0Jm1KOmQAVCeYXj2V
 WlL3L+2RcghVp3PLnnM7O0jVLQyqbsF2GZEluZB+xIKrEOvqxKLiduBhQL6zbos2QkrT
 x2faFQsebMwosWKJ7R5e/rMgJoz1PPrbUcTceBOKALF6lKlwk3DeZ/5fIT7CNIaQ+s8B
 uN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844252; x=1734449052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cFEO+uMgJmacMAFlsXy/XFjA9D7UAzv+GZ8zUt5SUg=;
 b=A1IMftXB393DbEYQdJz4vaEZxK2dH4/g9Ie1HV8BCKXxl4aliWq7ET6JPlkJOuezbM
 q0y/MyG07rXU3d+a6fW8IDV6UMgc5B+Dbx9H7xuoSu14HbTYHhxBbHuB0VZsSVXSxuvy
 658OaeYEd6opiAh1PhBUDieYd3N7atTycqcolbrHAmTn1rDnSmxK0aEL47/HcXSoHiFr
 GXfPxzjJb8yAKKEM+qPNxUNj1L1amVELy9qvmXH8rjvcoxZazyLxOFCAoBLRrgdQRVjD
 MEMFjc1/WVMuXviFyGqWVEwHHSY8f6vj/v3b3uqM+1RLE1qvSNSMjoIM7AsBZkcNM3/d
 rkvQ==
X-Gm-Message-State: AOJu0YxcPtaB2Ci+3Dkwaxwkj6urm+8567tUeCHQAJ5gjnYHxhnivrrs
 Rpyd1oH7GR9cWYSOrFYZ0T6S8BHh7GMWvgUK2bGR4y/04k5XbxTSViLpzHnwhmjZO39c/olcxWc
 kRvU/Hrjb
X-Gm-Gg: ASbGnctTpFTV0KSAyrGfa3Ig0WOT2FpN35/uDJ1lEqSPZj0+bas0nkqFl8MXTtVAhkY
 Z8Ovpe03Lozwf4EUKAgwutOYQAeIqHb7A/my6wfXJmJpERort1kLJsn2zGpMDLOdqQp/Col3uwU
 ItRtwJbXpIaPphTnSCmWZqYrgU6oB/PQ97XS4rs2rJEKiN4w2cjTxNqQO/Xz3oTcEiL0Dzhl5n5
 GpKh0qAyRkM256CpjVKGQlv9x9YI/Mw70Ul4+YKNDh2zxMEEd2VZlHXdEKSeg==
X-Google-Smtp-Source: AGHT+IEbrEdYM9kmj8xURsja6jJ9fSbhCvi6pFKm4SqsG1ENeQFSXGEFvPjrqhBtL67b+dt1LZJvpg==
X-Received: by 2002:a05:6808:2186:b0:3e7:644e:3cab with SMTP id
 5614622812f47-3eb19c1692dmr9371951b6e.7.1733844252646; 
 Tue, 10 Dec 2024 07:24:12 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/46] tcg/optimize: Add fold_masks_zsa, fold_masks_zs,
 fold_masks_z
Date: Tue, 10 Dec 2024 09:23:18 -0600
Message-ID: <20241210152401.1823648-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

Add additional routines to pass masks directly, rather than
storing them into OptContext.  To be used in upcoming patches.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1a9e3258e3..6644d24da6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1045,11 +1045,9 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
     return fold_const2(ctx, op);
 }
 
-static bool fold_masks(OptContext *ctx, TCGOp *op)
+static bool fold_masks_zsa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
+                           uint64_t s_mask, uint64_t a_mask)
 {
-    uint64_t a_mask = ctx->a_mask;
-    uint64_t z_mask = ctx->z_mask;
-    uint64_t s_mask = ctx->s_mask;
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
 
@@ -1083,6 +1081,24 @@ static bool fold_masks(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+__attribute__((unused))
+static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
+                          uint64_t z_mask, uint64_t s_mask)
+{
+    return fold_masks_zsa(ctx, op, z_mask, s_mask, -1);
+}
+
+__attribute__((unused))
+static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
+{
+    return fold_masks_zsa(ctx, op, z_mask, smask_from_zmask(z_mask), -1);
+}
+
+static bool fold_masks(OptContext *ctx, TCGOp *op)
+{
+    return fold_masks_zsa(ctx, op, ctx->z_mask, ctx->s_mask, ctx->a_mask);
+}
+
 /*
  * Convert @op to NOT, if NOT is supported by the host.
  * Return true f the conversion is successful, which will still
-- 
2.43.0


