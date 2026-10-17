Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC68CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9aN-00005C-Ex; Sat, 17 Oct 2026 14:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9aH-0008T1-5P; Sat, 17 Oct 2026 14:56:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9aF-0003e9-EL; Sat, 17 Oct 2026 14:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263372; bh=ITnnyncWib2x191MC0zn0HdualC3ggSRiq0YHZ6cAEg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WnH3R1rf688Ak6Z2qfR0sowhA6/1nxrg22L3F0KvafmXN9cFe9cMvA+KjrXgx+iyX
 JUax8GO8gyCbDRYwCdTl+UhfxuaiZUBEFLstRp4Qe54Tspjkpzvo7aVo/8MDk9q5YE
 mzmy+1PFcrL66oaCBGWl+vOuFhY3leci3geWIEIg3ibvXWr3PdY9k9ieG/KMlFTMua
 Z7KzEVZaDIeMfWUeD2/3x/6zQW18sl/DSfUoyRPP/CU5yJU1P8ZL/zY+V3fpMbrnHX
 AXj0ckjMrgJXhFjf9LEosP2IwtT5bQLPRoGbg6Ynb7/7emB9j3RZe653D1p1z3qfka
 +Pm5T3Cnqfgvw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 131AF1DE6AE;
 Sat, 17 Oct 2026 21:56:12 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 256BF443379;
 Sat, 17 Oct 2026 21:56:11 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 14/63] s390x/pci: Reject apertures beyond IOAT
 capacity in translation mode
Date: Sat, 17 Oct 2026 21:54:30 +0300
Message-ID: <20261017185528.722197-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

In order to support direct mapping (which is only bound by the aperture
size of the underlying host EDMA reported via vfio) QEMU reports the
host-provided EDMA to the guest.  However, when using translation mode
QEMU only supports up to 4 TiB currently (the size of a single RT
table).

Reject attempts by a guest to register a translation aperture that
would exceed what QEMU can support by giving an operand exception on
the MPCIFC instruction that requested the large aperture.  This
restriction can be removed in the future if/when support for additional
IOAT regions is added.

Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929153012.774530-4-mjrosato@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit d818e2b0e6317fe5685ce3671bdb566402ff00e9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 1be3bc0f46..f93c48842e 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1052,6 +1052,21 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
         return -EINVAL;
     }
 
+    /*
+     * We report an EDMA that may exceed what QEMU can handle in support
+     * of direct-mapping.  If the guest attempts to register an IOAT that
+     * is too large, reject it with an informative message.  Only direct
+     * mapping can be used for guests of this size until support is added
+     * to QEMU for additional IOAT regions.
+     */
+    if (t && pal >= ZPCI_TABLE_SIZE_RT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ioat pal 0x%"PRIx64" exceeds max translatable address\n",
+                      pal);
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return -EINVAL;
+    }
+
     iommu->pba = pba;
     iommu->pal = pal;
     iommu->g_iota = g_iota;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 04944d4fed..afe205959f 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -140,6 +140,7 @@ enum ZpciIoatDtype {
 #define ZPCI_PT_BITS            8
 #define ZPCI_ST_SHIFT           (ZPCI_PT_BITS + TARGET_PAGE_BITS)
 #define ZPCI_RT_SHIFT           (ZPCI_ST_SHIFT + ZPCI_TABLE_BITS)
+#define ZPCI_TABLE_SIZE_RT      (1ULL << (ZPCI_RT_SHIFT + ZPCI_TABLE_BITS))
 
 #define ZPCI_RTE_FLAG_MASK      0x3fffULL
 #define ZPCI_RTE_ADDR_MASK      (~ZPCI_RTE_FLAG_MASK)
-- 
2.47.3


