Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FA1C282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqRuE-00009m-0q; Fri, 07 Mar 2025 02:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tqRuA-00007k-FQ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:13:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tqRu6-0004tR-OM
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:13:58 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxvnOrnMpn4lWNAA--.12465S3;
 Fri, 07 Mar 2025 15:13:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzMSqnMpnozE7AA--.21350S2;
 Fri, 07 Mar 2025 15:13:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/intc: Add reset support for LoongArch irqchips
Date: Fri,  7 Mar 2025 15:13:41 +0800
Message-Id: <20250307071346.2260062-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMSqnMpnozE7AA--.21350S2
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

Here add reset support with LoongArch irqchips, including pch pic, ipi
and extioi interrupt controllers. For ipi irqchip, reset interface is
missing. For extioi irqchip, legacy reset callback is replaced with
new API and internal HW/SW states are cleared also. For pch pic irqchip,
legacy reset callback is replaced with new API.

Bibo Mao (5):
  hw/intc/loongarch_ipi: Add reset support
  hw/intc/loongarch_extioi: Add reset support
  hw/intc/loongarch_extioi: Replace legacy reset callback with new api
  hw/intc/loongarch_pch: Add reset support
  hw/intc/loongarch_pch: Replace legacy reset callback with new api

 hw/intc/loongarch_extioi.c                | 12 ++++---
 hw/intc/loongarch_extioi_common.c         | 41 +++++++++++++++++++++++
 hw/intc/loongarch_ipi.c                   | 29 ++++++++++++++++
 hw/intc/loongarch_pch_pic.c               | 26 +++++---------
 hw/intc/loongarch_pic_common.c            | 25 ++++++++++++++
 include/hw/intc/loongarch_extioi.h        |  1 +
 include/hw/intc/loongarch_extioi_common.h |  1 +
 include/hw/intc/loongarch_ipi.h           |  1 +
 include/hw/intc/loongarch_pch_pic.h       |  1 +
 include/hw/intc/loongarch_pic_common.h    |  1 +
 10 files changed, 116 insertions(+), 22 deletions(-)


base-commit: e8a01102936286e012ed0f00bd7f3b7474d415c9
-- 
2.39.3


