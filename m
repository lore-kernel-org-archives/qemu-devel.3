Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49780C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trbe8-0006AK-Bi; Mon, 10 Mar 2025 07:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trbe5-00069b-7D
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:50:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trbe1-00075K-Oo
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:50:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1844339f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741607401; x=1742212201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=68ZVYC3i6pbU9jPpcUojqydpDLEnl4MXVo9+wUYL1ak=;
 b=KQ3a0OUGC4UjpkhBG56NGL/th0fHDmVZP2YyjiTPcO+qabOqYIiGV/70HwMH/ji4Yt
 3LgFyiSzfVez/74rLVxF3PAwUT8Pmu/w0mHKFS8kNbkyR/ouaonYcKLLfs14cLO7RkQ2
 o1NmYJ3hiv7T19BxGXcXbRu8dKY3ihtekUSTkSgcVrQVQfzSL+bVwE0p8DwUrtIrIZxK
 JEwhlLNTlLglQqUB1FvTqC24elzbjjii0lWC4kxiADgNQ6IxVO4AhcsyIduzxXpbLbOm
 Bwt6qrasmQ5kx6K8mAlCYLP8yRMHC3d3kXFabUizvjr6Eu8cNv0uTaWZskqKaO10LIIr
 GngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741607401; x=1742212201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68ZVYC3i6pbU9jPpcUojqydpDLEnl4MXVo9+wUYL1ak=;
 b=j2MlTURCb3YM4//zld/wTFotlsEEw4fH7jkE5WtP5g/o6e5lGGmwdYlYNg6IVEUJY6
 qTG35AHcpp7Y5DrWdD1QKLJtLLkT++8JL5tb21eZDNODAayQkpm+TZjJ+stUrUl6O/xc
 i064Ezn8PexYM+Tq7P0rpCGAWHcE9/frxMwXWuo5dTaVPmU9gdn+3yEHfKB51jpPF7ML
 /mpJfVyV9cfoRn1AxxAuGvCtq6E/QX6qF8rlSat66bcS91XkSJghe/E49ythMUMh+Kjm
 wRi3W72JFcjWSHjunFvzGiRz1W+04hfy1fwt/68v+7maVCkyaUjOW+wc3e6/QP2slWd3
 sGcA==
X-Gm-Message-State: AOJu0Yxqq562GpMOcPBa16laUA/wMR6uypovb1cNHGNUFMO3pGnJE1Bp
 +iSrsDewUbp4cRa87sCQVpdipGXSfl8KjgoumGkSgekTz1dj5aG885W1s63KNdM=
X-Gm-Gg: ASbGnctrCxCQzd/cICYNtT+jwLGWvvM5SGiuJHMvy0nGPGc1hfWWR2RuMkW4iAgneNw
 zN/iPm3g+I+jNmNr0pBFhVF/UjezwI4sapoevuXIsXNRAzQTN7AA8ND10QKHEKZWFnp2dkS/7YU
 0Q+FG6PhrCB/xfcDcdqTT0O3SG+zY7GZZWchr+MkKg6E/MGNdRTQviIUVmJAmBXj+lCtQ3UUfBC
 ttItBBYy1Ov/QaQU76bSxAfxFO9yfmjSHGi4HPdmwst+JNpP0KL4+oOtese7cJk2cEbvy/SVAOy
 kW8IB/Ymf1ChqbV7iVHWnRwzL3FcJSuEguKhzmrRe8plXK8=
X-Google-Smtp-Source: AGHT+IE9zqVWenod3+tE+Lc/2jQKybd5NPdnjGjJ7V23kTMrnglmSU2CkTpgywjYOfQNAOQk5iOPOg==
X-Received: by 2002:a5d:47c8:0:b0:391:30b9:556a with SMTP id
 ffacd0b85a97d-39132d06e7fmr8217394f8f.7.1741607399402; 
 Mon, 10 Mar 2025 04:49:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba848sm14332525f8f.4.2025.03.10.04.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 04:49:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E22385F748;
 Mon, 10 Mar 2025 11:49:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/31] testing, plugin and maintainer updates
Date: Mon, 10 Mar 2025 11:49:57 +0000
Message-Id: <20250310114957.3401710-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

The following changes since commit 5136598e2667f35ef3dc1d757616a266bd5eb3a2:

  Merge tag 'accel-cpus-20250309' of https://github.com/philmd/qemu into staging (2025-03-10 13:40:48 +0800)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.0-for-softfreeze-100325-3

for you to fetch changes up to 0d3dea7d7a49c22897e7435e8e09d9f587bc56c8:

  MAINTAINERS: remove widely sanctioned entities (2025-03-10 10:30:01 +0000)

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
 tests/functional/test_aarch64_virt_gpu.py          | 137 +++++++++++++++++
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
 62 files changed, 647 insertions(+), 302 deletions(-)
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


