Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B98C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiJ-0006K5-Ax; Tue, 04 Mar 2025 17:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagz-0005Mk-6N
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:49 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagw-0006Tw-AQ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:48 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e56b229d60so442625a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127084; x=1741731884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jB70xwESzZMcF2byQH3dMmxVnsR0wVMNkKLR27tW5lE=;
 b=sWZSevqqojNOCiZ8Zfho0izJRy1g7+CkbHAGTS7OEJWRTUmRNZjbyL1+3vgKmNphBd
 20xTXjBGmpXzBIrgIE8FM9+7NjMvMctXj4qHvfQITwrdtazrAY10aQBlXVKWYxGM92eh
 V/zs/17Wdi4Rcq4cmZaUSElaZgw6+1IxGtyyA/wB/6CcYh2lepuVnDKOSh79cqvquTBT
 Rpmv6Uii5B8NjXi+NwRDsjp4QjzYHNorfSp6JgGHgMzQ+18JFjG8vwWDrzPGjRcyx61R
 NhsKmzhea5btiU3AT/oWUf1VyX5zvWBKnGgz0K1UHuLWiR1hfCLri1vqpxFgvH8akDvr
 XgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127084; x=1741731884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jB70xwESzZMcF2byQH3dMmxVnsR0wVMNkKLR27tW5lE=;
 b=UNIsMtl21BoViefhBL+VwZ3VlGbA5UCtIQhzN4a0Ni5G8nIfqISMQ6HeZhevpfurZ6
 N9W5BgwuzO9QDJOT/ML9GAjZADtrE6fgZILqBV8Lc8jN6w9+UwIucpiroSO2LhGy3ssw
 0XJpG43Aez1CQpznkPbHwARIxomjb2x1jeqU8RVqk31Hbtl2i5amcUpcw813mz4+ufGt
 9O2lmsKptSSYM7qHUMXiXLMPsganEqWEEZFHuujQARyGDaejxoyf1QJPMqWlnXWrlX15
 17XL+w29MWjgNR5c3RM1C/HMU1w1S2WEhVhuu6CyAPvM3OdGGqXKZVVTc55t84Wgvx6r
 jObw==
X-Gm-Message-State: AOJu0Yx3NkViPoVmJNLdukTczrQAJtYEXxBy77P9iz8t9KBJo7KLlL8G
 QgVNCATs1YJkLL4bvFeNH9DsVBDjKke/+gOD1l//H8tA/E9lpt/yHz0GGXARyT4=
X-Gm-Gg: ASbGnctGlpxIRa8WjbhPHp3tWemzwbDv520kbLBOyBHzAbA8NgLU6WYuUKwnx9cGagf
 MOM67u1krcyxSrJR2wKu88Qq+Tr4rG/wrwUVT3q0o1qfbrsgi7rVb7pU6fCk42nXg57dXTzsWbE
 7iJEWPUiSLTrQn6VaBqB/+Q3zRb61JHJT4vzLHm/Sp+n9oPkXsNYVgR2FD9/sDpWXfqRxgpxM0T
 5ZiswaceRdAAUncEPdhoKAOFlwYWUkAgS75cOXmNQOhFUtQttydzhBjuHTims5F+NMQQs/tCbnc
 0GmTMgWsYLH++ubV7UmBsCGoX/qSM8yEkhGZzLAjfiOx1c4=
X-Google-Smtp-Source: AGHT+IHUW2AM3YcL2E1/BkSH0wBoF7iv5vkOX+M0DE69d0tf05QvZWc+8xc34fu30xcc3KPqZKDbyQ==
X-Received: by 2002:a17:907:8689:b0:abf:7776:7e17 with SMTP id
 a640c23a62f3a-ac20ef7d0ddmr75997866b.19.1741127083909; 
 Tue, 04 Mar 2025 14:24:43 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e77dff28sm254369066b.24.2025.03.04.14.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 664F65F932;
 Tue,  4 Mar 2025 22:24:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 00/32] maintainer updates for 10.0 softfreeze (gpu/tcg
 tests, plugins, MAINTAINERS) pre-PR
Date: Tue,  4 Mar 2025 22:24:07 +0000
Message-Id: <20250304222439.2035603-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

As we rapidly approach softfreeze (due March 11th) its time to collect
together what I'm planning to merge for this release.

Testing

  - expand the aarch64 GPU tests
  - bump libvirt-ci for vulkan-tools
  - some fixes for clang compile of tcg

I've dropped the host-gpu patch in favour of just skipping the test in
python when we detect nVidia drivers.

The clang fixes are part way to removing the skip we have in
configure:

      case $target_arch in
        i386|x86_64)
          if $target_cc --version | grep -qi "clang"; then
            continue
          fi
          ;;
      esac

So that we can build tcg tests on the BSDs (at least for native
guests) and widen the testing. The work is unfinished but anyone wants
to tackle it just patch out the above bit in configure and try and
build and run check-tcg.

