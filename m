Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B375AC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvDc-0008J4-Gt; Wed, 03 Jul 2024 04:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sOvDb-0008Ii-Cz; Wed, 03 Jul 2024 04:19:59 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sOvDV-0001Xe-Tx; Wed, 03 Jul 2024 04:19:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com B03A6C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1719994787;
 bh=9LATfpfQH0xegHF6pdgkY3cHmRMwVxUDQ65gzLu8DDY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=JEMekhkG/rA0WGDUr91QSFEiebHSPWasIt/zMME8XyeRDjeDZx8HMrYEiGNrWwMZM
 EiwBd1n2+AeuM99HxUSJy+eBDNIhobDpE7XEE1tGlQa9FxL8uUa0SE80GSOx10xVtQ
 v4+sei1nsl8riVRfI3HjAaVMAmc6lLurPHMENE+X1lJVjXoVEz6Om+DP4B58ZnyL3x
 Nw8XkQbJULpPJoY6HBrSwXkUvmG06v3Zs1u4XrX78UiqU04kweGSBMed+xJQ0iqFjg
 HZhhMW8TdLlsgFLMVlZjueQOmYMQrhScBikOquTQ7lFQOdOSB4lB4IzXfQ8NU08rcv
 Ex0N4EGbn1B/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1719994787;
 bh=9LATfpfQH0xegHF6pdgkY3cHmRMwVxUDQ65gzLu8DDY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QZ7NSmenaFGeVgiul6DCPWXhYB0HkBIZpQAjFEGEXO69dpTB7zInA2Njd7JPXk/F+
 +1Fd1sU5G9CVy8kP8VzVaKQs1Ovpr1mBKwuXdEHVAnlxswQM8kOhvAj18ZVjfSn7gl
 zPHwtLu04xf7IOnuitoTUyKT/y7c5HhqIhCCTgpRVN0B7Znjj6cAkno/SVCs+0riZc
 pSrmLdyB5AzkMvSBkz8gQhQZqiqzyJeZ17bkRkkRCGAKu0RLgwNju6ikLY6OSvPxtK
 ePjwNnCod0BLGxLJx4PwJLv80oI5dlq0uKycIw7CFMut4ZGHLtnoV/EJZdbD9GWzUM
 q6ImvGBi0Ac8Q==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v4 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Wed, 3 Jul 2024 11:19:37 +0300
Message-ID: <20240703081939.498641-1-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
v4:
   - Change wrapper to direct call
---

Ivan Klokov (2):
  target/riscv: Add RISC-V CSR qtest support
  tests/qtest: QTest example for RISC-V CSR register

 target/riscv/cpu.c           | 17 +++++++
 target/riscv/cpu.h           |  3 ++
 target/riscv/csr.c           | 53 +++++++++++++++++++++-
 tests/qtest/libqtest.c       | 27 +++++++++++
 tests/qtest/libqtest.h       | 14 ++++++
 tests/qtest/meson.build      |  2 +
 tests/qtest/riscv-csr-test.c | 86 ++++++++++++++++++++++++++++++++++++
 7 files changed, 201 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1


