Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970C0C54E49
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 10:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdSsz-0003so-Q3; Fri, 23 Feb 2024 05:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rdSsS-0003bQ-VQ; Fri, 23 Feb 2024 05:34:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rdSsO-0001td-Td; Fri, 23 Feb 2024 05:34:00 -0500
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Th5ty0SfJz1vtZm;
 Fri, 23 Feb 2024 18:32:58 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 17E301A016B;
 Fri, 23 Feb 2024 18:33:33 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 18:33:32 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH v3 00/21] target/arm: Implement FEAT_NMI and FEAT_GICv3_NMI
Date: Fri, 23 Feb 2024 10:32:00 +0000
Message-ID: <20240223103221.1142518-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.32; envelope-from=ruanjinjie@huawei.com;
 helo=szxga06-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch set implements FEAT_NMI and FEAT_GICv3_NMI for armv8. These
introduce support for a new category of interrupts in the architecture
which we can use to provide NMI like functionality.

There are two modes for using this FEAT_NMI. When PSTATE.ALLINT or
PSTATE.SP & SCTLR_ELx.SCTLR_SPINTMASK is set, any entry to ELx causes all
interrupts including those with superpriority to be masked on entry to ELn
until the mask is explicitly removed by software or hardware. PSTATE.ALLINT
can be managed by software using the new register control ALLINT.ALLINT.
Independent controls are provided for this feature at each EL, usage at EL1
should not disrupt EL2 or EL3.

I have tested it with the following linux patches which try to support
FEAT_NMI in linux kernel:

	https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/T/#mb4ba4a2c045bf72c10c2202c1dd1b82d3240dc88

In the test, SGI, PPI and SPI interrupts can all be set to have super priority
to be converted to a hardware NMI interrupt. The SGI is tested with kernel
IPI as NMI framework, and the PPI interrupt is tested with "perf top" command
with hardware NMI enabled, and the PPI interrupt is tested with a custom
test module, in which NMI interrupts can be received and transmitted normally.

         +-------------------------------------------------+
         |               Distributor                       |
         +-------------------------------------------------+
             SPI |  NMI                         |  NMI
                \ /                            \ /
            +--------+                     +-------+
            | Redist |                     | Redist|
            +--------+                     +-------+
            SGI  | NMI                     PPI | NMI
                \ /                           \ /
          +-------------+             +---------------+
          |CPU Interface|   ...       | CPU Interface |
          +-------------+             +---------------+
               | NMI                         | NMI
              \ /                           \ /
            +-----+                       +-----+
            |  PE |                       |  PE |
            +-----+                       +-----+

Changes in v3:
- Remove the FIQ NMI.
- Adjust the patches Sequence.
- Reomve the patch "Set pstate.ALLINT in arm_cpu_reset_hold".
- Check whether support FEAT_NMI and FEAT_GICv3 for FEAT_GICv3_NMI.
- With CPU_INTERRUPT_NMI, both CPSR_I and ISR_IS must be set.
- Not include NMI logic when FEAT_NMI or SCTLR_ELx.NMI not enabled.
- Refator nmi mask in arm_excp_unmasked().
- Add VNMI definitions, add HCRX_VINMI and HCRX_VFNMI support in HCRX_EL2.
- Add Reviewed-by and Acked-by.
- Update the commit message.

Changes in v2:
- Break up the patches so that each one does only one thing.
- Remove the command line option and just implement it in "max" cpu.

Jinjie Ruan (21):
  target/arm: Handle HCR_EL2 accesses for bits introduced with FEAT_NMI
  target/arm: Add PSTATE.ALLINT
  target/arm: Add support for FEAT_NMI, Non-maskable Interrupt
  target/arm: Implement ALLINT MSR (immediate)
  target/arm: Support MSR access to ALLINT
  target/arm: Add support for Non-maskable Interrupt
  target/arm: Add support for NMI in arm_phys_excp_target_el()
  target/arm: Handle IS/FS in ISR_EL1 for NMI
  target/arm: Handle PSTATE.ALLINT on taking an exception
  hw/arm/virt: Wire NMI and VNMI irq lines from GIC to CPU
  hw/intc/arm_gicv3: Add external IRQ lines for NMI
  target/arm: Handle NMI in arm_cpu_do_interrupt_aarch64()
  hw/intc/arm_gicv3: Add irq superpriority information
  hw/intc/arm_gicv3_redist: Implement GICR_INMIR0
  hw/intc/arm_gicv3: Implement GICD_INMIR
  hw/intc: Enable FEAT_GICv3_NMI Feature
  hw/intc/arm_gicv3: Add NMI handling CPU interface registers
  hw/intc/arm_gicv3: Implement NMI interrupt prioirty
  hw/intc/arm_gicv3: Report the NMI interrupt in gicv3_cpuif_update()
  target/arm: Add FEAT_NMI to max
  hw/arm/virt: Add FEAT_GICv3_NMI feature support in virt GIC

 docs/system/arm/emulation.rst      |  1 +
 hw/arm/virt.c                      | 25 +++++++++++-
 hw/intc/arm_gicv3.c                | 63 ++++++++++++++++++++++++++----
 hw/intc/arm_gicv3_common.c         |  7 ++++
 hw/intc/arm_gicv3_cpuif.c          | 52 ++++++++++++++++++++++--
 hw/intc/arm_gicv3_dist.c           | 40 +++++++++++++++++++
 hw/intc/arm_gicv3_redist.c         | 23 +++++++++++
 hw/intc/gicv3_internal.h           |  5 +++
 include/hw/intc/arm_gic_common.h   |  2 +
 include/hw/intc/arm_gicv3_common.h |  7 ++++
 target/arm/cpu-features.h          |  5 +++
 target/arm/cpu-qom.h               |  4 +-
 target/arm/cpu.c                   | 54 ++++++++++++++++++++-----
 target/arm/cpu.h                   | 15 ++++++-
 target/arm/helper.c                | 58 +++++++++++++++++++++++++++
 target/arm/internals.h             |  3 ++
 target/arm/tcg/a64.decode          |  1 +
 target/arm/tcg/cpu64.c             |  1 +
 target/arm/tcg/helper-a64.c        | 24 ++++++++++++
 target/arm/tcg/helper-a64.h        |  1 +
 target/arm/tcg/translate-a64.c     | 10 +++++
 21 files changed, 377 insertions(+), 24 deletions(-)

-- 
2.34.1


