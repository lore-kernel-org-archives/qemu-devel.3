Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA72E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlv-0002x7-Ul; Sun, 22 Dec 2024 11:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlN-0002at-Qg
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:07 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlK-0002zb-Tj
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:05 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2164b1f05caso31193415ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884700; x=1735489500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLGJPFNJ8wfTFpeecaPk1zjZBnM4p3X0KbI5v3Dflro=;
 b=K0/ojJkQEkya+EeYiQd9Dyh0H8rWlD/Kx5Jg0OpkSuqcpKrj0rG4cwdL7NMdpkjFqD
 JlGXF9A9urmIQOderlQOX3dXkGUQQkz0k71Y6r9LDed1wTbMxglz5jBC1w/10IOk0eTa
 tL6XgZF4Ixh/+S58LzPkBve3DIxyILuLbi+J/MBFnnAiTAB80GEJl2NcdsPiDbtdP/Ow
 s1EVYaD1H2ek8CZ1T/y6xSsbCptU2et81W1Oa1vi7r4YpBPoi25v/WaHOzvEyXzBIYUw
 G9LAqIfDvX/5FC/4nNoQS5llOmtT7/ZrVTOdTx+3pw+612TMLNC5aVYnv8zR2T7mIScG
 ytlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884700; x=1735489500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLGJPFNJ8wfTFpeecaPk1zjZBnM4p3X0KbI5v3Dflro=;
 b=Dhv0x3zwkJEfT2dPvqCllPFAsEGya0/CnR8MroDBjdDKitUPybsmt2wuPI3vSTNpab
 IBzKBnHm0r1VsB675V+KStb9/Wb/F7VkEW4XXaCOfnbvSSJuTg0FxU39dWSzQwGzO82W
 JYpCtHqxEvCbqKAQKTI+N9xoDmgOzZwzKxOM9HUjbsaLKrPc9C6QhhnXQ1giTJTLV49w
 OsprtjAlwbpaT93KE4hSpqQtzBtGkmmOYaA/dQKkRzXNHypURsINki8nj2bB/k2ES3Ac
 hO83ftwX++oZPTAt+B6XvjuCHpgqVB59JQ4EdR8+gPIhfzQ/sqHtO2LFlUvfLXPGyzTr
 V8Dg==
X-Gm-Message-State: AOJu0YzNktWd3mwCFqllX58eDJHpxs/2DhRXBhmXTkOcCNbNLyz0Kzx0
 3cjskQvW8tnfNTKhbGNcGHGHV8ZPOG8REO/FlW6qM7F/ZOWlge4C3VigDm59EmDC+mfSl6NBGZF
 Cr4Q=
X-Gm-Gg: ASbGncsFgfRfoKIKtMMQORBVgwnb0/4RAdwgdWrDggLIp/oeQCSL5Lzm9C/joTiCet4
 1vmUbf3wSsLuZ9GAiLRqa4Rl1Nyi1yKQNMdUgOIuHua2B1z3yG6dUstOqPUFD/5lR+LkjF1gDFb
 AN7jnwRRYPz4PPrrgml4U3UryAka9d7BLjBtcQfJuSYR0eKs7WGYKoiZUofetdkwy0b1yj/kRwJ
 bPIuJ6JihCzrYK7nNbK3GlQg2AplNTxwmvpy/QzjbXINnFtItl9jo8vuQh2Uqo=
X-Google-Smtp-Source: AGHT+IFrHHCyrpFZor2XjwfNfbEC9XbWKndCgMUhow00wBV0vq5d/s3OEqQJe+Djuws72NWkzju0Yg==
X-Received: by 2002:a17:903:41c3:b0:216:69ca:773b with SMTP id
 d9443c01a7336-219e6e8c3d6mr146715085ad.5.1734884700332; 
 Sun, 22 Dec 2024 08:25:00 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 20/51] tcg/optimize: Use fold_masks_zs in fold_exts
Date: Sun, 22 Dec 2024 08:24:15 -0800
Message-ID: <20241222162446.2415717-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 tcg/optimize.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f05110cb9f..ab8ce1de2a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1761,49 +1761,44 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask_old, s_mask, z_mask, sign;
+    uint64_t s_mask_old, s_mask, z_mask;
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
-        sign = INT8_MIN;
-        z_mask = (uint8_t)z_mask;
+        s_mask |= INT8_MIN;
+        z_mask = (int8_t)z_mask;
         break;
     CASE_OP_32_64(ext16s):
-        sign = INT16_MIN;
-        z_mask = (uint16_t)z_mask;
+        s_mask |= INT16_MIN;
+        z_mask = (int16_t)z_mask;
         break;
     case INDEX_op_ext_i32_i64:
         type_change = true;
         QEMU_FALLTHROUGH;
     case INDEX_op_ext32s_i64:
-        sign = INT32_MIN;
-        z_mask = (uint32_t)z_mask;
+        s_mask |= INT32_MIN;
+        z_mask = (int32_t)z_mask;
         break;
     default:
         g_assert_not_reached();
     }
 
-    if (z_mask & sign) {
-        z_mask |= sign;
-    }
-    s_mask |= sign << 1;
-
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
     if (0 && !type_change && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
-- 
2.43.0


