Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F1AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 06:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJSaV-00032p-6L; Tue, 18 Jun 2024 02:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sJSaT-00031h-7R; Tue, 18 Jun 2024 02:45:01 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sJSaQ-00082Q-P0; Tue, 18 Jun 2024 02:45:00 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 87F99C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1718693091;
 bh=f8zifHfujh8u5YhQnQNjexWKw5+Xa5bMypS39TeycM8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=TWD8fJ4ZPhe0DbEDg40Co7144jh5tfBhMdna7evM/bQ57MX626K5L4KgeRSUcK0D6
 DdAzMHNvG6NNbXU00syeGC35/Y0IuHLmaQUDr1xlIDXRz+ZHRDfg3J7MpUml6+qHsf
 eFVjFD/yYhGWTdMCsmPgBRmlik8cvzJLKxfIkPIrL5u8NfjZa8YS8u4atzJ7NM13lG
 /K2v7T+YJVPMIajioVIkE7b6dOYJdbHR5QQanL7n/w6DEnexRWs55KbKDctPRtWaI7
 /6cFuVRLDU2Z7H9NDBUgG5daiHWCXyhNJlcb6GurMTVymCfyhyJWCQixWZT17dU+Gg
 qWmvawVXhejUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1718693091;
 bh=f8zifHfujh8u5YhQnQNjexWKw5+Xa5bMypS39TeycM8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=hYwHEH9apNMftUN7ZFRPb7lzoebr99pcofA6IrPImr5gfZXkiTX0evcSM54ObFohb
 0P8V1E25jG2kxGGxEcvIRLHkbtcqrO2tx10wPX4h5YSTKV8T5l5grClpe+5M4U9O+c
 4xTzLsUBmS8N78aMc9bvL/033rLvhwHE2DwaUHRtx6bM4oagzo8JJozsAPk+hf6acr
 TNEwvgBYZwdip9GdGx4BC6qWgnupS0Kyos98qQijNiXyT/Z8PTjHVvVNG5DzahV7Fd
 XkuwzlEFbAPrbLCKgqiynBqxP4lbK7F5BQHJVeKZO1IPnUXnDgeCgg+h7zzuxqop0g
 0yfpBxXbN4wJg==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v2 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Tue, 18 Jun 2024 09:44:41 +0300
Message-ID: <20240618064443.6474-1-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
v2:
   - Refactor unit test, add missed files
---

Ivan Klokov (2):
  Add RISC-V CSR qtest support
  QTest example for RISC-V CSR register

 target/riscv/cpu.c             | 13 +++++++++
 target/riscv/cpu.h             |  3 +++
 target/riscv/csr.c             | 49 +++++++++++++++++++++++++++++++++-
 tests/qtest/libqos/csr.c       | 42 +++++++++++++++++++++++++++++
 tests/qtest/libqos/csr.h       | 16 +++++++++++
 tests/qtest/libqos/meson.build |  3 +++
 tests/qtest/libqtest.c         | 27 +++++++++++++++++++
 tests/qtest/libqtest.h         | 14 ++++++++++
 tests/qtest/meson.build        |  2 ++
 tests/qtest/riscv-csr-test.c   | 47 ++++++++++++++++++++++++++++++++
 10 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/libqos/csr.c
 create mode 100644 tests/qtest/libqos/csr.h
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1


