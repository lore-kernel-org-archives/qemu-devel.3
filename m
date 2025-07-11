Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2C4C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDtg-0004Mh-4S; Fri, 11 Jul 2025 09:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtc-0004Lo-FD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDta-0002uy-0A
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-454ac069223so17076265e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240872; x=1752845672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xRsTG4P4X0f4QdplRbioZnf6v3d7mTePa4rDIHqnp+E=;
 b=GxWgp1dD60t74yU8glBbhgaD0uI6J5xukU3LEwjbfDOW1Gpf+zTPe7+cm+0TkCu68P
 zKgO3dSbayOsdbeKIm850FIIwrBcSvJVYD4gNAs2XJbgsMOlXaW1Hi79PZeXQWgk8o6y
 8X0SduD0dfZNWuLQIZQM0DMJ0WUJ53WYmfV/nuKfG6zTxddwKxxTmCRg75QPca2QdG7e
 BRDAL/+PF/7sa5vjidfEl/lM7VOSIE9+Wp+wfynvywNrUju+XhUMd2lMDLsWGUV4fCIP
 W0N2tcpUvMSYCVRAy/wKH1pA+8tQWEHmZ5zlvO68+O9jD8Z5Rt2zN/jfk25im8JiqFRm
 HqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240872; x=1752845672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xRsTG4P4X0f4QdplRbioZnf6v3d7mTePa4rDIHqnp+E=;
 b=G96lIeMbcge2YsCCiAZf98nu8FofzSI8WHdbhPSCEtajR/41m9gV3pqnWvuETSxUT7
 V3/3gmbNayZ8DfuNGlP8m6ckJnYX9/2sFPr0OaW1XcgxrSC2STBK582X0+mODVwCz1dt
 bv1I1O85dMARIIixbgit30IoVEj/gfImMdzkgFMc21iqKf6gKfP10ogik7IGfq6HBJzn
 fSezyt0BphgxwpZs0y9bpHWmzXfzDIKijtnkMOQ27ikkpsy+/x63ug3nVDjI7jz1B27M
 Mvo2hsiMii9yGBjOF2EBddai4VOQPsIIkCaQ33JIFTRGmq7l6ozcvE7+KVPV7gaAQJ1a
 8Bdg==
X-Gm-Message-State: AOJu0YzZWFu/8AYcLFQVYlwR0C+RuC5lwX3aZuroUH0iHD8RlyyasdbH
 Fz84PIq/kM6V9eVo4t1fxNo1vkG1JMOUypokpTDh/FH5/0DrIle9Nq8dxBCryUiQiBOwPPiTayJ
 /3//J
X-Gm-Gg: ASbGnctdysCwab/3DidwCa52CZjpxjXoWbXeJaojkw5XRP/1ZFgZX7sQ2FPbDkZg/DH
 i8PFajHEbTrSk4wKSGu5/BKctdEiyMvhLtIpu/ii6NTtQqSwmfQthT2tl9YdbQvSllfhwWhg8Rc
 u2abIfcOB6366RhkvWuaOAKnVHCvr5jg5jslA7pT7qDhpFz6Xiej880rM1MPaMOsKRgvJRfnDOB
 KgUQwJdOjETfa5/azWLTYvReSQPkdQOdx8BmNKAEo7Usvx14iwahzlKjgEYD9NyTK7uPDcRR9HY
 8xgfKWKdjespwEAFwEo6g789RTaYa+uAAZywKssx4eCyWjE2lF10AaNt31Pl2pMtEdhS5xSU6YI
 ZIWsUkHfm6AuSY693KMLHWiwlEWyL
X-Google-Smtp-Source: AGHT+IHR2oVz4QOaR9tqqbMDbCR6GKJQPgRjLKMPUu3nCgSBwhmVzUB/tn8JS/plE2GW/AykEx4WXw==
X-Received: by 2002:a05:600c:19ca:b0:442:f4a3:a2c0 with SMTP id
 5b1f17b1804b1-454e2b4b6d2mr37620565e9.13.1752240871782; 
 Fri, 11 Jul 2025 06:34:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/36] target-arm queue
