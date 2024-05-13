Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE83BC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ty1-0005PB-U3; Mon, 13 May 2024 07:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txi-0005CX-VP
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:28 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6Txg-0001Qp-Sx
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:35:22 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51f174e316eso5006273e87.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715600119; x=1716204919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP0ehDJwQwNPc3oCtX0Yl2I4Rx2QZwnqfx2D/w2BPys=;
 b=EYd1/tovwwEWLou00wYaNiRj3rTLY0WpVyqyukwfnkfyupuEvb0HxT6cSvIQXVoJ4t
 ylWBCzj+759q9qqBmbY2fKfJjYtSFKfNwuwlXV67R1rae30O28eFSqjL3m987YWFfCwB
 dZNI03vHGBvmkxzNVDNNmj7TBZuxrTLPsrju6hm6Rfr42QkXCMkb9QGZzgjuvPOybOJS
 azHOF0LDrlT4eXWydG5LX4YPBmaiF74+dPT3vqzFAW0C2s4HBCeiFai35pwgz7MWYTee
 BnMN2JGaLrS6ZKdrEWYgRUUj/g7eG1XrXVl+Xoip3VgOL95Nc4MzFLU3pC1OprwR/aLv
 7Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600119; x=1716204919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kP0ehDJwQwNPc3oCtX0Yl2I4Rx2QZwnqfx2D/w2BPys=;
 b=dxBkyNqRRPQGfHet0+CtGNW8JX917OiUfus1WawgRKVjoep5IMNwPeQOLwxFRbHqbP
 J2PtbxYMjNevoo0FcC+AcOVw43pwt6rCMRWwnMCICj6shj3RkD8L8iEYmvO6NR1YTMLL
 HumXfU00sN4ejamUucMRSpqs8Wu/hE4IfD6lfgSLGD/0jwrf+hd+3zVQBQYY7EFvogl9
 2YC+WysNZojNzeTiKwA9nnE8E0p9qdadAHMT8AyJLUpWIKCx9JaJesIhSOQZXdW8laSu
 p2jUzuwVIAqO5vQH1UCDuJUo2fbJC8Uv0+4LtLG6jww2I393i1VWsbPb+woLDL3dJfBr
 4THw==
X-Gm-Message-State: AOJu0YzFx0152L1s2ozWEWuXui2tiZL872moAVoxDCqzSFldMUxQaNM0
 rvlkZwzawUQqIjaAdAstmqT2b/gXCjFV3txPdEIj+suZ38JdW4l73Abaig3Jewi/ID5EhD33J65
 Q
X-Google-Smtp-Source: AGHT+IHp+8sFtqyIzAqkJkmHheC9Y3KmfQuCW3TTmYO5knbBQJRQ0vqWBFLz5eUIu1KBLtQOZbqrhg==
X-Received: by 2002:a05:6512:2003:b0:51e:25d2:453f with SMTP id
 2adb3069b0e04-5220ff72f1dmr4540795e87.68.1715600119097; 
 Mon, 13 May 2024 04:35:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b79bc0asm10987188f8f.1.2024.05.13.04.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 04:35:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B30D5FA15;
 Mon, 13 May 2024 12:35:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [Semihosting Tests PATCH 2/3] update includes for bare metal compiling
Date: Mon, 13 May 2024 12:35:12 +0100
Message-Id: <20240513113513.640007-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513113513.640007-1-alex.bennee@linaro.org>
References: <20240513113513.640007-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

We shouldn't use <string.h> for our own implementation. Also the base
types we need live in <stdint.h> as <inttypes.h> doesn't exist for the
bare metal compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


