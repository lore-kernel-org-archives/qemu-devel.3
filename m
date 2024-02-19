Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D7C48BC4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsIB-0003EG-Dn; Sun, 18 Feb 2024 20:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsI7-00039W-Gr; Sun, 18 Feb 2024 20:17:55 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsI5-0004BR-Nc; Sun, 18 Feb 2024 20:17:55 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-607cd210962so31415267b3.2; 
 Sun, 18 Feb 2024 17:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305471; x=1708910271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ypoNV7TDihhDE//3EFwZgzopV8EXsfG6IzmC2Wab+H8=;
 b=HJAf87flRuCQPtZTcuRkSSt1wIAuGzSDNG8ZZvJR2ZkNp7KiCL+Zo7yndEMf+RLOvL
 B4eEgd4CsCVzlBGr8ypfMVeH+1TxhUNeQHoxlzauYYUD5P7LRYNL6Wrr0xwWglelNe1a
 MxjvSiYJ8A6Nxag3KeB2bU98igYNIKSdmrjO1lM9Ay+rt3geyFWXlQJ66REd50otxqMa
 G1wlu8GblK4cTdUtR8Y+FjZHndPT8FacFi8hoy+I3FAhmQXQuxnp3NZnyv31imOXxofY
 H8d+ShGAf4gJSm3IFMIlV14d+jB/pEhNWn12T77bchDvqSNXXQVeC6sZik7/r+TgAiJ1
 rv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305471; x=1708910271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ypoNV7TDihhDE//3EFwZgzopV8EXsfG6IzmC2Wab+H8=;
 b=icb4+beEM8NNpQP1KnfXf44CiPn4bL/IfRBgYhCp9RPfvQRQ/nkZmmJlN4NgmUywLj
 PpAkIRQso7R3Z9zBh54kZ9jU9BLJFgfxmfNRHQeLCj6qW/9Xd/PRluTYVO3fjTNRropN
 +QcgbUT74ZKEq1PdCcwgyDz298Pkco2qHNZFOkBA3xcuDjrHNXMli1sTx6TUDk7ylEqa
 /J0CZ/oWVZgAp3+ngSaZfwARF9W0rGGzGrZJnJarIO3tGJ8rJF+noizXFzzksJv1XrBk
 5WlfueqnjQxEn/2eEiNtuiR0yKujLmBee6Zm1jT8DLSySazVYsL/qs3WgGVufS7Xs2tu
 imGA==
X-Gm-Message-State: AOJu0YyuaAyqjxc/iVokTksj5WH9EP3Nq/PJqIcvlzSuMAEauWgbmx2c
 lPMj1noEFotP3D7ydGu1iNtqDxy4BVeGtrYmPkVqhlAZugCk/b7gLRqH0N6Hqe4=
X-Google-Smtp-Source: AGHT+IGQBFCXoknodC2B+dFh0z8Tpr6QnTanJi4vkPS8Y+nB2reaqfIP/WYqrh2hO7jxi1XrOK1ULg==
X-Received: by 2002:a0d:eb94:0:b0:607:df61:5811 with SMTP id
 u142-20020a0deb94000000b00607df615811mr10338418ywe.13.1708305470572; 
 Sun, 18 Feb 2024 17:17:50 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:17:50 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 00/41] Raspberry Pi 4B machine
Date: Sun, 18 Feb 2024 19:16:58 -0600
Message-Id: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introducing Raspberry Pi 4B model.
It contains new BCM2838 SoC, PCIE subsystem,
RNG200, Thermal sensor and Genet network controller.

It can work with recent linux kernels 6.x.x.
Two avocado tests was added to check that.

Unit tests has been made as read/write operations
via mailbox properties.

Genet integration test is under development.

Every single commit
1) builds without errors
2) passes regression tests
3) passes style check*
*the only exception is bcm2838-mbox-property-test.c file
containing heavy macros usage which cause a lot of
false-positives of checkpatch.pl.

I did my best to keep the commits less than 200 changes,
but had to make some of them a bit more in order to
keep their integrity.

This is v5 patchset with the most of v1..v4 comments fixed.


