Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D431E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUQ9-00022y-7r; Thu, 19 Dec 2024 23:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPX-0001Yf-Ku
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:50 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPV-0006rk-Lx
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:46 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72764c995e5so916821b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668084; x=1735272884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeaDhdgh49HwDL7JKkbuMtxfcE1xBL3FzDC+L5uqhuU=;
 b=az/e7WiTyBU6GWbHaOWKF+fW0NAOE7ipcGRvHTVnEBOgqw1evvgETq/qCpMPD+Hp/U
 nq1uqk6uvQEnqz6HPrGrewpckEPS4wnFz+0Ca1G71q7XyjdmiIadziBo7Q9v9Lg4+hGi
 6WPcmQ3Gh22eNSQXCwO7LDR088ElAK5pfRPED5FJbz2DiJCxOhbTNrchmZJNq4lnr7B/
 s+UEH0Ct9WvFSKCg449rfLfjunMWCaI5NGKMkUzHERiRBnE1LJ7ynZ5bhwlSNazeKX+y
 xg2bd+RSf8rbJTfhv8Tc88tq3zh4pEojnSVTK04FBD6VOntLDNxYH1F0AebrR4xCLb5Y
 lREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668084; x=1735272884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jeaDhdgh49HwDL7JKkbuMtxfcE1xBL3FzDC+L5uqhuU=;
 b=pbX5tQhRZB4UwuEZn05CPGnrR757+Je7ewhP2GZTKYKffJYVHQU25vsV7tNOgYv11s
 EkrZyE6a3bauAMIUooEFcfkUctXV8yexrmNfGbo6+GAsog1f/U7nKDNCLIFuhbIieNYF
 OsxEK5WndZi+3dTvuzZCFyU1abvR9VR8/YIxVQchw42p6sjT9niK2BK24obpE6bbCUGV
 whyXoD17KYfqm1zrnqy17u1jNyTVX6wK0pUVGbMuVW1yazc1YtXOns9gPeMtkJvPMY2h
 jexba8liWAXlZRqj+sJSnDXsz8kYz6XjXzmRBdvxBdWVclNuvh6ZNcSo9SIULX6z9YVo
 X52A==
X-Gm-Message-State: AOJu0YzrOdZsu/q0x/omLze9ImKKWMRhQN5U2h98y3FePaREykc+brk0
 fmbYH9yE4RUoGuxMX1fgz2tQMf+3iVHNytFYpA8Ju9qq0PK9PVtYflS0Wrg1ZqNwYnGqyNp1SsZ
 4
X-Gm-Gg: ASbGncuslQ9sz3OpT2u1+C/KRF4AQPscypUMnXo7OAlXwK0kH60l18p9zt3P4gHJrBa
 LQqHOr29h4TOTMTLXxiBKbXLlKjHzy53j78x7rg1cw14tyrDJWuYCIZmdJ9IuV8T/QSniIQE5pA
 mbEubLZgEszs9YLEl7lMklC9Y7bnLFFUy2sjCko7FvGkLruHT68eWOQ3vVEYHLZKkgkiuVMeqe0
 ujXvXEqiHYOvOuZZtMjHXVdpJ51PMZEin0bgCdGLUvFZL9oKd7Man+SuiE3Qyw=
X-Google-Smtp-Source: AGHT+IHT3J90bjDvyZLE3DHgD6hE3bP85A5oxadrtb2zqTh0ZmjRQVbisOPyivxLSRvP6yP11weC8Q==
X-Received: by 2002:a05:6a00:240f:b0:728:e40d:c5fc with SMTP id
 d2e1a72fcca58-72abdeb6267mr1442069b3a.22.1734668084085; 
 Thu, 19 Dec 2024 20:14:44 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 51/51] tcg/optimize: Move fold_cmp_vec,
 fold_cmpsel_vec into alphabetic sort
Date: Thu, 19 Dec 2024 20:11:03 -0800
Message-ID: <20241220041104.53105-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

The big comment just above says functions should be sorted.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4ec70130a9..c708e50bc2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1635,6 +1635,36 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
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
@@ -2536,36 +2566,6 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
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


