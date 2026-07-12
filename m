Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525C3C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiliQ-0006EV-CC; Sun, 12 Jul 2026 00:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wili2-0005zi-SP; Sun, 12 Jul 2026 00:22:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilhy-0007FW-8W; Sun, 12 Jul 2026 00:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829782; bh=oHZsVuUaD+VJpQ0q2utAt7WKxN8bxXBK+Damo+PTnpI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aEOD/zi29UhnmZCX/7eWAqh1vyTyn3PDZ/Mf++Wx/tJis6BdJmslWq2/KVb5Ym6kc
 uRsi167r2mVEA4ZdpBGr+v5uPe0qS4agl1+T73oKrRG50Ri2jiiDBOzYAm0++YcWDk
 ZpJV+I/dyTWSLPMV9JsoXtmiqufm1azGxDTMAMo/Scs7hQUQsTciZW+zBvXB9yFB6w
 1NIPYAQXDq0/cpn1IQcCh1i7ergRGmbKbsTMAWtmrGtASGqpEszlwgW4Y9APBkjQKU
 24fZGt+Ub1txhyD2JHnfh3bJ79pBL4IFL017lVI+ZZTYInbcwB6zlYvQLq0UDz09YH
 q6Ob0ZW60C3Lg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C2AA1C0C1A;
 Sun, 12 Jul 2026 07:16:22 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6E3793EB97A;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AA67C13437; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 63/75] hw/riscv/riscv-iommu.c: check reserved MSI PTE
 basic bits
Date: Sun, 12 Jul 2026 07:15:21 +0300
Message-ID: <20260712041539.108341-63-mjt@tls.msk.ru>
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

We need to throw an MSI_MISCONFIGURED error when any of the reserved PTE
bits (first doubleword only) are set.

Fixes: Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3563
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260629125719.679626-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 11486349ad9b8858d3f45a540fd48b7a15b2b61d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 3e357c0b39c..8055c6d707d 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -656,6 +656,27 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
     switch (get_field(pte[0], RISCV_IOMMU_MSI_PTE_M)) {
     case RISCV_IOMMU_MSI_PTE_M_BASIC:
+        /*
+         * riscv-iommu spec MSI PTE basic translate mode:
+         * "When an MSI PTE has fields V = 1, C = 0, and M = 3
+         *  (basic translate mode), the PTE's complete format is:
+         *  First doubleword:  bit 63      C, = 0
+         *                     bits 53:10  PPN
+         *                     bits 2:1    M, = 3
+         *                     bit 0       V, = 1
+         *  All other bits of the first doubleword are reserved
+         *  and must be set to zeros by software.  The second
+         *  doubleword is ignored by an IOMMU so is free for
+         *  software to use."
+         *
+         * In other words, bits 62:54 and 9:3 of pte[0] are reserved.
+         */
+        if (pte[0] & (GENMASK_ULL(62, 54) | GENMASK_ULL(9, 3))) {
+            res = MEMTX_DECODE_ERROR;
+            cause = RISCV_IOMMU_FQ_CAUSE_MSI_MISCONFIGURED;
+            goto err;
+        }
+
         /* MSI Pass-through mode */
         addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
 
-- 
2.47.3


