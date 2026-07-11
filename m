Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A480DC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnT-0000Ch-7Z; Sat, 11 Jul 2026 18:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifn9-0007hU-S5; Sat, 11 Jul 2026 18:03:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifn7-0000Ap-SV; Sat, 11 Jul 2026 18:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=lMxgmBxPZgkIZe1yfCXgZoMOdYZzlgTKyz3c5LVEjU8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P+xaWJkBOr3sW5by5KGthUugn1rhKkXZw8rrC0B52htN/LpLi+xoyA6Z7JV8Kx3hl
 Gp1dYjpxX+mf7tX5zJitv6bE/CyM5rALoqZj/HkdxWZDqwXHnuyHlJkIvX5iPLk8hi
 nKXXxVma9pQbowjXG6SRPzEjszEvG9eYOxoFqI/0LSB0YdusnjeELelUaO+xHK/g2H
 b7e5Bhxm2wp11RgxGfPwtie9tZS5+dPHgrOwKegA7UvqjHksduFSuZV3mxVhgWnvyV
 Gt9+BXN1bY2SAfbptUmCgumrOzEs9j88Y6FDUyOF2RjJKcjunKQ9GPlk5U1e02YJMy
 W9QdMRkGnqqrw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0982C1C0AB3;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B4E2D3EAF3E;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 96C4913333; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 40/81] s390x/pci: Tighten region detection for BAR
 read/write
Date: Sun, 12 Jul 2026 00:58:18 +0300
Message-ID: <20260711215904.3757-40-mjt@tls.msk.ru>
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

For PCISTG/PCISTB/PCILG instruction emulation, ensure that the offset
and length provided by the guest does not overflow, and only return
a memory region when the specified offset+length combination matches
an existing subregion or the parent region.

Cc: qemu-stable@nongnu.org
Fixes: 4f6482bfe3 ("s390x/pci: search for subregion inside the BARs")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260707070728.147203-3-borntraeger@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 2d709a70c75724e972126671b2e2c0fca0b6e239)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 10066ca6180..ef20f7645eb 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -392,13 +392,22 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
 static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
                                         uint8_t len)
 {
+    uint64_t last = offset + len;
     MemoryRegion *subregion;
     uint64_t subregion_size;
 
+    /*
+     * Ensure the region is valid, the calculated address cannot wrap and that
+     * it falls within this region.
+     */
+    if (!mr || offset > last || last > memory_region_size(mr)) {
+        return NULL;
+    }
+
     QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
         subregion_size = memory_region_size(subregion);
         if ((offset >= subregion->addr) &&
-            (offset + len) <= (subregion->addr + subregion_size)) {
+            (last) <= (subregion->addr + subregion_size)) {
             mr = subregion;
             break;
         }
@@ -413,6 +422,10 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        return MEMTX_ERROR;
+    }
+
     offset -= mr->addr;
     return memory_region_dispatch_read(mr, offset, data,
                                        size_memop(len) | MO_BE,
@@ -513,6 +526,10 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        return MEMTX_ERROR;
+    }
+
     offset -= mr->addr;
     return memory_region_dispatch_write(mr, offset, data,
                                         size_memop(len) | MO_BE,
@@ -900,6 +917,11 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
+    if (!mr) {
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return 0;
+    }
+
     offset -= mr->addr;
 
     for (i = 0; i < len; i += 8) {
-- 
2.47.3


