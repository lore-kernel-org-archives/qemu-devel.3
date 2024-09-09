Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C38ECE584
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniBt-0004Zc-O3; Mon, 09 Sep 2024 13:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBq-0004KT-0E
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBo-00061x-II
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20573eb852aso37509185ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902915; x=1726507715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O70g17U7QTZMh9A6OBR0gUxSJFLq6gbdNh3PzLTWO+8=;
 b=XJfX72BOnZDvpdkOjVvwtixCu2RjnYr0hyEagJ5PESrDK8IaqBU+oskCF0emzMCc67
 1qnkF5Iwi1+/BrePJWTNlbXeTugRdfZxO5BR1jCnu8ZaT99pk+ZMUMeCHtwfGCTUVb/c
 tfeduLZ54KXwGh4VEPRFrDxg2XEO434zTr5iMuhMR2R5QVnMoO0FJbptEyYCmqFLkPoK
 6XCtBCWh4gLFYB9jF8o2kCkZS32MyRefHgIRHwax4bSlB+AQS51A/sALPL2vVBfvT/5R
 cQ33UjjZDormuAP1k1rNJl7nIUP8XUwQ/aaTeKX4+szCPK3/6/WO4I70dn18hZEM8raO
 sCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902915; x=1726507715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O70g17U7QTZMh9A6OBR0gUxSJFLq6gbdNh3PzLTWO+8=;
 b=waC6tUT/nmPorw4hXl3Ld3voIXa/2q1vL+OgaWHCAsr2TbBnrnuPlBYJBZ7z3321gA
 ddTUk7bRbuUdPD0aTJxF2M1pVe0XMOwCxkvJZVsACwxDFdy9r9ZoTeJmTXXrNi8eJuor
 fn7lhNNEzMz72Y4nUmotKQJh2WkP/8b6S/X8vCqhPyCd7OIw8Wqw2ZQRpmOrPrJKWpQJ
 LYB2cB+X72a+9qfYdpZCU4ybjSuk1i/qUDeScf8cyDY5x78OsSTWycc3lXr8Sfn5Jcn0
 +o6XxNjLSxeNUKrLcrVI/O3Qp1m8TTJZeYg2UzuDzdXgFJ7VuEx4/nDmpnhMG1BQZlx2
 6bgA==
X-Gm-Message-State: AOJu0YxVzqYEJ5Vi62Te49T2Ogn3raHHW0WP4mAqcaXIrWl/sGDHJBui
 M9hPnM9P6C8cQx66fSw5LcDRJJDoLksEEDgIjbN1knR4qaMSqnt3hh5IoswdFJLSSl3X/gUmG0w
 5
X-Google-Smtp-Source: AGHT+IFF4r7ci+UPnOhF698Nl9NC8NlKKa7yzFG9PasqkouSMVuWSzX0kCS0/Vaya8xAhnrPgiWyJw==
X-Received: by 2002:a17:903:94e:b0:207:3a4c:8c6f with SMTP id
 d9443c01a7336-20743c512ddmr6133845ad.29.1725902915147; 
 Mon, 09 Sep 2024 10:28:35 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 11/26] target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
Date: Mon,  9 Sep 2024 10:28:08 -0700
Message-ID: <20240909172823.649837-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

For LEA and PEA, while the manual says "size = (long)", it also says
that the pre-decrement and post-increment addressing modes are illegal.
For JMP, the manual says "unsized".  OS_UNSIZED is the way to signal
gen_lea_mode to reject those addressing modes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 71dfa6d9a2..c94ed8d463 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2560,7 +2560,7 @@ DISAS_INSN(lea)
     TCGv tmp;
 
     reg = AREG(insn, 9);
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2657,7 +2657,7 @@ DISAS_INSN(pea)
 {
     TCGv tmp;
 
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2908,7 +2908,7 @@ DISAS_INSN(jump)
      * Load the target address first to ensure correct exception
      * behavior.
      */
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
-- 
2.43.0


