Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12DAC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2024 04:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXZ2s-0000Ml-S9; Sat, 27 Jul 2024 00:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sXZ2r-0000ME-EJ
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 00:28:37 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sXZ2p-0001nr-AM
 for qemu-devel@nongnu.org; Sat, 27 Jul 2024 00:28:37 -0400
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46R4SACl049966
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Sat, 27 Jul 2024 12:28:10 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from atctrx.andestech.com (10.0.15.190) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 27 Jul
 2024 12:28:11 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH] RISC-V: Remove riscv_cpu_claim_interrupts()
Date: Sat, 27 Jul 2024 12:27:58 +0800
Message-ID: <20240727042758.2341031-1-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.190]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 46R4SACl049966
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The function of riscv_cpu_claim_interrupts() was introduced in commit
e3e7039 ("RISC-V: Allow interrupt controllers to claim interrupts") to
enforce hardware controlled of SEIP signal when there is an attached
external interrupt controller.

In later RISC-V privileged specification version 1.10, SEIP became
software-writable, even if there is an attached external interrupt
controller. Thus, the commit 33fe584 ("target/riscv: Allow software
access to MIP SEIP") was introduced to remove that limitation, and it
also removed the usage of "miclaim" mask.

It seems the function of riscv_cpu_claim_interrupts() is no longer used.
Therefore, we remove it in this commit.

Signed-off-by: Alvin Chang <alvinga@andestech.com>
---
 hw/intc/riscv_aclint.c    | 20 --------------------
 hw/intc/riscv_aplic.c     | 11 -----------
 hw/intc/riscv_imsic.c     |  8 --------
 hw/intc/sifive_plic.c     | 15 ---------------
 target/riscv/cpu.c        |  1 -
 target/riscv/cpu.h        |  3 ---
 target/riscv/cpu_helper.c | 11 -----------
 target/riscv/machine.c    |  1 -
 8 files changed, 70 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index e9f0536b1c..54cf69dada 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -280,7 +280,6 @@ static Property riscv_aclint_mtimer_properties[] = {
 static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
 {
     RISCVAclintMTimerState *s = RISCV_ACLINT_MTIMER(dev);
-    int i;
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_aclint_mtimer_ops,
                           s, TYPE_RISCV_ACLINT_MTIMER, s->aperture_size);
@@ -291,14 +290,6 @@ static void riscv_aclint_mtimer_realize(DeviceState *dev, Error **errp)
 
     s->timers = g_new0(QEMUTimer *, s->num_harts);
     s->timecmp = g_new0(uint64_t, s->num_harts);
-    /* Claim timer interrupt bits */
-    for (i = 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
-        if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
-            error_report("MTIP already claimed");
-            exit(1);
-        }
-    }
 }
 
 static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
@@ -472,7 +463,6 @@ static Property riscv_aclint_swi_properties[] = {
 static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
 {
     RISCVAclintSwiState *swi = RISCV_ACLINT_SWI(dev);
-    int i;
 
     memory_region_init_io(&swi->mmio, OBJECT(dev), &riscv_aclint_swi_ops, swi,
                           TYPE_RISCV_ACLINT_SWI, RISCV_ACLINT_SWI_SIZE);
@@ -480,16 +470,6 @@ static void riscv_aclint_swi_realize(DeviceState *dev, Error **errp)
 
     swi->soft_irqs = g_new(qemu_irq, swi->num_harts);
     qdev_init_gpio_out(dev, swi->soft_irqs, swi->num_harts);
-
-    /* Claim software interrupt bits */
-    for (i = 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
-        /* We don't claim mip.SSIP because it is writable by software */
-        if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0) {
-            error_report("MSIP already claimed");
-            exit(1);
-        }
-    }
 }
 
 static void riscv_aclint_swi_reset_enter(Object *obj, ResetType type)
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 32edd6d07b..cde8337542 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -873,17 +873,6 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     if (!aplic->msimode) {
         aplic->external_irqs = g_malloc(sizeof(qemu_irq) * aplic->num_harts);
         qdev_init_gpio_out(dev, aplic->external_irqs, aplic->num_harts);
-
-        /* Claim the CPU interrupt to be triggered by this APLIC */
-        for (i = 0; i < aplic->num_harts; i++) {
-            RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
-            if (riscv_cpu_claim_interrupts(cpu,
-                (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
-                error_report("%s already claimed",
-                             (aplic->mmode) ? "MEIP" : "SEIP");
-                exit(1);
-            }
-        }
     }
 
     msi_nonbroken = true;
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index b90f0d731d..8c61a5f28b 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -347,14 +347,6 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
                           IMSIC_MMIO_SIZE(imsic->num_pages));
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &imsic->mmio);
 
