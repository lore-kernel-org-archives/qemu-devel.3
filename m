Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A7AC19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwri-0007iT-Jr; Thu, 25 Apr 2024 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrf-0007fy-4h
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:07 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwrZ-00086x-MO
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:06 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34be34b3296so802726f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042919; x=1714647719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GXxNzvp3pctM95h9IO3sLT8TUCeqLQhxyJlDys2/tCQ=;
 b=fWaBcAP14DTNW7lWH+aYbK2rGwP10WIx/tHl20XK2ebWRIP9xE0KFxxsLcP8IPdl7K
 pbU5aRFNGctUdm709fl8dvBbyh435mcSnl6T3PG3ohSycWLGBaMv8lpx3u1yjEPKk9Gg
 lHP4AACa2R62iJR+4xrN7hkoG7Xc7C9G9dFw/3gGE3fFqX7gzR4qj4Ra51y6A8jZ/h0g
 WnF+gK4KXfnM0715G/PGYwD+mJGqdVzR+d2tWvCYicYLGpqN65VX5Im0gvZFKfCT2Ket
 Of1MjzzOY1/1UVH5qgKc9QR1+ZHLi2aiv8WDlbT/13o1Rlrh5E3xlXiR7LOyIVWbqY35
 FurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042919; x=1714647719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXxNzvp3pctM95h9IO3sLT8TUCeqLQhxyJlDys2/tCQ=;
 b=VDZGZstpTR6jP6L98h52/ovtutjtjsdbF2hLUJYHJOMar0yUgXVVe8TjYc/14SKXHO
 R630Sz2bmNwnExjg7n8+SzdBS1OXe4ixlULE5p8dppl4hIY4d81tk88KeZTLWABH0FNW
 YmoA69oueUs7ZUh/i/dqL5Oj/DoLg4z9Zfnme75i/7IuAW3Bu7/qzl2DXDYnvWIi49nV
 faYJ5tYtfSKnkNvbnWeHZvcPZz/H6mWG63QrLR5CQbxJDAHHbpA7nfegbFocZYU6OHnp
 pqD+sACmjL9TxE7YyuAWWQ/nRSEGINNJuynlR4X9DhawvZYCYkg+/FXypGzzcwnTcKnB
 YvzQ==
X-Gm-Message-State: AOJu0YxvDLlerW+hQABhxj8NJioYKPXEetjsGslX3Vsa4SfQnpm3Xq2t
 gdAhrG14xJeOLxwtMpQrSy8hkjgqnUjmB1LkHVouRPHmYFOe00anWUmoaOpOdULmlJ1uUk2aad8
 Y
X-Google-Smtp-Source: AGHT+IE5ZRboWrHzh596fssXbruqsgRoljdtQZ6NEpbvmkxjyPYO9yPeGlp7iGrKtAeGU8ZDhNp64Q==
X-Received: by 2002:adf:fdc2:0:b0:34a:572b:40f9 with SMTP id
 i2-20020adffdc2000000b0034a572b40f9mr4927027wrs.8.1714042919464; 
 Thu, 25 Apr 2024 04:01:59 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a5d4d11000000b0034bb61cc5efsm4234704wrt.24.2024.04.25.04.01.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:01:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/22] Misc HW patches for 2024-04-25
Date: Thu, 25 Apr 2024 13:01:33 +0200
Message-ID: <20240425110157.20328-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The following changes since commit 85b597413d4370cb168f711192eaef2eb70535ac:

  Merge tag 'housekeeping-20240424' of https://github.com/philmd/qemu into staging (2024-04-24 11:49:57 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240425

for you to fetch changes up to 098de99aad1aa911b4950b47b55d2e2bcc4f9c0c:

  hw/core: Support module-id in numa configuration (2024-04-25 12:48:12 +0200)

2 checkpatch issues:

- one spurious:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

- one deliberately ignored in a python script:
ERROR: line over 90 characters

----------------------------------------------------------------
Misc HW patch queue

- Script to compare machines compat_props[] (Maksim)
- Introduce 'module' CPU topology level (Zhao)
- Various cleanups (Thomas, Zhao, Inès, Bernhard)

----------------------------------------------------------------

Bernhard Beschow (1):
  hw/i386/pc_sysfw: Remove unused parameter from pc_isa_bios_init()

