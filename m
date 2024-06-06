Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8D6C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBdz-0007i0-OR; Thu, 06 Jun 2024 07:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdw-0007fG-St
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:56 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdu-0000sV-Mc
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:56 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2eaad2c673fso11504581fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674653; x=1718279453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ketSUghNepfPOiL/VZXF+Z/GBfbv0GHe9wK13u2WN5A=;
 b=NuHzj7wD2IjBWQ5uI3h4tiUc0zDgKUpoRfvMBWBU2bKU+fdbe/Zg/UKr4dky15hEFl
 NIBhNWf3EmeG7yEFVsvfut8pP5ISb5hVsh21fkrAkV1MRIBYSI/UCl2s3d8cHl1cASSu
 BFFBZKBUTTW45MHrSosCQUXio10awYfSyerluoNSVn0OO20ztuuIx+jwmL17t/XssFTw
 u+7Nsp764rrSK/2D8t1Xdljtlf8TeXp5jycN8Z07yGanssOfmnQ5wtnTKM+Xr5V6yUrZ
 A2gSJuf5QzPh+ag0PqN1fY7dl8DrckXMlfPFO9Z3xTJwYraEhj+HRcJk+yY0lobgVKP3
 SCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674653; x=1718279453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ketSUghNepfPOiL/VZXF+Z/GBfbv0GHe9wK13u2WN5A=;
 b=Uis33gVD4RNDFFE8Yh1X5A6qkewe3g7J0cWAwM5KaT5FfYHZXkL34nJxUhsr1xryP9
 s/8v/w7MeaEpZGu4uw+6Phrqaqw4gfIai19EXCmvjyoZm9eRWLPcB4eKSlNcqGlsBpyD
 a8+8zdtGV5G01tYZPOXFVTImQr0HCNYc1QOUp8cQewZ+2oEX702nkY8TmP2CpiOZb8Sd
 qTN8Se2UwM/s24EjJEU0Ft9OoHkhEy55CQyLDfxZwi0MRAsnOsxF+MoDAhbAeNOcXo7m
 lSATa4dOnapP1YWbcC+I3+GyEaqU6zJcxcB1oKIsn4P3NcXsOPPV67wsSxuTxZZm/Eke
 wE0g==
X-Gm-Message-State: AOJu0Yx5diyFwmm0NCj0kJ7CcoWuARb2/4BlDxuwlOPNOV/uu3Xvzr7x
 MTWxUU1vx2Z1w9ftT7vbLDs4y3MK9MIk5Ato6OFednMRv9VfqXitJ7wYyCKum0W4nlKOhg/iKVd
 d
X-Google-Smtp-Source: AGHT+IE48ykZwUeQa6eeupTCCDCO4mWhxkHuHsVOF93jR/ojqv3SB9jKAG2PqJPEyeRvlHU8hAn4AA==
X-Received: by 2002:a05:651c:1a2a:b0:2de:ca7f:c849 with SMTP id
 38308e7fff4ca-2eac7a7fcd5mr45373711fa.43.1717674652653; 
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070f9b4sm87433266b.187.2024.06.06.04.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB3DF5F7AD;
 Thu,  6 Jun 2024 12:50:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/12] testing cleanups (ci, vm, lcitool, ansible)
Date: Thu,  6 Jun 2024 12:50:35 +0100
Message-Id: <20240606115047.421045-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit db2feb2df8d19592c9859efb3f682404e0052957:

  Merge tag 'pull-misc-20240605' of https://gitlab.com/rth7680/qemu into staging (2024-06-05 14:17:01 -0700)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-june24-060624-1

for you to fetch changes up to c99064d03fc574254ab098562798c937a4761161:

  scripts/ci: drive ubuntu/build-environment.yml from lcitool (2024-06-06 10:26:22 +0100)

----------------------------------------------------------------
testing cleanups (ci, vm, lcitool, ansible):

  - clean up left over Centos 8 references
  - use -fno-sanitize=function to avoid non-useful errors
  - bump lcitool and update images (alpine, fedora)
  - make sure we have mingw-w64-tools for windows builds
  - drive ansible scripts with lcitool package lists

----------------------------------------------------------------
Alex Bennée (8):
      ci: remove centos-steam-8 customer runner
      docs/devel: update references to centos to non-versioned container
      tests/vm: update centos.aarch64 image to 9
      tests/vm: remove plain centos image
      scripts/ci: remove CentOS bits from common build-environment
      docs/ci: clean-up references for consistency
      tests/lcitool: generate package lists for ansible
      scripts/ci: drive ubuntu/build-environment.yml from lcitool

Thomas Huth (4):
      tests/lcitool: Delete obsolete centos-stream-8.yml file
      .gitlab-ci.d/buildtest.yml: Use -fno-sanitize=function in the clang-system job
      tests/lcitool: Bump to latest libvirt-ci and update Fedora and Alpine version
      tests/lcitool: Install mingw-w64-tools for the Windows cross-builds

 docs/devel/ci-jobs.rst.inc                         |   7 -
 docs/devel/ci-runners.rst.inc                      |  13 +-
 docs/devel/testing.rst                             |   8 +-
 .gitlab-ci.d/buildtest.yml                         |   1 +
 .gitlab-ci.d/custom-runners.yml                    |   1 -
 .../custom-runners/centos-stream-8-x86_64.yml      |  24 --
 .../custom-runners/ubuntu-22.04-aarch32.yml        |   2 +-
 .../custom-runners/ubuntu-22.04-aarch64.yml        |   2 +-
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml |   2 +-
 .../ci/org.centos/stream/8/build-environment.yml   |  82 ------
 scripts/ci/org.centos/stream/8/x86_64/configure    | 198 --------------
 scripts/ci/org.centos/stream/8/x86_64/test-avocado |  65 -----
 scripts/ci/org.centos/stream/README                |  17 --
 scripts/ci/setup/build-environment.yml             | 284 ---------------------
 scripts/ci/setup/ubuntu/build-environment.yml      |  69 +++++
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   | 127 +++++++++
 .../ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml    | 127 +++++++++
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     | 125 +++++++++
 tests/docker/dockerfiles/alpine.docker             |   4 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |   6 +-
 tests/docker/dockerfiles/fedora.docker             |   5 +-
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/projects/qemu-win-installer.yml      |   1 +
 tests/lcitool/projects/qemu.yml                    |   1 +
 tests/lcitool/refresh                              |  22 +-
 tests/lcitool/targets/centos-stream-8.yml          |   3 -
 tests/vm/Makefile.include                          |   1 -
 tests/vm/centos                                    |  51 ----
 tests/vm/centos.aarch64                            |  10 +-
 29 files changed, 497 insertions(+), 763 deletions(-)
 delete mode 100644 .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml
 delete mode 100644 scripts/ci/org.centos/stream/8/build-environment.yml
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/configure
 delete mode 100755 scripts/ci/org.centos/stream/8/x86_64/test-avocado
 delete mode 100644 scripts/ci/org.centos/stream/README
 delete mode 100644 scripts/ci/setup/build-environment.yml
 create mode 100644 scripts/ci/setup/ubuntu/build-environment.yml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
 create mode 100644 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
 delete mode 100644 tests/lcitool/targets/centos-stream-8.yml
 delete mode 100755 tests/vm/centos

-- 
2.39.2