-    /* Claim the CPU interrupt to be triggered by this IMSIC */
-    if (riscv_cpu_claim_interrupts(rcpu,
-            (imsic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
-        error_setg(errp, "%s already claimed",
-                   (imsic->mmode) ? "MEIP" : "SEIP");
-        return;
-    }
-
     /* Create output IRQ lines */
     imsic->external_irqs = g_malloc(sizeof(qemu_irq) * imsic->num_pages);
     qdev_init_gpio_out(dev, imsic->external_irqs, imsic->num_pages);
diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index e559f11805..f0f3dcce1f 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -356,7 +356,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
     SiFivePLICState *s = SIFIVE_PLIC(dev);
-    int i;
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_plic_ops, s,
                           TYPE_SIFIVE_PLIC, s->aperture_size);
@@ -385,20 +384,6 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
     s->m_external_irqs = g_malloc(sizeof(qemu_irq) * s->num_harts);
     qdev_init_gpio_out(dev, s->m_external_irqs, s->num_harts);
 
-    /*
-     * We can't allow the supervisor to control SEIP as this would allow the
-     * supervisor to clear a pending external interrupt which will result in
-     * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
-     * hardware controlled when a PLIC is attached.
-     */
-    for (i = 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
-        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
-            error_setg(errp, "SEIP already claimed");
-            return;
-        }
-    }
-
     msi_nonbroken = true;
 }
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3ba..19feb032d6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -967,7 +967,6 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         }
     }
     env->mcause = 0;
-    env->miclaim = MIP_SGEIP;
     env->pc = env->resetvec;
     env->bins = 0;
     env->two_stage_lookup = false;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1619c3acb6..6277979afd 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -258,8 +258,6 @@ struct CPUArchState {
     bool external_seip;
     bool software_seip;
 
-    uint64_t miclaim;
-
     uint64_t mie;
     uint64_t mideleg;
 
@@ -565,7 +563,6 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
-int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
 void riscv_cpu_interrupt(CPURISCVState *env);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 395a1d9140..bcafa55acd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -619,17 +619,6 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
     env->geilen = geilen;
 }
 
-int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
-{
-    CPURISCVState *env = &cpu->env;
-    if (env->miclaim & interrupts) {
-        return -1;
-    } else {
-        env->miclaim |= interrupts;
-        return 0;
-    }
-}
-
 void riscv_cpu_interrupt(CPURISCVState *env)
 {
     uint64_t gein, vsgein = 0, vstip = 0, irqf = 0;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 492c2c6d9d..0eabb6c076 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -378,7 +378,6 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.mhartid, RISCVCPU),
         VMSTATE_UINT64(env.mstatus, RISCVCPU),
         VMSTATE_UINT64(env.mip, RISCVCPU),
-        VMSTATE_UINT64(env.miclaim, RISCVCPU),
         VMSTATE_UINT64(env.mie, RISCVCPU),
         VMSTATE_UINT64(env.mvien, RISCVCPU),
         VMSTATE_UINT64(env.mvip, RISCVCPU),
-- 
2.34.1


