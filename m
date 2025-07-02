Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0630CC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2a-0008W3-1O; Wed, 02 Jul 2025 06:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2T-0008TW-JN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2P-0002oq-TQ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2407306f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453399; x=1752058199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=csTIh5aPTRusaV8JSGJU0V9FGLZpWINjUnUsGJPcreU=;
 b=RIncTQasJ+1dxhLoHvlI/rBoK4GWCrZ81HCROgNg2txKHsihzt3MVjbdFnlYK+fSkR
 JUPvM3CFQ4lhHgqgVvn/kTMXdLUREouO8cAgX/0AGnU/tg9RZ+cpLCPikmXHW0Z5Iy5h
 9u2Z1ShaadA43zOOSDkGuCJHjXRYrOVYllNxkTKAH5Az63KwkovkOE6qEALdRqVht0pT
 Cy/UdhZQBQ3ZDAMxqgiHMJ2xsECB75j9351rzC+oa4K7pJELFD+NXzHqkC+dBjwMr3F6
 zvFuAH6e+M2LPYcRHrASe0Vdg+YHSYVSMVQMgfaH+4AFGX3ORF85y6PUfbdr4p7nWBZv
 WjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453399; x=1752058199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=csTIh5aPTRusaV8JSGJU0V9FGLZpWINjUnUsGJPcreU=;
 b=mFgN53vrr2tMuVj/qqUj0gPQiEBwerXPIoWVayQ85ylbRFgjOSSEB9vhSIsXVEI6cj
 q/OnanxvLsFdRUWvvF0s5FnBRrD3rpv98nIgi9DfdaZOcFeBXHm8+Vqp+HsS9zcbUYhC
 swKY5S1350IKOw8Ey997c+FbgnkkJSZqEaxkb9PlOa3/o5C5kpwbAZRpZ2ALq2C++gFf
 iWzTA4ycTi4dPl5/X6fTwMfuz2J7uzRjYUqJ5C/0+yFfKIET26hcnNAnRkdNVu+MLHIn
 9cgoWImOWoRVz/QqxvfRLU0tpFL3rbGwuR5qjKFo5oIrw6tHZWthdXQKI6SqMroAAjt8
 C51A==
X-Gm-Message-State: AOJu0YxnJJ4sS++n6zjU8ZDlp6IM1e80KqkCggfdgG3xX//7P0iix0Jc
 qApsSGeuTT2Pe0XNvMmsk0jYexNwxoRCpuQ/aWY+MzWQpryv618UV6u/mLoBglFNHnOVmo01gP5
 FtaPN3b8=
X-Gm-Gg: ASbGncsDTAAEhw4E8Jw0Ks5DJSxX5uJGctWzxmRFwrWwqOWEAFj3gH76oAF5Eh0WMQo
 hiJV6/UQ5NNA61pQgyrHDrq0qyxtLHiTp2G2iu9Quh40H4+bHuUGZnhRdN8dA564DBItlbODrgg
 266jM5bVQ09rRxjNUzLFvz+iH4EQ35B8XsDP1JFOAexonwEBNGE1fSzkYQK4sR811aqRkRB8zg/
 mP2CZd+8ETUfmGogCf2s+MVuy0QzzotFxHythSo/n25LJVBxoy+A0T0tJLBvuZZ4trg33ndnNmS
 bEmUwAvJ/uu3bGVE8yy8TjWsmIGIMycOy6DlaZv++AdTCFm4XvRIfeN/xg8Pn40=
X-Google-Smtp-Source: AGHT+IFf7oyiD2SreR1JyHTvxWg00/G95FI+6KOOCnB92o4Jotr2Em497bGL4hq22eMUKpkFIxgySQ==
X-Received: by 2002:a05:6000:2910:b0:3a6:d26a:f0f5 with SMTP id
 ffacd0b85a97d-3b1ff14e59fmr1807099f8f.21.1751453399206; 
 Wed, 02 Jul 2025 03:49:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e595d1sm15898928f8f.71.2025.07.02.03.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:49:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C362C5F8BE;
 Wed, 02 Jul 2025 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/15] Maintainer updates for June (gitlab, semihosting, plugins,
 virtio-gpu)
