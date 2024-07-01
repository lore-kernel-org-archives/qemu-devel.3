Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0565C3064D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 02:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO73n-0001iJ-It; Sun, 30 Jun 2024 22:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO73l-0001ht-8f
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:46:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO73i-0005Ut-Uv
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:46:28 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7066c799382so2049936b3a.3
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 19:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719801985; x=1720406785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7uk0+/ouRfw5Hh1qNoz0AFZnn50xl2En+npPSW4GWrk=;
 b=aZILsPdXpQjZ7lm84Vjr2dCrri6/q4v7fuz8h8PDkUCA+5Z+usRMicG020x+sRFA5X
 oAaTH0NIHYssOPNRZKMPawfTWnuKvYX/Lv5QfV1X++7MgkbrduZGD+GXI5BGILvOs4Xr
 VXBWOLmEPq5Bz9DhVWGvpMuPGOSBqIbNSDdfJTzwH1XWdw6XIhq2BGEo0pgRJFpSMUT8
 Vt9KH7QlFZ9uYNiuCM+uFcv2fKpSkUqDL8oF+R33GX2j+USHgWCgDceH+xQ8WGaiKYks
 pt5BuG4EeSx4wPf83AiEQOvGCG5URJAHA9hO2fymkW5qewUNhtbQwQcOtxRDJ0paC0Rd
 HALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719801985; x=1720406785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uk0+/ouRfw5Hh1qNoz0AFZnn50xl2En+npPSW4GWrk=;
 b=qjjtGFBClqDk6Y80Kg9OpaUEauQLpp9CX4W8Tqwz+1Lft4tBMbXPeMu3XazJTGehBY
 ZeWne6yB8CouV/3rpIcJpTFuwqUC8QjaGHJeIkpkTr/apt/sAmivBppCnRtvH8SAOwpi
 0QRAp4VDt9Vx1vIo9eimPV6yBP9gQBgl1600wo4424OjMcyHJ7NqJdBO/sl1KhdxlHZT
 Cog5xd4N/vQX1+4iKpGLPskzg0zmApcifk9aE8hDQPAva+EIix3y8HW7Dh89uD6svk0o
 MhInwR9mRJjofyg4Nm/6pwNRf18f6fJ4cza971AtDqByuZkeAENxu5jU1Io/6uxPGyX5
 gzlA==
X-Gm-Message-State: AOJu0YytujimTRW2pTytmpcuStMWBrfkWGbLI5PinD8UzjyPgk7qzVpY
 lIJBQidkkI5pldf0EAy3dnzSI/i853GPa7QgbtIOSlmzTkSsxn9bfZtKAoDf4VR8A9BI5AfcnVY
 /
X-Google-Smtp-Source: AGHT+IHJVAWT6ryh6FoD06Wf+ZTdlA76R9jQlBkDuoLWlTkMy0avK+gIrxSpPUu18RkPE3nJoo5QeA==
X-Received: by 2002:a05:6a20:7343:b0:1be:cc4c:c386 with SMTP id
 adf61e73a8af0-1bef611c644mr6720067637.22.1719801984947; 
 Sun, 30 Jun 2024 19:46:24 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce6f6cbsm5549885a91.29.2024.06.30.19.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 19:46:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org,
 qemu-stable@nongnu.org
Subject: [PATCH] tcg/optimize: Fix TCG_COND_TST* simplification of setcond2
Date: Sun, 30 Jun 2024 19:46:23 -0700
Message-Id: <20240701024623.1265028-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Fix a typo in the argument movement.

Cc: qemu-stable@nongnu.org
Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c               |  2 +-
 tests/tcg/x86_64/test-2413.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/x86_64/test-2413.c

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8886f7037a..ba16ec27e2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2384,7 +2384,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
-        if (arg_is_const_val(op->args[2], 0)) {
+        if (arg_is_const_val(op->args[3], 0)) {
             goto do_setcond_high;
         }
         if (arg_is_const_val(op->args[4], 0)) {
diff --git a/tests/tcg/x86_64/test-2413.c b/tests/tcg/x86_64/test-2413.c
new file mode 100644
index 0000000000..a0e4d25093
--- /dev/null
+++ b/tests/tcg/x86_64/test-2413.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright 2024 Linaro, Ltd. */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2413 */
+
+#include <assert.h>
+
+void test(unsigned long *a, unsigned long *d, unsigned long c)
+{
+    asm("xorl %%eax, %%eax\n\t"
+        "xorl %%edx, %%edx\n\t"
+        "testb $0x20, %%cl\n\t"
+        "sete %%al\n\t"
+        "setne %%dl\n\t"
+        "shll %%cl, %%eax\n\t"
+        "shll %%cl, %%edx\n\t"
+        : "=a"(*a), "=d"(*d)
+        : "c"(c));
+}
+
+int main(void)
+{
+    long a, c, d;
+
+    for (c = 0; c < 64; c++) {
+        test(&a, &d, c);
+        assert(a == (c & 0x20 ? 0 : 1u << (c & 0x1f)));
+        assert(d == (c & 0x20 ? 1u << (c & 0x1f) : 0));
+    }
+    return 0;
+}
-- 
2.34.1


