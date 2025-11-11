Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF597CD13D2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 17:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIs03-0005v1-05; Tue, 11 Nov 2025 12:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzm-0005WH-BC
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:32 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIrzk-0003uM-3w
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 12:17:29 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6419aaced59so3584616a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762881446; x=1763486246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7PGrRKAvpWgdql03IMxILc4BiTJmKYPYpApvfDWwzvA=;
 b=TbBjO6LMtm74z3nbNyoj7IPufsDg7Eo40EDJkSseRfgeuZvg18d/q69clCZUes9khr
 IvFMdIrggdyCG5pSjgWm9+GfJbHsSiz4uaeb6GC9ybYozKUf1+SC6sxSU7hbFN9PWs3V
 mmG8UFqJ8fGYgeNzHcsbY89vtQuoV6bcQZQgVOCyi+sCuw4MjY4bHySnla1MmXRt9GnQ
 mApb3gXmpTWVJxOMlWG3W70KTNQIodAOMrUMQXstiXa73CWkjyU07pnBsCOPhCHxoNQf
 zWMaXe68wBnQ2wgjmaOQ+3MKUyFLhZH8UHr7bdZLiRlYotDc9QRmm3P71V2h4PD6cbiz
 0gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762881446; x=1763486246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PGrRKAvpWgdql03IMxILc4BiTJmKYPYpApvfDWwzvA=;
 b=GlN77rWDTWzMT/WBWxLzRgBRvUG6kJz8LpGo7u5HqCjgTQCgU9PkR5yHEB99+2hP0k
 jaMjsRhHDmpTOqYhPy6SLcsua4LU2fIdokGi9U0pbRSk4uS7B7K2B4EOeb806rU8uC94
 8zo0ckGgwtQ2kVKFLOw2ondHR9H+apbOt0515ZuLhpoHoxI9FE898qnFLEaQwEAKh/0l
 xUH05ZkajdhxJzqAYgEKTahXrE0oSUvq7C1PbG7s0iUmKYazjbWNgkL/8+gY0wuSFhYC
 z39lNlC1b2QpMaQX/XkyHoSkagGYc0lg/aovxRtw1vuaMEjGS1za7ugPr7oOjynZrrGZ
 tJBg==
X-Gm-Message-State: AOJu0YxQKFPUdTXhUM1vAmVQVMBDBunt+TfdfYRKEP6EcEe/sGVkRqOV
 aOIv9Djpoz9WBq2zy98Hxqp3Kdl/4cmWQJMUkI99wcruNkNzU6TVPBG1MfIs23uaVYU=
X-Gm-Gg: ASbGncs7m3yg0zx7L2Hx0XkDjVzma0qhg139FBp7SBQW60jtoSIj71Rr+r7fq3VIUI8
 M01MOAeL+LDfJ752LHBJtLz5W7HB08lWbRUBh89vIa9atOxDG5+egz1qIG3ptl3ZXMEgjIIT5vr
 mSz94D4Af3aIdxkV23cPAhGqfMPeH+EX7LZgLLkmFfMZX/iC2poZYGFLR6ZaTYtl88aLjkK5x8w
 rCmy92V4WAhAYgHnC8KfxmVTbaZ3DJwnRjhvo4kuUFIvMAoMREWzErn7ziGLpPF6Ft4LQiRAbTv
 YmvwYTozDZPn/3uXHSecF0jeN4WA1S1Ya+xb7OyrVUf4WyGCHNW7jxipjvWVmQYTc72Ftnfuzi4
 ScZlOOM7BMK5Wf9TSBwye+4Lh8HQvvOAEnZskZv1/UHkaNhWSujeLOlawzAaRHAoYpvbrQe8l0Q
 VC
X-Google-Smtp-Source: AGHT+IEwSTQ9giAUEpNEQqdy9Mb+KGSmZ4U/SBQjFBhbZiXZVql4E4LlqT2bTNk3BMmFNZmAjcWUOQ==
X-Received: by 2002:a05:6402:2554:b0:641:27d8:ec3f with SMTP id
 4fb4d7f45d1cf-6415e8126c2mr10443160a12.29.1762881445745; 
 Tue, 11 Nov 2025 09:17:25 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f862697sm13947763a12.25.2025.11.11.09.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 09:17:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F51E5F8FC;
 Tue, 11 Nov 2025 17:17:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Ed Maste <emaste@freebsd.org>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 00/16] testing/next cleanups (docker, functional)
Date: Tue, 11 Nov 2025 17:17:07 +0000
Message-ID: <20251111171724.78201-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

We have a new ppc64le custom runner box courtesy of OSUOSL. The
ansible scripts where updated in the last pull request and now we can
turn on the runner.

On the subject runners I've done some more template clean-ups to
improve maintainability and also tried to stop the custom runners
appearing when not prompted for.

Finally fileserver.linaro.org is being shutdown at the end of the year
so I have migrated the tests to a new server. Those changes have a Cc:
qemu-stable@nongnu.org tag as they will need back-porting.

Please review,

Alex.

Alex Bennée (15):
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
  gitlab: suppress custom runners being triggered by schedule
  gitlab: make the schedule rules a bit more general
  gitlab: add a weekly container building job

Pierrick Bouvier (1):
  docs/about/emulation: update assets for uftrace plugin documentation

 docs/about/emulation.rst                      |  20 +-
 docs/devel/testing/ci-jobs.rst.inc            |   6 +
 .gitlab-ci.d/base.yml                         |   4 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars           |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars             |   2 +-
 .gitlab-ci.d/container-template.yml           |   4 +
 .gitlab-ci.d/containers.yml                   |  36 ++++
 .gitlab-ci.d/custom-runners.yml               |   1 +
 .../custom-runners/debian-13-ppc64le.yml      |  40 ++++
 .../custom-runners/ubuntu-24.04-aarch64.yml   |  12 +-
 .../custom-runners/ubuntu-24.04-s390x.yml     | 181 +++++++-----------
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
 tests/functional/aarch64/test_kvm.py          |   7 +-
 tests/functional/aarch64/test_virt.py         |   5 +-
 tests/functional/aarch64/test_virt_gpu.py     |  16 +-
 tests/functional/aarch64/test_xen.py          |  12 +-
 tests/functional/x86_64/test_kvm_xen.py       |  17 +-
 .../functional/x86_64/test_netdev_ethtool.py  |  14 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/lcitool/refresh                         |   6 +-
 tests/vm/generated/freebsd.json               |   1 +
 43 files changed, 371 insertions(+), 330 deletions(-)
 create mode 100644 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml

-- 
2.47.3


