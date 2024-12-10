Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195FDE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL25u-0004Bz-Fs; Tue, 10 Dec 2024 10:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25t-0004Bd-0N
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:13 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL25r-0008IQ-Cy
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:12 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3ea36b05654so2929532b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844250; x=1734449050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MUsrrfhTagXqeJoeB4xz4rpIOAAqw8YmwMVIuKY4rN0=;
 b=v5zu+QUDCS5UGqxFHAIHZQ4HU042V5V6k/cjX9McOEp9z/pLcuzPie+6rbt/DvsFvc
 IHibHPZAcD4fkSI203Zm5bmrG6DfmwIFAwjDlUeKY1OVgzXySms0jf6yqMvFwf2BafFF
 y6cqjptMHmEk//pt4Uph4VaFd/NdiGZ/ZSC5Dy8x15yikHJ/KNvT0+HaXb3IDQAfmJmx
 EOummd0p4ZjJsYlkkKjCzZL5SttTym8GpvTxrwCBu5l7+OyVeGmxNfR+eq2fc/Y/5A4s
 hgM698cYdPPPmUueQqsd0Ui6ZzbX8TNwjQSfQllSCmiS7yWVIob/DryiQ0ovlKdBm3Cn
 1N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844250; x=1734449050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUsrrfhTagXqeJoeB4xz4rpIOAAqw8YmwMVIuKY4rN0=;
 b=vjia+4+EJgZiz6X8NMnpPaROmnZbGgfW7S8QFgT3GqLsim1mwWon1A0Q04o4TCyTYf
 5H89CEeee5MzcizZJllpR5dKqexqdxNMpQmjGY5EW5NvX5GJB+BLoI1e/V6QGCw1endi
 +WiXlrFToN944mOelxksndi9S3ypvuxFtW48hhqVqFUg9CQdZSYUUrfZpslJ4MbUoPmu
 AcpEQ+wIMbat1b4xp4is2kNlI3qWMCgt+aft3DpTEA+WbZDV0zrIoMvKLrtqYjQtITdx
 U8kT8L7MdijVBeRy+nuE5rc4TebWZLNMcc5RoBFp11uwES0tSzImfidPcWSmZB7xC2Ur
 iSwg==
X-Gm-Message-State: AOJu0Yz9fQmzXegs+O736BGo/pQCPLiinpfP9TJQy7nVaM8Ggd5MggnG
 BIZnDe44UO6Bjgb5f3+7YV2Wwl0O7CFMrzDLmN0AYSN0Pky29OZ6sC8baL98Gt8dp5UDk7/bLLy
 WbWsg+6at
X-Gm-Gg: ASbGncsmXdjHBiteA3MH/1TBRZD3l2nS2+CZywgXfuJA8Z6Z7ELEp0vOC7Bc+DNCxzr
 qNEL8RorjpUK/xejsMt+l4usJ4nbwacTj5W21fHxjVOts0IElcyRtxNKZaBtgbSZ3AykvPdXYUe
 cj7tPjhpTjIdsA7ukL1Ez8yPuYTucNTNrLOBMfgLbkicI95w2q7KDKWzP9NWkuLgqYA5thU0e3R
 O3OoQVaXwZ/dMatJj71RDKkeegZgtb/r2BtUXxYbRBjfbbDKv04kXR15Tyjkw==
X-Google-Smtp-Source: AGHT+IG11OU5v7Vd1Rqh+/W2uGiVVk4Pt61HJAYxL/5zB/sez7cs4pYTuWp3bCA+j11mMRPArQojsA==
X-Received: by 2002:a05:6808:3a0a:b0:3e7:b2b4:ee7a with SMTP id
 5614622812f47-3eb19df842dmr11783633b6e.26.1733844249835; 
 Tue, 10 Dec 2024 07:24:09 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/46] tcg/optimize: Split out finish_bb, finish_ebb
Date: Tue, 10 Dec 2024 09:23:16 -0600
Message-ID: <20241210152401.1823648-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

Call them directly from the opcode switch statement in tcg_optimize,
rather than in finish_folding based on opcode flags.  Adjust folding
of conditional branches to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e9ef16b3c6..20c918e83b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -964,24 +964,25 @@ static void copy_propagate(OptContext *ctx, TCGOp *op,
     }
 }
 
+static void finish_bb(OptContext *ctx)
+{
+    /* We only optimize memory barriers across basic blocks. */
+    ctx->prev_mb = NULL;
+}
+
+static void finish_ebb(OptContext *ctx)
+{
+    /* We only optimize across extended basic blocks. */
+    memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
+    remove_mem_copy_all(ctx);
+    finish_bb(ctx);
+}
+
 static void finish_folding(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     int i, nb_oargs;
 
-    /*
-     * We only optimize extended basic blocks.  If the opcode ends a BB
-     * and is not a conditional branch, reset all temp data.
-     */
-    if (def->flags & TCG_OPF_BB_END) {
-        ctx->prev_mb = NULL;
-        if (!(def->flags & TCG_OPF_COND_BRANCH)) {
-            memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
-            remove_mem_copy_all(ctx);
-        }
-        return;
-    }
-
     nb_oargs = def->nb_oargs;
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
@@ -1351,8 +1352,11 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
     if (i > 0) {
         op->opc = INDEX_op_br;
         op->args[0] = op->args[3];
+        finish_ebb(ctx);
+    } else {
+        finish_bb(ctx);
     }
-    return false;
+    return true;
 }
 
 static bool fold_brcond2(OptContext *ctx, TCGOp *op)
@@ -1443,9 +1447,12 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
         }
         op->opc = INDEX_op_br;
         op->args[0] = label;
-        break;
+        finish_ebb(ctx);
+        return true;
     }
-    return false;
+
+    finish_bb(ctx);
+    return true;
 }
 
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
@@ -3037,6 +3044,14 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(xor):
             done = fold_xor(&ctx, op);
             break;
+        case INDEX_op_set_label:
+        case INDEX_op_br:
+        case INDEX_op_exit_tb:
+        case INDEX_op_goto_tb:
+        case INDEX_op_goto_ptr:
+            finish_ebb(&ctx);
+            done = true;
+            break;
         default:
             break;
         }
-- 
2.43.0


