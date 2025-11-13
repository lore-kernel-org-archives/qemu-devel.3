Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69FACD5BBF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWF-0007U4-3P; Thu, 13 Nov 2025 05:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWD-0007Qd-D6
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:33 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUW9-0007Gu-KS
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:33 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64320b9bb4bso1464507a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029527; x=1763634327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=chAjRaWX6mnOVMi1DnkIGRryUwQ2jcnzVVnHr9nvJJY=;
 b=PCVmHN7K/gsrj09WsB09BROqaI5zfORm3INQxKhnwPCoeD1K6SFmtzLJqJ0dx/FIJ/
 ZLNQcDh4UOEEYwwZ9Hmg5KoGB4LOi+d6y8EwGw9FURSkVLGt4vkXVXzkUQRTePHmm/9Y
 JgmJ+XjFjVLfUgJECUoN65KxmJ7QT3wZ1ot6N1+WJ+J4v33wBIosa/Yshow3vBikdcSK
 04VyegjIIeYkIo0pxML14S2PwE+WuysM6E3MbRIG8FEX+UF954gmfOCKmxDppmY3Xyel
 tpD+2TReiiumh6NcJtYQnkdGvCYIH+dDHOLIj/WpR2rO62fQQTrDLmgwkSOVoMLv8Avf
 2acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029527; x=1763634327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chAjRaWX6mnOVMi1DnkIGRryUwQ2jcnzVVnHr9nvJJY=;
 b=gxRq4XQlGCj8XYjBFWD5+HCEEDdra5l5omrvfHOlCSa/sLqkTWqvlAzS1PTnR6CtnS
 WvkV9AiA8Rp/bE1FJ7m4aGvxqwNcIDlUSS2wrqjd2uDD/h4GCvek8MKL2JzCGbVVuTM/
 Q5PrxQc1kjnhCwm20lGnMR13W+lA62k6WAiFeeLbvKm9a8epEvy4xDK4j3bBvlA7m3St
 Jr7wgoDEJ2xCs7Qsjs11w5M25K6D7H7XPw73XszRHq6iSPh8hquUvE66bGVXlszLi0Ml
 khLnlZ6Losd1levP9cjLVfbw0sj1sv5XjW4+aS2zualuAWytxh4dnBSq5lnzy9wReXRw
 humA==
X-Gm-Message-State: AOJu0YxgaXCDLLp6UKjeyjfO8MNgh3DZ4vMnHxNZAmJXGIyvfjnaXL3e
 bOr3Kzmd4EgrxUp+9JcF2egIrB9cGr0QQ2T6HiQxGNUPxtAP2MbUwvLJlZSlqHQWDwA=
X-Gm-Gg: ASbGncu1yEMZLXtHLt5orFTVxRPnhNGcoev4i+sBGicHupUqMVfZsNd+eL+PMgoUKTW
 8OqHpJ6ILpCBUzmevg9qgJo8eX5XIJog4DLX9lRxxpZ2ffbWS3cXYVaEKR5CU0PUteznuwydKYY
 9BiOAGtiytFAvcyJZf0JpxbekK2Jb7HCQh/2KZOjfrKuzzqFy+i85y2eMAe8QdU5OuBr43/MnNp
 MQRlDCWC5K5ZvzElmPbrx/6vBp0NAd7KcyAGVXRLA3ejLTLQiCgpyUkZur4rpFOsgzlRzK0ZQAh
 Zts7VBS5mOGU0ZDu2xzE8ofhgUYzfKfexGNp8H5+D1/rcFP8BSAKTiMmkPOcHlyi3sH3LvvsUE4
 wH/jSvlYwQsiPvH5RuEmgp2Q6dT4WS8rUhonRgkNCdUE7dn1xc9lrfRCq6DcudHJ9WRGHB1SlBB
 r/
X-Google-Smtp-Source: AGHT+IFNhVB5nKc+PNdaIUHZX7Qe8gamJJJYytWacS2LD6k+o9vTaJU+dJq26dCkwbUdemwsE2Oohg==
X-Received: by 2002:a05:6402:2791:b0:640:b625:b920 with SMTP id
 4fb4d7f45d1cf-64334c9bcdamr2432223a12.6.1763029527091; 
 Thu, 13 Nov 2025 02:25:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a2d746bsm1158938a12.0.2025.11.13.02.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF5825F7DF;
 Thu, 13 Nov 2025 10:25:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>
Subject: [PATCH v2 00/18] testing/next cleanups (docker, functional) - pre-PR
Date: Thu, 13 Nov 2025 10:25:06 +0000
Message-ID: <20251113102525.1255370-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have a new ppc64le custom runner box courtesy of OSUOSL. The
ansible scripts where updated in the last pull request and now we can
turn on the runner. The initial runs showed some issues so for v2 I've
kept the tests basic.

