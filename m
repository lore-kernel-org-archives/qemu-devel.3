Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB827CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 20:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3rL-0005cA-Mc; Fri, 29 May 2026 16:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rI-0005bV-H0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT3rG-0007gQ-QM
 for qemu-devel@nongnu.org; Fri, 29 May 2026 16:31:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8353c9f24d2so7304476b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780086665; x=1780691465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iunL4KCalfZtawye7ZT9J8Pu4zGGcHn38w0XSr6WX4Q=;
 b=o0zqmCdWNtQdbA6QHl/tZ/9WxNEtUlSHwWr+CZwRc93qvq2vBlVvcKVfMhfPH81t4G
 fF6xzG016ypgT6fNrA0t8oWDA2U/bO1QggYIHkVIqgBt979Bs4VAwuUK9i/u5GRI0Fw4
 WBOOvhgx7olIxJErXgz5PBLpjRGuQ+g5hW8yOqrWjZDGIKJ8B3urEc5qB7S9d8YZI1JB
 z7gtM+FYpiwSvx/ucp/ivUuVIMsryAUBZv11pnrKOw9U/v3oBavEx9JvI9ywmgoSJzMl
 0bpCuAac3AI+dTXV59CJw0KS+UuLQ96GyQdNo7PFGu0e5yLtPVtOXFzrVNPPzPQ3SV3z
 +jWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780086665; x=1780691465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iunL4KCalfZtawye7ZT9J8Pu4zGGcHn38w0XSr6WX4Q=;
 b=Gph8Xe5OVKbY6wAaSvuQI1Q+2EPzaAAH5hqyQqv3HtET1g7N0hZATn6re+4JZv/Qu8
 M7bksesrst64fMpdYrZg5qL3I7A4tvnWh8h2RIoWb5k0XFRkEgRKZafAmaeWsfEcWHZU
 n7z0lR08CEudR2p3uPSxbHT3fjaEvG3Y+cn0zd1F3RAD0gH6BHUbeW7nnCA6QFPKnxJT
 2uHO69u2BmnZ223DlVbuGRp3ruzCz64RqXL8xZEg/DSJCi5EjyS/XMSylcbd3oQ7pwv6
 8jZcwMZ3H2O7f9TsIaD+Y12nSPDTmyJTP0BeCm0g1EFlGu8qkhvrD8dlKFx07nkTd04F
 wiYg==
X-Gm-Message-State: AOJu0YwsOvuaPw3+QdIVdorvAwelSfoJb2NNQhPovj3FKRbSFNmZlQzs
 byFXJZwy+GbG7FjzPv6t5pdFfa4E/4NYo72pmtluIZrZKDeI5GPmjcfJoiWYYH+vBMxGSL4fTc/
 kj0vm3Y8=
X-Gm-Gg: Acq92OHUjS2Ad2USiWMo7SVp7Vn63CcB+XX/DcUBdhBYUhs4C6zdHZ/N7W0s/3QpCll
 +TxwyBGxs9MRE8G0kqZwuMHmkO43PLGOTqEUmMFSyIM888qkV7ofEtxNSC446itabvGtW0BAbIy
 /TAooYc47Q90vYAqY8AnGxCiXHMSTldOuDEeyRWi/JiGq/K+w8tnOv5JMorHrNV8oXDb1Xv7Y+d
 4eK9bbnMMz2QaI6XypiN2g9VJ2DCfUc4Vdrym6VVsZksyQo1S98AIrKgZk+TzMQw5+ECzkJIRcl
 Q38vlCr8fRWHxUJktr5NxzkrgVw+0Z2wgC+1iJJTntutMG+QUz0z6mWcCzLzz8j/RvPcdmVk7xu
 fkKRQgkPwid65hcCmnqbWHw9SmwOzpwhWgtMtchO2gOA5M7AaHu949KcXXJb6eemJ0CXr8mmhzP
 5Pf8Wul3NeEFpCjgVxReLHFLmWBzZJGiFABK2gEcI=
X-Received: by 2002:a05:6a00:21cf:b0:841:e7f6:3e93 with SMTP id
 d2e1a72fcca58-84225347d97mr924767b3a.1.1780086664806; 
 Fri, 29 May 2026 13:31:04 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214b02365sm2720237b3a.8.2026.05.29.13.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:31:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/3] tcg: Massage fold_multiply2()
Date: Fri, 29 May 2026 13:31:00 -0700
Message-ID: <20260529203101.290947-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529203101.290947-1-richard.henderson@linaro.org>
References: <20260529203101.290947-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

In order to ease next commit review, check arg2 constness
in the inner loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260520125139.13352-2-philmd@linaro.org>
---
 tcg/optimize.c | 68 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b1abec69a5..ef5eb2cf17 100644
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
2.43.0


