Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B58E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOpc-0005Rc-6w; Sun, 22 Dec 2024 11:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOod-00051p-0l
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:29 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoa-0003kO-O4
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:26 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-728ea1e0bdbso3145058b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884903; x=1735489703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQH+PLeOfmKV/hMlw3a5mreXmP+mpfARLWnXc9y+J+4=;
 b=eUvpJs0LE63PL7s3ZJnmUQTBU3wmhe5a5hj7+6oEhpQOvJnRaDW4ov9PEg2ilzvd9Z
 P2ITmp6+KMEU/80ras5zdSDBCWcO7EHoW5HmxyS5xabCRgNcQxKjemFzQTelzrSYPmxj
 TEphB5GgGNWpxH0tcW6tJlawD/f2Mv7Mc1WfS9UDS8JoYtahyGAf6yFTxLwj+fZFTv9s
 4RbJx5WUqC/LPVwmPsKpSzp3OgL6x6//IyW07xPMBBC8LzYY4kzmLI+Mlhv63QCebUgj
 CAEOnCJUYYsjMMdUni5C4RNDnOZewpt2j/PFRMBw+mAy0e4q9dN6VXHaSIOzjaXnyB5l
 k0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884903; x=1735489703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQH+PLeOfmKV/hMlw3a5mreXmP+mpfARLWnXc9y+J+4=;
 b=Y8WHzC8CwHl7fT9jFS8LVUIzXYYbEmawuWOCE75n5pDI2/SyLJYy5x2Z79DB7mvx5f
 ZYo0sFej7YvdnzfEjHs51+Wfm3h/ARWJFEo2xJddxX6jj8MmfMMpXMd1TxyqcK0BkRYZ
 lHtyKtG+iXNZs6aNWY0YI5B4wx6ScmAaVTbqeK9jCrJHclPT+eFdm5/23oUrHz/6LCtN
 jmqC78zsdCaz/gqslBfjIX+2uUPPWU/ojEwpdli8msIEjg/B94267csJuM25Pl+q+sWN
 l9HZZeQz1bqu16XioDGVnUS/tuAMLonz70vNFdeYt2PGU9AW9mkwCusdRtQx22NGmtGh
 Fdfw==
X-Gm-Message-State: AOJu0YwW/7tgcGfX6Uju+63+o6iVKG5OePoSpULPHluBKNQnVNO1csor
 /61UnfMLXRMOjmoDWOhwSVEiCCj44LcaiBemcG6Zw4AD+qLqXpEKKAG6abZCUyHicP42qGtxq4v
 bAvI=
X-Gm-Gg: ASbGnctoyuPB+BRz95fczdJCf9mQF/dR5GEF+IWcPX2tJL38w7ruHulxnMBDUEP9ko/
 e49ZkDUs2Ne8D0/SZaSM4qgtm7mOoBONkcQey3p3iyd1CvlFALU8td1hO8cGpAu2JjZyIzXg2zc
 ZijQiC35qpFW99eZb1d+3F+NBl/hhbJHvywsczZFybHWutLxGUnmgnT2qrxd6TarAR7czFiLgGi
 Fe6u3XBb2WSmMxvp/U0huoEHhyhGkqlBxqVp/J5NCztxPaAcc5Wtv1JRTbS/xc=
X-Google-Smtp-Source: AGHT+IF0bWbSlEG5YE5v++2YzUlqLdqMq4M2OQX1WDgkIrRID/z1JJOXV7P7r0JP+mEru9PGQhZTVg==
X-Received: by 2002:a05:6a20:e68e:b0:1e1:becc:1c81 with SMTP id
 adf61e73a8af0-1e5e0801191mr18594050637.32.1734884903544; 
 Sun, 22 Dec 2024 08:28:23 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 51/51] tcg/optimize: Move fold_cmp_vec,
 fold_cmpsel_vec into alphabetic sort
Date: Sun, 22 Dec 2024 08:24:46 -0800
Message-ID: <20241222162446.2415717-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 312cbac690..2a9c87eb07 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1603,6 +1603,36 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
+{
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[3] = tcg_swap_cond(op->args[3]);
+    }
+    return finish_folding(ctx, op);
+}
+
+static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
+{
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[3], op->args[4])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
+    }
+
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[5] = tcg_swap_cond(op->args[5]);
+    }
+    /*
+     * Canonicalize the "false" input reg to match the destination,
+     * so that the tcg backend can implement "move if true".
+     */
+    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
+        op->args[5] = tcg_invert_cond(op->args[5]);
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask;
@@ -2502,36 +2532,6 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
 }
 
-static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
-{
-    /* Canonicalize the comparison to put immediate second. */
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[3] = tcg_swap_cond(op->args[3]);
-    }
-    return finish_folding(ctx, op);
-}
-
-static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
-{
-    /* If true and false values are the same, eliminate the cmp. */
-    if (args_are_copies(op->args[3], op->args[4])) {
-        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
-    }
-
-    /* Canonicalize the comparison to put immediate second. */
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[5] = tcg_swap_cond(op->args[5]);
-    }
-    /*
-     * Canonicalize the "false" input reg to match the destination,
-     * so that the tcg backend can implement "move if true".
-     */
-    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
-        op->args[5] = tcg_invert_cond(op->args[5]);
-    }
-    return finish_folding(ctx, op);
-}
-
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, s_mask_old;
-- 
2.43.0


