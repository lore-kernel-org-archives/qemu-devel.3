Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3EDC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kMb-0002gv-F4; Wed, 16 Sep 2026 03:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMX-0002R4-Fu; Wed, 16 Sep 2026 03:47:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMV-0005OR-OZ; Wed, 16 Sep 2026 03:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544619; bh=lG5vrb1V1sHxv7qGHlbvZp5ErE/m362kDdv72vKviZQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B7i/KNNzCDTseWe/lDYLQ0oDd/mk4gJ/Y8Rgh113cS0y3iFTxZWHxE3ES8QwgeSPW
 1L+rxyuNXKDo3T3VtD3S8gFWQNmeZ3IDEAfRTach4ljCnpTg85iwEacR9lTyps4QTj
 0hmzyIVqIhn3xziRdcqpnmy5Q4a+5IzAS6fBcRJCuDpl4ae1Xx+ijrTWtlJJyegOG5
 VjdYPJ5cIyWC74t5h/tLlKMgWdweyZ6k+eIoZUnpl9j3L9DMvcrzsJSTEwA9SWmejB
 xLuznRRpsaeE6x0H6y1iix45xEwgy+XzpjsHxLVetNr/tq7gVkiIsVBkY94V6Nkv78
 rGOF9nxXw1tsA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1413C1D55BA;
 Wed, 16 Sep 2026 10:43:39 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9802E429B73;
 Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 55CED5A719; Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 44/49] hw/cxl: fix the CDAT DOE overlapping the Flex
 Bus DVSEC when sn= is set
Date: Wed, 16 Sep 2026 10:43:02 +0300
Message-ID: <20260916074346.671467-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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

From: Junjie Cao <junjie.cao@intel.com>

ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
With sn= the Device Serial Number capability pushes the block to
0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
catches this -- pcie_add_capability() checks bounds, not overlap, and
the chain still walks because the DVSEC's next pointer becomes 0x190,
inside its own body.  Most cxl-type3 examples in
docs/system/devices/cxl.rst set sn=.

Derive the offset from the DVSEC block instead, as cxl_upstream.c
already does.  Without sn= the layout is unchanged byte for byte; with
sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
type 3 device has no VMStateDescription, so its config space never
reaches the migration stream.

Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260831022302.406740-1-junjie.cao@intel.com>
(cherry picked from commit 0ddbce88c45a7376a9fc948097d58195358ffec7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index df2a2fa6345..1606aa32790 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -903,8 +903,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     /* DOE Initialization */
-    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
-                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
+    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
+                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
 
     cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
-- 
2.47.3


