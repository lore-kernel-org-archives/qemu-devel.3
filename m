Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09591CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUb9-00080P-J6; Sat, 13 Jun 2026 16:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUb7-0007z9-7F; Sat, 13 Jun 2026 16:04:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUb5-0008CJ-6l; Sat, 13 Jun 2026 16:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381067; bh=6hmJxsuVBwTPTwBAYCDjcaFtNZHOpPhIriJ3TcPkJcw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=u4qgg7IJ+lJYZbfvYOJKmbFpkQCRrOAzTlDiqvQu6TTTkamly2Vd25eegVS7hyRnG
 7lF6pmqhhvsSH1p3ap75HzkE8o50Ec/KeSBdqwRuYtUGa6Lqfnl/e2pwSf/MYS5YHl
 IGYqxhOh+os5gIKrq7rrRo3enjsvU0D0JY80WstVM/b85Ha3fsgbJFixhzyLACIuTa
 tt/K3wiqKRSqYdkUmr+P1ei+zyNVFOsoTTpSb11aAzpTrsMFsHPuS4+PTmoc9FXsPc
 ushb39V/CTYn2wvEXiVWw4lIUYbALQyF0dJ3aMm/QjzuU2Jyz++j14wUtF5rgrittW
 FPnGux5n/g1Bw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F6201B6E6A;
 Sat, 13 Jun 2026 23:04:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6847F3CE8CD;
 Sat, 13 Jun 2026 23:04:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Tomasz Jeznach <tjeznach@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 03/61] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
Date: Sat, 13 Jun 2026 23:02:46 +0300
Message-ID: <20260613200411.1808021-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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

The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
model wasn't checking PTE_N and therefore was using the raw (NAPOT-
encoded) PPN directly in the physical address, yielding an address
32 KB above the correct base.

Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
the Svnapot handling already present in target/riscv/cpu_helper.c:

  napot_bits  = ctz64(ppn) + 1          /* 4 for 64KB */
  napot_mask  = (1 << napot_bits) - 1   /* 0xF */
  phys_base   = PPN_PHYS(ppn & ~napot_mask)
  page_offset = addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))

The spec only defines napot_bits == 4 (64KB); any other value is
treated as a reserved encoding.

This is a fix, rather than new feature support, because the spec
says "IOMMU implementations must support the Svnapot standard
extension for NAPOT Translation Contiguity."

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Message-ID: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit fcbd93e96be2ed0e5139542f54be31efa6d2b1dc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f8656ec04b..cecfd501be 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     return true;
 }
 
+/* Returns the NAPOT page mask, or 0 for reserved encodings. */
+static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
+{
+    int napot_bits = ctz64(ppn) + 1;
+    hwaddr napot_mask, page_mask;
+
+    /* The spec only defines 64KB (napot_bits == 4) */
+    if (napot_bits != 4) {
+        return 0;
+    }
+
+    napot_mask = (1ULL << napot_bits) - 1;
+    page_mask = PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
+
+    *out = PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
+
+    return page_mask;
+}
+
 /*
  * RISCV IOMMU Address Translation Lookup - Page Table Walk
  *
@@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         } else {
             /* Leaf PTE, translation completed. */
             sc[pass].step = sc[pass].levels;
-            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
-            /* Update address mask based on smallest translation granularity */
-            iotlb->addr_mask &= (1ULL << va_skip) - 1;
+
+            if (pte & PTE_N) {
+                hwaddr mask = riscv_iommu_napot_page_mask(ppn, addr, &base);
+
+                if (!mask) {
+                    break;
+                }
+                iotlb->addr_mask &= mask;
+            } else {
+                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+                /* Update address mask based on smallest translation granularity */
+                iotlb->addr_mask &= (1ULL << va_skip) - 1;
+            }
+
             /* Continue with S-Stage translation? */
             if (pass && sc[0].step != sc[0].levels) {
                 pass = S_STAGE;
@@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
             return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
         } else {
             /* Leaf PTE, translation completed. */
-            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            if (pte & PTE_N) {
+                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
+                    return MEMTX_ACCESS_ERROR;
+                }
+            } else {
+                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            }
             break;
         }
 
-- 
2.47.3


