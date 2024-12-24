Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A1FE7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9x-0002n8-8x; Tue, 24 Dec 2024 15:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9p-0002kh-Iq
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:34 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9o-0002Xs-5k
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:33 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21661be2c2dso51061105ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070731; x=1735675531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntKzLXVCf+dfdJqwHevl/7NkCe78JheCkwV4PXcpwhs=;
 b=Unh/ig9G8US+z/9RSgAEzWn1xkrz/udN6OUZb20HfBuV+VPNbwG1Q2h49hTLyFq8iX
 wLJL3lMu5kZw2560Gf6uJoK1zYc01SpkECZ3edevYhZ+cCs6cux5GTYUCZ45jhB1Dm9+
 NYT5CkFSN+5IRAzE8rSCt1+e8p7yOUiqUJ9XoP5yc2gtVEgtA7OhvsZmQq53MLdhyKL2
 A8qqJOf8eR5mogiY8VYuggdTpNXut7M7fju7TDF1hTf7PLmMiHA14vzKu8QOwQPz4VLu
 30xT4AglLB8CN9oNWqMRbwUTUeemanAwC93uTA2OeygBZyxuMBNRdGKiKSAAg2plHSAI
 S75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070731; x=1735675531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntKzLXVCf+dfdJqwHevl/7NkCe78JheCkwV4PXcpwhs=;
 b=UFHWZsxuCRM5V2F2NY5YRf56geIHYhZjDEgKk40rP9F0GkMMm4LY2etPjxljzsqSjS
 kYbbOYjBNDqxyJ9ZFoCMOSUaxAV8UKyrhO+2ZgCqnkVSbeFGisbXqQP+Sb2J23YSxCxH
 d8ca/r3ESyRet+2+j8+DcyDc3bh/w1PP0cm0y+05WrTLNYW9H0ISPqPxW8Bx/sCwJJXM
 MUgB2bh0LCGBW5e+iCzzR/uE/VJztlcZE+Lismj2vi0A/J+xLyDn7kObd1sJA1pxqMFo
 ViTfwJ2jalm2TUj92LWX2eaBybhRLVvX/1RexN4w3+MP5T7tPSxWLDT2x71zbLMUUxKi
 v7lQ==
X-Gm-Message-State: AOJu0Yy3UGZzaaYRvRUv7R3BEMyXapjz2b18H1GFF+M3Jw2fY93FrYuB
 WrBS/ZX9+Yw+FTkG6UiX4FtHs7gWhefqiihrAsYHLjK82FamA/hUdXcjbcuw843rpiKs5DEeegp
 Z8lM=
X-Gm-Gg: ASbGncuu2Hkl3xCLutLEvjqZNY06jOIs/3raMf21ac3TxXFATRyVnpVMK5vradw/O97
 fuSylQRWFi+XUHmhD6epJOX8WMAs5oN68gWAWFy26s46V0G7mu+IpAkZeTe/1b50cE4dj6fQru6
 e+uAy0n4bG0mKPlH+BKRmJ+2lEK8FOY7C1SQIq/KJMZCiNjI/5rvDQP3HTSu+Vm+/fd7WPtKUTZ
 Rr+An7fv8fOIoD+nkj/7kew+pFGnG7RydzAxhdgFqCHY0s/yrxFA4xGuUg0lgz92SHL5JWkryUk
 tfv39ewjkAPYCOJUUzkaWLBkSA==
X-Google-Smtp-Source: AGHT+IGzMIJ6Mlk2jxXTdAi5fsSe7a8ApsMFdGhI9MtvQSMQMFPj0jlbvVQYiwmUPhxW4vTNPGVODg==
X-Received: by 2002:a05:6a20:430d:b0:1e0:cbcf:8917 with SMTP id
 adf61e73a8af0-1e5e048ce0amr24611347637.21.1735070730797; 
 Tue, 24 Dec 2024 12:05:30 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/72] tcg/optimize: Use finish_folding in fold_add,
 fold_add_vec, fold_addsub2
Date: Tue, 24 Dec 2024 12:04:18 -0800
Message-ID: <20241224200521.310066-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
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


