Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8832AC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJpvZ-0003Ci-4A; Tue, 27 May 2025 04:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uJpvT-0003As-6R
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uJpvN-0000W6-Vj
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:44:46 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxIK9yezVoIxj+AA--.14116S3;
 Tue, 27 May 2025 16:44:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3xtyezVolPn0AA--.53554S2;
 Tue, 27 May 2025 16:44:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 00/12] hw/loongarch/virt: Add kernel irqchip support
Date: Tue, 27 May 2025 16:44:18 +0800
Message-Id: <20250527084430.3468174-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3xtyezVolPn0AA--.53554S2
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
  3. Interrupt injection to kernel, IRQ line interrupt is injected with
     API kvm_set_irq() and MSI interrupt is injected with API
     kvm_irqchip_send_msi().

---
v1 ... v2:
  1. Remove property irqchip-in-kernel with irqchip device driver, use
     global API kvm_irqchip_in_kernel() directly.
  2. Do not create memory map region if kernel irqchip is set.
  3. Modify copy and paste typo issue in kvm_arch_irqchip_create().
  4. Do not emulate MISC_FUNC_REG IOCSR register if kernel irqchip is
     set since it access EXTIOI memory region, this register need be
     emulated in kernel.
---
Bibo Mao (12):
  hw/intc/loongarch_extioi: Add kernel irqchip realize function
  hw/intc/loongarch_extioi: Add kernel irqchip save and restore function
  hw/intc/loongarch_ipi: Add kernel irqchip realize function
  hw/intc/loongson_ipi: Add load and save interface with ipi_common
    class
  hw/intc/loongarch_ipi: Add kernel irqchip save and restore function
  hw/intc/loongarch_pch_msi: Inject MSI interrupt to kernel
  hw/intc/loongarch_pch: Add kernel irqchip realize function
  ihw/intc/loongarch_pch: Add kernel irqchip save and restore function
  hw/intc/loongarch_pch: Inject irq line interrupt to kernel
  target/loongarch: Report error with split kernel_irqchip option
  hw/loongarch/virt: Disable emulation with IOCSR misc register
  hw/loongarch/virt: Add kernel irqchip support

 hw/intc/loongarch_extioi.c             |  45 ++++++--
 hw/intc/loongarch_extioi_kvm.c         | 146 +++++++++++++++++++++++++
 hw/intc/loongarch_ipi.c                |  25 +++++
 hw/intc/loongarch_ipi_kvm.c            |  83 ++++++++++++++
 hw/intc/loongarch_pch_msi.c            |  10 ++
 hw/intc/loongarch_pch_pic.c            |  41 ++++++-
 hw/intc/loongarch_pic_kvm.c            |  96 ++++++++++++++++
 hw/intc/loongson_ipi_common.c          |  33 ++++++
 hw/intc/meson.build                    |   6 +
 hw/loongarch/virt.c                    |  65 +++++++----
 include/hw/intc/loongarch_extioi.h     |   5 +
 include/hw/intc/loongarch_ipi.h        |   5 +
 include/hw/intc/loongarch_pch_pic.h    |   5 +
 include/hw/intc/loongarch_pic_common.h |   1 +
 include/hw/intc/loongson_ipi_common.h  |   2 +
 target/loongarch/cpu.h                 |   1 +
 target/loongarch/kvm/kvm.c             |  23 +++-
 17 files changed, 551 insertions(+), 41 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_kvm.c
 create mode 100644 hw/intc/loongarch_ipi_kvm.c
 create mode 100644 hw/intc/loongarch_pic_kvm.c


base-commit: 3c5a5e213e5f08fbfe70728237f7799ac70f5b99
-- 
2.39.3


