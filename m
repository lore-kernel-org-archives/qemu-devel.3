Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCCAE7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 01:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS4fe-0004Th-24; Sun, 29 Dec 2024 20:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tS4fb-0004T6-UY
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 20:34:11 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tS4fZ-0003dT-M9
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 20:34:11 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeCK+HFn9p9bAA--.28633S3;
 Mon, 30 Dec 2024 09:34:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxfcWJ+HFnrEUNAA--.2779S2;
 Mon, 30 Dec 2024 09:34:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] hw/intc/loongarch_ipi: Enhance multiple CPU irq routing
Date: Mon, 30 Dec 2024 09:33:56 +0800
Message-Id: <20241230013401.1564827-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxfcWJ+HFnrEUNAA--.2779S2
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

LoongArch IPI can send intterrupt to multiple CPUs, physical cpu id is
used to route interrupt for CPUs.

With cpu hotplug feature in future, logic cpu index depends on
CPUState::cpu_index heavily. Here add cpu hotplug notification interface
in IPI driver, cpu mapping logic is created inside. CPUState::cpu_index
is not used any more by IPI driver.

---
  v1 ... v2:
    1. Refresh to latest version.
    2. Rename present_cpu_map with present_map, and present_cpu with index.
    3. Replace present_cpu and cs with struct::IPICPUState.

---
Bibo Mao (5):
  hw/intc/loongson_ipi: Add more output parameter for cpu_by_arch_id
  hw/intc/loongarch_ipi: Add basic hotplug framework
  hw/intc/loongarch_ipi: Add cpu map table from physical cpu id
  hw/intc/loongarch_ipi: Implment cpu hotplug interface
  hw/intc/loongarch_ipi: Optimize function cpu_by_arch_id

 hw/intc/loongarch_ipi.c               | 126 ++++++++++++++++++++++----
 hw/intc/loongson_ipi.c                |  23 ++++-
 hw/intc/loongson_ipi_common.c         |  21 +++--
 hw/loongarch/virt.c                   |   5 +-
 include/hw/intc/loongarch_ipi.h       |  10 ++
 include/hw/intc/loongson_ipi_common.h |   3 +-
 include/hw/loongarch/virt.h           |   9 ++
 7 files changed, 164 insertions(+), 33 deletions(-)


base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
-- 
2.39.3


