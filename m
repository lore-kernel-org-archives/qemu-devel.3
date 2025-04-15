Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E4CC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lue-0008WA-V3; Tue, 15 Apr 2025 15:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luZ-0008TG-Hf
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:35 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luU-0007yf-8X
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:32 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af52a624283so3602a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745129; x=1745349929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LroDn4/SjjeFJEX9RTqeH2747ENzfkgV16zYEGcxIMU=;
 b=NTJaSO/Ps2kjqVvJgotgpN4Z7KmKCBtHnoYXiWioogJUwkz7Zx1y8nkc7acMuzRkHA
 2e0oLJQ1++Oa2MIbWQtGUTWAdoxq8xwKdylifkQ20c7iOSQnj1A4fOmc0KoJFscb8Zvl
 u+0Qi8f7+gnZ+yXDJtNlfmPE01H23YYp1zVLOWerF0h0x99EyM1eHg3RARvq4+pWgBEo
 llbOtT4Hexeiqt73QkgPqSJFqdzrUpqRBwmi9/vNd5vz42WaltTsM0EDjUPzQk6pzU7j
 UuE18b1cyHRrAF1bC6QjN3fMZvkawzORwmHa8/0d0z37//nWwZU4AFbJybjRow3xonHs
 kutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745129; x=1745349929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LroDn4/SjjeFJEX9RTqeH2747ENzfkgV16zYEGcxIMU=;
 b=P8d9Jg8PfxiK0YEJIywxLLYhbRTuzgX2kT4zqFIsbD4eXCihCwizrcLP9tAnF2jley
 ImQ3K6+PFiyEnxqmCbX5Rm/crtNKLxg+F9IGTzVzGcU+6EiwjhcAEduMX637LeFCJ4IO
 LEzILFcMh/aCTN0g9uug5ueJWtQc9cFIKn9qTQ9MYAXGOcXh6LLLIok6rvFLyRgBXLNk
 NkGtz7ahjng87q/qurD9PhxUVoEOplxvHvhLvle8z4hcOpoSJv1scbGo9w9RS7SZ3tYq
 pxpehnR+9AN5t7/2d4+cDd7TA+E/Asa4vDps3JqR1lbn40YD3qGQcFCtN63BsEbYyBEs
 8EJg==
X-Gm-Message-State: AOJu0YxfeYZHWIUvIBQ3rjenh16WrmLjHYdnKZ89AVK5TZ/IsyMDSKvu
 a6FMyiXPUXr64OSd7phZj7OfDAnWVfSXm26F99JEgPq5uIDzgFcbL5PtziNCWP6Lur+sIe/Liu9
 P
X-Gm-Gg: ASbGncsV/El6RHCrZzqIz4WgvmPBThDplI0fArZBVYtB1CqRbQ7FMD6V/pemSYaFhpx
 x+1nrcXbrNYxcKozFM56QHknMTPNOs6a9K7ikKkMJXOdRHwkwjHaPWEwoQITg/j6/shybR/4+H9
 SNhEcBtLuyuPix415iN/2Lz6aFmVnmiGtjPyKNvfDUGivN8TYrToDZHZPktD8mPpp4eMusyRh7b
 BqAOJU7ASgx/RzyqN9MIBSi98058Pljr8/rJSbtxJBeUpYKuSpXndzpicw1ZD5O+ehg+gWuxGkC
 N9A3Hgpm0fXJIPp/r/w/of1atio4QOL0NEYffZcKmoz1xFKuIBgdmr2XGE9EvxYe+fDjcEyEbcg
 =
X-Google-Smtp-Source: AGHT+IH/8rAisTiKU4IsMXkfpNkEW4/MmVMIOfMK2qIXqBN/LdDT8NN7TCaIi7+FAfGe1Gj5hfW5aA==
X-Received: by 2002:a05:6a21:107:b0:1fd:f4df:ab67 with SMTP id
 adf61e73a8af0-203acb7139fmr881717637.21.1744745128511; 
 Tue, 15 Apr 2025 12:25:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 015/163] tcg/optimize: Fold orc with immediate to or
Date: Tue, 15 Apr 2025 12:22:46 -0700
Message-ID: <20250415192515.232910-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d388c2b9ae..c75413c48c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2131,6 +2131,7 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_xx_to_i(ctx, op, -1) ||
@@ -2139,8 +2140,28 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        /* Fold orc r,x,i to or r,x,~i. */
+        switch (ctx->type) {
+        case TCG_TYPE_I32:
+        case TCG_TYPE_I64:
+            op->opc = INDEX_op_or;
+            break;
+        case TCG_TYPE_V64:
+        case TCG_TYPE_V128:
+        case TCG_TYPE_V256:
+            op->opc = INDEX_op_or_vec;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        op->args[2] = arg_new_constant(ctx, ~ti_const_val(t2));
+        return fold_or(ctx, op);
+    }
+
+    t1 = arg_info(op->args[1]);
+    s_mask = t1->s_mask & t2->s_mask;
     return fold_masks_s(ctx, op, s_mask);
 }
 
-- 
2.43.0


