Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47891E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDY-000736-OL; Tue, 24 Dec 2024 15:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDQ-0006SZ-DJ
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:16 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDO-0002xA-Mw
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:16 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-219f8263ae0so23718105ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070953; x=1735675753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVk+VUZFNdsgvGVfECPDzgCPxhi/YGH65zoztjt+K/8=;
 b=em3+DBNIE8dSsSC2fg5T/psu7wO10DQPf7W9/QZMBhgb9zCiP+H8bXp4xut1ong3zX
 +U37iAg2NqDJFm+n8JSdRgqFqfAo9RQl8YFInuPoiefBl1bzr4kE/KjStfbhzDcw15PF
 7Of9RhUEIUKR3lIiFfttogXPzK0byMecGwvdo7fZg4JVSNDb6fqHwMIslYl7sTT3V3xI
 ZOzTPRGcdEEUMCBGL79o7+8zJqujw4k9VeBTJ8XJyiPv5YForRN8cTP5SSnPrp0e6E+R
 QaNl/fzE0+9fFbIN8Z++iedTkCojNeFX5P4c59F+BXl3nfYl7V1ms7Jr6EaiR3goflN7
 tuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070953; x=1735675753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVk+VUZFNdsgvGVfECPDzgCPxhi/YGH65zoztjt+K/8=;
 b=Q+t6J+QTpzWVnliQ+SriOvlifgu2IEAp+xRl63GoxPVVKr75j3NfxFNhd9s/3y+Uzm
 Ve5j00pj56Opq0Bs4/6KOZDcbo7sAYnIlww6TBKGr8SOS9gOiphIniqpgRhu3YWAy7jp
 CRwN5GlT9ats0TgoVbCmvV+kM6TvOrN63kAunWsk83t1IYIhYrfLCP1ogcQ7XaTG7h6P
 i3PMSFyyxcs35UxOAGu0gskHyjU6M1P0gu9jwH6FwazheRKJKP1uiwi8TdjwCUfg22AX
 UzN9+UP30o54ILYBy2t/PiFsZXzvs2savdXBWdePmBarKoszBr6QLUqdLw6KsFBL2X9l
 V92Q==
X-Gm-Message-State: AOJu0YxrFPq/RtOKwhMA9CVHIDcqEoqgDVjou/ADfuXiEYKBP4TSQA3c
 TathsUz5jbbJeu2PRoYRgMzWlUJe3bAaYQqppRoqLq757Ud1NyYsMT3RlFGVTWQSISf/212KYbB
 S+NU=
X-Gm-Gg: ASbGnctzicaGlKvFzb5PW4BVIwL9tM4gKSKAOXbd9Y45X3uG8pCIYLvwtghkKO2M0rn
 9NqB6NoNCJ1DDCT+82lha5l/bgK617Xo4Q+jqz/NpqwuFpbt1o+ANXeQOh0nPtIJqsaTHWe183F
 erTC4ZrTRfhn96SyIiT26rT3Ty0q42Guc5Z3JnMMFNsWUedVEDCnn9wpRCnPFH1vE4jOHHc0/Q7
 oEb9hMZgwk/2XklQJOowWaPii6StHEcps2CGpmKVnBlJWR2ll+BbjalrKMfCwzueFWkoSjBaWis
 BgPLJTdcErDuSpuaZHjxy3dAXA==
X-Google-Smtp-Source: AGHT+IHYWWLx/2Q2CBVyh8pKkd+IbXEq1RSw/0FztlYrl2vxyVfqskhzViQPLZz7fkN0UTnPGcQ2Iw==
X-Received: by 2002:a05:6a00:6f0b:b0:725:b4f7:378e with SMTP id
 d2e1a72fcca58-72abdbe0cb5mr23205064b3a.0.1735070953400; 
 Tue, 24 Dec 2024 12:09:13 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 53/72] tcg/optimize: Move fold_bitsel_vec into alphabetic sort
Date: Tue, 24 Dec 2024 12:05:02 -0800
Message-ID: <20241224200521.310066-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

The big comment just above says functions should be sorted.
Add forward declarations as needed.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 114 +++++++++++++++++++++++++------------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 182be7e63c..1df61378ea 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1193,6 +1193,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
  *   3) those that produce information about the result value.
  */
 
+static bool fold_or(OptContext *ctx, TCGOp *op);
+static bool fold_orc(OptContext *ctx, TCGOp *op);
+static bool fold_xor(OptContext *ctx, TCGOp *op);
+
 static bool fold_add(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -1356,6 +1360,61 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
     return fold_masks_zs(ctx, op, z_mask, s_mask);
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
+    return finish_folding(ctx, op);
+}
+
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
 {
     int i = do_constant_folding_cond1(ctx, op, NO_DEST, &op->args[0],
@@ -2772,61 +2831,6 @@ static bool fold_xor(OptContext *ctx, TCGOp *op)
     return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
-static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
-{
-    /* If true and false values are the same, eliminate the cmp. */
-    if (args_are_copies(op->args[2], op->args[3])) {
-        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
-    }
-
-    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
-        uint64_t tv = arg_info(op->args[2])->val;
-        uint64_t fv = arg_info(op->args[3])->val;
-
-        if (tv == -1 && fv == 0) {
-            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
-        }
-        if (tv == 0 && fv == -1) {
-            if (TCG_TARGET_HAS_not_vec) {
-                op->opc = INDEX_op_not_vec;
-                return fold_not(ctx, op);
-            } else {
-                op->opc = INDEX_op_xor_vec;
-                op->args[2] = arg_new_constant(ctx, -1);
-                return fold_xor(ctx, op);
-            }
-        }
-    }
-    if (arg_is_const(op->args[2])) {
-        uint64_t tv = arg_info(op->args[2])->val;
-        if (tv == -1) {
-            op->opc = INDEX_op_or_vec;
-            op->args[2] = op->args[3];
-            return fold_or(ctx, op);
-        }
-        if (tv == 0 && TCG_TARGET_HAS_andc_vec) {
-            op->opc = INDEX_op_andc_vec;
-            op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
-            return fold_andc(ctx, op);
-        }
-    }
-    if (arg_is_const(op->args[3])) {
-        uint64_t fv = arg_info(op->args[3])->val;
-        if (fv == 0) {
-            op->opc = INDEX_op_and_vec;
-            return fold_and(ctx, op);
-        }
-        if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
-            op->opc = INDEX_op_orc_vec;
-            op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
-            return fold_orc(ctx, op);
-        }
-    }
-    return finish_folding(ctx, op);
-}
-
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
-- 
2.43.0


