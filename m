Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1A6C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiliU-0006HO-RK; Sun, 12 Jul 2026 00:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wili6-000610-NU; Sun, 12 Jul 2026 00:22:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wili5-0007Hf-2h; Sun, 12 Jul 2026 00:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=gGkAMl1Z6zPv1Q5fbIBJQaI9b4jZnu2XGQ1emVPJGys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=asd8QqvECHBCkoiV+dg/UUZCDQ/DhQD4SECEmYv9yU7udHSpEOlE7dg+2eOwcB7xB
 4Krq6IC2ezw7DRL2Z9WgKCYlK63bpz9yYNFBOlVXcD2NLcr2IIK3uTxl/LhcQV6NZt
 pTTRSodEDgW/KJGwRAzEsA3Nfdu26MPeLUS+NyprW4tTQ4bUoZyF8rSLJRhZJMd4PR
 srznHmVuRpODBZZ5H1eVsbRE57aYVFuzjy4BNoDZzV4B0b6GUYjfwXaOK3KSqmMHBl
 NT2zeD21b1mo8zODP8Cbc/JSk1SCx8aXGdJ9WkGr6IfsyOFdEJkYyTlKGAwbyBi9mo
 KwTsWHLfgsexA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4B8E61C0C1D;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7F2573EB97D;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B1EA01343D; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 66/75] hw/riscv/riscv-iommu.c: update ioval2 when
 faulting in spa_fetch()
Date: Sun, 12 Jul 2026 07:15:24 +0300
Message-ID: <20260712041539.108341-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv_iommu_translate(), the only caller of riscv_iommu_spa_fetch(),
will use riscv_iommu_report_fault() for all faults it detects.  And it
will use iotlb->translated_addr as 'iotval2' every time.

At this moment we're updating iotlb->translated_addr only after a
translation step is completed, meaning any fault that occur before that
will have a zeroed iotlb->translated_addr, and as a result iotval2 will
also be zero later on.

Keep iotlb->translated_addr updated with the latest translated addr we
have.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3559
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260702171202.1322493-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 79616dd6e499c4eed0af534872f3ff0e3c133c04)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b8120efc5ab..9dd2cb3715b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -553,6 +553,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     } while (1);
 
+    /*
+     * riscv_iommu_translate() will receive a fault and then call
+     * riscv_iommu_report_fault() using iotlb->translated_addr
+     * as iotval2.  Update translated_addr it with the latest
+     * translated addr we have.
+     */
+    iotlb->translated_addr = addr;
+
     return (iotlb->perm & IOMMU_WO) ?
                 (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
                         RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
-- 
2.47.3


