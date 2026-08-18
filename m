Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79F9C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCP-0007MV-MS; Tue, 18 Aug 2026 13:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCO-0007Lf-L3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCM-0004cx-Qg
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso163344b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072521; x=1787677321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=st89BtH1YIdinVd7rJQ55m7ueiw+97q7juqxabY6zvQ=;
 b=BufL7TBsBoJs7raAdJdNAHukBPXY7CbtO3vkhEYL3z+ezjWb+DF08tPQNzV9Ge0kTX
 Z8w2K86WkhL/Iyr3zewT2yCtNusAz22EleZvK/HT9glbaoVMrVrR9T7bTjd+gKI0JKu2
 OjciKpWwOtwrhKVPymeXd/wovboTgqb3EHHiTPqRyOKUXDY6HjQJulaGrTUJogFWpdaJ
 vDv01K34RHUN7re+sknkyzCo8+7H+KOLawb/vfAyb4XGkrMGkuKI1bd5Fd/GyJ2+e8lP
 nUk56bqhlDUeFGnmoMXhcEZsVFviEj+wN4ahY8grgCvXFY6CsIavuT1ljQ9Mj7qEO+Tc
 i7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072521; x=1787677321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=st89BtH1YIdinVd7rJQ55m7ueiw+97q7juqxabY6zvQ=;
 b=Le2pRpxO4Ai0pEUlHWQ3YFcYgecRTjNUnj/Jnc9S7yMz74mWqyppr/WelEuESD0UNs
 hxdhr1sN63wqliHnATB+/qkT1X7TGPeiUZ2gj5kdIfX+G+Kt6tZqL2YpAzRZmlAM5Ght
 cF1qsPdCcNH4lxMTsBQPO5MggWJ87OlGZ1gFnJzNtyfh8lzbyPcVsh/jsI9onpZN9ELT
 78KdxXPFLbDtstyKw3HsU5q/X0qnN2vl+20x3Fk19TFnp4ewKnq5Oqw3DFrO19G1MQV5
 GBA4x9GdwwuvQeW6pTwnjcDZ4UkWne4cmxg5Xy6upBgibkqGnKIc42GDbP6uw5a55PSD
 gN/A==
X-Gm-Message-State: AOJu0Yy2+fPqrtre9f10vXWlpN+yEL71HZNLRM7j/ERV8zdf2mEml2Cu
 dkftoubHbc5Ni4crvMqTV/+IZ0vs4ZsmTCReDNBbN1hWvi3uwy2KeaBiPElqb8HJMrkaOHqIj7d
 zz54KvbY=
X-Gm-Gg: AR+sD11jYk71XZAs6Th7FJE3pr1Zk2b7gqNEZYkLBIjNl2oK1GYwp+swoPE/U3aGd5X
 ah302I/Fij4shFW11ThLpjguGkn/9N9H0s+4V8ymVpt8/IMJ4kc/TGaFZcA6iD2gM7xzVH50Aa0
 SMF09LMBHb948jJBy/0JX6K1/Xe1VnGiCotBDmJHZcKcE9+6P2W1KKIH0eJi0wVNe7UP78dKj7o
 RQeuzTlT623oQPJHTELuIglq8wXFW8O6Sso3gN2eeyylz2b3pC9IWncldIGVP/9uoS5n2HrzAVc
 1+GSPlbzBe1UngwvXVLrgvKRqDKRda0om6Mynem7++2qps3pn3BDSa6Kf04L3pdhEMA860ZsGlB
 uxT5RYkW6e0om39lCtZO9Ft+8TyoqweKJPljmj/VhfY/UBD9PWVZHRRays9hniExbtRjKSlQFzb
 IjJyCv20IQTTUL+iGD3jWybzDvz2SEOuo/nvk7wyD4gAMHwUg10efTLc1dXHaPneOQxRCMBZ+4O
 zN5Q3sycPiYOmkAZ1dIYSOVja3nzGjv7JuZEUjT
X-Received: by 2002:a05:6a00:ccf:b0:848:3fe2:c88b with SMTP id
 d2e1a72fcca58-851b87a361cmr13194342b3a.6.1787072521012; 
 Tue, 18 Aug 2026 10:02:01 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jacob Young <jacobly@ziglang.org>
Subject: [PULL 02/38] tcg/optimize: Fix s_mask computation for shifts
Date: Tue, 18 Aug 2026 10:01:19 -0700
Message-ID: <20260818170155.1907006-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Skip s_mask computation for logical right shift.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Reported-by: Jacob Young <jacobly@ziglang.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c                     | 11 ++++++++++-
 tests/tcg/i386/test-i386-opt-shr.c | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/i386/test-i386-opt-shr.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ed2ff32ed2..d12babad88 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2656,8 +2656,17 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
 
         z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
         o_mask = do_constant_folding(op->opc, ctx->type, o_mask, sh);
-        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
+        if (op->opc == INDEX_op_shr) {
+            /*
+             * Logical right shift will force the sign bit zero.
+             * Don't bother computing s_mask and let fold_masks
+             * recompute from z_mask.
+             */
+            return fold_masks_zo(ctx, op, z_mask, o_mask);
+        }
+
+        s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
         return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
     }
 
diff --git a/tests/tcg/i386/test-i386-opt-shr.c b/tests/tcg/i386/test-i386-opt-shr.c
new file mode 100644
index 0000000000..9fb8d42022
--- /dev/null
+++ b/tests/tcg/i386/test-i386-opt-shr.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetition counting. */
+
+#include <assert.h>
+
+int main()
+{
+#ifndef __x86_64__
+    char test;
+
+    asm("movw $0x4000, %%ax\n\t"
+        "addw %%ax, %%ax\n\t"
+        "cwtl\n\t"
+        "shrl %%eax\n\t"
+        "cmpw $-0x3fff, %%ax\n\t"
+        "setnl %%al"
+        : "=a"(test));
+    assert(!test);
+#endif
+    return 0;
+}
-- 
2.43.0


