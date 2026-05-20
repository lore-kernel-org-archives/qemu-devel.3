Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AABCD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgOx-0006q1-S7; Wed, 20 May 2026 08:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgOw-0006kj-B3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:51:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgOu-0003cV-6S
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:51:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so70576175e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779281509; x=1779886309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBMZgKeqV5QnEo+pkmqJNIkd5X+RWgDO2+l9yzq+Z4k=;
 b=XOqdkyZnRTUM11o4arz0RvrRtRncgk6n9CfNtzMK05nTqZQNRgg3JzmTtv78d6lsQn
 C/R3iQ0UQcYLeuyKAYJ6nw4qZ+wA08tAUqvHxBwoR/NRUdJqfX81E+dN2OjNbjM2DYXZ
 1gzjf3XTr5GN4UtCSaXO09fUM4HvOroTIZEo5fI3ClU2BntnjNQCDvQp2aGs+7mX6RHC
 46GQF8EejpMSjIyVRrVvk/zLlVQyXddzgCGDpzT9I7kuiduUWvtjcpRX9ZUp3xLLJlQW
 dswK0yKgSTWQqmWa53u/vZpVLh2Odv60QBwDIhMMj5gOFOcgbFPhE5IA7m2kR+FaF29G
 y8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779281509; x=1779886309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gBMZgKeqV5QnEo+pkmqJNIkd5X+RWgDO2+l9yzq+Z4k=;
 b=GHEy0lBafuMCAD/5issfohtb7IRtMqdn+TqQtDdLwBCKx+CFVscV47kOI3F8kaGvV5
 okRzDjsYgGBH4e0T3CAIZnwBAHaF7Xrswu6GbuobnpcD/mcZIkIADqC1K8eBgjvmgifg
 NKoEgW+zsVqPHi4kE0K2G/H5RVnPCz1iJTSCO00NzRxyJgZCvYgjGYYdLA4qWH5VJI0m
 wO9yDvzhluawBwXe+oVX4R6dZh5o6lWmdhKuRAa+NZ+ZYD4aYYTGQ7izYeQQ+XELjE5K
 aXYl62TgzJtFEijVLIXWgEwJ6kQscsZ5hTY4LoELGi4ojINozOBpfq+uYvD1fbHmRBZH
 jPmg==
X-Gm-Message-State: AOJu0YxSKOSndNjuRMCJCZ20TqkQrRi4fvl8xqexV0ZgFwjCrEfWErN8
 gw84iGM2dvQ4SCZx9DBwkZIGTRr2G9PC7+j6RDLzEYC0wyqKXkJZdkR+FaQ4d8jVIZi5jVDchst
 CGrZ5c4I=
X-Gm-Gg: Acq92OHdbO1iDFygIQf89aH5xBFRx+tuW5HRLEm6WpFLBcRvaDVZu1PoI6NxPIbC/Qw
 rtUebBvOpfxm/+mS0XpaYybA9GV9lZZl01N3YmtDPcGWjzLs1mrXMBCLJEQYxvFTIHX70gjASca
 7wq5uaacCc7AavyUU4n2VklrKpXzCjrxm+qJWVCMBteeYn6DW1s5kXZ7osCsY//ShxMwdgrOvzC
 uEdjAF+/DuxfK851EaTmgLpSbABf8Mm/5+hdp745jc0vKNfyIokrLQB5Jyv+T5FfQbL+DCPAx0f
 a3/n+MHUHxNiYkmWG7KMNQxtVwCb0Z1V4LlV+Q/2muDmlMOin/sggnJi7VrBnRQR2yZw9Y8Z+VO
 pJkaHCF1DowLmE0U9dzmCM/GEcjMiVU4oE0p2em2Ts9AbDMzP3etvIiDD2+9TxYpx1wr4js58F6
 pxnIXLlyYosqEJHQRtPsfJaEPJKgObyIPwK7ZdwgyUgzWZriy26d2EHEeZbtqyqgZqwejpdru/M
 GiIAjGyjc8N2/ya6RlGUg==
X-Received: by 2002:a05:600c:c0db:b0:48e:8499:4be0 with SMTP id
 5b1f17b1804b1-48fe60ee481mr275845165e9.15.1779281508670; 
 Wed, 20 May 2026 05:51:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm56214191f8f.29.2026.05.20.05.51.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 05:51:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 1/2] tcg: Massage fold_multiply2()
Date: Wed, 20 May 2026 14:51:38 +0200
Message-ID: <20260520125139.13352-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520125139.13352-1-philmd@linaro.org>
References: <20260520125139.13352-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

In order to ease next commit review, check arg2 constness
in the inner loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Split of following commit]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/optimize.c | 68 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b1abec69a5d..ef5eb2cf175 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2173,45 +2173,45 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 {
     swap_commutative(op->args[0], &op->args[2], &op->args[3]);
 
-    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
-        uint64_t a = arg_const_val(op->args[2]);
+    if (arg_is_const(op->args[3])) {
         uint64_t b = arg_const_val(op->args[3]);
-        uint64_t h, l;
-        TCGArg rl, rh;
+        TCGArg rl = op->args[0];
+        TCGArg rh = op->args[1];
         TCGOp *op2;
 
-        switch (op->opc) {
-        case INDEX_op_mulu2:
-            if (ctx->type == TCG_TYPE_I32) {
-                l = (uint64_t)(uint32_t)a * (uint32_t)b;
-                h = (int32_t)(l >> 32);
-                l = (int32_t)l;
-            } else {
-                mulu64(&l, &h, a, b);
+        if (arg_is_const(op->args[2])) {
+            uint64_t a = arg_const_val(op->args[2]);
+            uint64_t h, l;
+
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                if (ctx->type == TCG_TYPE_I32) {
+                    l = (uint64_t)(uint32_t)a * (uint32_t)b;
+                    h = (int32_t)(l >> 32);
+                    l = (int32_t)l;
+                } else {
+                    mulu64(&l, &h, a, b);
+                }
+                break;
+            case INDEX_op_muls2:
+                if (ctx->type == TCG_TYPE_I32) {
+                    l = (int64_t)(int32_t)a * (int32_t)b;
+                    h = l >> 32;
+                    l = (int32_t)l;
+                } else {
+                    muls64(&l, &h, a, b);
+                }
+                break;
+            default:
+                g_assert_not_reached();
             }
-            break;
-        case INDEX_op_muls2:
-            if (ctx->type == TCG_TYPE_I32) {
-                l = (int64_t)(int32_t)a * (int32_t)b;
-                h = l >> 32;
-                l = (int32_t)l;
-            } else {
-                muls64(&l, &h, a, b);
-            }
-            break;
-        default:
-            g_assert_not_reached();
+
+            /* The proper opcode is supplied by tcg_opt_gen_mov. */
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op, rl, l);
+            tcg_opt_gen_movi(ctx, op2, rh, h);
+            return true;
         }
-
-        rl = op->args[0];
-        rh = op->args[1];
-
-        /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = opt_insert_before(ctx, op, 0, 2);
-
-        tcg_opt_gen_movi(ctx, op, rl, l);
-        tcg_opt_gen_movi(ctx, op2, rh, h);
-        return true;
     }
     return finish_folding(ctx, op);
 }
-- 
2.53.0


