Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F624CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Pm-0005ZI-BP; Tue, 07 Oct 2025 10:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pj-0005Xy-Me
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pc-000264-LY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:11:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so49120975e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846285; x=1760451085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=b3NM8pke1j1hp8yVwYAVui2MboXLWX0CntlGA5K2mRs=;
 b=Rd9WYBwDIKzEMilKXmbJyb21ERmoIJh7EaDp/k67CfHiyd2i/jgvzqx5vykAf9DmEZ
 KPL9RiJaflXo12u0eaDhx60fFo/s4aHnNL9o1pJUh2PTYfU4Y8wpD7THrXFmkSm+FW51
 B2c/9LGqb2bC420ZUzBp5aUNsJUY7NHp0/QRBSDfbduHeeCT/W1uFnz8ZTirfKNIBUEU
 woP6RKQyABKrRppBJj1dDd3F1daKbUHLi9fgUMe8m/rbSR0y7egOwNbX1PXCoccZG0PU
 seeGlQjgMTIWclukMlnW1T5trygabfHLUjlxi5L5VhNWCiLsotjhktNjo2JvcbXsmLW+
 5cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846285; x=1760451085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b3NM8pke1j1hp8yVwYAVui2MboXLWX0CntlGA5K2mRs=;
 b=dNTsisKJO0+dGkuEjlIAOB2+Cb0fV3fShUKmt7hMcNTh3hsQ8sWOY6NJLVSMKRUMJQ
 GL0a6Y/cCnsx5ExJEFbDnrrT8jxsKawXTbeTFDxHOGU9WKpBQa9wwa8WR5MWnTeEPHHd
 isn2hxnoMblVvHjICU2haDWYHZBP0QKJK+m/xxwkKe28aBwq65Vm517AfO0gVRwsKicl
 u2c4dv9j19daVBGCJczKtaK0gv43GWOdkpxLIlkTRdiWPapV3MCZ7eNrFFCw1qJM80h8
 gDebjhD/GwtfjLhi4YIEMFo75jzBVzmT6v4UGv2vS5BFKOlnW8++JJqtflfcwWBGkLJf
 EHsg==
X-Gm-Message-State: AOJu0YzDmLzkNGXrTcVIuVau95XSP1vyAZYOhW5YTJKDPMp14dFTe627
 xOK9PVp3EX6woASkHhANYqlnbkjP1v39ypYil+biiT3CcmOBVM+FS+9FtOMMtE01xoonlV27gPJ
 YuTVh
X-Gm-Gg: ASbGnctMDFZeajy2V/m8hYkwRqMEqgE0B3LcmaUqqhAY47xv4A+eu+ELi2KKk/MI9GU
 lhARPFd5qaXgQy7lALbKDRORcjlI+QuEhIzQqoOhp8kNhP5wxCqUyVcWHtfJk43UMAOSq6phELL
 QePYXn/D4Ax3PHCz9WMJ0srHlLhZNAhNvinWzsJKumRd8eiY1Um4CGHl4CK2O3iq3zVv9gbleEe
 CTvfACkVtN2LtQbr/h6LLKOwY3SfrgYDtQN6JZk5oOXm1YwnfZCFAjtLjVStl5gKwImZnEGP4XU
 vs4NSYNIeZ2RXU2Wd3oNPWS4S9GoEvF6BYWOv8PPBG0zYrHMKMjIsolWpwFawY0gYOo70jErUC1
 k+hIG13+B6jQLhLeENi1EWCet+p9rC7GzNsD7Aqk6982guRAPzRYxrAVP
X-Google-Smtp-Source: AGHT+IFpYoJ5BLFqZtF4xCU2iAqg9RW22UBaOn+vTxRHGvkukm6iheLKP/x5iSLEUaKpU42iyhZJFw==
X-Received: by 2002:a05:600c:628b:b0:46e:4883:27d with SMTP id
 5b1f17b1804b1-46e71147470mr118922325e9.30.1759846285262; 
 Tue, 07 Oct 2025 07:11:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/62] target-arm queue
Date: Tue,  7 Oct 2025 15:10:20 +0100
Message-ID: <20251007141123.3239867-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Hi; here's the target-arm queue. This is a little bigger than
I prefer, but the bulk of it is Luc's versal2 series.

thanks
-- PMM

The following changes since commit eb7abb4a719f93ddd56571bf91681044b4159399:

  hw/intc/loongarch_dintc: Set class_size for LoongArchDINTCClass (2025-10-06 13:54:50 -0700)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251007

