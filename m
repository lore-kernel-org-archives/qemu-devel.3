Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A534C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCf-0007Tj-4N; Tue, 18 Aug 2026 13:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCe-0007T0-1N
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCc-0004lF-F0
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso242655b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072537; x=1787677337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PNBZwXtGw/7SqTqr09BkkYdWVCo+PU/5thxbzztQAsQ=;
 b=JgvMxn7DJDCeTwJRCkFc3bMndtxbcMlTzn7N6AtSLf9tb+za8YtRQ3hZrJZQmRQVKm
 q2WkTDggJKAh/fgMr0ZVwAXAK96apWzvHtuBbDf8qkBXwCUuOOlDMjJS3MDAvzjkUe7Q
 rgOeTMLt0elbWRuL2YYxTCi3q9G6BEFk9adDfYY+nr90FmcnnPisKb20INzKQVzRZ2YW
 Tzy70oNjOzUq1pzCJYhFF8TQCQAfj8ZGRCRvulRpMmw8tQ27sqTCN7PdOYbYFpaTyZWU
 5TxRFYVSwV/EM5NmmG/KwEsRoPOlOTGVYriLH0/suGyIxSTVNOEX9c0btfwiwyds9PAF
 fTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072537; x=1787677337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PNBZwXtGw/7SqTqr09BkkYdWVCo+PU/5thxbzztQAsQ=;
 b=M1onWdDmo1xBs11eDzsAea2SrSThQI3+TaQLAHSoasOj+Vzu6OHNndGzWRBQ32FGqR
 E43JzQ5zbSEHSNf7pyFGG3LSrUpdFFhmgaUuaiQ8yNT98q6z56cISJEziw+N5We8G2H2
 Bbtx2LnVibjRkJtw4l4nyqnbaqP5jZ5d6XMVlKS/1I1jQknsfE+UjmGCRNRm0NHKiCy1
 Kq2MtHRDZ4ZoKU4NMs3vL4KbOsfzI0dTbuj+l+xB6JIgxmz5ghLrAe1G7Al6rjL8ibn4
 HvdFfHFsN2clyFtHpi7pSbzADHK2nmsIBY1mW3JjKcfjHSEEzlLv3UXB7I8dRxyoE/RE
 rhzA==
X-Gm-Message-State: AOJu0YyE/WTEl874vjbY16nE4RFdbqk+0/2xAkAe/jZk+DwXHWE9FDaJ
 CaHIsrOcP1dqBYTOZ7AlTZcjemx3G4i2YwrS91iEpn0l3YK8MHVNPRcq9lfCN17fkeH1yc/XpQ5
 Y2suAE7I=
X-Gm-Gg: AR+sD13KDoumrJz4Ys6vXtJnJeNaU3mO1d2aHT5haxywG2eZ+O9e/R23eS8rLl/Epjq
 thMVx2/Fo1NUIy3OrL66tJh0d86GzgmHk1dpTvanwO+Xt43k00qdRlL59hySQDbah5vfJ2rwwiK
 uSfk2KQ5WHlBKIjTe8UvUusUWu+c4HbZ7Vnync8ygFYqwH0ICPHO9O9d34zLgLl6tYXXup860Hd
 aGNMYXltres5XZVGYXJ1jcdDhIkEVqjlxlSfQt7lfxVcyL+NDMR34O/cBI13gOHP+6LJedvgPe6
 dcTIYJA2HsLQ2F3wqbkwrUQB01Y3yjZh4bNdG1jUr7JX6LccJtCSpCyWnFbA6YTzV4F0qOKmgut
 rs4VxZj3uQn9t4aNAG/o+xMH48UTEMxI6tRLHgHALRLg27XuH/l1xuObLPMT3MWW4UoNSZpVaV8
 zJQYy/EzY+w/unZ3SmYSRWIQOTjWvhMgMGeE1vmwlWZfHRn+feSOQZIIZwUh4Sspe9wvURvUNgj
 bUhNOoKcFMXO0sUxTNQ6T//H/Q7+isWs+A=
X-Received: by 2002:a05:6a00:10c9:b0:848:2c2e:c7a3 with SMTP id
 d2e1a72fcca58-84fde012431mr32978049b3a.16.1787072537082; 
 Tue, 18 Aug 2026 10:02:17 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/38] tcg/aarch64: Implement revbit{32,64}
Date: Tue, 18 Aug 2026 10:01:33 -0700
Message-ID: <20260818170155.1907006-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 tcg/aarch64/tcg-target.c.inc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 0afa988087..80995403e4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2656,12 +2656,28 @@ static const TCGOutOpUnary outop_revbit8 = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_revbit32(TCGContext *s, TCGType type,
+                          TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_insn(s, rr_sf, RBIT, TCG_TYPE_I32, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_ext32s(s, a0, a0);
+    }
+}
+
 static const TCGOutOpBswap outop_revbit32 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit32,
 };
 
+static void tgen_revbit64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_insn(s, rr_sf, RBIT, TCG_TYPE_I64, a0, a1);
+}
+
 static const TCGOutOpUnary outop_revbit64 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_revbit64,
 };
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
-- 
2.43.0


