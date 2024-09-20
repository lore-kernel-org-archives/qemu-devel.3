Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FD7CF58F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 09:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srZZx-00072V-Gr; Fri, 20 Sep 2024 05:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1srZZp-0006ek-GI
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1srZZm-0003xO-6s
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 05:05:20 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxSOnEOu1mRe8LAA--.26458S3;
 Fri, 20 Sep 2024 17:05:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn+TDOu1mdmoKAA--.59343S2;
 Fri, 20 Sep 2024 17:05:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 00/10] hw/intc/loongarch_extioi: Split into extioi common and
 extioi
Date: Fri, 20 Sep 2024 17:04:57 +0800
Message-Id: <20240920090507.2692125-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn+TDOu1mdmoKAA--.59343S2
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

In order to support irqchip_in_kenrel method, split loongarch extioi
emulation driver into two parts, extioi common and extioi TCG driver.
LoongArch extioi common driver includes vmstate and property interface,
also vmstate load and store interface is defined in extioi common driver.

In future LoongArch extioi kvm driver can inherit from extioi common
driver.

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
 include/hw/intc/loongarch_extioi_common.h |  99 +++++++++++++++++++
 5 files changed, 259 insertions(+), 149 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_common.c
 create mode 100644 include/hw/intc/loongarch_extioi_common.h


base-commit: 01dc65a3bc262ab1bec8fe89775e9bbfa627becb
-- 
2.39.3