Date: Fri, 11 Jul 2025 14:33:53 +0100
Message-ID: <20250711133429.1423030-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Hi; this should be my last major pullreq before softfreeze: it has
the nested-virt support, a new Cortex-M4 based board model, and
the CXL-on-arm patchset.

thanks
-- PMM

The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba336:

  Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu into staging (2025-07-07 09:22:41 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250711

for you to fetch changes up to 3a323a813fd42fc7c37ef09bc7a714d8e31691ce:

  tests/functional: Add a test for the MAX78000 arm machine (2025-07-11 13:30:32 +0100)

----------------------------------------------------------------
target-arm queue:
 * New board type max78000fthr
 * Enable use of CXL on Arm 'virt' board
 * Some more tidyup of ID register handling
 * Refactor AT insns and PMU regs into separate source files
 * Don't enforce NSE,NS check for EL3->EL3 returns
 * hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ
 * Allow nested-virtualization with KVM on the 'virt' board
 * system/qdev: Remove pointless NULL check in qdev_device_add_from_qdict
 * hw/arm/virt-acpi-build: Don't create ITS id mappings by default
 * target/arm: Remove unused helper_sme2_luti4_4b

----------------------------------------------------------------
Bernhard Beschow (1):
      hw/arm/fsl-imx8mp: Wire VIRQ and VFIQ

Cornelia Huck (5):
      arm/cpu: store id_afr0 into the idregs array
      arm/cpu: store id_aa64afr{0,1} into the idregs array
      arm/cpu: fix trailing ',' for SET_IDREG
      arm/cpu: store clidr into the idregs array
      arm/kvm: shorten one overly long line

Eric Auger (1):
      hw/arm/arm_gicv3_kvm: Add a migration blocker with kvm nested virt

Haibo Xu (3):
      hw/arm: Allow setting KVM vGIC maintenance IRQ
      target/arm/kvm: Add helper to detect EL2 when using KVM
      target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported

Jackson Donaldson (13):
      MAX78000: Add MAX78000FTHR Machine
      MAX78000: ICC Implementation
      MAX78000: Add ICC to SOC
      MAX78000: UART Implementation
      MAX78000: Add UART to SOC
      MAX78000: GCR Implementation
      MAX78000: Add GCR to SOC
      MAX78000: TRNG Implementation
      MAX78000: Add TRNG to SOC
      MAX78000: AES implementation
      MAX78000: Add AES to SOC
      docs/system: arm: Add max78000 board description
      tests/functional: Add a test for the MAX78000 arm machine

Jonathan Cameron (5):
      hw/cxl-host: Add an index field to CXLFixedMemoryWindow
      hw/cxl: Make the CXL fixed memory windows devices.
      hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances pxb-cxl
      docs/cxl: Add an arm/virt example.
      qtest/cxl: Add aarch64 virt test for CXL

Peter Maydell (2):
      target/arm: Don't enforce NSE,NS check for EL3->EL3 returns
      hw/arm/virt: Allow virt extensions with KVM

Philippe Mathieu-Daudé (1):
      system/qdev: Remove pointless NULL check in qdev_device_add_from_qdict

Richard Henderson (4):
      target/arm: Drop stub for define_tlb_insn_regs
      target/arm: Split out AT insns to tcg/cpregs-at.c
      target/arm: Split out performance monitor regs to cpregs-pmu.c
      target/arm: Remove helper_sme2_luti4_4b

Shameer Kolothum (1):
      hw/arm/virt-acpi-build: Don't create ITS id mappings by default

 docs/system/arm/max78000.rst              |   37 +
 docs/system/arm/virt.rst                  |    9 +
 docs/system/devices/cxl.rst               |   11 +
 docs/system/target-arm.rst                |    1 +
 include/hw/arm/max78000_soc.h             |   50 +
 include/hw/arm/virt.h                     |    4 +
 include/hw/char/max78000_uart.h           |   78 ++
 include/hw/cxl/cxl.h                      |    5 +-
 include/hw/cxl/cxl_host.h                 |    5 +-
 include/hw/intc/arm_gicv3_common.h        |    1 +
 include/hw/misc/max78000_aes.h            |   68 ++
 include/hw/misc/max78000_gcr.h            |  131 +++
 include/hw/misc/max78000_icc.h            |   33 +
 include/hw/misc/max78000_trng.h           |   35 +
 target/arm/cpregs.h                       |    3 +
 target/arm/cpu.h                          |    6 +-
 target/arm/internals.h                    |    5 +
 target/arm/kvm_arm.h                      |    7 +
 target/arm/tcg/helper.h                   |    1 -
 target/arm/cpu-sysregs.h.inc              |    4 +
 hw/acpi/cxl.c                             |   76 +-
 hw/arm/fsl-imx8mp.c                       |    4 +
 hw/arm/max78000_soc.c                     |  232 ++++
 hw/arm/max78000fthr.c                     |   50 +
 hw/arm/virt-acpi-build.c                  |   40 +-
 hw/arm/virt.c                             |   52 +-
 hw/char/max78000_uart.c                   |  285 +++++
 hw/cxl/cxl-host-stubs.c                   |    7 +-
 hw/cxl/cxl-host.c                         |  174 ++-
 hw/i386/pc.c                              |   50 +-
 hw/intc/arm_gicv3_common.c                |    1 +
 hw/intc/arm_gicv3_kvm.c                   |   29 +
 hw/intc/armv7m_nvic.c                     |    4 +-
 hw/misc/max78000_aes.c                    |  223 ++++
 hw/misc/max78000_gcr.c                    |  351 ++++++
 hw/misc/max78000_icc.c                    |  120 ++
 hw/misc/max78000_trng.c                   |  139 +++
 system/qdev-monitor.c                     |    9 +-
 target/arm/cpregs-pmu.c                   | 1309 +++++++++++++++++++++
 target/arm/cpu64.c                        |    8 +-
 target/arm/helper.c                       | 1813 +----------------------------
 target/arm/kvm-stub.c                     |    5 +
 target/arm/kvm.c                          |   24 +-
 target/arm/tcg-stubs.c                    |    5 -
 target/arm/tcg/cpregs-at.c                |  519 +++++++++
 target/arm/tcg/cpu-v7m.c                  |   16 +-
 target/arm/tcg/cpu32.c                    |   34 +-
 target/arm/tcg/cpu64.c                    |   68 +-
 target/arm/tcg/helper-a64.c               |   20 +-
 target/arm/tcg/vec_helper.c               |    1 -
 tests/qtest/cxl-test.c                    |   58 +-
 hw/arm/Kconfig                            |   15 +
 hw/arm/meson.build                        |    2 +
 hw/char/Kconfig                           |    3 +
 hw/char/meson.build                       |    1 +
 hw/misc/Kconfig                           |   12 +
 hw/misc/meson.build                       |    4 +
 target/arm/meson.build                    |    2 +
 target/arm/tcg/meson.build                |    1 +
 tests/functional/meson.build              |    1 +
 tests/functional/test_arm_max78000fthr.py |   48 +
 tests/qtest/meson.build                   |    1 +
 62 files changed, 4300 insertions(+), 2010 deletions(-)
 create mode 100644 docs/system/arm/max78000.rst
 create mode 100644 include/hw/arm/max78000_soc.h
 create mode 100644 include/hw/char/max78000_uart.h
 create mode 100644 include/hw/misc/max78000_aes.h
 create mode 100644 include/hw/misc/max78000_gcr.h
 create mode 100644 include/hw/misc/max78000_icc.h
 create mode 100644 include/hw/misc/max78000_trng.h
 create mode 100644 hw/arm/max78000_soc.c
 create mode 100644 hw/arm/max78000fthr.c
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 hw/misc/max78000_aes.c
 create mode 100644 hw/misc/max78000_gcr.c
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 hw/misc/max78000_trng.c
 create mode 100644 target/arm/cpregs-pmu.c
 create mode 100644 target/arm/tcg/cpregs-at.c
 create mode 100755 tests/functional/test_arm_max78000fthr.py

