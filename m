Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFC0CD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw0q-00019C-Kt; Tue, 09 Jun 2026 08:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxh-00065S-3X
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:42 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxf-0005nM-26
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:36 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260609104532epoutp03be4a5391ef98dca100613777b5700a99~3Y9JW-CJg3186931869epoutp03B
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 10:45:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260609104532epoutp03be4a5391ef98dca100613777b5700a99~3Y9JW-CJg3186931869epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1781001932;
 bh=TxxJCe8z8bGsTjg7U0bjaQsQUpIxab4OEeAVJoXOqEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c21GxcQcB0HkvYH2CGAsCgTZtVbUY6ZUnXRjjiicZst8aqSTrjKA7K5KUd10xhBid
 6PKCBHHBz78Lw5gE6Sc/8d0N/u2xSUPlTDjE/FZtd+t9s0fvFPNJTSix4QmWTq/PjE
 P5A0oa4UQqQq37/N31zafumpuvJ8gG0CAH1868wA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260609104532epcas5p33f246da5c968175e92657f238ae430b2~3Y9I9eNzE1373613736epcas5p3r;
 Tue,  9 Jun 2026 10:45:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4gZQY74Hqjz2SSKX; Tue,  9 Jun
 2026 10:45:31 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104530epcas5p153380a0f04ac6db56fe1edbb252bbb22~3Y9HnOdmu0842708427epcas5p1x;
 Tue,  9 Jun 2026 10:45:30 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104529epsmtip1eb3ddf39f5979cf72c95cd4d2505c618~3Y9GAP1LY2381323813epsmtip1Z;
 Tue,  9 Jun 2026 10:45:28 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
 shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
 gost.dev@samsung.com
Subject: [RFC 7/8] hw/pci: hw/cxl: Wire SVC initialization into port realize
 functions.
Date: Tue,  9 Jun 2026 16:28:35 +0530
Message-Id: <20260609105836.3702787-8-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104530epcas5p153380a0f04ac6db56fe1edbb252bbb22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104530epcas5p153380a0f04ac6db56fe1edbb252bbb22
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104530epcas5p153380a0f04ac6db56fe1edbb252bbb22@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=shrihari.s@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jun 2026 08:56:46 -0400
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

Integrate Streamlined Virtual Channel (SVC) capability initialization into the
realize() functions of both PCIe and CXL ports. This change ensures that the
'uio_capable' flag is correctly populated in CXL ports during the initialization
sequence.

'uio_capable' in CXL ports is responsible for enabling UIO capability in
HDM decoder registers.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c     | 1 +
 hw/pci-bridge/cxl_root_port.c      | 5 +++++
 hw/pci-bridge/cxl_upstream.c       | 4 ++++
 hw/pci-bridge/pcie_root_port.c     | 1 +
 hw/pci-bridge/xio3130_downstream.c | 1 +
 hw/pci-bridge/xio3130_upstream.c   | 1 +
 6 files changed, 13 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index e0fa6cfdc4..a9eaeb81bb 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -229,6 +229,7 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &dsp->bar);
+    pcie_config_uio_svc(d, errp);
 
     return;
 
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 4be2b400f9..eafcf59f83 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -164,6 +164,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
 {
     PCIDevice *pci_dev     = PCI_DEVICE(dev);
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(dev);
+    PCIEPort *p            = PCIE_PORT(dev);
     CXLRootPort *crp       = CXL_ROOT_PORT(dev);
     CXLComponentState *cxl_cstate = &crp->cxl_cstate;
     ComponentRegisters *cregs = &cxl_cstate->crb;
@@ -212,6 +213,10 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &crp->bar);
+    rc = pcie_config_uio_svc(pci_dev, errp);
+    if (p->flitmode && rc >= 0) {
+        crp->uio_capable = true;
+    }
 }
 
 static void cxl_rp_reset_hold(Object *obj, ResetType type)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a75d10e7b4..f6f5713437 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -411,6 +411,10 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
         goto err_cap;
     }
 
+    rc = pcie_config_uio_svc(d, errp);
+    if (p->flitmode && rc >= 0) {
+        usp->uio_capable = true;
+    }
     return;
 
 err_cap:
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 20554bd854..5a74b0e978 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -97,6 +97,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
         goto err_int;
     }
 
+    pcie_config_uio_svc(d, errp);
     pcie_cap_arifwd_init(d);
     pcie_cap_deverr_init(d);
     pcie_cap_slot_init(d, s);
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index b0b297bb53..cc19fb1213 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -93,6 +93,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
     if (rc < 0) {
         goto err_msi;
     }
+    pcie_config_uio_svc(d, errp);
     pcie_cap_flr_init(d);
     pcie_cap_deverr_init(d);
     pcie_cap_slot_init(d, s);
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 925df5add3..c28339dabe 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -84,6 +84,7 @@ static void xio3130_upstream_realize(PCIDevice *d, Error **errp)
     if (rc < 0) {
         goto err_msi;
     }
+    pcie_config_uio_svc(d, errp);
     pcie_cap_flr_init(d);
     pcie_cap_deverr_init(d);
 
-- 
2.34.1


