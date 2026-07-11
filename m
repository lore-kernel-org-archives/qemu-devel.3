Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D4AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifpz-0000fE-Ey; Sat, 11 Jul 2026 18:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpx-0000SY-FC; Sat, 11 Jul 2026 18:06:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpv-0000lb-6I; Sat, 11 Jul 2026 18:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=bFTSxvj/BEC3qyBYYqlDYHhMcfEv9LEOigum8Z0mjow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B7/2Lx8ogJFNOQuNbZAsPvHOsJt08tT7LXjB0bLcSX9iH72US8/sVCMcwinhB/9Ow
 up1OFVjTDB8y8OxYmcHYQZreFgK4DjzHkpIE2TdastMGpcXla3EiGXqAjIohEix7vz
 PLPLYxjqMooBB9RUVKOvu2iz8OxZah9/TM0kaLAWz+ioDO8whlKVL/Dnw7gpPouy1u
 R4B5XX//9yDoHaGQ/Zjga7HVD2CHbbqrCw6l/MllXhcCkcne/RTfNWlTpKM4KNqRap
 1ZKel3oosEGizspekWlfQYsSNkcWzDzNFtSJK/OL/MWomEgUZu43Njj1NvC3MP5Uxi
 WkF0knD9ScR0Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6A481C0AD1;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D8623EAF5C;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E11D51336F; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 70/81] hw/riscv/riscv-iommu.c: fault for non-user PTE
 in G_STAGE
Date: Sun, 12 Jul 2026 00:58:48 +0300
Message-ID: <20260711215904.3757-70-mjt@tls.msk.ru>
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

riscv-iommu spec 1.0 says:

"When checking the U bit in a second-stage PTE, the transaction
 is treated as not requesting supervisor privilege."

We need to *always* fault in case we're on G_STAGE and PTE_U is cleared
since we can't be on supervisor mode at this point.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3555
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260701121111.537654-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 9158c900ab308cbb8a70edcc7358efab7b34730e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 021176e3df8..2b150d0918f 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -485,6 +485,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Access bit not set */
         } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
             break;                /* Dirty bit not set */
+        } else if (pass == G_STAGE && !(pte & PTE_U)) {
+            /*
+             * riscv-iommu spec 1.0: "When checking the U bit in a
+             * second-stage PTE, the transaction is treated as
+             * not requesting supervisor privilege."
+             *
+             * I.e. we need to fault if this is a non-user PTE since
+             * we are always in user mode at this point.
+             */
+            break;
         } else {
             /* Leaf PTE, translation completed. */
             sc[pass].step = sc[pass].levels;
-- 
2.47.3


