Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD07CD4F49
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 00:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO36m-000075-DQ; Fri, 15 May 2026 20:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36l-00006j-6s
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:23 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36j-0001i7-EH
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:22 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-133466cf955so1810249c88.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778892140; x=1779496940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pOalp9rU7ghwrqo24wa0iYXG7c1IsdsEMC5MDrclkqc=;
 b=nOMzmo2LYyrGeL6MhTl0PyD1hg578trOneoabfjxBeIL1fJRiJA7IbxfJtQK7pf0IH
 rpINVk7aYVWyeISGRHd8ygKZqRP+Lq7slVdQ8lM1ElJiJXhLFmjd+TLu1GcmfK8YOfhx
 OqrCBzuAGQc6D1G6Cc6c3yJbj7eiJe6MI7NdeFNbS3N5wbY1hZeZ+Ly3G/1+5EE8SmRL
 Bq7Ff9AHY7Vh5UvWs4KNlQV8VdEE9Ivglz2nNwW5I+MPEZGVRdN+ZUpZUoGdbbknt9d7
 zDJlR6bQKuJDaSYUPizz3xF491NNavLOX55wUkCclUvrsDYHYe7Du03VJHu3jbCorKG1
 ickg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778892140; x=1779496940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOalp9rU7ghwrqo24wa0iYXG7c1IsdsEMC5MDrclkqc=;
 b=Ebox6SPEcjsNkM/EYebbC0KfeAGcpH6HXGHeuX3cUsXk5L97aiSFPtGVh0g42ol+PC
 jwlcUsg3v05Nfygbnkiwy94WiMuhVGPwOT/uV4f0vKy+CAWYaQofeVN8mkla2vbzM7pD
 UPaNj0zQbaX3fj1pTF75MEidDRTE90fBiv1DPzETet2aZRRQs6K+MejW3ZFTul41/xP5
 XlsFhYZS6DORTobjMOS8WmTLBftDvVb3YHsDbT0WRlxrKMiLtQeIJK/C1HldX5xQGTpi
 IwUHio13HV+ldSqFTA8kDDaWvvDnW+Hbkr6AmhzdVI4W3vnQNLZuA2OoAMwkLC1ymI0n
 phPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jewBeFdzIi4ZgFeIet0yiBPr1SjfDa7pRKUSTQXqltfQwJiWb/GZF5nBwN3rXwHvYXAp99K7dU70C@nongnu.org
X-Gm-Message-State: AOJu0YzIJ2R+qTsdlcCa/6a03Y8s4Q+nzOCJl4UE9sjgNLsrHjRP9jtO
 CTYRjPpr3X7H+vT7U956E+GvKDJ8qQi/XIX3fstdzvy2knCZrOJ3UfmU
X-Gm-Gg: Acq92OGNPdSDychxv948zDAle8VGl9nmkY3mgL05HrqB1cMrcI+UTogyzErNLAJVY4C
 hKBUenmLeQ6rwOsOvjeotXBq6DRY4qGSNuIX9lqMDVK0FOZSsj+YZw46tGHVaRzwebMgEl3lD0B
 VLu9q2nMp9HVlaNMyJPEEQRUYMj0fPPMJ2ZzBfUf0MbW/Mx5pjPHg812JSosEnpEg7AiORBiytl
 X4RigZV9UdVwXV/ZgIKqks1bTIv/GatFbv1CZQpHngl6MEubwsR8ePr+qfmrf1Jx8fwM6loNHYP
 zq+WFODzBzfUj2Hprp/icNzxgVY2XubIxG/M/IsVB2HD47FQLCSgsJzPHorrUmKFgJtG1suvTr+
 I5DRDlIWdf6S2jD1QCciXLmWX6VvyhiTd5psSrId0s/T5ZAawGEfa57ifHDmdgwWBO517YTjBXZ
 rPiIcbwEOYt5lltOECKSoV2RpM3XPlC+g=
X-Received: by 2002:a05:7022:327:b0:134:c6ab:a512 with SMTP id
 a92af1059eb24-13504a4d014mr2856577c88.36.1778892139719; 
 Fri, 15 May 2026 17:42:19 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc3490bcsm10190437c88.15.2026.05.15.17.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 17:42:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v6 00/10] hw/riscv: Add the Tenstorrent Atlantis machine
Date: Fri, 15 May 2026 17:41:55 -0700
Message-ID: <20260516004206.169035-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=npiggin@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Introducing Tenstorrent Atlantis!

 The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
 and CoreLab Technology. It is based on the Atlantis SoC, which includes
 the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

 The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
 RISC-V CPU.

Many thanks to the reviewers on v5 and I2C patches.

v5:
https://lore.kernel.org/qemu-devel/20260507043838.45652-1-npiggin@gmail.com/

I2C controller:
https://lore.kernel.org/qemu-devel/20260507120524.111056-1-npiggin@gmail.com/

Changes since v5:
- Dropped the tt-ascalon extension changes, Drew had concerns
  about Svadu/Svade, so we'll work on that independently.
- Re-added I2C since Corey gave an ack for the controller patch.

Thanks,
Nick

Chris Rauer (1):
  hw/i2c: Add DesignWare I2C Controller

Joel Stanley (5):
  hw/riscv/virt: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources
  hw/riscv: Add Tenstorrent Atlantis machine
  hw/riscv/atlantis: Integrate i2c controllers
  hw/riscv/atlantis: Add some i2c peripherals

Nicholas Piggin (4):
  hw/riscv/boot: Describe discontiguous memory in boot_info
  hw/riscv/boot: Account for discontiguous memory when loading firmware
  hw/riscv/atlantis: Provide a simple halting payload
  tests/functional/riscv64: Add tt-atlantis tests

 MAINTAINERS                                  |  19 +
 docs/system/riscv/tt_atlantis.rst            |  32 +
 docs/system/target-riscv.rst                 |   1 +
 hw/i2c/Kconfig                               |   5 +
 hw/i2c/designware_i2c.c                      | 742 +++++++++++++++++++
 hw/i2c/meson.build                           |   1 +
 hw/i2c/trace-events                          |   4 +
 hw/riscv/Kconfig                             |  13 +
 hw/riscv/aia.c                               |  93 +++
 hw/riscv/aia.h                               |  25 +
 hw/riscv/boot.c                              |  34 +-
 hw/riscv/meson.build                         |   3 +-
 hw/riscv/microchip_pfsoc.c                   |   8 +-
 hw/riscv/opentitan.c                         |   6 +-
 hw/riscv/shakti_c.c                          |   6 +-
 hw/riscv/sifive_u.c                          |   6 +-
 hw/riscv/spike.c                             |   6 +-
 hw/riscv/tt_atlantis.c                       | 663 +++++++++++++++++
 hw/riscv/virt-acpi-build.c                   |  27 +-
 hw/riscv/virt.c                              |  96 +--
 hw/riscv/xiangshan_kmh.c                     |   6 +-
 include/hw/i2c/designware_i2c.h              |  56 ++
 include/hw/riscv/boot.h                      |  12 +-
 include/hw/riscv/tt_atlantis.h               |  65 ++
 include/hw/riscv/virt.h                      |   2 +-
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  57 ++
 28 files changed, 1886 insertions(+), 107 deletions(-)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 hw/i2c/designware_i2c.c
 create mode 100644 hw/riscv/aia.c
 create mode 100644 hw/riscv/aia.h
 create mode 100644 hw/riscv/tt_atlantis.c
 create mode 100644 include/hw/i2c/designware_i2c.h
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

-- 
2.53.0


