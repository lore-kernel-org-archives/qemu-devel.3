Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA25C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSA-0000ci-CR; Mon, 30 Jun 2025 11:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRn-0000TI-O6
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:38 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0008Fy-06
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:30 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-735ae68cc78so2784107a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297359; x=1751902159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4bDMTeja2drb8U76A8rTMhXOU4TxSudcFPnnrBZGgM=;
 b=kbvRePd29fKB+6dXU7TLG2CTChssK1uimUi5J47qeAhS+0nrsQO16ja77QsYVlGX9B
 MV+X5SAtC7QU16UozDa72HJEpaye+ZPZnzut/42PX7dmbCt3gfPu/TS2yXz/BHTOFrnw
 FDa3hgG1rA9s5mIf43ye2nQ40SFTweewr+m7Rx+sgvlUH3LkXsYTtLFzMJcDahBkww3S
 I+wXQFn4xgbvOzI3vKqNOkLzi2bOX2z5EMfCQlTKLGZZaSd87rOdjnpX6hdCHMDIhhnl
 UUBgcR7mjb+y2zeNou+5IL6Bsm1FVO1B2XtIEbSVr4q6pyGuv1H9KHZnB86x2CyIpRvV
 rKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297359; x=1751902159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4bDMTeja2drb8U76A8rTMhXOU4TxSudcFPnnrBZGgM=;
 b=wq1wxYx+t3VwtL4TCM52Cdd2cKN//mmIakkLNDoa3jXibsiexyMnxnpYXR+TgA6Bvn
 fk7hT5502EezOWJb54rSqeMjt866jVynz0So5UGC+TusfH+CqkWO10hrVmCA49JRh4gP
 GtbO8qo1LgjnwLYaN9EUNFdiEHh0IBf/MyNO4AM8divD0RuYn7oNbTfkvpx8iQIKe4nT
 xV54afUU2OmZOUdU2vNsvQRsGtpxzL4/yN4SOeX08WKxJ4nROzsbAeVTO1QPzRoWkb8/
 klRX1+v4k0/eZt7WQLKiYlhywB/b9kSOA8dNAaIvM41EAAMgR5t6Wdzh/N3BLaQPcfpB
 tAUQ==
X-Gm-Message-State: AOJu0YwmszznUmAWa0l1yD6MKz3ecNL2Y8u+Sza+PVE+oqzr1UORspej
 r04qw84Pd5s54ZNcEeSkfhnzRw9fJQXQ1rxMESOqd2TsDAnqIX0EqBC83hL/et3OZJV8JBeRL3y
 bUX3I
X-Gm-Gg: ASbGncvxwCqVL4s+GHVvWfeUnH6Gc8piIMMGYI4Do2mRuyAtE2kfdrRoW+JfPXH+XDr
 mgTebS2NbFZZTJwsrQ8+oWPiATPAT/YI0mRnU0SIn7mg8hLiFDaIypNmD9tPRzfqnf1m5U3vdQ1
 GNTfFgsThMjnc7fh/GnuXY16Rpqsi2M6x38jOah/kjqUIhP+F4YqH5NXeNyRg9GAqk7/3z6Kjfu
 t2Pn+O9BRHJn9ZBW3eJreQhYggxT6PrISdKIc4oT8gfYytTLpyvpGGBOz0QhwZSMyVP/ybVIekT
 pqj7smiasgw8sdSTPzVesEicAbVpzjUQF8Z8swPTHwyvajNusZQafdyqfvDCKHhj9zM+Pw==
X-Google-Smtp-Source: AGHT+IHTrL/ytEuoHfo1QLP2hJuBhPS0BZ/mBMXukqmfEEd2H2PnRgNeFjbVYdgt/kUTGqh2yUgsSw==
X-Received: by 2002:a05:6830:720b:b0:72b:92aa:b69f with SMTP id
 46e09a7af769-73b1b7f88e8mr3501534a34.16.1751297359449; 
 Mon, 30 Jun 2025 08:29:19 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 23/29] tcg/optimize: Fold and to extract during optimize
Date: Mon, 30 Jun 2025 09:28:49 -0600
Message-ID: <20250630152855.148018-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index aa64f15779..06ccf39d64 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1044,8 +1044,9 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
  * If z_mask allows, fold the output to constant zero.
  * The passed s_mask may be augmented by z_mask.
  */
-static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
-                            uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
+static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
+                                uint64_t z_mask, uint64_t o_mask,
+                                int64_t s_mask, uint64_t a_mask)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
@@ -1095,6 +1096,13 @@ static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
     rep = MAX(rep - 1, 0);
     ti->s_mask = INT64_MIN >> rep;
 
+    return false;
+}
+
+static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
+                            uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
+{
+    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, -1);
     return true;
 }
 
@@ -1448,7 +1456,26 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
     /* Affected bits are those not known zero, masked by those known one. */
     a_mask = t1->z_mask & ~t2->o_mask;
 
-    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
+    if (!fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask)) {
+        if (ti_is_const(t2)) {
+            /*
+             * Canonicalize on extract, if valid.  This aids x86 with its
+             * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+             * which does not require matching operands.  Other backends can
+             * trivially expand the extract to AND during code generation.
+             */
+            uint64_t val = ti_const_val(t2);
+            if (!(val & (val + 1))) {
+                unsigned len = ctz64(~val);
+                if (TCG_TARGET_extract_valid(ctx->type, 0, len)) {
+                    op->opc = INDEX_op_extract;
+                    op->args[2] = 0;
+                    op->args[3] = len;
+                }
+            }
+        }
+    }
+    return true;
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


