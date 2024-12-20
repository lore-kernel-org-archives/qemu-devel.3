Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6E0E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMT-0008Uy-Kh; Thu, 19 Dec 2024 23:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMF-0008Pc-AS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:24 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMC-0006Kq-QD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:23 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so1178865a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667879; x=1735272679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uGMa5ilZclwRxAxELWf+zCLQJhdJ3SzUWO/11Vp97M=;
 b=PXBak6qEcNBrHs/6j008BNxaJEoUumNiZCLxrB7UYXIDgkHQPdZSUYu7liAlmn2Wge
 khwghgFDSGynujFDg7TBE9JUvKKNtTI50F4m6gtHerHd5vWFeEIJ5XJGsUH3Me7S44xq
 csir2jUT1y6Fusl4LmQpTWHLuWqrPbenGH5juHbJRYDtkiwz8+GPhvnHJ0jawf1pG+bG
 jiBIQfzN6iAL9lSMlVUyW71CG6D/vFvVyHnsQnGk3OetA3d5BANaqnfKTcW5Um6Ez6Wi
 pkOHILpnvpFDlbgbqH26uQ5CweAomCVleKdKaXDgRN0EzUUpjtSOHFs3c25rC0aUCED+
 5Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667879; x=1735272679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uGMa5ilZclwRxAxELWf+zCLQJhdJ3SzUWO/11Vp97M=;
 b=Cst6efL0qXoEzUdFXTD0LYxryTOPlbIhyGI6x4zJkO4nYI6mS9GwVjaDMrEayjWA3V
 ZNqmkvZJVU1t4WxHhOMt10XFzdt+5T7qOgAa3yEaPhSLDmEgybu4lmPscvlKCaffQI8J
 BJhr2UolzIpGoVw0ZL2CFIXQucvzC22JUEKMIRBN6uBik0lkXPBgXSwvFBZAKdo3GWOQ
 qKIz6CIkv68pZ5eXjZFFEByY9MCixEJzg4KtgOx5vDESqSEI+CZpEjwLFeJBmsa8Uc0Y
 7JuGlCoIQH5/HIEYQVOrrixeW8ucHfiHoB9aiGVq4OB5EMYyqqqa5jHkLWXvMWrithXG
 Ql6w==
X-Gm-Message-State: AOJu0Yz6o13xFPaVuG/QwjU4mqk5W9hqsRuau/jQm/Sj22n9eLHX7uWn
 I5MO3sMqu1TGZJ0L+bQrCoiNG6ELsmNQswHR9DVZY2Os9U+yYDhhsl5ZWweZ1XNJXiQt4fMndCE
 T
X-Gm-Gg: ASbGncvV2D6faCPU9IfvRBAi5MrEGzQl7meroLqTceqUM5mdO47L3CIaCcWlOTNSdK1
 87K6/pkUx13FtKFzp2yZ5uW+XakRJ80IfY0LIPe49pJuFpjv2BRBfeapliFkOccVOkzL7BEOjHc
 3bHN2/EXmd2GFLCO3OQyAkTdBpetoWQhsUfyty1R4lKHoRmwGxMw51gvc8Bs/xQSTv2KoGKDJUF
 fZR0wY+8CWYISbrN4gTSaX+N4joxzm29buR7QEEu+qkTi757UHSm6VifruUQMU=
X-Google-Smtp-Source: AGHT+IHEHii6PfPfZVn7yw9BbM2Ukjl0jDlGdKkC9ws/agScjwl7+k5ubDX2wdgOQB2RdzJPlWmOzw==
X-Received: by 2002:a17:90a:da88:b0:2f1:4715:5987 with SMTP id
 98e67ed59e1d1-2f452e1e7b4mr2348647a91.9.1734667879112; 
 Thu, 19 Dec 2024 20:11:19 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 19/51] tcg/optimize: Use fold_masks_zs in fold_exts
Date: Thu, 19 Dec 2024 20:10:31 -0800
Message-ID: <20241220041104.53105-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
Explicitly sign-extend z_mask instead of doing that manually.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 30bce33ca6..659190dcd8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1796,47 +1796,43 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask_old, s_mask, z_mask, sign;
     bool type_change = false;
+    TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
         return true;
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-    s_mask = arg_info(op->args[1])->s_mask;
+    t1 = arg_info(op->args[1]);
+    z_mask = t1->z_mask;
+    s_mask = t1->s_mask;
     s_mask_old = s_mask;
 
     switch (op->opc) {
     CASE_OP_32_64(ext8s):
         sign = INT8_MIN;
-        z_mask = (uint8_t)z_mask;
+        z_mask = (int8_t)z_mask;
         break;
     CASE_OP_32_64(ext16s):
         sign = INT16_MIN;
-        z_mask = (uint16_t)z_mask;
+        z_mask = (int16_t)z_mask;
         break;
     case INDEX_op_ext_i32_i64:
         type_change = true;
         QEMU_FALLTHROUGH;
     case INDEX_op_ext32s_i64:
         sign = INT32_MIN;
-        z_mask = (uint32_t)z_mask;
+        z_mask = (int32_t)z_mask;
         break;
     default:
         g_assert_not_reached();
     }
-
-    if (z_mask & sign) {
-        z_mask |= sign;
-    }
     s_mask |= sign << 1;
 
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
     if (!type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
-- 
2.43.0


