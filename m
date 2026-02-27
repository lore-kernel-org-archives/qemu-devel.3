Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E5FEFB5A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzbZ-0000LX-Sg; Fri, 27 Feb 2026 10:18:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbY-0000Kx-6N
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:12 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbV-0005kP-Rj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:11 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso3154122a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772205488; x=1772810288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+LZrklDHrdqFfwZAs4sXl23W3ebO7Dfgl3/IMicZgYk=;
 b=axBbP4ZCccxEFF6BFoqNM84PP6x/mctx24f6eb++a0CNjRMo7aVDWoKqh0++3Xdd3V
 G951H2q0xd4jjwpEHI6Z8DjCr+T7BjO2dNGa2D4RvtjgYKhXJWiCVH5uM7/+oRVEqtqd
 qs4VqdRW+HR3lscV7lbXFNadP3hQaabQl+rztcB1x7F0+0mOUcwuuGK+MjMJgIqIQ19f
 hJG3Aa/ti9RrsspfakMUaaY8yOipH6lwJF36euuugbV5derTnc3tgru+JUx8/rZO+G8B
 8XOHJq9ovjATBCgDNc6PjwaJrGFxgUHRDeQVDXwjIFCz4CH3apB8EJyU/B4ttyhj9KcT
 djTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772205488; x=1772810288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LZrklDHrdqFfwZAs4sXl23W3ebO7Dfgl3/IMicZgYk=;
 b=DWjGNKzVlaTlzKCP6sDXy33rsz9hMRKHj3yiF5EKcrDKLmylF0j6epN82lMHtHCGyb
 gesS56GBP98UXD23CdmtQ4bTAveUlZ2BYw4U2NpkOUGGzxB5COtek42yM/0yLg0KlLPL
 1HJu7Kx03AUObdYBBJr8b2C7fYMuqMjoiKDgGJuDeRqSM8UM05//UHwFt5fYmfG5K23B
 snlI+TMNIlze+JbpZKCVBIXhy800ZxfnFLvJgXp+5MQi/YvyxpNZeas5FyYz5MKUAN4X
 ojgOiNgYKjcvU/mEppXnr2X81YcVNtChpj9hrgmRZUq4/EuYne7ny0BXtY1Im+FNyFLm
 P74w==
X-Gm-Message-State: AOJu0Yx90O/K9AxbBQp1YLqSq+0Ho11/VHB3kOlcdRECjj61u6nbMrU4
 a/iJ/qhGUoWdgYZBg54LgQvR8AIsAJNu7Nr3TgTo9lLDyuHRwKrIAbq8SpiOqQe38is=
X-Gm-Gg: ATEYQzxp1ftd7h7jNm/L+l6uVe+RvFO8RJUqffDB//mn/RorSes/ZSVZkHTaWfQxRIJ
 LgBZYpikvga9QY/BbjM0B46u10N3ZSm2pughsbkWZZ6eTKRqMWQuIut4GNZkpfGidp43qTfzlG6
 ZcKkYYgJcLvivFCHZldxNvIbd4I/bAdl3Kyp4lbatf+b7doQxPybAFDdqqC2i/exFKULllRPgnA
 XbhqX/csy+faHtw2bwZgMOjE+z4lBDYyogXgUjZNIauQarYpBh5IrJLhHNVMF6ARaxniv5cxr5L
 F6ghxTQA/4m8coXqK4+VvPP5g2ukMP6XWr9yLeR1m2S2lxmGxBlilF6/MY83L2Cr+Q8S5ygj/bL
 r9Nf48LQh8v3pxV60kOgR/psOx4VjGBBz6LnTWrPWgtgrcR+sFV21Dw0T4oW/bYuZAZZ9t6MTPS
 b2B6rh1SrmwpWH90HyGVpeFZA=
X-Received: by 2002:a05:6402:3988:b0:65a:1a4e:7011 with SMTP id
 4fb4d7f45d1cf-65fdd6e3429mr1625197a12.12.1772205487600; 
 Fri, 27 Feb 2026 07:18:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac06dd07sm1371200a12.24.2026.02.27.07.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:18:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E35F5F7F3;
 Fri, 27 Feb 2026 15:18:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/7] testing updates (vm, docker, arm functional)
Date: Fri, 27 Feb 2026 15:17:57 +0000
Message-ID: <20260227151805.2335641-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit d8a9d97317d03190b34498741f98f22e2a9afe3e:

  Merge tag 'pull-target-arm-20260226' of https://gitlab.com/pm215/qemu into staging (2026-02-26 16:00:07 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.0-testing-updates-270226-2

for you to fetch changes up to 49105fa01059c100332a583816ba97562e181586:

  tests/functional: add Arm VBSA uefi conformance test (2026-02-27 12:54:17 +0000)

----------------------------------------------------------------
testing updates (vm, docker, arm functional)

  - migrate non-lcitool Debian containers to Trixie (13)
  - remove legacy-test-cross hacks
  - fix some minor make vm- Makefile issues
  - bump OpenBSD to 7.8
  - add VBSA EFI functional test for Arm

----------------------------------------------------------------
Alex Bennée (6):
      tests/docker: migrate legacy-test-cross compilers to trixie
      tests/vm: bump OpenBSD to the current 7.8 release
      tests/vm: remove unused import
      tests/vm: fix interactive boot
      tests/vm: build openbsd from lcitool data
      tests/functional: add Arm VBSA uefi conformance test

John Snow (1):
      tests/docker: upgrade most non-lcitool debian tests to debian 13

 configure                                          |  10 +-
 .gitlab-ci.d/buildtest.yml                         |  12 ---
 .gitlab-ci.d/container-cross.yml                   |   6 --
 .gitlab-ci.d/containers.yml                        |   1 -
 .../dockerfiles/debian-all-test-cross.docker       |   8 +-
 .../docker/dockerfiles/debian-hexagon-cross.docker |  11 ++-
 .../dockerfiles/debian-legacy-test-cross.docker    |  51 ----------
 .../dockerfiles/debian-loongarch-cross.docker      |  10 +-
 tests/docker/dockerfiles/debian-toolchain.docker   |   8 +-
 .../docker/dockerfiles/debian-tricore-cross.docker |   5 +-
 .../docker/dockerfiles/debian-xtensa-cross.docker  |   2 +-
 tests/functional/aarch64/meson.build               |   1 +
 tests/functional/aarch64/test_virt_vbsa.py         | 106 +++++++++++++++++++++
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/refresh                              |  13 ++-
 tests/vm/Makefile.include                          |   2 +-
 tests/vm/generated/openbsd.json                    |  27 ++++++
 tests/vm/openbsd                                   |  47 +--------
 18 files changed, 175 insertions(+), 147 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-legacy-test-cross.docker
 create mode 100755 tests/functional/aarch64/test_virt_vbsa.py
 create mode 100644 tests/vm/generated/openbsd.json

-- 
2.47.3


