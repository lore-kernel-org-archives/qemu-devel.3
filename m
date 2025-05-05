Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7CDC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QB-0006pQ-Kv; Mon, 05 May 2025 16:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pz-0006jf-G6
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Px-0000OG-Fy
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:03 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso6739035b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476880; x=1747081680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1L6qN3hGtDimEHeziZBjUMl7ndN8s0huzRJQqlZS3SE=;
 b=FSiZgqacHOlVpKVyaKbhstbJOBmuQACZkOlA0qtGe4/gx4ycBrr7j3giryaCm6C5q6
 NgRwpuNv0MLtrdaF6/HUTRAzmThL4tLRN/XEysK16gUQLJs2eBASdzu3OW2SZhSICn4x
 majDIxazmprJelA3bfrjR8nHMyKQxUdk3NyfnGgppjnflVuGG/2GTQ0w+r4FCGfSCL74
 Rwch/C9a3nVEHyBgnwE7+PY69VZEGQaP28y+C+4xtIEQ51lSJiN1ak+fGmP70Yl8wh23
 649TDn+1DxOHaJ84nYhixH3ZFven9KTIdp1L0s5eQ1oz++P7jTllHctcXir3eaYFbbCw
 Yekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476880; x=1747081680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1L6qN3hGtDimEHeziZBjUMl7ndN8s0huzRJQqlZS3SE=;
 b=gI576Yv09x9isvYKX4eao1rmTL18TMRUBx3U/lEXwIIxdNgCGilGxm+TTG7x2OmxTX
 5LaX16/40AfRbWZDgb9LwIBfY/z6i8YIJJzz4Rn1ozOx/7B6WzLljxLVJoGl7m3t5PNx
 98xxWBcTI0UD9nURdwJ6qQclJB03gZFLY2ixS0D8u+6zImkSN/2hgEE41BQLlCH81taC
 FHG7KfAhW+WD0fEYHM9blrJjYhaa6khh9Yjsi6GKk4yBnJTRSjAZvxFMECtPG+Ryoo0a
 HPY6grIHYw3DS51d2SBZ4EdJQTeq4R/7NR20ck0/dodn9drc04s2P4KsSG93ebrFCy2B
 zFnA==
X-Gm-Message-State: AOJu0YyTtAfipJAeUr4EVJaH8uF4G0zpP+jCZXYGs3Xn2sBoyhVD4wGy
 hGL8srx5zoickWdtEmQWKhFaBPu+ZREcNwZ2+cL0+c/1PsuQl3ffCb7Z1eCtEhe+IWT69qAQ8LX
 5
X-Gm-Gg: ASbGnctdx2WX5IchV33v6FX+6caO0zOTWr/L7tcj6/+wnRTyZmTt2Fcu3Vv7frB/5uM
 QLNk8/OiTmX5UARBIhbqXW1zeIWGHGVKKShTTPMu5BD9sp7ftbZzC/CJzeb74/raYkRdvmQfmZK
 CWnePZG9TRX3gbk85EUpIkVkymP1J78WwTmDJrwgGC0jpFTKXY4WaVp+jsmAhIxY/yD4U2lpS0+
 anYWKb3cVP9nhKTCbrVkYfDd3LJMM5zkJJlr7D99u9xeqqMHs85dSIRwuKRl2NGaj+Owh51c6A+
 t/M4TXQv471DN7npuKx4HA2eLBQx6e9G8SEIRWtSRwz0V8TcFnN/IrWF4BCcKDaKDy+iF6ccC84
 =
X-Google-Smtp-Source: AGHT+IFgRy8RDNUYoy9HmM8ZXEJ/celppDIh9+2BaaPHUMg4TpNRHay3/3Yvm0rfu1LVNRcGviL3jg==
X-Received: by 2002:a05:6a00:908c:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-74091a01224mr777481b3a.2.1746476880020; 
 Mon, 05 May 2025 13:28:00 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/20] tcg/optimize: Build and use z_bits and o_bits in
 fold_not
Date: Mon,  5 May 2025 13:27:39 -0700
Message-ID: <20250505202751.3510517-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 tcg/optimize.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d5256aa02c..8fbf682e6d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2246,10 +2246,14 @@ static bool fold_nor(OptContext *ctx, TCGOp *op)
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
 {
+    TempOptInfo *t1;
+
     if (fold_const1(ctx, op)) {
         return true;
     }
-    return fold_masks_s(ctx, op, arg_info(op->args[1])->s_mask);
+
+    t1 = arg_info(op->args[1]);
+    return fold_masks_zos(ctx, op, ~t1->o_mask, ~t1->z_mask, t1->s_mask);
 }
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
-- 
2.43.0


