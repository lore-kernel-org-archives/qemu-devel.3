Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C34C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ElO-0006eC-Sd; Tue, 22 Apr 2025 10:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7El0-0006b6-0N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:37:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ekw-0002tH-MU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:37:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-739be717eddso3969486b3a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745332669; x=1745937469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvnVMMpqOyOlOcWxcxsXb+3KSms4sfQsygRKMFEzBjs=;
 b=BvnF/gtbHX7LnAYXseee6hOJMORhibAZd29FMlw+CKQcUFzOzbcL4CPo5zqiptJos9
 Ii91d9c8eJEIltHtCPtc/A6h4s8u+bM2ZBnKMyoCjiD0zqwZoWgwo6FI9CQX//0XdJwy
 WSyDO4EFqPR7SUEIQSirCkAagsV9P0esEF5BERwCsjLO2QYenh/UwOXs0Xp52K7Sdkne
 refL87JeGjb3sgqguRoxXzpLGyQUBmqVsNAp47KUAuapx6foWompiA4T0/s6DDxXZDsW
 rV7CcJKOm6LxTYz3iSMsI0h8wb9tiltDlnZyRXnTkZPdslahe/L2kIdnyK5pPmp4TtuT
 gg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745332669; x=1745937469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvnVMMpqOyOlOcWxcxsXb+3KSms4sfQsygRKMFEzBjs=;
 b=ljC3ag8Snmj4BHrVQcbLKftQISElS0ZVCA+BpHWYv+vbtxdWTPFHTHAGuVLFOrYHPE
 2YaZDx1xixTbAOTTKV5r/1H/NRe5Po6ODYTxVxaEXQovPUcHQThdisQaM95NgDYH5G+t
 jS5oCLLD8sbHyeWrBFb6ozdbtFU3n643aBEiUw/O+fg069CppCH8AifZTVXJ9qB7rnR8
 KxsAwJ3Gqd0tXHZY1LMowpqzoD60trsytUreI8MihXnCjErnucYOxOZoXNXsuNdkwT0Y
 5CdAAryYMbbBw8176mMWguR0qF2Td+pVDlXunPVxJoO8oBjUjBWg4X6Z6yQMpjnKQlvQ
 uApA==
X-Gm-Message-State: AOJu0YydXG0aF3hFcA0btuiKxIFnhT/6gbeXpz3BJOpII6ldTp/Hj09R
 V2ZtFdXxM5Kw4Zr7ga1VElvnkqQOJwP3CyMwDOPIKdkpR+hBQLGoyzRfi8JK/XAwy+/T8ogeFHz
 x
X-Gm-Gg: ASbGncuaMODeyVj4a0iFLnuuK/DOUepYg3qsRVl8KeEImuUavA2bu7Jb7ZauXmfogOc
 GjSi7sB3SAecFMU5GlwCk0Q7tbugCFntzjiWYfRyhHzlY1Q2PxHaaM/ddWwmWd30EjMzLet7kf7
 3KXO6LMG9do5Wuvvq74e9mVLDz+KDxmMIu3edftqX/Up2FRxvSV5GfYW1db5DyJKEd/o60wIA/J
 RfqzejJuQqXDJP0uyzxZwMBvbUqVjRXPrS0qo9X6tF5p5/u1u1CbNhgjBe4Nz84mQ+0k3xdLbeu
 fkCNZrYbbXw/pm1lme0jv5IqUH3InQKbUI7jMJ62qM++n7hWOV6ROiIMruufbSPoOFXTs9t4Z+U
 =
X-Google-Smtp-Source: AGHT+IHxzem8MOQtFAP4nPPWpD+zNWuVEg1nLOTwK8iOvY/2YIfJK3AGUlks35ORo+KxFDj1fKMRYg==
X-Received: by 2002:a05:6a20:cf8f:b0:1f5:75a9:5257 with SMTP id
 adf61e73a8af0-203cbc5342fmr25761264637.13.1745332669270; 
 Tue, 22 Apr 2025 07:37:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db157bb7dsm7375952a12.69.2025.04.22.07.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 07:37:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com
