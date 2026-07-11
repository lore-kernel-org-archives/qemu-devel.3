Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3049C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifps-0008PC-HR; Sat, 11 Jul 2026 18:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpq-0008Dd-M0; Sat, 11 Jul 2026 18:06:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifpo-0000hx-Km; Sat, 11 Jul 2026 18:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=B7KsRGNyVEEYDlbiHI4fiED6oJQOw9Errnr9ooRgBG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B70TzBkR2R80Xrl310rZ57fbsJPgoLn0pAuCzG5a6G/kAV+xzL2ypBZ02qWwLPYRP
 ZCrX3EQ5YrbEtbsjPJAGB8p+eM4AWt6prgdacmfEyjtCXeyeVix/A7zwHTVVHPJwlK
 we1xr2C4QYrVc07TDL1X+IS3094FZirwf6MTgzH8UBsVMLbg0mJ2Fh4Hw1BTTjzGiS
 S06gGS0E+69UjukRgh6Ujna3IU3iTblHkizAfz7U0D0ff0sdEK/D7VjoXM+lbEUJhS
 pGR4o66Okvrc4U9aGedcwhX3sT1OLsxpNRlcjrFqR0YdIg319JaWXObZKVe52p44yX
 z5689m/20QwzQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A27A31C0ACE;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 596943EAF59;
 Sun, 12 Jul 2026 00:59:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D969213369; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 67/81] hw/riscv/riscv-iommu.c: fix fault type for
 spa_fetch() faults
Date: Sun, 12 Jul 2026 00:58:45 +0300
Message-ID: <20260711215904.3757-67-mjt@tls.msk.ru>
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

Under certain circunstances, like the one described in [1] and [2],
a read operation that faults will be logged as a write fault instead,
and vice-versa, if they happen after the translation phase in
riscv_iommu_spa_fetch().

The first problem is that we're overwriting iotlb->perm with PTE flags,
so an IOMMU_RO access flag can be overwritten by whatever flags
the PTE has.  This will cause the wrong fault type to be thrown at
the end of the function in case a fault happens.

To solve the iotlb->perm overwrite we'll bit_and the original
iotlb->perm access flags with the PTE access flags, preserving the
original access type.  So a IOMMU_RO access in a R+W PTE will result in
a IOMMU_RO perm.

Second, the resulting fault is received by riscv_iommu_translate(), which
will then report the fault.  To do that we require a transaction type
(ttype).  We're prioritizing checking "perm & IOMMU_RW" to set a
UADDR_WR ttype, and then checking "perm & IOMMU_RO" to set UADDR_RD
ttype.  The issue with that is IOMMU_RO=1 and IOMMU_RW=3, thus checking
"perm & IOMMU_RW" for a write then "perm & IOMMU_RO" for a read will
cause the read fault to always be diagnosed as write.

Make the iotlb->perm matches more strict: "perm & IOMMU_RW" must be
exactly IOMMU_RW, ensuring that 'perm' has both flags.  Then we can
check perm & IOMMU_WO and perm & IOMMU_RO without worrying about
overlapping with the RW flag.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3557
[2] https://gitlab.com/qemu-project/qemu/-/work_items/3577

Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3557
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3577
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260701124034.552271-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit b18e3f0e2d0f301952ff3ae4cb73d0e9eb4ee697)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b2e2ee486e9..b16a53294dd 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -272,6 +272,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
+    IOMMUAccessFlags pte_perm;
     dma_addr_t addr, base;
     uint64_t satp, gatp, pte;
     bool en_s, en_g;
@@ -499,8 +500,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             }
             /* Translation phase completed (GPA or SPA) */
             iotlb->translated_addr = base;
-            iotlb->perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
-                                                         : IOMMU_RO;
+
+            /*
+             * Do a bit_and between the PTE bits and the original
+             * request flags to determine the exact permission we
+             * need, i.e. if the original request is RO and the
+             * PTE has RW flags the actual perm is RO.
+             */
+            pte_perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
+                                     : IOMMU_RO;
+            iotlb->perm &= pte_perm;
 
             /* Check MSI GPA address match */
             if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
@@ -1682,7 +1691,8 @@ done:
     if (fault) {
         unsigned ttype = RISCV_IOMMU_FQ_TTYPE_PCIE_ATS_REQ;
 
-        if (iotlb->perm & IOMMU_RW) {
+        if ((iotlb->perm & IOMMU_RW) == IOMMU_RW
+            || iotlb->perm & IOMMU_WO) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_WR;
         } else if (iotlb->perm & IOMMU_RO) {
             ttype = RISCV_IOMMU_FQ_TTYPE_UADDR_RD;
-- 
2.47.3


