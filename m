Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72543CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3c-0002FO-3c; Sun, 18 Oct 2026 09:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3Z-0002E7-7d
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:09 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3X-0002FQ-7J
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:08 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-93f2493c28bso117853785a.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330566; x=1792935366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CIy+cFruiciE8t9cDQp0nmnBFZhytFerlNAm6bOIeH4=;
 b=SnZv3NqC9u39PWqj9cHGCcbejCx1uqQuY4yNj2uy7GMzYJSF0P4GUU80MDpRL27daM
 gBR/71pS0ac8DaxOkwQfP+Cquj7QMifj8Dgry3IxW8Apyzi0VdCydeoCWEBck6VBlr9b
 B4TRjXsbaCqhlUJH1HGLgNUGpEJPXLW/NHO3TrFZA80EoTWvqXREwYOtmwup3DcChq23
 61vmmEkjWQ3Z4hmCVTdX780RVa9R/QVSv04hobRaUNZuNyj4e8dk7wbRddOVIx284BaH
 CPqJrCG8zLAwmX3wMzcmCz2vUhqhaUQFXRELELnFDQ46N4KK3RFOqEAnwZiH92CYbAiR
 U44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330566; x=1792935366;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CIy+cFruiciE8t9cDQp0nmnBFZhytFerlNAm6bOIeH4=;
 b=gdgS4Mmidc2xHm7FamNfykffPOw0d+ljh7trb6vsHaEKRklhigs/hJpbvSHO5lY9Pk
 R7c1cus3oFmtcVhgSxLXS3O0LtbVqn9SjKu9MsUKM/V8dLVPmFCoXZhffqmEb098NLdU
 rjxh6m8BV3h+V22ZxIKSPqv+gyplT2QfYjTtrUM7FPKm7Y4QfPL0cTs7ZLjpDRF5Fe6Q
 5UFlD+ZS13OCtwhIknWK6Lr3Fv50F0DtUiNNJjBjzbpc9vMUrv/BIyuGkjjRaePg9Aff
 vnZFX3fM4TijUpzhXaqH/r5j2yFm3TCKf1IcizrJMxTrs4VKkks3t49qvZxy2VrL+JxW
 kFHw==
X-Gm-Message-State: AFq9FYLEKHgxT56MFpXsy1UaSUpkbhhJg5yJdpzQNTwRV//JWz2bB56W
 if2et8ZrPx0Z4ojL8FhXJ7aVO8vXvQkyI8wvIVEuwVXCIs42jEeINZHu7qOMnPn7
X-Gm-Gg: AYBFou3/rdVjPRTs/iH/Hl4rkWJiXq6p0Nesfy5XO/JTIsz9HR25aRl1HKqlZe+TkAQ
 mi60EczyEYa61FEegB5dx5w3BR2Hfc5TySWHyFKPjntXFI/iKQTWrcGohB/HA2gdyFVDQTu5/Or
 ymeRpt1R3b+kPfDZ1ZxLr8CdJHSssBlf1eQPpsRHuRBjbl/cksxQ7dy3mnK9W3ATazowOmIG8WR
 YzwJN5d7tHEDvLq0k3lsNq68kOrKruefcleehgCOpWgaNEjBdz09HOV//kaRbEEEGRD489cViLD
 PJEBb9bGcOPMln8vf7EKgAzn3xoYYJawLiu3kaTulnBX4hI8eGc4B5zDhEN4Ryyel3mLmEkTXf9
 /bQDSd4jpnnH6fI6bn4NF1NbGBaxbThYpKODR94e2LYCL6q+q34oN0fWXuF+F0jG1ll88eNrARj
 rI8gHITPSGxkr8nm5W6zDNV/0p2meqsqjLLpwrC9s3DB/+2Xy5ZfK7D7tgZgCjPRKJM1zPE1p1s
 1IdCwINDoLnd937sFMmhEXC/se7LEwDnGJfW76DKN8Nuyv6Lkw/LZVoQCorQpjrhAidDyk=
X-Received: by 2002:a05:620a:4888:b0:93a:10b0:aee7 with SMTP id
 af79cd13be357-93f29d4d901mr872337685a.44.1792330565504; 
 Sun, 18 Oct 2026 06:36:05 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:05 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v4 00/17] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
Date: Sun, 18 Oct 2026 09:35:46 -0400
Message-ID: <20261018133603.64323-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72b.google.com
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
it enumerate, and GENET passes real network traffic (DHCP, SSH, bulk
downloads) under both older (Debian 11, 5.15) and newer (Debian 13,
6.18) guest kernels. Most of the GENET code is Sergey Kambalin's
2024 series (patchwork series 829638), carried forward with his
authorship and Signed-off-by kept.

