Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB60CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S4-00041p-31; Wed, 29 Oct 2025 11:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rx-0003z3-DG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:02 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rr-0002s0-DQ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-637e9f9f9fbso13563581a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753049; x=1762357849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bVt91U9CN3CeKgB2+TdAfUtyShLCYqGa0ESHQprmkuk=;
 b=xuoePvQ1rLnH3Y0hSoLMniE4CNYIUuQJk1KGLmUzkhQC1FjAyMzGb5+iqh7+yMBmWh
 giK3WkG7mqZBjeM0qE3lJAG1Mqvv2HbM1NUnLGSCOYzl2sQt2yRXRCbBeOsuk4momPxK
 JSoJKsuU083ZtctlGvzFLSoRnESbFPGOst6KM8aslRwc5mVp1hRalgZRiVX17wExwWmK
 3vYK11IOPl3b2kLoNERd6rIIiKpSbTdgAo1ejLuEvKb+EDF79rR081HndvRBqB4SdtfS
 3aMVTV1yQCpG1RmMqdmtj5JBaXKOy9Urfnl2DXtkxwxtfV8OSbaroxQqs+vFyKaWc14/
 i6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753049; x=1762357849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVt91U9CN3CeKgB2+TdAfUtyShLCYqGa0ESHQprmkuk=;
 b=gMXqx2XIhWxkllJl/4ml3ZN0zBwucaSqqBhc1TpzFSo32P1ILKupAsvAigWiV1tu3N
 BdsQFn06EQEvwbiYQYcv4CFiyGE3V9H4c+gvV3Kxti/JWJWlmvPDuY4zBGasaC42cj+e
 urkNdLM2cQwua6lOcZN1tGRUcj2s19JPyznmmprtPH6LSos4UU5qDNB4wyv1ce16JpOO
 X+MK/R8Qob2wo4umNFzOUqiKpK45QyNwzSeR2VVU+T4S2oN4+DF3Hpz4hG2rL9Se5X4L
 MnZms2DlVcLu3J21A5cXRYKQb+PgKo8TeDj84KXrM0bBO6tJielB2o6jvlpiMSVGUnOi
 AkEA==
X-Gm-Message-State: AOJu0YxiU3B4CW39oBvtqNSfwqy1QEOIr/eHZ3gzjvSQOvZQXTU349dp
 ARdzUdIkVpKi34qMc1e0zTTEMCy6rH6m209pguukQ3FJqejA7lWNwu1Q3TI9czaPMsiBVINi1XV
 mLAYjqEM=
X-Gm-Gg: ASbGncupq5kSsJEpbXKXZmkCYIjkolUY+1V8mnVRtoWT7UrmAdqVrlKG4I/9aan+CVt
 7o6mxpd3r5V56lCcRoaddH/siY8E6HIT4LrpwAJMnTy9nePZrogbXXM09+RbA7c7wZ46g9ifbIp
 gAwqB0b1oZJcnsVHuXtLwln0AjzMOh07XAIpl0u3IaeGc+mCkBRoDpz8fqQkwWgo25nvd9/k5Hb
 k4zknlOAN5cOrlPGCK66UBCJmWhWdDCQcLh8CkGBE7b9GH+PK4WAVeHbKELqAxX70eP+N4xcFvz
 i+AcDqKniK9/eE9USLPAusrqw7ERtwhUtM8uYar3sBydP1IKLOwAITubvoq1CaZ1wTpKTfInUSs
 wMQfIA9kTXCZmtAvzbPnSd546FQEFB/g0xY3UOtFKD4bKrXEkjXFJYPlaaTszAqwRY09rtvhWSQ
 PJ
X-Google-Smtp-Source: AGHT+IHWIOUNwjQskpLNHvpUYWWWiHzcKKrthG6nnG+TOBGom+KolvUOFLJVXevZdRzpVsmHA66t+Q==
X-Received: by 2002:a17:907:7f05:b0:b40:b6a9:f70f with SMTP id
 a640c23a62f3a-b703d2df135mr350484266b.4.1761753048529; 
 Wed, 29 Oct 2025 08:50:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308c6csm1507517566b.1.2025.10.29.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA8855F7C7;
 Wed, 29 Oct 2025 15:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/35] maintainer updates (ci, plugins, semihosting)
Date: Wed, 29 Oct 2025 15:50:09 +0000
Message-ID: <20251029155045.257802-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-291025-1

for you to fetch changes up to 4f45b2c352bb72c13a8801805061b31979e3f048:

  semihosting: Fix GDB File-I/O FLEN (2025-10-29 14:13:40 +0000)

----------------------------------------------------------------
maintainer updates for 10.2

  - clean-up remaining 32 bit armhf bits in ci
  - rationalise build-environment.yml for Debian and Ubuntu
  - generate a Debian ppc64 package list
  - rationalise gitlab-runner.yml for Debian and Ubuntu
  - new TCG plugin feature to track discontinuities
  - add missing CFI annotation to plugin callbacks
  - drop SBSA_REF from minimal Arm build
  - format string fix for gdbstub syscall response
  - simplify the gdbstub flen handling for semihosting

