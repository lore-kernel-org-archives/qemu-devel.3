Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95756C28B30
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr270-0003HK-QS; Sat, 08 Mar 2025 16:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26y-0003FE-Gw
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26w-0000ux-Bj
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:36 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso126905e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470812; x=1742075612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/olTmy8XTTUA1KMSdUNu/qAD1H3xeJx2k2rmVKE8Uk4=;
 b=uF9jWYHohWGbJ3i1VDbCnvPwfGniby7tZhRmA0GMV3W9ZZd24rW031KDOL/v3WujMO
 6E0NX9XVsXPGSHGkqVO/vvNrMl8BgHL1mQrE261Uq2V679lmeTtDgCDkaHTSQwsUfqCs
 IdlihyaUYb9iDZZH5ZXGHUthhhB7RBIFwdCenl5XvePMJ1XDPXhAL74yEQSjUTJANFdx
 tkEkom9sdicIu3Y+4Ffv/p7kfXkDlWL8WtvVj97+P7tPY6MhmrbSyY7wI0HylkYXT5wh
 d5guaDUBVfKy+CCRU9K76l/cT+gwjxKgVKTUjZcZQFScZTuYWU/oPO8LbU7RAhFhNW7z
 tVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470812; x=1742075612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/olTmy8XTTUA1KMSdUNu/qAD1H3xeJx2k2rmVKE8Uk4=;
 b=M/TwMxzaD5zxYFHY6cQ0B9XJVu8BxdApj/7f7CbHr/0gouedlXhY5EbgdFKRZvMr6O
 hdmwbUr4Juv9gwaaOpk0tZEdZFdWlR+u1ArwRymfxwZQl0rAnlIK7CSpDHl7QJ8ewKJ1
 bEoSZGQ+NwWDBV5Q/tzUB4pKqSn8X1g2WBgN5P12xKqXA7W0p3P1qp5Ai8+l9xnuE6w/
 /YaRJaM73C/PZEUDkHuPNdtTWhsf2GxaJAkLw7zLZhjn33cXVajcLa6cju7j9W0nId03
 kUUrA3LbyBgsc10DNH8t6DKbaFIzVCwGpcAMvoCM0vON3VA8KZBhlloMsg3T0c3EA1am
 CumQ==
X-Gm-Message-State: AOJu0YyzvqjsSJWpQSwm1sVjH8qQM/lyhuzyR7H9V6hMfETugH4uUQe1
 RYEDtpwSNbTULKPvkx9kGJ16Z8vxiAWFBE4eyloWihVgTPDq0pTVTGDhUMsF/8mD6Gro0EGBUfs
 v
X-Gm-Gg: ASbGncuaU56AaM27rKF1Pb9hRs79VKfA7z0iMG/BDomANPodAniR1RhKtKqVwfWjJ8f
 9g7RcJd8EOgZq6yJDuRU6aCbaaM9vmu7OFqmHfWrGl+duaKTIvVIAkoUL0W7o26iMrSK+ut5Jaf
 tF+yk8LPqLJBNGzkUXwj/EBdoOuaM4sk0l6NZYZoU/6L0efPE+ZvNyou2rs2glVbCSsazrs2O2m
 voAbCw50sbRY5Q3GrzK6Gzn39jjVxLk+sSSK8wEypD/MdCPb6pU8pUzF61eWffv6qgb4JhGXpo9
 J5NhyHCRjcbDPnEBZ2+A7i+7oeZdU+FQIvdBDNPt7HB+5Kw=
X-Google-Smtp-Source: AGHT+IEAG+OThRThDUfL415XAS8o9PrgDtTontA1V6DNsu2nirlZSwFnXpHDmGYEffu9Tm70zjvbcA==
X-Received: by 2002:a05:6000:2c5:b0:391:10c5:d1a9 with SMTP id
 ffacd0b85a97d-39132d82751mr4997591f8f.31.1741470812591; 
 Sat, 08 Mar 2025 13:53:32 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2b8bsm9996792f8f.64.2025.03.08.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F2B25F9F8;
 Sat,  8 Mar 2025 21:53:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/31] testing, plugin and maintainer updates
Date: Sat,  8 Mar 2025 21:52:55 +0000
Message-Id: <20250308215326.2907828-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

The following changes since commit 98c7362b1efe651327385a25874a73e008c6549e:

  Merge tag 'accel-cpus-20250306' of https://github.com/philmd/qemu into staging (2025-03-07 07:39:49 +0800)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.0-for-softfreeze-080325-2

for you to fetch changes up to 8db681c98ba043a8c7b5884b3837c8869a978991:

  MAINTAINERS: remove widely sanctioned entities (2025-03-07 22:34:30 +0000)

----------------------------------------------------------------
functional and tcg tests, plugins and MAINTAINERS

  - update and expand aarch64 GPU tests
  - fix build dependence for plugins
  - update libvirt-ci to vulkan-tools
  - allow plugin tests to run on non-POSIX systems
  - tweak test/vm times
  - mark test-vma as linux only
  - various compiler fixes for tcg tests
  - add gitlab build unit tracker
  - error out early on stalled RME tests
  - compile core plugin code once
  - update MAINTAINERS

