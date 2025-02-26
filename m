Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2590C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI0y-0000y1-Ab; Wed, 26 Feb 2025 09:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0t-0000uO-Tk
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0q-0005dc-5n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso59958965e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578625; x=1741183425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aD8mJlxD2keTACfw2p6EEG00RXoqREFZi/wu7CwDcxo=;
 b=sxDiJz3XMO8HhyZbgpo+RtrtEF4KOUV5AEoPSK1yFoM7+qhwZgfci5t5/x9U7UmG+D
 OiKbLojWHvXTZhCIx6rSjueT8RKJ15IaTqE+FPudgm7bWip2JLQkCl0B2wCCdNyG8xSF
 25dQoFq2XHhcWENjDPLSJ/ecwKW+CzANS1+m5qrkKASVWQJl9sE4t+/2T/4D7jsRarTa
 XM7OrZg2IGQWxpspCkZ1TKjT5ILmoMVn7Pnnm/jtjYt9jUUz+3SyKeZzekshUf2os9up
 GF3b8R52n2UJclN/qiTRnGjrP4OyycnZXkP5F6VrNc0X0qRAs045GHdVE0QqCPbe/gK4
 9yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578625; x=1741183425;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aD8mJlxD2keTACfw2p6EEG00RXoqREFZi/wu7CwDcxo=;
 b=K0hF374gYLAL/2Po7kq77AJOWTXi/mu8SyaM+cEKv+8jsDY72klVgTQfQVXCZ6XOP0
 iQNjqjH1PuV9iWLdxEE1IEa+FDalN7Xo/Ycw6wi/Ws38NKmbIJtydNGM7RLSi+HnzE4r
 /fjq1XbS3xmgEJ9IZqBBtYo7dfv2NY8jHq21q/Z2rapHiC5mw8lplhejM1OwzWZD+wC/
 BkLuam8wfMyeUjTfrs0AwSYNTxBVB+OFU3kcjiLnNFQikkQ/TR7mUPeQUpiCw8pDRugP
 rHRtt0Oh382r9kH3DXTtDBX9+5rkBxRq2S5EmLEzwYw2unhyhE6pXN+lL03HqoHxJMv2
 7oVA==
X-Gm-Message-State: AOJu0YyVXmLKXU5oxxy5svm0cwO1Opxpi4OyrWNsdFWv4xcINDkglwUf
 XxCrbBmURvTtggNKeVkcd5Yrr4pc/0ORAO0oRX/tcRenkyw/zBDlaCm+kgAwjaMxgqFdjpX/bRQ
 bwCI=
X-Gm-Gg: ASbGnctT4QDJguqYQukkm6DHgfpIlcZmD0kK/VXsxRk3h1ofTC0+nfsMKDQB1jvUx4p
 BppKKYL8+QtqHpd4gVa4Ip1B9PiYOB26qKPxrxut0Qiy/nZvaB0FRZNN/+ngaWZ8bFOAwUa3O84
 54Btfw8eYpUTgyrM6Fo/KfHVXdIHilT/gUkimyP4NUSO1vDv1T+ttPTdWskf/aJzsqsz1xfhC9W
 4USRqYZ0/U7NYxneeasnDPD8BHiMFVswn/Zd2tvD+GfOt7FX/iQzzcrvOv0e6MhXks3HS4+rRgP
 TYlTELF9lcLutRgTFuOLygy/QBrm
X-Google-Smtp-Source: AGHT+IEvmtVJRdcQ5FjKraocEINIdzykySmqG8YnoH3o8EsoukYF6IgwU8CmR0zOKqbz4VuEUckD5w==
X-Received: by 2002:a05:600c:3b83:b0:439:86fb:7328 with SMTP id
 5b1f17b1804b1-43ab901559fmr26151585e9.24.1740578625453; 
 Wed, 26 Feb 2025 06:03:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd882602sm5654984f8f.41.2025.02.26.06.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB8195F924;
 Wed, 26 Feb 2025 14:03:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 00/25] maintainer updates for 10.0 softfreeze (gpu/tcg tests,
 plugins, MAINTAINERS)
Date: Wed, 26 Feb 2025 14:03:18 +0000
Message-Id: <20250226140343.3907080-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

I'll see if I can add a test to track the total number as we aim to
clean-up stuff for single binary purposes.

MAINTAINERS

  - updates due to sanctions