for you to fetch changes up to 932cac41ca633f24f192a69770bf91b55c4d27bb:

  target/arm: Enable FEAT_RME_GPC2 for -cpu max with x-rme (2025-10-07 11:26:10 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Don't set HCR.RW for AArch32 only CPUs
 * new board model: amd-versal2-virt
 * xlnx-zynqmp: model the GIC for the Cortex-R5 RPU cluster
 * hw/arm: Remove sl_bootparam_write() and 'hw/arm/sharpsl.h' header
 * Emulate FEAT_RME_GPC2

----------------------------------------------------------------
Clément Chigot (2):
      hw/arm/xlnx-zynqmp: move GIC_NUM_SPI_INTR define in header
      hw/arm/xlnx-zynqmp: introduce helper to compute RPU number

Francisco Iglesias (1):
      hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property

Frederic Konrad (1):
      hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5

Luc Michel (46):
      hw/arm/xlnx-versal: split the xlnx-versal type
      hw/arm/xlnx-versal: prepare for FDT creation
      hw/arm/xlnx-versal: uart: refactor creation
      hw/arm/xlnx-versal: canfd: refactor creation
      hw/arm/xlnx-versal: sdhci: refactor creation
      hw/arm/xlnx-versal: gem: refactor creation
      hw/arm/xlnx-versal: adma: refactor creation
      hw/arm/xlnx-versal: xram: refactor creation
      hw/arm/xlnx-versal: usb: refactor creation
      hw/arm/xlnx-versal: efuse: refactor creation
      hw/arm/xlnx-versal: ospi: refactor creation
      hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
      hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
      hw/arm/xlnx-versal: bbram: refactor creation
      hw/arm/xlnx-versal: trng: refactor creation
      hw/arm/xlnx-versal: rtc: refactor creation
      hw/arm/xlnx-versal: cfu: refactor creation
      hw/arm/xlnx-versal: crl: refactor creation
      hw/arm/xlnx-versal-virt: virtio: refactor creation
      hw/arm/xlnx-versal: refactor CPU cluster creation
      hw/arm/xlnx-versal: add the mp_affinity property to the CPU mapping
      hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
      hw/arm/xlnx-versal: add support for multiple GICs
      hw/arm/xlnx-versal: add support for GICv2
      hw/arm/xlnx-versal: rpu: refactor creation
      hw/arm/xlnx-versal: ocm: refactor creation
      hw/arm/xlnx-versal: ddr: refactor creation
      hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
      hw/misc/xlnx-versal-crl: remove unnecessary include directives
      hw/misc/xlnx-versal-crl: split into base/concrete classes
      hw/misc/xlnx-versal-crl: refactor device reset logic
      hw/arm/xlnx-versal: reconnect the CRL to the other devices
      hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ indices
      hw/arm/xlnx-versal: tidy up
      hw/misc/xlnx-versal-crl: add the versal2 version
      hw/arm/xlnx-versal: add a per_cluster_gic switch to VersalCpuClusterMap
      hw/arm/xlnx-versal: add the target field in IRQ descriptor
      target/arm/tcg/cpu64: add the cortex-a78ae CPU
      hw/arm/xlnx-versal: add versal2 SoC
      hw/arm/xlnx-versal-virt: rename the machine to amd-versal-virt
      hw/arm/xlnx-versal-virt: split into base/concrete classes
      hw/arm/xlnx-versal-virt: tidy up
      docs/system/arm/xlnx-versal-virt: update supported devices
      docs/system/arm/xlnx-versal-virt: add a note about dumpdtb
      hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt machine
      tests/functional/test_aarch64_xlnx_versal: test the versal2 machine

Peter Maydell (1):
      target/arm: Don't set HCR.RW for AArch32 only CPUs

Philippe Mathieu-Daudé (1):
      hw/arm: Remove sl_bootparam_write() and 'hw/arm/sharpsl.h' header

Richard Henderson (10):
      target/arm: Add isar feature test for FEAT_RME_GPC2
      target/arm: Add GPCCR fields from ARM revision L.b
      target/arm: Enable FEAT_RME_GPC2 bits in gpccr_write
      target/arm: Add cur_space to S1Translate
      target/arm: GPT_Secure is reserved without FEAT_SEL2
      target/arm: Implement GPT_NonSecureOnly
      target/arm: Implement SPAD, NSPAD, RLPAD
      target/arm: Fix GPT fault type for address outside PPS
      target/arm: Implement APPSAA
      target/arm: Enable FEAT_RME_GPC2 for -cpu max with x-rme

 MAINTAINERS                                  |    1 -
 docs/system/arm/emulation.rst                |    1 +
 docs/system/arm/xlnx-versal-virt.rst         |   80 +-
 include/hw/arm/sharpsl.h                     |   17 -
 include/hw/arm/xlnx-versal-version.h         |   16 +
 include/hw/arm/xlnx-versal.h                 |  342 +---
 include/hw/arm/xlnx-zynqmp.h                 |    5 +
 include/hw/intc/arm_gicv3_common.h           |    1 +
 include/hw/misc/xlnx-versal-crl.h            |  366 +++-
 target/arm/cpu-features.h                    |    5 +
 target/arm/cpu.h                             |    6 +
 hw/arm/xlnx-versal-virt.c                    |  741 ++------
 hw/arm/xlnx-versal.c                         | 2546 +++++++++++++++++++-------
 hw/arm/xlnx-zynqmp.c                         |  103 +-
 hw/gpio/zaurus.c                             |   42 -
 hw/intc/arm_gicv3_common.c                   |    3 +-
 hw/intc/arm_gicv3_cpuif.c                    |    2 +-
 hw/intc/arm_gicv3_kvm.c                      |    6 +
 hw/misc/xlnx-versal-crl.c                    |  614 ++++++-
 target/arm/helper.c                          |    8 +-
 target/arm/ptw.c                             |   95 +-
 target/arm/tcg/cpu64.c                       |   81 +-
 tests/functional/aarch64/test_xlnx_versal.py |   12 +-
 23 files changed, 3292 insertions(+), 1801 deletions(-)
 delete mode 100644 include/hw/arm/sharpsl.h
 create mode 100644 include/hw/arm/xlnx-versal-version.h

