Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66DBC83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGS8-0000cQ-07; Mon, 30 Jun 2025 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRh-0000SB-8L
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:26 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRb-0008FX-D0
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:23 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-735ac221670so2257439a34.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297358; x=1751902158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJ4j0E2WOSxfkWC/WL73iZDxZHFJ0TcMddjHVTP/mxs=;
 b=LrBkcB0rE7y5CIwnIMIlCozpmN2xu75eVe9LP3sFgsce9k6HZepRp+jG4vJxW1kL0W
 Q5gRVM2cbi5USoB6ckCMvv8dOeE/DpueGEQWutyQ21Xb7sDC6fscAWftAumwCKUwFkC3
 zdBCDJa8cXsRRPM+R4d/VWn4kS5E3kB5un+0O6dibrlSVFAe/rCSFE8kceAsIJBsJEaP
 gT5LXrQtR0kHFeZNPuaNdXyrAbAKpIdnEu3yoYoD9SyIfigXrn1mF3Js7Zi3UQgMJTd/
 OgtGpLmSJS1QtXz65VzItvqaqPUMp3GcQg4UjT005FgdJErFkmzr/WsGYWkZbqJeyj0H
 /sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297358; x=1751902158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJ4j0E2WOSxfkWC/WL73iZDxZHFJ0TcMddjHVTP/mxs=;
 b=qRva5bFvrLEoEmKnb3v/MzOejXGap88WDBDf+MaKJPUng8IEoITqwGHAkZdNBEdUpG
 BdFhUvqpK9Cc3/ts+Bw7JcjNMAESelrCjbsx+U7SLGHEN7pW+ZOYuiYzJnV+o07DDtYe
 DxiMJupIn/cp1ysQ6Avl14aZaTYv2ppvYf1vKfWcUZ9uUEkrQpBMK2YPekewQfVU/WaB
 hKYJsMStKu5nBV0wYe/wVdUytrSfedHQlXn82njXcqcI4OH+I6zhgguQTbXaryC7m/9C
 hcaIoW93CsSTPlSZSw3sKW7qj6Os254k3kcVXLpqyzy/aQnPJOF34lr7sL3pbdygKu1y
 PCSA==
X-Gm-Message-State: AOJu0YwbKI1/JmXHynetrfdzooeBh1x0CSI/tPd9m7aFD43lFcoZwREv
 hjRccnZyCuF+gFMDsB5wZGqal5P9odQMmHJDCChW0Ej2mzGV3SWyLCVQlWxblOw6dqEZ4vYN3/d
 b4u8z
X-Gm-Gg: ASbGncvtImy5FY0vjeHcqFpLlzJOF8T5yJkp+Y9r0+u15B2vZMdmFcRtrb+zIq6Fd8S
 0/kpU8xmRxjisjBKe9+j5Exbuq6fGHcBbz0q4bLrQ5DR7mtYR6MvPhVrOww6DglElyROcGMeI8P
 HVVUPQIEayMNFZQYZait8McaKasZLFXIhs3r29V/1dFCJUTVCD+hzd5CF3mG1REoChMTKOkCSUT
 CWo4jAv0fWzQB9DaHOcsyarV+DbGQW4WBjWvQ4MOPmT+mPIuKDbM/AQ9hNzYglGyZxfFWaGLHDY
 rRy5JzYvbK2z1DiiPNjJorYmzZojz2RQGYpjjpJ8OBJ3RWJ5mPdFI7hxqNT/YrRGTGQJYg==
X-Google-Smtp-Source: AGHT+IGeLbPp6XtfgEQGUVo8tDqXpX3YYpUwszm6hsiVRMmG//y79PRntXUr2KqvNsspIgHkv5YqYw==
X-Received: by 2002:a05:6830:648e:b0:735:a6b9:3b48 with SMTP id
 46e09a7af769-73ae9e7be78mr13214088a34.10.1751297357995; 
 Mon, 30 Jun 2025 08:29:17 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 21/29] tcg/optimize: Build and use o_bits in fold_shift
Date: Mon, 30 Jun 2025 09:28:47 -0600
Message-ID: <20250630152855.148018-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 673849f07a..0b441bc611 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2675,7 +2675,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask;
+    uint64_t s_mask, z_mask, o_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -2688,14 +2688,16 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     t2 = arg_info(op->args[2]);
     s_mask = t1->s_mask;
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
 
     if (ti_is_const(t2)) {
         int sh = ti_const_val(t2);
 
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
+        o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
-        return fold_masks_zs(ctx, op, z_mask, s_mask);
+        return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
     }
 
     switch (op->opc) {
-- 
2.43.0


