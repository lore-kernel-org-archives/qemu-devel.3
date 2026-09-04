Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE2AC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2VWt-0002OD-Pg; Fri, 04 Sep 2026 11:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2VWr-0002Nb-RU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:08:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2VWo-0001f5-Fq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 11:08:33 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49b0dbfbf7bso8655545e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788534508; x=1789139308; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0CNC2kNa/O3lZn614rXJHDgI2122AUVb6foOrhMrU0Y=;
 b=KUJohK98djtwRRXn8BG25aDazBHemQd2y5dU5q6DU2dDgYezITokvTDxI4UsFCIfAi
 JPfjqoMNH+orkGT/ElZdLc9ZnXpsjLcCRnnu9dszYdBr+9HhBB9w7ImC8ZepNN7ecZ3c
 BO1SDUfiOzxWf79Gbk5ULfinNtxpmy65Ut6/XKA69hNIF3ZBYp+wKJvnZbt5UE2FAxBB
 tFwW49kxwoJG1ayiYb/dYORMBNODLmrwFqxOQ/jFkZbkEXazpQCWIBUHDVfYrjd3dWD7
 z8YNZER+v9loF+b1ZAh+4wg3ZZbWitvx8b/RvqFefVF/AGxoezef7XwiOjhzHpCdeXq4
 wKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788534508; x=1789139308;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0CNC2kNa/O3lZn614rXJHDgI2122AUVb6foOrhMrU0Y=;
 b=WA8KbNzjkH6U31vZEio3UBMWig9XmqRHuXb7Z9NIXy7YRmJ0X2bopff2FdSWwMlAs1
 jBMsr7buN7mob7QlBoSLlmkoEqDRuCmeWF3FzezGaKA486133r12ge48OpYvpex/Atby
 PlQP1kTGq/Amh53l3bzEeAUTnBW/uNodUOSLoaB12KsrH+nQ+VFQRXCwQrQS7X9A1bDV
 zhL+bWEU+ZSZ3ZpPJoDHVFiLiuTWgSrPqO96wcWu6UvHqF6ZH0maEuPeJYNTVF+UEQ5i
 fvov6sXzrxXNm91afdYtMz95jmwWBSqiWzosDCjQJcODobJnj4Z1hu4zGAWv7AON0w4X
 qtAg==
X-Gm-Message-State: AFuF++lB9z0gjL9ly2hhXgWj8dQ7kudJEjTUaCAqZ4/uTURIcnacrFJN
 L+ToGvxS18s5YziqAp4NN/1q/CWIC04WJy/mjOxrRNLUGl3ycxk4THTnOacJMNTVgUIFa7SPZn2
 9htX+XcU=
X-Gm-Gg: AYBFou1ZMRElH9PV/EiJ567Xn46R9tqiw2zWcShs6Dznh5WbwJPlP/DLVj4ogsuOZq8
 f14KxpwD4AuTnXYVILBGPrnZLDvmGR6mDyXkI/WC9FGRFGjv6bsf3KCt/Qc71/5YhL4vl+BHz0L
 BBY/Yhgz79L/eBNOAq9piT8cpLCYtXT1n/Ea6WIqvtXY4LRXnzRWY3M68TcR6ddtmiDUK+LWzq7
 xPyYGBgNdKHZkZTFGKUr2St6N2/le9Anxd9danrcTya21GaVldMZn64KG6AOw5lUDB3HusIuDil
 bilVpAOnto5ZNCtQ3rRAEeVFJktE4jSYec+iSUi7kmW+hU5eEEg6g8ckpaQiX993z4zhlXbX3K4
 T/qBS+PHmY2zGrI6H9QfNMM2ufsLF95VBMHFU+mpUyuSqLtfFrsOq9q78pLyjA8rhTnYXLsAHc4
 vxIujFtcO4VBd3cGwuhI5OS8URJKNtcnMk5nvy3Lhsmu56inT2R481qOgBb9EF
