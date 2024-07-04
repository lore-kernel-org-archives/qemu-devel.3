Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF20C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPDIY-0007qx-Hd; Wed, 03 Jul 2024 23:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sPDIV-0007qb-Pp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:38:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sPDIT-0003AL-0k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 23:38:15 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxbPAbGYZmBs0AAA--.2439S3;
 Thu, 04 Jul 2024 11:38:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxlsUaGYZmgJI6AA--.59898S2; 
 Thu, 04 Jul 2024 11:38:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] Reconstruct loongson ipi driver
Date: Thu,  4 Jul 2024 11:37:58 +0800
Message-Id: <20240704033802.3838618-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxlsUaGYZmgJI6AA--.59898S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now loongson ipi and loongarch ipi share the same code with different
macro, loongson ipi has its separate function such mmio region,
loongarch ipi has other requirement such as irqchip in kernel.

Interrupt irqchip has strong relationship with architecture, since
it sends irq to vcpu and interfaces to get irqchip register is also
architecture specific. 

Here like other architectures, base class TYPE_LOONGSON_IPI_COMMON
is added, it comes from loongson ipi mostly. And it defined four abstract
interfaces which can be used for MIPS 3A4000 and Loongarch 3A5000 machine,
also can be used for 3A5000 irqchip in kernel mode soon.

Also Loongarch ipi and loongson ipi device are added here, it inherits
from base class TYPE_LOONGSON_IPI_COMMON. Loongarch ipi is tested,
loongson ipi device only passes to compile and make check, it is not
tested.

Bibo Mao (4):
  hw/intc/loongson_ipi_common: Add loongson ipi common class
  hw/intc/loongarch_ipi: Add loongarch ipi support
  hw/loongarch/virt: Replace loongson ipi with loongarch ipi
  hw/intc/loongson_ipi: reconstruct driver inherit from common class

 hw/intc/Kconfig                       |   3 +
 hw/intc/loongarch_ipi.c               |  80 ++++++
 hw/intc/loongson_ipi.c                | 330 ++-------------------
 hw/intc/loongson_ipi_common.c         | 394 ++++++++++++++++++++++++++
 hw/intc/meson.build                   |   3 +-
 hw/loongarch/Kconfig                  |   2 +-
 hw/loongarch/virt.c                   |   4 +-
 include/hw/intc/loongarch_ipi.h       |  33 +++
 include/hw/intc/loongson_ipi.h        |  54 ++--
 include/hw/intc/loongson_ipi_common.h |  77 +++++
 include/hw/loongarch/virt.h           |   1 -
 11 files changed, 632 insertions(+), 349 deletions(-)
 create mode 100644 hw/intc/loongarch_ipi.c
 create mode 100644 hw/intc/loongson_ipi_common.c
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 include/hw/intc/loongson_ipi_common.h


base-commit: 6746482d12da3b6e4d3cdf06481a0027a797f719
-- 
2.39.3


