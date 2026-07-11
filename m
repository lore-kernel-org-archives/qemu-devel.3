Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92822C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifqJ-0001mo-7H; Sat, 11 Jul 2026 18:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifqH-0001a6-E8; Sat, 11 Jul 2026 18:06:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifqF-0000lj-Gy; Sat, 11 Jul 2026 18:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=6zeMMvgmr1LqG7+TAFOiIBHYQoGC1Z+uX80Ucjkuuts=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qbrQlxRhw4JCuwNaFZnnutDD9mz0BfMOrli6sOLaP05CgZQdurWL9J29LW/u3MLbC
 B3j8HRizuWVZ7hys7mahQCu8tZKHJ1O9W8Ga38KmLwNPb7JbiY9cWJiJY8h7kUg3uN
 ifpyk6n3Dn7Fc+/rR9PXyaiZ1EuAsuu+IFgJerwPmRXkRNpChXdYQeXi01KLGKNord
 kRVV/dowAQEEBaNVppmkDXyDa8yZLvbZUdFuHk255mDjv5aBa5rEmjR1F6sAGjwNJ8
 DoxZpvdqPwMg6ZK+WlmOAZC+/cpbgtBJfE/KDU8GKKUd2tPqCzRHbkxpE9Kw92Kb7Z
 wvY4MIBocALFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BE0A41C0AD2;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 740323EAF5D;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E3A3B13371; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 71/81] hw/riscv/riscv-iommu.c: check reserved MSI PTE
 basic bits
Date: Sun, 12 Jul 2026 00:58:49 +0300
Message-ID: <20260711215904.3757-71-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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
index 2b150d0918f..4330b2257d4 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -667,6 +667,27 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
 
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


