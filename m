Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73C6F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquc-0007hb-Ru; Thu, 23 Apr 2026 06:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu6-0006ZG-WB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu4-0002NO-C3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso6307607f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938602; x=1777543402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=smRHFbZ3lUkLYKVcrIk8sD3R9MJPz7ZFklbF7kQOzmU=;
 b=ghN74jGwdpJcn2q4xZT4qaE12Y6GSQyBiJ9TBqReb4qXngFmw/q5/5FraKzBXU+9m4
 tzFqnTMeQZOYxl9dUe5/EQ1l31xvKostwbqcp54w0V8Jfj4DYmvMwWRjsXkFP/f5cFgJ
 EfABQXtElPnmvdwQ6X3NpbBA20cesPOWKHMRpuyjtSkSCHD+BeZTnnwJMm5dR66yI7oi
 ABXJKVSyAL0WjztLu1kDuZ8KhpldfrnqwqhN2J7wf1pQy7A7p0iNoPrqrYbgPbLMcJvw
 VyV+7SbhgCk9MFSxX3qVe2I8TYRNpwAmuJHT34r2vaDN4eyUo6tyDiqGnFIJk8+358mn
 ccOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938602; x=1777543402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=smRHFbZ3lUkLYKVcrIk8sD3R9MJPz7ZFklbF7kQOzmU=;
 b=pWFwC8Lxz2Ar8jO1oguISSn5McjKRLk/ePJV+1DSNB36QQ0nXZT99nq7vRFoDmBPhn
 QCSPA5IulHrCF4fSyDIesDN7YNhRJWkmZgpXzRn6lfYhY1yHGFZ+e5IEblkext4hwFz3
 odG/Zzu0fB8yZCWADjz7ChUin/xJDIz4S9jhm6eflsWTiK6YHjX+TOhnJn0qDnxfcqnQ
 yK76NHalKhq0/EOl9uRWRU+0ZlQKX3DzmDVA7eRbZO4hmOgJzHGrtj+0XMiuBrImAP6u
 7JCViVEP+GleIWyOmWuOgJwAZHQ13TfrubAybT399SG4C7PfYMhcIUX8wYyZfNJBUdKs
 s9XQ==
X-Gm-Message-State: AOJu0Yw0KCYQi//V3OXaSyTsToSEN0D8IGGbB/845qJd2ntrBpAxOwU0
 odKKZV/JAQBe+MHUXWGE2nUGyG9Gr5iQDmkQ81adxIRieAAiGrz1HjAMYxxV6uHxyt49pKb8SRB
 j6EjF
X-Gm-Gg: AeBDietUD4vj1CxKfFrAGj12rv5xNH13w2uAIcQenNZZ2l3JvjwZVC/Lz6Xy8ue/5+G
 0hFP+nSDSG8EJiur3gbDCijMUw2Wh3nMDS7GPZX1ZztEUeGF7g2iuhjV4dyHjjjG9FT+gHruaZR
 6hVS+ME0HmZPvu1W/+baVQOk/67er9y34BYsNjxXBftgv1fSfyo5hMetJ6a6vVxGLzl9FBzY/zy
 mO0mLn16QCDYYuYj4+of0feE8iW8D/5uOioQSbzTDw2yzW6DfwFc5JVcBKxCFomE3+IahBgQQ7V
 OsgYVJi0MAOX14snMaONIayow7DfgR59EgShg0ZM9kjbKrnxsH83wcjw2EeEpKROn1jotqwTBfR
 X7SyyjVpGLBUwwN1rgT9rBAk3dZQu0Ha0FdWSfGL0SA26U+8YX0K2sASyUdGgo6V+Kbm8xOkt/1
 cwMuHS6DNqrYl/sO9XVqsICynpyB+tb1PsZIBPcsgHYAMzMyeKg2jr1oYkLkFwPosgKbUZB6Gjh
 51pYvK3jpOVus/ywbSq43GJVUyEI6sUyiMhf2H5FA==
X-Received: by 2002:a05:6000:2211:b0:43f:e938:1e67 with SMTP id
 ffacd0b85a97d-43fe9381e75mr38017299f8f.38.1776938602288; 
 Thu, 23 Apr 2026 03:03:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/59] MAINTAINERS: Remove Paul Burton
Date: Thu, 23 Apr 2026 11:02:17 +0100
Message-ID: <20260423100229.2941820-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Paul Burton has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-17-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75cc6704f4..07a08b1a65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1487,7 +1487,6 @@ F: include/hw/intc/loongson_liointc.h
 F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
-M: Paul Burton <paulburton@kernel.org>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
-- 
2.43.0


