Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAA8C48260
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScnT-00030x-8s; Wed, 24 Jan 2024 07:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rScnQ-00030Z-4W; Wed, 24 Jan 2024 07:56:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rScnO-00017y-8w; Wed, 24 Jan 2024 07:55:59 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 24A6161D27;
 Wed, 24 Jan 2024 12:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847BEC433C7;
 Wed, 24 Jan 2024 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706100954;
 bh=sWj3663Jmj8sBFRio7qScRQKO4AK1EQL47ZBiYADI5M=;
 h=From:To:Cc:Subject:Date:From;
 b=ISeJWzsBWj20ECchs0xbmYVxstLgG+Sh3atoRBgRcpxyqQs9W9/T1WLl8kUzcYJAy
 339vxPxzo/J+MbtovSbMQBBB5JXtmiaeA52fV1zkuGsZYnx4+zFIAlAhXHzhMIVuvI
 4h5OKi0joQTcBXYnW5+Evr4N5f8rmiNBdiLb67CR96a+ffDa0s+WFLSYD5aJnnfVE1
 w0AM+0uOW1sqS5o9O4zRAa39FELKJP1NLcKVewEFmBw58mTAV8ACDUZ5eFYuer8T6W
 R0e80YMa76VyyHha1k3rvduvGqpV7JYa6lFuBGBG3A9ls02KtRFi1IkrtE51o2CH2m
 z+dNWXX3AXBVA==
From: Conor Dooley <conor@kernel.org>
To: qemu-riscv@nongnu.org
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] riscv: support new isa extension detection devicetree
 properties
Date: Wed, 24 Jan 2024 12:55:48 +0000
Message-ID: <20240124-squatting-getup-a16a8499ad73@spud>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=conor.dooley@microchip.com; h=from:subject:message-id;
 bh=U9xrLkvP6aWjr4EdzduhntI7SpEyvTJA1TFpNdnDKdI=;
 b=owGbwMvMwCFWscWwfUFT0iXG02pJDKkbOa4k/f8+/ZWwyfGin8/5FdVEd0xxsf/X5HZjIW9/5
 rXVPeGfO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRdysYGb5fk17NpnP17lHn
 Xabv+jV2LTWJT/Bk03zorrpmXtrj9hKG32ynnrPc51Ozf9+X8HFTY5qxoXrtqYsG0znE7TPzz+y
 W4gIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp;
 fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=conor@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Conor Dooley <conor.dooley@microchip.com>

Making it a series to keep the standalone change to riscv_isa_string()
that Drew reported separate.

Changes in v4:
- Other than a rebase, add a helper for the mxl_max to xlen conversion

Changes in v3:
- g_free() isa_extensions too
- use misa_mxl_max rather than the compile target for the base isa
- add a new patch changing riscv_isa_string() to do the same
- drop a null check that cannot be null
- rebased on top of Alistair's next branch

Changes in v2:
- use g_strdup() for multiletter extension string copying
- wrap stuff in #ifndef to prevent breaking the user mode build
- rename riscv_isa_set_props() -> riscv_isa_write_fdt()

CC: Alistair Francis <Alistair.Francis@wdc.com>
CC: Bin Meng <bin.meng@windriver.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Weiwei Li <liwei1518@gmail.com>
CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
CC: qemu-riscv@nongnu.org
CC: qemu-devel@nongnu.org

Conor Dooley (2):
  target/riscv: use misa_mxl_max to populate isa string rather than
    TARGET_LONG_BITS
  target/riscv: support new isa extension detection devicetree
    properties

 hw/riscv/sifive_u.c    |  7 ++---
 hw/riscv/spike.c       |  6 ++--
 hw/riscv/virt.c        |  6 ++--
 target/riscv/cpu.c     | 62 +++++++++++++++++++++++++++++++++++++++++-
 target/riscv/cpu.h     |  2 ++
 target/riscv/gdbstub.c |  2 +-
 6 files changed, 70 insertions(+), 15 deletions(-)

-- 
2.43.0


