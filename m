Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4E3C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnaF-0000EN-Ah; Tue, 11 Aug 2026 10:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaD-0000E6-Rz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:01 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnaC-0001q2-6l
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:36:01 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-9034b6b7674so6467376d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458959; x=1787063759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MOPsIRAHmnpYPNJRCDGGvnlTaDui8VBb2s0z+7gjrio=;
 b=W6EVVtrWyM2PGfuPVn6pOJoG5WDaxIV6Yr5mXoPrAAIGECxbe3FIMK7rpX8Lvj/jKh
 vWeRR6dLjwvpZtsXjLd44C1Zw9gFA3DFoaF20kVIyeb+Xm9VKs5q2CRl/8mNqFIDs6pA
 5p4XRCBD5TW8WVvsK2S/p6I75qjTTd6Tuqb8pu8X7zyH/HorXrdBC9alGB5VdYKWIDXA
 t4z8456HbFb2ihD9kfd1OT4UL93IZKgE8W/7BDJum49HIWvGq/R9NU8EHLTggFSz/EtV
 XmAUFBYN35W92kZuVP8aD2fm0ec3iYJQCWbuJ3E/z5f7HpsieLbDqB8RkfOmYO5mnYvW
 Vd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458959; x=1787063759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOPsIRAHmnpYPNJRCDGGvnlTaDui8VBb2s0z+7gjrio=;
 b=lCPgqwAgWRvBRcwpMWKLpVreP2DviZ48qfP7qb45LJh1UvSV37cqqsrHc1x55+N63j
 nicFcbiDtjWUskGx5RDzu6JWgQmSCj7Wak7zq6zsz5wRt6YOrGjP18VALUekRbZzH961
 iVHlKHHSp8WoIUA1tJY8gCaLhhVNMsaIo6Sgep3mlUADXeUERNNh3VGI2ac7LXmnncE7
 I1c9RUV/dAVJpvTElB8NZWux4O6cAlivZY+MddT1yOoN4n7WJfZ1MPy+zo4VXpVCFqTq
 rYV3n42gcl8DrwuyxRsVsA5G06FBQUM4+7JxvWPieeRlYryY+kKQcRapvDrLtYnOZ1ap
 AiXg==
X-Gm-Message-State: AOJu0YxdKeZZFpgGrkaR/CqqlUBs4sNRIHfn787+BJTcFfjJyLb/f7rB
 V7eT7wgJUyG6vq/wVyPl7KMPH7AyckqDZuJ9KqeRqKcKyrtua+7tp5RAfaDLbw==
X-Gm-Gg: AR+sD105soqU1p8C2wLDNT/qhZCk8lDel2db2BXjOw5SQPheF9cQHrKkdvvKIC30R7p
 jNK8eb5Zfph/tO4oddaX3kgTSaN3r0RdY367QNmkLs5u8YaaQWDo104VGrQxcex4OqgWQXq8fts
 yDO2uLUgL0Cg7rfig3sCkYdMGIXi/QPW5+l7bwl7ULjmMiTkRzP2FIWtSddWwxRubqt/XLAWyWo
 zweO9ZoofRW3dQKy2totrpZ5afR4/XSROxr61Giv8GLu2V/qH3+wuVlqQUoa2+FMnMuOpiv0MgX
 jQPPI23BNmuqDOYLytksf79Uzi/RzIZ3wxFUXXvLYw/HSCIpAOBCf/kRCFqtax4vK5MxIY4pozB
 sSGYIij3vW+DchQ63iym2HIf7nd+9dbUPRI6HBVwhXdLWl0GgdzqMvOQwUoT94e5BDueY7DikkW
 +BtG6lLindBwACZKBfX/cdCv/NuWNxVBxxW/FK/ug/B10BtRhEklQ0WDwFscxniZG/GOnfA8HSD
 Zb54UjJs60FkVFffOA=
X-Received: by 2002:a05:6214:3d8a:b0:908:92e3:a37 with SMTP id
 6a1803df08f44-90a6c258352mr3659486d6.32.1786458959163; 
 Tue, 11 Aug 2026 07:35:59 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c26e074sm681286d6.2.2026.08.11.07.35.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:35:58 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v2 00/19] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
Date: Tue, 11 Aug 2026 10:35:37 -0400
Message-ID: <20260811143557.7862-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf34.google.com
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

