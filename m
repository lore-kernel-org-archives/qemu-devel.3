Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB96C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0h-0007EH-Mc; Fri, 25 Apr 2025 17:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0f-0007Co-Ep
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0d-0000IN-BR
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739be717eddso2231958b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618098; x=1746222898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6mwXVI8d1YSlQiyWs1i63ZlMrwCEMPHw0ptzVPcyMU=;
 b=gKS5DG3O1IOgK9vmRQJzbuWpL77QqzT3x11mY8SxJ2tYUqPwON14Wi+Ripz2BeQobV
 fny3AxEstgwjRnkiA0rpqAkNuANKT2SX7M4+iiXOeJYo5dUJUY5kJpZSs/bwY5IM87yC
 j/G71WkbF2emp3Il+Zf62GZmOU54+MzpHQUE8vV/sppKNnyGNMdbHnOrCk75PiQMcbTD
 awYDQ6MJyOEJw/kRl/QNxmTszmwnW1TyXeyn+VtJ4u0YgNlSlb8OPDphR42rt1xLrDiP
 ECay8WXePGzU3dmw15FvN1TEe5O8DESmKLe2LcAKHlE+ZsDPB66uy0+nviKt3aRrfS6r
 3Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618098; x=1746222898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6mwXVI8d1YSlQiyWs1i63ZlMrwCEMPHw0ptzVPcyMU=;
 b=ZBuMtUYyRCV36M+oaNTUARrmD8rLrNThCV3HjDTHSOcD2btoGvW1md+C0UqcrCxLni
 qhYbxDE7GS5BTW7ZJyOiPjHq3287b3erT+11Ek7EMIkqc+w1rj2T9TUr4uTSx+aFBXd/
 AQQzYbBujQy6dSz0HYsp9ZQ0g6Eo33Q1ZZDhcU+70vpn6WLUH/OiUqGdrMPOnFI8aJcS
 hAa0E8sWZlFLpTx36tM+R3DuEXOXgw4c/GRBTne3YmO/PuSjDX9Xmu47PXs77Gl0DDgU
 zN82p1trZvu/uEEET59fVw6mwkY70U1EvgdXGVqae/hFvAkPpyIFf6dXkSZD+HDw+rQ2
 nkjA==
X-Gm-Message-State: AOJu0Yz+YffITzcOk2aVUXNEETUBvt4GGzfep4lVl3IO6fO/BApKMWAz
 JeV/fSQnIZtxYugOEGdCxTI+iHOI7FkPUjNq1XQqGk0SQU8gOszgR7GTlUylaSQO0tgt/yqlauI
 j
X-Gm-Gg: ASbGncuMaRzDLSbJwWKenI6kT+lShPgtOtlbuxo8yvJxqDYgDSxbcNgmp62V1Pt8tUC
 E1Fr7zdejsSs2jgpS68Io4/pvy4p8Zh4iR4TgabEks57TVEIW1+CqN54gNKjLWdiTnmzstgda5k
 EuB6s+TOW3Ic2rdJOpBTWM43aWHaH9Dpet+n3ILZcYg32tevjFVgiuN08FcRBghInztLQsCF6Xc
 1fHFGbOu4DB/O1Qv770XtbSM0UepmdRSs/XFqvMIZ+Fk2Xv8ghR+reg22I/qtPhE247nSYA4fhx
 u/QPEkdR99HFR6/zWgXtEllJgf5F7iHXyjsofvJh1q5XZQNpgl4Pse+clQjako9wrjBI4evf1YE
 =
X-Google-Smtp-Source: AGHT+IHZtGI0nCrwaS/jVbiUAAkIYhLe2hDXT30By5qfKIOVAdj7Cm5H6Xq87sMXo++tHmxgpwXRVA==
X-Received: by 2002:a05:6a21:9102:b0:1f5:619a:7f4c with SMTP id
 adf61e73a8af0-2045b99e19dmr5977835637.29.1745618098089; 
 Fri, 25 Apr 2025 14:54:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:54:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 004/159] tcg: Add TCGType to tcg_op_insert_{after,before}
Date: Fri, 25 Apr 2025 14:52:18 -0700
Message-ID: <20250425215454.886111-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  4 ++--
 tcg/optimize.c     |  4 ++--
 tcg/tcg.c          | 17 ++++++++++-------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index ff85fb23fa..d6a12afe06 100644
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
index ec7f6743d7..198d6181d9 100644
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


