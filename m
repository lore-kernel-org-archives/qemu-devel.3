Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456F8C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 03:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS5YT-00074O-PW; Wed, 18 Jun 2025 23:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uS5YK-00072U-8F
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uS5YG-00069E-K3
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:02:59 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxlmnSfVNorY4ZAQ--.58200S3;
 Thu, 19 Jun 2025 11:02:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhu7fVNoIXkgAQ--.48014S2;
 Thu, 19 Jun 2025 11:02:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 0/9] hw/loongarch: add the advanced extended interrupt
 controllers (AVECINTC) support
Date: Thu, 19 Jun 2025 10:39:35 +0800
Message-Id: <20250619023944.1278716-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhu7fVNoIXkgAQ--.48014S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

ntroduce the advanced extended interrupt controllers (AVECINTC). This
feature will allow each core to have 256 independent interrupt vectors
and MSI interrupts can be independently routed to any vector on any CPU.

The whole topology of irqchips in LoongArch machines looks like this if
AVECINTC is supported:

  +-----+     +-----------------------+     +-------+
  | IPI | --> |        CPUINTC        | <-- | Timer |
  +-----+     +-----------------------+     +-------+
               ^          ^          ^
               |          |          |
        +---------+ +----------+ +---------+     +-------+
        | EIOINTC | | AVECINTC | | LIOINTC | <-- | UARTs |
        +---------+ +----------+ +---------+     +-------+
             ^            ^
             |            |
        +---------+  +---------+
        | PCH-PIC |  | PCH-MSI |
        +---------+  +---------+
          ^     ^           ^
          |     |           |
  +---------+ +---------+ +---------+
  | Devices | | PCH-LPC | | Devices |
  +---------+ +---------+ +---------+
                   ^
                   |
              +---------+
              | Devices |
              +---------+

We can see more about AVECINTC on linux driver code[1]
and loongarch msg interrupts on volI 6.2 Message-Interrupts

Tested the code using the virion-net NIC the start scripts is kernel.sh at[3]

[1]: https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-loongarch-avec.c
[2]: https://github.com/loongson/LoongArch-Documentation/releases/download/2023.04.20/LoongArch-Vol1-v1.10-EN.pdf
[3]: https://github.com/gaosong715/qemu/releases/download/pull-loongarch-20250514/kernel.sh

v2:
  1: Use one irqline for avec parent_irq;
  2; Correct avec memroy area;
  3; Pch-msi not connecet to avec when avec is enabled and drop patch 7;
  4: Add misc_feature and misc_status for misc features an misc
     fetures status
  5: Define CSR_ESTAT and CSR_ECFG bit15 for msg interupt. clean patch9.
  6: Fix test demsg error.

Thanks.
Song Gao

Song Gao (9):
  hw/loongarch: move some machine define to virt.h
  loongarch: add virt feature avecintc support
  loongarch: add a advance interrupt controller device
  target/loongarch: add msg interrupt CSR registers
  hw/loongarch: AVEC controller add a MemoryRegion
  hw/loongarch: Implement avec controller imput and output pins
  hw/loongarch: Implement avec set_irq
  target/loongarch: loongarch CPU supoort avec irqs
  target/loongarch: do_interrupt support msg interrupt

 hw/intc/Kconfig                  |   3 +
 hw/intc/loongarch_avec.c         | 143 +++++++++++++++++++++++++++++++
 hw/intc/meson.build              |   1 +
 hw/loongarch/Kconfig             |   1 +
 hw/loongarch/virt.c              |  89 ++++++++++++++++++-
 include/hw/intc/loongarch_avec.h |  36 ++++++++
 include/hw/loongarch/virt.h      |  36 ++++++++
 include/hw/pci-host/ls7a.h       |   2 +
 target/loongarch/cpu-csr.h       |   6 +-
 target/loongarch/cpu.c           |  17 ++++
 target/loongarch/cpu.h           |  34 +++-----
 target/loongarch/machine.c       |   5 ++
 12 files changed, 346 insertions(+), 27 deletions(-)
 create mode 100644 hw/intc/loongarch_avec.c
 create mode 100644 include/hw/intc/loongarch_avec.h

-- 
2.34.1


