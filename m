Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B27CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 15:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkgU-0007Hr-3j; Fri, 04 Oct 2024 11:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgP-0007HD-QE
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1swkgM-0000nl-NP
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 11:57:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20b7259be6fso25194755ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728057448; x=1728662248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6fQ0hYRolhSNwyXozLq0AUpqIoarqWeWC5hRocSpGA=;
 b=Eivz0YmQVTRDAMW6uzSNNzkLQuCq+XYNyp4qyWHY+Jx4V4mOtYHO4DmDi29peLE3N/
 guDcaj/9shxB9Bza7YhUXeI7SVpxX5g7BKM/ii2qKBuP5xBnkEcn3m8Y9t9VPFgT3uSm
 zsGzeUDUUHhR37tPJFsBC+dmIN9P2/YQdvok7pUKSJZ3wUSzn2a6k9CQAB/jJkzgWnIt
 OjxHtZbn8NubNTX/GhxKucGOKX71mMnJAcCgwzGop3qH5k9s/BS4y3R3SwYy0RBfFDcK
 yfu3uYurVgGakrrJ43Cemk+SN7jWU3jQAZXDN5MXcZyVnCMW33pvUG/RGTGUw2x0olPH
 WFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728057448; x=1728662248;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q6fQ0hYRolhSNwyXozLq0AUpqIoarqWeWC5hRocSpGA=;
 b=xBPHZoiDcuvZwi0NZiWLYEcawEaXUHyjfd4Z/NNhjsdL7bHD8/XMEjaMGVjHv+LVxY
 RMKlOzc8VM7+A2mAJv66Gml6yq+S8RpfpVSEjA6ZZue8bN5UDyBMR99O5dPoutX0j0W6
 xTobcnrUmj2kn2pEZxS++IQcGXlPHfNtF+5r0bQ3N0cmJxOdX3y/mJ3kNgaHyfoZV2eM
 QfO8RmOa57ejuVkEv3BfqNlnFmBTUF8a74uAirDqjectiZOnKe9s7Nx0yKznMeHYuCSM
 LrPKXOqzPtbOLf/PEs6j4Jfl28NmLpHD4aVBMGegKvo3/dkX8TRhtKBQkUzEPG0FNsiZ
 mKBQ==
X-Gm-Message-State: AOJu0YzXcYYPuNbzoJKy7kLtSdCJee9qplWyJE0qor3VC52J21vNc636
 ZXdn8VUJtJvhtWU04bZFrvm5z3JBfMkUHpdM/3M4tipP47f6X/B+kcAgXzwS+i5Qzm9Cx/Wt/fa
 0
X-Google-Smtp-Source: AGHT+IECMxu/LK6TkbQWGrrErfMj+wLZ4FHF65mPSFO06RcNteGKts3adpumSlXxNsmP2PA88nVisw==
X-Received: by 2002:a17:902:f68d:b0:20b:7ec0:ee21 with SMTP id
 d9443c01a7336-20bfdfba791mr33512675ad.19.1728057447839; 
 Fri, 04 Oct 2024 08:57:27 -0700 (PDT)
Received: from grind.. (200-206-229-93.dsl.telesp.net.br. [200.206.229.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139306cfsm107635ad.170.2024.10.04.08.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 08:57:27 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 00/12] riscv: QEMU RISC-V IOMMU Support
Date: Fri,  4 Oct 2024 12:57:07 -0300
Message-ID: <20241004155721.2154626-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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

Hi,

In this new version we fixed the IOVA == GPA MSI early check in patch 3,
in riscv_iommu_spa_fetch(), after discussions with Tomasz and Drew on
v8.

The motivation behind what was being was making the emulation work with
the existing VFIO irqbypass support in the kernel. In the end this was
not a valid design choice - we were not following what the riscv-iommu
spec dictates when dealing with the IOVA==GPA case. To support
VFIO+irqbypass for the riscv-iommu spec 1.0 the Linux kernel will need
to do extra work [1].

No other changes made. Patches based on master. All patches acked.

Changes from v8:
- patch 3:
  - add the "!en_s" condition when checking for IOVA == GPA in
    riscv_iommu_spa_fetch()
- v8 link: https://lore.kernel.org/qemu-riscv/20241002010314.1928515-1-dbarboza@ventanamicro.com

[1] https://lore.kernel.org/qemu-riscv/CAH2o1u6h5nOMuGq8opXQNm6M=D=TrvygmoS+hHwmrgViy3reFA@mail.gmail.com/


Daniel Henrique Barboza (4):
  pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU device
  test/qtest: add riscv-iommu-pci tests
  qtest/riscv-iommu-test: add init queues test
  docs/specs: add riscv-iommu

Tomasz Jeznach (8):
  exec/memtxattr: add process identifier to the transaction attributes
  hw/riscv: add riscv-iommu-bits.h
  hw/riscv: add RISC-V IOMMU base emulation
  hw/riscv: add riscv-iommu-pci reference device
  hw/riscv/virt.c: support for RISC-V IOMMU PCIDevice hotplug
  hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
  hw/riscv/riscv-iommu: add ATS support
  hw/riscv/riscv-iommu: add DBG support

 docs/specs/index.rst             |    1 +
 docs/specs/pci-ids.rst           |    2 +
 docs/specs/riscv-iommu.rst       |   90 ++
 docs/system/riscv/virt.rst       |   13 +
 hw/riscv/Kconfig                 |    4 +
 hw/riscv/meson.build             |    1 +
 hw/riscv/riscv-iommu-bits.h      |  421 ++++++
 hw/riscv/riscv-iommu-pci.c       |  202 +++
 hw/riscv/riscv-iommu.c           | 2399 ++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.h           |  130 ++
 hw/riscv/trace-events            |   17 +
 hw/riscv/trace.h                 |    1 +
 hw/riscv/virt.c                  |   33 +-
 include/exec/memattrs.h          |    5 +
 include/hw/pci/pci.h             |    1 +
 include/hw/riscv/iommu.h         |   36 +
 meson.build                      |    1 +
 tests/qtest/libqos/meson.build   |    4 +
 tests/qtest/libqos/riscv-iommu.c |   76 +
 tests/qtest/libqos/riscv-iommu.h |  101 ++
 tests/qtest/meson.build          |    1 +
 tests/qtest/riscv-iommu-test.c   |  210 +++
 22 files changed, 3748 insertions(+), 1 deletion(-)
 create mode 100644 docs/specs/riscv-iommu.rst
 create mode 100644 hw/riscv/riscv-iommu-bits.h
 create mode 100644 hw/riscv/riscv-iommu-pci.c
 create mode 100644 hw/riscv/riscv-iommu.c
 create mode 100644 hw/riscv/riscv-iommu.h
 create mode 100644 hw/riscv/trace-events
 create mode 100644 hw/riscv/trace.h
 create mode 100644 include/hw/riscv/iommu.h
 create mode 100644 tests/qtest/libqos/riscv-iommu.c
 create mode 100644 tests/qtest/libqos/riscv-iommu.h
 create mode 100644 tests/qtest/riscv-iommu-test.c

-- 
2.45.2


