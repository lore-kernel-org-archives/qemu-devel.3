Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E53DCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw0r-0001Bv-Vg; Tue, 09 Jun 2026 08:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxX-0005wu-JM
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:27 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxV-0005WG-Mx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:27 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260609104523epoutp028a751f02dee93c1b77891082d4c33ef0~3Y9AtuqrR2804728047epoutp02h
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 10:45:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260609104523epoutp028a751f02dee93c1b77891082d4c33ef0~3Y9AtuqrR2804728047epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1781001923;
 bh=kMkgTZuJ/C4L91nSM6PkENeTgSP9+Fl1hfo4foCfyvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kzg8/WpO6518c/xezrBVBNN/zjxo6/epyhT23+3oYX7jF8AJSqxCTRkfZO90NbCKD
 AfFoQCrbmJyIpZE6CBRK4OgJMarpEGkQ10Z3jOUJ/K+BbN/WDxQMw0U9M0MOIsvyQ/
 rcabtg0T/woV+zPbFWLo/LeTQS2nP2OXSRIw3aig=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260609104522epcas5p439cb0cb8a4b0ff8ac258f238a87373ac~3Y9AUVs6j2655926559epcas5p4T;
 Tue,  9 Jun 2026 10:45:22 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4gZQXy216Lz6B9m7; Tue,  9 Jun
 2026 10:45:22 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7~3Y8-RXvoE1025210252epcas5p1V;
 Tue,  9 Jun 2026 10:45:21 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104520epsmtip111075b924d06186a6f24d55bfc9e6f84~3Y89s12ed2381023810epsmtip1U;
 Tue,  9 Jun 2026 10:45:20 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
 shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
 gost.dev@samsung.com
Subject: [RFC 4/8] hw/cxl: Add Streamlined Virtual Channel (SVC) property to
 CXL ports
Date: Tue,  9 Jun 2026 16:28:32 +0530
Message-Id: <20260609105836.3702787-5-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=shrihari.s@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jun 2026 08:56:42 -0400
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

Add Unordered IO (UIO) dependent property SVC to CXL ports
(Root, Upstream and Downstream).

The following properties are added to CXL ports:
    - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
    - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)

Note: 256B flit mode property was already added in CXL ports, so reused it.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c            | 2 ++
 hw/pci-bridge/cxl_root_port.c             | 1 +
 hw/pci-bridge/cxl_upstream.c              | 2 ++
 include/hw/pci-bridge/cxl_upstream_port.h | 1 +
 4 files changed, 6 insertions(+)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 7c7a1d1221..6f6f332c07 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -260,6 +260,8 @@ static const Property cxl_dsp_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
+    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
+    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index e82685d1ab..83fb5968b8 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -53,6 +53,7 @@ typedef struct CXLRootPort {
     CPMUState cpmu;
     MemoryRegion cpmu_registers;
     PCIResReserve res_reserve;
+    bool uio_capable;
 } CXLRootPort;
 
 #define TYPE_CXL_ROOT_PORT "cxl-rp"
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index ef5480b116..dadad3e15c 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -437,6 +437,8 @@ static const Property cxl_upstream_props[] = {
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
+    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
+    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
 };
 
 static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index d4186234c8..d23541e23a 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -22,6 +22,7 @@ typedef struct CXLUpstreamPort {
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
     bool flitmode;
+    bool uio_capable;
 
     DOECap doe_cdat;
     uint64_t sn;
-- 
2.34.1