----------------------------------------------------------------
Alex Bennée (26):
      tests/functional: move aarch64 GPU test into own file
      tests/functional: factor out common code in gpu test
      tests/functional: ensure we have a GPU device for tests
      tests/functional: bail early if vkmark hangs
      tests/functional: skip vulkan tests with nVidia
      tests/functional: expand tests to cover virgl
      tests/functional: update the aarch64_virg_gpu images
      libvirt-ci: bump to latest for vulkan-tools
      tests/vm: bump timeout for shutdown
      tests/tcg: mark test-vma as a linux-only test
      tests/tcg: add message to _Static_assert in test-avx
      tests/tcg: fix constraints in test-i386-adcox
      tests/tcg: enable -fwrapv for test-i386-bmi
      gitlab: add a new build_unit job to track build size
      plugins/api: use qemu_target_page_mask() to get value
      plugins/loader: populate target_name with target_name()
      include/qemu: plugin-memory.h doesn't need cpu-defs.h
      plugins/api: clean-up the includes
      plugins/plugin.h: include queue.h
      plugins/loader: compile loader only once
      plugins/api: split out binary path/start/end/entry code
      plugins/api: split out the vaddr/hwaddr helpers
      plugins/api: split out time control helpers
      plugins/api: build only once
      plugins/core: make a single build unit
      MAINTAINERS: remove widely sanctioned entities

Peter Maydell (1):
      tests/tcg: Suppress compiler false-positive warning on sha1.c

Philippe Mathieu-Daudé (2):
      tests/functional: Introduce the dso_suffix() helper
      tests/functional: Allow running TCG plugins tests on non-Linux/BSD hosts

Pierrick Bouvier (2):
      plugins: add explicit dependency in functional tests
      tests/functional: add boot error detection for RME tests

 MAINTAINERS                                        |   8 +-
 meson.build                                        |   1 +
 include/qemu/plugin-memory.h                       |   1 -
 plugins/plugin.h                                   |   7 +
 bsd-user/plugin-api.c                              |  15 ++
 linux-user/plugin-api.c                            |  15 ++
 plugins/api-system.c                               | 131 ++++++++++++++++
 plugins/api-user.c                                 |  57 +++++++
 plugins/api.c                                      | 171 +--------------------
 plugins/core.c                                     |  10 +-
 plugins/loader.c                                   |  15 +-
 plugins/system.c                                   |  24 +++
 plugins/user.c                                     |  19 +++
 tests/tcg/i386/test-avx.c                          |   2 +-
 tests/tcg/i386/test-i386-adcox.c                   |   6 +-
 tests/tcg/multiarch/{ => linux}/test-vma.c         |   0
 common-user/plugin-api.c.inc                       |  43 ++++++
 .gitlab-ci.d/check-units.py                        |  66 ++++++++
 .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                  |   2 +-
 .gitlab-ci.d/static_checks.yml                     |  22 +++
 bsd-user/meson.build                               |   1 +
 contrib/plugins/meson.build                        |   2 +
 linux-user/meson.build                             |   1 +
 plugins/meson.build                                |  11 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   1 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   1 +
 tests/docker/dockerfiles/alpine.docker             |   5 +-
 tests/docker/dockerfiles/centos9.docker            |   1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |   3 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   3 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   3 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   3 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   3 +-
 tests/docker/dockerfiles/debian.docker             |   3 +-
 .../docker/dockerfiles/fedora-rust-nightly.docker  |   1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker |   1 +
 tests/docker/dockerfiles/fedora.docker             |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker      |   1 +
 tests/docker/dockerfiles/ubuntu2204.docker         |   1 +
 tests/functional/meson.build                       |   6 +-
 tests/functional/qemu_test/__init__.py             |   2 +-
 tests/functional/qemu_test/config.py               |  12 ++
 tests/functional/qemu_test/testcase.py             |  12 +-
 tests/functional/test_aarch64_rme_sbsaref.py       |   3 +-
 tests/functional/test_aarch64_rme_virt.py          |   3 +-
 tests/functional/test_aarch64_tcg_plugins.py       |   5 +-
 tests/functional/test_aarch64_virt.py              |  71 ---------
 tests/functional/test_aarch64_virt_gpu.py          | 133 ++++++++++++++++
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/projects/qemu.yml                    |   1 +
 tests/lcitool/refresh                              |   2 +-
 tests/tcg/aarch64/Makefile.target                  |   3 +-
 tests/tcg/arm/Makefile.target                      |   3 +-
 tests/tcg/i386/Makefile.target                     |   2 +-
 tests/tcg/multiarch/Makefile.target                |   8 +
 tests/tcg/plugins/meson.build                      |   2 +
 tests/vm/basevm.py                                 |   2 +-
 tests/vm/generated/freebsd.json                    |   1 +
 62 files changed, 643 insertions(+), 302 deletions(-)
 create mode 100644 bsd-user/plugin-api.c
 create mode 100644 linux-user/plugin-api.c
 create mode 100644 plugins/api-system.c
 create mode 100644 plugins/api-user.c
 create mode 100644 plugins/system.c
 create mode 100644 plugins/user.c
 rename tests/tcg/multiarch/{ => linux}/test-vma.c (100%)
 create mode 100644 common-user/plugin-api.c.inc
 create mode 100755 .gitlab-ci.d/check-units.py
 create mode 100755 tests/functional/test_aarch64_virt_gpu.py

-- 
2.39.5


