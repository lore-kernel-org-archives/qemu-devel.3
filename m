Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E853CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsSC-0007sY-95; Wed, 06 Mar 2024 09:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS9-0007mK-V9
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:05 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001TI-9F
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:41:04 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5134f830488so2860879e87.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736043; x=1710340843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IYbIZXvWJUe0g9sZHqzUXajgboo5sOG8ohcMURUMfLA=;
 b=igd1PCp114duNeIFQOQjfDGzRV4UCk86r0Ak0RY7LZxJhb+NvsqhGb0MAguSRnK+ic
 fEwET2LC5PhzsMQ4mxm+JJCBvZW5hE7f8WNpbI+eIUpZfT/pedO+Wdipa11Yl44Jl7vf
 qFQ7FyADlxJncrFgUDxmX7kuTmDnDfxXiCw1wqthBPoqz+6KI6jfO2BwlVbn+CjPtbgc
 OWcDJbVX4ICU3Bl4XUpgLXSGSnMqwEYRZuwSMstxukKaCvX+/bmu17TyAMfrZZVqMuf1
 eMr2s8wY78OspebBqi0vgkS+2WMbkjt9QAvobVLFnnNv7r5gUki+4VB2khm1nVmJ+zs0
 FkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736043; x=1710340843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IYbIZXvWJUe0g9sZHqzUXajgboo5sOG8ohcMURUMfLA=;
 b=lAu67UrUyLysx6TvP3lNuJpDRhBbIkE1NKmJGWRnijJAbWb8j0i+km7O7WEr2jt+Hv
 ZH3wsxSJQnfh+MhhoMmmVirXTgSLKj8JpAqqaOpuzxV/Bn3ANUzbDCJUa+kRjP7urWW0
 EVuH8DNnQoGhZznxlc0KFJ/iZwLs+rMs6Y+OBqXx2CF2kPkKp/VeL4KytwHpNc8O2DFo
 vNcI5xg/1rTaKvKMS4JIhdEW9Ag9u3DrdU8+tsWa05yEv+liy5Kk5LGB4uMHJ0D1EfDA
 E/o4l/+DmVEGKOIsDZOsjYTM8v9/TJkFsH2P35FGgLtYCljVINDLq4gtHObGded3AZ0j
 sGQA==
X-Gm-Message-State: AOJu0YyGPvZa8bQAwlFsz93TodVpep3OfVsGKM4SjTmz2e7LIHhwScSc
 5RXcqiqrs2dpEQxbI3phPtx8+5TsMfAx6INFb4Z3/iRRxT+qM+bYtxmULp8kYpo3i7QJslnTbvc
 f
X-Google-Smtp-Source: AGHT+IEDdq0IlSpMchrNAJq3ThCj3AqU8AUa5PbtlNJyAql3kuf68RSAsp0i5Szq5AP0Gqd2GCT9Pg==
X-Received: by 2002:a19:910f:0:b0:512:d5e4:1aa4 with SMTP id
 t15-20020a19910f000000b00512d5e41aa4mr3457324lfd.60.1709736042629; 
 Wed, 06 Mar 2024 06:40:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b00412f02bff2csm3783373wmq.37.2024.03.06.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8EAF15F891;
 Wed,  6 Mar 2024 14:40:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 9.0 00/29] maintainer updates (tests, gdbstub, plugins)
Date: Wed,  6 Mar 2024 14:40:12 +0000
Message-Id: <20240306144041.3787188-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

The following changes since commit db596ae19040574e41d086e78469014191d7d7fc:

  Merge tag 'pull-target-arm-20240305' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-03-05 13:54:54 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-updates-060324-1

for you to fetch changes up to db7e8b1f75662cf957f6bfad938ed112488518ed:

  target/riscv: honour show_opcodes when disassembling (2024-03-06 12:35:51 +0000)

----------------------------------------------------------------
maintainer updates (tests, gdbstub, plugins):

  - expand QOS_PATH_MAX_ELEMENT_SIZE to avoid LTO issues
  - support fork-follow-mode in gdbstub
  - new thread-safe scoreboard API for TCG plugins
  - suppress showing opcodes in plugin disassembly

----------------------------------------------------------------
Alex Bennée (5):
      tests: bump QOS_PATH_MAX_ELEMENT_SIZE again
      disas: introduce show_opcodes
      disas/hppa: honour show_opcodes
      target/loongarch: honour show_opcodes when disassembling
      target/riscv: honour show_opcodes when disassembling

