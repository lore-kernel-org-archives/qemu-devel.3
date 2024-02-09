Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1A4C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWqc-0005Un-G3; Fri, 09 Feb 2024 14:47:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqa-0005Tp-GN
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqX-0005AT-7O
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41068e36cbbso8141825e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508055; x=1708112855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MI0FV4zTV6KOSfESsR93dH7doZBmSs4rrH/2nYVPQD8=;
 b=u9cM0mGA9tTAzvjg9ldEX8mrdDfKMl82eNbLVMQ1ck2t6813sZjjp2Z+GcUzrgRW+f
 vdD6iF6SJXz3IpzeWh7QQKnphhGkUbTr4JsUXAvolwDF7fzOQvBlo/VSPDQG2yXyaSbe
 maFLezgDJqXfZJPQAZT63sG84QoxJ4I2TR6O7X+37Xl1QF4aBHw6PMexzEqS49FCEw6v
 PKdsOqBeJOYI/PCdK0OCtWsSy2E0ossWesYyZ85nUntpM6Bxh1ImygWnMCwFJaqsGNch
 R5A0FZB78N31YX6wGw8WNsfi/2lodwUa9s38dY3HPBpIN5He2ify6RCAXPZfPIz+9798
 QdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508055; x=1708112855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MI0FV4zTV6KOSfESsR93dH7doZBmSs4rrH/2nYVPQD8=;
 b=pkErD77/Pql2E4yrgGowF3lj2Enm463A5ByFrSgAVxIJOC+Z39+v2Oo1CEHhgFP4R7
 1pkAtjFuW5QgO3YJmFB7i2Qhd1//Z4LCbi8xAlIV7lRLKT9LVTN4F0guGtTelQctfCNF
 8x3txUOJFgz/BPbDkL8bLPupYVs+dQJscxUxNSBUgohbxsfZ9vMZ9on8hbRv44/p37nT
 AieWkbjahzPQameZveaTVDzH4C1B2z9IlPKzZtS+85ESA7dxHeHQ576XHAex10IU1oDv
 9CHBFq4kZRtXxp3yQAJgzeON9g7RPNkpuUxsL6D/LAVD5g+ZqriLsJ29ezC4Wn4nfz9e
 VyvA==
X-Gm-Message-State: AOJu0YysMEf6XPGdqgfjAy/xYriKfUu4AE8x+apFZywoBGxnxpJvNiFH
 qxXF+y8IlIqrmay4EUvYb22o2Ltb66rV8E9hjnkQE2vQ8/XXidTa/zA0n4Q/j04PnD+oLM0cqvG
 e
X-Google-Smtp-Source: AGHT+IEA41+kxmiFM702lD51yz2oX9wwsvege+V+5vbPvQsxLIHEgaAA+IA16yp0GJRCC6mCPX8ReA==
X-Received: by 2002:a05:600c:c11:b0:40e:fc29:f52f with SMTP id
 fm17-20020a05600c0c1100b0040efc29f52fmr220243wmb.21.1707508055331; 
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c210f00b0040fe4b733f4sm1472758wml.26.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A71805F7D7;
 Fri,  9 Feb 2024 19:47:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/10] testing, doc and gdbstub updates
Date: Fri,  9 Feb 2024 19:47:24 +0000
Message-Id: <20240209194734.3424785-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa0296c:

  Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-09 11:22:20 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-updates-090224-1

for you to fetch changes up to 86b75667e04b49a0b75f061f589b3fbec3fb78f1:

  tests/tcg: Add the syscall catchpoint gdbstub test (2024-02-09 17:52:40 +0000)

----------------------------------------------------------------
testing, doc and gdbstub updates:

  - add sqlite3 to openSUSE image
  - mark CRIS as deprecated
  - re-enable the TCG plugin tests
  - use select for semihosting
  - implement syscall catching in gdbstub

----------------------------------------------------------------
Alex Bennée (2):
      docs: mark CRIS support as deprecated
      Revert "hw/elf_ops: Ignore loadable segments with zero size"

Fabiano Rosas (1):
      tests/docker: Add sqlite3 module to openSUSE Leap container

Ilya Leoshkevich (5):
      gdbstub: Expose TARGET_SIGTRAP in a target-agnostic way
      gdbstub: Allow specifying a reason in stop packets
      gdbstub: Add syscall entry/return hooks
      gdbstub: Implement catching syscalls
      tests/tcg: Add the syscall catchpoint gdbstub test

Paolo Bonzini (2):
      configure: run plugin TCG tests again
      kconfig: use "select" to enable semihosting

 docs/about/deprecated.rst                     |   7 ++
 configure                                     |   3 +
 configs/devices/m68k-softmmu/default.mak      |   2 -
 configs/devices/mips-softmmu/common.mak       |   3 -
 configs/devices/nios2-softmmu/default.mak     |   2 -
 configs/devices/riscv32-softmmu/default.mak   |   2 -
 configs/devices/riscv64-softmmu/default.mak   |   2 -
 configs/devices/xtensa-softmmu/default.mak    |   2 -
 gdbstub/internals.h                           |   2 +
 include/gdbstub/user.h                        |  29 ++++++-
 include/hw/elf_ops.h                          |  75 +++++++++----------
 include/user/syscall-trace.h                  |   7 +-
 gdbstub/gdbstub.c                             |   9 +++
 gdbstub/user-target.c                         |   5 ++
 gdbstub/user.c                                | 104 +++++++++++++++++++++++++-
 tests/tcg/multiarch/catch-syscalls.c          |  51 +++++++++++++
 target/m68k/Kconfig                           |   1 +
 target/mips/Kconfig                           |   1 +
 target/nios2/Kconfig                          |   1 +
 target/riscv/Kconfig                          |   2 +
 target/xtensa/Kconfig                         |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker |   1 +
 tests/lcitool/mappings.yml                    |   4 +
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/tcg/multiarch/Makefile.target           |  10 ++-
 tests/tcg/multiarch/gdbstub/catch-syscalls.py |  53 +++++++++++++
 26 files changed, 322 insertions(+), 58 deletions(-)
 create mode 100644 tests/tcg/multiarch/catch-syscalls.c
 create mode 100644 tests/tcg/multiarch/gdbstub/catch-syscalls.py

-- 
2.39.2


