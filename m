Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B78CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vET4K-00084z-A8; Thu, 30 Oct 2025 09:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vET4H-00084J-QJ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:51:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vET48-0001Aj-Km
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:51:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso7547415e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761832303; x=1762437103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ykwCFAYsBsKgu2ziaoNlAW6KMhB99vj38MdcSPNoy8o=;
 b=YXomgM/E+Gt4F2VKwRHlIXn76SS9Rqu86EFGzzYUoEnC2+DzAIYPlBYPY/0lczByv9
 hNKOeaFvmrQd9PqHZOIDQ7m7Yx3h/wNKg3HOhH1LtKqgR95ax/SvbG59Pi9eld+d/ZpM
 F8BAlFqrTcZLASvxKknETrudsqzHrQP5hif9ewyz9yfB0KYTj2mco7vod861KofmNq1J
 /09tjFFmrcH7J50LCoR/VtEW9CnKO/FF7yYEqNhSdxeWseWue9EDfq8wVJki7w6YlCkI
 O1uIDqcLtBl3jnlTuPDQHX8VzdfeSyIx3nh7cJD4C1NpPEIamlCkdkkFbd/vANkFkK/T
 AgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761832303; x=1762437103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ykwCFAYsBsKgu2ziaoNlAW6KMhB99vj38MdcSPNoy8o=;
 b=myceOeqM14F2g/Q0M1thumoxxi/sg+XhLeeC69rdDrHc52rVhLS4znuESG0SEveaxP
 0bhYNxVqqLN8k7U4XYEGRS9Te7U7V/hEo9lcDlRj0vz0oSU6Wz1npbrNfIx4459LMoR4
 KUZyBZ9xNGnfKVQxb1O9nmht9fnebC/fmlZN66SmBS5vSHiIUKeOdr/UFirdeugDxH1l
 1CYAhlT/HYEFWyOvKaHcI7564HMBOKs1fQXo5EottFLna6WxCn2HVtO5EsFchZIyFGmw
 lQoHkdjTlobuuFfdBpjAEndo6oexnEDjgKM4A8oQwfc2FKs6foHrwaIetpoVWRrq4kDX
 8G2A==
X-Gm-Message-State: AOJu0YwFiQ237xr6slKQ48vZeHfiZmMXVpFL/Z39OTifxg2vAaX8mmhN
 zCbG4rSY/WJP2zN4RkLre7lUxO0Rly7ULHkRYYa7+x4gh61iXHr9x6nyLzxM8LbCkNZtg0/cRto
 JlSE9LFE=
X-Gm-Gg: ASbGncueFqVovA/Sq3Y2S8Dad99GzanOlKM9X2IVHzeoC0eCPF/GU4NtkiT0tUPrcw8
 dvU2pdF/BeYW5GVLw/e02mMumW35Gq/ke4J9uMa6127qBrGekNpnrjp+SiB267FoX5qQTAAbXs4
 Y2f6DFouLJ3aoXS+8k+U+Tku8whgonUYTK3OHLg18xkzk09rh9jwe1cFUWFU15AVRqYMBMPm+Az
 u/+y7uXqC3q3gmODq0XljmX1p4tCwRkECkenkqokQQBdDGeqn1Fg95iBtp+ew26bGhFMJoyEh0n
 30sE4NXjAPrYoDFxEqMzeR6lbuBUoNRuJdhGdBl17m6QOiFbtmzo6GqKi2vMoinnFG5sWoT4xHB
 PEFW+o5tOEixlubmswPkHB5rphcYPLK0JIK49dTpVwlzNqpiJA2WFK2oz79zIlIJavL3k381A9B
 FAYdwVFskajoTIT74u+6hxfgMsSJP1GJ3fYSJNvVKMFBFh4bY=
X-Google-Smtp-Source: AGHT+IGPQ64KbJSYbIRALouiCJWO/SaetMCtibx3tOa0e7fJ2Stv540RHziOcN3jwIfrJZccRp+rgA==
X-Received: by 2002:a05:600c:6748:b0:475:dbb5:2397 with SMTP id
 5b1f17b1804b1-4772668eb39mr26015075e9.0.1761832302877; 
 Thu, 30 Oct 2025 06:51:42 -0700 (PDT)
