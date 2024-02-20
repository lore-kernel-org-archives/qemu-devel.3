Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496D1C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQsD-00027C-2t; Tue, 20 Feb 2024 09:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcP5d-0008R0-BI; Tue, 20 Feb 2024 07:19:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rcP5Z-0004ME-Mj; Tue, 20 Feb 2024 07:19:13 -0500
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TfJH35gcFz1FL86;
 Tue, 20 Feb 2024 20:14:07 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 7CAE8140118;
 Tue, 20 Feb 2024 20:18:58 +0800 (CST)
Received: from huawei.com (10.67.174.55) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 20:18:57 +0800
To: <peter.maydell@linaro.org>, <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, <wangyanan55@huawei.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <ruanjinjie@huawei.com>
Subject: [RFC PATCH 0/3] target/arm: Implement FEAT_NMI and FEAT_GICv3_NMI
Date: Tue, 20 Feb 2024 12:17:49 +0000
Message-ID: <20240220121752.490665-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=ruanjinjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Feb 2024 09:13:26 -0500
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
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch set implements FEAT_NMI and FEAT_GICv3_NMI for armv8. These
introduce support for a new category of interrupts in the architecture
which we can use to provide NMI like functionality.

There are two modes for using this FEAT_NMI. When PSTATE.ALLINT or
PSTATE.SP & SCTLR_ELx.SCTLR_SPINTMASK is set, any entry to ELx causes all
interrupts including those with superpriority to be masked on entry to ELn
until the mask is explicitly removed by software or hardware. PSTATE.ALLINT
can be managed by software using the new register control ALLINT.ALLINT.
Independent controls are provided for this feature at each EL, usage at EL1
should not disrupt EL2 or EL3.

I have tested it with the following linux patches which try to support
FEAT_NMI in linux kernel:

>-------https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/T/#mb4ba4a2c045bf72c10c2202c1dd1b82d3240dc88

In the test, SGI, PPI and SPI interrupts can all be set to have super priority
to be converted to a hardware NMI interrupt. The SGI is tested with kernel
IPI as NMI framework, and the PPI interrupt is tested with "perf top" command
with hardware NMI enabled, and the PPI interrupt is tested with a custom
test module, in which NMI interrupts can be received and transmitted normally.

Jinjie Ruan (3):
  target/arm: Implement FEAT_NMI to support Non-maskable Interrupt
  target/arm: Add NMI exception and handle PSTATE.ALLINT on taking an
    exception
  hw/intc/arm_gicv3: Implement FEAT_GICv3_NMI feature to support
    FEAT_NMI

 hw/arm/virt.c                      |  2 +
 hw/intc/arm_gicv3.c                | 61 ++++++++++++++++++++++++++----
 hw/intc/arm_gicv3_common.c         |  4 ++
 hw/intc/arm_gicv3_cpuif.c          | 57 ++++++++++++++++++++++++++--
 hw/intc/arm_gicv3_dist.c           | 39 +++++++++++++++++++
 hw/intc/arm_gicv3_redist.c         | 23 +++++++++++
 hw/intc/gicv3_internal.h           |  5 +++
 include/hw/core/cpu.h              |  1 +
 include/hw/intc/arm_gic_common.h   |  1 +
 include/hw/intc/arm_gicv3_common.h |  6 +++
 target/arm/cpu-features.h          |  5 +++
 target/arm/cpu-qom.h               |  1 +
 target/arm/cpu.c                   | 43 ++++++++++++++++++---
 target/arm/cpu.h                   | 12 +++++-
 target/arm/cpu64.c                 | 31 +++++++++++++++
 target/arm/helper.c                | 58 ++++++++++++++++++++++++++++
 target/arm/internals.h             |  4 ++
 target/arm/tcg/a64.decode          |  1 +
 target/arm/tcg/cpu64.c             | 11 ++++++
 target/arm/tcg/helper-a64.c        | 25 ++++++++++++
 target/arm/tcg/helper-a64.h        |  1 +
 target/arm/tcg/translate-a64.c     | 10 +++++
 22 files changed, 383 insertions(+), 18 deletions(-)

-- 
2.34.1


