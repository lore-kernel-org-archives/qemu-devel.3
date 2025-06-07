Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC670C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 15:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNviZ-0006NK-Q4; Sat, 07 Jun 2025 11:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNviY-0006Lj-SR
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 11:44:22 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNviX-0007HE-21
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 11:44:22 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so5748504a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749311058; x=1749915858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=awUk7VHW441ttOgOO2rNu2sbd3lzhXNGbbsQWfUwbtw=;
 b=O/BtHzIV7LWalB0Wie69p6Ifzxos2+TuF1oBdIBkNtr/Q0XnrpZggjxEnNMEyD0EQU
 JktpIoaUm0hwb7/XtKcSpIiBgV1jgu/eSAhv9N5Oy6sylpGOxjqreNHlwwnlL2u7gbOG
 ZWz5b0fx/jxcqCFCqDTApmAUBDqz+ruythfPUN/fUal4dMEzbTLXNedfzTv9FOztDsqk
 sJtVzihDrs7XJ5MsFxWpsznbvSGIAQnu6TOOcTQ3DXYJQCBixT7wCSEtWvv9Uu57sCMa
 quleCxMGpNflY/UZeYkQcEVvNxCR9zhzn7eh6NNWWv/G6/1CIRKhT0+cSeTOHWjR1UFm
 42aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749311058; x=1749915858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=awUk7VHW441ttOgOO2rNu2sbd3lzhXNGbbsQWfUwbtw=;
 b=Q3kRbl2c4om88tjkBASm9GU0t5iwKWNq2gy/WEdhuPNam65ln8Lr/HFyFVBKIaqb0o
 uedAN//ggRofsvr1Yif3c3NM7iuDxu8TCb9T7vRTHlEquTkd3XEw8XOoSb1AnCCIc9CY
 7VNhoNvYhfmrnaKMzbLmkhO5lj2YQw1r15Qi1/OLFniwp3dwS3qNuyyuWJf4O0xRE+9C
 PvXPE+v4pMTGBZBSoLuP/kDYGMrOSITi1OkvcAyrE2/PYkXmzooQ5e1j6WMaaJ32sAwW
 lS4XiXtpsBSKPXgSk5v4+Y0BKaY+FD7zwrgI0s9xYLYxSGoILa7AAdGBiVi/tljEU3qC
 HPkA==
X-Gm-Message-State: AOJu0YzExlJcLdUQSVxSv8fpPmzYkpEwA4kBm3KvQ6IkCbxN6P8BudIS
 tHpQ75pj27JmlNyfjrbzRx7nKfXB3CkgcbzS61cTuOVzNs+B80ZewtFhd3bptLeK0/sZFJxo2vh
 LYeaVGE0=
X-Gm-Gg: ASbGnctM4/sETRaJtO0PYs4YhgcKUGDhXJ97OJCaJhhC1G51q77VtFX0fSGM/qcK5Qa
 sr3WEZaIexot4CBjTYfeB/dutHaEKt3rM+xbMV2dDv22S0TV9pNn/LBgk7+pQqhZInLkrjMacue
 6qf8JAzjwMAMLhFj/o7km/o0c4TGMHRSUFvEUHssWmKGPM2P4jRzMualglDRJ7dL1Z3K6rLYNh1
 AuO6DTuqyuD91uPLNqUn2JpvAYUPm4EOQSkB7hhwBcPOTfhsHbNXfniviq1hJUGm2Tx3H4FiKKh
 4i35yu9odjg6kX1EiqvkVFUY2MAUq5V1adpBBS+YCvOJqTv6UawlCONy9yIWtO4=
X-Google-Smtp-Source: AGHT+IHKFF139SsqPelNmu8ESbEV4qVoRWK/pBvaEAyZYmeVIOhutWPH7v07NlyEr1UM/9un1d+1hA==
X-Received: by 2002:a17:907:3f23:b0:ad5:27f5:717c with SMTP id
 a640c23a62f3a-ade1a8da3b0mr652671966b.10.1749311047301; 
 Sat, 07 Jun 2025 08:44:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d753abfsm295417066b.19.2025.06.07.08.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 08:44:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0228D5F86B;
 Sat, 07 Jun 2025 16:44:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/11] maintainer updates for May (testing, plugins)
Date: Sat,  7 Jun 2025 16:44:04 +0100
Message-ID: <20250607154404.3810570-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 96215036f47403438c7c7869b7cd419bd7a11f82:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-06-06 09:42:59 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.1-maintainer-may-2025-070625-1

for you to fetch changes up to 63070ce368e1a2d430b9022a9db46f1817628efc:

  gdbstub: update aarch64-core.xml (2025-06-07 16:40:44 +0100)

----------------------------------------------------------------
maintainer updates for May (testing, plugins)

  - expose ~/.cache/qemu to container builds
  - disable debug info in CI
  - allow boot.S to handle target el mode selection
  - new arguments for ips plugin
  - cleanup assets in size_memop
  - fix include guard in gdbstub
  - introduce qGDBServerVersion gdbstub query
  - update gdb aarch64-core.xml to support bitfields

----------------------------------------------------------------
Alex Bennée (8):
      tests/docker: expose $HOME/.cache/qemu as docker volume
      gitlab: disable debug info on CI builds
      tests/tcg: make aarch64 boot.S handle different starting modes
      contrib/plugins: add a scaling factor to the ips arg
      contrib/plugins: allow setting of instructions per quantum
      include/exec: fix assert in size_memop
      include/gdbstub: fix include guard in commands.h
      gdbstub: assert earlier in handle_read_all_regs

Dominik 'Disconnect3d' Czarnota (1):
      gdbstub: Implement qGDBServerVersion packet

Manos Pitsidianakis (1):
      gdbstub: update aarch64-core.xml

Nabih Estefan (1):
      tests/qtest: Avoid unaligned access in IGB test

 docs/about/emulation.rst                  |   4 +
 include/exec/memop.h                      |   4 +-
 include/gdbstub/commands.h                |   2 +-
 contrib/plugins/ips.c                     |  49 ++++++++-
 gdbstub/gdbstub.c                         |  19 +++-
 tests/qtest/libqos/igb.c                  |   4 +-
 .gitlab-ci.d/buildtest-template.yml       |   1 +
 gdb-xml/aarch64-core.xml                  |  52 ++++++++-
 tests/docker/Makefile.include             |  10 +-
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 172 +++++++++++++++++++++++++++++-
 11 files changed, 300 insertions(+), 20 deletions(-)

-- 
2.47.2


