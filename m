Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3551C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKeC-0006Ef-8m; Fri, 09 May 2025 06:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKe8-0006As-VX
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKe5-00018d-5k
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:00 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxbWv00x1o7WLbAA--.31894S3;
 Fri, 09 May 2025 18:07:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxPcX00x1oMCfAAA--.29037S2;
 Fri, 09 May 2025 18:07:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 00/15] hw/loongarch/virt: Add kvm_irqchip_in_kernel support
Date: Fri,  9 May 2025 18:07:32 +0800
Message-Id: <20250509100747.1070094-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcX00x1oMCfAAA--.29037S2
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

To enable kvm_irqchip_in_kernel option on LoongArch virt machine
platform, property irqchip-in-kernel is added on irqchips including
ExtIOI, IPI, PCH_PCI and PCH_MSI irqchip.

If property irqchip-in-kernel is set, there is special operations with
irqchips in such fields:
  1. During irqchip object realization, kvm_create_device() is used here
     to create irqchip in KVM kernel.
  2. Add pre_save and post_load function, where register states can be
     get and set from KVM kernel.
  3. Interrupt injection to kernel, IRQ line intterupt is injected with
     API kvm_set_irq() and MSI intterrupt is injected with API
     kvm_irqchip_send_msi().
     
Bibo Mao (15):
  hw/intc/loongarch_extioi: Add irqchip-in-kernel property
  hw/intc/loongarch_extioi: Add irqchip-in-kernel realize function
  hw/intc/loongarch_extioi: Add irqchip-in-kernel save/restore function
  hw/intc/loongarch_ipi: Add irqchip-in-kernel property
  hw/intc/loongarch_ipi: Add irqchip-in-kernel realize function
  hw/intc/loongson_ipi: Add load and save interface with ipi_common
    class
  hw/intc/loongarch_ipi: Add irqchip-in-kernel save/restore function
  hw/intc/loongarch_pch_msi: Add irqchip-in-kernel property
  hw/intc/loongarch_pch_msi: Inject MSI interrupt to kernel
  hw/intc/loongarch_pch: Add irqchip-in-kernel property
  hw/intc/loongarch_pch: Add irqchip-in-kernel realize function
  hw/intc/loongarch_pch: Add irqchip-in-kernel save/restore function
  hw/intc/loongarch_pch: Inject irq line interrupt to kernel
  target/loongarch: Report error with split kernel_irqchip option
  hw/loongarch/virt: Add kvm_irqchip_in_kernel support

 hw/intc/loongarch_extioi.c             |  35 ++++++
 hw/intc/loongarch_extioi_kvm.c         | 146 +++++++++++++++++++++++++
 hw/intc/loongarch_ipi.c                |  41 +++++++
 hw/intc/loongarch_ipi_kvm.c            |  83 ++++++++++++++
 hw/intc/loongarch_pch_msi.c            |  17 +++
 hw/intc/loongarch_pch_pic.c            |  50 +++++++++
 hw/intc/loongarch_pic_kvm.c            |  96 ++++++++++++++++
 hw/intc/loongson_ipi_common.c          |  28 +++++
 hw/intc/meson.build                    |   6 +
 hw/loongarch/virt.c                    |  15 +++
 include/hw/intc/loongarch_extioi.h     |   6 +
 include/hw/intc/loongarch_ipi.h        |   6 +
 include/hw/intc/loongarch_pch_msi.h    |   1 +
 include/hw/intc/loongarch_pch_pic.h    |   6 +
 include/hw/intc/loongarch_pic_common.h |   1 +
 include/hw/intc/loongson_ipi_common.h  |   2 +
 target/loongarch/cpu.h                 |   1 +
 target/loongarch/kvm/kvm.c             |  23 +++-
 18 files changed, 562 insertions(+), 1 deletion(-)
 create mode 100644 hw/intc/loongarch_extioi_kvm.c
 create mode 100644 hw/intc/loongarch_ipi_kvm.c
 create mode 100644 hw/intc/loongarch_pic_kvm.c

-- 
2.39.3


