Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D604CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4j-0002RL-Nl; Thu, 15 Oct 2026 06:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4i-0002OO-FG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4g-0007qR-BO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:40 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so3341316f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061557; x=1792666357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kFGfTPQS4hsBp760p3qt8M92/PFVqzJWzO6KtWLgbgk=;
 b=kXSfkoFT7Be2MK11a8rY7cfJYyWSUDTWarRvkYEfW049ss3gYw0kAcRpsircm6bang
 tpUoSzCHfe2kRHlgFwnXmeNF5Lr8FGVGjWBplY/1tA1WFuMZ5wMFHP1Henymj5vp13x6
 8p9t11/2lJuCy3R2vA9C78EjXGvYdDQfOlBL3GkN+Up3t7G8Pr/h0mydjJH1EZhCkN70
 99tTimJcMGKYuOjUGYyQ34pofyW+q4e8mzON/IyEubx6mOz0RF4bYX1yJ5ky3vxqXcQS
 zT+vYl1YInc//aihFtZjYQcixMRxy+Qxj1+d+HAPF4rnxrAmZ0uZBZ0BRONJJp80FKJC
 bdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061557; x=1792666357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kFGfTPQS4hsBp760p3qt8M92/PFVqzJWzO6KtWLgbgk=;
 b=BAcDZIydEzAS1lIVuN7rPjJnwjDGlOJjVrJicHqcF+Zgd6rz0hC/Lnsj0BtmUICpby
 e1Npyvtzaj6y42076nZKUqzmFT/RRnKvI2FW0iIfD/SOLgVl/t04RrWYRQgz5Qpo75T2
 FbC4E1HUEjohiVG86wmNpoQnfVN9sbxKtt0/MPyDIpF9GCGafOXCvvO5hvwPrSy/JZsd
 KNw9qgCJTozwohdzQLNMGTEetEOyJDV4VbZCAnhMFnf9apubO1q62smtSTakBHhWyatX
 b/zbPYICgoZVTaWcikr0eHmjsrnA60y4CBaFrK8viQFG0kmBWSCg8YF7a7Qty0ig3qob
 W5xg==
X-Gm-Message-State: AFq9FYKToUTT7MS+vbABstLskDouOs9pBbhAUPcNRMIz3uNLEIPO/100
 MVpSML+j3FaK0108tGXPdgLzJ3A25fWzHSKhenqFa4AlkmKqY1uFh37/hKCRX8rzaaH16qMuLOr
 y/ivrG7g=
X-Gm-Gg: AYBFou1tE/OQZxaYMMo2lexF12CC8+UbGEkBmJU0h/i2cVL9isk7PJRJkPb8ygJM33v
 TX6T4eKqni1UhmVY1+zmateW8oYQdfY32jCi3i6Pin3EHXlkZ84Jy85vPopWJXKuObU1JZ414KR
 OAqSlUhaE6viOfAQdqM/cGW7vkDBgHkYqg8+6rTlFikjqSy4ha0D87vHWbJz9vsr4+fnNFjPB8Q
 4z1S+swGnQ/9ZicqhVWIghWQ0QFk1H53Z55tdg0uK49rqx/kkF4hKeP9u3HrjNN8plK7Sftyof4
 ODjezDdHsdwYYvWeKiDTNMEVll1JgyOeH5o2SkBiN2Arz3yGvdct1/BxCsjiGWq1fk9C0XyUXdb
 FOGkTVYelvwF805tsa+06M1zLYQ3mIT3r8E+lNFo7iGsLaSUyRZ/8tmCEPZRIDTVz+YRQ7T6685
 mbF2WJveFPJR9FitloUwuXuoU3z8N40bPNe9djNcmZmzL4QLQ316PukyF1bLJHvDUlfBv9ZyFOs
 tAYQXjTj8LeBo3SiWe+BYnLaI8ca1v3YnX6QAzMhJFkdZUgusZqX1UuUMmEYGzTHpoIgWCiCHIM
 YYWTP2X8v66qdBs=
X-Received: by 2002:a05:6000:468b:b0:48d:f1b4:38d1 with SMTP id
 ffacd0b85a97d-48df1b439acmr4281563f8f.35.1792061556969; 
 Thu, 15 Oct 2026 03:52:36 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/16] tcg/riscv64: Adjust sign of lui immediate in tcg_out_movi
Date: Thu, 15 Oct 2026 12:52:02 +0200
Message-ID: <20261015105212.356392-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

No real bug fix here, as we've already shown the full value
fits in int32_t, but simple subtraction in tcg_target_long
may produce a positive out-of-range intermediate.

Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 1ed87646e01..247b4a6a60e 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -789,21 +789,22 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long val)
 {
-    tcg_target_long lo, hi, tmp;
+    tcg_target_long tmp;
+    int32_t lo, hi;
     int shift, ret;
 
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
     }
 
-    lo = sextreg(val, 0, 12);
+    lo = sextract32(val, 0, 12);
     if (val == lo) {
         tcg_out_opc_imm(s, OPC_ADDI, rd, TCG_REG_ZERO, lo);
         return;
     }
 
-    hi = val - lo;
     if (val == (int32_t)val) {
+        hi = val - lo;
         tcg_out_opc_upper(s, OPC_LUI, rd, hi);
         if (lo != 0) {
             tcg_out_opc_imm(s, OPC_ADDIW, rd, rd, lo);
-- 
2.53.0


