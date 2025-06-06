Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A7AC5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQbV-00070v-DP; Fri, 06 Jun 2025 02:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uNQbK-00070O-Qs
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:30:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uNQbH-0007PW-B6
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:30:50 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxnOIQi0Jo_74NAQ--.3573S3;
 Fri, 06 Jun 2025 14:30:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxu8QNi0JoJcYMAQ--.37752S2;
 Fri, 06 Jun 2025 14:30:37 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 00/13] hw/loongarch/virt: Add kernel irqchip support
Date: Fri,  6 Jun 2025 14:30:20 +0800
Message-Id: <20250606063033.2557365-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8QNi0JoJcYMAQ--.37752S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If kernel irqchip is set such as kvm_irqchip_in_kernel() return true, there
is special operations with irqchips in such fields:
  1. During irqchip object realization, kvm_create_device() is used here
     to create irqchip in KVM kernel.
  2. Add pre_save and post_load function, where register states can be
     get and set from KVM kernel.
  3. With reset function, register and software state is initialized
     in qemu user space and set to KVM kernel with ioctl command.
  4. Interrupt injection to kernel, IRQ line interrupt is injected with
     API kvm_set_irq() and MSI interrupt is injected with API
     kvm_irqchip_send_msi().

---
v2 ... v3:
  1. Implement reset function with kernel irqchip device, initialize the
     registers and set to KVM kernel.
  2. Use register offset address rather base address in function
     kvm_pch_pic_save_load().
  3. Rename kvm_xxx_save_load() with kvm_xxx_access().
  4. Rename kvm_xxx_pre_save() with kvm_xxx_get(), kvm_xxx_post_load()
     with kvm_xxx_put().
  5. Macro KVM_IRQCHIP_NUM_PINS defined in UAPI header file is used
     kvm_loongarch_init_irq_routing(), which means the maxinium irq line
     number.

v1 ... v2:
  1. Remove property irqchip-in-kernel with irqchip device driver, use
     global API kvm_irqchip_in_kernel() directly.
  2. Do not create memory map region if kernel irqchip is set.
  3. Modify copy and paste typo issue in kvm_arch_irqchip_create().
  4. Do not emulate MISC_FUNC_REG IOCSR register if kernel irqchip is
     set since it access EXTIOI memory region, this register need be
     emulated in kernel.

Bibo Mao (13):
  hw/intc/loongarch_extioi: Add kernel irqchip realize function
  hw/intc/loongarch_extioi: Add kernel irqchip save and restore function
  hw/intc/loongarch_ipi: Add kernel irqchip realize function
  hw/intc/loongson_ipi: Add load and save interface with ipi_common
    class
  hw/intc/loongarch_ipi: Add kernel irqchip save and restore function
  hw/intc/loongarch_pch_msi: Inject MSI interrupt to kernel
  hw/intc/loongarch_pch: Add kernel irqchip realize function
  hw/intc/loongarch_pch: Add kernel irqchip save and restore function
  hw/intc/loongarch_pch: Inject irq line interrupt to kernel
  hw/loongarch/virt: Add reset support for kernel irqchip
  target/loongarch: Report error with split kernel_irqchip option
  hw/loongarch/virt: Disable emulation with IOCSR misc register
  hw/loongarch/virt: Add kernel irqchip support

 hw/intc/loongarch_extioi.c             |  49 ++++++---
 hw/intc/loongarch_extioi_kvm.c         | 140 +++++++++++++++++++++++++
 hw/intc/loongarch_ipi.c                |  29 +++++
 hw/intc/loongarch_ipi_kvm.c            |  85 +++++++++++++++
 hw/intc/loongarch_pch_msi.c            |  10 ++
 hw/intc/loongarch_pch_pic.c            |  45 +++++++-
 hw/intc/loongarch_pic_kvm.c            |  89 ++++++++++++++++
 hw/intc/loongson_ipi_common.c          |  33 ++++++
 hw/intc/meson.build                    |   6 ++
 hw/loongarch/virt.c                    |  65 +++++++-----
 include/hw/intc/loongarch_extioi.h     |   5 +
 include/hw/intc/loongarch_ipi.h        |   5 +
 include/hw/intc/loongarch_pch_pic.h    |   5 +
 include/hw/intc/loongarch_pic_common.h |   1 +
 include/hw/intc/loongson_ipi_common.h  |   2 +
 target/loongarch/cpu.h                 |   1 +
 target/loongarch/kvm/kvm.c             |  23 +++-
 17 files changed, 552 insertions(+), 41 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_kvm.c
 create mode 100644 hw/intc/loongarch_ipi_kvm.c
 create mode 100644 hw/intc/loongarch_pic_kvm.c


base-commit: 09be8a511a2e278b45729d7b065d30c68dd699d0
-- 
2.39.3


