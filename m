Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35596CF8853
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM40N-0001zT-Oi; Thu, 20 Nov 2025 07:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1vM40L-0001yu-3X
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:43:17 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1vM40H-00043j-1p
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:43:15 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx77_QDB9pvhcmAA--.14302S3;
 Thu, 20 Nov 2025 20:42:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBxysDPDB9plJg5AQ--.5496S2;
 Thu, 20 Nov 2025 20:42:55 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org,
	lixianglai@loongson.cn
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH V4 0/2] fix pci device can't alloc irq from fdt
Date: Thu, 20 Nov 2025 20:18:40 +0800
Message-Id: <cover.1763434297.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxysDPDB9plJg5AQ--.5496S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

When we use the -kernel parameter to start an elf format kernel relying on
fdt, we get the following error:

pcieport 0000:00:01.0: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.0: enabling device (0000 -> 0003)
pcieport 0000:00:01.0: PME: Signaling with IRQ 19
pcieport 0000:00:01.0: AER: enabled with IRQ 19
pcieport 0000:00:01.1: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.1: enabling device (0000 -> 0003)
pcieport 0000:00:01.1: PME: Signaling with IRQ 20
pcieport 0000:00:01.1: AER: enabled with IRQ 20
pcieport 0000:00:01.2: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.2: enabling device (0000 -> 0003)
pcieport 0000:00:01.2: PME: Signaling with IRQ 21
pcieport 0000:00:01.2: AER: enabled with IRQ 21
pcieport 0000:00:01.3: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.3: enabling device (0000 -> 0003)
pcieport 0000:00:01.3: PME: Signaling with IRQ 22
pcieport 0000:00:01.3: AER: enabled with IRQ 22
pcieport 0000:00:01.4: of_irq_parse_pci: failed with rc=-22

This is because  the description of interrupt-cell is missing in the pcie
irq map.  And there is a lack of a description of the interrupt trigger
type.  Now it is corrected and the correct interrupt-cell is added in the
pcie irq map.

Refer to the implementation in arm and add some comments.

changes:
V3->V4:
1.Delete the incorrect byte order conversion

changes:
V2->V3:
1.Delete unnecessary changes
2.Replace some magic numbers with macro definitions

V1->V2:
1.Fallback the incorrect modification of pch_pic interrupt-cells and add
the interrupt trigger type in the pcie irq map
2.Add macro definitions for the interrupt trigger types of fdt
3.Refer to the implementation in arm and add some comments.

Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>

Xianglai Li (2):
  Modify the interrupt trigger type in loongarch virt fdt to macro
    definition
  fix pci device can't alloc irq from fdt

 hw/loongarch/virt-fdt-build.c | 55 +++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 18 deletions(-)

-- 
2.39.1


