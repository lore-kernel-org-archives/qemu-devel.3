Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B92AC79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Vnq-0001hy-99; Mon, 07 Sep 2026 05:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x3Vnm-0001fq-Hw; Mon, 07 Sep 2026 05:38:10 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x3Vnd-00047H-PI; Mon, 07 Sep 2026 05:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788773867; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=xadJ0cdK2fBm/Zb1Cl+U5v3WRMT5l97oOmqKiq9rwI4=;
 b=fg++RmAjdWBMV7zfPxEMNYNB/FL9YP6KUHAgcvSVVGup2tANAzuQ8KDosuO53yjdeN3LYMbMeMtyXVqS9KWmaSY8dHyXGe61/5ZEzaXgFHTOgVXomAxYyV/t83iVntat6gQixXf7dBUDMLUBvZWPUkZ8fyhqgJV9hFpnAp1SwRw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R701e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=19; SR=0;
 TI=SMTPD_---0XATXGuq_1788773855; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0XATXGuq_1788773855 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 17:37:44 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, jic23@kernel.org
Cc: pbonzini@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: [PATCH v6 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Date: Mon,  7 Sep 2026 17:37:27 +0800
Message-ID: <20260907093735.2753-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=cp0613@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
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

This series adds CXL support to the RISC-V virt machine, following the
approach used by the ARM virt machine: CXL host bridges (pxb-cxl) are
described as ACPI0016 devices, an ACPI0017 (CXLM) device is added to the
DSDT with a _DEP on the CXL host bridges, and a CEDT table is built. A
bios-tables test is added to pin down the generated ACPI tables.

Changes since v5
----------------
  - Rebased onto current master, over the gpex_pcie_init() move to
    device-common.c: s->pci_bus is now assigned at the
    riscv_gpex_pcie_init() call site in virt_machine_init().
  - tests/qtest: switched to the renamed in-tree firmware blobs
    pc-bios/edk2-riscv64-{code,vars}.fd (Junjie).  The goldens are
    unchanged and still match with the updated edk2-stable202608 blob;
    all riscv64 ACPI cases pass.
  - hw/riscv/virt-acpi-build: the _DEP commit message now cites the
    companion kernel commit bf5418a5fe63 ("ACPI: scan: Honor _DEP for
    ACPI0016 PCI/CXL host bridge") alongside 3a59c3b772e5, both in
    v7.2 (Junjie).
  - Collected review tags: Junjie Cao's Reviewed-by/Tested-by on
    patches 1, 2 and 6.  Michael S. Tsirkin acked the ACPI parts on
    the v5 cover letter thread.

Changes since v4
----------------
  - tests/qtest: DSDT.cxl regenerated against the in-tree
    edk2-riscv-code.fd blob that the test boots (Junjie): the v4 golden
    carried the window allocation of my local edk2-stable202602 build.
    The 64-bit window is now 0x400100000..0x40010FFFF with the matching
    PCI0 range shift; the AML fragment in the commit message is updated
    accordingly.  CEDT.cxl is unchanged.
  - hw/riscv/virt: pci_bus_add_fw_cfg_extra_pci_roots() moved out of
    the cxl block (Junjie), so plain pxb-pcie expander bridges are also
    advertised to firmware with cxl=off, in line with arm/virt, pc and
    hppa.
  - Collected review tags.

Changes since v3
----------------
  - The CXL host bridge resource handling is reworked, following Junjie
    Cao's suggestion (and Igor Mammedov's earlier "fix UEFI" direction):
    instead of reserving a fixed 256 MiB carve-out and simulating the
    firmware PCI initialization in QEMU, the machine now advertises the
    pxb-cxl expander root buses to firmware via the etc/extra-pci-roots
    fw_cfg file (pci_bus_add_fw_cfg_extra_pci_roots(), as arm/virt and
    x86 do).  EDK2's PciBusDxe then enumerates behind the CXL host
    bridge and assigns the root-port window and bus numbers, and
    build_crs() emits a correct _CRS for the ACPI0016 host bridge.
    This keeps the machine code minimal (a single call, no carve-out),
    scales to multiple pxb-cxl host bridges, and lets firmware size the
    window to what is actually behind the bridge.
  - The bios-tables test is split into the staged flow documented in
    bios-tables-test.c, and ordered the same way the riscv64 goldens were
    originally added upstream (Sunil V L's commit cc3ba2422554 et al.):
    the feature code comes first, then three consecutive commits -- empty
    golden files + allowed-diff.h, the test code, and the populated golden
    master binaries with an emptied allowed-diff.h.

Changes since v2
----------------
  - hw/riscv/virt: The MMIO-window patch no longer touches the common
    gpex code (Igor).  The gpex_cfg.cxl_mmio32 field and the is_cxl
    static _CRS branch are dropped; the ACPI0016 _CRS now comes from the
    generic build_crs() path.  Since EDK2 does not enumerate the pxb-cxl
    expander bridge, riscv simulates the firmware PCI initialization
    (reserved window + depth-first bridge bus numbers) and re-applies it
    via a reset handler.
  - hw/riscv/virt: Drops the machine-global window/bus-range synthesis
    that did not scale past one pxb-cxl (Junjie).  The series targets a
    single CXL host bridge for now, documented in the commit message and
    a TODO.
  - hw/riscv/virt: CXL host register region and FMW setup folded into a
    single cxl_host_state_init() helper; redundant braces removed in
    create_fdt_pcie() (Daniel).
  - hw/riscv/virt-acpi-build: the _DEP commit message documents the
    kernel-compatibility behaviour (Alistair).
  - Carried review tags: Sunil V L's Reviewed-by on the _DEP patch and
    Alistair Francis's Acked-by on the test.

Changes since v1
----------------
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
    which is now merged upstream and thus no longer a prerequisite.
  - New patch 4: RISC-V ACPI bios-tables test for CXL, with golden AML
    files generated and included.

[1] https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/

Test
----
Built riscv64-softmmu and ran the new bios-tables test together with the
existing riscv64 ACPI tests; all pass.

Also booted an RVA22 guest with EDK2 firmware, using pxb-cxl + cxl-rp +
cxl-type3 + a CFMW: EDK2's PciBusDxe enumerates behind the CXL host
bridge (advertised via etc/extra-pci-roots), the root port and Type3
device show up (0000:0c:00.0 / 0000:0d:00.0), and 'cxl list' reports
the memdev (4 GiB) and the CFMWS root decoder.

QEMU invocation (CXL-relevant options shown):

    qemu-system-riscv64 \
        -M virt,aia=aplic-imsic,acpi=on,cxl=on \
        -cpu rva22s64 -smp 2 -m 4G \
        -object memory-backend-ram,id=vmem0,share=on,size=4G \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
        -device cxl-type3,bus=rp0,volatile-memdev=vmem0 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
        ...

Verification (total system memory grows by 4 GiB after onlining):

    # cxl list
    # cxl enable-memdev mem0
    # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
    # daxctl online-memory dax0.0
    # free -h

Chen Pei (6):
  hw/riscv/virt: Add CXL support to the RISC-V virt machine
  hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge
    dependency
  hw/riscv/virt: Advertise the CXL host bridge to firmware via
    extra-pci-roots
  tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
  tests/qtest: Add RISC-V ACPI bios tables test for CXL
  tests/qtest: Update RISC-V CXL ACPI golden master binaries

 hw/riscv/Kconfig                      |   2 +
 hw/riscv/virt-acpi-build.c            |  52 +++++++++++++++++++++++++
 hw/riscv/virt.c                       |  56 +++++++++++++++++++++++++++++++---
 include/hw/riscv/virt.h               |   3 ++
 tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
 tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6331 bytes
 tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
 7 files changed, 163 insertions(+), 4 deletions(-)
 create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
 create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl

-- 
2.50.1