Subject: [PATCH 2/2] tcg: Add TCGType to tcg_op_insert_{after,before}
Date: Tue, 22 Apr 2025 07:37:46 -0700
Message-ID: <20250422143746.261776-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422143746.261776-1-richard.henderson@linaro.org>
References: <20250422143746.261776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

We cannot rely on the value copied from TCGOP_TYPE(op), because
the relevant op could be typeless, such as INDEX_op_call.

Fixes: fb744ece3a78 ("tcg: Copy TCGOP_TYPE in tcg_op_insert_{after,before}")
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  4 ++--
 tcg/optimize.c     |  4 ++--
 tcg/tcg.c          | 17 ++++++++++-------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index a648ee7a0e..56c90fdb7a 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -107,8 +107,8 @@ void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
-                            TCGOpcode opc, unsigned nargs);
+                            TCGOpcode, TCGType, unsigned nargs);
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
-                           TCGOpcode opc, unsigned nargs);
+                           TCGOpcode, TCGType, unsigned nargs);
 
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index a4d4ad3005..3bd4ee4d58 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -347,13 +347,13 @@ static TCGArg arg_new_temp(OptContext *ctx)
 static TCGOp *opt_insert_after(OptContext *ctx, TCGOp *op,
                                TCGOpcode opc, unsigned narg)
 {
-    return tcg_op_insert_after(ctx->tcg, op, opc, narg);
+    return tcg_op_insert_after(ctx->tcg, op, opc, ctx->type, narg);
 }
 
 static TCGOp *opt_insert_before(OptContext *ctx, TCGOp *op,
                                 TCGOpcode opc, unsigned narg)
 {
-    return tcg_op_insert_before(ctx->tcg, op, opc, narg);
+    return tcg_op_insert_before(ctx->tcg, op, opc, ctx->type, narg);
 }
 
 static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dfd48b8264..3d2f924881 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3449,21 +3449,21 @@ TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs)
 }
 
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
-                            TCGOpcode opc, unsigned nargs)
+                            TCGOpcode opc, TCGType type, unsigned nargs)
 {
     TCGOp *new_op = tcg_op_alloc(opc, nargs);
 
-    TCGOP_TYPE(new_op) = TCGOP_TYPE(old_op);
+    TCGOP_TYPE(new_op) = type;
     QTAILQ_INSERT_BEFORE(old_op, new_op, link);
     return new_op;
 }
 
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
-                           TCGOpcode opc, unsigned nargs)
+                           TCGOpcode opc, TCGType type, unsigned nargs)
 {
     TCGOp *new_op = tcg_op_alloc(opc, nargs);
 
-    TCGOP_TYPE(new_op) = TCGOP_TYPE(old_op);
+    TCGOP_TYPE(new_op) = type;
     QTAILQ_INSERT_AFTER(&s->ops, old_op, new_op, link);
     return new_op;
 }
@@ -4214,7 +4214,8 @@ liveness_pass_2(TCGContext *s)
                 TCGOpcode lopc = (arg_ts->type == TCG_TYPE_I32
                                   ? INDEX_op_ld_i32
                                   : INDEX_op_ld_i64);
-                TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
+                TCGOp *lop = tcg_op_insert_before(s, op, lopc,
+                                                  arg_ts->type, 3);
 
                 lop->args[0] = temp_arg(dir_ts);
                 lop->args[1] = temp_arg(arg_ts->mem_base);
@@ -4277,7 +4278,8 @@ liveness_pass_2(TCGContext *s)
                     TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
                                       ? INDEX_op_st_i32
                                       : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc,
+                                                     arg_ts->type, 3);
                     TCGTemp *out_ts = dir_ts;
 
                     if (IS_DEAD_ARG(0)) {
@@ -4313,7 +4315,8 @@ liveness_pass_2(TCGContext *s)
                     TCGOpcode sopc = (arg_ts->type == TCG_TYPE_I32
                                       ? INDEX_op_st_i32
                                       : INDEX_op_st_i64);
-                    TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
+                    TCGOp *sop = tcg_op_insert_after(s, op, sopc,
+                                                     arg_ts->type, 3);
 
                     sop->args[0] = temp_arg(dir_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
-- 
2.43.0


