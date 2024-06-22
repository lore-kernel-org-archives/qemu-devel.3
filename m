Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7492EC2BD05
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWG-0007vi-UW; Sat, 22 Jun 2024 08:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW7-0007ki-RY
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW4-0000JA-A0
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-366dcd21604so626614f8f.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058005; x=1719662805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8TqPjrWurcxaMYlphBRpDrxRDcnk63JB/olF+Qaq8DA=;
 b=aJNeuXWPhlwKkxQE6kLcIU0Ish/CkVVAY0b/IpVvddDazz5M+tchfT6pBQoX8w3v0v
 KBIOI6GfFM1+ZLNTZKnpel4axCwxBvwqradUEboECEqdkXZvYBRx0qHPOVa/dJB/1k4D
 uYCI0hJ8naW7yUtzHkNT0FyuC1Csx3i8i9HIe3+UHuncLWZ4mrgM0o2JA3xUkw3zQU7G
 gUdhrUnXiXc77YkfQ6e9c3RJY0zn6RK1+WUdKgWF7IXS8JhOXS3g/UcLqoPb/QRerJgj
 asEdi6T+txAACs5owbeC+H/13cHDR1tj3n5uu/QxFVf5+JrMO9EXKU2VxWpOujzDw4cv
 Ix7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058005; x=1719662805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8TqPjrWurcxaMYlphBRpDrxRDcnk63JB/olF+Qaq8DA=;
 b=g6UiZyrLd5pSvmt+q3Sn19tA1xMNCgQELousY4tLp3SbDfssI8JUkagHr5Oc2TmAoA
 QK35rhGZJqTBLFERiZllAKuzwN5moXNOuhEX3UBgInaTQaeFswoyFjXSzLXmbA8K86n+
 0vZmohGsgqZap9cLaBtPQSqCzQdwpXvXn1fznnonQOETDo1ZErrHsb0Meubqz/0MXCSt
 wDDiUUlSwm68JnvFvBG7dH3pnoPu08jSx+1xppSn3D5YZXkCcKg3agIuVW7cCWJY74lh
 M6aNBwNop+B7D/0A4h4PvoPXlgjH0Ho5qC8nV7o9CaULr7bc7oGJZfOl7bVyaLJfCxfJ
 W7Qg==
X-Gm-Message-State: AOJu0YyZSZIdQNkz3iQeUHMDAjaha8xkqeOdcH0u8AVpXzZURJD3oiEh
 EiXUA1Ozz0lez0BOA/3m0mK7LAXw0fvl4/EGhyhx8f6bSTvmUbeICG+0Rnf9+OResuDCkWWizFL
 cEJk=
X-Google-Smtp-Source: AGHT+IG4hs+xO2yHu4yPpKVu5QIZdYMDYTjGL2gMYdM70OM6J9gLVOIw0BxMdVHHWjOnrd1+46yrjQ==
X-Received: by 2002:a5d:660c:0:b0:366:e7c8:453e with SMTP id
 ffacd0b85a97d-366e7c84697mr233493f8f.12.1719058005380; 
 Sat, 22 Jun 2024 05:06:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] target-arm queue
Date: Sat, 22 Jun 2024 13:06:25 +0100
Message-Id: <20240622120643.3797539-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Hi; here's the latest target-arm pullreq; this is pretty much
just various bugfixes.

-- PMM

The following changes since commit 02d9c38236cf8c9826e5c5be61780c4444cb4ae0:

  Merge tag 'pull-tcg-20240619' of https://gitlab.com/rth7680/qemu into staging (2024-06-19 14:00:39 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240622

for you to fetch changes up to 3b36cead6ecc0e40edb8b2f3e253baa01ebc1e9a:

  hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine (2024-06-21 16:24:46 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/net/can/xlnx-versal-canfd: Fix sorting of the tx queue
 * hw/arm/xilinx_zynq: Fix IRQ/FIQ routing
 * hw/intc/arm_gic: Fix deactivation of SPI lines
 * hw/timer/a9gtimer: Handle QTest mode in a9_gtimer_get_current_cpu
 * hw/misc: Set valid access size for Exynos4210 RNG
 * hw/arm/sbsa-ref: switch to 1GHz timer frequency
 * hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine
 * hw/arm/virt: allow creation of a second NonSecure UART
 * hw/arm/virt: Avoid unexpected warning from Linux guest on host with Fujitsu CPUs
 * scripts/coverity-scan/COMPONENTS.md: update component regexes
 * hw/usb/hcd-dwc2: Handle invalid address access in read and write functions
 * hw/usb/hcd-ohci: Fix ohci_service_td: accept zero-length TDs where CBP=BE+1

----------------------------------------------------------------
David Hubbard (1):
      hw/usb/hcd-ohci: Fix ohci_service_td: accept zero-length TDs where CBP=BE+1

Edgar E. Iglesias (1):
      hw/intc/arm_gic: Fix deactivation of SPI lines

Marcin Juszkiewicz (1):
      hw/arm/sbsa-ref: switch to 1GHz timer frequency

Peter Maydell (8):
      scripts/coverity-scan/COMPONENTS.md: Update paths to match gitlab CI
      scripts/coverity-scan/COMPONENTS.md: Fix 'char' component
      scripts/coverity-scan/COMPONENTS.md: Add crypto headers in host/include to the crypto component
      scripts/coverity-scan/COMPONENTS.md: Fix monitor component
      scripts/coverity-scan/COMPONENTS.md: Include libqmp in testlibs
      hw/arm/virt: Add serial aliases in DTB
      hw/arm/virt: Rename VIRT_UART and VIRT_SECURE_UART to VIRT_UART[01]
      hw/arm/virt: allow creation of a second NonSecure UART

Sebastian Huber (1):
      hw/arm/xilinx_zynq: Fix IRQ/FIQ routing

Shiva sagar Myana (1):
      hw/net/can/xlnx-versal-canfd: Fix sorting of the tx queue

Xiong Yining (1):
      hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa machine

Zhenyu Zhang (1):
      hw/arm/virt: Avoid unexpected warning from Linux guest on host with Fujitsu CPUs

Zheyu Ma (3):
      hw/timer/a9gtimer: Handle QTest mode in a9_gtimer_get_current_cpu
      hw/usb/hcd-dwc2: Handle invalid address access in read and write functions
      hw/misc: Set valid access size for Exynos4210 RNG

 docs/system/arm/sbsa.rst            |   4 ++
 docs/system/arm/virt.rst            |   6 +-
 hw/intc/gic_internal.h              |   8 ++-
 include/hw/arm/virt.h               |   5 +-
 hw/arm/sbsa-ref.c                   |  23 +++++---
 hw/arm/virt-acpi-build.c            |  22 +++++---
 hw/arm/virt.c                       |  63 ++++++++++++++++++---
 hw/arm/xilinx_zynq.c                |   5 +-
 hw/misc/exynos4210_rng.c            |   2 +
 hw/net/can/xlnx-versal-canfd.c      |   5 +-
 hw/timer/a9gtimer.c                 |   5 ++
 hw/usb/hcd-dwc2.c                   |   9 ++-
 hw/usb/hcd-ohci.c                   |   4 +-
 hw/usb/trace-events                 |   1 +
 scripts/coverity-scan/COMPONENTS.md | 107 ++++++++++++++++++------------------
 15 files changed, 179 insertions(+), 90 deletions(-)

