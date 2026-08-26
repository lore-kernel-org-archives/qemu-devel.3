Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED682C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8n1-0001hX-6p; Wed, 26 Aug 2026 04:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mx-0001gB-KL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mt-0000dY-7E
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:15 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20260826081503epoutp04d7189b472d74e4ce5dc62c31bd3934a6~PTOBACku02856128561epoutp04a
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20260826081503epoutp04d7189b472d74e4ce5dc62c31bd3934a6~PTOBACku02856128561epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787732103;
 bh=4RMhxE2Z3C/IuOSrEbcX8wrMEwxJYWrHoYRnX7Wxa+E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gFH3C+jVpJ0Ei27ZoL2DYY+VsDYYdM8jJ5Fyz2J8Zt0PeWsjzlMQEcXENtVlo3PCk
 OxQQ9vi6KZSXHgdGRxz/sghZLxJQQ24Q6fU5TwK4oyiUCVMyN0r1vqgHAllZ/Lkrbd
 hUe0oaOzVJ5skmOo/M0ifORG9CWeLf4Ix1r/KMzA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260826081502epcas5p46ea6912ff829d29c19c7b9e2bab7dd4a~PTOArarDO1994519945epcas5p4x;
 Wed, 26 Aug 2026 08:15:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4hVHWV5Bgpz6B9m9; Wed, 26 Aug
 2026 08:15:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20260826052014epcas5p11846c6a40fcec4ec4ba441ceb26e5dcc~PQ1ZKh1tC0398803988epcas5p1i;
 Wed, 26 Aug 2026 05:20:14 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052012epsmtip280cd1414e2b0dc05d1c3b4449c8f55c3~PQ1XNA1zy1150111501epsmtip2g;
 Wed, 26 Aug 2026 05:20:12 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 01/10] hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
Date: Wed, 26 Aug 2026 11:04:01 +0530
Message-Id: <1437941060.21787732102723.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052014epcas5p11846c6a40fcec4ec4ba441ceb26e5dcc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052014epcas5p11846c6a40fcec4ec4ba441ceb26e5dcc
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <CGME20260826052014epcas5p11846c6a40fcec4ec4ba441ceb26e5dcc@epcas5p1.samsung.com>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=shrihari.s@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 1de0b1e4fd..4f6fc9db61 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
     }
 
-    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, PCIE_PORT(s)->flitmode);
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