On the subject runners I've done some more template clean-ups to
improve maintainability and also tried to stop the custom runners
appearing when not prompted for. I've iterated on that for v2.

Finally fileserver.linaro.org is being shutdown at the end of the year
so I have migrated the tests to a new server. Those changes have a Cc:
qemu-stable@nongnu.org tag as they will need back-porting.

See the individual commits for change history. The following still
need review:

  gitlab: make custom runners need QEMU_CI to run
  gitlab: simplify the ubuntu-24.04-aarch64 rules
  gitlab: use template for ubuntu-24.04-s390x jobs
  tests: move test_virt_gpu to share.linaro.org
  tests: move test_kvm to share.linaro.org

Alex.

Alex Bennée (17):
  tests/docker: drop --link from COPYs in emsdk docker
  libvirt-ci: bump libvirt-ci to latest version
  tests/lcitool: update ENV stazas outputted by refresh
  tests/docker: add coreutils to the package list
  gitlab: add initial ppc64le custom-runner test
  tests: move test_xen assets to share.linaro.org
  tests: move test_virt assets to share.linaro.org
  tests: move test_netdev_ethtool to share.linaro.org
  tests: move test_kvm_xen to share.linaro.org
  tests: move test_kvm to share.linaro.org
  tests: move test_virt_gpu to share.linaro.org
  gitlab: use template for ubuntu-24.04-s390x jobs
  gitlab: simplify the ubuntu-24.04-aarch64 rules
  gitlab: suppress custom runners being triggered by schedule
  gitlab: make custom runners need QEMU_CI to run
  gitlab: make the schedule rules a bit more general
  gitlab: add a weekly container building job

Pierrick Bouvier (1):
  docs/about/emulation: update assets for uftrace plugin documentation

 docs/about/emulation.rst                      |  20 +-
 docs/devel/testing/ci-jobs.rst.inc            |   6 +
 .gitlab-ci.d/base.yml                         |   4 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars           |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars             |   2 +-
 .gitlab-ci.d/container-template.yml           |   5 +
 .gitlab-ci.d/containers.yml                   |  39 ++++
 .gitlab-ci.d/custom-runners.yml               |   1 +
 .../custom-runners/debian-13-ppc64le.yml      |  41 ++++
 .../custom-runners/ubuntu-24.04-aarch64.yml   |  45 ++---
 .../custom-runners/ubuntu-24.04-s390x.yml     | 185 +++++++-----------
 .../ci/setup/debian/debian-13-ppc64le.yaml    |   1 +
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   1 +
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   1 +
 tests/docker/Makefile.include                 |  11 ++
 tests/docker/dockerfiles/alpine.docker        |  11 +-
 tests/docker/dockerfiles/centos9.docker       |  11 +-
 .../dockerfiles/debian-amd64-cross.docker     |  21 +-
 .../dockerfiles/debian-arm64-cross.docker     |  21 +-
 .../dockerfiles/debian-armhf-cross.docker     |  21 +-
 .../dockerfiles/debian-i686-cross.docker      |  21 +-
 .../dockerfiles/debian-mips64el-cross.docker  |  21 +-
 .../dockerfiles/debian-mipsel-cross.docker    |  21 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |  21 +-
 .../dockerfiles/debian-riscv64-cross.docker   |  24 ++-
 .../dockerfiles/debian-s390x-cross.docker     |  21 +-
 tests/docker/dockerfiles/debian.docker        |  13 +-
 .../dockerfiles/emsdk-wasm32-cross.docker     |   8 +-
 .../dockerfiles/fedora-rust-nightly.docker    |  11 +-
 .../dockerfiles/fedora-win64-cross.docker     |  19 +-
 tests/docker/dockerfiles/fedora.docker        |  11 +-
 tests/docker/dockerfiles/opensuse-leap.docker |  11 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |  11 +-
 tests/functional/aarch64/test_kvm.py          |   4 +-
 tests/functional/aarch64/test_virt.py         |   5 +-
 tests/functional/aarch64/test_virt_gpu.py     |   8 +-
 tests/functional/aarch64/test_xen.py          |  12 +-
 tests/functional/x86_64/test_kvm_xen.py       |  17 +-
 .../functional/x86_64/test_netdev_ethtool.py  |  14 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/lcitool/refresh                         |   6 +-
 tests/vm/generated/freebsd.json               |   1 +
 43 files changed, 381 insertions(+), 351 deletions(-)
 create mode 100644 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml

-- 
2.47.3


