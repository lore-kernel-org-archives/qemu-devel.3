Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE1C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Lt9-0003Ox-AZ; Tue, 07 May 2024 10:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsj-0003BR-QQ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsa-0001MK-Ii
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1eb0e08bfd2so17930625ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092394; x=1715697194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5odWkAYeVMNCe6Cty3EzFB4YygxLZJZYtuimpCAAowk=;
 b=ElexNxAod7TGJHvlmsMOZgmZDNZlitUaXUoHL6AmfVd/+92UAywgSLISqaqMaWRPq9
 jT4ha7oCC/eBiiAuiUUGvXhY1H86PNReZybtkW+MA36Kyu0za9fQ1cArR4kMcYJElA/x
 CTcD8Cd1oStwT7Yw0Lwco2IV3pMVm4iJK2cXTi7bYrtZyNDmzmLvz9YmKrlh6HzwmhoF
 eraGmVd/Ov59uyGY4Q9Q0HYlwNTWqwOah1cqhlsY5BCbydH1DnDEC1lfIV3ulGuoyk13
 Scjp8u15FX7PvpDztEAfNB7T1ECprN1i0gTT/xmVIzgN7cc+XyEdyv7m+1+lmINm8WSS
 Gmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092394; x=1715697194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5odWkAYeVMNCe6Cty3EzFB4YygxLZJZYtuimpCAAowk=;
 b=QiVNA9rJWnYgQgoGpnpm7RiBYl2104AvCuFO531X7ewnYxC1ehB3jIHi7XI3P1QnZq
 90DukE2XLD8ehjhNJn6DSUqn1Ae0wEiwLM6ifIbc1lM4Mhk+zcR0qI2uF457Q68ymVyn
 rIN1yvDDC5kVdSB3OTmMV4+L1lJ8VTl1IgU4p/uEC47Tf1oljz4APkvkc6cxpu5oD21o
 XZrefvVps8NIxVCxyimyEp9+mMO3XI2ljKziQ2NggqhnfA2G8Yc3I59wC+TWicOELPKy
 jwDpz6ehZOup0yJOw45gUdOY8971VmiL59sRVGyAZpy9YyCICVm2i7jyjl2ktaRjmJ9U
 3uMA==
X-Gm-Message-State: AOJu0YzOkcbwdfZ/rKRFnX/DIT8wilRo9OyKb2sW+iA2EpTJymCPtPpa
 69iImsZU4IJYmk6koigKuSJsglcpAZ1ezhYgYMsVNqo3YeHobamnqv1PnsVn9DFN47+X48hy4zG
 S
X-Google-Smtp-Source: AGHT+IGbo/R87qjbZJ6QppuTS7cd6ecYBvKy/TZpIhcllv2dglDOyo3xsbBhPMfRu+aWAvNecVl9yg==
X-Received: by 2002:a17:902:6503:b0:1e0:a3dd:82df with SMTP id
 b3-20020a170902650300b001e0a3dd82dfmr12718209plk.38.1715092394503; 
 Tue, 07 May 2024 07:33:14 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] tcg/optimize: Optimize setcond with zmask
Date: Tue,  7 May 2024 07:33:04 -0700
Message-Id: <20240507143309.5528-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

If we can show that high bits of an input are zero,
then we may optimize away some comparisons.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2e9e5725a9..8886f7037a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2099,6 +2099,108 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
     return false;
 }
 
+static bool fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
+{
+    uint64_t a_zmask, b_val;
+    TCGCond cond;
+
+    if (!arg_is_const(op->args[2])) {
+        return false;
+    }
+
+    a_zmask = arg_info(op->args[1])->z_mask;
+    b_val = arg_info(op->args[2])->val;
+    cond = op->args[3];
+
+    if (ctx->type == TCG_TYPE_I32) {
+        a_zmask = (uint32_t)a_zmask;
+        b_val = (uint32_t)b_val;
+    }
+
+    /*
+     * A with only low bits set vs B with high bits set means that A < B.
+     */
+    if (a_zmask < b_val) {
+        bool inv = false;
+
+        switch (cond) {
+        case TCG_COND_NE:
+        case TCG_COND_LEU:
+        case TCG_COND_LTU:
+            inv = true;
+            /* fall through */
+        case TCG_COND_GTU:
+        case TCG_COND_GEU:
+        case TCG_COND_EQ:
+            return tcg_opt_gen_movi(ctx, op, op->args[0], neg ? -inv : inv);
+        default:
+            break;
+        }
+    }
+
+    /*
+     * A with only lsb set is already boolean.
+     */
+    if (a_zmask <= 1) {
+        bool convert = false;
+        bool inv = false;
+
+        switch (cond) {
+        case TCG_COND_EQ:
+            inv = true;
+            /* fall through */
+        case TCG_COND_NE:
+            convert = (b_val == 0);
+            break;
+        case TCG_COND_LTU:
+        case TCG_COND_TSTEQ:
+            inv = true;
+            /* fall through */
+        case TCG_COND_GEU:
+        case TCG_COND_TSTNE:
+            convert = (b_val == 1);
+            break;
+        default:
+            break;
+        }
+        if (convert) {
+            TCGOpcode add_opc, xor_opc, neg_opc;
+
+            if (!inv && !neg) {
+                return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+            }
+
+            switch (ctx->type) {
+            case TCG_TYPE_I32:
+                add_opc = INDEX_op_add_i32;
+                neg_opc = INDEX_op_neg_i32;
+                xor_opc = INDEX_op_xor_i32;
+                break;
+            case TCG_TYPE_I64:
+                add_opc = INDEX_op_add_i64;
+                neg_opc = INDEX_op_neg_i64;
+                xor_opc = INDEX_op_xor_i64;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            if (!inv) {
+                op->opc = neg_opc;
+            } else if (neg) {
+                op->opc = add_opc;
+                op->args[2] = arg_new_constant(ctx, -1);
+            } else {
+                op->opc = xor_opc;
+                op->args[2] = arg_new_constant(ctx, 1);
+            }
+            return false;
+        }
+    }
+
+    return false;
+}
+
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
     TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc;
@@ -2200,6 +2302,10 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
+
+    if (fold_setcond_zmask(ctx, op, false)) {
+        return true;
+    }
     fold_setcond_tst_pow2(ctx, op, false);
 
     ctx->z_mask = 1;
@@ -2214,6 +2320,10 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
     }
+
+    if (fold_setcond_zmask(ctx, op, true)) {
+        return true;
+    }
     fold_setcond_tst_pow2(ctx, op, true);
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
-- 
2.34.1


