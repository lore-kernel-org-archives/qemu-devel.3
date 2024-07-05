Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94212C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPktx-0005ej-AU; Fri, 05 Jul 2024 11:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkts-0005br-6u
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:04 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktm-0000Iq-Fn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:02 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab63so2894938a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193455; x=1720798255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XcVl3CIIpd3/oWqZ945JO7NG19KHhnzTp2iMdNtb86Y=;
 b=EsjzvDbBhMPAJFQSdnNDlrtMxrR6Kt5xDBEe2oCQZRayCYX7/9h++19Vi6ILthb6i8
 XVlUOAk3k5voJyPe6/VWzR8Uz06x5wdlnSXD2Q+RXseM7T3KXs0FMGWNXITKXDh1+Jlp
 4ZB2j070TVIi16kVBkivCG/h5/cdiAL613Bl7voZUcyq/Nv01M79W0X9+h6jv2WUD8h5
 05bMi9RdrepzlpHkmkUw60LT+vdqJfxPsCx8ckMCqDZXym1SAd6Tu3A4H9XdBkuGgbKe
 o3tYIt9eX/GZn8CzQgqybsMzSO4vy5mpjc1vDaLRN2NXNTzKXpm3DYDBDc3TqBtwwX91
 lkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193455; x=1720798255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XcVl3CIIpd3/oWqZ945JO7NG19KHhnzTp2iMdNtb86Y=;
 b=HVpyeSggTblNvUmKyAmk6xFU8HMUZW95jObXefR1FzpCExdXrRenL5yCT4kU82A3P2
 Jmufh/40nbZkaHzO3272C8FPNfAkr1ml/1CqoJWIndekLr09xiQ/U2bBWA6rWFUabgst
 eB6zGqoWaTuyosH+jEaF7nTo4f2U8JwyoJlRK/DqAwx14uQHfzREs/yEztHsKqMshf41
 kCiWOeGT/4EFEBVk5T6tD5bbv9YJwfNzyR31k1ySjoDU6sWV9rEiL6vbrNsS3MZSH6JU
 3LjZO5OjrV5+AzPXARMsh45ztCuWYd+xWeh+fg99A37zjHF6wuYru42WcQ52E2iAvdP1
 Mtkg==
X-Gm-Message-State: AOJu0Yz3PKrT7QCoGQi+8vn4oebZMIfbB9JG3SgWo2hfkPb9HKuBqIUc
 qyHWE++Prw+QIydbxXpPn1A2Khr7ROQkEP7l9GFCQssNIbsl9Z9OCnFuBh4g3ysg3ejd6AM7q2w
 m
X-Google-Smtp-Source: AGHT+IE6jtA93kLbkUS0hopSdwC3p9MjSSUY2otR7Qs+ts0nrTtYKKa8oIEy8fvBmn2LUp7PROJDQQ==
X-Received: by 2002:a17:906:1cdb:b0:a77:cf09:9c72 with SMTP id
 a640c23a62f3a-a77cf099d03mr135344566b.38.1720193455384; 
 Fri, 05 Jul 2024 08:30:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72b033f3a3sm662295466b.187.2024.07.05.08.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0CB285F876;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/40] maintainer updates for testing, plugins and gdbstub
Date: Fri,  5 Jul 2024 16:30:12 +0100
Message-Id: <20240705153052.1219696-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

The following changes since commit 5915139aba1646220630596de30c673528e047c9:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-07-04 09:16:07 -0700)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-july24-050724-1

for you to fetch changes up to 340ca46b681b1e9cac1643a7fd964947aeb68a56:

  tests/tcg/aarch64: Add MTE gdbstub tests (2024-07-05 12:35:36 +0100)

----------------------------------------------------------------
Updates for testing, plugins, gdbstub

  - restore some 32 bit host builds and testing
  - move some physmem tracepoint definitions
  - use --userns keep-id for podman builds
  - cleanup check-tcg compiler flag checking for Arm
  - fix some casting in fcvt test
  - tweak check-tcg inline asm for clang
  - suppress some invalid clang warnings
  - disable KVM for the TCI builds
  - improve the insn tracking plugin
  - cleanups to the lockstep plugin
  - free plugin data on cpu finalise
  - assert cpu->index assigned
  - move qemu_plugin_vcpu_init__async into plugin code
  - add support for dynamic gdb command tables
  - allow targets to extend gdb capabilities
  - enable user-mode MTE support

----------------------------------------------------------------
Akihiko Odaki (6):
      tests/docker: Specify --userns keep-id for Podman
      tests/tcg/aarch64: Explicitly specify register width
      tests/tcg/aarch64: Fix irg operand type
      tests/tcg/aarch64: Do not use x constraint
      tests/tcg/arm: Fix fcvt result messages
      tests/tcg/arm: Manually register allocate half-precision numbers

