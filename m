Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6715606A337
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Yz5ETYsI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZJt-0003YR-1u; Wed, 04 Nov 2026 06:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1xOZJp-0003Wo-Sa
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:38:17 -0500
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1xOZJl-0005CQ-Oh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:38:17 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20261104113804epoutp04831f53662dfb7732045f1ea2c18770b1~k1JQxNIv62602726027epoutp04K
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20261104113804epoutp04831f53662dfb7732045f1ea2c18770b1~k1JQxNIv62602726027epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793792284;
 bh=1wM3zL+uTsyKlFjdgUfPHOt4NIoAKdyW2WiJddhSn+E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yz5ETYsIBTMgELGDWS5D166NIZL7Xq2xhmqlMsmLr9BmIHJiCP9TKeRM+MDfdzSg0
 +9Icm8lxv2X2CnQFwQ8Sbgiabm82nc015aFdYDbv8LWT8clWEqaKehpgQgFDGt+A92
 x1N3VlbCbzjMv+tA60QHYIocXE0TS6kt73HST1bA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20261104113803epcas5p286a75c22603e142bdc74cb66fa4a17a8~k1JQPq0IR1390013900epcas5p2S;
 Wed,  4 Nov 2026 11:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4jKNjR6lKzz6B9m5; Wed,  4 Nov
 2026 11:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20261104113044epcas5p2f8aa4ebe7305b60819571c1a8aefe295~k1C3UXcY22350023500epcas5p2I;
 Wed,  4 Nov 2026 11:30:44 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261104113041epsmtip1e29814f825c506ece958cb88d08f6ee8~k1C0KytrG2364123641epsmtip1c;
 Wed,  4 Nov 2026 11:30:41 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
 junjie.cao@intel.com
Subject: [PATCH qemu v1 7/8] hw/cxl: Wire SVC and Dev3 capabilities to CXL
 Type 3 device
Date: Wed,  4 Nov 2026 17:22:41 +0530
Message-Id: <331418503.141793792283935.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104115242.2035807-1-shrihari.s@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261104113044epcas5p2f8aa4ebe7305b60819571c1a8aefe295
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113044epcas5p2f8aa4ebe7305b60819571c1a8aefe295
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
 <CGME20261104113044epcas5p2f8aa4ebe7305b60819571c1a8aefe295@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=shrihari.s@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the SVC and Dev3 capabilities to the CXL type 3 device to make
it work as a UIO completer. The x-uio option works together with
the x-svc and x-256b-flit options: the device carries the UIO
capability when all three are set, and logs a warning that UIO is
not enabled when x-uio is set without x-svc and x-256b-flit.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 hw/mem/cxl_type3.c          | 29 +++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 778a18ddea..12430c77d2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -17,6 +17,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pcie_dev3.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "qapi/error.h"
@@ -1191,6 +1192,33 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
     pcie_doe_init(pci_dev, &ct3d->doe_comp, 0x1b0, doe_comp_prot, true,
                   CXL_T3_MSIX_PCIE_DOE_COMPLIANCE);
 
+    /*
+     * The HDM decoder UIO capability builds on the SVC and 256-byte
+     * flit mode capabilities in the PCIe config space: the device
+     * carries the UIO capability when it is configured for SVC and
+     * 256-byte flit mode as well.
+     */
+    if (ct3d->uio_comp_capable && (!ct3d->svc || !ct3d->flitmode)) {
+        warn_report("x-uio=on requires x-svc=on and x-256b-flit=on; "
+                    "UIO will not be enabled on this device");
+        ct3d->uio_comp_capable = false;
+    }
+
+    if (ct3d->svc) {
+        /* SVC capability of the type3 device */
+        rc = pcie_svc_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF,
+                               ct3d->flitmode, errp);
+        if ((rc >= 0) && ct3d->uio_comp_capable) {
+            /*
+             * The Dev3 Capability is placed after SVC in the PCIe
+             * config space, and the device is initialized as a UIO
+             * completer.
+             */
+            pcie_dev3_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF + PCI_SVC_SIZEOF,
+                               false, true, errp);
+        }
+    }
+
     /* Set default value for patrol scrub attributes */
     ct3d->patrol_scrub_attrs.scrub_cycle_cap =
                            CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
@@ -1556,6 +1584,7 @@ static const Property ct3_props[] = {
                                 width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
     DEFINE_PROP_BOOL("hdm-db", CXLType3Dev, hdmdb, false),
+    DEFINE_PROP_BOOL("x-svc", CXLType3Dev, svc, false),
     DEFINE_PROP_BOOL("x-uio", CXLType3Dev, uio_comp_capable, false),
     DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
 };
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e8480026c3..a095febf90 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -884,6 +884,7 @@ struct CXLType3Dev {
     PCIExpLinkWidth width;
     bool flitmode;
     bool uio_comp_capable;
+    bool svc;
 
     /* DOE */
     DOECap doe_cdat;
-- 
2.34.1



