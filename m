Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECFDCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1mR-0004Dn-Fq; Thu, 06 Nov 2025 10:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH1mP-0004DZ-Qs
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:20:05 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH1mO-0002fN-AA
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:20:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so6534605e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762442402; x=1763047202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VlTCtfYKtoXt+b0ne2b2RGYNQUV6PFlJABknwYUtpwY=;
 b=c1oub8GyBWZDXjP2WcHQYHQQpQaFbR2qpC1xklTxVCFxGTdSE2dVHGlmVrDjbAmqE4
 K64DcGwR0BMVgJOy2UqJv6iQANjTLxY5FxbO8CeH+dY1jxN8+HtW7H0r9ueA0v0bdY+P
 GVaBQ5zpv6JSSOlwnIB0uea03NayeUsjHz9+lNThe5f+Uc81+NO7reffS5hhEFPVjhpI
 jsvgyJraV+/aw9KiJRrSgMu1H5XhWjRaKqNqxCVRV1ULgtzHZsl+kHqU0xIMK6RZVyNB
 7eqxySAGrProGqLGhM49w7PlVpgn9Sz4cp+PPLvkvhdu5Ff/Pne3aI6ZCO7L92PO0aou
 KgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762442402; x=1763047202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VlTCtfYKtoXt+b0ne2b2RGYNQUV6PFlJABknwYUtpwY=;
 b=Rmwq6hLCAySiO5WD86DkluXYai0oPVt6ArK/GRIB5gjX43arT5HbUHrywJPRCUIjDY
 RuoP20/Xw1HLSC+CQQhwY1mXezLX1SVPDIjbSyt4Kk6vlv3kq7k2TrUjDqqwK/Qf/GG7
 JlWtxiY1OCBi6OO5qFw9AcYb3iANjwHEfzEH3jBGCCRfemgV1EAMmjNiZVue3C104wA8
 TSVC74WB2oMXc9fgME37b9EDxHyvvwUczfJ2yITrDq9UsuCxFyeBBrGjWCmIGBMGqkGU
 xVa4VCFNhpgNqvPvwxwdhqWXxF+sgj9d+MzP+eLeImmL66i1vLQY3uq6s8WP+TRNXnFJ
 IDFA==
X-Gm-Message-State: AOJu0Yyfm0EcGJfqj4A2M1kD++gofxxkh5HMmY8UEisrDyep1aoksibi
 M7vWIuV9JZfiZnwXDnZ62ITlcKzU0NFBeIfUjG658FYnRGy97QbFOMlxXul5G5U3XDYxULGxfsm
 TXp2u
X-Gm-Gg: ASbGncurNdO77fODWmzjJis4uPSMDyLfaWGJoUZymHbXq5h7sEo1DSeSW/zzvMAdu3G
 6yUTWUQOWpIcmWwbMZZGGn9fFhdJe+3N6z1kq4JRCFGlUZ+YfsczM2H+HC+BBA9vWN+PSTv4zTS
 5bg04+QDvg+AMhfj/RWfkuN37r30JWD++GbtdPMUJjv6ZC8uO583l2GSL3nvE0EbM4SrsHbS7qP
 UTMp+1yzjxV6pMXbqrCmMdOEm6wOalj4ztbYWoNAH4/3xrmM8iHPCjmg1Wkz5gAkX1uFYTNLAgk
 /kd2nJZUAFPTx0BXEwGayJsE1d6908MVNL9JQaCih6y7r834oCBlTq6eCWZkS9ka9mXUY92gyoD
 9LgOqdLqUKY0r6zGTJgZpKba1/yiAgPQDAIcJNLx/rPXSEfhFH2jR2S5zc8Qtf/urMsx1l5ztcq
 GAT7BUmQ==
X-Google-Smtp-Source: AGHT+IET2HXZHDUL3DcrvMNEf4LAQ0LsPJjf4siRC9zQprVVcVaykh57IC2ALd5rJIAOn1Ke7QtFBg==
X-Received: by 2002:a05:600c:6219:b0:477:67ca:cdbb with SMTP id
 5b1f17b1804b1-47767cad1a3mr22215245e9.36.1762442402087; 
 Thu, 06 Nov 2025 07:20:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477688258easm31807025e9.12.2025.11.06.07.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 07:20:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] qtest: Allow and ignore blank lines in input
Date: Thu,  6 Nov 2025 15:19:59 +0000
Message-ID: <20251106151959.1088095-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Currently the code that reads the qtest protocol commands insists
that every input line has a command.  If it receives a line with
nothing but whitespace it will trip an assertion in
qtest_process_command().

This is a little awkward for the case where we are feeding qtest a
set of bug-reproduction commands via standard input or a file,
because it means you need to be careful not to leave a blank line at
the start or the end when cutting and pasting the command sequence
from a bug report.

Change the code to allow and ignore blank lines in the input.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/qtest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/system/qtest.c b/system/qtest.c
index e4d1cd75daa..baef06d4d1b 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -69,6 +69,9 @@ static void *qtest_server_send_opaque;
  * so clients should always handle many async messages before the response
  * comes in.
  *
+ * Extra ASCII space characters in command inputs are permitted and ignored.
+ * Lines containing only spaces are permitted and ignored.
+ *
  * Valid requests
  * ^^^^^^^^^^^^^^
  *
@@ -367,7 +370,11 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         fprintf(qtest_log_fp, "\n");
     }
 
-    g_assert(command);
+    if (!command) {
+        /* Input line was blank: ignore it */
+        return;
+    }
+
     if (strcmp(words[0], "irq_intercept_out") == 0
         || strcmp(words[0], "irq_intercept_in") == 0) {
         DeviceState *dev;
-- 
2.43.0


