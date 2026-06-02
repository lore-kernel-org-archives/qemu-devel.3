Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF63CD6E61
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUJr0-00068P-KM; Tue, 02 Jun 2026 03:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wUJqy-00067M-I2; Tue, 02 Jun 2026 03:48:00 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wUJqw-0004vm-1E; Tue, 02 Jun 2026 03:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780386456; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=CWKt2cCvKkOmMj+t9+D/h6L/rJsPw5V6cot0yy8LCKw=;
 b=TEZx33QdBwRpM5xzu6iBkBQ1U2PLB+bujihkpyHtZ20Rnb4SiwrJBlhCtOJQGVDrIzuEnxvgdvN7mqsXbUNHFZPwOKZhKfCih3GUwdcIwhKV05aDeDYmNnwBmD1ihrPl3QDpOcY7/wFH5OzVKnk737o70rulFaMHh5TYouSAEWc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0X43o4Lk_1780386135; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X43o4Lk_1780386135 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 15:42:19 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com, fan.ni@samsung.com,
 guoren@kernel.org
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 0/4] hw/riscv/virt: Add CXL support and fix virtio DMA into
 CXL memory
Date: Tue,  2 Jun 2026 15:41:23 +0800
Message-ID: <20260602074127.63819-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
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

This series enables CXL (Compute Express Link) on the RISC-V 'virt'
machine (patch 1, mirroring hw/arm/virt), fixes two RISC-V-specific
gaps that block Type-3 enumeration today (patches 2 and 3), and
fixes one arch-agnostic CXL bug that surfaces as soon as a Type-3
device is brought online as system RAM (patch 4).

  1/4 Wires up CXLState, the CXL host register region, the Fixed
      Memory Windows and the ACPI0017 / CEDT plumbing on the
      RISC-V virt machine, mirroring hw/arm/virt.

  2/4 Adds an ACPI _DEP from ACPI0017 to the ACPI0016 CXL host
      bridges so cxl_acpi probes after acpi_pci_root has attached
      the bridges.  Without this the CXL port topology comes up
      incomplete on RISC-V because probe ordering is not guaranteed.

      Kernel dependency: this patch relies on a small kernel-side
      change that calls acpi_dev_clear_dependencies() in
      acpi_pci_root_add().  That kernel patch has completed review
      on linux-pci:
      https://lore.kernel.org/linux-pci/20260526025118.38935-1-cp0613@linux.alibaba.com/

  3/4 Reserves the top 256 MiB of the RISC-V virt 32-bit PCIe MMIO
      window exclusively for CXL host bridges and emits it via the
      ACPI0016 _CRS, so Linux can place the 64-bit non-prefetchable
      CXL component/device register BARs below 4 GiB.  PCI0's
      mmio32 window and FDT 'ranges' are shrunk by the same amount.

  4/4 Overlays a RAM alias of the Type-3 device's memory backend at
      the committed HDM decoder's HPA range, so that
      address_space_map() on CFMW addresses returns a direct host
      pointer instead of taking the 4 KiB bounce-buffer path.
      Without it, once 'daxctl online-memory' exposes CXL memory to
      the kernel allocator, any virtio scatter list larger than
      4 KiB into that range dies with:

          virtio: bogus descriptor or out of resources

      This bug is not RISC-V specific -- CFMW registration and the
      bounce-buffer limit are both arch-agnostic -- but the RISC-V
      virt machine is where the rest of this series first lights up
      the daxctl + virtio path end-to-end.

      Scope: the fix covers the common single-device, single-decoder
      configuration.  interleave_ways > 1 and HDM decoders inside a
      CXL switch keep falling through to the existing cfmws_ops +
      bounce-buffer path, exactly as today (no regression; left as
      follow-up work).  An alternative implementation that was
      considered is teaching the CFMW MemoryRegion itself to expose
      a ram_block; the overlay-on-commit approach was preferred as
      it mirrors the existing PCI BAR / IOMMU MR overlay pattern
      and is local to cxl_type3.

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
  hw/cxl: Map committed HDM decoder ranges as RAM for direct DMA

 hw/mem/cxl_type3.c          |  81 +++++++++++++++++++++++++++++++++++
 hw/pci-host/gpex-acpi.c     |  36 +++++++++++++++-
 hw/riscv/Kconfig            |   2 +
 hw/riscv/virt-acpi-build.c  |  52 +++++++++++++++++++++++
 hw/riscv/virt.c             | 100 +++++++++++++++++++++++++++++++++++++++-----
 include/hw/cxl/cxl_device.h |   4 ++
 include/hw/pci-host/gpex.h  |   1 +
 include/hw/riscv/virt.h     |   3 ++
 8 files changed, 267 insertions(+), 12 deletions(-)

--
2.50.1


