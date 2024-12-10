Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E04E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26R-0004Km-32; Tue, 10 Dec 2024 10:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26A-0004HG-DW
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:30 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL269-0008L1-3r
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:30 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eb7e725aa0so97102b6e.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844267; x=1734449067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XYCGoc8876to2IEiv5A3VnrVbfuHFvGEsqz5PWCPMH0=;
 b=xZeG1VTN/ggEsI+uGWH/QTU+LTbxn4JcH6oHNPejDI8nLvLM2W+J6b2RreGpGPrnhL
 G+VFBhapgvHWNhblviKQgeMy0qFoGxnUOf6ZqfOGN6T8djeZg0Kku6n2KLyG8MUZYkP9
 CrnlfSyzP5ycIBR7qXdzPbvb//UcUNGbRs78enVJhT41SIf6UHgCdzq5Zg2nI+P/IVMt
 xFmaORbfzaVm03yjsWzMQYnBFAl3UezMEmy7nbINCcXvNG/4qugfB7EIhMvwPCsD4GuC
 PHGEADzOxphhYb0t3+vPcVwoJygttp3YysjJRTdq2f0krdtz/qiIePuF6UjWkEYCL00l
 Wkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844267; x=1734449067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYCGoc8876to2IEiv5A3VnrVbfuHFvGEsqz5PWCPMH0=;
 b=PqtBMs+w1kvBeyvQxt0f0E1CPeTM+CT0+LG2mFfzigoCDgcYlMRUw9MkZew8mm9a8m
 GeXmo9Tw+1ZU28Cbk4RaZ4ZnQV7rCJDRYlFFoVyN9Z0Wl2thGNHqdiCtsOC6eskCAEPn
 1Xv9D49zGFt/aFr1eh4LCSednm1/Bqy13CoP+Sm4RnkiqpT9gsvgm2IhREF96I5CnrGP
 q21YXiCtD/HQjlkXY4MkvrGfY+KzamnIfG3igc0zQUawX1IkiMvdrvVWaPLO8O1yzr4h
 Q6l9/a0HOsYih+r1qQ3e6LNKlkwXKmwjje6RS1oUwe6ilLJHInz7DXuoPiV2oPtFDg1n
 xmow==
X-Gm-Message-State: AOJu0YxPoejYf1Bo+w58BshXau4mvevC8WZoSHpHZmLb1wxMKQt1rF3A
 fBq1q1ekKxBV9jsuM7jslXXzRtaLMkQCR2S6eHKPGmzxEMl51EB5GxUMgbD+tvczVl+TjOg5Md6
 NOna+4WDD
X-Gm-Gg: ASbGncv13Zs00Ccbhnz91g8oqo2nehS9fu2ROCIA4qA5DrFK2VQFBVdkAuRgkw6TVi5
 08/Q1jSyhGDt8s9tefNbLrP4/yPdjOBaXgQnZDYr3NUX2vHii2IhoAFv+0rDt4XLm4MpPZZ2jAw
 bUJu7RJz7ylYulMgVfiFjHjGMiAdu1ro/tDFyDTiCEHlD9qaCZQHnVsj3IFvUdQ0Q9CtraxfpHD
 89LR6NpoSuld1vEmsIb73D4G4TT/LLfdlgvhqxH98BD7Ccmtvfjfv6PdeeeJw==
X-Google-Smtp-Source: AGHT+IGRy66qpP57TdPsTPF7yRwJ+MWMbA6zHrPHuD3t6XSEnImIm07cMGdJZNLohrjdlimstvZWUg==
X-Received: by 2002:a05:6808:220b:b0:3eb:749c:f151 with SMTP id
 5614622812f47-3eb749cf312mr1274547b6e.1.1733844267655; 
 Tue, 10 Dec 2024 07:24:27 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/46] tcg/optimize: Use fold_masks_zsa in fold_extract
Date: Tue, 10 Dec 2024 09:23:30 -0600
Message-ID: <20241210152401.1823648-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5f3a824a07..955151f4cf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1716,7 +1716,7 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask_old, z_mask;
+    uint64_t z_mask_old, z_mask, s_mask, a_mask = -1;
     int pos = op->args[2];
     int len = op->args[3];
 
@@ -1731,12 +1731,11 @@ static bool fold_extract(OptContext *ctx, TCGOp *op)
     z_mask_old = arg_info(op->args[1])->z_mask;
     z_mask = extract64(z_mask_old, pos, len);
     if (pos == 0) {
-        ctx->a_mask = z_mask_old ^ z_mask;
+        a_mask = z_mask_old ^ z_mask;
     }
-    ctx->z_mask = z_mask;
-    ctx->s_mask = smask_from_zmask(z_mask);
+    s_mask = smask_from_zmask(z_mask);
 
-    return fold_masks(ctx, op);
+    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
 }
 
 static bool fold_extract2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


