Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751EBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMW-0008WP-Sd; Thu, 19 Dec 2024 23:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUML-0008Qb-44
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:30 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMJ-0006NK-Fe
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:28 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ef8c012913so1054897a91.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667886; x=1735272686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldx4yMmQFQdLg1ALYs2lWhfuOJE12kF68SKOPYDg5SQ=;
 b=bvLq/s5JfCs1NkoAb1aCalZqxyRL+o8qqfbJXzzAAJYMUbm2kZvPyZEyqWmzVWKaqY
 d8Vha3zcWqvI2ALZbDjdkbIWBDDbN+gMR12LFAR8StNsZHSBHmgwsyiXGxYlpbJGI/90
 9WQKh9ewVh8OjkuT2qMXfDAT4p3e3FN74If3qh5Kt6N+AUW/yfalThNFnSLYh3jSwKNi
 1gW9ejSprM8OjteMdd+HGdWAO7146BRduYp9GzmRLJeM3R9llk4/PPCx0dsPf7UISCsu
 vgLlVBK06wknS77qfZ6Q686Jeza7cxYWFeiTZu10/d582HXuCnZIiPwaLnOvJsKSIoPq
 Q3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667886; x=1735272686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldx4yMmQFQdLg1ALYs2lWhfuOJE12kF68SKOPYDg5SQ=;
 b=oNI2SJoTVXeqFmXettgFQkEKW4A61T4VRBGC42QvQRlD9IZpVuiQ2n9OCm7sTnVRix
 i04aZxOeOZz1XHy9grR9e5AClnhvx4MmFiYfkhaOAjhtOVLJ1U4xUuEzPtc33PODwSfB
 HM2elDXpnjDlLWO2ExrL2TDoYUNoidmQ/XZWEMSSjghQGEyLQ1EwT6JtT/aR0pt67HVX
 RjogAq6O3/2zybULKn3PpT765/wjhuCNvbdZVU5YjaSyxJTmjj5MRRzRwKh8prc11AmV
 fF4USkQTcTDc/JHxRYMo6NDtTXLpp8+jSikwXa6ncAD4RXWVvE6Prwg6Dk+2EBS+SsOe
 S68Q==
X-Gm-Message-State: AOJu0YzPt9VfqgPfrmqQGAzRWC7T2a1Bi6tbsA4XStdQReqXUOad4GWV
 A5PzX6uakbmXk33HWhDc0RfRLODxFyKvPCN48z8RYUT+YXwc3YG2tIQk5pb+7Vcr1IAnlouquBo
 n
X-Gm-Gg: ASbGncsnt1kOb25bDKtbtw3zACuJMkIC0OLq5v+ihjL8mRKqCKrXuKwJ9ynYk/o03nX
 k8nhNyaMdLVJbFqxDtW7rB4KSpvHeiP4CXJtt1utC0ekn9X4KyxgU17PinpFz8y142copuTBmpA
 k1HlcfTWCv96BhrFMw83JJlfum4aE3zQsej7kH1KQIIRZ8xkoY+gr6TnII7eOXPC2Hnd09uhLRa
 UIyR8ZncgZVwfsRcVqkG3BizCq5Kg2rPbGWC5BOAnBUH+MP/XkwGWINl4bOtT4=
X-Google-Smtp-Source: AGHT+IG4WYhJVYctHfnJdousc887mFC0tbwXAqCza/WASVZJcqKzO8/ZsS0WZlJyue91rbPGaMzYiw==
X-Received: by 2002:a17:90b:548f:b0:2ee:8aa7:94a0 with SMTP id
 98e67ed59e1d1-2f452f014f1mr2106427a91.32.1734667886205; 
 Thu, 19 Dec 2024 20:11:26 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/51] tcg/optimize: Use fold_masks_zs in fold_qemu_ld
Date: Thu, 19 Dec 2024 20:10:41 -0800
Message-ID: <20241220041104.53105-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Avoid the use of the OptContext slots.

Be careful not to call fold_masks_zs when the memory operation
is wide enough to require multiple outputs, so split into two
functions: fold_qemu_ld_1reg and fold_qemu_ld_2reg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index da9c8c4669..b01929fccf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2127,24 +2127,33 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     return fold_masks_s(ctx, op, s_mask);
 }
 
-static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
+static bool fold_qemu_ld_1reg(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     MemOpIdx oi = op->args[def->nb_oargs + def->nb_iargs];
     MemOp mop = get_memop(oi);
     int width = 8 * memop_size(mop);
+    uint64_t z_mask = -1, s_mask = 0;
 
     if (width < 64) {
-        ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
+        s_mask = MAKE_64BIT_MASK(width, 64 - width);
         if (!(mop & MO_SIGN)) {
-            ctx->z_mask = MAKE_64BIT_MASK(0, width);
-            ctx->s_mask <<= 1;
+            z_mask = MAKE_64BIT_MASK(0, width);
+            s_mask <<= 1;
         }
     }
 
     /* Opcodes that touch guest memory stop the mb optimization.  */
     ctx->prev_mb = NULL;
-    return false;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
+}
+
+static bool fold_qemu_ld_2reg(OptContext *ctx, TCGOp *op)
+{
+    /* Opcodes that touch guest memory stop the mb optimization.  */
+    ctx->prev_mb = NULL;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
@@ -3033,11 +3042,18 @@ void tcg_optimize(TCGContext *s)
             break;
         case INDEX_op_qemu_ld_a32_i32:
         case INDEX_op_qemu_ld_a64_i32:
+            done = fold_qemu_ld_1reg(&ctx, op);
+            break;
         case INDEX_op_qemu_ld_a32_i64:
         case INDEX_op_qemu_ld_a64_i64:
+            if (TCG_TARGET_REG_BITS == 64) {
+                done = fold_qemu_ld_1reg(&ctx, op);
+                break;
+            }
+            QEMU_FALLTHROUGH;
         case INDEX_op_qemu_ld_a32_i128:
         case INDEX_op_qemu_ld_a64_i128:
-            done = fold_qemu_ld(&ctx, op);
+            done = fold_qemu_ld_2reg(&ctx, op);
             break;
         case INDEX_op_qemu_st8_a32_i32:
         case INDEX_op_qemu_st8_a64_i32:
-- 
2.43.0


