Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07095E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlt-0002vB-MP; Sun, 22 Dec 2024 11:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlR-0002bH-Jq
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlP-0003CE-Vc
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:09 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21636268e43so39251525ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884706; x=1735489506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klMxP8/nueO2LoUasMDvvsH0HmT8kwTeat8aAub+VXg=;
 b=YesKbA++hU1jN8rouZyiGTx0yQxwNozKiDjEFX51at37MyJ9dZd+JnVX9nOhSs7kwS
 FzvHlGNCNNgFz/anRB1ROFUjJWgUC5LwjKFK5YWg7hRoMRrR2rGd4M6yeMgHBUX6yujK
 FxNcR9lLRodDpa84yYY77PArDaFG5C0C+HBgQhGwkoy4Q3t7GffpEZ3p0A25aJ0KLUKw
 /6wqqK85MTE2QF6Iuan/pK9L3l0TlI1QYLLnzGRVt7iTz9ojUuLM5L0c2FIyMw/UqRWO
 Fdq0aEcpKEL2rk5vBMs651A632QkRKBhZUzbJAFlaYqUI01ju8Ec/HWSWpvZFy4tbhIU
 Bkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884706; x=1735489506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klMxP8/nueO2LoUasMDvvsH0HmT8kwTeat8aAub+VXg=;
 b=SJ3paayBf+HbKbH8TAP/ulEWT/Gwt9i4qE/dZTizHhNWJMUJAEqqtIIKRG6h9S3AsT
 aP81nNlF5dnnzRfk9htHN8FUR9YMs2lWh4OnoXe5hszcTlGsK96Wr7Lef930So8KUF//
 XkjO7aNl94gQqI63bMo53v17uQq80VfbZUUYP4Bj+LIWtKCPcQ3SUK/ePKkiK9BtAQ4Q
 OuhVuVO6QHYlA/Ozf8EmZo5YHBZ+vaPOQobKHcZNtmLXl7fD8oa/T0P+bQU9KcIJapPT
 y1z6kRm3Mv5D1NvMIWbvMjTqhnEuMDH0K+uZ9L9nfDrfbzUF4O5BVB1ihScp3F5uxzYC
 d2Nw==
X-Gm-Message-State: AOJu0YyrBG+kXGdPjzO5BrL8Y5msi5QvA2TriUBj+GfSkk9k8AD32Nu0
 /WKR6MBH4EgFZubGWnjyjPFxZCTHxwFEGYjdH8c2hsSBz7t71VdTHVLMJJypTEnP5RUdgLD6en+
 B7uI=
X-Gm-Gg: ASbGncvkNIi+Yz1VQYZqpoLNMsXjYbvBwcJOfQ02L0D+YqKPsnI4a8vTbHcoRNkgSc0
 3EHLZ4v1uVhwVPZwc72c6W+8/Is5cgIpczyz88spvRqkMycUDO0agO88Qq4dPz03pibJYsR3VXz
 6EUh1Sz95FgVYRMF96GXrp586BcoXdN1MO3UZy8Za+KTc1mkBkFq/sy8LBFcmCcM3o8fNh8ZNrV
 EH4Vk33QP20RtfoWsVWXCfR/kFmaRaHetkhtHcOSt9iWE/fk7S8PSnudlF/ecQ=
X-Google-Smtp-Source: AGHT+IH2CFjtOlhmGZVT12QWM/jpkYdW2zC93s3Ohv/mDbX0CZUADNwKH6QtsstDN3JqJyOw4iSJiw==
X-Received: by 2002:a17:902:ccc7:b0:215:94b0:9df4 with SMTP id
 d9443c01a7336-219e6f283aemr156292645ad.54.1734884706590; 
 Sun, 22 Dec 2024 08:25:06 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 30/51] tcg/optimize: Use fold_masks_zs in fold_qemu_ld
Date: Sun, 22 Dec 2024 08:24:25 -0800
Message-ID: <20241222162446.2415717-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Avoid the use of the OptContext slots.

Be careful not to call fold_masks_zs when the memory operation
is wide enough to require multiple outputs, so split into two
functions: fold_qemu_ld_1reg and fold_qemu_ld_2reg.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c1305e9eab..0eeff6c6b4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2093,24 +2093,33 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     return fold_masks_s(ctx, op, s_mask);
 }
 
-static bool fold_qemu_ld(OptContext *ctx, TCGOp *op)
+static bool fold_qemu_ld_1reg(OptContext *ctx, TCGOp *op)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     MemOpIdx oi = op->args[def->nb_oargs + def->nb_iargs];
     MemOp mop = get_memop(oi);
     int width = 8 * memop_size(mop);
+    uint64_t z_mask = -1, s_mask = 0;
 
     if (width < 64) {
         if (mop & MO_SIGN) {
-            ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
+            s_mask = MAKE_64BIT_MASK(width - 1, 64 - (width - 1));
         } else {
-            ctx->z_mask = MAKE_64BIT_MASK(0, width);
+            z_mask = MAKE_64BIT_MASK(0, width);
         }
     }
 
     /* Opcodes that touch guest memory stop the mb optimization.  */
     ctx->prev_mb = NULL;
-    return false;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
+}
+
+static bool fold_qemu_ld_2reg(OptContext *ctx, TCGOp *op)
+{
+    /* Opcodes that touch guest memory stop the mb optimization.  */
+    ctx->prev_mb = NULL;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_qemu_st(OptContext *ctx, TCGOp *op)
@@ -2995,11 +3004,18 @@ void tcg_optimize(TCGContext *s)
             break;
         case INDEX_op_qemu_ld_a32_i32:
         case INDEX_op_qemu_ld_a64_i32:
+            done = fold_qemu_ld_1reg(&ctx, op);
+            break;
         case INDEX_op_qemu_ld_a32_i64:
         case INDEX_op_qemu_ld_a64_i64:
+            if (TCG_TARGET_REG_BITS == 64) {
+                done = fold_qemu_ld_1reg(&ctx, op);
+                break;
+            }
+            QEMU_FALLTHROUGH;
         case INDEX_op_qemu_ld_a32_i128:
         case INDEX_op_qemu_ld_a64_i128:
-            done = fold_qemu_ld(&ctx, op);
+            done = fold_qemu_ld_2reg(&ctx, op);
             break;
         case INDEX_op_qemu_st8_a32_i32:
         case INDEX_op_qemu_st8_a64_i32:
-- 
2.43.0


