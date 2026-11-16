Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEA606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=lSuG1U8G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Hb-0005os-7Z; Mon, 16 Nov 2026 15:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HS-0005CW-K0; Mon, 16 Nov 2026 15:26:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HO-0006va-My; Mon, 16 Nov 2026 15:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=5YCk1zYUroWtr7v4ozD9j/SO9KjusdgSQ+AzCyIJAvw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lSuG1U8GNvgA9aAJhdZ/kY6rL+bK40br1zhA1cN9Xe6ztubpJXYBH2+QF5loar0lz
 LSPNdlTkZqSzdXMz3ckPIz1smnm4v0yxWXbPPePMnkyYykL0Pic1km7EBYKHIM3S9l
 rnk49Uw4yRVqF0N6jtNnzXK0+FIcOs6KxNl6PQbRigSF0QIr/wr0R5F9e8mVvZbohu
 QVtm+sGhptZmN25vin6BxhHHvA3GzmQTXiw27cGlaWraIQ/ntTLsv4XOLulRBRBgpi
 Zof3zYkfU1CMXQKvNTkaAlqfaDxo4L4Ks6yIhWWilmCFh2E2ojY1+mAoYUqZ20PqcO
 LvEtwyoEJ7Cfw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B5FB31E719D;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AEBEA45FBC9;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 80012B8E56; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nikhil Kumar Singh <nikhilks@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 08/63] hw/pci-host/pnv_phb4: fix guest-triggerable
 abort on 8-byte config access
Date: Mon, 16 Nov 2026 23:24:47 +0300
Message-ID: <20261116202554.535325-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

A guest-triggerable assertion crash (DoS) exists in pnv_phb4_config_write()
and pnv_phb4_config_read(). When a guest performs an 8-byte access to
PHB_CONFIG_DATA (offset 0x130), QEMU aborts because the switch(size)
statement in the config accessors only handles 1, 2, and 4-byte accesses,
hitting g_assert_not_reached() in the default case.

Since guest input is untrusted, an invalid access size should not crash
the host. Fix this by adding a size > 4 guard in pnv_phb4_reg_write() and
pnv_phb4_reg_read() before the config accessor calls, and by replacing
the g_assert_not_reached() in pnv_phb4_config_write() and
pnv_phb4_config_read() with phb_error() to cover any other callers.
Invalid reads now return ~0ull, maintaining PCI conventions.

Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3591
Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260805090530.1333997-1-nikhilks@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit 0b76df366bfd9f25b0f01d66c96e8e5d81984d01)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 705a5bcf074..02ca2f978c5 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -84,7 +84,9 @@ static void pnv_phb4_config_write(PnvPHB4 *phb, unsigned off,
         val = bswap32(val);
         break;
     default:
-        g_assert_not_reached();
+        phb_error(phb, "invalid config write size %u at offset 0x%x\n",
+                  size, off);
+        return;
     }
     pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
 }
@@ -119,7 +121,9 @@ static uint64_t pnv_phb4_config_read(PnvPHB4 *phb, unsigned off,
     case 4:
         return bswap32(val);
     default:
-        g_assert_not_reached();
+        phb_error(phb, "invalid config read size %u at offset 0x%x\n",
+                  size, off);
+        return ~0ull;
     }
 }
 
@@ -507,6 +511,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 
     /* Special case outbound configuration data */
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb_error(phb, "invalid config write size %u at 0x%"PRIx64"\n",
+                      size, off);
+            return;
+        }
         pnv_phb4_config_write(phb, off & 0x3, size, val);
         return;
     }
@@ -644,6 +653,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb_error(phb, "invalid config read size %u at 0x%"PRIx64"\n",
+                      size, off);
+            return ~0ull;
+        }
         return pnv_phb4_config_read(phb, off & 0x3, size);
     }
 
-- 
2.47.3


