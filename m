Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F9C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEo-000236-5J; Sun, 04 Feb 2024 16:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEg-00021n-I1
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:12 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEe-0003VJ-V0
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:10 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d944e8f367so29516885ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082867; x=1707687667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRgNiPJydpvDmMhlC8JjCGm8KjRyw9Ww/5hSgKncWeA=;
 b=GWQSF/tHgGOKsfRTJYVx9Qp3o/J79d456+faWrmwtAGLeB84dJciMTfx43YELoYBXx
 MAPhOpzLH5SpTRrE1ZJCH/lrPM914iWotTiajqe2SrwkS/7FyAZbPac4b/DBwbUCqbvw
 17bLgRlQjgVWkgoAIdaEQaLFsWNIauI/axjwurIKUaGi1/Tlehahu98iBH2lQbG+1TR2
 iRobQdPuGaEV7LnFtPyHZY43qAMP1MypQEcL8Fv50YGZFvmy7E3Z+F9VKFUgeRfClahY
 oAonN9BR9DBZKPFpfbly8Xnjp3Fq6M5yI5rHEmZnY17Lw5KqOmm6o36HBKMIDyI07aEA
 6VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082867; x=1707687667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRgNiPJydpvDmMhlC8JjCGm8KjRyw9Ww/5hSgKncWeA=;
 b=S3wYQMnmcCioNCInEoExORHYnkpES0/UBVbC40gpIVusCjXEDh8sKUPEPxVXBF9kyk
 VyRVDNVYN9iwk6s0wQcjli+6gFNItyECcGkCT1EXQpnPEM34oU1ghYiefIfRSNM3Cqek
 Wy/ItV6AX8Uue30+8K0e0YPmhzBxRRalPLAjjJsO3LozTs0cemFHc+Fn/aCNXYhFElNl
 BAC2zRFVchStops8CjF91HYnMG4tHdXxmxrOZgou1f+2N5rNkCmMOKW9lKvTYGnDJpvX
 Wva+VJv9VJqsDRtrrKqIyOZEFbbZxGbDMtRJ9FSejDYwlBfDYMMY3OOlctk1ezTAbeq4
 jOAQ==
X-Gm-Message-State: AOJu0YxJLW3DXZHJdhSHrBBbxKc4ehv9vf3xItm7N8oA0XlOjJcDKh/N
 oArxni/2lz7LO7lHjFI56r1iQGVkK7bQuk5CjUZYZjrl4RlfCAYZJS5BOe4AnyWK/P+wmMTh5bG
 bxg8=
X-Google-Smtp-Source: AGHT+IFz6CHDUuDQ+vQ2G1c0VkUuZ008dKXCCxFnlIOXJnNk3PLVSmy6I3/r++Qj76ZcmhT3ceFgSg==
X-Received: by 2002:a17:902:6803:b0:1d9:5b4d:6ffe with SMTP id
 h3-20020a170902680300b001d95b4d6ffemr8606983plk.52.1707082867330; 
 Sun, 04 Feb 2024 13:41:07 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/39] tcg/optimize: Do swap_commutative2 in
 do_constant_folding_cond2
Date: Mon,  5 Feb 2024 07:40:18 +1000
Message-Id: <20240204214052.5639-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Mirror the new do_constant_folding_cond1 by doing all
argument and condition adjustment within one helper.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 107 ++++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9c04dba099..08a9280432 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -713,43 +713,6 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
     return -1;
 }
 
-/*
- * Return -1 if the condition can't be simplified,
- * and the result of the condition (0 or 1) if it can.
- */
-static int do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
-{
-    TCGArg al = p1[0], ah = p1[1];
-    TCGArg bl = p2[0], bh = p2[1];
-
-    if (arg_is_const(bl) && arg_is_const(bh)) {
-        tcg_target_ulong blv = arg_info(bl)->val;
-        tcg_target_ulong bhv = arg_info(bh)->val;
-        uint64_t b = deposit64(blv, 32, 32, bhv);
-
-        if (arg_is_const(al) && arg_is_const(ah)) {
-            tcg_target_ulong alv = arg_info(al)->val;
-            tcg_target_ulong ahv = arg_info(ah)->val;
-            uint64_t a = deposit64(alv, 32, 32, ahv);
-            return do_constant_folding_cond_64(a, b, c);
-        }
-        if (b == 0) {
-            switch (c) {
-            case TCG_COND_LTU:
-                return 0;
-            case TCG_COND_GEU:
-                return 1;
-            default:
-                break;
-            }
-        }
-    }
-    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
-        return do_constant_folding_cond_eq(c);
-    }
-    return -1;
-}
-
 /**
  * swap_commutative:
  * @dest: TCGArg of the destination argument, or NO_DEST.
@@ -796,6 +759,10 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
     return false;
 }
 
+/*
+ * Return -1 if the condition can't be simplified,
+ * and the result of the condition (0 or 1) if it can.
+ */
 static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
@@ -813,6 +780,51 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
     return r;
 }
 
+static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
+{
+    TCGArg al, ah, bl, bh;
+    TCGCond c;
+    bool swap;
+
+    swap = swap_commutative2(args, args + 2);
+    c = args[4];
+    if (swap) {
+        args[4] = c = tcg_swap_cond(c);
+    }
+
+    al = args[0];
+    ah = args[1];
+    bl = args[2];
+    bh = args[3];
+
+    if (arg_is_const(bl) && arg_is_const(bh)) {
+        tcg_target_ulong blv = arg_info(bl)->val;
+        tcg_target_ulong bhv = arg_info(bh)->val;
+        uint64_t b = deposit64(blv, 32, 32, bhv);
+
+        if (arg_is_const(al) && arg_is_const(ah)) {
+            tcg_target_ulong alv = arg_info(al)->val;
+            tcg_target_ulong ahv = arg_info(ah)->val;
+            uint64_t a = deposit64(alv, 32, 32, ahv);
+            return do_constant_folding_cond_64(a, b, c);
+        }
+        if (b == 0) {
+            switch (c) {
+            case TCG_COND_LTU:
+                return 0;
+            case TCG_COND_GEU:
+                return 1;
+            default:
+                break;
+            }
+        }
+    }
+    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
+        return do_constant_folding_cond_eq(c);
+    }
+    return -1;
+}
+
 static void init_arguments(OptContext *ctx, TCGOp *op, int nb_args)
 {
     for (int i = 0; i < nb_args; i++) {
@@ -1225,15 +1237,13 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_brcond2(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[4];
-    TCGArg label = op->args[5];
+    TCGCond cond;
+    TCGArg label;
     int i, inv = 0;
 
-    if (swap_commutative2(&op->args[0], &op->args[2])) {
-        op->args[4] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond2(&op->args[0], &op->args[2], cond);
+    i = do_constant_folding_cond2(ctx, &op->args[0]);
+    cond = op->args[4];
+    label = op->args[5];
     if (i >= 0) {
         goto do_brcond_const;
     }
@@ -1986,14 +1996,11 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[5];
+    TCGCond cond;
     int i, inv = 0;
 
-    if (swap_commutative2(&op->args[1], &op->args[3])) {
-        op->args[5] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond2(&op->args[1], &op->args[3], cond);
+    i = do_constant_folding_cond2(ctx, &op->args[1]);
+    cond = op->args[5];
     if (i >= 0) {
         goto do_setcond_const;
     }
-- 
2.34.1


