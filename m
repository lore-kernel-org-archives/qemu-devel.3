Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E548C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 03:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHEaN-0002us-4N; Tue, 11 Jun 2024 23:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHEaL-0002uX-6y; Tue, 11 Jun 2024 23:23:41 -0400
Received: from 59-120-53-16.hinet-ip.hinet.net ([59.120.53.16]
 helo=mail.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1sHEaJ-0005KB-0q; Tue, 11 Jun 2024 23:23:40 -0400
Received: from atcpcw16.andestech.com (10.0.1.106) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Jun
 2024 11:17:23 +0800
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>, Ethan Chen
 <ethan84@andestech.com>
Subject: [PATCH v7 0/2] Support RISC-V IOPMP
Date: Wed, 12 Jun 2024 11:17:04 +0800
Message-ID: <20240612031706.2927602-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.1.106]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
Received-SPF: pass client-ip=59.120.53.16; envelope-from=ethan84@andestech.com;
 helo=mail.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Due to changing the referenced specification version, this patch has changed
a lot in this version.

This series implements basic functions of IOPMP specification v0.9.1 rapid-k
model.
The specification url:
https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.1

When IOPMP is enabled, memory access from devices will check by IOPMP.

CPU as an IOPMP requestor has not been implemented because the IOTLB does not
support recording sections outside the current CPU address space.

Changes for v7:

  - Change the specification version to v0.9.1
  - Remove the sps extension
  - Remove stall support, transaction information which need requestor device
    support.
  - Remove iopmp_cascade option for virt machine
  - Refine 'addr' range checks switch case (Daniel)


Ethan Chen (2):
  hw/misc/riscv_iopmp: Add RISC-V IOPMP device
  hw/riscv/virt: Add IOPMP support

 docs/system/riscv/virt.rst    |    6 +
 hw/misc/Kconfig               |    3 +
 hw/misc/meson.build           |    1 +
 hw/misc/riscv_iopmp.c         | 1002 +++++++++++++++++++++++++++++++++
 hw/misc/trace-events          |    4 +
 hw/riscv/Kconfig              |    1 +
 hw/riscv/virt.c               |   57 +-
 include/hw/misc/riscv_iopmp.h |  152 +++++
 include/hw/riscv/virt.h       |    5 +-
 9 files changed, 1228 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/riscv_iopmp.c
 create mode 100644 include/hw/misc/riscv_iopmp.h

-- 
2.34.1