Received: from localhost.localdomain (124.149.216.82.rev.sfr.net.
 [82.216.149.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772899fdf0sm40471005e9.3.2025.10.30.06.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Oct 2025 06:51:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL v2 00/23] Misc single binary patches for 2025-10-29
Date: Thu, 30 Oct 2025 14:51:38 +0100
Message-ID: <20251030135139.20433-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20251030

for you to fetch changes up to dfbf7775403db6fdd3e298bf7664b6149d7d6f77:

  hw/riscv: Replace target_ulong uses (2025-10-30 14:48:26 +0100)

----------------------------------------------------------------
Various patches related to single binary work:

- Make hw/arm/ common by adding a QOM type to machines to
  tag in which binary (32 or 64-bit) they can be used.
  Convert the Virt and SBSA-Ref machines.
- Build Xen files once

----------------------------------------------------------------

Anton Johansson (1):
  hw/riscv: Replace target_ulong uses

Philippe Mathieu-Daudé (22):
  hw/arm: Register TYPE_TARGET_ARM/AARCH64_MACHINE QOM interfaces
  hw/core: Allow ARM/Aarch64 binaries to use the 'none' machine
  hw/arm: Add DEFINE_MACHINE_ARM() / DEFINE_MACHINE_AARCH64() macros
  hw/arm: Filter machine types for qemu-system-arm/aarch64 binaries
  meson: Prepare to accept per-binary TargetInfo structure
    implementation
  config/target: Implement per-binary TargetInfo structure (ARM,
    AARCH64)
  hw/arm/virt: Register valid CPU types dynamically
  hw/arm/virt: Check accelerator availability at runtime
  qemu/target_info: Add target_arm() helper
  qemu/target_info: Add target_aarch64() helper
  qemu/target_info: Add target_base_arm() helper
  hw/arm/virt: Replace TARGET_AARCH64 -> target_aarch64()
  hw/arm/virt: Get default CPU type at runtime
  hw/arm/sbsa-ref: Include missing 'cpu.h' header
  hw/arm/sbsa-ref: Build only once
  hw/arm/virt-acpi-build: Include missing 'cpu.h' header
  hw/arm/virt-acpi-build: Build only once
  hw/arm/virt: Build only once
  hw/arm/meson: Move Xen files to arm_common_ss[]
  hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in req_size_bits()
  hw/xen: Replace target_ulong by agnostic target_long_bits()
  hw/xen: Build only once

 MAINTAINERS                       |  1 +
 meson.build                       | 10 ++++-
 include/hw/arm/machines-qom.h     | 46 +++++++++++++++++++
 include/qemu/target-info.h        | 21 +++++++++
 configs/targets/aarch64-softmmu.c | 26 +++++++++++
 configs/targets/arm-softmmu.c     | 26 +++++++++++
 hw/arm/aspeed.c                   | 27 ++++++++++-
 hw/arm/aspeed_ast27x0-fc.c        |  2 +
 hw/arm/b-l475e-iot01a.c           |  2 +
 hw/arm/bananapi_m2u.c             |  3 +-
 hw/arm/collie.c                   |  2 +
 hw/arm/cubieboard.c               |  3 +-
 hw/arm/digic_boards.c             |  3 +-
 hw/arm/exynos4_boards.c           |  3 ++
 hw/arm/fby35.c                    |  2 +
 hw/arm/highbank.c                 |  3 ++
 hw/arm/imx25_pdk.c                |  3 +-
 hw/arm/imx8mp-evk.c               |  4 +-
 hw/arm/integratorcp.c             |  3 +-
 hw/arm/kzm.c                      |  3 +-
 hw/arm/mcimx6ul-evk.c             |  4 +-
 hw/arm/mcimx7d-sabre.c            |  4 +-
 hw/arm/microbit.c                 |  2 +
 hw/arm/mps2-tz.c                  |  5 +++
 hw/arm/mps2.c                     |  5 +++
 hw/arm/mps3r.c                    |  2 +
 hw/arm/msf2-som.c                 |  3 +-
 hw/arm/musca.c                    |  3 ++
 hw/arm/musicpal.c                 |  3 +-
 hw/arm/netduino2.c                |  3 +-
 hw/arm/netduinoplus2.c            |  3 +-
 hw/arm/npcm7xx_boards.c           |  6 +++
 hw/arm/npcm8xx_boards.c           |  2 +
 hw/arm/olimex-stm32-h405.c        |  3 +-
 hw/arm/omap_sx1.c                 |  3 ++
 hw/arm/orangepi.c                 |  3 +-
 hw/arm/raspi.c                    |  6 +++
 hw/arm/raspi4b.c                  |  2 +
 hw/arm/realview.c                 |  5 +++
 hw/arm/sabrelite.c                |  3 +-
 hw/arm/sbsa-ref.c                 |  3 ++
 hw/arm/stellaris.c                |  3 ++
 hw/arm/stm32vldiscovery.c         |  3 +-
 hw/arm/versatilepb.c              |  3 ++
 hw/arm/vexpress.c                 |  3 ++
 hw/arm/virt-acpi-build.c          |  1 +
 hw/arm/virt.c                     | 74 ++++++++++++++++++-------------
 hw/arm/xilinx_zynq.c              |  2 +
 hw/arm/xlnx-versal-virt.c         |  3 ++
 hw/arm/xlnx-zcu102.c              |  2 +
 hw/core/null-machine.c            |  6 ++-
 hw/riscv/riscv-iommu.c            |  6 ++-
 hw/riscv/riscv_hart.c             |  2 +-
 hw/xen/xen-hvm-common.c           |  9 ++--
 target-info-qom.c                 | 24 ++++++++++
 target-info.c                     | 21 +++++++++
 target/arm/machine.c              | 18 ++++++++
 configs/targets/meson.build       |  5 +++
 hw/arm/meson.build                |  8 ++--
 hw/xen/meson.build                | 22 ++++-----
 60 files changed, 406 insertions(+), 75 deletions(-)
 create mode 100644 include/hw/arm/machines-qom.h
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c
 create mode 100644 target-info-qom.c
 create mode 100644 configs/targets/meson.build

-- 
2.51.0


