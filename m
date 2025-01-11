Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED16AE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 12:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWaNJ-0005if-Kl; Sat, 11 Jan 2025 07:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWaNB-0005i8-7m
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 07:13:50 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWaN8-0003zi-0g
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 07:13:47 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso471817166b.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736597624; x=1737202424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lc1W+XfcKAdOaf1O8UWwWcxWQ0C3DqQlc+xqMIBV/44=;
 b=iCSccPjbuHXq2YdGAU3dZ5Zf1yA/1QcTra09l3hRA1+XSVewc3ZYqh8//T9gtOlxEk
 AZeu/pt73Q0K2kHufSMnfTkWA1xMslg+kDcybCbti/VyAZ0reTiggT1kHpjfeAS7awUm
 5Syx6Bsmz16tAbsYBbQQ46fy2LOdGv+tKD2q2qc/mp4QvweEGD9Dhzynl5mOehenXqok
 v8NS3PG+GNKvDBciIhAPYaOLbMACEMLIVDIixrlaQOOg49oWoFjReSdcc0IBpZRsWrJR
 FSyrrkIQsIyW1PE+mMGlCfCs2FwEsmjS1VSk1+q59T9ryfyqspjAxDWhO4qRbiIWvEPP
 tqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736597624; x=1737202424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lc1W+XfcKAdOaf1O8UWwWcxWQ0C3DqQlc+xqMIBV/44=;
 b=RfBWCQArWLJiB+6aXqi6v8QCAOJcz1uLXxNq276dHLI/7ANV2GCFpcOid73RvEQ3Zj
 83SwWmI377J3CZtNjOU4GjZabFi1jyiRBZrhn8MJEBFOXUBUMJ61ZmQ+pxjSb7xTlGLm
 QanroPzMK6MXxDJbACSR9DsqZfQZ6+GGQJ2gbT/xCK6LIw+DUZQuwhkKHZiHgDdBeLhP
 agKR9zEBXaUXP6kuRt/nZBvzrvuvs4nu3y+UwB2WuL8skJz8CRESHTMWp3gSTPeX0f9+
 ZZjQhPokD+agyGotsxRivZ46yi/ahR+u9d32J2X72CZ0Dwi1edC1bzrj2nGPlyJKvDzz
 KR4Q==
X-Gm-Message-State: AOJu0YzGgIsYB5jwn6P+qQ1YeWHUCjMgh7xLliwy+6us9d8yiKDMlFDA
 3lbXEQCtv1CZKLuHHIcE8OlabRawAGpz3fixKdOapEowDBKhzMdEi8dpzyknxUIzBhMo0pETnl9
 Iw20=
X-Gm-Gg: ASbGnctxogCk0ujPUwqdI6ZJNgPoOO+hvnBAowJDq9amv6NgzXzse/xb7fHc7+Pox9L
 Zn6ifBIBpPNFmHP5jBxeKmXNzuVzrUWWDD0PimBk38IAbubQGqEcBErONumqyx2eCTnpkD7p+r4
 UDcH+RNbyTLm8O0LXjPCtdDEtXVVDxLese8dRZ1bByWiVYqxVvfiojEocR5rlwnprHt1zolgctw
 s63cjPJRdfRuWlH/mjjXRHoWTI9n7kqOslQeKidijCKOz3VQtTIlU0=
X-Google-Smtp-Source: AGHT+IEUQodkzVxMGWC2ihegR8sbhju7DoNcNvDRSuWcDupE3toRNuMRGzyB6VA9EhaH563rJsw/lw==
X-Received: by 2002:a17:907:9413:b0:aa6:7165:504b with SMTP id
 a640c23a62f3a-ab2ab709c3bmr1211897666b.31.1736597623596; 
 Sat, 11 Jan 2025 04:13:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dad57sm270180666b.66.2025.01.11.04.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 04:13:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 317CF5F886;
 Sat, 11 Jan 2025 12:13:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/32] testing updates for 10.0 (tuxrun, libvirt, dockerfiles,
 misc)
Date: Sat, 11 Jan 2025 12:13:41 +0000
Message-Id: <20250111121341.141204-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

The following changes since commit bc6afa1c711da5b4f37c9685a812c77b114d84cb:

  Merge tag 'pull-xenfv-20250109-1' of https://gitlab.com/dwmw2/qemu into staging (2025-01-09 08:39:32 -0500)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.0-testing-updates-110125-1

for you to fetch changes up to ae0aef5e761ad6425c634f3d83b8cc5b52d1ce0a:

  MAINTAINERS: Remove myself from reviewers (2025-01-11 11:22:01 +0000)

