Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6870ACD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw1B-0001kW-Ih; Tue, 09 Jun 2026 08:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxQ-0005vd-Fd
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:25 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxN-0005GR-Vm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:20 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260609104514epoutp0206549b9f70734efddb9b8864019ff096~3Y84V3Y9Q2759827598epoutp02s
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 10:45:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260609104514epoutp0206549b9f70734efddb9b8864019ff096~3Y84V3Y9Q2759827598epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1781001914;
 bh=SQXj/9l+rMnTTINxJGJSqKcLnI0ozzZ6odUUtMvj6p4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eNuBI1EgznepIqPaV2U1I3Nkz8DQ4/AsV9jE8ZgpMNIL5qJnkFlCRLyoUkkKENgZ8
 kYRGWdzuYHaiwbiBi4PL1bke/a1myLGhiXYxZ1mAVrE5RIIeGRswcMKLR8R2wBsAL4
 xXc2D9Gf6TJYORAEq17oMZ4u/IRqTKoz6Fm6EUl0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20260609104514epcas5p29e026fbda4c91c8ad0f28faee4321cf7~3Y84ABFH12641426414epcas5p2L;
 Tue,  9 Jun 2026 10:45:14 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4gZQXn0m60z6B9mH; Tue,  9 Jun
 2026 10:45:13 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454~3Y82snguL0826308263epcas5p3i;
 Tue,  9 Jun 2026 10:45:12 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104510epsmtip1ef1e7c0a14ad2159e301bcc1daba8e5a~3Y81HtHiv2354323543epsmtip1Z;
 Tue,  9 Jun 2026 10:45:10 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
 shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
 gost.dev@samsung.com
Subject: [RFC 2/8] hw/pci: Move 'x-256b-flit' property from cxl_root_port to
 pcie_root_port.
Date: Tue,  9 Jun 2026 16:28:30 +0530
Message-Id: <20260609105836.3702787-3-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104512epcas5p37f4a75a633dd8e5bb22f51e9660ee454@epcas5p3.samsung.com>
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
X-Mailman-Approved-At: Tue, 09 Jun 2026 08:56:40 -0400
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

Relocate 'x-256b-flit' property from cxl_root_port to its parent
pcie_root_port so that both can utilize this property.

This is a pure refactor and does not impact any existing behavior.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_root_port.c  | 1 -
 hw/pci-bridge/pcie_root_port.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index df69c5200f..e82685d1ab 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -237,7 +237,6 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced5685..eeee24e042 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -152,6 +152,7 @@ static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.34.1


