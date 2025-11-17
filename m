Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9F2CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1XI-0006PY-4B; Mon, 17 Nov 2025 10:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1X1-00063O-8v
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:52:53 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1Wz-0008SN-5C
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:52:43 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3c965df5so2686949f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394759; x=1763999559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mIqRs+rCNE4Z2ctXJqeS35WeuYppkgXebW7tbFGonOc=;
 b=rap8+QUAjwTzxQb+3idMsz/LSDNHWKqz4SB5cf1z/bjHyQ9d1RuCKpKh0pn+MGdiet
 aNREphVV8nRNrrGQSlQakYZweBjvJSGsEIyBGpBXKrU2NdRlogyNsimmLiZFZ3FaFhiy
 p2xpe4Qqpp7qY//tZbFDc8qWXNGV5WYdNVaFQRbbWN8Vw4/nCBhXDxKEXgAoLMVKq3KF
 2XVogYmLDK+Nd5Y4RyFMeiFvhSRDGOYkcSQsxlmReddb7D8kwFP5v+Gz830zUMudFLaT
 KcNnekLlUnqVRoidsE2VeGHAft1pPuTKJM7y95Ghb4m5GMoPZWQ2OKoDiZBwMLYqMkz3
 AejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394759; x=1763999559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIqRs+rCNE4Z2ctXJqeS35WeuYppkgXebW7tbFGonOc=;
 b=ANEaXyYlPk4HzG4PcJo4LxyIKKLsGQTm6HUEpwuc6LSEsrfUO1mANKO+jQS6Ztcg0h
 we2aIYYT13feDxYnlTIAqkw6R/AgSueeZN0jitEavIdH/QZyk56dtPXGg/A9jqzOv/7c
 M8TrpKYiF4kCExQNMkXlfrEf6xgtxBnGpbnzP6eHrzqAlYddtZ5sZZ+XPhKxdHnQh83+
 PNHgNC9GMEBX8hDek+vJTD8qJH0A+IhRQJqo5oTZe9NN+AiDkPZejt1kvwitUdqedueb
 /6U8SLB1jzdMODNOkcpjPR7vOHza/ful5kB+/k95Lm+aJYy4VpEnWM8db5XAgJB6zU51
 Dpag==
X-Gm-Message-State: AOJu0YzMUhy7Q7fiCy+0Ebv64QUf0MnQ42B4J5aEI9XrJ4f7VDkEgats
 GazPJFVb7/xpDqgVAkt+QCwq7UJi0Z00ZmRdd74CruVfi0hs2ZJBChiBrERAN0+lZtZ4CQRPf/U
 PWsDs
X-Gm-Gg: ASbGncv9vVZrZYcbDHIPWjx2O7zppNmSTEeCYFAUqJf04Ai2SeXSehJlkkJiHf+APik
 EZ4z6UdNzyA5G2zXANxLMDx+TYaesAIczEfZ6x1ZzsSqWyFuJCmtu5MxiCoWhyTkwhEBB3R/tp8
 5oDnPJRsizgTYx8VhhH/0lOSuA87ov5kIOfesQTOR+OQQ/EY3WkTkxWKUG031Zmc4pRzR/P9gt6
 Odx5zS8ZJjTTz6vTpKpmiap9dvD/a+B6Wv9ifjTKq/Ej86DGot+H1/iKgulGeNQGxeO6lJNYsFB
 Gt1cH222Tmsd4bZRHVuVOdsq3JoCRJTAgQ32TRMUtCgBFQ80WjVg2Uhh6KRH73tW+efTiMvk9Zb
 5S7uL/Dri/WTC8KxyX/8/pPcdEcYfM0R5bVZxehx4SsVKgJ+ZNi+72/jml2qMz6rrKsKlLHUKDi
 ZbGu9SMl05/CI=
X-Google-Smtp-Source: AGHT+IHbTC2GUtGO4yvOmzCIJ29S6kM2/Vd/H2PAh4X9Ejk4XZApel6xoIBq5SPl7Km0ZFS0jsexlg==
X-Received: by 2002:a05:6000:40c9:b0:429:8b01:c093 with SMTP id
 ffacd0b85a97d-42b5934f642mr11796269f8f.15.1763394759093; 
 Mon, 17 Nov 2025 07:52:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm26930072f8f.37.2025.11.17.07.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:52:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AA9A75F860;
 Mon, 17 Nov 2025 15:52:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/18] testing updates for 10.2
Date: Mon, 17 Nov 2025 15:52:37 +0000
Message-ID: <20251117155237.4124861-1-alex.bennee@linaro.org>
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

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-171125-2

for you to fetch changes up to 8bec7b9874235e60f14172618121c60fdbd39302:

  gitlab: add a weekly container building job (2025-11-17 15:51:00 +0000)

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
      tests/lcitool: update ENV stanzas outputted by refresh
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


