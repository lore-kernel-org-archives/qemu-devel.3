Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F609C5CFC1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwsp-00042P-EP; Tue, 11 Aug 2026 20:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwso-000429-Mv
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsn-0000SD-1y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so517466b3a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494708; x=1787099508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ShHagJFPCpKOUo+itn/8wD0Rm6G8LbkyM3xldQpaDhQ=;
 b=KMc5SXNQ+h+sfHzKgsxp0QWOPjfhqQHGu+D6BHfMUz1b5P2fLrNOnmT1ERCgy4Ck6U
 NyzDwM8l7rRn3Ojo1YKXoiLQK5DfRMZwX3IZ9VuN+YK15fHHSA6++4BTkjQIxM/C7ptM
 OxhuRbp2PZlAatK/ZIvtDc2fzDQ2PtImGPCg3/rj1dr/RxTiQgVrVM1UlLPuYkwJEc6m
 3MZIEFFn49hT2/a2rLjsKnXUHDd3jJ2QU7Wu5ejbCELM+xwzpbbbNrEpWH1JzD0y1rRg
 wo5/p9vM/rkn79wS4D5IuhxcJr+Fu8m2ivC+AqlXA2Qx9JXcwPaY44NwUUKtwHJrKulc
 MDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494708; x=1787099508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ShHagJFPCpKOUo+itn/8wD0Rm6G8LbkyM3xldQpaDhQ=;
 b=RtT0OyyaF2TTBnZe3kE9A+I8UqXHGvJtZuYCsQ4oRMSxlFl8UpRJ2KAmQZfEQF4aSm
 HpSAYoruTF0vEKKEm8wKSTystsF8MNkBkVx5+VkMMNeSAa5QMU6ePQ1Ew3einx9ZzSqq
 dGZo3+K8jflHtc7gd/L6vKWHvsTY16u7rcQn4kef4azEkKHxgYQ+ziKrUOjjRMfoGaLW
 m/y6hYrqSArBwzQP2vLTn6qDQSOc7qC+aULejvN+aGPh4oTEtl3vkSVvr1qpqNyIrg6P
 kOJL7+N6xgss0ALL0RreLRpmAY1uSaUjPLofapSg9zhc0D2Cyk+eQfsbzl8joNS0t7Cu
 N9rg==
X-Gm-Message-State: AOJu0YwtWU5YTXqyxtCSmd9ml1CwlTj//v9IhsI1i87aXP6K1CoNHfjj
 d01YLoGpOrXyOlrnNeIv6Ca+1iICJjjgV64OwpAUV6OcbRT65N6RfOWqhDjGqzAdrgkoSvJpGR2
 HwA+t
X-Gm-Gg: AR+sD12yz9iSM8GeY4PxJfQU/6ol6NxmkRUhp2MaG7hhFZDfnjZuNetIvAY39MQM/Z6
 9ExgSY4bV2CkZlTtsBfcqpkiLfOor0QFZ2YfnsfRVmwb+I24b+KqSjGi9Z7iHMKrlKM9HNC77mU
 YngPmDOJe1pzhwSvUOIB4Y3d8B9eF2Tztjnyfe1+O7T0rOeS3YjTDm8FcIxv/TDIIr4WN1dCR7v
 PVFduebMCOdFcW/OTND6Si8KHPf0xN1RKQLeiO2ldQK5BywyEz8NL2e13/cAHuIshxUUKRP6yq9
 Ke8L/3YgsoF2TavKFjqcw7l8SyVETWU/cCVQjGhpzDQc9OQ6GvIdN82n1+qTorhJ+8y0gh4oPDW
 O+ofjXriFhNa3AwPLEC4R3QwpErxqf+jkyA2t6JhUFG3bKyn8V7v7OjBw790SZZ0gUaPpzwdyo3
 JKnQx4gmmIkmBYcydqel+pqN164GgiCFKuRzMCZPuWMnAd4tCqCTvyJHPfuSeYAI7i7hLkmc/Qr
 +fuTBWMTVW+PeeowM28
X-Received: by 2002:a05:6a00:1da5:b0:842:706e:ad43 with SMTP id
 d2e1a72fcca58-84fb55685dbmr1183796b3a.33.1786494707559; 
 Tue, 11 Aug 2026 17:31:47 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] tcg/optimize: Handle min/max opcodes
Date: Tue, 11 Aug 2026 17:31:38 -0700
Message-ID: <20260812003143.225228-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812003143.225228-1-richard.henderson@linaro.org>
References: <20260812003143.225228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index facf4c1e0f..d291c844ca 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -597,6 +597,30 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x % ((uint64_t)y ? : 1);
 
+    case INDEX_op_smax:
+        if (type == TCG_TYPE_I32) {
+            return MAX((int32_t)x, (int32_t)y);
+        }
+        return MAX((int64_t)x, (int64_t)y);
+
+    case INDEX_op_smin:
+        if (type == TCG_TYPE_I32) {
+            return MIN((int32_t)x, (int32_t)y);
+        }
+        return MIN((int64_t)x, (int64_t)y);
+
+    case INDEX_op_umax:
+        if (type == TCG_TYPE_I32) {
+            return MAX((uint32_t)x, (uint32_t)y);
+        }
+        return MAX((uint64_t)x, (uint64_t)y);
+
+    case INDEX_op_umin:
+        if (type == TCG_TYPE_I32) {
+            return MIN((uint32_t)x, (uint32_t)y);
+        }
+        return MIN((uint64_t)x, (uint64_t)y);
+
     default:
         g_assert_not_reached();
     }
@@ -2101,6 +2125,16 @@ static bool fold_mb(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_minmax(OptContext *ctx, TCGOp *op, uint64_t bound)
+{
+    if (fold_const2_commutative(ctx, op) ||
+        fold_xi_to_i(ctx, op, bound) ||
+        fold_xx_to_x(ctx, op)) {
+        return true;
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_mov(OptContext *ctx, TCGOp *op)
 {
     return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -3258,6 +3292,14 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sextract:
             done = fold_sextract(&ctx, op);
             break;
+        case INDEX_op_smax:
+            done = fold_minmax(&ctx, op, (ctx.type == TCG_TYPE_I32
+                                          ? INT32_MAX : INT64_MAX));
+            break;
+        case INDEX_op_smin:
+            done = fold_minmax(&ctx, op, (ctx.type == TCG_TYPE_I32
+                                          ? INT32_MIN : INT64_MIN));
+            break;
         case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
@@ -3273,6 +3315,16 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sub_vec:
             done = fold_sub_vec(&ctx, op);
             break;
+        case INDEX_op_umax:
+            /*
+             * Note that 32-bit constants are stored sign extended,
+             * so (int32_t)UINT32_MAX == -1.
+             */
+            done = fold_minmax(&ctx, op, -1);
+            break;
+        case INDEX_op_umin:
+            done = fold_minmax(&ctx, op, 0);
+            break;
         case INDEX_op_xor:
         case INDEX_op_xor_vec:
             done = fold_xor(&ctx, op);
-- 
2.43.0


