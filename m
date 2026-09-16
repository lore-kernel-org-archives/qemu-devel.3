Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B975CC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJI-0000zW-R4; Wed, 16 Sep 2026 09:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJF-0000yE-OI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:21 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJE-0000GZ-1T
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:21 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6b1ae72186eso604615eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563859; x=1790168659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+yjjV+A7iYyzKjGgR+UNc4f/t+ifl8d6M9mByR9w2bU=;
 b=k8Kj+yexrV/lZ673oULieg648ezNTZ9+NdIlk3Cius6YtYE5ZOGbrCQ7MS5yN8xZER
 l32vWfjEOv7FzCuBGaWXn2VUvrXYq3S6r0pdsWtNBMiDVWPUzS/4ROVG99/NYGcMbAtY
 kFz1DzMH42Br0W11yxyWI9n87axRsChrgm1UQWmMYRE+eRPiRgFJsySiYHSYKEfdcMSr
 CStWjl6r0+Nkkxig6RFc1i7C8j0bVCvkJ4B2gU8RkrVH8ncwVH5Blecf16b9DKe9EtDk
 FdUbu09UiQw6bkyhaKsAYS6UBOcEg6rp+lkNdBpUbGZtfDLaJEI8QEJqDSGnmqaQjfwu
 u8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563859; x=1790168659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+yjjV+A7iYyzKjGgR+UNc4f/t+ifl8d6M9mByR9w2bU=;
 b=RTVq3ZzsZPCaj0HwBhhlNmMpXZFLCrwRvwD9QpiC4Rrh67ymlDnlhxgv9NqGeXHKo6
 7rabb+ze8xiPyL3dGhYNPcrHoJkCy3/RT8vOkqxgJb5BYvFcM07V71Cny4rWQ08poAYd
 hfsgFjos2Oe4zJ/Y7ahNHfKdUZ9jUkXsCgEAdF4X1OssKNZ/I5cKJCd7EocZcVyZkwji
 P4jgcGjkupCwTKjcSJDl1fRaFrWh+ZI554RrNhruOYQbu8S/s9L47Gnl1ADDGN8AlTcN
 7N2oj74qQKLgrfo9Yxo6J8pvcK1J2dEZatJ/aOxggkHFlyJVGHXZUANY0sU3rWw33Jg2
 b5TQ==
X-Gm-Message-State: AFuF++lRypOa7CuPaI+wBhxHHEbe9T5hR/7clgukIHi+/wgP4Sl69inD
 WuieoWGgN3U/kpS/qiwEUvi0eKA5rd8xOMcfR6LI3PqaFA9temdfYqA71iUpSl5YyL9Ekqu3QOI
 ZdVqn/1I=
X-Gm-Gg: AYBFou1f2sVJXWjz9mye0tpt5CqeifnIfY6yk7J8vOXEvg+j3vqmT9iqLjh0geVOnvU
 at3SCFSe2adU/oZc7ZUp4ot7zmWP+k8f4RH76HZwr2mRDGZbGfEjnop3vnkyuqNnp5uECQcHGAu
 tTQuKaiEpWU0bcYnBFkRxNtMzoES3jvkF7XjVCi7gIUgVPXF45eplqZQuHOO7EazT0xI/EomwHH
 s/10aHSLIySJGazIc/kkMGWy8YMn9jGe4vKtjMW8GtSdEnOvsZnEBvTK6IQJ+sLFtu4em72Or47
 deWhl5vHEmt5cIPrK6Qr2YFi62oQRFnO4XXVMs5Pde+ev7X7FO72aKrhn7WBEk9CuCLpfzLh0ji
 C7SrM244LgGCUWv3Me5T96pZNT6iTsKTqdLyFtgVBCM+2AShwH13BAKiFLv+/wNGoe2eWBwN1AP
 f8tOX+0icXcBjcziaYX9KCisGFUtVmoqOxjJX8NKqFikw80bFbg5DBljyLfOdYoGb0vlpD9d66z
 JKxolN34mj06aoWNg==
X-Received: by 2002:a05:6820:162a:b0:6b3:1874:6f21 with SMTP id
 006d021491bc7-6c7cdc59df3mr2388431eaf.0.1789563857809; 
 Wed, 16 Sep 2026 06:04:17 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/92] include/qemu/compiler: Define QEMU_ALIAS
Date: Wed, 16 Sep 2026 03:02:37 -1000
Message-ID: <20260916130409.3382710-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 3661dc5fbaa..8fa4552ef8f 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -230,6 +230,13 @@
 # define QEMU_UNINITIALIZED
 #endif
 
+/*
+ * Alias the current function definition to another.
+ */
+
+#define QEMU_ALIAS(N) \
+    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
-- 
2.53.0


