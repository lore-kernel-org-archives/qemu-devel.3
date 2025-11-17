Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A87FCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1Uj-0003lQ-TR; Mon, 17 Nov 2025 10:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UK-0003c7-4o
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:58 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UG-0007wB-Rb
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:55 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3ad51fecso3244661f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394590; x=1763999390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YxJ/zi1XYYElkuEg504MvPkurULcHHt1PpfSLGfoXJ8=;
 b=v3wjBXm1mDgvCE+jbygpg46GVT6OFxoMSKsMCKbkqEXMaqOHr4CTTuN+55s0Si23kV
 s24W7kGMbWzIsNKp1tCfXadc8hFzYappLg/UdlXX1EnedqXwEuZpmQFU++48CsQXvdHO
 cz1P4Mf5vVFqBX/AQ+mIUJlFI8GOWBS9oyC1GdR+6LVC4/tYQACZQghYsk0b71u00PkO
 zH0maOoenIBQclxBqYOPtiBtuFW3MomI0n7dTbHrDgz7eRJL8vI/dls8NGFPOXMES0Nc
 NpBW70u4cijKSXUBjlp+QA+NC4fPUKc7cgnhYZALkAUUMf1Lvh7bCWDeWkp4nzFgwvJY
 5BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394590; x=1763999390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxJ/zi1XYYElkuEg504MvPkurULcHHt1PpfSLGfoXJ8=;
 b=vKLRId0Ug/ydaySl8g658DIhI8HwFRMQc9fA1oDbVNbknKLJoy+1j3BgtNwH4j6ntx
 hULZ2RoAFIm0vChURIpHi6u8j5k6n3I6G6MRwsvLHfcu4DV+SbzG/KFeOBYGfcHKMpww
 8lw+1K0CM2wMAzM9Ywn7vJwRQCS9vzi2kL1GVqKdkxnlojYTxCGepCeXmDD2eK9sLJDu
 DLrYrrtKHJcP5Tfr7gGKYaW+h9ihTRnZM234PAW5T4gQDRBLrQSvbqco8e0D1k/iOYOR
 KQFQtm9QomPFsl05eF2Qt2VW5rsW6d9nxKZR+zJ03AsMStagI0HEEn1Mrjef2nHrMmgm
 h4KQ==
X-Gm-Message-State: AOJu0Yz4r3fLdyPKmjWSFu3iKyMHfUmzslMuTK2SHpv+D4E91OKmKuvo
 tAmfeR3L6mM8yhc8np2db7Sm25Po3amwzOH2vo7NUaojQKXPQyylQWIES6GR7ioeGI6zX4d8EnK
 2p03x
X-Gm-Gg: ASbGncsJsROZiXm57WDgW+UheN9YqM9UBb8RCrdPCau3DdaS6jIsS2hUV6djKPzrjX6
 H3fM5XkFYh30scYxaiyzUJn45VVs0gQx6qOMGoGs9f/MISmIQrqZcWrkfzJGTpRZ1fiDpAiGgSb
 R+16xvMTUOEnsCOSIDdOKhTKGIvZuwRAwszhTpJa8o0r4rtX+1J+SxkgF9JpohBlFVQUbGk5SI6
 Nwu1s8EzmAnjtkQAxzm13RJNd2qK0svEM9vPeXSGR8QplqBz1XuyPvyzH/2lvqkTRutYCc8gEQE
 73YDekOc+K3TCUP86Pnyz/nefg0ffzfo+0q3HkEAYZOm7A6Qpx8mLzdfpwyrJgorvGTw4d3kiPf
 3S0yIDTiSQBXRZ0XvfjUl4l5gFRzK9nmZgGGFGFdGOZ07rFfRW8ZfcHEtBeleI2zPg+12J+QQAv
 Wumo9NHe7pi44=
X-Google-Smtp-Source: AGHT+IEm4vivApyfd48VqYwU8y4YaH9SFlakPfiC3DKBD36vf6rlGEDlZ2+3GSNalxokx7HnuYFiqA==
X-Received: by 2002:a05:6000:4024:b0:42b:40b5:e683 with SMTP id
 ffacd0b85a97d-42b59349a6amr12142697f8f.23.1763394589574; 
 Mon, 17 Nov 2025 07:49:49 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm26515816f8f.9.2025.11.17.07.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 30B2E5F76E;
 Mon, 17 Nov 2025 15:49:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/18] testing updates for 10.2
Date: Mon, 17 Nov 2025 15:49:29 +0000
Message-ID: <20251117154948.4122164-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

