Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9907BCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB1u-0007Y1-EJ; Sat, 17 Oct 2026 16:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0e-0005uV-OB; Sat, 17 Oct 2026 16:28:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0c-0003wD-W6; Sat, 17 Oct 2026 16:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268837; bh=nH0CvQP+rDYWKCBng+koUebVNeteBTGd0leESiXIIR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oTRXbnCVymAupLOiK/Z8C/5jgS9aATxDD/qMehOHv4hpKkhBbSigjceZbWFMkJryl
 uZHul2+TwM0QdPOrLmtiKFyoJ9ir+Ov8FtRJR7YsgtCoSkGgPDTWwS5FJwaTCoizyN
 K5xIPk0RDeXShaxpA3MHtAUeb5IlnpteO9FLt3aLpmzoBp4AL1u+ejaQ057u22y6vs
 KFG4t2EqRVuPeLpkGYp5/0I2WppmMCrZIKAMVIAUQ87SKHeKZBxt9YrulMwEB1F6iG
 MBkjYQdjBhAB/BD55DM4KzA8IzrvzOsAWibKaTY35/wbJWZ9nOUgPZvIl+tD0yMPFg
 nODk856ajLQYw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DCB541DE749;
 Sat, 17 Oct 2026 23:27:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D62F0443420;
 Sat, 17 Oct 2026 23:27:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 14/73] s390x/pci: Reject apertures beyond IOAT
 capacity in translation mode
Date: Sat, 17 Oct 2026 23:25:32 +0300
Message-ID: <20261017202638.728621-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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
index 73417edade..09026360d4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1054,6 +1054,21 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
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
index 9228523ce8..f182bab246 100644
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


