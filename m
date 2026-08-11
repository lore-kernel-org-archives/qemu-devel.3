Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E104C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXF-0005RV-N0; Tue, 11 Aug 2026 00:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXD-0005PY-6m
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:19 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXB-0002nA-PK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:18 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso596585a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424176; x=1787028976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PNBZwXtGw/7SqTqr09BkkYdWVCo+PU/5thxbzztQAsQ=;
 b=b1hBlSw8qkCT7WSesAd4uK3jbt54wMclgdfLsAsmKSlJAWyhV9yw2hhrfxNRG+YWMR
 EUdA+VHA1HlCucNSKDqFeRXA9Gl7Aegt2YqlhTp7lHitb8PTTwdEKwrcwgtPxm6H1bG+
 v9YYxi0e4laLM0jBahNCFRC5qgplp/j08fgLBgGsuUDHI5IIxvLSpuULETBOR7cWCMSQ
 QRvKEXetk9jxP0r06hx6uQNSZe96gy0WH5cNwHXjmIxMEHCFFQ1e0Ojm1Ft75kGgIKjf
 rWC0VGRtZOkbRAB9I6KJr0aTBKu5V++6mmJfD3UG5k59974x4ndiFf21luyXV5B+nd2f
 6YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424176; x=1787028976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PNBZwXtGw/7SqTqr09BkkYdWVCo+PU/5thxbzztQAsQ=;
 b=ctGV22YK8pShdu8OKqG6k6JbexXgKKOQu9qYYg5xe9i2jsUqZS2pzldfqa0yEiN6ow
 vDhTlPe6focsoJiXhTBlD/U5uz51PnR4i1AOtp78MzV48waJ2uYI+8riD1jgK9LRSKPc
 yrLl0jSUD30zOOeMk0juBssHDvM8Ucc1aHAwH7RXLK2bZssHGEgHuxYljlOYn9IVGN7a
 4m/qyBllTt2o3voDFI9IVEmn8bOY3BjhOmb94dxl28wxOdD5zSWXRIYZEtYU95ic+6kq
 LtCYlScfQTDOygzQO1IgRuo7ckXpjbJGW+VRlym6PEsoQPv/4jblL2hS71Iad2jhVlrU
 gNCA==
X-Gm-Message-State: AOJu0YyL/FeUCZbEf1NQGZRhQ2b2O7AQKZ7iL3xEh1RnqHm6uOt4uiEF
 50Csw9YaQ6GTNSnFahuW7BQFXyYWank7pIAjw4ZvASE8vVLUWanfghuGATa/RK1Vn0Ky3j8ikVk
 ShH1v
X-Gm-Gg: AR+sD10Be+Ya7HpN9U0tfh1B3x0jVbrG4h87jYSA+KEmd9tB+AQcPcsiHdJsiLBAUW5
 3xmmDH4aYsTDWivMbVVMc5nLUr0IbmuOpXbVTVKXQi+G02vn3EK9+uP1sVeoITmdUrpq37ZbK4e
 YHbG2rBiyRn3YTqGoIXqItq3nmUbUBDwNiae8H7T1zbs86iCxAtxSqrCGyxi6sBXuQM1Bb/wRt0
 rWHqbDqTcZrQIgSEY87g8GiI2HsY2IDmp4TW1fdUadKlPKV6iyoQxCRDIBweQxuErHk+9zDwLDJ
 RBcX4odmR+uc+fUtHeuT8r+yKdyweTUI+h1R9/oP9j3uyVDhsBsDrj8t/4b/82MNtejFx7TQ8/v
 DrC80mFfFzTqDZvp5M71CpEP6C0JzirS5W7bGioedocyWstikjDLQvfYi6ZH7rQPL9q45oC2ll3
 0NkvaIbBq2wYOyxQtHREhfrJQbve8NhoU+h+QQ95YMWgNuUQ33TYp6BxEPL6JoCyKccl8DYzyZE
 89SAkVQR/VGkNo8hW1X
X-Received: by 2002:a17:90b:2e0c:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-392ed18a96amr255952a91.15.1786424176103; 
 Mon, 10 Aug 2026 21:56:16 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/16] tcg/aarch64: Implement revbit{32,64}
Date: Mon, 10 Aug 2026 21:55:59 -0700
Message-ID: <20260811045605.1246543-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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


