Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5C1E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlJ-0002ZT-45; Sun, 22 Dec 2024 11:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlA-0002Y4-JA
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:52 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOl8-0002wZ-0B
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:51 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2164b1f05caso31192775ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884688; x=1735489488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8y2SP5gsVRd2DDyIzSjHzTbblUtHqyMo6MFtQTYJr0=;
 b=enPxr/sT/UHNGTQxWtSudzFt78ZZwzD2BTQzV4ZTz6KB0SEjbQeZ0jF9ipkB4x2vVp
 g/1M8VjSsBiiMxnPASfmGE5ahaqA2KQ4Vunp2pbfEqghiod06MUcQ+8aGyFqT3yvS7gJ
 IWHKWjujoszTFBHCzFTnrkHe8x38HY4I3ahjcw+x8wLjC2HXpitM21XhfmoKzlXYDyJ5
 V2CZmhvG9swsBvuABiMi4oK+HDDMRMFVP5klnNXJCy3Fiv8HB9VFCgSX5xA3yXCrj71l
 Yg1AsoB6Lc6Qi8ZkDT+bS2aLVqBQqRvWVJetRG5W0/L5GJcc1swn1FlqeFQegBqA03Jy
 WH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884688; x=1735489488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8y2SP5gsVRd2DDyIzSjHzTbblUtHqyMo6MFtQTYJr0=;
 b=BGEDGLgWpcUg4YAkDCuJZxQAbcLWXSPODYADy3mo5QbfY0WNZ0LT0gScd2QfoHaY1W
 1G5rqMwQxhClIYOacl9xwlW8/sPymRNPTUGUZ25c6As9nCozVHzX+EyTezgDV6EVhteT
 +SXMHrzrU7XFFPlf+5JPtF7R3QVkVQLuDNn73Wf8+9lVx8gY20AjSTpJ0+y9PE+NIjd1
 sMwW9OBNPIhVBwvfqkCrZl+qtkG1NJ4blglB2CNblb2rcoZXP34pqeZjNZ/O8XXW3bp9
 bfkf3tcwuI4WiUnfNp9Ze5m2IYjRgqdICd/h/xnKOoI6dhPgt5R+/uTHQfFv4jCMZak2
 ObzQ==
X-Gm-Message-State: AOJu0YzhJJISsofRMAFkRTjKscuG7z27vwq7d8D4IgwxaPvRZvbAOtIJ
 r2Uinjmu1yJ+dYT6yVYN4R5VKge1k1wCT8sOp89aLJtgAIEjH72gL0LN5MyaWnbhTf6tJMroGtZ
 bNKw=
X-Gm-Gg: ASbGncvgy4TpEfwchsHejxbkxNuNX6DD9k6SKiOvZ/s7MG0IiQLGBE1uGuGZwKWpVDN
 Pw99hX6BWb8HsbqD/Jc+QAdt9lB/c0FcvTBK0mrKvJuxis2WihOnDwfwNbecCvPg7iIHF4wiB20
 1TssSoCtfcmh6nNhiPS1GrKHCG47ECovbwEEv9k6FaK3qMy9QM+6AAY0na05bJMJU5KD+uOm3TU
 INgIAd/X/TaiqrxnCbJ2JpElTtVkIRDYwRMvgQnU12YHldeLoKCKIDywvBvB2w=
X-Google-Smtp-Source: AGHT+IH7SODC73G8OQaLqUkM4p/Zm18XhYJsv3Upjr3YP8PC8Pmz66yA/UIs4Ik1Hikbxb9aBaml5A==
X-Received: by 2002:a17:903:41c3:b0:216:69ca:773b with SMTP id
 d9443c01a7336-219e6e8c3d6mr146708575ad.5.1734884688553; 
 Sun, 22 Dec 2024 08:24:48 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 01/51] tcg/optimize: Split out finish_bb, finish_ebb
Date: Sun, 22 Dec 2024 08:23:56 -0800
Message-ID: <20241222162446.2415717-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


