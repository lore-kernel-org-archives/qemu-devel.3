Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E802C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn61-0001H5-OC; Tue, 25 Aug 2026 05:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn60-0001GP-BA; Tue, 25 Aug 2026 05:05:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn5x-0003gl-M4; Tue, 25 Aug 2026 05:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=gj7E6fWJMqufBZwP5ZePLv79d4udBu3fgamaJk/JhP4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=r4H0nriFb/QDB9Bt/y0TmGGEv/4SMuSPL8UPsBTixfxC8VjP/KWH5FiYcWjp78Le5
 pHu41kpLUGrf8PDFHOlhKWPuoG5cJ7kxYsCz0YBw9qD4C1Ugr2d4Ybb3rncrckFKnp
 /yVHL3M38jyWO2zFw3VlWF2CAcqMPjOBQ4LZ/mZZuCzZwwCFJg++PDBD3cyBlH9q65
 7PVaJaUpMluFKoKm783Dheue5G33IFj9psvKMI7O+FA3B0Gi9U6kT1kCRWNd84Nzz3
 gw7umv5YRegEIi8r6u2wSzNm5lyI5NL9AjFYhjddEzocGjSjUnB8dnyCR7aUWwjBBx
 fCwJ4pkh6YqpA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AED1D1CE3C5;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9B3C8416187;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 04B8232573; Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 187/196] hw/riscv/riscv-iommu: fix U-bit check to
 apply only to leaf S/VS-stage PTEs
Date: Tue, 25 Aug 2026 12:01:44 +0300
Message-ID: <20260825090157.471948-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Commit b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and
no priv access") placed its check ahead of the leaf-vs-non-leaf
branch in riscv_iommu_spa_fetch(), so it fires on every PTE walked,
including non-leaf/table entries. Per the RISC-V privileged spec's
address translation algorithm (Sv39/Sv48/etc., the "leaf PTE has
been reached" step, followed separately by the U-bit permission
check), the U bit is only defined and checked for the leaf PTE
reached at the end of the walk -- non-leaf PTEs don't carry a
meaningful U bit at all.

Move the check after the leaf/non-leaf branch, alongside the other
leaf-only checks, mirroring how the G_STAGE U-bit check (added in
9158c900ab30) is already correctly placed.

Fixes: b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access")
Fixes: ca4a88e4ae1e in 11.0.x
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit f16fd27b3fe3c305d95c61d3516e458c45c6e8c9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c59e5d40e5e..ba77f4ce47e 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -476,13 +476,6 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Invalid PTE */
         } else if (pte & PTE_RESERVED(false)) {
             break;                /* Reserved PTE bits set */
-        } else if (!(pte & PTE_U) && !pv) {
-            /*
-             * All accesses are assumed to be User mode unless
-             * process_id is valid (pv).  In case we have a
-             * non-user mode PTE and !pv we need to fault.
-             */
-            break;
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
@@ -491,6 +484,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
         } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
             break;                /* Misaligned PPN */
+        } else if (!(pte & PTE_U) && !pv) {
+            /*
+             * All accesses are assumed to be User mode unless
+             * process_id is valid (pv).  In case we have a
+             * non-user mode leaf PTE and !pv we need to fault.
+             */
+            break;
         } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
         } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
-- 
2.47.3