Plugins

  - reduce the total number of compilation units
  - I have added a gitlab script to track the total number of build units

Misc

  - MAINTAINERS updates due to sanctions
  - meson.build split debug change

I should send out the pre-PR sometime next week, hopefully getting my
10.0 PR submitted with time to spare ;-)

The following still need review:

  meson.build: default to -gsplit-dwarf for debug info
  plugins/core: make a single build unit
  gitlab: add a new build_unit job to track build size
  tests/tcg: fix constraints in test-i386-adcox
  tests/functional: update the aarch64_virg_gpu images
  tests/functional: bail early if vkmark hangs
  tests/functional: factor out common code in gpu test
  tests/functional: move aarch64 GPU test into own file

Alex.

Alex Bennée (27):
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
  meson.build: default to -gsplit-dwarf for debug info

Peter Maydell (1):
  tests/tcg: Suppress compiler false-positive warning on sha1.c

Philippe Mathieu-Daudé (2):
  tests/functional: Introduce the dso_suffix() helper
  tests/functional: Allow running TCG plugins tests on non-Linux/BSD
    hosts

Pierrick Bouvier (2):
  plugins: add explicit dependency in functional tests
  tests/functional: add boot error detection for RME tests

 MAINTAINERS                                   |   7 +-
 meson.build                                   |   8 +-
 include/qemu/plugin-memory.h                  |   1 -
 plugins/plugin.h                              |   7 +
 bsd-user/plugin-api.c                         |  15 ++
 linux-user/plugin-api.c                       |  15 ++
 plugins/api-system.c                          | 131 ++++++++++++++
 plugins/api-user.c                            |  57 ++++++
 plugins/api.c                                 | 171 +-----------------
 plugins/core.c                                |  10 +-
 plugins/loader.c                              |  15 +-
 plugins/system.c                              |  24 +++
 plugins/user.c                                |  19 ++
 tests/tcg/i386/test-avx.c                     |   2 +-
 tests/tcg/i386/test-i386-adcox.c              |   4 +-
 tests/tcg/multiarch/{ => linux}/test-vma.c    |   0
 common-user/plugin-api.c.inc                  |  43 +++++
 .gitlab-ci.d/check-units.py                   |  66 +++++++
 .gitlab-ci.d/cirrus/freebsd-14.vars           |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars             |   2 +-
 .gitlab-ci.d/static_checks.yml                |  22 +++
 bsd-user/meson.build                          |   1 +
 contrib/plugins/meson.build                   |   2 +
 linux-user/meson.build                        |   1 +
 meson_options.txt                             |   2 +
 plugins/meson.build                           |  11 +-
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |   1 +
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |   1 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/docker/dockerfiles/alpine.docker        |   5 +-
 tests/docker/dockerfiles/centos9.docker       |   1 +
 .../dockerfiles/debian-amd64-cross.docker     |   3 +-
 .../dockerfiles/debian-arm64-cross.docker     |   3 +-
 .../dockerfiles/debian-armhf-cross.docker     |   3 +-
 .../dockerfiles/debian-i686-cross.docker      |   3 +-
 .../dockerfiles/debian-mips64el-cross.docker  |   3 +-
 .../dockerfiles/debian-mipsel-cross.docker    |   3 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   3 +-
 .../dockerfiles/debian-s390x-cross.docker     |   3 +-
 tests/docker/dockerfiles/debian.docker        |   3 +-
 .../dockerfiles/fedora-rust-nightly.docker    |   1 +
 .../dockerfiles/fedora-win64-cross.docker     |   1 +
 tests/docker/dockerfiles/fedora.docker        |   1 +
 tests/docker/dockerfiles/opensuse-leap.docker |   1 +
 tests/docker/dockerfiles/ubuntu2204.docker    |   1 +
 tests/functional/meson.build                  |   6 +-
 tests/functional/qemu_test/__init__.py        |   2 +-
 tests/functional/qemu_test/config.py          |  12 ++
 tests/functional/qemu_test/testcase.py        |  12 +-
 tests/functional/test_aarch64_rme_sbsaref.py  |   3 +-
 tests/functional/test_aarch64_rme_virt.py     |   3 +-
 tests/functional/test_aarch64_tcg_plugins.py  |   5 +-
 tests/functional/test_aarch64_virt.py         |  71 --------
 tests/functional/test_aarch64_virt_gpu.py     | 133 ++++++++++++++
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/lcitool/refresh                         |   2 +-
 tests/tcg/aarch64/Makefile.target             |   3 +-
 tests/tcg/arm/Makefile.target                 |   3 +-
 tests/tcg/i386/Makefile.target                |   2 +-
 tests/tcg/multiarch/Makefile.target           |   8 +
 tests/tcg/plugins/meson.build                 |   2 +
 tests/vm/basevm.py                            |   2 +-
 tests/vm/generated/freebsd.json               |   1 +
 64 files changed, 650 insertions(+), 303 deletions(-)
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


