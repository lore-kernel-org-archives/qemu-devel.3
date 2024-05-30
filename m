Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305E0C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdsj-0004wa-Cw; Thu, 30 May 2024 07:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdsh-0004uN-5x
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:39 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCdsf-0002gE-JB
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:23:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a98so523765a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717068214; x=1717673014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGoFF8PPa/BpM4KP9BeBmjTmucakXvrHPoIh46UpeKY=;
 b=r/4SYbx8a5PNeWKCS+vcaAQPfc/7aAPQ4Lbz7sPDb9qYSkF6a0/gooKhgWofgyYuL+
 I1UVAplYSiibvqx0EUYolcTvOeH7dcrdtfrSLCKhxL8WWlgJBMlNLhxBxOdU78UJa2hk
 cI9VWVpaWttpPopVZEEnNUyLCxsXKGoymrJ5p7ijhnnZMyfhRFCPPfrIyiutl+I6DiR3
 HzxvkTueXCdDk9i4XAUdai7fwjgIit7AipBG7lxpYL/TA4L0HhIx+8erfJu+5MOsjvW4
 Ean7/sBUZA1FztNbg/nnlDmWCbYUZAykqLmJvfbe3lDoJiXDGAd3bkl328g8QdlJhd4I
 TE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717068214; x=1717673014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGoFF8PPa/BpM4KP9BeBmjTmucakXvrHPoIh46UpeKY=;
 b=ROwXBeitzNZKoiyvKWae90OT8/0Ow8HlSILjuU6f0H98ep6AkEUITF03omfi+oMwDx
 +MtznZfmvFK/Mi4+0oXrGBm1HoulTHu9eeybcuSVvZ0hKv5ZJchvOti0E3Q2ZF+jYxCP
 ekk0/dJGGUktA3iOSwpUi02STk9LWQeewJnYOP0Ai63Jjs8NC881l5h4ZCuJIw1TPFE6
 V9mFn2QTXm2kXZQK0XJLt+KPD76BHqax1wIPcA+vjuzedCGtCQh0T6v0NDcxS1acpj9u
 dqMzRvBA9XhRq5JvEYMmzzbbKMOYPCxYzszVDGN2wZrOU1S4BJgsqMTCpcHGbD8hr9QK
 8WhQ==
X-Gm-Message-State: AOJu0Yyehkgud5EqlJdd8jh6uwNhxQAR2A1ueo6tJjD+9XZfsuGF8H3a
 DE9RHXoBs0dIpbF2Ka3HkfmhztqfLHrq3IhQpRn+xeZKjWCve/rzVHJff0eMwkU3/mz5LXM87Px
 N
X-Google-Smtp-Source: AGHT+IEw2j6h6ipAB3UcU3pjLCg35Hdcl8dxUzdGnzI9kUReOXQR2+1GPoL2TKZ7MWBWXXsBT2vVjw==
X-Received: by 2002:a50:8ad8:0:b0:572:d082:79fa with SMTP id
 4fb4d7f45d1cf-57a177aaa3bmr1274039a12.14.1717068213685; 
 Thu, 30 May 2024 04:23:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578523cba01sm9798275a12.35.2024.05.30.04.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 04:23:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF6DE5F8E3;
 Thu, 30 May 2024 12:23:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH v2 2/3] update includes for bare metal
 compiling
Date: Thu, 30 May 2024 12:23:31 +0100
Message-Id: <20240530112332.1439238-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530112332.1439238-1-alex.bennee@linaro.org>
References: <20240530112332.1439238-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We shouldn't use <string.h> for our own implementation. Also the base
types we need live in <stdint.h> as <inttypes.h> doesn't exist for the
bare metal compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 semihosting.c | 4 ++--
 semihosting.h | 2 +-
 string.c      | 2 +-
 usertest.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/semihosting.c b/semihosting.c
index 7a0ee0c..27dafbe 100644
--- a/semihosting.c
+++ b/semihosting.c
@@ -16,8 +16,8 @@
  *    from this software without specific prior written permission.
  */
 
-#include <inttypes.h>
-#include <string.h>
+#include <stdint.h>
+#include "string.h"
 #include "semihosting.h"
 
 int semi_open(char const *filename, int mode)
diff --git a/semihosting.h b/semihosting.h
index 06cda8d..68344fb 100644
--- a/semihosting.h
+++ b/semihosting.h
@@ -19,7 +19,7 @@
 #ifndef SEMIHOSTING_H
 #define SEMIHOSTING_H
 
-#include <inttypes.h>
+#include <stdint.h>
 
 #define SYS_OPEN	1
 #define OPEN_RDONLY	1
diff --git a/string.c b/string.c
index 045d71b..c289aa1 100644
--- a/string.c
+++ b/string.c
@@ -16,7 +16,7 @@
  *    from this software without specific prior written permission.
  */
 
-#include <string.h>
+#include "string.h"
 
 static void *__memmove_down(void *__dest, __const void *__src, size_t __n)
 {
diff --git a/usertest.c b/usertest.c
index ce0f61d..5df95f3 100644
--- a/usertest.c
+++ b/usertest.c
@@ -20,7 +20,7 @@
  *    from this software without specific prior written permission.
  */
 
-#include <stdio.h>
+#include "string.h"
 #include "semihosting.h"
 #include "printf/printf.h"
 
-- 
2.39.2


