Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E702EB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEFw-0000KJ-DB; Mon, 02 Mar 2026 20:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFv-0000K3-AR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:59 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vxEFt-000732-OI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:08:59 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-824ba8f0acaso2596503b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 17:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772500136; x=1773104936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtKLD5VhlXLsGWM2u+h1lyzJYi1swGBiHzUBqjwhzQE=;
 b=zCNwHXSxt0mVt9E48YuoBEhEL/zw4S+2yM+byJ3yaKx3Pu2lcSZhpO2snjDzzXHn1S
 x+fLDte8r54ygKnpMBm448fsQKhxIBHWd4iMP8XCfeCuFyJS6/lVVt8jxlkjAEp/yjin
 KnVIQ519EKqgtg1DzK831Wj+7CzC10LSd0W6IFQ7LQkAJ2AdFxr2ZPRpsn+peF1Cxwmc
 y9weLm3r8dwtc4r1qAsez+TBrI2r4PqMcbD7l3s5sPBz0V2M8+HDSHxJdjYDwKGzfk9S
 l4vSrfA94lVdx47SE+ZO9RlTjXsBv5ru6oTAtFKUYXQ0j5zSxZOH0JsDdyBxrGzZd1fo
 F9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772500136; x=1773104936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtKLD5VhlXLsGWM2u+h1lyzJYi1swGBiHzUBqjwhzQE=;
 b=HtRzBsiMOvlKCVrQiFtG6+hZf3nZ9KVmfzUC7VEMSJLAs5WQGnjjgAsR9fqKPC8BnQ
 wSwYhcsVkBx1bnYUgPSTrylPyf5hSh4FiozlymoS6sblYuFxmbBnj3G2jnhTIKtgSF4P
 EIemTaf0pMUhfbSFCWHTsDfYVb9uaNvdLYUFRgt6pur1kRIj5wwMxQvi9WYBRMJTRxh/
 9b4SkMfto5YCNEij2UoreRU5DlDpjh0Lal+pla1Q4q9eb2QMntrx+XSj0Ynak2XaRuKY
 0Q3wmiUcDJTvChEkROvaadIawm+FJ4XMFB6dW7r4vLfHQ5/VRJLlG3Mne5v48NaPeCwO
 tcxA==
X-Gm-Message-State: AOJu0YxE2MPD/ZXFIdSoQPaqzlWZNJPnOcDcvQ6SilUZvrSsAtYyn2gw
 w7QlhFc/ynPP1sgY7jSlNzeU73mn6IZ11Z9tOm/GUo7fEbZ3z8Gz0slVsyusPrGMtGebXkABGvR
 nN5mR2p8=
X-Gm-Gg: ATEYQzxFEaBzPrWlswAW+lc2N6eI866tipRtztp7/QDxtlvVV57wccbIrxMoGbmKTwb
 rfyLc+OCNuHId19ohdxC9tVXIPrunVQk+uGRGElhFR224aARd/vk8Wk6RUN4iEub/GZ7tBqfBVE
 JGs31SYXVTuquLfpBf0W62SanPG/pNj7rlSHs4fPwP89CtfFTjs6c4TmbzaqR7akRzDWm9kjAa4
 Qe9e2UhOrYw8x4QxxF6F9tKLxrZGS22RMJMdA54m5keRQwEOfzsdTpcKZyMWt+xy9anTNceRNxZ
 DjVkxEl2mIvJWiXm4xjVlHo1dympKTigr5zFFBUBtWoR//UnvzJMI9oWJ4A5eDovRqsP+GWLoCY
 R7TTDWtVFo1Upgr8Y3fUbFQsxqoA4W/0CKbj7YvNVJzEYjmLyAnUnQDTjDDQAc0LjhIuGb4h1i/
 VAUFFZWqGLFHeohzVNrrLTq/aPePXVig==
X-Received: by 2002:a05:6a00:228e:b0:827:433c:ba7e with SMTP id
 d2e1a72fcca58-8274d9ebdf0mr12827370b3a.41.1772500136339; 
 Mon, 02 Mar 2026 17:08:56 -0800 (PST)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d94de6sm14484988b3a.24.2026.03.02.17.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 17:08:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	jim.macarthur@linaro.org
Subject: [PATCH v3 7/7] tcg/optimize: possibly expand deposit into zero with
 shifts
Date: Tue,  3 Mar 2026 12:08:32 +1100
Message-ID: <20260303010833.1115741-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303010833.1115741-1-richard.henderson@linaro.org>
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Use tcg_op_imm_match to choose between expanding with AND+SHL vs SHL+SHR.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 59761c2c84..b1abec69a5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1743,14 +1743,38 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
             goto done;
         }
 
-        /* Lower invalid deposit into zero as AND + SHL. */
+        /* Lower invalid deposit into zero as AND + SHL or SHL + SHR. */
         if (!valid) {
-            op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
-            op2->args[0] = ret;
-            op2->args[1] = arg2;
-            op2->args[2] = arg_new_constant(ctx, len_mask);
-            fold_and(ctx, op2);
+            if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
+                /* EXTRACT (at 0) + SHL */
+                op2 = opt_insert_before(ctx, op, INDEX_op_extract, 4);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = 0;
+                op2->args[3] = len;
+            } else if (tcg_op_imm_match(INDEX_op_and, ctx->type, len_mask)) {
+                /* AND + SHL */
+                op2 = opt_insert_before(ctx, op, INDEX_op_and, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, len_mask);
+            } else {
+                /* SHL + SHR */
+                int shl = width - len;
+                int shr = width - len - ofs;
 
+                op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
+                op2->args[0] = ret;
+                op2->args[1] = arg2;
+                op2->args[2] = arg_new_constant(ctx, shl);
+
+                op->opc = INDEX_op_shr;
+                op->args[1] = ret;
+                op->args[2] = arg_new_constant(ctx, shr);
+                goto done;
+            }
+
+            /* Finish the (EXTRACT|AND) + SHL cases. */
             op->opc = INDEX_op_shl;
             op->args[1] = ret;
             op->args[2] = arg_new_constant(ctx, ofs);
-- 
2.43.0


