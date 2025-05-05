Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAAFC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QB-0006p4-1m; Mon, 05 May 2025 16:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q7-0006n7-Cq
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q4-0000Q3-DN
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:11 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7403f3ece96so6434843b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476887; x=1747081687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9AbSjauKdD8z/AvZIK1KVWP//5BiT2GwV1phO/RT8K8=;
 b=sLKSQfxJ54789vWKHwC1Mt//QaRXHVFR55EsOoDX8bXjS/qNidaPoDj2vsFmpA470a
 DbX9qoElLkbMp4Q7R5nv56+ipzk4Te20T4SV/U4DLEADKt4gOJzBi3JY7VVfJkJkjllx
 4E41hLUsHt7FegMuBlbyJNlO1+OZsPAZJTgXqWVheXMUp04XEhpMwluhDq6IA1bWvQnp
 7euGReD5AMx+CEL/lXt6pFcCQ6/6VLdpWFI8ZzDIlUJD2UReoL9QsS7K6RkdhgZnZvCh
 lox6EQHvjH95oZA6C/S9nkD/v/Qc4kUU8Vup9EZOpjLYm+W3yNTtQGNMmyE0Htfq7+wE
 pRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476887; x=1747081687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AbSjauKdD8z/AvZIK1KVWP//5BiT2GwV1phO/RT8K8=;
 b=iym7BrHpjuFp+vfm9G5Clk01MOFH/9c1pJ+23l2x6pZiPe9vBXAmtyGPv/o41o6MJ2
 lP310Pi7V5+FMOhvrYS60FnPcxy1g0s+CUSRi+P+9oTAB27HK9H1J1K/h0Q709KzqRJp
 8izqwMMuAtFvtZzhTJEtvWasPghtEoSS0Lqh0G6Zr3d2GWbIvSDI5BkY77SAM+aTU7w/
 NKhjmFzPxII7JSsaJiO+ZlvnITYei78XWO55WCt/g9t7LfWuwlOPmTcnt8yexjdFMMLY
 r5NCYTsL84W6DXL/NGpBeOZby99LGRzaG2gF115m/HztrC2+a/mwDb2P1okbZaqwxgoR
 olDw==
X-Gm-Message-State: AOJu0YxP9lkYvCddYOCEUH9QNWG0oGR4tUyZ/Gtgl6uk7ZW9wBnCNXlW
 6vmBem9ZZtclpkrYCaQA5P3FoQhUtUeg/5y2kNx7bDRyUQQYmtytvdupb3148PMcUb/41golqT+
 V
X-Gm-Gg: ASbGncujvB/MJRH6HNdWFPL57wmWsMzbxhynOSE4MzH/vY+w8c31tpW+3Ix017so9OI
 zdrYlzD0KjKJ1SN3GMfJgXYMkdEJCazvLkbQnnraDtv2TZuQNYCjWz3HJwavXC3gXfn0JzIy1qe
 vBmKclnevmWqB55+Yd2SZtCZAmYqvPr3F+6aJT6ICX/wD0d1OOwo0luysczYG7buYa5r6+duX3Y
 VyxVqxrbVfxXpXjE8ogojdT/GjuvAThnOfcU1qOw1UNMwOKlB+1vJORVFFKzOe2y6s971oIsYWr
 LBsri2iJ9sUl2GK0NlOTvupraNjOEcmOCezA0k+FVwgWYG2TOMFd9kUc+KlkKH6KmPr1iV/+G4U
 =
X-Google-Smtp-Source: AGHT+IEmQwNwXF9kc7bnsiMpxWn5urvyiXa7ImgQdzX8i/ytw6rSu5cmxizFt6lM2DSdM6V/2NFlxQ==
X-Received: by 2002:a05:6a21:2d0b:b0:1ee:ef0b:7bf7 with SMTP id
 adf61e73a8af0-2118143a34cmr672182637.19.1746476886552; 
 Mon, 05 May 2025 13:28:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/20] tcg/optimize: Build and use o_bits in fold_exts
Date: Mon,  5 May 2025 13:27:47 -0700
Message-ID: <20250505202751.3510517-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 tcg/optimize.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 424fd57922..d7f017accf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2021,7 +2021,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask, z_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1;
 
     if (fold_const1(ctx, op)) {
@@ -2030,17 +2030,19 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     z_mask = t1->z_mask;
+    o_mask = t1->o_mask;
     s_mask = t1->s_mask;
 
     switch (op->opc) {
     case INDEX_op_ext_i32_i64:
         s_mask |= INT32_MIN;
         z_mask = (int32_t)z_mask;
+        o_mask = (int32_t)o_mask;
         break;
     default:
         g_assert_not_reached();
     }
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
-- 
2.43.0


