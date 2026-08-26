Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6A4C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8pk-0003zB-M4; Wed, 26 Aug 2026 04:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8pj-0003yv-OD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:18:07 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8ph-0003B0-Pn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:18:07 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260826081803epoutp03665a0bb1554d4f29bb7d42e99d488cc4~PTQorAMGw2103221032epoutp03m
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260826081803epoutp03665a0bb1554d4f29bb7d42e99d488cc4~PTQorAMGw2103221032epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787732283;
 bh=Vtbd2n0Q60hLv5lgLLEXETA9TtHgTBHeXPmUSvh+e28=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HdBCloQkopl7/XBGsA4RjL3Ypu3339n+453YW8Sge7vJ5FVswSdlO9508Sy7O6My0
 WlD8Ofuh2CU7EoGukt50wXR3M/u1vi/5ZnNyOi7aTR8hYxbHIOIABDIbbctTU2WVSx
 WJ/E6C229p4vBKGJtNVSZoNS8xEflyzqEolhzRFU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260826081802epcas5p456e877443ef3ad49bfacdd58f1c9a738~PTQoOcAWk1534715347epcas5p4W;
 Wed, 26 Aug 2026 08:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4hVHZy4Yr9z3hhT7; Wed, 26 Aug
 2026 08:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260826052054epcas5p465329951e4377c63c450fd60aa2258b3~PQ19z-Mbx3144831448epcas5p4D;
 Wed, 26 Aug 2026 05:20:54 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052052epsmtip237c411953b7b1552d4c6e9367759e0e7~PQ18NKU0g1001010010epsmtip2V;
 Wed, 26 Aug 2026 05:20:52 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 09/10] hw/cxl: Wire SVC and Dev3 capability to CXL Type 3
 device
Date: Wed, 26 Aug 2026 11:04:09 +0530
Message-Id: <1437941060.21787732282637.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052054epcas5p465329951e4377c63c450fd60aa2258b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052054epcas5p465329951e4377c63c450fd60aa2258b3
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <CGME20260826052054epcas5p465329951e4377c63c450fd60aa2258b3@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=shrihari.s@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Adds SVC and Dev3 capability to CXL type 3 device to make
it work as a UIO completer.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/mem/cxl_type3.c          | 15 +++++++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0adf2e8b3e..74ddcf6e58 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1195,6 +1195,20 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
     pcie_doe_init(pci_dev, &ct3d->doe_comp, 0x1b0, doe_comp_prot, true,
                   CXL_T3_MSIX_PCIE_DOE_COMPLIANCE);
 
+    if (ct3d->svc) {
+        /* SVC capability of the type3 device */
+        rc = pcie_svc_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF, errp);
+        if ((rc >= 0) && ct3d->flitmode && ct3d->uio_comp_capable) {
+
+            /*
+             * The Dev3 Capability is initialized  after AER in the PCIe config
+             * space. Also initializing CXL type3 device as a UIO completer.
+             */
+            pcie_dev3_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF + PCI_SVC_SIZEOF,
+                               false, true, errp);
+        }
+    }
+
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
                            CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
@@ -1560,6 +1574,7 @@ static const Property ct3_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
+    DEFINE_PROP_BOOL("x-svc", CXLType3Dev, svc, false),
     DEFINE_PROP_BOOL("x-uio", CXLType3Dev, uio_comp_capable, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3d92d3f46c..5505aefe37 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -885,6 +885,7 @@ struct CXLType3Dev {
     bool flitmode;
     bool uio_comp_capable;
     bool uio_enabled;
+    bool svc;
 
     /* DOE */
     DOECap doe_cdat;
-- 
2.34.1



