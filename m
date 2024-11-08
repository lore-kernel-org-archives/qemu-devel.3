Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0177AD5E145
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KCV-0001Bx-Aq; Fri, 08 Nov 2024 03:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t9KBM-00005u-3L
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:17:29 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t9KBH-0005gA-0r
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:17:25 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxGeAKyS1nly85AA--.46784S3;
 Fri, 08 Nov 2024 16:17:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxxsAIyS1nea9MAA--.4604S2;
 Fri, 08 Nov 2024 16:17:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] hw/intc/loongarch_extioi: Split into common and
 extioi
Date: Fri,  8 Nov 2024 16:17:02 +0800
Message-Id: <20241108081712.632890-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxxsAIyS1nea9MAA--.4604S2
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

In order to support irqchip_in_kenrel method, split loongarch extioi
emulation driver into two parts, extioi common and extioi TCG driver.
LoongArch extioi common driver includes vmstate and property interface,
also vmstate load and store interface is defined in extioi common driver.

In future LoongArch extioi kvm driver can inherit from extioi common
driver.

---
v1 ... v2:
  1. Remove unused element parent_unrealize in structure
     LoongArchExtIOICommonClass to solve the compile and make check issue
---
Bibo Mao (10):
  include: Add loongarch_extioi_common header file
  include: Move struct LoongArchExtIOI to header file
    loongarch_extioi_common
  include: Rename LoongArchExtIOI with LoongArchExtIOICommonState
  hw/intc/loongarch_extioi: Rename LoongArchExtIOI with
    LoongArchExtIOICommonState
  hw/intc/loongarch_extioi: Add common realize interface
  hw/intc/loongarch_extioi: Add unrealize interface
  hw/intc/loongarch_extioi: Add common file loongarch_extioi_common
  hw/intc/loongarch_extioi: Inherit from loongarch_extioi_common
  hw/intc/loongarch_extioi: Add pre_save interface
  hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi

 hw/intc/loongarch_extioi.c                | 110 +++++++--------------
 hw/intc/loongarch_extioi_common.c         | 113 ++++++++++++++++++++++
 hw/intc/meson.build                       |   2 +-
 include/hw/intc/loongarch_extioi.h        |  84 +++-------------
 include/hw/intc/loongarch_extioi_common.h |  98 +++++++++++++++++++
 5 files changed, 258 insertions(+), 149 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_common.c
 create mode 100644 include/hw/intc/loongarch_extioi_common.h


base-commit: 9eb9350c0e519be97716f6b27f664bd0a3c41a36
-- 
2.39.3


