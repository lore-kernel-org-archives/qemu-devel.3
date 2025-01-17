Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E607C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1y-00044n-5r; Fri, 17 Jan 2025 13:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1r-0003vx-HI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:11 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1l-0007pP-HO
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:11 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216395e151bso35159595ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138303; x=1737743103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkmlLK7Fahw0RO7FW2rGNPWMoqBNxNRmAvk5ugcs8i8=;
 b=RsXteXrIN5foSrSQoYrkp0ZKchJUJigaNGRlbdktxTc9J9syTNnlD45M6UlW90xo7f
 j320VbjVj53jNR1NROyRH0T9PIFWrA7oxRNRHShl9PJ7F717PCzsVM843o31p8QXxgrm
 GqhmFAgL7aZHYpRoFly5iGaE/Q2GgM9ruLoBIMEn1pXL/JwAswhmxK0b3N4DOdY0mIUh
 46UGLmHPi9+Oqk+KW9UUzvSJs9qr4i03POExvdSW0AcEksK5poeGHPGYJRfKbbTBFQX2
 4OSna5LqNPN1874j32j2jJ92ebt+5AIDSxd36Qnenqsjdc5PzB6PYjpcTbAr/e1jhE34
 jvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138303; x=1737743103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkmlLK7Fahw0RO7FW2rGNPWMoqBNxNRmAvk5ugcs8i8=;
 b=FQ4Da39R6o5tS1FkyZLpB2PXaP5yjXVPWEzBHeV7KwILs9Xp3ac9e/+Zo5UXdTWjji
 shrqsdBdu4NThQ1/f8GGxlWqSb+0vTTc+GmycnNAxY2wFMr9pFCkWKYWWvL3O/H/BxZK
 diqxN79pBh1pmFu7i8fs6Mp+b6/ZL/nnF0t2/hBMDwG58bEztn/1aRue6AimWrDY+Dru
 /18PPWOqOkvn0K+jQ6FrboSXCFdzOU8qiUVH3WL7gIRauKpkn9GsJZnMB/T80Qyvzmw/
 hHT43bTHTvCXxiVAfeC5CQizMSNYngXlrgFUFwOrTkHqS+WNQnhHaHTMEFO1ZF8R2rw8
 Jeog==
X-Gm-Message-State: AOJu0YwoZwgCCMANH9v9kaoOLn0XkYl4blfqnbiLGZSZ5Jzk/iMV+BQb
 MFUUBotnDT/3mIUvCPNCQQTdIAa3oh1u3bwXcT7S4JbCjamt72EazUOdrJrzuYwSILSG1b5s7UG
 K
X-Gm-Gg: ASbGncuPL3nEd/ATK8+O0pxpjZraBdT8OLcT1ZoMyraOStBUfrXdQsjLkUzK5JnXnAx
 5AYhrgl90tlLFWwKPbp7sxFN12T3vbq1T+Z7PG66JLWJAJy6GroHa9xdz/rIl4rmR1/WJpZUAcU
 1Rqb9r7UdM0gFIsDtTqqpCJCXjuNXIOaUOAz6b9KeHe81VttCxXgW9f9l5i8JE5GAU7f+PwBUHO
 ux9GPoLhtsqfbC4L7/5bhEfrg5uUpMoSprDogvR88sy5U8It1gubeUeKu0WrQrKywDOL7XOWqPM
 FEldeEnN+2VdFYw=
X-Google-Smtp-Source: AGHT+IHejYBf6r5BXJgc/X8yuDSfdQxFa/rg6dm3BVy8eb9+ECdzggm3Murr/MCJQj2exEU3XXaLZg==
X-Received: by 2002:a17:903:2352:b0:215:58be:334e with SMTP id
 d9443c01a7336-21c35c9af72mr53230595ad.10.1737138303011; 
 Fri, 17 Jan 2025 10:25:03 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/68] tcg: Add type and flags arguments to tcg_op_supported
Date: Fri, 17 Jan 2025 10:23:55 -0800
Message-ID: <20250117182456.2077110-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  7 ++++++-
 tcg/tcg.c         | 11 +++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 238c55c9ac..ac0a080b15 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -834,7 +834,12 @@ typedef struct TCGTargetOpDef {
     const char *args_ct_str[TCG_MAX_OP_ARGS];
 } TCGTargetOpDef;
 
-bool tcg_op_supported(TCGOpcode op);
+/*
+ * tcg_op_supported:
+ * Query if @op, for @type and @flags, is supported by the host
+ * on which we are currently executing.
+ */
+bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags);
 
 void tcg_gen_call0(void *func, TCGHelperInfo *, TCGTemp *ret);
 void tcg_gen_call1(void *func, TCGHelperInfo *, TCGTemp *ret, TCGTemp *);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f2bbff8079..43293ca255 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1931,9 +1931,11 @@ TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 }
 #endif /* CONFIG_DEBUG_TCG */
 
-/* Return true if OP may appear in the opcode stream.
-   Test the runtime variable that controls each opcode.  */
-bool tcg_op_supported(TCGOpcode op)
+/*
+ * Return true if OP may appear in the opcode stream with TYPE.
+ * Test the runtime variable that controls each opcode.
+ */
+bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 {
     const bool have_vec
         = TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256;
@@ -6243,7 +6245,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
             /* fall through */
         default:
             /* Sanity check that we've not introduced any unhandled opcodes. */
-            tcg_debug_assert(tcg_op_supported(opc));
+            tcg_debug_assert(tcg_op_supported(opc, TCGOP_TYPE(op),
+                                              TCGOP_FLAGS(op)));
             /* Note: in order to speed up the code, it would be much
                faster to have specialized register allocator functions for
                some common argument patterns */
-- 
2.43.0


