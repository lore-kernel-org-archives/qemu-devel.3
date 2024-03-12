Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366D9C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0GX-0002yX-9M; Tue, 12 Mar 2024 07:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GV-0002xb-9m
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GF-0000gm-UY
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33e570ef661so2872833f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242734; x=1710847534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mwfMGz7gvLHDv221s3e96BTTG/gLrNS+foMF6hO2JQQ=;
 b=sOxYKFBJGtvUsR2glCsdJPZO1m2MdhkBpkMI1on0wgw0+XV0bhH6K5xSa1AnAFN1ZO
 M92EBd9YKkEfUR6zxKUDedZD3MIIIVK8pq4+rGEedfuGeLv827tJ/Vgdin7Tj6vDKFQf
 xvBbw+BJRAtuhhX04xSKn1T/c/zxqVPjp51foa/aEOrbmCS27SWbjaYGEFgI0dDc4J41
 Yyodf0VgT2tq76b2gDzycGbqH6XpBfbcuN9a/MeBm5xaiN3K5dfbOC24vXFnDKxzYVdi
 HL+LfVX/05ExD8mzutZWmhRRonHOLiHSNXq3MF50vsdY7mzNrSihZXTbWorIguJTfH1A
 zxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242734; x=1710847534;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwfMGz7gvLHDv221s3e96BTTG/gLrNS+foMF6hO2JQQ=;
 b=eTmerZV5qTWdqEjfqtQz4ZWth+iZMAhlguomXLJN7Sw+fiW6FaP1MekaloEnomOErB
 /Ch9XZMjDe0icGC6UPXM7TMVs9uv5nDnPoku5Rk490PbZFaHrJPomSBS4eprSWsUFSpA
 nMGLP09jwVZ+7CHdpWbMmzI0vIxeUySV961IAJa4E1zxiSROBWVBea5kWFlb2NEhfgAZ
 REIVZ7RmjjMPxDjy7IyrYU06SQcm1m80zPowqmkQKL80dXp8oTfTiroBQoHl5rkkVl6C
 MhEjwYw4ZbqqMcl23zzvU4upGUTee/iFrUbnXvabZkZoty/LHKZy50WzQB9d3AVENxDL
 TeXw==
X-Gm-Message-State: AOJu0Yx99TQUe2MlfXPUZwGT0cyKe5tHeHfQt7d2KVoP0cK62aIGdTF7
 ev+uUtSkC798NRuWCdb53WcsGLzZIHLpbfmv9c2oWfEMLb+aT9+J/fcYJ44LCo/0rPP20QU0VDk
 e
X-Google-Smtp-Source: AGHT+IFVcH+AYKCkdT4Fmlj2/5LpIUT+Aq/uJmmvL4oqNTpkO+rEOJAHVokfr2POyuTUOxk/gnha+A==
X-Received: by 2002:adf:a499:0:b0:33d:fd3c:7b87 with SMTP id
 g25-20020adfa499000000b0033dfd3c7b87mr2242519wrb.23.1710242733730; 
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b3-20020a05600003c300b0033e3cb02cefsm9095330wrg.86.2024.03.12.04.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9712E5F88A;
 Tue, 12 Mar 2024 11:25:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 9.0 0/8] final maintainer updates (testing, gdbstub)
Date: Tue, 12 Mar 2024 11:25:24 +0000
Message-Id: <20240312112532.1558319-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-final-120324-1

for you to fetch changes up to 0532045e8112c13a8a949e696576672e64c6fa14:

  gdbstub: Fix double close() of the follow-fork-mode socket (2024-03-12 10:48:35 +0000)

----------------------------------------------------------------
final updates for 9.0 (testing, gdbstub):

  - avoid transferring pointless git data
  - fix the over rebuilding of test VMs
  - support Xfer:siginfo:read in gdbstub
  - fix double close() in gdbstub

----------------------------------------------------------------
Alex Bennée (2):
      gitlab: aggressively avoid extra GIT data
      tests/vm: ensure we build everything by default

Gustavo Romero (5):
      gdbstub: Rename back gdb_handlesig
      linux-user: Move tswap_siginfo out of target code
      gdbstub: Save target's siginfo
      gdbstub: Add Xfer:siginfo:read stub
      tests/tcg: Add multiarch test for Xfer:siginfo:read stub

Ilya Leoshkevich (1):
      gdbstub: Fix double close() of the follow-fork-mode socket

 gdbstub/internals.h                                |  1 +
 include/gdbstub/user.h                             | 19 +++------
 linux-user/signal-common.h                         |  2 -
 bsd-user/main.c                                    |  2 +-
 bsd-user/signal.c                                  |  5 ++-
 gdbstub/gdbstub.c                                  |  8 ++++
 gdbstub/user.c                                     | 49 +++++++++++++++++++---
 linux-user/aarch64/signal.c                        |  2 +-
 linux-user/alpha/signal.c                          |  2 +-
 linux-user/arm/signal.c                            |  2 +-
 linux-user/hexagon/signal.c                        |  2 +-
 linux-user/hppa/signal.c                           |  2 +-
 linux-user/i386/signal.c                           |  6 +--
 linux-user/loongarch64/signal.c                    |  2 +-
 linux-user/m68k/signal.c                           |  4 +-
 linux-user/main.c                                  |  2 +-
 linux-user/microblaze/signal.c                     |  2 +-
 linux-user/mips/signal.c                           |  4 +-
 linux-user/nios2/signal.c                          |  2 +-
 linux-user/openrisc/signal.c                       |  2 +-
 linux-user/ppc/signal.c                            |  4 +-
 linux-user/riscv/signal.c                          |  2 +-
 linux-user/s390x/signal.c                          |  2 +-
 linux-user/sh4/signal.c                            |  2 +-
 linux-user/signal.c                                | 15 +++++--
 linux-user/sparc/signal.c                          |  2 +-
 linux-user/xtensa/signal.c                         |  2 +-
 tests/tcg/multiarch/segfault.c                     | 14 +++++++
 .gitlab-ci.d/base.yml                              |  4 ++
 .gitlab-ci.d/buildtest-template.yml                |  1 +
 .gitlab-ci.d/buildtest.yml                         |  2 +
 .gitlab-ci.d/windows.yml                           |  2 +
 tests/tcg/multiarch/Makefile.target                | 10 ++++-
 .../multiarch/gdbstub/test-qxfer-siginfo-read.py   | 26 ++++++++++++
 tests/vm/basevm.py                                 |  2 +-
 35 files changed, 158 insertions(+), 52 deletions(-)
 create mode 100644 tests/tcg/multiarch/segfault.c
 create mode 100644 tests/tcg/multiarch/gdbstub/test-qxfer-siginfo-read.py

-- 
2.39.2


