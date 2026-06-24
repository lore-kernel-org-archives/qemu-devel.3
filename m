Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33CACDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNtM-0006B2-Rt; Wed, 24 Jun 2026 09:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNtK-00061L-L0; Wed, 24 Jun 2026 09:43:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNtI-00025H-RX; Wed, 24 Jun 2026 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308007; bh=oSBt1no7uW7UsqIIUgO+H9H6J1W2PuuatD0PtVI1C58=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K7e086MafkcD3IWb+kLr5CG8Whxa+L3F2l/ABKr9v8VH8hCG0haH8TOPD/RGpzzVO
 JBYycDG9AsWQZjuercAehmU3npEFJ6Oj+vojSCgcG2j36j/8vrJ9lhXza5h14kLAza
 8Ze6gM+8azFCO9E8Jv+N3rVnUz771tMgBEijs5FnqIiHFpkEXVmmGfSH9Vwk2mjvcH
 KeEQW54+ZeSb56hW4UxUx61r0M2qFTsROUOavA7CRB7qons7BqPCl2z3f+r187ytXc
 +ThgDFx2TFFrOHKJHUnqkAGszmVbH3sZEFAzAEuDjnKsyWcUcUIpnzGkplOfnF4xeW
 ZXb0NT5IpiXdg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 709FA1BAA1B;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0AD593DEA6A;
 Wed, 24 Jun 2026 16:33:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>,
 Zexiang Zhang <chan9yan9@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 105/107] ppc/pnv_phb3: Error out on invalid config
 access
Date: Wed, 24 Jun 2026 16:31:50 +0300
Message-ID: <20260624133301.403266-105-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Aditya Gupta <adityag@linux.ibm.com>

PHB in Power8 supports 8 byte registers, and hence the ops structure
allows accessing of 8 bytes in 'pnv_phb3_reg_ops'

Both 'pnv_phb3_reg_read' & 'pnv_phb3_reg_write' pass the arguments as is
to 'pnv_phb3_config_{read,write}', if offset is PHB_CONFIG_DATA.

This when called with size as 8, causes following assert failure in
'pci_host_config_read_common' & 'pci_host_config_write_common':

    assert(len <= 4);

Validate that size is <=4, before jumping to pci_host_config_{read,write}_common

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3334
Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
Fixes: 9ae1329ee2fe ("ppc/pnv: Add models for POWER8 PHB3 PCIe Host bridge")
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260326190438.734239-2-adityag@linux.ibm.com>
(cherry picked from commit 218109781209f9d77242b2cdf743acac8bc3b893)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index d6ab515337..4ffdb4ce31 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -475,6 +475,11 @@ void pnv_phb3_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size)
 
     /* Special case configuration data */
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
+                      off, size);
+            return;
+        }
         pnv_phb3_config_write(phb, off & 0x3, size, val);
         return;
     }
@@ -597,6 +602,11 @@ uint64_t pnv_phb3_reg_read(void *opaque, hwaddr off, unsigned size)
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
+        if (size > 4) {
+            phb3_error(phb, "Invalid config access, offset: 0x%"PRIx64" size: %d",
+                      off, size);
+            return ~0ull;
+        }
         return pnv_phb3_config_read(phb, off & 0x3, size);
     }
 
-- 
2.47.3