----------------------------------------------------------------
Alex Bennée (8):
      ci: clean-up remaining bits of armhf builds.
      scripts/ci/setup: regenerate yaml
      scripts/ci: move build-environment.yaml up a level
      scripts/ci: allow both Ubuntu or Debian to run upgrade
      tests/lcitool: generate a yaml file for the ppc64le runner
      scripts/ci: modify gitlab runner deb setup
      plugins/core: add missing QEMU_DISABLE_CFI annotations
      configs: drop SBSA_REF from minimal specification

Julian Ganz (25):
      plugins: add types for callbacks related to certain discontinuities
      plugins: add API for registering discontinuity callbacks
      plugins: add hooks for new discontinuity related callbacks
      contrib/plugins: add plugin showcasing new dicontinuity related API
      target/alpha: call plugin trap callbacks
      target/arm: call plugin trap callbacks
      target/avr: call plugin trap callbacks
      target/hppa: call plugin trap callbacks
      target/i386: call plugin trap callbacks
      target/loongarch: call plugin trap callbacks
      target/m68k: call plugin trap callbacks
      target/microblaze: call plugin trap callbacks
      target/mips: call plugin trap callbacks
      target/openrisc: call plugin trap callbacks
      target/ppc: call plugin trap callbacks
      target/riscv: call plugin trap callbacks
      target/rx: call plugin trap callbacks
      target/s390x: call plugin trap callbacks
      target/sh4: call plugin trap callbacks
      target/sparc: call plugin trap callbacks
      target/tricore: call plugin trap callbacks
      target/xtensa: call plugin trap callbacks
      tests: add plugin asserting correctness of discon event's to_pc
      tests: add test for double-traps on rv64
      tests: add test with interrupted memory accesses on rv64

Sean Anderson (2):
      gdbstub: Fix %s formatting
      semihosting: Fix GDB File-I/O FLEN

 docs/about/emulation.rst                           |   8 +
 docs/devel/testing/ci-jobs.rst.inc                 |   7 -
 configs/devices/aarch64-softmmu/minimal.mak        |   1 -
 include/qemu/plugin-event.h                        |   3 +
 include/qemu/plugin.h                              |  13 ++
 include/qemu/qemu-plugin.h                         |  60 ++++++
 target/arm/internals.h                             |   1 +
 contrib/plugins/traps.c                            |  83 ++++++++
 gdbstub/syscalls.c                                 |   2 +-
 plugins/core.c                                     |  58 ++++++
 plugins/loader.c                                   |   1 +
 semihosting/arm-compat-semi.c                      |   5 +-
 target/alpha/helper.c                              |  13 ++
 target/arm/helper.c                                |  24 +++
 target/arm/tcg/m_helper.c                          |   5 +
 target/avr/helper.c                                |   3 +
 target/hppa/int_helper.c                           |  17 ++
 target/i386/tcg/excp_helper.c                      |   3 +
 target/i386/tcg/seg_helper.c                       |   4 +
 target/loongarch/tcg/tcg_cpu.c                     |   4 +
 target/m68k/op_helper.c                            |  22 ++
 target/microblaze/helper.c                         |  10 +
 target/mips/tcg/system/tlb_helper.c                |  11 +
 target/openrisc/interrupt.c                        |  15 ++
 target/ppc/excp_helper.c                           |  41 ++++
 target/riscv/cpu_helper.c                          |   9 +
 target/rx/helper.c                                 |  12 ++
 target/s390x/tcg/excp_helper.c                     |   8 +
 target/sh4/helper.c                                |   4 +
 target/sparc/int32_helper.c                        |   7 +
 target/sparc/int64_helper.c                        |  10 +
 target/tricore/op_helper.c                         |   5 +
 target/xtensa/exc_helper.c                         |   6 +
 target/xtensa/xtensa-semi.c                        |   3 +
 tests/tcg/plugins/discons.c                        | 221 +++++++++++++++++++++
 .../custom-runners/ubuntu-24.04-aarch64.yml        |   2 -
 contrib/plugins/meson.build                        |   2 +-
 .../ci/setup/{ubuntu => }/build-environment.yml    |  32 +--
 scripts/ci/setup/debian/debian-13-ppc64le.yaml     | 134 +++++++++++++
 scripts/ci/setup/gitlab-runner.yml                 |   6 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml   |   4 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml     |   4 +-
 tests/lcitool/refresh                              |   1 +
 tests/tcg/plugins/meson.build                      |   2 +-
 tests/tcg/riscv64/Makefile.softmmu-target          |  12 ++
 tests/tcg/riscv64/doubletrap.S                     |  73 +++++++
 tests/tcg/riscv64/interruptedmemory.S              |  97 +++++++++
 47 files changed, 1031 insertions(+), 37 deletions(-)
 create mode 100644 contrib/plugins/traps.c
 create mode 100644 tests/tcg/plugins/discons.c
 rename scripts/ci/setup/{ubuntu => }/build-environment.yml (63%)
 create mode 100644 scripts/ci/setup/debian/debian-13-ppc64le.yaml
 create mode 100644 tests/tcg/riscv64/doubletrap.S
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

-- 
2.47.3


