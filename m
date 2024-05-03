Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413BEC25B75
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nDt-00017W-TI; Fri, 03 May 2024 03:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDs-0000zo-OS
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:48 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nDr-0001LQ-2k
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:20:48 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dcc8d10d39so101723801fa.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720845; x=1715325645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAInt9n6R0I02RcTDmsM7sU3am9+yxrb3hMuH3Duw+8=;
 b=U6J58vk3/SzG1xTpfPKxZTWczLFPVEQEWl6BX3RrPJxuqglXbPIFFnlIBjlAKdtFDs
 d7A54X7tzoPywW/DeSIg4pbBsM+8cg0R0f4bK6KHcoK8KiIJORv9WoCfBPEBU9VfO22B
 7GqN0aA+qL25I2omLwIib9Y2GbwNWM7kAowhYzgC9n4IyjPZJcrUCPWyv/IuHtAUmXj7
 1O9mJ9KG/kwfddpIPx9dLYU3G7Nn3z07eHhFY8WtmWY5bGe5y9d+afftxQztRBGC1Ymp
 PCPBZUVLNPxUqtJ+FtN+AfYZlJj30V10/Eov51wH9oyIhiamPfhLoek7R1xD7VWtDMSf
 rx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720845; x=1715325645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hAInt9n6R0I02RcTDmsM7sU3am9+yxrb3hMuH3Duw+8=;
 b=bOUL2wIuuayFy6YMBBUd8jK2WTWuVtNlMHnxhYVdkVbVzWymkR+Oqn2kT8CN3UP+7b
 0uIt2xx7OEKHYH0vb4irsXmxvAy/GDjoIvgeEg4Ck/MK6dW6RehLlnDyERqs1gKlq2Qs
 IQiSk0aNFqpRvFsIy0FfdwRDx23FbtLS+4y7oy/4XedDdNs/+yzBnPc2pCjKC8cmrupJ
 nChN6S46BuiM21WYVAzwN8qIT8xhoxbouzPJWA+rDAp04Vy7Tbd53WodRyl25KJUCWRo
 ibjxePx8ncel8yfj35MmPxG6msoDKqSCMfd5ENnaZeH585XPTaylUCuQFVFuA5Ky/pTa
 5iBA==
X-Gm-Message-State: AOJu0YwVGL3ACJ8EBZIAaYnyMogHt9nn2KxH0jcb/n4ko7MNsCU9sHxQ
 dJyAUTvI9oCbRLStyMW8oia+NfL6AV/XPIO1qnRJdBuCdSKGjpZR3HYYoi0lIu1n4LVkRUpMvrl
 n
X-Google-Smtp-Source: AGHT+IGK3MlPj+aXrGOxpKDLJj+zaqm50axp+vgE9ADNT0lsdn4wqtleQtfiTx86MCC3SoJVolW8+Q==
X-Received: by 2002:a2e:96c3:0:b0:2e1:5644:24e7 with SMTP id
 d3-20020a2e96c3000000b002e1564424e7mr1222721ljj.13.1714720844841; 
 Fri, 03 May 2024 00:20:44 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 dn15-20020a0560000c0f00b0034d9012e74bsm3071456wrb.72.2024.05.03.00.20.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:20:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/9] target/alpha: Return DISAS_NORETURN once
Date: Fri,  3 May 2024 09:20:09 +0200
Message-ID: <20240503072014.24751-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Trivial change to make next commits easier to understand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240424234436.995410-4-richard.henderson@linaro.org>
[PMD: Split bigger patch, part 3/5]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 01914e7b56..41151f002e 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -447,12 +447,12 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 0);
-        return DISAS_NORETURN;
     } else {
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_lookup_and_goto_ptr();
-        return DISAS_NORETURN;
     }
+
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
@@ -472,8 +472,6 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
         tcg_gen_goto_tb(1);
         tcg_gen_movi_i64(cpu_pc, dest);
         tcg_gen_exit_tb(ctx->base.tb, 1);
-
-        return DISAS_NORETURN;
     } else {
         TCGv_i64 i = tcg_constant_i64(imm);
         TCGv_i64 d = tcg_constant_i64(dest);
@@ -481,8 +479,9 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
         tcg_gen_lookup_and_goto_ptr();
-        return DISAS_NORETURN;
     }
+
+    return DISAS_NORETURN;
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-- 
2.41.0


