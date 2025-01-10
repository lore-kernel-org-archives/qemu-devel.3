Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A16E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtt-0004ga-PM; Fri, 10 Jan 2025 08:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtk-0004bA-1h
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:00 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEti-0004go-2U
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:17:59 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so15335575e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515075; x=1737119875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HEtabBil4N5lsFhbqab0ddUt8KgCDJEZu4RJQ2J0jwU=;
 b=L32cUDKYAmf5UOC1SVkUkmLZbGjXECjlXJIhoR3XWUsYYUB0+dJPfARsTSR07ZzGrh
 SUCwUStFw211+rn1fYC77R1O8dw040n3tekzk4O43mDke06xyl7VIbQ4Z32xsnbu/a/D
 L1Vb0HXAEVJdOYlJ/BUUDN9nsvulbyRSo5r5CfcOI01tEf4DS1Enjm1C3NeaXkESgkp6
 LD1YQUqssRjYPKFFeKwKALb9ZrUn3huRUOgom+4djS+lMfRAekmvq1mYh+1X4eDD+Lqt
 vUBwglThvSauIgfMd3BNgqVc1hNI9PW38DKf7TY0qed824plXq7gDsYZjCAqkk+dKKFs
 pmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515075; x=1737119875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HEtabBil4N5lsFhbqab0ddUt8KgCDJEZu4RJQ2J0jwU=;
 b=PxmcFld0W8fvBRe/OKbgBQO9IAB6BwzOXkZ0xxCTV6rRhnnElb9jWcceHj7BUPhWwb
 wbpWBT1xqiGDNfrSZYUyGlunYp3LVoKwi437Ipbl/rBkdVSgSPLUJWzpcm3rliqJAB9p
 n4hqvXdqZNB9h84JlJEXKUWeE6u3hBtZ69dm3BDh/65o1btwgs8NJEyxWMMtgcMDfS+o
 3YbTK7kdIum7A6rRHzvnn+0MqK718QUwaVam18yFLYnSsejzdkjgzVSLULMQMY6MSjer
 X4S695KQ1JJ+7oVOvZXr4ESSi+TG2KgaiQQVWr9hJ3lcL+CbwzIJeLETwko7pzqydyn2
 UozQ==
X-Gm-Message-State: AOJu0YzjY71T9dRaUpCJhOU5DWtGOjJKmd6v/cedN+KxhENrT2vvbERN
 Vm5Gj4tqr8F42PvfXrwkAnvty/fwIt10oQWfHpuABdgrVb2C+wpOcMN/htp+ieEpCuKdEC4HAtQ
 MYEM=
X-Gm-Gg: ASbGncvzjebbMntep5b9xGFpyQszTkQDwsFqENx6g3TpoF/WQ8PFY8nzbqrfdMzBsGF
 +wu2eLIGA2LaFbvY/+WWXNyXRl8rWGnynMkBQv6Ar6BMi1d+3LeI3xjs2EtrmB0I2Yk6qf5Fn+e
 gmQgpbmXnWabiNm4iZ5AWDJkldTl2LHsxe6/uoIjy5MhXfdxyBUnJMvhPuboFYY8YqqILmi3Mtu
 NmteJHzWl5z28C1hHvjh/A9pLuZsAUp5cn0eDkJSkpXNMYUUqWCpM4=
X-Google-Smtp-Source: AGHT+IH6DifN01oGueE7z+dw0/navOV6PHUvwIUCaBvVz39NNjL+amVmbW8OzNMngjxchvA8GVM62Q==
X-Received: by 2002:a5d:59ab:0:b0:385:fa26:f0d8 with SMTP id
 ffacd0b85a97d-38a872f6af0mr9431715f8f.8.1736515075435; 
 Fri, 10 Jan 2025 05:17:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81e4sm4593542f8f.64.2025.01.10.05.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 185DE5F8C8;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/32] testing updates for 10.0 (tuxrun, libvirt, dockerfiles,
 misc)
Date: Fri, 10 Jan 2025 13:17:22 +0000
Message-Id: <20250110131754.2769814-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

  https://gitlab.com/stsquad/qemu.git tags/pull-10.0-testing-updates-100125-1

for you to fetch changes up to 70b7c929ba39f15a94fbc63d9be88e8da907cc46:

  MAINTAINERS: Remove myself from reviewers (2025-01-10 11:18:38 +0000)

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
 tests/functional/test_aarch64_virt.py              | 117 +++++++++++++++++----
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
 35 files changed, 461 insertions(+), 182 deletions(-)
 create mode 100755 tests/functional/test_aarch64_rme_sbsaref.py
 create mode 100755 tests/functional/test_aarch64_rme_virt.py
 create mode 100755 tests/functional/test_m68k_tuxrun.py

-- 
2.39.5