v4: thanks to Peter for the review.

  - Patch 1: move the dc->user_creatable rationale comment next to
    the line it explains; add a VMStateDescription for the root port
    (PCI device, AER log and the regs[] array).
  - Patch 2: treat root_port.regs[] as little-endian bytes and access
    it with ldn_le_p()/stn_le_p()/ldl_le_p() instead of memcpy() and
    a uint32_t * overlay. Drop pci_bus_set_route_irq_fn(), its
    callback and the irq_num[] storage that only fed it: INTx routing
    queries come only from VFIO (with KVM irqfds), some x86 code and
    hw/remote, none of which applies to raspi4b.
  - Patch 3: drop the call to the removed set_irq_num() helper.
  - Patch 4: set both min and max access size on impl and valid.
  - Patch 8: BCM2838GenetPhyAuxShdRegs becomes an array of uint16_t
    rather than a struct, as suggested on patch 11.
  - Patch 10: access the register block as host-order uint32_t at the
    register's offset instead of memcpy() of an arbitrary size (the
    HFB filter array becomes uint32_t too, so every register in the
    block is one); do not call qemu_macaddr_default_if_unset() when
    the guest programs a MAC address, just update the NIC info
    string; accept an access that ends exactly at the end of the
    register block.
  - Patch 11: do not call bcm2838_genet_phy_update_link() from the
    MDIO patch; it is only defined by the RX patch, so the series did
    not build at this point. The prototype and the call move to the
    RX patch. Reword the "8 bits" comment and assert that the
    expansion shadow register indexes are in range.
  - Patch 12: check that a TX frame is at least a status block plus
    an Ethernet header, and that a frame's descriptors fit in
    tx_packet[]; check that reading the frame from guest memory
    succeeded; use lduw_be_p()/stw_be_p(); lower-case local names; add
    a helper for building 64-bit values from register halves; drop
    redundant "!= 0" on bools; split the producer-index handling out
    of bcm2838_genet_tdma() to reduce nesting.
  - Patch 13: the same clean-ups as the TX path where they apply;
    replace the comment that described an old bug with one noting
    that we do not implement the hardware's partial RX checksum and
    rely on the guest checking in software.
  - New patch 14: add a VMStateDescription for the GENET device,
    which had none.
  - Patch 17: call require_netdev('user') so the test is skipped on
    builds without the user-mode network backend.
  - Added Peter's Reviewed-by to patches 3-9 and 15-17. I kept it on
    3, 4 and 8 although each changed slightly (the call removed in
    3, the access sizes in 4, the array type in 8); please say if you
    would rather I dropped it.

Based on master (7e8d3c7fc4); it also applies cleanly to current
master (a19f59a72d). It conflicts trivially (raspi4b.c and
bcm2838_peripherals.[ch]) with the RNG200/thermal series, which is in
target-arm.next; I will rebase once that lands.

Tested: checkpatch.pl reports no errors; every patch builds on its
own; tests/functional/aarch64/test_raspi4.py passes; and unmodified
Raspberry Pi OS Bullseye and Trixie based images boot under raspi4b
with a working network (DHCP, ping, 3MB download, 1MB upload) and SSH.

Marcelo Manzo (8):
  hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
  hw/arm/bcm2838_pcie: add BCM2838 PCIe host
  hw/arm/bcm2838: enable BCM2838 PCIe host bridge
  hw/net/bcm2838_genet: add GENET stub device
  hw/net/bcm2838_genet: add migration state
  hw/arm/bcm2838: enable BCM2838 GENET controller
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
 hw/arm/bcm2838.c                        |   13 +
 hw/arm/bcm2838_pcie.c                   |  311 ++++++
 hw/arm/bcm2838_peripherals.c            |   46 +
 hw/arm/meson.build                      |    4 +-
 hw/arm/raspi4b.c                        |    2 -
 hw/arm/trace-events                     |    4 +
 hw/net/bcm2838_genet.c                  | 1189 +++++++++++++++++++++++
 hw/net/meson.build                      |    2 +
 hw/net/trace-events                     |   16 +
 include/hw/arm/bcm2838_pcie.h           |   73 ++
 include/hw/arm/bcm2838_peripherals.h    |    7 +
 include/hw/net/bcm2838_genet.h          |  438 +++++++++
 tests/functional/aarch64/test_raspi4.py |   31 +
 14 files changed, 2137 insertions(+), 5 deletions(-)
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 include/hw/net/bcm2838_genet.h

-- 
2.55.0


