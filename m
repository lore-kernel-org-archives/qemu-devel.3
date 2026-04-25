Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3FBFF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGctW-0006zA-76; Sat, 25 Apr 2026 09:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGctT-0006yM-R9
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:17:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGctQ-0008Gl-Nq
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:17:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82f33d28c1dso4764824b3a.3
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123075; x=1777727875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=YX2v6/XRsVtr8NZBTyRWs8eBd31aH/Qd9dfsSxnSR4k=;
 b=Yv4fQ5yjniYJ0nor+f7JPPLOJcK7bSjIrCMBWl9HXZUaqjuDUgX6hV2IUj28AJtTZE
 UfQNirVKaFLcXlCeLk1bvVfocBOW5QCjK9IaQFCP0HuHUUBOEZEK6LGCnUQ4v7pz5PrL
 lrd520hY2bT9uTCi+e15CauyTataZK7mVe35zat5SEgtmzVDOGsLf1ziW54Hoz8fhq10
 8RgW/MXC14vAS4e/Kd+mqtQd+MX60xxdc7TfZpINhv/5HKwI64z/070oLjTQ+VNeeOIp
 ZUyR5nY0wTpsaadwTDQr5jUqJk6EutTWgVKC6Cq0Wbw2fKhNcCJ8r2HHMTnmPnYGaM0Q
 8zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123075; x=1777727875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YX2v6/XRsVtr8NZBTyRWs8eBd31aH/Qd9dfsSxnSR4k=;
 b=m2pR+bmDEHlY35u2dJ6DAZaspg3G4gQeGT7L1Ccm8DowItfYYbwN3meZDQ7mVGChtW
 Ea5aGPp0KQy50eV5D5SY+02oYc1qrQCNkl41whb8BWCXbDSChwkp5b3ZXM2B9auxaRur
 zyHZFARlG9z2vl1i/a/+r39KLiIeSfc8DGXFz9LMD9JKZOGi+uMlIFErtXrcXSjO8Zly
 /4/cVlTEc/iK73Jq+j2ib6WFbW1tZcJYsiyj4r5M/x/rPdB99hSHKPA/aN9sk2EANLPX
 o//kCtCkuDzKyt4Jwyb0ALwBrFYLS20HK5vrQXxMkKOTCnc5DDSUOiHtt6MbT4z0fYwc
 ouvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WPtNlvadrDZxSlvVkLdofqNdvHzmucTmwwCzpFLGVjzjtvUQBeIf3ci1rbqwTFZwXpoQl99Xa0ym+@nongnu.org
X-Gm-Message-State: AOJu0YwcKC9zEjt4t199f0V02C+CUFtNYuPVuzcCJ7UQdHpV3qbCE6Ha
 YDIgA72phrzdY3jsvTGS8i4keN5j1atpqRmrX2EVmjJ+4lwUaZg+/UG5
X-Gm-Gg: AeBDieuz42JjdD7JSJ9O/n2rq6o83YALi5IoXyvfcv1wGdOclw4LtDeYVpcqHBkHp3C
 5udkOAaYP+Wcy46jcdGOL2ivx5NCY8nzTXRSe9b+jkZMp9kNA7bwIquvrKLu3ZLSynPbXy4vjPp
 /yJ0dByDRGqJET/MbqDv3/NfeMCdLwG2awZbcelIIyrJM58LcDB1MtUMKhvDId2LCmrVChOPp/A
 T8LZeuvlIpnWIXeUoQtCDztOPEnPa8Ty6fGwqUAs2H4Q2xsygAfSY+pZlJdD5yOB5caQNEfHYPK
 96cg8Yvf6SR0g7M+jlFGv3rlSnUqDHSswR2g9hJmIh4B9FJnYOMcp9pqdUNDLs8Ihq1niECPRVf
 jD/7TpPzekNVkdrl90z4MclWIgjnIukuPrjVK3X8pYw/uxQ7PV7kZ4zehFK+8f6G2YCXMzelZLz
 A4DGXdwZ+CJ2tCgaxSGOpIR363NiEkraiEefG+YUHpSM6nVozD5Ce697W54JMjGisP+eL9zBApw
 wKt1Bfa2bTdjAh5tuN76pchN3r/RVqwJHLDyBpG8aU=
