Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0871C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reyMu-0003Q7-81; Tue, 27 Feb 2024 09:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reyMo-0003PC-Do
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:23:34 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reyMZ-00064e-TO
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:23:34 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d22b8801b9so71267181fa.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709043798; x=1709648598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7lCDJFul+ibKZoZMtWLX/cuzMrJlZE5tPkzq+eVYpt8=;
 b=fxoVpo7pirm3KjnDZvomfgYmmNhYLa3pFmlL6f369bRpWrLyc75vV+RXIlS/cBBLEV
 MBXFWfjUm8XP7nraQkunmZEGu2+jQi/GxcanUX3yzIppJzGP/dBeE2hItYlpGCIJfzr0
 AXZ30+jwIrgdzmjOLYAv0LDRTEoMLXJEqCpFevpD4ZuGv6H3rRH2gVfu6UAotMWTyTm8
 mKuldflro+ly9sMfVy/kPawoZZpiABxpnlUAMgg69KTV75Q61tvuvJV47GGuU5+3dhAa
 0l5BsPqFPV5vrMOZzr63yOtqAMafbjCkfKesk/0q7+BrsEtz61PrA729Ryhj1mU8+Dp/
 z/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709043798; x=1709648598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7lCDJFul+ibKZoZMtWLX/cuzMrJlZE5tPkzq+eVYpt8=;
 b=IjpFI0fBWdLrzj1F0yIvn7IxXamFWFDxCVQ36rmStSGZJ6sO9BbF0K+FNFo8xReQvI
 H01A/Fd5zPvZ3pYAW2xUmXfyrfk/fqjMvYtJppcfHiv6xkSlWQZgOqj4s8OJKbvAMIgj
 s6IvDoVAB8+L7qZrn9IpR8vCobSgB38koGjzP2afGU/LgtgUXVkfKbprHLuIHwgxQpII
 ikRFxI7cn8AB7d+/JK7ky+V710NpoCCJjB43/DR9SQC7ty5umrwPIX5IjrKnuGlaPTpo
 1VZUoEE1YKMW6RiQ/8neotQUsvV4YUQX5vRZ8drHE3P1JrPXBkc4i9e0+kQcki0bOpwY
 9T/g==
X-Gm-Message-State: AOJu0YxdQpaov2bzOYL0E9DwK7bg0kJussiiqvKDPB6aXtfbXzDAVFXY
 tclD8sJwK9x8ugNDRkxX5YMCOSjC95meDGa8L5llVQkYUf1mtKq1Hmg892srZXtwCyRF5gRgvoi
 9
X-Google-Smtp-Source: AGHT+IEThw6Uv5NLYbJQrCEMY4rKtLacZNH5pAL8rxvpYmMTM783qwiw1bWZJxXwKCG2PvLu5+hCOg==
X-Received: by 2002:a05:651c:782:b0:2d2:4314:8c06 with SMTP id
 g2-20020a05651c078200b002d243148c06mr5006791lje.15.1709043797666; 
 Tue, 27 Feb 2024 06:23:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00411a6ce0f99sm11465829wmo.24.2024.02.27.06.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:23:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/tcg/multiarch: Give the 'memory' TCG test a larger
 timeout
Date: Tue, 27 Feb 2024 14:23:16 +0000
Message-Id: <20240227142316.1827154-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The 'memory' TCG test times out intermittently on our cross-i686-tci
CI job. We expect this to be a slow config (it's using TCI), so it's
possible that when the CI runner is heavily loaded it tips past
the timeout.

Double the timeout for tests.  If this doesn't resolve the
intermittents we can assume we're looking at some kind of
TCI-specific hang.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2079
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I could not figure out a way to get the timeout to apply to the
'memory' test specifically (including all its variants like
running with plugins or the gdbserver or record-replay).
---
 tests/tcg/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8cf65f68dd8..af1a18cee1b 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -98,7 +98,8 @@ QEMU_OPTS=
 #   15s    original default
 #   60s    with --enable-debug
 #   90s    with --enable-tcg-interpreter
-TIMEOUT=90
+# The 'memory' test in particular is very slow under TCI.
+TIMEOUT=180
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 # The order we include is important. We include multiarch first and
-- 
2.34.1


