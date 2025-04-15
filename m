Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D230C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luc-0008Uq-3C; Tue, 15 Apr 2025 15:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luT-0008Qm-K6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luP-0007wU-RB
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso2715503b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745124; x=1745349924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3efgV/pEu80aXE8j5/SUl3haOtWo5u+W7F4cNHVCaw=;
 b=SA0KeA4kUIH212msmuWsOvLD+skRRIrYDzkiXQjwXFVSMeZj5nnx3KFyv4GriLoRdm
 MJYtcp5crgS8G4lNscbu4l6hSNlxKWI3cEuKIHFu+n13hI6LpU2EKH5O9klj6YBg+O1x
 Lr0v3USDB78JXaInLk2Qs6GvKOgp8c5rcdvonF7q4j2YCmcEz1dbRF7J45Hf3Ng56yAh
 F+LOTvfiEsvuifYJU2EyvSMl2wp8INhqhCZak+TmxS5ZcvG2ux4aD7SfALXWQ3pK4tSg
 jFe2sUA/iGe+A+0rntcJcF6PM8bRg1N7rCHEqdtIlYJcgp4jW9fvJXr8RQbYKFsvhD5b
 12SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745124; x=1745349924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3efgV/pEu80aXE8j5/SUl3haOtWo5u+W7F4cNHVCaw=;
 b=w+i9qLvG0mF/ewBSmRDcC51J0bWlF7zFqy+eMASyDZqImPGDzldiZCZmVB0JhgyUBz
 hRJC9yrb0EL5K4oDcsq5vUYe/L076okxXO0beSjK4nBgMSkTR9WsVb3Vmw7uPnQDeokC
 wNrnN23BeJFSIL4c3EWw25l2xtTI7qiHTLuCfbj7yHiWoP5HPDDesXB5x/rdtffQUe06
 OL/AEGfE4r9d6vzd/S+jcQ05HvAYAB6a4oQr2RkVUCCwuiWdbox00BPHfgBe+iycyP51
 rPFgjw+iy7RYT63aq+fdQGaE+NNj54VWpMGTAaCLXLGd7ZOF6Awzn29D812hOZvBg2p2
 xxtQ==
X-Gm-Message-State: AOJu0Yz5hWtbNF1erxJLTJ+TeaorhhGgHylr9FmVU/+xkkKZ3ezPbPJM
 yDQv0WdDkN/OiAr9A7HkL6Wnb8gyvkHBR93e7RRFqpYtCFAwiSm62iD7iipaX2/qecFLjcF0TgJ
 Z
X-Gm-Gg: ASbGncu6bVvZeKO3hKglHmR74GCLMMyn3vZX32RZZZ40fIDfoKqOus50Oz8ga5fx++x
 QpnegvHEofAqx3YC5ToVslZMo0YRIFGSIwVvAdrsbwj/blJxIYvRjoTB6nEc3k+HKjEgjSbQ35y
 tQriGwFWqjDUEiAY7F2QI0YT32rVXkSp8i0DuZSC0pdOEdzZcCVoNh5cYVxZ160et5tcQN4dqt7
 DV1vwSPdMQZZinO6wqR+63uPCsaD/l6wVjDNDBi3p1jo2G8Yd++0BIDfZTIcIuWpUwzEmtD9ER+
 fYkaBQF/yTY3kQBHOrW3yKfQG855JeYjj2pb6RBDYEJfuZPQyZ9Nu/p82laRAq0+C3w0hMqxkN2
 qaQe4agCzSA==
X-Google-Smtp-Source: AGHT+IGkCuOmxRFYk8uInRF6nAbOFEbqXZNbEccBIrdGp6GpwqrHloLrViXeyVs4JgbNsQ5uG8DQ2Q==
X-Received: by 2002:a05:6a00:2309:b0:732:5276:4ac9 with SMTP id
 d2e1a72fcca58-73c1f905c9fmr758989b3a.9.1744745124178; 
 Tue, 15 Apr 2025 12:25:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 010/163] tcg/optimize: Emit add r, r,
 -1 in fold_setcond_tst_pow2
Date: Tue, 15 Apr 2025 12:22:41 -0700
Message-ID: <20250415192515.232910-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

We canonicalize subtract with constant to add with constant.
Fix this missed instance.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0b84d97051..f0aeb10d07 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2289,7 +2289,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode xor_opc, neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2311,7 +2311,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        sub_opc = INDEX_op_sub_i32;
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
@@ -2323,7 +2322,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        sub_opc = INDEX_op_sub_i64;
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
@@ -2367,10 +2365,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     if (neg && inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_add, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
-        op2->args[2] = arg_new_constant(ctx, 1);
+        op2->args[2] = arg_new_constant(ctx, -1);
     } else if (inv) {
         op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
         op2->args[0] = ret;
-- 
2.43.0