Ilya Leoshkevich (12):
      gdbstub: Support disablement in a multi-threaded process
      {linux,bsd}-user: Introduce get_task_state()
      {linux,bsd}-user: Update ts_tid after fork()
      gdbstub: Introduce gdbserver_fork_start()
      {linux,bsd}-user: Pass pid to fork_end()
      {linux,bsd}-user: Pass pid to gdbserver_fork()
      gdbstub: Call gdbserver_fork() both in parent and in child
      gdbstub: Introduce gdb_handle_query_supported_user()
      gdbstub: Introduce gdb_handle_set_thread_user()
      gdbstub: Introduce gdb_handle_detach_user()
      gdbstub: Implement follow-fork-mode child
      tests/tcg: Add two follow-fork-mode tests

Pierrick Bouvier (12):
      plugins: scoreboard API
      plugins: define qemu_plugin_u64
      plugins: implement inline operation relative to cpu_index
      plugins: add inline operation per vcpu
      tests/plugin: add test plugin for inline operations
      tests/plugin/mem: migrate to new per_vcpu API
      tests/plugin/insn: migrate to new per_vcpu API
      tests/plugin/bb: migrate to new per_vcpu API
      contrib/plugins/hotblocks: migrate to new per_vcpu API
      contrib/plugins/howvec: migrate to new per_vcpu API
      plugins: remove non per_vcpu inline operation from API
      plugins: cleanup codepath for previous inline operation

 bsd-user/bsd-file.h                                |   2 +-
 bsd-user/freebsd/os-proc.h                         |   6 +-
 bsd-user/qemu.h                                    |   7 +-
 gdbstub/internals.h                                |   3 +
 include/disas/dis-asm.h                            |   8 +
 include/gdbstub/user.h                             |  10 +-
 include/qemu/plugin.h                              |   7 +
 include/qemu/qemu-plugin.h                         | 142 +++++++++---
 include/user/safe-syscall.h                        |   2 +-
 linux-user/m68k/target_cpu.h                       |   2 +-
 linux-user/qemu.h                                  |   5 +
 linux-user/signal-common.h                         |   2 +-
 linux-user/user-internals.h                        |   2 +-
 plugins/plugin.h                                   |  17 +-
 tests/qtest/libqos/qgraph.h                        |   2 +-
 accel/tcg/plugin-gen.c                             |  69 +++++-
 bsd-user/main.c                                    |   9 +-
 bsd-user/signal.c                                  |  20 +-
 contrib/plugins/hotblocks.c                        |  50 +++--
 contrib/plugins/howvec.c                           |  53 +++--
 disas/disas.c                                      |   1 +
 disas/hppa.c                                       |   8 +-
 disas/riscv.c                                      |  28 +--
 gdbstub/gdbstub.c                                  |  29 ++-
 gdbstub/user-target.c                              |   4 +-
 gdbstub/user.c                                     | 244 ++++++++++++++++++++-
 linux-user/aarch64/cpu_loop.c                      |   2 +-
 linux-user/arm/cpu_loop.c                          |   4 +-
 linux-user/arm/signal.c                            |   2 +-
 linux-user/cris/cpu_loop.c                         |   2 +-
 linux-user/elfload.c                               |   2 +-
 linux-user/hppa/signal.c                           |   2 +-
 linux-user/linuxload.c                             |   2 +-
 linux-user/m68k/cpu_loop.c                         |   2 +-
 linux-user/main.c                                  |   8 +-
 linux-user/mips/cpu_loop.c                         |   2 +-
 linux-user/ppc/signal.c                            |   4 +-
 linux-user/riscv/cpu_loop.c                        |   2 +-
 linux-user/signal.c                                |  30 +--
 linux-user/syscall.c                               |  32 +--
 linux-user/vm86.c                                  |  18 +-
 linux-user/xtensa/signal.c                         |   2 +-
 plugins/api.c                                      | 100 +++++++--
 plugins/core.c                                     |  79 ++++++-
 semihosting/arm-compat-semi.c                      |   8 +-
 target/loongarch/disas.c                           |  13 +-
 tests/plugin/bb.c                                  |  63 +++---
 tests/plugin/inline.c                              | 186 ++++++++++++++++
 tests/plugin/insn.c                                | 106 +++++----
 tests/plugin/mem.c                                 |  46 ++--
 tests/tcg/multiarch/follow-fork-mode.c             |  56 +++++
 plugins/qemu-plugins.symbols                       |  13 +-
 tests/plugin/meson.build                           |   2 +-
 tests/tcg/Makefile.target                          |   2 +-
 tests/tcg/multiarch/Makefile.target                |  17 +-
 .../multiarch/gdbstub/follow-fork-mode-child.py    |  40 ++++
 .../multiarch/gdbstub/follow-fork-mode-parent.py   |  16 ++
 57 files changed, 1257 insertions(+), 338 deletions(-)
 create mode 100644 tests/plugin/inline.c
 create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

-- 
2.39.2


