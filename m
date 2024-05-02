Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2015C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2TBT-0000bl-90; Thu, 02 May 2024 05:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBO-0000b7-K2
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:56:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2TBN-000174-3u
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:56:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34da84cb755so1444604f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714643811; x=1715248611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7qwGbQTjhjXahUTZWh0LtFO6xVuUCN4ooMRx2Zw77U=;
 b=enkVHEcd71DBDUJaHHAp+kjQg+TEXxw8hByTR4TVdP61drr4W6n0gkAOxGe4ltkSaQ
 rJ/z8CeHu6hhYy+p8JrceICqo4OStMGdSzMMZxgx7vbDhdtRlJBkr5dACIMpTl5w5vgL
 3M0W8qyujmbwpWWaQ32Lfi2J5FavfKnK444jzKE2LasaW1G0wvZwuzQJBG0nYY3fzAQ0
 JG9WKB8gzII1maJBpfDvdFaLS54DXnh+pAZiz7Cd+izR3UZaR7MhLEz2xJsmbKiPpHEI
 O9mrfXD5/GdbvA5Y2eClKSqypmkNvd0yJmwXdrV6M2UpGyR6tJbQqb6ohB7UmnrCZNcN
 0mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714643811; x=1715248611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7qwGbQTjhjXahUTZWh0LtFO6xVuUCN4ooMRx2Zw77U=;
 b=lVA5ncFJCUAzB0ruHmYTSqlipSfEvY4A+GGy4gKKGLvlDmnUxFhiNc6QnXK0wDFF6M
 X+oBh4cg1bdQ8mUIlx+J56TRlGzYr4XezpNlTcJMwoVsJb6jTjzTNOpFqWwIwyYJwBwS
 gYgUy0EFl2JQn6ITRbmkS01VgUoN176FP6nG0Wt9DYMzGlMFHMWUivD6cMCpGFPQdD0X
 6Rdd+nelYiwLiS1ru5oVUomeaOOnEhwzgh9qTw4VcUcGB5Iax0FRFLKG2sDO9+wQGyYr
 OZOQuaeuVftGNmeL1vFMdJgo6t5RzW16nFWNVIHxED7/Uc9kfCTk3ZaeApmGw17FgIAo
 aTEw==
X-Gm-Message-State: AOJu0YyGbShHw6v7xpslBM+HijO1bgQ3cDXradDa+wYPvEFax26H8Ul1
 mIAjAmO0ihq4VsomRVbNQV87vyM3+Ae3FvTPlLeHtXA9/tSuEzQ4cm5PEwE0RW1cn38y7RjigAb
 R
X-Google-Smtp-Source: AGHT+IFdw3YhuGEsLnONzC/k0yW36l0mMcvNvC69kV+/6oNwYAgrsCn18qbJ8Ls+UBEa49PNTxRH+g==
X-Received: by 2002:adf:facf:0:b0:34d:a23c:cb4a with SMTP id
 a15-20020adffacf000000b0034da23ccb4amr1272261wrs.7.1714643811001; 
 Thu, 02 May 2024 02:56:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.106])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a5d544f000000b0034db8184b41sm847863wrv.112.2024.05.02.02.56.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 May 2024 02:56:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] crypto: Remove 'crypto-tls-x509-helpers.h' from
 crypto-tls-psk-helpers.c
Date: Thu,  2 May 2024 11:56:40 +0200
Message-ID: <20240502095642.93368-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240502095642.93368-1-philmd@linaro.org>
References: <20240502095642.93368-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

crypto-tls-psk-helpers.c doesn't access the declarations
of "crypto-tls-x509-helpers.h", remove the include line
to avoid when building with GNUTLS but without Libtasn1:

  In file included from tests/unit/crypto-tls-psk-helpers.c:23:
  tests/unit/crypto-tls-x509-helpers.h:26:10: fatal error:
  libtasn1.h: No such file or directory
     26 | #include <libtasn1.h>
        |          ^~~~~~~~~~~~
  compilation terminated.

Fixes: e1a6dc91dd ("crypto: Implement TLS Pre-Shared Keys (PSK).")
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/crypto-tls-psk-helpers.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/unit/crypto-tls-psk-helpers.c b/tests/unit/crypto-tls-psk-helpers.c
index c6cc740772..36527fd655 100644
--- a/tests/unit/crypto-tls-psk-helpers.c
+++ b/tests/unit/crypto-tls-psk-helpers.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 
-#include "crypto-tls-x509-helpers.h"
 #include "crypto-tls-psk-helpers.h"
 #include "qemu/sockets.h"
 
-- 
2.41.0