X-Received: by 2002:a05:600c:138c:b0:49b:8c63:dfdf with SMTP id
 5b1f17b1804b1-49cf825bd7amr112048595e9.15.1788534508169; 
 Fri, 04 Sep 2026 08:08:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm413211195e9.0.2026.09.04.08.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 08:08:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 410005F954;
 Fri, 04 Sep 2026 16:08:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 000/105] move check-tcg into the meson build
Date: Fri,  4 Sep 2026 16:08:26 +0100
Message-ID: <20260904150826.2331577-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit d2843fbf80260e4346c856819e8cea11768c9d0e:

  Merge tag 'pull-riscv-to-apply-20260904' of https://github.com/alistair23/qemu into staging (2026-09-04 09:43:27 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-check-tcg-meson-040926-2

for you to fetch changes up to 7a485176838e6b6044e73f925d308bb4b3002597:

  MAINTAINERS: add maintainer for tcg/tests meson infrastructure (2026-09-04 16:06:22 +0100)

----------------------------------------------------------------
tests/tcg: conversion to meson

  - remove unused variable from multiarch/memory
  - standardise checking plugin output
  - bump minimal meson to 1.6.0
  - introduce meson plumbing for check-tcg
  - return error code if docker probe fails
  - add CI/self/mem test to gdbstub prot-none tests
  - use raw opcode for fprcvt test in arm
  - remove unused variables from gpc-test
  - teach probe-gdb-support about mips
  - identify or1k pc register
  - port check-tcg logic to meson (all targets)
  - update documentation
  - add Pierrick as a maintainer for tests/tcg

