Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637A4C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhBq-0001Tk-3j; Thu, 13 Jun 2024 05:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sHhBo-0001Qg-5z; Thu, 13 Jun 2024 05:56:16 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sHhBm-0003AB-8j; Thu, 13 Jun 2024 05:56:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 8AF38C000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1718272569;
 bh=VwcNLD6groCCHJQ/lPenwhAy7Jffh+jeFQdqK1UBB+A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=L2r38FwkF0gEo+s1QrFlWiWaFVcrla+HH5AhcN8KX3RdAFGDXBqBmKKfhpe2Om511
 pLshnvu8WENQYIQQBzQNC64aALFK2REiOirs5S9DRuaaAqpEeQrkXhLg7NV5xiBnUb
 DhFTT6qN2X2gxLphJs4yD6+VoKacov+ceWjC6WC1Y/wtGKisOkUkW+snX5rhkYjElk
 0dYM+6IoLf5eDuY6VphB24XD+Bvluo+QMdv9R7d4NE+FdielQl8O3vWptsr9fxhEDw
 vuIZ8SDfbug8X2K/grAr5OeA42L2BG2dQhUGnI8RAIQwEHkKZJiO5DMN31nlMM49Iv
 KgaHUbxfv+XOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1718272569;
 bh=VwcNLD6groCCHJQ/lPenwhAy7Jffh+jeFQdqK1UBB+A=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=m76VQfbKvFUtLFRkroMvChgy6vgxMdzMg7Q2C7PJnbJTO8PkZF8u2mjCroLzeVxxp
 LMkbqypisjSHOqF1w8dO/410zs0vT2KLRpm2x3xjEscfq9TppphhXU1Rb5S4qrCjrw
 aGGjY+vF0XRQTlr7ScpEQ4X5fjlQt1Dttpo1OKHhnpODwd1ASRhwAMJiv9h+hH0s/n
 7vts4QrDf0HENHynlu4+ihRbXFHAjOJhEeNHtRItFAEAhgYhgrpMsoiDzGpzkX9a8y
 uYRbgZEjOtUQcXh5C8siMZBsVph9eUgBZr+FxJ42cccae6h6clC+WtGuyermE3kJbn
 2nzESIqadtCgw==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH 0/2] Support RISC-V CSR read/write in Qtest environment
Date: Thu, 13 Jun 2024 12:55:59 +0300
Message-ID: <20240613095601.16299-1-ivan.klokov@syntacore.com>
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

Ivan Klokov (2):
  Add RISC-V CSR qtest support
  QTest example for RISC-V CSR register

 target/riscv/cpu.c             | 13 +++++++
 target/riscv/cpu.h             |  3 ++
 target/riscv/csr.c             | 49 +++++++++++++++++++++++-
 tests/qtest/libqos/meson.build |  3 ++
 tests/qtest/libqtest.c         | 27 ++++++++++++++
 tests/qtest/libqtest.h         | 14 +++++++
 tests/qtest/meson.build        |  2 +
 tests/qtest/riscv-csr-test.c   | 68 ++++++++++++++++++++++++++++++++++
 8 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

-- 
2.34.1


