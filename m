Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506E8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgP3-0007Ez-Eu; Wed, 20 May 2026 08:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgP1-00074Q-7p
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:51:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgOz-0003d6-GM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:51:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso51414625e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779281516; x=1779886316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KD0LwbPnEERREvv0kdN5YQBpyhPsKT2FNknCk4iL4as=;
 b=ncKbYTihufUxTkmWnkYFOi3xFVCcYzD7+mTL++1jpC51SYLLPsmQfQVWmEx3v7d7RN
 U1375c2a459JVE0mMiLmuFybc4Euc2yY8kCaDdLLrTbTB+NyYotLOoqXMkxNFc4QEQvf
 KLDsPzvCHubG9espCTnEqp2zkwvgSLu/Y+LTL6hhcg/7Na0E84lAIePBREzzQ649O20i
 mfLWwkIY9DOUPV+B1Zct/J33CULjjyjWWBuJZ1FcHqAjynaX3ICjSxcm4GGjQrc10qE7
 raXgX3F59csnetJ1xXUck6pvqDwPNapfkvCRoL2wEsxM+B+DVuVr9Kpt2DVfq7GRvxFq
 mX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779281516; x=1779886316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KD0LwbPnEERREvv0kdN5YQBpyhPsKT2FNknCk4iL4as=;
 b=laEOiUR51HLFU+qP3apJZ/oG55BEffiuoS28dSOMZfxz/uzJaZb9IkFBN9TQHapRbh
 JQWWsxV+fu5udIaDYCFK0yANu1EoFkgkQB7eAytLIQzi6lY0hWhhZXQPfL2R4ToWIhXm
 8T6KiXo9ssbJ8KS/gskJ7Bt2mSN+T/VDlsguq1ySZ0MXPcsW12wzzm3sxW8thoyvNTPU
 k2pkruCtKYInNe33LhB1suQ6S2m0GeNDucAULWbGgBldpvyxGNKbc0PaECTUE6haJ/Jh
 OWrURMCyjH/JzkeDfxgw8qnyIFskRb/u56vSQisRl6UpUMqwwa7m5/la5vfe704pc7Og
 gROQ==
X-Gm-Message-State: AOJu0Yw9HfTQTYDAkZ235r6m+V6pKQt6PDuu8kqxeAydt3RMXnL3Bqj9
 t7SZp3roJZCozZ+aZXliWN1mBllFRKpO+FsQ8qipl7npNlOoxGHskluP2HmMpnPhivwKYAZR1YV
 tAO3BD9w=
X-Gm-Gg: Acq92OHlaCXg4C0RJeslN1w/lzbF5CdvoqSVZidWbTNHnQjZJ1CwgMFAKXXtu+EUp+Q
 pTn8iI+7Vu2PgSEAKGrKgCQRzZcumjEwM5n+4KUzxe/pToRZvsvK8ekGFmQ2igT/Ii1w9afulFE
 rj9weKYv5+GPmgCE8yUbeDP/ZpXKHuFg77ZL3Mw/F457XsAjRPFZDL8nj1ItPWMa7xu0bN8T970
 2RUyilakrXRhhKQNJnDiLkVPO00LIo+XVMKnGl0m53oxvjzyHi1qPUT38P2eY8qXJS7dMSoIw2z
 ycxO0XiRzkJnt6f+//Ag43Zj+cKfaC78SrpbJAAKWz6xAHTH2yDhsi4wTrB1do/l/+8wDvR6eG0
 w5upEl43tWFs37iyvYXqkXbOWaHm1VhHZ6nFhNPuNVhC6gL8qZOptxAdnNGyK1MDIdnetZbr013
 /1JBoWH+3onPJ8hUkB6Jr/rT69YlCaa8z9CyT6KwxWL5vjDSU2Jfg2flez08eWLRjRk0ZwJsAg6
 JZOAsP6kV4=
X-Received: by 2002:a05:600c:181c:b0:48f:d5b2:7c1a with SMTP id
 5b1f17b1804b1-48fe60eca66mr238393215e9.13.1779281515851; 
 Wed, 20 May 2026 05:51:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaf0fb46sm129829755e9.11.2026.05.20.05.51.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 05:51:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v11 2/2] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
Date: Wed, 20 May 2026 14:51:39 +0200
Message-ID: <20260520125139.13352-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520125139.13352-1-philmd@linaro.org>
References: <20260520125139.13352-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Zero operands produce a zero high and low product. One operands produce
a copy of the other operand and a zero or sign extension in the high
half.

Fold those cases during TCG optimization so wide-multiply idioms used by
target translators can collapse before code generation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/optimize.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ef5eb2cf175..fcdef25beed 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2212,6 +2212,34 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
             tcg_opt_gen_movi(ctx, op2, rh, h);
             return true;
         }
+
+        if (b == 0) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op2, rl, 0);
+            tcg_opt_gen_movi(ctx, op, rh, 0);
+            return true;
+        }
+        if (b == 1) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_mov(ctx, op2, rl, op->args[2]);
+
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                tcg_opt_gen_movi(ctx, op, rh, 0);
+                break;
+            case INDEX_op_muls2:
+                op->opc = INDEX_op_sar;
+                op->args[0] = rh;
+                op->args[1] = rl;
+                op->args[2] =
+                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            return true;
+        }
     }
     return finish_folding(ctx, op);
 }
-- 
2.53.0