I should send out the pre-PR sometime next week, hopefully getting my
10.0 PR submitted with time to spare ;-)

The following still need review:

  plugins/api: split out binary path/start/end/entry code
  plugins/api: use qemu_target_page_mask() to get value
  tests/tcg: enable -fwrapv for test-i386-bmi
  tests/tcg: fix constraints in test-i386-adcox
  tests/tcg: add message to _Static_assert in test-avx
  tests/tcg: mark test-vma as a linux-only test
  tests/vm: bump timeout for shutdown
  libvirt-ci: bump to latest for vulkan-tools (libvirt MR 525)
  tests/functional: skip vulkan tests with nVidia
  tests/functional: expand tests to cover virgl
  tests/functional: ensure we have a GPU device for tests
  tests/functional: factor out common code in gpu test
  tests/functional: move aarch64 GPU test into own file

Alex.

Alex Bennée (22):
  tests/functional: move aarch64 GPU test into own file
  tests/functional: factor out common code in gpu test
  tests/functional: ensure we have a GPU device for tests
  tests/functional: expand tests to cover virgl
  tests/functional: skip vulkan tests with nVidia
  libvirt-ci: bump to latest for vulkan-tools (libvirt MR 525)
  tests/vm: bump timeout for shutdown
  tests/tcg: mark test-vma as a linux-only test
  tests/tcg: add message to _Static_assert in test-avx
  tests/tcg: fix constraints in test-i386-adcox
  tests/tcg: enable -fwrapv for test-i386-bmi
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
  MAINTAINERS: remove widely sanctioned entities

Philippe Mathieu-Daudé (2):
  tests/functional: Introduce the dso_suffix() helper
  tests/functional: Allow running TCG plugins tests on non-Linux/BSD
    hosts

Pierrick Bouvier (1):
  plugins: add explicit dependency in functional tests

 MAINTAINERS                                   |   7 +-
 meson.build                                   |   1 +
 include/qemu/plugin-memory.h                  |   1 -
 plugins/plugin.h                              |   7 +
 bsd-user/plugin-api.c                         |  15 ++
 linux-user/plugin-api.c                       |  14 ++
 plugins/api-system.c                          | 131 ++++++++++++++
 plugins/api-user.c                            |  57 ++++++
 plugins/api.c                                 | 171 +-----------------
 plugins/loader.c                              |  15 +-
 plugins/system.c                              |  24 +++
 plugins/user.c                                |  19 ++
 tests/tcg/i386/test-avx.c                     |   2 +-
 tests/tcg/i386/test-i386-adcox.c              |   4 +-
 tests/tcg/multiarch/{ => linux}/test-vma.c    |   0
 common-user/plugin-api.c.inc                  |  43 +++++
 .gitlab-ci.d/cirrus/freebsd-14.vars           |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars             |   2 +-
 bsd-user/meson.build                          |   1 +
 contrib/plugins/meson.build                   |   2 +
 linux-user/meson.build                        |   1 +
 plugins/meson.build                           |   8 +-
 .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |   1 +
 .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |   1 +
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
 tests/functional/meson.build                  |   4 +-
 tests/functional/qemu_test/__init__.py        |   2 +-
 tests/functional/qemu_test/config.py          |   6 +
 tests/functional/test_aarch64_tcg_plugins.py  |  11 +-
 tests/functional/test_aarch64_virt.py         |  71 --------
 tests/functional/test_aarch64_virt_gpu.py     | 131 ++++++++++++++
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/lcitool/refresh                         |   2 +-
 tests/tcg/i386/Makefile.target                |   2 +-
 tests/tcg/plugins/meson.build                 |   2 +
 tests/vm/basevm.py                            |   2 +-
 tests/vm/generated/freebsd.json               |   1 +
 53 files changed, 520 insertions(+), 284 deletions(-)
 create mode 100644 bsd-user/plugin-api.c
 create mode 100644 linux-user/plugin-api.c
 create mode 100644 plugins/api-system.c
 create mode 100644 plugins/api-user.c
 create mode 100644 plugins/system.c
 create mode 100644 plugins/user.c
 rename tests/tcg/multiarch/{ => linux}/test-vma.c (100%)
 create mode 100644 common-user/plugin-api.c.inc
 create mode 100755 tests/functional/test_aarch64_virt_gpu.py

-- 
2.39.5


