Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC274C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 11:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqUQl-0000sI-M8; Sun, 02 Aug 2026 07:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wqUQd-0000rb-Qm; Sun, 02 Aug 2026 07:32:27 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nendensu@ispras.ru>)
 id 1wqUQb-00070B-Vp; Sun, 02 Aug 2026 07:32:27 -0400
Received: from DESKTOP-J3VFOUN.localdomain (unknown [62.217.189.53])
 by mail.ispras.ru (Postfix) with ESMTPSA id D93C2406C743;
 Sun,  2 Aug 2026 11:32:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D93C2406C743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1785670342;
 bh=3nBDBDXqD+EJ2nTkI6GvI5wX9Ib/awAH1T4ShSJPPe4=;
 h=From:To:Cc:Subject:Date:From;
 b=CZZHXWy7euaFUhc1yA/PDenYpK14D+6dW1LR+BRBra17NE5VcNYsgyrA90AZ3Atkp
 AvkkuOjZMM+iKDcY9t90Vb0eE+GP9k7UMaE3k00j3AiHRoFGf8nB0qtpI2HObsSlC3
 0aV7RMuAnVovRg4MeWXx8aeiWwilmiUk7ms1B7g4=
From: Ivan Efremov <nendensu@ispras.ru>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 farosas@suse.de, lvivier@redhat.com, Ivan Efremov <nendensu@ispras.ru>
Subject: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
Date: Sun,  2 Aug 2026 14:31:27 +0300
Message-ID: <20260802113130.7818-1-nendensu@ispras.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=nendensu@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The seed CSR value on RV64 was sign extended while converting to target_ulong.

The first patch makes SEED_OPST_* unsigned.
The second patch adds qtest to check that upper 32 bits are zero.

Tests ran:
- riscv-csr-test
- make check: 324 passed, 11 skipped
- RISC-V Zkr-00 architectural test

Ivan Efremov (2):
  target/riscv: Fix seed CSR sign extension
  tests/qtest: Add seed CSR zero extension test

 target/riscv/cpu_bits.h      | 10 +++++-----
 tests/qtest/riscv-csr-test.c | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 5 deletions(-)

-- 
2.43.0


