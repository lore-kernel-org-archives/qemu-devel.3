Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D921C28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 09:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsIYo-0003eJ-4p; Wed, 12 Mar 2025 05:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tsIYf-0003ZL-JU; Wed, 12 Mar 2025 05:39:25 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1tsIYb-0000kh-Vz; Wed, 12 Mar 2025 05:39:25 -0400
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 52C9bARa069428
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Mar 2025 17:37:10 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 12 Mar 2025
 17:38:41 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <qemu-riscv@nongnu.org>,
 Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v11 0/8] Support RISC-V IOPMP
Date: Wed, 12 Mar 2025 17:37:24 +0800
Message-ID: <20250312093735.1517740-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.1.106]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 52C9bARa069428
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When IOPMP is enabled, memory access to system memory from devices and
the CPU will be checked by the IOPMP.

The issue of CPU access to non-CPU address space via IOMMU was previously
mentioned by Jim Shu, who provided a patch[1] to fix it. IOPMP also requires
this patch.

You can use a customized QEMU[2] to run bare-metal demo[3] to show IOPMP
functionality. The modifications involve applying patch[1] and adding a simple
DMA device along with a second IOPMP device to the virt machine. These
additional devices are intended to demonstrate more complex scenarios for IOPMP.

[1] accel/tcg: Store section pointer in CPUTLBEntryFull
    https://patchew.org/QEMU/20240612081416.29704-1-jim.shu@sifive.com/20240612081416.29704-2-jim.shu@sifive.com/
[2] https://github.com/zhanyangch/qemu/tree/iopmp_patch_test
[3] https://github.com/zhanyangch/iopmp-test

Changes for v11:

  - Update specification version number to v0.7, note that the version number is
    changed according to the new lifecycle policy, the contents remain almost
    the same as previous version(v0.9.2RC3)
  - Add IOPMP document (Alistair)
  - Fix naming convention (Alistair)
  - Remove redundant memory copy and refine length check in
    transaction information (Alistair)
  - Refine the entry matching in IOPMP for TLB, now it only matches TLB of
    current transalted address instead of full transaction (Alistair)

Changes for v10:

  - Fix a build error for iopmp_dispatcher
  - The mmio size of IOPMP device is calculated based on properties, rather
    than relying on a fixed value

Changes for v9:

  - Change the specification version to v0.9.2 RC3
  - Remove API for configuration CPU IOPMP property (Alistair)
  - Add a dispatcher device to forward iopmp transaction information

Changes for v8:

  - Support transactions from CPU
  - Add an API to set up IOPMP protection for system memory
  - Add an API to configure the RISCV CPU to support IOPMP and specify the
    CPU's RRID
  - Add an API for DMA operation with IOPMP support
  - Add SPDX license identifiers to new files (Stefan W.)
  - Remove IOPMP PCI interface(pci_setup_iommu) (Zhiwei)

Changes for v7:

  - Change the specification version to v0.9.1
  - Remove the sps extension
  - Remove stall support, transaction information which need requestor device
    support.
  - Remove iopmp_cascade option for virt machine
  - Refine 'addr' range checks switch case (Daniel)

Ethan Chen (8):
  hw/core: Add config stream
  memory: Introduce memory region fetch operation
  system/physmem: Support IOMMU granularity smaller than TARGET_PAGE
    size
  target/riscv: Add support for IOPMP
  hw/misc/riscv_iopmp_txn_info: Add struct for transaction infomation
  hw/misc/riscv_iopmp: Add RISC-V IOPMP device
  hw/misc/riscv_iopmp_dispatcher: Device for redirect IOPMP transaction
    infomation
  hw/riscv/virt: Add IOPMP support

 accel/tcg/cputlb.c                       |   29 +-
 docs/specs/index.rst                     |    1 +
 docs/specs/riscv-iopmp.rst               |   60 +
 docs/system/riscv/virt.rst               |    9 +
 hw/Kconfig                               |    1 +
 hw/core/Kconfig                          |    3 +
 hw/core/meson.build                      |    2 +-
 hw/misc/Kconfig                          |    4 +
 hw/misc/meson.build                      |    2 +
 hw/misc/riscv_iopmp.c                    | 2157 ++++++++++++++++++++++
 hw/misc/riscv_iopmp_dispatcher.c         |  139 ++
 hw/misc/trace-events                     |    4 +
 hw/riscv/Kconfig                         |    1 +
 hw/riscv/virt.c                          |   75 +
 include/exec/memory.h                    |   27 +
 include/hw/misc/riscv_iopmp.h            |  199 ++
 include/hw/misc/riscv_iopmp_dispatcher.h |   61 +
 include/hw/misc/riscv_iopmp_txn_info.h   |   38 +
 include/hw/riscv/virt.h                  |    3 +
 system/memory.c                          |  104 ++
 system/physmem.c                         |    4 +
 system/trace-events                      |    2 +
 target/riscv/cpu.c                       |    3 +
 target/riscv/cpu_cfg.h                   |    2 +
 target/riscv/cpu_helper.c                |   18 +-
 25 files changed, 2938 insertions(+), 10 deletions(-)
 create mode 100644 docs/specs/riscv-iopmp.rst
 create mode 100644 hw/misc/riscv_iopmp.c
 create mode 100644 hw/misc/riscv_iopmp_dispatcher.c
 create mode 100644 include/hw/misc/riscv_iopmp.h
 create mode 100644 include/hw/misc/riscv_iopmp_dispatcher.h
 create mode 100644 include/hw/misc/riscv_iopmp_txn_info.h

-- 
2.34.1


