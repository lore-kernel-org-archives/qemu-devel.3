Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C9DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSHU-0000Ai-Nw; Mon, 29 Jul 2024 11:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHS-00009W-CN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHQ-0008Dy-2L
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso15849625e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266838; x=1722871638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YkEuatbeFB6Sn7Y4+jGONuoXv1eU2raNGMru3A7ZrTQ=;
 b=X1Tdthpq3ozKr+TfQZnPdnLaNWmMUNNHz19VQgBDtUh91heMm8EBsx7rEqC62Huyhm
 AEKAiRhSpBz3IEP1VihTYyPU1iAvemdxLmEdKN8G+fMRb0MnyCmjSWLp+Vfhx1G19qsW
 Swu9ENhyI4yz8RS/QE1NS/aEBAbnAouqE3GwiWW/Ai20tLDdzEjY61hJLB9Cfh3K2Evh
 5LiJEmep437ACbvfm+FIk3UHF1yVqwyTuH5stxPMbMTNTnM7dksSkvzxnJjy/9pXXski
 L41KgaVOnCZUuaBD/XveoqupL90B0hMhnOa/awlnEk4x0YdEpSA1ibGMbIPV1saadgkQ
 pVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266838; x=1722871638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YkEuatbeFB6Sn7Y4+jGONuoXv1eU2raNGMru3A7ZrTQ=;
 b=DPx4nW9OPXUdxzZbNHuYzcqt9/8B+s+wy1kZ5ElQh9aVxihzvP8MJ9B3LoLo96TGdF
 khywqTH4FiNHeOSN1l8dN+WjQVkrRTEe9Lub0Lcl9LvVEnD3N194Sg+OB4p/akTAlqQd
 A2YUo86A//HoNxhUuItgRo9+tYdXEAXJKBzFDU7XH8orP6eDWC9IAwhYK7MVO+Z7crN+
 G0q+dm6eOatxwCllkRhR5GhGog/Mv7Adl2P5dVuLYF2wcueQs+fadKt2zRQkvkKkvTJv
 5UkZrK9dtpEGJdUQHqI3JHyyTzjMda9J5OFlrj22HjftsOSNe0arnxQ47GmAytr93T0r
 L7Fg==
X-Gm-Message-State: AOJu0YxBj/if8G9Hn7If7cZUNPi62bWRM8U0LYyn7MKk6SskyTUl/A42
 hRXxlnaFrTMxJedvdGugER08JAaMIVe78/gcuHlYz8jRpyv6GvId3ah/lRZJGBriJ2+/5bi5YNa
 9
X-Google-Smtp-Source: AGHT+IHwTc/plAP2j4BPCitOC3N3JkjYPtLjMJAIYuuogo7QMQzuktr1VzItk1ZpfpUFob/heKu4YA==
X-Received: by 2002:a05:600c:1ca3:b0:427:dac4:d36 with SMTP id
 5b1f17b1804b1-42811d73a0cmr49852725e9.7.1722266837723; 
 Mon, 29 Jul 2024 08:27:17 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42805730d92sm183049295e9.3.2024.07.29.08.27.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:27:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/14] Docs / testing patches for 2024-07-29
Date: Mon, 29 Jul 2024 17:27:00 +0200
Message-ID: <20240729152714.10225-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:

  Merge tag 'pull-ppc-for-9.1-2-20240726-1' of https://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/docs-testing-20240729

for you to fetch changes up to 8e2275592299b637e87cc905d20bfdeffa586a83:

  tests/avocado: test_arm_emcraft_sf2: handle RW requirements for asset (2024-07-29 16:33:24 +0200)

Ignored warnings:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  WARNING: line over 80 characters

----------------------------------------------------------------
Docs & testing patch queue

- Test QAPI firmware.json schema (Thomas)
- Handle new env.doc2path() return value (Peter)
- Convert some Avocado tests to simpler python-based functional testing (Thomas)
- Improve how assets are used by some Avocado tests (Cleber)

----------------------------------------------------------------

Cleber Rosa (3):
  tests/avocado: mips: fallback to HTTP given certificate expiration
  tests/avocado: mips: add hint for fetchasset plugin
  tests/avocado: test_arm_emcraft_sf2: handle RW requirements for asset

Peter Maydell (1):
  docs/sphinx/depfile.py: Handle env.doc2path() returning a Path not a
    str

Thomas Huth (9):
  python: Install pycotap in our venv if necessary
  tests/functional: Add base classes for the upcoming pytest-based tests
  tests/Makefile.include: Increase the level of indentation in the help
    text
  tests/functional: Prepare the meson build system for the functional
    tests
  tests/functional: Convert simple avocado tests into standalone python
    tests
  tests/functional: Convert avocado tests that just need a small
    adjustment
  tests/functional: Convert the x86_cpu_model_versions test
  tests/functional: Convert the riscv_opensbi avocado test into a
    standalone test
  gitlab-ci: Add "check-functional" to the build tests

Thomas Weißschuh (1):
  docs: add test for firmware.json QAPI

 MAINTAINERS                                   |  11 +
 docs/meson.build                              |   5 +
 docs/sphinx/depfile.py                        |   2 +-
 .gitlab-ci.d/buildtest-template.yml           |   3 +-
 .gitlab-ci.d/buildtest.yml                    |  60 ++--
 python/wheels/pycotap-1.3.1-py3-none-any.whl  | Bin 0 -> 5119 bytes
 pythondeps.toml                               |   1 +
 tests/Makefile.include                        |  41 ++-
 tests/avocado/boot_linux_console.py           |  24 +-
 tests/avocado/riscv_opensbi.py                |  63 ----
 tests/functional/meson.build                  |  86 +++++
 tests/functional/qemu_test/__init__.py        | 328 ++++++++++++++++++
 .../test_cpu_queries.py}                      |   7 +-
 .../test_empty_cpu_model.py}                  |   7 +-
 .../test_info_usernet.py}                     |  11 +-
 .../test_mem_addr_space.py}                   |  52 +--
 .../test_pc_cpu_hotplug_props.py}             |  11 +-
 .../test_ppc_74xx.py}                         |  74 ++--
 tests/functional/test_riscv_opensbi.py        |  36 ++
 .../version.py => functional/test_version.py} |  13 +-
 .../test_virtio_version.py}                   |   8 +-
 .../test_x86_cpu_model_versions.py}           |  63 +---
 tests/meson.build                             |   1 +
 23 files changed, 636 insertions(+), 271 deletions(-)
 create mode 100644 python/wheels/pycotap-1.3.1-py3-none-any.whl
 delete mode 100644 tests/avocado/riscv_opensbi.py
 create mode 100644 tests/functional/meson.build
 create mode 100644 tests/functional/qemu_test/__init__.py
 rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (89%)
 mode change 100644 => 100755
 rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
 mode change 100644 => 100755
 rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
 mode change 100644 => 100755
 rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (93%)
 mode change 100644 => 100755
 rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_riscv_opensbi.py
 rename tests/{avocado/version.py => functional/test_version.py} (78%)
 mode change 100644 => 100755
 rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
 mode change 100644 => 100755
 rename tests/{avocado/x86_cpu_model_versions.py => functional/test_x86_cpu_model_versions.py} (92%)
 mode change 100644 => 100755

-- 
2.45.2


