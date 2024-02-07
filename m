Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A102C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXeLE-0005Na-0S; Wed, 07 Feb 2024 04:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1rXeLB-0005MT-Ru; Wed, 07 Feb 2024 04:35:37 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1rXeL1-0005Gh-DX; Wed, 07 Feb 2024 04:35:36 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4179Z4lU091824;
 Wed, 7 Feb 2024 17:35:04 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox.andestech.com (10.0.12.22) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Wed, 7 Feb 2024 17:35:04 +0800
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, Ethan Chen <ethan84@andestech.com>
Subject: [PATCH v6 0/3] Support RISC-V IOPMP
Date: Wed, 7 Feb 2024 17:34:41 +0800
Message-ID: <20240207093444.249112-1-ethan84@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.12.22]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4179Z4lU091824
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
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

This series implements IOPMP specification v1.0.0-draft4 rapid-k model and add
IOPMP device to RISC-V virt machine.

Patch 1 add config STREAM make other device can reuse /hw/core/stream.c, IOPMP
implementation will use it. Patch 2 implement IOPMP deivce. Patch 3 add IOPMP
device to RISC-V virt machine.

The IOPMP specification url:
https://github.com/riscv-non-isa/iopmp-spec/blob/main/riscv_iopmp_specification.pdf

Changes for v6:
  - Rebased
  - IOPMP: Fix MDLCK_MD and ENTRYLCK_F did not lock correspond registers
           Fix iopmp_write for ENTRY_ADDRH and ENTRYLCK_L
  - Refine coding style (Daniel Henrique Barboza)

Thanks,
Ethan Chen

Ethan Chen (3):
  hw/core: Add config stream
  Add RISC-V IOPMP support
  hw/riscv/virt: Add IOPMP support

 docs/system/riscv/virt.rst                    |   12 +
 hw/Kconfig                                    |    1 +
 hw/core/Kconfig                               |    3 +
 hw/core/meson.build                           |    2 +-
 hw/misc/Kconfig                               |    4 +
 hw/misc/meson.build                           |    1 +
 hw/misc/riscv_iopmp.c                         | 1202 +++++++++++++++++
 hw/misc/trace-events                          |    4 +
 hw/riscv/Kconfig                              |    1 +
 hw/riscv/virt.c                               |  110 +-
 include/hw/misc/riscv_iopmp.h                 |  187 +++
 .../hw/misc/riscv_iopmp_transaction_info.h    |   28 +
 include/hw/riscv/virt.h                       |    8 +-
 13 files changed, 1559 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/riscv_iopmp.c
 create mode 100644 include/hw/misc/riscv_iopmp.h
 create mode 100644 include/hw/misc/riscv_iopmp_transaction_info.h

-- 
2.34.1


