Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B93C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHV3-0008F2-3C; Wed, 12 Aug 2026 18:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUl-0007Yq-Di
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:23 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUi-00018t-VA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:22 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c999f162c9aso1133929a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573938; x=1787178738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oP0xPjlLzI3yratNAQYhA0C1+FXrDvewHgZ6UdllNaY=;
 b=VXAZKe9Xa/GI6dO/Ec65v7DCpW5M2AD5tnnR6puLQB+MnmcQubZodFzebwdNWBMOPS
 sb9Jk5snTKDvWvURnynTKcsoUfhVdIizJ4UaWW0YaIQYiEsYJm0ZNJRvLPjW4jLRmsn8
 EsrGy+Iar4lCaXTToz4efwXcAPgbaiDgx2pJst6PsUEpxauDiAD2nc0Grwt5gV9YVxkW
 wNZV3O7pBe96yx6KJbTjVQF+25Dmohoppikows7UPRefVAvTwIBGg1ZbAIfHvb8QgtMR
 +JNkThsBLw9Z5b2a5O3pTa181TBeAB5rNcJOLV0tjhjR8bH3gfGrvrMG2WUbbyTVFDet
 +hTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573938; x=1787178738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oP0xPjlLzI3yratNAQYhA0C1+FXrDvewHgZ6UdllNaY=;
 b=PqbJ79xf0vW7ajO60y697wUJ5fp/kOeFDQl6hTqDIdZ1mLyz8XzybyPi26uy6VKXXT
 x05WFCxFGnUMZURUkvvmJnGdUrxOK7qOxYp1TiUBUWshKkpNrGSzSNmAsS/mtg9B0m/I
 o5KcnurIVySuQfFz0u2EuzBJNiVQZe8L+s51U98aAewuzrikST0H9QFz4Qmv3+geNXWe
 VaSQ9DdWpwjWdS7ZUGJ27lY6cxoUuEoYxoapCGLYKfvM1OJJ4yQAu+KZ5HfuXS79OitR
 lXrfu3Geu1oiXI2wev4C6NZxI4pMkJI5Hglnmj6o7J9LQoyzMk8v1yU9Nli3j+bnDYWu
 UVsg==
X-Gm-Message-State: AOJu0YySihK1z3HyvP5gSWaBqR3R1EvgnqlUA429jPTROLmtizf43wS+
 WH58rAmS6rUDhTK8oaOm6M5NhHh0ZE5cbv3SeeNZlTaXTW6bgCl/yyApzZTfVjiAFKb/xlM2eR1
 kmdy6
X-Gm-Gg: AR+sD13lmYKIhEv86UvgZWY19bj3hriFdnytM9D/BxSkFqAL+D1sBfwYfIEjtfJfmM7
 XSA0k4pyUyRl22DSfbOhLZhvAl8CixyqvieRHTGpdXQUTfShY82yLrIPsrYSM0gZf9wmSKz6yjG
 hXijnr8TYj5hFoo7/Y50xLklxiNcQZje8X2GxQO7w+FZ7clhfrlQpFe2whegPlPctDPV77gIMId
 OxQjMNlbEFX4d+jVVTXR22KS5e83CtM0+F3TSrmAO8aD25y0iIIl9IaSZ2Cf8yfCEst+IJoxcVI
 2Tx2YMv13qje1yZ7UiRM8UO9ANemACiY9mFZwkq1BDprSObfTd2GXDI+hDEvv0EnDdAC+cPGOUP
 4Ubymhf6YhD0rPl/X4bFopUGTABlf6AGvLaftcDJmcrui+opc8fxK0R8YNyMatBGkYebqfFn5BT
 9FNY3ZbDKNjXAMcYwGIIc+hVKUXJorpL1x5zEFeOzbVSCdNYLt26PQrKo8pYoN3AFyufzBU5jaa
 mvLE7Wv0JlycYP9QPkz
X-Received: by 2002:a05:6a21:168d:b0:3c4:511e:26ab with SMTP id
 adf61e73a8af0-3cc550619a1mr2170310637.3.1786573938303; 
 Wed, 12 Aug 2026 15:32:18 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	Alistair.Francis@wdc.com
Subject: [PATCH v2 36/52] disas/riscv: Skip post-processing of illegal insns
Date: Wed, 12 Aug 2026 15:31:26 -0700
Message-ID: <20260812223142.349142-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index bc86cb866a..75c2fa11e6 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5321,12 +5321,14 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
             }
         }
     }
-    if (!op) {
+
+    if (op) {
+        decode_inst_operands(&dec, isa, op);
+        op = decode_inst_lift_pseudo(&dec, op);
+    } else {
         op = &rvi_opcode_data[rv_op_illegal];
     }
 
-    decode_inst_operands(&dec, isa, op);
-    op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec, op);
 }
 
-- 
2.43.0