X-Received: by 2002:a05:6a00:1993:b0:82c:2241:ab71 with SMTP id
 d2e1a72fcca58-82f8c9718c5mr38660687b3a.42.1777123074576; 
 Sat, 25 Apr 2026 06:17:54 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:17:53 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 00/13] hw/riscv: Add the Tenstorrent Atlantis machine
Date: Sat, 25 Apr 2026 23:17:06 +1000
Message-ID: <20260425131721.932250-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v4 addresses the review comments from Phil and picks up some r-b from
Chao, Phil and Alistair. Thanks for the reviews.

  - Describe PCIe mappings separately from the MemMapEntry table so
    the mappings aren't mixed with fixed hardware addresses. The
    mappings used are changed too, and the XXX comment and check was
    dropped
  - Move temperature sensor from bus 0 to bus 4 and use ti,tmp105
    compatible instead of national,lm75 to match the QEMU model name 
  - Add i2c_get_bus() to do bounds checking on getting i2c buses
  - Make halting payload const 
  - Don't remove rootfs in functional test, the test framework handles
    cleanup
  - Rename Svadu patch to  to better describe what it does
  - Other minor cleanups

v3: https://lore.kernel.org/qemu-devel/20260421053140.752059-1-joel@jms.id.au/

Original cover letter:

Introducing Tenstorrent Atlantis!

 The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
 and CoreLab Technology. It is based on the Atlantis SoC, which includes
 the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

 The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
 RISC-V CPU.

This initial series adds the base machine support including:

 - AIA (Advanced Interrupt Architecture) support
 - PCIe controller and DesignWare I2C integration
 - Serial console and device tree generation
 - Functional tests for OpenSBI+Linux boot

Chris Rauer (1):
  hw/i2c: Add designware i2c controller

Joel Stanley (5):
  hw/riscv/virt: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources
  hw/riscv: Add Tenstorrent Atlantis machine
  hw/riscv/atlantis: Integrate i2c buses
  hw/riscv/atlantis: Add some i2c peripherals

Nicholas Piggin (7):
  hw/riscv/boot: Describe discontiguous memory in boot_info
  hw/riscv/boot: Account for discontiguous memory when loading firmware
  hw/riscv/boot: Provide a simple halting payload
  target/riscv: tt-ascalon: Enable Zkr extension
  target/riscv: tt-ascalon: Enable Svadu by removing Svade
  hw/riscv/atlantis: Add PCIe controller
  tests/functional/riscv64: Add tt-atlantis tests

 MAINTAINERS                                  |  20 +
 docs/system/riscv/tt_atlantis.rst            |  38 +
 docs/system/target-riscv.rst                 |   1 +
 hw/riscv/aia.h                               |  25 +
 include/hw/i2c/designware_i2c.h              | 101 ++
 include/hw/riscv/boot.h                      |  13 +-
 include/hw/riscv/tt_atlantis.h               |  86 ++
 include/hw/riscv/virt.h                      |   2 +-
 hw/i2c/designware_i2c.c                      | 817 ++++++++++++++++
 hw/riscv/aia.c                               |  93 ++
 hw/riscv/boot.c                              |  45 +-
 hw/riscv/microchip_pfsoc.c                   |   6 +-
 hw/riscv/opentitan.c                         |   6 +-
 hw/riscv/shakti_c.c                          |   6 +-
 hw/riscv/sifive_u.c                          |   6 +-
 hw/riscv/spike.c                             |   6 +-
 hw/riscv/tt_atlantis.c                       | 944 +++++++++++++++++++
 hw/riscv/virt-acpi-build.c                   |  27 +-
 hw/riscv/virt.c                              |  96 +-
 hw/riscv/xiangshan_kmh.c                     |   6 +-
 target/riscv/cpu.c                           |   2 +-
 hw/i2c/Kconfig                               |   4 +
 hw/i2c/meson.build                           |   1 +
 hw/i2c/trace-events                          |   4 +
 hw/riscv/Kconfig                             |  19 +
 hw/riscv/meson.build                         |   3 +-
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  59 ++
 29 files changed, 2333 insertions(+), 108 deletions(-)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 hw/riscv/aia.h
 create mode 100644 include/hw/i2c/designware_i2c.h
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100644 hw/i2c/designware_i2c.c
 create mode 100644 hw/riscv/aia.c
 create mode 100644 hw/riscv/tt_atlantis.c
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

-- 
2.47.3


