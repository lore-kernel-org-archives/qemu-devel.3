Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A259CCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxgs-0000oJ-2l; Wed, 03 Apr 2024 06:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrxgm-0000jC-Mp; Wed, 03 Apr 2024 06:17:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rrxgh-0006ba-Tu; Wed, 03 Apr 2024 06:17:52 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V8gbP5BfSzXkKn;
 Wed,  3 Apr 2024 18:14:41 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 5A92A140F81;
 Wed,  3 Apr 2024 18:17:39 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 18:17:38 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v12 00/23] target/arm: Implement FEAT_NMI and FEAT_GICv3_NMI
Date: Wed, 3 Apr 2024 10:15:48 +0000
Message-ID: <20240403101611.3204086-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=ruanjinjie@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch set implements FEAT_NMI and FEAT_GICv3_NMI for ARMv8. These
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
IPI as NMI framework, softlockup, hardlockup and kgdb test cases, and the PPI
interrupt is tested with "perf top" command with hardware NMI enabled, and
the SPI interrupt is tested with a custom test module, in which NMI interrupts
can be received and sent normally.

And the Virtual NMI(VNMI) SGI, PPI and SPI interrupts has also been tested in
nested QEMU Virtual Machine with host "virtualization=true". The SGI VNMI is
tested by accessing GICR_INMIR0 and GICR_ISPENDR0 with devmem command, as well
as hardlockup and kgdb testcases. The PPI VNMI is tested by accessing
GICR_INMIR0 and GICR_ISPENDR0 with devmem command, as well as "perf top"
command with hardware NMI enabled, which works well. The SPI VNMI is tested
with a custom test module, in which SPI VNMI can be sent from the
GIC and received normally.

         +-------------------------------------------------+
         |               Distributor                       |
         +-------------------------------------------------+
             SPI |  NMI                        |  NMI
                \/                            \/
            +--------+                     +-------+
            | Redist |                     | Redist|
            +--------+                     +-------+
            SGI  | NMI                     PPI | NMI
                \/                            \/
          +-------------+             +---------------+
          |CPU Interface|   ...       | CPU Interface |
          +-------------+             +---------------+
               | NMI                         | NMI
              \/                            \/
            +-----+                       +-----+
            |  PE |                       |  PE |
            +-----+                       +-----+