----------------------------------------------------------------
Pierrick Bouvier (105):
      tests/tcg/multiarch/system/memory.c: remove unused variable
      tests/tcg/multiarch/plugin/check-plugin-output.sh: take test output as input
      tests/tcg/multiarch/plugin: rename check-plugin-output to regex-compare
      meson: bump minimal version to 1.6.0
      tests/tcg: introduce meson.build
      tests/tcg/meson.build: introduce exe_name
      tests/tcg/meson.build: introduce test_name
      tests/tcg/meson.build: introduce cflags
      tests/tcg/meson.build: introduce qemu_args
      tests/tcg/meson.build: introduce env_var
      tests/tcg/plugins: build list of test_plugins
      tests/tcg/meson.build: introduce plugin_test
      tests/tcg/meson.build: test gdb support and introduce gdb_arch
      tests/tcg/meson.build: introduce gdb_test
      tests/tcg/meson.build: introduce wrapper
      tests/tcg/meson.build: introduce expected_output
      tests/tcg/meson.build: add wrapper run_and_check_forbidden_output
      tests/tcg/meson.build: add wrapper run_with_input
      tests/tcg/meson.build: add wrapper record_replay
      tests/tcg/meson.build: add wrapper check_plugin_output
      tests/tcg/meson.build: add logic to skip tests
      tests/tcg/meson.build: introduce cc_feat and cc_feat_cflags
      tests/tcg/meson.build: introduce gdb_feat and gdb_feat_version
      tests/tcg/meson.build: move gdb_arch support check
      tests/tcg/meson.build: let test infrastructure detect compiler
      tests/docker/docker.py: return error code if probe fails
      tests/docker/docker.py: remove "Image is up to date" info
      tests/tcg/meson.build: introduce cc_dockerfile and cc_docker_host_arch
      tests/tcg/meson.build: check host cross cc is working
      tests/tcg/meson.build: introduce depends
      tests/tcg/meson.build: use full path for QEMU binary
      tests/tcg/meson.build: add top-level 'tcg-tests' target
      tests/tcg/Makefile: skip user/system tests if target Makefile is not present
      tests/tcg/multiarch/gdbstub/prot-none.py: deactivate on gitlab CI
      tests/tcg/multiarch/gdbstub/prot-none.py: detect if /proc/self/mem can be used to access PROT_NONE pages
      tests/tcg/multiarch: declare user tests
      tests/tcg/multiarch: declare system tests
      tests/tcg/meson.build: add generic plugin tests
      tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
      tests/tcg/aarch64: user tests
      tests/tcg/aarch64/system/gpc-test.c: remove unused variables
      tests/tcg/aarch64: system tests
      tests/tcg/aarch64_be: user tests
      tests/tcg/alpha: add float reference files
      tests/tcg/alpha: user tests
      tests/tcg/alpha: system tests
      tests/tcg/arm: user tests
      tests/tcg/arm: system tests
      tests/tcg/hexagon/overflow.c: add missing include
      tests/tcg/hexagon: user tests
      tests/tcg/multiarch/sha1.c: fix big endian implementation
      tests/tcg/hppa: add float reference files
      tests/tcg/hppa: user tests
      tests/tcg/i386: add missing float reference files
      tests/tcg/i386: user tests
      tests/tcg/i386: system tests
      tests/tcg/loongarch64: user tests
      tests/tcg/loongarch64: system tests
      tests/tcg/m68k: add float reference files
      tests/tcg/m68k: user tests
      scripts/probe-gdb-support.py: add mapping for mips architecture
      tests/tcg/mips: add float reference files
      test/tcg/mips: user tests
      tests/tcg/mips64: add float reference files
      tests/tcg/mips64: user tests
      tests/tcg/mips64el: add float reference files
      tests/tcg/mips64el: user tests
      tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
      tests/tcg/or1k/test_addic.c: remove unused variables
      tests/tcg/or1k/test_muli.c: remove set but unused variable
      tests/tcg/or1k: add float reference files
      plugins/api.c: identify or1k pc register and mark it as read only
      tests/tcg/or1k: user tests
      tests/tcg/ppc64: add float reference files
      tests/tcg/ppc64: remove dependency on qemu/compiler.h
      tests/tcg/ppc64: user tests
      tests/tcg/ppc64le: add missing float reference file
      tests/tcg/ppc64le: user tests
      tests/tcg/riscv64: add float reference files
      tests/tcg/riscv64: user tests
      tests/tcg/riscv64: system tests
      tests/tcg/s390x/head64.S: declare _exit symbol after main
      tests/tcg/s390x: add float reference files
      tests/tcg/s390x: user tests
      tests/tcg/s390x/console.c: directly implement memcpy and memset
      tests/tcg/s390x: system tests
      tests/tcg/sh4: add float reference files
      tests/tcg/sh4: user tests
      tests/tcg/tricore: system tests
      tests/tcg/x86_64: add missing float reference file
      tests/tcg/x86_64: user tests
      tests/tcg/x86_64: system tests
      tests/tcg/xtensa/crt.S: align .text section
      tests/docker/dockerfiles/debian-xtensa-cross.docker: add test_kc705_be toolchain for xtensaeb
      tests/tcg/xtensa: system tests
      tests/tcg/xtensa: xtensaeb system tests
      tests: remove tcg tests machinery
      tests/tcg: remove remaining Makefiles
      configure: directly pass gdb path as a meson option
      tests/tcg/meson.build: implement ./configure containers options
      tests/tcg/meson.build: implement ./configure -cross-cc-* options
      configure: remove cross_cc and gdb detection logic
      meson.build: add summary for TCG tests
      docs/devel/testing/: update documentation
      MAINTAINERS: add maintainer for tcg/tests meson infrastructure

 MAINTAINERS                                        |   4 +-
 docs/devel/build-system.rst                        |   4 +-
 docs/devel/testing/main.rst                        |  35 +-
 configure                                          | 530 +----------
 tests/tcg/s390x/pgm-specification.mak              |  15 -
 meson.build                                        |  21 +-
 plugins/api.c                                      |   2 +
 tests/tcg/aarch64/system/gpc-test.c                |   5 -
 tests/tcg/arm/fcvt.c                               |   6 +-
 tests/tcg/hexagon/overflow.c                       |   1 +
 tests/tcg/multiarch/sha1.c                         |   1 +
 tests/tcg/multiarch/system/memory.c                |   3 +-
 tests/tcg/or1k/test_addic.c                        |   2 +-
 tests/tcg/or1k/test_muli.c                         |   5 +-
 tests/tcg/ppc64/vector.c                           |  11 +-
 tests/tcg/ppc64/vsx_f2i_nan.c                      |   7 +-
 tests/tcg/s390x/console.c                          |  30 +-
 tests/tcg/test_cc.c                                |   9 +
 tests/lcitool/refresh                              |  14 +-
 .../dockerfiles/debian-all-test-cross.docker       |  14 +-
 .../docker/dockerfiles/debian-xtensa-cross.docker  |   4 +-
 meson_options.txt                                  |  95 +-
 pythondeps.toml                                    |   2 +-
 scripts/probe-gdb-support.py                       |   1 +
 tests/Makefile.include                             |  68 +-
 tests/docker/docker.py                             |   4 +-
 tests/meson.build                                  |   2 +-
 tests/tcg/Makefile.target                          | 281 ------
 tests/tcg/aarch64/Makefile.softmmu-target          | 147 ---
 tests/tcg/aarch64/Makefile.target                  | 211 -----
 tests/tcg/aarch64/meson.build                      | 210 +++++
 tests/tcg/aarch64/system/meson.build               | 109 +++
 tests/tcg/aarch64_be/Makefile.target               |  17 -
 tests/tcg/aarch64_be/meson.build                   |  22 +
 tests/tcg/alpha/Makefile.softmmu-target            |  34 -
 tests/tcg/alpha/Makefile.target                    |  18 -
 tests/tcg/alpha/float_convd.ref                    | 988 +++++++++++++++++++++
 tests/tcg/alpha/float_convs.ref                    | 748 ++++++++++++++++
 tests/tcg/alpha/float_madds.ref                    | 768 ++++++++++++++++
 tests/tcg/alpha/meson.build                        |  55 ++
 tests/tcg/alpha/system/meson.build                 |  47 +
 tests/tcg/arm/Makefile.softmmu-target              |  80 --
 tests/tcg/arm/Makefile.target                      |  87 --
 tests/tcg/arm/meson.build                          |  80 ++
 tests/tcg/arm/system/meson.build                   |  69 ++
 tests/tcg/hexagon/Makefile.target                  | 166 ----
 tests/tcg/hexagon/meson.build                      | 120 +++
 tests/tcg/hppa/Makefile.target                     |  14 -
 tests/tcg/hppa/float_convd.ref                     | 988 +++++++++++++++++++++
 tests/tcg/hppa/float_convs.ref                     | 748 ++++++++++++++++
 tests/tcg/hppa/float_madds.ref                     | 768 ++++++++++++++++
 tests/tcg/hppa/meson.build                         |  22 +
 tests/tcg/i386/Makefile.softmmu-target             |  37 -
 tests/tcg/i386/Makefile.target                     | 102 ---
 tests/tcg/i386/float_convd.conf                    | 988 ---------------------
 tests/tcg/i386/float_convd.ref                     | 988 +++++++++++++++++++++
 tests/tcg/i386/float_madds.ref                     | 768 ++++++++++++++++
 tests/tcg/i386/meson.build                         |  58 ++
 tests/tcg/i386/system/meson.build                  |  49 +
 tests/tcg/loongarch64/Makefile.softmmu-target      |  33 -
 tests/tcg/loongarch64/Makefile.target              |  20 -
 tests/tcg/loongarch64/meson.build                  |  32 +
 tests/tcg/loongarch64/system/meson.build           |  48 +
 tests/tcg/m68k/Makefile.target                     |   7 -
 tests/tcg/m68k/float_convd.ref                     | 988 +++++++++++++++++++++
 tests/tcg/m68k/float_convs.ref                     | 748 ++++++++++++++++
 tests/tcg/m68k/float_madds.ref                     | 768 ++++++++++++++++
 tests/tcg/m68k/meson.build                         |  23 +
 tests/tcg/meson.build                              | 513 +++++++++++
 tests/tcg/minilib/Makefile.target                  |  21 -
 tests/tcg/mips/Makefile.target                     |  19 -
 tests/tcg/mips/float_convd.ref                     | 988 +++++++++++++++++++++
 tests/tcg/mips/float_convs.ref                     | 748 ++++++++++++++++
 tests/tcg/mips/float_madds.ref                     | 768 ++++++++++++++++
 tests/tcg/mips/meson.build                         |  25 +
 tests/tcg/mips64/Makefile.target                   |  20 -
 tests/tcg/mips64/float_convd.ref                   | 988 +++++++++++++++++++++
 tests/tcg/mips64/float_convs.ref                   | 748 ++++++++++++++++
 tests/tcg/mips64/float_madds.ref                   | 768 ++++++++++++++++
 tests/tcg/mips64/meson.build                       |  27 +
 tests/tcg/mips64el/Makefile.target                 |   8 -
 tests/tcg/mips64el/float_convd.ref                 | 988 +++++++++++++++++++++
 tests/tcg/mips64el/float_convs.ref                 | 748 ++++++++++++++++
 tests/tcg/mips64el/float_madds.ref                 | 768 ++++++++++++++++
 tests/tcg/mips64el/meson.build                     |  14 +
 tests/tcg/multiarch/Makefile.target                | 224 -----
 tests/tcg/multiarch/gdbstub/prot-none.py           |  42 +-
 tests/tcg/multiarch/meson.build                    | 149 ++++
 tests/tcg/multiarch/plugin/check-plugin-output.sh  |  36 -
 tests/tcg/multiarch/plugin/regex-compare.sh        |  28 +
 tests/tcg/multiarch/sha1.ref                       |   1 +
 tests/tcg/multiarch/system/Makefile.softmmu-target |  81 --
 tests/tcg/multiarch/system/meson.build             |  53 ++
 tests/tcg/or1k/Makefile                            |  71 --
 tests/tcg/or1k/float_convd.ref                     | 247 ++++++
 tests/tcg/or1k/float_convs.ref                     | 187 ++++
 tests/tcg/or1k/float_madds.ref                     | 192 ++++
 tests/tcg/or1k/meson.build                         |  72 ++
 tests/tcg/plugins/meson.build                      |  11 +-
 tests/tcg/ppc64/Makefile.target                    |  63 --
 tests/tcg/ppc64/float_convd.ref                    | 988 +++++++++++++++++++++
 tests/tcg/ppc64/float_convs.ref                    | 748 ++++++++++++++++
 tests/tcg/ppc64/float_madds.ref                    | 768 ++++++++++++++++
 tests/tcg/ppc64/meson.build                        |  56 ++
 tests/tcg/ppc64le/Makefile.target                  |   7 -
 tests/tcg/ppc64le/float_convd.ref                  | 988 +++++++++++++++++++++
 tests/tcg/ppc64le/meson.build                      |  14 +
 tests/tcg/riscv64/Makefile.target                  |  20 -
 tests/tcg/riscv64/float_convd.ref                  | 988 +++++++++++++++++++++
 tests/tcg/riscv64/float_convs.ref                  | 748 ++++++++++++++++
 tests/tcg/riscv64/float_madds.ref                  | 768 ++++++++++++++++
 tests/tcg/riscv64/meson.build                      |  38 +
 tests/tcg/riscv64/system/meson.build               |  76 ++
 tests/tcg/s390x/Makefile.softmmu-target            |  57 --
 tests/tcg/s390x/Makefile.target                    | 129 ---
 tests/tcg/s390x/float_convd.ref                    | 988 +++++++++++++++++++++
 tests/tcg/s390x/float_convs.ref                    | 748 ++++++++++++++++
 tests/tcg/s390x/float_madds.ref                    | 768 ++++++++++++++++
 tests/tcg/s390x/head64.S                           |   2 +
 tests/tcg/s390x/meson.build                        | 142 +++
 tests/tcg/s390x/system/meson.build                 |  92 ++
 tests/tcg/scripts/check_plugin_output.sh           |  25 +
 tests/tcg/scripts/record_replay.sh                 |  16 +
 .../tcg/scripts/run_and_check_forbidden_output.sh  |  19 +
 tests/tcg/scripts/run_and_diff.sh                  |  15 +
 tests/tcg/scripts/run_with_input.sh                |  12 +
 tests/tcg/sh4/Makefile.target                      |  18 -
 tests/tcg/sh4/float_convd.ref                      | 494 +++++++++++
 tests/tcg/sh4/float_convs.ref                      | 374 ++++++++
 tests/tcg/sh4/float_madds.ref                      | 384 ++++++++
 tests/tcg/sh4/meson.build                          |  25 +
 tests/tcg/tricore/Makefile.softmmu-target          |  53 --
 tests/tcg/tricore/meson.build                      |  57 ++
 tests/tcg/x86_64/Makefile.softmmu-target           |  44 -
 tests/tcg/x86_64/Makefile.target                   |  41 -
 tests/tcg/x86_64/float_madds.ref                   | 768 ++++++++++++++++
 tests/tcg/x86_64/meson.build                       |  84 ++
 tests/tcg/x86_64/system/meson.build                |  63 ++
 tests/tcg/xtensa/Makefile.softmmu-target           |  46 -
 tests/tcg/xtensa/crt.S                             |   1 +
 tests/tcg/xtensa/meson.build                       | 110 +++
 tests/tcg/xtensaeb/Makefile.softmmu-target         |   5 -
 142 files changed, 30884 insertions(+), 3868 deletions(-)
 delete mode 100644 tests/tcg/s390x/pgm-specification.mak
 create mode 100644 tests/tcg/test_cc.c
 delete mode 100644 tests/tcg/Makefile.target
 delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/meson.build
 create mode 100644 tests/tcg/aarch64/system/meson.build
 delete mode 100644 tests/tcg/aarch64_be/Makefile.target
 create mode 100644 tests/tcg/aarch64_be/meson.build
 delete mode 100644 tests/tcg/alpha/Makefile.softmmu-target
 delete mode 100644 tests/tcg/alpha/Makefile.target
 create mode 100644 tests/tcg/alpha/float_convd.ref
 create mode 100644 tests/tcg/alpha/float_convs.ref
 create mode 100644 tests/tcg/alpha/float_madds.ref
 create mode 100644 tests/tcg/alpha/meson.build
 create mode 100644 tests/tcg/alpha/system/meson.build
 delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
 delete mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/meson.build
 create mode 100644 tests/tcg/arm/system/meson.build
 delete mode 100644 tests/tcg/hexagon/Makefile.target
 create mode 100644 tests/tcg/hexagon/meson.build
 delete mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/hppa/float_convd.ref
 create mode 100644 tests/tcg/hppa/float_convs.ref
 create mode 100644 tests/tcg/hppa/float_madds.ref
 create mode 100644 tests/tcg/hppa/meson.build
 delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
 delete mode 100644 tests/tcg/i386/Makefile.target
 delete mode 100644 tests/tcg/i386/float_convd.conf
 create mode 100644 tests/tcg/i386/float_convd.ref
 create mode 100644 tests/tcg/i386/float_madds.ref
 create mode 100644 tests/tcg/i386/meson.build
 create mode 100644 tests/tcg/i386/system/meson.build
 delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/loongarch64/Makefile.target
 create mode 100644 tests/tcg/loongarch64/meson.build
 create mode 100644 tests/tcg/loongarch64/system/meson.build
 delete mode 100644 tests/tcg/m68k/Makefile.target
 create mode 100644 tests/tcg/m68k/float_convd.ref
 create mode 100644 tests/tcg/m68k/float_convs.ref
 create mode 100644 tests/tcg/m68k/float_madds.ref
 create mode 100644 tests/tcg/m68k/meson.build
 create mode 100644 tests/tcg/meson.build
 delete mode 100644 tests/tcg/minilib/Makefile.target
 delete mode 100644 tests/tcg/mips/Makefile.target
 create mode 100644 tests/tcg/mips/float_convd.ref
 create mode 100644 tests/tcg/mips/float_convs.ref
 create mode 100644 tests/tcg/mips/float_madds.ref
 create mode 100644 tests/tcg/mips/meson.build
 delete mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64/float_convd.ref
 create mode 100644 tests/tcg/mips64/float_convs.ref
 create mode 100644 tests/tcg/mips64/float_madds.ref
 create mode 100644 tests/tcg/mips64/meson.build
 delete mode 100644 tests/tcg/mips64el/Makefile.target
 create mode 100644 tests/tcg/mips64el/float_convd.ref
 create mode 100644 tests/tcg/mips64el/float_convs.ref
 create mode 100644 tests/tcg/mips64el/float_madds.ref
 create mode 100644 tests/tcg/mips64el/meson.build
 delete mode 100644 tests/tcg/multiarch/Makefile.target
 create mode 100644 tests/tcg/multiarch/meson.build
 delete mode 100755 tests/tcg/multiarch/plugin/check-plugin-output.sh
 create mode 100755 tests/tcg/multiarch/plugin/regex-compare.sh
 create mode 100644 tests/tcg/multiarch/sha1.ref
 delete mode 100644 tests/tcg/multiarch/system/Makefile.softmmu-target
 create mode 100644 tests/tcg/multiarch/system/meson.build
 delete mode 100644 tests/tcg/or1k/Makefile
 create mode 100644 tests/tcg/or1k/float_convd.ref
 create mode 100644 tests/tcg/or1k/float_convs.ref
 create mode 100644 tests/tcg/or1k/float_madds.ref
 create mode 100644 tests/tcg/or1k/meson.build
 delete mode 100644 tests/tcg/ppc64/Makefile.target
 create mode 100644 tests/tcg/ppc64/float_convd.ref
 create mode 100644 tests/tcg/ppc64/float_convs.ref
 create mode 100644 tests/tcg/ppc64/float_madds.ref
 create mode 100644 tests/tcg/ppc64/meson.build
 delete mode 100644 tests/tcg/ppc64le/Makefile.target
 create mode 100644 tests/tcg/ppc64le/float_convd.ref
 create mode 100644 tests/tcg/ppc64le/meson.build
 delete mode 100644 tests/tcg/riscv64/Makefile.target
 create mode 100644 tests/tcg/riscv64/float_convd.ref
 create mode 100644 tests/tcg/riscv64/float_convs.ref
 create mode 100644 tests/tcg/riscv64/float_madds.ref
 create mode 100644 tests/tcg/riscv64/meson.build
 create mode 100644 tests/tcg/riscv64/system/meson.build
 delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
 delete mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/float_convd.ref
 create mode 100644 tests/tcg/s390x/float_convs.ref
 create mode 100644 tests/tcg/s390x/float_madds.ref
 create mode 100644 tests/tcg/s390x/meson.build
 create mode 100644 tests/tcg/s390x/system/meson.build
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh
 create mode 100755 tests/tcg/scripts/record_replay.sh
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh
 create mode 100755 tests/tcg/scripts/run_and_diff.sh
 create mode 100755 tests/tcg/scripts/run_with_input.sh
 delete mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sh4/float_convd.ref
 create mode 100644 tests/tcg/sh4/float_convs.ref
 create mode 100644 tests/tcg/sh4/float_madds.ref
 create mode 100644 tests/tcg/sh4/meson.build
 delete mode 100644 tests/tcg/tricore/Makefile.softmmu-target
 create mode 100644 tests/tcg/tricore/meson.build
 delete mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
 delete mode 100644 tests/tcg/x86_64/Makefile.target
 create mode 100644 tests/tcg/x86_64/float_madds.ref
 create mode 100644 tests/tcg/x86_64/meson.build
 create mode 100644 tests/tcg/x86_64/system/meson.build
 delete mode 100644 tests/tcg/xtensa/Makefile.softmmu-target
 create mode 100644 tests/tcg/xtensa/meson.build
 delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

-- 
2.47.3


