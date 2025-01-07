Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80484E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 03:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUzxG-00056j-QZ; Mon, 06 Jan 2025 22:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tUzxF-00056H-9r
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:29 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tUzxC-0004c1-Tu
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:29 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx++GkmnxnTfheAA--.55041S3;
 Tue, 07 Jan 2025 11:08:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxfcejmnxnn2gXAA--.35275S2;
 Tue, 07 Jan 2025 11:08:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] hw/intc/loongson_ipi: Remove property num_cpu
Date: Tue,  7 Jan 2025 11:08:12 +0800
Message-Id: <20250107030819.90442-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxfcejmnxnn2gXAA--.35275S2
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

Property num_cpu is not necessary, it can be acquired from function
possible_cpu_arch_ids(), also adding arch_id and CPUState pointer in
IPICore object, so that IPICore object can be parsed from physical
cpu id.

---
  v2 ... v3:
    1. Remove TYPE_HOTPLUG_HANDLER interface support
    2. Remove num_cpu property
    3. Adding arch_id and CPUState pointer in IPICore object

  v1 ... v2:
    1. Refresh to latest version.
    2. Rename present_cpu_map with present_map, and present_cpu with index.
    3. Replace present_cpu and cs with struct::IPICPUState.

---
Bibo Mao (7):
  hw/intc/loongarch_ipi: Implement realize interface
  hw/intc/loongson_ipi: Remove num_cpu from loongson_ipi_common
  hw/intc/loongson_ipi: Remove property num_cpu from loongson_ipi_common
  hw/intc/loongarch_ipi: Get cpu number from possible_cpu_arch_ids
  hw/intc/loongarch_ipi: Remove num-cpu property
  hw/intc/loongson_ipi: Add more output parameter for cpu_by_arch_id
  hw/intc/loongarch_ipi: Use alternative function cpu_by_arch_id

 hw/intc/loongarch_ipi.c               | 69 ++++++++++++++++++++-------
 hw/intc/loongson_ipi.c                | 43 ++++++++++++++++-
 hw/intc/loongson_ipi_common.c         | 41 +++++-----------
 hw/loongarch/virt.c                   |  1 -
 include/hw/intc/loongarch_ipi.h       |  1 +
 include/hw/intc/loongson_ipi_common.h |  5 +-
 6 files changed, 109 insertions(+), 51 deletions(-)


base-commit: 9ee90cfc25747ab25c7da31a50f167fc5122e20e
-- 
2.39.3


