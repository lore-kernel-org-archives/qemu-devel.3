Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CB4C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 23:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKRUM-0005tq-Iy; Thu, 20 Jun 2024 19:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1sKRUJ-0005t9-JE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:46:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wzssyqa@gmail.com>) id 1sKRUH-00063C-Sf
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:46:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so12114475ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718927200; x=1719532000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=NoVnXxozX2Jamz42DuJRZj2z8nz8xYd9StQ7DmE2FI0=;
 b=eDq+mTHqC+tLEzTSYSLMg9BQHOPEZw4iuzPbgDfaVU+K+0W+YSTDIntqrlA1worV5h
 +vUMHP/UrbeA15SprRV+qTRmuEEx/YazuzrKLnDVGskig24Hl2CVLrogZqv4LbTrqCUh
 WJ5Hs+tYy1o9S8qEV7XHYedL3mFe61Zr7t7eecgxwI0V5v+A/rLzsxpqyDWo8rwG9NuN
 WaboU4S8X4VJjZSaeWAoaaokmrNg3hkCVFcp0CZncV0ca7EOI3Hqlsk2RHEt+NONZuHW
 ZRqfVs1K9Aja0ZXp50AmN3fbwIeHnJewL7KcNECeaZHLOKqCGZ+DRRL0q5bB9frS4Bzh
 DIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718927200; x=1719532000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoVnXxozX2Jamz42DuJRZj2z8nz8xYd9StQ7DmE2FI0=;
 b=S3corHPtc+FtYZBfYcFjtXpJHKHLRKiKQL8FpdD5NydW/zX3h+bKLR2Y5CaoK7R49z
 89nIB5z6BZFgRZSaLU0nFDKTCv8iXvq+GwQxU8xcdR4Jw5AcmJRRgfIynDGWiAldX9Ds
 /7R5Bu7w2GQLsL0moCCf+xYlsmlOx1spj1l+atAzbZiNYFDIstj8vSY0e09N1V8dLjmT
 wsI+HLTxpu5AHLNK54yu8J187R7JrgNEfdbNlb3ifQgLGON0fuvPIgPYP0BdGT23szGz
 Yr6iIw7iCKqly0z1/ohwn4ntx2HCAL8vgp6PrhUKH+v60iCNqKfJMlM458ddjk76G0bv
 L4lg==
X-Gm-Message-State: AOJu0YzUD23396CS2lPprkV4PuAxX0zmde3epd21ffTQyVT8bVglfAiL
 flLm909aUljL7J29nFHRCDllhUGOAP1N2aIbRG/g3glr+11fTyflnZwZnPxZ
X-Google-Smtp-Source: AGHT+IFqHSQ/dPO8x3SeYEj6J5ZKRfDk+Y+qF97simhKcZfPN6KrYl9ym4CymrL5bQIXjGCffWM62g==
X-Received: by 2002:a17:902:e542:b0:1f7:3217:3519 with SMTP id
 d9443c01a7336-1f9aa3da6f7mr88647635ad.25.1718927199864; 
 Thu, 20 Jun 2024 16:46:39 -0700 (PDT)
Received: from localhost.localdomain ([194.169.55.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc7d39sm1738885ad.301.2024.06.20.16.46.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Jun 2024 16:46:39 -0700 (PDT)
From: YunQiang Su <syq@debian.org>
To: qemu-devel@nongnu.org
Cc: macro@orcam.me.uk,
	philmd@linaro.org,
	YunQiang Su <syq@debian.org>
Subject: [PATCH] mips: pass code of conditional trap
Date: Fri, 21 Jun 2024 07:46:33 +0800
Message-Id: <20240620234633.74447-1-syq@debian.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=wzssyqa@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Linux and We use the code of conditional trap instructions to emit
signals other than simple SIGTRAP.  Currently, code 6 (overflow),
7 (div by zero) are supported. It means that if code 7 is used with
a conditional trap instruction, a SIGFPE instead of SIGTRAP will emit.

But when `gen_trap` we didn't pass the code as we use `generate_exception`,
which has no info about the code.  Let's introduce a new function
`generate_exception_code` for it.
---
 target/mips/tcg/translate.c | 8 +++++++-
 target/mips/tcg/translate.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 333469b268..e680a1c2f2 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1353,6 +1353,12 @@ void generate_exception(DisasContext *ctx, int excp)
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));
 }
 
+void generate_exception_with_code(DisasContext *ctx, int excp, int code)
+{
+    gen_helper_raise_exception_err(tcg_env, tcg_constant_i32(excp),
+                                   tcg_constant_i32(code));
+}
+
 void generate_exception_end(DisasContext *ctx, int excp)
 {
     generate_exception_err(ctx, excp, 0);
@@ -4553,7 +4559,7 @@ static void gen_trap(DisasContext *ctx, uint32_t opc,
         if (ctx->hflags != ctx->saved_hflags) {
             tcg_gen_movi_i32(hflags, ctx->hflags);
         }
-        generate_exception(ctx, EXCP_TRAP);
+        generate_exception_with_code(ctx, EXCP_TRAP, code);
         gen_set_label(l1);
     }
 }
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 2b6646b339..e3d544b478 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -134,6 +134,7 @@ enum {
     } while (0)
 
 void generate_exception(DisasContext *ctx, int excp);
+void generate_exception_with_code(DisasContext *ctx, int excp, int code);
 void generate_exception_err(DisasContext *ctx, int excp, int err);
 void generate_exception_end(DisasContext *ctx, int excp);
 void generate_exception_break(DisasContext *ctx, int code);
-- 
2.39.3 (Apple Git-146)