Date: Wed,  2 Jul 2025 11:49:40 +0100
Message-ID: <20250702104955.3778269-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

The following changes since commit 6138e72b7e33e0240ee955a2754dd038ee99494d:

  Merge tag 'pull-tcg-20250630' of https://gitlab.com/rth7680/qemu into staging (2025-07-01 04:25:08 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.1-maintainer-june-2025-020725-1

for you to fetch changes up to 1fa2ffdbec55d84326e22f046bc3e26322836f5a:

  virtio-gpu: support context init multiple timeline (2025-07-02 10:10:07 +0100)

----------------------------------------------------------------
Maintainer updates for June (gitlab, semihosting, plugins, virtio-gpu)

 - mark s390x runner system tests as allow_fail
 - build semihosting once
 - add register write support to plugins
 - add virtual memory write support to plugins
 - add harder memory read/write support to plugins
 - add patcher plugin and tests
 - re-stock virtio-gpu MAINTAINERS
 - fix context init for Venus fences

----------------------------------------------------------------
Alex Bennée (3):
      gitlab: mark s390x-system to allow failures
      MAINTAINERS: add myself to virtio-gpu for Odd Fixes
      MAINTAINERS: add Akihiko and Dmitry as reviewers

Gustavo Romero (1):
      tests/functional: Add PCI hotplug test for aarch64

Philippe Mathieu-Daudé (2):
      semihosting/uaccess: Remove uses of target_ulong type
      semihosting/uaccess: Compile once

Rowan Hart (8):
      gdbstub: Expose gdb_write_register function to consumers of gdbstub
      plugins: Add register write API
      plugins: Add enforcement of QEMU_PLUGIN_CB flags in register R/W callbacks
      plugins: Add memory virtual address write API
      plugins: Add memory hardware address read/write API
      tests/tcg: Remove copy-pasted notes and from i386 and add x86_64 system tests to tests
      plugins: Add patcher plugin and test
      plugins: Update plugin version and add notes

Yiwei Zhang (1):
      virtio-gpu: support context init multiple timeline

 MAINTAINERS                                        |  11 +-
 include/exec/gdbstub.h                             |  14 ++
 include/hw/core/cpu.h                              |   1 +
 include/qemu/plugin.h                              |  15 ++
 include/qemu/qemu-plugin.h                         | 176 +++++++++++++--
 include/semihosting/uaccess.h                      |  12 +-
 accel/tcg/plugin-gen.c                             |  30 +++
 gdbstub/gdbstub.c                                  |   2 +-
 hw/display/virtio-gpu-virgl.c                      |  44 ++++
 plugins/api.c                                      | 135 ++++++++++-
 plugins/core.c                                     |  33 +++
 semihosting/uaccess.c                              |  10 +-
 tests/tcg/plugins/patch.c                          | 251 +++++++++++++++++++++
 tests/tcg/x86_64/system/patch-target.c             |  22 ++
 .gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml |   2 +
 semihosting/meson.build                            |   5 +-
 tests/functional/meson.build                       |   1 +
 tests/functional/test_aarch64_hotplug_pci.py       |  72 ++++++
 tests/tcg/Makefile.target                          |   7 +-
 tests/tcg/plugins/meson.build                      |   2 +-
 tests/tcg/x86_64/Makefile.softmmu-target           |  21 +-
 tests/tcg/x86_64/system/validate-patch.py          |  39 ++++
 22 files changed, 863 insertions(+), 42 deletions(-)
 create mode 100644 tests/tcg/plugins/patch.c
 create mode 100644 tests/tcg/x86_64/system/patch-target.c
 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
 create mode 100755 tests/tcg/x86_64/system/validate-patch.py

-- 
2.47.2


