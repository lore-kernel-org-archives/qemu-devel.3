Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE3CC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTISp-0006HB-QQ; Mon, 15 Jul 2024 05:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTISn-00065V-6l; Mon, 15 Jul 2024 05:57:45 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sTISk-00008e-Cx; Mon, 15 Jul 2024 05:57:44 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46F9vE0E072662
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 15 Jul 2024 17:57:14 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 17:57:16 +0800
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, Ethan Chen
 <ethan84@andestech.com>
Subject: [PATCH v8 0/8] Support RISC-V IOPMP
Date: Mon, 15 Jul 2024 17:56:54 +0800
Message-ID: <20240715095702.1222213-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 46F9vE0E072662
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This series implements basic functions of IOPMP specification v0.9.1 rapid-k
model.
The specification url:
https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.1

When IOPMP is enabled, memory access to system memory from devices and
the CPU will be checked by the IOPMP.

The issue of CPU access to non-CPU address space via IOMMU was previously
mentioned by Jim Shu, who provided a patch[1] to fix it. IOPMP also requires
this patch.

[1] accel/tcg: Store section pointer in CPUTLBEntryFull
    https://patchew.org/QEMU/20240612081416.29704-1-jim.shu@sifive.com/20240612081416.29704-2-jim.shu@sifive.com/


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
  memory: Introduce memory region fetch operation
  system/physmem: Support IOMMU granularity smaller than TARGET_PAGE
    size
  target/riscv: Add support for IOPMP
  hw/misc/riscv_iopmp: Add RISC-V IOPMP device
  hw/misc/riscv_iopmp: Add API to set up IOPMP protection for system
    memory
  hw/misc/riscv_iopmp: Add API to configure RISCV CPU IOPMP support
  hw/misc/riscv_iopmp:  Add DMA operation with IOPMP support API
  hw/riscv/virt: Add IOPMP support

 accel/tcg/cputlb.c            |   29 +-
 docs/system/riscv/virt.rst    |    5 +
 hw/misc/Kconfig               |    3 +
 hw/misc/meson.build           |    1 +
 hw/misc/riscv_iopmp.c         | 1289 +++++++++++++++++++++++++++++++++
 hw/misc/trace-events          |    3 +
 hw/riscv/Kconfig              |    1 +
 hw/riscv/virt.c               |   63 ++
 include/exec/memory.h         |   30 +
 include/hw/misc/riscv_iopmp.h |  173 +++++
 include/hw/riscv/virt.h       |    5 +-
 system/memory.c               |  104 +++
 system/physmem.c              |    4 +
 system/trace-events           |    2 +
 target/riscv/cpu_cfg.h        |    2 +
 target/riscv/cpu_helper.c     |   18 +-
 16 files changed, 1722 insertions(+), 10 deletions(-)
 create mode 100644 hw/misc/riscv_iopmp.c
 create mode 100644 include/hw/misc/riscv_iopmp.h

-- 
2.34.1