This series gets raspi4b's PCIe root complex and GENET Ethernet
controller working end to end: the PCIe link comes up and devices on
it actually enumerate, and GENET passes real network traffic (DHCP,
SSH) under both older and newer guest kernels.

v2: per Peter Maydell's review of two follow-up series posted after
this one ("hw/arm/bcm2838_pcie: make PCI device enumeration work" and
half of "hw/arm/raspi4b: fix watchdog and GENET bugs hit by modern
distro kernels"), folded both of those bugfixes directly into the
patches here that introduce the affected code, since neither
bcm2838_pcie.c nor bcm2838_genet.c is in upstream git yet:

  - patch 2 ("add BCM2838 PCIe host") and patch 3 ("enable BCM2838
    PCIe host bridge") now include the PCI enumeration fix (config
    space read/write underflow, missing pcie_host_mmcfg_init(),
    wrongly-overridden config_read/config_write, and the MMIO window
    address-translation fix) instead of introducing it broken and
    fixing it in a later series;
  - patch 6, 9, 10, 12, and 13 now include the per-ring DMA
    status/RX-ring-selection fix (proper per-ring enable bitmask for
    both RDMA and TDMA, a queued-packet flush on ring enable, and
    scanning for the first active ring instead of assuming the last
    one) instead of introducing that bug and fixing it afterwards;
  - patch 18 carries the accompanying docs note about PCIe MSI/MSI-X
    not being implemented (use msi=off,msix=off).

Those two follow-up threads are superseded by this v2 and shouldn't be
applied standalone. No functional changes beyond what those two fixes
already did -- this is purely relocating the same diffs to where the
buggy code was first introduced. checkpatch.pl is clean (0 errors)
across all 19 patches, the series builds standalone from a clean
worktree (--target-list=aarch64-softmmu), and the full
tests/functional/aarch64/test_raspi4.py suite passes, including the
GENET and PCIe tests that exercise exactly the folded-in fixes.

Marcelo Manzo (10):
  hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
  hw/arm/bcm2838_pcie: add BCM2838 PCIe host
  hw/arm/bcm2838: enable BCM2838 PCIe host bridge
  hw/net/bcm2838_genet: add GENET stub device
  hw/arm/bcm2838: enable BCM2838 GENET controller
  hw/net/bcm2838_genet: fix PHY autonegotiation-restart deadlock
  hw/net/bcm2838_genet: fix bogus RX checksum reporting
  hw/net/bcm2838_genet: fix TX ring activation check
  docs/system/arm/raspi: move PCIe/GENET from missing to implemented
  tests/functional/aarch64: add raspi4b GENET networking test

Sergey Kambalin (9):
  hw/net/bcm2838_genet: add GENET register structs, part 1/4
  hw/net/bcm2838_genet: add GENET register structs, part 2/4
  hw/net/bcm2838_genet: add GENET register structs, part 3/4
  hw/net/bcm2838_genet: add GENET register structs, part 4/4
  hw/net/bcm2838_genet: add GENET register access macros
  hw/net/bcm2838_genet: implement GENET register ops
  hw/net/bcm2838_genet: implement GENET MDIO
  hw/net/bcm2838_genet: implement GENET TX path
  hw/net/bcm2838_genet: implement GENET RX path

 docs/system/arm/raspi.rst               |    6 +-
 hw/arm/bcm2838.c                        |   15 +
 hw/arm/bcm2838_pcie.c                   |  308 +++++++
 hw/arm/bcm2838_peripherals.c            |   46 +
 hw/arm/meson.build                      |    4 +-
 hw/arm/raspi4b.c                        |    2 -
 hw/arm/trace-events                     |    4 +
 hw/net/bcm2838_genet.c                  | 1119 +++++++++++++++++++++++
 hw/net/meson.build                      |    2 +
 hw/net/trace-events                     |   16 +
 include/hw/arm/bcm2838_pcie.h           |   75 ++
 include/hw/arm/bcm2838_peripherals.h    |    7 +
 include/hw/net/bcm2838_genet.h          |  428 +++++++++
 tests/functional/aarch64/test_raspi4.py |   30 +
 14 files changed, 2057 insertions(+), 5 deletions(-)
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 include/hw/net/bcm2838_genet.h

-- 
2.47.1


