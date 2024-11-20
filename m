Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0DED6E2CF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7s-00022C-V7; Wed, 20 Nov 2024 02:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tDf7o-00020K-Uk; Wed, 20 Nov 2024 02:27:45 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tDf7m-00080i-E1; Wed, 20 Nov 2024 02:27:44 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 56C98E0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1732087655;
 bh=HrS7WbWkRaqecfl7Oq0nUQ3cMlQuM+a8oImZfQl4DgE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ium+PWFaIH92sI73nXbmPWGcwPgFTbhRzaJAi3sVRJCdsvLNzUcfS5tw1Z7YSSDyl
 7zAIdFEbW9Zb4qeSO7DMor3EWNg/yru3R0X0/qixFkqK32vuDNEBkBpNNtTvbtgTeT
 ci7cXCaYbNGt55wjSBpQPqZzdSyCxqjLNNPMpesSMAG+M/FfOnR7BO55E/u++e61iq
 ts6y55mkoHfis3AsphH3n6fiI4IFCVfBzPvtkhRgfHdFyfv0SvohVD4/UKFKYvxtw9
 UuMKWUgC63baBSAskDt1ZVi1v6D3kDiBebqzqO+HKxvmXIHqZQ37NeW+0tqF/zu0xV
 CAJfhvu0zFcmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1732087655;
 bh=HrS7WbWkRaqecfl7Oq0nUQ3cMlQuM+a8oImZfQl4DgE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QdRVeA+/t0b4ej4F5blY9uPpIGQudyu6ov/CifzlI4hcq9Woj+GEs6sG++JcQFvA5
 bdC9D3AtOBZZXENwJ9Cl5/jDt4OsRj2KQIttmGqp2whIdrIqjrFUrFQmHroIStyR7o
 bLIqMdG6eMiUUwsK7/u6OFkM1BD2va3boRNUS5qWMIro6iCjK/Yg6LfV6VZYg+ElW9
 lcj0KdJwbLqqNsPaIgwjByLIS9lMsCGd0mbAsCOkWF05adZVT9jShVEhF+xm0RtJL3
 av4sTdrZUBRhKpt9NFni+GMpZrSTbjpgbBVjfUD1JOPrpBT+X6IwY84jLO3pJx3WEt
 R9nbyWd9F3Xww==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@suse.de>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v6 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Wed, 20 Nov 2024 10:27:10 +0300
Message-ID: <20241120072712.65302-1-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
v7:
   - Fix build errors, add Reviewed-by, Acked-by.
---

Ivan Klokov (2):
  target/riscv: Add RISC-V CSR qtest support
  tests/qtest: QTest example for RISC-V CSR register

 hw/riscv/riscv_hart.c        | 55 +++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c       | 27 +++++++++++++++++
 tests/qtest/libqtest.h       | 14 +++++++++
 tests/qtest/meson.build      |  2 +-
 tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1


