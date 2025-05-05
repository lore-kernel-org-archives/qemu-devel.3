Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFE6C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2Q7-0006nA-OV; Mon, 05 May 2025 16:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Py-0006is-4R
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pw-0000Nd-Au
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74019695377so4018217b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476877; x=1747081677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ng45Q3ozB7fDbFJmX/4XPxigFXCk4HF6+j4a4hv4d8g=;
 b=QiX3bMFm0blhibYNXA8+jJ+l+06bnXqr27pTYDicrJRGyEDavHra8jWZVBZSho0UYa
 HLGAygaotCHMQHpUKoGuBL7oyeHEIhKXSgCbcEUhOy74mPGsTKLPft/Po0am20hPUE+Z
 dfxpp+kaujSYGgoNfOfx7i/jyDzrtQpDMKlfZa7xYQtLELFGFXtK9sUBNG8yz+qSIEmQ
 PC6NJaR/WsAmRKCkZpZ9fISkMiNG7B8MaE/N2+1WfmYPu7iVU30TevPWbYIf0gfYXD6V
 7CKzQOpOwyKaI860wM89ciokJXcQW0KAdGJ5UTbNfuVmRQt3Kb8BBLKL81VyHYrp5zLC
 vzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476877; x=1747081677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ng45Q3ozB7fDbFJmX/4XPxigFXCk4HF6+j4a4hv4d8g=;
 b=MKR6lvNi14sC8zP9MH31rC4GG1TiByTw8wJEQykxy4QfCIWfREmr3M1MVLx95Ep67i
 8gpl6UTSnO6p6xAfkfBiHjf5NWAMT/naPRoEhPWRzIa+oR+ztxvmRZbTBqUjKASwKejT
 /wAU5lcUJDj0sIBT/0xlKWA7u33jcfBkPaJs2SMbFduIMhLcab4GpkKZZzHl7lXa+oq/
 +gGu0Qp4oa5qfN+Af4XVVTMe797NJ0A3CEx88IN2OJcx3/JSNkOGD4GwAyE6kXGUjjA2
 f7XJPCpCXRsq5WANDxR2/LOrqEEREvgVcDwcJZIYAd7XduIQMlOfAgtCG157xrV5bc/x
 oqGg==
X-Gm-Message-State: AOJu0Yz65qQm8VGSAeROJ5PYULsoN4jGYqIRsW+Iizoo0Du5XijlbwFP
 0ahocIvI7RmxiGagmyA1Zjr7LHH068QwpmoYUd5R0F2xhgCZH2tWkyKnTvAf7O6OgQUqDPfQbYa
 /
X-Gm-Gg: ASbGncugAkyLY1go9BUtInzmYQIC0vfxo0XCGsgmapp84P7Rr2r9sTuHOiMqz8SUUcT
 hnoAFtKHPC+6pNdNm5LlhcWtzaDL77vsQEzT253nnHY67mpANr3RHNPZCpA+qCEuAj7HsICwVB2
 LoIZpP4myCVjuUnCa+dwmGB+SNEFD/+2iHAvw5KrDMAcIm/HYEIxSX1IPZ+GQHhFK/HwVmIlVQU
 RWVVolCt5fCv/bRTsvxrisqjbMZ3nzJToCr0fvXQkQqhmycwGdKDdDy14i7g34AfSdGtRiiujCv
 dyFBZgEVZZnOcLBxH1HX5amS46emVt9AHnRQw0xlZ41B/316cGumMBbQkg+cIpEZ2bTMz4AuWXb
 ihg9PC9NFWQ==
X-Google-Smtp-Source: AGHT+IF4JYHgYkFegPvkJPilDRgVtwCFcoBILf/Nl+YICY0g4UsEZaC3sNXEpbKFn9wmuau1KKEtTQ==
X-Received: by 2002:a05:6a00:4293:b0:73f:ebb:6cb2 with SMTP id
 d2e1a72fcca58-7406f08d144mr13196662b3a.3.1746476877434; 
 Mon, 05 May 2025 13:27:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_eqv
Date: Mon,  5 May 2025 13:27:36 -0700
Message-ID: <20250505202751.3510517-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index faee3e8580..08d15e5395 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1917,7 +1917,7 @@ static bool fold_dup2(OptContext *ctx, TCGOp *op)
 
 static bool fold_eqv(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -1947,8 +1947,12 @@ static bool fold_eqv(OptContext *ctx, TCGOp *op)
     }
 
     t1 = arg_info(op->args[1]);
+
+    z_mask = (t1->z_mask | ~t2->o_mask) & (t2->z_mask | ~t1->o_mask);
+    o_mask = ~(t1->z_mask | t2->z_mask) | (t1->o_mask & t2->o_mask);
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_extract(OptContext *ctx, TCGOp *op)
-- 
2.43.0


