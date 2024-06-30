Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E000FC27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNznN-0004pP-Gj; Sun, 30 Jun 2024 15:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznJ-0004n6-R8
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNznC-0007Tv-1H
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:01:01 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c901185d73so2297494a91.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719774052; x=1720378852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gXcD6RKAlC5/aI6jjanCPGZJp69fMWK17rMgS0+fr4A=;
 b=bUGf/MFzDdqAFArxVdLCBU134AKTwdAyi9ajlYDWzt0dHEw48va0oXSXc9ckvkTRKA
 Li56WpnlAvbgk04T0sVZ+dGDqPyI8R4TgDhAh1k43a2g+WtdIIE/PbHcPZGGAct41sPo
 rwS4hbTQfrw685x+jyl/OKgAhOLLGpCvPaMYvPSp/JA7KTKFGSGV1LIIF34jOwMSVbIt
 3TslGf7p1+7c9Ll40zduycJl02RZ92OJRiKTHFCDq7JXqaS9RPk5Z/9mI6N8JEgWNb7W
 dWWPPq/vubpMepr6fuHAvGAbF1OTmUs9m9q/OI3o7ni8bAgBmt/4REaTlN728Ri8JNV5
 ek1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719774052; x=1720378852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXcD6RKAlC5/aI6jjanCPGZJp69fMWK17rMgS0+fr4A=;
 b=axgxBPXpOU0Q3v/FxmHo2UXBXnfRveCRzhKooD1NFQxyjsC+x4XK/dRe5ln7lsWl+z
 zBt+7P9TCx7a6BwiJt57FZm0MM6jdvkX3tW6Br7fiWOV6kL0qEg43NMl6Civ5r1oNqq+
 whrkaJo09AI8vpx8c4+1SIimvE8aDluN2fSNWa2r5Q2ZSE6uEJK1q7ApJZRy0722f9OE
 BGSQ7NRLI+qbMa5eNDcq8ntEGXmDJOjj57KgLKnwQVdSM+twu8K74K5H8ejZ8dA74PJj
 vWgCPflwi9u+opsxuRQ/xUFbfnGEk5fSly0DtPESwYVnr39HPWuX4HfxWnNeHHjpltxd
 Dbrw==
X-Gm-Message-State: AOJu0YxHKXVE5H20jasgMlw/ZH067IW6oXQ1tE0KddfLP9ky/QfTH8Gr
 wPPti55Yyxelq6OwLYaB6ioLs17sz/sDejjlBoHeX/OnR2bBJHxjI6/baBlUM/XOB0kbd0ClQRT
 X
X-Google-Smtp-Source: AGHT+IEthC5QVyTQ/7eOjF+4TvYgEyOu4GkrGIj5ryErsBROvoy85muTbR5y4LjwT8Kvyg42VNtEIQ==
X-Received: by 2002:a17:90a:da01:b0:2c8:2236:e2c3 with SMTP id
 98e67ed59e1d1-2c92804d09dmr10735280a91.17.1719774051859; 
 Sun, 30 Jun 2024 12:00:51 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e7e4bsm5115641a91.52.2024.06.30.12.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 12:00:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com,
	alex.bennee@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH v4 00/14] test/tcg: Clang build fixes for arm/aarch64
Date: Sun, 30 Jun 2024 12:00:36 -0700
Message-Id: <20240630190050.160642-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Supercedes: 20240629-tcg-v3-0-fa57918bdf09@daynix.com
("[PATCH v3 0/7] tests/tcg/aarch64: Fix inline assemblies for clang")

On top of Akihiko's patches for aarch64, additional changes are
required for arm, both as a host and as a guest.


r~


Akihiko Odaki (5):
  tests/tcg/aarch64: Explicitly specify register width
  tests/tcg/aarch64: Fix irg operand type
  tests/tcg/aarch64: Do not use x constraint
  tests/tcg/arm: Fix fcvt result messages
  tests/tcg/arm: Manually register allocate half-precision numbers

Richard Henderson (9):
  tests/tcg/minilib: Constify digits in print_num
  tests/tcg: Adjust variable defintion from cc-option
  tests/tcg/aarch64: Drop -fno-tree-loop-distribute-patterns
  tests/tcg/aarch64: Add -fno-integrated-as for sme
  tests/tcg/arm: Drop -N from LDFLAGS
  tests/tcg/arm: Use -fno-integrated-as for test-arm-iwmmxt
  tests/tcg/arm: Use -march and -mfpu for fcvt
  tests/tcg/arm: Use vmrs/vmsr instead of mcr/mrc
  linux-user/main: Suppress out-of-range comparison warning for clang

 linux-user/main.c                         |   1 +
 tests/tcg/aarch64/bti-1.c                 |   6 +-
 tests/tcg/aarch64/bti-3.c                 |   6 +-
 tests/tcg/aarch64/mte-1.c                 |   2 +-
 tests/tcg/arm/fcvt.c                      |  28 +-
 tests/tcg/minilib/printf.c                |   2 +-
 tests/tcg/Makefile.target                 |   2 +-
 tests/tcg/aarch64/Makefile.softmmu-target |   4 +-
 tests/tcg/aarch64/Makefile.target         |  18 +-
 tests/tcg/aarch64/fcvt.ref                | 604 +++++++++++-----------
 tests/tcg/arm/Makefile.softmmu-target     |   4 +-
 tests/tcg/arm/Makefile.target             |  12 +-
 tests/tcg/arm/fcvt.ref                    | 604 +++++++++++-----------
 13 files changed, 653 insertions(+), 640 deletions(-)

-- 
2.34.1


