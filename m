Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB3CC021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzKF-0000mI-Vt; Tue, 25 Feb 2025 13:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ3-0008HP-Ql
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:23 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ1-0002C7-C5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:20 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so15397385e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506717; x=1741111517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u9s5E9vJL83glFBvhdpeE2aqzCOgd5BN92rYhBP9wLw=;
 b=jj+E+mW5duA8Nm3WJZZBPDZW2Z2VNUORVekIbxL5zoJqD2w+p254JOz4KVU1C3qEhp
 uN1jcVttE4upY8U5PAj7JoVK+d+rnzRi9fZRAhYZA9osN9PkokFCgY/jy3y+ih+vlmcH
 jUKcIGSWGDhbZ5Z2TFQAjpiv3hkr/qcjxcJiD8b586eGuFqFwgtCK0rq6ynHKrPO2QU2
 F9bleYDOX6ihk6tl/AEY0LJ7I3b7hOmA6uXnIyD/mmRXxDoyvpBZ72y56aHKruh8+JiW
 /rl4M1NFve9mRHYtklF0QbtLsD7FqmwGwvfwhw2JAK0g1fcs86CEgIAPHnx0nnY085jP
 JCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506717; x=1741111517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9s5E9vJL83glFBvhdpeE2aqzCOgd5BN92rYhBP9wLw=;
 b=rpELJ2Aa2GC20mjCklnx51kWQKXS6o2houyq/OtuXMuURCc6ZNY8eYkYDMBdIwTIqm
 4cD1fhoZCFvWnw4XTix/kA+Lf8Q18U0XBjnfSDN39Gkb9DCJWJzDHXiKEHqRQF5l8/+N
 hwrGMAVVWXV24oEGI/LepWpwmHA2+/WcgT7dWyQY/IdRtBH2UobmxmX1BljioYBh6H8g
 uxCwF7n+mYWiz6xL0f9+doM2c6cuiTz2wDad1j40bf6rNQlZvEcDq6N0X9IuvY1upJFo
 p4GWe3L0Enawikl+cS7MyLnXJDtZs/rb96zzslp5hZDr9NBNsDsUV6oW13+90N9q2hW0
 iCJw==
X-Gm-Message-State: AOJu0YzjMHyHE1ZcJWDMPPVfjoGeDOugnZV+oarMHZJXqpihFZ80Am5W
 fq0F9Hr0Xv8ZvAQHk2es60C1dHHgyF3W644NS8Uoz8A+K7FksuDdPsSgG/pAC2LKz8kZPA4IoGU
 J
X-Gm-Gg: ASbGncsOSys5HJk1lk5h8Go9x3+mmYC5RBosXJ4fgOQwyOxQwQ7nktq3FONOFO2WgPt
 XINCZSo0wS18YtG4CL8XMoVpybWd2O52OTuvAlQkM9nw5MsLuDIGNj+5gi//swhukrs16fV2/3H
 dTKD6y/wrowohjJ7Mgd3DRYF+rj9GTlRx/4fMXfP+j/y476xFeDc0nYJvok8kQcnnhS0K1K+iVS
 91PwL7lDC6M4Oxiflzj1nBbXgRWLfkjgCUQCqwjOJkybjJBnghoKYCudnypoLoI0s9+AbN/990f
 dRJVJa2vm8NIgJjB2+dkLGqS6lu2f77v
X-Google-Smtp-Source: AGHT+IFv651/pReZgfsPrxrTA4JaZemUtu0Fu1aTOdENqus9mO+F8lZYXBX139yfYhrvcbzeh3GLsA==
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id
 5b1f17b1804b1-439ae221d72mr147818635e9.29.1740506717137; 
 Tue, 25 Feb 2025 10:05:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/43] monitor/hmp-cmds.c: Clean up hmp_dumpdtb printf
Date: Tue, 25 Feb 2025 18:04:29 +0000
Message-ID: <20250225180510.1318207-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In hmp_dumpdtb(), we print a message when the command succeeds.  This
message is missing the trailing \n, so the HMP command prompt is
printed immediately after it.  We also weren't capitalizing 'DTB', or
quoting the filename in the message.  Fix these nits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250206151214.2947842-2-peter.maydell@linaro.org
---
 monitor/hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 3825ff40a9b..7ded3378cfc 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -431,6 +431,6 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    monitor_printf(mon, "dtb dumped to %s", filename);
+    monitor_printf(mon, "DTB dumped to '%s'\n", filename);
 }
 #endif
-- 
2.43.0


