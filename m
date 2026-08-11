Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A61CC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wttqY-00038m-MF; Tue, 11 Aug 2026 17:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wttqW-00037b-7t
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:17:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wttqU-0003Nn-O0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:17:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ccf2360620so3713565ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786483033; x=1787087833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JflFgfrMzFhzr0a4ISUj6Kxh9Ka0CQzG1qGrmlrzl20=;
 b=DVd4bqbsmFwVUKaZ4HYBCfJ4jr1Rrdg7Q+GNUohuhIs9pLLfjCmzqmCh9XTxVAOjV+
 ZB6G/qKVJwChMFMXAMofkdPjk1dRx7jRlJ+2xlBFIn2hpBi232yseJHxROHzVRrzpoJJ
 /CR7MuSUih9D/yIoNS6Sqf/km4N6At+hseHjIlmIoipC5dgijz7/PKluyufvQV4iePjT
 awufAZES+TzuHdxxLlpcUJEWW8zPz8wnMHBynUNgsResJ+V0yHB1dwXzUfwIJbM7T2a5
 7L/bDbeEbCtjk+RnruswO+lrXTavBEJBS8rQE0h87sjRuMxaf8N5OlGe41W6w180v/Eu
 TVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786483033; x=1787087833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JflFgfrMzFhzr0a4ISUj6Kxh9Ka0CQzG1qGrmlrzl20=;
 b=kUnxFTMUxIDJn5uzNGy10ThtDj7Ht+xnqX3aEf4hZVEq45pP1xAo4TDR9FNnR5Logy
 oqhDcifoSvm1ZTcQE7PTVsroLZHfaiwzYDMZ9QxoM1s2Rz0yeqxNzwzQbwnUh3+Xnhdm
 cqKR6ucdQpue9tPx6su3J75eusYKPMrfj1nRsYKRJl4Kf9rIciFOg55nFfHFP1BXCJfg
 AHfsGcY3mW/Su/YbPQ2MAz+tDcJIHC6vMUZf8j+3jrCKgxT8zp0MWqO+l1NcbegLkeNa
 ZIdHFaWpKujh+7LMUQCt4iISPKHCgikV/I48oVfOrs614PVUo007tUxr2othv3T1Rgwf
 eqsA==
X-Gm-Message-State: AOJu0Yy9OE4fAwllJK58/gyWnu7ch6lesCm7ShF7lTfH7pchdemKINWh
 gEPeCANTNKlejNrJvy1e9Z2DZ4BPTH+oH+nvKqXwEhAjl4FRmAd4qPhInxUA9wkaF+8fUFtJay6
 HNxbv
X-Gm-Gg: AR+sD130K+NrDyQml0tdDSEi2iZp8L98oedcIBRiSyXHHtcAUL9chxBQmWW5/YDb0DU
 9QXrrACV7ZOAYlZF70cuqEXvy8ObccR+OTTRRyC0LvahXhs3GIUaXQICS1x0hsw3ocJN29MbPXq
 B3aRWh+c5EF74mb2jpzxsCyDJqpFibqYXlk1CKSlncuQ/I+mjBMlYrk9GtJ5EqBgyIL0kNN4EvK
 xtiWzYWucG52WALHPImpiPXgyi+p3rSG8qj0X1kLG6d9mZMAcXrmUpHTvKkEszPhRNMDDmQbXck
 HWIFffuhmmV7qzBxxoJt9qUzlRlUlzgTE1nlqIVVF+1O3d+6hIjXCoJhJd0fV6xcJYG/1TQiXlj
 8fbEvIn/bSPjrsKBalO4pYE5rGFWVvPYYlAts1e3UbhSkV90AHT253hlvpvho4ohGrLMyDoD6e+
 60CZ5RuSSdta5fu0VayFekbjCTYf05rRVNqgMQ2wezMvNrgFcm9I2mK/rL5S6HTY1LHV5Bn0XJZ
 lqItWKPqK0fO7jmh0X8FBVRdabGuRU=
X-Received: by 2002:a17:902:e552:b0:2c9:c083:cd50 with SMTP id
 d9443c01a7336-2d3455c4540mr3754285ad.17.1786483032893; 
 Tue, 11 Aug 2026 14:17:12 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3160f1117sm12615885ad.58.2026.08.11.14.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:17:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jacob Young <jacobly@ziglang.org>
Subject: [PATCH v2] tcg/optimize: Fix s_mask computation for shifts
Date: Tue, 11 Aug 2026 14:17:10 -0700
Message-ID: <20260811211710.146307-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Skip s_mask computation for logical right shift.

Cc: qemu-stable@nongnu.org
Fixes: 93a967fbb57 ("tcg/optimize: Propagate sign info for shifting")
Reported-by: Jacob Young <jacobly@ziglang.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c                     | 11 ++++++++++-
 tests/tcg/i386/test-i386-opt-shr.c | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/i386/test-i386-opt-shr.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2960c0f3b7..8a394acf00 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2666,8 +2666,17 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
 
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
index 0000000000..b1ba64689e
--- /dev/null
+++ b/tests/tcg/i386/test-i386-opt-shr.c
@@ -0,0 +1,18 @@
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