----------------------------------------------------------------
Testing updates for 10.0

  - update the tuxrun images to the latest baseline
  - add the m68k tuxrun test
  - ensure qtest checks the result of clock_step operations
  - introduce new ztsd helper to functional tests
  - ensure aarch64_virt test exits early when no TCG
  - add new test to exercise virtio-vulkan
  - bump libvirt-ci to latest version
  - move riscv64 cross container from sid to trixie
  - remove workaround from mips containers now upstream updated
  - fix VM tests to use correct path for local QEMU binary
  - add ability to get a root debug shell on VM images
  - add keymap dependency to vnc tests
  - remove retiring maintainers from avocado and dockerfiles

----------------------------------------------------------------
Alex Bennée (28):
      tests/functional: update the arm tuxrun tests
      tests/functional: update the i386 tuxrun tests
      tests/functional: add a m68k tuxrun tests
      tests/functional: update the mips32 tuxrun tests
      tests/functional: update the mips32el tuxrun tests
      tests/functional: update the mips64 tuxrun tests
      tests/functional: update the mips64el tuxrun tests
      tests/functional: update the ppc32 tuxrun tests
      tests/functional: update the ppc64 tuxrun tests
      tests/functional: update the riscv32 tuxrun tests
      tests/functional: update the riscv64 tuxrun tests
      tests/functional: update the s390x tuxrun tests
      tests/functional: update the sparc64 tuxrun tests
      tests/functional: update the x86_64 tuxrun tests
      tests/qtest: remove clock_steps from virtio tests
      system/qtest: properly feedback results of clock_[step|set]
      tests/functional: remove hacky sleep from the tests
      tests/functional: add zstd support to uncompress utility
      tests/functional: update tuxruntest to use uncompress utility
      tests/functional: remove unused kernel_command_line
      tests/functional: bail aarch64_virt tests early if missing TCG
      tests/functional: extend test_aarch64_virt with vulkan test
      tests/lcitool: bump to latest version of libvirt-ci
      tests/docker: move riscv64 cross container from sid to trixie
      tests/vm: fix build_path based path
      tests/vm: partially un-tabify help output
      tests/vm: allow interactive login as root
      pc-bios: ensure keymaps dependencies set vnc tests

Daniel P. Berrangé (1):
      tests/lcitool: remove temp workaround for debian mips64el

Philippe Mathieu-Daudé (1):
      dockerfiles: Remove 'MAINTAINER' entry in debian-tricore-cross.docker

Pierrick Bouvier (1):
      tests/functional/aarch64: add tests for FEAT_RME

Wainer dos Santos Moschetta (1):
      MAINTAINERS: Remove myself from reviewers

 MAINTAINERS                                        |   3 +-
 system/qtest.c                                     |  23 ++--
 tests/qtest/libqos/virtio.c                        |   4 -
 .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
 pc-bios/keymaps/meson.build                        |  17 ++-
 .../dockerfiles/debian-mips64el-cross.docker       |   9 ++
 .../docker/dockerfiles/debian-riscv64-cross.docker |   4 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |   2 -
 tests/functional/meson.build                       |   5 +
 tests/functional/qemu_test/tuxruntest.py           |  12 +--
 tests/functional/qemu_test/uncompress.py           |  24 +++++
 tests/functional/test_aarch64_rme_sbsaref.py       |  69 ++++++++++++
 tests/functional/test_aarch64_rme_virt.py          |  98 +++++++++++++++++
 tests/functional/test_aarch64_virt.py              | 119 +++++++++++++++++----
 tests/functional/test_arm_tuxrun.py                |  28 ++---
 tests/functional/test_i386_tuxrun.py               |   8 +-
 tests/functional/test_m68k_tuxrun.py               |  34 ++++++
 tests/functional/test_mips64_tuxrun.py             |   8 +-
 tests/functional/test_mips64el_tuxrun.py           |   8 +-
 tests/functional/test_mips_tuxrun.py               |   8 +-
 tests/functional/test_mipsel_tuxrun.py             |   8 +-
 tests/functional/test_ppc64_tuxrun.py              |  16 +--
 tests/functional/test_ppc_tuxrun.py                |   8 +-
 tests/functional/test_riscv32_tuxrun.py            |   8 +-
 tests/functional/test_riscv64_tuxrun.py            |  16 +--
 tests/functional/test_s390x_tuxrun.py              |   8 +-
 tests/functional/test_sparc64_tuxrun.py            |   8 +-
 tests/functional/test_x86_64_tuxrun.py             |   8 +-
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/mappings.yml                         |  29 -----
 tests/lcitool/refresh                              |   4 +-
 tests/qtest/meson.build                            |   2 +-
 tests/vm/Makefile.include                          |  29 ++---
 tests/vm/basevm.py                                 |  12 ++-
 tests/vm/generated/freebsd.json                    |   2 +-
 35 files changed, 463 insertions(+), 182 deletions(-)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py
 create mode 100755 tests/functional/test_m68k_tuxrun.py

-- 
2.39.5