Inès Varhol (1):
  hw/misc : Correct 5 spaces indents in stm32l4x5_exti

Maksim Davydov (4):
  qom: add default value
  qmp: add dump machine type compatibility properties
  python/qemu/machine: add method to retrieve QEMUMachine::binary field
  scripts: add script to compare compatibility properties

Philippe Mathieu-Daudé (7):
  hw/core: Remove check on NEED_CPU_H in tcg-cpu-ops.h
  target/i386: Move APIC related code to cpu-apic.c
  hw/misc/applesmc: Simplify DeviceReset handler
  hw/misc/imx: Replace sprintf() by snprintf()
  hw/riscv/virt: Replace sprintf by g_strdup_printf
  hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
  hw/xtensa: Include missing 'exec/cpu-common.h' in 'bootparam.h'

Thomas Huth (2):
  hw: Fix problem with the A*MPCORE switches in the Kconfig files
  hw: Add a Kconfig switch for the TYPE_CPU_CLUSTER device

Zhao Liu (7):
  hw/cxl/cxl-cdat: Make ct3_load_cdat() return boolean
  hw/cxl/cxl-cdat: Make ct3_build_cdat() return boolean
  hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return boolean
  hw/core/machine: Introduce the module as a CPU topology level
  hw/core/machine: Support modules in -smp
  hw/core: Introduce module-id as the topology subindex
  hw/core: Support module-id in numa configuration

 MAINTAINERS                             |   5 +
 qapi/machine.json                       |  74 +++-
 hw/xtensa/bootparam.h                   |   2 +
 include/hw/boards.h                     |   4 +
 include/hw/core/tcg-cpu-ops.h           |   3 -
 include/hw/cxl/cxl_component.h          |   2 +-
 include/hw/{elf_ops.h => elf_ops.h.inc} |   0
 bsd-user/elfload.c                      |   2 +-
 hw/core/loader.c                        |   4 +-
 hw/core/machine-hmp-cmds.c              |   4 +
 hw/core/machine-qmp-cmds.c              |  23 +-
 hw/core/machine-smp.c                   |  41 +-
 hw/core/machine.c                       |  18 +
 hw/cxl/cxl-cdat.c                       |  28 +-
 hw/i386/pc_sysfw.c                      |   5 +-
 hw/mem/cxl_type3.c                      |   3 +-
 hw/misc/applesmc.c                      |  36 +-
 hw/misc/imx25_ccm.c                     |   2 +-
 hw/misc/imx31_ccm.c                     |   2 +-
 hw/misc/imx6_ccm.c                      |   4 +-
 hw/misc/imx6_src.c                      |   2 +-
 hw/misc/imx6ul_ccm.c                    |   4 +-
 hw/misc/imx7_src.c                      |   2 +-
 hw/misc/stm32l4x5_exti.c                |   8 +-
 hw/net/imx_fec.c                        |   2 +-
 hw/pci-bridge/cxl_upstream.c            |   3 +-
 hw/riscv/virt.c                         |  17 +-
 hw/ssi/imx_spi.c                        |   2 +-
 linux-user/elfload.c                    |   2 +-
 qom/qom-qmp-cmds.c                      |   1 +
 system/vl.c                             |   3 +
 target/i386/cpu-apic.c                  | 112 ++++++
 target/i386/cpu-sysemu.c                |  77 ----
 target/i386/monitor.c                   |  25 --
 tests/qtest/fuzz/qos_fuzz.c             |   2 +-
 hw/Kconfig                              |   1 +
 hw/arm/Kconfig                          |  18 +-
 hw/cpu/Kconfig                          |  15 +-
 hw/cpu/meson.build                      |   3 +-
 hw/riscv/Kconfig                        |   2 +
 python/qemu/machine/machine.py          |   5 +
 scripts/compare-machine-types.py        | 486 ++++++++++++++++++++++++
 target/i386/meson.build                 |   1 +
 43 files changed, 858 insertions(+), 197 deletions(-)
 rename include/hw/{elf_ops.h => elf_ops.h.inc} (100%)
 create mode 100644 target/i386/cpu-apic.c
 create mode 100755 scripts/compare-machine-types.py

-- 
2.41.0


