Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6448C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8my-0001gx-P1; Wed, 26 Aug 2026 04:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mx-0001gD-NQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8mt-0000iV-6c
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:15:15 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260826081503epoutp02c00e4dacaf13007c1c084d195f82414c~PTOBgxujR0337903379epoutp02d
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:15:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260826081503epoutp02c00e4dacaf13007c1c084d195f82414c~PTOBgxujR0337903379epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787732103;
 bh=OG8KGA6iNaDm5Nb0zur+0t9DSzKZnPwrW+yzcMOhUZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kLUI8ie/72flDMai0Zz8UyQcAwlBSzwM18BR+zPKsawL5MsLajIKkr+0lYR0hHOUK
 CRcVEEcPfSFpjX3K/hLOt/MkWMg/fVPpF/No7Skc92p+lVtpadbcJQSzplnb15BhY/
 vHRa+2qvhUB9wP8iCjno1E76PcGoiGdjUY3+W/nw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
 20260826081503epcas5p147dd52e542f9ac18d9c017611bc08611~PTOBFL0nJ2673826738epcas5p1J;
 Wed, 26 Aug 2026 08:15:03 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4hVHWW1DLVz6B9mL; Wed, 26 Aug
 2026 08:15:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052031epcas5p22d19179c1970e4caad602b4f6c89d58e~PQ1pALF703053730537epcas5p2e;
 Wed, 26 Aug 2026 05:20:31 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052030epsmtip2e285eea0fd92b6f0e3921e5d03111e85~PQ1nStUUm1126911269epsmtip2C;
 Wed, 26 Aug 2026 05:20:30 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 03/10] hw/pci: Add SVC capability and UIO properties to
 PCIe ports
Date: Wed, 26 Aug 2026 11:04:03 +0530
Message-Id: <124323713.61787732103161.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052031epcas5p22d19179c1970e4caad602b4f6c89d58e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052031epcas5p22d19179c1970e4caad602b4f6c89d58e
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <CGME20260826052031epcas5p22d19179c1970e4caad602b4f6c89d58e@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=shrihari.s@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dongjoo Seo <dongjoo.seo1@samsung.com>

Implement the Streamlined Virtual Channel (SVC) extended capability
for PCIe ports (Root, Upstream, and Downstream). This capability is
mandatory for enabling Unordered IO (UIO) traffic as per PCIe 6.4
specification [1].

UIO functionality depends on two key prerequisites:
  1. SVC
  2. 256-byte Flit mode support

This patch adds the following experimental properties to PCIe ports:
  - x-svc: Enable SVC in the port.
  - x-256b-flit: Enable 256B flit mode in the port.

This change lays the groundwork for UIO emulation in QEMU.

[1]: PCIe 6.4 Specification, Table 2-46 (Streamlined Virtual Channel).

Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/pcie_root_port.c     | 1 +
 hw/pci-bridge/xio3130_downstream.c | 2 ++
 hw/pci-bridge/xio3130_upstream.c   | 7 +++++++
 include/hw/pci/pcie_port.h         | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index eeee24e042..0ae7b10fbd 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -153,6 +153,7 @@ static const Property rp_props[] = {
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
     DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
 };
 
 static void rp_instance_post_init(Object *obj)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 0c3fed3053..090a3fdfc9 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -137,6 +137,8 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 40057b749b..767b7d17f2 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
@@ -123,6 +124,11 @@ static const VMStateDescription vmstate_xio3130_upstream = {
     }
 };
 
+static const Property xio3130_upstream_props[] = {
+    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
+};
+
 static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -138,6 +144,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
     dc->desc = "TI X3130 Upstream Port of PCI Express Switch";
     device_class_set_legacy_reset(dc, xio3130_upstream_reset);
     dc->vmsd = &vmstate_xio3130_upstream;
+    device_class_set_props(dc, xio3130_upstream_props);
 }
 
 static const TypeInfo xio3130_upstream_info = {
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 1bcc734649..0b3e0efb8c 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -37,6 +37,9 @@ struct PCIEPort {
 
     /* pci express switch port */
     uint8_t     port;
+
+    /* Streamlined Virtual Channel (SVC) capability */
+    bool    svc;
 };
 
 void pcie_port_init_reg(PCIDevice *d);
-- 
2.34.1



