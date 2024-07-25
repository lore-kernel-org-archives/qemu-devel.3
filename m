Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E457AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 09:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWuwA-00014T-VW; Thu, 25 Jul 2024 05:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWuw8-00013p-V2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:39:01 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sWuw7-0005sW-1n
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721900339; x=1753436339;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nb/z+Zw2u6vX8s5Ikr6JNE42acGvDhKFx4c1E3gHpjE=;
 b=bnRmzurfQxSwev4lKDNTQy1Ep4FcCeErjzu/2PHlTGZeoUKTthQ3R7tY
 07dRovJb9xo7oImR4ynk4MOjkb2nccvyKUxAOQ+ZLUF0pYxWY6TtWOZ1/
 9Z8NS/gziXGptYF1cLNBrGmakI11tjM2GKpeJh56yqxB7dI74SOad8hTq
 zrfN01VC9eajVjGfTFbwEPVbvrjNVxUbxS2d4AtzPqiRljGXqgfKwlpZa
 Cepzwjd5XcpRIDYxBDTUF/U/MmKJ4WbO9LSArMrzkD//L7X0iDbQmmt5c
 C6e5uydWqHs3A1CU5lcWAr2p3O2grDg9kmp8xt4sVXXytk94bvq4/K+8w w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="170442931"
X-IronPort-AV: E=Sophos;i="6.09,235,1716217200"; d="scan'208";a="170442931"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 18:38:54 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 631E8D648A
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 18:38:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A9E84D4BC2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 18:38:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3F209200894BB
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 18:38:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 917AA1A000A;
 Thu, 25 Jul 2024 17:38:50 +0800 (CST)
To: mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v4] pci-bridge: avoid linking a single downstream port more
 than once
Date: Thu, 25 Jul 2024 05:38:19 -0400
Message-ID: <20240725093819.15549-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28550.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28550.006
X-TMASE-Result: 10--9.551500-10.000000
X-TMASE-MatchedRID: 1RpOuHOu+mZ6bMYbioM9qazGfgakLdjatOtXYgbXjdcd3hIj0tmc7Rsk
 AdaEfeQKA3GvyENlx3vmn3xyPJAJoh2P280ZiGmRGYJhRh6ssesAPNCUrAcH+wzvg1/q1MH2s8W
 7VNomNMP/ixwGSXguAN5KAOif9PljkfRhdidsajMURSScn+QSXoDH9tzzuv1v+gtHj7OwNO2FR9
 Hau8GO7sjN9R1Av5Rdx7pv+xUmLEfXVXSgckrweY8qVqnrC9tsv8tlVGhfz7s=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since the downstream port is not checked, two slots can be linked to
a single port. However, this can prevent the driver from detecting the
device properly.

It is necessary to ensure that a downstream port is not linked more than
once.

Links: https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

---
V3[3] -> V4:
 - make the error message more readable
 - fix the downstream port check error

V2[2] -> V3:
 - Move this check into pcie_cap_init()

V1[1] -> V2:
 - Move downstream port check forward

[1] https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujitsu.com
[2] https://lore.kernel.org/qemu-devel/20240717085621.55315-1-yaoxt.fnst@fujitsu.com
[3] https://lore.kernel.org/qemu-devel/20240725032731.13032-1-yaoxt.fnst@fujitsu.com
---
 hw/pci/pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4b2f0805c6e0..1e53be1bc7c5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -192,6 +192,13 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
 
     assert(pci_is_express(dev));
 
+    if ((type == PCI_EXP_TYPE_DOWNSTREAM || type == PCI_EXP_TYPE_ROOT_PORT) &&
+        pcie_find_port_by_pn(pci_get_bus(dev), port)) {
+        error_setg(errp, "The port %d is already in use, please select "
+                   "another port", port);
+        return -EBUSY;
+    }
+
     pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
                              PCI_EXP_VER2_SIZEOF, errp);
     if (pos < 0) {
-- 
2.41.0


