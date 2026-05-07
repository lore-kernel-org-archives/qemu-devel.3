Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E682CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11G-0003Rn-Ng; Thu, 07 May 2026 11:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL116-0003ON-NY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL114-0003jM-IN
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ad135063so9671915e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169116; x=1778773916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=e7ji0TjByY9J1ucK+70VU+hsuVqz9IoJ8twiSP9TLRs=;
 b=PxbhFAcv4DlFvJqCFtvocRu2Z1mQJNX2iS9ZgKUPUDaua9wUbV1Uc9cy4+qvx4EhgV
 BCiOhhWh+0X6D2q2+DFR08pdLCZ81fNmzo6S+S/yJeBcYPRYuz4iXMb+V74UBh+Rk/Jw
 HUU4ZzCbyCnAGnngd8BK7nw0ZS3ZH4yETJzWPVM5SaJlMQkNcA9YN0jbtUPkCWCvAMOv
 6L7RkexPi/OA3Vh8xUDRMZ4YfjkceoW78m7qMCc3jgCOQ/402cFfAqecZuUU/7fIu4Iv
 owijSZvJLQF+WIGEdg3I3wQ1bRsWlkhz6kKaUpLkOBd8u7UKmCVZOWxG2U99z79TkCxa
 0AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169116; x=1778773916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7ji0TjByY9J1ucK+70VU+hsuVqz9IoJ8twiSP9TLRs=;
 b=hd8aQswdsfmexmyDwn1qxS48bSMkaFTXjxYxrKtqWSAwSX6vBMgMrozC331lMc/u10
 1GTPjIIpWYiUuM21zDi+jCSLi3rGaNArwBnJ7OU/kfMMB6n1ax84dJav/KXJzd+RYxvc
 2ENIPe1aKtQ/6i4e5O/+0IXDiTifKdojBbMRikuBOwo8ACjRpog7QwCnHBEy6xDcV2dj
 YAUvbEc9RQgEs4WFTR0JABl8upa3C4iHLsLNie0rDgBbgv2cD7OXe6yM420H+55kd87C
 nY5gf9JS38+1i0b8J+P1Clvh2ykyS0uXHGRBU3o6piNIK9DqnfYYzLvucGg+q/PfuUGy
 hMNg==
X-Gm-Message-State: AOJu0YwnsszU1Njq1YB8lzqaFOWgINFFC93ihLHNIVVOFhZbIbtjtVXR
 ngn4emQzY+T9YcJ5phzJ4DQRODTnseEpJPBvoXa7HuawYQuZT+cQ4s8CzDK0t1rydTO4BZC+/62
 xb8VN
X-Gm-Gg: AeBDieuA6PzFkEsdg6e3yLwgBcBR/xYJjYnKOXLbf5mduWdhgNAahcowQySsN8b3lac
 9KJsMSZk4dJtoHjpLNZaM7RHybOAlapKiYxDGuvLigmzgh7pt1otpi7L2xUVMwhCuCslphTkcw5
 cwoEtRxjR8wRXbEaBZaCiJFcKr7z7/G9HHEvCvhyGHoWhquosuSsrgUrvI6JegMY+v1e9PZZOWz
 /n4NBrbAI2aawI3wjZdLRuGTkRVGVn6ajHbIkPsZPitB+4syTHAg2m2VkqgkPUk27csUBHVwXy3
 0SieyEW7URFD9cLUOHiGYr5GAfV+5rsyUdT28x30jXaoCEvePpHsWZyH8qxGsTvDd0hhRgQma10
 sQUp4zOyfmk0GCQIApqd/uc6p3lkbpxcuzXelOxEVsKPn3KzeCWE/B7llxaPzjyRnsedZc8ejkV
 t4jUaNpi32K0pqAfUJUw9XSFWPpE4iM8rd/jA5UqKIWgyl9VwfkfVGMK4Ay/c6/Oo02XMSye19Y
 mSaQXNIGvBCUFjzqezHrcdHfMM0Jmo=
X-Received: by 2002:a05:600c:3f18:b0:487:2671:fb8f with SMTP id
 5b1f17b1804b1-48e51e19668mr137675255e9.8.1778169115910; 
 Thu, 07 May 2026 08:51:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.51.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:51:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/67] target-arm queue
