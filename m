Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761C2CA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 07:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy3Vd-0002Ir-Pn; Mon, 15 Sep 2025 03:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uy3VW-0002Gw-4i
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uy3VE-0000KQ-0J
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:11 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxP9MTvsdo62wKAA--.21816S3;
 Mon, 15 Sep 2025 15:19:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxVOQSvsdoXteWAA--.24724S2;
 Mon, 15 Sep 2025 15:19:46 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/8] Add high MMIO support with GPEX host bridge
Date: Mon, 15 Sep 2025 15:19:38 +0800
Message-Id: <20250915071946.315171-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxVOQSvsdoXteWAA--.24724S2
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

On LoongArch Virt Machine, MMIO region with GPEX host bridge is
0x40000000 -- 0x7FFFFFFF. The total size is 1G bytes and it is enough
for emulated virtio devices basically.

However on some conditions such as hostmem is added with virtio-gpu
device with -device virtio-gpu-gl,hostmem=4G. The PCIE MMIO region is
not enough, 64-bit high MMIO region is required.

Here property highmem-mmio is added on virt machine to add 64-bit high
MMIO region supported. With high MMIO region added, it is not compatible
with old machine, so property highmem-mmio is disabled by default.

Bibo Mao (8):
  target/loongarch: Add phys_bits in CPULoongArchState
  hw/loongarch/virt: Add field ram_end in LoongArchVirtMachineState
  hw/loongarch/virt: Add field gpx in LoongArchVirtMachineState
  hw/loongarch/virt: Get irq number from gpex config info
  hw/loongarch/virt: Get PCI info from gpex config info
  hw/loongarch/virt: Add property highmem_mmio with virt machine
  hw/loongarch/virt: Add high MMIO support with GPEX host
  hw/loongarch/virt: Add property highmem-mmio-size with virt machine

 hw/loongarch/virt-acpi-build.c |  17 +---
 hw/loongarch/virt-fdt-build.c  |  43 +++++++---
 hw/loongarch/virt.c            | 152 ++++++++++++++++++++++++++++++---
 include/hw/loongarch/virt.h    |   5 +-
 target/loongarch/cpu.c         |  13 +--
 target/loongarch/cpu.h         |   2 +
 6 files changed, 186 insertions(+), 46 deletions(-)


base-commit: 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d
-- 
2.39.3


