Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC428CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa9DJ-00052L-Mj; Thu, 18 Jun 2026 05:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wa9DG-000509-6K; Thu, 18 Jun 2026 05:39:07 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wa9DA-0007Em-Vb; Thu, 18 Jun 2026 05:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1781775515; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=97ymu4KBxBp/OQDwgYUMqaKqMzm8RdydWTCp6VQPG4w=;
 b=Xmcr3Sssg7gzeHTCcg9V5i2LmSOraggon0qS86//XUqJ7WnXuKpC+dYb9RqDO1fWNYTwqop39TO9iO/f8vdBGnZVV9MF6vBI4CaF7IxYGc+Di5lVvhS38Z8bs35JOTCUGA04hqH8dhTQZtq9J5Sc7ScOGU/LjFZv+Rt7AxgnAio=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0X56RwJP_1781775507; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X56RwJP_1781775507 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 18 Jun 2026 17:38:34 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, dave.jiang@intel.com,
 alison.schofield@intel.com, imammedo@redhat.com, mst@redhat.com,
 guoren@kernel.org
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/4] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Date: Thu, 18 Jun 2026 17:38:22 +0800
Message-ID: <20260618093827.3507-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This series adds CXL (Compute Express Link) support to the RISC-V virt
machine in QEMU, following the same approach as the ARM virt machine.

Prerequisite
------------
This series depends on Alireza Sanaee's v8 series [1]:

  [1/3] hw/cxl: Use HPA in cxl_cfmws_find_device() rather than offset
        in window
  [2/3] hw/cxl: Allow cxl_cfmws_find_device() to filter on whether
        interleaved paths are accepted
  [3/3] hw/cxl: Add a performant (and correct) path for the non
        interleaved cases

Patch [1/3] is already in the tree. Patches [2/3] and [3/3] have been
tested and verified functional on RISC-V QEMU with CXL enabled.  They
are not included in this posting; please apply them before this series.

Series overview
---------------
  [1/4] (hw/riscv/virt): Wires up the core CXL machine support --
  Kconfig selects, CXLState, PCIBus pointer (pci_bus), cxl_machine_init(),
  CXL host register region, FMW mapping, and machine_done hooks.

  [2/4] (hw/riscv/virt-acpi-build): Adds ACPI0017 (CXLM) to the
  DSDT with a _DEP on every ACPI0016 CXL host bridge device.  The _DEP
  ensures the OS defers ACPI0017 enumeration until acpi_pci_root has
  attached all CXL host bridges, fixing a probe-ordering race that
  leaves the CXL port topology incomplete.  A corresponding kernel
  change to call acpi_dev_clear_dependencies() in acpi_pci_root_add()
  is required on the Linux side. That kernel patch has merged:
  https://lore.kernel.org/linux-pci/20260526025118.38935-1-cp0613@linux.alibaba.com/

  [3/4] (hw/riscv/virt, gpex): Reserves the top 256 MiB of the
  32-bit MMIO window for CXL host bridges.  CXL component-register
  BARs are 64-bit non-prefetchable; per PCI-to-PCI Bridge Architecture
  Specification Rev 1.2 §3.2.5.8-10, only the prefetchable window can
  be 64-bit, so Linux places these BARs in the 32-bit non-prefetchable
  bridge window.  Without this reservation PCI0 consumes the entire
  1 GiB 32-bit range and CXL bridges get an empty _CRS, preventing
  BAR assignment.

  [4/4] (tests/qtest): Adds a RISC-V bios-tables test for the CXL
  variant.  Expected AML golden files (DSDT.cxl, CEDT.cxl) are
  generated and included.

Changes from v1
---------------
  - hw/riscv/virt: PCIBus *bus renamed to PCIBus *pci_bus (Jonathan).
  - hw/riscv/virt: Dropped outer if (s->pci_bus) guard around
    cxl_hook_up_pxb_registers(); the function already handles a NULL
    bus internally (Jonathan).
  - hw/riscv/virt-acpi-build: All s->bus references updated to
    s->pci_bus; iasl -d decompiled DSDT fragment added to commit
    message.
  - hw/riscv/virt,gpex: Commit message expanded with PCI-to-PCI Bridge
    Spec §3.2.5.8/9/10 citations (Jonathan).
  - Original patch 4 ("Map committed HDM decoder ranges as RAM for
    direct DMA") dropped; superseded by Alireza Sanaee's v8 series [1],
    which correctly handles the interleaved/non-interleaved split and
    supports KVM.
  - New patch 4: RISC-V ACPI bios-tables test for CXL, with golden AML
    files generated and included.

[1] https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/

Test
---------------
Tested on the RISC-V virt machine with EDK2 firmware and a buildroot
guest carrying the kernel patches above.

QEMU invocation (CXL-relevant options shown; EDK2 pflash, -bios,
-kernel, -append and the virtio-blk rootfs are as usual):

    qemu-system-riscv64 \
        -M virt,aia=aplic-imsic,acpi=on,cxl=on \
        -cpu rv64 -smp 2 -m 4G,maxmem=8G,slots=8 \
        -object memory-backend-ram,id=vmem0,share=on,size=4G \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
        -device cxl-type3,bus=rp0,volatile-memdev=vmem0,id=cxl-vmem0 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
        ...   # EDK2 pflash + -bios fw_dynamic.bin + -kernel Image
              # + virtio-blk rootfs + -append "root=/dev/vda ..."

Verification (compare the two `free -h` outputs: total system memory
grows by 4 GiB after onlining):

    # free -h
    # cxl list
    # cxl enable-memdev mem0
    # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
    # daxctl online-memory dax0.0
    # free -h

Chen Pei (4):
  hw/riscv/virt: Add CXL support to the RISC-V virt machine
  hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge
    dependency
  hw/riscv/virt,gpex: Provide 32-bit MMIO window for CXL host bridges
  tests/qtest: Add RISC-V ACPI bios tables test for CXL

 hw/pci-host/gpex-acpi.c               |  36 +++++++++-
 hw/riscv/Kconfig                      |   2 +
 hw/riscv/virt-acpi-build.c            |  52 ++++++++++++++
 hw/riscv/virt.c                       |  98 +++++++++++++++++++++++---
 include/hw/pci-host/gpex.h            |   1 +
 include/hw/riscv/virt.h               |   3 +
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6212 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++++++++
 9 files changed, 234 insertions(+), 12 deletions(-)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

-- 
2.50.1


