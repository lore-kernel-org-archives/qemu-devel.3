Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3F5CF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHg-0001hd-6G; Sun, 22 Sep 2024 08:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHL-0000vs-MP
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHH-0002Nc-DC
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so418539766b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006481; x=1727611281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zeN6h7OSkzIznAtGXkS2TM05Vzv6xYEK4cYNsvDB5Y=;
 b=jmWnQTiyPxdNf0WqcMfqfLTd4lpnVGqTwk/COH5GHtzlJ71LJcWoqOh2qrAmfOrHjF
 GGIy2+tQ68hjzerC3XjcnqrsiCKU8JE5LplD3OaNwemQhk/FYjQ371tSc3ip6VJcsrmg
 oqAdXSdAgFnZDhKuqSSSjAGaV0FT7MIPkzc2ku4NNwGvcAc3gq2vLKZsdIbhksL0ADGj
 yQeRrfO6rC8LGWOzecI7CvugPxA6IXtq5LkXKxGijX6DrVpo9LCjtzMFy8yfScSKFj99
 wC6eEeOydMO4grWOYFVDMDxSq5FjiSL6YF8iLA7LHzHZy4BSH7JgvDyMiUfTmR7btm7m
 smow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006481; x=1727611281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zeN6h7OSkzIznAtGXkS2TM05Vzv6xYEK4cYNsvDB5Y=;
 b=hpVwkXe9Flht4f93o97ycufaihfdoV8qnUFQ8eXY4DEq+iGMZpFoHS/zGq13hS2T8c
 H4mQ55J1VXxjcBsX/ZcH129+f3Cn+YzAEXR0bu7bQu5w9tFHVRWLO4v2FfVTUZp86kE5
 YTuCXq+LYWcpB5t1JWfSRw1t1yn7lVaqaK3h6663Lsw+6QBCbLVrUAlIabQYqt4BAnHv
 g0QMfpnXD4+c4CeoOt/FvGkMK8qeAeUoAgN/kuFOD64c/PpAjmqv9musCyjEa2MYnaau
 sg2tDK57JtS+gqL01Zfb7r5caPwZHlE0efgJ8miG39ZZOJrv5x/LSXDvKksbDPn+jGJX
 F/2g==
X-Gm-Message-State: AOJu0Yw9b1vAYxH59rQH5+p9uQErBRE9GfDbAxwthTREGB9TLbNZHPc/
 H3I1aaMiFQMQxRHHDOWgCNoCZJHuCyqI7YHOm2T/39wy+TpRB3fUi01zhgtsP0R+lo0zIxUC/Gf
 gW6M=
X-Google-Smtp-Source: AGHT+IHOaHZi4k/6+kCpm3Jq8g1Fcn9cZq1iOtykAGBpxiIchbnIM2a1IskeTMztyPDoGpwWpIqdyA==
X-Received: by 2002:a17:907:7e85:b0:a8d:caa:7ffb with SMTP id
 a640c23a62f3a-a90d561babemr746550866b.29.1727006481084; 
 Sun, 22 Sep 2024 05:01:21 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 12/31] tcg/optimize: Optimize bitsel_vec
Date: Sun, 22 Sep 2024 14:00:53 +0200
Message-ID: <20240922120112.5067-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

Fold matching true/false operands.
Fold true/false operands with 0/-1 to simpler logicals.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f11f576fd4..e9ef16b3c6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2737,6 +2737,61 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
     return fold_masks(ctx, op);
 }
 
+static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
+{
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[2], op->args[3])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
+    }
+
+    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
+        uint64_t tv = arg_info(op->args[2])->val;
+        uint64_t fv = arg_info(op->args[3])->val;
+
+        if (tv == -1 && fv == 0) {
+            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+        }
+        if (tv == 0 && fv == -1) {
+            if (TCG_TARGET_HAS_not_vec) {
+                op->opc = INDEX_op_not_vec;
+                return fold_not(ctx, op);
+            } else {
+                op->opc = INDEX_op_xor_vec;
+                op->args[2] = arg_new_constant(ctx, -1);
+                return fold_xor(ctx, op);
+            }
+        }
+    }
+    if (arg_is_const(op->args[2])) {
+        uint64_t tv = arg_info(op->args[2])->val;
+        if (tv == -1) {
+            op->opc = INDEX_op_or_vec;
+            op->args[2] = op->args[3];
+            return fold_or(ctx, op);
+        }
+        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
+            op->opc = INDEX_op_andc_vec;
+            op->args[2] = op->args[1];
+            op->args[1] = op->args[3];
+            return fold_andc(ctx, op);
+        }
+    }
+    if (arg_is_const(op->args[3])) {
+        uint64_t fv = arg_info(op->args[3])->val;
+        if (fv == 0) {
+            op->opc = INDEX_op_and_vec;
+            return fold_and(ctx, op);
+        }
+        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
+            op->opc = INDEX_op_orc_vec;
+            op->args[2] = op->args[1];
+            op->args[1] = op->args[3];
+            return fold_orc(ctx, op);
+        }
+    }
+    return false;
+}
+
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
@@ -2964,6 +3019,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_cmpsel_vec:
             done = fold_cmpsel_vec(&ctx, op);
             break;
+        case INDEX_op_bitsel_vec:
+            done = fold_bitsel_vec(&ctx, op);
+            break;
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-- 
2.43.0


