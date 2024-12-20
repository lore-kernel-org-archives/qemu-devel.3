Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C0BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUM5-0008Ko-2J; Thu, 19 Dec 2024 23:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM2-0008Jj-Vu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:11 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM0-0006Fr-3Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:10 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166022c5caso12521185ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667866; x=1735272666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8y2SP5gsVRd2DDyIzSjHzTbblUtHqyMo6MFtQTYJr0=;
 b=y9dOPg+Ji83v30rY70HGLg5/rEjIeA+YGg4GGS+6YhSRr3k1kkDrRiME7BSWw0q14n
 dy/xwiHrYyBL5Pbo3WFKoEJvJBfz5J4jE9yeE1InMnjmqgWRHvOF6q3f1OTcNqopRKA1
 s8WQGUl1rdTMmi1ppwugeJrSCFbnQSUnkq/uXJjth/y+xuG9NmhFbaByLVkCvhS7jNf/
 aVvBCN3HtDjcR0oSOOPJxaNWsc4KeydyqBH4CKS/k/8M3ufRBrCxPkJcdK42OcYwKTM1
 Yi2ac11VQhX0qfOC4+acwIXBHajnTaEQe9YOuM/Ixnglj41eJZ+/VxyOqg+lxA0OM+DY
 +H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667866; x=1735272666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8y2SP5gsVRd2DDyIzSjHzTbblUtHqyMo6MFtQTYJr0=;
 b=NGH3pxFVgePta61xL94uPuy3LTQwAz8yZt973m1semMsmqLA8XMN/1MeMq11uiKDHJ
 Iw3L6uI3HuypDtDhg1RC4xMHfbVgaACPk5c1a4uoGudJdJRlveSR9HGI+DYF4u2bGvu+
 4QXqDULYgLiwezj4z7ALpKVGzGde3CT4KqTD3YWRpQ+3FCjBwGyyfh69J7VKk6Z9rVv8
 fUUflUuEwPPnAtZC9Im+3xgsBECTbs6buS0RW5XX6fYK8cIhIEcwTeOW3wcfuOEuutlV
 CNl3N9qVgEuXrP5FR9g8j6KVywjDosJMXCKvxesM1Xeen+tKHQ6JuFR19+WjcBEj9162
 p38w==
X-Gm-Message-State: AOJu0YzG9c9zXvX+Ip5hK7uxigcgdgf4AYUROIbGDEnLh0OY1NYNYnJu
 Sf8OAfg4WdSqWQoX6E8+GcAwHpJH+Tn3u7xBGrZOh66e85ubYY+qF2Q947BGd490yNh+GoOqKTn
 O
X-Gm-Gg: ASbGncviRD/W2WblnlEJ4oWmy6Ib0Hix+pYsBZcAkHymjTYDW5m1EFMtNuJltbi19F9
 eR/HQyH1tNrDjcLDcsEGlsxUEZKZGuZ13R6A8XEA3NxpQn2X3CIGTozFQFGCoZvrCmOjkIJQxdg
 b8LBvM8cBcX4/M5vx0fZ3BmZlsESedl4mKrCdtLpm0Kb2zhDY8A3L6zfXs0OTCG6ZwjsvMeuYKf
 R8qkSF5VWD5/WXE43XsSv+FtEqqZmFlIAczz8PQv2p41KZpRXLbBo6n+kQMH4k=
X-Google-Smtp-Source: AGHT+IGDUAPPF8eayva0pbLRcYAzPJ+BP9D8YRCS1S7KcW8+QTTZ6ODmVJVvyjsgwa2MHot7ao75og==
X-Received: by 2002:a17:90a:d448:b0:2f4:43ce:dcea with SMTP id
 98e67ed59e1d1-2f452ee5e95mr2088579a91.25.1734667866161; 
 Thu, 19 Dec 2024 20:11:06 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 01/51] tcg/optimize: Split out finish_bb, finish_ebb
Date: Thu, 19 Dec 2024 20:10:13 -0800
Message-ID: <20241220041104.53105-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e9ef16b3c6..453e8c43bd 100644
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
+    finish_bb(ctx);
+    /* We only optimize across extended basic blocks. */
+    memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
+    remove_mem_copy_all(ctx);
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


