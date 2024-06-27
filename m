Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E0BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoHa-0001Wj-0f; Thu, 27 Jun 2024 08:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sMoHW-0001Vx-Fq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:31:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sMoHS-0004VF-7H
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:31:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx7eqMW31meaYKAA--.43236S3;
 Thu, 27 Jun 2024 20:31:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx78eLW31mKjwzAA--.55672S2; 
 Thu, 27 Jun 2024 20:31:07 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jiaxun.yang@flygoat.com, maobibo@loongson.cn,
 chenhuacai@kernel.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com
Subject: [RESEND PATCH 0/2] hw/intc: Restore loongarch_ipi for LoongArch
Date: Thu, 27 Jun 2024 20:13:46 +0800
Message-Id: <20240627121348.3412568-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx78eLW31mKjwzAA--.55672S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

Currently LoongArch and MIPS architectures share loongson_ipi,
and modifications to loongson_ipi by the MIPS architecture may
lead to some unknown problems in the LoongArch architecture.
In order to minimize the impact of this inter-architectural
interaction, we believe that it is necessary to restore loongarch_ipi.

Song Gao (2):
  Revert "hw/intc: Remove loongarch_ipi.c"
  hw/intc: Restore loongarch_ipi for LoongArch

 MAINTAINERS                     |   2 -
 include/hw/intc/loongarch_ipi.h |  54 +++++
 include/hw/loongarch/virt.h     |   2 +-
 hw/intc/loongarch_ipi.c         | 347 ++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c             |   4 +-
 hw/intc/Kconfig                 |   3 +
 hw/intc/meson.build             |   1 +
 hw/intc/trace-events            |   3 +
 hw/loongarch/Kconfig            |   2 +-
 9 files changed, 412 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/intc/loongarch_ipi.h
 create mode 100644 hw/intc/loongarch_ipi.c

-- 
2.34.1


