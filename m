Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B62C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqF-00067l-Ev; Mon, 22 Jul 2024 07:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqD-00060S-JW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:29 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqB-0002V2-S8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:29 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52ed9b802ceso3601634e87.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646266; x=1722251066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AtSpKBg1PmrqtB9T+k18UXmGojBdHF5u/W8SCXR64Q=;
 b=AP79L0ukUD9rMYNL1/5In/Tpiucwh15srzsL+o9SWCqsL7rgyGsmV3U5XxU+ASC+z3
 I04R8pJ1Q6b8oigypEfjDbrJiYFtT7AL2YuMMgUZ8EaaXqVdjmYIAoFVB8B8M7b0za/E
 J4sn77ANVB2fNCqKy4/NdbjEq6B75IVLE64K/2sOHeqgFNScrMpX0F5FCPnTVkF8qv//
 X76Yq/qsY5FfJxBaUQ0voCRPNu3/6G4O25n2FU4HXAplhjBkpQRYku7G4Wds3TAr6VG8
 AHAJ5c/DnCWGt3VQK3Q7aMF85LunfcO+4GzGvUbdhHxePlPDB8GbttPzKHH1eJnNCiwz
 G3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646266; x=1722251066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7AtSpKBg1PmrqtB9T+k18UXmGojBdHF5u/W8SCXR64Q=;
 b=L8qgU5AeT7Db7hYKXEVEZ5TAx3HGjDCNCAsP8Yz5TWYCsB3T8xigm4TXwHAwXr6ydk
 T1xFu9m3kQ51EEtqbjm4lmec6r1arbXgja/mlQlmvAl3ikkos4g0oYDe2PiOMYWu/BYt
 xKJh79+57sfDpUco/pjBLw5T7wL5YPQvEmwptET0REyFzhT+9GP85Gl7sZT2pRmh6aB0
 7LAn0n2U6LLjkmKGVvsSqW3Cm+++iB+JorqgfsG0otH32KomGg9u3V2bXmrJ6oUyx6+l
 AZojN626B3eK9683d8mVecwTaQODQtCMORYg8G4RO8jnpzzaTGv3XqTh1AzUQ18Uqy3T
 r4yA==
X-Gm-Message-State: AOJu0YwtHbTIIm/pHOP4RABu5i8o/HVybnYEKsO0iBbf4C4BRPsALb+D
 Aqzr8FA9xXJlRDCuvHlAIZuFUCwIwd9K9FywU5aviq7LK/cSoAWhjJXwBLXL9iOcy0JzqlPdKSy
 g
X-Google-Smtp-Source: AGHT+IHe1ySeXT19FsNX7wE6bb/v8ISDKLD9zdrD5E19IUELryty/6F+fHt8ZqjC47Qkc6RvkViYKQ==
X-Received: by 2002:a05:6512:1322:b0:52c:e0e1:9ae3 with SMTP id
 2adb3069b0e04-52efb851b4amr4187041e87.57.1721646265801; 
 Mon, 22 Jul 2024 04:04:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c9225fdsm415887666b.173.2024.07.22.04.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D2416211C;
 Mon, 22 Jul 2024 12:04:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 16/16] tests/tcg/aarch64: Fix test-mte.py
Date: Mon, 22 Jul 2024 12:04:13 +0100
Message-Id: <20240722110413.118418-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Python 3.12 warns:

  TEST    gdbstub MTE support on aarch64
/home/rth/qemu/src/tests/tcg/aarch64/gdbstub/test-mte.py:21: SyntaxWarning: invalid escape sequence '\('
  PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."

Double up the \ to pass one through to the pattern.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240719004143.1319260-1-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index 2db0663c1a..66f9c25f8a 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -18,7 +18,7 @@
 from test_gdbstub import main, report
 
 
-PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \(0x[0-9a-f]+\)."
+PATTERN_0 = "Memory tags for address 0x[0-9a-f]+ match \\(0x[0-9a-f]+\\)."
 PATTERN_1 = ".*(0x[0-9a-f]+)"
 
 
-- 
2.39.2