Alex Bennée (11):
      tests/lcitool: fix debian-i686-cross toolchain prefix
      testing: restore some testing for i686
      tracepoints: move physmem trace points
      hw/core: ensure kernel_end never gets used undefined
      gitlab: don't bother with KVM for TCI builds
      test/plugin: make insn plugin less noisy by default
      test/plugins: preserve the instruction record over translations
      plugins/lockstep: preserve sock_path
      plugins/lockstep: make mixed-mode safe
      plugins/lockstep: mention the one-insn-per-tb option
      plugins/lockstep: clean-up output

Gustavo Romero (11):
      gdbstub: Clean up process_string_cmd
      gdbstub: Move GdbCmdParseEntry into a new header file
      gdbstub: Add support for target-specific stubs
      target/arm: Fix exception case in allocation_tag_mem_probe
      target/arm: Make some MTE helpers widely available
      target/arm: Factor out code for setting MTE TCF0 field
      gdbstub: Make hex conversion function non-internal
      gdbstub: Pass CPU context to command handler
      gdbstub: Use true to set cmd_startswith
      gdbstub: Add support for MTE in user mode
      tests/tcg/aarch64: Add MTE gdbstub tests

Philippe Mathieu-Daudé (3):
      plugins: Ensure vCPU index is assigned in init/exit hooks
      plugins: Free CPUPluginState before destroying vCPU state
      accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/

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

 configure                                         |   4 +
 configs/targets/aarch64-linux-user.mak            |   2 +-
 gdbstub/internals.h                               |  23 -
 include/gdbstub/commands.h                        | 103 ++++
 include/qemu/plugin.h                             |   3 +
 linux-user/aarch64/mte_user_helper.h              |  32 ++
 linux-user/aarch64/target_prctl.h                 |  22 +-
 target/arm/internals.h                            |   6 +
 target/arm/tcg/mte_helper.h                       |  66 +++
 contrib/plugins/lockstep.c                        |  23 +-
 gdbstub/gdbstub.c                                 | 341 +++++++-----
 gdbstub/syscalls.c                                |   7 +-
 gdbstub/system.c                                  |   7 +-
 gdbstub/user-target.c                             |  25 +-
 gdbstub/user.c                                    |   7 +-
 hw/core/cpu-common.c                              |  14 +-
 hw/core/loader-fit.c                              |   2 +-
 linux-user/aarch64/mte_user_helper.c              |  35 ++
 linux-user/main.c                                 |   1 +
 linux-user/syscall.c                              |   9 -
 plugins/core.c                                    |  10 +-
 system/physmem.c                                  |   4 +-
 target/arm/cpu.c                                  |   1 +
 target/arm/gdbstub.c                              |  46 ++
 target/arm/gdbstub64.c                            | 223 ++++++++
 target/arm/tcg/mte_helper.c                       |  48 +-
 tests/plugin/insn.c                               | 112 +++-
 tests/tcg/aarch64/bti-1.c                         |   6 +-
 tests/tcg/aarch64/bti-3.c                         |   6 +-
 tests/tcg/aarch64/mte-1.c                         |   2 +-
 tests/tcg/aarch64/mte-8.c                         |  99 ++++
 tests/tcg/arm/fcvt.c                              |  28 +-
 tests/tcg/minilib/printf.c                        |   2 +-
 .gitlab-ci.d/buildtest.yml                        |   2 +-
 .gitlab-ci.d/crossbuilds.yml                      |  13 +-
 gdb-xml/aarch64-mte.xml                           |  11 +
 linux-user/aarch64/meson.build                    |   2 +
 system/trace-events                               |   6 +
 tests/docker/Makefile.include                     |   7 +-
 tests/docker/dockerfiles/debian-i686-cross.docker |   2 +-
 tests/lcitool/refresh                             |   2 +-
 tests/tcg/Makefile.target                         |   2 +-
 tests/tcg/aarch64/Makefile.softmmu-target         |   4 +-
 tests/tcg/aarch64/Makefile.target                 |  32 +-
 tests/tcg/aarch64/fcvt.ref                        | 604 +++++++++++-----------
 tests/tcg/aarch64/gdbstub/test-mte.py             |  86 +++
 tests/tcg/arm/Makefile.softmmu-target             |   4 +-
 tests/tcg/arm/Makefile.target                     |  12 +-
 tests/tcg/arm/fcvt.ref                            | 604 +++++++++++-----------
 trace-events                                      |   5 -
 50 files changed, 1771 insertions(+), 946 deletions(-)
 create mode 100644 include/gdbstub/commands.h
 create mode 100644 linux-user/aarch64/mte_user_helper.h
 create mode 100644 target/arm/tcg/mte_helper.h
 create mode 100644 linux-user/aarch64/mte_user_helper.c
 create mode 100644 tests/tcg/aarch64/mte-8.c
 create mode 100644 gdb-xml/aarch64-mte.xml
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py

-- 
2.39.2