Changes in v12:
- pPriority<63> = ICC_AP1R_EL1NS<63> if HaveNMIExt() and HaveEL(EL3) and
  (IsNonSecure(), fix the wrong writing.
- Do not check nmi_support repetitively in icc_hppi_can_preempt(),
  and icc_activate_irq, ich_highest_active_virt_prio(), hppvi_index(),
  icv_hppi_can_preempt(), icv_rpr_read() and icv_activate_irq(),
  gicv3_cpuif_virt_irq_fiq_update().
- Check hppi.nmi after check icc_hppi_can_preempt() for icc_iar1_read() and
  icc_nmiar1_read().
- When NMI is 1, the virtual interrupt's priority is 0x0.
- Make the thisnmi logic more concisely in hppvi_index().
- Use is_nmi to simplify code and check is_nmi before comparing vpmr.
- Also check sctlrx.NMI in icv_iar_read().
- Check icv_hppi_can_preempt() for icv_nmiar1_read().
- Check ICH_LR_EL2.NMI after check icv_hppi_can_preempt() as icv_iar_read()
  do it in icv_nmiar1_read().
- Correct thisnmi to bool in icv_eoir_write().
- Check thisnmi and nmi both true instead of identical in icv_eoir_write().
- nmi_needed -> gicv3_cpu_nmi_needed, needed_nmi -> gicv3_nmi_needed.
- Correct the comment style in arm_cpu_initfn() and icv_nmiar1_read().
- Fix the typo, "prioirty" -> "priority".
- Remove the redundant blank line.
- Update the subject and commit message, hppi.superprio -> hppi.nmi,
  super priority -> non-maskable property.
- Add Reviewed-by.

Changes in v11:
- Put vmstate_gicv3_cpu_nmi and vmstate_gicv3_gicd_nmi into existing list.
- Remove the excess != 0.
- Handle NMI priority in icc_highest_active_prio() and handle NMI RPR in
  icc_rpr_read() separately.
- Only set NMI bit for a NMI and and ordinary priority bit for a non-NMI in
  icc_activate_irq().
- Only clear APR bit for AP1R0 in icc_drop_prio().
- Check special INTID_* in callers instead of passing two extra boolean args
  for ack functions.
- Handle NMI in icc_hppi_can_preempt() and icc_highest_active_group().
- Also check icc_hppi_can_preempt() for icc_nmiar1_read().
- Deal with NMI in the callers instead of ich_highest_active_virt_prio().
- Set either NMI or a group-priority bit, not both.
- Only set AP NMI bits in the 0 reg.
- Handle NMI in hppvi_index(), icv_hppi_can_preempt() and icv_eoir_write().
- Add Reviewed-by.

Changes in v10:
- Correct the exception_target_el(env) to 2 in msr_set_allint_el1 helper,
  since it is a hypervisor trap from EL1 to EL2.
- In arm_cpu_exec_interrupt(), if SCTLR_ELx.NMI is 0, NMI -> IRQ,
  VINMI -> VIRQ, VFNMI -> VFIQ.
- Make arm_cpu_update_virq() and arm_cpu_update_vfiq() check that it is not a
  VINMI/VFNMI, so only set 1 bit in interrupt_request, not 2.
- Adjust "hw/intc: Enable FEAT_GICv3_NMI Feature" to before "add irq
  non-maskable property".
- superprio -> nmi, gicr_isuperprio -> gicr_inmir0, is_nmi -> nmi,
  is_hppi -> hppi, has_superprio -> nmi, superpriority -> non-maskable property.
- Save NMI state in vmstate_gicv3_cpu and vmstate_gicv3.
- Exchange the order of nmi and hppi parameters.
- Handle APR and RPR NMI bits, rename ICH_AP1R_EL2_NMI to ICV_AP1R_EL1_NMI.
- Set ICV_RPR_EL1.NMI according to the ICV_AP1R<n>_EL1.NMI in
  ich_highest_active_virt_prio()
- Update the commit message.

Changes in v9:
- Move nmi_reginfo and related functions inside an existing ifdef
  TARGET_AARCH64 to solve the --target-list=aarch64-softmmu,arm-softmmu
  compilation problem.
- Check 'isread' when writing to ALLINT.
- Update the GPIOs passed in the arm_cpu_kvm_set_irq, and update the comment.
- Definitely not merge VINMI and VFNMI into EXCP_VNMI.
- ARM_CPU_VNMI -> ARM_CPU_VINMI, CPU_INTERRUPT_VNMI -> CPU_INTERRUPT_VINMI.
- Update VINMI and VFNMI when writing HCR_EL2 or HCRX_EL2.
- Update the commit subject and message, VNMI -> VINMI.
- Handle CPSR_F and ISR_FS according to CPU_INTERRUPT_VFNMI instead of
  CPU_INTERRUPT_VFIQ and HCRX_EL2.VFNMI.
- Not check SCTLR_NMI in arm_cpu_do_interrupt_aarch64().
- Correct the INTID_NMI logic.
- Declare cpu variable to reuse latter.

Changes in v8:
- Fix the rcu stall after sending a VNMI in qemu VM.
- Fix an unexpected interrupt bug when sending VNMI by running qemu VM.
- Test the VNMI interrupt.
- Update the commit message.
- Add Reviewed-by.

Changes in v7:
- env->cp15.hcrx_el2 -> arm_hcrx_el2_eff().
- Reorder the irqbetter() code for clarity.
- Eliminate the has_superprio local variable for gicv3_get_priority().
- false -> cs->hpplpi.superprio in gicv3_redist_update_noirqset().
- 0x0 -> false in arm_gicv3_common_reset_hold().
- Clear superprio in several places for hppi, hpplpi and hppvlpi.
- Add Reviewed-by.

Changes in v6:
- Fix DISAS_TOO_MANY to DISAS_UPDATE_EXIT for ALLINT MSR (immediate).
- Verify that HCR_EL2.VF is set before checking VFNMI.
- env->cp15.hcr_el2 -> arm_hcr_el2_eff().
- env->cp15.hcrx_el2 -> arm_hcrx_el2_eff().
- Not combine VFNMI with CPU_INTERRUPT_VNMI.
- Implement icv_nmiar1_read().
- Put the "extract superprio info" code into gicv3_get_priority().
- Update the comment in irqbetter().
- Reset the cs->hppi.superprio to 0x0.
- Set hppi.superprio to false for LPI.
- Add Reviewed-by.

Changes in v5:
- Remove the comment for ALLINT in cpu.h.
- Merge allint_check() to msr_i_allint to clear the ALLINT MSR (immediate)
  implementation.
- Rename msr_i_allint() to msr_set_allint_el1() to make it clearer.
- Drop the & 1 in trans_MSR_i_ALLINT().
- Add Reviewed-by.

Changes in v4:
- Handle VNMI within the CPU and the GIC.
- Keep PSTATE.ALLINT in env->pstate but not env->allint.
- Fix the ALLINT MSR (immediate) decodetree implementation.
- Accept NMI unconditionally for arm_cpu_has_work() but add comment.
- Improve nmi mask in arm_excp_unmasked().
- Make the GICR_INMIR0 and GICD_INMIR implementation more clearer.
- Improve ICC_NMIAR1_EL1 implementation
- Extract gicv3_get_priority() to avoid priority code repetition.
- Add Reviewed-by.

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

Jinjie Ruan (23):
  target/arm: Handle HCR_EL2 accesses for bits introduced with FEAT_NMI
  target/arm: Add PSTATE.ALLINT
  target/arm: Add support for FEAT_NMI, Non-maskable Interrupt
  target/arm: Implement ALLINT MSR (immediate)
  target/arm: Support MSR access to ALLINT
  target/arm: Add support for Non-maskable Interrupt
  target/arm: Add support for NMI in arm_phys_excp_target_el()
  target/arm: Handle IS/FS in ISR_EL1 for NMI, VINMI and VFNMI
  target/arm: Handle PSTATE.ALLINT on taking an exception
  hw/arm/virt: Wire NMI and VINMI irq lines from GIC to CPU
  hw/intc/arm_gicv3: Add external IRQ lines for NMI
  target/arm: Handle NMI in arm_cpu_do_interrupt_aarch64()
  hw/intc/arm_gicv3: Add has-nmi property to GICv3 device
  hw/intc/arm_gicv3: Add irq non-maskable property
  hw/intc/arm_gicv3_redist: Implement GICR_INMIR0
  hw/intc/arm_gicv3: Implement GICD_INMIR
  hw/intc/arm_gicv3: Add NMI handling CPU interface registers
  hw/intc/arm_gicv3: Handle icv_nmiar1_read() for icc_nmiar1_read()
  hw/intc/arm_gicv3: Implement NMI interrupt priority
  hw/intc/arm_gicv3: Report the NMI interrupt in gicv3_cpuif_update()
  hw/intc/arm_gicv3: Report the VINMI interrupt
  target/arm: Add FEAT_NMI to max
  hw/arm/virt: Add FEAT_GICv3_NMI feature support in virt GIC

 docs/system/arm/emulation.rst      |   1 +
 hw/arm/virt.c                      |  25 ++-
 hw/intc/arm_gicv3.c                |  67 +++++++-
 hw/intc/arm_gicv3_common.c         |  48 ++++++
 hw/intc/arm_gicv3_cpuif.c          | 253 +++++++++++++++++++++++++++--
 hw/intc/arm_gicv3_dist.c           |  36 ++++
 hw/intc/arm_gicv3_redist.c         |  22 +++
 hw/intc/gicv3_internal.h           |  13 ++
 hw/intc/trace-events               |   2 +
 include/hw/intc/arm_gic_common.h   |   2 +
 include/hw/intc/arm_gicv3_common.h |   7 +
 target/arm/cpu-features.h          |   5 +
 target/arm/cpu-qom.h               |   5 +-
 target/arm/cpu.c                   | 147 +++++++++++++++--
 target/arm/cpu.h                   |   9 +
 target/arm/helper.c                | 101 +++++++++++-
 target/arm/internals.h             |  21 +++
 target/arm/tcg/a64.decode          |   1 +
 target/arm/tcg/cpu64.c             |   1 +
 target/arm/tcg/helper-a64.c        |  12 ++
 target/arm/tcg/helper-a64.h        |   1 +
 target/arm/tcg/translate-a64.c     |  19 +++
 22 files changed, 753 insertions(+), 45 deletions(-)

-- 
2.34.1