The following changes since commit e88510fcdc13380bd4895a17d6f8a0b3a3325b85:

  Merge tag 'pull-target-arm-20251114' of https://gitlab.com/pm215/qemu into staging (2025-11-14 17:59:05 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-171125-1

for you to fetch changes up to 11a4716211766af6058ad517d73da97f37475e39:

  gitlab: add a weekly container building job (2025-11-17 15:43:35 +0000)

----------------------------------------------------------------
testing updates for 10.2

  - fix emsdk image for podman
  - update lcitool and clean-up ENV stanzas
  - include coreutils for io tests
  - move a number of assets due to linaro changes
  - add ppc64le custom runner
  - rationalise the gitlab custom runners with templates
  - clean-up the custom runner rules
  - add a scheduled container build

----------------------------------------------------------------
Alex Bennée (17):
      tests/docker: drop --link from COPYs in emsdk docker
      libvirt-ci: bump libvirt-ci to latest version
      tests/lcitool: update ENV stazas outputted by refresh
      tests/docker: add coreutils to the package list
      tests: move test_xen assets to share.linaro.org
      tests: move test_virt assets to share.linaro.org
      tests: move test_netdev_ethtool to share.linaro.org
      tests: move test_kvm_xen to share.linaro.org
      tests: move test_kvm to share.linaro.org
      tests: move test_virt_gpu to share.linaro.org
      gitlab: add initial ppc64le custom-runner test
      gitlab: use template for ubuntu-24.04-s390x jobs
      gitlab: simplify the ubuntu-24.04-aarch64 rules
      gitlab: suppress custom runners being triggered by schedule
      gitlab: make custom runners need QEMU_CI to run
      gitlab: make the schedule rules a bit more general
      gitlab: add a weekly container building job

Pierrick Bouvier (1):
      docs/about/emulation: update assets for uftrace plugin documentation

 docs/about/emulation.rst                           |  20 +--
 docs/devel/testing/ci-jobs.rst.inc                 |   6 +
 .gitlab-ci.d/base.yml                              |   4 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                  |   2 +-
 .gitlab-ci.d/container-template.yml                |   5 +
 .gitlab-ci.d/containers.yml                        |  39 +++++
 .gitlab-ci.d/custom-runners.yml                    |   1 +
 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml  |  45 +++++
 .../custom-runners/ubuntu-24.04-aarch64.yml        |  49 ++----
 .gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml | 189 ++++++++-------------
 scripts/ci/setup/debian/debian-13-ppc64le.yaml     |   1 +
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml   |   1 +
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml     |   1 +
 tests/docker/Makefile.include                      |  11 ++
 tests/docker/dockerfiles/alpine.docker             |  11 +-
 tests/docker/dockerfiles/centos9.docker            |  11 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |  21 +--
 tests/docker/dockerfiles/debian-arm64-cross.docker |  21 +--
 tests/docker/dockerfiles/debian-armhf-cross.docker |  21 +--
 tests/docker/dockerfiles/debian-i686-cross.docker  |  21 +--
 .../dockerfiles/debian-mips64el-cross.docker       |  21 +--
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  21 +--
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  21 +--
 .../docker/dockerfiles/debian-riscv64-cross.docker |  24 ++-
 tests/docker/dockerfiles/debian-s390x-cross.docker |  21 +--
 tests/docker/dockerfiles/debian.docker             |  13 +-
 tests/docker/dockerfiles/emsdk-wasm32-cross.docker |   8 +-
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  11 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |  19 ++-
 tests/docker/dockerfiles/fedora.docker             |  11 +-
 tests/docker/dockerfiles/opensuse-leap.docker      |  11 +-
 tests/docker/dockerfiles/ubuntu2204.docker         |  11 +-
 tests/functional/aarch64/test_kvm.py               |   4 +-
 tests/functional/aarch64/test_virt.py              |   5 +-
 tests/functional/aarch64/test_virt_gpu.py          |   8 +-
 tests/functional/aarch64/test_xen.py               |  12 +-
 tests/functional/x86_64/test_kvm_xen.py            |  17 +-
 tests/functional/x86_64/test_netdev_ethtool.py     |  14 +-
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/projects/qemu.yml                    |   1 +
 tests/lcitool/refresh                              |   6 +-
 tests/vm/generated/freebsd.json                    |   1 +
 43 files changed, 393 insertions(+), 351 deletions(-)
 create mode 100644 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml

-- 
2.47.3


