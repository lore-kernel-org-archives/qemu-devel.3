Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAE3E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 12:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQQe3-0001fc-D0; Wed, 25 Dec 2024 07:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tQQe1-0001fC-6I; Wed, 25 Dec 2024 07:37:45 -0500
Received: from m.syntacore.com ([178.249.69.228] helo=pmg.syntacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tQQdz-0002D5-KF; Wed, 25 Dec 2024 07:37:44 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by pmg.syntacore.com (Proxmox) with ESMTP id 35398B41C1D;
 Wed, 25 Dec 2024 15:37:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:message-id:mime-version:reply-to:subject:subject
 :to:to; s=m; bh=5h5SS3dtpMXl/Rc9/gob9tkfcbKneYRjPt757j/XuS4=; b=
 DycA6+0h9/na/S4UUCgbQSvrwGEh8U+OczZADjJPs3a1Nvubz2w4xDPgIG3EGZo2
 8FMjNEmjgFB1QFcBNAzMZyK4hnPHwGqVXYkMjWO2cvl2LUHUtpr+EwSKqrKqe1E8
 s94IfihrkO4Lzka0610BwC69Q8FlM10dDHZjQn/ign/FaCqXtpu5BPG4zpa18le6
 e8MlNsy356UPPrEdF+fsmFRxMf1/fpRxfMl6JRsGAYETHGs19CUSZLIXRrhMevLw
 7T/f/SPx8as8UQi/yS7y0Guiecfg6qksf+dSGn5G8OogsOcG2vos6AoRczVJ7K1/
 XuaNE+D6csh1VrXyLYUyUA==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 by pmg.syntacore.com (Proxmox) with ESMTPS id 20E14B41BB8;
 Wed, 25 Dec 2024 15:37:32 +0300 (MSK)
Received: from VirtualBox.corp.yadro.com (172.22.3.83) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Dec 2024 15:36:38 +0300
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@suse.de>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [PATCH v8 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Wed, 25 Dec 2024 15:37:16 +0300
Message-ID: <20241225123718.45991-1-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.3.83]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=ivan.klokov@syntacore.com; helo=pmg.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These patches add functionality for unit testing RISC-V-specific registers.
The first patch adds a Qtest backend, and the second implements a simple test.

---
v8:
   - Delete RFC label.
v7:
   - Fix build errors, add Reviewed-by, Acked-by.
---

Ivan Klokov (2):
  target/riscv: Add RISC-V CSR qtest support
  tests/qtest: QTest example for RISC-V CSR register

 hw/riscv/riscv_hart.c        | 56 ++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c       | 27 +++++++++++++++++
 tests/qtest/libqtest.h       | 14 +++++++++
 tests/qtest/meson.build      |  2 +-
 tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1



