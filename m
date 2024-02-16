Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A39C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw04-00065T-0m; Fri, 16 Feb 2024 06:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw01-00061F-SA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ravzz-0000lb-Dy
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:03:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41243d19ecaso3261945e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081396; x=1708686196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J/rOTUJTmJCvqjsh8WtTyqg+93BkNUx8+ULq6Bp/Bug=;
 b=fdYthkvyuz/OIoxoABdELJ+mWlCHvQb3+IY8uSbimJ8LuOoMUZKab/CxaL6klMzsA8
 sQr6rpayXF4jsO47FRUKNKn/tm3yms9LbptI5uFD9adW6Q6qMLY9SPXts6SjuTcw5dnX
 MFKf6a9vqG3BcnDB/s9bksgYr/cj1SQkzQG9yszuh7LYa4VORA+9VZW1P9Tjn/0Y/5f0
 DW1w1g9SZoV2SDN5lEN+P3h0P3bn9+EOO6q8fadmVE/O+bzFI/NkY3W/EfK2r5UeLWiN
 Q5cuivXFayPNW6RIQNDyb0T8IQ522E3FWSPmMHAHS1xnuLbpy8sgkPGiaF/yThBXlv6L
 oaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081396; x=1708686196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J/rOTUJTmJCvqjsh8WtTyqg+93BkNUx8+ULq6Bp/Bug=;
 b=hbRIADehmvV0/pRtWEXgx17Luo6/K6uSD/7Q6E3/ooLEvw8M/2/WD9+VN8Zu2q6jCx
 H4hteM2HN0/Tr3JqTgvdOcpGhv8Y75TxdQcHtuq3AFiIW8TPW0+orC6e0hIppoqhYV2A
 w0ngv/q996zS+3Ky7ikMtV1RvIgDO8RxQfDV0JHAzz4jmDGxLzidD0+A5UAvYnOVip0W
 CoBT0Xt3tVUii+C5PvnU+kISy+HbeROgipjs8KLSMkYHfeMim7EchXnF0Q18XR+b3s0k
 ZOYYMhuHG+AheqTMSoyq+f/XleRwuBVVGadGZtxsTAzyzUoYbc+pP3T2G42aSKNaZdhB
 C+mQ==
X-Gm-Message-State: AOJu0YzVFy9Z5XQWpRzvDyyhS8z1n//0z4OSUOxqVw8NALgopxLtN8Xv
 1r6duahrIryxVMNXLhbJq42y5lJkTyWByzInzSqr6ZPaybCMAvs8Tz4s71R+sw4eZBNteSJx78N
 c
X-Google-Smtp-Source: AGHT+IEsdB3vxjY3T6aZ7NSbsF7V+UxUx9S6wCdTuQBu0J+MhJXRfnYM3ak42Az5TQ2crBtm6SdE2g==
X-Received: by 2002:a05:600c:3594:b0:412:62:86f8 with SMTP id
 p20-20020a05600c359400b00412006286f8mr3582788wmq.4.1708081396553; 
 Fri, 16 Feb 2024 03:03:16 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 bv9-20020a0560001f0900b0033b1277e95dsm1927322wrb.77.2024.02.16.03.03.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:03:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/21] hw: More QDev cleanups
Date: Fri, 16 Feb 2024 12:02:51 +0100
Message-ID: <20240216110313.17039-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Various QDev cleanups extracted to my "enforce QDev API" branch.
- When available, instead of plain QOM, use QDev API equivalent
- Add missing QOM parentship for some obj created with qdev_*new()
- Prefer object_initialize_child() over object_initialize()

Philippe Mathieu-Daudé (21):
  hw/i386/pc: Do not use C99 mixed-declarations style
  hw/i386/pc_sysfw: Use qdev_is_realized() instead of QOM API
  hw/ppc/spapr_cpu: Use qdev_is_realized() instead of QOM API
  hw/tricore/testboard: Use qdev_new() instead of QOM basic API
  hw/ppc/pnv_bmc: Use qdev_new() instead of QOM API
  hw: Replace DEVICE(object_new) -> qdev_new()
  target: Replace DEVICE(object_new) -> qdev_new()
  hw/isa: Inline isa_try_new()
  hw/usb: Inline usb_try_new()
  hw/usb: Inline usb_new()
  hw/usb: Add QOM parentship relation with hub devices
  hw/pci-host/q35: Update q35_host_props[] comment
  hw/pci-host/raven: Embedded OrIRQ in PRePPCIState
  hw/pci-host/raven: Prefer object_initialize_child over
    object_initialize
  hw/core/register: Prefer object_initialize_child over
    object_initialize
  hw/net/can/versal: Prefer object_initialize_child over
    object_initialize
  hw/i386/iommu: Prefer object_initialize_child over object_initialize
  hw/pci-host/versatile: Replace object_initialize() -> _child()
  hw/s390x/zpci-bus: Add QOM parentship relation with zPCI devices
  hw/arm/mps2: Add QOM parentship relation with OR IRQ gates
  hw: Add QOM parentship relation with CPUs

 include/hw/isa/isa.h                     |  1 -
 include/hw/net/ne2000-isa.h              |  2 +-
 include/hw/tricore/tricore_testdevice.h  |  3 ---
 include/hw/usb.h                         |  1 -
 hw/arm/mps2.c                            |  5 +++++
 hw/arm/musicpal.c                        |  2 +-
 hw/core/qdev.c                           |  2 +-
 hw/core/register.c                       |  2 +-
 hw/i386/amd_iommu.c                      |  6 +++---
 hw/i386/pc.c                             |  6 +++---
 hw/i386/pc_sysfw.c                       |  6 ++----
 hw/i386/x86.c                            |  1 +
 hw/isa/isa-bus.c                         |  5 -----
 hw/microblaze/petalogix_ml605_mmu.c      |  1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 hw/mips/cps.c                            |  1 +
 hw/net/can/xlnx-versal-canfd.c           |  2 +-
 hw/nios2/10m50_devboard.c                |  1 +
 hw/pci-host/q35.c                        |  6 +++---
 hw/pci-host/raven.c                      | 18 ++++++++----------
 hw/pci-host/versatile.c                  |  3 ++-
 hw/ppc/e500.c                            |  1 +
 hw/ppc/pnv_bmc.c                         | 10 +++++-----
 hw/ppc/spapr.c                           |  1 +
 hw/ppc/spapr_cpu_core.c                  |  3 +--
 hw/s390x/s390-pci-bus.c                  |  1 +
 hw/sparc/sun4m.c                         |  4 ++--
 hw/tricore/tricore_testboard.c           |  4 +---
 hw/usb/bus.c                             | 17 ++++-------------
 hw/usb/dev-serial.c                      |  2 +-
 target/mips/cpu.c                        |  2 +-
 target/xtensa/cpu.c                      |  2 +-
 32 files changed, 55 insertions(+), 67 deletions(-)

-- 
2.41.0


