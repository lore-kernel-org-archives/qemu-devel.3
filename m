Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACB7CD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw0y-0001EE-Bf; Tue, 09 Jun 2026 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxN-0005vH-Db
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxK-00051t-Hs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:17 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260609104506epoutp02ba8931195556d140ab201886f9c73658~3Y8wlCJ2N2804728047epoutp02X
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 10:45:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260609104506epoutp02ba8931195556d140ab201886f9c73658~3Y8wlCJ2N2804728047epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1781001906;
 bh=TVQhRc8dDekoMA1OaYDeOudEU0aw2a7ljZsV7Lahev0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q8rynW1K25DYDtd5HTDNkCDh6nEAdnvYnmY4Rj54EwGJlc77aeERtFctxPOooW8sD
 3s/ENHjsZUhWTVkB/uCPpkVxSGKu61pseun1ktgc/w4aSHfQIdhZ0TYv9S9j4200Le
 YAPvbmGSi0P++CxbJRblmmdAFyBHzQIWO5MULDZA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260609104504epcas5p1308772014546eb7371d7b142a4326203~3Y8vhycwn0554305543epcas5p16;
 Tue,  9 Jun 2026 10:45:04 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4gZQXc241xz6B9m6; Tue,  9 Jun
 2026 10:45:04 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb~3Y8uSH2Fc0554305543epcas5p1k;
 Tue,  9 Jun 2026 10:45:03 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104501epsmtip12bdcceb0bf7d0b7fce7b04526feba867~3Y8sscY8B2355923559epsmtip1G;
 Tue,  9 Jun 2026 10:45:01 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
 shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
 gost.dev@samsung.com
Subject: [RFC 1/8] hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
Date: Tue,  9 Jun 2026 16:28:29 +0530
Message-Id: <20260609105836.3702787-2-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb@epcas5p1.samsung.com>
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
X-Mailman-Approved-At: Tue, 09 Jun 2026 08:56:29 -0400
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

Move the 'flitmode' property from PCIESlot to PCIEPort. This change
allows all the derived ports (PCIe ports or CXL ports) to use this
property.

This is a structural refactor only. There is no functional change in
existing behavior.

Note: This property was added from Davidlohr's BI patch series[1].

[1]: https://lore.kernel.org/all/20251103195209.1319917-2-dave@stgolabs.net/

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_downstream.c | 6 +++---
 hw/pci-bridge/cxl_root_port.c  | 6 +++---
 hw/pci/pcie.c                  | 2 +-
 include/hw/pci/pcie_port.h     | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index d1e27994a3..7c7a1d1221 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -118,7 +118,7 @@ static void cxl_dsp_reset(DeviceState *qdev)
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
-    PCIESlot *s = PCIE_SLOT(d);
+    PCIEPort *p = PCIE_PORT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -132,7 +132,7 @@ static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x27, /* Cache, IO, Mem, non-MLD */
         .ctrl                    = 0x02, /* IO always enabled */
-        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
+        .status                  = p->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
     };
     cxl_component_create_dvsec(cxl, CXL2_DOWNSTREAM_PORT,
@@ -259,7 +259,7 @@ static const Property cxl_dsp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_16),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 0ee18ef5c3..df69c5200f 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -112,7 +112,7 @@ static void latch_registers(CXLRootPort *crp)
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
 {
-    PCIESlot *s = PCIE_SLOT(d);
+    PCIEPort *p = PCIE_PORT(d);
     CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
     int i;
@@ -135,7 +135,7 @@ static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
     dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
         .cap                     = 0x26, /* IO, Mem, non-MLD */
         .ctrl                    = 0x2,
-        .status                  = s->flitmode ? 0x6 : 0x26, /* lack of 68B */
+        .status                  = p->flitmode ? 0x6 : 0x26, /* lack of 68B */
         .rcvd_mod_ts_data_phase1 = 0xef,
     };
     cxl_component_create_dvsec(cxl, CXL2_ROOT_PORT,
@@ -237,7 +237,7 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1de0b1e4fd..d452199d85 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 53cd64c5ed..1bcc734649 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -33,6 +33,7 @@ struct PCIEPort {
     /*< private >*/
     PCIBridge   parent_obj;
     /*< public >*/
+    bool flitmode;
 
     /* pci express switch port */
     uint8_t     port;
@@ -58,7 +59,6 @@ struct PCIESlot {
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-    bool flitmode;
 
     /* Disable ACS (really for a pcie_root_port) */
     bool        disable_acs;
-- 
2.34.1