Sergey Kambalin (41):
  Split out common part of BCM283X classes
  Split out common part of peripherals
  Split out raspi machine common part
  Introduce BCM2838 SoC
  Add GIC-400 to BCM2838 SoC
  Add BCM2838 GPIO stub
  Implement BCM2838 GPIO functionality
  Connect SD controller to BCM2838 GPIO
  Add GPIO and SD to BCM2838 periph
  Introduce Raspberry PI 4 machine
  Temporarily disable unimplemented rpi4b devices
  Add memory region for BCM2837 RPiVid ASB
  Add BCM2838 PCIE Root Complex
  Add BCM2838 PCIE host
  Enable BCM2838 PCIE
  Add RPi4 RNG200
  Implement BCM2838 thermal sensor
  Add clock_isp stub
  Add GENET stub
  Add GENET register structs. Part 1
  Add GENET register structs. Part 2
  Add GENET register structs. Part 3
  Add GENET register structs. Part 4
  Add GENET register access macros
  Implement GENET register ops
  Implement GENET MDIO
  Implement GENET TX path
  Implement GENET RX path
  Enable BCM2838 GENET controller
  Add Rpi4b boot tests
  Add mailbox test stub
  Add mailbox test constants
  Add mailbox tests tags. Part 1
  Add mailbox tests tags. Part 2
  Add mailbox tests tags. Part 3
  Add mailbox property tests. Part 1
  Add mailbox property tests. Part 2
  Add mailbox property tests. Part 3
  Add missed BCM2835 properties
  Append added properties to mailbox test
  Add RPi4B to paspi.rst

 docs/system/arm/raspi.rst                |   11 +-
 hw/arm/bcm2835_peripherals.c             |  215 +++--
 hw/arm/bcm2836.c                         |  117 ++-
 hw/arm/bcm2838.c                         |  282 ++++++
 hw/arm/bcm2838_pcie.c                    |  295 ++++++
 hw/arm/bcm2838_peripherals.c             |  287 ++++++
 hw/arm/meson.build                       |    8 +-
 hw/arm/raspi.c                           |  130 +--
 hw/arm/raspi4b.c                         |  111 +++
 hw/arm/trace-events                      |    7 +
 hw/gpio/bcm2838_gpio.c                   |  390 ++++++++
 hw/gpio/meson.build                      |    5 +-
 hw/misc/bcm2835_property.c               |   21 +
 hw/misc/bcm2838_rng200.c                 |  405 ++++++++
 hw/misc/bcm2838_thermal.c                |   98 ++
 hw/misc/meson.build                      |    2 +
 hw/misc/trace-events                     |    9 +
 hw/net/bcm2838_genet.c                   | 1088 ++++++++++++++++++++++
 hw/net/meson.build                       |    2 +
 hw/net/trace-events                      |   16 +
 include/hw/arm/bcm2835_peripherals.h     |   29 +-
 include/hw/arm/bcm2836.h                 |   27 +-
 include/hw/arm/bcm2838.h                 |   31 +
 include/hw/arm/bcm2838_pcie.h            |   75 ++
 include/hw/arm/bcm2838_peripherals.h     |   94 ++
 include/hw/arm/raspberrypi-fw-defs.h     |   11 +
 include/hw/arm/raspi_platform.h          |   38 +-
 include/hw/display/bcm2835_fb.h          |    2 +
 include/hw/gpio/bcm2838_gpio.h           |   45 +
 include/hw/misc/bcm2838_rng200.h         |   43 +
 include/hw/misc/bcm2838_thermal.h        |   24 +
 include/hw/net/bcm2838_genet.h           |  426 +++++++++
 tests/avocado/boot_linux_console.py      |   92 ++
 tests/qtest/bcm2838-mailbox.c            |   60 ++
 tests/qtest/bcm2838-mailbox.h            |  532 +++++++++++
 tests/qtest/bcm2838-mbox-property-test.c |  631 +++++++++++++
 tests/qtest/meson.build                  |    3 +-
 37 files changed, 5457 insertions(+), 205 deletions(-)
 create mode 100644 hw/arm/bcm2838.c
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 hw/arm/bcm2838_peripherals.c
 create mode 100644 hw/arm/raspi4b.c
 create mode 100644 hw/gpio/bcm2838_gpio.c
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/arm/bcm2838.h
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 include/hw/arm/bcm2838_peripherals.h
 create mode 100644 include/hw/gpio/bcm2838_gpio.h
 create mode 100644 include/hw/misc/bcm2838_rng200.h
 create mode 100644 include/hw/misc/bcm2838_thermal.h
 create mode 100644 include/hw/net/bcm2838_genet.h
 create mode 100644 tests/qtest/bcm2838-mailbox.c
 create mode 100644 tests/qtest/bcm2838-mailbox.h
 create mode 100644 tests/qtest/bcm2838-mbox-property-test.c

-- 
2.34.1


