Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C9C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QG-0006t0-9g; Mon, 05 May 2025 16:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q8-0006o1-H7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q5-0000RH-Un
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:12 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso4071066b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476888; x=1747081688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=//jTx+xrgsbGn/aMj2raUmnH/lr9//Bq0ITGijiGoV0=;
 b=lHJwLgSCV29/CEazPD655tN0B/Toe0r/39VlNaNgfT2HkTPZtKrgaAbIEiZxsrQc/g
 P4lldPigEqdhZhtT1orWyeqtOybkQA+fg+GccmFyEnm3odTD9UBWLw+R4fCBVSsEsQYm
 ykmxMMgzV64AEJhAtH4GQP7cicDgVXJIvsI+UzuQllEU+BC78VCxEjtQJpxpvvDXyzeJ
 1dk9B3VdRKe4aVLqzJU+rWrJMv16kti2hVgpV3ABp4w6PyLDOwYgPfrIAJn7e7BYT/nS
 X2gjHo+v6PoQj5Km3LPCoyQv7PrM+rKXV5Sdaw+ehWV7FsxWYJq5wsBAoMat92aU/ths
 wqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476888; x=1747081688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//jTx+xrgsbGn/aMj2raUmnH/lr9//Bq0ITGijiGoV0=;
 b=dKWzHTHC93FbJlS2C5pw8kXT1fYV0BE/EMZu0ghhY//3w60l9Cfqb3bAFsB3vRDtGz
 XXch2oVX2pl5q2sIS9XdWmvZ7jxBpyBldRdnIm5g49MsJDe8x51FFFWb651KvtAqkhCD
 IBqkB3Bvf+PLVe/ISZyloAbLHXFwxI/TTncMAdtCUQnyM+fJCBq6I+CsJ1LJdXVrTRy0
 ykkXaBRGWIC1fs5IsbnXQAiGyGMEwwHgvEzZvPc0yRPPNyqnjyQFFm040ts0Guwqgcpr
 SRvZ4ELyKD6Du5m4Tynwff/OCgYWO734vekceGSX82s2tujdhnO2A3EgV/5qv5QVN3Ca
 yTgw==
X-Gm-Message-State: AOJu0YxmZ1z8E6rIjwYEe9oh7f8G/d+qerdv5pNXHh/loZEKsw6ZpdEv
 tGJO/bFwvybhRj3JG/IVR61BKKTxhv0sQOwRf4J4tmvBT1HkbGrCz96rBCc+2hGscinibubwo7J
 /
X-Gm-Gg: ASbGncsmUPUORqQa37PvKFebLKJtMt+9OvwpjCctRqWm6gegMe9X9T8l85RSCCwp83F
 bHuBlzo8UoKZPMnQ59mPkJic/ULWzVfA4jVFsUU154MX6Z/XSRpxBbejFqU2YasI2uaYdR4bFtc
 ghjWSEQQ2xTOn89IQXIbGpg5KLFBIVK3ncT0TuuWcRao09NINbUIyyG92d741uyWiWjUjLhSWih
 IUTXZ3XcK1t3Zv+SoOYbo7OMEz2Z6KT/giG4wWYOy2GaTlzciKH9sBkOcDnLmrMplgoj+5fkowS
 UifmYzH0chgDzWg6guPF2yzCPI9rF6KakCKvUovVKz7EzUzABwYQndLHsOQI+QjufHaPyVNBDwg
 =
X-Google-Smtp-Source: AGHT+IEJE1+nKH3+rOm979nAZMz/vFi2Jts1DVfN6SGX3hstAhZ9hAKCIZ3Dbpwtm1OaeDiBuNZvtg==
X-Received: by 2002:a05:6a00:301f:b0:736:9e40:13b1 with SMTP id
 d2e1a72fcca58-74058b25ab3mr20965051b3a.23.1746476888383; 
 Mon, 05 May 2025 13:28:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/20] tcg/optimize: Build and use o_bits in fold_movcond
Date: Mon,  5 May 2025 13:27:49 -0700
Message-ID: <20250505202751.3510517-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 tcg/optimize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1d722bebc2..1040e67220 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2105,7 +2105,7 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *tt, *ft;
     int i;
 
@@ -2131,6 +2131,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
     tt = arg_info(op->args[3]);
     ft = arg_info(op->args[4]);
     z_mask = tt->z_mask | ft->z_mask;
+    o_mask = tt->o_mask & ft->o_mask;
     s_mask = tt->s_mask & ft->s_mask;
 
     if (ti_is_const(tt) && ti_is_const(ft)) {
@@ -2153,7 +2154,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         }
     }
 
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_mul(OptContext *ctx, TCGOp *op)
-- 
2.43.0


