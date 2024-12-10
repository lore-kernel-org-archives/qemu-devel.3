Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B4DE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26Z-0004cM-2G; Tue, 10 Dec 2024 10:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26R-0004L4-HQ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:47 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Q-0008O2-07
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:47 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eb5a870158so894322b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844284; x=1734449084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d4P+9Tt3wIqDLYzY9wcDFZqqW4I3YHsp/F22EZTtKAc=;
 b=hljxopk2NF856ElMjQhfl0d02t6x2Nyn8ffG4UfDibVG8Jb5B1amX4sUPwCjMHeZyS
 CPRA5pSgIHR4SOpr5bYRf54R1BCo3d8Nsua0JVyoI+S5tf0VHV0rZICMLFgphY4sjnpU
 BdoWsglLEDlFS1c1GC7WUe7/rrOR8czJZgnldLHuHc7ejmizvSoWuuWqpSzrsdQSat0x
 WRA+eR+5wKxlyLh7PoLw2XsU3IOd521JmCpsOp3SJbaUrIdizwrMG7bLGRbWStmS+VOM
 Em4SK1+9v4t6z3DmXi9c23lz/pKYFhDDYoeIAPEc2NFFtu7qe7wWEOPmHIrsOe7vfJ2X
 hK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844284; x=1734449084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4P+9Tt3wIqDLYzY9wcDFZqqW4I3YHsp/F22EZTtKAc=;
 b=qh68NlruHjM2g5D5dujvLGBst2s11rpMxZU6Y1pFdW/C43rjqNS9/G4Tuc3XC94k3g
 0E8IVBbTVibjZdP+tgovr7Qr3iOhjCGW5jKBio3UtJyhgN/d5BMzKxlCKfa/ALrQ/HOb
 XF6nxYS5YqafcsmE7LBgIsqnul8cEL5XTdvY/pPvIwxtdKHGMZelvz0Z1YDPvxRrOubz
 8/QQrUPp/VgeBVYd/KrGC6y2Yu5h1kU3dGqJxy2l/4O6j+naDPUe619pzLZh897OnWnV
 M3Dx+LXGB3tProttKcXj+lgwrG9a/zf8cKu/e6sGyiqcest1iNUHjpXrwCor9MAHtm9O
 fr5A==
X-Gm-Message-State: AOJu0Yzr29bAiUVqpYNw303z2Hx0hLP7o5qCTNZ5XhgYIcDmU/VZyOyj
 N5GGr2/Z02SvRYFSNBaii5djssNSyQvSKyM2pa9s/RlTf5ksuzFLfmz5QuFVpnYkuicIUOAeGnG
 5ElFztzYx
X-Gm-Gg: ASbGncuVFIqJd4Clcpt+KiG+DHiLYYl7t0DZPoJH4IFJwEwi1sJ2x/XTS/hMABG+FMT
 37ucqB3nDdvQKoit6VMtRYd1jSxbUI3QEzdNjKwUpHF/n1clYxs2VbLY2iyxb70RBwqvL4oUMtG
 RgqqwvCUs5YOYWa/Pa3qwfYXKJl1uiNWWcD9rD7kpEEqxzyedWOFGboo0TgR7LyiyGKjXgirk3J
 JS3QSo6FWFMyZunfoqF532R6G/VOL3VAwiYeOSSC702qWk26B7EwswBhI3LKw==
X-Google-Smtp-Source: AGHT+IHzcPSYBNsGX2TQaXxrhfHMTQk1BDs7dvVvuF4ilkto38wzzFjv7q5heMcxBClPaQ8txbThDw==
X-Received: by 2002:a05:6808:13d3:b0:3eb:3d1b:4876 with SMTP id
 5614622812f47-3eb3d1b4dffmr7820711b6e.32.1733844284181; 
 Tue, 10 Dec 2024 07:24:44 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/46] tcg/optimize: Return true from fold_qemu_st, fold_tcg_st
Date: Tue, 10 Dec 2024 09:23:43 -0600
Message-ID: <20241210152401.1823648-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Stores have no output operands, and so need no further work.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6f41ef5adb..ee00620ce0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2125,7 +2125,7 @@ static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
 {
     /* Opcodes that touch guest memory stop the mb optimization.  */
     ctx->prev_mb = NULL;
-    return false;
+    return true;
 }
 
 static bool fold_remainder(OptContext *ctx, TCGOp *op)
@@ -2694,7 +2694,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
         remove_mem_copy_all(ctx);
-        return false;
+        return true;
     }
 
     switch (op->opc) {
@@ -2718,7 +2718,7 @@ static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
         g_assert_not_reached();
     }
     remove_mem_copy_in(ctx, ofs, ofs + lm1);
-    return false;
+    return true;
 }
 
 static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
@@ -2728,8 +2728,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     TCGType type;
 
     if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
-        fold_tcg_st(ctx, op);
-        return false;
+        return fold_tcg_st(ctx, op);
     }
 
     src = arg_temp(op->args[0]);
@@ -2751,7 +2750,7 @@ static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
     last = ofs + tcg_type_size(type) - 1;
     remove_mem_copy_in(ctx, ofs, last);
     record_mem_copy(ctx, type, src, ofs, last);
-    return false;
+    return true;
 }
 
 static bool fold_xor(OptContext *ctx, TCGOp *op)
-- 
2.43.0


