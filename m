Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C05E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26X-0004Zx-Lx; Tue, 10 Dec 2024 10:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26Q-0004KY-Mn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:46 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26N-0008Nj-Lj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:46 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3eb4b6106c8so1152611b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844282; x=1734449082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pq5MdM9DhMkAXeYGoQ73cVGbD5KT8phmzZmqweBcPyM=;
 b=kH0ILhdp1BxKRgHEEV4lXVNqBU4BU/TNGJmQVSTRu3LxShc2ihrfvdT4/3yNFt+JvL
 KcFj8Xnw9BADFXCwcWrmx4VxRIQPek2OWFaU5syclMVw7VPSX1yAhaTjxRmMToDO4ay2
 OtZjNrZUzQSh3N+QCSC3oMSUkk+R0JR3Ccr0fI/FimKhd19ve2Y7haKkgawbP3tHXind
 HWGK7o3fBYtHzwTpczTl7C38KEGf0902xnl5JCYnBY4MylUOUc/Txkb5P/IdzSS9rEZd
 rgQOiKTC/Z/YcbvuoQVgojFMkhJheYIV+12dRECemtfaLnAB1KhB7REGvEOBcPvdmbmg
 MadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844282; x=1734449082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pq5MdM9DhMkAXeYGoQ73cVGbD5KT8phmzZmqweBcPyM=;
 b=Rr+bSBALQoxTLjTUivKCdbZvd07a4BluRrGAfZYhdypvx0hCRr2ftm1fVbSzYX/4GM
 epVSrjzKRsHsyxIDiWejBNe7DsWdq2emgeo8TSK/56Zz1J4LAtEkrzUM96bd1p7lpYns
 M60h2iEbu9NnhPN+B/2FzicBSO7nkDbAftEDPJw0w0JdGZPm3AuWmgDDtu17pJraXVvz
 rB5bJHI+B8yMISkaRCjVDdcIx9URT1WnX/d1IDhTgQqWystcwcYmt0cj/KgsLLxFdL4e
 VWLDFj+UOWIDMWYgqp6zOAsR2Ind5k0cdaN13gzxiVv7XthPMTDDQwLjd6/8JI4TbJi1
 3jhQ==
X-Gm-Message-State: AOJu0YwBLW7Qp3yysMLr/UYSXHLdq3lSf/83F8ki4YhqnYvLOZDBcp3W
 4u/Zpk+Uogo0+8tFynzzNhLyAp0PaFHpU22rywYcBw8cnoU3hkhCDWE7K85cr6Swu8TCe1Wt5CQ
 fXzRuG3xE
X-Gm-Gg: ASbGncuyGLPfHa+PntXA9n3Lb64eyh5+dzshtu70/EmvOuYjXRlCNoq9tlT3QaRzflk
 O6Iio/3ARziDQpwLO9ntfgv0Y7ETGm/rHyyCuzpspWmXCvdSihrqPwExj388yqqXRD15ehenD+R
 1q6oQLSXhHKcW7eulEaZ0t6gtYOdkQTtoIyFEBSIsSax8sLFjWVkHGKT4MP8EnPKU4/lmZ/9ZhL
 M4MVTo/Q150NdPLv/BBSt3u78FxsFEPosc6ruGftpDPShhT+9R63jcDtBRQwA==
X-Google-Smtp-Source: AGHT+IEhdz9Ufppfho40Qsw0TMBD5fjqb7keWnl25dhjD9A73I3qH37VaJsdHqBXRPXlqKS17F+XEw==
X-Received: by 2002:a05:6808:1805:b0:3eb:5e08:f806 with SMTP id
 5614622812f47-3eb5e097668mr4544223b6e.29.1733844282647; 
 Tue, 10 Dec 2024 07:24:42 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/46] tcg/optimize: Use fold_masks_zs in fold_qemu_ld
Date: Tue, 10 Dec 2024 09:23:42 -0600
Message-ID: <20241210152401.1823648-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Be careful not to call fold_masks_zs when the memory operation
is wide enough to require multiple outputs, so split into two
functions: fold_qemu_ld_1reg and fold_qemu_ld_2reg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 76ad02d73b..6f41ef5adb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2092,24 +2092,33 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     return fold_masks_zs(ctx, op, -1, s_mask);
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
-        ctx->s_mask = MAKE_64BIT_MASK(width, 64 - width);
+        s_mask = MAKE_64BIT_MASK(width, 64 - width);
         if (!(mop & MO_SIGN)) {
-            ctx->z_mask = MAKE_64BIT_MASK(0, width);
-            ctx->s_mask <<= 1;
+            z_mask = MAKE_64BIT_MASK(0, width);
+            s_mask <<= 1;
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
@@ -3001,11 +3010,18 @@ void tcg_optimize(TCGContext *s)
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