Date: Thu,  7 May 2026 16:50:47 +0100
Message-ID: <20260507155154.1886557-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Hi; here's another arm pullreq. This is big but it's almost
entirely the GICv5 emulation. I did throw in a couple of other
tiny bugfix patches.

thanks
-- PMM

The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260507

for you to fetch changes up to 18b664c90085b0d2be9c2ad8c747e00a7a733402:

  hw/misc/bcm2835_rng: Specify valid memory access sizes (2026-05-07 15:14:58 +0100)

----------------------------------------------------------------
target-arm queue:
 * Initial experimental GICv5 interrupt controller emulation
 * target/arm: Report IL=0 for Thumb 16-bit BKPT insn
 * hw/misc/bcm2835_rng: Specify valid memory access sizes

----------------------------------------------------------------
Peter Maydell (67):
      qom/object: Add object_resolve_and_typecheck()
      hw/core: Permit devices to define an array of link properties
      hw/intc: Skeleton of GICv5 IRS classes
      hw/arm/Kconfig: select ARM_GICV5 for ARM_VIRT board
      hw/intc/arm_gicv5: Implement skeleton code for IRS register frames
      hw/intc/arm_gicv5: Add migration blocker
      hw/intc/arm_gicv5: Create and validate QOM properties
      hw/intc/arm_gicv5: Create inbound GPIO lines for SPIs
      hw/intc/arm_gicv5: Define macros for config frame registers
      hw/intc/arm_gicv5: Implement IRS ID regs
      hw/intc/arm_gicv5: Add link property for MemoryRegion for DMA
      hw/intc/arm_gicv5: Implement gicv5_class_name()
      hw/intc/arm_gicv5: Add defines for GICv5 architected PPIs
      target/arm: GICv5 cpuif: Initial skeleton and GSB barrier insns
      target/arm: Set up pointer to GICv5 in each CPU
      hw/intc/arm_gicv5: Implement IRS_IST_{BASER, STATUSR, CFGR}
      hw/intc/arm_gicv5: Cache LPI IST config in a struct
      hw/intc/arm_gicv5: Implement gicv5_set_priority()
      target/arm: GICv5 cpuif: Implement the GIC CDPRI instruction
      hw/intc/arm_gicv5: Implement IRS_MAP_L2_ISTR
      hw/intc/arm_gicv5: Implement remaining set-config functions
      target/arm: GICv5 cpuif: Implement GIC CD* insns for setting config
      hw/intc/arm_gicv5: Create backing state for SPIs
      hw/intc/arm_gicv5: Make gicv5_set_* update SPI state
      hw/intc/arm_gicv5: Implement gicv5_request_config()
      target/arm: GICv5 cpuif: Implement GIC CDRCFG and ICC_ICSR_EL1
      hw/intc/arm_gicv5: Implement IRS_SPI_{SELR, STATUSR, CFGR, DOMAINR}
      hw/intc/arm_gicv5: Update SPI state for CLEAR/SET events
      hw/intc/arm_gicv5: Implement IRS_CR0 and IRS_CR1
      hw/intc/arm_gicv5: Implement IRS_SYNCR and IRS_SYNC_STATUSR
      hw/intc/arm_gicv5: Implement IRS_PE_{CR0, SELR, STATUSR}
      hw/intc/arm_gicv5: Implement CoreSight ID registers
      hw/intc/arm_gicv5: Cache pending LPIs in a hash table
      target/arm: GICv5 cpuif: Implement ICC_IAFFIDR_EL1
      target/arm: GICv5 cpuif: Implement ICC_IDR0_EL1
      target/arm: GICv5 cpuif: Implement GICv5 PPI active set/clear registers
      target/arm: GICv5 cpuif: Implement PPI handling mode register
      target/arm: GICv5 cpuif: Implement PPI pending status registers
      target/arm: GICv5 cpuif: Implement PPI enable register
      target/arm: GICv5 cpuif: Implement PPI priority registers
      target/arm: GICv5 cpuif: Implement ICC_APR_EL1 and ICC_HAPR_EL1
      target/arm: GICv5 cpuif: Calculate the highest priority PPI
      hw/intc/arm_gicv5: Calculate HPPI in the IRS
      target/arm: GICv5 cpuif: Implement ICC_CR0_EL1
      target/arm: GICv5 cpuif: Implement ICC_PCR_EL1
      target/arm: GICv5 cpuif: Implement ICC_HPPIR_EL1
      hw/intc/arm_gicv5: Implement Activate command
      target/arm: GICv5 cpuif: Implement GICR CDIA command
      target/arm: GICv5 cpuif: Implement GIC CDEOI
      hw/intc/arm_gicv5: Implement Deactivate command
      target/arm: GICv5 cpuif: Implement GIC CDDI
      target/arm: GICv5 cpuif: Signal IRQ or FIQ
      target/arm: Connect internal interrupt sources up as GICv5 PPIs
      target/arm: Add has_gcie property to enable FEAT_GCIE
      hw/intc/arm_gicv3_cpuif: Don't allow GICv3 if CPU has GICv5 cpuif
      hw/arm/virt: Remember CPU phandles rather than looking them up by name
      hw/arm/virt: Move MSI controller creation out of create_gic()
      hw/arm/virt: Pull "wire CPU interrupts" out of create_gic()
      hw/arm/virt: Split GICv2 and GICv3/4 creation
      hw/arm/virt: Create and connect GICv5
      hw/arm/virt: Advertise GICv5 in the DTB
      hw/arm/virt: Handle GICv5 in interrupt bindings for PPIs
      hw/arm/virt: Use correct interrupt type for GICv5 SPIs in the DTB
      hw/arm/virt: Enable GICv5 CPU interface when using GICv5
      hw/arm/virt: Allow user to select GICv5
      target/arm: Report IL=0 for Thumb 16-bit BKPT insn
      hw/misc/bcm2835_rng: Specify valid memory access sizes

 docs/system/arm/virt.rst           |   19 +
 hw/arm/Kconfig                     |    1 +
 hw/arm/virt.c                      |  527 +++++++---
 hw/core/qdev-properties.c          |   78 ++
 hw/intc/Kconfig                    |    5 +
 hw/intc/arm_gicv3.c                |    2 +-
 hw/intc/arm_gicv3_cpuif.c          |   14 +-
 hw/intc/arm_gicv5.c                | 1962 ++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  215 ++++
 hw/intc/gicv3_internal.h           |    2 +-
 hw/intc/meson.build                |    4 +
 hw/intc/trace-events               |   23 +
 hw/misc/bcm2835_rng.c              |    4 +
 include/hw/arm/fdt.h               |   10 +
 include/hw/arm/virt.h              |   15 +
 include/hw/core/qdev-properties.h  |   41 +
 include/hw/intc/arm_gicv5.h        |   51 +
 include/hw/intc/arm_gicv5_common.h |  247 +++++
 include/hw/intc/arm_gicv5_stream.h |  228 +++++
 include/hw/intc/arm_gicv5_types.h  |  110 ++
 include/qom/object.h               |   17 +
 meson.build                        |    1 +
 qom/object.c                       |   41 +-
 target/arm/cpregs-pmu.c            |    9 +-
 target/arm/cpu-features.h          |    6 +
 target/arm/cpu.c                   |   62 ++
 target/arm/cpu.h                   |   28 +
 target/arm/helper.c                |   21 +
 target/arm/internals.h             |    9 +
 target/arm/tcg-stubs.c             |    4 +
 target/arm/tcg/gicv5-cpuif.c       |  952 +++++++++++++++++
 target/arm/tcg/meson.build         |    1 +
 target/arm/tcg/trace-events        |   11 +
 target/arm/tcg/trace.h             |    1 +
 target/arm/tcg/translate.c         |    2 +-
 35 files changed, 4564 insertions(+), 159 deletions(-)
 create mode 100644 hw/intc/arm_gicv5.c
 create mode 100644 hw/intc/arm_gicv5_common.c
 create mode 100644 include/hw/intc/arm_gicv5.h
 create mode 100644 include/hw/intc/arm_gicv5_common.h
 create mode 100644 include/hw/intc/arm_gicv5_stream.h
 create mode 100644 include/hw/intc/arm_gicv5_types.h
 create mode 100644 target/arm/tcg/gicv5-cpuif.c
 create mode 100644 target/arm/tcg/trace-events
 create mode 100644 target/arm/tcg/trace.h

