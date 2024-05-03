Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCCAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uxX-0002RX-5A; Fri, 03 May 2024 11:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxU-0002Of-DZ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uxS-0002ge-KU
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:36:24 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a58fbbcd77aso928255466b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750576; x=1715355376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zvz7ETr3ntE3slsyyBiQtPL/DAqR4yC2HaL2gy45cQQ=;
 b=VWi/pVYt2rucUABnKs2vAng5Yd7ZiEeFNqPeQxCaAIbHo3yBByG4xlOO0CyExikNVQ
 ZQPfSScv8SKIYXKzBN+33ScXjSbuuWXuMu5UUIEzOfC9HV+z2Z9LelBwXK+rkS/lDQuM
 kZ1nL1u07Xe74E2vGlEcKxA/8qy4ggFGyrtUx2Eq2CbKnYkzTcMhmRsLqAmwzjBWLcri
 lEpIyWO1jgdou8ooRYZmT7tidp4ThqnogLioFc3Zlb83PHrS78sSoAhXH4B5JD7nVq6Y
 SPRRjXkDqYqJk8CajFYdquK3LDVjs1hxghkEC9WboxQ7X/ZSuOayVgSWhenugg4vix2Y
 Ee3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750576; x=1715355376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvz7ETr3ntE3slsyyBiQtPL/DAqR4yC2HaL2gy45cQQ=;
 b=Otnp0Tbzo6c8b4u/ywAIMqUXhyj1ncKI4E6PJaRH3pIf03WO2yyQnuYntSemsoAoZ8
 o8GXKUMTB6/FKQJ2kvEEWlRtpfs+kGeyeaaPMFbWnfsZRD7EzZjJG1Eg5TRwwt6lA92e
 xpOHIsZ+4rJikhGu/slbLL6hM6I94z7HhS6eLLOApHt/49R6CChEyf4w5Rvi3nXp7w3d
 W46+Ocnb+0/9mYIYH8/R0xqaLLsl1H5TH9Cr6/sfiM5ZxoCoWWK+UYan1xgIMfI569ew
 0rQcWdh96XBiBSfg2U+CwiRRBDDeOYvlCNLpTScdylVzyp9VaBl88MfzsJ6jAdmv9EK4
 ITWg==
X-Gm-Message-State: AOJu0Yyp52z9FtJMlhKb+K+zlVRzUUQGSgxD8QqHSsp4t0FR2Au3vIJE
 u5ORaBVNqaeu7vTNqbOuAQNICZsy4OnDwmrnxet8Yy7zEwOFyUlG0yfWLTRv9HZokV5ZWNtmULT
 a
X-Google-Smtp-Source: AGHT+IFfUcIHUptFsto3Dl7hLEbEjOT69c1J7lHzefrPxlqPhrmxKlZFlfJDPspKMqeq83Ws5cw1cw==
X-Received: by 2002:a17:906:415:b0:a58:ec3c:d2fa with SMTP id
 d21-20020a170906041500b00a58ec3cd2famr1830510eja.57.1714750575741; 
 Fri, 03 May 2024 08:36:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a170906c30200b00a55b2f9a2e2sm1811127ejz.105.2024.05.03.08.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:36:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/14] Accel / SH4 / UI patches for 2024-05-03
Date: Fri,  3 May 2024 17:35:59 +0200
Message-ID: <20240503153613.38709-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:

  Merge tag 'accel-20240426' of https://github.com/philmd/qemu into staging (2024-04-26 15:28:13 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-sh4-ui-20240503

for you to fetch changes up to 2d27c91e2b72ac7a65504ac207c89262d92464eb:

  ui/cocoa.m: Drop old macOS-10.12-and-earlier compat ifdefs (2024-05-03 17:33:26 +0200)

----------------------------------------------------------------
- Fix NULL dereference in NVMM & WHPX init_vcpu()
- Move user emulation headers "exec/user" to "user"
- Fix SH-4 ADDV / SUBV opcodes
- Drop Cocoa compatility on macOS <= 10.12
- Update Anthony PERARD email

----------------------------------------------------------------

Anthony PERARD (1):
  MAINTAINERS: Update my email address

Peter Maydell (1):
  ui/cocoa.m: Drop old macOS-10.12-and-earlier compat ifdefs

Philippe Mathieu-Daudé (12):
  accel/nvmm: Fix NULL dereference in nvmm_init_vcpu()
  accel/whpx: Fix NULL dereference in whpx_init_vcpu()
  exec: Include missing license in 'exec/cpu-common.h'
  user: Move 'abitypes.h' from 'exec/user' to 'user'
  user: Move 'thunk.h' from 'exec/user' to 'user'
  coverity: Update user emulation regexp
  plugins/api: Only include 'exec/ram_addr.h' with system emulation
  plugins: Update stale comment
  target/sh4: Fix ADDV opcode
  target/sh4: Fix SUBV opcode
  target/sh4: Rename TCGv variables as manual for ADDV opcode
  target/sh4: Rename TCGv variables as manual for SUBV opcode

 MAINTAINERS                         |  3 +--
 bsd-user/qemu.h                     |  4 ++--
 include/exec/cpu-all.h              |  2 +-
 include/exec/cpu-common.h           |  9 ++++++--
 include/{exec => }/user/abitypes.h  |  4 ++--
 include/user/syscall-trace.h        |  2 +-
 include/{exec => }/user/thunk.h     | 10 ++++++---
 linux-user/qemu.h                   |  2 +-
 linux-user/user-internals.h         |  2 +-
 linux-user/thunk.c                  |  2 +-
 plugins/api.c                       |  2 +-
 plugins/core.c                      |  2 +-
 target/i386/nvmm/nvmm-all.c         |  2 +-
 target/i386/whpx/whpx-all.c         |  2 +-
 target/sh4/translate.c              | 32 ++++++++++++++++++-----------
 tests/tcg/sh4/test-addv.c           | 27 ++++++++++++++++++++++++
 tests/tcg/sh4/test-subv.c           | 30 +++++++++++++++++++++++++++
 scripts/coverity-scan/COMPONENTS.md |  2 +-
 tests/tcg/sh4/Makefile.target       |  6 ++++++
 ui/cocoa.m                          | 13 ------------
 20 files changed, 112 insertions(+), 46 deletions(-)
 rename include/{exec => }/user/abitypes.h (97%)
 rename include/{exec => }/user/thunk.h (97%)
 create mode 100644 tests/tcg/sh4/test-addv.c
 create mode 100644 tests/tcg/sh4/test-subv.c

-- 
2.41.0


