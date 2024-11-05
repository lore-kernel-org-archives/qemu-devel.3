Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA664D2B92E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KYQ-0002Ds-Tj; Tue, 05 Nov 2024 09:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1t8KYP-0002Cn-C3; Tue, 05 Nov 2024 09:29:09 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1t8KYN-0005gt-1v; Tue, 05 Nov 2024 09:29:09 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 893C4E0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1730816940;
 bh=zJ6hEnRimXrs6YKU6j4iTGPdFCy0Gv1EcNFRgo6eeCU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=j8XXFDH5ntI0Z3D6DzTRPYVDifjsVCnUNdU69zMgU5j5xBKR75hgcfNixRyurA0nD
 w1H5q5fJyyIL5YXG6CktD+eK1eje9Ck+lhTJWFfipPIj2wgZPFuzHsCHkNlB56p6nz
 rGW8Th6/f6YueP96fN781EVk4Z27iJfNc4naWhXYrJwSqc/a2Z98uSWgzE1ZSGIKnB
 8fROirqvgCpMi7uvyAJQB1gHBAQNYDEFUNPx7etC3MiyE2F+iB76+nSyH0fLa9jMhh
 JOcf/eehaNGt1HkTW8ti4XkqUmGSe6uaRGF/KWa7uLZKKw8to5rVZ72SsMZgyQIrSp
 GPsqSvTw+2ZrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1730816940;
 bh=zJ6hEnRimXrs6YKU6j4iTGPdFCy0Gv1EcNFRgo6eeCU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LrvPyTiiFCG+2COhrid7AYEUTvkgYOVaKaNleameQRKk6I++UEUs5094U4pOLEUWZ
 K8SkyK3bjnD2V44Zn1EufJ1/LEUCPQ11OGewY+gAl6xiIYyIxRgjyYCCWptYwuBMZU
 Ou3sgIpzYPHYQ7qpX4twhF16WuXbinvtupQ5x9C49mQw58dCUXmFdA5fYcZnJNl5nN
 0pT3/PCohBN2v/1ejlEoHTYtE3GSSAzX/sq1P7sh1Kr0KY9q+eof42buH2GCHhhNog
 CB1c2klsh9EoJkhCkTAzynPkK4oY7XBsixZydLaQ5xJ3uar2g0h7DnOpv40qcSIqIv
 dkvEjdy+GIPGQ==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v5 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Tue, 5 Nov 2024 17:28:38 +0300
Message-ID: <20241105142840.59617-1-ivan.klokov@syntacore.com>
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
v5:
   - Move code from target/riscv to hw/riscv
---

Ivan Klokov (2):
  target/riscv: Add RISC-V CSR qtest support
  tests/qtest: QTest example for RISC-V CSR register

 hw/riscv/riscv_hart.c        | 65 ++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c       | 27 +++++++++++++++
 tests/qtest/libqtest.h       | 14 ++++++++
 tests/qtest/meson.build      |  2 +-
 tests/qtest/riscv-csr-test.c | 56 +++++++++++++++++++++++++++++++
 5 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1


